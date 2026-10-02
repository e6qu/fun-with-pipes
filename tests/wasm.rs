//! WebAssembly: every golden run test is compiled with
//! `--target wasm32-wasi` and run under node's WASI; the output must match
//! the `.out` file. Programs using effects WASI does not provide (tasks,
//! sockets) must be rejected at compile time. The browser target is run
//! through its JavaScript loader. Skipped when clang cannot target WASI or
//! node is missing.

use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests")
}

fn available() -> bool {
    let probe = std::env::temp_dir().join(format!("fwp-wasm-probe-{}.wasm", std::process::id()));
    let src = std::env::temp_dir().join(format!("fwp-wasm-probe-{}.c", std::process::id()));
    std::fs::write(&src, "int main(void) { return 0; }\n").unwrap();
    let ok = Command::new(std::env::var("FWP_WASM_CC").unwrap_or_else(|_| "clang".into()))
        .args(["--target=wasm32-wasi", "-o"])
        .arg(&probe)
        .arg(&src)
        .output()
        .map(|o| o.status.success())
        .unwrap_or(false)
        && Command::new("node").arg("--version").output().is_ok();
    let _ = std::fs::remove_file(&probe);
    let _ = std::fs::remove_file(&src);
    if !ok {
        eprintln!("skipping: no clang wasm32-wasi toolchain or node");
    }
    ok
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

fn build(path: &Path, target: &str, out: &Path) -> std::process::Output {
    Command::new(fwp())
        .arg("build")
        .arg(path.file_name().unwrap())
        .args(["--target", target, "-O1", "-o"])
        .arg(out)
        .current_dir(path.parent().unwrap())
        .output()
        .unwrap()
}

#[test]
fn golden_programs_under_wasi() {
    if !available() {
        return;
    }
    let mut ran = 0;
    let mut failures = Vec::new();
    let mut entries: Vec<_> = std::fs::read_dir(dir().join("run"))
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    entries.sort();
    for path in entries {
        let expected = match std::fs::read_to_string(path.with_extension("out")) {
            Ok(s) => s,
            Err(_) => continue,
        };
        let wasm = std::env::temp_dir().join(format!(
            "fwp-wasm-{}-{}.wasm",
            std::process::id(),
            path.file_stem().unwrap().to_string_lossy()
        ));
        let b = build(&path, "wasm32-wasi", &wasm);
        let stderr = String::from_utf8_lossy(&b.stderr);
        if !b.status.success() {
            if stderr.contains("does not provide the") {
                // tasks and sockets: rejected at compile time, as required
                continue;
            }
            let got = render(b"", &b.stderr, b.status.code().unwrap_or(-1));
            if got != expected {
                failures.push(format!("{}: build failed:\n{}", path.display(), stderr));
            }
            continue;
        }
        let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
        let mut child = Command::new("node")
            .arg("--no-warnings")
            .arg(dir().join("wasm/wasi-run.mjs"))
            .arg(&wasm)
            .current_dir(path.parent().unwrap())
            .env("FWP_SEED", "42")
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()
            .unwrap();
        {
            use std::io::Write;
            child.stdin.take().unwrap().write_all(&input).unwrap();
        }
        let out = child.wait_with_output().unwrap();
        let _ = std::fs::remove_file(&wasm);
        let got = render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1));
        ran += 1;
        if got != expected {
            failures.push(format!(
                "{}:\n--- expected\n{}--- got\n{}",
                path.display(),
                expected,
                got
            ));
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
    assert!(ran >= 10, "only {} programs ran", ran);
}

#[test]
fn unavailable_effects_are_rejected() {
    if !available() {
        return;
    }
    let path = dir().join("run/http.fwp");
    let out = build(
        &path,
        "wasm32-wasi",
        &std::env::temp_dir().join("fwp-wasm-reject.wasm"),
    );
    assert!(!out.status.success());
    assert_eq!(
        String::from_utf8_lossy(&out.stderr),
        "fwp build: the WebAssembly target does not provide the `Network` effect (used by `tcp.listen`)\n"
    );
    let out = build(
        &dir().join("run/cli_process.fwp"),
        "wasm32-wasi",
        &std::env::temp_dir().join("fwp-wasm-reject.wasm"),
    );
    assert!(!out.status.success());
    assert_eq!(
        String::from_utf8_lossy(&out.stderr),
        "fwp build: the WebAssembly target does not provide the `Process` effect (used by `process.call`)\n"
    );
}

#[test]
fn browser_loader() {
    if !available() {
        return;
    }
    let path = dir().join("run/basics.fwp");
    let wasm = std::env::temp_dir().join(format!("fwp-browser-{}.wasm", std::process::id()));
    let b = build(&path, "wasm32-browser", &wasm);
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let js = wasm.with_extension("js");
    let out = Command::new("node")
        .arg("--no-warnings")
        .arg(dir().join("wasm/browser-run.mjs"))
        .arg(&js)
        .output()
        .unwrap();
    let _ = std::fs::remove_file(&wasm);
    let _ = std::fs::remove_file(&js);
    assert!(out.status.success());
    assert_eq!(
        String::from_utf8_lossy(&out.stdout),
        std::fs::read_to_string(path.with_extension("out")).unwrap()
    );
}

#[test]
fn webassembly_tutorial_runs_under_wasi() {
    if !available() {
        return;
    }
    let tut = Path::new(env!("CARGO_MANIFEST_DIR")).join("docs/tutorials/10-webassembly");
    let wasm = std::env::temp_dir().join(format!("fwp-wasm-tutorial-{}.wasm", std::process::id()));
    let b = build(&tut.join("main.fwp"), "wasm32-wasi", &wasm);
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let out = Command::new("node")
        .arg("--no-warnings")
        .arg(dir().join("wasm/wasi-run.mjs"))
        .arg(&wasm)
        .output()
        .unwrap();
    let _ = std::fs::remove_file(&wasm);
    assert_eq!(
        String::from_utf8_lossy(&out.stdout),
        std::fs::read_to_string(tut.join("main.out")).unwrap()
    );
}
