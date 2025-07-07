#define _USE_MATH_DEFINES
#include <math.h>

#define SINE_TABLE_POWER 11
#define SINE_TABLE_SIZE 2048

double sineTable_4q[SINE_TABLE_SIZE];
void GEN_TRIG_TABLE() {
    for (int i = 0; i < SINE_TABLE_SIZE; i++) {
        double x = ((double)i * 2 * M_PI) / SINE_TABLE_SIZE;
        sineTable_4q[i] = sin(x);
    }
}

// nsin time: 7.922 sec
// test1:
//      fsin: 0.813 sec, 512 halfsine table
//      
//      fsin error: -132.5db
// test2:
//      fsin: 0.822 sec, 256 halfsine table
//      fsin error: -113.6db
// test3:
//      fsin: 0.823, 2048 halfsine table
//      fsin error: -149.33db
// test4:
//      fsin: 0.954, 2048 halfsine table, float
//      fsin error: -133.38db
// test5:
//      fsin: 0.622, 2048 halfsine table, int truc instead of floor
//      fsin error: -168.61db
// test6:
//      fsin: 0.758, 2048 halfsine table, inv w/ math instead of if
//      fsin error: -168.61db
// test7: remove extra bit ops, func identical, 0.622 => 0.619
// test8:
//      fsin: 600 sec, 2048 fullsine table
//      fsin error: -162.37db
double fastSin(double x) {
    int sinIndex = x * (0.5f * SINE_TABLE_SIZE / M_PI);
    double delta = x - sinIndex * (2.f * M_PI / SINE_TABLE_SIZE); // distance from x to nearest val in table
    int cosIndex = sinIndex + SINE_TABLE_SIZE/4; // cosine aka sine derivative is always pi/4 ahead of sine

    sinIndex &= SINE_TABLE_SIZE-1;
    cosIndex &= SINE_TABLE_SIZE-1;

    double sinVal = sineTable_4q[sinIndex];
    double cosVal = sineTable_4q[cosIndex];

    return sinVal + (cosVal - 0.5f*sinVal*delta) * delta;
}

// test 1:
//      chebsin: 1.644 sec
//      error: -133.35db
// from https://mooooo.ooo/chebyshev-sine-approximation/
const float chebCoeffs[6] = {
    -0.10132118f,           // x
    0.0066208798f,          // x^3
    -0.00017350505f,        // x^5
    0.0000025222919f,       // x^7
    -0.000000023317787f,    // x^9
    0.00000000013291342f,   // x^11
};
float chebSin(float x) {
    float pi_major = 3.1415927f;
    float pi_minor = -0.00000008742278f;

    int piCount = x / pi_major;
    int pi2Count = piCount / 2;
    if (piCount > 0) {
        pi2Count += piCount & 1;
    } else {
        pi2Count -= piCount & 1;
    }
    x += 2*M_PI * -pi2Count;

    float x2 = x*x;
    float p11 = chebCoeffs[5];
    float p9  = p11*x2 + chebCoeffs[4];
    float p7  = p9*x2  + chebCoeffs[3];
    float p5  = p7*x2  + chebCoeffs[2];
    float p3  = p5*x2  + chebCoeffs[1];
    float p1  = p3*x2  + chebCoeffs[0];
    return (x - pi_major - pi_minor) * (x + pi_major + pi_minor) * p1 * x;
}