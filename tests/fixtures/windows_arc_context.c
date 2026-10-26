/* The OS must preserve live values even when ARC has no collector snapshot. */
#define _WIN32_WINNT 0x0a00
#define FWP_GC 1
#define FWP_ARC_ONLY 1
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <setjmp.h>
#include <fenv.h>
#include <windows.h>
static void fwp_trap(const char *message) { fprintf(stderr, "%s\n", message); exit(101); }
static char *fwp_heap_sp(void) { return __builtin_frame_address(0); }
static int forbidden_snapshot(void) { _Exit(211); }
#undef setjmp
#define setjmp(buffer) forbidden_snapshot()
/* WINDOWS_CONTEXT */
static fwp_win_context root, child;
static int phase;
static char child_text[] = "child register", root_text[] = "root register";
static volatile double child_number = 1.25, root_number = 2.5;
#if defined(__aarch64__)
#define INTEGER_REGISTER "x28"
#define FLOAT_REGISTER "d8"
#define FLOAT_CONSTRAINT "+w"
#else
#define INTEGER_REGISTER "r15"
#define FLOAT_REGISTER "xmm6"
#define FLOAT_CONSTRAINT "+x"
#endif

static void CALLBACK child_entry(void *argument) {
    (void)argument;
    fwp_win_context_started(&child);
    register char *held __asm__(INTEGER_REGISTER) = child_text;
    register double number __asm__(FLOAT_REGISTER) = child_number;
    volatile uint64_t stack_value = UINT64_C(0x123456789abcdef0);
    if (fesetround(FE_DOWNWARD)) _Exit(212);
    for (int i = 0; i < 8; i++) {
        __asm__ volatile("" : "+r"(held), FLOAT_CONSTRAINT(number));
        phase = i + 1;
        fwp_win_context_switch(&child, &root);
        __asm__ volatile("" : "+r"(held), FLOAT_CONSTRAINT(number));
        if (held != child_text || strcmp(held, "child register") || number != 1.25 ||
            stack_value != UINT64_C(0x123456789abcdef0) || fegetround() != FE_DOWNWARD) _Exit(213);
    }
    phase = 9;
    fwp_win_context_switch(&child, &root);
    abort();
}

int main(void) {
    if (IsThreadAFiber()) return 214;
    fwp_win_context_root(&root);
    if (!IsThreadAFiber() || !root.converted_thread) return 214;
    register char *held __asm__(INTEGER_REGISTER) = root_text;
    register double number __asm__(FLOAT_REGISTER) = root_number;
    for (int iteration = 0; iteration < 32; iteration++) {
        memset(&child, 0, sizeof child);
        phase = 0;
        child.fiber = CreateFiberEx(65536, (size_t)256 << 20,
                                   FIBER_FLAG_FLOAT_SWITCH, child_entry, NULL);
        if (!child.fiber || fesetround(FE_UPWARD)) return 215;
        for (int expected = 1; expected <= 9; expected++) {
            __asm__ volatile("" : "+r"(held), FLOAT_CONSTRAINT(number));
            fwp_win_context_switch(&root, &child);
            __asm__ volatile("" : "+r"(held), FLOAT_CONSTRAINT(number));
            if (phase != expected || held != root_text || strcmp(held, "root register") ||
                number != 2.5 || fegetround() != FE_UPWARD) return 216;
        }
        DeleteFiber(child.fiber);
        memset(&child, 0, sizeof child);
    }
    fwp_win_context borrowed = {0};
    fwp_win_context_root(&borrowed);
    if (borrowed.converted_thread || borrowed.fiber != root.fiber) return 217;
    fwp_win_context_root_finish(&borrowed);
    if (!IsThreadAFiber()) return 218;
    fwp_win_context_root_finish(&root);
    if (IsThreadAFiber()) return 219;
    puts("ARC fibers preserve registers, stack, rounding and host ownership");
    return 0;
}
