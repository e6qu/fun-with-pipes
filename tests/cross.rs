//! Cross-compilation (`fwp build --target aarch64-linux`): every golden
//! program built for 64-bit ARM Linux and run under qemu prints what it
//! prints on the host. Skipped without an aarch64 C compiler
//! (`aarch64-linux-gnu-gcc`) and `qemu-aarch64`; programs that use TLS
//! are skipped without the target's OpenSSL. Without qemu, a build
//! is still checked to be an aarch64 executable.
//!
//! With musl (`--target x86_64-linux-musl`, built with `musl-gcc` on an
//! x86-64 host), every golden program is built as a static executable
//! and run directly; the programs that use tasks are also run on aarch64
//! with the runtime's own task switch (`FWP_OWN_CONTEXT`, which musl
//! builds use) instead of glibc's `swapcontext`.

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

const TRIPLE: &str = "aarch64-linux-gnu";

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn have(prog: &str) -> bool {
    Command::new(prog)
        .arg("--version")
        .output()
        .is_ok_and(|o| o.status.success())
}

struct TempDir(PathBuf);

impl TempDir {
    fn new(name: &str) -> TempDir {
        let d = std::env::temp_dir().join(format!("fwp-cross-{}-{}", name, std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        std::fs::create_dir_all(&d).unwrap();
        TempDir(d)
    }
}

impl Drop for TempDir {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

fn build(src: &Path, exe: &Path, opts: &[&str]) -> Output {
    build_for("aarch64-linux", &[], src, exe, opts)
}

fn build_for(target: &str, env: &[(&str, &str)], src: &Path, exe: &Path, opts: &[&str]) -> Output {
    Command::new(fwp())
        .arg("build")
        .arg(src)
        .args(["--target", target, "-O1", "-o"])
        .arg(exe)
        .args(opts)
        .envs(env.iter().copied())
        .current_dir(src.parent().unwrap())
        .output()
        .unwrap()
}

fn render(o: &Output) -> String {
    let mut s = String::from_utf8_lossy(&o.stdout).to_string();
    if !o.stderr.is_empty() {
        s.push_str("--- stderr\n");
        s.push_str(&String::from_utf8_lossy(&o.stderr));
    }
    if let Some(c) = o.status.code().filter(|c| *c != 0) {
        s.push_str(&format!("--- exit {}\n", c));
    }
    s
}

/// Run an aarch64 executable under qemu, with the target's libraries.
fn run(exe: &Path, cwd: &Path, input: &[u8]) -> Output {
    let mut cmd = Command::new("qemu-aarch64");
    cmd.arg("-L").arg(format!("/usr/{}", TRIPLE)).arg(exe);
    run_cmd(cmd, cwd, input)
}

fn run_cmd(mut cmd: Command, cwd: &Path, input: &[u8]) -> Output {
    let mut child = cmd
        .current_dir(cwd)
        .env("FWP_SEED", "42")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(input).unwrap();
    child.wait_with_output().unwrap()
}

/// Whether the target's OpenSSL headers are installed (Debian and Ubuntu:
/// `libssl-dev:arm64`).
fn target_openssl() -> bool {
    Path::new(&format!("/usr/include/{}/openssl/opensslconf.h", TRIPLE)).exists()
}

/// The ELF machine of an executable (183 is aarch64).
fn elf_machine(exe: &Path) -> u16 {
    let b = std::fs::read(exe).unwrap();
    assert_eq!(&b[..4], b"\x7fELF", "{} is not an ELF file", exe.display());
    u16::from_le_bytes([b[18], b[19]])
}

#[test]
fn builds_for_aarch64() {
    if !have(&format!("{}-gcc", TRIPLE)) {
        return;
    }
    let dir = TempDir::new("elf");
    let src = root().join("tests/run/basics.fwp");
    for opts in [&[][..], &["--static"], &["--fat"]] {
        let exe = dir.0.join("basics");
        let b = build(&src, &exe, opts);
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        assert_eq!(elf_machine(&exe), 183, "{:?}", opts);
    }
}

#[test]
fn golden_programs_on_aarch64() {
    if !have(&format!("{}-gcc", TRIPLE)) || !have("qemu-aarch64") {
        return;
    }
    goldens("aarch64-linux", &[], &[], |_| true, run);
}

#[test]
fn golden_programs_with_musl() {
    if std::env::consts::ARCH != "x86_64" || !have_cc("musl-gcc") {
        eprintln!("skipping: needs musl-gcc on x86-64");
        return;
    }
    goldens(
        "x86_64-linux-musl",
        &[],
        &["--static"],
        |_| true,
        |exe, cwd, input| run_cmd(Command::new(exe), cwd, input),
    );
}

#[test]
fn tasks_on_aarch64_with_the_runtimes_own_switch() {
    if !have(&format!("{}-gcc", TRIPLE)) || !have("qemu-aarch64") {
        return;
    }
    let cc = format!("{}-gcc -DFWP_OWN_CONTEXT", TRIPLE);
    goldens(
        "aarch64-linux",
        &[("FWP_CC_aarch64_linux_gnu", cc.as_str())],
        &[],
        |src| src.contains("task.") || src.contains("channel."),
        run,
    );
}

/// `musl-gcc` and the like print no version: whether they compile.
fn have_cc(cc: &str) -> bool {
    Command::new(cc)
        .args(["-x", "c", "-", "-fsyntax-only"])
        .stdin(Stdio::null())
        .output()
        .is_ok_and(|o| o.status.success())
}

/// Build the golden programs whose source passes `pick` for `target` and
/// check what each prints when `exec` runs it.
fn goldens(
    target: &str,
    env: &[(&str, &str)],
    opts: &[&str],
    pick: impl Fn(&str) -> bool + Sync,
    exec: impl Fn(&Path, &Path, &[u8]) -> Output + Sync,
) {
    let dir = TempDir::new(&format!("golden-{}-{}", target, env.len()));
    let mut entries: Vec<PathBuf> = std::fs::read_dir(root().join("tests/run"))
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .filter(|p| pick(&std::fs::read_to_string(p).unwrap()))
        .collect();
    entries.sort();
    let queue = std::sync::Mutex::new(entries);
    let failures = std::sync::Mutex::new(Vec::new());
    std::thread::scope(|s| {
        for _ in 0..4 {
            s.spawn(|| loop {
                let Some(path) = queue.lock().unwrap().pop() else {
                    break;
                };
                let name = path.file_stem().unwrap().to_string_lossy().to_string();
                let exe = dir.0.join(&name);
                let b = build_for(target, env, &path, &exe, opts);
                if !b.status.success() {
                    let err = String::from_utf8_lossy(&b.stderr);
                    // compile errors are covered by tests/golden_run.rs; a
                    // program that uses TLS needs the target's OpenSSL
                    let no_tls =
                        err.contains("uses TLS") && (target.ends_with("musl") || !target_openssl());
                    if err.contains("C compiler failed") && !no_tls {
                        failures.lock().unwrap().push(format!(
                            "{} (build):\n{}",
                            path.display(),
                            err
                        ));
                    }
                    continue;
                }
                let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
                let got = render(&exec(&exe, path.parent().unwrap(), &input));
                let want = std::fs::read_to_string(path.with_extension("out")).unwrap_or_default();
                if got != want {
                    failures.lock().unwrap().push(format!(
                        "{} ({}):\n--- expected\n{}--- got\n{}",
                        path.display(),
                        target,
                        want,
                        got
                    ));
                }
            });
        }
    });
    let failures = failures.into_inner().unwrap();
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}
