/* Faults are stopped by the ledger before a second free, stale count operation
 * or destructive shared reuse reaches the underlying runtime. */
static void run_owner_ledger_probe(void) {
    const char *mode = getenv("FWP_LEDGER_CASE");
    if (!mode) owner_ledger_error(208, "test case must be explicit");
    if (!strcmp(mode, "exercise")) {
        const char *rounds_text = getenv("FWP_LEDGER_ROUNDS");
        if (!rounds_text) owner_ledger_error(208, "round count must be explicit");
        int rounds = atoi(rounds_text);
        if (rounds != 8 && rounds != 1024) owner_ledger_error(208, "unexpected round count");
        for (int round = 0; round < rounds; round++) {
            size_t before = owner_ledger_live;
            for (size_t size = 0; size <= 20000; size += 20000) {
                void *record = fwp_alloc_init(size);
                void *filled = fwp_alloc(size);
                void *leaf = fwp_alloc_leaf(size);
                fwp_mem_free(filled);
                fwp_mem_free(record);
                fwp_mem_free(leaf);
            }
            /* Big allocations are chunk-aligned: these actual addresses have
             * the same bucket at this test's 64-entry table capacity. */
            void *collision[6];
            for (size_t i = 0; i < 6; i++) {
                collision[i] = fwp_alloc_leaf(20000);
                if (owner_ledger_hash((uintptr_t)collision[i]) !=
                    owner_ledger_hash((uintptr_t)collision[0]))
                    owner_ledger_error(208, "collision control did not collide");
            }
            const size_t order[] = {2, 0, 4, 1, 5, 3};
            for (size_t i = 0; i < 6; i++) fwp_mem_free(collision[order[i]]);
            /* A freed address can be used by a later allocation. */
            fwp_mem_free(fwp_alloc_init(24));
            if (owner_ledger_live != before)
                owner_ledger_error(208, "round did not restore its live allocation count");
        }
        /* Exercise a cluster crossing the table's end with opaque test keys.
         * They are never dereferenced or passed to the real allocator. */
        uintptr_t key = 4096;
        while (owner_ledger_hash(key) != OWNER_LEDGER_CAPACITY - 1) key += 16;
        void *wrapped[6];
        for (size_t i = 0; i < 6; i++) {
            wrapped[i] = (void *)(key + i * OWNER_LEDGER_CAPACITY * 16);
            owner_ledger_alloc(wrapped[i]);
        }
        const size_t wrapped_order[] = {2, 0, 4, 1, 5, 3};
        for (size_t i = 0; i < 6; i++) owner_ledger_free(wrapped[wrapped_order[i]]);
        if (owner_ledger_allocations < (size_t)rounds * 13)
            owner_ledger_error(208, "allocation paths were not observed");
        return;
    }
    void *pointer = fwp_alloc_init(24);
    if (!strcmp(mode, "missing-release")) return;
    if (!strcmp(mode, "duplicate-address")) {
        /* Simulate an allocator publishing the same live address twice. */
        owner_ledger_alloc(pointer);
    } else if (!strcmp(mode, "double-free")) {
        fwp_mem_free(pointer);
        fwp_mem_free(pointer);
    } else if (!strcmp(mode, "interior-free")) {
        fwp_mem_free((char *)pointer + 1);
    } else if (!strcmp(mode, "stale-dup")) {
        fwp_mem_free(pointer);
        fwp_rc_dup(PTR(pointer));
    } else if (!strcmp(mode, "stale-drop")) {
        fwp_mem_free(pointer);
        fwp_rc_drop(PTR(pointer));
    } else if (!strcmp(mode, "stale-last")) {
        fwp_mem_free(pointer);
        (void)fwp_rc_release_last(PTR(pointer));
    } else if (!strcmp(mode, "capacity")) {
        for (size_t i = 0; i < OWNER_LEDGER_CAPACITY; i++) (void)fwp_alloc_leaf(8);
    } else if (!strcmp(mode, "shared-object") || !strcmp(mode, "shared-array")) {
        V value = fwp_rc_fresh(PTR(pointer));
        fwp_rc_dup(value);
        int unique = !strcmp(mode, "shared-object") ? fwp_rc_unique(value) : fwp_rc_unique_mut(value);
        if (unique) owner_ledger_error(208, "shared allocation was selected for reuse");
        fwp_rc_drop(value);
        fwp_mem_free(pointer);
    } else if (!strcmp(mode, "physical-free")) {
        fwp_mem_free(pointer);
    } else {
        owner_ledger_error(208, "unknown test case");
    }
}
