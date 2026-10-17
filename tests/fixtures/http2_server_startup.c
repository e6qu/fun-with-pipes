static jmp_buf failed;
static int recover(void) { return 1; }
static void no_release(void *arg) { (void)arg; }
static int server_cancelled;
typedef struct { V conn, initial, limits, handler, upgrade; } server_arguments;
static void serve_cancelled(void *arg, int cancelled) {
    if (cancelled) { server_cancelled++; return; }
    server_arguments *a = arg;
    fwp_p_http2_serve(a->conn, a->initial, a->limits, a->handler, a->upgrade);
    _Exit(12); /* cancellation must unwind after all connection children finish */
}
static int socket_closed(fwp_socket_t fd) {
    int kind = 0; socklen_t n = sizeof kind;
#ifdef _WIN32
    return getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&kind, &n) == SOCKET_ERROR && WSAGetLastError() == WSAENOTSOCK;
#else
    return getsockopt(fd, SOL_SOCKET, SO_TYPE, &kind, &n) == -1 && errno == EBADF;
#endif
}
int main(void) {
    fwp_lib_init(); fwp_gc_start(__builtin_frame_address(0)); fwp_tasks_init();
    for (stage = 0; stage < 5; stage++) {
        V listener = fwp_p_tcp_listen(fwp_cstr("127.0.0.1:0"), ERROR_TYPE);
        V address = fwp_p_local_addr(listener);
        V conn = fwp_p_tcp_connect(address, ERROR_TYPE);
        V peer = fwp_p_tcp_accept(listener, ERROR_TYPE);
        fwp_socket_t fd = SOCK(conn)->fd;
        watched_tls = NULL; tls_finals = 0;
        if (stage < 3) {
            SSL_CTX *ctx = SSL_CTX_new(TLS_client_method());
            if (!ctx) return 9;
            watched_tls = SSL_new(ctx); SSL_CTX_free(ctx);
            if (!watched_tls) return 10;
            STREAM(conn)->tls = watched_tls;
        }
        V capture = fwp_rc_fresh(fwp_cstr("handler capture"));
        V handler = fwp_rc_fresh(fwp_pap(4, 1, &capture));
        V initial = fwp_cstr("");
        struct { uint32_t tag, n; V f[1]; } duration = {0, 1, {0}};
        struct { uint32_t tag, n; V f[3]; } limits = {0, 3, {4096, 1, PTR(&duration)}};
        V fields[] = {fwp_cstr("GET"), fwp_cstr("/hello"), 0, initial};
        V request = fwp_record(4, fields), upgrade = fwp_data(1, 1, &request);
        int trapped = 0, before = connection_finals, before_streams = stream_finals;
        fwp_trap_recover = recover; fwp_trap_jb = &failed; fwp_trap_cleanup = fwp_cleanups;
        if (!setjmp(failed)) {
            if (stage == 4) {
                server_arguments args = {conn, initial, PTR(&limits), handler, upgrade};
                fwp_task *task = fwp_spawn_task(0, serve_cancelled, &args, 0, 0);
                fwp_task_own_internal(task, 0);
                fwp_join_children(); fwp_free_zombie();
                if (server_cancelled != 1) return 13;
            } else fwp_p_http2_serve(conn, initial, PTR(&limits), handler, upgrade);
        }
        else trapped = 1;
        fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (trapped != (stage < 3) || fwp_cleanups) return 4;
        if (SOCK(conn)->fd != FWP_INVALID_SOCKET) return 5;
        fwp_join_children(); fwp_free_zombie();
        if (connection_finals != before + 1 || !socket_closed(fd)) return 6;
        if (*fwp_rc_slot(handler) != 1) return 7;
        if (stream_finals != before_streams + (stage > 0)) return 8;
        if (tls_finals != (stage < 3)) return 11;
        fwp_closure_drop(handler); fwp_sock_drop(conn); fwp_sock_drop(peer); fwp_sock_drop(listener);
        FWP_KEEP_ALIVE(address); FWP_KEEP_ALIVE(upgrade); FWP_KEEP_ALIVE(initial);
    }
    fwp_lib_finish(); return 0;
}
