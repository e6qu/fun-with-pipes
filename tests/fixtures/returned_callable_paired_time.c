/* Both invocation modes share one process, constructor and allocator instance. */
#include "returned_callable_peer.h"
#include "callable_phase_clock.h"
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

uint64_t returned_apply_reference(uint64_t, uint32_t, uint64_t *);

_Noreturn void returned_failure(const unsigned char *message, size_t length, int status) {
    if (fwrite(message, 1, length, stderr) != length) exit(74);
    exit(status);
}

int returned_observe(int argc, char **argv) {
    if (argc != 6 || (strcmp(argv[1], "0") && strcmp(argv[1], "1"))) return 73;
    if (strcmp(argv[2], "4096") || strcmp(argv[3], "256")) return 73;
    if (strcmp(argv[4], "0") && strcmp(argv[4], "1") && strcmp(argv[4], "16")) return 73;
    if (strcmp(argv[5], "reference") && strcmp(argv[5], "current")) return 73;
    const int32_t kind = argv[1][0] - '0';
    const int64_t population = 4096, cycles = 256, passes = strtoll(argv[4], NULL, 10);
    const unsigned first = strcmp(argv[5], "reference") == 0 ? 0 : 1;
    uint64_t (*entries[2])(uint64_t, uint32_t, uint64_t *) = {returned_apply_reference, fwp_apply_borrowed};
    uint64_t construction[2] = {0, 0}, invocation[2] = {0, 0}, destruction[2] = {0, 0};
    int64_t checksum[2] = {0, 0};
    for (int64_t cycle = 0; cycle < 2 * cycles; cycle++) {
        /* ABBA or BAAB: equal batches and mean batch position for both modes. */
        const unsigned mode = first ^ ((cycle % 4 == 1 || cycle % 4 == 2) ? 1u : 0u);
        uint64_t (*apply)(uint64_t, uint32_t, uint64_t *) = entries[mode];
        uint64_t start = callable_phase_clock();
        returned_callable *values = malloc((size_t)population * sizeof(*values));
        if (!values) return 74;
        for (int64_t i = 0; i < population; i++) values[i] = returned_make(kind, i + 7);
        uint64_t made = callable_phase_clock();
        for (int64_t pass = 0; pass < passes; pass++) {
            for (int64_t i = 0; i < population; i++) {
                uint64_t input = (uint64_t)pass;
                int64_t result = (int64_t)apply(values[i], 1, &input);
                if (__builtin_add_overflow(checksum[mode], result, &checksum[mode])) return 75;
            }
        }
        uint64_t called = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) fwp_closure_drop(values[i]);
        free(values);
        uint64_t released = callable_phase_clock();
        if (made < start || called < made || released < called) return 76;
        construction[mode] += made - start;
        invocation[mode] += called - made;
        destruction[mode] += released - called;
        if (!returned_storage_clean()) return 78;
    }
    const int64_t expected = (kind + 1) * cycles *
        (passes * (population * (population - 1) / 2 + 7 * population) +
         population * passes * (passes - 1) / 2);
    if (checksum[0] != expected || checksum[1] != expected) return 75;
    for (unsigned mode = 0; mode < 2; mode++) {
        printf("%" PRId64 " %" PRIu64 " %" PRIu64 " %" PRIu64 "%s",
               checksum[mode], construction[mode], invocation[mode], destruction[mode],
               mode == 0 ? " " : "\n");
    }
    return 0;
}
