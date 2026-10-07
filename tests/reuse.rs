//! Reuse in place (the default; `FWP_REUSE=0` when compiling turns it
//! off): every golden program behaves the same under
//! `FWP_REUSE_VERIFY=1`, which copies a value judged unique and poisons
//! the original instead of reusing it, so that a wrong judgment changes
//! the output (with the collector verifying itself as well). Plain reuse
//! is what tests/golden_run.rs runs.
//! `tests/run/reuse_aliasing.fwp` keeps a second reference to records it
//! updates in each of the ways a program can.

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
        let d = std::env::temp_dir().join(format!("fwp-reuse-{}-{}", name, std::process::id()));
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

#[test]
fn golden_programs_with_reuse_verified() {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new("golden");
    let mut entries: Vec<PathBuf> = std::fs::read_dir(root().join("tests/run"))
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
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
                let b = Command::new(fwp())
                    .arg("build")
                    .arg(&path)
                    .args(["-O1", "-o"])
                    .arg(&exe)
                    .env("FWP_REUSE", "1")
                    .current_dir(path.parent().unwrap())
                    .output()
                    .unwrap();
                if !b.status.success() {
                    continue; // compile errors are covered by tests/golden_run.rs
                }
                let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
                let want = std::fs::read_to_string(path.with_extension("out")).unwrap_or_default();
                let verify: &[(&str, &str)] = &[
                    ("FWP_REUSE_VERIFY", "1"),
                    ("FWP_GC_VERIFY", "1"),
                    ("FWP_GC_STRESS", "50"),
                ];
                let got = render(&run(&exe, path.parent().unwrap(), &input, verify));
                if got != want {
                    failures.lock().unwrap().push(format!(
                        "{} (reuse verified):\n--- expected\n{}--- got\n{}",
                        path.display(),
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

/// A loop that updates a record of five fields (too many to keep in
/// registers) allocates a copy per iteration, and nothing with reuse.
#[test]
fn unique_records_are_updated_in_place() {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new("inplace");
    let src = dir.0.join("upd.fwp");
    std::fs::write(
        &src,
        "Acc = { n: I64, total: I64, label: String, hi: I64, lo: I64 }\n\n\
         step : Acc -> Acc\n\
         step = update { n = add 1, total = add 3, hi = add 2 }\n\n\
         go : (I64, Acc) -> Step[(I64, Acc), Acc]\n\
         go = if (.0 | eq 0) (.1 | Stop) (both (.0 | sub 1) (.1 | step) | Again)\n\n\
         main = (1000000, Acc { n = 0, total = 0, label = \"x\", hi = 0, lo = 0 }) | loop go | echo\n",
    )
    .unwrap();
    let allocated = |reuse: &str| -> f64 {
        let exe = dir.0.join(format!("upd{}", reuse));
        let b = Command::new(fwp())
            .arg("build")
            .arg(&src)
            .arg("-o")
            .arg(&exe)
            .env("FWP_REUSE", reuse)
            .output()
            .unwrap();
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let o = run(&exe, &dir.0, b"", &[("FWP_GC_STATS", "1")]);
        assert_eq!(
            String::from_utf8_lossy(&o.stdout),
            "Acc {hi = 2000000, label = \"x\", lo = 0, n = 1000000, total = 3000000}\n"
        );
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
    let (copied, reused) = (allocated("0"), allocated("1"));
    assert!(
        copied > 10.0 && reused < 1.0,
        "{} MiB copied, {} MiB with reuse",
        copied,
        reused
    );
}

/// A recursive function that rebuilds every node of a tree writes each
/// new node into the old one when the tree is unique.
#[test]
fn variant_cells_are_reused() {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new("cells");
    let src = dir.0.join("tree.fwp");
    std::fs::write(
        &src,
        "Tree =\n    | Leaf\n    | Node Tree I64 Tree\n\n\
         rec build : I64 -> Tree\n\
         build = match\n    0 -> Leaf\n    _ -> make { 0 = sub 1 | build, 1 = id, 2 = sub 1 | build } | uncurry3 Node\n\n\
         rec incr : Tree -> Tree\n\
         incr = match\n    Leaf -> Leaf\n    Node -> curry3 (make { 0 = .0 | incr, 1 = .1 | add 1, 2 = .2 | incr } | uncurry3 Node)\n\n\
         rec total : Tree -> I64\n\
         total = match\n    Leaf -> 0\n    Node -> curry3 (fork add (.0 | total) (fork add .1 (.2 | total)))\n\n\
         step : (I64, Tree) -> Step[(I64, Tree), Tree]\n\
         step = if (.0 | eq 0) (.1 | Stop) (both (.0 | sub 1) (.1 | incr) | Again)\n\n\
         main = (10, 16 | build) | loop step | total | echo\n",
    )
    .unwrap();
    let allocated = |reuse: &str| -> f64 {
        let exe = dir.0.join(format!("tree{}", reuse));
        let b = Command::new(fwp())
            .arg("build")
            .arg(&src)
            .arg("-o")
            .arg(&exe)
            .env("FWP_REUSE", reuse)
            .output()
            .unwrap();
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let o = run(&exe, &dir.0, b"", &[("FWP_GC_STATS", "1")]);
        assert_eq!(String::from_utf8_lossy(&o.stdout), "786404\n");
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
    let (copied, reused) = (allocated("0"), allocated("1"));
    // the tree itself is built once either way
    assert!(
        reused * 4.0 < copied,
        "{} MiB copied, {} MiB with reuse",
        copied,
        reused
    );
}

/// An array that a loop pushes to or writes into, or a map it inserts
/// into, holding its only reference, is written in place: the loops
/// allocate next to nothing, where copying allocates a whole array or map
/// per step.
#[test]
fn unique_arrays_are_written_in_place() {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new("arrays");
    for (name, want, copied_at_least) in [
        ("push", "199993\n", 1000.0),
        ("set", "500500\n", 100.0),
        ("map", "100014\n", 1000.0),
    ] {
        let src = root().join(format!("tests/reuse/{}.fwp", name));
        let allocated = |reuse: &str| -> f64 {
            let exe = dir.0.join(format!("{}{}", name, reuse));
            let b = Command::new(fwp())
                .arg("build")
                .arg(&src)
                .arg("-o")
                .arg(&exe)
                .env("FWP_REUSE", reuse)
                .output()
                .unwrap();
            assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
            let o = run(&exe, &dir.0, b"", &[("FWP_GC_STATS", "1")]);
            assert_eq!(String::from_utf8_lossy(&o.stdout), want);
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
        let (copied, in_place) = (allocated("0"), allocated("1"));
        assert!(
            copied > copied_at_least && in_place < 10.0,
            "{}: {} MiB copied, {} MiB in place",
            name,
            copied,
            in_place
        );
    }
}

/// Objects are freed when their last counted reference goes: building
/// and walking a tree over and over needs no collection, where leaving the
/// trees to the collector takes many.
#[test]
fn objects_are_freed_by_their_counts() {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new("free");
    let src = root().join("tests/reuse/tree.fwp");
    let stats = |free: &str| -> (f64, u64) {
        let exe = dir.0.join(format!("tree{}", free));
        let b = Command::new(fwp())
            .arg("build")
            .arg(&src)
            .arg("-o")
            .arg(&exe)
            .env("FWP_FREE", free)
            .output()
            .unwrap();
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let o = run(&exe, &dir.0, b"", &[("FWP_GC_STATS", "1")]);
        assert_eq!(String::from_utf8_lossy(&o.stdout), "13105400\n");
        let err = String::from_utf8_lossy(&o.stderr).to_string();
        let words: Vec<&str> = err.split_whitespace().collect();
        let collections = words[2].parse().unwrap();
        let freed = err
            .split(" MiB freed by counts")
            .next()
            .unwrap()
            .rsplit('(')
            .next()
            .unwrap()
            .parse()
            .unwrap();
        (freed, collections)
    };
    let (kept, kept_collections) = stats("0");
    let (freed, collections) = stats("1");
    assert!(
        kept == 0.0 && kept_collections > 5 && freed > 100.0 && collections == 0,
        "collector only: {} collections; freed by counts: {} MiB, {} collections",
        kept_collections,
        freed,
        collections
    );
}
