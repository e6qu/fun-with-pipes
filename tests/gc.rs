//! The collector of native programs (runtime/fwp_rt_gc.c): every golden
//! program under FWP_GC_STRESS (a collection at every allocation, to find
//! missing roots) with FWP_GC_VERIFY (each minor collection checked
//! against a full trace, to find old objects pointing to young ones that
//! a minor collection does not see), and memory that stays bounded in a long allocating loop
//! and in HTTP, REST and gRPC servers handling many requests.

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
#[cfg(unix)]
use std::os::unix::fs::PermissionsExt;
#[cfg(unix)]
use std::os::unix::process::ExitStatusExt;
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};

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
        let d = std::env::temp_dir().join(format!("fwp-gc-{}-{}", name, std::process::id()));
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

fn build(args: &[&str], cwd: &Path, ownership: &str) {
    let out = Command::new(fwp())
        .args(["build", "--gc", ownership])
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

fn retain_stress_failure(path: &Path, dir: &Path, want: &str, got: &str) {
    let stem = path.file_stem().unwrap();
    let exe = dir
        .join(stem)
        .with_extension(std::env::consts::EXE_EXTENSION);
    let retained = std::env::temp_dir().join(format!(
        "fwp-golden-gc-{}-{}",
        std::process::id(),
        stem.to_string_lossy()
    ));
    if exe.exists() {
        std::fs::copy(&exe, &retained).unwrap();
        eprintln!("GC stress binary retained at {}", retained.display());
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
        .args(["build", "--gc", "tracing", "--emit-c", "-O2", "-o"])
        .arg(&source)
        .arg(path.file_name().unwrap())
        .current_dir(path.parent().unwrap())
        .output()
        .unwrap();
    if emitted.status.success() {
        eprintln!("GC stress C retained at {}", source.display());
    } else {
        std::fs::write(retained.with_extension("emit.log"), &emitted.stderr).unwrap();
    }
}

/// A golden program built natively and run with a collection at every
/// allocation: the output must not change.
fn stressed(path: &Path, dir: &Path) -> String {
    stressed_with_env(path, dir, &[])
}

fn stressed_with_env(path: &Path, dir: &Path, env: &[(&str, &str)]) -> String {
    let exe = dir
        .join(path.file_stem().unwrap())
        .with_extension(std::env::consts::EXE_EXTENSION);
    let b = Command::new(fwp())
        .args(["build", "--gc", "tracing"])
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
        // compiler failure for a valid program must not silently skip GC CI.
        return render(b"", &b.stderr, b.status.code().unwrap_or(-1));
    }
    let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
    let mut child = Command::new(&exe)
        .current_dir(path.parent().unwrap())
        .env("FWP_SEED", "42")
        .env("FWP_GC_STRESS", "1")
        // every minor collection checked against a full trace
        .env("FWP_GC_VERIFY", "1")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(&input).unwrap();
    let out = child.wait_with_output().unwrap();
    std::fs::write(
        &status_path,
        format!(
            "{build_status}run FWP_GC_STRESS=1 FWP_GC_VERIFY=1: {}\n",
            status_detail(out.status)
        ),
    )
    .unwrap();
    render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1))
}

#[test]
fn golden_programs_under_gc_stress() {
    assert!(have_cc(), "native GC checks require a working C compiler");
    let dir = TempDir::new("stress");
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
                eprintln!("GC stress example started: {}", path.display());
                let want = std::fs::read_to_string(path.with_extension("out")).unwrap_or_default();
                let got = stressed(&path, &dir.0);
                eprintln!(
                    "GC stress example finished: {} ({:.2}s)",
                    path.display(),
                    started.elapsed().as_secs_f64()
                );
                if got != want {
                    retain_stress_failure(&path, &dir.0, &want, &got);
                    failures.lock().unwrap().push(format!(
                        "{} (FWP_GC_STRESS=1):\n--- expected\n{}--- got\n{}",
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
fn gc_failure_artifacts_retain_the_native_executable() {
    assert!(have_cc(), "native artifact verification needs a C compiler");
    let dir = TempDir::new("native-artifact");
    let source = dir.0.join("native-artifact.fwp");
    std::fs::write(&source, "main = \"saved\" | string.repeat 2 | echo\n").unwrap();
    let output = stressed(&source, &dir.0);
    assert_eq!(output, "savedsaved\n");
    // Exercise failure retention with a deliberate snapshot mismatch, keeping
    // the native executable, its exact output/status and generated C together.
    retain_stress_failure(&source, &dir.0, "deliberate artifact control\n", &output);
    let executable = dir
        .0
        .join("native-artifact")
        .with_extension(std::env::consts::EXE_EXTENSION);
    let retained = std::env::temp_dir().join(format!(
        "fwp-golden-gc-{}-native-artifact",
        std::process::id()
    ));
    let binary = std::fs::read(&executable).unwrap();
    assert_eq!(std::fs::read(&retained).unwrap(), binary);
    if cfg!(windows) {
        assert!(binary.starts_with(b"MZ"));
    }
    let status = std::fs::read_to_string(retained.with_extension("status")).unwrap();
    assert!(status.contains("run FWP_GC_STRESS=1 FWP_GC_VERIFY=1: code=Some(0)"));
    assert!(retained.with_extension("c").is_file());
    if let Some(destination) = std::env::var_os("FWP_GC_DIAGNOSTICS_ARTIFACTS") {
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
fn gc_stress_reports_native_compiler_failure() {
    assert!(have_cc(), "native GC checks require a working C compiler");
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
    let got = stressed_with_env(&source, &dir.0, &[("CC", compiler.to_str().unwrap())]);
    assert!(
        got.contains("GC compiler failure control"),
        "native compiler failure was not reported: {got}"
    );
    assert!(got.contains("--- exit "), "{got}");
    assert_ne!(got, "hellohellohello\n");
    retain_stress_failure(&source, &dir.0, "hellohellohello\n", &got);
    let retained = std::env::temp_dir().join(format!(
        "fwp-golden-gc-{}-gc-compiler-failure-control",
        std::process::id()
    ));
    assert!(retained.with_extension("c").exists());
    assert!(std::fs::read_to_string(retained.with_extension("status"))
        .unwrap()
        .contains("build -O2: code=Some("));
    let positive = stressed(&source, &dir.0);
    assert_eq!(positive, "hellohellohello\n");
    let executable = dir.0.join("gc-compiler-failure-control");
    assert!(executable.exists());
    let positive_status = std::fs::read_to_string(executable.with_extension("status")).unwrap();
    assert!(positive_status.contains("build -O2: code=Some(0)"));
    assert!(positive_status.contains("run FWP_GC_STRESS=1 FWP_GC_VERIFY=1: code=Some(0)"));
    if let Some(destination) = std::env::var_os("FWP_GC_DIAGNOSTICS_ARTIFACTS") {
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

/// The collector's statistics line (FWP_GC_STATS=1): (MiB allocated,
/// collections, max RSS in KiB).
fn stats(stderr: &str) -> (f64, u64, u64) {
    let line = stderr
        .lines()
        .find(|l| l.starts_with("fwp gc: "))
        .unwrap_or_else(|| panic!("no statistics in {:?}", stderr));
    let words: Vec<&str> = line.split_whitespace().collect();
    let after = |w: &str| {
        let i = words.iter().position(|x| *x == w).unwrap();
        words[i + 1].trim_end_matches(',')
    };
    let collections = words[2].parse().unwrap();
    // "N collections (M minor), X MiB allocated"
    let mib = words.iter().position(|x| *x == "MiB").unwrap();
    let allocated = words[mib - 1].parse().unwrap();
    let rss = after("RSS").parse().unwrap();
    (allocated, collections, rss)
}

#[test]
#[cfg_attr(
    not(target_os = "linux"),
    ignore = "resident-memory checks require Linux /proc"
)]
fn long_loop_runs_in_bounded_memory() {
    assert!(linux(), "resident-memory checks require Linux /proc");
    assert!(have_cc(), "native GC checks require a working C compiler");
    let dir = TempDir::new("loop");
    let exe = dir.0.join("churn");
    // Exercise normal counted reclamation first; the separate shared build
    // below disables both freeing and reuse to require actual tracing.
    build(
        &[
            root().join("tests/gc/churn.fwp").to_str().unwrap(),
            "-o",
            exe.to_str().unwrap(),
        ],
        &dir.0,
        "tracing",
    );
    let out = Command::new(&exe)
        .env("FWP_GC_STATS", "1")
        .output()
        .unwrap();
    assert!(out.status.success());
    assert_eq!(String::from_utf8_lossy(&out.stdout), "21768000\n");
    let (allocated, _, rss) = stats(&String::from_utf8_lossy(&out.stderr));
    // Counted ownership can reclaim this workload without a collection.
    // The shared control below separately requires actual tracing.
    assert!(allocated > 0.0, "allocated {} MiB", allocated);
    assert!(rss < 64 * 1024, "max RSS {} KiB", rss);

    let shared = dir.0.join("churn-shared");
    let built = Command::new(fwp())
        .args(["build", "--gc", "tracing"])
        .arg(root().join("tests/gc/churn.fwp"))
        .arg("-o")
        .arg(&shared)
        .env("FWP_FREE", "0")
        .env("FWP_REUSE", "0")
        .current_dir(&dir.0)
        .output()
        .unwrap();
    assert!(
        built.status.success(),
        "{}",
        String::from_utf8_lossy(&built.stderr)
    );
    let out = Command::new(&shared)
        .env("FWP_GC_STATS", "1")
        .output()
        .unwrap();
    assert!(out.status.success());
    assert_eq!(String::from_utf8_lossy(&out.stdout), "21768000\n");
    let (allocated, collections, rss) = stats(&String::from_utf8_lossy(&out.stderr));
    // Without ownership or a collector this needs about 1 GB.
    assert!(allocated > 800.0, "allocated {} MiB", allocated);
    assert!(collections > 10, "{} collections", collections);
    assert!(rss < 64 * 1024, "max RSS {} KiB", rss);

    // FWP_GC=off: the same output, no collections
    let out = Command::new(&exe)
        .env("FWP_GC", "off")
        .env("FWP_GC_STATS", "1")
        .output()
        .unwrap();
    assert!(out.status.success());
    assert_eq!(String::from_utf8_lossy(&out.stdout), "21768000\n");
    let (_, collections, _) = stats(&String::from_utf8_lossy(&out.stderr));
    assert_eq!(collections, 0);
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
struct Running(Child);

impl Drop for Running {
    fn drop(&mut self) {
        let _ = self.0.kill();
        let _ = self.0.wait();
    }
}

/// Start a server and read the address from its first line on stderr
/// (after `marker`).
fn start(mut cmd: Command, marker: &str) -> (Running, String) {
    let mut server = Running(
        cmd.stdout(Stdio::null())
            .stderr(Stdio::piped())
            .spawn()
            .unwrap(),
    );
    let mut stderr = BufReader::new(server.0.stderr.take().unwrap());
    let mut line = String::new();
    loop {
        line.clear();
        stderr.read_line(&mut line).unwrap();
        assert!(!line.is_empty(), "server exited");
        if let Some(a) = line.trim().split(marker).nth(1) {
            let addr = a.trim_start_matches("http://").trim_end_matches('/');
            let addr = addr.to_string();
            // keep draining stderr so the server never blocks on it
            std::thread::spawn(move || {
                let mut sink = Vec::new();
                let _ = stderr.read_to_end(&mut sink);
            });
            return (server, addr);
        }
    }
}

/// `n` GET requests over keep-alive connections of 50 requests each,
/// cycling through `paths`; every response must be a 200.
fn requests(addr: &str, paths: &[&str], n: usize) {
    let mut done = 0;
    while done < n {
        let conn = TcpStream::connect(addr).unwrap();
        let mut reader = BufReader::new(conn.try_clone().unwrap());
        conn.set_nodelay(true).unwrap();
        let mut w = conn;
        for _ in 0..50 {
            let path = paths[done % paths.len()];
            // one write: a request split over packets waits for delayed ACKs
            let req = format!("GET {} HTTP/1.1\r\nhost: test\r\n\r\n", path);
            w.write_all(req.as_bytes()).unwrap();
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
/// requests after a warm-up (without the collector it grows by about
/// 11 KiB per request).
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
    assert!(have_cc(), "native GC checks require a working C compiler");
    let dir = TempDir::new("http");
    let exe = dir.0.join("api");
    build(
        &[
            root().join("examples/server/api.fwp").to_str().unwrap(),
            "-o",
            exe.to_str().unwrap(),
        ],
        &dir.0,
        "tracing",
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
    assert!(have_cc(), "native GC checks require a working C compiler");
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
        "tracing",
    );
    let mut cmd = Command::new(&exe);
    cmd.args(["--listen", "127.0.0.1:0"]);
    bounded_server(
        cmd,
        "listening on ",
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
    grpc_server_memory("tracing");
}

#[test]
#[cfg_attr(
    not(target_os = "linux"),
    ignore = "resident-memory checks require Linux /proc"
)]
fn arc_grpc_server_runs_in_bounded_memory() {
    grpc_server_memory("arc");
}

fn grpc_server_memory(memory_mode: &str) {
    assert!(linux(), "resident-memory checks require Linux /proc");
    assert!(have_cc(), "native GC checks require a working C compiler");
    let dir = TempDir::new(&format!("grpc-{memory_mode}"));
    std::fs::copy(
        root().join("tests/grpc/greeter.fwp"),
        dir.0.join("greeter.fwp"),
    )
    .unwrap();
    std::fs::copy(root().join("tests/gc/hammer.fwp"), dir.0.join("hammer.fwp")).unwrap();
    build(
        &["hammer.fwp", "--service", "greeter", "-o", "split"],
        &dir.0,
        memory_mode,
    );
    let mut cmd = Command::new(dir.0.join("split/greeter"));
    cmd.args(["--listen", "127.0.0.1:0"]);
    if memory_mode == "arc" {
        cmd.env_remove("FWP_GC")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0");
    }
    let (server, addr) = start(cmd, "listening on ");
    let client = |n: &str| {
        let mut cmd = Command::new(dir.0.join("split/hammer"));
        cmd.env("FWP_SERVICE_GREETER", &addr)
            .env("N", n)
            .env("FWP_GC_STATS", "1");
        if memory_mode == "arc" {
            cmd.env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0");
        }
        let out = cmd.output().unwrap();
        assert!(
            out.status.success(),
            "{}",
            String::from_utf8_lossy(&out.stderr)
        );
        if memory_mode == "arc" {
            assert_eq!(stats(&String::from_utf8_lossy(&out.stderr)).1, 0);
        }
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
    eprintln!("{memory_mode} server RSS KiB after warm-up and each 8000-call batch: {samples:?}");
    // Keep the same whole-process bound as ownership replaces traced storage.
    assert!(
        after < before + 8 * 1024,
        "RSS grew from {} KiB to {} KiB over 32000 calls; samples {samples:?}",
        before,
        after
    );
}
