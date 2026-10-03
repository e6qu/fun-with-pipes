//! Static memory (`fwp build --memory static`, runtime/fwp_rt_static.c):
//! every golden program behaves the same with all of its memory mapped at
//! startup; nothing is asked of the operating system after that (checked
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
        .arg(src)
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
                // two thousand tasks at once
                let opts: &[&str] = if name == "tasks_local" {
                    &["--tasks", "2048", "--task-stack", "256K"]
                } else {
                    &[]
                };
                let exe = dir.0.join(&name);
                if !build(&path, &exe, opts).status.success() {
                    continue; // compile errors are covered by tests/golden_run.rs
                }
                let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
                let got = render(&run(&exe, path.parent().unwrap(), &input));
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
         squares = task.map (fork mul id id)\n\n\
         xs : Vector[F64, Dyn]\n\
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
    // about 200 MiB allocated, a few KiB live at a time
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
    assert_eq!(render(&o).lines().next(), Some("3000000"), "{}", render(&o));
    let report = String::from_utf8_lossy(&o.stderr);
    assert!(report.contains("heap            1024 KiB"), "{}", report);
}

#[test]
fn running_out_names_the_option() {
    if !linux_cc() {
        return;
    }
    let dir = TempDir::new("out");
    let cases: &[(&str, &[&str], &str)] = &[
        // a list of a million elements, all live
        (
            "main = range 0 1000000 | sum | echo\n",
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
