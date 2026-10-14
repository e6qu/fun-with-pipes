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

#ifdef _WIN32
/* Windows 10 is the generated runtime's minimum SDK/API contract. */
#if defined(_WIN32_WINNT) && _WIN32_WINNT < 0x0a00
#error "fwp requires the Windows 10 API contract"
#endif
#ifndef _WIN32_WINNT
#define _WIN32_WINNT 0x0a00
#endif
#endif
#include <stdint.h>
#include <stddef.h>
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
#if !defined(__wasi__) && !defined(_WIN32)
#include <pthread.h>
#endif
#include <errno.h>
#include <stdarg.h>
#include <ctype.h>
#ifdef _WIN32
#ifndef WIN32_LEAN_AND_MEAN
#define WIN32_LEAN_AND_MEAN
#endif
#include <winsock2.h>
#include <ws2tcpip.h>
#include <windows.h>
#endif

typedef uint64_t V;
typedef __int128 i128;
typedef unsigned __int128 u128;

/* A conservative collector needs the owner alive while values preloaded
 * from it cross allocations. An empty compiler fence extends that lifetime
 * without adding machine instructions. WebAssembly has no stack tracing. */
#if !defined(__wasi__) && !defined(__wasm__)
#define FWP_KEEP_ALIVE(p) __asm__ volatile("" : : "r"(p) : "memory")
#else
#define FWP_KEEP_ALIVE(p) ((void)(p))
#endif


/* ------------------------------------------------------------------ alloc */

/* runtime/fwp_rt_gc.c: the collected heap */
static void *fwp_alloc(size_t n);      /* zeroed; scanned for values */
static void *fwp_alloc_leaf(size_t n); /* zeroed; holds no values */
/* whether all memory was mapped at startup (runtime/fwp_rt_static.c) */
#ifdef FWP_STATIC_MEMORY
static const int fwp_static_memory = 1;
#else
static const int fwp_static_memory = 0;
#endif
/* scanned for values; the caller writes all of its first n bytes before
 * anything else is allocated (only the slot's slack is zeroed) */
static void *fwp_alloc_init(size_t n);
/* runtime memory that may hold values (explicitly freed, or collected) */
static void *fwp_mem_alloc(size_t n);
static void *fwp_mem_realloc(void *p, size_t old, size_t n);
static void fwp_mem_free(void *p);
static void fwp_gc_start(void *top);
static void fwp_trap(const char *msg);

/* runtime/fwp_rt_task.c: preemption. A safe point (the entry of a
 * function of a program that uses tasks, an iteration of `loop`) spends
 * one unit of the running task's slice. */
static int32_t fwp_budget = 0;
static void fwp_preempt(void);
#ifdef FWP_ASYNCIFY
/* WebAssembly with Asyncify: a task's C stack (linear memory) is checked
 * here, since the engine's stack, on which its calls run, is much larger */
static uintptr_t fwp_stack_low = 0;
#define FWP_TICK()                                                                              \
    do {                                                                                        \
        volatile char fwp_sp_;                                                                  \
        if (__builtin_expect((uintptr_t)&fwp_sp_ < fwp_stack_low, 0)) fwp_trap("stack overflow"); \
        if (__builtin_expect(--fwp_budget <= 0, 0)) fwp_preempt();                              \
    } while (0)
#else
#define FWP_TICK() do { if (__builtin_expect(--fwp_budget <= 0, 0)) fwp_preempt(); } while (0)
#endif

/* ---------------------------------------------------------------- objects */

typedef struct { uint32_t tag; uint32_t n; V f[]; } fwp_obj;
typedef struct { uint64_t len; char d[]; } fwp_str;
typedef struct { uint32_t fn; uint32_t n; V a[]; } fwp_clo;
typedef struct { uint64_t len; V d[]; } fwp_arr;
/* map: len entries, keys and values interleaved; sets use values of 0 */
typedef struct { uint64_t len; V d[]; } fwp_map;
typedef struct { FILE *f; uint64_t refs; char path[]; } fwp_file;

#define OBJ(v) ((fwp_obj *)(uintptr_t)(v))
#define STR(v) ((fwp_str *)(uintptr_t)(v))
#define CLO(v) ((fwp_clo *)(uintptr_t)(v))
#define ARR(v) ((fwp_arr *)(uintptr_t)(v))
#define MAP(v) ((fwp_map *)(uintptr_t)(v))
#define PTR(p) ((V)(uintptr_t)(p))

static inline uint32_t fwp_tag(V v) { return v < 4096 ? (uint32_t)v : OBJ(v)->tag; }

static V fwp_data(uint32_t tag, uint32_t n, const V *f) {
    if (n == 0) return tag;
    fwp_obj *o = (fwp_obj *)fwp_alloc_init(sizeof(fwp_obj) + n * sizeof(V));
    o->tag = tag;
    o->n = n;
    for (uint32_t i = 0; i < n; i++) o->f[i] = f[i];
    /* Inlining may preload fields before allocation: retain their owner. */
    FWP_KEEP_ALIVE(f);
    return PTR(o);
}

static V fwp_record(uint32_t n, const V *f) {
    if (n == 0) return 0;
    return fwp_data(0, n, f);
}

static V fwp_tuple2(V a, V b) { V f[2] = {a, b}; return fwp_record(2, f); }

static V fwp_str_new(const char *s, size_t len) {
    fwp_str *r = (fwp_str *)fwp_alloc_leaf(sizeof(fwp_str) + len + 1);
    r->len = len;
    memcpy(r->d, s, len);
    r->d[len] = 0;
    /* A source slice can be the only remaining root of its allocation. */
    FWP_KEEP_ALIVE(s);
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
    V owner = xs;
    *n = fwp_list_len(xs);
    V *a = (V *)fwp_alloc((*n + 1) * sizeof(V));
    for (size_t i = 0; i < *n; i++) { a[i] = OBJ(xs)->f[0]; xs = OBJ(xs)->f[1]; }
    FWP_KEEP_ALIVE(owner);
    return a;
}

static V fwp_list_from(const V *a, size_t n) {
    V r = 0;
    for (size_t i = n; i > 0; i--) r = fwp_cons(a[i - 1], r);
    /* Clang can preload the elements of an inlined, short buffer and
     * discard its only pointer before the allocating constructors run.
     * Keep the owning buffer reachable until every cell has been built. */
    FWP_KEEP_ALIVE(a);
    return r;
}

static V fwp_arr_new(size_t n) {
    if (n > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap("array too large");
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
    i128 *p = (i128 *)fwp_alloc_leaf(sizeof(i128));
    *p = x;
    return PTR(p);
}
static inline i128 fwp_i128(V v) { return *(i128 *)(uintptr_t)v; }
static V fwp_box_u128(u128 x) {
    u128 *p = (u128 *)fwp_alloc_leaf(sizeof(u128));
    *p = x;
    return PTR(p);
}
static inline u128 fwp_u128(V v) { return *(u128 *)(uintptr_t)v; }

#ifdef FWP_EXACT_FLOAT
#ifndef FWP_BINARY128_DEFINED
#define FWP_BINARY128_DEFINED
struct fwp_binary128 { uint64_t low, high; };
#endif
static V fwp_box_f128(float128_t x) {
    float128_t *p = (float128_t *)fwp_alloc_leaf(sizeof x);
    *p = x; return PTR(p);
}
static inline float128_t fwp_f128(V v) { float128_t x; memcpy(&x, (void *)(uintptr_t)v, sizeof x); return x; }
static struct fwp_binary128 fwp_to_c_quad(V v) { float128_t x=fwp_f128(v); return (struct fwp_binary128){x.v[0],x.v[1]}; }
static V fwp_from_c_quad(struct fwp_binary128 x) { return fwp_box_f128((float128_t){{x.low,x.high}}); }
#endif

/* ------------------------------------------------------------- descriptors */

enum {
    K_I8, K_I16, K_I32, K_I64, K_I128, K_U8, K_U16, K_U32, K_U64, K_U128,
    K_F32, K_F64, K_STR, K_BYTES, K_ADT, K_LIST, K_RECORD, K_ARRAY, K_MAP,
    K_SET, K_TINT, K_TRIT, K_FUN, K_FILE, K_OPAQUE, K_NATIVE, K_F16, K_BF16, K_F128
};

static int fwp_float_kind(int k) { return k == K_F16 || k == K_BF16 || k == K_F32 || k == K_F64 || k == K_F128; }
#ifdef FWP_EXACT_FLOAT
static float128_t fwp_float_quad(int k, V v) {
    switch (k) {
    case K_F16: return f16_to_f128((float16_t){(uint16_t)v});
    case K_BF16: return fwp_bf16_to_f128((uint16_t)v);
    case K_F32: return f32_to_f128((float32_t){(uint32_t)v});
    case K_F64: return f64_to_f128((float64_t){v});
    case K_F128: return fwp_f128(v);
    default: fwp_trap("invalid float kind"); return (float128_t){{0, 0}};
    }
}
static V fwp_quad_float(int k, float128_t x) {
    switch (k) {
    case K_F16: return f128_to_f16(x).v;
    case K_BF16: return fwp_f128_to_bf16(x);
    case K_F32: return f128_to_f32(x).v;
    case K_F64: return f128_to_f64(x).v;
    case K_F128: return fwp_box_f128(x);
    default: fwp_trap("invalid float kind"); return 0;
    }
}
static int fwp_exact_format(int k) { return k == K_F16 ? 16 : k == K_BF16 ? 17 : 128; }
static int fwp_parse_exact(const char *s, int k, V *out) {
    uint64_t low, high;
    int status = fwp_decimal_parse(s, fwp_exact_format(k), &low, &high);
    if (status < 0) fwp_trap("out of memory");
    if (!status) return 0;
    *out = k == K_F128 ? fwp_box_f128((float128_t){{low, high}}) : low;
    return 1;
}
#endif

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
    int width;              /* TInt width; 1 if record is a tuple; typed JSON
                               flags (Bool, Option, Json, Duration) */
    const int *order;       /* nominal record: fields in declaration order */
    const char *const *jnames; /* record: JSON names of the fields, if renamed */
    void (*dup)(V), (*drop)(V); /* typed reconstruction ownership */
};

/* Array descriptors stay outside the payload header. Views retain only
 * pointer-free numeric backing stores; pointer-bearing slices stay copies. */
#define FWP_ARRAY_VIEW_FLAG (UINT64_C(1) << 63)
typedef struct { uint64_t len; V owner; const unsigned char *data; } fwp_array_view;
static inline uint64_t fwp_array_header(V a) {
    uint64_t header; memcpy(&header, (const void *)(uintptr_t)a, sizeof header); return header;
}
static inline size_t fwp_array_len(V a) { return (size_t)(fwp_array_header(a) & ~FWP_ARRAY_VIEW_FLAG); }
static inline int fwp_array_is_view(V a) { return (fwp_array_header(a) & FWP_ARRAY_VIEW_FLAG) != 0; }
static inline const unsigned char *fwp_array_data(V a) {
    if (fwp_array_is_view(a)) {
        const unsigned char *data;
        memcpy(&data, (const unsigned char *)(uintptr_t)a + offsetof(fwp_array_view, data), sizeof data);
        return data;
    }
    return (const unsigned char *)(uintptr_t)a + sizeof(fwp_arr);
}
static inline V fwp_array_owner(V a) {
    if (!fwp_array_is_view(a)) return a;
    V owner; memcpy(&owner, (const unsigned char *)(uintptr_t)a + offsetof(fwp_array_view, owner), sizeof owner); return owner;
}
static inline void fwp_array_set_len(V a, size_t n) {
    if (fwp_array_is_view(a)) fwp_trap("internal: mutating an array view");
    uint64_t len = n; memcpy((void *)(uintptr_t)a, &len, sizeof len);
}
static inline int fwp_array_numeric(const fwp_desc *elem) {
    if (!elem) return 0;
    switch (elem->kind) {
    case K_I8: case K_I16: case K_I32: case K_I64:
    case K_U8: case K_U16: case K_U32: case K_U64:
    case K_F16: case K_BF16: case K_F32: case K_F64: case K_F128: return 1;
    default: return 0;
    }
}
static inline size_t fwp_array_stride(const fwp_desc *elem) {
    /* Quad values cannot fit in a V even when narrow packing is disabled. */
    if (elem && elem->kind == K_F128) return 16;
#if FWP_PACKED_ARRAYS
    if (elem) switch (elem->kind) {
    case K_I8: case K_U8: return 1;
    case K_I16: case K_U16: case K_F16: case K_BF16: return 2;
    case K_I32: case K_U32: case K_F32: return 4;
    default: break;
    }
#else
    (void)elem;
#endif
    return sizeof(V);
}
static inline int fwp_array_should_view(V a, size_t count, const fwp_desc *elem) {
    if (!count || !fwp_array_numeric(elem)) return 0;
    size_t stride = fwp_array_stride(elem), backing = fwp_array_len(fwp_array_owner(a));
    /* Copy tiny slices and slices retaining more than four times their payload.
     * Division keeps this decision independent of byte-count overflow. */
    return count > sizeof(fwp_array_view) / stride
        && count >= backing / 4 + (backing % 4 != 0);
}
static inline V fwp_array_load(V a, size_t i, const fwp_desc *elem) {
    size_t stride = fwp_array_stride(elem);
    const unsigned char *p = fwp_array_data(a) + i * stride;
    /* This is a borrowed view, valid only while the array owner stays alive.
     * Escaping values must copy the bits into their own scalar box. */
    if (stride == 16) return PTR(p);
    if (stride == sizeof(V)) { V word; memcpy(&word, p, sizeof word); return word; }
    if (stride == 1) {
        uint8_t word; memcpy(&word, p, sizeof word);
        return elem->kind == K_I8 ? (V)(int64_t)(int8_t)word : (V)word;
    }
    if (stride == 2) {
        uint16_t word; memcpy(&word, p, sizeof word);
        return elem->kind == K_I16 ? (V)(int64_t)(int16_t)word : (V)word;
    }
    uint32_t word; memcpy(&word, p, sizeof word);
    return elem->kind == K_I32 ? (V)(int64_t)(int32_t)word : (V)word;
}
static inline void fwp_array_store(V a, size_t i, V value, const fwp_desc *elem) {
    if (fwp_array_is_view(a)) fwp_trap("internal: mutating an array view");
    size_t stride = fwp_array_stride(elem);
    unsigned char *p = (unsigned char *)(uintptr_t)a + sizeof(fwp_arr) + i * stride;
    if (stride == 16) { memmove(p, (const void *)(uintptr_t)value, 16); return; }
    if (stride == sizeof(V)) { memcpy(p, &value, sizeof value); return; }
    if (stride == 1) { uint8_t word = (uint8_t)value; memcpy(p, &word, sizeof word); return; }
    if (stride == 2) { uint16_t word = (uint16_t)value; memcpy(p, &word, sizeof word); return; }
    uint32_t word = (uint32_t)value; memcpy(p, &word, sizeof word);
}
static V fwp_array_new_packed(size_t n, const fwp_desc *elem) {
    /* Preserve the established count/trap boundary in every layout mode. */
    if (n > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap("array too large");
    if (fwp_array_stride(elem) > sizeof(V) && n > (SIZE_MAX - sizeof(fwp_arr)) / fwp_array_stride(elem)) fwp_trap("array too large");
    size_t bytes = sizeof(fwp_arr) + n * fwp_array_stride(elem);
    void *storage = fwp_array_numeric(elem) ? fwp_alloc_leaf(bytes) : fwp_alloc(bytes);
    V result = PTR(storage); uint64_t len = n; memcpy(storage, &len, sizeof len); return result;
}

static V fwp_array_escape(V value, const fwp_desc *elem) {
#ifdef FWP_EXACT_FLOAT
    if (elem && elem->kind == K_F128) return fwp_box_f128(fwp_f128(value));
#endif
    return value;
}

static int fwp_is_signed_kind(int k) { return k == K_I8 || k == K_I16 || k == K_I32 || k == K_I64; }

/* ---------------------------------------------------------------- control */

/* Typed releases registered by ownership-aware callers. Nodes live in their
 * caller's stack frame; normal return unlinks without running the callback.
 * Unwind runs releases before longjmp invalidates those frames. A callback
 * may release storage but must not suspend, throw or register another node. */
typedef struct fwp_cleanup {
    struct fwp_cleanup *prev;
    void (*release)(void *);
    void *arg;
} fwp_cleanup;
static fwp_cleanup *fwp_cleanups = 0;

static void fwp_cleanup_push(fwp_cleanup *c, void (*release)(void *), void *arg) {
    c->prev = fwp_cleanups;
    c->release = release;
    c->arg = arg;
    fwp_cleanups = c;
}

static void fwp_cleanup_pop(fwp_cleanup *c) {
    if (fwp_cleanups != c) abort(); /* internal: normal returns must be LIFO */
    fwp_cleanups = c->prev;
}

static void fwp_cleanup_unwind(fwp_cleanup *stop) {
    while (fwp_cleanups != stop) {
        fwp_cleanup *c = fwp_cleanups;
        if (!c) abort(); /* internal: the target must be an ancestor */
        fwp_cleanups = c->prev;
        c->release(c->arg);
    }
}

/* Foreign callback borrows belong to the active task and C call. The frames
 * live on that call's stack; unwind/cancellation restores the previous frame. */
typedef struct fwp_foreign_callback {
    struct fwp_foreign_callback *prev;
    uint32_t function, parameter;
    V closure;
} fwp_foreign_callback;
static fwp_foreign_callback *fwp_foreign_callbacks;
static void fwp_foreign_callback_release(void *arg) {
    fwp_foreign_callback *frame = arg;
    if (fwp_foreign_callbacks != frame) abort();
    fwp_foreign_callbacks = frame->prev;
}
static V fwp_foreign_callback_get(uint32_t function, uint32_t parameter) {
    for (fwp_foreign_callback *f = fwp_foreign_callbacks; f; f = f->prev)
        if (f->function == function && f->parameter == parameter) return f->closure;
    fwp_trap("foreign callback invoked outside its calling task and call");
    return 0;
}

typedef struct fwp_handler {
    jmp_buf jb;
    struct fwp_handler *prev;
    V value;
    const fwp_desc *desc;
    size_t state_depth;
    fwp_cleanup *cleanup;
} fwp_handler;

static fwp_handler *fwp_handlers = 0;
static V *fwp_state = 0;
static size_t fwp_state_len = 0, fwp_state_cap = 0;
typedef struct fwp_state_owner {
    struct fwp_state_owner *prev;
    size_t index;
    V value;
    void (*duplicate)(V);
    void (*drop)(V);
} fwp_state_owner;
static fwp_state_owner *fwp_state_owners = 0;

static FILE *fwp_prog_out; /* where `print` writes (stderr in binary exec mode) */

static void fwp_flush(void) {
    if (fwp_prog_out) fflush(fwp_prog_out);
    fflush(stdout);
}

/* A gRPC server recovers from a trap in a call it is serving
 * (runtime/fwp_rt_grpc.c): the predicate says whether the trap happened
 * where it can be recovered, and sets the jump target. */
static jmp_buf *fwp_trap_jb = 0;
static fwp_cleanup *fwp_trap_cleanup = 0;
static int (*fwp_trap_recover)(void) = 0;
static char fwp_trap_msg[1024];

static void fwp_trap(const char *msg) {
    if (fwp_trap_recover && fwp_trap_recover() && fwp_trap_jb) {
        snprintf(fwp_trap_msg, sizeof fwp_trap_msg, "%s", msg);
        fwp_cleanup_unwind(fwp_trap_cleanup);
        longjmp(*fwp_trap_jb, 1);
    }
    fwp_flush();
    fprintf(stderr, "fwp: trap: %s\n", msg);
    exit(101);
}

/* `prim.trap`: stop the program with a message (like a failed check) */
static V fwp_p_trap(V msg) {
    fwp_trap(STR(msg)->d);
    return 0;
}

/* Keep the diagnostic buffer out of hot arithmetic and recursive frames. */
static __attribute__((cold, noinline)) void fwp_trap_overflow(const char *ty) {
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
    fwp_cleanup_unwind(fwp_handlers->cleanup);
    longjmp(fwp_handlers->jb, 1);
}

/* Unused State slots must not remain conservative roots in this buffer. */
static void fwp_state_restore(size_t depth) {
    while (fwp_state_len > depth) fwp_state[--fwp_state_len] = 0;
    fwp_state_len = depth;
}

static V fwp_state_pop(void) {
    V value = fwp_state[fwp_state_len - 1];
    fwp_state[fwp_state_len - 1] = 0;
    fwp_state_len--;
    return value;
}

static void fwp_state_push(V s) {
    if (fwp_state_len == fwp_state_cap) {
        size_t old = fwp_state_cap;
        fwp_state_cap = fwp_state_cap ? fwp_state_cap * 2 : 16;
        fwp_state = (V *)fwp_mem_realloc(fwp_state, old * sizeof(V), fwp_state_cap * sizeof(V));
    }
    fwp_state[fwp_state_len++] = s;
}

/* ------------------------------------------------------------- application */

typedef struct {
    V (*entry)(V *);
    void (*captures)(V, int);
    /* Duplicate a borrowed argument slice by its monomorphic parameter types. */
    void (*arguments)(V *, uint32_t, uint32_t);
    /* Drop pending arguments along the complete specialized arrow spine,
     * including arguments awaiting a returned function in overapplication. */
    void (*drop_arguments)(V *, uint32_t, uint32_t);
} fwp_owned_fninfo;
typedef struct { uint32_t arity; V (*entry)(V *); const char *name;
                 const fwp_owned_fninfo *owned; } fwp_fninfo;
static const fwp_fninfo *fwp_fns; /* set by the generated main */

static V fwp_apply(V f, uint32_t n, V *args) {
    for (;;) {
        fwp_clo *c = CLO(f);
        const fwp_fninfo *fi = &fwp_fns[c->fn];
        uint32_t ar = fi->arity;
        uint32_t have = c->n;
        /* the common case: a function with nothing captured, given (at
         * least) all its arguments, reads them where they are */
        if (have == 0 && n >= ar && ar > 0) {
            V r = fi->entry(args);
            if (n == ar) return r;
            f = r;
            args += ar;
            n -= ar;
            continue;
        }
        if (have + n < ar) {
            fwp_clo *r = (fwp_clo *)fwp_alloc(sizeof(fwp_clo) + (have + n) * sizeof(V));
            r->fn = c->fn;
            r->n = have + n;
            for (uint32_t i = 0; i < have; i++) r->a[i] = c->a[i];
            for (uint32_t i = 0; i < n; i++) r->a[have + i] = args[i];
            return PTR(r);
        }
        uint32_t need = ar - have;
        V all[ar ? ar : 1];
        for (uint32_t i = 0; i < have; i++) all[i] = c->a[i];
        for (uint32_t i = 0; i < need; i++) all[have + i] = args[i];
        V r = fi->entry(all);
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
