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
    let dir = fwp::cgen::TempDir::new("tail-recursion").unwrap();
    let src = dir.join("program.fwp");
    let source = include_str!("fixtures/tail_recursion.fwp");
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
    assert_eq!(
        raw.stdout,
        b"0\n(\"right\", \"left\")\n3\n2\n1\nErr \"stop\"\n10\n42\n(\"sharedshared\", (\"sharedshared\", \"sharedshared\"))\n"
    );
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
    assert!(
        diagnostics.lines().any(|s| s.contains("down: frame loop")),
        "{diagnostics}"
    );
    assert!(
        diagnostics.lines().any(|s| s.contains("swap: frame loop")),
        "{diagnostics}"
    );
    assert!(
        diagnostics
            .lines()
            .any(|s| s.contains("count-back: ordinary calls")),
        "{diagnostics}"
    );
    for mode in ["tracing", "arc"] {
        let cfile = dir.join(format!("{mode}.c"));
        let mut command = Command::new(compiler);
        command.env_remove("FWP_NO_OPT").args(["build", "--emit-c"]);
        if mode == "arc" {
            command.args(["--gc", "arc"]);
        }
        checked(command.arg(&src).arg("-o").arg(&cfile));
        let mut code = std::fs::read_to_string(&cfile).unwrap();
        assert!(code.contains("fwp_self_again:"));
        if mode == "arc" {
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
            assert_eq!(main.matches("    fwp_cl_finish();\n").count(), 1);
            let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    intptr_t tail_budget = fwp_gc.budget;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.budget < tail_budget) { fprintf(stderr, \"tail recursion retained %ld bytes\\n\", (long)(tail_budget-fwp_gc.budget)); exit(193); }\n");
            code = format!("{runtime}{main}");
        }
        for opt in ["-O0", "-O2"] {
            let binary = dir.join(format!("{mode}{opt}.exe"));
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let output = checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", if mode == "tracing" { "1" } else { "0" })
                    .env("FWP_GC_VERIFY", if mode == "tracing" { "1" } else { "0" })
                    .env(
                        "FWP_REUSE_VERIFY",
                        if mode == "tracing" { "1" } else { "0" },
                    ),
            );
            assert_eq!(output.stdout, raw.stdout, "{mode} {opt}");
        }
    }
}

#[test]
fn tail_loop_remains_cancellable() {
    let dir = fwp::cgen::TempDir::new("tail-cancel").unwrap();
    let src = dir.join("cancel.fwp");
    std::fs::write(
        &src,
        "rec spin : () -> ()\nspin = const () | spin\nmain = task.within 10ms spin | echo\n",
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let interpreted = checked(
        Command::new(compiler)
            .env("FWP_PREEMPT", "37")
            .args(["run", "--interp"])
            .arg(&src),
    );
    assert_eq!(interpreted.stdout, b"None\n");
    let binary = dir.join("cancel.exe");
    checked(
        Command::new(compiler)
            .args(["build", "--gc", "arc", "-O0"])
            .arg(&src)
            .arg("-o")
            .arg(&binary),
    );
    let native = checked(Command::new(binary).env("FWP_PREEMPT", "37"));
    assert_eq!(native.stdout, interpreted.stdout);
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
