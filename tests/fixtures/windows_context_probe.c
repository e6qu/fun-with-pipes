#define _WIN32_WINNT 0x0a00
#include <stdint.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <setjmp.h>
#include <time.h>
#include <fenv.h>
typedef uint64_t V;
typedef struct { uint32_t tag, n; V f[]; } fwp_obj;
typedef struct { uint64_t len; char d[]; } fwp_str;
#define STR(v) ((fwp_str *)(uintptr_t)(v))
#define FWP_LIBRARY 1
static void fwp_trap(const char *message) { fprintf(stderr, "%s\n", message); exit(101); }
/* NATIVE_ALLOCATOR */
/* WINDOWS_CONTEXT */
static fwp_win_context root, child;
static uintptr_t hidden_root;
static int phase;
#define HIDE ((uintptr_t)UINT64_C(0x5a5a5a5a5a5a5a5a))
static void fwp_heap_scan_stacks(char *sp) { (void)sp; fwp_win_context_scan(&child); }

static void CALLBACK child_entry(void *argument) {
    (void)argument;
    fwp_win_context_started(&child);
#if defined(__aarch64__)
    register char *held __asm__("x28");
#else
    register char *held __asm__("r15");
#endif
    held = fwp_alloc_leaf(64);
    strcpy(held, "register root");
    hidden_root = (uintptr_t)held ^ HIDE;
    if (fesetround(FE_DOWNWARD)) exit(30);
    __asm__ volatile("" : "+r"(held));
    phase = 1;
    fwp_win_context_switch(&child, &root);
    __asm__ volatile("" : "+r"(held));
    if (strcmp(held, "register root") || fegetround() != FE_DOWNWARD) exit(31);
    volatile V local = (V)(uintptr_t)fwp_alloc_leaf(64);
    strcpy((char *)(uintptr_t)local, "stack root");
    hidden_root = (uintptr_t)local ^ HIDE;
    phase = 2;
    fwp_win_context_switch(&child, &root);
    if (strcmp((char *)(uintptr_t)local, "stack root")) exit(32);
    phase = 3;
    fwp_win_context_switch(&child, &root);
    abort();
}

int main(void) {
    fwp_heap_start();
    if (IsThreadAFiber()) return 10;
    fwp_win_context_root(&root);
    if (!IsThreadAFiber() || !root.converted_thread) return 11;
    for (int iteration = 0; iteration < 32; iteration++) {
        memset(&child, 0, sizeof child);
        phase = 0;
        child.fiber = CreateFiberEx(65536, (size_t)256 << 20,
                                   FIBER_FLAG_FLOAT_SWITCH, child_entry, NULL);
        if (!child.fiber) return 12;
        if (fesetround(FE_UPWARD)) return 13;
        fwp_win_context_switch(&root, &child);
        if (phase != 1 || fegetround() != FE_UPWARD || !child.sp || !child.top) return 14;
        // Independently prove registers; exclude even incidental stack copies.
        char *saved = child.sp;
        child.sp = child.top;
        fwp_heap.major_next = 1;
        fwp_heap_collect();
        if (!fwp_heap_marked((void *)(hidden_root ^ HIDE))) return 23;
        child.sp = saved;
        fwp_win_context_switch(&root, &child);
        if (phase != 2) return 15;
        // The OS owns restoration. This copy exists only for GC, so clearing
        // it isolates the suspended stack without corrupting fiber execution.
        memset(child.registers, 0, sizeof child.registers);
        fwp_heap.major_next = 1;
        fwp_heap_collect();
        if (!fwp_heap_marked((void *)(hidden_root ^ HIDE))) return 24;
        fwp_win_context_switch(&root, &child);
        if (phase != 3) return 16;
        DeleteFiber(child.fiber);
        memset(&child, 0, sizeof child);
        fwp_heap.major_next = 1;
        fwp_heap_collect();
        if (fwp_heap.live) return 17;
    }
    // Library teardown must preserve a fiber installed by its host.
    fwp_win_context borrowed = {0};
    fwp_win_context_root(&borrowed);
    if (borrowed.converted_thread || borrowed.fiber != root.fiber) return 18;
    fwp_win_context_root_finish(&borrowed);
    if (!IsThreadAFiber()) return 19;
    fwp_win_context_root_finish(&root);
    if (IsThreadAFiber()) return 20;
    fwp_heap_finish();
    return 0;
}
