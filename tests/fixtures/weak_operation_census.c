/* Diagnostic managed-slot counts; no native allocation, ARC or timing claims. */
#include "weak_operation_peer.h"
#include "weak_operation_census.h"
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
    if (argc != 4) fail("expected population lookups control", 2);
    int64_t population = number(argv[1]), lookups = number(argv[2]);
    if ((population != 1 && population != 64 && population != 4096) ||
        (lookups != 1 && lookups != 16 && lookups != 64)) fail("invalid experiment arguments", 2);
    if (!reference_calibrate(argv[3])) fail("allocation observer control failed", 79);
    ReferenceOwner *owners = malloc((size_t)population * sizeof(*owners));
    ReferenceWeak *weak = malloc((size_t)population * sizeof(*weak));
    if (!owners || !weak) { free(owners); free(weak); fail("out of memory", 102); }
    ReferenceCosts costs[6];
    int64_t live = 0, expired = 0;
    reference_cost_begin();
    for (int64_t i = 0; i < population; i++) owners[i] = reference_make(1);
    costs[0] = reference_cost_end();
    reference_cost_begin();
    for (int64_t i = 0; i < population; i++) weak[i] = reference_downgrade(owners[i]);
    costs[1] = reference_cost_end();
    reference_cost_begin();
    for (int64_t repeat = 0; repeat < lookups; repeat++)
        for (int64_t i = 0; i < population; i++) live += reference_lookup(weak[i]);
    costs[2] = reference_cost_end();
    reference_cost_begin();
    for (int64_t i = 0; i < population; i++) reference_release_owner(owners[i]);
    costs[3] = reference_cost_end();
    reference_cost_begin();
    for (int64_t repeat = 0; repeat < lookups; repeat++)
        for (int64_t i = 0; i < population; i++) expired += reference_lookup(weak[i]);
    costs[4] = reference_cost_end();
    reference_cost_begin();
    for (int64_t i = 0; i < population; i++) reference_release_weak(weak[i]);
    costs[5] = reference_cost_end();
    free(owners); free(weak);
    if (!reference_clean()) fail("reference release check failed", 79);
    if (live != population * lookups || expired != 0) fail("incorrect result", 4);
    printf("{\"population\":%" PRId64 ",\"lookups\":%" PRId64 ",\"live\":%" PRId64 ",\"expired\":%" PRId64 ",\"phases\":[",
           population, lookups, live, expired);
    for (size_t phase = 0; phase < 6; phase++) {
        ReferenceCosts c = costs[phase];
        printf("%s{\"allocations\":%" PRIu64 ",\"slotBytes\":%" PRIu64 ",\"someAllocations\":%" PRIu64
               ",\"someSlotBytes\":%" PRIu64 ",\"liveBytes\":%" PRIu64 ",\"peakLiveBytes\":%" PRIu64 "}",
               phase ? "," : "", c.allocations, c.slot_bytes, c.some_allocations, c.some_slot_bytes, c.live_bytes, c.peak_live_bytes);
    }
    puts("]}");
    return 0;
}
