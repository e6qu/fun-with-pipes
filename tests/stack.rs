//! Records and variants that do not escape live on the stack
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

fn linux_cc() -> bool {
    Path::new("/proc/self/status").exists()
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
    if !linux_cc() {
        return;
    }
    let dir = TempDir::new("variant");
    let src = root().join("tests/stack/shapes.fwp");
    let allocated = |stack: &str| -> f64 {
        let exe = dir.0.join(format!("shapes{}", stack));
        let b = Command::new(fwp())
            .arg("build")
            .arg(&src)
            .arg("-o")
            .arg(&exe)
            .env("FWP_STACK", stack)
            .output()
            .unwrap();
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let o = run(&exe, &dir.0, b"", &[("FWP_GC_STATS", "1")]);
        assert_eq!(String::from_utf8_lossy(&o.stdout), EXPECTED);
        let err = String::from_utf8_lossy(&o.stderr);
        let mib = err
            .split(" MiB allocated")
            .next()
            .unwrap()
            .rsplit(' ')
            .next()
            .unwrap();
        mib.parse().unwrap()
    };
    let (heap, stack) = (allocated("0"), allocated("1"));
    assert!(
        heap > 10.0 && stack < 1.0,
        "{} MiB on the heap, {} MiB with stack objects",
        heap,
        stack
    );
}

const EXPECTED: &str = "6118033823962\n";
