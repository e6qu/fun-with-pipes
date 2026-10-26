//! Native golden behavior, failure artifacts, and bounded loop/service memory.

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
#[cfg(unix)]
use std::os::unix::fs::PermissionsExt;
#[cfg(unix)]
use std::os::unix::process::ExitStatusExt;
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::thread::JoinHandle;
use std::time::Duration;

#[path = "support/http_server_process.rs"]
mod http_server_process;

#[path = "support/allocation_report.rs"]
mod allocation_report;

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
        .is_ok_and(|output| output.status.success())
}

fn linux() -> bool {
    Path::new("/proc/self/status").exists()
}

struct TempDir(PathBuf);

impl TempDir {
    fn new(name: &str) -> TempDir {
        let d =
            std::env::temp_dir().join(format!("fwp-native-memory-{}-{}", name, std::process::id()));
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

fn build(args: &[&str], cwd: &Path) {
    let out = Command::new(fwp())
        .args(["build"])
        .args(args)
        .current_dir(cwd)
        .output()
        .unwrap();
    assert!(
        out.status.success(),
        "fwp build {:?}: {}",
        args,
        String::from_utf8_lossy(&out.stderr)
    );
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

fn status_detail(status: std::process::ExitStatus) -> String {
    let detail = format!("code={:?}", status.code());
    #[cfg(unix)]
    {
        format!(
            "{detail} signal={:?} core_dumped={}",
            status.signal(),
            status.core_dumped()
        )
    }
    #[cfg(not(unix))]
    {
        detail
    }
}

fn retain_native_failure(path: &Path, dir: &Path, want: &str, got: &str) {
    let stem = path.file_stem().unwrap();
    let exe = dir
        .join(stem)
        .with_extension(std::env::consts::EXE_EXTENSION);
    let retained = std::env::temp_dir().join(format!(
        "fwp-golden-counted-{}-{}",
        std::process::id(),
        stem.to_string_lossy()
    ));
    if exe.exists() {
        std::fs::copy(&exe, &retained).unwrap();
        eprintln!("Native corpus binary retained at {}", retained.display());
    }
    std::fs::copy(
        exe.with_extension("status"),
        retained.with_extension("status"),
    )
    .unwrap();
    std::fs::write(
        retained.with_extension("report"),
        format!("--- expected\n{want}--- got\n{got}"),
    )
    .unwrap();
    let source = retained.with_extension("c");
    let emitted = Command::new(fwp())
        .args(["build", "--emit-c", "-O2", "-o"])
        .arg(&source)
        .arg(path.file_name().unwrap())
        .current_dir(path.parent().unwrap())
        .output()
        .unwrap();
    if emitted.status.success() {
        eprintln!("Native corpus C retained at {}", source.display());
    } else {
        std::fs::write(retained.with_extension("emit.log"), &emitted.stderr).unwrap();
    }
}

/// A golden program built natively: output and failure behavior must match.
fn native_example(path: &Path, dir: &Path) -> String {
    native_example_with_env(path, dir, &[])
}

fn native_example_with_env(path: &Path, dir: &Path, env: &[(&str, &str)]) -> String {
    let exe = dir
        .join(path.file_stem().unwrap())
        .with_extension(std::env::consts::EXE_EXTENSION);
    let b = Command::new(fwp())
        .args(["build"])
        .arg(path.file_name().unwrap())
        .args(["-O2", "-o"])
        .arg(&exe)
        .envs(env.iter().copied())
        .current_dir(path.parent().unwrap())
        .output()
        .unwrap();
    let status_path = exe.with_extension("status");
    let build_status = format!("build -O2: {}\n", status_detail(b.status));
    std::fs::write(&status_path, &build_status).unwrap();
    if !b.status.success() {
        // Expected source errors still match their snapshots. A native C
        // compiler failure for a valid program must not silently skip native CI.
        return render(b"", &b.stderr, b.status.code().unwrap_or(-1));
    }
    let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
    let mut child = Command::new(&exe)
        .current_dir(path.parent().unwrap())
        .env("FWP_SEED", "42")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(&input).unwrap();
    let out = child.wait_with_output().unwrap();
    std::fs::write(
        &status_path,
        format!("{build_status}run native: {}\n", status_detail(out.status)),
    )
    .unwrap();
    render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1))
}

#[test]
fn golden_programs_with_counted_ownership() {
    assert!(
        have_cc(),
        "native ownership checks require a working C compiler"
    );
    let dir = TempDir::new("corpus");
    let mut entries: Vec<PathBuf> = std::fs::read_dir(root().join("tests/run"))
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    // Start the longest measured cases first so other workers can finish the
    // short programs alongside them. Intel CI run 38925341899 spent 1744s on
    // collections_build and 175s on http. Keep every case and all four workers.
    // Workers pop from the end, so the priority cases sort last.
    entries.sort_by_key(|path| {
        let long = matches!(
            path.file_name().and_then(|name| name.to_str()),
            Some("collections_build.fwp" | "http.fwp")
        );
        (long, path.clone())
    });
    let queue = std::sync::Mutex::new(entries);
    let failures = std::sync::Mutex::new(Vec::new());
    std::thread::scope(|s| {
        for _ in 0..4 {
            s.spawn(|| loop {
                let Some(path) = queue.lock().unwrap().pop() else {
                    break;
                };
                let started = std::time::Instant::now();
                eprintln!("Native corpus example started: {}", path.display());
                let want = std::fs::read_to_string(path.with_extension("out")).unwrap_or_default();
                let got = native_example(&path, &dir.0);
                eprintln!(
                    "Native corpus example finished: {} ({:.2}s)",
                    path.display(),
                    started.elapsed().as_secs_f64()
                );
                if got != want {
                    retain_native_failure(&path, &dir.0, &want, &got);
                    failures.lock().unwrap().push(format!(
                        "{} (counted ownership):\n--- expected\n{}--- got\n{}",
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

#[test]
fn native_failure_artifacts_retain_the_executable() {
    assert!(have_cc(), "native artifact verification needs a C compiler");
    let dir = TempDir::new("native-artifact");
    let source = dir.0.join("native-artifact.fwp");
    std::fs::write(&source, "main = \"saved\" | string.repeat 2 | echo\n").unwrap();
    let output = native_example(&source, &dir.0);
    assert_eq!(output, "savedsaved\n");
    // Exercise failure retention with a deliberate snapshot mismatch, keeping
    // the native executable, its exact output/status and generated C together.
    retain_native_failure(&source, &dir.0, "deliberate artifact control\n", &output);
    let executable = dir
        .0
        .join("native-artifact")
        .with_extension(std::env::consts::EXE_EXTENSION);
    let retained = std::env::temp_dir().join(format!(
        "fwp-golden-counted-{}-native-artifact",
        std::process::id()
    ));
    let binary = std::fs::read(&executable).unwrap();
    assert_eq!(std::fs::read(&retained).unwrap(), binary);
    if cfg!(windows) {
        assert!(binary.starts_with(b"MZ"));
    }
    let status = std::fs::read_to_string(retained.with_extension("status")).unwrap();
    assert!(status.contains("run native: code=Some(0)"));
    assert!(retained.with_extension("c").is_file());
    if let Some(destination) = std::env::var_os("FWP_NATIVE_MEMORY_ARTIFACTS") {
        let destination = PathBuf::from(destination);
        std::fs::create_dir_all(&destination).unwrap();
        std::fs::write(destination.join("native.bin"), &binary).unwrap();
        for extension in ["c", "status", "report"] {
            std::fs::copy(
                retained.with_extension(extension),
                destination.join(format!("native.{extension}")),
            )
            .unwrap();
        }
    }
    std::fs::remove_file(&retained).unwrap();
    for extension in ["c", "status", "report"] {
        std::fs::remove_file(retained.with_extension(extension)).unwrap();
    }
}

#[cfg(unix)]
#[test]
fn native_corpus_reports_compiler_failure() {
    assert!(
        have_cc(),
        "native ownership checks require a working C compiler"
    );
    let dir = TempDir::new("compiler-failure-control");
    let source = dir.0.join("gc-compiler-failure-control.fwp");
    std::fs::write(&source, "main = \"hello\" | string.repeat 3 | echo\n").unwrap();
    let compiler = dir.0.join("fail-cc");
    std::fs::write(
        &compiler,
        "#!/bin/sh\nprintf '%s\\n' 'GC compiler failure control' >&2\nexit 37\n",
    )
    .unwrap();
    std::fs::set_permissions(&compiler, std::fs::Permissions::from_mode(0o755)).unwrap();
    let got = native_example_with_env(&source, &dir.0, &[("CC", compiler.to_str().unwrap())]);
    assert!(
        got.contains("GC compiler failure control"),
        "native compiler failure was not reported: {got}"
    );
    assert!(got.contains("--- exit "), "{got}");
    assert_ne!(got, "hellohellohello\n");
    retain_native_failure(&source, &dir.0, "hellohellohello\n", &got);
    let retained = std::env::temp_dir().join(format!(
        "fwp-golden-counted-{}-gc-compiler-failure-control",
        std::process::id()
    ));
    assert!(retained.with_extension("c").exists());
    assert!(std::fs::read_to_string(retained.with_extension("status"))
        .unwrap()
        .contains("build -O2: code=Some("));
    let positive = native_example(&source, &dir.0);
    assert_eq!(positive, "hellohellohello\n");
    let executable = dir.0.join("gc-compiler-failure-control");
    assert!(executable.exists());
    let positive_status = std::fs::read_to_string(executable.with_extension("status")).unwrap();
    assert!(positive_status.contains("build -O2: code=Some(0)"));
    assert!(positive_status.contains("run native: code=Some(0)"));
    if let Some(destination) = std::env::var_os("FWP_NATIVE_MEMORY_ARTIFACTS") {
        let destination = PathBuf::from(destination);
        std::fs::create_dir_all(&destination).unwrap();
        std::fs::copy(&source, destination.join("source.fwp")).unwrap();
        std::fs::copy(&executable, destination.join("positive.bin")).unwrap();
        std::fs::copy(
            executable.with_extension("status"),
            destination.join("positive.status"),
        )
        .unwrap();
        for extension in ["c", "status", "report"] {
            std::fs::copy(
                retained.with_extension(extension),
                destination.join(format!("negative.{extension}")),
            )
            .unwrap();
        }
    }
    for extension in ["c", "status", "report", "emit.log"] {
        let _ = std::fs::remove_file(retained.with_extension(extension));
    }
}

#[test]
#[cfg_attr(
    not(target_os = "linux"),
    ignore = "resident-memory checks require Linux /proc"
)]
fn long_loop_runs_in_bounded_memory() {
    assert!(linux(), "resident-memory checks require Linux /proc");
    assert!(
        have_cc(),
        "native ownership checks require a working C compiler"
    );
    let dir = TempDir::new("loop");
    let exe = dir.0.join("churn");
    build(
        &[
            root().join("tests/gc/churn.fwp").to_str().unwrap(),
            "-o",
            exe.to_str().unwrap(),
        ],
        &dir.0,
    );
    let out = Command::new(&exe)
        .env("FWP_ALLOC_STATS", "1")
        .output()
        .unwrap();
    assert!(out.status.success(), "{out:?}");
    assert_eq!(out.stdout, b"21768000\n");
    let report = allocation_report::parse(&String::from_utf8_lossy(&out.stderr)).unwrap();
    assert!(report.allocated > 0 && report.released > 0, "{report:?}");
    assert!(report.rss_kib < 64 * 1024, "max RSS {} KiB", report.rss_kib);
}

fn rss_kib(pid: u32) -> u64 {
    let s = std::fs::read_to_string(format!("/proc/{}/status", pid)).unwrap();
    s.lines()
        .find_map(|l| l.strip_prefix("VmRSS:"))
        .unwrap()
        .trim()
        .trim_end_matches("kB")
        .trim()
        .parse()
        .unwrap()
}

/// A server, killed when dropped (also when a test fails).
struct Running(Child, Option<JoinHandle<()>>);

impl Drop for Running {
    fn drop(&mut self) {
        let _ = self.0.kill();
        let _ = self.0.wait();
        if let Some(reader) = self.1.take() {
            reader.join().expect("memory-test server stderr reader");
        }
    }
}

/// Bound startup even for a silent server, and drain logs without retaining them.
fn start(mut cmd: Command, prefix: &str) -> (Running, String) {
    let description = format!("{cmd:?}");
    let (child, address, mut stderr) =
        http_server_process::start(&mut cmd, prefix, Duration::from_secs(60), Stdio::null())
            .unwrap_or_else(|error| panic!("{description}: {error}"));
    let address = address
        .trim_start_matches("http://")
        .trim_end_matches('/')
        .to_owned();
    let reader = std::thread::spawn(move || {
        let _ = std::io::copy(&mut stderr, &mut std::io::sink());
    });
    (Running(child, Some(reader)), address)
}

/// `n` GET requests over keep-alive connections of 50 requests each,
/// cycling through `paths`; every response must be a 200.
fn requests(addr: &str, paths: &[&str], n: usize) {
    let mut done = 0;
    while done < n {
        let conn = TcpStream::connect(addr).unwrap();
        conn.set_nodelay(true).unwrap();
        let mut reader = BufReader::new(conn);
        for _ in 0..50 {
            let path = paths[done % paths.len()];
            // one write: a request split over packets waits for delayed ACKs
            let req = format!("GET {} HTTP/1.1\r\nhost: test\r\n\r\n", path);
            reader.get_mut().write_all(req.as_bytes()).unwrap();
            let mut status = String::new();
            reader.read_line(&mut status).unwrap();
            assert!(status.contains(" 200 "), "{}: {:?}", path, status);
            let mut length = 0usize;
            loop {
                let mut h = String::new();
                reader.read_line(&mut h).unwrap();
                if h == "\r\n" || h.is_empty() {
                    break;
                }
                if let Some(v) = h.to_ascii_lowercase().strip_prefix("content-length:") {
                    length = v.trim().parse().unwrap();
                }
            }
            let mut body = vec![0u8; length];
            reader.read_exact(&mut body).unwrap();
            done += 1;
        }
    }
}

/// A server's resident memory grows by less than `limit_kib` over `n`
/// requests after a warm-up. The limit is whole-process growth, not heap bytes.
fn bounded_server(cmd: Command, marker: &str, paths: &[&str], n: usize, limit_kib: u64) {
    let (server, addr) = start(cmd, marker);
    requests(&addr, paths, 5000);
    let before = rss_kib(server.0.id());
    requests(&addr, paths, n);
    let after = rss_kib(server.0.id());
    drop(server);
    assert!(
        after < before + limit_kib,
        "RSS grew from {} KiB to {} KiB over {} requests",
        before,
        after,
        n
    );
}

#[test]
#[cfg_attr(
    not(target_os = "linux"),
    ignore = "resident-memory checks require Linux /proc"
)]
fn http_server_runs_in_bounded_memory() {
    assert!(linux(), "resident-memory checks require Linux /proc");
    assert!(
        have_cc(),
        "native ownership checks require a working C compiler"
    );
    let dir = TempDir::new("http");
    let exe = dir.0.join("api");
    build(
        &[
            root().join("examples/server/api.fwp").to_str().unwrap(),
            "-o",
            exe.to_str().unwrap(),
        ],
        &dir.0,
    );
    let mut cmd = Command::new(&exe);
    cmd.env("FWP_ADDR", "127.0.0.1:0");
    bounded_server(
        cmd,
        "listening on ",
        &["/health", "/items/7", "/items/123456"],
        20000,
        16 * 1024,
    );
}

#[test]
#[cfg_attr(
    not(target_os = "linux"),
    ignore = "resident-memory checks require Linux /proc"
)]
fn rest_server_runs_in_bounded_memory() {
    assert!(linux(), "resident-memory checks require Linux /proc");
    assert!(
        have_cc(),
        "native ownership checks require a working C compiler"
    );
    let dir = TempDir::new("rest");
    let exe = dir.0.join("books");
    build(
        &[
            root().join("examples/rest/books.fwp").to_str().unwrap(),
            "--rest",
            "-o",
            exe.to_str().unwrap(),
        ],
        &dir.0,
    );
    let mut cmd = Command::new(&exe);
    cmd.args(["--listen", "127.0.0.1:0"]);
    bounded_server(
        cmd,
        "fwp: rest listening on ",
        &["/health", "/books/2", "/books?author=Friedman"],
        20000,
        16 * 1024,
    );
}

#[test]
#[cfg_attr(
    not(target_os = "linux"),
    ignore = "resident-memory checks require Linux /proc"
)]
fn grpc_server_runs_in_bounded_memory() {
    assert!(linux(), "resident-memory checks require Linux /proc");
    assert!(
        have_cc(),
        "native ownership checks require a working C compiler"
    );
    let dir = TempDir::new("grpc");
    std::fs::copy(
        root().join("tests/grpc/greeter.fwp"),
        dir.0.join("greeter.fwp"),
    )
    .unwrap();
    std::fs::copy(root().join("tests/gc/hammer.fwp"), dir.0.join("hammer.fwp")).unwrap();
    build(
        &["hammer.fwp", "--service", "greeter", "-o", "split"],
        &dir.0,
    );
    let mut cmd = Command::new(dir.0.join("split/greeter"));
    cmd.args(["--listen", "127.0.0.1:0"]);
    let (server, addr) = start(cmd, "fwp: service greeter listening on ");
    let client = |n: &str| {
        let mut cmd = Command::new(dir.0.join("split/hammer"));
        cmd.env("FWP_SERVICE_GREETER", &addr)
            .env("N", n)
            .env("FWP_ALLOC_STATS", "1");
        let out = cmd.output().unwrap();
        assert!(
            out.status.success(),
            "{}",
            String::from_utf8_lossy(&out.stderr)
        );
        let report = allocation_report::parse(&String::from_utf8_lossy(&out.stderr)).unwrap();
        assert!(report.allocated > 0 && report.released > 0, "{report:?}");
        out
    };
    // the client: 2 calls per iteration
    let out = client("4000");
    assert_eq!(String::from_utf8_lossy(&out.stdout), "66893\n");
    let before = rss_kib(server.0.id());
    let mut samples = vec![before];
    for _ in 0..4 {
        let out = client("4000");
        assert_eq!(String::from_utf8_lossy(&out.stdout), "66893\n");
        samples.push(rss_kib(server.0.id()));
    }
    let after = rss_kib(server.0.id());
    drop(server);
    eprintln!("server RSS KiB after warm-up and each 8000-call batch: {samples:?}");
    // Keep the same whole-process bound as ownership replaces traced storage.
    assert!(
        after < before + 8 * 1024,
        "RSS grew from {} KiB to {} KiB over 32000 calls; samples {samples:?}",
        before,
        after
    );
}
