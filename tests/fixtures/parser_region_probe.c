/* Exercise the actual block allocator with injected allocation failures. This
 * probe alone does not establish that generated parser links are count-free. */
static size_t region_allocations, region_fail_at;
static void *region_probe_allocate(size_t bytes) {
    if (++region_allocations == region_fail_at) fwp_fail(0, NULL);
    return fwp_alloc_unique(bytes);
}
#define fwp_alloc_unique region_probe_allocate
@region_runtime@
#undef fwp_alloc_unique

static int region_fill(size_t count) {
    fwp_region region = {NULL};
    fwp_cleanup cleanup;
    fwp_cleanup_push(&cleanup, fwp_region_release, &region);
    V last = 0;
    for (size_t index = 0; index < count; index++) {
        V value = fwp_region_data(PTR(&region), 1, 2, (V[]){(V)index, last});
        if (value % 8 || fwp_rc_slot(value) != NULL) return 241;
        last = value;
    }
    /* A nested region cannot overwrite or release its caller's nodes. */
    if (count) {
        int result = region_fill(0);
        if (result) return result;
        fwp_region inner = {NULL};
        fwp_cleanup inner_cleanup;
        fwp_cleanup_push(&inner_cleanup, fwp_region_release, &inner);
        V child = fwp_region_data(PTR(&inner), 0, 1, (V[]){UINT64_MAX});
        if (OBJ(child)->f[0] != UINT64_MAX) return 242;
        fwp_cleanup_pop(&inner_cleanup);
        fwp_region_release(&inner);
    }
    for (size_t index = count; index; index--) {
        if (!last || fwp_tag(last) != 1 || OBJ(last)->f[0] != index - 1) return 243;
        last = OBJ(last)->f[1];
    }
    if (last) return 243;
    fwp_cleanup_pop(&cleanup);
    fwp_region_release(&region);
    if (region.blocks) return 244;
    /* Releasing an empty owner must be harmless. */
    fwp_region_release(&region);
    return 0;
}

static int region_case(size_t count, size_t fail_at, size_t expected_allocations) {
    size_t baseline = fwp_heap.live;
    fwp_handler handler;
    handler.prev = fwp_handlers; handler.state_depth = fwp_state_len;
    handler.cleanup = fwp_cleanups; fwp_handlers = &handler;
    region_allocations = 0; region_fail_at = fail_at;
    if (!setjmp(handler.jb)) {
        int result = region_fill(count);
        if (result) return result;
        if (fail_at || region_allocations != expected_allocations) return 245;
    } else {
        if (!fail_at || region_allocations != fail_at) return 246;
    }
    fwp_handlers = handler.prev;
    if (fwp_cleanups != handler.cleanup) return 247;
    if (fwp_heap.live != baseline) return 248;
    return 0;
}

/* An oversized node gets exact storage, then the next small node resumes the
 * capped policy. Fail each allocation and preserve the existing owner chain. */
static int region_large_case(size_t failure) {
    size_t baseline = fwp_heap.live;
    fwp_handler handler = {0};
    handler.prev = fwp_handlers; handler.state_depth = fwp_state_len;
    handler.cleanup = fwp_cleanups; fwp_handlers = &handler;
    region_allocations = 0; region_fail_at = failure;
    if (!setjmp(handler.jb)) {
        fwp_region region = {NULL}; fwp_cleanup cleanup;
        fwp_cleanup_push(&cleanup, fwp_region_release, &region);
        V fields[600];
        for (size_t i = 0; i < 600; i++) fields[i] = i;
        V large = fwp_region_data(PTR(&region), 7, 600, fields);
        if (region.blocks->capacity != sizeof(fwp_obj) + sizeof fields) return 249;
        V small = fwp_region_data(PTR(&region), 0, 1, (V[]){42});
        if (region.blocks->capacity != 4096 || region_allocations != 2) return 249;
        if (OBJ(small)->f[0] != 42 || large % 8 || fwp_rc_slot(large)) return 249;
        for (size_t i = 0; i < 600; i++) if (OBJ(large)->f[i] != i) return 249;
        fwp_cleanup_pop(&cleanup); fwp_region_release(&region);
        if (failure) return 245;
    } else if (!failure || region_allocations != failure) return 246;
    fwp_handlers = handler.prev;
    if (fwp_cleanups != handler.cleanup || fwp_heap.live != baseline) return 248;
    return 0;
}

int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    /* 24-byte nodes: block boundaries are 10, 31, 73 and 158 nodes.
     * Include the independently owned inner node in each nonempty count. */
    const size_t counts[] = {0, 1, 10, 11, 31, 32, 73, 74, 158, 159, 257, 8193};
    const size_t allocations[] = {0, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 53};
    for (size_t c = 0; c < sizeof counts / sizeof counts[0]; c++) {
        size_t count = counts[c];
        size_t expected = allocations[c];
        for (size_t repeat = 0; repeat < 3; repeat++) {
            int result = region_case(count, 0, expected);
            if (result) return result;
        }
        for (size_t failure = 1; failure <= expected; failure++) {
            int result = region_case(count, failure, expected);
            if (result) return result;
        }
    }
    for (size_t failure = 0; failure <= 2; failure++) {
        int result = region_large_case(failure);
        if (result) return result;
    }
    return fwp_heap.live == baseline ? 0 : 248;
}
