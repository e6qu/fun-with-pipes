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

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::sync::{Arc, Mutex, OnceLock};
use std::time::{Duration, Instant};

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
    String::from_utf8_lossy(&o.stdout).into_owned()
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
    log: Arc<Mutex<String>>,
}

impl Drop for Server {
    fn drop(&mut self) {
        let _ = self.child.kill();
        let _ = self.child.wait();
    }
}

impl Server {
    /// The port it listens on.
    fn port(&self) -> &str {
        self.addr.rsplit(':').next().unwrap()
    }
}

/// Start a server and wait for its "listening on" line.
// (the child is waited for when the `Server` is dropped)
#[allow(clippy::zombie_processes)]
fn start(mut cmd: Command) -> Server {
    cmd.stdout(Stdio::null()).stderr(Stdio::piped());
    let mut child = cmd.spawn().expect("start server");
    let mut err = BufReader::new(child.stderr.take().unwrap());
    let mut line = String::new();
    let deadline = Instant::now() + Duration::from_secs(60);
    loop {
        line.clear();
        if err.read_line(&mut line).unwrap() == 0 || Instant::now() > deadline {
            let _ = child.kill();
            panic!("server exited before listening: {}", line);
        }
        if let Some(a) = line.trim().split("listening on ").nth(1) {
            let addr = a.to_string();
            let log = Arc::new(Mutex::new(line.clone()));
            let l = log.clone();
            std::thread::spawn(move || {
                let mut line = String::new();
                while err.read_line(&mut line).unwrap_or(0) > 0 {
                    l.lock().unwrap().push_str(&line);
                    line.clear();
                }
            });
            return Server { child, addr, log };
        }
    }
}

fn curl(args: &[&str]) -> (i32, String) {
    let o = Command::new("curl")
        .args(["-s", "-m", "20", "-w", " [%{http_code}]"])
        .args(args)
        .output()
        .expect("run curl");
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

/// TLS connections in one program, interpreted and native: the same
/// output, which `tests/tls/streams.out` holds.
#[test]
fn streams() {
    let Some(certs) = certs() else { return };
    let d = scratch("streams");
    let file = root().join("tests/tls/streams.fwp");
    let expected = root().join("tests/tls/streams.out");
    for (i, mut cmd) in both_ways(&file, &d, "streams").into_iter().enumerate() {
        cmd.current_dir(certs);
        let o = run(cmd, 120);
        let got = text(&o);
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

/// Mutual TLS in one program, interpreted and native: a server that
/// requires client certificates and clients with and without one
/// (`tests/tls/mutual.out`).
#[test]
fn mutual_tls() {
    let Some(certs) = certs() else { return };
    let d = scratch("mutual");
    let file = root().join("tests/tls/mutual.fwp");
    let expected = root().join("tests/tls/mutual.out");
    for (i, mut cmd) in both_ways(&file, &d, "mutual").into_iter().enumerate() {
        cmd.current_dir(certs);
        let o = run(cmd, 120);
        let got = text(&o);
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
            start(cmd)
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
        if have("curl", "--version") {
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
    servers.push(start(cmd));
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
        servers.push(start(cmd));
    }
    let roundtrip = root().join("tests/rest/roundtrip.fwp");
    let expected = std::fs::read_to_string(root().join("tests/rest/roundtrip.out")).unwrap();
    let clients = both_ways(&roundtrip, &d, "roundtrip");
    for srv in &servers {
        assert!(srv.addr.starts_with("https://"), "{}", srv.addr);
        let base = format!("https://localhost:{}", srv.port());
        if have("curl", "--version") {
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
    servers.push(start(cmd));
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
        servers.push(start(cmd));
    }
    if !have("curl", "--version") {
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

/// gRPC servers that require client certificates (`--tls-client-ca`,
/// FWP_TLS_CLIENT_CA natively), called by clients that present one with
/// `grpc.with-tls` (an imported client) or FWP_SERVICE_<M>_CERT (a split
/// build, which also trusts the CA of FWP_SERVICE_<M>_CA), and by grpcurl.
#[test]
fn grpc_with_client_certificates() {
    let Some(certs) = certs() else { return };
    let d = scratch("grpc-mtls");
    let app = root().join("tests/tls/whoami.fwp");
    let file = |n: &str| certs.join(n).to_str().unwrap().to_string();
    // the client of the imported .proto, in the certificates' directory
    let proto = run(
        {
            let mut c = Command::new(fwp());
            c.args(["proto", "--grpc"]).arg(&app);
            c
        },
        60,
    );
    assert!(proto.status.success());
    std::fs::write(d.join("whoami.proto"), text(&proto)).unwrap();
    let o = Command::new(fwp())
        .args(["proto", "--import", "whoami.proto", "-o", "whoamigen.fwp"])
        .current_dir(&d)
        .output()
        .unwrap();
    assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    std::fs::copy(
        root().join("tests/tls/whoamiclient.fwp"),
        d.join("whoamiclient.fwp"),
    )
    .unwrap();
    let mut servers = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["serve", "--grpc", "--interp"])
        .arg(&app)
        .args(["--listen", "127.0.0.1:0", "--tls-cert", &file("server.pem")])
        .args([
            "--tls-key",
            &file("server.key"),
            "--tls-client-ca",
            &file("ca.pem"),
        ]);
    servers.push(start(cmd));
    let mut clients = vec![{
        let mut c = Command::new(fwp());
        c.args(["run", "--interp"]).arg(d.join("whoamiclient.fwp"));
        c
    }];
    if have_cc() {
        let exe = d.join("server");
        build(
            &[app.to_str().unwrap(), "--grpc", "-o", exe.to_str().unwrap()],
            &root(),
        );
        let mut cmd = Command::new(&exe);
        cmd.args(["--listen", "127.0.0.1:0"])
            .env("FWP_TLS_CERT", file("server.pem"))
            .env("FWP_TLS_KEY", file("server.key"))
            .env("FWP_TLS_CLIENT_CA", file("ca.pem"));
        servers.push(start(cmd));
        let exe = d.join("whoamiclient");
        build(
            &[
                d.join("whoamiclient.fwp").to_str().unwrap(),
                "-o",
                exe.to_str().unwrap(),
            ],
            &d,
        );
        clients.push(Command::new(exe));
    }
    let expected = "with a certificate\n  CN=fwp client,O=fwp\nwithout a certificate\n  UNAVAILABLE\nwith the certificate again\n  CN=fwp client,O=fwp\n";
    for srv in &servers {
        assert!(srv.addr.starts_with("tls://"), "{}", srv.addr);
        for c in &clients {
            let mut c2 = Command::new(c.get_program());
            c2.args(c.get_args())
                .arg(format!("tls://localhost:{}", srv.port()))
                .current_dir(certs);
            let o = run(c2, 120);
            assert_eq!(text(&o), expected, "{}", String::from_utf8_lossy(&o.stderr));
        }
        if have("grpcurl", "-version") {
            let o = Command::new("grpcurl")
                .args(["-cacert", &file("ca.pem"), "-cert", &file("client.pem")])
                .args(["-key", &file("client.key")])
                .arg(format!("localhost:{}", srv.port()))
                .arg("fwp.Whoami/GrpcPeer")
                .output()
                .unwrap();
            assert_eq!(
                text(&o),
                "{\n  \"value\": \"CN=fwp client,O=fwp\"\n}\n",
                "{}",
                String::from_utf8_lossy(&o.stderr)
            );
        }
    }
    // a split build's client: the CA and the certificate of FWP_SERVICE_<M>_*
    let ex = root().join("examples/grpc");
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
        "--grpc",
        "--interp",
        "weather.fwp",
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
    let srv = start(cmd);
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

/// The weather service of examples/grpc over TLS: interpreted and native
/// servers (flags, environment variables) called by interpreted and native
/// clients of a split build (`FWP_SERVICE_WEATHER=tls://...`), and by
/// grpcurl when it is installed.
#[test]
fn grpc_over_tls() {
    let Some(certs) = certs() else { return };
    let d = scratch("grpc");
    let ex = root().join("examples/grpc");
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
        "--grpc",
        "--interp",
        "weather.fwp",
        "--listen",
        "127.0.0.1:0",
    ])
    .arg("--tls-cert")
    .arg(&cert)
    .arg("--tls-key")
    .arg(&key)
    .current_dir(&ex);
    servers.push(start(cmd));
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
        servers.push(start(cmd));
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

/// Routes from a .proto file served with `grpc.serve-tls`, and called by
/// the generated client functions at a `tls://` address.
#[test]
fn grpc_routes_over_tls() {
    let Some(certs) = certs() else { return };
    let d = scratch("routes");
    let hello = root().join("tests/grpc/hello");
    for f in ["gen.fwp", "client.fwp"] {
        std::fs::copy(hello.join(f), d.join(f)).unwrap();
    }
    for f in ["server.pem", "server.key"] {
        std::fs::copy(certs.join(f), d.join(f)).unwrap();
    }
    let server = std::fs::read_to_string(hello.join("server.fwp")).unwrap();
    let plain = "| grpc.serve (args () | head";
    assert!(server.contains(plain));
    std::fs::write(
        d.join("server.fwp"),
        server.replace(
            plain,
            "| grpc.serve-tls (tls.server \"server.pem\" \"server.key\") (args () | head",
        ),
    )
    .unwrap();
    let expected = std::fs::read_to_string(hello.join("client.out")).unwrap();
    let mut servers = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["run", "--interp", "server.fwp", "127.0.0.1:0"])
        .current_dir(&d);
    servers.push(start(cmd));
    let mut clients = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["run", "--interp", "client.fwp"]).current_dir(&d);
    clients.push(cmd);
    if have_cc() {
        build(&["server.fwp", "-o", "server"], &d);
        build(&["client.fwp", "-o", "client"], &d);
        let mut cmd = Command::new(d.join("server"));
        cmd.arg("127.0.0.1:0").current_dir(&d);
        servers.push(start(cmd));
        clients.push(Command::new(d.join("client")));
    }
    for srv in &servers {
        assert!(srv.addr.starts_with("tls://"), "{}", srv.addr);
        for c in &clients {
            let mut c2 = Command::new(c.get_program());
            c2.args(c.get_args())
                .arg(&srv.addr)
                .current_dir(&d)
                .env("SSL_CERT_FILE", certs.join("ca.pem"));
            let o = run(c2, 120);
            let mut got = text(&o);
            if !o.stderr.is_empty() {
                got.push_str("--- stderr\n");
                got.push_str(&String::from_utf8_lossy(&o.stderr));
            }
            assert_eq!(got, expected);
        }
        let _ = srv.log.lock().unwrap().len();
    }
}
