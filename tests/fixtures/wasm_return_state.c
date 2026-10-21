/* The test includes this before the real helper source. Rename its public
 * symbols because compile_for also links the actual WebAssembly runtime. */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
static int probe_reallocations;
static void *probe_realloc(void *p, size_t bytes) {
    probe_reallocations++;
    if (PROBE_CASE == 1) return NULL;
    return realloc(p, bytes);
}
#define realloc probe_realloc
#define abort() _Exit(217)
#define saveSetjmp probe_saveSetjmp
#define testSetjmp probe_testSetjmp
#define getTempRet0 probe_getTempRet0
#define fwp_lj_prepare probe_lj_prepare
/* Exercise growth bounds with a small, fully allocated table. These limits
 * substitute for the enormous real limits; no invalid table range is scanned. */
#if PROBE_CASE == 3
#undef UINT32_MAX
#define UINT32_MAX 7
#elif PROBE_CASE == 4
#undef SIZE_MAX
#define SIZE_MAX (sizeof(fwp_sj_entry) * 7)
#endif
