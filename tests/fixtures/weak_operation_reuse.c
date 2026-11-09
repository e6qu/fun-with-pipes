/* Compare saved integer addresses; never inspect a released target. */
#include "weak_operation_peer.h"
#include <inttypes.h>
#include <stdio.h>
#include <stdlib.h>

static void fail(void) { fputs("weak reuse check failed\n", stderr); exit(79); }
int main(int argc, char **argv) {
    (void)argv;
    if (argc != 1) { fputs("expected no arguments\n", stderr); return 2; }
    unsigned reused = 0, expired = 0, replacement_live = 0;
    for (unsigned round = 0; round < 1024; round++) {
        ReferenceOwner owner = reference_make(1);
        uintptr_t address = (uintptr_t)owner;
        ReferenceWeak weak = reference_downgrade(owner);
        if (!reference_lookup(weak)) fail();
        reference_release_owner(owner);
        if (reference_lookup(weak)) fail();
        ReferenceOwner replacement = reference_make(1);
        if ((uintptr_t)replacement == address) reused++;
        int revived = reference_lookup(weak);
        if (revived) fail();
        expired++;
        ReferenceWeak current = reference_downgrade(replacement);
        if (!reference_lookup(current)) fail();
        replacement_live++;
        reference_release_owner(replacement);
        if (reference_lookup(current)) fail();
        reference_release_weak(current);
        reference_release_weak(weak);
    }
    if (!reused) fail();
    printf("{\"rounds\":1024,\"reused\":%u,\"expired\":%u,\"replacementLive\":%u}\n",
           reused, expired, replacement_live);
    return 0;
}
