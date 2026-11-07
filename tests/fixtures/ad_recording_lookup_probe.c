static jmp_buf recording_recovered;
static int recording_recover(void) { return 1; }
static fwp_tape_scope recording_scope = {-1};
static fwp_cleanup recording_scope_owner;

static int recording_trap(V a, V b, const char *message, unsigned lookups) {
    fwp_trap_recover = recording_recover;
    fwp_trap_jb = &recording_recovered;
    recording_lookup_calls = 0;
    int result;
    if (!setjmp(recording_recovered)) {
        f1(a, fwp_from_f64(0.5), b, fwp_from_f64(0.5));
        result = 62;
    } else if (strcmp(fwp_trap_msg, message)) result = 63;
    else if (recording_lookup_calls != lookups) result = 64;
    else result = 0;
    /* Recovery is valid only while this setjmp frame remains active. */
    fwp_trap_recover = NULL;
    fwp_trap_jb = NULL;
    return result;
}

int main(void) {
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    fwp_cleanup_push(&recording_scope_owner, fwp_tape_scope_release, &recording_scope);
    fwp_trap_cleanup = &recording_scope_owner;

    V first = fwp_p_ad_tape(2);
    V second = fwp_p_ad_tape(2); /* Registry growth precedes the local state. */
    V half = fwp_from_f64(0.5);
    recording_lookup_calls = 0;
    V node = first;
    for (unsigned i = 0; i < 100; i++) node = f1(node, half, node, half);
    if (recording_lookup_calls != 100 * EXPECTED_LOOKUPS) return 61;
    fwp_tape *t = fwp_tape_of((int64_t)first >> 32);
    if (t->len != 202 || t->cap < 200) return 65;
    for (unsigned i = 0; i < 200; i++) {
        if (fwp_from_f64(t->ops[i].da) != half || fwp_from_f64(t->ops[i].db) != half) return 66;
    }
    V result = fwp_rc_fresh(fwp_p_ad_backward_one(first, node, fwp_from_f64(1.0)));
    if (ARR(result)->len != 2 || fwp_f64(ARR(result)->d[0]) != 1.0
        || fwp_f64(ARR(result)->d[1]) != 0.0) return 67;
    fwp_rc_free_arr(result);
    int code = recording_trap(first, first, FWP_AD_OUTSIDE, 1);
    if (code) return code;
    code = recording_trap(first, second, FWP_AD_MIXED, 0);
    if (code) return code;
    code = recording_trap(0, 0, FWP_AD_OUTSIDE, 1); /* Initial cache ID must not be zero. */
    if (code) return code;
    code = recording_trap(second + 2, second, FWP_AD_INVALID_NODE, 1);
    if (code) return code;
    t = fwp_tape_of((int64_t)second >> 32);
    t->len = fwp_tape_limit();
    code = recording_trap(second + (V)fwp_tape_limit(), second, "autodiff: the tape is full", 1);
    t->len = 2;
    if (code) return code;
    fwp_owned_tape typed = {0};
    t->owned = &typed;
    code = recording_trap(second, second, FWP_AD_REPRESENTATION, 1);
    t->owned = NULL;
    if (code) return code;

    /* A fresh worker invocation must revalidate a slot reused after retirement. */
    V reused = fwp_p_ad_tape(2);
    recording_lookup_calls = 0;
    if (f1(reused, half, reused, half) != reused + 3
        || recording_lookup_calls != EXPECTED_LOOKUPS) return 68;
    recording_lookup_calls = 0;
    if (f1((V)-1, half, (V)-1, half) != (V)-1 || recording_lookup_calls) return 69;

    /* Switching between live IDs validates each newly selected tape. No registry
     * or lifecycle operation occurs while this explicit local state is live. */
    fwp_ad_recording state = {-1, NULL};
    recording_lookup_calls = 0;
    fwp_p_ad_push(second, half, (V)-1, half, &state);
    fwp_p_ad_push(reused, half, (V)-1, half, &state);
    fwp_p_ad_push(second, half, (V)-1, half, &state);
    if (recording_lookup_calls != 3) return 70;
    static const V bits[] = {0x8000000000000000ULL, 0x7ff8000000000042ULL, 0x7ff0000000000042ULL};
    for (size_t i = 0; i < sizeof bits / sizeof bits[0]; i++) {
        node = fwp_p_ad_push(second, bits[i], second, bits[i], &state);
        t = state.tape;
        size_t op = (size_t)((node & 0xffffffff) - t->leaves);
        if (fwp_from_f64(t->ops[op].da) != bits[i] || fwp_from_f64(t->ops[op].db) != bits[i]) return 71;
    }

    /* Trap after an append: unwind past the worker and retire every scoped tape. */
    recording_fail_after_append = 1;
    fwp_trap_cleanup = recording_scope_owner.prev;
    fwp_trap_recover = recording_recover;
    fwp_trap_jb = &recording_recovered;
    if (!setjmp(recording_recovered)) { f1(second, half, second, half); return 72; }
    if (strcmp(fwp_trap_msg, "recording append control") || recording_scope.head != -1
        || fwp_cleanups) return 73;
    recording_fail_after_append = 0;
    fwp_trap_cleanup = NULL; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
    fwp_tape_finish(); fwp_caf_finish();
    if (fwp_tapes || fwp_ntapes || fwp_tapes_cap || fwp_tape_cached_bytes
        || fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 74;
    return 0;
}
