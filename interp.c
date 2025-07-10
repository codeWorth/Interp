#include <stdlib.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "string.h"
#include <assert.h>
#include <time.h>
#include "fastmath.h"

#define F_PI 3.1415926535f
#define SIMD

typedef enum {
    EXEC = 0,
    HELP = 1,
    ERROR = 2
} ParseResult;

typedef struct {
    char const* inFile;
    char const* outFile;
    double startSpd;
    double endSpd;
    double delayTime;
    double holdTime;
} Params;

typedef struct {
    char chunkID[4];
    uint32_t chunkSize;
    char format[4];
    char fmtChunkID[4];
    uint32_t fmtChunkSize;
    uint16_t audioFormat;
    uint16_t numChannels;
    uint32_t sampleRate;
    uint32_t byteRate;
    uint16_t blockAlign;
    uint16_t bitDepth;
    char dataChunkID[4];
    uint32_t dataChunkSize;
} WavHeader;

WavHeader copyHeader(const WavHeader* orig, uint32_t newDataChunkSize) {
    WavHeader newHeader = *orig;
    newHeader.dataChunkSize = newDataChunkSize;
    return newHeader;
}

ParseResult parseParams(int argc, char const* argv[], Params* params) {
    char const* param = NULL;
    int foundParams = 0;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-h") == 0) {
            return HELP;
        }

        if (param == NULL) {
            if (argv[i][0] == '-') {
                param = argv[i]+1;
            } else if (i != argc-1) {
                printf("Out file should be last param!");
                return ERROR;
            } else {
                params->outFile = argv[i];
                foundParams++;
            }
        } else {
            if (strcmp(param, "i") == 0) {
                params->inFile = argv[i];
            } else if (strcmp(param, "s") == 0) {
                params->startSpd = atof(argv[i]);
            } else if (strcmp(param, "e") == 0) {
                params->endSpd = atof(argv[i]);
            } else if (strcmp(param, "d") == 0) {
                params->delayTime = atof(argv[i]);
            } else if (strcmp(param, "H") == 0) {
                params->holdTime = atof(argv[i]);
            } else {
                printf("Unrecognized param %s\n", param);
                return ERROR;
            }
            foundParams++;
            param = NULL;
        }
    }
    return foundParams == 6 ? EXEC : ERROR;
}

bool verifyHeader(const WavHeader* header) {
    if (strncmp(header->chunkID, "RIFF", 4) != 0) {
        printf("Invalid RIFF header tag %.4s.\n", header->chunkID);
        return false;
    }

    if (strncmp(header->format, "WAVE", 4) != 0) {
        printf("Format %.4s is not .wav, this program only handles wave files currently.\n", header->format);
        return false;
    }

    if (strncmp(header->fmtChunkID, "fmt ", 4) != 0) {
        printf("First chunk %.4s should be format chunk instead.\n", header->format);
        return false;
    }

    if (header->fmtChunkSize != 16) {
        printf("Chunk size %d should be 16 for PCM.\n", header->fmtChunkSize);
        return false;
    }

    if (header->audioFormat != 1) {
        printf("Audio must be uncompressed.\n");
        return false;
    }

    if (header->bitDepth != 16 && header->bitDepth != 24 && header->bitDepth != 32) {
        printf("Bit depth %d must be one of 16, 24, or 32.\n", header->bitDepth);
        return false;
    }

    return true;
}

/**
 * @brief Constructs new array with data from given array plus padding on either side.
 * Converts values to floats.
 * 
 * @param data Original data to copy.
 * @param count Number of enteries in original data.
 * @param padSize Size of padding on each side.
 * @param padValue Value to pad with.
 * @return float* Pointer to padded data array.
 */
float* padAndFloat(const int32_t* data, int count, int padSize, float padValue) {
    float* padded = _mm_malloc(sizeof(float) * (count + padSize*2), 32);
    for (int i = 0; i < count; i++) {
        padded[i+padSize] = data[i];
    }
    for (int i = 0; i < padSize; i++) {
        padded[i] = padValue;
        padded[count + padSize + i] = padValue;
    }
    return padded;
}

/**
 * @brief Constructs new array with data from given array plus padding on either side.
 * Converts values to doubles.
 * 
 * @param data Original data to copy.
 * @param count Number of enteries in original data.
 * @param padSize Size of padding on each side.
 * @param padValue Value to pad with.
 * @return double* Pointer to padded data array.
 */
double* padAndDouble(const int32_t* data, int count, int padSize, double padValue) {
    double* padded = _mm_malloc(sizeof(double) * (count + padSize*2), 32);
    for (int i = 0; i < count; i++) {
        padded[i+padSize] = data[i];
    }
    for (int i = 0; i < padSize; i++) {
        padded[i] = padValue;
        padded[count + padSize + i] = padValue;
    }
    return padded;
}

/**
 * @brief Generates a sequence of time values in seconds to sample the input data at. 
 * Output sample rate will change linearly from startK*sampleRate to endK*sampleRate.
 * 
 * @param startK Starting ratio between original and upsampled sample rate.
 * @param endK Ending ratio between original and upsampled sample rate.
 * @param startOffset How long, in seconds, to hold at startK before beginning to increase.
 * @param endOffset How long, in seconds, to hold at endK after reaching it.
 * @param count Number of samples in data.
 * @param sampleRate Sample rate of data.
 * @param totalUpsamples Location to store the number of samples in the result.
 * @return Array containing the upsampled time stamps.
 */
double* upsampleCurve(double startK, double endK, double startOffset, double endOffset, int count, int sampleRate, int* totalUpsamples) {
    // In the original data, data point N is located at T = N / sampleRate
    // For the beginning section of the upsample, data point N is located at T = N * startK / sampleRate
    // Similar for the ending section of the upscale
    // Hence we store (startK / sampleRate) and (endK / sampleRate)
    // Then for the increasing section, we must smoothly go from (startK / sampleRate) to (endK / sampleRate)
    double startRatePerSample = startK / sampleRate;
    double endRatePerSample = endK / sampleRate;

    double origDuration = (double)count / sampleRate; // how many seconds long the original data is
    double curveDuration = origDuration - startOffset - endOffset; // how many seconds spent increasing sample rate
    assert(curveDuration > 0.f);

    // these values are non-integers for now, which will be corrected later
    double startHoldSamples = startOffset / startRatePerSample; // number of samples to hold at the starting sample rate
    double endHoldSamples = endOffset / startRatePerSample; // number of samples to hold at the ending sample rate

    /*
    Solves for (A, B, n) given the following contraints:
        p(x) = Ax^2 + Bx
        p(n) = sCurveDuration
        p'(0) = sr1
        p'(n) = sr2
    */
    double curveSamples = 2*curveDuration / (startRatePerSample + endRatePerSample);
    double curveA = (endRatePerSample - startRatePerSample) / (2 * curveSamples);
    double curveB = startRatePerSample;

    *totalUpsamples = (int)ceil(startHoldSamples+curveSamples+endHoldSamples); // accounts for each # of samples being possible non-int
    double* upsamples = malloc(sizeof(double) * *totalUpsamples);

    for (int i = 0; i < *totalUpsamples; i++) {
        if (i < ceil(startHoldSamples)) {
            upsamples[i] = i * startRatePerSample;
        } else if (i < ceil(startHoldSamples + curveSamples)) {
            double n = i - startHoldSamples;
            upsamples[i] = curveA * n*n + curveB * n + startOffset;
        } else {
            upsamples[i] = endRatePerSample * (i - startHoldSamples - curveSamples) + startOffset + curveDuration;
        }
    }

    printf("Generated %d upsample times.\n", *totalUpsamples);
    if (startHoldSamples >= 1) {
        printf("\tStart to mid: %d", (int)ceil(startHoldSamples));
    }
    if (*totalUpsamples - ceil(startHoldSamples+curveSamples) > 0) {
        printf("\tMid to end: %d\n", (int)(*totalUpsamples - ceil(startHoldSamples+curveSamples)));
    }
    printf("Durations in samples: %f, %f, %f\n", startHoldSamples, curveSamples, endHoldSamples);

    return upsamples;
}

/**
 * @brief Performs sinc interpolation to upscale a signal, but windows the signal to upsamples around target sample. 
 * Large differences in sample and upsample have no significant effect, because sinc(X->inf) -> 0
 * 
 * @param data Signal to be interpolated.
 * @param samples Original time stamps of each sample.
 * @param dataCount Number of data points in the signal.
 * @param upsamples New time stamps.
 * @param upCount Number of data points in the upsampled signal.
 * @param windowSize Size of window around each sample time. Must be odd.
 * @return Array containing the upsampled signal.
 */
int32_t* fastSincInterp(int sampleRate, int32_t* data, int dataCount, double* upsamples, int upCount, int windowSize) {
    assert(windowSize%2 == 1);
    struct timespec start, finish;

    int paddedWindowSize = ceil(windowSize / 8.f) * 8 + 1;
    // float* paddedData = padAndFloat(data, dataCount, paddedWindowSize/2, 0);     // 3180 ms
    double* paddedDataD = padAndDouble(data, dataCount, paddedWindowSize/2, 0);     // 4540 ms, -110db diff (insignificant)
    int upIndex = 0;
    int32_t* result = _mm_malloc(sizeof(int32_t) * upCount, 32);

    printf("Upsampling %d samples w/ window size = %d...\n", upCount, windowSize);

    clock_gettime(CLOCK_REALTIME, &start);

    #ifdef SIMD
    // prepare some vectors
    int startN = -paddedWindowSize/2;
    __m256i inc = _mm256_setr_epi32(0, 1, 2, 3, -1, -1, -1, -1);
    __m256d PI = _mm256_set1_pd(M_PI);
    __m256d ones = _mm256_set1_pd(1.f);
    __m256i offset = _mm256_set1_epi32(4);
    #endif

    // loop over all upsamples
    while (upIndex < upCount) {
        int origIndex = upsamples[upIndex] * sampleRate; // gets the nearest orig index to the given time stamp

        #ifdef SIMD

        __m256d upsample = _mm256_set1_pd(upsamples[upIndex]*sampleRate);
        __m256i origN = _mm256_add_epi32(inc, _mm256_set1_epi32(origIndex - paddedWindowSize/2)); // origN = origIndex - windowSize/2 + i

        double sum = 0;

        for (int i = 0; i < paddedWindowSize; i += 4) {
            // begin data load as soon as possible
            // origN will always be 8 adjacent indecies beginning at (origIndex + i)
            __m256d dataChunk = _mm256_loadu_pd(paddedDataD + origIndex + i);

            // double dt = upsamples[upIndex]*sampleRate - origN;
            __m256d origN_f = _mm256_cvtepi32_pd(_mm256_castsi256_si128(origN));
            __m256d dt = upsample - origN_f;

            __m256d xs = PI * dt;
            __m256d isZero = _mm256_cmp_pd(xs, _mm256_setzero_pd(), _CMP_EQ_OQ); // dt == 0
            __m256d sines; fastSinSIMD_d(&xs, &sines);

            __m256d divs = sines / xs;
            __m256d sinc = _mm256_blendv_pd(divs, ones, isZero); // dt == 0 ? 1 : div
            
            __m256d results =  dataChunk * sinc;

            sum += sum4(&results);

            origN = _mm256_add_epi32(origN, offset);
        }

        #else

        double sum = 0;

        for (int i = 0; i < paddedWindowSize; i++) {
            int origN = origIndex - paddedWindowSize/2 + i;
            
            double dt = upsamples[upIndex]*sampleRate - origN;
            double sinc = dt == 0 ? 1 : fastSinD(M_PI * dt) / (M_PI * dt);
            sum += paddedDataD[origIndex + i] * sinc;
        }

        #endif

        result[upIndex] = sum;
        upIndex++;
    }
    clock_gettime(CLOCK_REALTIME, &finish);

    _mm_free(paddedDataD);

    printf("Proc took %d milliseconds.\n", (finish.tv_sec - start.tv_sec)*1000 + (finish.tv_nsec - start.tv_nsec) / 1000000L);
    printf("Done upsampling, writing result...\n");

    return result;
}

int getDataChunkCount(const WavHeader* header) {
    return header->dataChunkSize / (header->bitDepth/8);
}

int32_t* readWavfile(FILE* inFile, const WavHeader* header) {
    int32_t* data = NULL;
    int dataChunkCount = getDataChunkCount(header);

    if (header->bitDepth == 32) {
        data = _mm_malloc(dataChunkCount * sizeof(int32_t), 32);
        fread(data, sizeof(uint32_t), dataChunkCount, inFile);
    } else if (header->bitDepth == 24) {
        data = _mm_malloc(dataChunkCount * sizeof(int32_t), 32);

        int valueCount = 0;
        uint8_t chunk[32];

        while (valueCount+8 <= dataChunkCount) {
            fread(chunk, 3, 4, inFile); // read 4 24bit ints to chunk [0, 16)
            fread(chunk + 16, 3, 4, inFile); // read next 4 24bit ints to chunk [16, 32)
            
            __m256i buff = _mm256_loadu_si256((const __m256i*)chunk);
            __m256i shuffle = _mm256_setr_epi8(
                -1, 0, 1, 2,
                -1, 3, 4, 5,
                -1, 6, 7, 8,
                -1, 9, 10, 11,
                -1, 16, 17, 18,
                -1, 19, 20, 21,
                -1, 22, 23, 24,
                -1, 25, 26, 27
            );
            __m256i spread = _mm256_shuffle_epi8(buff, shuffle);
            __m256i shifted = _mm256_srai_epi32(spread, 8);
            _mm256_store_si256((__m256i*)(data + valueCount), shifted);

            valueCount += 8;
        }

        int remaining = dataChunkCount - valueCount;
        if (remaining > 0) {
            fread(&chunk, 3, remaining, inFile);
            for (int i = 0; i < remaining*3; i += 3) {
                int32_t val = chunk[i+2] << 24;
                val >>= 8;
                val |= chunk[i];
                val |= chunk[i+1] << 8;
                data[valueCount] = val;
                valueCount++;
            }
        }

        printf("Read all %d values...\n", valueCount);
    } else {
        printf("Bit depth %d not yet supported.\n", header->bitDepth);
    }

    return data;
}

bool writeWavfile(const char* outPath, const WavHeader* inHeader, const int32_t* data, int count) {
    WavHeader outHeader = copyHeader(inHeader, count*sizeof(int32_t));
    FILE* outFile;

    // Check if file exists and confirm overwrite with user
    outFile = fopen(outPath, "rb");
    if (outFile != NULL) {
        printf("File %s already exists! Overwrite (Y/N)?\t", outPath);
        while (true) {
            char resp[5];
            fgets(resp, sizeof(resp), stdin);
            if (resp[0] == 'Y') {
                break;
            } else if (resp[0] == 'N') {
                printf("Aborting.\n");
                return false;
            } else {
                printf("Unrecognized response. Overwrite (Y/N)?\t");
            }
        }
    }

    outFile = fopen(outPath, "wb");

    fwrite(&outHeader, sizeof(outHeader), 1, outFile);
    if (outHeader.bitDepth == 32) {
        fwrite(data, sizeof(uint32_t), count, outFile);
    } else if (outHeader.bitDepth == 24) {
        int valueCount = 0;
        uint8_t chunk[32];

        while (valueCount+8 <= count) {
            __m256i buff = _mm256_load_si256((const __m256i*)(data + valueCount));

            __m256i shuffle = _mm256_setr_epi8(
                0, 1, 2,
                4, 5, 6,
                8, 9, 10,
                12, 13, 14,
                -1, -1, -1, -1,
                16, 17, 18,
                20, 21, 22,
                24, 25, 26,
                28, 29, 30,
                -1, -1, -1, -1
            );
            __m256i spread = _mm256_shuffle_epi8(buff, shuffle);
            _mm256_store_si256((__m256i*)chunk, spread);

            fwrite(chunk, 3, 4, outFile);
            fwrite(chunk + 16, 3, 4, outFile);

            valueCount += 8;
        }

        int remaining = count - valueCount;
        if (remaining > 0) {
            for (int i = 0; i < remaining; i++) {
                int32_t val = data[valueCount + i];
                fwrite(&val, 3, 1, outFile);
            }
        }
    }

    fclose(outFile);
    return true;
}

int main(int argc, char const *argv[]) {
    GEN_TRIG_TABLE();

    Params params;
    ParseResult result = parseParams(argc, argv, &params);

    if (result == HELP) {
        printf("Use the following params:\n\t-i\tin file path\n\t-s\tstart rate\n\t-e\tend rate\n\t-d\tstart delay time\n\t-H\tend hold time\n\tout file path\n");
        return 0;
    } else if (result == ERROR) {
        printf("Some param parse error occured\n");
        return 1;
    }

    FILE* inFile;
    inFile = fopen(params.inFile, "rb");
    if (inFile == NULL) {
        printf("Unable to open file at %s\n", params.inFile);
        return 1;
    }

    WavHeader header;
    fread(&header, sizeof(header), 1, inFile);

    if (verifyHeader(&header)) {
        printf("Verified file header, continuing...\n");
    } else {
        return 1;
    }

    int32_t* data = readWavfile(inFile, &header);
    if (data == NULL) {
        return 1;
    }
    fclose(inFile);

    int upCount;
    int origCount = getDataChunkCount(&header);
    double* upsamples = upsampleCurve(params.startSpd, params.endSpd, params.delayTime, params.holdTime, origCount, header.sampleRate, &upCount);
    int32_t* upsampledData = fastSincInterp(header.sampleRate, data, origCount, upsamples, upCount, 2047);
    free(upsamples);

    writeWavfile(params.outFile, &header, upsampledData, upCount);

    _mm_free(data);
    _mm_free(upsampledData);
    return 0;
}
