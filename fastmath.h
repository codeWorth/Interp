#define _USE_MATH_DEFINES
#include <math.h>

#define SINE_TABLE_POWER 9
#define SINE_TABLE_SIZE 512

double sineTable_4q[SINE_TABLE_SIZE];
float f_sineTable_4q[SINE_TABLE_SIZE];
void GEN_TRIG_TABLE() {
    for (int i = 0; i < SINE_TABLE_SIZE; i++) {
        double x = ((double)i * 2 * M_PI) / SINE_TABLE_SIZE;
        sineTable_4q[i] = sin(x);
        f_sineTable_4q[i] = sin(x);
    }
}

const float F_PI = M_PI;

// nsin time: 7.922 sec
// test1:
//      fsin: 0.813 sec, 512 halfsine table
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
//      fsin: 0.600 sec, 2048 fullsine table
//      fsin error: -162.37db
double fastSinD(double x) {
    int sinIndex = x * (0.5f * SINE_TABLE_SIZE / M_PI);
    double delta = x - sinIndex * (2.f * M_PI / SINE_TABLE_SIZE); // distance from x to nearest val in table
    int cosIndex = sinIndex + SINE_TABLE_SIZE/4; // cosine aka sine derivative is always pi/4 ahead of sine

    sinIndex &= SINE_TABLE_SIZE-1;
    cosIndex &= SINE_TABLE_SIZE-1;

    double sinVal = sineTable_4q[sinIndex];
    double cosVal = sineTable_4q[cosIndex];

    return sinVal + (cosVal - 0.5f*sinVal*delta) * delta;
}

// fastSinF is 2x faster than chebSin (16.950 vs 7.816) under indentical circumstances
float fastSinF(float x) {
    int sinIndex = x * (0.5f * SINE_TABLE_SIZE / F_PI);
    float delta = x - sinIndex * (2.f * F_PI / SINE_TABLE_SIZE); // distance from x to nearest val in table
    int cosIndex = sinIndex + SINE_TABLE_SIZE/4; // cosine aka sine derivative is always pi/4 ahead of sine

    sinIndex &= SINE_TABLE_SIZE-1;
    cosIndex &= SINE_TABLE_SIZE-1;

    float sinVal = f_sineTable_4q[sinIndex];
    float cosVal = f_sineTable_4q[cosIndex];

    return sinVal + (cosVal - 0.5f*sinVal*delta) * delta;
}

// Switching to floats somehow causes ~1 second slowdown
// Hopefully SIMD easily makes up the difference
// test 1:
//      simd: 3.214 sec
//      error: -87.3db
void fastSinSIMD(__m256* xs, __m256* result) {
    // x * (0.5f * SINE_TABLE_SIZE / M_PI);
    __m256 scale = _mm256_set1_ps(0.5f * SINE_TABLE_SIZE / F_PI);
    __m256i sinIndex = _mm256_cvtps_epi32(_mm256_mul_ps(*xs, scale));

    // sinIndex * (-2.f * M_PI / SINE_TABLE_SIZE) + x;
    scale = _mm256_set1_ps(-2.f * F_PI / SINE_TABLE_SIZE);
    __m256 sinIndex_f = _mm256_cvtepi32_ps(sinIndex);
    __m256 delta =  _mm256_fmadd_ps(scale, sinIndex_f, *xs);

    // sinIndex + SINE_TABLE_SIZE/4
    __m256i offset = _mm256_set1_epi32(SINE_TABLE_SIZE/4);
    __m256i cosIndex = _mm256_add_epi32(sinIndex, offset);

    // sinIndex &= SINE_TABLE_SIZE-1;
    // cosIndex &= SINE_TABLE_SIZE-1;
    __m256i mask = _mm256_set1_epi32(SINE_TABLE_SIZE-1);
    sinIndex = _mm256_and_si256(sinIndex, mask);
    cosIndex = _mm256_and_si256(cosIndex, mask);

    // double sinVal = sineTable_4q[sinIndex];
    // double cosVal = sineTable_4q[cosIndex];
    __m256 sinVal = _mm256_i32gather_ps(f_sineTable_4q, sinIndex, sizeof(float));
    __m256 cosVal = _mm256_i32gather_ps(f_sineTable_4q, cosIndex, sizeof(float));

    // (-0.5f*sinVal*delta + cosVal)
    scale = _mm256_set1_ps(-0.5f);
    __m256 inner = _mm256_mul_ps(scale, sinVal);
    inner = _mm256_fmadd_ps(inner, delta, cosVal);

    // (cosVal - 0.5f*sinVal*delta) * delta + sinVal;
    *result = _mm256_fmadd_ps(inner, delta, sinVal);
}

// test 1:
//      chebsin: 1.644 sec
//      error: -133.35db
// test 2:
//      chebsin bitwise: 16.950
//      error: -134db
// test 3:
//      chebsin ternary: 18.87
//      error: -136db
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

    int piCount = x / pi_major; // number of whole PIs contained in x
    int piSign = piCount >> 31; // piCount > 0 ? 0x00 : 0xFF;
    int diff = ((piCount&1) ^ piSign) + (piSign&1); // negate (piCount&1) if piSign is 0xFF
    // int diff = piCount > 0 ? piCount&1 : -(piCount&1);

    x += 2*M_PI * -(piCount/2 + diff);

    float x2 = x*x;
    float p11 = chebCoeffs[5];
    float p9  = p11*x2 + chebCoeffs[4];
    float p7  = p9*x2  + chebCoeffs[3];
    float p5  = p7*x2  + chebCoeffs[2];
    float p3  = p5*x2  + chebCoeffs[1];
    float p1  = p3*x2  + chebCoeffs[0];
    return (x - pi_major - pi_minor) * (x + pi_major + pi_minor) * p1 * x;
}

// void chebSinSIMD(__m256* x, __m256* result) {
//     __m256 pi_major = _mm256_set1_ps(3.1415927f);
//     __m256 pi_minor = _mm256_set1_ps(-0.00000008742278f);
//     __m256i ones = _mm256_set1_epi32(1);

//     __m256i piCount = _mm256_cvtps_epi32(_mm256_div_ps(*x, pi_major));
//     __m256i piSign = _mm256_srai_epi32(piCount, 31);
//     __m256i diff =  _mm256_add_epi32(
//         _mm256_xor_epi32(
//             _mm256_and_si256(piCount, ones), 
//             piSign), 
//         _mm256_and_si256(piSign, ones)
//     );


//     x += 2*M_PI * -(piCount/2 + diff);

//     float x2 = x*x;
//     float p11 = chebCoeffs[5];
//     float p9  = p11*x2 + chebCoeffs[4];
//     float p7  = p9*x2  + chebCoeffs[3];
//     float p5  = p7*x2  + chebCoeffs[2];
//     float p3  = p5*x2  + chebCoeffs[1];
//     float p1  = p3*x2  + chebCoeffs[0];
//     return (x - pi_major - pi_minor) * (x + pi_major + pi_minor) * p1 * x;
// }

// per https://stackoverflow.com/questions/13219146/how-to-sum-m256-horizontally
float sum8(__m256* x) {
    const __m128 hiQuad = _mm256_extractf128_ps(*x, 1);
    const __m128 loQuad = _mm256_castps256_ps128(*x);
    const __m128 sumQuad = _mm_add_ps(loQuad, hiQuad);

    const __m128 loDual = sumQuad;
    const __m128 hiDual = _mm_movehl_ps(sumQuad, sumQuad);
    const __m128 sumDual = _mm_add_ps(loDual, hiDual);

    const __m128 lo = sumDual;
    const __m128 hi = _mm_shuffle_ps(sumDual, sumDual, 0x1);
    const __m128 sum = _mm_add_ss(lo, hi);
    
    return _mm_cvtss_f32(sum);
}