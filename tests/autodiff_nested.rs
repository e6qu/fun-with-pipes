//! Reverse-over-reverse records typed backward operations on enclosing tapes.
use std::process::{Command, Output};
#[path = "support/c_instrument.rs"]
mod c_instrument;

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

const FUNCTIONS: &str = r#"
square : List[t] -> t where Ring[t], Dup[t]
square = head | option.unwrap-or zero | fork mul id id
cube : List[t] -> t where Ring[t], Dup[t]
cube = head | option.unwrap-or zero | fork mul id (fork mul id id)
with-unused : List[Rev[F64]] -> List[Rev[F64]]
with-unused = tap (length | ad.tape | ignore) | map (fork mul id id)
"#;
const MAIN: &str = r#"
main = [
    [0.0] | grad (grad square | sum) | eq [2.0] | echo,
    [3.0] | grad (grad (grad cube | sum) | sum) | eq [6.0] | echo,
    [2.0, 3.0] | rev.jacobian (map (fork mul id id)) | eq [[4.0, 0.0], [0.0, 6.0]] | echo,
    [2.0, 3.0] | rev.jacobian (grad product) | eq [[0.0, 1.0], [1.0, 0.0]] | echo,
    [0.5] | grad (grad (head | option.unwrap-or zero | sin) | sum)
        | head | option.unwrap-or zero | add (sin 0.5) | abs | lt 1e-14 | echo,
    [0.0f128] | grad (grad square | sum) | eq [2.0f128] | echo,
    [0.0f16] | grad (grad square | sum) | eq [2.0f16] | echo,
    [0.0bf16] | grad (grad square | sum) | eq [2.0bf16] | echo,
    [1.0] | grad (vjp-checkpointed {steps = 3, every = 2} (map (fork mul id id)) [one] | sum)
        | eq [56.0] | echo,
    range 0 65 | map (int.to-float | singleton | grad (grad square | sum))
        | flatten | sum | eq 130.0 | echo,
    [1.0] | grad (grad (rev._replay 300 (map (add one)) | square) | sum)
        | eq [2.0] | echo,
    range 0 16 | each (const [2.0, 3.0] | rev.jacobian with-unused
        | eq [[4.0, 0.0], [0.0, 6.0]] | echo),
] | ignore
"#;

#[test]
fn jacobian_output_count_keeps_its_callback_in_scope_without_optimization() {
    let dir = fwp::cgen::TempDir::new("jacobian-scope").unwrap();
    let source = dir.join("jacobian.fwp");
    std::fs::write(
        &source,
        format!("{FUNCTIONS}\nmain = [2.0, 3.0] | rev.jacobian with-unused | echo\n"),
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for raw in [false, true] {
        let mut command = Command::new(compiler);
        command.env_remove("FWP_NO_OPT");
        if raw {
            command.env("FWP_NO_OPT", "1");
        }
        let reference = checked(command.args(["run", "--interp"]).arg(&source));
        assert_eq!(reference.stdout, b"[[4.0, 0.0], [0.0, 6.0]]\n");
        assert!(reference.stderr.is_empty(), "{reference:?}");
        let cfile = dir.join("jacobian.c");
        let mut command = Command::new(compiler);
        command.env_remove("FWP_NO_OPT");
        if raw {
            command.env("FWP_NO_OPT", "1");
        }
        checked(
            command
                .args(["build", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("jacobian.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let actual = checked(&mut Command::new(binary));
            assert_eq!(actual.stdout, reference.stdout);
            assert!(actual.stderr.is_empty(), "{actual:?}");
        }
    }
}

#[test]
fn nested_reverse_derivatives_match_analytic_values_and_both_engines() {
    let dir = fwp::cgen::TempDir::new("fwp-nested-reverse").unwrap();
    let source = dir.join("nested.fwp");
    std::fs::write(&source, format!("{FUNCTIONS}{MAIN}")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(reference.stdout, "True\n".repeat(27).as_bytes());
    assert!(reference.stderr.is_empty());

    for opt in ["-O1", "-O2"] {
        let cfile = dir.join("nested.c");
        let mut build = Command::new(compiler);
        build
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile);
        checked(&mut build);
        let code = std::fs::read_to_string(cfile).unwrap();
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (runtime, main) = code.split_at(start);
        // Observe cleanup before the next expression, not just after global
        // shutdown. The Jacobian's counting pass creates an unused raw tape;
        // each of sixteen rounds must release it along with its row tapes.
        let print = "static V fwp_p_print(V s) {";
        assert_eq!(runtime.matches(print).count(), 1);
        let runtime = runtime.replace(
                print,
                &format!(
                "static unsigned nested_scope_checks;\nstatic void nested_tapes_finished(void);\n{print}\n    nested_tapes_finished();"
            ),
            );
        let runtime = format!("{runtime}\nstatic void nested_tapes_finished(void) {{\n    nested_scope_checks++;\n    if(fwp_owned_tapes)exit(196);\n    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)exit(197);\n}}\n");
        let checked_code = format!("{runtime}{}", main
                .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    size_t nested_live_bytes=0;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(nested_scope_checks != 27)exit(198);\n    if(fwp_owned_tapes)exit(193);\n    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)exit(194);\n    if(fwp_heap.live > nested_live_bytes)exit(195);\n"));
        let binary = dir.join("nested.exe");
        fwp::cgen::compile_c(&checked_code, &binary, opt).unwrap();
        let output = checked(Command::new(&binary).env("FWP_AD_WORKSPACE", "0"));
        assert_eq!(output.stdout, reference.stdout, "{opt}");
        assert_eq!(output.stderr, reference.stderr, "{opt}");

        let release =
            "    fwp_mem_free(owner->weights); fwp_mem_free(owner->adj); fwp_mem_free(owner);";
        assert_eq!(checked_code.matches(release).count(), 1);
        fwp::cgen::compile_c(&checked_code.replace(release, ""), &binary, opt).unwrap();
        assert_eq!(
            Command::new(&binary)
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap()
                .status
                .code(),
            Some(195)
        );
    }
}

#[test]
fn inactive_zero_control_preserves_nonzero_second_derivatives_at_zero() {
    let dir = fwp::cgen::TempDir::new("fwp-active-zero").unwrap();
    let source = dir.join("zero.fwp");
    // d²(x³)/dx² is zero at zero, but its derivative is six. A third
    // reverse level must retain that active zero through the backward pass.
    std::fs::write(
        &source,
        format!(
            "{FUNCTIONS}\nmain = [0.0] | grad (grad (grad cube | sum) | sum) | eq [6.0] | echo\n"
        ),
    )
    .unwrap();
    let cfile = dir.join("zero.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let correct = "if (fwp_apply_borrowed(owner->inactive_zero, 1, &a) == FWP_TRUE) continue;";
    assert_eq!(code.matches(correct).count(), 1);
    // Wrongly prune a zero Rev[F64] even if its tape vertex is active.
    let broken = code.replace(correct, "if (owner->elem->kind == K_RECORD && owner->elem->fields[0]->kind == K_F64 && fwp_f64(OBJ(a)->f[0]) == 0.0) continue;");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("zero.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        assert_eq!(checked(&mut Command::new(&binary)).stdout, b"True\n");
        fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
        assert_eq!(checked(&mut Command::new(&binary)).stdout, b"False\n");
    }
}

#[test]
fn nested_reverse_rejects_expired_and_unrelated_tapes() {
    let dir = fwp::cgen::TempDir::new("fwp-nested-errors").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (main, message) in [
        ("main = [1.0] | ad.scope rev._seed | .1 | grad square | echo", "used after the grad"),
        ("mixed : List[Rev[F64]] -> Rev[F64]\nmixed = ad.scope (both rev._seed rev._seed | both (.0 | .1 | head | option.unwrap-or zero) (.1 | .1 | head | option.unwrap-or zero) | uncurry add | .value)\nmain = [1.0] | grad mixed | echo", "two different grad computations"),
    ] {
        let source = dir.join("error.fwp");
        std::fs::write(&source, format!("{FUNCTIONS}\n{main}\n")).unwrap();
        let reference = Command::new(compiler).env("FWP_NO_OPT", "1").args(["run", "--interp"]).arg(&source).output().unwrap();
        assert!(!reference.status.success());
        assert!(String::from_utf8_lossy(&reference.stderr).contains(message), "{reference:?}");
        let binary = dir.join("error.exe");
        checked(Command::new(compiler).args(["build"]).arg(&source).arg("-o").arg(&binary));
        let output = Command::new(binary).output().unwrap();
        assert!(!output.status.success());
        assert!(String::from_utf8_lossy(&output.stderr).contains(message), "{output:?}");
    }
}

#[test]
fn managed_tapes_release_across_recovered_failure_and_task_cancellation() {
    let dir = fwp::cgen::TempDir::new("fwp-nested-unwind").unwrap();
    let source = dir.join("unwind.fwp");
    std::fs::write(&source, format!("{FUNCTIONS}\nprobe : List[F64] -> List[F64] ! {{Error[String]}}\nprobe = grad (grad square | sum)\nmain = [1.0] | attempt probe | ignore\n")).unwrap();

    let cfile = dir.join("unwind.c");
    let mut build = Command::new(env!("CARGO_BIN_EXE_fwp"));
    build
        .args(["build", "--emit-c"])
        .arg(&source)
        .arg("-o")
        .arg(&cfile);
    checked(&mut build);
    let original = std::fs::read_to_string(cfile).unwrap();
    assert!(original.contains("#define FWP_UNWIND 1"));
    let main = original
        .split("static void *fwp_main_thread(void *arg)")
        .nth(1)
        .unwrap()
        .split("    V r = ")
        .nth(1)
        .unwrap()
        .split("();")
        .next()
        .unwrap();
    let start = original
        .find("static void fwp_owned_tape_release(void *pointer)")
        .unwrap();
    let end = start
        + original[start..]
            .find("static void fwp_owned_tape_reserve")
            .unwrap();
    let release = c_instrument::calls(&original[start..end], &[("fwp_mem_free", "nested_free")])
            .replace("    if (!owner) return;", "    if (!owner) return;\n    nested_expected_frees += 1 + (owner->weights != NULL) + (owner->adj != NULL);");
    let mut code = format!("{}\nstatic size_t nested_expected_frees;\nstatic void nested_point(int);\nstatic void nested_free(void *);\n{release}{}", &original[..start], &original[end..]);
    for (point, marker) in [
            (
                1,
                "    V base = fwp_ad_tape_new((V)n, owner);\n    fwp_cleanup_pop(&cleanup);",
            ),
            (2, "    owner->len = t->len = idx + 1;"),
            (11, "        fwp_cleanup_push(&weight_cleanup, fwp_value_release, &weight);"),
            (
                3,
                "    fwp_cleanup_push(&value_cleanup, fwp_owned_tape_release, owner);",
            ),
            (
                4,
                "            fwp_cleanup_push(&product_cleanup, fwp_value_release, &product);",
            ),
            (
                5,
                "        result.value = fwp_rc_fresh(fwp_cons(value, result.value));\n    }\n    fwp_cleanup_pop(&result_cleanup);\n    fwp_cleanup_pop(&value_cleanup);",
            ),
            (7, "    V zero = OBJ(parameters)->f[0];"),
            (8, "    owner->zero = zero;"),
            (9, "    V callback = OBJ(parameters)->f[1]; fwp_rc_dup(callback); owner->add = callback;"),
            (10, "    callback = OBJ(parameters)->f[2]; fwp_rc_dup(callback); owner->mul = callback;"),
        ] {
            assert_eq!(code.matches(marker).count(), 1, "stage {point}");
            let injected = if point == 5 {
                marker.replace("    }\n    fwp_cleanup_pop(&result_cleanup);", "        nested_point(5);\n    }\n    fwp_cleanup_pop(&result_cleanup);")
            } else {
                format!("{marker}\n    nested_point({point});")
            };
            code = code.replace(marker, &injected);
        }
    code = code.replace(
        "int main(int argc, char **argv)",
        "int unused_main(int argc, char **argv)",
    );
    let probe = include_str!("fixtures/autodiff_nested_unwind.c")
        .replace("NESTED_MAIN", main)
        .replace(
            "static size_t nested_expected_frees, nested_actual_frees;",
            "static size_t nested_actual_frees;",
        );
    code.push_str(&probe);
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("unwind.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for mode in 0..=11 {
            checked(
                Command::new(&binary)
                    .arg(mode.to_string())
                    .env("FWP_AD_WORKSPACE", "0"),
            );
        }
        let broken = code.replace("nested_free(owner->weights);", "(void)owner->weights;");
        assert_ne!(broken, code);
        fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
        assert_eq!(
            Command::new(&binary)
                .arg("4")
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap()
                .status
                .code(),
            Some(195)
        );

        let registration = "        fwp_cleanup_push(&weight_cleanup, fwp_value_release, &weight);";
        let missing_weight = code.replace(registration, "");
        fwp::cgen::compile_c(&missing_weight, &binary, opt).unwrap();
        assert_eq!(
            Command::new(&binary)
                .arg("11")
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap()
                .status
                .code(),
            Some(197)
        );

        let seed_cleanup = "    fwp_cleanup_push(&cleanup, fwp_owned_tape_release, owner);";
        assert_eq!(code.matches(seed_cleanup).count(), 1);
        let missing_seed_owner = code.replace(seed_cleanup, "");
        fwp::cgen::compile_c(&missing_seed_owner, &binary, opt).unwrap();
        assert_eq!(
            Command::new(&binary)
                .arg("8")
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap()
                .status
                .code(),
            Some(193)
        );
    }
}

// These programs fail admission; runtime identity checks are tested separately
// with explicit C owners rather than an execution-mode bypass.
fn rejects_escaped_tapes(source: &str) {
    let dir = fwp::cgen::TempDir::new("escaped-tapes").unwrap();
    let input = dir.join("escaped.fwp");
    std::fs::write(&input, source).unwrap();
    for raw in [false, true] {
        for args in [vec!["run", "--interp"], vec!["build", "--emit-c"]] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command.env_remove("FWP_NO_OPT");
            if raw {
                command.env("FWP_NO_OPT", "1");
            }
            let output = command.args(&args).arg(&input).output().unwrap();
            assert!(!output.status.success(), "{args:?}: {output:?}");
            assert!(output.stdout.is_empty(), "{output:?}");
            let error = String::from_utf8_lossy(&output.stderr);
            assert!(
                error.contains("ownership:") && error.contains("outside an autodiff scope"),
                "{error}"
            );
        }
    }
}

fn task_identity_runtime() -> String {
    let dir = fwp::cgen::TempDir::new("tape-identity-runtime").unwrap();
    let input = dir.join("runtime.fwp");
    let cfile = dir.join("runtime.c");
    std::fs::write(&input, "main = echo \"runtime\"\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let runtime = std::fs::read_to_string(cfile).unwrap().replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    format!(
        "{runtime}\n{}",
        include_str!("fixtures/autodiff_task_identity.c")
    )
}

#[test]
fn completed_task_identity_cannot_be_reused_by_a_later_task() {
    rejects_escaped_tapes(include_str!("fixtures/ad_task_reuse.fwp"));
    let dir = fwp::cgen::TempDir::new("retired-tape-task").unwrap();
    let code = task_identity_runtime();
    let identity = "    task->identity = ++fwp_task_identity;";
    assert_eq!(code.matches(identity).count(), 1);
    let repeated = code.replace(identity, "    task->identity = 1;");
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [(&code, 101), (&repeated, 0)] {
            let binary = dir.join("identity.exe");
            fwp::cgen::compile_c(source, &binary, opt).unwrap();
            let output = Command::new(binary)
                .arg("2")
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap();
            assert_eq!(output.status.code(), Some(expected), "{output:?}");
            assert!(output.stdout.is_empty(), "{output:?}");
            if expected == 101 {
                assert_eq!(
                    output.stderr,
                    b"fwp: trap: autodiff: managed tape belongs to another task\n"
                );
            } else {
                assert!(output.stderr.is_empty(), "{output:?}");
            }
        }
    }
}

#[test]
fn admission_rejects_escaped_tapes_and_runtime_checks_task_identity() {
    rejects_escaped_tapes(
        r#"
work : List[Rev[Rev[F64]]] -> () -> Rev[Rev[F64]]
work = curry (.0 | head | option.unwrap-or zero | fork mul id id)
main = [1.0] | rev._seed | .1 | rev._seed | .1
    | compose work task.spawn | task.await | ignore
"#,
    );
    let dir = fwp::cgen::TempDir::new("cross-task-tape").unwrap();
    let code = task_identity_runtime();
    let guard = "    if (owner->task != (fwp_cur == fwp_root ? 0 : fwp_cur->identity))\n        fwp_trap(\"autodiff: managed tape belongs to another task\");";
    assert_eq!(code.matches(guard).count(), 2);
    let unchecked = code.replace(guard, "");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("identity.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for (mode, expected) in [("0", 0), ("1", 101)] {
            let output = Command::new(&binary)
                .arg(mode)
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap();
            assert_eq!(output.status.code(), Some(expected), "{output:?}");
            assert!(output.stdout.is_empty(), "{output:?}");
            if expected == 101 {
                assert_eq!(
                    output.stderr,
                    b"fwp: trap: autodiff: managed tape belongs to another task\n"
                );
            } else {
                assert!(output.stderr.is_empty(), "{output:?}");
            }
        }
        fwp::cgen::compile_c(&unchecked, &binary, opt).unwrap();
        let output = checked(Command::new(binary).arg("1").env("FWP_AD_WORKSPACE", "0"));
        assert!(
            output.stdout.is_empty() && output.stderr.is_empty(),
            "{output:?}"
        );
    }
}
