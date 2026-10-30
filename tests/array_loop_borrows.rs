//! Borrowed array data survives ownership transfer; changing arrays stay dynamic.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}
#[test]
fn invariant_and_changing_array_loops_match_interpretation() {
    let dir = fwp::cgen::TempDir::new("array-loop-borrows").unwrap();
    let source = dir.join("arrays.fwp");
    std::fs::write(&source, include_str!("fixtures/array_loop_borrows.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let expected = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    {
        for packing in ["0", "1"] {
            let cfile = dir.join("arrays.c");
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_PACKED_ARRAYS", packing)
                    .env("FWP_ARRAY_FUSION", "1")
                    .args(["build", "--emit-c"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(cfile).unwrap();
            assert!(
                code.contains("const unsigned char *array_data_"),
                "no invariant data borrow"
            );
            let advancing = code
                .split("/* loop of advancing :")
                .nth(1)
                .expect("changing loop");
            let advancing = advancing.split("/* loop of ").next().unwrap();
            // These arrays change after every step. Reusing their old data
            // pointer would either read the wrong elements or freed storage.
            assert!(!advancing.contains("const unsigned char *array_data_"));
            let binary = dir.join("arrays.exe");
            for optimization in ["-O1", "-O2"] {
                fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
                let output = checked(&mut Command::new(&binary));
                assert_eq!(
                    output.stdout, expected.stdout,
                    "counted packing={packing} {optimization}"
                );
                assert_eq!(
                    output.stderr, expected.stderr,
                    "counted packing={packing} {optimization}"
                );
            }
        }
    }
}

#[test]
fn known_scalar_array_folds_preserve_order_views_and_failure() {
    let dir = fwp::cgen::TempDir::new("scalar-array-folds").unwrap();
    let source = dir.join("folds.fwp");
    std::fs::write(&source, include_str!("fixtures/scalar_array_folds.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let optimized = checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(optimized.stdout, reference.stdout);
    assert_eq!(optimized.stderr, reference.stderr);
    for packing in ["0", "1"] {
        let cfile = dir.join("folds.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_PACKED_ARRAYS", packing)
                .env("FWP_ARRAY_FUSION", "0")
                .args(["build", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        assert!(code.contains("direct known scalar array fold; input stays borrowed"));
        let unknown = code
            .split("/* unknown :")
            .nth(1)
            .unwrap()
            .split("/* ")
            .next()
            .unwrap();
        assert!(
            !unknown.contains("fwp_hof"),
            "unknown callback was specialized"
        );
        for level in ["-O1", "-O2"] {
            let binary = dir.join("folds.exe");
            fwp::cgen::compile_c(&code, &binary, level).unwrap();
            let result = checked(&mut Command::new(binary));
            assert_eq!(result.stdout, reference.stdout, "{packing} {level}");
            assert_eq!(result.stderr, reference.stderr, "{packing} {level}");
        }
    }
}

#[test]
fn direct_scalar_array_fold_keeps_the_first_checked_overflow() {
    let dir = fwp::cgen::TempDir::new("scalar-array-fold-overflow").unwrap();
    let source = dir.join("overflow.fwp");
    std::fs::write(
        &source,
        r#"
step : I64 -> I64 -> I64 ! {IO}
step = curry (tap (.1 | echo) | uncurry add)
export checked-fold : Array[I64] -> I64 ! {IO}
checked-fold = array.fold step 0
main = [9223372036854775807, 1, 2] | array.from-list | checked-fold | echo
"#,
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(!reference.status.success());
    assert_eq!(reference.stdout, b"9223372036854775807\n1\n");
    assert!(String::from_utf8_lossy(&reference.stderr).contains("overflow"));
    let cfile = dir.join("overflow.c");
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .env("FWP_ARRAY_FUSION", "0")
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    assert!(code.contains("direct known scalar array fold; input stays borrowed"));
    for level in ["-O1", "-O2"] {
        let binary = dir.join("overflow.exe");
        fwp::cgen::compile_c(&code, &binary, level).unwrap();
        let result = Command::new(binary).output().unwrap();
        assert!(!result.status.success());
        assert_eq!(result.stdout, reference.stdout, "{level}");
        assert!(String::from_utf8_lossy(&result.stderr).contains("overflow"));
    }
}
