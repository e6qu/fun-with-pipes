#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>

int main(void) {
    int64_t i = 100000000, acc = 0;
    while (i != 0) {
        /* fwp computes the next index before the product and accumulated sum. */
        int64_t next, product, sum;
        if (__builtin_sub_overflow(i, INT64_C(1), &next)) {
            fputs("subtraction overflow\n", stderr);
            return 1;
        }
        if (__builtin_mul_overflow(i, INT64_C(3), &product)) {
            fputs("multiplication overflow\n", stderr);
            return 1;
        }
        if (__builtin_add_overflow(acc, product % 7, &sum)) {
            fputs("addition overflow\n", stderr);
            return 1;
        }
        i = next;
        acc = sum;
    }
    printf("%" PRId64 "\n", acc);
    return 0;
}
