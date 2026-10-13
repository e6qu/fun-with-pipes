#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
/* Reject overflowing/zeroed requests deterministically, without asking the
 * sanitizer or OS to fulfill SIZE_MAX. Observe the real allocation otherwise. */
static void *observe_calloc(size_t count, size_t bytes) {
    if (count != 1) exit(132);
    if (!bytes) exit(131);
    if (bytes == SIZE_MAX) return NULL;
    return calloc(count, bytes);
}
#define calloc observe_calloc
/* WASM_ALLOCATOR */
int main(void) {
    void *empty = fwp_alloc(0);
    if (!empty) return 129;
    free(empty);
    for (size_t n = 1; n < 4096; n += 17) {
        unsigned char *p = fwp_alloc(n);
        if ((uintptr_t)p % _Alignof(max_align_t)) return 130;
        for (size_t i = 0; i < n; i++) if (p[i]) return 133;
        free(p);
    }
    fwp_alloc(SIZE_MAX);
    return 128;
}
