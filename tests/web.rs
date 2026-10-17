//! HTTP/2, WebSocket and HTTP compression (docs/concurrency.md) on both
//! backends, with tests/web/server.fwp and tests/web/client.fwp:
//!
//! - curl over HTTP/2 (h2c with prior knowledge, and h2 chosen with ALPN
//!   over TLS), concurrent streams on one connection, a graceful shutdown
//!   with a stream in flight, `--compressed`, compressed request bodies;
//! - the fwp client against the fwp server, every pairing of the
//!   interpreter and native code, in cleartext and over TLS (h2, wss);
//! - WebSocket from raw sockets (the handshake, masking, fragmentation,
//!   ping and pong, close codes, an oversized message, an unmasked client
//!   frame) and from node's WebSocket client when node is installed;
//! - the native client and server under `FWP_GC_STRESS=16`.
//!
//! TLS needs the `openssl` command (for a throwaway CA and certificate);
//! without it, curl or a C compiler, the tests that need them are skipped.

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::sync::OnceLock;
use std::time::{Duration, Instant};

#[path = "support/client_allocations.rs"]
mod client_allocations;

#[path = "support/entry_checks.rs"]
mod entry_checks;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn have(cmd: &str, arg: &str) -> bool {
    Command::new(cmd)
        .arg(arg)
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()
        .is_ok_and(|status| status.success())
}

fn have_cc() -> bool {
    have(
        &std::env::var("CC").unwrap_or_else(|_| "cc".into()),
        "--version",
    )
}

fn scratch(name: &str) -> PathBuf {
    let d = std::env::temp_dir().join(format!("fwp-web-{}-{}", std::process::id(), name));
    let _ = std::fs::remove_dir_all(&d);
    std::fs::create_dir_all(&d).unwrap();
    d
}

/// A CA (ca.pem) and a certificate for localhost and 127.0.0.1 that it
/// signed (server.pem, server.key); `None` without `openssl`.
fn certs() -> Option<&'static Path> {
    static DIR: OnceLock<Option<PathBuf>> = OnceLock::new();
    DIR.get_or_init(|| {
        if !have("openssl", "version") {
            eprintln!("skipping TLS: no openssl command");
            return None;
        }
        let d = scratch("certs");
        let run = |args: &[&str]| {
            Command::new("openssl")
                .args(args)
                .current_dir(&d)
                .stdout(Stdio::null())
                .stderr(Stdio::null())
                .status()
                .is_ok_and(|s| s.success())
        };
        std::fs::write(
            d.join("ext.cnf"),
            "subjectAltName=DNS:localhost,IP:127.0.0.1\n",
        )
        .unwrap();
        let ok = run(&[
            "req",
            "-x509",
            "-newkey",
            "rsa:2048",
            "-nodes",
            "-keyout",
            "ca.key",
            "-out",
            "ca.pem",
            "-days",
            "2",
            "-subj",
            "/CN=fwp test CA",
        ]) && run(&[
            "req",
            "-newkey",
            "rsa:2048",
            "-nodes",
            "-keyout",
            "server.key",
            "-out",
            "server.csr",
            "-subj",
            "/CN=localhost",
        ]) && run(&[
            "x509",
            "-req",
            "-in",
            "server.csr",
            "-CA",
            "ca.pem",
            "-CAkey",
            "ca.key",
            "-CAcreateserial",
            "-out",
            "server.pem",
            "-days",
            "2",
            "-extfile",
            "ext.cnf",
        ]);
        ok.then_some(d)
    })
    .as_deref()
}

/// The native server and client, built once.
fn natives() -> Option<&'static (PathBuf, PathBuf)> {
    static EXES: OnceLock<Option<(PathBuf, PathBuf)>> = OnceLock::new();
    EXES.get_or_init(|| {
        if !have_cc() {
            eprintln!("skipping native: no C compiler");
            return None;
        }
        let d = scratch("bin");
        let build = |name: &str| {
            let exe = d.join(name);
            let st = Command::new(fwp())
                .arg("build")
                .arg(root().join("tests/web").join(format!("{}.fwp", name)))
                .arg("-o")
                .arg(&exe)
                .status()
                .unwrap();
            assert!(st.success(), "building {}", name);
            exe
        };
        Some((build("server"), build("client")))
    })
    .as_ref()
}

#[derive(Clone, Copy, PartialEq, Debug)]
enum Backend {
    Interp,
    Native,
}

struct Server {
    child: Child,
    addr: String,
    stderr: BufReader<std::process::ChildStderr>,
}

impl Drop for Server {
    fn drop(&mut self) {
        let _ = self.child.kill();
        let _ = self.child.wait();
    }
}

fn program(b: Backend, name: &str) -> Option<Command> {
    match b {
        Backend::Interp => {
            let mut c = Command::new(fwp());
            c.args(["run", "--interp"])
                .arg(root().join("tests/web").join(format!("{}.fwp", name)));
            Some(c)
        }
        Backend::Native => {
            let (s, c) = natives()?;
            Some(Command::new(if name == "server" { s } else { c }))
        }
    }
}

fn start(b: Backend, tls: bool, env: &[(&str, &str)]) -> Option<Server> {
    start_command(program(b, "server")?, tls, env)
}

fn start_command(mut cmd: Command, tls: bool, env: &[(&str, &str)]) -> Option<Server> {
    if tls {
        let d = certs()?;
        cmd.env("FWP_TLS_CERT", d.join("server.pem"))
            .env("FWP_TLS_KEY", d.join("server.key"));
    }
    for (k, v) in env {
        cmd.env(k, v);
    }
    #[cfg(windows)]
    {
        use std::os::windows::process::CommandExt;
        cmd.creation_flags(0x00000200); // isolate CTRL_BREAK to this server
    }
    let mut child = cmd
        .env("FWP_ADDR", "127.0.0.1:0")
        .stdout(Stdio::null())
        .stderr(Stdio::piped())
        .spawn()
        .expect("start server");
    let mut stderr = BufReader::new(child.stderr.take().unwrap());
    let mut line = String::new();
    stderr.read_line(&mut line).expect("read address");
    let addr = line
        .trim()
        .strip_prefix(if tls {
            "listening on https://"
        } else {
            "listening on http://"
        })
        .unwrap_or_else(|| panic!("unexpected first line: {:?}", line))
        .to_string();
    Some(Server {
        child,
        addr,
        stderr,
    })
}

fn curl_program() -> String {
    std::env::var("FWP_TEST_CURL").unwrap_or_else(|_| "curl".into())
}

fn curl(args: &[&str]) -> String {
    let out = Command::new(curl_program())
        .args(["-sS", "-m", "20"])
        .args(args)
        .output()
        .expect("run curl");
    assert!(out.status.success(), "curl {args:?}: {out:?}");
    String::from_utf8_lossy(&out.stdout).into_owned()
}

fn stop_server(server: &mut Server, base: &str, ca: &Path) -> String {
    assert_eq!(
        curl(&[
            "--http1.1",
            "--cacert",
            ca.to_str().unwrap(),
            &format!("{base}/stop")
        ]),
        "stopping"
    );
    let until = Instant::now() + Duration::from_secs(30);
    loop {
        if let Some(status) = server.child.try_wait().unwrap() {
            let mut stderr = String::new();
            server.stderr.read_to_string(&mut stderr).unwrap();
            assert!(status.success(), "server: {status}: {stderr}");
            assert!(stderr.lines().any(|line| line == "stopped"), "{stderr}");
            return stderr;
        }
        assert!(Instant::now() < until, "server did not finish shutdown");
        std::thread::sleep(Duration::from_millis(20));
    }
}

#[cfg(any(target_os = "linux", target_os = "macos", windows))]
fn process_rss_kib(pid: u32) -> u64 {
    #[cfg(target_os = "linux")]
    {
        let status = std::fs::read_to_string(format!("/proc/{pid}/status")).unwrap();
        status
            .lines()
            .find_map(|line| line.strip_prefix("VmRSS:"))
            .unwrap()
            .split_whitespace()
            .next()
            .unwrap()
            .parse()
            .unwrap()
    }
    #[cfg(target_os = "macos")]
    {
        let out = Command::new("ps")
            .args(["-o", "rss=", "-p", &pid.to_string()])
            .output()
            .unwrap();
        assert!(out.status.success(), "{out:?}");
        String::from_utf8(out.stdout)
            .unwrap()
            .trim()
            .parse()
            .unwrap()
    }
    #[cfg(windows)]
    {
        let out = Command::new("powershell")
            .args([
                "-NoProfile",
                "-Command",
                &format!("[math]::Floor((Get-Process -Id {pid}).WorkingSet64 / 1024)"),
            ])
            .output()
            .unwrap();
        assert!(out.status.success(), "{out:?}");
        String::from_utf8(out.stdout)
            .unwrap()
            .trim()
            .parse()
            .unwrap()
    }
}

fn backends() -> Vec<Backend> {
    let mut v = vec![Backend::Interp];
    if natives().is_some() {
        v.push(Backend::Native);
    }
    v
}

// ------------------------------------------------------------------ curl

fn curl_cleartext(b: Backend) {
    if !have(&curl_program(), "--version") {
        return;
    }
    let Some(srv) = start(b, false, &[]) else {
        return;
    };
    let base = format!("http://{}", srv.addr);
    let u = |p: &str| format!("{}{}", base, p);
    let fmt = "|%{http_version}|%{http_code}";
    assert_eq!(
        curl(&["-w", fmt, &u("/hello")]),
        "hello over HTTP/1.1|1.1|200"
    );
    assert_eq!(
        curl(&["--http2-prior-knowledge", "-w", fmt, &u("/hello")]),
        "hello over HTTP/2|2|200"
    );
    // `Upgrade: h2c`: the request (with its body) is stream 1, and the
    // connection goes on as HTTP/2
    assert_eq!(
        curl(&["--http2", "-w", fmt, &u("/hello")]),
        "hello over HTTP/2|2|200"
    );
    assert_eq!(
        curl(&["--http2", "-d", "posted body", "-w", fmt, &u("/echo")]),
        "11 bytes: posted body|2|200"
    );
    assert_eq!(
        curl(&["--http2", "-w", fmt, &u("/hello"), &u("/stream")]),
        "hello over HTTP/2|2|200chunk 1\nchunk 2\nchunk 3\n|2|200"
    );
    // HEAD, an unknown path, and a streamed body, over HTTP/2
    let head = curl(&["--http2-prior-knowledge", "-I", &u("/hello")]);
    assert!(head.starts_with("HTTP/2 200"), "{}", head);
    assert!(head.contains("content-length: 17"), "{}", head);
    assert_eq!(
        curl(&["--http2-prior-knowledge", "-w", fmt, &u("/nothing")]),
        "not found|2|404"
    );
    assert_eq!(
        curl(&["--http2-prior-knowledge", "-w", fmt, &u("/stream")]),
        "chunk 1\nchunk 2\nchunk 3\n|2|200"
    );
    // compression: --compressed, over both versions
    for v in ["--http1.1", "--http2-prior-knowledge"] {
        let headers = curl(&[
            v,
            "--compressed",
            "-D",
            "-",
            "-o",
            if cfg!(windows) { "NUL" } else { "/dev/null" },
            &u("/big"),
        ]);
        assert!(
            headers
                .to_ascii_lowercase()
                .contains("content-encoding: gzip"),
            "{}",
            headers
        );
        let body = curl(&[v, "--compressed", &u("/big")]);
        assert_eq!(body, "compress me ".repeat(500));
        // without accept-encoding, the body is sent as it is
        let plain = curl(&[v, "-D", "-", &u("/big")]);
        assert!(!plain.contains("content-encoding"), "{}", plain);
        assert!(plain.ends_with(&"compress me ".repeat(500)));
        // a streamed body is gzipped chunk by chunk; for a client that
        // accepts only deflate, it is sent as it is
        let stream = curl(&[v, "--compressed", "-D", "-", &u("/stream")]);
        assert!(
            stream
                .to_ascii_lowercase()
                .contains("content-encoding: gzip"),
            "{}",
            stream
        );
        assert!(
            stream.ends_with("chunk 1\nchunk 2\nchunk 3\n"),
            "{}",
            stream
        );
        let deflate = curl(&[
            v,
            "-H",
            "accept-encoding: deflate",
            "-D",
            "-",
            &u("/stream"),
        ]);
        assert!(!deflate.contains("content-encoding"), "{}", deflate);
        assert!(
            deflate.ends_with("chunk 1\nchunk 2\nchunk 3\n"),
            "{}",
            deflate
        );
    }
    // a small body is left alone by the config, compressed by the
    // middleware; `q=0` refuses a coding
    let small = curl(&["--compressed", "-D", "-", &u("/small")]);
    assert!(small.contains("content-encoding: gzip"), "{}", small);
    assert!(small.ends_with("small but compressed"), "{}", small);
    let refused = curl(&["-H", "accept-encoding: gzip;q=0", "-D", "-", &u("/small")]);
    assert!(!refused.contains("content-encoding"), "{}", refused);
    // request bodies with a content encoding
    let dir = scratch(&format!("gz-{:?}", b));
    let gz = dir.join("body.gz");
    // Fixed Python gzip output keeps this input independent of fwp's encoder.
    std::fs::write(&gz, include_bytes!("web/zipped-body.gz")).unwrap();
    {
        for v in ["--http1.1", "--http2-prior-knowledge"] {
            assert_eq!(
                curl(&[
                    v,
                    "-H",
                    "content-encoding: gzip",
                    "--data-binary",
                    &format!("@{}", gz.display()),
                    "-w",
                    fmt,
                    &u("/echo"),
                ])
                .split('|')
                .next()
                .unwrap(),
                "11 bytes: zipped body"
            );
        }
    }
    assert_eq!(
        curl(&[
            "-H",
            "content-encoding: br",
            "-d",
            "x",
            "-w",
            fmt,
            &u("/echo")
        ]),
        "unsupported content encoding|1.1|415"
    );
    assert_eq!(
        curl(&[
            "-H",
            "content-encoding: gzip",
            "-d",
            "not gzip",
            "-w",
            fmt,
            &u("/echo")
        ]),
        "invalid compressed request body|1.1|400"
    );

    // concurrent streams: five slow requests on one connection, together
    let started = Instant::now();
    let out = curl(&[
        "--http2-prior-knowledge",
        "-Z",
        "-w",
        "%{num_connects} %{http_version} %{http_code}\n",
        "-o",
        if cfg!(windows) { "NUL" } else { "/dev/null" },
        "-o",
        if cfg!(windows) { "NUL" } else { "/dev/null" },
        "-o",
        if cfg!(windows) { "NUL" } else { "/dev/null" },
        "-o",
        if cfg!(windows) { "NUL" } else { "/dev/null" },
        "-o",
        if cfg!(windows) { "NUL" } else { "/dev/null" },
        &u("/slow"),
        &u("/slow"),
        &u("/slow"),
        &u("/slow"),
        &u("/slow"),
    ]);
    let elapsed = started.elapsed();
    let lines: Vec<&str> = out.lines().collect();
    assert_eq!(lines.len(), 5, "{}", out);
    let connects: u32 = lines
        .iter()
        .map(|l| l.split(' ').next().unwrap().parse::<u32>().unwrap())
        .sum();
    assert_eq!(connects, 1, "one connection for five streams: {}", out);
    assert!(lines.iter().all(|l| l.ends_with(" 2 200")), "{}", out);
    assert!(
        elapsed < Duration::from_millis(1400),
        "the streams ran one after another: {:?}",
        elapsed
    );
    drop(srv);
}

#[test]
fn curl_h2c_and_compression_interpreted() {
    curl_cleartext(Backend::Interp);
}

#[test]
fn curl_h2c_and_compression_native() {
    if natives().is_some() {
        curl_cleartext(Backend::Native);
    }
}

#[test]
fn curl_h2_over_tls_with_alpn() {
    if !have(&curl_program(), "--version") || certs().is_none() {
        return;
    }
    let ca = certs().unwrap().join("ca.pem");
    let ca = ca.to_str().unwrap();
    for b in backends() {
        let srv = start(b, true, &[]).unwrap();
        let u = format!("https://{}/hello", srv.addr);
        let fmt = "|%{http_version}";
        assert_eq!(
            curl(&["--cacert", ca, "--http2", "-w", fmt, &u]),
            "hello over HTTP/2|2",
            "{:?}",
            b
        );
        // a client that offers only HTTP/1.1
        assert_eq!(
            curl(&["--cacert", ca, "--http1.1", "-w", fmt, &u]),
            "hello over HTTP/1.1|1.1",
            "{:?}",
            b
        );
        let big = curl(&[
            "--cacert",
            ca,
            "--http2",
            "--compressed",
            &format!("https://{}/big", srv.addr),
        ]);
        assert_eq!(big, "compress me ".repeat(500));
    }
}

#[test]
fn h2_graceful_shutdown() {
    if !have(&curl_program(), "--version") {
        return;
    }
    for b in backends() {
        let mut srv = start(b, false, &[]).unwrap();
        let u = format!("http://{}/slow", srv.addr);
        let slow = std::thread::spawn(move || {
            curl(&["--http2-prior-knowledge", "-w", "|%{http_code}", &u])
        });
        std::thread::sleep(Duration::from_millis(150));
        #[cfg(unix)]
        assert!(Command::new("kill")
            .args(["-TERM", &srv.child.id().to_string()])
            .status()
            .unwrap()
            .success());
        #[cfg(windows)]
        {
            #[link(name = "kernel32")]
            extern "system" {
                fn GenerateConsoleCtrlEvent(event: u32, group: u32) -> i32;
            }
            assert_ne!(
                unsafe { GenerateConsoleCtrlEvent(1, srv.child.id()) },
                0,
                "send CTRL_BREAK: {}",
                std::io::Error::last_os_error()
            );
        }
        assert_eq!(slow.join().unwrap(), "slow|200", "{:?}", b);
        let st = srv.child.wait().unwrap();
        assert!(st.success(), "{:?}: {}", b, st);
        let mut rest = String::new();
        srv.stderr.read_to_string(&mut rest).unwrap();
        assert_eq!(rest.trim(), "stopped");
    }
}

// --------------------------------------------------------- fwp ↔ fwp

fn expected_client(tls: bool) -> String {
    format!(
        "auto: (200, \"hello over HTTP/{}\")
http/1.1: (200, \"hello over HTTP/1.1\")
http/2: (200, \"hello over HTTP/2\")
big: 6000 bytes, content-encoding None
stream: (200, \"chunk 1\\nchunk 2\\nchunk 3\\n\")
gzip request: (200, \"18 bytes: compressed request\")
concurrent: [Some 200, Some 200, Some 200, Some 200]
protocol Some \"superchat\"
text ping me
binary [1, 2, 255]
long text 60000
close 4000 asked to
end
done
",
        if tls { "2" } else { "1.1" }
    )
}

fn run_client(b: Backend, srv: &Server, tls: bool, env: &[(&str, &str)]) {
    let mut cmd = program(b, "client").unwrap();
    let (http, ws) = if tls {
        ("https", "wss")
    } else {
        ("http", "ws")
    };
    cmd.env("FWP_BASE", format!("{}://{}", http, srv.addr))
        .env("FWP_WS", format!("{}://{}/ws", ws, srv.addr));
    if tls {
        cmd.env("SSL_CERT_FILE", certs().unwrap().join("ca.pem"));
    }
    for (k, v) in env {
        cmd.env(k, v);
    }
    let out = cmd.output().unwrap();
    assert_eq!(
        String::from_utf8_lossy(&out.stdout),
        expected_client(tls),
        "client {:?}; stderr: {}",
        b,
        String::from_utf8_lossy(&out.stderr)
    );
    assert!(out.status.success());
}

fn fwp_pairs(tls: bool) {
    if tls && certs().is_none() {
        return;
    }
    for sb in backends() {
        let srv = start(sb, tls, &[]).unwrap();
        for cb in backends() {
            run_client(cb, &srv, tls, &[]);
        }
    }
}

#[test]
fn fwp_client_and_server() {
    fwp_pairs(false);
}

#[test]
fn fwp_client_and_server_over_tls() {
    fwp_pairs(true);
}

#[test]
fn checked_arc_http_matches_interpreter_with_pooled_and_tls_calls() {
    assert!(have_cc(), "HTTP ARC checks require a native C compiler");
    let ca = certs().expect("HTTP ARC checks require OpenSSL for native TLS");
    let dir = scratch("arc-client");
    let source = root().join("tests/web/arc-client.fwp");
    let artifacts = std::env::var_os("FWP_HTTP_CLIENT_ARTIFACTS").map(PathBuf::from);
    if let Some(path) = &artifacts {
        std::fs::create_dir_all(path).unwrap();
    }
    let mut binaries = Vec::new();
    let mut servers = Vec::new();
    for role in ["client", "server"] {
        let input = root().join(if role == "client" {
            "tests/web/arc-client.fwp"
        } else {
            "tests/web/server.fwp"
        });
        let artifact_dir = artifacts.as_ref().map(|path| {
            if role == "client" {
                path.clone()
            } else {
                path.join("server")
            }
        });
        if let Some(path) = &artifact_dir {
            std::fs::create_dir_all(path).unwrap();
        }
        for mode in ["tracing", "arc"] {
            for opt in ["-O1", "-O2"] {
                eprintln!("Building HTTP {role} {mode} {opt}");
                let cfile = dir.join(format!("{role}-{mode}{opt}.c"));
                let binary = dir.join(format!("{role}-{mode}{opt}.exe"));
                let out = Command::new(fwp())
                    .args(["build", "--gc", mode, "--emit-c", "-o"])
                    .arg(&cfile)
                    .arg(&input)
                    .output()
                    .unwrap();
                assert!(out.status.success(), "{mode}: {out:?}");
                let code = std::fs::read_to_string(&cfile).unwrap();
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                if let Some(path) = &artifact_dir {
                    std::fs::copy(&cfile, path.join(format!("{mode}{opt}.c"))).unwrap();
                    std::fs::copy(&binary, path.join(format!("{mode}{opt}.exe"))).unwrap();
                }
                if mode == "arc" {
                    let symbols = Command::new("nm").arg(&binary).output().unwrap();
                    assert!(symbols.status.success(), "{symbols:?}");
                    let symbols = String::from_utf8_lossy(&symbols.stdout);
                    for name in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                        assert!(!symbols.contains(name), "ARC {role} contains {name}");
                    }
                    if let Some(path) = &artifact_dir {
                        std::fs::write(path.join(format!("{mode}{opt}.nm")), symbols.as_bytes())
                            .unwrap();
                    }
                }
                if role == "client" {
                    binaries.push((mode, opt, binary));
                } else {
                    servers.push((mode, opt, binary));
                }
            }
        }
    }
    for tls in [false, true] {
        let mut programs = vec![(
            "interp".to_owned(),
            program(Backend::Interp, "server").unwrap(),
        )];
        for (mode, opt, binary) in &servers {
            let mut command = Command::new(binary);
            let stress = if *mode == "tracing" { "1" } else { "0" };
            command
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress);
            programs.push((format!("{mode}{opt}"), command));
        }
        for (backend, command) in programs {
            let mut server = start_command(command, tls, &[]).unwrap();
            let base = format!("{}://{}", if tls { "https" } else { "http" }, server.addr);
            let run = |command: &mut Command| {
                command
                    .env("FWP_BASE", &base)
                    .env("SSL_CERT_FILE", ca.join("ca.pem"))
                    .output()
                    .unwrap()
            };
            eprintln!("Comparing HTTP interpreter client / {backend} server / TLS {tls}");
            let reference = run(Command::new(fwp()).args(["run", "--interp"]).arg(&source));
            assert!(
                reference.status.success(),
                "{backend:?}/{tls}: {reference:?}"
            );
            let expected = expected_client(tls)
                .split("protocol Some")
                .next()
                .unwrap()
                .to_owned()
                + "done\n";
            assert_eq!(String::from_utf8_lossy(&reference.stdout), expected);
            for (mode, opt, binary) in &binaries {
                eprintln!("Comparing HTTP {mode} {opt} client / {backend} server / TLS {tls}");
                let out = run(Command::new(binary)
                    .env("FWP_GC_STRESS", if *mode == "tracing" { "1" } else { "0" })
                    .env("FWP_GC_VERIFY", if *mode == "tracing" { "1" } else { "0" })
                    .env(
                        "FWP_REUSE_VERIFY",
                        if *mode == "tracing" { "1" } else { "0" },
                    ));
                assert!(
                    out.status.success(),
                    "{mode}/{opt}/{backend:?}/{tls}: {out:?}"
                );
                assert_eq!(
                    out.stdout, reference.stdout,
                    "{mode}/{opt}/{backend:?}/{tls}"
                );
                if let Some(path) = &artifacts {
                    let prefix = format!("{mode}{opt}-{backend}-tls-{tls}");
                    std::fs::write(path.join(format!("{prefix}.stdout")), &out.stdout).unwrap();
                    std::fs::write(path.join(format!("{prefix}.stderr")), &out.stderr).unwrap();
                }
            }
            let stderr = stop_server(&mut server, &base, &ca.join("ca.pem"));
            if let Some(path) = &artifacts {
                std::fs::write(
                    path.join(format!("server-{backend}-tls-{tls}.stderr")),
                    stderr,
                )
                .unwrap();
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

/// Compare current tracing/ARC costs for identical pooled HTTP/2 calls. These
/// allocation counters exclude raw transport buffers and are not a speed test.
#[test]
#[ignore = "runner-only repeated HTTP client allocation measurement"]
fn repeated_http_client_memory_measurement() {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let artifacts = PathBuf::from(
        std::env::var_os("FWP_HTTP_MEMORY_ARTIFACTS").expect("measurement artifact directory"),
    );
    std::fs::create_dir_all(&artifacts).unwrap();
    let source = root().join("tests/web/repeated-client.fwp");
    std::fs::copy(&source, artifacts.join("client.fwp")).unwrap();
    std::fs::write(artifacts.join("scope.txt"), "Current fwp tracing and checked ARC clients perform identical sequential pooled HTTP/2 GET /hello calls against an interpreted loopback server. Each response body is consumed/released and its status contributes 200 to the result. Inputs: 1, 16, 256 calls, cleartext and TLS; three separate instrumented processes per case, with raw interpreter and ordinary native output as controls. Native -O2, ordinary compiler optimization, -ffp-contract=off. Managed allocation requests/bytes, effective retains and allocator-charged peak/final storage start after constant initialization and end after entry execution and cached-value cleanup, before whole-runtime shutdown. GC is disabled and physical freeing enabled in both modes. Pooled connections and detached I/O tasks can remain at this sample. Raw network buffers, TLS/allocator/OS metadata, server memory, process RSS and timing are excluded. This compares memory modes at one revision, not before/after speed or C/Rust parity. Source, ordinary and instrumented C/binaries and raw results are retained.\n").unwrap();
    let ca = certs().expect("HTTP memory checks require OpenSSL");
    let mut binaries = Vec::new();
    for mode in ["tracing", "arc"] {
        let cfile = artifacts.join(format!("{mode}.c"));
        let out = Command::new(fwp())
            .args(["build", "--gc", mode, "--emit-c", "-o"])
            .arg(&cfile)
            .arg(&source)
            .output()
            .unwrap();
        assert!(out.status.success(), "{mode}: {out:?}");
        let generated = std::fs::read_to_string(&cfile).unwrap();
        let instrumented = client_allocations::instrument_client_allocations(&generated);
        let measured_c = artifacts.join(format!("{mode}-measured.c"));
        std::fs::write(measured_c, &instrumented).unwrap();
        let ordinary = artifacts.join(format!("{mode}.exe"));
        let measured = artifacts.join(format!("{mode}-measured.exe"));
        fwp::cgen::compile_c(&generated, &ordinary, "-O2").unwrap();
        fwp::cgen::compile_c(&instrumented, &measured, "-O2").unwrap();
        binaries.push((mode, ordinary, measured));
    }
    let mut rows = String::from("mode\ttls\tcalls\trepetition\trequests\trequested_bytes\tretains\tpeak_charged_bytes\tfinal_charged_bytes\tcollections\n");
    let mut final_storage = std::collections::BTreeMap::new();
    for tls in [false, true] {
        let server = start(Backend::Interp, tls, &[]).unwrap();
        let base = format!("{}://{}", if tls { "https" } else { "http" }, server.addr);
        for calls in [1, 16, 256] {
            let expected = format!("{}\n", calls * 200);
            let run = |command: &mut Command| {
                command
                    .arg(calls.to_string())
                    .env("FWP_BASE", &base)
                    .env("SSL_CERT_FILE", ca.join("ca.pem"))
                    .env("FWP_GC", "off")
                    .env("FWP_FREE", "1")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap()
            };
            let reference = run(Command::new(fwp())
                .args(["run", "--interp"])
                .env("FWP_NO_OPT", "1")
                .arg(&source));
            assert!(reference.status.success(), "{reference:?}");
            assert_eq!(String::from_utf8_lossy(&reference.stdout), expected);
            for (mode, ordinary, measured) in &binaries {
                for (binary, repetition) in
                    [(ordinary, 0), (measured, 1), (measured, 2), (measured, 3)]
                {
                    let out = run(&mut Command::new(binary));
                    let prefix = format!("{mode}-tls-{tls}-{calls}-{repetition}");
                    std::fs::write(artifacts.join(format!("{prefix}.stdout")), &out.stdout)
                        .unwrap();
                    std::fs::write(artifacts.join(format!("{prefix}.stderr")), &out.stderr)
                        .unwrap();
                    assert!(out.status.success(), "{prefix}: {out:?}");
                    assert_eq!(String::from_utf8_lossy(&out.stdout), expected, "{prefix}");
                    let stderr = String::from_utf8(out.stderr).unwrap();
                    if repetition == 0 {
                        assert!(stderr.is_empty(), "{prefix}: {stderr}");
                    } else {
                        let fields = stderr.trim().strip_prefix("client-memory\t").unwrap();
                        let values: Vec<u64> =
                            fields.split('\t').map(|v| v.parse().unwrap()).collect();
                        assert_eq!(values.len(), 6);
                        assert!(values[0] > 0 && values[1] > 0);
                        assert_eq!(values[5], 0, "collections must be disabled");
                        rows.push_str(&format!("{mode}\t{tls}\t{calls}\t{repetition}\t{fields}\n"));
                        std::fs::write(artifacts.join("memory.tsv"), &rows).unwrap();
                        let first = final_storage.entry((*mode, tls)).or_insert(values[4]);
                        assert_eq!(
                            values[4], *first,
                            "{prefix}: completed calls must not accumulate managed storage"
                        );
                    }
                }
            }
        }
    }
    println!("{rows}");
}

/// Count server allocations through graceful shutdown, then sample live process
/// memory over repeated connections. Both memory modes run with collection off.
#[test]
#[ignore = "runner-only HTTP server managed-memory and process-memory measurement"]
#[cfg(any(target_os = "linux", target_os = "macos", windows))]
fn repeated_http_server_memory_measurement() {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let artifacts = PathBuf::from(
        std::env::var_os("FWP_HTTP_SERVER_MEMORY_ARTIFACTS")
            .expect("server measurement artifact directory"),
    );
    std::fs::create_dir_all(&artifacts).unwrap();
    let ca = certs()
        .expect("server measurement requires OpenSSL")
        .join("ca.pem");
    for source in ["server.fwp", "repeated-client.fwp"] {
        std::fs::copy(
            root().join("tests/web").join(source),
            artifacts.join(source),
        )
        .unwrap();
    }
    std::fs::write(artifacts.join("scope.txt"), "Current fwp tracing and checked ARC servers handle identical sequential HTTP/2 GET /hello requests from an ordinary native ARC client over loopback. Each body is received and released; status 200 is summed. Inputs 1, 16 and 256 calls, cleartext and TLS, three fresh measured server processes per case; an ordinary server is the output control. Every server then handles one HTTP/1.1 /stop request, drains children and exits. Managed counters begin after constant initialization and end after entry execution and cached-value cleanup, before complete runtime shutdown; they include server startup, the requested calls and the fixed shutdown request. Collection is disabled and freeing enabled in both modes. Counters exclude raw transport/TLS buffers, allocator metadata/pages and client memory. Separately, ordinary uninstrumented servers receive five batches of 4096 calls each; each batch starts a fresh client process, and the server's 1000-request connection limit exercises connection replacement within each batch. Current server resident memory is sampled after each client exits and a 100 ms settling interval; the first batch warms caches and the next four must remain within 8 MiB of that first sample. Linux uses /proc VmRSS, macOS ps RSS and Windows process WorkingSet64; these are resident-memory samples, not allocated/live-value counts. Native -O2 with normal compiler optimization and -ffp-contract=off. This compares memory modes at one revision; it makes no speed or C/Rust parity claim. Source, generated C, ordinary/instrumented binaries, raw counter rows, RSS samples and stderr are retained. Separate counters record entries into the generic ownership check through cached-value cleanup. Instrumentation can prevent check elimination/inlining, so these are instrumented executions, not ordinary machine-call counts. The counted client runs against a control server; its work is excluded from measured-server allocation rows.\n").unwrap();
    let emit = |name: &str, mode: &str, file: &str| {
        eprintln!("server memory: emitting {name}");
        let cfile = artifacts.join(format!("{name}.c"));
        let out = Command::new(fwp())
            .args(["build", "--gc", mode, "--emit-c", "-o"])
            .arg(&cfile)
            .arg(root().join("tests/web").join(file))
            .output()
            .unwrap();
        assert!(out.status.success(), "{name}: {out:?}");
        std::fs::read_to_string(cfile).unwrap()
    };
    let client = artifacts.join("client.exe");
    let client_code = emit("client", "arc", "repeated-client.fwp");
    fwp::cgen::compile_c(&client_code, &client, "-O2").unwrap();
    let client_counted_code = entry_checks::instrument(&client_code, entry_checks::SIGNATURE);
    let client_counted = artifacts.join("client-counted.exe");
    std::fs::write(artifacts.join("client-counted.c"), &client_counted_code).unwrap();
    fwp::cgen::compile_c(&client_counted_code, &client_counted, "-O2").unwrap();
    let run_client = |base: &str, calls: usize| {
        let out = Command::new(&client)
            .arg(calls.to_string())
            .env("FWP_BASE", base)
            .env("SSL_CERT_FILE", &ca)
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert!(out.status.success(), "{base}/{calls}: {out:?}");
        assert_eq!(
            String::from_utf8_lossy(&out.stdout),
            format!("{}\n", calls * 200)
        );
        out.stdout
    };
    let mut rows = String::from("mode\ttls\tcalls\trepetition\trequests\trequested_bytes\tretains\tpeak_charged_bytes\tfinal_charged_bytes\tcollections\n");
    let mut rss_rows = String::from("mode\ttls\tbatch\tcumulative_calls\trss_kib\n");
    let mut entry_rows =
        String::from("role\tserver_mode\ttls\tcalls\trepetition\tentry_check_calls\n");
    for mode in ["tracing", "arc"] {
        eprintln!("server memory: building {mode} ordinary and measured servers");
        let code = emit(&format!("server-{mode}"), mode, "server.fwp");
        let ordinary = artifacts.join(format!("server-{mode}.exe"));
        fwp::cgen::compile_c(&code, &ordinary, "-O2").unwrap();
        let measured = artifacts.join(format!("server-{mode}-measured.exe"));
        let instrumented = entry_checks::instrument(
            &client_allocations::instrument_client_allocations(&code),
            entry_checks::SIGNATURE,
        )
        .replace("client-memory\\t", "server-memory\\t");
        std::fs::write(
            artifacts.join(format!("server-{mode}-measured.c")),
            &instrumented,
        )
        .unwrap();
        fwp::cgen::compile_c(&instrumented, &measured, "-O2").unwrap();
        for tls in [false, true] {
            let launch = |binary: &Path| {
                start_command(
                    Command::new(binary),
                    tls,
                    &[
                        ("FWP_GC", "off"),
                        ("FWP_FREE", "1"),
                        ("FWP_GC_STRESS", "0"),
                        ("FWP_GC_VERIFY", "0"),
                        ("FWP_GC_STATS", "0"),
                        ("FWP_REUSE_VERIFY", "0"),
                    ],
                )
                .unwrap()
            };
            let address = |server: &Server| {
                format!("{}://{}", if tls { "https" } else { "http" }, server.addr)
            };
            let mut final_charge = None;
            for calls in [1, 16, 256] {
                let mut control = launch(&ordinary);
                let base = address(&control);
                let expected = run_client(&base, calls);
                let counted = Command::new(&client_counted)
                    .arg(calls.to_string())
                    .env("FWP_BASE", &base)
                    .env("SSL_CERT_FILE", &ca)
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert!(counted.status.success(), "{counted:?}");
                assert_eq!(counted.stdout, expected);
                let count_stderr = String::from_utf8(counted.stderr).unwrap();
                std::fs::write(
                    artifacts.join(format!("client-{mode}-tls-{tls}-{calls}.stderr")),
                    &count_stderr,
                )
                .unwrap();
                entry_rows.push_str(&format!(
                    "client\t{mode}\t{tls}\t{calls}\t0\t{}\n",
                    entry_checks::count(&count_stderr)
                ));
                std::fs::write(artifacts.join("entry-checks.tsv"), &entry_rows).unwrap();
                stop_server(&mut control, &base, &ca);
                for repetition in 0..3 {
                    eprintln!(
                        "server memory: {mode}, TLS={tls}, {calls} calls, repetition {repetition}"
                    );
                    let mut server = launch(&measured);
                    let base = address(&server);
                    assert_eq!(run_client(&base, calls), expected);
                    let stderr = stop_server(&mut server, &base, &ca);
                    entry_rows.push_str(&format!(
                        "server\t{mode}\t{tls}\t{calls}\t{repetition}\t{}\n",
                        entry_checks::count(&stderr)
                    ));
                    std::fs::write(artifacts.join("entry-checks.tsv"), &entry_rows).unwrap();
                    std::fs::write(
                        artifacts.join(format!("{mode}-tls-{tls}-{calls}-{repetition}.stderr")),
                        &stderr,
                    )
                    .unwrap();
                    let counter = stderr
                        .lines()
                        .find_map(|line| line.strip_prefix("server-memory\t"))
                        .expect("server counters");
                    let counts: Vec<i64> = counter
                        .split('\t')
                        .map(|value| value.parse().unwrap())
                        .collect();
                    assert_eq!(counts.len(), 6, "{stderr}");
                    rows.push_str(&format!(
                        "{mode}\t{tls}\t{calls}\t{repetition}\t{counter}\n"
                    ));
                    std::fs::write(artifacts.join("server-memory.tsv"), &rows).unwrap();
                    assert_eq!(counts[5], 0, "unexpected collection: {stderr}");
                    if let Some(before) = final_charge {
                        assert_eq!(counts[4], before, "server final managed storage changed with request count: {mode}/{tls}/{calls}");
                    } else {
                        final_charge = Some(counts[4]);
                    }
                }
            }
            let mut server = launch(&ordinary);
            let base = address(&server);
            let mut samples = Vec::new();
            for batch in 0..5 {
                eprintln!("server RSS: {mode}, TLS={tls}, batch {batch}, 4096 calls");
                run_client(&base, 4096);
                std::thread::sleep(Duration::from_millis(100));
                let rss = process_rss_kib(server.child.id());
                samples.push(rss);
                eprintln!("server RSS: {mode}, TLS={tls}, batch {batch}: {rss} KiB");
                rss_rows.push_str(&format!(
                    "{mode}\t{tls}\t{batch}\t{}\t{rss}\n",
                    (batch + 1) * 4096
                ));
                std::fs::write(artifacts.join("server-rss.tsv"), &rss_rows).unwrap();
            }
            let stderr = stop_server(&mut server, &base, &ca);
            std::fs::write(
                artifacts.join(format!("{mode}-tls-{tls}-long-running.stderr")),
                stderr,
            )
            .unwrap();
            assert!(
                samples[1..].iter().all(|&rss| rss < samples[0] + 8 * 1024),
                "{mode}/{tls}: server RSS KiB after each 4096-call batch: {samples:?}"
            );
        }
    }
}

#[test]
fn native_under_gc_stress() {
    if natives().is_none() {
        return;
    }
    let stress = [("FWP_GC_STRESS", "16")];
    let srv = start(Backend::Native, false, &stress).unwrap();
    run_client(Backend::Native, &srv, false, &stress);
    if certs().is_some() {
        let srv = start(Backend::Native, true, &stress).unwrap();
        run_client(Backend::Native, &srv, true, &stress);
    }
}

// ------------------------------------------------------- raw WebSocket

struct Ws {
    s: TcpStream,
    r: BufReader<TcpStream>,
}

fn ws_open(addr: &str) -> Ws {
    ws_open_with(addr, "").0
}

/// A session whose request has `headers` (lines ending in CRLF) too, and
/// the response head.
fn ws_open_with(addr: &str, headers: &str) -> (Ws, String) {
    let mut s = TcpStream::connect(addr).unwrap();
    s.set_read_timeout(Some(Duration::from_secs(20))).unwrap();
    let key = "dGhlIHNhbXBsZSBub25jZQ==";
    write!(
        s,
        "GET /ws HTTP/1.1\r\nhost: {}\r\nupgrade: websocket\r\nconnection: keep-alive, Upgrade\r\nsec-websocket-key: {}\r\nsec-websocket-version: 13\r\n{}\r\n",
        addr, key, headers
    )
    .unwrap();
    let mut r = BufReader::new(s.try_clone().unwrap());
    let mut head = String::new();
    loop {
        let mut l = String::new();
        r.read_line(&mut l).unwrap();
        if l == "\r\n" || l.is_empty() {
            break;
        }
        head.push_str(&l);
    }
    let lower = head.to_ascii_lowercase();
    assert!(head.starts_with("HTTP/1.1 101 "), "{}", head);
    assert!(lower.contains("upgrade: websocket"), "{}", head);
    // RFC 6455, section 1.3
    assert!(
        head.contains("s3pPLMBiTxaQ9kYGzzhZRbK+xOo="),
        "accept key: {}",
        head
    );
    (Ws { s, r }, lower)
}

/// A client frame: masked unless `unmasked`.
fn frame(fin: bool, op: u8, payload: &[u8], unmasked: bool) -> Vec<u8> {
    let mut f = vec![if fin { 0x80 } else { 0 } | op];
    let m = if unmasked { 0 } else { 0x80 };
    let n = payload.len();
    if n < 126 {
        f.push(m | n as u8);
    } else if n < 65536 {
        f.push(m | 126);
        f.extend_from_slice(&(n as u16).to_be_bytes());
    } else {
        f.push(m | 127);
        f.extend_from_slice(&(n as u64).to_be_bytes());
    }
    if unmasked {
        f.extend_from_slice(payload);
    } else {
        let key = [0x12, 0x34, 0x56, 0x78];
        f.extend_from_slice(&key);
        f.extend(payload.iter().enumerate().map(|(i, b)| b ^ key[i % 4]));
    }
    f
}

impl Ws {
    fn send(&mut self, f: &[u8]) {
        self.s.write_all(f).unwrap();
    }

    /// The next frame from the server: (FIN, opcode, payload); servers do
    /// not mask.
    fn recv(&mut self) -> (bool, u8, Vec<u8>) {
        let (b0, p) = self.recv_raw();
        (b0 & 0x80 != 0, b0 & 0x0f, p)
    }

    /// The next frame: its first byte and its payload.
    fn recv_raw(&mut self) -> (u8, Vec<u8>) {
        let mut h = [0u8; 2];
        self.r.read_exact(&mut h).unwrap();
        assert_eq!(h[1] & 0x80, 0, "a server frame is not masked");
        let mut n = (h[1] & 0x7f) as usize;
        if n == 126 {
            let mut b = [0u8; 2];
            self.r.read_exact(&mut b).unwrap();
            n = u16::from_be_bytes(b) as usize;
        } else if n == 127 {
            let mut b = [0u8; 8];
            self.r.read_exact(&mut b).unwrap();
            n = u64::from_be_bytes(b) as usize;
        }
        let mut p = vec![0u8; n];
        self.r.read_exact(&mut p).unwrap();
        (h[0], p)
    }

    fn close_code(&mut self) -> u16 {
        let (_, op, p) = self.recv();
        assert_eq!(op, 8, "expected a close frame");
        u16::from_be_bytes([p[0], p[1]])
    }

    /// The server closes the connection after the closing handshake.
    fn closed(&mut self) {
        let mut b = [0u8; 1];
        assert_eq!(self.r.read(&mut b).unwrap_or(0), 0);
    }
}

fn raw_websocket(b: Backend) {
    let Some(srv) = start(b, false, &[]) else {
        return;
    };
    // messages, fragmentation, ping
    let mut ws = ws_open(&srv.addr);
    ws.send(&frame(true, 1, b"hello", false));
    assert_eq!(ws.recv(), (true, 1, b"hello".to_vec()));
    ws.send(&frame(false, 1, b"frag", false));
    ws.send(&frame(true, 9, b"between fragments", false));
    assert_eq!(ws.recv(), (true, 10, b"between fragments".to_vec()));
    ws.send(&frame(false, 0, b"men", false));
    ws.send(&frame(true, 0, b"ted", false));
    assert_eq!(ws.recv(), (true, 1, b"fragmented".to_vec()));
    let big: Vec<u8> = (0..70000).map(|i| (i % 251) as u8).collect();
    ws.send(&frame(true, 2, &big, false));
    assert_eq!(ws.recv(), (true, 2, big));
    // the closing handshake, started by the client
    let mut close = 1000u16.to_be_bytes().to_vec();
    close.extend_from_slice(b"done");
    ws.send(&frame(true, 8, &close, false));
    assert_eq!(ws.close_code(), 1000);
    ws.closed();

    // started by the server, with its code and reason
    let mut ws = ws_open(&srv.addr);
    ws.send(&frame(true, 1, b"close", false));
    let (_, op, p) = ws.recv();
    assert_eq!(
        (op, &p[..2], &p[2..]),
        (8, &4000u16.to_be_bytes()[..], &b"asked to"[..])
    );
    ws.send(&frame(true, 8, &4000u16.to_be_bytes(), false));
    ws.closed();

    // a message over the limit: 1009
    let mut ws = ws_open(&srv.addr);
    ws.send(&frame(true, 2, &vec![7u8; 100001], false));
    assert_eq!(ws.close_code(), 1009);
    // fragments over the limit together
    let mut ws = ws_open(&srv.addr);
    ws.send(&frame(false, 2, &vec![7u8; 60000], false));
    ws.send(&frame(true, 0, &vec![7u8; 60000], false));
    assert_eq!(ws.close_code(), 1009);
    // an unmasked client frame: 1002
    let mut ws = ws_open(&srv.addr);
    ws.send(&frame(true, 1, b"plain", true));
    assert_eq!(ws.close_code(), 1002);
    // text that is not UTF-8: 1007
    let mut ws = ws_open(&srv.addr);
    ws.send(&frame(true, 1, &[0xff, 0xfe], false));
    assert_eq!(ws.close_code(), 1007);
    // a continuation without a start: 1002
    let mut ws = ws_open(&srv.addr);
    ws.send(&frame(true, 0, b"x", false));
    assert_eq!(ws.close_code(), 1002);

    // permessage-deflate: the server agrees, each message on its own
    let offer = "sec-websocket-extensions: permessage-deflate; client_max_window_bits\r\n";
    let (mut ws, head) = ws_open_with(&srv.addr, offer);
    assert!(
        head.contains("sec-websocket-extensions: permessage-deflate; server_no_context_takeover; client_no_context_takeover"),
        "{}",
        head
    );
    // a compressed message (RSV1): a stored block, then the empty stored
    // block of a flush without its 00 00 ff ff
    let text = b"compressed ".repeat(20);
    let mut z = vec![0, text.len() as u8, 0, !(text.len() as u8), 0xff];
    z.extend_from_slice(&text);
    z.push(0);
    ws.send(&frame(true, 0x40 | 1, &z, false));
    // the echo comes back compressed, as it has more than 64 bytes
    let (b0, p) = ws.recv_raw();
    assert_eq!(b0, 0x80 | 0x40 | 1, "a compressed text frame: {:?}", p);
    assert!(p.len() < text.len() / 2, "{} bytes", p.len());
    // a short one is sent as it is
    ws.send(&frame(true, 1, b"short", false));
    assert_eq!(ws.recv(), (true, 1, b"short".to_vec()));
    // a compressed continuation: 1002
    ws.send(&frame(false, 0x40 | 1, &z, false));
    ws.send(&frame(true, 0x40, &z, false));
    assert_eq!(ws.close_code(), 1002);
    // data that does not inflate: 1007
    let (mut ws, _) = ws_open_with(&srv.addr, offer);
    ws.send(&frame(true, 0x40 | 2, &[0xff, 0xff, 0xff], false));
    assert_eq!(ws.close_code(), 1007);
    // an offer the server cannot honour, and RSV1 without an agreement
    let (mut ws, head) = ws_open_with(
        &srv.addr,
        "sec-websocket-extensions: permessage-deflate; server_max_window_bits=10\r\n",
    );
    assert!(!head.contains("sec-websocket-extensions"), "{}", head);
    ws.send(&frame(true, 0x40 | 1, &z, false));
    assert_eq!(ws.close_code(), 1002);

    // not an upgrade request
    if have(&curl_program(), "--version") {
        let u = format!("http://{}/ws", srv.addr);
        assert_eq!(
            curl(&["-w", "|%{http_code}", &u]),
            "expected a WebSocket upgrade request|400"
        );
        assert_eq!(
            curl(&[
                "-H",
                "upgrade: websocket",
                "-H",
                "connection: upgrade",
                "-H",
                "sec-websocket-key: x",
                "-H",
                "sec-websocket-version: 8",
                "-w",
                "|%{http_code}",
                &u
            ]),
            "unsupported WebSocket version|426"
        );
    }
}

#[test]
fn websocket_raw_interpreted() {
    raw_websocket(Backend::Interp);
}

#[test]
fn websocket_raw_native() {
    if natives().is_some() {
        raw_websocket(Backend::Native);
    }
}

#[test]
fn websocket_node_client() {
    // node 22 and later have a WebSocket client
    let Ok(out) = Command::new("node")
        .args([
            "-e",
            "process.exit(typeof WebSocket === 'function' ? 0 : 1)",
        ])
        .output()
    else {
        return;
    };
    if !out.status.success() {
        eprintln!("skipping: node without WebSocket");
        return;
    }
    let script = r#"
const ws = new WebSocket(process.argv[1]);
ws.binaryType = 'arraybuffer';
const out = [];
ws.onopen = () => {
  out.push('ext:' + ws.extensions);
  ws.send('hi'); ws.send(new Uint8Array([1, 2, 3])); ws.send('x'.repeat(70000)); ws.send('close');
};
ws.onmessage = (e) => out.push(typeof e.data === 'string'
  ? 'text:' + (e.data.length > 20 ? e.data.length : e.data)
  : 'bin:' + new Uint8Array(e.data).join(','));
ws.onclose = (e) => console.log(out.join(' '), 'close', e.code, e.reason, e.wasClean);
"#;
    for b in backends() {
        let srv = start(b, false, &[]).unwrap();
        let out = Command::new("node")
            .args(["-e", script, &format!("ws://{}/ws", srv.addr)])
            .output()
            .unwrap();
        assert_eq!(
            String::from_utf8_lossy(&out.stdout).trim(),
            "ext:permessage-deflate; server_no_context_takeover; client_no_context_takeover text:hi bin:1,2,3 text:70000 close 4000 asked to true",
            "{:?}: {}",
            b,
            String::from_utf8_lossy(&out.stderr)
        );
    }
}

#[test]
fn chat_example() {
    let mut child = Command::new(fwp())
        .args(["run", "--interp"])
        .arg(root().join("examples/server/chat.fwp"))
        .env("FWP_ADDR", "127.0.0.1:0")
        .stdout(Stdio::null())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let mut stderr = BufReader::new(child.stderr.take().unwrap());
    let mut line = String::new();
    stderr.read_line(&mut line).unwrap();
    let addr = line
        .trim()
        .strip_prefix("chat on http://")
        .unwrap_or_else(|| panic!("unexpected first line: {:?}", line))
        .to_string();
    // a client has joined once its own message comes back through the hub
    let mut a = ws_open(&addr);
    a.send(&frame(true, 1, b"a is here", false));
    assert_eq!(a.recv(), (true, 1, b"a is here".to_vec()));
    let mut b = ws_open(&addr);
    b.send(&frame(true, 1, b"b is here", false));
    assert_eq!(b.recv(), (true, 1, b"b is here".to_vec()));
    let first = a.recv();
    assert_eq!(first, (true, 1, b"b is here".to_vec()));
    a.send(&frame(true, 1, b"hello b", false));
    assert_eq!(b.recv(), (true, 1, b"hello b".to_vec()));
    assert_eq!(a.recv(), (true, 1, b"hello b".to_vec()));
    let _ = child.kill();
    let _ = child.wait();
}
