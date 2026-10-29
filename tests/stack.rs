//! Records, variants and closures that do not escape live on the stack
//! (`src/escape.rs`; `FWP_STACK=0` when compiling turns it off). That
//! tests/reuse.rs compares outputs with and without eligible storage reuse.

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

#[path = "support/allocation_report.rs"]
mod allocation_report;

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

/// Inlining `const` preserves the constructed record's typed binding. That
/// ownership context must not hide its origin from the return ABI analysis.
#[test]
fn wide_record_aliases_are_returned_without_allocating() {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new("wide-alias");
    let mib = allocated(&dir, "wide_alias", "FWP_STACK", "1", "60003000000\n");
    assert!(mib < 1.0, "wide record alias allocated {mib} MiB");
}

/// Returning fields through aliases must preserve owned children and the
/// intervening effect, with both native memory modes agreeing with raw IR.
#[test]
fn record_return_aliases_preserve_owners_and_effects() {
    if !native_cc() {
        return;
    }
    let dir = TempDir::new("owned-return-alias");
    let src = dir.0.join("owned.fwp");
    std::fs::write(&src, r#"
rec alias : String -> (String, String, String, String, String, String) ! {IO}
alias = make { 0 = id, 1 = concat "a", 2 = concat "b", 3 = concat "c", 4 = concat "d", 5 = concat "e" }
    | fork const id (const "effect" | print)
main = range 1 17 | map (flip string.repeat "seed" | alias) | echo
"#).unwrap();
    let expected = Command::new(fwp())
        .args(["run", "--interp"])
        .arg(&src)
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    assert!(
        expected.status.success(),
        "{}",
        String::from_utf8_lossy(&expected.stderr)
    );
    {
        for (opt, stack) in [("-O1", "0"), ("-O2", "1")] {
            let exe = dir.0.join(format!("owned-counted-{stack}"));
            let build = Command::new(fwp())
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe)
                .env("FWP_STACK", stack)
                .output()
                .unwrap();
            assert!(
                build.status.success(),
                "{}",
                String::from_utf8_lossy(&build.stderr)
            );
            let actual = run(&exe, &dir.0, b"", &[]);
            assert_eq!(
                actual.status.code(),
                expected.status.code(),
                "counted/{opt}: {}",
                String::from_utf8_lossy(&actual.stderr)
            );
            assert_eq!(actual.stdout, expected.stdout, "counted/{opt}");
            assert_eq!(actual.stderr, expected.stderr, "counted/{opt}");
        }
    }
}

/// What `tests/stack/<name>.fwp`, compiled with `var` set to `value`,
/// allocates (MiB), checking that it prints `expected`.
fn allocated(dir: &TempDir, name: &str, var: &str, value: &str, expected: &str) -> f64 {
    let src = root().join(format!("tests/stack/{}.fwp", name));
    let exe = dir.0.join(format!("{}{}", name, value));
    let b = Command::new(fwp())
        .args(["build"])
        .arg(&src)
        .arg("-o")
        .arg(&exe)
        .env(var, value)
        .output()
        .unwrap();
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let o = run(&exe, &dir.0, b"", &[("FWP_ALLOC_STATS", "1")]);
    assert_eq!(String::from_utf8_lossy(&o.stdout), expected);
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    let err = String::from_utf8_lossy(&o.stderr);
    allocation_report::parse(&err)
        .expect("allocation report")
        .allocated as f64
        / 1_048_576.0
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

/// Required stack setup must fail before language code, without changing stacks
/// or silently disabling overflow reporting. Attribute failures also clean up.
#[cfg(any(target_os = "linux", target_os = "macos"))]
#[test]
fn runtime_startup_reports_stack_and_handler_failures() {
    let dir = fwp::cgen::TempDir::new("runtime-startup-failures").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, "main = 42 | echo\n").unwrap();
    for memory in ["dynamic", "static"] {
        let cfile = dir.join(format!("{memory}.c"));
        let mut build = Command::new(fwp());
        build.args(["build", "--memory", memory, "--emit-c"]);
        if memory == "static" {
            build.args([
                "--heap",
                "1M",
                "--pool",
                "4M",
                "--stack",
                "1M",
                "--tasks",
                "2",
                "--task-stack",
                "64K",
                "--threads",
                "2",
            ]);
        }
        let output = build.arg(&source).arg("-o").arg(&cfile).output().unwrap();
        assert!(output.status.success(), "{memory}: {output:?}");
        let code = std::fs::read_to_string(cfile).unwrap();
        let marker = "typedef uint64_t V;";
        assert_eq!(code.matches(marker).count(), 1);
        let instrumented = code.replace(
            marker,
            &format!(
                "{marker}\n{}",
                include_str!("fixtures/runtime_startup_faults.c")
            ),
        );
        for opt in ["-O0", "-O2"] {
            let binary = dir.join(format!("startup-{memory}{opt}.exe"));
            fwp::cgen::compile_c(&instrumented, &binary, opt).unwrap();
            let artifacts = std::env::var_os("FWP_STARTUP_ARTIFACTS").map(PathBuf::from);
            if let Some(path) = &artifacts {
                std::fs::create_dir_all(path).unwrap();
                std::fs::write(path.join(format!("startup-{memory}{opt}.c")), &instrumented)
                    .unwrap();
                std::fs::copy(&binary, path.join(format!("startup-{memory}{opt}.exe"))).unwrap();
            }
            for (fault, message) in [
                ("none", ""),
                ("attributes", "cannot initialize main thread attributes"),
                ("stack", "cannot configure main runtime stack"),
                ("create", "cannot create main runtime thread"),
                ("altstack", "cannot install stack overflow handler"),
                ("signal-mask", "cannot install stack overflow handler"),
                ("segv", "cannot install stack overflow handler"),
                ("bus", "cannot install stack overflow handler"),
            ] {
                let actual = Command::new(&binary)
                    .env("FWP_STARTUP_FAULT", fault)
                    .env_remove("FWP_ALLOC_STATS")
                    .env_remove("FWP_MEMORY_REPORT")
                    .output()
                    .unwrap();
                if let Some(path) = &artifacts {
                    let label = format!("startup-{memory}{opt}-{fault}");
                    std::fs::write(path.join(format!("{label}.stdout")), &actual.stdout).unwrap();
                    std::fs::write(path.join(format!("{label}.stderr")), &actual.stderr).unwrap();
                    std::fs::write(
                        path.join(format!("{label}.status")),
                        format!("{}\n", actual.status),
                    )
                    .unwrap();
                }
                let (status, stdout, stderr) = if fault == "none" {
                    (0, "42\n", String::new())
                } else {
                    (101, "", format!("fwp: trap: {message}\n"))
                };
                assert_eq!(
                    actual.status.code(),
                    Some(status),
                    "{memory}/{opt}/{fault}: {actual:?}"
                );
                assert_eq!(actual.stdout, stdout.as_bytes(), "{memory}/{opt}/{fault}");
                assert_eq!(actual.stderr, stderr.as_bytes(), "{memory}/{opt}/{fault}");
            }
        }
    }
}
