#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
typedef uint64_t V;
typedef struct {uint64_t len; V d[];} fwp_arr;
#define ARR(v) ((fwp_arr *)(uintptr_t)(v))
#define FWP_KCHUNK 256
typedef struct {const double **inputs;} fwp_kernel;
static void *input_owner;
static void counted_free(void *p) {if (p == input_owner) input_owner = NULL; free(p);}
static void fwp_trap(const char *message) {
    if (strcmp(message, "array too large")) exit(127);
    if (input_owner) exit(128);
    exit(1);
}
static void *fwp_k_malloc(size_t bytes) {if (bytes > 256) exit(129); void *p = malloc(bytes ? bytes : 1); if (!p) exit(126); return p;}
static void fwp_kernel_prepare(fwp_kernel *k, V a, V b, V c, size_t n) {
    (void)a;(void)b;(void)c;(void)n;
    k->inputs = input_owner = malloc(sizeof(double *)); if (!input_owner) exit(126);
}
static void fwp_kernel_parallel(const fwp_kernel *k, int reduction, size_t n, size_t blocks, int64_t threads, double *out) {
    (void)k;(void)reduction;(void)blocks;(void)threads;
    if (n > 8) exit(129);
    for (size_t i = 0; i < n; i++) out[i] = 2.5;
}
static V fwp_arr_new(size_t n) {fwp_arr *a = fwp_k_malloc(sizeof(fwp_arr) + n * sizeof(V));a->len = n;return (V)(uintptr_t)a;}
#define free counted_free
/* WORKSPACE */
/* DEVICE_RUN */
#undef free
int main(void) {
    size_t limit = SIZE_MAX / FWP_KCHUNK / sizeof(double);
    if (!fwp_kernel_workspace_fits(0) || !fwp_kernel_workspace_fits(limit) || fwp_kernel_workspace_fits(limit + 1) || fwp_kernel_workspace_fits(SIZE_MAX)) return 133;
    V r = fwp_p_device_run(1, 3, 0, 0, 0);
    double values[] = {2.5, 2.5, 2.5};
    if (ARR(r)->len != 3 || memcmp(ARR(r)->d, values, sizeof values) || input_owner) return 134;
    free(ARR(r));
    r = fwp_p_device_run(1, (V)(int64_t)-1, 0, 0, 0);
    if (ARR(r)->len || input_owner) return 135;
    free(ARR(r));
    fwp_p_device_run(1, UINT64_C(2305843009213693952), 0, 0, 0);
    return 130;
}
