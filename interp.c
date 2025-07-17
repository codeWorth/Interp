#include <stdlib.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <time.h>
#include "fastmath.h"

#define F_PI 3.1415926535f
// SIMD: 14400 ms, -97.2db
// No SIMD: 22510 ms, -98.6db
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
} ChunkHeader;

typedef struct {
    char format[4];
} RiffChunk;

typedef struct {
    uint16_t audioFormat;
    uint16_t numChannels;
    uint32_t sampleRate;
    uint32_t byteRate;
    uint16_t blockAlign;
    uint16_t bitDepth;
} FmtChunk;

typedef struct {
    ChunkHeader riffHeader;
    RiffChunk riffChunk;

    ChunkHeader fmtHeader;
    FmtChunk fmtChunk;

    ChunkHeader dataHeader;
} WavInfo;

void writeStr(char* dest, const char* src, int n) {
    for (int i = 0; i < n; i++) dest[i] = src[i];
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
 * @brief Extracts the given channel from interleaved audio, converts to float,
 * and pads with the given value on both sides.
 * 
 * @param data Original data to copy.
 * @param channelIndex Index of channel to extract.
 * @param channelCount Total number of included channels.
 * @param sampleCount Number of enteries in data.
 * @param padSize Size of padding on each side.
 * @param padValue Value to pad with.
 * @return float* Pointer to padded exracted channel.
 */
float* extractPadAndFloat(const int32_t* data, int channelIndex, int channelCount, int sampleCount, int padSize, float padValue) {
    float* padded = _mm_malloc(sizeof(float) * (sampleCount + padSize*2), 32);
    for (int i = 0; i < sampleCount; i++) {
        padded[i+padSize] = data[i*channelCount + channelIndex];
    }
    for (int i = 0; i < padSize; i++) {
        padded[i] = padValue;
        padded[sampleCount + padSize + i] = padValue;
    }
    return padded;
}

int32_t* interleaveChannels(int32_t** channels, int channelCount, int sampleCount) {
    int32_t* outData = malloc(sizeof(int32_t) * channelCount * sampleCount);
    for (int c = 0; c < channelCount; c++) {
        for (int n = 0; n < sampleCount; n++) {
            outData[n*channelCount + c] = channels[c][n];
        }
    }
    return outData;
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
        printf("\tStart to mid: %d\n", (int)ceil(startHoldSamples));
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
int32_t* fastSincInterp(int sampleRate, int32_t* data, int channelIndex, int channelCount, int dataCount, double* upsamples, int upCount, int windowSize) {
    assert(windowSize%2 == 1);
    struct timespec start, finish;

    int paddedWindowSize = ceil(windowSize / 8.f) * 8 + 1;
    float* paddedData = extractPadAndFloat(data, channelIndex, channelCount, dataCount, paddedWindowSize/2, 0);
    int upIndex = 0;
    int32_t* result = _mm_malloc(sizeof(int32_t) * upCount, 32);

    printf("Upsampling %d samples w/ window size = %d...\n", upCount, windowSize);

    clock_gettime(CLOCK_REALTIME, &start);

    #ifdef SIMD
    // prepare some vectors
    int startN = -paddedWindowSize/2;
    __m256i inc = _mm256_setr_epi32(0, 1, 2, 3, 4, 5, 6, 7);
    __m256 PI = _mm256_set1_ps(M_PI);
    __m256 ones = _mm256_set1_ps(1.f);
    __m256i offset = _mm256_set1_epi32(8);
    #endif

    // loop over all upsamples
    while (upIndex < upCount) {
        int origIndex = upsamples[upIndex] * sampleRate; // gets the nearest orig index to the given time stamp

        #ifdef SIMD

        __m256d upsample = _mm256_set1_pd(upsamples[upIndex]*sampleRate);
        __m256i origN = _mm256_add_epi32(inc, _mm256_set1_epi32(origIndex - paddedWindowSize/2)); // origN = origIndex - windowSize/2 + i

        double sum = 0;

        for (int i = 0; i < paddedWindowSize; i += 8) {
            // begin data load as soon as possible
            // origN will always be 8 adjacent indecies beginning at (origIndex + i)
            __m256 dataChunk = _mm256_loadu_ps(paddedData + origIndex + i);

            // Almost all float error is removed by using doubles to subtract instead of floats
            // double dt = upsamples[upIndex]*sampleRate - origN;
            __m256d origN_d_L = _mm256_cvtepi32_pd(_mm256_castsi256_si128(origN)); // lower half
            __m256d origN_d_U = _mm256_cvtepi32_pd(_mm256_extracti128_si256(origN, 1)); // upper half
            __m256d dt_L = upsample - origN_d_L;
            __m256d dt_U = upsample - origN_d_U;
            __m256 dt = _mm256_set_m128(_mm256_cvtpd_ps(dt_U), _mm256_cvtpd_ps(dt_L));

            __m256 xs = PI * dt;
            __m256 isZero = _mm256_cmp_ps(xs, _mm256_setzero_ps(), _CMP_EQ_OQ); // dt == 0
            __m256 sines; fastSinSIMD(&xs, &sines);

            __m256 divs = sines / xs;
            __m256 sinc = _mm256_blendv_ps(divs, ones, isZero); // dt == 0 ? 1 : div
            
            __m256 results =  dataChunk * sinc;

            sum += sum8(&results);

            origN = _mm256_add_epi32(origN, offset);
        }

        #else

        double sum = 0;

        for (int i = 0; i < paddedWindowSize; i++) {
            int origN = origIndex - paddedWindowSize/2 + i;
            
            double dt = upsamples[upIndex]*sampleRate - origN;
            double sinc = dt == 0 ? 1 : fastSinD(M_PI * dt) / (M_PI * dt);
            sum += paddedData[origIndex + i] * sinc;
        }

        #endif

        result[upIndex] = sum;
        upIndex++;
    }
    clock_gettime(CLOCK_REALTIME, &finish);

    _mm_free(paddedData);

    printf("Proc took %d milliseconds.\n", (finish.tv_sec - start.tv_sec)*1000 + (finish.tv_nsec - start.tv_nsec) / 1000000L);
    printf("Done upsampling, writing result...\n");

    return result;
}

int getDataChunkCount(const WavInfo* wavInfo) {
    return wavInfo->dataHeader.chunkSize / (wavInfo->fmtChunk.bitDepth/8 * wavInfo->fmtChunk.numChannels);
}

bool verifyWavInfo(const WavInfo* wavInfo) {
    if (strncmp(wavInfo->riffHeader.chunkID, "RIFF", 4) != 0) {
        printf("Invalid RIFF header tag %.4s.\n", wavInfo->riffHeader.chunkID);
        return false;
    }

    if (strncmp(wavInfo->riffChunk.format, "WAVE", 4) != 0) {
        printf("Format %.4s is not .wav, this program only handles wave files currently.\n", wavInfo->riffChunk.format);
        return false;
    }

    if (strncmp(wavInfo->fmtHeader.chunkID, "fmt ", 4) != 0) {
        printf("Format chunk \"%.4s\" should be \"fmt \" instead.\n", wavInfo->fmtHeader.chunkID);
        return false;
    }

    if (wavInfo->fmtHeader.chunkSize != 16) {
        printf("Chunk size %d should be 16 for PCM.\n", wavInfo->fmtHeader.chunkSize);
        return false;
    }

    if (wavInfo->fmtChunk.audioFormat != 1) {
        printf("Audio must be uncompressed.\n");
        return false;
    }

    if (wavInfo->fmtChunk.bitDepth != 16 && wavInfo->fmtChunk.bitDepth != 24 && wavInfo->fmtChunk.bitDepth != 32) {
        printf("Bit depth %d must be one of 16, 24, or 32.\n", wavInfo->fmtChunk.bitDepth);
        return false;
    }

    return true;
}

WavInfo readWavInfo(FILE* inFile) {
    WavInfo wavInfo;

    fread(&wavInfo.riffHeader, sizeof(ChunkHeader), 1, inFile);
    fread(&wavInfo.riffChunk, sizeof(RiffChunk), 1, inFile);

    ChunkHeader header; // seek till fmt chunk
    while (fread(&header, sizeof(ChunkHeader), 1, inFile) > 0) {
        if (strncmp(header.chunkID, "fmt ", 4) == 0) {
            wavInfo.fmtHeader = header;
            break;
        } else {
            fseek(inFile, header.chunkSize, SEEK_CUR);
        }
    }
    fread(&wavInfo.fmtChunk, sizeof(FmtChunk), 1, inFile);

    // seek till data chunk
    while (fread(&header, sizeof(ChunkHeader), 1, inFile) > 0) {
        if (strncmp(header.chunkID, "data", 4) == 0) {
            wavInfo.dataHeader = header;
            break;
        } else {
            fseek(inFile, header.chunkSize, SEEK_CUR);
        }
    }

    return wavInfo;
}

int32_t* readWavData(FILE* inFile, const WavInfo* wavInfo) {
    int32_t* data = NULL;
    int dataChunkCount = getDataChunkCount(wavInfo);

    dataChunkCount *= wavInfo->fmtChunk.numChannels;
    if (wavInfo->fmtChunk.bitDepth == 32) {
        data = _mm_malloc(dataChunkCount * sizeof(int32_t), 32);
        fread(data, sizeof(uint32_t), dataChunkCount, inFile);
    } else if (wavInfo->fmtChunk.bitDepth == 24) {
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
        printf("Bit depth %d not yet supported.\n", wavInfo->fmtChunk.bitDepth);
    }

    return data;
}

void writeHeader(FmtChunk fmtChunk, int upCount, FILE* outFile) {
    ChunkHeader dataHeader;
    writeStr(dataHeader.chunkID, "data", 4);
    dataHeader.chunkSize = upCount * (fmtChunk.bitDepth/8 * fmtChunk.numChannels);

    ChunkHeader fmtHeader;
    writeStr(fmtHeader.chunkID, "fmt ", 4);
    fmtHeader.chunkSize = 16;

    ChunkHeader riffHeader;
    writeStr(riffHeader.chunkID, "RIFF", 4);
    riffHeader.chunkSize = 36 + fmtHeader.chunkSize + dataHeader.chunkSize;
    RiffChunk riffChunk;
    writeStr(riffChunk.format, "WAVE", 4);

    fwrite(&riffHeader, sizeof(ChunkHeader), 1, outFile);
    fwrite(&riffChunk, sizeof(RiffChunk), 1, outFile);

    fwrite(&fmtHeader, sizeof(ChunkHeader), 1, outFile);
    fwrite(&fmtChunk, sizeof(FmtChunk), 1, outFile);

    fwrite(&dataHeader, sizeof(ChunkHeader), 1, outFile);
}

bool writeWavfile(const char* outPath, const WavInfo* wavInfo, const int32_t* data, int count) {
    FILE* outFile;
    // Check if file exists and confirm overwrite with user
    outFile = fopen(outPath, "rb");
    if (outFile != NULL) {
        printf("File %s already exists! Overwrite (Y/N)?\t", outPath);
        while (true) {
            char resp[5];
            fgets(resp, sizeof(resp), stdin);
            if (resp[0] == 'Y') {
                fclose(outFile);
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

    writeHeader(wavInfo->fmtChunk, count, outFile);

    count *= wavInfo->fmtChunk.numChannels;
    if (wavInfo->fmtChunk.bitDepth == 32) {
        fwrite(data, sizeof(uint32_t), count, outFile);
    } else if (wavInfo->fmtChunk.bitDepth == 24) {
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

    WavInfo wavInfo = readWavInfo(inFile);

    if (verifyWavInfo(&wavInfo)) {
        printf("Verified file header, continuing...\n");
    } else {
        return 1;
    }

    int32_t* data = readWavData(inFile, &wavInfo);
    if (data == NULL) {
        return 1;
    }
    fclose(inFile);

    int32_t** upsampledChannels = malloc(sizeof(void*) * wavInfo.fmtChunk.numChannels);
    int upCount;
    int origCount = getDataChunkCount(&wavInfo);
    double* upsamples = upsampleCurve(
        params.startSpd, params.endSpd, 
        params.delayTime, params.holdTime, 
        origCount, wavInfo.fmtChunk.sampleRate, 
        &upCount
    );

    for (int c = 0; c < wavInfo.fmtChunk.numChannels; c++) {
        upsampledChannels[c] = fastSincInterp(
            wavInfo.fmtChunk.sampleRate, data,
            c, wavInfo.fmtChunk.numChannels,
            origCount,
            upsamples, upCount,
            8191 // 8191 much better than 4095 for complicated audio
        ); 
    }
    int32_t* upsampledData = interleaveChannels(upsampledChannels, wavInfo.fmtChunk.numChannels, upCount);

    writeWavfile(params.outFile, &wavInfo, upsampledData, upCount);

    _mm_free(data);
    for (int c = 0; c < wavInfo.fmtChunk.numChannels; c++) {
        _mm_free(upsampledChannels[c]);
    }
    free(upsampledData);
    free(upsamples);
    return 0;
}
