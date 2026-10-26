/* Keep one live slot per page while reclaiming its neighbors. */
static uintptr_t pressure_slots[FWP_STATIC_HEAP / 16];
static void static_heap_pressure_probe(void) {
    const char *kind = getenv("FWP_STATIC_PROBE");
    size_t pages = FWP_STATIC_HEAP / HEAP_CHUNK;
    if (!kind || fwp_heap.nchunks != pages || fwp_heap.top) exit(41);
    if (!strcmp(kind, "slots")) {
        size_t slots = FWP_STATIC_HEAP / 16;
        for (size_t i = 0; i < slots; i++) {
            pressure_slots[i] = (uintptr_t)fwp_alloc_leaf(16);
            *(uint64_t *)pressure_slots[i] = i + 1;
        }
        for (size_t i = 0; i < slots; i++)
            if (i % (HEAP_CHUNK / 16)) fwp_mem_free((void *)pressure_slots[i]);
        if (fwp_heap.live != pages * 16) exit(43);
        for (size_t i = 0; i < slots; i++) {
            if (!(i % (HEAP_CHUNK / 16))) {
                if (*(uint64_t *)pressure_slots[i] != i + 1) exit(46);
                continue;
            }
            unsigned char *p = fwp_alloc_leaf(16);
            for (size_t j = 0; j < 16; j++) if (p[j]) exit(45);
            pressure_slots[i] = (uintptr_t)p;
        }
        if (fwp_heap.top != pages || fwp_heap.live != FWP_STATIC_HEAP) exit(44);
        for (size_t i = 0; i < slots; i++) fwp_mem_free((void *)pressure_slots[i]);
    } else if (!strcmp(kind, "pages") || !strcmp(kind, "exhausted")) {
        for (size_t i = 0; i < pages; i++) pressure_slots[i] = (uintptr_t)fwp_alloc_leaf(HEAP_CHUNK);
        if (!strcmp(kind, "pages"))
            for (size_t i = 0; i < pages; i++) fwp_mem_free((void *)pressure_slots[i]);
        unsigned char *p = fwp_alloc_leaf(2 * HEAP_CHUNK);
        if (fwp_heap.top != pages) exit(47);
        for (size_t i = 0; i < 2 * HEAP_CHUNK; i++) if (p[i]) exit(48);
        fwp_mem_free(p);
    } else { exit(49); }
    if (fwp_heap.live) exit(50);
    exit(0);
}
