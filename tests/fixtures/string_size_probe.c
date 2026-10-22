#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef uint64_t V;
typedef struct { uint64_t len; char d[]; } fwp_str;
typedef struct { char *d; size_t len, cap; } fwp_buf;
#define STR(v) ((fwp_str *)(uintptr_t)(v))
#define PTR(v) ((V)(uintptr_t)(v))
#define FWP_KEEP_ALIVE(v) ((void)(v))
static _Noreturn void fwp_trap(const char *message) {
    if (strcmp(message, "string too large")) exit(128);
    exit(125);
}
static void *fwp_alloc_leaf(size_t size) { (void)size; exit(126); }
static size_t fwp_count_arg(V n) {
    uint64_t count = (int64_t)n < 0 ? 0 : n;
    return count > SIZE_MAX ? SIZE_MAX : (size_t)count;
}
static void buf_put(fwp_buf *b, const char *s, size_t n) {
    (void)b; (void)s; (void)n; exit(127);
}
static V buf_to_str(fwp_buf *b) { (void)b; exit(128); }
/* STRING_CONSTRUCTOR */
/* CONCAT */
/* REPEAT */
int main(int argc, char **argv) {
    if (argc != 2) return 128;
    /* Use the real header type: casting a different struct violates C aliasing.
       Every path exits before reading payload bytes, so no payload is needed. */
    fwp_str a={0},b={0};
    switch (atoi(argv[1])) {
    case 0: fwp_str_new("",SIZE_MAX); break;
    case 1: a.len=SIZE_MAX; b.len=1; fwp_p_concat(PTR(&b),PTR(&a)); break;
    case 2: a.len=SIZE_MAX-sizeof(fwp_str)-1; b.len=1; fwp_p_concat(PTR(&b),PTR(&a)); break;
    case 3: fwp_str_new("",0); break;
    case 4: a.len=1; b.len=2; fwp_p_concat(PTR(&b),PTR(&a)); break;
    case 5: fwp_p_str_repeat(INT64_MAX,PTR(&a)); break;
    default: return 128;
    }
    return 128;
}
