/* fwp runtime: value representation, allocation, application, effects,
 * structural operations driven by type descriptors, and the primitives.
 *
 * This file is embedded in every generated program (one translation unit),
 * so the C compiler can inline and specialize runtime calls.
 *
 * Values are 64-bit words (V):
 *   - integers up to 64 bits: inline (signed values sign-extended)
 *   - I128/U128: pointer to a boxed 128-bit integer
 *   - F32/F64: IEEE bits
 *   - ADT values: small integer tag for nullary constructors (< 4096),
 *     otherwise a pointer to an object {tag, n, fields}
 *   - records/tuples: pointer to an object (unit is 0)
 *   - strings and bytes: pointer to {len, bytes}
 *   - closures: pointer to {fn, n, args} (partial application)
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#ifdef __wasi__
/* setjmp/longjmp are lowered to WebAssembly exception handling
 * (-mllvm -wasm-enable-sjlj); the helpers are in the WASI section below
 * and runtime/wasm/longjmp.S. */
typedef long jmp_buf[4];
int setjmp(jmp_buf) __attribute__((returns_twice));
_Noreturn void longjmp(jmp_buf, int);
#else
#include <setjmp.h>
#endif
#include <math.h>
#include <time.h>
#ifndef __wasi__
#include <pthread.h>
#endif
#include <errno.h>
#include <ctype.h>

typedef uint64_t V;
typedef __int128 i128;
typedef unsigned __int128 u128;


/* ------------------------------------------------------------------ alloc */

static char *fwp_heap_cur = 0, *fwp_heap_end = 0;

static void *fwp_alloc(size_t n) {
    n = (n + 15) & ~(size_t)15;
    if ((size_t)(fwp_heap_end - fwp_heap_cur) < n) {
        size_t chunk = n > (1 << 20) ? n : (1 << 20);
        fwp_heap_cur = (char *)malloc(chunk);
        if (!fwp_heap_cur) {
            fprintf(stderr, "fwp: out of memory\n");
            exit(102);
        }
        fwp_heap_end = fwp_heap_cur + chunk;
    }
    void *p = fwp_heap_cur;
    fwp_heap_cur += n;
    return p;
}

/* ---------------------------------------------------------------- objects */

typedef struct { uint32_t tag; uint32_t n; V f[]; } fwp_obj;
typedef struct { uint64_t len; char d[]; } fwp_str;
typedef struct { uint32_t fn; uint32_t n; V a[]; } fwp_clo;
typedef struct { uint64_t len; V d[]; } fwp_arr;
/* map: len entries, keys and values interleaved; sets use values of 0 */
typedef struct { uint64_t len; V d[]; } fwp_map;
typedef struct { FILE *f; const char *path; } fwp_file;

#define OBJ(v) ((fwp_obj *)(uintptr_t)(v))
#define STR(v) ((fwp_str *)(uintptr_t)(v))
#define CLO(v) ((fwp_clo *)(uintptr_t)(v))
#define ARR(v) ((fwp_arr *)(uintptr_t)(v))
#define MAP(v) ((fwp_map *)(uintptr_t)(v))
#define PTR(p) ((V)(uintptr_t)(p))

static inline uint32_t fwp_tag(V v) { return v < 4096 ? (uint32_t)v : OBJ(v)->tag; }

static V fwp_data(uint32_t tag, uint32_t n, const V *f) {
    if (n == 0) return tag;
    fwp_obj *o = (fwp_obj *)fwp_alloc(sizeof(fwp_obj) + n * sizeof(V));
    o->tag = tag;
    o->n = n;
    memcpy(o->f, f, n * sizeof(V));
    return PTR(o);
}

static V fwp_record(uint32_t n, const V *f) {
    if (n == 0) return 0;
    return fwp_data(0, n, f);
}

static V fwp_tuple2(V a, V b) { V f[2] = {a, b}; return fwp_record(2, f); }

static V fwp_str_new(const char *s, size_t len) {
    fwp_str *r = (fwp_str *)fwp_alloc(sizeof(fwp_str) + len + 1);
    r->len = len;
    memcpy(r->d, s, len);
    r->d[len] = 0;
    return PTR(r);
}

static V fwp_cstr(const char *s) { return fwp_str_new(s, strlen(s)); }

static inline V fwp_some(V x) { return fwp_data(1, 1, &x); }
#define FWP_NONE ((V)0)
#define FWP_TRUE ((V)1)
#define FWP_FALSE ((V)0)
#define FWP_UNIT ((V)0)

/* list: Nil = 0, Cons = 1 */
static V fwp_cons(V x, V xs) { V f[2] = {x, xs}; return fwp_data(1, 2, f); }

static size_t fwp_list_len(V xs) {
    size_t n = 0;
    while (xs != 0) { n++; xs = OBJ(xs)->f[1]; }
    return n;
}

/* list -> temporary array of items */
static V *fwp_list_items(V xs, size_t *n) {
    *n = fwp_list_len(xs);
    V *a = (V *)fwp_alloc((*n + 1) * sizeof(V));
    for (size_t i = 0; i < *n; i++) { a[i] = OBJ(xs)->f[0]; xs = OBJ(xs)->f[1]; }
    return a;
}

static V fwp_list_from(const V *a, size_t n) {
    V r = 0;
    for (size_t i = n; i > 0; i--) r = fwp_cons(a[i - 1], r);
    return r;
}

static V fwp_arr_new(size_t n) {
    fwp_arr *a = (fwp_arr *)fwp_alloc(sizeof(fwp_arr) + n * sizeof(V));
    a->len = n;
    return PTR(a);
}

/* ---------------------------------------------------------------- numbers */

static inline V fwp_from_f64(double x) { V v; memcpy(&v, &x, 8); return v; }
static inline double fwp_f64(V v) { double x; memcpy(&x, &v, 8); return x; }
static inline V fwp_from_f32(float x) { uint32_t b; memcpy(&b, &x, 4); return (V)b; }
static inline float fwp_f32(V v) { uint32_t b = (uint32_t)v; float x; memcpy(&x, &b, 4); return x; }

static V fwp_box_i128(i128 x) {
    i128 *p = (i128 *)fwp_alloc(sizeof(i128));
    *p = x;
    return PTR(p);
}
static inline i128 fwp_i128(V v) { return *(i128 *)(uintptr_t)v; }
static V fwp_box_u128(u128 x) {
    u128 *p = (u128 *)fwp_alloc(sizeof(u128));
    *p = x;
    return PTR(p);
}
static inline u128 fwp_u128(V v) { return *(u128 *)(uintptr_t)v; }

/* ------------------------------------------------------------- descriptors */

enum {
    K_I8, K_I16, K_I32, K_I64, K_I128, K_U8, K_U16, K_U32, K_U64, K_U128,
    K_F32, K_F64, K_STR, K_BYTES, K_ADT, K_LIST, K_RECORD, K_ARRAY, K_MAP,
    K_SET, K_TINT, K_TRIT, K_FUN, K_FILE, K_OPAQUE, K_NATIVE
};

typedef struct fwp_desc fwp_desc;
struct fwp_desc {
    int kind;
    const char *name;       /* numeric type name, ADT name, nominal record name */
    int n;                  /* record fields or ADT variants */
    const char *const *names;          /* field or constructor names */
    const fwp_desc *const *fields;     /* record field descriptors */
    const int *arity;                  /* ADT: fields per variant */
    const fwp_desc *const *const *vfields; /* ADT: per-variant field descriptors */
    const fwp_desc *elem;   /* list/array/set element, map key */
    const fwp_desc *elem2;  /* map value */
    int width;              /* TInt width; 1 if record is a tuple */
};

static int fwp_is_signed_kind(int k) { return k == K_I8 || k == K_I16 || k == K_I32 || k == K_I64; }

/* ---------------------------------------------------------------- control */

typedef struct fwp_handler {
    jmp_buf jb;
    struct fwp_handler *prev;
    V value;
    const fwp_desc *desc;
    size_t state_depth;
} fwp_handler;

static fwp_handler *fwp_handlers = 0;
static V *fwp_state = 0;
static size_t fwp_state_len = 0, fwp_state_cap = 0;

static FILE *fwp_prog_out; /* where `print` writes (stderr in binary exec mode) */

static void fwp_flush(void) {
    if (fwp_prog_out) fflush(fwp_prog_out);
    fflush(stdout);
}

static void fwp_trap(const char *msg) {
    fwp_flush();
    fprintf(stderr, "fwp: trap: %s\n", msg);
    exit(101);
}

static void fwp_trap_overflow(const char *ty) {
    char buf[96];
    snprintf(buf, sizeof buf, "arithmetic overflow in %s", ty);
    fwp_trap(buf);
}

static void fwp_display_top(V v, const fwp_desc *d, FILE *out);

static void fwp_fail(V value, const fwp_desc *d) {
    if (!fwp_handlers) {
        fwp_flush();
        fprintf(stderr, "error: ");
        fwp_display_top(value, d, stderr);
        fprintf(stderr, "\n");
        exit(1);
    }
    fwp_handlers->value = value;
    fwp_handlers->desc = d;
    longjmp(fwp_handlers->jb, 1);
}

static void fwp_state_push(V s) {
    if (fwp_state_len == fwp_state_cap) {
        fwp_state_cap = fwp_state_cap ? fwp_state_cap * 2 : 16;
        fwp_state = (V *)realloc(fwp_state, fwp_state_cap * sizeof(V));
    }
    fwp_state[fwp_state_len++] = s;
}

/* ------------------------------------------------------------- application */

typedef struct { uint32_t arity; V (*entry)(V *); const char *name; } fwp_fninfo;
static const fwp_fninfo *fwp_fns; /* set by the generated main */

static V fwp_apply(V f, uint32_t n, V *args) {
    for (;;) {
        fwp_clo *c = CLO(f);
        uint32_t ar = fwp_fns[c->fn].arity;
        uint32_t have = c->n;
        if (have + n < ar) {
            fwp_clo *r = (fwp_clo *)fwp_alloc(sizeof(fwp_clo) + (have + n) * sizeof(V));
            r->fn = c->fn;
            r->n = have + n;
            memcpy(r->a, c->a, have * sizeof(V));
            memcpy(r->a + have, args, n * sizeof(V));
            return PTR(r);
        }
        uint32_t need = ar - have;
        V all[ar ? ar : 1];
        memcpy(all, c->a, have * sizeof(V));
        memcpy(all + have, args, need * sizeof(V));
        V r = fwp_fns[c->fn].entry(all);
        if (n == need) return r;
        f = r;
        args += need;
        n -= need;
    }
}

static inline V fwp_apply1(V f, V x) { return fwp_apply(f, 1, &x); }
static inline V fwp_apply2(V f, V x, V y) { V a[2] = {x, y}; return fwp_apply(f, 2, a); }

static V fwp_pap(uint32_t fn, uint32_t n, const V *args) {
    fwp_clo *r = (fwp_clo *)fwp_alloc(sizeof(fwp_clo) + n * sizeof(V));
    r->fn = fn;
    r->n = n;
    memcpy(r->a, args, n * sizeof(V));
    return PTR(r);
}
