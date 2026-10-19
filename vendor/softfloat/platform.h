/* fwp configuration for Berkeley SoftFloat 3e. */
#define LITTLEENDIAN 1
#define SOFTFLOAT_FAST_INT64 1
#define SOFTFLOAT_ROUND_ODD 1
#define INLINE_LEVEL 0
#define INLINE static inline
#if defined(__wasm__)
#define THREAD_LOCAL
#else
#define THREAD_LOCAL _Thread_local
#endif
