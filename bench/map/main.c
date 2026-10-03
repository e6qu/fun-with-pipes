#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
/* a sorted array of pairs, searched by bisection (as fwp's maps are) */
typedef struct { int64_t k, v; } pair;
static int64_t key(int64_t i) { return i * 7919 % 1000003; }
static int cmp(const void *a, const void *b) {
    int64_t x = ((const pair *)a)->k, y = ((const pair *)b)->k;
    return x < y ? -1 : x > y;
}
int main(void) {
    int64_t n = 500000;
    pair *t = malloc(n * sizeof *t);
    for (int64_t i = 0; i < n; i++) { t[i].k = key(i); t[i].v = i; }
    qsort(t, n, sizeof *t, cmp);
    printf("%lld\n", (long long)n);
    int64_t sum = 0;
    for (int64_t i = 0; i < 2000000; i++) {
        int64_t k = key(i), lo = 0, hi = n;
        while (lo < hi) {
            int64_t mid = (lo + hi) / 2;
            if (t[mid].k < k) lo = mid + 1; else hi = mid;
        }
        if (lo < n && t[lo].k == k) sum += t[lo].v;
    }
    printf("%lld\n", (long long)sum);
    free(t);
    return 0;
}
