//! Static memory (`fwp build --memory static`, runtime/fwp_rt_static.c):
//! Linux golden programs behave the same with runtime storage mapped at
//! startup; the standalone workload makes no later memory mappings (checked
//! with strace where it is installed); a loop that allocates far more than
//! the heap runs in it; and running out of a part says which option to
//! raise.

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
        let d = std::env::temp_dir().join(format!("fwp-static-{}-{}", name, std::process::id()));
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

/// Build `src` (in `cwd`) with static memory and the given options.
fn build(src: &Path, exe: &Path, opts: &[&str]) -> Output {
    Command::new(fwp())
        .arg("build")
        .arg(src.file_name().unwrap())
        .args(["--memory", "static", "-O1", "-o"])
        .arg(exe)
        .args(opts)
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

fn run(exe: &Path, cwd: &Path, input: &[u8]) -> Output {
    let mut child = Command::new(exe)
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

#[test]
fn golden_programs_with_static_memory() {
    if !linux_cc() {
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
                let opts: &[&str] = match name.as_str() {
                    // Two thousand tasks at once.
                    "tasks_local" => &["--tasks", "2048", "--task-stack", "256K"],
                    // Preserve the deliberately invalid tape's runtime trap.
                    // arc_corpus separately requires its compile-time rejection.
                    "ad_task_reuse" => &["--gc", "tracing"],
                    _ => &[],
                };
                let exe = dir.0.join(&name);
                let built = build(&path, &exe, opts);
                let got = if built.status.success() {
                    let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
                    render(&run(&exe, path.parent().unwrap(), &input))
                } else {
                    // Expected language diagnostics still match their snapshot;
                    // an unexpected native compilation failure must fail here.
                    render(&built)
                };
                let want = std::fs::read_to_string(path.with_extension("out")).unwrap_or_default();
                if got != want {
                    failures.lock().unwrap().push(format!(
                        "{} (--memory static):\n--- expected\n{}--- got\n{}",
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

/// The memory system calls a program makes after mapping its static
/// memory: none but the guard pages' mprotect.
#[test]
fn nothing_is_mapped_after_startup() {
    if !linux_cc() || Command::new("strace").arg("-V").output().is_err() {
        return;
    }
    let dir = TempDir::new("strace");
    // tasks, channels, a parallel kernel and plenty of allocation
    let src = dir.0.join("busy.fwp");
    std::fs::write(
        &src,
        "step : (I64, I64) -> Step[(I64, I64), I64]\n\
         step = if (.0 | eq 0) (.1 | Stop) (both (.0 | sub 1) (fork add .1 .0) | Again)\n\n\
         squares : List[I64] -> List[Option[I64]] ! {Async}\n\
         squares = task.map (fork mul id id)\n\n\
         xs : Vector[F64, _]\n\
         xs = 100000 | range 0 | map (int.to-float | mul 0.0001) | vector.from-list\n\n\
         main = [\n    \
             (2000000, 0) | loop step | echo,\n    \
             range 0 50 | squares | length | echo,\n    \
             range 0 100000 | map show | map string.length | sum | echo,\n\
             xs | tensor.lazy | add 1.0 | tensor.sum-on (CpuParallel 4) | echo,\n\
         ] | ignore\n",
    )
    .unwrap();
    let exe = dir.0.join("busy");
    let b = build(&src, &exe, &[]);
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let trace = dir.0.join("trace");
    let o = Command::new("strace")
        .args(["-f", "-o"])
        .arg(&trace)
        .args(["-e", "trace=mmap,munmap,mremap,brk,mprotect,madvise"])
        .arg(&exe)
        .output()
        .unwrap();
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    assert_eq!(
        String::from_utf8_lossy(&o.stdout),
        "2000001000000\n50\n488890\n599995.0000000001\n"
    );
    let trace = std::fs::read_to_string(&trace).unwrap();
    let lines: Vec<&str> = trace.lines().collect();
    let start = lines
        .iter()
        .position(|l| l.contains("MAP_POPULATE"))
        .expect("the static memory is mapped with MAP_POPULATE");
    let after: Vec<&str> = lines[start + 1..]
        .iter()
        .copied()
        .filter(|l| !(l.contains("mprotect(") && l.contains("PROT_NONE")))
        .filter(|l| !l.contains("+++ exited") && !l.contains("resumed>"))
        .collect();
    assert!(
        after.is_empty(),
        "memory system calls after startup:\n{}",
        after.join("\n")
    );
}

#[test]
fn a_small_heap_is_collected_and_reused() {
    if !linux_cc() {
        return;
    }
    let dir = TempDir::new("small");
    let src = dir.0.join("churn.fwp");
    // Three million loop steps must fit in 1 MiB with default ownership.
    std::fs::write(
        &src,
        "step : (I64, I64) -> Step[(I64, I64), I64]\n\
         step = if (.0 | eq 0) (.1 | Stop) (both (.0 | sub 1) (fork add .1 (.0 | rem 3)) | Again)\n\n\
         main = (3000000, 0) | loop step | echo\n",
    )
    .unwrap();
    let exe = dir.0.join("churn");
    let b = build(&src, &exe, &["--heap", "1M"]);
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let o = Command::new(&exe)
        .env("FWP_MEMORY_REPORT", "1")
        .output()
        .unwrap();
    assert!(o.status.success(), "{}", render(&o));
    assert_eq!(o.stdout, b"3000000\n", "{}", render(&o));
    let report = String::from_utf8_lossy(&o.stderr);
    assert!(report.contains("heap            1024 KiB"), "{}", report);

    // Actual collection needs a separate control: counted reclamation can keep
    // the default build bounded without tracing. Disable freeing and reuse for
    // short-lived lists/strings, then require collection inside the same 1 MiB.
    let workload = include_str!("gc/churn.fwp");
    assert_eq!(workload.matches("(6000, 0)").count(), 1);
    let source = dir.0.join("shared.fwp");
    std::fs::write(&source, workload.replace("(6000, 0)", "(60, 0)")).unwrap();
    let shared = dir.0.join("shared");
    let built = Command::new(fwp())
        .args([
            "build", "--gc", "tracing", "--memory", "static", "--heap", "1M", "-O1",
        ])
        .arg(&source)
        .arg("-o")
        .arg(&shared)
        .env("FWP_FREE", "0")
        .env("FWP_REUSE", "0")
        .output()
        .unwrap();
    assert!(built.status.success(), "{}", render(&built));
    let collected = Command::new(&shared)
        .env("FWP_GC", "on")
        .env("FWP_GC_STATS", "1")
        .env("FWP_MEMORY_REPORT", "1")
        .output()
        .unwrap();
    assert!(collected.status.success(), "{}", render(&collected));
    assert_eq!(collected.stdout, b"217680\n", "{}", render(&collected));
    let report = String::from_utf8_lossy(&collected.stderr);
    assert!(report.contains("heap            1024 KiB"), "{report}");
    let statistics = report
        .lines()
        .find(|line| line.starts_with("fwp gc: "))
        .expect("collection statistics");
    let collections: usize = statistics
        .split_whitespace()
        .nth(2)
        .unwrap()
        .parse()
        .unwrap();
    assert!(collections > 0, "{report}");

    // Without either counted reclamation or tracing, the identical executable
    // must exhaust this heap. This prevents a vacuous collection assertion.
    let uncollected = Command::new(&shared).env("FWP_GC", "off").output().unwrap();
    assert_eq!(
        uncollected.status.code(),
        Some(102),
        "{}",
        render(&uncollected)
    );
    assert!(
        String::from_utf8_lossy(&uncollected.stderr).contains("the static heap (1024 KiB) is full"),
        "{}",
        render(&uncollected)
    );
}

#[test]
fn running_out_names_the_option() {
    if !linux_cc() {
        return;
    }
    let dir = TempDir::new("out");
    let cases: &[(&str, &[&str], &str)] = &[
        // a list of a million elements, all live (reversed, so it is
        // built: a range folded directly is fused into a loop)
        (
            "main = range 0 1000000 | reverse | sum | echo\n",
            &["--heap", "1M"],
            "fwp: out of memory: the static heap (1024 KiB) is full; build with a larger --heap\n",
        ),
        (
            "main = range 0 100 | task.map (fork mul id id) | length | echo\n",
            &["--tasks", "8"],
            "fwp: out of memory: the static memory has stacks for 8 tasks; build with a larger --tasks\n",
        ),
    ];
    for (i, (prog, opts, want)) in cases.iter().enumerate() {
        let src = dir.0.join(format!("p{}.fwp", i));
        std::fs::write(&src, prog).unwrap();
        let exe = dir.0.join(format!("p{}", i));
        let b = build(&src, &exe, opts);
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let o = run(&exe, &dir.0, b"");
        assert_eq!(o.status.code(), Some(102), "{}: {}", prog, render(&o));
        assert_eq!(String::from_utf8_lossy(&o.stderr), *want, "{}", prog);
    }
}

#[test]
fn options_are_checked() {
    let cases: &[(&[&str], &str)] = &[
        (&["--heap", "64M"], "add --memory static"),
        (
            &["--memory", "static", "--heap", "12"],
            "a size of at least 64K",
        ),
        (&["--memory", "pooled"], "--memory is static or dynamic"),
        (
            &["--memory", "static", "--target", "wasm32-wasi"],
            "builds native executables",
        ),
    ];
    let hello = root().join("examples/hello.fwp");
    for (opts, want) in cases {
        let o = Command::new(fwp())
            .arg("build")
            .arg(&hello)
            .args(*opts)
            .args(["-o", "/dev/null"])
            .output()
            .unwrap();
        assert_eq!(o.status.code(), Some(2), "{:?}", opts);
        let err = String::from_utf8_lossy(&o.stderr);
        assert!(err.contains(want), "{:?}: {}", opts, err);
    }
}
