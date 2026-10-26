static int startup_stage, trapped, finalized;
static void *pending;
static fwp_task *started_reader, *started_writer;
static g_conn *connected;
static char target[300];
static char pool_key[4097];
static void no_start_release(void *arg) { (void)arg; }
static void connect_client(void *arg, int cancelled) {
    if (cancelled) _Exit(30);
    volatile V transport = 0;
    SSL *volatile expected_tls = 0;
    jmp_buf failed;
    jmp_buf *saved = fwp_cur->trap_jb;
    fwp_cleanup *saved_cleanup = fwp_cur->trap_cleanup;
    if (!setjmp(failed)) {
        fwp_cur->trap_jb = &failed; fwp_cur->trap_cleanup = fwp_cleanups;
        V conn = fwp_p_tcp_connect(fwp_cstr(target), ERROR_TYPE);
        transport = conn;
        if (startup_stage < 0) {
            SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());
            if (!ctx) _Exit(31);
            expected_tls = SSL_new(ctx); SSL_CTX_free(ctx);
            if (!expected_tls) _Exit(32);
            STREAM(conn)->tls = expected_tls;
        }
        if (startup_stage == -2) { fwp_p_http2_serve(conn, 0, 0, 0, 0); _Exit(33); }
        V option = fwp_data(1, 1, &conn);
        connected = (g_conn *)(uintptr_t)fwp_p_http2_send(fwp_cstr(pool_key), option, 0, ERROR_TYPE, RESPONSE_TYPE);
        FWP_KEEP_ALIVE(option);
    } else trapped++;
    fwp_cur->trap_jb = saved; fwp_cur->trap_cleanup = saved_cleanup;
    if (startup_stage < 0) {
        if (!transport || SOCK(transport)->fd == FWP_INVALID_SOCKET || STREAM(transport)->tls != expected_tls) _Exit(10);
        fwp_p_sock_close(transport);
    }
    FWP_KEEP_ALIVE(transport);
}
int main(void) {
    fwp_lib_init(); fwp_heap_start(); fwp_trap_recover = g_trap_recover;
    memset(pool_key, 'x', sizeof pool_key - 1); pool_key[sizeof pool_key - 1] = 0;
    for (startup_stage = -2; startup_stage < 3; startup_stage++) {
        V listener = fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"), ERROR_TYPE);
        V address = fwp_p_local_addr(listener); snprintf(target, sizeof target, "%s", STR(address)->d);
        pending = 0; started_reader = started_writer = 0; connected = 0; trapped = finalized = 0;
        fwp_task *task = fwp_spawn_task(0, connect_client, 0, 0, 0); fwp_await(task);
        if (startup_stage < 0) {
            if (!task->done || !trapped || pending || fwp_cleanups || g_pool) return 11;
            fwp_p_tcp_stop(listener); FWP_KEEP_ALIVE(listener); FWP_KEEP_ALIVE(PTR(task));
            continue;
        }
        g_conn *c = pending;
        if (!task->done || !c || fwp_cleanups || trapped != (startup_stage < 2)) return 1;
        if (startup_stage == 0 && (connected || g_pool || started_reader || started_writer)) return 2;
        if (startup_stage == 1 && (connected || g_pool || !started_reader || started_writer)) return 3;
        if (startup_stage == 2) {
            if (connected != c || g_pool != c || !started_reader || !started_writer || c->refs != 2 || c->dead) return 4;
            if (started_reader->ownership != FWP_TASK_UNIQUE || started_writer->ownership != FWP_TASK_UNIQUE) return 5;
            if (w_pooled(pool_key) != c || w_pooled("different") || strlen(c->authority) != strlen(pool_key) + 6) return 6;
            pool_key[sizeof pool_key - 2] = 'y';
            if (w_pooled(pool_key)) return 6;
            pool_key[sizeof pool_key - 2] = 'x';
            g_conn_dead(c, "finished");
        }
        int64_t limit = fwp_now_ns() + 10000000000LL;
        while (fwp_tasks_active) {
            if (fwp_now_ns() >= limit) return 7;
            fwp_park(0, fwp_now_ns() + 1000000LL); fwp_free_zombie();
        }
        fwp_free_zombie();
        if (startup_stage == 2) {
            if (c->refs || c->fd != FWP_INVALID_SOCKET || finalized) return 8;
            g_conn_drop(c); connected = 0;
        }
        if (finalized != 1 || g_pool || fwp_cleanups) return 9;
        fwp_p_tcp_stop(listener); FWP_KEEP_ALIVE(listener); FWP_KEEP_ALIVE(PTR(task));
    }
    fwp_lib_finish(); return 0;
}
