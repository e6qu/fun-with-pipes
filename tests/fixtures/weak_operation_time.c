/* Ordinary population caller; slot storage is outside the measured phases. */
#include "weak_operation_peer.h"
#include "callable_phase_clock.h"
#include <errno.h>
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

static void fail(const char *text, int status) { fprintf(stderr, "%s\n", text); exit(status); }
static int64_t number(const char *text) {
    if (!*text) fail("invalid integer", 2);
    for (const char *p = text; *p; p++) if (*p < '0' || *p > '9') fail("invalid integer", 2);
    errno = 0;
    char *end;
    intmax_t value = strtoimax(text, &end, 10);
    if (errno || *end || value > INT64_MAX) fail("invalid integer", 2);
    return (int64_t)value;
}
int reference_observe(int argc, char **argv) {
    if (argc != 4) fail("expected population lookups batches", 2);
    int64_t population = number(argv[1]), lookups = number(argv[2]), batches = number(argv[3]);
    if ((population != 1 && population != 64 && population != 4096) ||
        (lookups != 1 && lookups != 16 && lookups != 64) ||
        (batches != 1 && batches != 16 && batches != 64 && batches != 256 && batches != 1024))
        fail("invalid experiment arguments", 2);
    ReferenceOwner *owners = malloc((size_t)population * sizeof(*owners));
    ReferenceWeak *weak = malloc((size_t)population * sizeof(*weak));
    if (!owners || !weak) { free(owners); free(weak); fail("out of memory", 102); }
    int64_t live = 0, expired = 0;
    uint64_t times[6] = {0};
    for (int64_t batch = 0; batch < batches; batch++) {
        uint64_t t[7];
        t[0] = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) owners[i] = reference_make(1);
        t[1] = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) weak[i] = reference_downgrade(owners[i]);
        t[2] = callable_phase_clock();
        for (int64_t repeat = 0; repeat < lookups; repeat++)
            for (int64_t i = 0; i < population; i++) live += reference_lookup(weak[i]);
        t[3] = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) reference_release_owner(owners[i]);
        t[4] = callable_phase_clock();
        for (int64_t repeat = 0; repeat < lookups; repeat++)
            for (int64_t i = 0; i < population; i++) expired += reference_lookup(weak[i]);
        t[5] = callable_phase_clock();
        for (int64_t i = 0; i < population; i++) reference_release_weak(weak[i]);
        t[6] = callable_phase_clock();
        for (size_t phase = 0; phase < 6; phase++) {
            if (t[phase + 1] < t[phase]) fail("clock moved backwards", 77);
            times[phase] += t[phase + 1] - t[phase];
        }
#if REFERENCE_DIAGNOSTIC == 1
        if (!reference_clean()) fail("reference release check failed", 79);
#endif
    }
    free(owners); free(weak);
    if (live != population * lookups * batches || expired != 0) fail("incorrect result", 4);
    printf("{\"live\":%" PRId64 ",\"expired\":%" PRId64 ",\"targetCreation\":%" PRIu64
           ",\"weakCreation\":%" PRIu64 ",\"liveLookup\":%" PRIu64 ",\"ownerRelease\":%" PRIu64
           ",\"expiredLookup\":%" PRIu64 ",\"weakRelease\":%" PRIu64 "}\n",
           live, expired, times[0], times[1], times[2], times[3], times[4], times[5]);
    return 0;
}
#if REFERENCE_FWP == 0
int main(int argc, char **argv) { return reference_observe(argc, argv); }
#endif
