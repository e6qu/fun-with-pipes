/* KIND, COUNT, UPDATES, REPEATS and EXPECTED are supplied by the runner.
 * KIND: 0 checked integer loop, 1 materialized map/fold, 2 coordinate updates.
 * Coordinate updates reuse two buffers; this differs from immutable fwp arrays. */
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

static uint64_t clock_ns(void) {
    struct timespec value;
    if (clock_gettime(CLOCK_MONOTONIC, &value)) exit(1);
    return (uint64_t)value.tv_sec * UINT64_C(1000000000) + (uint64_t)value.tv_nsec;
}
static uint64_t bits(double value) {
    uint64_t result;
    memcpy(&result, &value, sizeof result);
    return result;
}
#if KIND == 0
static int64_t measure(int64_t i) {
    int64_t total = 0;
    while (i != 0) {
        int64_t next, product, sum;
        if (__builtin_sub_overflow(i, INT64_C(1), &next) ||
            __builtin_mul_overflow(i, INT64_C(3), &product) ||
            __builtin_add_overflow(total, product % 7, &sum)) exit(2);
        i = next; total = sum;
    }
    return total;
}
#elif KIND == 1
static double measure(double *input, size_t count) {
    double *mapped = malloc(count * sizeof *mapped);
    if (count && !mapped) exit(2);
    for (size_t i = 0; i < count; i++) mapped[i] = input[i] * 3.0 + 1.0;
    free(input);
    double result = -0.0;
    for (size_t i = 0; i < count; i++) result = mapped[i] + result;
    free(mapped);
    return result;
}
#elif KIND == 2
static double *measure(double *input, size_t count) {
    if (UPDATES == 0) return input;
    double *next = malloc(count * sizeof *next);
    if (!next) exit(2);
    for (size_t step = 0; step < UPDATES; step++) {
        for (size_t i = 0; i < count; i++) {
            double previous = i == 0 ? 0.0 : 200.0 * (input[i] - input[i-1] * input[i-1]);
            double following = i+1 == count ? 0.0 :
                -400.0 * input[i] * (input[i+1] - input[i] * input[i]) - 2.0 * (1.0 - input[i]);
            next[i] = input[i] - 0.001 * (previous + following);
        }
        double *old = input; input = next; next = old;
    }
    free(next);
    return input;
}
#else
#error Unknown workload
#endif

int main(void) {
    const uint64_t expected[] = {EXPECTED};
    uint64_t setup = 0, work = 0, release = 0, checksum = 0;
    uint64_t total_start = clock_ns();
    for (size_t round = 0; round < REPEATS; round++) {
        uint64_t start = clock_ns();
#if KIND == 0
        int64_t input = COUNT;
        __asm__ volatile("" : "+r"(input) :: "memory");
#else
        size_t count = COUNT;
        double *input = malloc(count * sizeof *input);
        if (count && !input) return 2;
        for (size_t i = 0; i < count; i++) input[i] = KIND == 1 ? 2.0 : (i % 2 ? 1.0 : -1.2);
        __asm__ volatile("" : "+r"(input), "+r"(count) :: "memory");
#endif
        setup += clock_ns() - start;
        start = clock_ns();
#if KIND == 0
        int64_t result = measure(input);
        __asm__ volatile("" : "+r"(result) :: "memory");
#elif KIND == 1
        uint64_t result = bits(measure(input, count));
        __asm__ volatile("" : "+r"(result) :: "memory");
#else
        double *result = measure(input, count);
        __asm__ volatile("" : "+r"(result) :: "memory");
#endif
        work += clock_ns() - start;
#if KIND == 2
        for (size_t i = 0; i < COUNT; i++) {
            uint64_t value = bits(result[i]);
            if (value != expected[i]) return 3;
            checksum ^= value + round;
        }
#else
        uint64_t value = (uint64_t)result;
        if (value != expected[0]) return 3;
        checksum ^= value + round;
#endif
        start = clock_ns();
#if KIND == 2
        free(result);
#endif
        release += clock_ns() - start;
    }
    uint64_t total = clock_ns() - total_start;
    printf("{\"constructionNs\":%" PRIu64 ",\"computationNs\":%" PRIu64 ",\"releaseNs\":%" PRIu64 ",\"loopNs\":%" PRIu64 ",\"checksum\":%" PRIu64 "}\n",
           setup, work, release, total, checksum);
    return 0;
}
