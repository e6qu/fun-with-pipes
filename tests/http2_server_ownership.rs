//! Request tasks and escaped stream handles have independent storage owners.
#[path = "support/http2_values.rs"]
mod http2_values;
use std::process::Command;

#[test]
fn http_server_jobs_release_on_completion_cancellation_and_start_failure() {
    let mut generated = http2_values::generated();
    for (before, after) in [
        ("fwp_apply_borrowed_span(((struct g_web *)j->c->web)->handler, 1, &call, 0, 0);", "server_handle(call);"),
        ("fwp_task *task = fwp_spawn_task(0, w_handle, j, 0, 0);", "if(fail_start)fwp_trap(\"injected handler startup failure\"); fwp_task *task = fwp_spawn_task(0, w_handle, j, 0, 0);"),
        ("static void g_stream_final(void *p) {", "static void g_stream_final(void *p) { stream_finals++;"),
        ("static void g_conn_final(void *p) {", "static void g_conn_final(void *p) { connection_finals++;"),
        ("static void w_job_finish(void *arg) {", "static void w_job_finish(void *arg) { job_finishes++;"),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{before}");
        generated = generated.replacen(before, after, 1);
    }
    // Keep platform feature definitions before every system header. V is
    // available here, so the probe does not need to prepend its own headers.
    let value_type = "typedef uint64_t V;";
    assert_eq!(generated.matches(value_type).count(), 1);
    generated = generated.replacen(
        value_type,
        "typedef uint64_t V;\nstatic int fail_start,stream_finals,connection_finals,job_finishes; static void server_handle(V);",
        1,
    );
    let fixture = include_str!("fixtures/http2_server_ownership.c");
    let finish = "task->cfinish = w_job_finish;";
    assert_eq!(generated.matches(finish).count(), 1);
    let missing_finish = generated.replace(finish, "/* deliberately omit job release */");
    let stream_owner = "fwp_rc_fresh(PTR(s)); /* active-list owner */";
    assert_eq!(generated.matches(stream_owner).count(), 1);
    let missing_stream = generated.replace(stream_owner, "/* deliberately omit request owner */");
    let dir = fwp::cgen::TempDir::new("http2-server-ownership").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [
            (&missing_stream, 12),
            (&missing_finish, 13),
            (&generated, 0),
        ] {
            fwp::cgen::compile_c(&format!("{code}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}, {expected}: {out:?}"
            );
        }
        let out = Command::new(&exe)
            .env("SERVER_STRESS", "1")
            .output()
            .unwrap();
        assert!(out.status.success(), "{opt}, stress: {out:?}");
    }
}

#[test]
fn http_server_startup_releases_transport_requests_and_handler_captures() {
    let mut generated = http2_values::generated();
    for (before, after) in [
        ("struct g_web *w = (struct g_web *)fwp_mem_alloc(sizeof *w);", "if(stage==0)fwp_trap(\"server configuration failure\"); struct g_web *w = (struct g_web *)fwp_mem_alloc(sizeof *w);"),
        ("fwp_task *task = fwp_spawn_task(0, w_handle, j, 0, 0);", "if(stage==2)fwp_trap(\"handler startup failure\"); fwp_task *task = fwp_spawn_task(0, w_handle, j, 0, 0);"),
        ("static void g_conn_final(void *p) {", "static void g_conn_final(void *p) { connection_finals++;"),
        ("static void g_stream_final(void *p) {", "static void g_stream_final(void *p) { stream_finals++;"),
        ("static void fwp_tls_dispose(void *p) {", "static void fwp_tls_dispose(void *p) { if(p && p == watched_tls)tls_finals++;"),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{before}");
        generated = generated.replacen(before, after, 1);
    }
    // Scope the writer hook to HTTP serve; gRPC also reserves a writer owner.
    let start = generated.find("static V fwp_p_http2_serve(").unwrap();
    let writer = "fwp_task *writer = fwp_spawn_task(0, g_writer, c, 0, 0);";
    let tail = generated[start..].replacen(writer, "if(stage==1)fwp_trap(\"writer startup failure\"); fwp_task *writer = fwp_spawn_task(0, g_writer, c, 0, 0);", 1);
    assert_ne!(tail, generated[start..]);
    let buffer = "unsigned char buf[65536];";
    assert_eq!(tail.matches(buffer).count(), 1);
    generated.replace_range(
        start..,
        &tail.replace(
            buffer,
            "unsigned char buf[65536]; if(stage==4)fwp_cancel_tree(fwp_cur);",
        ),
    );
    let handler = "fwp_closure_drop(w->handler);";
    assert_eq!(generated.matches(handler).count(), 1);
    let missing_handler = generated.replace(handler, "/* deliberately omit handler release */");
    let owner = "fwp_cleanup_push(&server_cleanup, w_server_release, &server_owner);";
    assert_eq!(generated.matches(owner).count(), 1);
    let missing_server = generated.replace(
        owner,
        "fwp_cleanup_push(&server_cleanup, no_release, &server_owner);",
    );
    let hooks =
        "static int stage, connection_finals, stream_finals, tls_finals; static void *watched_tls; static void no_release(void *);";
    let fixture = include_str!("fixtures/http2_server_startup.c");
    let dir = fwp::cgen::TempDir::new("http2-server-startup").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(&missing_server, 6), (&missing_handler, 7), (&generated, 0)] {
            fwp::cgen::compile_c(&format!("{hooks}\n{code}\n{fixture}"), &exe, opt).unwrap();
            let out = Command::new(&exe).output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}, {expected}: {out:?}"
            );
        }
    }
}
