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

int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    const size_t counts[] = {0, 1, 257, 8193};
    for (size_t c = 0; c < sizeof counts / sizeof counts[0]; c++) {
        size_t count = counts[c];
        size_t per_block = 4096 / (sizeof(fwp_obj) + 2 * sizeof(V));
        size_t expected = count ? (count + per_block - 1) / per_block + 1 : 0;
        for (size_t repeat = 0; repeat < 3; repeat++) {
            int result = region_case(count, 0, expected);
            if (result) return result;
        }
        for (size_t failure = 1; failure <= expected; failure++) {
            int result = region_case(count, failure, expected);
            if (result) return result;
        }
    }
    return fwp_heap.live == baseline ? 0 : 248;
}
