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
    let mut cmd = program(b, "server")?;
    if tls {
        let d = certs()?;
        cmd.env("FWP_TLS_CERT", d.join("server.pem"))
            .env("FWP_TLS_KEY", d.join("server.key"));
    }
    for (k, v) in env {
        cmd.env(k, v);
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

fn curl(args: &[&str]) -> String {
    let out = Command::new("curl")
        .args(["-s", "-m", "20"])
        .args(args)
        .output()
        .expect("run curl");
    String::from_utf8_lossy(&out.stdout).into_owned()
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
    if !have("curl", "--version") {
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
        let headers = curl(&[v, "--compressed", "-D", "-", "-o", "/dev/null", &u("/big")]);
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
    let st = Command::new("sh")
        .arg("-c")
        .arg(format!("printf 'zipped body' | gzip > {}", gz.display()))
        .status()
        .unwrap();
    if st.success() {
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
        "/dev/null",
        "-o",
        "/dev/null",
        "-o",
        "/dev/null",
        "-o",
        "/dev/null",
        "-o",
        "/dev/null",
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
    if !have("curl", "--version") || certs().is_none() {
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
    if !have("curl", "--version") {
        return;
    }
    for b in backends() {
        let mut srv = start(b, false, &[]).unwrap();
        let u = format!("http://{}/slow", srv.addr);
        let slow = std::thread::spawn(move || {
            curl(&["--http2-prior-knowledge", "-w", "|%{http_code}", &u])
        });
        std::thread::sleep(Duration::from_millis(150));
        let pid = srv.child.id().to_string();
        assert!(Command::new("kill")
            .args(["-TERM", &pid])
            .status()
            .unwrap()
            .success());
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
    let mut s = TcpStream::connect(addr).unwrap();
    s.set_read_timeout(Some(Duration::from_secs(20))).unwrap();
    let key = "dGhlIHNhbXBsZSBub25jZQ==";
    write!(
        s,
        "GET /ws HTTP/1.1\r\nhost: {}\r\nupgrade: websocket\r\nconnection: keep-alive, Upgrade\r\nsec-websocket-key: {}\r\nsec-websocket-version: 13\r\n\r\n",
        addr, key
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
    Ws { s, r }
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
        (h[0] & 0x80 != 0, h[0] & 0x0f, p)
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

    // not an upgrade request
    if have("curl", "--version") {
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
            "text:hi bin:1,2,3 text:70000 close 4000 asked to true",
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
