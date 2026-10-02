//! The standard library's own in-language tests (`fwp test --std`).

use std::process::Command;

#[test]
fn std_tests_pass() {
    let out = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["test", "--std"])
        .output()
        .unwrap();
    let stdout = String::from_utf8_lossy(&out.stdout);
    let failed: Vec<&str> = stdout.lines().filter(|l| l.contains("FAILED")).collect();
    assert!(
        out.status.success() && failed.is_empty(),
        "std tests failed:\n{}\n{}",
        failed.join("\n"),
        String::from_utf8_lossy(&out.stderr)
    );
    assert!(stdout.contains("passed, 0 failed"));
}
