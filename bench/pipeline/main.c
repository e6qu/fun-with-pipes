#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
/* the same lists, as arrays: built, mapped, filtered and summed */
int main(void) {
    int64_t total = 0, n = 1000000;
    int64_t *a = malloc(n * sizeof *a), *b = malloc(n * sizeof *b);
    for (int r = 0; r < 20; r++) {
        for (int64_t i = 0; i < n; i++) a[i] = i * 3;
        int64_t k = 0;
        for (int64_t i = 0; i < n; i++) if (a[i] % 2 == 0) b[k++] = a[i];
        int64_t s = 0;
        for (int64_t i = 0; i < k; i++) s += b[i];
        total += s;
    }
    printf("%lld\n", (long long)total);
    free(a);
    free(b);
    return 0;
}
