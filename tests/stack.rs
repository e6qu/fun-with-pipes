//! Records, variants and closures that do not escape live on the stack
//! (`src/escape.rs`; `FWP_STACK=0` when compiling turns it off). That
//! every golden program behaves the same with them, under a stressed and
//! verifying collector, is checked by tests/reuse.rs.

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn native_cc() -> bool {
    cfg!(any(target_os = "linux", target_os = "macos"))
        && Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
            .arg("--version")
            .output()
            .is_ok_and(|o| o.status.success())
}

struct TempDir(PathBuf);

impl TempDir {
    fn new(name: &str) -> TempDir {
        let d = std::env::temp_dir().join(format!("fwp-stack-{}-{}", name, std::process::id()));
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

fn run(exe: &Path, cwd: &Path, input: &[u8], env: &[(&str, &str)]) -> Output {
    let mut child = Command::new(exe)
        .current_dir(cwd)
        .env("FWP_SEED", "42")
        .envs(env.iter().copied())
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(input).unwrap();
    child.wait_with_output().unwrap()
}

/// A variant built in a loop and passed to a function that matches on it
/// and hands it on (so it is not kept as its fields) is allocated once per
/// iteration on the heap, and not at all on the stack.
#[test]
fn values_that_do_not_escape_are_not_allocated() {
    on_heap_and_stack("shapes", "FWP_STACK", "6118033823962\n");
}

/// A closure built in a loop and given to a function that only applies
/// it lives on the stack too.
#[test]
fn closures_that_do_not_escape_are_not_allocated() {
    on_heap_and_stack("twice", "FWP_STACK", "999944\n");
}

/// A recursive function returning an `Option` (not inlined) returns it as
/// a struct, which its caller matches without allocating (`FWP_VRET=0`
/// turns that off).
#[test]
fn variants_returned_as_structs_are_not_allocated() {
    on_heap_and_stack("digits", "FWP_VRET", "182551542\n");
}

/// A recursive function returning a record of six fields, which it builds
/// on every path, returns it as a struct in the caller's frame.
#[test]
fn wide_records_are_returned_without_allocating() {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new("wide");
    let mib = allocated(&dir, "wide", "FWP_STACK", "1", "60003000000\n");
    assert!(mib < 1.0, "{} MiB", mib);
}

/// What `tests/stack/<name>.fwp`, compiled with `var` set to `value`,
/// allocates (MiB), checking that it prints `expected`.
fn allocated(dir: &TempDir, name: &str, var: &str, value: &str, expected: &str) -> f64 {
    let src = root().join(format!("tests/stack/{}.fwp", name));
    let exe = dir.0.join(format!("{}{}", name, value));
    let b = Command::new(fwp())
        .arg("build")
        .arg(&src)
        .arg("-o")
        .arg(&exe)
        .env(var, value)
        .output()
        .unwrap();
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let o = run(&exe, &dir.0, b"", &[("FWP_GC_STATS", "1")]);
    assert_eq!(String::from_utf8_lossy(&o.stdout), expected);
    let err = String::from_utf8_lossy(&o.stderr);
    let mib = err
        .split(" MiB allocated")
        .next()
        .unwrap()
        .rsplit(' ')
        .next()
        .unwrap();
    mib.parse().unwrap()
}

/// `tests/stack/<name>.fwp` prints `expected`, allocating more than 10 MiB
/// with `var` set to 0 when compiling and less than 1 MiB without.
fn on_heap_and_stack(name: &str, var: &str, expected: &str) {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new(name);
    let heap = allocated(&dir, name, var, "0", expected);
    let stack = allocated(&dir, name, var, "1", expected);
    assert!(
        heap > 10.0 && stack < 1.0,
        "{}: {} MiB on the heap, {} MiB with stack objects",
        name,
        heap,
        stack
    );
}
