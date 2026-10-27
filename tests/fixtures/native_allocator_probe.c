#ifdef _WIN32
#define _WIN32_WINNT 0x0a00
#endif
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <setjmp.h>
#include <time.h>
typedef uint64_t V;
typedef struct { uint32_t tag, n; V f[]; } fwp_obj;
typedef struct { uint64_t len; char d[]; } fwp_str;
#define STR(v) ((fwp_str *)(uintptr_t)(v))
#define FWP_LIBRARY 1
static void fwp_trap(const char *message) { fprintf(stderr, "%s\n", message); exit(101); }
/* NATIVE_ALLOCATOR */
static int finalizers;
static void finalize(void *value) {
    if (strcmp(value, "owned until unload")) exit(34);
    finalizers++;
}
int main(void) {
    fwp_heap_start();
#ifdef _WIN32
    MEMORY_BASIC_INFORMATION region;
    if (!VirtualQuery(fwp_heap.base, &region, sizeof region) || region.State != MEM_RESERVE) return 12;
#endif
    V value = fwp_rc_fresh((V)(uintptr_t)fwp_alloc_leaf(32));
    for (unsigned i = 0; i < 300; i++) fwp_rc_dup(value);
    for (unsigned i = 0; i < 300; i++) if (fwp_rc_release_last(value)) return 25;
    if (!fwp_rc_last(value) || fwp_heap.rc_wide_len) return 26;
    fwp_rc_free_obj(value);
    if (fwp_heap.live || fwp_heap.freed != 32) return 27;
    for (unsigned i = 0; i < 1024; i++) {
        V next = fwp_rc_fresh((V)(uintptr_t)fwp_alloc_leaf(32));
        if (next != value || next % 16 || !fwp_rc_last(next)) return 28;
        fwp_rc_free_obj(next);
    }
    size_t size = (size_t)40 << 20;
    unsigned char *large = fwp_alloc_leaf(size);
    memset(large, 0x79, size);
    fwp_mem_free(large);
    if (fwp_heap.live || fwp_heap.nfree_chunks < (size >> HEAP_SHIFT)) return 29;
    unsigned char *again = fwp_alloc_leaf(size);
    if (again != large) return 30;
    for (size_t i = 0; i < size; i += 4096) if (again[i]) return 30;
#ifdef _WIN32
    if (!VirtualQuery(again, &region, sizeof region) || region.State != MEM_COMMIT) return 31;
    void *reservation = fwp_heap.reservation;
#endif
    fwp_mem_free(again);
    if (fwp_heap.live || fwp_heap.total_alloc != fwp_heap.freed || fwp_heap.peak != size) return 35;
    if (fwp_heap_status_kb("VmHWM") <= 0) return 32;
    char *owned = fwp_alloc_leaf(32);
    strcpy(owned, "owned until unload");
    fwp_heap_finalizer(owned, finalize);
    fwp_heap_finish();
    if (finalizers != 1) return 34;
#ifdef _WIN32
    if (!VirtualQuery(reservation, &region, sizeof region) || region.State != MEM_FREE) return 33;
#endif
    return 0;
}
