/* Exercise actual scope constructors. A detached child reads their settings
 * only after the parent has returned, failed, trapped or been cancelled. */
static int stage, depth, entered, released, child_checked, cancelled, typed, trapped;
static int64_t parent_deadline;
static fwp_task *escaped;
static V metadata, duration, original_name, original_value;
static void *metadata_block;
static size_t metadata_bytes;
static int metadata_attempts, metadata_frees, fail_metadata;
static void *metadata_alloc(size_t bytes) {
    metadata_attempts++;
    if (fail_metadata) { fail_metadata = 0; fwp_trap("out of memory"); }
    if (metadata_block) _Exit(54);
    metadata_bytes = bytes;
    return metadata_block = fwp_alloc_leaf(bytes);
}
static void metadata_free(void *block) {
    if (block != metadata_block) _Exit(54);
    metadata_frees++; metadata_block = 0; fwp_mem_free(block);
}
static void metadata_no_release(void *block) { (void)block; }
static const fwp_desc context_error = {.kind=K_STR, .name="String"};

static void check_inherited(void) {
    g_ctx *ctx = g_ctx_of();
    if (!ctx->gzip || ctx->deadline != parent_deadline || ctx->n != 3) _Exit(41);
    const char *expected[] = {"x-parent", "parent", "x-name", "one  two", "x-name", "again"};
    for (size_t i = 0; i < 6; i++) {
        uintptr_t address = (uintptr_t)ctx->kv[i], base = (uintptr_t)metadata_block;
        if (strcmp(ctx->kv[i], expected[i]) || address < base || address - base >= metadata_bytes) _Exit(42);
    }
}

static void inherited_child(void *arg, int stop) {
    (void)arg;
    if (stop) _Exit(43);
    while (!released) { fwp_park(0, 0); fwp_check_cancel(); }
    if (!fwp_cur->gctx) _Exit(41);
    if (fwp_cur->gctx != &fwp_cur->gctx_storage) _Exit(53);
    check_inherited();
    child_checked++;
    /* Nested scopes must restore this child's inherited settings too. */
    depth = 3;
    if (fwp_p_grpc_with_gzip(0) != 42) _Exit(44);
    check_inherited();
}

static uintptr_t scope_callback(uintptr_t ignored) {
    (void)ignored;
    if (stage == 9) {
        if (!g_ctx_of()->metadata_owner || g_ctx_of()->metadata_owner->users != SIZE_MAX) _Exit(58);
        return 42;
    }
    if (depth == 0) { depth = 1; return fwp_p_grpc_with_deadline(duration, 0); }
    if (depth == 1) {
        depth = 2;
        if (stage == 7) STR(original_name)->len = SIZE_MAX;
        if (stage == 8) STR(original_value)->len = SIZE_MAX;
        return fwp_p_grpc_with_metadata(metadata, 0);
    }
    check_inherited();
    if (depth == 3) return 42;
    escaped = fwp_spawn_task(0, inherited_child, 0, 0, 1);
    fwp_task_own_internal(escaped, 1);
    if (stage == 1) fwp_fail(fwp_cstr("scope failure"), &context_error);
    if (stage == 2) fwp_trap("scope trap");
    if (stage == 3) { entered = 1; fwp_park(0, 0); fwp_check_cancel(); _Exit(45); }
    return 42;
}

static void parent(void *arg, int stop) {
    (void)arg;
    if (stop) {
        cancelled++;
        g_ctx *ctx = g_ctx_of();
        if (ctx->gzip || ctx->deadline != parent_deadline || ctx->n != 1 || fwp_cleanups) _Exit(49);
        return;
    }
    void *saved_context = fwp_cur->gctx;
    jmp_buf failure;
    jmp_buf *saved_trap = fwp_cur->trap_jb;
    fwp_cleanup *saved_cleanup = fwp_cur->trap_cleanup;
    fwp_handler handler = {0};
    handler.prev = fwp_handlers;
    handler.cleanup = fwp_cleanups;
    handler.state_depth = fwp_state_len;
    fwp_handlers = &handler;
    if (!setjmp(failure)) {
        if (!setjmp(handler.jb)) {
            fwp_cur->trap_jb = &failure;
            fwp_cur->trap_cleanup = fwp_cleanups;
            if (fwp_p_grpc_with_gzip(0) != 42 || stage) _Exit(46);
        } else {
            typed++;
            if (handler.desc != &context_error || strcmp(STR(handler.value)->d, "scope failure")) _Exit(47);

        }
    } else {
        trapped++;
        const char *expected = stage >= 5 ? "outgoing metadata too large" : stage == 4 ? "out of memory" : "scope trap";
        if (strcmp(fwp_trap_msg, expected)) _Exit(48);
        STR(original_name)->len = 6; STR(original_value)->len = 8;
    }
    fwp_handlers = handler.prev;
    fwp_cur->trap_jb = saved_trap;
    fwp_cur->trap_cleanup = saved_cleanup;
    if (fwp_cur->gctx != saved_context || fwp_cleanups) _Exit(49);
}

/* Failure controls bypass teardown so cancellation cannot replace the original
 * failure code. Successful runs still execute complete library shutdown. */
int main(void) {
    fwp_lib_init();
    fwp_heap_start();
    fwp_tasks_init();
    fwp_trap_recover = g_trap_recover;
    for (stage = 0; stage < 9; stage++) {
        depth = entered = released = child_checked = cancelled = typed = trapped = 0;
        escaped = 0; metadata_block = 0; metadata_attempts = metadata_frees = 0; fail_metadata = stage == 4;
        const char *parent_headers[] = {"x-parent", "parent"};
        g_ctx before = {0};
        parent_deadline = fwp_now_ns() + INT64_C(60000000000);
        before.deadline = parent_deadline;
        before.kv = parent_headers; before.n = 1;
        if (stage == 5) before.n = SIZE_MAX;
        if (stage == 6) before.n = (SIZE_MAX - sizeof(g_metadata)) / 2 / sizeof(char *);
        fwp_cur->gctx = &before;
        original_name = fwp_cstr("X-Name");
        original_value = fwp_cstr("one\r\ntwo");
        V pairs[4];
        pairs[0] = fwp_tuple2(original_name, original_value);
        pairs[1] = fwp_tuple2(fwp_cstr("X-Name"), fwp_cstr("again"));
        pairs[2] = fwp_tuple2(fwp_cstr(""), fwp_cstr("ignored"));
        pairs[3] = fwp_tuple2(fwp_cstr(":path"), fwp_cstr("ignored"));
        metadata = fwp_list_from(pairs, 4);
        V nanoseconds = INT64_C(3600000000000);
        duration = fwp_record(1, &nanoseconds);
        fwp_task *task = fwp_spawn_task(0, parent, 0, 0, 0);
        fwp_task_own_internal(task, 1);
        if (stage == 3) {
            fwp_p_task_yield();
            if (!entered || task->done) _Exit(50);
            fwp_p_task_cancel(PTR(task));
        }
        fwp_await(task);
        if (stage >= 4) {
            if (escaped || child_checked || !task->done || cancelled || typed || trapped != 1 ||
                metadata_attempts != (stage == 4) || metadata_frees || fail_metadata ||
                metadata_block || fwp_cur->gctx != &before || fwp_cleanups) _Exit(56);
            fwp_task_drop(PTR(task));
            fwp_cur->gctx = 0;
            continue;
        }
        if (metadata_frees) _Exit(55);
        if (!escaped || escaped->done || child_checked || !task->done ||
            cancelled != (stage == 3) || typed != (stage == 1) ||
            trapped != (stage == 2) || fwp_cur->gctx != &before || fwp_cleanups) _Exit(51);
        fwp_task_drop(PTR(task));
        /* This private fixture mutates source buffers to detect borrowed copies. */
        memset(STR(original_name)->d, '?', STR(original_name)->len);
        memset(STR(original_value)->d, '?', STR(original_value)->len);
        released = 1;
        fwp_make_ready(escaped);
        fwp_await(escaped);
        if (child_checked != 1 || !escaped->done || escaped->gctx_owner) _Exit(52);
        fwp_task_drop(PTR(escaped));
        if (metadata_attempts != 1 || metadata_frees != 1 || metadata_block) _Exit(54);


        fwp_cur->gctx = 0;
    }
    /* Failed child ownership is atomic across headers, TLS and capture. A
     * synchronous scope can still borrow these owners without incrementing. */
    g_metadata saturated = {.users=SIZE_MAX};
    g_tls tls = {.users=1}; g_capture capture = {.users=1};
    g_ctx context = {.tls=&tls, .capture=&capture.headers,
                     .capture_owner=&capture, .metadata_owner=&saturated};
    jmp_buf failed;
    fwp_cur->trap_jb = &failed; fwp_cur->trap_cleanup = fwp_cleanups;
    if (!setjmp(failed)) { g_context_acquire(&context); _Exit(57); }
    if (tls.users != 1 || capture.users != 1 || saturated.users != SIZE_MAX ||
        strcmp(fwp_trap_msg, "too many outgoing metadata owners")) _Exit(57);
    stage = 9; fwp_cur->gctx = &context;
    if (fwp_p_grpc_with_gzip(0) != 42 || tls.users != 1 || capture.users != 1 ||
        saturated.users != SIZE_MAX || fwp_cur->gctx != &context || fwp_cleanups) _Exit(58);
    fwp_cur->gctx = 0; fwp_cur->trap_jb = 0;
    fwp_lib_finish();
    return 0;
}
