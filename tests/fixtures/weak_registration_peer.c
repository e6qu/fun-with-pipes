/* Serial registration semantics, not a timing or allocation benchmark. */
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

typedef struct { int calls, destroyed, metadata, disposed; } Counts;
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

/* A failing callback still owns its target until dispatch returns the error. */
static int callback_error(Weak *acquired, Weak **outside, Counts *counts) {
    require(acquired->target->identity == 9);
    counts->calls++;
    release_owner(outside);
    require(counts->destroyed == 65 && acquired->target->identity == 9);
    return -1;
}

static int dispatch_error(Weak *weak, Weak **outside, Counts *counts) {
    Weak *acquired = upgrade(weak);
    if (!acquired) return 0;
    int result = callback_error(acquired, outside, counts);
    release_owner(&acquired);
    return result;
}

typedef struct { int value; Counts *counts; } Payload;
typedef struct { Weak *target; Payload *payload; } Pending;

static Pending enqueue(Weak *owner, Counts *counts) {
    Payload *payload = malloc(sizeof(*payload));
    require(payload != NULL);
    *payload = (Payload){11, counts};
    return (Pending){downgrade(owner), payload};
}

static void dispose_payload(Payload **slot) {
    Payload *payload = *slot;
    require(payload != NULL && payload->value == 11);
    payload->counts->disposed++;
    free(payload);
    *slot = NULL;
}

static void dispose_pending(Pending *entry) {
    require(entry->target != NULL && entry->payload != NULL);
    release_weak(&entry->target);
    dispose_payload(&entry->payload);
}

static int queued_dispatch(Pending *entry, Weak **outside, Counts *counts) {
    Weak *held = upgrade(entry->target);
    if (!held) return 0;
    counts->calls++;
    require(held->target->identity == 17 && entry->payload->value == 11);
    release_owner(outside);
    require(counts->destroyed == 0 && held->target->identity == 17);
    release_owner(&held);
    return -1;
}

static int drain_queue(Pending queue[2], Weak **outside, Counts *counts) {
    for (size_t index = 0; index < 2; index++) {
        if (!queue[index].target) continue; /* Slot removed by cancellation. */
        int result = queued_dispatch(&queue[index], outside, counts);
        dispose_pending(&queue[index]);
        if (result == -1) {
            for (size_t remaining = index + 1; remaining < 2; remaining++) {
                if (queue[remaining].target) dispose_pending(&queue[remaining]);
            }
            return result;
        }
    }
    return 0;
}

static void queued_checks(void) {
    Counts counts = {0, 0, 0, 0};
    Weak *owner = create(&counts, 17);
    Pending queue[2] = {enqueue(owner, &counts), enqueue(owner, &counts)};
    dispose_pending(&queue[0]); /* Cancel and release a queued payload before entry. */
    require(counts.disposed == 1 && counts.destroyed == 0);
    release_owner(&owner);
    require(counts.destroyed == 1); /* The remaining queued weak link owns no target. */
    require(drain_queue(queue, &owner, &counts) == 0);
    require(counts.calls == 0 && counts.disposed == 2 && counts.metadata == 0);

    counts = (Counts){0, 0, 0, 0};
    owner = create(&counts, 17);
    queue[0] = enqueue(owner, &counts);
    queue[1] = enqueue(owner, &counts);
    require(drain_queue(queue, &owner, &counts) == -1);
    require(owner == NULL && counts.calls == 1 && counts.destroyed == 1);
    require(counts.disposed == 2 && counts.metadata == 0);
}

int main(int argc, char **argv) {
    (void)argv;
    if (argc != 1) { fputs("expected no arguments\n", stderr); return 2; }
    Counts counts = {0, 0, 0, 0};
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
    owner = create(&counts, 9);
    weak = downgrade(owner);
    require(dispatch_error(weak, &owner, &counts) == -1);
    require(owner == NULL && counts.calls == 2 && counts.destroyed == 66);
    require(upgrade(weak) == NULL && counts.metadata == 1);
    require(dispatch_error(weak, &owner, &counts) == 0);
    require(counts.calls == 2);
    release_weak(&weak);
    require(counts.metadata == 0);
    queued_checks();
    puts("calls=2 destroyed=66 expired=1 cancelled=1 error=1 queue=1");
    return 0;
}
