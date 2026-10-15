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
    for gc in ["tracing", "arc"] {
        for packing in ["0", "1"] {
            let cfile = dir.join("arrays.c");
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_PACKED_ARRAYS", packing)
                    .env("FWP_ARRAY_FUSION", "1")
                    .args(["build", "--gc", gc, "--emit-c"])
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
                let output = checked(
                    Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", if gc == "arc" { "0" } else { "1" })
                        .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", if gc == "arc" { "0" } else { "1" }),
                );
                assert_eq!(
                    output.stdout, expected.stdout,
                    "{gc} packing={packing} {optimization}"
                );
                assert_eq!(
                    output.stderr, expected.stderr,
                    "{gc} packing={packing} {optimization}"
                );
            }
        }
    }
}
