/* Serial counted target plus lazily allocated, separately owned weak metadata.
 * These functions compile separately from the population/phase caller. */
#include "weak_operation_peer.h"
#include <stddef.h>
#include <stdlib.h>

struct ReferenceTarget {
    size_t strong;
    ReferenceWeak weak;
};
struct ReferenceControl {
    size_t owners;
    ReferenceOwner target;
};

#if REFERENCE_DIAGNOSTIC == 1
static size_t targets, metadata;
int reference_clean(void) { return targets == 0 && metadata == 0; }
#endif

ReferenceOwner reference_make(int64_t input) {
    if (input != 1) exit(90);
    ReferenceOwner owner = malloc(sizeof(*owner));
    if (!owner) exit(91);
    *owner = (struct ReferenceTarget){1, NULL};
#if REFERENCE_DIAGNOSTIC == 1
    targets++;
#endif
    return owner;
}
ReferenceWeak reference_downgrade(ReferenceOwner owner) {
    if (!owner->weak) {
        owner->weak = malloc(sizeof(*owner->weak));
        if (!owner->weak) exit(91);
        *owner->weak = (struct ReferenceControl){1, owner};
#if REFERENCE_DIAGNOSTIC == 1
        metadata++;
#endif
    }
    if (owner->weak->owners == SIZE_MAX) exit(92);
    owner->weak->owners++;
    return owner->weak;
}
void reference_release_weak(ReferenceWeak weak) {
    if (!weak->owners) exit(92);
    if (--weak->owners == 0) {
#if REFERENCE_DIAGNOSTIC == 1
        metadata--;
#endif
        free(weak);
    }
}
void reference_release_owner(ReferenceOwner owner) {
    if (!owner->strong) exit(92);
    if (--owner->strong == 0) {
        if (owner->weak) {
            owner->weak->target = NULL;
            reference_release_weak(owner->weak);
        }
#if REFERENCE_DIAGNOSTIC == 1
        targets--;
#endif
        free(owner);
    }
}
int reference_lookup(ReferenceWeak weak) {
    ReferenceOwner acquired = weak->target;
    if (!acquired) return 0;
    if (!acquired->strong || acquired->strong == SIZE_MAX) exit(92);
    acquired->strong++;
    reference_release_owner(acquired);
    return 1;
}
