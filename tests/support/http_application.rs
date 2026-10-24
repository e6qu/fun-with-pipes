//! Bounded-live cohorts through the maintained JSON API, including failures.
use super::{example, fwp, http_server_process};
use std::io::{BufRead, BufReader, Read, Write};
use std::net::TcpStream;
use std::path::{Path, PathBuf};
use std::process::{Child, Command, ExitStatus, Stdio};
use std::sync::{mpsc, Arc, Mutex};
use std::thread::JoinHandle;
use std::time::{Duration, Instant};

#[path = "http_application_memory.rs"]
mod memory;
#[path = "process_memory.rs"]
mod process_memory;

struct Observed {
    child: Child,
    address: String,
    lines: mpsc::Receiver<String>,
    reader: Option<JoinHandle<()>>,
    log: Arc<Mutex<String>>,
    resident: String,
    artifact: PathBuf,
}

impl Observed {
    fn start(binary: &Path, artifact: PathBuf) -> Self {
        let mut command = Command::new(binary);
        command
            .env("FWP_ADDR", "127.0.0.1:0")
            .env_remove("FWP_TLS_CERT")
            .env_remove("FWP_TLS_KEY");
        let (child, address, stderr) = http_server_process::start(
            &mut command,
            "listening on http://",
            Duration::from_secs(60),
            Stdio::piped(),
        )
        .unwrap();
        let log = Arc::new(Mutex::new(String::new()));
        let recorded = Arc::clone(&log);
        let (sender, lines) = mpsc::channel();
        let reader = std::thread::spawn(move || {
            for line in stderr.lines() {
                let line = line.unwrap();
                recorded.lock().unwrap().push_str(&format!("{line}\n"));
                let _ = sender.send(line);
            }
        });
        Self {
            child,
            address,
            lines,
            reader: Some(reader),
            log,
            resident: "connections\trss_kib\n".into(),
            artifact,
        }
    }

    fn checkpoint(&mut self, connections: usize, resume: bool) {
        let deadline = Instant::now() + Duration::from_secs(20);
        let line = loop {
            let message = self
                .lines
                .recv_timeout(deadline.saturating_duration_since(Instant::now()));
            let line = match message {
                Ok(line) => line,
                Err(error) => {
                    let log = self.log.lock().unwrap().clone();
                    panic!(
                        "idle memory checkpoint after {connections} connections: {error}; {log}"
                    );
                }
            };
            if !line.starts_with("http-wait") {
                break line;
            }
        };
        let fields: Vec<_> = line.split('\t').collect();
        assert_eq!(fields.len(), 7, "{line}");
        assert_eq!(fields[0], "http-memory", "{line}");
        assert_eq!(fields[1].parse::<usize>().unwrap(), connections, "{line}");
        if resume {
            assert_eq!(fields[1], fields[2], "unclosed socket: {line}");
            assert_eq!(fields[4], "1", "listener is the only remaining task");
            assert_eq!(fields[6], "0", "collector ran: {line}");
            let rss = process_memory::process_rss_kib(self.child.id());
            assert!(rss > 0);
            self.resident.push_str(&format!("{connections}\t{rss}\n"));
            self.child.stdin.as_mut().unwrap().write_all(b"\n").unwrap();
        }
    }

    fn wait(&mut self) -> ExitStatus {
        let end = Instant::now() + Duration::from_secs(20);
        loop {
            if let Some(status) = self.child.try_wait().unwrap() {
                return status;
            }
            assert!(Instant::now() < end, "API shutdown deadline");
            std::thread::sleep(Duration::from_millis(10));
        }
    }
}

impl Drop for Observed {
    fn drop(&mut self) {
        let _ = self.child.kill();
        let status = self.child.wait();
        if let Some(reader) = self.reader.take() {
            let _ = reader.join();
        }
        // Preserve evidence even when a response, timeout or memory assertion fails.
        std::fs::write(
            self.artifact.with_extension("stderr"),
            self.log.lock().unwrap().as_bytes(),
        )
        .unwrap();
        std::fs::write(self.artifact.with_extension("rss.tsv"), &self.resident).unwrap();
        let status = match status {
            Ok(status) => status
                .code()
                .map_or_else(|| status.to_string(), |code| code.to_string()),
            Err(error) => format!("wait failed: {error}"),
        };
        std::fs::write(self.artifact.with_extension("status"), status).unwrap();
    }
}

fn connection(address: &str) -> (TcpStream, BufReader<TcpStream>) {
    let stream =
        TcpStream::connect_timeout(&address.parse().unwrap(), Duration::from_secs(15)).unwrap();
    stream
        .set_read_timeout(Some(Duration::from_secs(15)))
        .unwrap();
    stream
        .set_write_timeout(Some(Duration::from_secs(15)))
        .unwrap();
    stream.set_nodelay(true).unwrap();
    let reader = BufReader::new(stream.try_clone().unwrap());
    (stream, reader)
}

fn response(reader: &mut BufReader<TcpStream>) -> (u32, String) {
    let mut status = String::new();
    assert!(
        reader.read_line(&mut status).unwrap() > 0,
        "missing HTTP response"
    );
    let status = status.split_whitespace().nth(1).unwrap().parse().unwrap();
    let mut length = None;
    let mut chunked = false;
    loop {
        let mut line = String::new();
        assert!(
            reader.read_line(&mut line).unwrap() > 0,
            "truncated headers"
        );
        if line == "\r\n" {
            break;
        }
        let lower = line.to_ascii_lowercase();
        if let Some(value) = lower.strip_prefix("content-length:") {
            assert!(length.is_none());
            length = Some(value.trim().parse::<usize>().unwrap());
        }
        if let Some(value) = lower.strip_prefix("transfer-encoding:") {
            assert_eq!(value.trim(), "chunked");
            assert!(!chunked);
            chunked = true;
        }
    }
    let mut body = Vec::new();
    if chunked {
        assert!(length.is_none());
        loop {
            let mut line = String::new();
            reader.read_line(&mut line).unwrap();
            let size = usize::from_str_radix(line.trim(), 16).unwrap();
            assert!(size <= 65536, "unexpected API chunk size");
            let start = body.len();
            body.resize(start + size, 0);
            reader.read_exact(&mut body[start..]).unwrap();
            let mut end = [0; 2];
            reader.read_exact(&mut end).unwrap();
            assert_eq!(&end, b"\r\n");
            if size == 0 {
                break;
            }
        }
    } else {
        let size = length.expect("response framing");
        assert!(size <= 65536);
        body.resize(size, 0);
        reader.read_exact(&mut body).unwrap();
    }
    (status, String::from_utf8(body).unwrap())
}

fn send(stream: &mut TcpStream, method: &str, path: &str, headers: &str, body: &str) {
    write!(
        stream,
        "{method} {path} HTTP/1.1\r\nhost: test\r\ncontent-length: {}\r\n{headers}\r\n{body}",
        body.len()
    )
    .unwrap();
}

fn metrics(stream: &mut TcpStream, reader: &mut BufReader<TcpStream>) -> f64 {
    send(stream, "GET", "/metrics", "", "");
    let (status, body) = response(reader);
    assert_eq!(status, 200);
    let count: f64 = body
        .lines()
        .find_map(|line| line.strip_prefix("http_requests_total "))
        .expect("request counter")
        .parse()
        .expect("numeric request counter");
    assert!(
        count.is_finite() && count >= 1.0 && count.fract() == 0.0,
        "{body}"
    );
    count
}

fn cohort(address: &str, repeats: usize, disconnect: bool) {
    std::thread::scope(|scope| {
        let workers: Vec<_> = (0..8).map(|_| scope.spawn(move || {
            let (mut stream, mut reader) = connection(address);
            if disconnect {
                stream.write_all(b"POST /items HTTP/1.1\r\nhost: test\r\ncontent-length: 100\r\n\r\n{").unwrap();
                return;
            }
            for _ in 0..repeats {
                for (method, path, headers, body, code, expected) in [
                    ("GET", "/health", "", "", 200, "{\"status\":\"ok\"}"),
                    ("GET", "/items/42", "", "", 200, "{\"id\":42,\"name\":\"item 42\"}"),
                    ("GET", "/items/x", "", "", 404, "no such item"),
                    ("GET", "/nothing", "", "", 404, "not found"),
                    ("POST", "/items", "authorization: Bearer secret\r\n", "{\"name\":\"héllo\"}", 201, "{\"id\":1,\"name\":\"héllo\"}"),
                    ("POST", "/items", "", "{}", 401, "missing or invalid bearer token"),
                    ("POST", "/items", "authorization: Bearer secret\r\n", "{}", 422, "name is required"),
                    ("GET", "/slow?ms=0", "", "", 200, "slept 0 ms"),
                    ("GET", "/stream", "", "", 200, "line 1\nline 2\nline 3\nline 4\nline 5\n"),
                ] {
                    send(&mut stream, method, path, headers, body);
                    assert_eq!(response(&mut reader), (code, expected.into()), "{method} {path}");
                }
                assert!(metrics(&mut stream, &mut reader) > 0.0);
            }
        })).collect();
        for worker in workers {
            worker.join().unwrap();
        }
    });
}

fn cancel_pending(server: &mut Observed) {
    let (mut control, mut reader) = connection(&server.address);
    let baseline = metrics(&mut control, &mut reader);
    let mut pending = Vec::new();
    for _ in 0..7 {
        let (mut stream, reader) = connection(&server.address);
        send(&mut stream, "GET", "/slow?ms=60000", "", "");
        pending.push((stream, reader));
    }
    let deadline = Instant::now() + Duration::from_secs(10);
    for polls in 1.. {
        if metrics(&mut control, &mut reader) == baseline + f64::from(polls) + 7.0 {
            break;
        }
        assert!(Instant::now() < deadline, "slow handlers did not enter");
        std::thread::sleep(Duration::from_millis(10));
    }
    drop(reader);
    drop(control);
    http_server_process::terminate(&server.child).unwrap();
    assert!(server.wait().success());
    // Shutdown's 3s grace expires before the handler's 5s timeout. All seven
    // incomplete requests must lose their connection; no successful slow reply.
    for (_, mut reader) in pending {
        let mut bytes = Vec::new();
        if let Err(error) = reader.read_to_end(&mut bytes) {
            assert_eq!(error.kind(), std::io::ErrorKind::ConnectionReset, "{error}");
        }
        assert!(!String::from_utf8_lossy(&bytes).contains("slept 60000 ms"));
    }
}

fn exercise(binary: &Path, artifact: PathBuf, variant: &str) {
    let mut server = Observed::start(binary, artifact);
    cohort(&server.address, 1, false);
    server.checkpoint(8, true);
    cohort(&server.address, 4, false);
    server.checkpoint(16, variant == "healthy");
    if variant != "healthy" {
        assert_eq!(server.wait().code(), Some(241), "broken observer control");
        if let Some(reader) = server.reader.take() {
            reader.join().unwrap();
        }
        let log = server.log.lock().unwrap().clone();
        assert!(log.contains("http-memory changed"), "{log}");
        return;
    }
    for (i, repeats) in [16, 1, 16, 4].into_iter().enumerate() {
        cohort(&server.address, repeats, false);
        server.checkpoint((i + 3) * 8, true);
    }
    cohort(&server.address, 0, true);
    server.checkpoint(56, true);
    cohort(&server.address, 1, false);
    server.checkpoint(64, true);
    cancel_pending(&mut server);
    if let Some(reader) = server.reader.take() {
        reader.join().unwrap();
    }
    let log = server.log.lock().unwrap().clone();
    assert!(log.contains("http-shutdown\t1\n"), "{log}");
    assert!(log.contains("http-final\t72\t72\t0\t"), "{log}");
    assert!(log.ends_with("http-metrics-final\t0\n"), "{log}");
    let samples: Vec<u64> = server
        .resident
        .lines()
        .skip(1)
        .map(|line| line.split_once('\t').unwrap().1.parse().unwrap())
        .collect();
    assert_eq!(samples.len(), 8);
    assert!(
        samples.iter().all(|rss| *rss <= samples[0] + 8192),
        "RSS exceeded the predeclared warm-baseline + 8 MiB budget: {samples:?}"
    );
}

fn measure(opt: &str) {
    let temporary = fwp::cgen::TempDir::new("http-application-memory").unwrap();
    let artifacts = std::env::var_os("FWP_HTTP_APPLICATION_ARTIFACTS")
        .map(PathBuf::from)
        .unwrap_or_else(|| temporary.join("evidence"));
    std::fs::create_dir_all(&artifacts).unwrap();
    let source = temporary.join("api.c");
    let output = Command::new(fwp())
        .args(["build", "--gc", "arc", "--emit-c", opt])
        .arg(example())
        .arg("-o")
        .arg(&source)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let original = std::fs::read_to_string(source).unwrap();
    let observed = memory::instrument(&original);
    for (variant, code) in [
        ("healthy", observed.clone()),
        (
            "missing-free",
            observed.replace(
                "#define HTTP_APP_OMIT_FREE 0",
                "#define HTTP_APP_OMIT_FREE 1",
            ),
        ),
        (
            "missing-close",
            observed.replace(
                "#define HTTP_APP_OMIT_CLOSE 0",
                "#define HTTP_APP_OMIT_CLOSE 1",
            ),
        ),
    ] {
        let artifact = artifacts.join(format!("api-{variant}{}", opt.trim_start_matches('-')));
        std::fs::write(artifact.with_extension("c"), &code).unwrap();
        let binary = artifact.with_extension("exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        exercise(&binary, artifact, variant);
    }
}

#[test]
fn api_live_memory_o1() {
    let mut command = Command::new(fwp());
    command
        .env("FWP_NO_OPT", "1")
        .env_remove("FWP_TLS_CERT")
        .env_remove("FWP_TLS_KEY")
        .args(["run", "--interp"])
        .arg(example());
    let mut reference = super::start(command);
    cohort(&reference.addr, 1, false);
    cohort(&reference.addr, 0, true);
    http_server_process::terminate(&reference.child).unwrap();
    let end = Instant::now() + Duration::from_secs(20);
    loop {
        if let Some(status) = reference.child.try_wait().unwrap() {
            assert!(status.success());
            break;
        }
        assert!(Instant::now() < end, "reference shutdown deadline");
        std::thread::sleep(Duration::from_millis(10));
    }
    measure("-O1");
}
#[test]
fn api_live_memory_o2() {
    measure("-O2");
}

// Diagnostic entry only: exercise an explicitly selected saved executable.
// It does not replace the ordinary tests that compile this revision.
#[test]
#[ignore = "requires a saved native API binary and a fresh artifact directory"]
fn api_saved_binary_idle_memory() {
    let binary = PathBuf::from(std::env::var_os("FWP_HTTP_APPLICATION_BINARY").unwrap());
    let artifacts = PathBuf::from(std::env::var_os("FWP_HTTP_APPLICATION_ARTIFACTS").unwrap());
    std::fs::create_dir(&artifacts).unwrap();
    exercise(&binary, artifacts.join("api-saved"), "healthy");
}
