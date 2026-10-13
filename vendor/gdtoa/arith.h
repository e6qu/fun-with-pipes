/* fwp: all accepted targets are little endian IEEE binary64 hosts. */
#include <stdint.h>
#include <stddef.h>
#ifdef __wasi__
/* LLVM's wasm exception-based setjmp lowering, also used by the runtime. */
typedef long jmp_buf[4];
int setjmp(jmp_buf) __attribute__((returns_twice));
_Noreturn void longjmp(jmp_buf, int);
#else
#include <setjmp.h>
#endif
#define IEEE_8087
#define Arith_Kind_ASL 1
#define Long int
#define Intcast (int)(long)
#define Double_Align
#if UINTPTR_MAX > UINT32_MAX
#define X64_bit_pointers
#endif
#define MULTIPLE_THREADS
#define Omit_Private_Memory
#define NO_HEX_FP
#define No_Hex_NaN
#define NO_ERRNO
