//! Self-tail recursion reuses frames in both execution backends.
use fwp::ir::{Body, Expr, Func, Program, MT};
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(out.status.success(), "{command:?}: {out:?}");
    out
}

#[test]
fn deep_self_recursion_preserves_swaps_aliases_effects_and_failure_order() {
    let cases = [
        (
            "tail-recursion",
            include_str!("fixtures/tail_recursion.fwp"),
            &b"0\n(\"right\", \"left\")\n3\n2\n1\nErr \"stop\"\n10\n42\n(\"sharedshared\", (\"sharedshared\", \"sharedshared\"))\n"[..],
            &["down", "swap"][..],
            &["count-back"][..],
        ),
        (
            "mixed-tail-recursion",
            include_str!("fixtures/mixed_tail_recursion.fwp"),
            &b"1\n(\"left!\", \"right\")\n(\"sharedshared\", (\"sharedshared!\", \"sharedshared\"))\n0\n3\n2\n1\nErr \"stop\"\nErr \"argument\"\n1\n"[..],
            &["mixed", "mixed-swap", "nested", "observed", "ordered", "wide-mixed"][..],
            &[][..],
        ),
        (
            "weak-tail-recursion",
            include_str!("fixtures/weak_tail_recursion.fwp"),
            &b"(True, True, True)\nTrue\nTrue\n3\n2\n1\nTrue\n"[..],
            &["weak-swap", "weak-failure"][..],
            &[][..],
        ),
        (
            "mutual-tail-recursion",
            include_str!("fixtures/mutual_tail_recursion.fwp"),
            &b"0\n1\n1\n0\n3\n2\n1\nErr \"stop\"\n"[..],
            &["$tail-pair"][..],
            &[][..],
        ),
    ];
    for (name, source, expected, tails, ordinary) in cases {
        let dir = fwp::cgen::TempDir::new(name).unwrap();
        let src = dir.join("program.fwp");
        let compiler = env!("CARGO_BIN_EXE_fwp");
        // Smaller raw recursion gives an independent semantic reference. Parity
        // is unchanged: the long swap count is odd in both versions.
        std::fs::write(&src, source.replace("200000", "20").replace("200001", "21")).unwrap();
        let raw = checked(
            Command::new(compiler)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src),
        );
        assert_eq!(raw.stdout, expected, "{name}");
        std::fs::write(&src, source).unwrap();
        let interpreted = checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_DUMP_IR", "1")
                .args(["run", "--interp"])
                .arg(&src),
        );
        assert_eq!(interpreted.stdout, raw.stdout);
        let diagnostics = String::from_utf8_lossy(&interpreted.stderr);
        for function in tails {
            assert!(
                diagnostics
                    .lines()
                    .any(|s| s.contains(&format!("{function}: frame loop"))),
                "{diagnostics}"
            );
        }
        for function in ordinary {
            assert!(
                diagnostics
                    .lines()
                    .any(|s| s.contains(&format!("{function}: ordinary calls"))),
                "{diagnostics}"
            );
        }
        {
            let cfile = dir.join("counted.c");
            let mut command = Command::new(compiler);
            command.env_remove("FWP_NO_OPT").args(["build", "--emit-c"]);

            checked(command.arg(&src).arg("-o").arg(&cfile));
            let mut code = std::fs::read_to_string(&cfile).unwrap();
            assert!(code.contains("fwp_self_again:"));
            // Observe actual frame addresses at every executed back edge.
            // Count each generated loop separately so unrelated caller frames
            // cannot hide growth or inflate the range being measured.
            let loops = code.matches("fwp_self_again:;").count();
            let mut index = 0;
            code = code
                .split("fwp_self_again:;")
                .enumerate()
                .map(|(part, text)| {
                    if part == 0 {
                        return text.to_string();
                    }
                    let probe = format!(
                        "fwp_self_again:;\n    volatile unsigned char tail_marker;\n    tail_probe({index}, (uintptr_t)&tail_marker);\n{text}"
                    );
                    index += 1;
                    probe
                })
                .collect();
            let marker = "typedef uint64_t V;";
            assert_eq!(code.matches(marker).count(), 1);
            code = code.replacen(
                marker,
                &format!(
                    r#"{marker}
static uintptr_t tail_low[{loops}], tail_high[{loops}];
static size_t tail_visits[{loops}];
static int tail_active;
static size_t tail_allocations, tail_requested_bytes;
static void tail_probe(size_t id, uintptr_t address) {{
    if (!tail_visits[id] || address < tail_low[id]) tail_low[id] = address;
    if (!tail_visits[id] || address > tail_high[id]) tail_high[id] = address;
    tail_visits[id]++;
}}
"#
                ),
                1,
            );
            for (marker, condition) in [
                ("static inline void *fwp_alloc_init(size_t n) {", "1"),
                (
                    "static inline void *fwp_heap_alloc(size_t n, int kind) {",
                    "kind != 0",
                ),
            ] {
                assert_eq!(code.matches(marker).count(), 1);
                code = code.replace(marker, &format!("{marker} if(tail_active && ({condition})) {{ tail_allocations++; tail_requested_bytes += n; }}"));
            }
            {
                let start = code
                    .find("static void *fwp_main_thread(void *arg) {")
                    .unwrap();
                let (runtime, main) = code.split_at(start);
                assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
                assert_eq!(
                    main.matches(
                        "    /* Ownership observation point: before runtime teardown. */\n"
                    )
                    .count(),
                    1
                );
                let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    size_t tail_live_bytes = fwp_heap.live;\n    tail_active = 1;\n")
                    .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live > tail_live_bytes) { fprintf(stderr, \"tail recursion retained %ld bytes\\n\", (long)(fwp_heap.live - tail_live_bytes)); exit(193); }\n");
                code = format!("{runtime}{main}");
            }
            let observation = "    /* Ownership observation point: before runtime teardown. */\n";
            code = code.replace(
                observation,
                &format!(
                    r#"{observation}
    size_t tail_total_visits = 0;
    if (getenv("FWP_TEST_TAIL_BAD_STACK")) {{ tail_low[0] = 0; tail_high[0] = 65537; }}
    for (size_t i = 0; i < {loops}; i++) {{
        tail_total_visits += tail_visits[i];
        if (tail_high[i] - tail_low[i] > 65536) exit(194);
    }}
    if (tail_total_visits < 200000) exit(195);
    tail_active = 0;
    const char *tail_report_path = getenv("FWP_TEST_TAIL_REPORT");
    if (tail_report_path) {{
        FILE *report = fopen(tail_report_path, "w");
        if (!report) exit(198);
        fprintf(report, "allocations %zu bytes %zu live-before %zu live-after %zu\n",
            tail_allocations, tail_requested_bytes, tail_live_bytes, fwp_heap.live);
        for (size_t i = 0; i < {loops}; i++)
            fprintf(report, "loop %zu visits %zu stack-range %zu\n", i, tail_visits[i],
                (size_t)(tail_high[i] - tail_low[i]));
        if (fclose(report)) exit(198);
    }}
"#
                ),
            );
            for opt in ["-O0", "-O2"] {
                let binary = dir.join(format!("counted{opt}.exe"));
                let report_path = dir.join(format!("counted{opt}.txt"));
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let output =
                    checked(Command::new(&binary).env("FWP_TEST_TAIL_REPORT", &report_path));
                assert_eq!(output.stdout, raw.stdout, "{name} counted {opt}");
                assert_eq!(output.stderr, raw.stderr, "{name} counted {opt}");
                let report = std::fs::read_to_string(&report_path).unwrap();
                assert_eq!(report.lines().count(), loops + 1);
                eprintln!("{name} {opt}\n{report}");
                let broken = Command::new(&binary)
                    .env("FWP_TEST_TAIL_BAD_STACK", "1")
                    .output()
                    .unwrap();
                assert_eq!(
                    broken.status.code(),
                    Some(194),
                    "stack observer: {broken:?}"
                );
                if let Some(path) = std::env::var_os("FWP_TAIL_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let label = format!("{name}-counted{opt}");
                    std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
                    std::fs::write(path.join(format!("{label}.txt")), &report).unwrap();
                    std::fs::write(path.join(format!("{label}.stdout")), &output.stdout).unwrap();
                    std::fs::write(path.join(format!("{label}.stderr")), &output.stderr).unwrap();
                    std::fs::write(
                        path.join(format!("{label}.status")),
                        format!("{:?}\n", output.status.code()),
                    )
                    .unwrap();
                    std::fs::write(
                        path.join(format!("{label}-bad-stack.status")),
                        format!("{:?}\n", broken.status.code()),
                    )
                    .unwrap();
                    std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                    let mut disassemble = Command::new(if cfg!(target_os = "macos") {
                        "otool"
                    } else if cfg!(windows) {
                        "llvm-objdump"
                    } else {
                        "objdump"
                    });
                    disassemble
                        .arg(if cfg!(target_os = "macos") {
                            "-tvV"
                        } else {
                            "-d"
                        })
                        .arg(&binary);
                    let listing = checked(&mut disassemble);
                    assert!(!listing.stdout.is_empty(), "empty disassembly: {label}");
                    std::fs::write(path.join(format!("{label}.asm")), listing.stdout).unwrap();
                }
            }
        }
    }
}

#[test]
fn tail_loop_remains_cancellable() {
    let sources = [
        ("rec spin : () -> ()\nspin = const () | spin\nmain = task.within 10ms spin | echo\n", "None\n"),
        ("rec spin : I64 -> I64\nspin = match\n    0 -> 1 | spin | add 1\n    _ -> spin\nmain = task.within 10ms (const 1 | spin) | echo\n", "None\n"),
        ("rec weak-spin : WeakChannel[I64] -> WeakChannel[I64]\nweak-spin = id | weak-spin\nexpired : () -> WeakChannel[I64] ! {Async}\nexpired = const 1 | channel.make | channel.downgrade\nrun-weak : WeakChannel[I64] -> () -> WeakChannel[I64] ! {IO}\nrun-weak = curry (.0 | tap (const \"entered\" | echo) | weak-spin)\nmain = expired () | run-weak | task.within 100ms | option.is-none | echo\n", "entered\nTrue\n"),
        ("rec ping : I64 -> I64\nping = sub 1 | pong\nrec pong : I64 -> I64\npong = add 1 | ping\nmain = task.within 10ms (const 0 | ping) | echo\n", "None\n"),
    ];
    for (case, (source, expected)) in sources.into_iter().enumerate() {
        let dir = fwp::cgen::TempDir::new("tail-cancel").unwrap();
        let src = dir.join("cancel.fwp");
        std::fs::write(&src, source).unwrap();
        let compiler = env!("CARGO_BIN_EXE_fwp");
        let interpreted = checked(
            Command::new(compiler)
                .env("FWP_PREEMPT", "37")
                .args(["run", "--interp"])
                .arg(&src),
        );
        assert_eq!(interpreted.stdout, expected.as_bytes());
        let cfile = dir.join("cancel.c");
        checked(
            Command::new(compiler)
                .args(["build", "--emit-c"])
                .arg(&src)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        assert!(code.contains("fwp_self_again:;"));
        let code = code
            .replace(
                "typedef uint64_t V;",
                "typedef uint64_t V;\nstatic size_t tail_cancel_visits;",
            )
            .replace("fwp_self_again:;", "fwp_self_again:; tail_cancel_visits++;");
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (prefix, body) = code.split_at(start);
        let init = "    fwp_init_consts();\n";
        let observe = "    /* Ownership observation point: before runtime teardown. */\n";
        assert_eq!(body.matches(init).count(), 1);
        assert_eq!(body.matches(observe).count(), 1);
        let code = prefix.to_owned()
            + &body
                .replace(
                    init,
                    &format!("{init}    size_t tail_cancel_baseline = fwp_heap.live;\n"),
                )
                .replace(
                    observe,
                &format!("{observe}    if(fwp_heap.live != tail_cancel_baseline) exit(196);\n    if(tail_cancel_visits < 2) exit(197);\n"),
                );
        for optimization in ["-O0", "-O2"] {
            let binary = dir.join(format!("cancel{optimization}.exe"));
            fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
            let native = Command::new(&binary)
                .env("FWP_PREEMPT", "37")
                .output()
                .unwrap();
            if let Some(root) = std::env::var_os("FWP_TAIL_ARTIFACTS") {
                let root = std::path::PathBuf::from(root);
                std::fs::create_dir_all(&root).unwrap();
                let prefix = root.join(format!("cancel-{case}{optimization}"));
                std::fs::write(prefix.with_extension("c"), &code).unwrap();
                std::fs::copy(&binary, prefix.with_extension("exe")).unwrap();
                std::fs::write(prefix.with_extension("stdout"), &native.stdout).unwrap();
                std::fs::write(prefix.with_extension("stderr"), &native.stderr).unwrap();
                std::fs::write(
                    prefix.with_extension("status"),
                    format!("{:?}\n", native.status.code()),
                )
                .unwrap();
            }
            assert!(
                native.status.success(),
                "cancel case {case} {optimization}: {native:?}"
            );
            assert_eq!(native.stdout, interpreted.stdout);
        }
    }
}

#[test]
fn cleanup_and_unknown_captures_keep_their_original_frames() {
    let integer = MT::Con("std::I64".into(), vec![]);
    for ty in [
        MT::Con("std::File".into(), vec![]),
        MT::Con("std::Channel".into(), vec![integer.clone()]),
        MT::Con("std::Task".into(), vec![integer.clone()]),
        MT::Fun(Box::new(integer.clone()), Box::new(integer)),
    ] {
        let call = Expr::Call(0, vec![Expr::Local(0)]);
        let mut program = Program::default();
        program.funcs.push(Func {
            name: "keep-owner".into(),
            arity: 1,
            locals: vec![ty.clone()],
            ty: MT::Fun(Box::new(ty.clone()), Box::new(ty)),
            body: Body::Expr(call.clone()),
        });
        fwp::tailrec::analyze(&mut program);
        assert!(
            program.self_tail.is_empty(),
            "opaque owner must keep its frame"
        );
        program.funcs[0].body = Body::Expr(Expr::ResourceRegion {
            parameters: vec![0],
            bindings: vec![],
            body: Box::new(call),
        });
        fwp::tailrec::analyze(&mut program);
        assert!(
            program.self_tail.is_empty(),
            "cleanup cannot move before the call"
        );
    }
}
