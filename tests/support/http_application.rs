//! Bounded-live cohorts through the maintained JSON API, including failures.
use super::{example, fwp, http_server_process};
#[cfg(windows)]
use std::ffi::c_char;
use std::io::{BufRead, BufReader, Read, Write};
use std::net::{TcpListener, TcpStream};
#[cfg(windows)]
use std::os::windows::io::{AsRawSocket, RawSocket};
use std::path::{Path, PathBuf};
use std::process::{Child, Command, ExitStatus, Stdio};
use std::sync::{mpsc, Arc, Mutex};
use std::thread::JoinHandle;
use std::time::{Duration, Instant};

#[path = "http_application_memory.rs"]
mod memory;
#[path = "process_memory.rs"]
mod process_memory;

#[cfg(windows)]
#[link(name = "ws2_32")]
extern "system" {
    fn setsockopt(
        socket: RawSocket,
        level: i32,
        option: i32,
        value: *const c_char,
        size: i32,
    ) -> i32;
    fn getsockopt(
        socket: RawSocket,
        level: i32,
        option: i32,
        value: *mut c_char,
        size: *mut i32,
    ) -> i32;
    fn WSAGetLastError() -> i32;
}

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
        assert_eq!(fields.len(), 6, "{line}");
        assert_eq!(fields[0], "http-memory", "{line}");
        assert_eq!(fields[1].parse::<usize>().unwrap(), connections, "{line}");
        if resume {
            assert_eq!(fields[1], fields[2], "unclosed socket: {line}");
            assert_eq!(fields[4], "1", "listener is the only remaining task");
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

fn connection(address: &str) -> BufReader<TcpStream> {
    let stream =
        TcpStream::connect_timeout(&address.parse().unwrap(), Duration::from_secs(15)).unwrap();
    stream
        .set_read_timeout(Some(Duration::from_secs(15)))
        .unwrap();
    stream
        .set_write_timeout(Some(Duration::from_secs(15)))
        .unwrap();
    stream.set_nodelay(true).unwrap();
    BufReader::new(stream)
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

fn metrics(reader: &mut BufReader<TcpStream>) -> f64 {
    send(reader.get_mut(), "GET", "/metrics", "", "");
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

fn cohort(address: &str, repeats: usize, disconnect: bool, item_only: bool) {
    std::thread::scope(|scope| {
        let workers: Vec<_> = (0..8).map(|_| scope.spawn(move || {
            let mut reader = connection(address);
            if disconnect {
                reader.get_mut().write_all(b"POST /items HTTP/1.1\r\nhost: test\r\ncontent-length: 100\r\n\r\n{").unwrap();
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
                    if item_only && path != "/items/42" {
                        continue;
                    }
                    send(reader.get_mut(), method, path, headers, body);
                    assert_eq!(response(&mut reader), (code, expected.into()), "{method} {path}");
                }
                if !item_only {
                    assert!(metrics(&mut reader) > 0.0);
                }
            }
        })).collect();
        for worker in workers {
            worker.join().unwrap();
        }
    });
}

fn cancel_pending(server: &mut Observed) {
    let mut control = connection(&server.address);
    let baseline = metrics(&mut control);
    let mut pending = Vec::new();
    for _ in 0..7 {
        let mut reader = connection(&server.address);
        send(reader.get_mut(), "GET", "/slow?ms=60000", "", "");
        pending.push(reader);
    }
    let deadline = Instant::now() + Duration::from_secs(10);
    for polls in 1.. {
        if metrics(&mut control) == baseline + f64::from(polls) + 7.0 {
            break;
        }
        assert!(Instant::now() < deadline, "slow handlers did not enter");
        std::thread::sleep(Duration::from_millis(10));
    }
    drop(control);
    http_server_process::terminate(&server.child).unwrap();
    assert!(server.wait().success());
    // Shutdown's 3s grace expires before the handler's 5s timeout. All seven
    // incomplete requests must lose their connection; no successful slow reply.
    for mut reader in pending {
        let mut bytes = Vec::new();
        if let Err(error) = reader.read_to_end(&mut bytes) {
            assert_eq!(error.kind(), std::io::ErrorKind::ConnectionReset, "{error}");
        }
        assert!(!String::from_utf8_lossy(&bytes).contains("slept 60000 ms"));
    }
}

fn exercise(binary: &Path, artifact: PathBuf, variant: &str, item_only: bool) {
    let mut server = Observed::start(binary, artifact);
    cohort(&server.address, 1, false, item_only);
    server.checkpoint(8, true);
    cohort(&server.address, 4, false, item_only);
    server.checkpoint(16, variant == "healthy");
    if variant != "healthy" {
        assert_eq!(server.wait().code(), Some(241), "broken observer control");
        if let Some(reader) = server.reader.take() {
            reader.join().unwrap();
        }
        let log = server.log.lock().unwrap().clone();
        let diagnostic = if variant == "missing-count" {
            "http-allocation observation missing"
        } else {
            "http-memory changed"
        };
        assert!(log.contains(diagnostic), "{log}");
        return;
    }
    for (i, repeats) in [16, 1, 16, 4].into_iter().enumerate() {
        cohort(&server.address, repeats, false, item_only);
        server.checkpoint((i + 3) * 8, true);
    }
    cohort(&server.address, 0, true, item_only);
    server.checkpoint(56, true);
    cohort(&server.address, 1, false, item_only);
    server.checkpoint(64, true);
    verify_finish(&mut server);
}

fn verify_finish(server: &mut Observed) {
    cancel_pending(server);
    if let Some(reader) = server.reader.take() {
        reader.join().unwrap();
    }
    let log = server.log.lock().unwrap().clone();
    assert!(log.contains("http-shutdown\t1\n"), "{log}");
    assert!(log.contains("http-final\t72\t72\t0\t"), "{log}");
    assert!(log.ends_with("http-metrics-final\t0\n"), "{log}");
    let traffic: Vec<Vec<u64>> = log
        .lines()
        .filter_map(|line| line.strip_prefix("http-traffic\t"))
        .map(|line| {
            line.split('\t')
                .map(|value| value.parse().unwrap())
                .collect()
        })
        .collect();
    assert_eq!(traffic.len(), 9, "{log}");
    let idle: Vec<u64> = log
        .lines()
        .filter(|line| line.starts_with("http-memory\t"))
        .map(|line| line.split('\t').nth(3).unwrap().parse().unwrap())
        .collect();
    for (index, row) in traffic.iter().enumerate() {
        assert_eq!(row.len(), 5);
        assert_eq!(row[0], (index as u64 + 1) * 8);
        assert!(row[1] > 0 && row[2] >= row[3] && row[4] > 0, "{row:?}");
        assert_eq!(row[2] - row[3], if index < 8 { idle[index] } else { 0 });
        if index > 0 {
            assert!(
                row[1] > traffic[index - 1][1],
                "allocation count did not advance"
            );
            assert!(row[2] >= traffic[index - 1][2] && row[3] >= traffic[index - 1][3]);
            assert!(row[4] >= traffic[index - 1][4]);
        }
    }
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
        .args(["build", "--emit-c", opt])
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
        exercise(&binary, artifact, variant, false);
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
    cohort(&reference.addr, 1, false, false);
    cohort(&reference.addr, 0, true, false);
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

#[test]
fn api_allocation_observer_rejects_missing_counts_o2() {
    let temporary = fwp::cgen::TempDir::new("http-allocation-control").unwrap();
    let artifacts = std::env::var_os("FWP_HTTP_APPLICATION_ARTIFACTS")
        .map(PathBuf::from)
        .unwrap_or_else(|| temporary.join("evidence"))
        .join("allocation-controls");
    std::fs::create_dir_all(&artifacts).unwrap();
    let source = temporary.join("api.c");
    let output = Command::new(fwp())
        .args(["build", "--emit-c", "-O2"])
        .arg(example())
        .arg("-o")
        .arg(&source)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let observed = memory::instrument(&std::fs::read_to_string(source).unwrap());
    assert_eq!(observed.matches("#define HTTP_APP_OMIT_COUNT 0").count(), 1);
    let code = observed.replace(
        "#define HTTP_APP_OMIT_COUNT 0",
        "#define HTTP_APP_OMIT_COUNT 1",
    );
    let artifact = artifacts.join("missing-countO2");
    std::fs::write(artifact.with_extension("c"), &code).unwrap();
    let binary = artifact.with_extension("exe");
    fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
    exercise(&binary, artifact, "missing-count", false);
}

#[test]
fn api_item_allocation_traffic_o2() {
    let temporary = fwp::cgen::TempDir::new("http-item-traffic").unwrap();
    let artifacts = std::env::var_os("FWP_HTTP_APPLICATION_ARTIFACTS")
        .map(PathBuf::from)
        .unwrap_or_else(|| temporary.join("evidence"))
        .join("item-traffic");
    std::fs::create_dir_all(&artifacts).unwrap();
    let source = temporary.join("api.c");
    let output = Command::new(fwp())
        .args(["build", "--emit-c", "-O2"])
        .arg(example())
        .arg("-o")
        .arg(&source)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let code = memory::instrument(&std::fs::read_to_string(source).unwrap());
    let artifact = artifacts.join("apiO2");
    std::fs::write(artifact.with_extension("c"), &code).unwrap();
    let binary = artifact.with_extension("exe");
    fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
    exercise(&binary, artifact, "healthy", true);
}

fn pressure_header(reader: &mut BufReader<TcpStream>, expected: usize) {
    let mut line = String::new();
    reader.read_line(&mut line).unwrap();
    assert_eq!(line, "HTTP/1.1 200 OK\r\n");
    let mut length = None;
    loop {
        line.clear();
        assert!(reader.read_line(&mut line).unwrap() > 0);
        if line == "\r\n" {
            break;
        }
        let (name, value) = line.split_once(':').unwrap();
        assert!(!name.eq_ignore_ascii_case("transfer-encoding"));
        if name.eq_ignore_ascii_case("content-length") {
            assert!(length.is_none());
            length = Some(value.trim().parse::<usize>().unwrap());
        }
    }
    assert_eq!(length, Some(expected));
}

#[test]
fn api_slow_clients_release_backpressured_output_o2() {
    let temporary = fwp::cgen::TempDir::new("http-pressure").unwrap();
    let artifacts = std::env::var_os("FWP_HTTP_APPLICATION_ARTIFACTS")
        .map(PathBuf::from)
        .unwrap_or_else(|| temporary.join("evidence"))
        .join("pressure");
    std::fs::create_dir_all(&artifacts).unwrap();
    let original = std::fs::read_to_string(example()).unwrap();
    let route = "routes = http.router [";
    assert_eq!(original.matches(route).count(), 1);
    let source_text = original.replace(
        route,
        &format!("{route}\n    http.route \"GET\" \"/pressure/:bytes\" pressure,"),
    ) + r#"
pressure : Request -> Response ! {Async, IO, Network, FileIO, Error[HttpError]}
pressure =
    http.param "bytes"
    | option.and-then parse-int
    | or-fail { status = 400, message = "byte count required" }
    | flip string.repeat "x"
    | http.text 200
"#;
    let source = artifacts.join("api.fwp");
    std::fs::write(&source, source_text).unwrap();
    let emitted = temporary.join("api.c");
    let result = Command::new(fwp())
        .args(["build", "--emit-c", "-O2"])
        .arg(&source)
        .arg("-o")
        .arg(&emitted)
        .output()
        .unwrap();
    assert!(result.status.success(), "{result:?}");
    let mut code = memory::instrument(&std::fs::read_to_string(emitted).unwrap());
    for (before, after) in [
        ("    if (!c) { http_app_checkpoint(); return FWP_NONE; }",
         "    if (!c) { http_app_checkpoint(); return FWP_NONE; }\n    int pressure_buffer = 16384;\n    if (setsockopt(SOCK(c)->fd, SOL_SOCKET, SO_SNDBUF, (const char *)&pressure_buffer, (socklen_t)sizeof pressure_buffer)) abort();"),
        ("        if (k < 0 && (fwp_socket_again(errno))) {\n            if (!fwp_wait_fd(fd, ww, at)) return fwp_io_error(\"timeout\", \"write timed out\", err);",
         "        if (k < 0 && (fwp_socket_again(errno))) {\n            int pressure_errno = errno;\n            fprintf(stderr, \"http-wait-pressure-write\\n\"); fflush(stderr); errno = pressure_errno;\n            if (!fwp_wait_fd(fd, ww, at)) return fwp_io_error(\"timeout\", \"write timed out\", err);"),
        ("            k = fwp_socket_send(fd, STR(data)->d + off, len - off, MSG_NOSIGNAL);\n        if (k > 0)",
         "            k = fwp_socket_send(fd, STR(data)->d + off, len - off > 16384 ? 16384 : len - off, MSG_NOSIGNAL);\n        if (len >= 1048576 && (off == 0 || (k > 0 && off + (size_t)k == len))) { int saved = errno; fprintf(stderr, \"http-wait-pressure-send %zu/%zu %lld error=%d\\n\", off, len, (long long)k, k < 0 ? saved : 0); fflush(stderr); errno = saved; }\n        if (k > 0)"),
    ] {
        assert_eq!(code.matches(before).count(), 1, "{before}");
        code = code.replacen(before, after, 1);
    }
    let artifact = artifacts.join("apiO2");
    std::fs::write(artifact.with_extension("c"), &code).unwrap();
    let binary = artifact.with_extension("exe");
    fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
    let mut server = Observed::start(&binary, artifact);
    const BODY_BYTES: usize = 8 * 1024 * 1024;
    for round in 0..8 {
        if round == 6 {
            cohort(&server.address, 0, true, true);
            server.checkpoint(56, true);
            continue;
        }
        let mut large = connection(&server.address);
        // Constrain the unread client's buffering as well as the sender. A large
        // nonblocking Winsock send need not stop at the requested SO_SNDBUF size.
        // The diagnostic also limits each actual send above; the real would-block
        // branch and readiness wait must still occur before the client reads.
        #[cfg(windows)]
        {
            const SOL_SOCKET: i32 = 0xffff;
            const SO_RCVBUF: i32 = 0x1002;
            let requested = 256 * 1024_i32;
            let socket = large.get_ref().as_raw_socket();
            let mut size = std::mem::size_of_val(&requested) as i32;
            let result = unsafe {
                setsockopt(
                    socket,
                    SOL_SOCKET,
                    SO_RCVBUF,
                    (&requested as *const i32).cast(),
                    size,
                )
            };
            assert_eq!(result, 0, "pressure receive buffer: {}", unsafe {
                WSAGetLastError()
            });
            let mut actual = 0_i32;
            let result = unsafe {
                getsockopt(
                    socket,
                    SOL_SOCKET,
                    SO_RCVBUF,
                    (&mut actual as *mut i32).cast(),
                    &mut size,
                )
            };
            assert_eq!(result, 0, "read pressure receive buffer: {}", unsafe {
                WSAGetLastError()
            });
            assert_eq!(size, std::mem::size_of_val(&actual) as i32);
            assert_eq!(actual, requested);
        }
        let path = format!("/pressure/{BODY_BYTES}");
        if round == 1 {
            write!(large.get_mut(), "GET {path} HTTP/1.1\r\nhost:").unwrap();
        } else if round == 3 {
            large
                .get_mut()
                .write_all(b"POST /items HTTP/1.1\r\nhost: test\r\ncontent-length: 10000\r\n\r\n{")
                .unwrap();
        } else {
            send(large.get_mut(), "GET", &path, "", "");
        }
        let mut controls: Vec<_> = (0..7)
            .map(|_| {
                let mut reader = connection(&server.address);
                send(reader.get_mut(), "GET", "/items/42", "", "");
                assert_eq!(
                    response(&mut reader),
                    (200, "{\"id\":42,\"name\":\"item 42\"}".into())
                );
                reader
            })
            .collect();
        if round == 1 {
            large
                .get_mut()
                .write_all(b" test\r\ncontent-length: 0\r\n\r\n")
                .unwrap();
        }
        if round != 3 {
            let deadline = Instant::now() + Duration::from_secs(15);
            loop {
                let line = server
                    .lines
                    .recv_timeout(deadline.saturating_duration_since(Instant::now()))
                    .unwrap_or_else(|error| {
                        panic!(
                            "pressure round {round}: waiting for blocked write: {error}; {}",
                            server.log.lock().unwrap()
                        )
                    });
                if line == "http-wait-pressure-write" {
                    break;
                }
                assert!(line.starts_with("http-wait"), "{line}");
            }
            // Other requests must finish before the large response is consumed.
            send(controls[0].get_mut(), "GET", "/items/42", "", "");
            assert_eq!(
                response(&mut controls[0]),
                (200, "{\"id\":42,\"name\":\"item 42\"}".into())
            );
            pressure_header(&mut large, BODY_BYTES);
            let mut remaining = if matches!(round, 2 | 5) {
                32768
            } else {
                BODY_BYTES
            };
            let deadline = Instant::now() + Duration::from_secs(30);
            let mut buffer = [0; 32768];
            while remaining > 0 {
                assert!(Instant::now() < deadline, "pressure response deadline");
                large
                    .get_mut()
                    .set_read_timeout(Some(deadline.saturating_duration_since(Instant::now())))
                    .unwrap();
                let count = remaining.min(buffer.len());
                large.read_exact(&mut buffer[..count]).unwrap();
                assert!(buffer[..count].iter().all(|byte| *byte == b'x'));
                remaining -= count;
                if round == 4 && remaining == BODY_BYTES - buffer.len() {
                    send(controls[0].get_mut(), "GET", "/items/42", "", "");
                    assert_eq!(
                        response(&mut controls[0]),
                        (200, "{\"id\":42,\"name\":\"item 42\"}".into())
                    );
                }
            }
        }
        drop(large);
        drop(controls);
        server.checkpoint((round + 1) * 8, true);
    }
    verify_finish(&mut server);
}

// Diagnostic entry only: exercise an explicitly selected saved executable.
// It does not replace the ordinary tests that compile this revision.
#[test]
#[ignore = "requires a saved native API binary and a fresh artifact directory"]
fn api_saved_binary_idle_memory() {
    let binary = PathBuf::from(std::env::var_os("FWP_HTTP_APPLICATION_BINARY").unwrap());
    let artifacts = PathBuf::from(std::env::var_os("FWP_HTTP_APPLICATION_ARTIFACTS").unwrap());
    std::fs::create_dir(&artifacts).unwrap();
    exercise(&binary, artifacts.join("api-saved"), "healthy", false);
}

#[test]
fn client_socket_closes_while_another_child_runs() {
    let listener = TcpListener::bind("127.0.0.1:0").unwrap();
    let client = connection(&listener.local_addr().unwrap().to_string());
    let (mut peer, _) = listener.accept().unwrap();
    peer.set_read_timeout(Some(Duration::from_secs(2))).unwrap();
    let mut command = Command::new(std::env::current_exe().unwrap());
    command
        .args([
            "--exact",
            "http_server_process::tests::child",
            "--nocapture",
        ])
        .env("FWP_HTTP_STARTUP_CHILD", "ready");
    let mut unrelated = super::start(command);
    drop(client);
    let closed = peer.read(&mut [0]);
    assert!(unrelated.child.try_wait().unwrap().is_none());
    assert_eq!(
        closed.unwrap(),
        0,
        "another child retained the client socket"
    );
}
