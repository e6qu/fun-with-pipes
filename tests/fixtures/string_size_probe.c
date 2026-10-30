#include <stdint.h>
#include <stddef.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

typedef uint64_t V;
typedef struct { uint64_t len; char d[]; } fwp_str;
#define STR(v) ((fwp_str *)(uintptr_t)(v))
#define PTR(v) ((V)(uintptr_t)(v))
static _Noreturn void fwp_trap(const char *message) {
    if (strcmp(message, "string too large")) exit(128);
    exit(125);
}
static void *fwp_alloc_leaf(size_t size) { (void)size; exit(126); }
/* These synthetic size inputs do not have managed ownership metadata. */
static int fwp_rc_unique(V value) { (void)value; return 0; }
static size_t fwp_count_arg(V n) {
    uint64_t count = (int64_t)n < 0 ? 0 : n;
    return count > SIZE_MAX ? SIZE_MAX : (size_t)count;
}
/* STRING_CONSTRUCTOR */
/* CONCAT */
static size_t replace_forced_count;
/* FIND */
/* REPLACE */
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
    case 6: a.len=SIZE_MAX-1; fwp_p_str_repeat(1,PTR(&a)); break;
    case 7: a.len=2; fwp_p_str_repeat(INT64_MAX,PTR(&a)); break;
    case 8: a.len=3; fwp_p_str_repeat(INT64_MAX,PTR(&a)); break;
    case 9:
    case 10:
    case 11: {
        /* Real small objects keep all pointer arithmetic within allocated storage.
           The harness changes only the match count, and every case exits before copying. */
        fwp_str *source=malloc(sizeof(fwp_str)+2);
        fwp_str *pattern=malloc(sizeof(fwp_str)+2);
        fwp_str *replacement=malloc(sizeof(fwp_str)+3);
        if(!source || !pattern || !replacement)return 128;
        source->len=pattern->len=1; replacement->len=2;
        memcpy(source->d,"x",2); memcpy(pattern->d,"x",2); memcpy(replacement->d,"yy",3);
        replace_forced_count=atoi(argv[1])==9?SIZE_MAX:atoi(argv[1])==10?SIZE_MAX-sizeof(fwp_str)-1:0;
        fwp_p_replace(PTR(pattern),PTR(replacement),PTR(source));
        break;
    }
    default: return 128;
    }
    return 128;
}
