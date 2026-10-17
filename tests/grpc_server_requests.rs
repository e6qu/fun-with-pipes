//! Pending parser requests and served input sources have independent owners.
use fwp::ir::*;
use std::process::Command;

#[test]
fn served_requests_survive_resets_jobs_and_retained_inputs() {
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
                name: "web".into(),
                arity: 0,
                locals: vec![],
                ty: unit,
                body: Body::Prim("http2.connect".into()),
            },
        ],
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (generated, _) = fwp::cgen::generate_library(&program, "request_owners").unwrap();
    let finalizer = "static void g_stream_final(void *p) {";
    assert_eq!(generated.matches(finalizer).count(), 1);
    let generated = generated.replace(finalizer, &format!("{finalizer}\n    request_finals++;"));
    let prefix = "static int request_finals;\n";
    let fixture = include_str!("fixtures/grpc_server_requests.c");
    let controls = [
        (
            "    fwp_rc_fresh(PTR(s)); /* active connection list */",
            "",
            0,
            232,
        ),
        (
            "    fwp_rc_dup(PTR(s));\n    l->v[l->n++] = s;",
            "    l->v[l->n++] = s;",
            1,
            233,
        ),
        (
            "    for (size_t i = 0; i < n; i++) g_stream_drop(values[i]);",
            "    (void)n;",
            2,
            239,
        ),
        ("    g_stream_drop(request);", "    (void)request;", 0, 239),
        (
            "    fwp_rc_dup(PTR(s));\n    j->s = s;",
            "    j->s = s;",
            0,
            234,
        ),
        (
            "    if (source->server) g_stream_drop(s);",
            "    if (source->server) g_stream_reader_release(c, s);",
            5,
            236,
        ),
        (
            "    fwp_cleanup_push(&peer_cleanup, g_job_peer_finish, j);",
            "",
            6,
            243,
        ),
    ];
    let dir = fwp::cgen::TempDir::new("grpc-request-owners").unwrap();
    let binary = dir.join("requests.exe");
    for opt in ["-O1", "-O2"] {
        for (needle, replacement, stage, expected) in controls {
            assert_eq!(generated.matches(needle).count(), 1, "{needle}");
            let broken = generated.replace(needle, replacement);
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
        fwp::cgen::compile_c(&format!("{prefix}{generated}\n{fixture}"), &binary, opt).unwrap();
        for gc in ["off", "on"] {
            for poison in ["0", "1"] {
                for stage in 0..7 {
                    let output = Command::new(&binary)
                        .arg(stage.to_string())
                        .env("FWP_GC", gc)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    assert!(
                        output.status.success(),
                        "{opt}/{gc}/{poison}/{stage}: {output:?}"
                    );
                }
            }
        }
    }
}
