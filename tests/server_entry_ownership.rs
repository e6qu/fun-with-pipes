//! Generated REST/MCP entries must preserve values and release request owners.
use fwp::json::Json;
use std::io::{BufRead, BufReader, Write};
use std::net::{Shutdown, TcpStream};
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Output, Stdio};
use std::sync::mpsc::{self, Receiver};
use std::thread::JoinHandle;
use std::time::{Duration, Instant};

#[path = "support/client_allocations.rs"]
mod client_allocations;

#[path = "support/process_memory.rs"]
mod process_memory;

fn fixture() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/server_entries.fwp")
}

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn generated(dir: &Path, interface: &str, mode: &str, free: bool) -> String {
    let name = interface.trim_start_matches("--");
    let path = dir.join(format!("{name}-{mode}-{free}.c"));
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", interface, "--gc", mode, "--emit-c", "-o"])
            .arg(&path)
            .arg(fixture())
            .env("FWP_FREE", if free { "1" } else { "0" }),
    );
    let source = std::fs::read_to_string(path).unwrap();
    assert_eq!(source.contains("#define FWP_ARC_ONLY 1"), mode == "arc");
    source
}

fn run_input(command: &mut Command, input: String) -> Output {
    let mut child = command
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let mut stdin = child.stdin.take().unwrap();
    // Drain output while writing: repeated replies can exceed a pipe's capacity.
    let writer = std::thread::spawn(move || stdin.write_all(input.as_bytes()));
    let output = child.wait_with_output().unwrap();
    writer.join().unwrap().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn request(id: u64, method: &str, parameters: &str) -> String {
    format!(
        "{{\"jsonrpc\":\"2.0\",\"id\":{id},\"method\":\"{method}\",\"params\":{{\"_meta\":{{\"io.modelcontextprotocol/protocolVersion\":\"{}\"}},{parameters}}}}}\n",
        fwp::mcp::VERSION
    )
}

fn tool(id: u64, name: &str, arguments: &str) -> String {
    request(
        id,
        "tools/call",
        &format!("\"name\":\"{name}\",\"arguments\":{arguments}"),
    )
}

fn input(repeats: usize) -> String {
    let mut input = String::new();
    for repetition in 0..repeats {
        let id = repetition as u64 * 8;
        input.push_str(&tool(
            id,
            "copy",
            r#"{"text":"owned é","values":[1,-2,9007199254740993]}"#,
        ));
        input.push_str(&tool(
            id + 1,
            "duplicate",
            r#"{"text":"aliased","values":[4,5]}"#,
        ));
        input.push_str(&tool(id + 2, "checked", r#"{"input":7}"#));
        input.push_str(&tool(id + 3, "checked", r#"{"input":0}"#));
        input.push_str(&tool(id + 4, "outcome", r#"{"input":0}"#));
        input.push_str(&tool(id + 5, "copy", r#"{"text":9,"values":[]}"#));
        input.push_str("{broken JSON\n");
        input.push_str(&request(id + 7, "unknown/method", "\"unused\":true"));
        input.push_str("\n{\"jsonrpc\":\"2.0\",\"method\":\"notifications/cancelled\"}\n");
    }
    input
}

fn assert_replies(output: &Output, repeats: usize) {
    let text = String::from_utf8_lossy(&output.stdout);
    let replies: Vec<_> = text
        .lines()
        .map(|line| Json::parse(line).unwrap())
        .collect();
    assert_eq!(replies.len(), repeats * 8, "{text}");
    for (repetition, replies) in replies.as_chunks::<8>().0.iter().enumerate() {
        for (index, reply) in replies.iter().enumerate() {
            let expected = if index == 6 {
                Json::Null
            } else {
                Json::Num((repetition * 8 + index).to_string())
            };
            assert_eq!(reply.get("id"), Some(&expected), "{reply:?}");
        }
        assert_eq!(
            replies[0].at(&["result", "structuredContent"]),
            Some(&Json::parse(r#"{"text":"owned é","values":[1,-2,9007199254740993]}"#).unwrap())
        );
        assert_eq!(
            replies[1].at(&["result", "structuredContent", "result"]),
            Some(
                &Json::parse(
                    r#"[{"text":"aliased","values":[4,5]},{"text":"aliased","values":[4,5]}]"#
                )
                .unwrap()
            )
        );
        assert_eq!(
            replies[2]
                .at(&["result", "structuredContent", "result"])
                .and_then(Json::as_str),
            Some("value 7")
        );
        for reply in &replies[3..6] {
            assert_eq!(
                reply.at(&["result", "isError"]),
                Some(&Json::Bool(true)),
                "{reply:?}"
            );
        }
        assert_eq!(
            replies[6].at(&["error", "code"]),
            Some(&Json::Num("-32700".into()))
        );
        assert_eq!(
            replies[7].at(&["error", "code"]),
            Some(&Json::Num("-32601".into()))
        );
    }
}

fn precision_input() -> String {
    let arguments = r#"{"unsigned":18446744073709551615,"wide":-170141183460469231731687303715884105728,"u-wide":340282366920938463463374607431768211455,"precise":9.007199254740993e15,"precise-near-one":1.0000000000000000000000000000007889}"#;
    tool(9007199254740993, "exact", arguments) + &tool(9007199254740994, "exact-failure", arguments)
}

fn assert_precision_replies(output: &Output) {
    let text = String::from_utf8_lossy(&output.stdout);
    let replies: Vec<_> = text
        .lines()
        .map(|line| Json::parse(line).unwrap())
        .collect();
    assert_eq!(replies.len(), 2, "{text}");
    for (reply, id) in replies.iter().zip(["9007199254740993", "9007199254740994"]) {
        assert_eq!(reply.get("id"), Some(&Json::Num(id.into())));
    }
    let expected = Json::parse(r#"{"unsigned":18446744073709551615,"wide":"-170141183460469231731687303715884105728","u-wide":"340282366920938463463374607431768211455","precise":9.007199254740993e15,"precise-near-one":1.0000000000000000000000000000007889}"#).unwrap();
    assert_eq!(
        replies[0].at(&["result", "structuredContent"]),
        Some(&expected)
    );
    assert_eq!(
        replies[1].at(&["result", "isError"]),
        Some(&Json::Bool(true))
    );
    let content = replies[1]
        .at(&["result", "content"])
        .and_then(Json::as_array)
        .unwrap();
    let error = content[0].get("text").and_then(Json::as_str).unwrap();
    assert_eq!(Json::parse(error).unwrap(), expected);
}

#[test]
fn exact_json_and_csv_values_and_traps_match_in_all_memory_modes() {
    let dir = fwp::cgen::TempDir::new("entry-numeric-codecs").unwrap();
    let root = Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/run");
    for name in [
        "json_exact_numbers",
        "rest_csv_numbers",
        "trap_json_number",
        "trap_json_typed_number",
        "trap_json_depth",
    ] {
        let source = root.join(format!("{name}.fwp"));
        let expected = std::fs::read_to_string(source.with_extension("out")).unwrap();
        let compare = |label: &str, output: Output| {
            let mut actual = String::from_utf8(output.stdout).unwrap();
            if !output.stderr.is_empty() {
                actual.push_str("--- stderr\n");
                actual.push_str(&String::from_utf8(output.stderr).unwrap());
            }
            let code = output.status.code().expect("codec process exited normally");
            if code != 0 {
                actual.push_str(&format!("--- exit {code}\n"));
            }
            assert_eq!(actual, expected, "{name}: {label}");
        };
        compare(
            "raw interpreter",
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["run", "--interp"])
                .arg(&source)
                .env("FWP_NO_OPT", "1")
                .output()
                .unwrap(),
        );
        for (mode, opt) in [("arc", "-O2"), ("tracing", "-O1"), ("tracing", "-O2")] {
            let exe = dir.join(format!("{name}-{mode}-{opt}.exe"));
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .args(["build", "--gc", mode, opt, "-o"])
                    .arg(&exe)
                    .arg(&source),
            );
            let stress = if mode == "tracing" { "1" } else { "0" };
            compare(
                &format!("{mode} {opt}"),
                Command::new(&exe)
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress)
                    .output()
                    .unwrap(),
            );
        }
    }
}

#[test]
fn mcp_stdio_aliases_errors_and_notifications_match_raw_interpreter() {
    let dir = fwp::cgen::TempDir::new("mcp-entry").unwrap();
    eprintln!("MCP entries: raw interpreter reference");
    let reference = run_input(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["serve", "--mcp", "--interp"])
            .arg(fixture())
            .env("FWP_NO_OPT", "1"),
        input(2),
    );
    assert_replies(&reference, 2);
    let precise = run_input(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["serve", "--mcp", "--interp"])
            .arg(fixture())
            .env("FWP_NO_OPT", "1"),
        precision_input(),
    );
    assert_precision_replies(&precise);
    for mode in ["tracing", "arc"] {
        eprintln!("MCP entries: {mode} native result and alias checks");
        let source = generated(dir.path(), "--mcp", mode, true);
        let binary = dir.join(format!("mcp-{mode}.exe"));
        fwp::cgen::compile_c(&source, &binary, "-O1").unwrap();
        let stress = if mode == "tracing" { "16" } else { "0" };
        let result = run_input(
            Command::new(&binary)
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", if mode == "tracing" { "1" } else { "0" })
                .env(
                    "FWP_REUSE_VERIFY",
                    if mode == "tracing" { "1" } else { "0" },
                ),
            input(2),
        );
        assert_eq!(result.stdout, reference.stdout, "{mode}");
        assert!(result.stderr.is_empty(), "{mode}: {result:?}");
        let result = run_input(
            Command::new(&binary)
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", if mode == "tracing" { "1" } else { "0" })
                .env(
                    "FWP_REUSE_VERIFY",
                    if mode == "tracing" { "1" } else { "0" },
                ),
            precision_input(),
        );
        assert_eq!(result.stdout, precise.stdout, "{mode} precision");
        assert_precision_replies(&result);
    }
}

#[test]
fn generated_entries_accept_proved_functions_and_reject_channel_captures() {
    let dir = fwp::cgen::TempDir::new("entry-cycle").unwrap();
    let source = dir.join("cycle.fwp");
    for interface in ["--rest", "--mcp"] {
        std::fs::write(
            &source,
            r#"callbacks : I64 -> Channel[I64 -> I64] ! {Async}
callbacks = channel.make
# expose: rest, mcp
export queued : I64 -> I64 ! {Async}
queued = both id (const 1 | callbacks)
    | tap (fork channel.send .1 (.0 | add))
    | .1
    | channel.recv
    | option.map (apply 5)
    | option.unwrap-or 0
"#,
        )
        .unwrap();
        let cfile = dir.join("accepted.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", interface, "--emit-c", "-o"])
                .arg(&cfile)
                .arg(&source),
        );
        if interface == "--mcp" {
            let code = std::fs::read_to_string(&cfile).unwrap();
            let binary = dir.join("queued.exe");
            fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
            let result = run_input(
                Command::new(binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
                tool(7, "queued", r#"{"input":3}"#),
            );
            let reply = Json::parse(String::from_utf8_lossy(&result.stdout).trim()).unwrap();
            assert_eq!(
                reply.at(&["result", "structuredContent", "result"]),
                Some(&Json::Num("8".into())),
                "{reply:?}"
            );
        }
        std::fs::write(
            &source,
            r#"callbacks : I64 -> Channel[() -> () ! {Async}] ! {Async}
callbacks = channel.make
keep : Channel[() -> () ! {Async}] -> () -> () ! {Async}
keep = then2 const channel.close
send-self = fork channel.send id keep
# expose: rest, mcp
export rejected : () -> () ! {Async}
rejected = const 1 | callbacks | tap send-self | channel.recv | option.map (apply ()) | ignore
"#,
        )
        .unwrap();
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", interface, "--emit-c", "-o"])
            .arg(dir.join("rejected.c"))
            .arg(&source)
            .output()
            .unwrap();
        assert!(!output.status.success());
        let error = String::from_utf8_lossy(&output.stderr);
        assert!(
            error.contains("ownership:") && error.contains("queued function's captured"),
            "{interface}: {error}"
        );
    }
}

fn headers(interface: &str, name: &str) -> Vec<(String, String)> {
    let mut headers = vec![("content-type".into(), "application/json".into())];
    if interface == "mcp" {
        headers.extend([
            ("MCP-Protocol-Version".into(), fwp::mcp::VERSION.into()),
            ("Mcp-Method".into(), "tools/call".into()),
            ("Mcp-Name".into(), name.into()),
        ]);
    }
    headers
}

fn http_body(interface: &str, name: &str, argument: &str) -> String {
    if interface == "mcp" {
        tool(1, name, argument)
    } else {
        argument.into()
    }
}

fn path(interface: &str, name: &str) -> String {
    if interface == "mcp" {
        "/mcp".into()
    } else {
        format!("/{name}")
    }
}

fn client_source(interface: &str) -> String {
    let quote = |s: &str| Json::Str(s.into()).to_string();
    let mut source = include_str!("fixtures/server_entry_client.fwp").to_owned();
    source.push_str("\ncases : List[Case]\ncases = [\n");
    for (name, argument) in [
        (
            "copy",
            r#"{"text":"owned é","values":[1,-2,9007199254740993]}"#,
        ),
        ("duplicate", r#"{"text":"aliased","values":[4,5]}"#),
        (
            "checked",
            if interface == "mcp" {
                r#"{"input":0}"#
            } else {
                "0"
            },
        ),
    ] {
        let headers = headers(interface, name)
            .iter()
            .map(|(key, value)| format!("({}, {})", quote(key), quote(value)))
            .collect::<Vec<_>>()
            .join(", ");
        source.push_str(&format!(
            "    Case {{ path = {}, headers = [{headers}], body = {} }},\n",
            quote(&path(interface, name)),
            quote(&http_body(interface, name, argument))
        ));
    }
    source.push_str("]\n");
    source
}

fn certificate(dir: &Path) {
    checked(
        Command::new("openssl")
            .args([
                "req",
                "-x509",
                "-newkey",
                "rsa:2048",
                "-nodes",
                "-days",
                "2",
                "-subj",
                "/CN=localhost",
                "-addext",
                "subjectAltName=DNS:localhost,IP:127.0.0.1",
                "-keyout",
                "server.key",
                "-out",
                "server.pem",
            ])
            .current_dir(dir),
    );
}

struct HttpServer {
    child: Child,
    addr: String,
    interface: &'static str,
    tls: bool,
    lines: Receiver<String>,
    log: Option<JoinHandle<String>>,
}

impl Drop for HttpServer {
    fn drop(&mut self) {
        let _ = self.child.kill();
        let _ = self.child.wait();
        if let Some(log) = self.log.take() {
            let _ = log.join();
        }
    }
}

impl HttpServer {
    fn start(command: &mut Command, interface: &'static str, tls: bool, cert: &Path) -> Self {
        assert!(!tls || interface == "rest", "MCP exposes plain HTTP only");
        command.args(["--listen", "127.0.0.1:0"]);
        if tls {
            command
                .arg("--tls-cert")
                .arg(cert.join("server.pem"))
                .arg("--tls-key")
                .arg(cert.join("server.key"));
        }
        let description = format!("{command:?}");
        let began = Instant::now();
        let mut child = command
            .stdout(Stdio::null())
            .stderr(Stdio::piped())
            .spawn()
            .unwrap();
        let stderr = child.stderr.take().unwrap();
        let (sender, lines) = mpsc::channel();
        let log = std::thread::spawn(move || {
            let mut log = String::new();
            for line in BufReader::new(stderr).lines() {
                let line = line.unwrap();
                log.push_str(&line);
                log.push('\n');
                let _ = sender.send(line);
            }
            log
        });
        let mut server = Self {
            child,
            addr: String::new(),
            interface,
            tls,
            lines,
            log: Some(log),
        };
        let announcement = match server.lines.recv_timeout(Duration::from_secs(30)) {
            Ok(line) => line,
            Err(error) => {
                let _ = server.child.kill();
                let _ = server.child.wait();
                let log = server.log.take().unwrap().join().unwrap();
                panic!("server announcement after {:?}: {error}; command: {description}; stderr: {log}", began.elapsed());
            }
        };
        let prefix = format!(
            "fwp: {interface} listening on {}://",
            if tls { "https" } else { "http" }
        );
        let address = announcement
            .strip_prefix(&prefix)
            .unwrap_or_else(|| panic!("{announcement}"));
        server.addr = if interface == "mcp" {
            address.strip_suffix("/mcp").expect("MCP path").into()
        } else {
            address.into()
        };
        server
    }

    fn base(&self) -> String {
        format!(
            "{}://{}",
            if self.tls { "https" } else { "http" },
            self.addr
        )
    }

    fn call(&self, cert: &Path, name: &str, argument: &str) -> (u16, Json) {
        let mut command =
            Command::new(std::env::var("FWP_TEST_CURL").unwrap_or_else(|_| "curl".into()));
        command
            .args([
                "--silent",
                "--show-error",
                "--max-time",
                "20",
                "--http1.1",
                "--cacert",
            ])
            .arg(cert.join("server.pem"));
        for (name, value) in headers(self.interface, name) {
            command.args(["--header", &format!("{name}: {value}")]);
        }
        let output = checked(
            command
                .args([
                    "--data-binary",
                    &http_body(self.interface, name, argument),
                    "--write-out",
                    "\n%{http_code}",
                ])
                .arg(format!("{}{}", self.base(), path(self.interface, name))),
        );
        let text = String::from_utf8(output.stdout).unwrap();
        let (body, status) = text.rsplit_once('\n').unwrap();
        (status.parse().unwrap(), Json::parse(body).unwrap())
    }

    fn cancel_handler(&mut self) {
        assert!(!self.tls);
        let mut connection = TcpStream::connect(&self.addr).unwrap();
        connection
            .set_write_timeout(Some(Duration::from_secs(10)))
            .unwrap();
        let body = http_body(
            self.interface,
            "slow",
            r#"{"text":"cancelled alias","values":[1,2,3]}"#,
        );
        let headers = headers(self.interface, "slow")
            .iter()
            .map(|(key, value)| format!("{key}: {value}\r\n"))
            .collect::<String>();
        write!(connection, "POST {} HTTP/1.1\r\nhost: test\r\nconnection: close\r\n{headers}content-length: {}\r\n\r\n{body}",
            path(self.interface, "slow"), body.len()).unwrap();
        // The handler announces that it owns the decoded input before waiting.
        // Disconnect only after this marker, so the case cannot pass without
        // entering the handler and exercising its live decoded aliases.
        let marker = self
            .lines
            .recv_timeout(Duration::from_secs(30))
            .expect("handler started");
        assert_eq!(marker, "entry waiting");
        connection.shutdown(Shutdown::Both).unwrap();
    }

    fn stop(mut self, cert: &Path) -> String {
        let (status, reply) = self.call(cert, "stop", "{}");
        assert_eq!(status, 200);
        let result = if self.interface == "mcp" {
            reply
                .at(&["result", "structuredContent", "result"])
                .unwrap()
        } else {
            &reply
        };
        assert_eq!(result.as_str(), Some("stopping"));
        let until = Instant::now() + Duration::from_secs(30);
        loop {
            if let Some(status) = self.child.try_wait().unwrap() {
                let log = self.log.take().unwrap().join().unwrap();
                assert!(status.success(), "{status}: {log}");
                return log;
            }
            assert!(Instant::now() < until, "server failed to finish normally");
            std::thread::sleep(Duration::from_millis(20));
        }
    }
}

fn exercise_http(server: &HttpServer, cert: &Path) -> Vec<(u16, Json)> {
    let mut replies = Vec::new();
    for (name, arguments) in [
        (
            "copy",
            r#"{"text":"owned é","values":[1,-2,9007199254740993]}"#,
        ),
        ("duplicate", r#"{"text":"aliased","values":[4,5]}"#),
        (
            "checked",
            if server.interface == "mcp" {
                r#"{"input":0}"#
            } else {
                "0"
            },
        ),
    ] {
        replies.push(server.call(cert, name, arguments));
    }
    let payload = Json::parse(r#"{"text":"owned é","values":[1,-2,9007199254740993]}"#).unwrap();
    let duplicates =
        Json::parse(r#"[{"text":"aliased","values":[4,5]},{"text":"aliased","values":[4,5]}]"#)
            .unwrap();
    assert_eq!(replies[0].0, 200);
    assert_eq!(replies[1].0, 200);
    if server.interface == "rest" {
        assert_eq!(replies[0].1, payload);
        assert_eq!(replies[1].1, duplicates);
        assert_eq!(
            replies[2],
            (500, Json::parse(r#"{"error":"zero"}"#).unwrap())
        );
    } else {
        assert_eq!(
            replies[0].1.at(&["result", "structuredContent"]),
            Some(&payload)
        );
        assert_eq!(
            replies[1].1.at(&["result", "structuredContent", "result"]),
            Some(&duplicates)
        );
        assert_eq!(replies[2].0, 200);
        assert_eq!(
            replies[2].1.at(&["result", "isError"]),
            Some(&Json::Bool(true))
        );
    }
    replies
}

#[test]
fn generated_http_entries_preserve_results_and_disconnected_handler_owners() {
    let dir = fwp::cgen::TempDir::new("http-entries").unwrap();
    certificate(dir.path());
    for interface in ["rest", "mcp"] {
        let flag = format!("--{interface}");
        let mut references = Vec::new();
        for tls in [false, true]
            .into_iter()
            .filter(|tls| !tls || interface == "rest")
        {
            eprintln!("{interface} HTTP: raw interpreter, TLS={tls}");
            let mut server = HttpServer::start(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .args(["serve", &flag, "--interp"])
                    .arg(fixture())
                    .env("FWP_NO_OPT", "1"),
                interface,
                tls,
                dir.path(),
            );
            let replies = exercise_http(&server, dir.path());
            if !tls {
                server.cancel_handler();
            }
            assert_eq!(exercise_http(&server, dir.path()), replies);
            server.stop(dir.path());
            references.push((tls, replies));
        }
        for mode in ["tracing", "arc"] {
            eprintln!("{interface} HTTP: building {mode}");
            let code = generated(dir.path(), &flag, mode, true);
            let binary = dir.join(format!("{interface}-{mode}.exe"));
            fwp::cgen::compile_c(&code, &binary, "-O1").unwrap();
            for (tls, replies) in &references {
                let mut server = HttpServer::start(
                    Command::new(&binary)
                        .env("FWP_GC_STRESS", if mode == "tracing" { "16" } else { "0" })
                        .env("FWP_GC_VERIFY", if mode == "tracing" { "1" } else { "0" })
                        .env(
                            "FWP_REUSE_VERIFY",
                            if mode == "tracing" { "1" } else { "0" },
                        ),
                    interface,
                    *tls,
                    dir.path(),
                );
                assert_eq!(
                    &exercise_http(&server, dir.path()),
                    replies,
                    "{interface}/{mode}/{tls}"
                );
                if !tls {
                    server.cancel_handler();
                }
                assert_eq!(&exercise_http(&server, dir.path()), replies);
                server.stop(dir.path());
            }
        }
    }
}

#[test]
#[ignore = "runner-only REST/MCP HTTP managed-memory and resident-memory measurement"]
#[cfg(any(target_os = "linux", target_os = "macos", windows))]
fn generated_http_entries_release_requests_and_bound_process_memory() {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let interface = match std::env::var("FWP_ENTRY_INTERFACE").as_deref() {
        Ok("rest") => "rest",
        Ok("mcp") => "mcp",
        value => panic!("FWP_ENTRY_INTERFACE must select rest or mcp: {value:?}"),
    };
    let artifacts =
        PathBuf::from(std::env::var_os("FWP_SERVER_ENTRY_ARTIFACTS").expect("entry artifacts"))
            .join("http");
    std::fs::create_dir_all(&artifacts).unwrap();
    certificate(&artifacts);
    std::fs::copy(fixture(), artifacts.join("server_entries.fwp")).unwrap();
    std::fs::write(artifacts.join("scope.txt"), "Generated REST (HTTP/TLS) and MCP (HTTP) servers at one revision, tracing versus checked ARC, with collection disabled and counted freeing enabled. An ordinary native ARC client makes three sequential pooled HTTP/2 requests per cycle: a copied record, duplicate aliases of a record, and a caught error. It prints every response status and body. A raw-interpreter server establishes output for each transport, then ordinary and instrumented native servers must match it. Managed counters cover startup after constant initialization through normal entry and cached-value cleanup; include 1/16/128 request cycles and one HTTP/1.1 shutdown request, with three fresh measured processes per case. Raw transport/TLS/OS storage, allocator metadata and client memory are excluded. Separately, ordinary persistent servers process five batches of 1024 cycles (3072 requests per batch), with a fresh client per batch; the 1000-request connection limit exercises replacement. After each client exits and 100 ms settling, Linux VmRSS/macOS ps RSS/Windows WorkingSet64 is sampled. The first batch warms caches; later samples must stay less than 8 MiB above it. These samples are not peak process memory. Native -O2, ordinary fwp optimization and separate floating multiplication/addition rounding. No timing or C/Rust parity claim.\n").unwrap();
    let mut rows = String::from("interface\tmode\ttls\tcycles\trepetition\trequests\trequested_bytes\tretains\tpeak_bytes\tfinal_bytes\n");
    let mut rss = String::from("interface\tmode\ttls\tbatch\tcumulative_requests\trss_kib\n");
    let flag = format!("--{interface}");
    let client_file = artifacts.join(format!("client-{interface}.fwp"));
    std::fs::write(&client_file, client_source(interface)).unwrap();
    let client_c = client_file.with_extension("c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c", "-o"])
            .arg(&client_c)
            .arg(&client_file),
    );
    let client = client_file.with_extension("exe");
    fwp::cgen::compile_c(&std::fs::read_to_string(client_c).unwrap(), &client, "-O2").unwrap();
    let run_client = |server: &HttpServer, cycles: usize| {
        checked(
            Command::new(&client)
                .arg(cycles.to_string())
                .env("FWP_BASE", server.base())
                .env("SSL_CERT_FILE", artifacts.join("server.pem"))
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0"),
        )
        .stdout
    };
    let mut references = Vec::new();
    for tls in [false, true]
        .into_iter()
        .filter(|tls| !tls || interface == "rest")
    {
        let server = HttpServer::start(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["serve", &flag, "--interp"])
                .arg(fixture())
                .env("FWP_NO_OPT", "1"),
            interface,
            tls,
            &artifacts,
        );
        let expected = run_client(&server, 1);
        assert_eq!(expected.iter().filter(|b| **b == b'\n').count(), 3);
        server.stop(&artifacts);
        references.push((tls, expected));
    }
    for mode in ["tracing", "arc"] {
        eprintln!("entry HTTP memory: build {interface}/{mode}");
        let code = generated(&artifacts, &flag, mode, true);
        let ordinary = artifacts.join(format!("{interface}-{mode}-true.exe"));
        fwp::cgen::compile_c(&code, &ordinary, "-O2").unwrap();
        let counted_code = client_allocations::instrument_client_allocations(&code);
        let counted = artifacts.join(format!("{interface}-{mode}-measured.exe"));
        std::fs::write(counted.with_extension("c"), &counted_code).unwrap();
        fwp::cgen::compile_c(&counted_code, &counted, "-O2").unwrap();
        for (tls, reference) in &references {
            let launch = |binary: &Path| {
                HttpServer::start(
                    Command::new(binary)
                        .env("FWP_GC", "off")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                    interface,
                    *tls,
                    &artifacts,
                )
            };
            let mut final_bytes = None;
            for cycles in [1, 16, 128] {
                let expected = reference.repeat(cycles);
                let server = launch(&ordinary);
                assert_eq!(run_client(&server, cycles), expected);
                server.stop(&artifacts);
                for repetition in 0..3 {
                    eprintln!("entry HTTP memory: {interface}/{mode}/TLS={tls}, cycles={cycles}, sample={repetition}");
                    let server = launch(&counted);
                    assert_eq!(run_client(&server, cycles), expected);
                    let stderr = server.stop(&artifacts);
                    std::fs::write(
                        artifacts.join(format!(
                            "{interface}-{mode}-{tls}-{cycles}-{repetition}.stderr"
                        )),
                        &stderr,
                    )
                    .unwrap();
                    let reports: Vec<_> = stderr
                        .lines()
                        .filter_map(|line| line.strip_prefix("client-memory\t"))
                        .collect();
                    assert_eq!(reports.len(), 1);
                    let counters: Vec<u64> =
                        reports[0].split('\t').map(|n| n.parse().unwrap()).collect();
                    assert_eq!(counters.len(), 5);
                    assert!(counters[0] > 0 && counters[3] >= counters[4]);
                    assert_eq!(
                        *final_bytes.get_or_insert(counters[4]),
                        counters[4],
                        "{interface}/{mode}/{tls}/{cycles}"
                    );
                    rows.push_str(&format!(
                        "{interface}\t{mode}\t{tls}\t{cycles}\t{repetition}\t{}\n",
                        reports[0]
                    ));
                    std::fs::write(artifacts.join("memory.tsv"), &rows).unwrap();
                }
            }
            let server = launch(&ordinary);
            let mut warm = None;
            for batch in 0..5 {
                assert_eq!(run_client(&server, 1024), reference.repeat(1024));
                std::thread::sleep(Duration::from_millis(100));
                let resident = process_memory::process_rss_kib(server.child.id());
                assert!(resident > 0);
                assert!(
                    resident < *warm.get_or_insert(resident) + 8192,
                    "{interface}/{mode}/{tls}: RSS {resident}, warm {warm:?}"
                );
                rss.push_str(&format!(
                    "{interface}\t{mode}\t{tls}\t{batch}\t{}\t{resident}\n",
                    (batch + 1) * 3072
                ));
                std::fs::write(artifacts.join("rss.tsv"), &rss).unwrap();
            }
            server.stop(&artifacts);
        }
    }
}

#[test]
#[ignore = "runner-only repeated generated-entry memory measurement"]
fn mcp_stdio_releases_repeated_requests_without_collection() {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let artifacts =
        PathBuf::from(std::env::var_os("FWP_SERVER_ENTRY_ARTIFACTS").expect("entry artifacts"));
    std::fs::create_dir_all(&artifacts).unwrap();
    std::fs::copy(fixture(), artifacts.join("server_entries.fwp")).unwrap();
    std::fs::write(artifacts.join("scope.txt"), "Repeated generated MCP standard-input server, same fixture and messages in tracing and checked ARC. One, 16 or 128 repetitions of eight replies: returned record, duplicated record aliases, successful value, caught error, explicit error result, invalid typed input, malformed JSON, and unknown method; blank lines and notifications produce no reply. Ordinary -O2 servers validate every response before the allocation-instrumented server is compared byte for byte. Collection is disabled and counted freeing enabled except in the explicit tracing build with FWP_FREE=0, which must demonstrate increasing retained storage. Managed allocation requests, payload bytes, actual count increments and peak/final charged storage cover constant initialization completion through main and cached-value cleanup, before whole-runtime disposal. Raw buffers, OS storage, allocator metadata and process RSS are excluded. No elapsed-time or C/Rust comparison.\n").unwrap();
    let mut rows = String::from(
        "mode\tfree\trepeats\trequests\trequested_bytes\tretains\tpeak_bytes\tfinal_bytes\n",
    );
    let mut finals = Vec::new();
    for (mode, free) in [("tracing", true), ("arc", true), ("tracing", false)] {
        eprintln!("MCP memory: build {mode}, counted freeing={free}");
        let source = generated(&artifacts, "--mcp", mode, free);
        let ordinary = artifacts.join(format!("mcp-{mode}-{free}.exe"));
        fwp::cgen::compile_c(&source, &ordinary, "-O2").unwrap();
        let measured = client_allocations::instrument_client_allocations(&source);
        let binary = artifacts.join(format!("mcp-measured-{mode}-{free}.exe"));
        std::fs::write(binary.with_extension("c"), &measured).unwrap();
        fwp::cgen::compile_c(&measured, &binary, "-O2").unwrap();
        let mut case_finals = Vec::new();
        for repeats in [1, 16, 128] {
            eprintln!("MCP memory: {mode}, counted freeing={free}, repetitions={repeats}");
            let run = |path: &Path| {
                run_input(
                    Command::new(path)
                        .env("FWP_GC", "off")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                    input(repeats),
                )
            };
            let expected = run(&ordinary);
            assert_replies(&expected, repeats);
            let output = run(&binary);
            assert_eq!(output.stdout, expected.stdout);
            let stderr = String::from_utf8(output.stderr).unwrap();
            std::fs::write(
                artifacts.join(format!("mcp-{mode}-{free}-{repeats}.stderr")),
                &stderr,
            )
            .unwrap();
            let counters: Vec<u64> = stderr
                .lines()
                .find_map(|line| line.strip_prefix("client-memory\t"))
                .expect("memory counters")
                .split('\t')
                .map(|n| n.parse().unwrap())
                .collect();
            assert_eq!(counters.len(), 5);
            assert!(counters[3] >= counters[4]);
            case_finals.push(counters[4]);
            rows.push_str(&format!(
                "{mode}\t{free}\t{repeats}\t{}\n",
                counters
                    .iter()
                    .map(u64::to_string)
                    .collect::<Vec<_>>()
                    .join("\t")
            ));
            std::fs::write(artifacts.join("mcp-stdio-memory.tsv"), &rows).unwrap();
        }
        if free {
            assert!(
                case_finals.windows(2).all(|pair| pair[0] == pair[1]),
                "{mode}: {case_finals:?}"
            );
        } else {
            assert!(
                case_finals.windows(2).all(|pair| pair[0] < pair[1]),
                "missing-free control: {case_finals:?}"
            );
        }
        finals.push((mode, free, case_finals));
    }
    eprintln!("MCP final managed bytes: {finals:?}");
}
