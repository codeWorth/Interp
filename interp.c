#include <stdlib.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include "string.h"
#include <assert.h>
#define _USE_MATH_DEFINES
#include <math.h>

typedef enum {
    EXEC = 0,
    HELP = 1,
    ERROR = 2
} ParseResult;

typedef struct {
    char const* inFile;
    char const* outFile;
    float startSpd;
    float endSpd;
    float delayTime;
    float holdTime;
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

int min(int a, int b) {
    return a < b ? a : b;
}
int max(int a, int b) {
    return a > b ? a : b;
}

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
float* upsampleCurve(float startK, float endK, float startOffset, float endOffset, int count, int sampleRate, int* totalUpsamples) {
    // In the original data, data point N is located at T = N / sampleRate
    // For the beginning section of the upsample, data point N is located at T = N * startK / sampleRate
    // Similar for the ending section of the upscale
    // Hence we store (startK / sampleRate) and (endK / sampleRate)
    // Then for the increasing section, we must smoothly go from (startK / sampleRate) to (endK / sampleRate)
    float startRatePerSample = startK / sampleRate;
    float endRatePerSample = endK / sampleRate;

    float origDuration = (float)count / sampleRate; // how many seconds long the original data is
    float curveDuration = origDuration - startOffset - endOffset; // how many seconds spent increasing sample rate
    assert(curveDuration > 0.f);

    // these values are non-integers for now, which will be corrected later
    float startHoldSamples = startOffset / startRatePerSample; // number of samples to hold at the starting sample rate
    float endHoldSamples = endOffset / startRatePerSample; // number of samples to hold at the ending sample rate

    /*
    Solves for (A, B, n) given the following contraints:
        p(x) = Ax^2 + Bx
        p(n) = sCurveDuration
        p'(0) = sr1
        p'(n) = sr2
    */
    float curveSamples = 2*curveDuration / (startRatePerSample + endRatePerSample);
    float curveA = (endRatePerSample - startRatePerSample) / (2 * curveSamples);
    float curveB = startRatePerSample;

    *totalUpsamples = (int)ceil(startHoldSamples+curveSamples+endHoldSamples); // accounts for each # of samples being possible non-int
    float* upsamples = malloc(sizeof(float) * *totalUpsamples);

    for (int i = 0; i < *totalUpsamples; i++) {
        if (i < ceil(startHoldSamples)) {
            upsamples[i] = i * startRatePerSample;
        } else if (i < ceil(startHoldSamples + curveSamples)) {
            float n = i - startHoldSamples;
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
int32_t* fastSincInterp(int sampleRate, int32_t* data,int dataCount, float* upsamples, int upCount, int windowSize) {
    assert(windowSize%2 == 1);

    int upIndex = 0;
    int32_t* result = _mm_malloc(sizeof(int32_t) * upCount, 32);

    printf("Upsampling %d samples w/ window size = %d...\n", upCount, windowSize);

    // loop over all upsamples
    while (upIndex < upCount) {
        int origIndex = upsamples[upIndex] * sampleRate; // gets the nearest orig index to the given time stamp

        int lower = max(0, origIndex - windowSize/2) + windowSize/2 - origIndex;
        int upper = min(dataCount, origIndex + windowSize/2+1) + windowSize/2 - origIndex;

        double sum = 0;
        for (int i = lower; i < upper; i++) {
            int origN = origIndex + i - windowSize/2;

            float dt = upsamples[upIndex]*sampleRate - origN;
            double sinc = dt == 0 ? 1 : sin(M_PI * dt) / (M_PI * dt);
            sum += (double)data[origN] * sinc;
        }
        result[upIndex] = sum;

        upIndex++;
    }

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
            
            __m256i buff = _mm256_load_si256((const __m256i*)chunk);
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
    float* upsamples = upsampleCurve(params.startSpd, params.endSpd, params.delayTime, params.holdTime, origCount, header.sampleRate, &upCount);
    int32_t* upsampledData = fastSincInterp(header.sampleRate, data, origCount, upsamples, upCount, 4095);
    free(upsamples);

    writeWavfile(params.outFile, &header, upsampledData, upCount);

    _mm_free(data);
    _mm_free(upsampledData);
    return 0;
}
