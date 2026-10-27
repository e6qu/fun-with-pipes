//! Allocation comparisons use ARC with and without in-place reuse.
//! Both variants retain and release owners; FWP_NO_REUSE disables only reuse.
//! Aliases and invalid uniqueness are covered by arc_corpus and ownership-ledger
//! fault tests. These comparisons keep the original allocation thresholds.

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

#[path = "support/allocation_report.rs"]
mod allocation_report;

#[path = "support/record_probe.rs"]
mod record_probe;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
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

/// A loop that updates a record of five fields (too many to keep in
/// registers) allocates a copy per iteration, and nothing with reuse.
#[test]
fn unique_records_are_updated_in_place() {
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
    let cfile = dir.0.join("reuse.c");
    let emitted = Command::new(fwp())
        .args(["build", "--emit-c", "-O2"])
        .arg(&src)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let code = std::fs::read_to_string(cfile).unwrap();
    let allocated = |reuse: bool| -> f64 {
        let exe = dir.0.join(format!("upd{reuse}.exe"));
        let measured = if reuse {
            code.clone()
        } else {
            format!("#define FWP_NO_REUSE 1\n{code}")
        };
        fwp::cgen::compile_c(&measured, &exe, "-O2").unwrap();
        let o = run(&exe, &dir.0, b"", &[("FWP_ALLOC_STATS", "1")]);
        record_probe::save(
            "reuse_allocations",
            &format!("record-reuse-{reuse}"),
            &measured,
            &exe,
            &o,
        );
        assert!(o.status.success(), "execution failed: {o:?}");
        assert_eq!(
            String::from_utf8_lossy(&o.stdout),
            "Acc {hi = 2000000, label = \"x\", lo = 0, n = 1000000, total = 3000000}\n"
        );
        let err = String::from_utf8_lossy(&o.stderr);
        allocation_report::parse(&err)
            .expect("allocation report")
            .allocated as f64
            / 1_048_576.0
    };
    let (copied, reused) = (allocated(false), allocated(true));
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
    let cfile = dir.0.join("reuse.c");
    let emitted = Command::new(fwp())
        .args(["build", "--emit-c", "-O2"])
        .arg(&src)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let code = std::fs::read_to_string(cfile).unwrap();
    let allocated = |reuse: bool| -> f64 {
        let exe = dir.0.join(format!("tree{reuse}.exe"));
        let measured = if reuse {
            code.clone()
        } else {
            format!("#define FWP_NO_REUSE 1\n{code}")
        };
        fwp::cgen::compile_c(&measured, &exe, "-O2").unwrap();
        let o = run(&exe, &dir.0, b"", &[("FWP_ALLOC_STATS", "1")]);
        record_probe::save(
            "reuse_allocations",
            &format!("tree-reuse-{reuse}"),
            &measured,
            &exe,
            &o,
        );
        assert!(o.status.success(), "execution failed: {o:?}");
        assert_eq!(String::from_utf8_lossy(&o.stdout), "786404\n");
        let err = String::from_utf8_lossy(&o.stderr);
        allocation_report::parse(&err)
            .expect("allocation report")
            .allocated as f64
            / 1_048_576.0
    };
    let (copied, reused) = (allocated(false), allocated(true));
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
    let dir = TempDir::new("arrays");
    for (name, want, copied_at_least) in [
        ("push", "199993\n", 1000.0),
        ("set", "500500\n", 100.0),
        ("map", "100014\n", 1000.0),
    ] {
        let src = root().join(format!("tests/reuse/{}.fwp", name));
        let cfile = dir.0.join("reuse.c");
        let emitted = Command::new(fwp())
            .args(["build", "--emit-c", "-O2"])
            .arg(&src)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(emitted.status.success(), "{emitted:?}");
        let code = std::fs::read_to_string(cfile).unwrap();
        let allocated = |reuse: bool| -> f64 {
            let exe = dir.0.join(format!("{name}{reuse}.exe"));
            let measured = if reuse {
                code.clone()
            } else {
                format!("#define FWP_NO_REUSE 1\n{code}")
            };
            fwp::cgen::compile_c(&measured, &exe, "-O2").unwrap();
            let o = run(&exe, &dir.0, b"", &[("FWP_ALLOC_STATS", "1")]);
            record_probe::save(
                "reuse_allocations",
                &format!("{name}-reuse-{reuse}"),
                &measured,
                &exe,
                &o,
            );
            assert!(o.status.success(), "execution failed: {o:?}");
            assert_eq!(String::from_utf8_lossy(&o.stdout), want);
            let err = String::from_utf8_lossy(&o.stderr);
            allocation_report::parse(&err)
                .expect("allocation report")
                .allocated as f64
                / 1_048_576.0
        };
        let (copied, in_place) = (allocated(false), allocated(true));
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
    let dir = TempDir::new("free");
    let src = root().join("tests/reuse/tree.fwp");
    let cfile = dir.0.join("tree.c");
    let emitted = Command::new(fwp())
        .args(["build", "--emit-c"])
        .arg(&src)
        .args(["-o"])
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let current = std::fs::read_to_string(&cfile).unwrap();
    let free_entry = "static void fwp_mem_free(void *p) {";
    assert_eq!(current.matches(free_entry).count(), 2);
    // Both programs keep generated counts/drops. Only physical release is
    // deliberately omitted in the faulty version; no collector rescues it.
    let missing = current.replace(
        free_entry,
        "static void fwp_mem_free(void *p) { (void)p; return;",
    );
    for (name, code, release) in [
        ("missing-free", missing.as_str(), false),
        ("counted", current.as_str(), true),
    ] {
        let exe = dir.0.join(format!("{name}.exe"));
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
        let out = run(&exe, &dir.0, b"", &[("FWP_ALLOC_STATS", "1")]);
        assert!(out.status.success(), "{out:?}");
        assert_eq!(out.stdout, b"13105400\n");
        let report = allocation_report::parse(&String::from_utf8_lossy(&out.stderr)).unwrap();
        assert!(report.allocated > 100 * 1_048_576, "{report:?}");
        if release {
            assert!(report.released > 100 * 1_048_576, "{report:?}");
        } else {
            assert_eq!(report.released, 0, "{report:?}");
            assert!(report.live > 100 * 1_048_576, "{report:?}");
        }
    }
}
