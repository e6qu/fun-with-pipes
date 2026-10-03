//! Golden tests for program execution: every `tests/run/*.fwp` is run with
//! the interpreter and compiled to a native executable; stdout, stderr and
//! the exit code of both must match the `.out` file byte for byte. Run with
//! `FWP_BLESS=1` to regenerate (from the interpreter).

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

fn have_cc() -> bool {
    Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok()
}

/// Build a program natively and run the executable.
fn run_native(path: &Path) -> String {
    let exe = std::env::temp_dir().join(format!(
        "fwp-golden-{}-{}",
        std::process::id(),
        path.file_stem().unwrap().to_string_lossy()
    ));
    let build = Command::new(fwp())
        .arg("build")
        .arg(path.file_name().unwrap())
        .current_dir(path.parent().unwrap())
        .arg("-o")
        .arg(&exe)
        .arg("-O1")
        .output()
        .unwrap();
    if !build.status.success() {
        // compile errors are reported exactly as `fwp run` reports them
        return render(b"", &build.stderr, build.status.code().unwrap_or(-1));
    }
    let out = exec(Command::new(&exe), path);
    let _ = std::fs::remove_file(&exe);
    out
}

fn exec(mut cmd: Command, path: &Path) -> String {
    use std::io::Write;
    use std::process::Stdio;
    let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
    let mut child = cmd
        .current_dir(path.parent().unwrap())
        .env("FWP_SEED", "42")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(&input).unwrap();
    let out = child.wait_with_output().unwrap();
    render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1))
}

fn run(path: &Path) -> String {
    let mut cmd = Command::new(fwp());
    cmd.args(["run", "--interp"]).arg(path.file_name().unwrap());
    exec(cmd, path)
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
    let native = have_cc();
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
                "{} (interpreter):\n--- expected\n{}--- got\n{}",
                path.display(),
                want,
                got
            ));
        }
        if native {
            let got = run_native(&path);
            if got != want {
                failures.push(format!(
                    "{} (native):\n--- expected\n{}--- got\n{}",
                    path.display(),
                    want,
                    got
                ));
            }
        }
    }
    if !failures.is_empty() {
        panic!("{}", failures.join("\n"));
    }
}
