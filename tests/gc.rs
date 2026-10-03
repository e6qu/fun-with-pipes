//! The collector of native programs (runtime/fwp_rt_gc.c): every golden
//! program under FWP_GC_STRESS (a collection at every allocation, to find
//! missing roots) with FWP_GC_VERIFY (each minor collection checked
//! against a full trace, to find old objects pointing to young ones that
//! a minor collection does not see), and memory that stays bounded in a long allocating loop
//! and in HTTP, REST and gRPC servers handling many requests.

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
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
        .is_ok()
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

fn build(args: &[&str], cwd: &Path) {
    let out = Command::new(fwp())
        .arg("build")
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

/// A golden program built natively and run with a collection at every
/// allocation: the output must not change.
fn stressed(path: &Path, dir: &Path) -> Option<String> {
    let exe = dir.join(path.file_stem().unwrap());
    let b = Command::new(fwp())
        .arg("build")
        .arg(path.file_name().unwrap())
        .args(["-O2", "-o"])
        .arg(&exe)
        .current_dir(path.parent().unwrap())
        .output()
        .unwrap();
    if !b.status.success() {
        return None; // compile errors are covered by tests/golden_run.rs
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
    Some(render(
        &out.stdout,
        &out.stderr,
        out.status.code().unwrap_or(-1),
    ))
}

#[test]
fn golden_programs_under_gc_stress() {
    if !have_cc() {
        return;
    }
    let dir = TempDir::new("stress");
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
                let want = std::fs::read_to_string(path.with_extension("out")).unwrap_or_default();
                if let Some(got) = stressed(&path, &dir.0) {
                    if got != want {
                        failures.lock().unwrap().push(format!(
                            "{} (FWP_GC_STRESS=1):\n--- expected\n{}--- got\n{}",
                            path.display(),
                            want,
                            got
                        ));
                    }
                }
            });
        }
    });
    let failures = failures.into_inner().unwrap();
    assert!(failures.is_empty(), "{}", failures.join("\n"));
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
fn long_loop_runs_in_bounded_memory() {
    if !have_cc() || !linux() {
        return;
    }
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
        .env("FWP_GC_STATS", "1")
        .output()
        .unwrap();
    assert!(out.status.success());
    assert_eq!(String::from_utf8_lossy(&out.stdout), "21768000\n");
    let (allocated, collections, rss) = stats(&String::from_utf8_lossy(&out.stderr));
    // without a collector this needs about 1 GB
    assert!(allocated > 800.0, "allocated {} MiB", allocated);
    assert!(collections > 10, "{} collections", collections);
    assert!(rss < 64 * 1024, "max RSS {} KiB", rss);

    // FWP_GC=off: the same output, no collections
    let out = Command::new(&exe)
        .env("FWP_GC", "off")
        .env("FWP_GC_STATS", "1")
        .output()
        .unwrap();
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
fn http_server_runs_in_bounded_memory() {
    if !have_cc() || !linux() {
        return;
    }
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
fn rest_server_runs_in_bounded_memory() {
    if !have_cc() || !linux() {
        return;
    }
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
        "listening on ",
        &["/health", "/books/2", "/books?author=Friedman"],
        20000,
        16 * 1024,
    );
}

#[test]
fn grpc_server_runs_in_bounded_memory() {
    if !have_cc() || !linux() {
        return;
    }
    let dir = TempDir::new("grpc");
    std::fs::copy(
        root().join("tests/grpc/greeter.fwp"),
        dir.0.join("greeter.fwp"),
    )
    .unwrap();
    std::fs::copy(root().join("tests/gc/hammer.fwp"), dir.0.join("hammer.fwp")).unwrap();
    build(&["greeter.fwp", "--grpc", "-o", "greeter"], &dir.0);
    build(
        &["hammer.fwp", "--service", "greeter", "-o", "split"],
        &dir.0,
    );
    let mut cmd = Command::new(dir.0.join("greeter"));
    cmd.args(["--listen", "127.0.0.1:0"]);
    let (server, addr) = start(cmd, "listening on ");
    let client = |n: &str| {
        let out = Command::new(dir.0.join("split/hammer"))
            .env("FWP_SERVICE_GREETER", &addr)
            .env("N", n)
            .env("FWP_GC_STATS", "1")
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "{}",
            String::from_utf8_lossy(&out.stderr)
        );
        out
    };
    // the client: 2 calls per iteration
    let out = client("4000");
    assert_eq!(String::from_utf8_lossy(&out.stdout), "66893\n");
    let before = rss_kib(server.0.id());
    for _ in 0..4 {
        client("4000");
    }
    let after = rss_kib(server.0.id());
    drop(server);
    // without the collector the server grows by about 7 KiB per call
    assert!(
        after < before + 8 * 1024,
        "RSS grew from {} KiB to {} KiB over 32000 calls",
        before,
        after
    );
}
