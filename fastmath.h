#define _USE_MATH_DEFINES
#include <math.h>

#define SINE_TABLE_POWER 11
#define SINE_TABLE_SIZE 2048

double sineTable_2q[SINE_TABLE_SIZE];
void GEN_TRIG_TABLE() {
    for (int i = 0; i < SINE_TABLE_SIZE; i++) {
        double x = ((double)i * M_PI) / SINE_TABLE_SIZE;
        sineTable_2q[i] = sin(x);
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
double fastSin(double x) {
    int sinIndex = x * (SINE_TABLE_SIZE / M_PI); // index will be [0,SINE_TABLE_SIZE) for x in pos half
    double delta = x - sinIndex * (M_PI / SINE_TABLE_SIZE); // distance from x to nearest val in table
    int cosIndex = sinIndex + SINE_TABLE_SIZE/2; // cosine aka sine derivative is always pi/4 ahead of sine

    int negSin = sinIndex & SINE_TABLE_SIZE; // 0 when sinIndex in q1,q2, nonzero when q3,q4
    int negCos = cosIndex & SINE_TABLE_SIZE;

    sinIndex &= SINE_TABLE_SIZE-1;
    cosIndex &= SINE_TABLE_SIZE-1;

    double sinVal = sineTable_2q[sinIndex];
    double cosVal = sineTable_2q[cosIndex];

    if (negSin) sinVal *= -1;
    if (negCos) cosVal *= -1;

    return sinVal + (cosVal - 0.5f*sinVal*delta) * delta;
}