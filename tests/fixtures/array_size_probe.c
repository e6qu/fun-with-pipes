#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef uint64_t V;
typedef struct { uint64_t len; V d[]; } fwp_arr;
#define PTR(p) ((V)(uintptr_t)(p))
static size_t requested;
static void *fwp_alloc(size_t n) {
    if (n > 256) exit(130);
    requested = n;
    /* Oversized requests that wrapped to zero still get a valid header,
       so the omission control never relies on an out-of-bounds write. */
    void *p = malloc(256);
    if (!p) exit(102);
    return p;
}
static void fwp_trap(const char *message) {
    if (strcmp(message, "array too large")) exit(131);
    exit(1);
}
/* ARRAY_CONSTRUCTOR */
int main(void) {
    fwp_arr *a = (fwp_arr *)(uintptr_t)fwp_arr_new(3);
    if (a->len != 3 || requested != sizeof(fwp_arr) + 3 * sizeof(V)) return 132;
    free(a);
    a = (fwp_arr *)(uintptr_t)fwp_arr_new((SIZE_MAX - sizeof(fwp_arr)) / sizeof(V) + 1);
    free(a);
    return 129;
}
