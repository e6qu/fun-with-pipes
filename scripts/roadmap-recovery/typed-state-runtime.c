/* A run-state activation owns its typed value independently of the scanned
 * buffer. These records live on the task stack; switching tasks saves the head.
 * Legacy untyped activations keep the shared compatibility convention. */
static fwp_state_owner *fwp_state_current_owner(void) {
    fwp_state_owner *owner = fwp_state_owners;
    while (owner && owner->index + 1 != fwp_state_len) owner = owner->prev;
    return owner;
}

static void fwp_state_owner_release(void *arg) {
    fwp_state_owner *owner = arg;
    V value = owner->value;
    owner->value = 0;
    /* Unlink before dropping captures: a destructor can itself recover a trap. */
    fwp_state_owners = owner->prev;
    if (owner->index < fwp_state_len) fwp_state[owner->index] = 0;
    if (owner->drop && value) owner->drop(value);
}

static V fwp_p_get_owned(void (*duplicate)(V)) {
    V value = fwp_p_get();
    if (duplicate) duplicate(value);
    return value;
}

static void fwp_state_install_owned(fwp_state_owner *owner, V value) {
    V old = owner->value;
    /* Install the new owner before old-value destruction can unwind. */
    owner->value = value;
    fwp_state[owner->index] = value;
    if (owner->drop && old) owner->drop(old);
}

static V fwp_p_put_owned(V value, void (*duplicate)(V)) {
    if (!fwp_state_len) return FWP_UNIT;
    fwp_state_owner *owner = fwp_state_current_owner();
    if (owner) {
        if (owner->duplicate) owner->duplicate(value);
        fwp_state_install_owned(owner, value);
    } else {
        /* Only pointer-bearing monomorphic values enter the legacy fallback. */
        if (duplicate) fwp_rc_share(value);
        fwp_state[fwp_state_len - 1] = value;
    }
    return FWP_UNIT;
}

static V fwp_p_modify_owned(V function, void (*duplicate)(V), void (*drop)(V)) {
    V current = fwp_p_get();
    V result = fwp_apply_borrowed(function, 1, &current);
    fwp_state_owner *owner = fwp_state_current_owner();
    if (owner) fwp_state_install_owned(owner, result);
    else if (fwp_state_len) {
        if (duplicate) fwp_rc_share(result);
        fwp_state[fwp_state_len - 1] = result;
    } else if (drop && result) drop(result);
    FWP_KEEP_ALIVE(function);
    return FWP_UNIT;
}

static V fwp_p_run_state_owned(V initial, V function, V argument,
        void (*duplicate)(V), void (*drop_state)(V), void (*drop_result)(V)) {
    size_t depth = fwp_state_len;
    fwp_handler handler;
    handler.prev = fwp_handlers;
    handler.state_depth = depth;
    handler.cleanup = fwp_cleanups;
    fwp_state_owner owner = {fwp_state_owners, depth, 0, duplicate, drop_state};
    fwp_cleanup state_cleanup;
    /* A failed retain leaves the borrowed initial value with its caller. */
    if (duplicate) duplicate(initial);
    owner.value = initial;
    fwp_state_owners = &owner;
    fwp_cleanup_push(&state_cleanup, fwp_state_owner_release, &owner);
    fwp_state_push(initial);
    fwp_handlers = &handler;
    if (setjmp(handler.jb) == 0) {
        V result = fwp_apply_borrowed(function, 1, &argument);
        fwp_handlers = handler.prev;
        fwp_value_owner result_owner = {result, drop_result};
        fwp_cleanup result_cleanup;
        fwp_value_protect(&result_owner, &result_cleanup);
        V state = fwp_state_pop();
        /* Both values remain owned across result-box allocation. */
        V pair = fwp_rc_fresh(fwp_tuple2(result, state));
        fwp_value_finish(&result_owner, &result_cleanup);
        owner.value = 0;
        fwp_state_owners = owner.prev;
        fwp_cleanup_pop(&state_cleanup);
        FWP_KEEP_ALIVE(initial);
        FWP_KEEP_ALIVE(function);
        FWP_KEEP_ALIVE(argument);
        return pair;
    }
    /* Failure already unwound the typed owner before invalidating its frame. */
    fwp_handlers = handler.prev;
    fwp_state_restore(depth);
    fwp_fail(handler.value, handler.desc);
    return 0;
}
