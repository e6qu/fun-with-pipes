/* Diagnostic-only ledger: requested payload bytes, not allocator slot capacity.
 * Fixed observation storage is outside the measured runtime allocator. */
static int callable_active;
static struct {
    uint64_t requests, bytes, frees, retains, releases, applications, peak;
} callable_counts;
static struct { void *address; size_t bytes; } callable_allocations[64];
static size_t callable_live;

static void callable_allocated(void *address, size_t bytes) {
    if (!callable_active) return;
    size_t empty = 64;
    for (size_t i = 0; i < 64; i++) {
        if (callable_allocations[i].address == address) abort();
        if (!callable_allocations[i].address) empty = i;
    }
    if (!address || empty == 64 || bytes > SIZE_MAX - callable_live) abort();
    callable_allocations[empty].address = address;
    callable_allocations[empty].bytes = bytes;
    callable_live += bytes;
    callable_counts.requests++;
    callable_counts.bytes += bytes;
    if (callable_live > callable_counts.peak) callable_counts.peak = callable_live;
}

static void callable_freed(void *address) {
    if (!address) return;
    for (size_t i = 0; i < 64; i++) {
        if (callable_allocations[i].address != address) continue;
        if (!callable_active || callable_allocations[i].bytes > callable_live) abort();
        callable_live -= callable_allocations[i].bytes;
        callable_allocations[i].address = NULL;
        callable_allocations[i].bytes = 0;
        callable_counts.frees++;
        return;
    }
    /* Pre-existing startup storage is outside this ledger. */
}
