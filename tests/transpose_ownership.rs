//! Transposed list structure owns aliases and cleans every partial column.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn transpose_preserves_values_and_reclaims_partial_construction() {
    let dir = fwp::cgen::TempDir::new("transpose-ownership").unwrap();
    let input = dir.join("transpose.fwp");
    std::fs::write(&input, include_str!("fixtures/transpose_ownership.fwp")).unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );

    let cfile = dir.join("counted.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let source = std::fs::read_to_string(&cfile).unwrap();
    assert!(source.contains("return fwp_p_list_transpose_owned(l0,"));
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("program.exe");
        fwp::cgen::compile_c(&source, &binary, opt).unwrap();
        let output = checked(&mut Command::new(&binary));
        assert_eq!(output.stdout, reference.stdout);
        assert_eq!(output.stderr, reference.stderr);
    }

    let a = source.find("static V fwp_p_list_transpose_owned(").unwrap();
    let b = a + source[a..].find("static V fwp_p_list_transpose(V").unwrap();
    let body = source[a..b].replace("fwp_cons(", "transpose_cons(");
    let measured = format!(
        "{}{body}{}\n{}",
        source[..a]
            .replace(
                "static V fwp_map_finish_protected(",
                "static V transpose_cons(V, V);\nstatic V fwp_map_finish_protected("
            )
            .replace(
                "V node = fwp_rc_fresh(fwp_data(1, 2, fields));",
                "V node = fwp_rc_fresh(transpose_cons(fields[0], fields[1]));"
            ),
        source[b..].replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)"
        ),
        include_str!("fixtures/transpose_ownership_probe.c")
    );
    let binary = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&measured, &binary, opt).unwrap();

        checked(&mut Command::new(&binary));
    }
    for (before, after, expected) in [
        (
            "if (dup_element) dup_element(value);",
            "/* omitted alias owner */",
            201,
        ),
        (
            "fwp_scratch_finish(&rows, &scratch_cleanup);",
            "fwp_cleanup_pop(&scratch_cleanup);",
            202,
        ),
    ] {
        assert_eq!(body.matches(before).count(), 1);
        let broken = measured.replacen(&body, &body.replace(before, after), 1);
        fwp::cgen::compile_c(&broken, &binary, "-O2").unwrap();
        let output = Command::new(&binary).output().unwrap();
        assert_eq!(output.status.code(), Some(expected), "{before}: {output:?}");
    }
}
