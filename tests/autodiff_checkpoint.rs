//! Segmented reverse replay: semantic agreement, bounded tape storage and owners.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

const SOURCE: &str = r#"
nonlinear : List[t] -> List[t] where Floating[t]
nonlinear = map sin
close : List[F64] -> List[F64] -> Bool
close = zip-with sub | flip compose (map abs | all (lt 1e-14))
main = [
    [2.0, 3.0] | vjp-checkpointed {steps = 9, every = 4} (map (add 1.0)) [2.0, 3.0] | echo,
    [2.0, 3.0] | vjp-checkpointed {steps = 0, every = 4} (const "unused" | prim.trap) [4.0, 5.0] | echo,
    [2.0] | vjp-checkpointed {steps = 3, every = 10} (map (mul 2.0)) [1.0] | echo,
    [0.5, 0.75] | fork close
        (vjp (rev._replay 17 nonlinear) [1.0, 2.0])
        (vjp-checkpointed {steps = 17, every = 4} nonlinear [1.0, 2.0]) | echo,
    [1.0f128] | vjp-checkpointed {steps = 3, every = 2} (map (mul 2.0)) [1.0f128] | eq [8.0f128] | echo,
    [1.0f16] | vjp-checkpointed {steps = 3, every = 2} (map (mul 2.0)) [1.0f16] | eq [8.0f16] | echo,
    [1.0bf16] | vjp-checkpointed {steps = 3, every = 2} (map (mul 2.0)) [1.0bf16] | eq [8.0bf16] | echo,
    [1.0, 2.0] | vjp-checkpointed {steps = 3, every = 2} (map (mul 2.0) | Cons 1.0) [1.0, 1.0, 1.0, 1.0, 1.0] | echo,
] | ignore
"#;

#[test]
fn checkpointed_vjp_matches_explicit_segment_precision_and_raw_execution() {
    let dir = fwp::cgen::TempDir::new("fwp-checkpoint-semantics").unwrap();
    let source = dir.join("checkpoint.fwp");
    std::fs::write(&source, SOURCE).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(
        String::from_utf8_lossy(&reference.stdout),
        "[2.0, 3.0]\n[4.0, 5.0]\n[8.0]\nTrue\nTrue\nTrue\nTrue\n[8.0, 8.0]\n"
    );
    assert!(reference.stderr.is_empty());
    for mode in ["tracing", "arc"] {
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("checkpoint.exe");
            let mut build = Command::new(compiler);
            build.arg("build").arg(&source).arg(opt);
            if mode == "arc" {
                build.args(["--gc", "arc"]);
            }
            checked(build.arg("-o").arg(&binary));
            let output = checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", if mode == "arc" { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if mode == "arc" { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if mode == "arc" { "0" } else { "1" }),
            );
            assert_eq!(output.stdout, reference.stdout, "{mode} {opt}");
            assert_eq!(output.stderr, reference.stderr, "{mode} {opt}");
        }
    }
}

#[test]
fn checkpoint_arguments_fail_before_replay_and_reject_wrong_seed_counts() {
    let dir = fwp::cgen::TempDir::new("fwp-checkpoint-errors").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (config, seeds, error) in [
        (
            "{steps = -1, every = 2}",
            "[1.0]",
            "steps must be nonnegative",
        ),
        (
            "{steps = 0, every = 0}",
            "[1.0]",
            "interval must be positive",
        ),
        (
            "{steps = 0, every = 2}",
            "[]",
            "seed count differs from output count",
        ),
        (
            "{steps = 3, every = 2}",
            "[]",
            "seed count differs from output count",
        ),
    ] {
        let source = dir.join("error.fwp");
        std::fs::write(
            &source,
            format!("main = [2.0] | vjp-checkpointed {config} (map (mul 2.0)) {seeds} | echo\n"),
        )
        .unwrap();
        let reference = Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source)
            .output()
            .unwrap();
        assert!(!reference.status.success());
        assert!(
            String::from_utf8_lossy(&reference.stderr).contains(error),
            "{reference:?}"
        );
        for mode in ["tracing", "arc"] {
            let binary = dir.join("error.exe");
            let mut build = Command::new(compiler);
            build.arg("build").arg(&source);
            if mode == "arc" {
                build.args(["--gc", "arc"]);
            }
            checked(build.arg("-o").arg(&binary));
            let output = Command::new(binary).output().unwrap();
            assert!(!output.status.success());
            assert!(
                String::from_utf8_lossy(&output.stderr).contains(error),
                "{output:?}"
            );
        }
    }
}

#[test]
fn checkpoint_tapes_are_bounded_and_released_without_collection() {
    let dir = fwp::cgen::TempDir::new("fwp-checkpoint-memory").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let mut peaks = Vec::new();
    for checkpointed in [false, true] {
        let source = dir.join("memory.fwp");
        let call = if checkpointed {
            "vjp-checkpointed {steps = 4096, every = 32} (map (add 1.0)) [1.0]"
        } else {
            "vjp (rev._replay 4096 (map (add 1.0))) [1.0]"
        };
        std::fs::write(&source, format!("main = [2.0] | {call} | echo\n")).unwrap();
        let cfile = dir.join("memory.c");
        checked(
            Command::new(compiler)
                .args(["build", "--gc", "arc", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let code = code
            .replace(
                "static fwp_tape *fwp_tapes = 0;",
                "static int64_t checkpoint_peak;\nstatic fwp_tape *fwp_tapes = 0;",
            )
            .replace(
                "    t->cap = cap;",
                "    t->cap = cap;\n    if(cap > checkpoint_peak) checkpoint_peak=cap;",
            );
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (runtime, main) = code.split_at(start);
        let code = format!("{runtime}{}", main
            .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t checkpoint_budget=fwp_gc.budget_given;\n")
            .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    for(int64_t i=0;i<fwp_ntapes;i++) if(fwp_tapes[i].live)exit(193);\n    if(fwp_gc.enabled || fwp_gc.ncollect || fwp_gc.budget < checkpoint_budget)exit(194);\n    fprintf(stderr,\"%lld\\n\",(long long)checkpoint_peak);\n"));
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("memory.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let output = checked(Command::new(&binary).env("FWP_AD_WORKSPACE", "0"));
            assert_eq!(output.stdout, b"[1.0]\n");
            let peak: i64 = std::str::from_utf8(&output.stderr)
                .unwrap()
                .trim()
                .parse()
                .unwrap();
            if checkpointed {
                assert!(peak <= 64, "{peak}");
            } else {
                assert_eq!(peak, 4096, "only recorded operations need metadata");
            }
            peaks.push((checkpointed, opt, peak));
            if checkpointed {
                assert_eq!(code.matches("        fwp_tape_retire(t);").count(), 1);
                let broken = code.replace("        fwp_tape_retire(t);", "");
                fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
                assert_eq!(
                    Command::new(&binary)
                        .env("FWP_AD_WORKSPACE", "0")
                        .output()
                        .unwrap()
                        .status
                        .code(),
                    Some(193)
                );
            }
        }
    }
    if let Some(directory) = std::env::var_os("FWP_AD_WORKSPACE_ARTIFACTS") {
        std::fs::create_dir_all(&directory).unwrap();
        std::fs::write(
            std::path::PathBuf::from(directory).join("checkpoint-capacity.txt"),
            format!("{peaks:?}\n"),
        )
        .unwrap();
    }
}
