//! Accepted connections release after I/O, callbacks and independently retained users.
use fwp::ir::*;
use std::process::Command;

#[test]
fn accepted_connections_release_after_startup_io_jobs_and_channels() {
    let no_reuse = std::env::var("FWP_REUSE").as_deref() == Ok("0");
    let unit = MT::unit();
    let program = Program {
        funcs: vec![
            Func {
                name: "available".into(),
                arity: 1,
                locals: vec![unit.clone()],
                ty: MT::Fun(Box::new(unit.clone()), Box::new(MT::con("std::Bool"))),
                body: Body::Prim("tls.available".into()),
            },
            Func {
                name: "pooled".into(),
                arity: 1,
                locals: vec![MT::con("std::String")],
                ty: MT::Fun(
                    Box::new(MT::con("std::String")),
                    Box::new(MT::con("std::Bool")),
                ),
                body: Body::Prim("http2.pooled".into()),
            },
        ],
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (mut code, _) = fwp::cgen::generate_library(&program, "accepted_owners", &[]).unwrap();
    for (before, after) in [
        ("static void g_conn_final(void *p) {", "static void g_conn_final(void *p) { if(p==seen_connection)connection_finals++;"),
        ("static void g_accept_loop(fwp_socket_t lfd, const g_server *srv) {", "static fwp_socket_t seen_fd;\nstatic fwp_socket_t connection_accept(fwp_socket_t,struct sockaddr *,socklen_t *);\nstatic SSL *connection_tls(SSL_CTX *,fwp_socket_t);\nstatic void connection_reader(void *,int);\nstatic void g_accept_loop(fwp_socket_t lfd, const g_server *srv) {"),
        ("fwp_socket_t fd = fwp_socket_accept(lfd, (struct sockaddr *)&ss, &sl);", "fwp_socket_t fd = connection_accept(lfd, (struct sockaddr *)&ss, &sl);"),
        ("g_conn *c = g_conn_new(fd, \"\", peer, srv);", "g_conn *c = g_conn_new(fd, \"\", peer, srv); seen_connection=c;seen_fd=fd;"),
        ("fwp_cleanup_push(&accepted_owner, g_connect_ref_release, c);", "fwp_cleanup_push(&accepted_owner, g_connect_ref_release, c); if(connection_stage==0)fwp_trap(\"accepted startup trap\");"),
        ("c->ssl = (SSL *)fwp_tls_accepted(srv->tls, fd);", "c->ssl = connection_tls(srv->tls, fd);"),
        ("fwp_task *reader = fwp_spawn_task(0, g_reader, c, 0, 0);", "fwp_task *reader = fwp_spawn_task(0, connection_reader, c, 0, 0); seen_reader=reader;"),
    ] {
        assert_eq!(code.matches(before).count(), 1, "{before}");
        code = code.replace(before, after);
    }
    // HTTP and gRPC both start a writer. Inject this failure only into the
    // gRPC reader whose connection lifetime this test exercises.
    let start = code
        .find("static void g_reader(void *arg, int cancelled) {")
        .unwrap();
    let end = start + code[start..].find("\n}\n").unwrap() + 3;
    let writer = "fwp_task *writer = fwp_spawn_task(0, g_writer, c, 0, 0);";
    assert_eq!(code[start..end].matches(writer).count(), 1);
    let reader = code[start..end].replace(writer, "if(connection_stage==4)fwp_trap(\"writer startup trap\"); fwp_task *writer = fwp_spawn_task(0, g_writer, c, 0, 0); if(connection_stage==5)fwp_cancel_tree(writer);");
    code.replace_range(start..end, &reader);
    let prefix = "static int connection_stage,connection_finals;static void *seen_connection,*seen_reader;\n";
    let fixture = include_str!("fixtures/grpc_server_connections.c");
    let controls = [
        (
            "fwp_cleanup_push(&accepted_owner, g_connect_ref_release, c);",
            "",
            0,
            238,
        ),
        (
            "                    g_conn_release(c);\n                    continue;",
            "                    continue;",
            1,
            238,
        ),
        (
            "        fwp_cleanup_push(&writer_owner, g_connect_ref_release, c);",
            "",
            4,
            252,
        ),
        (
            "    fwp_rc_dup(PTR(c));\n    j->c = c;",
            "    j->c = c;",
            6,
            254,
        ),
        (
            "    g_conn_drop(connection);\n#ifndef FWP_RESOURCE_NO_FREE",
            "    (void)connection;\n#ifndef FWP_RESOURCE_NO_FREE",
            7,
            246,
        ),
    ];
    let dir = fwp::cgen::TempDir::new("grpc-accepted-owners").unwrap();
    let binary = dir.join("connections.exe");
    // The no-reuse mode cannot be combined with ARC. Replay counted transport
    // ownership controls with tracing excluded as well as with ordinary stress.
    for (arc, opt) in [(false, "-O1"), (false, "-O2"), (true, "-O2")] {
        if no_reuse && arc {
            continue;
        }
        let code = if arc {
            format!("#define FWP_ARC_ONLY 1\n{code}")
        } else {
            code.clone()
        };
        if no_reuse {
            assert!(!code.contains("#define FWP_RESOURCE_OWNERS 1"));
            let counted = "#ifdef FWP_RESOURCE_OWNERS\n            fwp_rc_fresh(PTR(c));\n#endif";
            assert_eq!(code.matches(counted).count(), 1);
            // Enabling counts without counted channel owners must fail even
            // though the callback remains reachable by the tracing collector.
            let broken = code.replace(counted, "            fwp_rc_fresh(PTR(c));");
            for (runtime, expected) in [(&code, 0), (&broken, 239)] {
                fwp::cgen::compile_c(&format!("{prefix}{runtime}\n{fixture}"), &binary, opt)
                    .unwrap();
                for gc in ["off", "on"] {
                    let output = Command::new(&binary)
                        .arg("9")
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    assert_eq!(
                        output.status.code(),
                        Some(expected),
                        "{opt}/{gc}/no-reuse: {output:?}"
                    );
                }
            }
            continue;
        }
        // Counting an unsuccessful accept as a connection stops the fixture
        // before it can exercise any ownership. A forced readiness retry must
        // expose that old test-driver assumption on every host.
        let early_stop = fixture
            .replace("if(accept_calls)fwp_trap", "if(accept_calls++)fwp_trap")
            .replace("if(accepted!=FWP_INVALID_SOCKET)accept_calls++;", "");
        fwp::cgen::compile_c(&format!("{prefix}{code}\n{early_stop}"), &binary, opt).unwrap();
        let output = Command::new(&binary)
            .arg("7")
            .env("FWP_GC", "off")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert_eq!(output.status.code(), Some(237), "{opt}: {output:?}");
        for (needle, replacement, stage, expected) in controls {
            assert_eq!(code.matches(needle).count(), 1, "{needle}");
            let broken = code.replace(needle, replacement);
            fwp::cgen::compile_c(&format!("{prefix}{broken}\n{fixture}"), &binary, opt).unwrap();
            let output = Command::new(&binary)
                .arg(stage.to_string())
                .env("FWP_GC", "off")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                output.status.code(),
                Some(expected),
                "{opt}/{stage} omitted {needle}: {output:?}"
            );
        }
        fwp::cgen::compile_c(&format!("{prefix}{code}\n{fixture}"), &binary, opt).unwrap();
        let settings: &[(&str, &str, &str)] = if arc {
            &[("off", "0", "0")]
        } else {
            &[
                ("off", "1", "0"),
                ("off", "1", "1"),
                ("on", "1", "0"),
                ("on", "1", "1"),
            ]
        };
        for &(gc, verify, poison) in settings {
            for stage in 0..9 {
                let output = Command::new(&binary)
                    .arg(stage.to_string())
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert!(
                    output.status.success(),
                    "{opt}/arc={arc}/{gc}/{poison}/{stage}: {output:?}"
                );
            }
        }
    }
    if !no_reuse {
        // Generate this mode in a separate process; do not mutate process-wide
        // compiler options while Rust's test harness is running.
        let output = Command::new(std::env::current_exe().unwrap())
            .args([
                "--exact",
                "accepted_connections_release_after_startup_io_jobs_and_channels",
                "--nocapture",
            ])
            .env("FWP_REUSE", "0")
            .output()
            .unwrap();
        assert!(output.status.success(), "no-reuse compiler: {output:?}");
    }
}
