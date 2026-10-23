//! gRPC between the modules of a split program (docs/services.md): a
//! module served by the interpreter (`fwp serve file module`) and as a
//! native executable (`fwp build --service`), called by interpreted and
//! native clients in every combination, with every kind of call (streams
//! from `Iterator` and `Channel` types), deadlines, metadata, statuses and
//! concurrency; and interoperability of the servers with Go's HTTP/2
//! client.
//!
//! `FWP_BLESS=1` rewrites the expected outputs.

use std::io::{BufRead, BufReader, Read};
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

#[path = "support/client_allocations.rs"]
mod client_allocations;
use client_allocations::instrument_client_allocations;

#[path = "support/queued_grpc_responses.rs"]
mod queued_grpc_responses;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn dir() -> PathBuf {
    root().join("tests/grpc")
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
    let d = std::env::temp_dir().join(format!("fwp-grpc-{}-{}", std::process::id(), name));
    let _ = std::fs::remove_dir_all(&d);
    std::fs::create_dir_all(&d).unwrap();
    d
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

fn render(o: &std::process::Output) -> String {
    let mut s = String::from_utf8_lossy(&o.stdout).to_string();
    if !o.stderr.is_empty() {
        s.push_str("--- stderr\n");
        s.push_str(&String::from_utf8_lossy(&o.stderr));
    }
    if let Some(c) = o.status.code().filter(|c| *c != 0) {
        s.push_str(&format!("--- exit {}\n", c));
    }
    s
}

/// Compare with an expected file, or rewrite it with `FWP_BLESS=1`.
fn expect_file(path: &Path, actual: &str, what: &str) {
    if bless() {
        std::fs::write(path, actual).unwrap();
        return;
    }
    let expected = std::fs::read_to_string(path)
        .unwrap_or_else(|_| panic!("missing {} (run with FWP_BLESS=1)", path.display()));
    assert_eq!(actual, expected, "{} differs from {}", what, path.display());
}

/// A running server; killed when dropped.
struct Server {
    child: Child,
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
    /// Wait until the server's standard error contains `text`.
    fn wait_log(&self, text: &str) -> bool {
        let start = Instant::now();
        while start.elapsed() < Duration::from_secs(15) {
            if self.log.lock().unwrap().contains(text) {
                return true;
            }
            std::thread::sleep(Duration::from_millis(20));
        }
        false
    }
}

/// Start a server and wait for its listening address. Reading a partial line
/// must not defeat the deadline; a background reader drains stderr throughout.
fn start(mut cmd: Command, timeout: Duration) -> Server {
    cmd.stdout(Stdio::null()).stderr(Stdio::piped());
    let mut child = cmd.spawn().expect("start server");
    let mut err = BufReader::new(child.stderr.take().unwrap());
    let log = Arc::new(Mutex::new(String::new()));
    let output = log.clone();
    let (ready, address) = std::sync::mpsc::channel();
    let reader = std::thread::spawn(move || {
        let mut ready = Some(ready);
        let mut line = String::new();
        while err.read_line(&mut line).is_ok_and(|n| n > 0) {
            output.lock().unwrap().push_str(&line);
            if let Some(addr) = line.trim().split("listening on ").nth(1) {
                if let Some(sender) = ready.take() {
                    let _ = sender.send(addr.to_owned());
                }
            }
            line.clear();
        }
    });
    match address.recv_timeout(timeout) {
        Ok(addr) => Server { child, addr, log },
        Err(error) => {
            let _ = child.kill();
            let _ = child.wait();
            let _ = reader.join();
            panic!("server did not start ({error}): {}", log.lock().unwrap());
        }
    }
}

#[test]
fn server_startup_deadline_covers_silent_processes() {
    let d = scratch("silent-startup");
    let source = d.join("silent.fwp");
    std::fs::write(&source, "main = 30s | task.sleep\n").unwrap();
    let began = Instant::now();
    let result = std::panic::catch_unwind(|| {
        // Construct the command inside the unwind boundary: Unix Command can
        // contain pre-exec callbacks and is not itself UnwindSafe.
        let mut command = Command::new(fwp());
        command.args(["run", "--interp"]).arg(&source);
        start(command, Duration::from_millis(100))
    });
    let error = match result {
        Err(error) => error,
        Ok(_) => panic!("a silent process must not count as a ready server"),
    };
    let message = error
        .downcast_ref::<String>()
        .expect("startup failure message");
    assert!(message.contains("timed out"), "{message}");
    assert!(
        began.elapsed() < Duration::from_secs(15),
        "startup waited for the silent child instead of its deadline"
    );
    std::fs::remove_dir_all(d).unwrap();
}

fn build(args: &[&str], cwd: &Path) {
    let mut cmd = Command::new(fwp());
    cmd.arg("build").args(args).arg("-O1").current_dir(cwd);
    let o = run(cmd, 300);
    assert!(o.status.success(), "fwp build {:?}: {}", args, render(&o));
}

/// The greeter served by the interpreter and as a native executable: the
/// module `greeter` of client.fwp, split off with `--service`.
fn greeter_servers(native_dir: Option<&Path>) -> Vec<Server> {
    let mut v = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["serve", "--interp"])
        .arg(dir().join("client.fwp"))
        .arg("greeter")
        .args(["--listen", "127.0.0.1:0"]);
    v.push(start(cmd, Duration::from_secs(60)));
    if let Some(d) = native_dir {
        let out = d.join("servers");
        build(
            &[
                dir().join("client.fwp").to_str().unwrap(),
                "--service",
                "greeter",
                "-o",
                out.to_str().unwrap(),
            ],
            &dir(),
        );
        let mut cmd = Command::new(out.join("greeter"));
        cmd.args(["--listen", "127.0.0.1:0"]);
        v.push(start(cmd, Duration::from_secs(60)));
    }
    v
}

// ------------------------------------------------------------------ calls

/// Explicit ARC builds must exclude tracing from both sides of the boundary,
/// while retaining the existing call, failure, concurrency and alias behavior.
#[test]
fn arc_remote_calls_exclude_tracing_and_preserve_behavior() {
    if !have_cc() {
        return;
    }
    let d = scratch("arc-remote");
    let artifacts = std::env::var_os("FWP_REMOTE_ARC_ARTIFACTS").map(PathBuf::from);
    if let Some(path) = &artifacts {
        std::fs::create_dir_all(path).unwrap();
    }
    let cases = ["client", "concurrent", "shared-stream", "input-failure"];
    for name in cases {
        let split = d.join(name);
        build(
            &[
                "--gc",
                "arc",
                "--service",
                "greeter",
                "--emit-c",
                dir().join(format!("{name}.fwp")).to_str().unwrap(),
                "-o",
                split.to_str().unwrap(),
            ],
            &dir(),
        );
        for member in [name, "greeter"] {
            let code = std::fs::read_to_string(split.join(format!("{member}.c"))).unwrap();
            assert!(code.contains("#define FWP_ARC_ONLY 1"), "{name}/{member}");
            if let Some(path) = &artifacts {
                if member != "greeter" || name == "client" {
                    std::fs::write(path.join(format!("{member}.c")), &code).unwrap();
                }
            }
        }
    }
    let interpreted = greeter_servers(None);
    for opt in ["-O1", "-O2"] {
        let mut executables = Vec::new();
        for name in cases.into_iter().chain(["greeter"]) {
            let source = if name == "greeter" {
                d.join("client/greeter.c")
            } else {
                d.join(name).join(format!("{name}.c"))
            };
            let binary = d.join(format!("{name}{opt}.exe"));
            fwp::cgen::compile_c(&std::fs::read_to_string(source).unwrap(), &binary, opt).unwrap();
            let mut nm = Command::new("nm");
            nm.arg(&binary);
            let symbols = run(nm, 30);
            assert!(symbols.status.success(), "{}", render(&symbols));
            let symbols = String::from_utf8_lossy(&symbols.stdout);
            if let Some(path) = &artifacts {
                std::fs::copy(&binary, path.join(binary.file_name().unwrap())).unwrap();
                std::fs::write(path.join(format!("{name}{opt}.nm")), symbols.as_bytes()).unwrap();
            }
            for tracing in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                assert!(
                    !symbols.contains(tracing),
                    "{name} {opt} contains {tracing}"
                );
            }
            executables.push(binary);
        }
        let mut native = Command::new(executables.last().unwrap());
        native
            .args(["--listen", "127.0.0.1:0"])
            .env_remove("FWP_GC")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0");
        let native = start(native, Duration::from_secs(60));
        for server in [&interpreted[0], &native] {
            for (index, name) in cases.iter().enumerate() {
                for use_interpreter in [false, true] {
                    let mut cmd = if use_interpreter {
                        let mut cmd = Command::new(fwp());
                        cmd.args(["run", "--interp", "--service", "greeter"])
                            .arg(dir().join(format!("{name}.fwp")))
                            .env("FWP_NO_OPT", "1");
                        cmd
                    } else {
                        Command::new(&executables[index])
                    };
                    cmd.env("FWP_SERVICE_GREETER", &server.addr)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0");
                    let out = run(cmd, 120);
                    if *name == "input-failure" {
                        assert_eq!(out.status.code(), Some(101), "{out:?}");
                        assert!(out.stdout.is_empty(), "{out:?}");
                        assert!(
                            String::from_utf8_lossy(&out.stderr).contains("division by zero"),
                            "{out:?}"
                        );
                    } else {
                        let expected =
                            std::fs::read_to_string(dir().join(format!("{name}.out"))).unwrap();
                        assert_eq!(
                            render(&out),
                            expected,
                            "{name} {opt} interpreter={use_interpreter}"
                        );
                    }
                }
            }
        }
    }
    drop(interpreted);
    std::fs::remove_dir_all(d).unwrap();
}

/// Every kind of call of greeter.fwp: interpreted and native servers,
/// interpreted and native clients.
#[test]
fn every_kind_of_call() {
    let native = have_cc();
    let d = scratch("served");
    let mut servers = greeter_servers(native.then_some(d.as_path()));
    let client = dir().join("client.fwp");
    let split = d.join("split");
    let failed_client = dir().join("input-failure.fwp");
    let failed_split = d.join("input-failure-split");
    if native {
        build(
            &[
                client.to_str().unwrap(),
                "--service",
                "greeter",
                "-o",
                split.to_str().unwrap(),
            ],
            &dir(),
        );
        build(
            &[
                failed_client.to_str().unwrap(),
                "--service",
                "greeter",
                "-o",
                failed_split.to_str().unwrap(),
            ],
            &dir(),
        );
        // The tracing comparison is an explicit compiler mode, selected before
        // generation. It must not accidentally test another owned server.
        let no_reuse = d.join("no-reuse");
        let mut compile = Command::new(fwp());
        compile
            .args([
                "build",
                "--gc",
                "tracing",
                "--service",
                "greeter",
                "--emit-c",
                "-o",
            ])
            .arg(&no_reuse)
            .arg(&client)
            .current_dir(dir())
            .env("FWP_REUSE", "0");
        let generated = run(compile, 300);
        assert!(generated.status.success(), "{}", render(&generated));
        let source = std::fs::read_to_string(no_reuse.join("greeter.c")).unwrap();
        assert!(!source.contains("#define FWP_RESOURCE_OWNERS 1"));
        let binary = no_reuse.join("greeter");
        fwp::cgen::compile_c(&source, &binary, "-O1").unwrap();
        let mut server = Command::new(binary);
        server.args(["--listen", "127.0.0.1:0"]);
        servers.push(start(server, Duration::from_secs(60)));
    }
    let mut outputs = Vec::new();
    for s in &servers {
        let mut cmd = Command::new(fwp());
        cmd.args(["run", "--interp", "--service", "greeter"])
            .arg(&client)
            .env("FWP_SERVICE_GREETER", &s.addr);
        outputs.push(("interpreted client", render(&run(cmd, 120))));
        if native {
            let mut cmd = Command::new(split.join("client"));
            cmd.env("FWP_SERVICE_GREETER", &s.addr);
            outputs.push(("native client", render(&run(cmd, 120))));
        }
        // A failing input continuation must preserve the caller's trap and
        // produce no response, for each interpreter/native client/server pair.
        for interpreted in [true, false] {
            if !interpreted && !native {
                continue;
            }
            let mut cmd = if interpreted {
                let mut cmd = Command::new(fwp());
                cmd.args(["run", "--interp", "--service", "greeter"])
                    .arg(&failed_client);
                cmd
            } else {
                Command::new(failed_split.join("input-failure"))
            };
            cmd.env("FWP_SERVICE_GREETER", &s.addr);
            let out = run(cmd, 120);
            assert_eq!(out.status.code(), Some(101), "{out:?}");
            assert!(out.stdout.is_empty(), "{out:?}");
            assert!(
                String::from_utf8_lossy(&out.stderr).contains("division by zero"),
                "{out:?}"
            );
        }
        // a slow call past its deadline is cancelled on the server
        assert!(
            s.wait_log("(in greeter.slow)") && s.wait_log("(in greeter.nap)"),
            "{}",
            s.log.lock().unwrap()
        );
    }
    for (who, out) in &outputs {
        expect_file(&dir().join("client.out"), out, who);
    }
}

/// Many calls at once on one connection, and a fast call during a slow one.
#[test]
fn calls_are_concurrent() {
    let native = have_cc();
    let d = scratch("concurrent");
    let servers = greeter_servers(native.then_some(d.as_path()));
    let client = dir().join("concurrent.fwp");
    let split = d.join("split");
    if native {
        build(
            &[
                client.to_str().unwrap(),
                "--service",
                "greeter",
                "-o",
                split.to_str().unwrap(),
            ],
            &dir(),
        );
    }
    for s in &servers {
        let mut cmd = Command::new(fwp());
        cmd.args(["run", "--interp", "--service", "greeter"])
            .arg(&client)
            .env("FWP_SERVICE_GREETER", &s.addr);
        let out = render(&run(cmd, 120));
        expect_file(&dir().join("concurrent.out"), &out, "interpreted client");
        if native {
            let mut cmd = Command::new(split.join("concurrent"));
            cmd.env("FWP_SERVICE_GREETER", &s.addr);
            let out = render(&run(cmd, 120));
            expect_file(&dir().join("concurrent.out"), &out, "native client");
        }
    }
}

/// Two tasks retain and consume the same cached stream positions.
#[test]
fn stream_aliases_are_consistent_across_tasks() {
    assert!(
        have_cc(),
        "shared stream comparison requires native compilation"
    );
    let d = scratch("shared-stream");
    let servers = greeter_servers(Some(d.as_path()));
    let client = dir().join("shared-stream.fwp");
    let split = d.join("split");
    build(
        &[
            client.to_str().unwrap(),
            "--service",
            "greeter",
            "-o",
            split.to_str().unwrap(),
        ],
        &dir(),
    );
    for server in &servers {
        let mut interpreted = Command::new(fwp());
        interpreted
            .args(["run", "--interp", "--service", "greeter"])
            .arg(&client)
            .env("FWP_SERVICE_GREETER", &server.addr);
        expect_file(
            &dir().join("shared-stream.out"),
            &render(&run(interpreted, 120)),
            "interpreted shared stream",
        );
        let mut native = Command::new(split.join("shared-stream"));
        native.env("FWP_SERVICE_GREETER", &server.addr);
        expect_file(
            &dir().join("shared-stream.out"),
            &render(&run(native, 120)),
            "native shared stream",
        );
    }
    if let Some(path) = std::env::var_os("FWP_STREAM_ARTIFACTS") {
        let path = PathBuf::from(path);
        std::fs::create_dir_all(&path).unwrap();
        let suffix = std::env::consts::EXE_SUFFIX;
        std::fs::copy(
            split.join(format!("shared-stream{suffix}")),
            path.join("shared-client.exe"),
        )
        .unwrap();
        std::fs::copy(
            d.join("servers").join(format!("greeter{suffix}")),
            path.join("shared-server.exe"),
        )
        .unwrap();
        std::fs::copy(&client, path.join("shared-client.fwp")).unwrap();
        std::fs::copy(dir().join("greeter.fwp"), path.join("shared-server.fwp")).unwrap();
        std::fs::write(path.join("service-build.txt"), "Both executables built by this revision's fwp build --service greeter -O1. Client source: shared-stream.fwp; server built from client.fwp and greeter.fwp. Native C flags include -std=gnu11 -ffp-contract=off. These correctness binaries have no allocation counters and are not timed.
").unwrap();
    }
}

/// Measure complete generated clients, including iterator wrappers and the
/// connection setup omitted by the queued-message C fixture. Run on CI only;
/// these counters establish a baseline, not a bounded-memory guarantee.
#[test]
#[ignore = "runner-only remote client allocation measurement"]
fn remote_stream_client_memory_measurement() {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let artifacts = PathBuf::from(
        std::env::var_os("FWP_STREAM_CLIENT_ARTIFACTS").expect("measurement artifact directory"),
    );
    std::fs::create_dir_all(&artifacts).unwrap();
    std::fs::copy(dir().join("greeter.fwp"), artifacts.join("greeter.fwp")).unwrap();
    std::fs::write(artifacts.join("scope.txt"), "Generated standalone clients call an interpreted greeter server over real loopback HTTP/2. For each input size, raw unoptimized interpretation and an uninstrumented compiled client must print the expected result. Three separate measured client processes count managed allocation requests, requested bytes and effective retains, sampling allocator-charged storage after each allocation. Measurement starts after constant initialization and ends after entry execution and top-level cached-value cleanup, before complete runtime shutdown. GC is disabled and physical freeing enabled. Raw network/message buffers, allocator metadata/pages, process memory and server memory are excluded. No timing or C/Rust comparison. Inputs are 64, 1024 and 16384; full consumers sum 1..n, partial consumers sum the first 32, retained consumers sum then reread the initial value. The compiler uses its ordinary optimizer and native -O2; code is emitted through fwp build --service greeter --emit-c and compiled through this revision's cgen::compile_c. Compiler versions, CPU details, source, generated C and binaries accompany this report.\n").unwrap();
    let d = scratch("stream-client-memory");
    std::fs::copy(dir().join("greeter.fwp"), d.join("greeter.fwp")).unwrap();
    let mut server = Command::new(fwp());
    server
        .args(["serve", "--interp"])
        .arg(dir().join("client.fwp"))
        .arg("greeter")
        .args(["--listen", "127.0.0.1:0"]);
    let server = start(server, Duration::from_secs(60));
    let mut rows = String::from("mode\telements\trepetition\trequests\trequested_bytes\tretains\tpeak_charged_bytes\tfinal_charged_bytes\tcollections\n");
    for (mode, consume) in [
        ("unique", "iter.fold add 0"),
        (
            "retained",
            "both (iter.fold add 0) (iter.take 1 | iter.to-list)",
        ),
        ("partial", "iter.take 32 | iter.fold add 0"),
    ] {
        let source = d.join(format!("{mode}.fwp"));
        std::fs::write(&source, format!("import greeter\n\nmain =\n    () | args | head | option.and-then parse-int\n    | (match\n        Some _ -> id\n        None -> \"expected a numeric measurement count\" | fail)\n    | greeter.count\n    | {consume}\n    | echo\n")).unwrap();
        let split = d.join(mode);
        build(
            &[
                source.to_str().unwrap(),
                "--service",
                "greeter",
                "--emit-c",
                "-o",
                split.to_str().unwrap(),
            ],
            &d,
        );
        let cpath = split.join(format!("{mode}.c"));
        let generated = std::fs::read_to_string(&cpath).unwrap();
        let instrumented = instrument_client_allocations(&generated);
        let measured_c = artifacts.join(format!("{mode}-measured.c"));
        std::fs::copy(&source, artifacts.join(format!("{mode}.fwp"))).unwrap();
        std::fs::copy(&cpath, artifacts.join(format!("{mode}.c"))).unwrap();
        std::fs::write(&measured_c, &instrumented).unwrap();
        let measured = artifacts.join(format!("{mode}-measured{}", std::env::consts::EXE_SUFFIX));
        let ordinary = artifacts.join(format!("{mode}{}", std::env::consts::EXE_SUFFIX));
        fwp::cgen::compile_c(&generated, &ordinary, "-O2").unwrap();
        fwp::cgen::compile_c(&instrumented, &measured, "-O2").unwrap();
        for elements in [64_i64, 1024, 16384] {
            let count = if mode == "partial" { 32 } else { elements };
            let sum = count * (count + 1) / 2;
            let expected = if mode == "retained" {
                format!("({sum}, [1])\n")
            } else {
                format!("{sum}\n")
            };
            let mut reference = Command::new(fwp());
            reference
                .args(["run", "--interp", "--service", "greeter"])
                .arg(&source)
                .arg(elements.to_string())
                .env("FWP_NO_OPT", "1")
                .env("FWP_SERVICE_GREETER", &server.addr);
            let result = run(reference, 120);
            assert!(result.status.success(), "reference: {}", render(&result));
            assert_eq!(String::from_utf8_lossy(&result.stdout), expected);
            for (exe, record, repetition) in [
                (&ordinary, false, 0),
                (&measured, true, 0),
                (&measured, true, 1),
                (&measured, true, 2),
            ] {
                let mut command = Command::new(exe);
                command
                    .arg(elements.to_string())
                    .env("FWP_SERVICE_GREETER", &server.addr)
                    .env("FWP_FREE", "1")
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_REUSE_VERIFY", "0");
                let result = run(command, 120);
                assert!(
                    result.status.success(),
                    "{mode}/{elements}: {}",
                    render(&result)
                );
                assert_eq!(String::from_utf8_lossy(&result.stdout), expected);
                let stderr = String::from_utf8(result.stderr).unwrap();
                if record {
                    let fields = stderr
                        .trim()
                        .strip_prefix("client-memory\t")
                        .expect("only the measurement line on stderr");
                    let values: Vec<u64> = fields.split('\t').map(|v| v.parse().unwrap()).collect();
                    assert_eq!(values.len(), 6);
                    assert!(values[0] > 0 && values[1] > 0);
                    assert_eq!(values[5], 0, "collections must be disabled");
                    rows.push_str(&format!("{mode}\t{elements}\t{repetition}\t{fields}\n"));
                } else {
                    assert!(stderr.is_empty(), "{stderr}");
                }
            }
        }
    }
    std::fs::write(artifacts.join("memory.tsv"), &rows).unwrap();
    println!("{rows}");
}

/// Baseline for multiple calls in one process. No tracing-free claim: record
/// connection/stream objects and queued message storage independently.
#[test]
#[ignore = "runner-only repeated remote call allocation measurement"]
fn repeated_remote_call_memory_measurement() {
    measure_repeated_remote_calls(false);
}

/// Close each connection and drain its detached tasks before reusing the client.
#[test]
#[ignore = "native connection measurements run on GitHub runners"]
fn closed_remote_connection_memory_measurement() {
    measure_repeated_remote_calls(true);
}

fn measure_repeated_remote_calls(close_connections: bool) {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let artifacts = PathBuf::from(
        std::env::var_os("FWP_REPEATED_CLIENT_ARTIFACTS").expect("measurement artifact directory"),
    );
    std::fs::create_dir_all(&artifacts).unwrap();
    std::fs::copy(dir().join("greeter.fwp"), artifacts.join("greeter.fwp")).unwrap();
    std::fs::write(artifacts.join("scope.txt"), "One native client process makes 1, 16 or 256 batches of remote calls over loopback HTTP/2 to an interpreted greeter. Each response contains integers 1..64. Full batches sum all 64; partial batches sum only the first 32; retained batches sum an initial stream, make and sum a second call while retaining the initial iterator, then reread its first value. Retained batches therefore make twice as many calls. Raw unoptimized interpreter and ordinary native output must agree. Three separate instrumented processes per case count managed allocations/retains/charged bytes, created/finalized connection and stream objects, and requested/freed queued-message bytes including their header and trailing byte. GC is disabled, physical freeing enabled. Counters start after constant initialization. Final counters follow root execution, joining its child tasks and cached-value cleanup, before whole-runtime shutdown. Reusable connections and detached I/O tasks are still live; the sample does not establish their destruction. Checkpoints are immediately before each new stream is allocated, after connection selection and request-header preparation; a checkpoint can deliberately include an earlier retained iterator. Excludes other raw buffers, TLS/OS/allocator metadata, server/whole-process memory and timing. Native builds use ordinary -O2. Source, generated C, executables and raw stderr are retained.\n").unwrap();
    if close_connections {
        let scope = artifacts.join("scope.txt");
        let original = std::fs::read_to_string(&scope).unwrap().replace("Reusable connections and detached I/O tasks are still live; the sample does not establish their destruction.", "Before the final sample, measurement hooks close every pooled connection and drain all detached I/O tasks.");
        std::fs::write(scope, format!("{original}\nConnection-churn variant: measurement-only native hooks close the pool before each new call and after cached-value cleanup, cancel/wait for the detached connection reader and writer, and require zero live I/O tasks and one closed socket per created connection before sampling. Each call uses a new connection. Ordinary native and interpreter executions still use their usual pooling: their output is the functional reference, not an equivalent transport workload. Compare ownership revisions using these same churn hooks; do not use this experiment as a timing comparison with pooled calls. Retained iterators still keep earlier cached values across connection closure. Drain rows record created/closed connections, live I/O tasks, managed charge, unfinalized connection/request counts and unread message bytes. Scheduler stack pools, other raw buffers and TLS/OS storage remain excluded.\n")).unwrap();
    }
    let d = scratch("repeated-client-memory");
    std::fs::copy(dir().join("greeter.fwp"), d.join("greeter.fwp")).unwrap();
    let mut command = Command::new(fwp());
    command
        .args(["serve", "--interp"])
        .arg(dir().join("client.fwp"))
        .arg("greeter")
        .args(["--listen", "127.0.0.1:0"]);
    let server = start(command, Duration::from_secs(60));
    let mut rows=String::from("mode\tbatches\trepetition\trequests\trequested_bytes\tretains\tpeak_charged_bytes\tfinal_charged_bytes\tcollections\tconnections_created\tconnections_finalized\tstreams_created\tstreams_finalized\tmessages_created\tmessages_freed\tmessage_requested_bytes\tmessage_freed_bytes\tpeak_message_bytes\n");
    let mut checkpoints=String::from("mode\tbatches\trepetition\tprior_streams\tmanaged_charged_bytes\tmessage_bytes\tlive_connections\tlive_streams\n");
    let mut drains=String::from("mode\tbatches\trepetition\tconnections_created\tconnections_closed\tlive_io_tasks\tmanaged_charged_bytes\tunfinalized_connections\tunfinalized_streams\tmessage_bytes\n");
    let mut storage=String::from("mode\tbatches\trepetition\tconnection_requested_bytes\tconnection_charged_bytes\tio_task_requested_bytes\tio_task_charged_bytes\tconnection_header_bytes\ttask_bytes\n");
    for (mode, consume, per_batch, calls_per_batch) in [
        ("full", "const 64 | greeter.count | iter.fold add 0", 2080, 1),
        ("partial", "const 64 | greeter.count | iter.take 32 | iter.fold add 0", 528, 1),
        ("retained", "const 64 | greeter.count | both (iter.fold add 0) (both (const 64 | greeter.count | iter.fold add 0) (iter.take 1 | iter.to-list | sum) | uncurry add) | uncurry add", 4161, 2),
    ] {
        let source=d.join(format!("{mode}.fwp"));
        std::fs::write(&source,format!("import greeter\n\nconsume : I64 -> I64\nconsume = {consume}\nstep = curry (both .0 (.1 | consume) | uncurry add)\n\nmain =\n    () | args | head | option.and-then parse-int\n    | (match\n        Some _ -> id\n        None -> \"expected a numeric batch count\" | fail)\n    | flip iter.take (iter.count-from 0)\n    | iter.fold step 0\n    | echo\n")).unwrap();
        let split=d.join(mode);
        build(&[source.to_str().unwrap(),"--service","greeter","--emit-c","-o",split.to_str().unwrap()],&d);
        let generated=std::fs::read_to_string(split.join(format!("{mode}.c"))).unwrap();
        let instrumented=instrument_repeated_client(&generated);
        let instrumented=if close_connections {instrument_closed_connections(&instrumented, include_str!("fixtures/grpc_connection_drain.c"))} else {instrumented};
        std::fs::copy(&source,artifacts.join(format!("{mode}.fwp"))).unwrap();
        std::fs::write(artifacts.join(format!("{mode}.c")),&generated).unwrap();
        std::fs::write(artifacts.join(format!("{mode}-measured.c")),&instrumented).unwrap();
        let ordinary=artifacts.join(format!("{mode}{}",std::env::consts::EXE_SUFFIX));
        let measured=artifacts.join(format!("{mode}-measured{}",std::env::consts::EXE_SUFFIX));
        fwp::cgen::compile_c(&generated,&ordinary,"-O2").unwrap();
        fwp::cgen::compile_c(&instrumented,&measured,"-O2").unwrap();
        for batches in [1,16,256] {
            let expected=format!("{}\n",batches*per_batch);
            let mut reference=Command::new(fwp());
            reference.args(["run","--interp","--service","greeter"]).arg(&source).arg(batches.to_string()).env("FWP_NO_OPT","1").env("FWP_SERVICE_GREETER",&server.addr);
            let output=run(reference,120);
            assert!(output.status.success(),"reference: {}",render(&output));
            assert_eq!(String::from_utf8_lossy(&output.stdout),expected);
            for (exe,record,repetition) in [(&ordinary,false,0),(&measured,true,0),(&measured,true,1),(&measured,true,2)] {
                let mut command=Command::new(exe);
                command.arg(batches.to_string()).env("FWP_SERVICE_GREETER",&server.addr).env("FWP_FREE","1").env("FWP_GC","off").env("FWP_GC_STRESS","0").env("FWP_GC_VERIFY","0").env("FWP_GC_STATS","0").env("FWP_REUSE_VERIFY","0");
                let output=run(command,120);
                assert!(output.status.success(),"{mode}/{batches}: {}",render(&output));
                assert_eq!(String::from_utf8_lossy(&output.stdout),expected);
                let stderr=String::from_utf8(output.stderr).unwrap();
                if !record {assert!(stderr.is_empty(),"{stderr}");continue;}
                std::fs::write(artifacts.join(format!("{mode}-{batches}-{repetition}.log")),&stderr).unwrap();
                let mut memory=None;let mut transport=None;let mut count=0;let mut closed=0;let mut storage_seen=false;
                for line in stderr.lines() {
                    if let Some(fields)=line.strip_prefix("client-memory\t") {assert!(memory.replace(fields).is_none());}
                    else if let Some(fields)=line.strip_prefix("transport-memory\t") {assert!(transport.replace(fields).is_none());}
                    else if let Some(fields)=line.strip_prefix("call-memory\t") {
                        let values:Vec<u64>=fields.split('\t').map(|v|v.parse().unwrap()).collect();
                        assert_eq!(values.len(),5);assert_eq!(values[0],count);
                        checkpoints.push_str(&format!("{mode}\t{batches}\t{repetition}\t{fields}\n"));count+=1;
                    } else if let Some(fields)=line.strip_prefix("connection-drain\t") {
                        assert!(close_connections);
                        let values:Vec<u64>=fields.split('\t').map(|v|v.parse().unwrap()).collect();
                        assert_eq!(values.len(),7);closed+=1;
                        assert_eq!(values[0],closed);assert_eq!(values[1],closed);assert_eq!(values[2],0);
                        assert_eq!(values[5],0);assert_eq!(values[6],0);
                        drains.push_str(&format!("{mode}\t{batches}\t{repetition}\t{fields}\n"));
                    } else if let Some(fields)=line.strip_prefix("connection-storage\t") {
                        assert!(close_connections&&!storage_seen);storage_seen=true;
                        let values:Vec<u64>=fields.split('\t').map(|v|v.parse().unwrap()).collect();
                        assert_eq!(values.len(),6);
                        assert!(values[1]>=values[0]);assert!(values[3]>=values[2]);
                        assert_eq!(values[2],2*count*values[5]);
                        storage.push_str(&format!("{mode}\t{batches}\t{repetition}\t{fields}\n"));
                    } else {panic!("unexpected measurement output: {line}");}
                }
                assert_eq!(count,batches*calls_per_batch);
                if close_connections {assert_eq!(closed,count);assert!(storage_seen);}
                let memory=memory.unwrap();let transport=transport.unwrap();
                let m:Vec<u64>=memory.split('\t').map(|v|v.parse().unwrap()).collect();
                let t:Vec<u64>=transport.split('\t').map(|v|v.parse().unwrap()).collect();
                assert_eq!(m.len(),6);assert_eq!(m[5],0,"collection must remain disabled");
                assert_eq!(t.len(),9);assert!(t[0]>0&&t[0]<=count);assert_eq!(t[2],count);
                if close_connections {assert_eq!(t[0],count);}
                assert!(t[1]<=t[0]&&t[3]<=t[2]&&t[5]<=t[4]&&t[7]<=t[6]);
                assert!(t[8]>=t[6]-t[7]);
                if mode!="partial" {assert_eq!(t[4],count*64);assert_eq!(t[5],t[4]);assert_eq!(t[7],t[6]);}
                rows.push_str(&format!("{mode}\t{batches}\t{repetition}\t{memory}\t{transport}\n"));
            }
        }
        if mode=="full" {
            if close_connections {
                let broken=instrumented.replace("client_drain_connections();","client_require_drained();");
                assert_ne!(broken,instrumented);
                let path=artifacts.join(format!("missing-connection-drain{}",std::env::consts::EXE_SUFFIX));
                std::fs::write(artifacts.join("missing-connection-drain.c"),&broken).unwrap();
                fwp::cgen::compile_c(&broken,&path,"-O2").unwrap();
                let mut command=Command::new(path);
                command.arg("1").env("FWP_SERVICE_GREETER",&server.addr).env("FWP_FREE","1").env("FWP_GC","off").env("FWP_GC_STRESS","0").env("FWP_REUSE_VERIFY","0");
                let output=run(command,120);
                assert_eq!(output.status.code(),Some(213),"missing connection drain: {}",render(&output));
                std::fs::write(artifacts.join("missing-connection-drain.log"),render(&output)).unwrap();
            }
            // Omit real raw-message releases, so the measurement must expose
            // retained message bytes even though language output remains right.
            assert!(instrumented.contains("client_message_free(g->m);"));
            let broken=instrumented.replace("client_message_free(g->m);","(void)g->m;");
            let path=artifacts.join(format!("missing-message-release{}",std::env::consts::EXE_SUFFIX));
            std::fs::write(artifacts.join("missing-message-release.c"),&broken).unwrap();
            fwp::cgen::compile_c(&broken,&path,"-O2").unwrap();
            let mut command=Command::new(path);
            command.arg("1").env("FWP_SERVICE_GREETER",&server.addr).env("FWP_FREE","1").env("FWP_GC","off").env("FWP_GC_STRESS","0").env("FWP_REUSE_VERIFY","0");
            let output=run(command,120);assert!(output.status.success(),"{}",render(&output));
            assert_eq!(output.stdout,b"2080\n");
            let stderr=String::from_utf8(output.stderr).unwrap();
            let fields=stderr.lines().find_map(|line|line.strip_prefix("transport-memory\t")).unwrap();
            let t:Vec<u64>=fields.split('\t').map(|v|v.parse().unwrap()).collect();
            assert!(t[4]>t[5]&&t[6]>t[7],"omitted message release was not detected: {fields}");
            std::fs::write(artifacts.join("missing-message-release.log"),stderr).unwrap();
        }
    }
    std::fs::write(artifacts.join("memory.tsv"), &rows).unwrap();
    std::fs::write(artifacts.join("checkpoints.tsv"), checkpoints).unwrap();
    if close_connections {
        std::fs::write(artifacts.join("drains.tsv"), drains).unwrap();
        std::fs::write(artifacts.join("connection-storage.tsv"), storage).unwrap();
    }
    println!("{rows}");
}

/// Record input-iterator retention before changing client sender ownership.
#[test]
#[ignore = "native sender measurements run on GitHub runners"]
fn sender_input_memory_measurement() {
    assert_eq!(std::env::var("GITHUB_ACTIONS").as_deref(), Ok("true"));
    let artifacts = PathBuf::from(
        std::env::var_os("FWP_REPEATED_CLIENT_ARTIFACTS").expect("measurement artifact directory"),
    );
    std::fs::create_dir_all(&artifacts).unwrap();
    std::fs::copy(dir().join("greeter.fwp"), artifacts.join("greeter.fwp")).unwrap();
    std::fs::write(
        artifacts.join("scope.txt"),
        include_str!("fixtures/sender-inputs/README.md"),
    )
    .unwrap();
    let d = scratch("sender-input-memory");
    std::fs::copy(dir().join("greeter.fwp"), d.join("greeter.fwp")).unwrap();
    let mut command = Command::new(fwp());
    command
        .args(["serve", "--interp"])
        .arg(dir().join("client.fwp"))
        .arg("greeter")
        .args(["--listen", "127.0.0.1:0"]);
    let server = start(command, Duration::from_secs(60));
    let mut rows=String::from("mode\tbatches\trepetition\trequests\trequested_bytes\tretains\tpeak_charged_bytes\tfinal_charged_bytes\tcollections\tconnections_created\tconnections_finalized\tstreams_created\tstreams_finalized\tmessages_created\tmessages_freed\tmessage_requested_bytes\tmessage_freed_bytes\tpeak_message_bytes\n");
    let mut checkpoints=String::from("mode\tbatches\trepetition\tprior_streams\tmanaged_charged_bytes\tmessage_bytes\tlive_connections\tlive_streams\n");
    let mut drains=String::from("mode\tbatches\trepetition\tconnections_created\tconnections_closed\tlive_tasks\tmanaged_charged_bytes\tunfinalized_connections\tunfinalized_streams\tmessage_bytes\n");
    let mut storage=String::from("mode\tbatches\trepetition\tconnection_requested_bytes\tconnection_charged_bytes\tio_task_requested_bytes\tio_task_charged_bytes\tconnection_header_bytes\ttask_bytes\n");
    let mut senders=String::from("mode\tbatches\trepetition\tsenders_created\tsenders_finished\tinputs_pulled\tinputs_encoded\tsender_requested_bytes\tsender_charged_bytes\tsender_task_requested_bytes\tsender_task_charged_bytes\tsender_bytes\ttask_bytes\n");
    for (mode, source_text, per_batch, responses, detached) in [
        (
            "synchronous",
            include_str!("fixtures/sender-inputs/synchronous.fwp"),
            2080,
            1,
            false,
        ),
        (
            "bidirectional",
            include_str!("fixtures/sender-inputs/bidirectional.fwp"),
            439,
            64,
            true,
        ),
        (
            "retained-input",
            include_str!("fixtures/sender-inputs/retained-input.fwp"),
            878,
            64,
            true,
        ),
        (
            "early-completion",
            include_str!("fixtures/sender-inputs/early-completion.fwp"),
            60,
            3,
            true,
        ),
    ] {
        let source = d.join(format!("{mode}.fwp"));
        std::fs::write(&source, source_text).unwrap();
        let split = d.join(mode);
        build(
            &[
                source.to_str().unwrap(),
                "--service",
                "greeter",
                "--emit-c",
                "-o",
                split.to_str().unwrap(),
            ],
            &d,
        );
        let generated = std::fs::read_to_string(split.join(format!("{mode}.c"))).unwrap();
        let instrumented = instrument_sender_client(&generated);
        std::fs::copy(&source, artifacts.join(format!("{mode}.fwp"))).unwrap();
        std::fs::write(artifacts.join(format!("{mode}.c")), &generated).unwrap();
        std::fs::write(artifacts.join(format!("{mode}-measured.c")), &instrumented).unwrap();
        let ordinary = artifacts.join(format!("{mode}{}", std::env::consts::EXE_SUFFIX));
        let measured = artifacts.join(format!("{mode}-measured{}", std::env::consts::EXE_SUFFIX));
        fwp::cgen::compile_c(&generated, &ordinary, "-O2").unwrap();
        fwp::cgen::compile_c(&instrumented, &measured, "-O2").unwrap();
        for batches in [1, 16, 256] {
            let expected = format!("{}\n", batches * per_batch);
            let mut reference = Command::new(fwp());
            reference
                .args(["run", "--interp", "--service", "greeter"])
                .arg(&source)
                .arg(batches.to_string())
                .env("FWP_NO_OPT", "1")
                .env("FWP_SERVICE_GREETER", &server.addr);
            let output = run(reference, 120);
            assert!(output.status.success(), "reference: {}", render(&output));
            assert_eq!(String::from_utf8_lossy(&output.stdout), expected);
            for (exe, record, repetition) in [
                (&ordinary, false, 0),
                (&measured, true, 0),
                (&measured, true, 1),
                (&measured, true, 2),
            ] {
                let mut command = Command::new(exe);
                command
                    .arg(batches.to_string())
                    .env("FWP_SERVICE_GREETER", &server.addr)
                    .env("FWP_FREE", "1")
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_REUSE_VERIFY", "0");
                let output = run(command, 120);
                assert!(
                    output.status.success(),
                    "{mode}/{batches}: {}",
                    render(&output)
                );
                assert_eq!(String::from_utf8_lossy(&output.stdout), expected);
                let stderr = String::from_utf8(output.stderr).unwrap();
                if !record {
                    assert!(stderr.is_empty(), "{stderr}");
                    continue;
                }
                std::fs::write(
                    artifacts.join(format!("{mode}-{batches}-{repetition}.log")),
                    &stderr,
                )
                .unwrap();
                let mut unique = std::collections::BTreeMap::new();
                let mut count = 0;
                let mut closed = 0;
                for line in stderr.lines() {
                    let (label, fields) = line.split_once('\t').expect("measurement prefix");
                    let values: Vec<u64> = fields.split('\t').map(|v| v.parse().unwrap()).collect();
                    match label {
                        "call-memory" => {
                            assert_eq!(values.len(), 5);
                            assert_eq!(values[0], count);
                            count += 1;
                            checkpoints
                                .push_str(&format!("{mode}\t{batches}\t{repetition}\t{fields}\n"));
                        }
                        "connection-drain" => {
                            assert_eq!(values.len(), 7);
                            closed += 1;
                            assert_eq!(values[0], closed);
                            assert_eq!(values[1], closed);
                            assert_eq!(values[2], 0);
                            assert_eq!(&values[4..], &[0, 0, 0]);
                            drains
                                .push_str(&format!("{mode}\t{batches}\t{repetition}\t{fields}\n"));
                        }
                        "client-memory" | "transport-memory" | "connection-storage"
                        | "sender-storage" => {
                            assert!(unique.insert(label, (fields, values)).is_none());
                        }
                        _ => panic!("unexpected measurement output: {line}"),
                    }
                }
                assert_eq!(count, batches);
                assert_eq!(closed, batches);
                assert_eq!(unique.len(), 4);
                let (memory, m) = &unique["client-memory"];
                assert_eq!(m.len(), 6);
                assert_eq!(m[5], 0);
                let (transport, t) = &unique["transport-memory"];
                assert_eq!(t.len(), 9);
                assert_eq!(&t[..4], &[batches, batches, batches, batches]);
                assert_eq!(t[4], batches * responses);
                assert_eq!(t[4], t[5]);
                assert_eq!(t[6], t[7]);
                let (connection, c) = &unique["connection-storage"];
                assert_eq!(c.len(), 6);
                assert!(c[1] >= c[0] && c[3] >= c[2]);
                assert_eq!(c[2], 2 * batches * c[5]);
                let (sender, s) = &unique["sender-storage"];
                assert_eq!(s.len(), 10);
                let expected_senders = if detached { batches } else { 0 };
                assert_eq!(s[0], expected_senders);
                assert_eq!(s[1], s[0]);
                assert_eq!(s[2], s[3]);
                if mode == "early-completion" {
                    assert!(s[2] >= 3 * batches && s[2] <= 64 * batches);
                } else {
                    assert_eq!(s[2], 64 * batches);
                }
                assert_eq!(s[4], s[0] * s[8]);
                assert_eq!(s[6], s[0] * s[9]);
                assert!(s[5] >= s[4] && s[7] >= s[6]);
                rows.push_str(&format!(
                    "{mode}\t{batches}\t{repetition}\t{memory}\t{transport}\n"
                ));
                storage.push_str(&format!("{mode}\t{batches}\t{repetition}\t{connection}\n"));
                senders.push_str(&format!("{mode}\t{batches}\t{repetition}\t{sender}\n"));
            }
        }
        if mode == "bidirectional" {
            let broken =
                instrumented.replace("client_drain_connections();", "client_require_drained();");
            assert_ne!(broken, instrumented);
            let path = artifacts.join(format!(
                "missing-sender-drain{}",
                std::env::consts::EXE_SUFFIX
            ));
            std::fs::write(artifacts.join("missing-sender-drain.c"), &broken).unwrap();
            fwp::cgen::compile_c(&broken, &path, "-O2").unwrap();
            let mut command = Command::new(path);
            command
                .arg("1")
                .env("FWP_SERVICE_GREETER", &server.addr)
                .env("FWP_FREE", "1")
                .env("FWP_GC", "off")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_REUSE_VERIFY", "0");
            let output = run(command, 120);
            assert_eq!(output.status.code(), Some(213), "{}", render(&output));
            std::fs::write(artifacts.join("missing-sender-drain.log"), render(&output)).unwrap();
        }
    }
    for (name, table) in [
        ("memory.tsv", rows),
        ("checkpoints.tsv", checkpoints),
        ("drains.tsv", drains),
        ("connection-storage.tsv", storage),
        ("senders.tsv", senders),
    ] {
        std::fs::write(artifacts.join(name), table).unwrap();
    }
}

fn instrument_sender_client(generated: &str) -> String {
    let mut code = instrument_repeated_client(generated);
    code = instrument_closed_connections(&code, include_str!("fixtures/grpc_sender_drain.c"));
    for (before,after) in [
        ("static int g_cursor_next(g_cursor *input, void (*drop)(V), V *value) {", "static uint64_t client_inputs_pulled,client_inputs_encoded,client_senders_created,client_senders_finished;\nstatic int g_cursor_next(g_cursor *input, void (*drop)(V), V *value) {"),
        ("    input->cur = fwp_apply1(OBJ(node)->f[1], FWP_UNIT);\n#endif\n    return 1;", "    input->cur = fwp_apply1(OBJ(node)->f[1], FWP_UNIT);\n#endif\n    if(client_active)client_inputs_pulled++;\n    return 1;"),
        ("static void g_sender_peer_finish(void *arg) {", "static void client_note_sender(g_sender *);\nstatic void client_note_sender_task(fwp_task *);\nstatic void g_sender_peer_finish(void *arg) {\n    if(client_active)client_senders_finished++;"),
        ("    g_sender *x = (g_sender *)fwp_alloc(sizeof *x);", "    g_sender *x = (g_sender *)fwp_alloc(sizeof *x); client_note_sender(x);"),
        ("    fwp_task *t = fwp_spawn_task(0, g_send_all, x, 0, 1);", "    fwp_task *t = fwp_spawn_task(0, g_send_all, x, 0, 1); client_note_sender_task(t);"),
        ("static void g_encode_request(const fwp_remote *r, V *vals, h2_buf *out) {", "static void g_encode_request(const fwp_remote *r, V *vals, h2_buf *out) {\n    if(client_active)client_inputs_encoded++;"),
        ("    client_connection_storage();", "    client_connection_storage();\n    client_sender_storage();"),
    ] {assert_eq!(code.matches(before).count(),1,"{before}");code=code.replacen(before,after,1);}
    code
}

fn instrument_closed_connections(code: &str, drain_fixture: &str) -> String {
    let mut code = code.to_owned();
    let signature = "static g_stream *g_open_tls(const char *addr";
    assert_eq!(code.matches(signature).count(), 1);
    code=code.replacen(signature,&format!("static void client_drain_connections(void);\nstatic void client_require_drained(void);\n{signature}"),1);
    let begin = code.find(signature).unwrap();
    let at = begin
        + code[begin..].find("    fwp_check_cancel();").unwrap()
        + "    fwp_check_cancel();".len();
    code.insert_str(at, "\n    client_drain_connections();");
    let close = "        fwp_socket_close(c->fd);\n        c->fd = FWP_INVALID_SOCKET;";
    assert_eq!(code.matches(close).count(), 1);
    code = code.replacen(
        close,
        &format!("{close}\n        if(client_active)client_connections_closed++;"),
        1,
    );
    let declaration = "static uint64_t client_connections_created, client_connections_finalized;";
    assert_eq!(code.matches(declaration).count(), 1);
    code = code.replacen(
        declaration,
        &format!("{declaration}\nstatic uint64_t client_connections_closed;\nstatic void client_note_connection(g_conn *);\nstatic void client_note_io_task(fwp_task *);"),
        1,
    );
    for (before,after) in [
        ("g_conn *c = g_conn_new(fd, \"\", given, 0);", "g_conn *c = g_conn_new(fd, \"\", given, 0); client_note_connection(c);"),
        ("startup.reader = fwp_spawn_task(0, g_reader, c, 0, 1);", "startup.reader = fwp_spawn_task(0, g_reader, c, 0, 1); client_note_io_task(startup.reader);"),
        ("startup.writer = fwp_spawn_task(0, g_writer, c, 0, 1);", "startup.writer = fwp_spawn_task(0, g_writer, c, 0, 1); client_note_io_task(startup.writer);"),
    ] {assert_eq!(code.matches(before).count(),1);code=code.replacen(before,after,1);}
    let main = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    code.insert_str(main, drain_fixture);
    let end = "    client_transport_end();";
    assert_eq!(code.matches(end).count(), 1);
    code.replacen(
        end,
        &format!("    client_drain_connections();\n    client_require_drained();\n    client_connection_storage();\n{end}"),
        1,
    )
}

fn instrument_repeated_client(generated: &str) -> String {
    let mut code = instrument_client_allocations(generated);
    let original = include_str!("../runtime/fwp_rt_grpc.c");
    assert_eq!(
        code.matches(original).count(),
        1,
        "instrument only the gRPC runtime, not unrelated free calls"
    );
    let mut runtime = original.to_string();
    let marker = "typedef struct g_msg { struct g_msg *next; size_t n; unsigned char d[]; } g_msg;";
    assert_eq!(runtime.matches(marker).count(), 1);
    runtime = runtime.replacen(
        marker,
        &format!(
            "{marker}\n{}",
            include_str!("fixtures/grpc_repeated_memory.c")
        ),
        1,
    );
    for (before,after) in [
        ("static g_stream *g_stream_new(g_conn *c, uint32_t id) {", "static g_stream *g_stream_new(g_conn *c, uint32_t id) {\n    if(client_active){client_call_checkpoint();client_streams_created++;}"),
        ("static void g_stream_final(void *p) {", "static void g_stream_final(void *p) {\n    if(client_active)client_streams_finalized++;"),
        ("    fwp_gc_finalizer(c, g_conn_final);", "    fwp_gc_finalizer(c, g_conn_final);\n    if(client_active)client_connections_created++;"),
        ("static void g_conn_final(void *p) {", "static void g_conn_final(void *p) {\n    if(client_active)client_connections_finalized++;"),
        ("        m->n = mn;", "        m->n = mn;\n        if(client_active){client_messages_created++;client_message_requested+=sizeof(*m)+mn+1;uint64_t live=client_message_requested-client_message_freed;if(live>client_message_peak)client_message_peak=live;}"),
    ] {assert_eq!(runtime.matches(before).count(),1,"{before}");runtime=runtime.replacen(before,after,1);}
    for (argument, count) in [
        ("m", 1),
        ("g->m", 3),
        ("first.m", 1),
        ("g.m", 2),
        ("req", 3),
    ] {
        let before = format!("free({argument});");
        // The counting helper contains one additional free(m).
        let expected = if argument == "m" { count + 1 } else { count };
        assert_eq!(runtime.matches(&before).count(), expected, "{argument}");
        if argument == "m" {
            runtime = runtime.replace("        free(m);", "        client_message_free(m);");
        } else {
            runtime = runtime.replace(&before, &format!("client_message_free({argument});"));
        }
    }
    code = code.replacen(original, &runtime, 1);
    let end = "    client_measure_end();";
    assert_eq!(code.matches(end).count(), 1);
    code.replacen(
        end,
        "    client_transport_end();\n    client_measure_end();",
        1,
    )
}

// ------------------------------------------------------------ interoperability

/// Go's HTTP/2 client (the standard library only) calls both servers.
#[test]
fn go_client_interoperates() {
    if !have("go", "version") {
        return;
    }
    let d = scratch("go");
    let go = d.join("interop");
    let mut cmd = Command::new("go");
    cmd.arg("build")
        .arg("-o")
        .arg(&go)
        .arg(dir().join("interop.go"));
    let b = run(cmd, 300);
    if !b.status.success() {
        // an older Go without unencrypted HTTP/2 support
        eprintln!("skipping: {}", String::from_utf8_lossy(&b.stderr));
        return;
    }
    let servers = greeter_servers(have_cc().then_some(d.as_path()));
    for s in &servers {
        let mut cmd = Command::new(&go);
        cmd.arg(&s.addr);
        expect_file(
            &dir().join("interop.out"),
            &render(&run(cmd, 120)),
            "the Go client",
        );
    }
}

#[path = "support/grpc_server_measurement.rs"]
mod server_measurement;
