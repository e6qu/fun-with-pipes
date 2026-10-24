//! The example JSON API server (examples/server/api.fwp), interpreted and
//! compiled natively: endpoints driven with curl, a concurrent load test
//! over keep-alive connections, and graceful shutdown on SIGTERM/CTRL_BREAK.
//! These are correctness checks, not throughput measurements.

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
use std::path::{Path, PathBuf};
use std::process::{Child, Command};
use std::time::{Duration, Instant};

#[path = "support/http_server_process.rs"]
mod http_server_process;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn example() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("examples/server/api.fwp")
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

fn start(mut cmd: Command) -> Server {
    cmd.env("FWP_ADDR", "127.0.0.1:0");
    let (child, addr, stderr) =
        http_server_process::start(&mut cmd, "listening on http://", Duration::from_secs(60))
            .unwrap();
    Server {
        child,
        addr,
        stderr,
    }
}

fn curl(args: &[&str]) -> String {
    let out = Command::new("curl")
        .args(["-sS", "-m", "10", "-w", " [%{http_code}]"])
        .args(args)
        .output()
        .expect("run curl");
    assert!(out.status.success(), "curl {args:?}: {out:?}");
    String::from_utf8(out.stdout).unwrap()
}

/// One request on an open keep-alive connection; returns (status, body).
fn request(conn: &mut TcpStream, reader: &mut BufReader<TcpStream>, path: &str) -> (u32, String) {
    let req = format!("GET {} HTTP/1.1\r\nhost: test\r\n\r\n", path);
    conn.write_all(req.as_bytes()).unwrap();
    let mut status = String::new();
    reader.read_line(&mut status).unwrap();
    let code: u32 = status
        .split_whitespace()
        .nth(1)
        .expect("HTTP status")
        .parse()
        .unwrap();
    let mut length = None;
    loop {
        let mut h = String::new();
        assert!(
            reader.read_line(&mut h).unwrap() > 0,
            "truncated response headers"
        );
        if h == "\r\n" {
            break;
        }
        if let Some(v) = h.to_ascii_lowercase().strip_prefix("content-length:") {
            assert!(length.is_none(), "duplicate content length");
            length = Some(v.trim().parse::<usize>().unwrap());
        }
    }
    let mut body = vec![0u8; length.expect("keep-alive response content length")];
    reader.read_exact(&mut body).unwrap();
    (code, String::from_utf8(body).unwrap())
}

fn exercise(name: &str, cmd: Command, clients: usize, per_client: usize) {
    let mut srv = start(cmd);
    let base = format!("http://{}", srv.addr);

    assert_eq!(
        curl(&[&format!("{}/health", base)]),
        "{\"status\":\"ok\"} [200]"
    );
    assert_eq!(
        curl(&[&format!("{}/items/42", base)]),
        "{\"id\":42,\"name\":\"item 42\"} [200]"
    );
    assert_eq!(curl(&[&format!("{}/items/x", base)]), "no such item [404]");
    assert_eq!(curl(&[&format!("{}/nothing", base)]), "not found [404]");
    assert_eq!(
        curl(&[
            "-X",
            "POST",
            "-H",
            "authorization: Bearer secret",
            "-d",
            "{\"name\": \"pipe\"}",
            &format!("{}/items", base)
        ]),
        "{\"id\":1,\"name\":\"pipe\"} [201]"
    );
    assert_eq!(
        curl(&["-X", "POST", "-d", "{}", &format!("{}/items", base)]),
        "missing or invalid bearer token [401]"
    );
    assert_eq!(
        curl(&[&format!("{}/stream", base)]),
        "line 1\nline 2\nline 3\nline 4\nline 5\n [200]"
    );

    // load: concurrent clients, each with one keep-alive connection
    let workers: Vec<_> = (0..clients)
        .map(|c| {
            let addr = srv.addr.clone();
            std::thread::spawn(move || {
                let mut conn =
                    TcpStream::connect_timeout(&addr.parse().unwrap(), Duration::from_secs(20))
                        .unwrap();
                conn.set_nodelay(true).unwrap();
                conn.set_write_timeout(Some(Duration::from_secs(20)))
                    .unwrap();
                conn.set_read_timeout(Some(Duration::from_secs(20)))
                    .unwrap();
                let mut reader = BufReader::new(conn.try_clone().unwrap());
                for i in 0..per_client {
                    let id = c * 1000 + i;
                    let (code, body) = request(&mut conn, &mut reader, &format!("/items/{}", id));
                    assert_eq!(code, 200);
                    assert_eq!(body, format!("{{\"id\":{},\"name\":\"item {}\"}}", id, id));
                }
            })
        })
        .collect();
    for w in workers {
        w.join().expect("load client failed");
    }
    let n = clients * per_client;
    eprintln!("{name}: {n} verified keep-alive responses");

    let metrics = curl(&[&format!("{}/metrics", base)]);
    assert!(
        metrics.contains("# TYPE http_requests_total counter"),
        "{}",
        metrics
    );

    // graceful shutdown: an in-flight request finishes, then the process
    // exits; new connections are refused
    let addr = srv.addr.clone();
    let slow = std::thread::spawn(move || {
        let mut conn =
            TcpStream::connect_timeout(&addr.parse().unwrap(), Duration::from_secs(20)).unwrap();
        conn.set_read_timeout(Some(Duration::from_secs(20)))
            .unwrap();
        conn.set_write_timeout(Some(Duration::from_secs(20)))
            .unwrap();
        let mut reader = BufReader::new(conn.try_clone().unwrap());
        request(&mut conn, &mut reader, "/slow?ms=800")
    });
    std::thread::sleep(Duration::from_millis(200));
    http_server_process::terminate(&srv.child).unwrap();
    let (code, body) = slow.join().unwrap();
    assert_eq!((code, body.as_str()), (200, "slept 800 ms"));
    let until = Instant::now() + Duration::from_secs(30);
    let status = loop {
        if let Some(status) = srv.child.try_wait().unwrap() {
            break status;
        }
        assert!(Instant::now() < until, "server did not finish shutdown");
        std::thread::sleep(Duration::from_millis(20));
    };
    assert!(status.success(), "{}: exit status {}", name, status);
    let mut rest = String::new();
    srv.stderr.read_to_string(&mut rest).unwrap();
    assert_eq!(rest.trim(), "stopped");
    assert!(TcpStream::connect(&srv.addr).is_err());
}

#[test]
fn interpreted_server() {
    let mut cmd = Command::new(fwp());
    cmd.env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(example());
    exercise("interpreter", cmd, 8, 25);
}

#[test]
fn native_server() {
    let directory = fwp::cgen::TempDir::new("example-api").unwrap();
    let exe = directory.join("api.exe");
    let st = Command::new(fwp())
        .args(["build", "--gc", "arc", "-O2"])
        .arg(example())
        .arg("-o")
        .arg(&exe)
        .status()
        .unwrap();
    assert!(st.success());
    exercise("native", Command::new(&exe), 64, 200);
}
