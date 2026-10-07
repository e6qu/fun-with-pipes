//! Preemptive scheduling: tasks are preempted after a slice of function
//! entries (`FWP_PREEMPT`), counted alike by the interpreter and native
//! programs, so the same program interleaves alike on both, whatever the
//! slice; the collector finds the roots of tasks preempted at any safe
//! point; and the outputs do not change from run to run.
//! Timer wake order depends on wall time. The scoped timer fixture
//! collects both results before reporting them in a fixed order.

use std::path::{Path, PathBuf};
use std::process::Command;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn have_cc() -> bool {
    Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok()
}

struct TempDir(PathBuf);

impl TempDir {
    fn new(name: &str) -> TempDir {
        let d = std::env::temp_dir().join(format!("fwp-preempt-{}-{}", name, std::process::id()));
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

fn render(out: &std::process::Output) -> String {
    let mut s = String::from_utf8_lossy(&out.stdout).to_string();
    if !out.stderr.is_empty() {
        s.push_str("--- stderr\n");
        s.push_str(&String::from_utf8_lossy(&out.stderr));
    }
    if let Some(c) = out.status.code().filter(|c| *c != 0) {
        s.push_str(&format!("--- exit {}\n", c));
    }
    s
}

fn interpret(path: &Path, env: &[(&str, &str)]) -> String {
    let out = Command::new(fwp())
        .args(["run", "--interp"])
        .arg(path)
        .env("FWP_SEED", "42")
        .envs(env.iter().copied())
        .output()
        .unwrap();
    render(&out)
}

fn build(path: &Path, dir: &Path) -> PathBuf {
    let exe = dir.join(path.file_stem().unwrap());
    let b = Command::new(fwp())
        .arg("build")
        .arg(path)
        .args(["-O2", "-o"])
        .arg(&exe)
        .output()
        .unwrap();
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    exe
}

fn native(exe: &Path, env: &[(&str, &str)]) -> String {
    let out = Command::new(exe)
        .env("FWP_SEED", "42")
        .envs(env.iter().copied())
        .output()
        .unwrap();
    render(&out)
}

/// Programs with tasks that compute between their suspensions, where the
/// slice decides the interleaving.
const PROGRAMS: &[&str] = &[
    "tests/run/preempt.fwp",
    "tests/run/tasks_local.fwp",
    "tests/run/tasks.fwp",
];

#[test]
fn backends_interleave_alike_for_any_slice() {
    let dir = TempDir::new("slices");
    let cc = have_cc();
    for p in PROGRAMS {
        let path = root().join(p);
        let exe = cc.then(|| build(&path, &dir.0));
        for slice in ["1", "37", "1000"] {
            let env = [("FWP_PREEMPT", slice)];
            let want = interpret(&path, &env);
            if matches!(*p, "tests/run/tasks_local.fwp" | "tests/run/tasks.fwp") {
                let expected = std::fs::read_to_string(path.with_extension("out")).unwrap();
                assert_eq!(want, expected, "scoped results with slice {slice}");
            }
            assert!(
                !want.contains("--- exit"),
                "{} slice {}: {}",
                p,
                slice,
                want
            );
            if let Some(exe) = &exe {
                assert_eq!(native(exe, &env), want, "{} with FWP_PREEMPT={}", p, slice);
                // the collector finds the roots of tasks switched out at
                // safe points
                let stressed = [("FWP_PREEMPT", slice), ("FWP_GC_STRESS", "1")];
                assert_eq!(
                    native(exe, &stressed),
                    want,
                    "{} with FWP_PREEMPT={} FWP_GC_STRESS=1",
                    p,
                    slice
                );
            }
        }
    }
}

#[test]
fn output_is_reproducible() {
    let path = root().join("tests/run/preempt.fwp");
    let want = std::fs::read_to_string(path.with_extension("out")).unwrap();
    for _ in 0..3 {
        assert_eq!(interpret(&path, &[]), want);
    }
    if have_cc() {
        let dir = TempDir::new("repro");
        let exe = build(&path, &dir.0);
        for _ in 0..5 {
            assert_eq!(native(&exe, &[]), want);
        }
    }
}

/// Without preemption (`FWP_PREEMPT=0`), a task that spins forever keeps
/// the others from running: the deadline of `task.within` is never
/// noticed. With it, the spinning task is cancelled on time.
#[test]
fn deadline_cancels_a_spinning_task() {
    let dir = TempDir::new("deadline");
    let src = dir.0.join("spin.fwp");
    std::fs::write(
        &src,
        "forever : () -> I64\nforever = loop Again\n\nmain = task.within 100ms forever | echo\n",
    )
    .unwrap();
    let t = std::time::Instant::now();
    assert_eq!(interpret(&src, &[]), "None\n");
    assert!(t.elapsed() < std::time::Duration::from_secs(20));
    if have_cc() {
        let exe = build(&src, &dir.0);
        let t = std::time::Instant::now();
        assert_eq!(native(&exe, &[]), "None\n");
        assert!(t.elapsed() < std::time::Duration::from_secs(5));
        // a time slice is not needed: the slice is a count, so even a
        // very long one ends
        assert_eq!(native(&exe, &[("FWP_PREEMPT", "100000000")]), "None\n");
    }
}
