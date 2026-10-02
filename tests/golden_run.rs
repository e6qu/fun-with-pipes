//! Golden tests for program execution: every `tests/run/*.fwp` is compiled
//! and run with the interpreter; stdout, stderr and the exit code are
//! compared with the `.out` file. Run with `FWP_BLESS=1` to regenerate.

use std::path::{Path, PathBuf};
use std::process::Command;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn render(stdout: &[u8], stderr: &[u8], code: i32) -> String {
    let mut s = String::from_utf8_lossy(stdout).to_string();
    if !stderr.is_empty() {
        s.push_str("--- stderr\n");
        s.push_str(&String::from_utf8_lossy(stderr));
    }
    if code != 0 {
        s.push_str(&format!("--- exit {}\n", code));
    }
    s
}

fn run(path: &Path) -> String {
    let out = Command::new(fwp())
        .arg("run")
        .arg(path.file_name().unwrap())
        .current_dir(path.parent().unwrap())
        .env("FWP_SEED", "42")
        .output()
        .unwrap();
    render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1))
}

#[test]
fn run_snapshots() {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/run");
    let bless = std::env::var("FWP_BLESS").is_ok();
    let mut entries: Vec<_> = std::fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    entries.sort();
    let mut failures = Vec::new();
    for path in entries {
        let got = run(&path);
        let out = path.with_extension("out");
        if bless {
            std::fs::write(&out, &got).unwrap();
            continue;
        }
        let want = std::fs::read_to_string(&out).unwrap_or_default();
        if got != want {
            failures.push(format!(
                "{}:\n--- expected\n{}--- got\n{}",
                path.display(),
                want,
                got
            ));
        }
    }
    if !failures.is_empty() {
        panic!("{}", failures.join("\n"));
    }
}
