//! Explicit exit has no result owner and preserves status/output order in ARC.
use std::path::Path;
use std::process::{Command, Output};

const CASES: [i32; 7] = [0, 1, 255, 256, -1, i32::MIN, i32::MAX];

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn assert_exit(output: &Output, code: i32) {
    assert_eq!(output.status.code(), Some(code & 255), "{output:?}");
    assert_eq!(output.stdout, b"before\n", "{output:?}");
    assert!(output.stderr.is_empty(), "{output:?}");
}

fn input(dir: &fwp::cgen::TempDir) -> std::path::PathBuf {
    let input = dir.join("exit.fwp");
    std::fs::write(&input, include_str!("fixtures/process_exit_ownership.fwp")).unwrap();
    input
}

#[test]
fn explicit_exit_preserves_output_and_status_without_a_collector() {
    let dir = fwp::cgen::TempDir::new("process-exit-ownership").unwrap();
    let input = input(&dir);
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for code in CASES {
        for raw in [false, true] {
            let mut command = Command::new(compiler);
            command.args(["run", "--interp"]);
            if raw {
                command.env("FWP_NO_OPT", "1");
            } else {
                command.env_remove("FWP_NO_OPT");
            }
            let output = command
                .arg(&input)
                .arg("--")
                .arg(code.to_string())
                .output()
                .unwrap();
            assert_exit(&output, code);
        }
    }
    {
        let cfile = dir.join("exit.c");
        checked(
            Command::new(compiler)
                .args(["build", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let source = std::fs::read_to_string(&cfile).unwrap();
        let binary = dir.join("exit.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&source, &binary, opt).unwrap();
            for code in CASES {
                let output = Command::new(&binary)
                    .arg(code.to_string())
                    .output()
                    .unwrap();
                assert_exit(&output, code);
            }
            {
                let symbols = checked(Command::new("nm").arg(&binary));
                let symbols = String::from_utf8_lossy(&symbols.stdout);
                for tracing in ["fwp_heap_scan", "fwp_heap_mark_all", "fwp_heap_sweep"] {
                    assert!(!symbols.contains(tracing), "{symbols}");
                }
            }
        }
    }
}

#[test]
fn explicit_exit_uses_actual_wasi_process_status() {
    // Actual WASI jobs require their toolchain. Native-only jobs do not claim
    // WebAssembly coverage from this test.
    if std::env::var_os("FWP_REQUIRE_WASI_ARC").is_none() {
        eprintln!("actual WASI exit checks require the dedicated WASI toolchain job");
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-process-exit").unwrap();
    let input = input(&dir);
    let cfile = dir.join("exit.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--target", "wasm32-wasi", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let source = std::fs::read_to_string(cfile).unwrap();
    let binary = dir.join("exit.wasm");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_for(&source, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
        for code in CASES {
            let output = Command::new("node")
                .arg("--no-warnings")
                .arg(Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/wasm/wasi-run.mjs"))
                .arg(&binary)
                .arg(code.to_string())
                .output()
                .unwrap();
            assert_exit(&output, code);
        }
    }
}
