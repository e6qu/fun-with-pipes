#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/* The same lists, as arrays: built, mapped, filtered and summed. */
int main(void) {
    int64_t total = 0, n = 1000000;
    int64_t *a = malloc(n * sizeof *a);
    if (!a) return 1;
    int64_t *b = malloc(n * sizeof *b);
    if (!b) { free(a); return 1; }
    int status = 1;
    for (int r = 0; r < 20; r++) {
        for (int64_t i = 0; i < n; i++) {
            if (__builtin_mul_overflow(i, INT64_C(3), &a[i])) goto cleanup;
        }
        int64_t k = 0;
        for (int64_t i = 0; i < n; i++) if (a[i] % 2 == 0) b[k++] = a[i];
        int64_t sum = 0;
        for (int64_t i = 0; i < k; i++) {
            if (__builtin_add_overflow(sum, b[i], &sum)) goto cleanup;
        }
        if (__builtin_add_overflow(total, sum, &total)) goto cleanup;
    }
    printf("%" PRId64 "\n", total);
    status = 0;
cleanup:
    free(a);
    free(b);
    return status;
}
