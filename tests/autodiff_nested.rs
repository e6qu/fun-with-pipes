//! Reverse-over-reverse records typed backward operations on enclosing tapes.
use std::process::{Command, Output};

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
    assert_eq!(reference.stdout, "True\n".repeat(9).as_bytes());
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
                .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t nested_budget=fwp_gc.budget;\n")
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
