//! The example JSON API server (examples/server/api.fwp), interpreted and
//! compiled natively: endpoints driven with curl, a concurrent load test
//! over keep-alive connections, and graceful shutdown on SIGTERM.

use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::time::{Duration, Instant};

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn example() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("examples/server/api.fwp")
}

fn have(tool: &str) -> bool {
    Command::new(tool).arg("--version").output().is_ok()
}

struct Server {
    child: Child,
    addr: String,
    stderr: BufReader<std::process::ChildStderr>,
}

fn start(mut cmd: Command) -> Server {
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
        .strip_prefix("listening on http://")
        .unwrap_or_else(|| panic!("unexpected first line: {:?}", line))
        .to_string();
    Server {
        child,
        addr,
        stderr,
    }
}

fn curl(args: &[&str]) -> String {
    let out = Command::new("curl")
        .args(["-s", "-m", "10", "-w", " [%{http_code}]"])
        .args(args)
        .output()
        .expect("run curl");
    String::from_utf8_lossy(&out.stdout).into_owned()
}

/// One request on an open keep-alive connection; returns (status, body).
fn request(conn: &mut TcpStream, reader: &mut BufReader<TcpStream>, path: &str) -> (u32, String) {
    let req = format!("GET {} HTTP/1.1\r\nhost: test\r\n\r\n", path);
    conn.write_all(req.as_bytes()).unwrap();
    let mut status = String::new();
    reader.read_line(&mut status).unwrap();
    let code: u32 = status.split(' ').nth(1).unwrap_or("0").parse().unwrap_or(0);
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
    (code, String::from_utf8_lossy(&body).into_owned())
}

fn exercise(name: &str, cmd: Command, clients: usize, per_client: usize) {
    let mut srv = start(cmd);
    let base = format!("http://{}", srv.addr);

    if have("curl") {
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
    }

    // load: concurrent clients, each with one keep-alive connection
    let started = Instant::now();
    let workers: Vec<_> = (0..clients)
        .map(|c| {
            let addr = srv.addr.clone();
            std::thread::spawn(move || {
                let mut conn = TcpStream::connect(&addr).unwrap();
                conn.set_nodelay(true).unwrap();
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
    let secs = started.elapsed().as_secs_f64();
    eprintln!(
        "{}: {} requests in {:.2}s ({:.0}/s)",
        name,
        n,
        secs,
        n as f64 / secs
    );

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
        let mut conn = TcpStream::connect(&addr).unwrap();
        conn.set_read_timeout(Some(Duration::from_secs(20)))
            .unwrap();
        let mut reader = BufReader::new(conn.try_clone().unwrap());
        request(&mut conn, &mut reader, "/slow?ms=800")
    });
    std::thread::sleep(Duration::from_millis(200));
    let pid = srv.child.id().to_string();
    assert!(Command::new("kill")
        .args(["-TERM", &pid])
        .status()
        .unwrap()
        .success());
    let (code, body) = slow.join().unwrap();
    assert_eq!((code, body.as_str()), (200, "slept 800 ms"));
    let status = srv.child.wait().unwrap();
    assert!(status.success(), "{}: exit status {}", name, status);
    let mut rest = String::new();
    srv.stderr.read_to_string(&mut rest).unwrap();
    assert_eq!(rest.trim(), "stopped");
    assert!(TcpStream::connect(&srv.addr).is_err());
}

#[test]
fn interpreted_server() {
    let mut cmd = Command::new(fwp());
    cmd.args(["run", "--interp"]).arg(example());
    exercise("interpreter", cmd, 8, 25);
}

#[test]
fn native_server() {
    if !have(&std::env::var("CC").unwrap_or_else(|_| "cc".into())) {
        return;
    }
    let exe = std::env::temp_dir().join(format!("fwp-api-{}", std::process::id()));
    let st = Command::new(fwp())
        .arg("build")
        .arg(example())
        .arg("-o")
        .arg(&exe)
        .status()
        .unwrap();
    assert!(st.success());
    exercise("native", Command::new(&exe), 64, 200);
    let _ = std::fs::remove_file(&exe);
}
