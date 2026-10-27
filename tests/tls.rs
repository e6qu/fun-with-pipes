//! TLS (docs/tls.md) on both backends: TLS connections (`tests/tls/streams.fwp`:
//! verification and its failures, ALPN, plain peers, a stalled handshake),
//! HTTPS servers queried by curl and by fwp clients, an fwp client of
//! `openssl s_server`, REST over HTTPS with a generated OpenAPI client, and
//! gRPC over TLS between fwp clients and servers (and grpcurl, when
//! installed).
//!
//! A throwaway CA and a certificate for localhost and 127.0.0.1 are made
//! at test time with the `openssl` command; without it the tests are
//! skipped. Clients trust the CA through `SSL_CERT_FILE` or `ca-file`.
//! `FWP_BLESS=1` rewrites `tests/tls/streams.out`.

use std::io::{Read, Write};
use std::net::TcpStream;
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::sync::OnceLock;
use std::thread::JoinHandle;
use std::time::{Duration, Instant};

#[path = "support/http_server_process.rs"]
mod http_server_process;

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
        .is_ok()
}

fn have_cc() -> bool {
    have(
        &std::env::var("CC").unwrap_or_else(|_| "cc".into()),
        "--version",
    )
}

fn bless() -> bool {
    std::env::var("FWP_BLESS").is_ok_and(|v| v == "1")
}

fn scratch(name: &str) -> PathBuf {
    let d = std::env::temp_dir().join(format!("fwp-tls-{}-{}", std::process::id(), name));
    let _ = std::fs::remove_dir_all(&d);
    std::fs::create_dir_all(&d).unwrap();
    d
}

fn openssl(args: &[&str], dir: &Path) -> bool {
    Command::new("openssl")
        .args(args)
        .current_dir(dir)
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .status()
        .is_ok_and(|s| s.success())
}

/// A directory with ca.pem (a CA), server.pem and server.key (a
/// certificate for localhost and 127.0.0.1 that it signed), other.key
/// (an unrelated key), client.pem and client.key (a client certificate
/// that the CA signed; both.pem has both), and rogue.pem and rogue.key (a
/// self-signed client certificate); `None`, and the tests skip, without
/// `openssl`.
fn certs() -> Option<&'static Path> {
    static DIR: OnceLock<Option<PathBuf>> = OnceLock::new();
    DIR.get_or_init(|| {
        if !have("openssl", "version") {
            assert!(std::env::var_os("FWP_REQUIRE_TLS").is_none(), "required OpenSSL CLI is missing");
            eprintln!("skipping: no openssl command");
            return None;
        }
        let d = scratch("certs");
        let ok = openssl(
            &[
                "req", "-x509", "-newkey", "rsa:2048", "-nodes", "-keyout", "ca.key", "-out",
                "ca.pem", "-days", "2", "-subj", "/CN=fwp test CA", "-addext",
                "basicConstraints=critical,CA:TRUE", "-addext", "keyUsage=critical,keyCertSign",
            ],
            &d,
        ) && openssl(
            &[
                "req", "-newkey", "rsa:2048", "-nodes", "-keyout", "server.key", "-out",
                "server.csr", "-subj", "/CN=localhost",
            ],
            &d,
        ) && {
            std::fs::write(
                d.join("ext.cnf"),
                "subjectAltName=DNS:localhost,IP:127.0.0.1\nbasicConstraints=CA:FALSE\nextendedKeyUsage=serverAuth\n",
            )
            .unwrap();
            openssl(
                &[
                    "x509", "-req", "-in", "server.csr", "-CA", "ca.pem", "-CAkey", "ca.key",
                    "-CAcreateserial", "-out", "server.pem", "-days", "2", "-extfile", "ext.cnf",
                ],
                &d,
            )
        } && openssl(&["genrsa", "-out", "other.key", "2048"], &d)
            && openssl(
                &[
                    "req", "-newkey", "rsa:2048", "-nodes", "-keyout", "client.key", "-out",
                    "client.csr", "-subj", "/O=fwp/CN=fwp client",
                ],
                &d,
            )
            && {
                std::fs::write(
                    d.join("client.cnf"),
                    "basicConstraints=CA:FALSE\nextendedKeyUsage=clientAuth\n",
                )
                .unwrap();
                openssl(
                    &[
                        "x509", "-req", "-in", "client.csr", "-CA", "ca.pem", "-CAkey", "ca.key",
                        "-CAcreateserial", "-out", "client.pem", "-days", "2", "-extfile",
                        "client.cnf",
                    ],
                    &d,
                )
            }
            && openssl(
                &[
                    "req", "-x509", "-newkey", "rsa:2048", "-nodes", "-keyout", "rogue.key",
                    "-out", "rogue.pem", "-days", "2", "-subj", "/CN=rogue",
                ],
                &d,
            )
            && {
                let both = std::fs::read_to_string(d.join("client.pem")).unwrap()
                    + &std::fs::read_to_string(d.join("client.key")).unwrap();
                std::fs::write(d.join("both.pem"), both).is_ok()
            };
        if !ok {
            assert!(std::env::var_os("FWP_REQUIRE_TLS").is_none(), "required TLS certificates could not be generated");
            eprintln!("skipping: openssl could not make the test certificates");
            return None;
        }
        Some(d)
    })
    .as_deref()
}

/// Run a command to completion, killing it after `secs` seconds.
fn run(mut cmd: Command, secs: u64) -> std::process::Output {
    cmd.stdout(Stdio::piped()).stderr(Stdio::piped());
    let mut child = cmd.spawn().expect("start command");
    let mut out = child.stdout.take().unwrap();
    let mut err = child.stderr.take().unwrap();
    let o = std::thread::spawn(move || {
        let mut b = Vec::new();
        let _ = out.read_to_end(&mut b);
        b
    });
    let e = std::thread::spawn(move || {
        let mut b = Vec::new();
        let _ = err.read_to_end(&mut b);
        b
    });
    let start = Instant::now();
    let status = loop {
        if let Some(s) = child.try_wait().unwrap() {
            break s;
        }
        if start.elapsed() > Duration::from_secs(secs) {
            let _ = child.kill();
            break child.wait().unwrap();
        }
        std::thread::sleep(Duration::from_millis(20));
    };
    std::process::Output {
        status,
        stdout: o.join().unwrap(),
        stderr: e.join().unwrap(),
    }
}

fn text(o: &std::process::Output) -> String {
    // OpenSSL 3 releases name the same TLS alert differently. Keep the
    // complete failure checked while canonicalizing its version label.
    String::from_utf8_lossy(&o.stdout).replace(
        "ssl/tls alert bad certificate",
        "sslv3 alert bad certificate",
    )
}

fn build(args: &[&str], cwd: &Path) {
    let mut cmd = Command::new(fwp());
    cmd.arg("build").args(args).arg("-O1").current_dir(cwd);
    let o = run(cmd, 300);
    assert!(
        o.status.success(),
        "fwp build {:?}: {}",
        args,
        String::from_utf8_lossy(&o.stderr)
    );
}

/// A running server; killed when dropped.
struct Server {
    child: Child,
    /// What follows "listening on " in its first line of standard error.
    addr: String,
    stderr: Option<JoinHandle<()>>,
}

impl Drop for Server {
    fn drop(&mut self) {
        let _ = self.child.kill();
        let _ = self.child.wait();
        if let Some(reader) = self.stderr.take() {
            reader.join().expect("TLS server stderr reader");
        }
    }
}

impl Server {
    /// The port it listens on.
    fn port(&self) -> &str {
        self.addr.rsplit(':').next().unwrap()
    }
}

/// Enforce the startup deadline even for a silent or partial announcement.
fn start(mut cmd: Command, prefix: &str) -> Server {
    let description = format!("{cmd:?}");
    let (child, addr, mut stderr) =
        http_server_process::start(&mut cmd, prefix, Duration::from_secs(60), Stdio::null())
            .unwrap_or_else(|error| panic!("{description}: {error}"));
    let reader = std::thread::spawn(move || {
        let _ = std::io::copy(&mut stderr, &mut std::io::sink());
    });
    Server {
        child,
        addr,
        stderr: Some(reader),
    }
}

fn curl_command() -> String {
    std::env::var("FWP_TEST_CURL").unwrap_or_else(|_| "curl".into())
}

fn have_curl() -> bool {
    let available = have(&curl_command(), "--version");
    assert!(
        available || std::env::var_os("FWP_REQUIRE_TLS").is_none(),
        "required TLS peer curl unavailable"
    );
    available
}

fn curl(args: &[&str]) -> (i32, String) {
    let o = Command::new(curl_command())
        .args(["-sS", "-m", "20", "-w", " [%{http_code}]"])
        .args(args)
        .output()
        .expect("run curl");
    if !o.status.success() {
        eprintln!("curl peer: {}", String::from_utf8_lossy(&o.stderr));
    }
    (
        o.status.code().unwrap_or(-1),
        String::from_utf8_lossy(&o.stdout).into_owned(),
    )
}

/// The interpreted and (with a C compiler) native commands that run a
/// program: `fwp run file` and the executable `fwp build` makes of it.
fn both_ways(file: &Path, d: &Path, name: &str) -> Vec<Command> {
    let mut v = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["run", "--interp"]).arg(file);
    v.push(cmd);
    if have_cc() {
        let exe = d.join(name);
        build(
            &[file.to_str().unwrap(), "-o", exe.to_str().unwrap()],
            &root(),
        );
        v.push(Command::new(exe));
    }
    v
}

// ------------------------------------------------------------ connections

fn stream_snapshot(text: &str) -> String {
    let mut result = text.replace(
        "TLS handshake failed: ssl/tls alert bad certificate",
        "TLS handshake failed: sslv3 alert bad certificate",
    );
    if cfg!(windows) {
        // Windows may reset the TCP connection before its peer reads the TLS
        // rejection alert. Preserve the client's exact certificate diagnostic
        // and the failed handshake on the peer, without requiring alert delivery.
        for detail in [
            "tlsv1 alert unknown ca",
            "sslv3 alert bad certificate",
            "wrong version number",
            "Connection reset by peer",
            "Software caused connection abort",
            "connection closed",
        ] {
            result = result.replace(
                &format!("TLS handshake failed: {detail}"),
                "TLS handshake failed: peer rejected connection",
            );
        }
    }
    result
}

/// TLS connections in one program, interpreted and native: the same
/// output, which `tests/tls/streams.out` holds.
#[test]
fn streams() {
    let Some(certs) = certs() else { return };
    let d = scratch("streams");
    let file = root().join("tests/tls/streams.fwp");
    let expected = root().join("tests/tls/streams.out");
    let mut reference = None;
    for (i, mut cmd) in both_ways(&file, &d, "streams").into_iter().enumerate() {
        cmd.current_dir(certs);
        let o = run(cmd, 120);
        let raw = text(&o);
        let got = stream_snapshot(&raw);
        if let Some(expected) = &reference {
            assert_eq!(&got, expected, "native and interpreter TLS output differs");
        } else {
            reference = Some(got.clone());
        }
        assert!(
            o.status.success(),
            "{}{}",
            got,
            String::from_utf8_lossy(&o.stderr)
        );
        if bless() && i == 0 {
            std::fs::write(&expected, &raw).unwrap();
        }
        let want = std::fs::read_to_string(&expected).unwrap_or_default();
        assert_eq!(
            got,
            stream_snapshot(&want),
            "{} differs",
            if i == 0 { "interpreted" } else { "native" }
        );
    }
}

/// Mutual TLS in one program, interpreted and native: a server that
/// requires client certificates and clients with and without one
/// (`tests/tls/mutual.out`).
#[test]
fn mutual_tls() {
    let Some(certs) = certs() else { return };
    let d = scratch("mutual");
    let file = root().join("tests/tls/mutual.fwp");
    let expected = root().join("tests/tls/mutual.out");
    let mut commands = both_ways(&file, &d, "mutual");
    if have_cc() {
        let binary = d.join("mutual-arc.exe");
        build(
            &[file.to_str().unwrap(), "-o", binary.to_str().unwrap()],
            &root(),
        );
        let symbols = Command::new("nm").arg(&binary).output().unwrap();
        assert!(symbols.status.success(), "{symbols:?}");
        let symbols = String::from_utf8_lossy(&symbols.stdout);
        for name in ["fwp_heap_scan", "fwp_heap_mark_all", "fwp_heap_sweep"] {
            assert!(!symbols.contains(name), "ARC TLS binary contains {name}");
        }
        if let Some(path) = std::env::var_os("FWP_TCP_CONSTRUCTOR_ARTIFACTS") {
            let path = PathBuf::from(path);
            std::fs::create_dir_all(&path).unwrap();
            std::fs::copy(&binary, path.join("mutual-tls-arc.exe")).unwrap();
            std::fs::write(path.join("mutual-tls-arc.nm"), symbols.as_bytes()).unwrap();
        }
        commands.push(Command::new(binary));
    }
    for (i, mut cmd) in commands.into_iter().enumerate() {
        cmd.current_dir(certs);
        let o = run(cmd, 120);
        // TLS 1.3 clients can finish their handshake before receiving the
        // server's certificate rejection. Both handshake and subsequent read
        // failure are valid here; require the server rejection and all success
        // cases exactly, without imposing socket-delivery timing on the test.
        let got = text(&o)
            .replace(
                "without a certificate\nclient: read error\n",
                "without a certificate\nclient: tls error\n",
            )
            .replace(
                "with a certificate of another CA\nclient: read error\n",
                "with a certificate of another CA\nclient: tls error\n",
            );
        assert!(
            o.status.success(),
            "{}{}",
            got,
            String::from_utf8_lossy(&o.stderr)
        );
        if bless() && i == 0 {
            std::fs::write(&expected, &got).unwrap();
        }
        let want = std::fs::read_to_string(&expected).unwrap_or_default();
        assert_eq!(
            got,
            want,
            "{} differs",
            if i == 0 { "interpreted" } else { "native" }
        );
    }
}

/// A program without TLS does not depend on OpenSSL; one with it does.
#[test]
fn linking() {
    if !have_cc() || !have("ldd", "--version") {
        return;
    }
    let d = scratch("linking");
    std::fs::write(d.join("plain.fwp"), "main = \"hi\" | print\n").unwrap();
    std::fs::write(
        d.join("secure.fwp"),
        "main = [\n    tls.available () | format \"tls: {}\" | print,\n    \"localhost:1\" | attempt tls.connect | match { Ok -> const (), Err -> .kind | print },\n] | ignore\n",
    )
    .unwrap();
    for (name, ssl) in [("plain", false), ("secure", true)] {
        build(&[&format!("{}.fwp", name), "-o", name], &d);
        let o = Command::new("ldd").arg(d.join(name)).output().unwrap();
        assert_eq!(
            String::from_utf8_lossy(&o.stdout).contains("libssl"),
            ssl,
            "{}",
            name
        );
    }
    let o = Command::new(d.join("secure")).output().unwrap();
    assert_eq!(text(&o), "tls: True\nconnect\n");
    let o = Command::new(fwp())
        .args(["run", "--interp"])
        .arg(d.join("secure.fwp"))
        .output()
        .unwrap();
    assert_eq!(text(&o), "tls: True\nconnect\n");
}

/// WebAssembly targets have no sockets: TLS is rejected like TCP.
#[test]
fn rejected_for_webassembly() {
    let d = scratch("wasm");
    std::fs::write(
        d.join("w.fwp"),
        "main = tls.connect \"example.com:443\" | tcp.close\n",
    )
    .unwrap();
    let o = Command::new(fwp())
        .args(["build", "--target", "wasm32-wasi", "--emit-c", "w.fwp"])
        .current_dir(&d)
        .output()
        .unwrap();
    assert!(!o.status.success());
    let err = String::from_utf8_lossy(&o.stderr);
    assert!(err.contains("`Network` effect"), "{}", err);
}

// ------------------------------------------------------------ HTTPS

/// examples/server/api.fwp serving HTTPS (FWP_TLS_CERT, FWP_TLS_KEY),
/// interpreted and native.
fn api_servers(certs: &Path, d: &Path) -> Vec<Server> {
    let file = root().join("examples/server/api.fwp");
    both_ways(&file, d, "api")
        .into_iter()
        .map(|mut cmd| {
            cmd.env("FWP_ADDR", "127.0.0.1:0")
                .env("FWP_TLS_CERT", certs.join("server.pem"))
                .env("FWP_TLS_KEY", certs.join("server.key"));
            start(cmd, "listening on ")
        })
        .collect()
}

/// Start a TLS handshake and stop in the middle of it (a client hello
/// cut short), or never start one.
fn stalled_clients(addr: &str) -> Vec<TcpStream> {
    let silent = TcpStream::connect(addr).unwrap();
    let mut partial = TcpStream::connect(addr).unwrap();
    // a handshake record header announcing 512 bytes, and only a few
    partial
        .write_all(&[0x16, 0x03, 0x01, 0x02, 0x00, 0x01, 0x00])
        .unwrap();
    vec![silent, partial]
}

/// curl and fwp clients (interpreted and native) against the HTTPS
/// servers, while other clients stall in their handshakes.
#[test]
fn https_servers_and_clients() {
    let Some(certs) = certs() else { return };
    let d = scratch("https");
    let ca = certs.join("ca.pem");
    let ca = ca.to_str().unwrap();
    let clients = both_ways(&root().join("tests/tls/client.fwp"), &d, "client");
    for srv in api_servers(certs, &d) {
        let addr = srv.addr.strip_prefix("https://").expect("an https address");
        let base = format!("https://localhost:{}", srv.port());
        let _stalled = stalled_clients(addr);
        if have_curl() {
            let started = Instant::now();
            assert_eq!(
                curl(&["--cacert", ca, &format!("{}/health", base)]),
                (0, "{\"status\":\"ok\"} [200]".to_string())
            );
            assert_eq!(
                curl(&["--cacert", ca, &format!("{}/items/42", base)]).1,
                "{\"id\":42,\"name\":\"item 42\"} [200]"
            );
            assert_eq!(
                curl(&["--cacert", ca, &format!("{}/stream", base)]).1,
                "line 1\nline 2\nline 3\nline 4\nline 5\n [200]"
            );
            assert_eq!(
                curl(&[
                    "--cacert",
                    ca,
                    "-X",
                    "POST",
                    "-H",
                    "authorization: Bearer secret",
                    "-d",
                    "{\"name\": \"pipe\"}",
                    &format!("{}/items", base)
                ])
                .1,
                "{\"id\":1,\"name\":\"pipe\"} [201]"
            );
            // the stalled handshakes held up nothing
            assert!(started.elapsed() < Duration::from_secs(10));
            // concurrent requests, some slow
            let workers: Vec<_> = (0..8)
                .map(|i| {
                    let (ca, base) = (ca.to_string(), base.clone());
                    std::thread::spawn(move || {
                        let path = if i % 2 == 0 {
                            "/slow?ms=300"
                        } else {
                            "/health"
                        };
                        curl(&["--cacert", &ca, &format!("{}{}", base, path)]).1
                    })
                })
                .collect();
            for (i, w) in workers.into_iter().enumerate() {
                let want = if i % 2 == 0 {
                    "slept 300 ms [200]"
                } else {
                    "{\"status\":\"ok\"} [200]"
                };
                assert_eq!(w.join().unwrap(), want);
            }
            // an untrusted certificate: curl refuses it (60)
            assert_eq!(curl(&[&format!("{}/health", base)]).0, 60);
            // and plain HTTP gets no answer
            assert_ne!(
                curl(&[&format!("http://{}/health", addr)]).1,
                "{\"status\":\"ok\"} [200]"
            );
        }
        for mut c in both_ways_cmds(&clients) {
            c.env("SSL_CERT_FILE", certs.join("ca.pem")).args([
                format!("{}/items/7", base),
                format!("https://127.0.0.1:{}/health", srv.port()),
                format!("{}/stream", base),
            ]);
            let o = run(c, 60);
            assert_eq!(
                text(&o),
                "200 {\"id\":7,\"name\":\"item 7\"}\n200 {\"status\":\"ok\"}\n200 line 1\n",
                "{}",
                String::from_utf8_lossy(&o.stderr)
            );
        }
        // without the CA, the clients refuse the server
        for mut c in both_ways_cmds(&clients) {
            c.env("SSL_CERT_FILE", certs.join("server.pem"))
                .arg(format!("{}/health", base));
            let o = run(c, 60);
            assert_eq!(
                text(&o).replace(srv.port(), "PORT"),
                "tls error: localhost:PORT: certificate verify failed: unable to get local issuer certificate\n"
            );
        }
    }
}

/// Fresh commands with the same programs.
fn both_ways_cmds(cmds: &[Command]) -> Vec<Command> {
    cmds.iter()
        .map(|c| {
            let mut n = Command::new(c.get_program());
            n.args(c.get_args());
            n
        })
        .collect()
}

/// A free port on 127.0.0.1 (another process may take it before it is
/// used; callers retry).
fn free_port() -> u16 {
    std::net::TcpListener::bind("127.0.0.1:0")
        .unwrap()
        .local_addr()
        .unwrap()
        .port()
}

/// fwp clients of a server that is not fwp: `openssl s_server`.
#[test]
fn client_of_openssl_s_server() {
    let Some(certs) = certs() else { return };
    let d = scratch("s_server");
    let clients = both_ways(&root().join("tests/tls/client.fwp"), &d, "client");
    let mut server = None;
    for _ in 0..5 {
        let port = free_port();
        let mut child = Command::new("openssl")
            .args([
                "s_server",
                "-quiet",
                "-www",
                "-cert",
                "server.pem",
                "-key",
                "server.key",
            ])
            .args(["-accept", &port.to_string()])
            .current_dir(certs)
            .stdin(Stdio::piped())
            .stdout(Stdio::null())
            .stderr(Stdio::null())
            .spawn()
            .unwrap();
        let started = Instant::now();
        while started.elapsed() < Duration::from_secs(10) {
            if TcpStream::connect(("127.0.0.1", port)).is_ok() {
                break;
            }
            if child.try_wait().unwrap().is_some() {
                break;
            }
            std::thread::sleep(Duration::from_millis(50));
        }
        if child.try_wait().unwrap().is_none() {
            server = Some((child, port));
            break;
        }
    }
    let (mut child, port) = server.expect("openssl s_server did not start");
    for mut c in both_ways_cmds(&clients) {
        c.env("SSL_CERT_FILE", certs.join("ca.pem"))
            .arg(format!("https://localhost:{}/", port));
        let o = run(c, 60);
        let out = text(&o);
        assert!(
            out.starts_with("200 "),
            "{}{}",
            out,
            String::from_utf8_lossy(&o.stderr)
        );
    }
    let _ = child.kill();
    let _ = child.wait();
}

// ------------------------------------------------------------ REST

/// A REST server over HTTPS (`--tls-cert`, `--tls-key`; FWP_TLS_CERT and
/// FWP_TLS_KEY natively), called by curl and by the client that
/// `fwp openapi --import` generated from its document.
#[test]
fn rest_over_https() {
    let Some(certs) = certs() else { return };
    let d = scratch("rest");
    let api = root().join("tests/rest/api.fwp");
    let cert = certs.join("server.pem");
    let key = certs.join("server.key");
    let mut servers = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["serve", "--rest", "--interp"])
        .arg(&api)
        .args(["--listen", "127.0.0.1:0", "--tls-cert"])
        .arg(&cert)
        .arg("--tls-key")
        .arg(&key);
    servers.push(start(cmd, "fwp: rest listening on "));
    if have_cc() {
        let exe = d.join("server");
        let o = Command::new(fwp())
            .arg("build")
            .arg(&api)
            .args(["--rest", "-O1", "-o"])
            .arg(&exe)
            .output()
            .unwrap();
        assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
        let mut cmd = Command::new(&exe);
        cmd.args(["--listen", "127.0.0.1:0"])
            .env("FWP_TLS_CERT", &cert)
            .env("FWP_TLS_KEY", &key);
        servers.push(start(cmd, "fwp: rest listening on "));
    }
    let roundtrip = root().join("tests/rest/roundtrip.fwp");
    let expected = std::fs::read_to_string(root().join("tests/rest/roundtrip.out")).unwrap();
    let clients = both_ways(&roundtrip, &d, "roundtrip");
    for srv in &servers {
        assert!(srv.addr.starts_with("https://"), "{}", srv.addr);
        let base = format!("https://localhost:{}", srv.port());
        if have_curl() {
            let (code, body) = curl(&[
                "--cacert",
                certs.join("ca.pem").to_str().unwrap(),
                &format!("{}/openapi.json", base),
            ]);
            assert_eq!(code, 0);
            assert!(
                body.contains("\"openapi\"") && body.ends_with(" [200]"),
                "{}",
                body
            );
        }
        for mut c in both_ways_cmds(&clients) {
            c.env("SSL_CERT_FILE", certs.join("ca.pem"))
                .env("FWP_TEST_BASE", &base);
            let o = run(c, 120);
            assert_eq!(text(&o), expected, "{}", String::from_utf8_lossy(&o.stderr));
        }
    }
    // a certificate without a key
    let o = Command::new(fwp())
        .args(["serve", "--rest", "--interp"])
        .arg(&api)
        .args(["--listen", "127.0.0.1:0", "--tls-cert"])
        .arg(&cert)
        .env_remove("FWP_TLS_KEY")
        .output()
        .unwrap();
    assert_eq!(o.status.code(), Some(1));
    assert_eq!(
        String::from_utf8_lossy(&o.stderr),
        "fwp: --tls-cert needs --tls-key (or FWP_TLS_KEY)\n"
    );
}

/// A REST server that requires client certificates (`--tls-client-ca`,
/// FWP_TLS_CLIENT_CA natively) authenticates its clients by their subject
/// (`# auth: client-cert`) and gives it to endpoints.
#[test]
fn rest_with_client_certificates() {
    let Some(certs) = certs() else { return };
    let d = scratch("rest-mtls");
    let app = root().join("tests/tls/whoami.fwp");
    let file = |n: &str| certs.join(n).to_str().unwrap().to_string();
    let mut servers = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["serve", "--rest", "--interp"])
        .arg(&app)
        .args(["--listen", "127.0.0.1:0", "--tls-cert", &file("server.pem")])
        .args([
            "--tls-key",
            &file("server.key"),
            "--tls-client-ca",
            &file("ca.pem"),
        ]);
    servers.push(start(cmd, "fwp: rest listening on "));
    if have_cc() {
        let exe = d.join("server");
        build(
            &[app.to_str().unwrap(), "--rest", "-o", exe.to_str().unwrap()],
            &root(),
        );
        let mut cmd = Command::new(&exe);
        cmd.args(["--listen", "127.0.0.1:0"])
            .env("FWP_TLS_CERT", file("server.pem"))
            .env("FWP_TLS_KEY", file("server.key"))
            .env("FWP_TLS_CLIENT_CA", file("ca.pem"));
        servers.push(start(cmd, "fwp: rest listening on "));
    }
    if !have_curl() {
        return;
    }
    for srv in &servers {
        let base = format!("https://localhost:{}", srv.port());
        let with = |path: &str, cert: &str, key: &str| {
            curl(&[
                "--cacert",
                &file("ca.pem"),
                "--cert",
                &file(cert),
                "--key",
                &file(key),
                &format!("{}{}", base, path),
            ])
        };
        let me = "\"CN=fwp client,O=fwp\" [200]";
        assert_eq!(with("/whoami", "client.pem", "client.key"), (0, me.into()));
        assert_eq!(with("/peer", "client.pem", "client.key"), (0, me.into()));
        assert_eq!(
            with("/grpc-peer", "client.pem", "client.key"),
            (0, "\"none\" [200]".into())
        );
        // no certificate, or one the CA did not sign: no handshake
        let (code, _) = curl(&["--cacert", &file("ca.pem"), &format!("{}/peer", base)]);
        assert_ne!(code, 0);
        let (code, _) = with("/whoami", "rogue.pem", "rogue.key");
        assert_ne!(code, 0);
    }
    // client certificates need a server certificate
    let o = Command::new(fwp())
        .args(["serve", "--rest", "--interp"])
        .arg(&app)
        .args([
            "--listen",
            "127.0.0.1:0",
            "--tls-client-ca",
            &file("ca.pem"),
        ])
        .env_remove("FWP_TLS_CERT")
        .env_remove("FWP_TLS_KEY")
        .output()
        .unwrap();
    assert_eq!(o.status.code(), Some(1));
    assert_eq!(
        String::from_utf8_lossy(&o.stderr),
        "fwp: --tls-client-ca needs --tls-cert and --tls-key\n"
    );
}

// ------------------------------------------------------------ gRPC

/// A service that requires client certificates (`--tls-client-ca`),
/// called by the client of a split build that presents one
/// (FWP_SERVICE_<M>_CERT, trusting the CA of FWP_SERVICE_<M>_CA).
#[test]
fn grpc_with_client_certificates() {
    let Some(certs) = certs() else { return };
    let file = |n: &str| certs.join(n).to_str().unwrap().to_string();
    // a split build's client: the CA and the certificate of FWP_SERVICE_<M>_*
    let ex = root().join("tests/tls");
    let local = run(
        {
            let mut c = Command::new(fwp());
            c.args(["run", "--interp", "forecast-client.fwp"])
                .current_dir(&ex);
            c
        },
        120,
    );
    let mut cmd = Command::new(fwp());
    cmd.args([
        "serve",
        "--interp",
        "forecast-client.fwp",
        "weather",
        "--listen",
        "127.0.0.1:0",
    ])
    .args([
        "--tls-cert",
        &file("server.pem"),
        "--tls-key",
        &file("server.key"),
    ])
    .args(["--tls-client-ca", &file("ca.pem")])
    .current_dir(&ex);
    let srv = start(cmd, "fwp: service weather listening on ");
    let client = |cert: bool| {
        let mut c = Command::new(fwp());
        c.args([
            "run",
            "--interp",
            "--service",
            "weather",
            "forecast-client.fwp",
        ])
        .current_dir(&ex)
        .env_remove("SSL_CERT_FILE")
        .env(
            "FWP_SERVICE_WEATHER",
            format!("tls://localhost:{}", srv.port()),
        )
        .env("FWP_SERVICE_WEATHER_CA", file("ca.pem"));
        if cert {
            c.env("FWP_SERVICE_WEATHER_CERT", file("client.pem"))
                .env("FWP_SERVICE_WEATHER_KEY", file("client.key"));
        }
        run(c, 120)
    };
    assert_eq!(text(&client(true)), text(&local));
    assert!(!text(&client(false)).contains("Lisbon"));
}

/// The weather service of tests/tls over TLS: interpreted and native
/// servers (flags, environment variables) called by interpreted and native
/// clients of a split build (`FWP_SERVICE_WEATHER=tls://...`), and by
/// grpcurl when it is installed.
#[test]
fn grpc_over_tls() {
    let Some(certs) = certs() else { return };
    let d = scratch("grpc");
    let ex = root().join("tests/tls");
    let cert = certs.join("server.pem");
    let key = certs.join("server.key");
    // what the client prints when the calls are local
    let local = run(
        {
            let mut c = Command::new(fwp());
            c.args(["run", "--interp", "forecast-client.fwp"])
                .current_dir(&ex);
            c
        },
        120,
    );
    let expected = text(&local);
    assert!(expected.contains("Lisbon"), "{}", expected);
    let mut servers = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args([
        "serve",
        "--interp",
        "forecast-client.fwp",
        "weather",
        "--listen",
        "127.0.0.1:0",
    ])
    .arg("--tls-cert")
    .arg(&cert)
    .arg("--tls-key")
    .arg(&key)
    .current_dir(&ex);
    servers.push(start(cmd, "fwp: service weather listening on "));
    let mut clients = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args([
        "run",
        "--interp",
        "--service",
        "weather",
        "forecast-client.fwp",
    ])
    .current_dir(&ex);
    clients.push(cmd);
    if have_cc() {
        let out = d.join("split");
        build(
            &[
                "--service",
                "weather",
                "forecast-client.fwp",
                "-o",
                out.to_str().unwrap(),
            ],
            &ex,
        );
        let mut cmd = Command::new(out.join("weather"));
        cmd.args(["--listen", "127.0.0.1:0"])
            .env("FWP_TLS_CERT", &cert)
            .env("FWP_TLS_KEY", &key);
        servers.push(start(cmd, "fwp: service weather listening on "));
        clients.push(Command::new(out.join("forecast-client")));
    }
    for srv in &servers {
        assert!(srv.addr.starts_with("tls://"), "{}", srv.addr);
        for (scheme, host) in [("tls", "localhost"), ("grpcs", "127.0.0.1")] {
            for c in &clients {
                let mut c2 = Command::new(c.get_program());
                c2.args(c.get_args())
                    .env("SSL_CERT_FILE", certs.join("ca.pem"))
                    .env(
                        "FWP_SERVICE_WEATHER",
                        format!("{}://{}:{}", scheme, host, srv.port()),
                    );
                if let Some(dir) = c.get_current_dir() {
                    c2.current_dir(dir);
                }
                let o = run(c2, 120);
                assert_eq!(text(&o), expected, "{}", String::from_utf8_lossy(&o.stderr));
            }
        }
        // the server's certificate is not trusted without the CA
        for c in &clients {
            let mut c2 = Command::new(c.get_program());
            c2.args(c.get_args()).env("SSL_CERT_FILE", &cert).env(
                "FWP_SERVICE_WEATHER",
                format!("tls://localhost:{}", srv.port()),
            );
            if let Some(dir) = c.get_current_dir() {
                c2.current_dir(dir);
            }
            let o = run(c2, 120);
            let all = format!("{}{}", text(&o), String::from_utf8_lossy(&o.stderr))
                .replace(srv.port(), "PORT");
            assert!(
                all.contains("cannot connect to localhost:PORT: certificate verify failed: unable to get local issuer certificate"),
                "{}",
                all
            );
        }
        // a cleartext (h2c) client cannot talk to it
        let mut c2 = Command::new(clients[0].get_program());
        c2.args(clients[0].get_args())
            .current_dir(&ex)
            .env("FWP_SERVICE_WEATHER", format!("127.0.0.1:{}", srv.port()));
        let o = run(c2, 120);
        assert!(!text(&o).contains("Lisbon"));
        if have("grpcurl", "-version") {
            let o = Command::new("grpcurl")
                .arg("-cacert")
                .arg(certs.join("ca.pem"))
                .args(["-d", "{\"name\": \"Oslo\", \"lat\": 60}"])
                .arg(format!("localhost:{}", srv.port()))
                .arg("weather.Weather/Now")
                .output()
                .unwrap();
            assert_eq!(
                text(&o),
                "{\n  \"place\": \"Oslo\",\n  \"celsius\": 6\n}\n",
                "{}",
                String::from_utf8_lossy(&o.stderr)
            );
            let o = Command::new("grpcurl")
                .arg("-cacert")
                .arg(certs.join("ca.pem"))
                .arg(format!("localhost:{}", srv.port()))
                .arg("list")
                .output()
                .unwrap();
            assert_eq!(text(&o), "grpc.health.v1.Health\nweather.Weather\n");
            // grpcurl refuses the certificate without the CA
            let o = Command::new("grpcurl")
                .arg(format!("localhost:{}", srv.port()))
                .arg("list")
                .output()
                .unwrap();
            assert!(!o.status.success());
        }
        // a slow handshake holds up no other client
        let _stalled = stalled_clients(&srv.addr["tls://".len()..]);
        let mut c2 = Command::new(clients[0].get_program());
        c2.args(clients[0].get_args())
            .current_dir(&ex)
            .env("SSL_CERT_FILE", certs.join("ca.pem"))
            .env(
                "FWP_SERVICE_WEATHER",
                format!("tls://localhost:{}", srv.port()),
            );
        assert_eq!(text(&run(c2, 120)), expected);
    }
}

/// A socket reset must stay an error even when Windows' CRT errno is zero.
#[test]
fn native_tls_preserves_socket_errors_and_clean_shutdown() {
    let Some(_certs) = certs() else { return };
    use fwp::ir::*;
    let unit = MT::unit();
    let program = Program {
        funcs: vec![Func {
            name: "available".into(),
            arity: 1,
            locals: vec![unit.clone()],
            ty: MT::Fun(Box::new(unit), Box::new(MT::con("std::Bool"))),
            body: Body::Prim("tls.available".into()),
        }],
        exports: vec![("available".into(), 0)],
        ..Program::default()
    };
    let (generated, _) = fwp::cgen::generate_library(&program, "tls_errors", &[]).unwrap();
    let hooks = r#"
#if defined(_WIN32) && !defined(_WIN32_WINNT)
#define _WIN32_WINNT 0x0a00
#endif
#include <openssl/ssl.h>
static int test_read(SSL *ssl,void *data,int n);
static int test_write(SSL *ssl,const void *data,int n);
static int test_step(SSL *ssl);
static int test_error(const SSL *ssl,int result);
static int test_finished(const SSL *ssl);
#define SSL_read test_read
#define SSL_write test_write
#define SSL_do_handshake test_step
#define SSL_get_error test_error
#define SSL_is_init_finished test_finished
"#;
    let fixture = r#"
#undef SSL_read
#undef SSL_write
#undef SSL_do_handshake
#undef SSL_get_error
#undef SSL_is_init_finished
static int error_kind=SSL_ERROR_SYSCALL,uncleared;
#ifdef _WIN32
#define TEST_RESET WSAECONNRESET
#else
#define TEST_RESET ECONNRESET
#endif
static int test_step(SSL *ssl){
 (void)ssl;
#ifdef _WIN32
 if(WSAGetLastError()!=0)uncleared++;
 errno=0;WSASetLastError(TEST_RESET);
#else
 if(errno!=0)uncleared++;
 errno=TEST_RESET;
#endif
 return -1;
}
static int test_read(SSL *ssl,void *data,int n){(void)data;(void)n;return test_step(ssl);}
static int test_write(SSL *ssl,const void *data,int n){(void)data;(void)n;return test_step(ssl);}
static int test_error(const SSL *ssl,int result){(void)ssl;(void)result;return error_kind;}
static int test_finished(const SSL *ssl){(void)ssl;return 1;}
static void stale_error(void){errno=EDOM;
#ifdef _WIN32
 WSASetLastError(WSAEINVAL);
#endif
}
int main(void){
 fwp_lib_init();if(fwp_sockets_init())return 246;
 SSL_CTX *ctx=SSL_CTX_new(TLS_client_method());if(!ctx)return 246;
 SSL *ssl=SSL_new(ctx);SSL_CTX_free(ctx);if(!ssl)return 246;
 char byte=0;int wait=99;ssize_t result;
 stale_error();result=fwp_tls_recv(ssl,&byte,1,&wait);
 if(result!=-1||errno!=TEST_RESET||uncleared)return 247;
 stale_error();result=fwp_tls_send(ssl,&byte,1,&wait);
 if(result!=-1||errno!=TEST_RESET||uncleared)return 247;
 stale_error();result=fwp_tls_step(ssl,&wait);
 if(result!=-2||strcmp(fwp_tls_err,"TLS handshake failed: Connection reset by peer")||uncleared)return 247;
 error_kind=SSL_ERROR_ZERO_RETURN;
 stale_error();if(fwp_tls_recv(ssl,&byte,1,&wait)!=0||uncleared)return 247;
 stale_error();if(fwp_tls_send(ssl,&byte,1,&wait)!=-2||uncleared)return 247;
 stale_error();if(fwp_tls_step(ssl,&wait)!=-2||uncleared)return 247;
 error_kind=SSL_ERROR_WANT_READ;wait=99;
 if(fwp_tls_recv(ssl,&byte,1,&wait)!=-1||errno!=EAGAIN||wait!=0)return 247;
 error_kind=SSL_ERROR_WANT_WRITE;wait=99;
 if(fwp_tls_send(ssl,&byte,1,&wait)!=-1||errno!=EAGAIN||wait!=1)return 247;
 SSL_free(ssl);puts("TLS socket errors, waits and clean shutdown preserved");return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("tls-errors").unwrap();
    let exe = dir.join("probe.exe");
    let broken = generated
        .replace("    int e = WSAGetLastError();", "    int e = 0;")
        .replace("    int e = errno;", "    int e = 0;");
    assert_ne!(generated, broken);
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [(&generated, 0), (&broken, 247)] {
            fwp::cgen::compile_c(&format!("{hooks}\n{source}\n{fixture}"), &exe, opt).unwrap();
            let output = Command::new(&exe).output().unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
    }
}
