/* Serial registration semantics, not a timing or allocation benchmark. */
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct { int calls, destroyed, metadata; } Counts;
typedef struct { int identity; Counts *counts; } Target;
typedef struct { unsigned strong, weak; Target *target; Counts *counts; } Weak;

static void require(bool condition) {
    if (!condition) { fputs("lifetime check failed\n", stderr); exit(79); }
}

static Weak *create(Counts *counts, int identity) {
    Weak *control = malloc(sizeof(*control));
    require(control != NULL);
    Target *target = malloc(sizeof(*target));
    require(target != NULL);
    *target = (Target){identity, counts};
    /* The live target owns one implicit weak metadata reference. */
    *control = (Weak){1, 1, target, counts};
    counts->metadata++;
    return control;
}

static void release_weak(Weak **slot) {
    Weak *control = *slot;
    *slot = NULL;
    require(control != NULL && control->weak > 0);
    if (--control->weak == 0) {
        control->counts->metadata--;
        free(control);
    }
}

static Weak *downgrade(Weak *owner) {
    require(owner != NULL && owner->target != NULL);
    owner->weak++;
    return owner;
}

static Weak *upgrade(Weak *weak) {
    if (!weak || !weak->target) return NULL;
    require(weak->strong > 0);
    weak->strong++;
    return weak;
}

static void release_owner(Weak **slot) {
    Weak *owner = *slot;
    *slot = NULL;
    require(owner != NULL && owner->strong > 0);
    if (--owner->strong == 0) {
        Target *target = owner->target;
        owner->target = NULL;
        target->counts->destroyed++;
        free(target);
        release_weak(&owner);
    }
}

static bool dispatch(Weak *weak, bool *cancelled, Weak **outside, Counts *counts) {
    if (*cancelled) return false;
    Weak *active = upgrade(weak);
    if (!active) return false;
    counts->calls++;
    require(active->target->identity == 7);
    *cancelled = true;
    release_owner(outside);
    require(counts->destroyed == 0);
    /* A cancelled nested dispatch does not enter the callback. */
    require(!dispatch(weak, cancelled, outside, counts));
    Weak *nested = upgrade(weak);
    require(nested != NULL && nested->target->identity == 7);
    release_owner(&nested);
    require(counts->destroyed == 0);
    release_owner(&active);
    return true;
}

int main(int argc, char **argv) {
    (void)argv;
    if (argc != 1) { fputs("expected no arguments\n", stderr); return 2; }
    Counts counts = {0, 0, 0};
    require(upgrade(NULL) == NULL);
    Weak *owner = create(&counts, 7);
    Weak *weak = downgrade(owner);
    bool cancelled = true;
    require(!dispatch(weak, &cancelled, &owner, &counts));
    require(counts.calls == 0 && counts.destroyed == 0);
    cancelled = false;
    require(dispatch(weak, &cancelled, &owner, &counts));
    require(owner == NULL && counts.calls == 1 && counts.destroyed == 1);
    require(!dispatch(weak, &cancelled, &owner, &counts));
    cancelled = false;
    require(!dispatch(weak, &cancelled, &owner, &counts));
    require(upgrade(weak) == NULL && counts.metadata == 1);
    /* Repeated new targets must not revive an expired registration. */
    for (int identity = 0; identity < 64; identity++) {
        Weak *replacement = create(&counts, identity);
        require(upgrade(weak) == NULL);
        release_owner(&replacement);
    }
    require(counts.destroyed == 65 && counts.metadata == 1);
    release_weak(&weak);
    require(counts.metadata == 0);
    puts("calls=1 destroyed=65 expired=1 cancelled=1");
    return 0;
}
