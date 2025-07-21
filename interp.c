#include <stdlib.h>
#include <immintrin.h>
#include <stdio.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <assert.h>
#include <time.h>
#include <process.h>
#include <windows.h>

// large aliasing? spike with window size = 64
#define WINDOW_SIZE 256 // must be a factor of 8
#include "fastmath.h"
#include "wavfile.h"

#define F_PI 3.1415926535f
// SIMD: 14400 ms, -97.2db
// No SIMD: 22510 ms, -98.6db
#define SIMD
#define MAX_THREADS 12
#define MIN_THREAD_WORK 65536
// #define VERBOSE

typedef enum {
    EXEC_R = 0,
    HELP_R = 1,
    ERROR_R = 2
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
    ChannelView dest;
    const float* paddedData; 
    const double* upsamples;
    int sampleRate;
    int windowSize;
    int tStart;
    int tEnd;
    int tIndex;
} ThreadParams;

void _fastSincInterp(void* tParams_);

ParseResult parseParams(int argc, char const* argv[], Params* params) {
    char const* param = NULL;
    int foundParams = 0;

    for (int i = 1; i < argc; i++) {
        if (strcmp(argv[i], "-h") == 0) {
            return HELP_R;
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
    return foundParams == 6 ? EXEC_R : ERROR_R;
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
 * @param windowSize How large of a region around each sample to perform sinc interpolation. Must be a factor of 8
 */
void dispatchFastSincInterp(ChannelView dest, ChannelView channel, int sampleRate, const double* upsamples, int windowSize) {
    assert(windowSize % 8 == 0);
    struct timespec start, finish;

    float* paddedData = _aligned_malloc(sizeof(float) * (channel.count + windowSize), 32);
    padChannel(paddedData, channel, windowSize/2, 0.f);

    printf("Upsampling %d samples from channel %d w/ window size = %d...\n", dest.count, channel.offset+1, windowSize);

    clock_gettime(CLOCK_REALTIME, &start);

    int threadCount = min(MAX_THREADS, dest.count / MIN_THREAD_WORK);
    int threadSize = dest.count / threadCount;
    threadSize = lrint(threadSize / 16.0) * 16; // keep each thread on 64 byte bounadries to avoid false sharing

    if (threadSize < MIN_THREAD_WORK || threadCount == 1) {
        ThreadParams params = {dest, paddedData, upsamples, sampleRate, windowSize, 0, dest.count, 0};
        _fastSincInterp(&params);
    } else {
        printf("Spinning up %d threads...\n", threadCount);
        HANDLE threads[threadCount];
        ThreadParams params[threadCount];
        for (int i = 0; i < threadCount; i++) {
            int end = i == threadCount-1 ? dest.count : (i+1)*threadSize;
            params[i] = (ThreadParams){dest, paddedData, upsamples, sampleRate, windowSize, i*threadSize, end, i};
            threads[i] = (HANDLE)_beginthread(_fastSincInterp, 0, params + i);
        }
        for (int i = 0; i < threadCount; i++) {
            WaitForSingleObject(threads[i], INFINITE);
        }
    }

    clock_gettime(CLOCK_REALTIME, &finish);

    _aligned_free(paddedData);

    printf("Proc took %d milliseconds.\n", (finish.tv_sec - start.tv_sec)*1000 + (finish.tv_nsec - start.tv_nsec) / 1000000L);
    printf("Done upsampling channel %d...\n", channel.offset+1);
}

inline VecPairF doublePrecisionDT(VecPairI origN, __m256d upsample) {
    // Almost all float error is removed by using doubles to subtract instead of floats
    // double dt = upsamples[upIndex]*sampleRate - origN;
    __m256d origN_d_L1 = _mm256_cvtepi32_pd(_mm256_castsi256_si128(origN.a)); // lower half
    __m256d origN_d_U1 = _mm256_cvtepi32_pd(_mm256_extracti128_si256(origN.a, 1)); // upper half
    __m256d origN_d_L2 = _mm256_cvtepi32_pd(_mm256_castsi256_si128(origN.b));
    __m256d origN_d_U2 = _mm256_cvtepi32_pd(_mm256_extracti128_si256(origN.b, 1));

    __m256d dt_L1 = upsample - origN_d_L1;
    __m256d dt_U1 = upsample - origN_d_U1;
    __m256d dt_L2 = upsample - origN_d_L2;
    __m256d dt_U2 = upsample - origN_d_U2;

    return (VecPairF){
        _mm256_set_m128(_mm256_cvtpd_ps(dt_U1), _mm256_cvtpd_ps(dt_L1)),
        _mm256_set_m128(_mm256_cvtpd_ps(dt_U2), _mm256_cvtpd_ps(dt_L2))
    };
}

void _fastSincInterp(void* tParams_) {
    ThreadParams tParams = *(ThreadParams*)tParams_;
    const double* upsamples = tParams.upsamples;
    int windowSize = tParams.windowSize;

    #ifdef VERBOSE
    printf("Starting thread %d for samples %d .. %d\n", tParams.tIndex, tParams.tStart, tParams.tEnd);
    #endif

    #ifdef SIMD
    // prepare some vectors
    __m256 PI = _mm256_set1_ps(M_PI);
    __m256i offset = _mm256_set1_epi32(8);
    #endif

    // loop over all upsamples
    int upIndex = tParams.tStart;
    while (upIndex < tParams.tEnd) {
        int origIndex = lrint(upsamples[upIndex] * tParams.sampleRate); // gets the nearest orig index to the given time stamp

        #ifdef SIMD

        __m256d upsample = _mm256_set1_pd(upsamples[upIndex] * tParams.sampleRate);
        __m256i origN = _mm256_add_epi32(
            _mm256_setr_epi32(0, 1, 2, 3, 4, 5, 6, 7), 
            _mm256_set1_epi32(origIndex - windowSize/2)
        ); // origN = origIndex - windowSize/2 + i

        double sum = 0;

        for (int i = 0; i < windowSize; i += 16) {
            // origN will always be 8 adjacent indecies beginning at (origIndex + i)
            __m256 dataChunk1 = _mm256_loadu_ps(tParams.paddedData + origIndex + i);
            __m256 dataChunk2 = _mm256_loadu_ps(tParams.paddedData + origIndex + (i+8));

            __m256i origN_next = _mm256_add_epi32(origN, offset);
            VecPairF dt = doublePrecisionDT((VecPairI){origN, origN_next}, upsample);
            VecPairF kaiser = fastKaiser_simd(dt);

            __m256 xs1 = PI * dt.a;
            __m256 xs2 = PI * dt.b;
            __m256 isZero1 = _mm256_cmp_ps(xs1, _mm256_setzero_ps(), _CMP_EQ_OQ); // dt == 0
            __m256 isZero2 = _mm256_cmp_ps(xs2, _mm256_setzero_ps(), _CMP_EQ_OQ);
            VecPairF sines = padeSin_simd((VecPairF){xs1, xs2});    // cheb vs LUT vs pade all give basically the same result
                                                                    // pade is slightly faster than cheb and ~1.5x faster than LUT

            __m256 divs1 = sines.a / xs1 * kaiser.a; // sinc calculation, not including zero asymptote
            __m256 divs2 = sines.b / xs2 * kaiser.b;
            __m256 results1 = _mm256_blendv_ps(dataChunk1 * divs1, dataChunk1, isZero1); // res = dt != 0 ? data*sinc : data*1
            __m256 results2 = _mm256_blendv_ps(dataChunk2 * divs2, dataChunk2, isZero2);
            __m256 results = results1 + results2;

            sum += sum8(results);

            origN = _mm256_add_epi32(origN_next, offset);
        }

        #else

        double sum = 0;

        for (int i = 0; i < windowSize; i++) {
            int origN = origIndex - windowSize/2 + i;
            
            double dt = upsamples[upIndex]*tParams.sampleRate - origN;
            double sinc = dt == 0 ? 1 : fastSinD(M_PI * dt) / (M_PI * dt);
            sum += tParams.paddedData[origIndex + i] * sinc;
        }

        #endif

        v_put(&tParams.dest, upIndex, sum);
        
        #ifdef VERBOSE
        const int chunkSize = 131072;
        int delta = upIndex - tStart;
        if (delta % chunkSize == 0 && delta >= chunkSize) {
            printf("\tFinished chunk %d for thread %d\n", delta/chunkSize, tParams.tIndex);
        }
        #endif

        upIndex++;
    }
}

int main(int argc, char const *argv[]) {
    GEN_TRIG_TABLE();
    GEN_BESSEL_TABLE();

    Params params;
    ParseResult result = parseParams(argc, argv, &params);

    if (result == HELP_R) {
        printf("Use the following params:\n\t-i\tin file path\n\t-s\tstart rate\n\t-e\tend rate\n\t-d\tstart delay time\n\t-H\tend hold time\n\tout file path\n");
        return 0;
    } else if (result == ERROR_R) {
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
        dispatchFastSincInterp(
            (ChannelView){upsampledData, c, wavInfo.fmtChunk.numChannels, upCount}, 
            (ChannelView){data, c, wavInfo.fmtChunk.numChannels, origCount},
            wavInfo.fmtChunk.sampleRate, upsamples,
            WINDOW_SIZE
        );
    }

    printf("Finished upsampling, writing result...\n");
    writeWavfile(params.outFile, &wavInfo, upsampledData, upCount * wavInfo.fmtChunk.numChannels);

    free(upsampledData);
    free(upsamples);
    return 0;
}
