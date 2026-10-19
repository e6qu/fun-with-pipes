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
"#;
const MAIN: &str = r#"
main = [
    [0.0] | grad (grad square | sum) | eq [2.0] | echo,
    [3.0] | grad (grad (grad cube | sum) | sum) | eq [6.0] | echo,
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
] | ignore
"#;

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
    assert_eq!(reference.stdout, "True\n".repeat(10).as_bytes());
    assert!(reference.stderr.is_empty());
    for arc in [false, true] {
        for opt in ["-O1", "-O2"] {
            let cfile = dir.join("nested.c");
            let mut build = Command::new(compiler);
            build
                .args(["build", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile);
            if arc {
                build.args(["--gc", "arc"]);
            }
            checked(&mut build);
            let code = std::fs::read_to_string(cfile).unwrap();
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            let checked_code = format!("{runtime}{}", main
                .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t nested_budget=fwp_gc.budget_given;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_owned_tapes)exit(193);\n    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)exit(194);\n#if FWP_ARC_ONLY\n    if(fwp_gc.enabled || fwp_gc.ncollect || fwp_gc.budget<nested_budget)exit(195);\n#endif\n"));
            let binary = dir.join("nested.exe");
            fwp::cgen::compile_c(&checked_code, &binary, opt).unwrap();
            let output = checked(
                Command::new(&binary)
                    .env("FWP_AD_WORKSPACE", "0")
                    .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" }),
            );
            assert_eq!(output.stdout, reference.stdout, "arc={arc} {opt}");
            assert_eq!(output.stderr, reference.stderr, "arc={arc} {opt}");
            if arc {
                let release = "    fwp_mem_free(owner->weights); fwp_mem_free(owner->adj); fwp_mem_free(owner);";
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
            .args(["build", "--gc", "arc", "--emit-c"])
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
        checked(Command::new(compiler).args(["build", "--gc", "arc"]).arg(&source).arg("-o").arg(&binary));
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
    for arc in [false, true] {
        let cfile = dir.join("unwind.c");
        let mut build = Command::new(env!("CARGO_BIN_EXE_fwp"));
        build
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile);
        if arc {
            build.args(["--gc", "arc"]);
        }
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
                "    fwp_cleanup_pop(&cleanup);\n    FWP_KEEP_ALIVE(parameters);",
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
                        .env("FWP_AD_WORKSPACE", "0")
                        .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                        .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" }),
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
            if arc {
                let registration =
                    "        fwp_cleanup_push(&weight_cleanup, fwp_value_release, &weight);";
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
            }
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
}

#[test]
fn completed_task_identity_cannot_be_reused_by_a_later_task() {
    let dir = fwp::cgen::TempDir::new("fwp-tape-task-reuse").unwrap();
    let source = dir.join("reuse.fwp");
    std::fs::write(&source, include_str!("run/ad_task_reuse.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .args(["run", "--interp"])
        .arg(&source)
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    assert_eq!(reference.status.code(), Some(101), "{reference:?}");
    let cfile = dir.join("reuse.c");
    checked(
        Command::new(compiler)
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let identity = "    task->identity = ++fwp_task_identity;";
    assert_eq!(code.matches(identity).count(), 1);
    let broken = code.replace(
        identity,
        "    task->identity = 1; /* reuse a completed task identity */",
    );
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("reuse.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let actual = Command::new(&binary)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(actual.status.code(), reference.status.code(), "{actual:?}");
        assert_eq!(actual.stdout, reference.stdout);
        assert_eq!(actual.stderr, reference.stderr);
        fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
        assert_eq!(
            Command::new(&binary).output().unwrap().status.code(),
            Some(0)
        );
    }
}

#[test]
fn managed_tapes_reject_cross_task_use_in_both_engines() {
    let dir = fwp::cgen::TempDir::new("fwp-nested-task").unwrap();
    let source = dir.join("task.fwp");
    std::fs::write(
        &source,
        r#"
work : List[Rev[Rev[F64]]] -> () -> Rev[Rev[F64]]
work = curry (.0 | head | option.unwrap-or zero | fork mul id id)
main = [1.0] | rev._seed | .1 | rev._seed | .1
    | compose work task.spawn | task.await | ignore
"#,
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .args(["run", "--interp"])
        .arg(&source)
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    assert_eq!(reference.status.code(), Some(101), "{reference:?}");
    let message = "autodiff: managed tape belongs to another task";
    assert!(
        String::from_utf8_lossy(&reference.stderr).contains(message),
        "{reference:?}"
    );
    let binary = dir.join("task.exe");
    checked(
        Command::new(compiler)
            .args(["build", "-O2"])
            .arg(&source)
            .arg("-o")
            .arg(&binary),
    );
    let actual = Command::new(&binary)
        .env("FWP_GC_STRESS", "1")
        .env("FWP_GC_VERIFY", "1")
        .env("FWP_REUSE_VERIFY", "1")
        .output()
        .unwrap();
    assert_eq!(actual.status.code(), reference.status.code(), "{actual:?}");
    assert_eq!(actual.stdout, reference.stdout);
    assert!(
        String::from_utf8_lossy(&actual.stderr).contains(message),
        "{actual:?}"
    );
    // Starting the scheduler later must not change the root tape's identity.
    std::fs::write(
        &source,
        r#"
main = [1.0] | rev._seed | .1 | rev._seed | .1
    | tap (compose (const (const ())) task.spawn | task.await | ignore)
    | head | option.unwrap-or zero | fork mul id id | .value | .value | echo
"#,
    )
    .unwrap();
    let reference = checked(
        Command::new(compiler)
            .args(["run", "--interp"])
            .arg(&source)
            .env("FWP_NO_OPT", "1"),
    );
    assert_eq!(reference.stdout, b"1.0\n");
    checked(
        Command::new(compiler)
            .args(["build", "-O2"])
            .arg(&source)
            .arg("-o")
            .arg(&binary),
    );
    let actual = checked(
        Command::new(&binary)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1"),
    );
    assert_eq!(actual.stdout, reference.stdout);
    assert_eq!(actual.stderr, reference.stderr);
}
