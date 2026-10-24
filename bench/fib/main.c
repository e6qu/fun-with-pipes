#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

static int64_t fib(int64_t n) {
    if (n == 0 || n == 1) return n;
    int64_t first, second, sum;
    if (__builtin_sub_overflow(n, INT64_C(1), &first)) exit(1);
    int64_t left = fib(first);
    if (__builtin_sub_overflow(n, INT64_C(2), &second)) exit(1);
    int64_t right = fib(second);
    if (__builtin_add_overflow(left, right, &sum)) exit(1);
    return sum;
}

int main(void) {
    printf("%" PRId64 "\n", fib(35));
    return 0;
}
