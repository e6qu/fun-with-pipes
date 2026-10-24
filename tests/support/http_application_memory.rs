//! Observe the maintained API at the listener's ordinary idle checkpoints.
pub fn instrument(original: &str) -> String {
    let mut code = original.to_owned();
    for (before, after) in [
        ("typedef uint64_t V;", concat!("typedef uint64_t V;\n",
            "static unsigned long long http_app_opened, http_app_closed, http_app_sampled;\n",
            "static int http_app_active;\n",
            "static void *http_app_listener;\nstatic unsigned http_app_shutdown_cancelled;\n",
            "#define HTTP_APP_OMIT_FREE 0\n#define HTTP_APP_OMIT_CLOSE 0\n",
            "static void http_app_checkpoint(void);\n")),
        ("    s->refs = 1;", "    s->refs = 1;\n    if (kind == 1) http_app_opened++;"),
        ("if (s->fd != FWP_INVALID_SOCKET) { fwp_fd_closing(s->fd); fwp_socket_close(s->fd); s->fd = FWP_INVALID_SOCKET; }",
         "if (s->fd != FWP_INVALID_SOCKET) { fwp_fd_closing(s->fd); if (!HTTP_APP_OMIT_CLOSE || !http_app_active || s->kind != 1) { fwp_socket_close(s->fd); if (s->kind == 1) http_app_closed++; } s->fd = FWP_INVALID_SOCKET; }"),
        ("        if (SOCK(c)->kind == 1) shutdown(fd, SHUT_RDWR);\n        fwp_socket_close(fd);",
         "        if (SOCK(c)->kind == 1) shutdown(fd, SHUT_RDWR);\n        if (!HTTP_APP_OMIT_CLOSE || !http_app_active || SOCK(c)->kind != 1) { fwp_socket_close(fd); if (SOCK(c)->kind == 1) http_app_closed++; }"),
        ("static void fwp_rc_free_obj(V v) {\n    if (!fwp_rc_last(v)) return;",
         "static void fwp_rc_free_obj(V v) {\n    if (!fwp_rc_last(v)) return;\n    if (HTTP_APP_OMIT_FREE && http_app_active) return;"),
        ("    V c = fwp_accept(l, fwp_after(d), err);\n    if (!c) return FWP_NONE;",
         "    V c = fwp_accept(l, fwp_after(d), err);\n    if (!c) { http_app_checkpoint(); return FWP_NONE; }"),
        ("static void fwp_cancel_tree(fwp_task *t) {\n    if (t->done) return;",
         "static void fwp_cancel_tree(fwp_task *t) {\n    if (t->done) return;\n    if (http_app_listener == t && fwp_shutdown && !t->cancelled) http_app_shutdown_cancelled++;"),
        ("    fwp_nmetrics = fwp_metrics_cap = 0;", "    fwp_nmetrics = fwp_metrics_cap = 0;\n    if (http_app_active) fprintf(stderr, \"http-metrics-final\\t0\\n\");"),
    ] {
        assert_eq!(code.matches(before).count(), 1, "{before}");
        code = code.replacen(before, after, 1);
    }
    let marker = "static void *fwp_main_thread(void *arg) {";
    assert_eq!(code.matches(marker).count(), 1);
    code = code.replace(
        marker,
        &format!(
            "{}\n{marker}",
            include_str!("../fixtures/http_app_memory.c")
        ),
    );
    let start = code.find(marker).unwrap();
    let (runtime, main) = code.split_at(start);
    let initial = "    fwp_init_consts();\n";
    let final_point = "    /* Ownership observation point: before runtime teardown. */\n";
    assert_eq!(main.matches(initial).count(), 1);
    assert_eq!(main.matches(final_point).count(), 1);
    format!(
        "{runtime}{}",
        main.replace(
            initial,
            &format!("{initial}    http_app_start = http_app_charge();\n")
        )
        .replace(
            final_point,
            &format!("{final_point}    http_app_finish();\n")
        )
    )
}
