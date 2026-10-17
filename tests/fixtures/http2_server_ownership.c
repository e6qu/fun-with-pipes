static int handler_mode, entered;
static V escaped;
static fwp_wl handler_wait;
static jmp_buf failure;
static int recover(void) { return 1; }
static void server_handle(uint64_t call) {
    entered++;
    g_call *k = (g_call *)(uintptr_t)call;
    if (handler_mode == 1) {
        fwp_rc_dup(call);
        escaped = call;
        k->s->local_end = 1;
    } else if (handler_mode == 2) {
        fwp_park(&handler_wait, 0);
        fwp_check_cancel();
        _Exit(30);
    } else k->s->local_end = 1;
}
static g_stream *request(g_conn *c, uint32_t id) {
    h2_hdrs headers = {0};
    h2_hdrs_add(&headers, ":method", 7, "GET", 3);
    h2_hdrs_add(&headers, ":path", 5, "/hello", 6);
    g_slist pending = {0};
    g_web_stream(c, id, &headers, 1, &pending);
    if (pending.n != 1) _Exit(11);
    g_stream *s = pending.v[0];
    if (*fwp_rc_slot(PTR(s)) != 2) _Exit(12);
    g_slist_release(&pending);
    return s; /* borrow active-list owner */
}
int main(void) {
    fwp_lib_init(); fwp_gc_start(__builtin_frame_address(0)); fwp_tasks_init();
    g_conn *c = g_conn_new(FWP_INVALID_SOCKET, "", "server probe", 0);
    fwp_rc_fresh(PTR(c));
    struct g_web *w = fwp_mem_alloc(sizeof *w);
    w->max_header = 4096; w->max_requests = 1000; c->web = w;
    intptr_t budget = fwp_gc.budget;
    for (int scoped = 0; scoped < 2; scoped++) {
    for (handler_mode = 0; handler_mode < 4; handler_mode++) {
        fwp_scope scope = {0, 0, 0, fwp_cur->scope};
        fwp_scope_owner scope_owner = {fwp_cur, &scope, fwp_handlers};
        if (scoped) fwp_cur->scope = &scope;
        int before = job_finishes;
        int streams_before = stream_finals;
        g_stream *s = request(c, 1 + 2 * (handler_mode + scoped * 4));
        fail_start = handler_mode == 3;
        fwp_trap_recover = recover; fwp_trap_jb = &failure; fwp_trap_cleanup = fwp_cleanups;
        if (!setjmp(failure)) {
            w_start(c, s);
            if (fail_start) return 14;
        } else if (!fail_start) return 15;
        fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (fail_start) {
            if (*fwp_rc_slot(PTR(c)) != 1 || *fwp_rc_slot(PTR(s)) != 1 || s->task) return 16;
            g_unlink(c, s);
        } else {
            fwp_task *task = s->task;
            if (!task || task->ownership != (scoped ? FWP_TASK_SHARED : FWP_TASK_UNIQUE)) return 17;
            if (handler_mode == 2) {
                while (!handler_wait.head) fwp_p_task_yield();
                fwp_cancel_tree(task);
            }
            fwp_join_children(); fwp_free_zombie();
            if (job_finishes != before + 1) return 13;
            if (scoped && (scope.n != 1 || !scope.tasks[0]->done || *fwp_rc_slot(PTR(task)) != 1)) return 23;
        }
        if (scoped) fwp_scope_release(&scope_owner);
        if (handler_mode == 1) {
            g_call *k = (g_call *)(uintptr_t)escaped;
            if (k->task || k->s->task || k->s->listed || stream_finals != streams_before) return 18;
            V copied = fwp_p_http2_request(escaped, REQUEST_TYPE);
            if (strcmp(STR(OBJ(copied)->f[1])->d, "/hello")) return 19;
            REQUEST_TYPE->drop(copied);
            g_call_drop(escaped); escaped = 0;
        }
        if (c->streams || stream_finals != streams_before + 1 || *fwp_rc_slot(PTR(c)) != 1 || fwp_cleanups) return 20;
        if (!getenv("SERVER_STRESS") && fwp_gc.budget != budget) {
            fprintf(stderr, "mode %d managed storage delta %lld\n", handler_mode, (long long)(fwp_gc.budget-budget));
            return 21;
        }
    }
    }
    /* A retained handle outlives both its task and the closed connection. */
    handler_mode = 1; fail_start = 0;
    g_stream *last = request(c, 17);
    w_start(c, last); fwp_join_children(); fwp_free_zombie();
    if (!escaped || c->streams || connection_finals) return 24;
    g_conn_dead(c, "closed"); g_conn_drop(c);
    if (connection_finals) return 25;
    V copied = fwp_p_http2_request(escaped, REQUEST_TYPE);
    if (strcmp(STR(OBJ(copied)->f[1])->d, "/hello")) return 26;
    REQUEST_TYPE->drop(copied);
    g_call_drop(escaped); escaped = 0;
    if (connection_finals != 1 || entered != 7) return 22;
    fwp_lib_finish(); return 0;
}
