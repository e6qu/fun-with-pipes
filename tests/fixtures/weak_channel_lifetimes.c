/* Runs in the emitted production runtime. Inspect expiration before any
 * deliberately stale target could be dereferenced by a faulty implementation. */
static unsigned weak_child_drops;
static jmp_buf weak_recovered;
static int weak_recover(void) { return 1; }

static int failed_allocations(void) {
    intptr_t baseline = fwp_gc.budget;
    size_t live = owner_ledger_live;
    V channel = fwp_p_channel_make_owned(1, NULL);
    fail_weak_allocation = 1;
    fwp_trap_recover = weak_recover;
    fwp_trap_jb = &weak_recovered;
    fwp_trap_cleanup = 0;
    if (setjmp(weak_recovered) == 0) { fwp_p_channel_downgrade(channel); return 232; }
    if (((fwp_chan *)(uintptr_t)channel)->weak || *fwp_rc_slot(channel) != 1) return 233;
    V weak = fwp_p_channel_downgrade(channel);
    intptr_t before = fwp_gc.budget;
    size_t owners = owner_ledger_live;
    fail_weak_allocation = 2;
    if (setjmp(weak_recovered) == 0) { fwp_p_channel_upgrade(weak); return 234; }
    if (*fwp_rc_slot(channel) != 1) return 231;
    if (fwp_gc.budget != before || owner_ledger_live != owners || fwp_cleanups) return 235;
    fwp_trap_recover = 0;
    fwp_trap_jb = 0;
    fwp_channel_drop(channel);
    fwp_weak_channel_drop(weak);
    if (fwp_gc.budget != baseline || owner_ledger_live != live) return 222;
    return 0;
}

static void weak_child_drop(V weak) {
    if (((fwp_weak_channel *)(uintptr_t)weak)->target) exit(221);
    if (fwp_p_channel_upgrade(weak) != FWP_NONE) exit(223);
    weak_child_drops++;
    fwp_weak_channel_drop(weak);
}

static void channel_option_drop(V option) {
    if (option == FWP_NONE) return;
    fwp_channel_drop(OBJ(option)->f[0]);
    fwp_rc_free_obj(option);
}

int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns = fwp_fn_table;
    fwp_init_consts();
    fwp_tasks_init();
    int failure = failed_allocations();
    if (failure) return failure;
    intptr_t baseline = fwp_gc.budget;
    size_t live = owner_ledger_live;
    unsigned reused = 0;
    for (unsigned round = 0; round < 1024; round++) {
        V channel = fwp_p_channel_make_owned(1, weak_child_drop);
        V weak = fwp_p_channel_downgrade(channel);
        V queued = fwp_p_channel_downgrade(channel);
        if (weak != queued) return 224; /* one control object per channel */
        if (fwp_p_channel_send_owned(channel, queued, weak_child_drop) != FWP_TRUE) return 225;
        V acquired = fwp_p_channel_upgrade(weak);
        if (acquired == FWP_NONE || OBJ(acquired)->f[0] != channel) return 226;
        fwp_p_channel_close(channel);
        fwp_channel_drop(channel); /* the acquired owner keeps the closed queue alive */
        V second = fwp_p_channel_upgrade(weak);
        if (second == FWP_NONE) return 227;
        channel_option_drop(second);
        channel_option_drop(acquired); /* expires before destroying the queued weak value */
        if (weak_child_drops != round + 1) return 228;
        if (((fwp_weak_channel *)(uintptr_t)weak)->target) return 221;

        V replacement = fwp_p_channel_make_owned(1, NULL);
        if (replacement == channel) reused++;
        if (fwp_p_channel_upgrade(weak) != FWP_NONE) return 229;
        fwp_channel_drop(replacement);
        fwp_weak_channel_drop(weak);
        if (fwp_gc.budget != baseline || owner_ledger_live != live) return 222;
    }
    if (!reused) return 230; /* actually exercise allocator address reuse */
    return 0;
}
