/* One externally compiled consumer shared by the fwp, C and Rust diagnostics.
 * No LTO: each solve must supply every result coordinate before releasing it.
 * DUMP=1 records exact float bits for untimed validation. DUMP=0 hashes all
 * coordinates and prints once at process end. Neither mode allocates storage.
 * Read bytes: fwp stores float bits in word-backed storage; aliasing that
 * storage through a double lvalue would violate C's effective-type rules. */
#include <inttypes.h>
#include <math.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#ifndef DESCENT_SINK_DUMP
#error DESCENT_SINK_DUMP must be supplied
#endif
#ifndef DESCENT_SINK_OMIT_LAST
#error DESCENT_SINK_OMIT_LAST must be supplied
#endif
_Static_assert(DESCENT_SINK_DUMP == 0 || DESCENT_SINK_DUMP == 1, "invalid dump setting");
_Static_assert(DESCENT_SINK_OMIT_LAST == 0 || DESCENT_SINK_OMIT_LAST == 1, "invalid control setting");
_Static_assert(sizeof(double) == sizeof(uint64_t), "expected 64-bit doubles");

static uint64_t result_hash = UINT64_C(14695981039346656037);
static uint64_t completed_solves;

void descent_sink_values(const void *values, size_t count) {
    if (!count || !values) _Exit(227);
    completed_solves++;
    result_hash = (result_hash ^ count) * UINT64_C(1099511628211);
    if (DESCENT_SINK_DUMP) putchar('[');
    for (size_t i = 0; i < count - DESCENT_SINK_OMIT_LAST; ++i) {
        uint64_t bits;
        double value;
        const unsigned char *address = (const unsigned char *)values + i * sizeof bits;
        memcpy(&bits, address, sizeof bits);
        memcpy(&value, address, sizeof value);
        if (!isfinite(value)) _Exit(227);
        result_hash = (result_hash ^ bits) * UINT64_C(1099511628211);
        if (DESCENT_SINK_DUMP)
            printf(i ? ",\"%016" PRIx64 "\"" : "\"%016" PRIx64 "\"", bits);
    }
    if (DESCENT_SINK_DUMP) puts("]");
}

void descent_sink_report(void) {
    if (!DESCENT_SINK_DUMP)
        printf("%" PRIu64 " %016" PRIx64 "\n", completed_solves, result_hash);
    if (fflush(stdout) || ferror(stdout)) _Exit(228);
}
