#define _USE_MATH_DEFINES
#include <math.h>

#define SINE_TABLE_POWER 9
#define SINE_TABLE_SIZE 512

float sineTable_1q[SINE_TABLE_SIZE];
void GEN_TRIG_TABLE() {
    for (int i = 0; i < SINE_TABLE_SIZE; i++) {
        double x = ((double)i * 0.5 * M_PI) / SINE_TABLE_SIZE;
        sineTable_1q[i] = sin(x);
    }
}

// error seems to be on the order of -80db
inline float fastSin(float x) {
    int sinIndex = x * 2/M_PI * SINE_TABLE_SIZE; // index will be [0,SINE_TABLE_SIZE) for x in first quadrant
    float delta = x - sinIndex * (0.5f * M_PI / SINE_TABLE_SIZE); // distance from x to nearest val in table
    int cosIndex = sinIndex + SINE_TABLE_SIZE; // cosine aka sine derivative is always pi/4 ahead of sine

    int negSin = ((sinIndex & (SINE_TABLE_SIZE*2)) >> (SINE_TABLE_POWER+1)) & 1; // 0 when sinIndex in q1,q2, 1 when q3,q4
    int negCos = ((cosIndex & (SINE_TABLE_SIZE*2)) >> (SINE_TABLE_POWER+1)) & 1;

    int flipSin = ((sinIndex & SINE_TABLE_SIZE) >> SINE_TABLE_POWER) & 1; // 0 when sinIndex in q1,q3, 1 when q2,q4
    int flipCos = ((cosIndex & SINE_TABLE_SIZE) >> SINE_TABLE_POWER) & 1;

    sinIndex *= -2*flipSin + 1;
    sinIndex += SINE_TABLE_SIZE * flipSin;
    cosIndex *= -2*flipCos + 1;
    cosIndex += SINE_TABLE_SIZE * flipCos;

    sinIndex &= SINE_TABLE_SIZE-1;
    cosIndex &= SINE_TABLE_SIZE-1;

    float sinVal = sineTable_1q[sinIndex];
    float cosVal = sineTable_1q[cosIndex];

    sinVal *= -2*negSin + 1;
    cosVal *= -2*negCos + 1;

    return sinVal + (cosVal - 0.5f*sinVal*delta) * delta;
}