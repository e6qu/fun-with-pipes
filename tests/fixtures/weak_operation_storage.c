/* Exit after an explicit ownership boundary; heaptrack observes actual retention.
 * Stages 0..2 deliberately leave owners behind. These are diagnostic processes. */
#include "weak_operation_peer.h"
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
int main(int argc, char **argv) {
    if (argc != 3) fail("expected population stage", 2);
    int64_t population = number(argv[1]), stage = number(argv[2]);
    if ((population != 64 && population != 4096) || stage > 3)
        fail("invalid experiment arguments", 2);
    ReferenceOwner *owners = malloc((size_t)population * sizeof(*owners));
    ReferenceWeak *weak = malloc((size_t)population * sizeof(*weak));
    if (!owners || !weak) { free(owners); free(weak); fail("out of memory", 102); }
    int64_t live = 0, expired = 0;
    for (int64_t i = 0; i < population; i++) owners[i] = reference_make(1);
    if (stage >= 1) {
        for (int64_t i = 0; i < population; i++) weak[i] = reference_downgrade(owners[i]);
        for (int64_t i = 0; i < population; i++) live += reference_lookup(weak[i]);
    }
    if (stage >= 2) {
        for (int64_t i = 0; i < population; i++) reference_release_owner(owners[i]);
        for (int64_t i = 0; i < population; i++) expired += reference_lookup(weak[i]);
    }
    if (stage >= 3) {
        for (int64_t i = 0; i < population; i++) reference_release_weak(weak[i]);
    }
    free(owners); free(weak);
    if (live != (stage >= 1 ? population : 0) || expired != 0) fail("incorrect result", 4);
    printf("{\"population\":%" PRId64 ",\"stage\":%" PRId64 ",\"live\":%" PRId64 ",\"expired\":%" PRId64 "}\n",
           population, stage, live, expired);
    return 0;
}
