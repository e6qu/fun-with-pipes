/* Count actual owner operations, then independently check physical release.
 * The scalar deliberately contains an allocation address: its bits are not an
 * owner. A shared pair leaves its children untouched on numeric projection. */
static void projection_release_leaf(V value) {
    if (!fwp_rc_release_last(value)) exit(241);
    fwp_mem_free((void *)(uintptr_t)value);
}
int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    fwp_budget = INT32_MAX;
    size_t baseline = fwp_heap.live;
    for (int shared = 0; shared < 2; shared++) {
        for (int text = 0; text < 2; text++) {
            V left = fwp_rc_fresh(fwp_cstr("left"));
            V right = fwp_rc_fresh(fwp_cstr("right"));
            V scalar = fwp_rc_fresh(fwp_cstr("scalar bits"));
            V box = fwp_rc_fresh(fwp_record(3, (V[]){left, scalar, right}));
            if (shared) fwp_rc_dup(box);
            projection_dups = 0;
            projection_active = 1;
            V result = text ? @text@(box) : @numeric@(box);
            /* extra-owner-control */
            projection_active = 0;
            if (result != (text ? left : scalar)) return 242;
            if (!text && projection_dups) return 243;
            if (*fwp_rc_slot(scalar) != 1) return 244;
            if (shared) {
                if (*fwp_rc_slot(box) != 1 || *fwp_rc_slot(right) != 1
                    || *fwp_rc_slot(left) != (text ? 2 : 1)) return 245;
                fwp_rc_free_obj(box);
                if (text) fwp_rc_drop(left);
                else projection_release_leaf(left);
                projection_release_leaf(right);
            }
            if (text) {
                if (*fwp_rc_slot(left) != 1 || STR(left)->len != 4
                    || memcmp(STR(left)->d, "left", 4)) return 246;
                projection_release_leaf(left);
            }
            projection_release_leaf(scalar);
            if (fwp_heap.live != baseline) return 247;
        }
    }
    /* Interrupt at the real entry tick, before any field read. This exercises
     * the same pending-owner cleanup used when task preemption fails. */
    V left = fwp_rc_fresh(fwp_cstr("left"));
    V right = fwp_rc_fresh(fwp_cstr("right"));
    V box = fwp_rc_fresh(fwp_record(3, (V[]){left, 37, right}));
    fwp_handler handler;
    handler.prev = fwp_handlers; handler.state_depth = fwp_state_len;
    handler.cleanup = fwp_cleanups; fwp_handlers = &handler;
    projection_fail = 1;
    if (!setjmp(handler.jb)) { @numeric@(box); return 248; }
    projection_fail = 0;
    fwp_handlers = handler.prev;
    if (fwp_cleanups != handler.cleanup || fwp_heap.live != baseline) return 249;
    return 0;
}
