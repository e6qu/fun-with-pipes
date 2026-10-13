/* fwp configuration: one integer implementation for Clang/GCC targets. */
#ifndef FWP_TLFLOAT_CONFIG
#define FWP_TLFLOAT_CONFIG
#define TLFLOAT_VERSION_MAJOR 1
#define TLFLOAT_VERSION_MINOR 15
#define TLFLOAT_VERSION_PATCH 0
#define TLFLOAT_COMPILER_SUPPORTS_INT128
/* Compiler-wide integer arithmetic and count-leading-zero builtins work on
 * Linux/macOS/Windows ARM64/AMD64 and wasm32. No x86-only MSVC intrinsics. */
#define TLFLOAT_DISABLE_ARCH_OPTIMIZATION
#define TLFLOAT_ENABLE_INT128_OPT
#define TLFLOAT_ENABLE_GNUC_CLZ
#endif
