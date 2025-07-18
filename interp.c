#include <stdlib.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <time.h>
#include "fastmath.h"

#define IO_CHUNK_SIZE 2048
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

typedef struct {
    float* data;
    int offset;
    int stride;
    int count;
} ChannelView;

inline int min(int a, int b) {
    return a < b ? a : b;
}

/**
 * @brief Retrieve the value stored at the given index of the view of the interleaved data.
 * 
 * @param view Channel view to read into.
 * @param i Index.
 * @return float Value at the given index.
 */
inline float v_get(const ChannelView* view, int i) {
    return view->data[view->offset + i * view->stride];
}

/**
 * @brief Store the given value at the given index in interleaved data.
 * 
 * @param view Channel view to write into.
 * @param i Index.
 * @param value Value to write.
 */
inline void v_put(const ChannelView* view, int i, float value) {
    view->data[view->offset + i * view->stride] = value;
}

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
 * @brief Copy given interleaved channel into dest with padding on either side.
 * 
 * @param dest Destination array.
 * @param channelView Source channel.
 * @param padWidth Size of padding on each side.
 * @param padValue Value to pad with.
 */
void padChannel(float* dest, ChannelView channelView, int padWidth, float padValue) {
    for (int i = 0; i < padWidth; i++) {
        dest[i] = padValue;
        dest[i+padWidth+channelView.count] = padValue;
    }
    for (int i = 0; i < channelView.count; i++) {
        dest[i+padWidth] = v_get(&channelView, i);
    }
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
 * @return Array containing the upsampled time stamps. Memory must be freed by caller.
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
    assert(upsamples != NULL);

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
 * Large differences in sample and upsample time have no significant effect, because sinc(X->inf) -> 0
 * 
 * @param dest Destination channel in interleaved array.
 * @param channel Channel from interleaved audio to upsample.
 * @param sampleRate Sample rate of the original audio.
 * @param upsamples New time points with which to upsample.
 * @param upCount Number of new samples.
 * @param windowSize How large of a region around each sample to perform sinc interpolation
 */
void fastSincInterp(ChannelView dest, ChannelView channel, int sampleRate, const double* upsamples, int windowSize) {
    struct timespec start, finish;

    int paddedWindowSize = ceil(windowSize / 8.f) * 8;
    float* paddedData = _aligned_malloc(sizeof(float) * (channel.count + paddedWindowSize), 32);
    padChannel(paddedData, channel, paddedWindowSize/2, 0.f);

    int upIndex = 0;

    printf("Upsampling %d samples w/ window size = %d...\n", dest.count, windowSize);

    clock_gettime(CLOCK_REALTIME, &start);

    #ifdef SIMD
    // prepare some vectors
    __m256i inc = _mm256_setr_epi32(0, 1, 2, 3, 4, 5, 6, 7);
    __m256 PI = _mm256_set1_ps(M_PI);
    __m256 ones = _mm256_set1_ps(1.f);
    __m256i offset = _mm256_set1_epi32(8);
    #endif

    // loop over all upsamples
    while (upIndex < dest.count) {
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

        v_put(&dest, upIndex, sum);
        upIndex++;
    }
    clock_gettime(CLOCK_REALTIME, &finish);

    _aligned_free(paddedData);

    printf("Proc took %d milliseconds.\n", (finish.tv_sec - start.tv_sec)*1000 + (finish.tv_nsec - start.tv_nsec) / 1000000L);
    printf("Done upsampling, writing result...\n");
}

int getDataEntriesCount(const WavInfo* wavInfo) {
    return wavInfo->dataHeader.chunkSize / (wavInfo->fmtChunk.bitDepth/8);
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

/**
 * @brief Reads the audio data in the given file into the given destination.
 * The current file read position should be at the start of the data.
 * 
 * @param dest Destination array.
 * @param inFile File to read from.
 * @param wavInfo Wave file info from header chunks.
 * @return true Successfully read data.
 * @return false Some error occured.
 */
bool readWavData(float* dest, FILE* inFile, const WavInfo* wavInfo) {
    int dataCount = getDataEntriesCount(wavInfo);

    if (wavInfo->fmtChunk.bitDepth == 32) {

        int32_t chunk[IO_CHUNK_SIZE];
        int i = 0;
        while (i < dataCount) {
            int readCount = min(IO_CHUNK_SIZE, dataCount - i);
            fread(chunk, sizeof(int32_t), readCount, inFile);
            for (int j = 0; j < readCount; j++) dest[i+j] = chunk[j];
            i += readCount;
        }

        printf("Read all %d values...\n", dataCount);

    } else if (wavInfo->fmtChunk.bitDepth == 24) {

        int8_t chunk[IO_CHUNK_SIZE/4*3];
        int bI = 0;
        int bCount = dataCount*3;
        while (bI < bCount) {
            int readSize = min(IO_CHUNK_SIZE/4*3, bCount - bI);
            fread(chunk, sizeof(uint8_t), readSize, inFile);

            for (int j = 0; j < readSize; j += 3) {
                int32_t result = chunk[j+2] << 16; // setting the highest byte first also sets the sign bits
                result |= (chunk[j+1] << 8) & 0xFF00;
                result |= chunk[j] & 0xFF;

                dest[(bI + j)/3] = result;
            }
            
            bI += readSize;
        }

        printf("Read all %d values...\n", dataCount);

    } else if (wavInfo->fmtChunk.bitDepth == 16) {
        
        int16_t chunk[IO_CHUNK_SIZE];
        int i = 0;
        while (i < dataCount) {
            int readCount = min(IO_CHUNK_SIZE, dataCount - i);
            fread(chunk, sizeof(int16_t), readCount, inFile);
            for (int j = 0; j < readCount; j++) dest[i+j] = chunk[j];
            i += readCount;
        }

        printf("Read all %d values...\n", dataCount);

    } else {
        printf("Bit depth %d not supported.\n", wavInfo->fmtChunk.bitDepth);
    }

    return true;
}

void writeHeader(FmtChunk fmtChunk, int dataEntriesCount, FILE* outFile) {
    ChunkHeader dataHeader;
    writeStr(dataHeader.chunkID, "data", 4);
    dataHeader.chunkSize = dataEntriesCount * (fmtChunk.bitDepth/8);

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

bool writeWavfile(const char* outPath, const WavInfo* wavInfo, const float* data, int count) {
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

    if (wavInfo->fmtChunk.bitDepth == 32) {

        int32_t chunk[IO_CHUNK_SIZE];
        int i = 0;
        while (i < count) {
            int writeCount = min(IO_CHUNK_SIZE, count - i);
            for (int j = 0; j < writeCount; j++) chunk[j] = data[i+j];
            fwrite(chunk, sizeof(int32_t), writeCount, outFile);
            i += writeCount;
        }

    } else if (wavInfo->fmtChunk.bitDepth == 24) {
        
        uint8_t chunk[IO_CHUNK_SIZE/4*3];
        int bI = 0;
        int bCount = count*3;
        while (bI < bCount) {
            int writeSize = min(IO_CHUNK_SIZE/4*3, bCount - bI);

            for (int j = 0; j < writeSize; j += 3) {
                int32_t value = data[(bI + j)/3];
                
                chunk[j] = value & 0xFF;
                chunk[j+1] = (value >> 8) & 0xFF;
                chunk[j+2] = (value >> 16) & 0xFF; 
            }
            
            fwrite(chunk, sizeof(uint8_t), writeSize, outFile);
            bI += writeSize;
        }

    } else if (wavInfo->fmtChunk.bitDepth == 16) {

        int16_t chunk[IO_CHUNK_SIZE];
        int i = 0;
        while (i < count) {
            int writeCount = min(IO_CHUNK_SIZE, count - i);
            for (int j = 0; j < writeCount; j++) chunk[j] = data[i+j];
            fwrite(chunk, sizeof(int16_t), writeCount, outFile);
            i += writeCount;
        }

    } else {
        printf("Cannot write %d bit depth!\n", wavInfo->fmtChunk.bitDepth);
        return false;
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

    float* data = malloc(sizeof(float) * getDataEntriesCount(&wavInfo));
    assert(data != NULL);
    if (!readWavData(data, inFile, &wavInfo)) {
        return 1;
    }
    fclose(inFile);

    int upCount;
    int origCount = getDataEntriesCount(&wavInfo) / wavInfo.fmtChunk.numChannels;
    double* upsamples = upsampleCurve(
        params.startSpd, params.endSpd, 
        params.delayTime, params.holdTime, 
        origCount, wavInfo.fmtChunk.sampleRate, 
        &upCount
    );

    float* upsampledData = malloc(sizeof(float) * upCount * wavInfo.fmtChunk.numChannels);
    assert(upsampledData != NULL);
    for (int c = 0; c < wavInfo.fmtChunk.numChannels; c++) {
        fastSincInterp(
            (ChannelView){upsampledData, c, wavInfo.fmtChunk.numChannels, upCount}, 
            (ChannelView){data, c, wavInfo.fmtChunk.numChannels, origCount},
            wavInfo.fmtChunk.sampleRate, upsamples,
            8191
        );
    }

    writeWavfile(params.outFile, &wavInfo, upsampledData, upCount * wavInfo.fmtChunk.numChannels);

    free(upsampledData);
    free(upsamples);
    return 0;
}
