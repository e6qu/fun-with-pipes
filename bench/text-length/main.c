#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

static inline int64_t characters(int64_t value) {
    uint64_t magnitude = value < 0 ? (uint64_t)0 - (uint64_t)value : (uint64_t)value;
    int64_t count = 1;
    if (magnitude >= UINT64_C(10000000000000000)) { magnitude /= UINT64_C(10000000000000000); count += 16; }
    if (magnitude >= UINT64_C(100000000)) { magnitude /= UINT64_C(100000000); count += 8; }
    if (magnitude >= UINT64_C(10000)) { magnitude /= UINT64_C(10000); count += 4; }
    if (magnitude >= UINT64_C(100)) { magnitude /= UINT64_C(100); count += 2; }
    if (magnitude >= UINT64_C(10)) count++;
    return count + (value < 0);
}

static int64_t add(int64_t left, int64_t right) {
    int64_t result;
    if (__builtin_add_overflow(left, right, &result)) abort();
    return result;
}

int main(void) {
    int64_t total = 0;
    for (int64_t i = 0; i < 2000000; i++) {
        int64_t product;
        if (__builtin_mul_overflow(i, (int64_t)3, &product)) abort();
        total = add(total, add(1, add(characters(i), characters(product))));
    }
    printf("%" PRId64 "\n", total);
    return 0;
}
