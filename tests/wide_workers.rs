//! Unboxed wide workers preserve checked arithmetic and owned generic boundaries.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn numeric_tail_workers_bound_stack_and_preserve_preemption() {
    let dir = fwp::cgen::TempDir::new("wide-tail-stack").unwrap();
    let source = dir.join("tail.fwp");
    std::fs::write(
        &source,
        r#"
Spin = { a: I128, b: I128, remaining: I64 }
start : I64 -> Spin
start = make Spin { a = const 17i128, b = const 29i128, remaining = id }
rec rotate : Spin -> Spin
rotate = if (.remaining | eq 0) id
    (make Spin { a = .b, b = .a, remaining = .remaining | sub 1 } | rotate)
work : I64 -> () -> (I128, I128)
work = curry (.0 | start | rotate | both .a .b)
main = [
    task.spawn (work 32769) | task.await | echo,
    task.spawn (work 10000000) | tap (const () | task.yield)
        | tap task.cancel | task.await | echo,
] | ignore
"#,
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    // Raw evaluation has a finite recursive stack. Use a shallow odd count
    // for the semantic reference; the native case separately proves 32769
    // iterations fit the deliberately bounded task stack with the same swap.
    let reference_source = dir.join("reference.fwp");
    std::fs::write(
        &reference_source,
        std::fs::read_to_string(&source)
            .unwrap()
            .replace("work 32769", "work 33"),
    )
    .unwrap();
    let expected = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&reference_source),
    );
    assert!(String::from_utf8_lossy(&expected.stdout).ends_with("None\n"));
    let cfile = dir.join("tail.c");
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let generated = std::fs::read_to_string(cfile).unwrap();
    let code = generated.replace(
        "#define FWP_NATIVE_TASK_STACK ((size_t)256 << 20)",
        "#define FWP_NATIVE_TASK_STACK ((size_t)1 << 20)",
    );
    assert_ne!(code, generated);
    let start = code.find("/* native wide worker: rotate */").unwrap();
    let end = start + code[start..].find("\n}\n").unwrap() + 3;
    let worker = &code[start..end];
    let signature = worker.lines().nth(1).unwrap();
    let result_type = signature.split_whitespace().nth(1).unwrap();
    let name = signature
        .split_whitespace()
        .nth(2)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    assert!(
        worker.contains("fwp_wide_again:;\n    FWP_TICK();"),
        "{worker}"
    );
    assert!(worker.contains("goto fwp_wide_again;"), "{worker}");
    assert_eq!(worker.matches(&format!("{name}(")).count(), 1, "{worker}");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(if cfg!(windows) { "tail.exe" } else { "tail" });
        let run = || {
            Command::new(&binary)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap()
        };
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let actual = run();
        assert!(actual.status.success(), "{opt}: {actual:?}");
        assert_eq!(actual.stdout, expected.stdout, "{opt}");
        assert_eq!(actual.stderr, expected.stderr, "{opt}");
        // Force a real recursive call after removing the compiler's loop;
        // the barrier prevents the C compiler from reintroducing tail calls.
        let recursive = worker.replace("goto fwp_wide_again;", &format!(
            "{result_type} recursive = {name}(l0); __asm__ volatile(\"\" : : \"m\"(recursive) : \"memory\"); return recursive;"
        ));
        fwp::cgen::compile_c(&code.replacen(worker, &recursive, 1), &binary, opt).unwrap();
        let failed = run();
        assert_eq!(failed.status.code(), Some(101), "{opt}: {failed:?}");
        assert!(String::from_utf8_lossy(&failed.stderr).contains("stack overflow"));
        let unpreempted = worker.replace("    FWP_TICK();", "");
        fwp::cgen::compile_c(&code.replacen(worker, &unpreempted, 1), &binary, opt).unwrap();
        let wrong = run();
        assert!(wrong.status.success(), "{opt}: {wrong:?}");
        assert_ne!(
            wrong.stdout, expected.stdout,
            "missing preemption control did not fail"
        );
    }
}

#[test]
fn wide_workers_match_raw_arithmetic_and_reclaim_boundaries() {
    let dir = std::env::temp_dir().join(format!("fwp-wide-workers-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let cases = [
        ("records", include_str!("fixtures/wide_records.fwp")),
        ("values", r#"
rec sum-wide : I128 -> I128
sum-wide = if (le 0i128) (const 0i128) (fork add id (sub 1i128 | sum-wide))
rec sum-unsigned : U128 -> U128
sum-unsigned = if (eq 0u128) (const 0u128) (fork add id (sub 1u128 | sum-unsigned))
transform : I128 -> I128
transform = add 7i128 | mul 3i128 | sub 2i128 | div 2i128 | rem 17i128 | neg | abs
main = [
    range 0i128 33i128 | map sum-wide | both id id | echo,
    range 0u128 33u128 | map sum-unsigned | echo,
    range -20i128 20i128 | map transform | echo,
    range 0i128 17i128 | map (sum-wide | add) | map (apply 2i128) | echo,
] | ignore
"#),
        ("quad", r#"
rec sum-quad : F128 -> F128
sum-quad = if (le 0.0f128) (const 0.0f128) (fork add id (sub 1.0f128 | sum-quad))
transform : F128 -> F128
transform = abs | add 1.0f128 | sqrt | ln | exp | sin | cos | tan | round | neg
main = [
    [0.0f128, 1.0f128, 9.0f128, 32.0f128] | map sum-quad | both id id | echo,
    [-0.0f128, -2.5f128, 1.0000000000000000000000000000000002f128] | map transform | echo,
    [0.0f128, 5.0f128] | map (sum-quad | add) | map (apply 2.0f128) | echo,
] | ignore
"#),
        ("overflow", "work : I128 -> I128\nwork = add 1i128 | mul 2i128\nmain = 170141183460469231731687303715884105727i128 | work | echo\n"),
        ("division", "work : I128 -> I128\nwork = div -1i128\nmain = -170141183460469231731687303715884105728i128 | work | echo\n"),
        ("zero", "work : U128 -> U128\nwork = div 0u128\nmain = 3u128 | work | echo\n"),
        ("record-traps", "work : (I128, I128) -> (I128, I128)\nwork = make { 0 = .0 | add 1i128, 1 = .1 | div 0i128 }\nmain = (170141183460469231731687303715884105727i128, 0i128) | work | echo\n"),
    ];
    for (name, source) in cases {
        let input = dir.join(format!("{name}.fwp"));
        std::fs::write(&input, source).unwrap();
        let reference = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            reference.status.success(),
            matches!(name, "values" | "quad" | "records"),
            "{reference:?}"
        );
        for workers in ["0", "1"] {
            for gc in ["tracing", "arc"] {
                let cfile = dir.join(format!("{name}-{workers}-{gc}.c"));
                checked(
                    Command::new(env!("CARGO_BIN_EXE_fwp"))
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_WIDE_WORKERS", workers)
                        .args(["build", "--gc", gc, "--emit-c"])
                        .arg(&input)
                        .arg("-o")
                        .arg(&cfile),
                );
                let mut code = std::fs::read_to_string(cfile).unwrap();
                if matches!(name, "values" | "quad" | "records") {
                    assert_eq!(code.contains("/* native wide worker:"), workers == "1");
                    if workers == "1" {
                        if name == "records" {
                            assert!(code.contains("fwp_wide_record_"));
                            assert!(code.contains("/* native wide worker: walk */"));
                        }
                        for section in code.split("/* native wide worker:").skip(1) {
                            let body = section.split("\nstatic V f").next().unwrap();
                            assert!(
                                !body.contains("fwp_box_") && !body.contains("fwp_alloc"),
                                "{body}"
                            );
                        }
                    }
                    let start = code
                        .find("static void *fwp_main_thread(void *arg) {")
                        .unwrap();
                    let (runtime, main) = code.split_at(start);
                    let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    intptr_t wide_budget=fwp_gc.budget;\n")
                        .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(!FWP_USE_GC && fwp_gc.budget<wide_budget) exit(193);\n");
                    code = format!("{runtime}{main}");
                    // ARC has no collector; tracing stress intentionally changes its budget.
                    code = code.replace("!FWP_USE_GC", if gc == "arc" { "1" } else { "0" });
                }
                for opt in ["-O1", "-O2"] {
                    let binary = dir.join(format!("{name}-{workers}-{gc}{opt}"));
                    fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                    let actual = Command::new(binary)
                        .env("FWP_GC_STRESS", if gc == "arc" { "0" } else { "1" })
                        .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", if gc == "arc" { "0" } else { "1" })
                        .output()
                        .unwrap();
                    assert_eq!(
                        actual.status.code(),
                        reference.status.code(),
                        "{name}/{workers}/{gc}/{opt}: {actual:?}"
                    );
                    assert_eq!(actual.stdout, reference.stdout);
                    assert_eq!(actual.stderr, reference.stderr);
                }
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
