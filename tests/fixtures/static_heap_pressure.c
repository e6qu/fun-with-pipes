/* Keep one root per managed page, or age whole pages before dropping them.
 * Every choice is supplied by the harness; this is not a language entry point. */
static volatile uintptr_t pressure_roots[FWP_STATIC_HEAP / GC_CHUNK];

static void static_heap_pressure_probe(void) {
    const char *kind = getenv("FWP_STATIC_PROBE");
    size_t pages = sizeof pressure_roots / sizeof *pressure_roots;
    if (!kind || fwp_gc.nchunks != pages || fwp_gc.top || fwp_gc.ncollect) exit(41);
    if (!strcmp(kind, "slots")) {
        /* Fill every page with 16-byte leaves; keep its first leaf alive. */
        for (size_t i = 0; i < pages * GC_CHUNK / 16; ++i) {
            void *p = fwp_alloc_leaf(16);
            size_t page = ((uintptr_t)p - (uintptr_t)fwp_gc.base) >> GC_SHIFT;
            if (page >= pages) exit(42);
            if (!pressure_roots[page]) {
                pressure_roots[page] = (uintptr_t)p;
                *(uint64_t *)p = page + 1;
            }
        }
        if (fwp_gc.ncollect) exit(43);
        unsigned char *p = fwp_alloc_leaf(16);
        if (!fwp_gc.ncollect || fwp_gc.top != pages || fwp_gc.nfree_chunks) exit(44);
        for (size_t i = 0; i < 16; ++i) if (p[i]) exit(45);
        for (size_t i = 0; i < pages; ++i) {
            if (!fwp_gc_marked((void *)pressure_roots[i]) ||
                *(uint64_t *)pressure_roots[i] != i + 1) exit(46);
        }
    } else if (!strcmp(kind, "pages")) {
        /* A minor collection cannot reclaim these deliberately aged objects. */
        for (size_t i = 0; i < pages; ++i)
            pressure_roots[i] = (uintptr_t)fwp_alloc_leaf(GC_CHUNK);
        if (fwp_gc.armed) {
            fwp_gc.major_next = 1;
            fwp_gc_collect();
        }
        for (size_t i = 0; i < pages; ++i) pressure_roots[i] = 0;
        size_t before = fwp_gc.ncollect;
        unsigned char *p = fwp_alloc_leaf(2 * GC_CHUNK);
        if (fwp_gc.ncollect <= before || fwp_gc.top != pages) exit(47);
        for (size_t i = 0; i < 2 * GC_CHUNK; ++i) if (p[i]) exit(48);
    } else {
        exit(49);
    }
    exit(0);
}
