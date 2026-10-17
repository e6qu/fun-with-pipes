//! HTTP client responses own partial copies and release requests on every exit.
#[path = "support/http2_values.rs"]
mod http2_values;
use std::process::Command;

#[test]
fn http2_client_startup_releases_reserved_io_and_connection_owners() {
    let mut generated = http2_values::generated();
    for (before, after) in [
        ("static void g_conn_final(void *p) {", "static void g_conn_final(void *p) { if(p==pending)finalized++;"),
        ("c = g_conn_new(fd, \"http2 \", STR(key)->d, 0);", "c = g_conn_new(fd, \"http2 \", STR(key)->d, 0); pending=c;"),
        ("transport_start.reader = fwp_spawn_task(0, g_reader, c, 0, 1);", "if(startup_stage==0)fwp_trap(\"reader startup failure\"); transport_start.reader=fwp_spawn_task(0,g_reader,c,0,1); started_reader=transport_start.reader;"),
        ("transport_start.writer = fwp_spawn_task(0, g_writer, c, 0, 1);", "if(startup_stage==1)fwp_trap(\"writer startup failure\"); transport_start.writer=fwp_spawn_task(0,g_writer,c,0,1); started_writer=transport_start.writer;"),
        ("c->refs--; /* I/O tasks retain transport; this call keeps storage */", "c->refs--; return PTR(c); /* expose the startup owner without starting a request */"),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{before}");
        generated = generated.replacen(before, after, 1);
    }
    let fixture = include_str!("fixtures/http2_client_startup.c");
    let declarations = "static int startup_stage, finalized; static void *pending, *started_reader, *started_writer; static void no_start_release(void *);";
    let fixture = fixture
        .replace("static fwp_task *started_reader, *started_writer;", "")
        .replace(
            "started_reader->ownership",
            "((fwp_task *)started_reader)->ownership",
        )
        .replace(
            "started_writer->ownership",
            "((fwp_task *)started_writer)->ownership",
        );
    let reserve = "fwp_cleanup_push(&io_owner, g_connect_ref_release, c);";
    let startup =
        "fwp_cleanup_push(&transport_start_cleanup, g_connect_start_abort, &transport_start);";
    assert_eq!(generated.matches(reserve).count(), 2);
    assert_eq!(generated.matches(startup).count(), 1);
    let missing_reserve =
        generated.replace(reserve, "fwp_cleanup_push(&io_owner, no_start_release, c);");
    let missing_startup = generated.replace(
        startup,
        "fwp_cleanup_push(&transport_start_cleanup, no_start_release, &transport_start);",
    );
    let full_key = "c = g_conn_new(fd, \"http2 \", STR(key)->d, 0);";
    assert_eq!(generated.matches(full_key).count(), 1);
    let truncated_key = generated.replace(full_key,
        "char short_key[1194]; snprintf(short_key,sizeof short_key,\"%s\",STR(key)->d); c = g_conn_new(fd, \"http2 \", short_key, 0);");
    let dir = fwp::cgen::TempDir::new("http2-client-startup").unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [
            (&missing_reserve, 9),
            (&missing_startup, 9),
            (&truncated_key, 6),
            (&generated, 0),
        ] {
            fwp::cgen::compile_c(&format!("{declarations}\n{source}\n{fixture}"), &exe, opt)
                .unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "{opt}, expected {expected}: {out:?}"
            );
        }
        let out = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert!(out.status.success(), "{opt}, stress: {out:?}");
    }
}

#[test]
fn http2_client_responses_release_partial_copies_and_request_owners() {
    let generated = http2_values::generated();
    let begin = generated.find("static V fwp_p_http2_send(").unwrap();
    let end = begin
        + generated[begin..]
            .find(
                "/* -------------------------------------------------------------- compression */",
            )
            .unwrap();
    let method = generated[begin..end]
        .replace(
            "g_stream *s = g_stream_new(c, id);",
            "g_stream *s = client_stream(c, id);",
        )
        .replace(
            "for (;;) {\n        if (s->remote_end)",
            "allocation_left=response_fail_at;\n    for (;;) {\n        if (s->remote_end)",
        );
    assert_ne!(method, generated[begin..end]);
    let generated = format!(
        "{}static g_stream *client_stream(g_conn *, uint32_t);\n{}{}",
        &generated[..begin],
        method,
        &generated[end..]
    );
    let mut generated = generated.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int response_fail_at, allocation_left, stream_finals, request_resets; static void client_allocation(void);");
    for (before, after) in [
        (
            "static inline void *fwp_alloc_init(size_t n) {",
            "static inline void *fwp_alloc_init(size_t n) { client_allocation();",
        ),
        (
            "static inline void *fwp_gc_alloc(size_t n, int leaf) {",
            "static inline void *fwp_gc_alloc(size_t n, int leaf) { if(leaf)client_allocation();",
        ),
        (
            "static void g_stream_final(void *p) {",
            "static void g_stream_final(void *p) { stream_finals++;",
        ),
        (
            "static void g_call_reset(void *arg) {",
            "static void g_call_reset(void *arg) { request_resets++;",
        ),
    ] {
        assert_eq!(generated.matches(before).count(), 1, "{before}");
        generated = generated.replacen(before, after, 1);
    }
    let fixture = include_str!("fixtures/http2_client_ownership.c");
    let dir = fwp::cgen::TempDir::new("http2-client-ownership").unwrap();
    let exe = dir.join("probe");
    let missing_fields = generated.replace("if (d && d->drop) d->drop(f->values[i]);", "(void)d;");
    let guard = "fwp_cleanup_push(&request_cleanup, g_call_release, &call);";
    assert_eq!(generated.matches(guard).count(), 1);
    let missing_request = generated.replace(
        guard,
        "fwp_cleanup_push(&request_cleanup, no_release, &call);",
    );
    for opt in ["-O1", "-O2"] {
        for (source, status) in [(&missing_fields, 5), (&missing_request, 3), (&generated, 0)] {
            assert!(status == 0 || source != &generated);
            fwp::cgen::compile_c(
                &format!("static void no_release(void *);\n{source}\n{fixture}"),
                &exe,
                opt,
            )
            .unwrap();
            let out = Command::new(&exe)
                .env("FWP_GC", "off")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(status),
                "{opt}, expected {status}: {out:?}"
            );
        }
        for stress in [false, true] {
            let mut cmd = Command::new(&exe);
            cmd.env("FWP_REUSE_VERIFY", "1");
            if stress {
                cmd.env("FWP_CLIENT_STRESS", "1")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1");
            }
            let out = cmd.output().unwrap();
            assert!(out.status.success(), "{opt}, stress {stress}: {out:?}");
        }
    }
}
