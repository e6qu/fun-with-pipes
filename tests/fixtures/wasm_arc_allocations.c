/* Test-only libc ledger: independently count physical storage, not RC entries. */
#include <stdlib.h>
#include <stdint.h>
#include <stdio.h>
static struct { void *address; size_t bytes; unsigned line, phase; } wasm_arc_storage[16384];
static size_t wasm_arc_live, wasm_arc_bytes, wasm_arc_slots_used;
static unsigned wasm_arc_phase;
static void wasm_arc_register(void *p, size_t n, unsigned line) {
    if (!p) return;
    size_t empty = 16384;
    for (size_t i = 0; i < wasm_arc_slots_used; i++) {
        if (wasm_arc_storage[i].address == p) exit(245);
        if (!wasm_arc_storage[i].address && empty == 16384) empty = i;
    }
    if (empty == 16384) {
        if (wasm_arc_slots_used == 16384) exit(242);
        empty = wasm_arc_slots_used++;
    }
    wasm_arc_storage[empty].address = p; wasm_arc_storage[empty].bytes = n;
    wasm_arc_storage[empty].line = line; wasm_arc_storage[empty].phase = wasm_arc_phase;
    wasm_arc_live++; wasm_arc_bytes += n;
}
static void wasm_arc_unregister(void *p) {
    if (!p) return;
    for (size_t i = 0; i < wasm_arc_slots_used; i++) if (wasm_arc_storage[i].address == p) {
        wasm_arc_bytes -= wasm_arc_storage[i].bytes; wasm_arc_live--;
        wasm_arc_storage[i].address = NULL;
        while (wasm_arc_slots_used && !wasm_arc_storage[wasm_arc_slots_used - 1].address)
            wasm_arc_slots_used--;
        return;
    }
    exit(243);
}
static void *wasm_arc_malloc(size_t n, unsigned line) {
    void *p = malloc(n); wasm_arc_register(p, n, line); return p;
}
static void *wasm_arc_calloc(size_t n, size_t size, unsigned line) {
    void *p = calloc(n, size); wasm_arc_register(p, n * size, line); return p;
}
static void *wasm_arc_realloc(void *p, size_t n, unsigned line) {
    /* The observer removes metadata before realloc invalidates the old address. */
    size_t old = 0;
    if (p) {
        for (size_t i = 0; i < wasm_arc_slots_used; i++)
            if (wasm_arc_storage[i].address == p) old = wasm_arc_storage[i].bytes;
        wasm_arc_unregister(p);
    }
    void *q = realloc(p, n);
    if (q) wasm_arc_register(q, n, line);
    else if (n && p) wasm_arc_register(p, old, line);
    return q;
}
static void wasm_arc_free(void *p) {
    wasm_arc_unregister(p); free(p);
}
#define malloc(n) wasm_arc_malloc((n), __LINE__)
#define calloc(n, s) wasm_arc_calloc((n), (s), __LINE__)
#define realloc(p, n) wasm_arc_realloc((p), (n), __LINE__)
#define free wasm_arc_free
