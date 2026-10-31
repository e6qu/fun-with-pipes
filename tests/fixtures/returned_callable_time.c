/* Separate caller, without LTO. Each population owns independent captures.
 * Timed binaries contain neither allocation counters nor per-call clocks. */
#include "returned_callable_peer.h"
#include "callable_phase_clock.h"
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

_Noreturn void returned_failure(const unsigned char *message, size_t length, int status) {
    if (fwrite(message, 1, length, stderr) != length) exit(74);
    exit(status);
}

#if RETURNED_FWP
int returned_observe(int argc, char **argv) {
#else
int main(int argc, char **argv) {
#endif
    if (argc != 5 || (strcmp(argv[1], "0") && strcmp(argv[1], "1"))) return 73;
    /* Fixed recorded workload; reject accidental partial/oversized inputs. */
    if (strcmp(argv[2], "4096") || strcmp(argv[3], "256") || strcmp(argv[4], "16")) return 73;
    const int32_t kind = argv[1][0] - '0';
    const int64_t population = 4096, cycles = 256, passes = 16;
    uint64_t construction = 0, invocation = 0, destruction = 0;
    int64_t checksum = 0;
    for (int64_t cycle = 0; cycle < cycles; cycle++) {
        uint64_t start = callable_phase_clock();
        returned_callable *values = malloc((size_t)population * sizeof(*values));
        if (!values) return 74;
        for (int64_t i = 0; i < population; i++) values[i] = returned_make(kind, i + 7);
        uint64_t made = callable_phase_clock();
        for (int64_t pass = 0; pass < passes; pass++) {
            for (int64_t i = 0; i < population; i++) {
#if RETURNED_FWP
                uint64_t input = (uint64_t)pass;
                int64_t result = (int64_t)fwp_apply_borrowed(values[i], 1, &input);
#else
                int64_t result = values[i].invoke(values[i].capture, pass);
#endif
                if (__builtin_add_overflow(checksum, result, &checksum)) return 75;
            }
        }
        uint64_t called = callable_phase_clock();
#if RETURNED_FWP
        for (int64_t i = 0; i < population; i++) fwp_closure_drop(values[i]);
#endif
        free(values);
        uint64_t released = callable_phase_clock();
        if (made < start || called < made || released < called) return 76;
        construction += made - start;
        invocation += called - made;
        destruction += released - called;
#if RETURNED_FWP
        if (!returned_storage_clean()) return 78;
#endif
    }
    const int64_t expected = (kind + 1) * cycles *
        (passes * (population * (population - 1) / 2 + 7 * population) +
         population * passes * (passes - 1) / 2);
    if (checksum != expected) return 75;
    printf("%" PRId64 " %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
           checksum, construction, invocation, destruction);
    return 0;
}
