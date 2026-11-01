/* Appended to generated C, keeping ordinary runtime startup and teardown. */
int returned_storage_clean(void) {
    return fwp_heap.live == callable_baseline && !fwp_cleanups &&
        !fwp_state_len && !fwp_state_owners;
}

V returned_make(int32_t kind, int64_t capture) {
    switch (kind) {
    case 0: return PARTIAL_MAKE;
    case 1: return CAPTURED_MAKE;
    default: fputs("invalid callable kind\n", stderr); exit(71);
    }
}

int64_t returned_direct(int32_t kind, int64_t capture, int64_t input) {
    switch (kind) {
    case 0: return (int64_t)PARTIAL_DIRECT;
    case 1: return (int64_t)CAPTURED_DIRECT;
    default: fputs("invalid callable kind\n", stderr); exit(71);
    }
}

static void returned_owner_drop(void *arg) {
    V *owner = arg;
    V value = *owner;
    *owner = 0;
    if (value) fwp_closure_drop(value);
}

/* Failure injection uses the runtime's real nonlocal cleanup, then retries in
 * the same initialized runtime. No changed automatic value is read after jump. */
int returned_recovery(int32_t kind, int32_t completed) {
    fwp_handler handler = {0};
    handler.prev = fwp_handlers;
    handler.state_depth = fwp_state_len;
    handler.cleanup = fwp_cleanups;
    fwp_handlers = &handler;
    if (!setjmp(handler.jb)) {
        V owner = returned_make(kind, 7);
        fwp_cleanup cleanup;
        fwp_cleanup_push(&cleanup, returned_owner_drop, &owner);
        for (int32_t x = 0; x < completed; x++) {
            V input = (V)x;
            if ((int64_t)fwp_apply_borrowed(owner, 1, &input) != (kind + 1) * (7 + x)) abort();
        }
        fwp_fail(0, NULL);
        abort();
    }
    fwp_handlers = handler.prev;
    fwp_state_restore(handler.state_depth);
    if (handler.value || handler.desc || !returned_storage_clean()) return 79;
    V retry = returned_make(kind, 7), input = 3;
    int64_t result = (int64_t)fwp_apply_borrowed(retry, 1, &input);
    fwp_closure_drop(retry);
    return result == (kind + 1) * 10 && returned_storage_clean() ? 0 : 79;
}
