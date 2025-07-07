#include <immintrin.h>
#include "fastmath.h"
#include <time.h>
#include <stdio.h>

void benchmarkCallingFunc() {
    struct timespec start, finish;

    int data[10000];
    float samples[10000];
    for (int i = 0; i < 10000; i++) {
        samples[i] = ((i*91) % 100000) / 1000.f;
    }

    // spin up
    printf("Spin up... ");
    for (double x = -30000.0; x < 30000.0; x += 0.001001) {
        double sin = fastSinD(x);
    }
    for (float x = -30000.f; x < 30000.f; x += 0.001001f) {
        float sin = fastSinF(x);
    }
    printf("done\n");

    clock_gettime(CLOCK_REALTIME, &start);
    double result = 0;
    for (int n = 0; n < 10; n++) {
        for (int k = 0; k < 10000; k++) {
            double sum = 0;

            for (int i = 0; i < 4095; i++) {

                double dt = samples[(k+n)%10000]*10 - i;
                float sinc = dt == 0 ? 1 : fastSinD(M_PI * dt) / (M_PI * dt);
                sum += (double)data[(i*k+n) % 10000] * sinc;
            }

            result += sum;
        }
    }
    printf("%f\n", result);
    clock_gettime(CLOCK_REALTIME, &finish);

    printf("Double fast sin took %d milliseconds.\n", (finish.tv_sec - start.tv_sec)*1000 + (finish.tv_nsec - start.tv_nsec) / 1000000L);

    clock_gettime(CLOCK_REALTIME, &start);
    result = 0;
    for (int n = 0; n < 10; n++) {
        for (int k = 0; k < 10000; k++) {
            double sum = 0;

            for (int i = 0; i < 4095; i++) {

                float dt = samples[(k+n)%10000]*10 - i;
                float sinc = dt == 0 ? 1 : fastSinF(M_PI * dt) / (M_PI * dt);
                sum += (float)data[(i*k+n) % 10000] * sinc;
            }

            result += sum;
        }
    }
    printf("%f\n", result);
    clock_gettime(CLOCK_REALTIME, &finish);

    printf("Float fast sin took %d milliseconds.\n", (finish.tv_sec - start.tv_sec)*1000 + (finish.tv_nsec - start.tv_nsec) / 1000000L);
}

void benchmarkFastSin() {
    struct timespec start, finish;

    // spin up
    printf("Spin up... ");
    for (double x = -30000.0; x < 30000.0; x += 0.001001) {
        double sin = fastSinD(x);
    }
    for (float x = -30000.f; x < 30000.f; x += 0.001001f) {
        float sin = fastSinF(x);
    }
    printf("done\n");

    clock_gettime(CLOCK_REALTIME, &start);
    for (int k = 0; k < 100; k++) {
        for (double x = -30000.0; x < 30000.0; x += 0.01001) {
            double sin = fastSinD(x);
        }
    }
    clock_gettime(CLOCK_REALTIME, &finish);

    printf("Double fast sin took %d milliseconds.\n", (finish.tv_sec - start.tv_sec)*1000 + (finish.tv_nsec - start.tv_nsec) / 1000000L);

    clock_gettime(CLOCK_REALTIME, &start);
    for (int k = 0; k < 100; k++) {
        for (float x = -30000.f; x < 30000.f; x += 0.01001f) {
            float sin = fastSinF(x);
        }
    }
    clock_gettime(CLOCK_REALTIME, &finish);

    printf("Float fast sin took %d milliseconds.\n", (finish.tv_sec - start.tv_sec)*1000 + (finish.tv_nsec - start.tv_nsec) / 1000000L);
}

// Test results show no significant difference between double and float approx.
// Therefore, speed diff in main program must be due to float->double conversion in the calling code.
int main(int argc, char const *argv[]) {
    GEN_TRIG_TABLE();

    benchmarkCallingFunc();

    return 0;
}