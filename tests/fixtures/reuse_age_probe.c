/* Collect real small/large immutable/mutable objects; no synthetic age bits. */
static V reuse_age_owners[4];

int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    for (size_t i = 0; i < 4; i++) {
        size_t size = i & 1 ? GC_MAX_SMALL + 32 : 128;
        fwp_obj *object = i < 2 ? fwp_alloc_init(size) : fwp_alloc(size);
        memset(object, 0, size);
        object->n = (uint32_t)((size - sizeof(fwp_obj)) / sizeof(V));
        V value = fwp_rc_fresh(PTR(object));
        reuse_age_owners[i] = value;
        int unique = fwp_rc_unique(value);
        if (unique != (fwp_reuse_verify ? 2 : 1) || !fwp_rc_young(value)) return 240;
        fwp_rc_dup(value);
        if (fwp_rc_unique(value) || fwp_rc_unique_mut(value)) return 241;
        if (fwp_rc_release_last(value)) return 242;
        if (fwp_rc_unique(value) != unique) return 243;
    }
    fwp_gc_collect();
    for (size_t i = 0; i < 4; i++) {
        V value = reuse_age_owners[i];
        size_t chunk = ((uintptr_t)value - (uintptr_t)fwp_gc.base) >> GC_SHIFT;
        gc_chunk *meta = &fwp_gc.meta[chunk];
        if ((meta->type == GC_BIG) != (int)(i & 1)) return 244;
        if (fwp_rc_unique(value)) return 239;
        if (fwp_rc_young(value)) return 238;
        /* Mutable arrays are rescanned, so their age must not block reuse. */
        if (i >= 2 && fwp_rc_unique_mut(value) != (fwp_reuse_verify ? 2 : 1)) return 237;
        if (!fwp_rc_release_last(value)) return 236;
        fwp_rc_free_obj(value);
        reuse_age_owners[i] = 0;
    }
    return 0;
}
