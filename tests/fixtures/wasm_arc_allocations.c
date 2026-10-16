/* Test-only libc ledger: independently count physical storage, not RC entries. */
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
static struct { void *address; size_t bytes; } wasm_arc_storage[16384];
static size_t wasm_arc_live, wasm_arc_bytes;
static void wasm_arc_register(void *p, size_t n) {
    if (!p) return;
    for (size_t i = 0; i < 16384; i++) if (!wasm_arc_storage[i].address) {
        wasm_arc_storage[i].address = p; wasm_arc_storage[i].bytes = n;
        wasm_arc_live++; wasm_arc_bytes += n; return;
    }
    exit(242);
}
static void wasm_arc_unregister(void *p) {
    if (!p) return;
    for (size_t i = 0; i < 16384; i++) if (wasm_arc_storage[i].address == p) {
        wasm_arc_bytes -= wasm_arc_storage[i].bytes; wasm_arc_live--;
        wasm_arc_storage[i].address = NULL; return;
    }
    exit(243);
}
static void *wasm_arc_malloc(size_t n) {
    void *p = malloc(n); wasm_arc_register(p, n); return p;
}
static void *wasm_arc_calloc(size_t n, size_t size) {
    void *p = calloc(n, size); wasm_arc_register(p, n * size); return p;
}
static void *wasm_arc_realloc(void *p, size_t n) {
    /* The observer removes metadata before realloc invalidates the old address. */
    size_t old = 0;
    if (p) {
        for (size_t i = 0; i < 16384; i++)
            if (wasm_arc_storage[i].address == p) old = wasm_arc_storage[i].bytes;
        wasm_arc_unregister(p);
    }
    void *q = realloc(p, n);
    if (q) wasm_arc_register(q, n);
    else if (n && p) wasm_arc_register(p, old);
    return q;
}
static void wasm_arc_free(void *p) {
    wasm_arc_unregister(p); free(p);
}
#define malloc wasm_arc_malloc
#define calloc wasm_arc_calloc
#define realloc wasm_arc_realloc
#define free wasm_arc_free
