//! Establish the cost of repeated service scopes before changing their lifetimes.
use std::process::{Command, Output};

#[path = "support/http2_values.rs"]
mod http2_values;

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn instrument(code: &str) -> String {
    let declarations = r#"typedef uint64_t V;
static int context_measure;
static unsigned long long context_requests, context_bytes;
static double context_start_charge;
"#;
    assert_eq!(code.matches("typedef uint64_t V;").count(), 1);
    let mut code = code.replace("typedef uint64_t V;", declarations);
    for (signature, condition) in [
        (
            "static inline void *fwp_gc_alloc(size_t n, int leaf) {",
            "leaf != 0",
        ),
        ("static inline void *fwp_alloc_init(size_t n) {", "1"),
    ] {
        assert_eq!(code.matches(signature).count(), 1);
        code = code.replace(signature, &format!("{signature}\nif(context_measure && ({condition})){{context_requests++;context_bytes+=n;}}"));
    }
    let main = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    let (prefix, body) = code.split_at(main);
    assert_eq!(body.matches("    fwp_init_consts();\n").count(), 1);
    assert_eq!(body.matches("    fwp_cl_finish();\n").count(), 1);
    let body = body.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    context_start_charge=fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);context_measure=1;\n")
        .replace("    fwp_cl_finish();\n", r#"    fwp_cl_finish();
    context_measure=0;
    fprintf(stderr,"context %llu %llu %.0f %zu\n",context_requests,context_bytes,
        fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget)-context_start_charge,fwp_gc.ncollect);
#ifdef FWP_GCTX_OWNERS
    fprintf(stderr,"layout %zu %zu %zu %zu\n",sizeof(g_ctx),_Alignof(g_ctx),sizeof(fwp_task),_Alignof(fwp_task));
#else
    fprintf(stderr,"layout 0 0 %zu %zu\n",sizeof(fwp_task),_Alignof(fwp_task));
#endif
"#);
    prefix.to_string() + &body
}

#[test]
fn repeated_service_scopes_preserve_state_and_report_storage() {
    let dir = fwp::cgen::TempDir::new("service-context-storage").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        ("plain", "const (add 1) | modify"),
        ("gzip", "const (const (add 1) | modify) | grpc.with-gzip"),
        (
            "deadline",
            "const (const (add 1) | modify) | grpc.with-deadline 1s",
        ),
        (
            "metadata",
            "const (const (add 1) | modify) | grpc.with-metadata [(\"X-Name\", \"one\\r\\ntwo\")]",
        ),
        (
            "capture",
            "const (const (add 1) | modify) | grpc.with-response-metadata | .0",
        ),
    ];
    let mut report = String::from(
        "case\titerations\tmanaged_requests\trequested_bytes\tfinal_charged_bytes\tcollections\n",
    );
    let mut measurements = std::collections::BTreeMap::new();
    let mut layouts =
        String::from("case\tcontext_bytes\tcontext_alignment\ttask_bytes\ttask_alignment\n");
    for (name, body) in cases {
        for count in [1, 32, 128] {
            let label = format!("{name}-{count}");
            let input = dir.join(format!("{label}.fwp"));
            let source = format!("# Each input triggers one state update; the final count must equal the input length.\nmain = range 0 {count} | run-state 0 (each ({body})) | .1 | echo\n");
            std::fs::write(&input, &source).unwrap();
            let raw = checked(
                Command::new(compiler)
                    .args(["run", "--interp"])
                    .env("FWP_NO_OPT", "1")
                    .arg(&input),
            );
            let optimized = checked(
                Command::new(compiler)
                    .args(["run", "--interp"])
                    .env_remove("FWP_NO_OPT")
                    .arg(&input),
            );
            assert_eq!(
                (&raw.stdout, &raw.stderr),
                (&optimized.stdout, &optimized.stderr)
            );
            assert_eq!(raw.stdout, format!("{count}\n").as_bytes());
            assert!(raw.stderr.is_empty());
            let cfile = dir.join(format!("{label}.c"));
            checked(
                Command::new(compiler)
                    .args(["build", "--gc", "tracing", "--emit-c", "-O2"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let generated = std::fs::read_to_string(&cfile).unwrap();
            let measured = instrument(&generated);
            let binary = dir.join(format!("{label}.exe"));
            fwp::cgen::compile_c(&measured, &binary, "-O2").unwrap();
            let output = checked(
                Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            assert_eq!(output.stdout, raw.stdout);
            let counters = String::from_utf8(output.stderr).unwrap();
            let lines: Vec<_> = counters.lines().collect();
            assert_eq!(lines.len(), 2, "{counters}");
            let layout: Vec<_> = lines[1].split_whitespace().collect();
            assert_eq!(layout.len(), 5, "{counters}");
            assert_eq!(layout[0], "layout");
            layouts.push_str(&format!("{label}\t{}\n", layout[1..].join("\t")));
            let fields: Vec<_> = lines[0].split_whitespace().collect();
            assert_eq!(fields.len(), 5, "{counters}");
            assert_eq!(fields[0], "context");
            let values: Vec<i64> = fields[1..]
                .iter()
                .map(|field| field.parse().unwrap())
                .collect();
            assert!(values[..3].iter().all(|value| *value >= 0), "{counters}");
            assert_eq!(values[3], 0, "measurement collected garbage: {counters}");
            measurements.insert((name, count), values.clone());
            report.push_str(&format!(
                "{name}\t{count}\t{}\t{}\t{}\t{}\n",
                values[0], values[1], values[2], values[3]
            ));
            if let Some(path) = std::env::var_os("FWP_CONTEXT_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                std::fs::write(path.join(format!("{label}.fwp")), &source).unwrap();
                std::fs::write(path.join(format!("{label}.c")), &generated).unwrap();
                std::fs::write(path.join(format!("{label}-measured.c")), &measured).unwrap();
                std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                std::fs::write(path.join("storage.tsv"), &report).unwrap();
                std::fs::write(path.join("layout.tsv"), &layouts).unwrap();
            }
        }
    }
    for name in ["gzip", "deadline"] {
        for metric in 0..3 {
            assert_eq!(
                measurements[&(name, 128)][metric] - measurements[&(name, 32)][metric],
                measurements[&("plain", 128)][metric] - measurements[&("plain", 32)][metric],
                "{name} scope allocates per call (metric {metric})"
            );
        }
    }
    eprintln!("{report}\n{layouts}");
    // These counts do not establish collector-free service execution. Raw TLS/capture buffers,
    // allocator metadata, pages and total process memory are outside this count.
}

#[test]
fn children_keep_scope_settings_after_return_failure_and_cancellation() {
    let generated = http2_values::generated();
    let start = generated.find("static V g_with_ctx(").unwrap();
    let end = start
        + generated[start..]
            .find("\nstatic V fwp_p_grpc_with_metadata")
            .unwrap();
    let callback = "V r = fwp_apply1(f, FWP_UNIT);";
    assert_eq!(generated[start..end].matches(callback).count(), 1);
    let method = generated[start..end].replace(callback, "V r = scope_callback(f);");
    let generated = format!("{}{}{}", &generated[..start], method, &generated[end..]);
    let hooks = "#include <stdint.h>\nstatic uintptr_t scope_callback(uintptr_t);\nstatic void inherited_child(void *, int);\n";
    let fixture = include_str!("fixtures/service_context_inheritance.c");
    let inherit = "    t->gctx = fwp_cur->gctx;";
    assert_eq!(generated.matches(inherit).count(), 1);
    let broken = generated.replace(
        inherit,
        &format!("{inherit}\n    if(t->cfn==inherited_child)t->gctx=0;"),
    );
    let snapshot = "    if (t->gctx) {\n        t->gctx_storage = *(const g_ctx *)t->gctx;\n        t->gctx = &t->gctx_storage;\n    }";
    assert_eq!(generated.matches(snapshot).count(), 1);
    let borrowed = generated.replace(snapshot, "");
    let dir = fwp::cgen::TempDir::new("service-context-inheritance").unwrap();
    let binary = dir.join("probe");
    for optimization in ["-O1", "-O2"] {
        for (source, expected) in [(&broken, 41), (&borrowed, 53)] {
            fwp::cgen::compile_c(
                &format!("{hooks}\n{source}\n{fixture}"),
                &binary,
                optimization,
            )
            .unwrap();
            let output = Command::new(&binary).env("FWP_GC", "off").output().unwrap();
            assert_eq!(
                output.status.code(),
                Some(expected),
                "invalid inherited settings: {output:?}"
            );
        }
        fwp::cgen::compile_c(
            &format!("{hooks}\n{generated}\n{fixture}"),
            &binary,
            optimization,
        )
        .unwrap();
        for collection in ["off", "on"] {
            for reuse in ["0", "1"] {
                let output = checked(
                    Command::new(&binary)
                        .env("FWP_GC", collection)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", reuse),
                );
                assert!(output.stdout.is_empty() && output.stderr.is_empty());
            }
        }
        if let Some(path) = std::env::var_os("FWP_CONTEXT_ARTIFACTS") {
            let path = std::path::PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::write(
                path.join("inheritance.c"),
                format!("{hooks}\n{generated}\n{fixture}"),
            )
            .unwrap();
            std::fs::copy(&binary, path.join(format!("inheritance{optimization}.exe"))).unwrap();
        }
    }
}
