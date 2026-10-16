//! Invalid build options must fail before emitting an unintended artifact.
use std::process::Command;

#[test]
fn build_rejects_unknown_options_in_either_position() {
    let dir = fwp::cgen::TempDir::new("compiler-options").unwrap();
    let input = dir.join("input.fwp");
    let artifact = dir.join("unintended.c");
    std::fs::write(&input, "main = ()\n").unwrap();
    for option in ["--sharedlib", "--unknown", "--gc=banana", "-O99"] {
        for first in [false, true] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command
                .current_dir(dir.path())
                .args(["build", "--emit-c", "-o"])
                .arg(&artifact);
            if first {
                command.arg(option).arg(&input);
            } else {
                command.arg(&input).arg(option);
            }
            let output = command.output().unwrap();
            assert_eq!(output.status.code(), Some(2), "{output:?}");
            assert!(String::from_utf8_lossy(&output.stderr)
                .contains(&format!("unknown option `{option}`")));
            assert!(!artifact.exists(), "bad option emitted an artifact");
        }
    }
}

#[test]
fn build_requires_one_input_and_values_for_value_options() {
    let dir = fwp::cgen::TempDir::new("compiler-values").unwrap();
    let input = dir.join("input.fwp");
    std::fs::write(&input, "main = ()\n").unwrap();
    for option in ["-o", "--fn", "--link", "--service", "--pgo-input"] {
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .current_dir(dir.path())
            .args(["build", "--emit-c"])
            .arg(&input)
            .arg(option)
            .output()
            .unwrap();
        assert_eq!(output.status.code(), Some(2), "{output:?}");
        assert!(
            String::from_utf8_lossy(&output.stderr).contains(&format!("{option} needs a value"))
        );
        assert!(!input.with_extension("c").exists());
    }
    let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .current_dir(dir.path())
        .args(["build", "--emit-c"])
        .arg(&input)
        .arg(&input)
        .output()
        .unwrap();
    assert_eq!(output.status.code(), Some(2), "{output:?}");
    assert!(String::from_utf8_lossy(&output.stderr).contains("expected one input file"));
    assert!(!input.with_extension("c").exists());
}
