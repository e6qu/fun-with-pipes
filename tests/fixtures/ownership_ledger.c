/* Test-only native ARC allocation ledger. Capacity is supplied by the test.
 * Removing an entry retains neither the allocation nor a tombstone. This checks
 * allocator events, not all reads through borrowed pointers or address reuse. */
#define OWNER_LEDGER_CAPACITY @CAPACITY@
static uintptr_t owner_ledger_slots[OWNER_LEDGER_CAPACITY];
static size_t owner_ledger_live;
static size_t owner_ledger_allocations;
static size_t owner_ledger_releases;

static void owner_ledger_error(int status, const char *message) {
    fprintf(stderr, "ownership ledger: %s\n", message);
    _Exit(status);
}
static size_t owner_ledger_hash(uintptr_t pointer) {
    return (size_t)((pointer >> 4) * (uintptr_t)2654435761U) & (OWNER_LEDGER_CAPACITY - 1);
}
static size_t owner_ledger_find(uintptr_t pointer) {
    size_t slot = owner_ledger_hash(pointer);
    while (owner_ledger_slots[slot] && owner_ledger_slots[slot] != pointer)
        slot = (slot + 1) & (OWNER_LEDGER_CAPACITY - 1);
    return slot;
}
static void owner_ledger_alloc(void *allocation) {
    uintptr_t pointer = (uintptr_t)allocation;
    if (!pointer) owner_ledger_error(200, "allocator returned a null address");
    size_t slot = owner_ledger_find(pointer);
    if (owner_ledger_slots[slot])
        owner_ledger_error(201, "allocator returned an address that is still live");
    /* Keep an empty slot so every search terminates. Exceeding this explicit
     * test bound fails; it never disables observation or grows hidden storage. */
    if (owner_ledger_live == OWNER_LEDGER_CAPACITY - 1)
        owner_ledger_error(206, "explicit live-allocation capacity exceeded");
    owner_ledger_slots[slot] = pointer;
    owner_ledger_live++;
    owner_ledger_allocations++;
}
static void owner_ledger_free(void *allocation) {
    if (!allocation) return;
    uintptr_t pointer = (uintptr_t)allocation;
    size_t slot = owner_ledger_find(pointer);
    if (!owner_ledger_slots[slot])
        owner_ledger_error(202, "free of a dead, interior or unregistered address");
    owner_ledger_slots[slot] = 0;
    owner_ledger_live--;
    owner_ledger_releases++;
    /* Reinsert the following cluster: deleting its first member must not hide
     * other live allocations. No tombstones accumulate over long executions. */
    size_t next = (slot + 1) & (OWNER_LEDGER_CAPACITY - 1);
    while (owner_ledger_slots[next]) {
        uintptr_t moved = owner_ledger_slots[next];
        owner_ledger_slots[next] = 0;
        owner_ledger_slots[owner_ledger_find(moved)] = moved;
        next = (next + 1) & (OWNER_LEDGER_CAPACITY - 1);
    }
}
static void owner_ledger_finish(void) {
    if (owner_ledger_live || owner_ledger_allocations != owner_ledger_releases)
        owner_ledger_error(205, "live allocations remain after ownership cleanup");
}
