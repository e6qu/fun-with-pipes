static int allocation_left, response_mode, stream_finals, request_resets;
static g_stream *waiting_request;
static V pending_key, pending_request;
static int cancellation_finished;
static jmp_buf allocation_failure;
static int recover_allocation(void) { return 1; }
static void client_allocation(void) {
    if (allocation_left > 0 && !--allocation_left) fwp_trap("injected HTTP response allocation failure");
}
static g_stream *client_stream(g_conn *c, uint32_t id) {
    g_stream *s = g_stream_new(c, id);
    h2_hdrs_add(&s->headers, ":status", 7, "201", 3);
    h2_hdrs_add(&s->headers, "x-a", 3, "one", 3);
    h2_hdrs_add(&s->headers, "x-b", 3, "two", 3);
    h2_hdrs_add(&s->headers, "x-a", 3, "three", 5);
    h2_hdrs_add(&s->trailers, "x-t", 3, "last", 4);
    static const unsigned char body[] = {0, 255, 192, 128, 10};
    h2b_put(&s->data, body, sizeof body);
    s->remote_end = response_mode == 0;
    if (response_mode == 1) g_set_reset(s, "peer reset");
    waiting_request = s;
    return s;
}
static void pending_client(void *arg, int cancelled) {
    if (cancelled) return;
    V response = fwp_p_http2_send(pending_key, FWP_NONE, pending_request, ERROR_TYPE, RESPONSE_TYPE);
    RESPONSE_TYPE->drop(response);
    _Exit(20); /* a waiting response must be cancelled before it completes */
}
static void pending_finished(void *arg) { cancellation_finished++; }
static int response_matches(V response) {
    if (OBJ(response)->n != 3 || OBJ(response)->f[0] != 201) return 0;
    const char *keys[] = {"x-a", "x-b", "x-a", "x-t"};
    const char *values[] = {"one", "two", "three", "last"};
    V list = OBJ(response)->f[1];
    for (int i = 0; i < 4; i++) {
        if (!list) return 0;
        V pair = OBJ(list)->f[0];
        if (strcmp(STR(OBJ(pair)->f[0])->d, keys[i]) || strcmp(STR(OBJ(pair)->f[1])->d, values[i])) return 0;
        list = OBJ(list)->f[1];
    }
    static const unsigned char body[] = {0, 255, 192, 128, 10};
    V data = OBJ(response)->f[2];
    return !list && STR(data)->len == sizeof body && !memcmp(STR(data)->d, body, sizeof body);
}
static void no_release(void *arg) { (void)arg; }
int main(void) {
    fwp_lib_init(); fwp_heap_start(); fwp_tasks_init();
    g_conn *c = g_conn_new(FWP_INVALID_SOCKET, "", "http2 probe", 0);
    fwp_rc_fresh(PTR(c)); g_pool = c; /* pool owns storage, with no transport tasks */
    V key = fwp_cstr("probe");
    V fields[] = {fwp_cstr("GET"), fwp_cstr("http"), fwp_cstr("example.test"), fwp_cstr("/echo"), 0, fwp_cstr("")};
    V request = fwp_record(6, fields);
    size_t live_bytes = fwp_heap.live;
    int failures = 0, completed = 0;
    for (volatile int allocation = 1; allocation < 64; allocation++) {
        stream_finals = request_resets = 0; response_mode = 0;
        fwp_trap_recover = recover_allocation; fwp_trap_jb = &allocation_failure; fwp_trap_cleanup = fwp_cleanups;
        /* Arm after the request stream and raw metadata exist, at the response boundary. */
        response_fail_at = allocation;
        if (!setjmp(allocation_failure)) {
            V response = fwp_p_http2_send(key, FWP_NONE, request, ERROR_TYPE, RESPONSE_TYPE);
            allocation_left = response_fail_at = 0;
            if (!response_matches(response)) return 1;
            RESPONSE_TYPE->dup(response); RESPONSE_TYPE->drop(response);
            if (!response_matches(response)) return 2;
            RESPONSE_TYPE->drop(response); completed = 1;
        } else failures++;
        allocation_left = response_fail_at = 0; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (fwp_cleanups || c->streams || stream_finals != 1 || *fwp_rc_slot(PTR(c)) != 1) return 3;
        if (!completed && request_resets != 1) return 4;
        if (!fwp_reuse_verify && !getenv("FWP_CLIENT_STRESS") && fwp_heap.live != live_bytes) {
            fprintf(stderr, "allocation %d: charged storage delta %lld\n", allocation, (long long)(live_bytes - fwp_heap.live)); return 5;
        }
        c->out.len = 0;
        if (completed) break;
    }
    if (!completed || failures != 18) { fprintf(stderr, "response failures %d, completed %d\n", failures, completed); return 6; }
    /* A peer reset releases both request owners and the temporary connection owner. */
    response_mode = 1; stream_finals = request_resets = 0;
    fwp_handler error = {0}; error.prev = fwp_handlers; error.cleanup = fwp_cleanups; fwp_handlers = &error;
    if (!setjmp(error.jb)) { fwp_p_http2_send(key, FWP_NONE, request, ERROR_TYPE, RESPONSE_TYPE); return 7; }
    fwp_handlers = error.prev;
    if (strcmp(STR(OBJ(error.value)->f[0])->d, "http2") || strcmp(STR(OBJ(error.value)->f[1])->d, "peer reset")) return 8;
    ERROR_TYPE->drop(error.value);
    if (fwp_cleanups || c->streams || stream_finals != 1 || request_resets != 1 || *fwp_rc_slot(PTR(c)) != 1) return 9;
    if (!fwp_reuse_verify && !getenv("FWP_CLIENT_STRESS") && fwp_heap.live != live_bytes) return 5;
    response_mode = 2; stream_finals = request_resets = 0; waiting_request = NULL;
    pending_key = key; pending_request = request;
    fwp_task *task = fwp_spawn_task(0, pending_client, NULL, 0, 0);
    fwp_task_own_internal(task, 0); task->cfinish = pending_finished;
    while (!waiting_request || !waiting_request->waiters.head) fwp_p_task_yield();
    fwp_cancel_tree(task);
    while (!cancellation_finished) fwp_p_task_yield();
    fwp_free_zombie();
    if (fwp_cleanups || c->streams || stream_finals != 1 || request_resets != 1 || *fwp_rc_slot(PTR(c)) != 1) return 10;
    waiting_request = NULL; pending_key = pending_request = 0;
    g_pool = NULL; g_conn_drop(c);
    FWP_KEEP_ALIVE(request); FWP_KEEP_ALIVE(key);
    fwp_lib_finish(); return 0;
}
