#define _USE_MATH_DEFINES
#include <math.h>

typedef struct {
    __m256 a;
    __m256 b;
} VecPairF;
typedef struct {
    __m256i a;
    __m256i b;
} VecPairI;

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
inline __m256 fastSinSIMD(__m256 xs) {
    // x * (0.5f * SINE_TABLE_SIZE / M_PI);
    __m256 scale = _mm256_set1_ps(0.5f * SINE_TABLE_SIZE / F_PI);
    __m256i sinIndex = _mm256_cvtps_epi32(xs * scale);

    // sinIndex * (-2.f * M_PI / SINE_TABLE_SIZE) + x;
    scale = _mm256_set1_ps(-2.f * F_PI / SINE_TABLE_SIZE);
    __m256 sinIndex_f = _mm256_cvtepi32_ps(sinIndex);
    __m256 delta =  _mm256_fmadd_ps(scale, sinIndex_f, xs);

    // sinIndex + SINE_TABLE_SIZE/4
    __m256i offset = _mm256_set1_epi32(SINE_TABLE_SIZE/4);
    __m256i cosIndex = sinIndex + offset;

    // sinIndex &= SINE_TABLE_SIZE-1;
    // cosIndex &= SINE_TABLE_SIZE-1;
    __m256i mask = _mm256_set1_epi32(SINE_TABLE_SIZE-1);
    sinIndex = sinIndex & mask;
    cosIndex = cosIndex & mask;

    // double sinVal = sineTable_4q[sinIndex];
    // double cosVal = sineTable_4q[cosIndex];
    __m256 sinVal = _mm256_i32gather_ps(f_sineTable_4q, sinIndex, sizeof(float));
    __m256 cosVal = _mm256_i32gather_ps(f_sineTable_4q, cosIndex, sizeof(float));

    // (-0.5f*sinVal*delta + cosVal)
    scale = _mm256_set1_ps(-0.5f);
    __m256 inner = _mm256_fmadd_ps(scale * sinVal, delta, cosVal);

    // (cosVal - 0.5f*sinVal*delta) * delta + sinVal;
    return _mm256_fmadd_ps(inner, delta, sinVal);
}
void fastSinSIMD_d(__m256d* xs, __m256d* result) {
    __m256d scale = _mm256_set1_pd(0.5f * SINE_TABLE_SIZE / F_PI);
    __m256i sinIndex = _mm256_castsi128_si256(_mm256_cvtpd_epi32(*xs * scale));

    scale = _mm256_set1_pd(-2.f * F_PI / SINE_TABLE_SIZE);
    __m256d sinIndex_f = _mm256_cvtepi32_pd(_mm256_castsi256_si128(sinIndex));
    __m256d delta =  _mm256_fmadd_pd(scale, sinIndex_f, *xs);

    __m256i offset = _mm256_set1_epi32(SINE_TABLE_SIZE/4);
    __m256i cosIndex = sinIndex + offset;

    __m256i mask = _mm256_set1_epi32(SINE_TABLE_SIZE-1);
    sinIndex = sinIndex & mask;
    cosIndex = cosIndex & mask;

    __m256d sinVal = _mm256_i32gather_pd(sineTable_4q, _mm256_castsi256_si128(sinIndex), sizeof(double));
    __m256d cosVal = _mm256_i32gather_pd(sineTable_4q, _mm256_castsi256_si128(cosIndex), sizeof(double));

    scale = _mm256_set1_pd(-0.5f);
    __m256d inner = _mm256_fmadd_pd(scale * sinVal, delta, cosVal);

    *result = _mm256_fmadd_pd(inner, delta, sinVal);
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
// test 4 (in situ):
//      chebsin error: -88db
//      lookup error: -97db
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
    unsigned int u_piCount = piCount;
    int diff = piCount & (~u_piCount >> 31); // equiv to piCount > 0 ? piCount&1 : 0 
    int pi2Count = piCount >> 1 + diff;

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

inline __m256 chebSinSIMD(__m256 x) {
    __m256 pi_major = _mm256_set1_ps(3.1415927f);
    __m256 pi_minor = _mm256_set1_ps(-0.00000008742278f);
    
    __m256 piCount = _mm256_round_ps(
        x / _mm256_set1_ps(2*M_PI),
        _MM_FROUND_TO_NEAREST_INT
    );
    __m256 xNorm = _mm256_fmadd_ps(_mm256_set1_ps(-2*M_PI), piCount, x);
    __m256 x2 = xNorm * xNorm;

    __m256 p11 = _mm256_set1_ps(chebCoeffs[5]);
    __m256 p9  = _mm256_fmadd_ps(p11, x2, _mm256_set1_ps(chebCoeffs[4]));
    __m256 p7  = _mm256_fmadd_ps(p9, x2, _mm256_set1_ps(chebCoeffs[3])); 
    __m256 p5  = _mm256_fmadd_ps(p7, x2, _mm256_set1_ps(chebCoeffs[2])); 
    __m256 p3  = _mm256_fmadd_ps(p5, x2, _mm256_set1_ps(chebCoeffs[1]));
    __m256 p1  = _mm256_fmadd_ps(p3, x2, _mm256_set1_ps(chebCoeffs[0]));

    return (xNorm - pi_major - pi_minor) * (xNorm + pi_major + pi_minor) * p1 * xNorm;
}

// per https://stackoverflow.com/questions/13219146/how-to-sum-m256-horizontally
inline float sum8(__m256 x) {
    const __m128 hiQuad = _mm256_extractf128_ps(x, 1);
    const __m128 loQuad = _mm256_castps256_ps128(x);
    const __m128 sumQuad = _mm_add_ps(loQuad, hiQuad);

    const __m128 loDual = sumQuad;
    const __m128 hiDual = _mm_movehl_ps(sumQuad, sumQuad);
    const __m128 sumDual = _mm_add_ps(loDual, hiDual);

    const __m128 lo = sumDual;
    const __m128 hi = _mm_shuffle_ps(sumDual, sumDual, 0x1);
    const __m128 sum = _mm_add_ss(lo, hi);
    
    return _mm_cvtss_f32(sum);
}
// https://stackoverflow.com/questions/49941645/get-sum-of-values-stored-in-m256d-with-sse-avx
double sum4(__m256d* v) {
    __m128d vlow  = _mm256_castpd256_pd128(*v);
    __m128d vhigh = _mm256_extractf128_pd(*v, 1); // high 128
            vlow  = _mm_add_pd(vlow, vhigh);     // reduce down to 128

    __m128d high64 = _mm_unpackhi_pd(vlow, vlow);
    return  _mm_cvtsd_f64(_mm_add_sd(vlow, high64));  // reduce to scalar
}

// size = 3 -> -99db error
// size = 4 -> -109db error
// size = 5 -> -110.15 error
// size = 6 -> -110.35 error
#define BESSEL_TABLE_SIZE 5
#define ALPHA 15

double bessel0(double x) {
    int k = BESSEL_TABLE_SIZE;
    assert(k < 10); // We will likely hit long overflow at k >= 10, and its uneeded accuracy anyway
    double factors[k];

    long pwr2 = 1;
    long fact = 1;
    for (int i = 0; i < k; i++) {
        long product = pwr2 * fact;
        factors[i] = 1.0 / (double)(product * product); // 1 / (2^k * k!)^2
        pwr2 *= 2.0;
        fact *= i+1;
    }

    double x2 = x*x;
    double sum = factors[k-1];
    for (int i = k-2; i >= 0; i--) {
        sum = factors[i] + x2 * sum;
    }

    return sum;
}

float bessel_table[BESSEL_TABLE_SIZE];
void GEN_BESSEL_TABLE() {
    double denom = bessel0(ALPHA);

    long pwr2 = 1;
    long fact = 1;
    for (int i = 0; i < BESSEL_TABLE_SIZE; i++) {
        long product = pwr2 * fact;
        bessel_table[i] = 1.0 / ((double)(product * product) * denom);
        pwr2 *= 2.0;
        fact *= i+1;
    }
}

double fastBessel0_bakedDiv(double x) {
    double x2 = x*x;

    double sum = bessel_table[BESSEL_TABLE_SIZE-1];
    for (int i = BESSEL_TABLE_SIZE-2; i >= 0; i--) {
        sum = bessel_table[i] + x2 * sum;
    }

    return sum;
}

inline VecPairF fastBessel0_bakedDiv_simd(VecPairF x2) {
    __m256 sum1 = _mm256_set1_ps(bessel_table[BESSEL_TABLE_SIZE-1]);
    __m256 sum2 = sum1;
    for (int i = BESSEL_TABLE_SIZE-2; i >= 0; i--) {
        sum1 = _mm256_fmadd_ps(x2.a, sum1, _mm256_set1_ps(bessel_table[i]));
        sum2 = _mm256_fmadd_ps(x2.b, sum2, _mm256_set1_ps(bessel_table[i]));
    }

    return (VecPairF){sum1, sum2};
}

double fastKaiser(double x) {
    const double M = WINDOW_SIZE/2;
    const double scale = ALPHA / M;

    double x2 = x*x;
    double y = scale * sqrt(M*M - x2);
    return fastBessel0_bakedDiv(y);
}

// W/ kaiser @ 64 window, -130db error, 505ms proc time
// W/out kaiser @ 64 window, -61db error, 497ms proc time
inline VecPairF fastKaiser_simd(VecPairF x) {
    __m256 M2 = _mm256_set1_ps((WINDOW_SIZE / 2) * (WINDOW_SIZE / 2));
    __m256 scale2 = _mm256_set1_ps((float)ALPHA * ALPHA / ((WINDOW_SIZE / 2) * (WINDOW_SIZE / 2)));

    __m256 x2_1 = x.a*x.a;
    __m256 x2_2 = x.b*x.b;
    // we don't have to worry about bounding because of removing the square root here
    // as long as input values are within 1.25 * WINDOW_SIZE, the result is roughly 0
    __m256 y2_1 = scale2 * (M2 - x2_1);
    __m256 y2_2 = scale2 * (M2 - x2_2);
    return fastBessel0_bakedDiv_simd((VecPairF){y2_1, y2_2});
}

// 6/6 pade approximant is essentially just as performant as 5/5 and gives equiv error to LUT
// https://www.wolframalpha.com/input?i=%5B6%2F6%5D+pade+of+sin%28x%29
// operates on a domain of [-pi/2, pi/2], which is significantly better than [-pi, pi]
inline VecPairF padeSin_simd(VecPairF x) {
    __m256i piCount1 = _mm256_cvtps_epi32(x.a * _mm256_set1_ps(1.0/M_PI));
    __m256i piCount2 = _mm256_cvtps_epi32(x.b * _mm256_set1_ps(1.0/M_PI));
    __m256 xNorm1 = _mm256_fmadd_ps(
        _mm256_set1_ps(-M_PI), 
        _mm256_cvtepi32_ps(piCount1), 
        x.a
    );
    __m256 xNorm2 = _mm256_fmadd_ps(
        _mm256_set1_ps(-M_PI), 
        _mm256_cvtepi32_ps(piCount2), 
        x.b
    );
    __m256 x2_1 = xNorm1 * xNorm1;
    __m256 x2_2 = xNorm2 * xNorm2;
    
    __m256i piParity1 = _mm256_slli_epi32(piCount1, 31); // piCount%2 == 0 ? 0x0 : 0x80000000
    __m256i piParity2 = _mm256_slli_epi32(piCount2, 31);
    __m256 xNormCorrected1 = _mm256_castsi256_ps(_mm256_xor_si256(
        _mm256_castps_si256(xNorm1),
        piParity1
    )); // flip sign according to pi parity
    __m256 xNormCorrected2 = _mm256_castsi256_ps(_mm256_xor_si256(
        _mm256_castps_si256(xNorm2),
        piParity2
    ));

    __m256 numer1 = _mm256_fmadd_ps(
        _mm256_set1_ps(0.0029035821005), x2_1,
        _mm256_set1_ps(-0.129956552824)
    );
    numer1 = _mm256_fmadd_ps(numer1, x2_1, _mm256_set1_ps(1.0));
    numer1 *= xNormCorrected1;

    __m256 numer2 = _mm256_fmadd_ps(
        _mm256_set1_ps(0.0029035821005), x2_2,
        _mm256_set1_ps(-0.129956552824)
    );
    numer2 = _mm256_fmadd_ps(numer2, x2_2, _mm256_set1_ps(1.0));
    numer2 *= xNormCorrected2;

    __m256 denom1 = _mm256_fmadd_ps(
        _mm256_set1_ps(0.00000726192876828), x2_1,
        _mm256_set1_ps(0.000688601074264)
    );
    denom1 = _mm256_fmadd_ps(denom1, x2_1, _mm256_set1_ps(0.0367101138426));
    denom1 = _mm256_fmadd_ps(denom1, x2_1, _mm256_set1_ps(1.0));

    __m256 denom2 = _mm256_fmadd_ps(
        _mm256_set1_ps(0.00000726192876828), x2_2,
        _mm256_set1_ps(0.000688601074264)
    );
    denom2 = _mm256_fmadd_ps(denom2, x2_2, _mm256_set1_ps(0.0367101138426));
    denom2 = _mm256_fmadd_ps(denom2, x2_2, _mm256_set1_ps(1.0));

    return (VecPairF){
        numer1 / denom1,
        numer2 / denom2
    };
}