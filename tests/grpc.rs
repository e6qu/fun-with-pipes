//! gRPC (docs/grpc.md): servers of exported functions (`fwp serve --grpc`,
//! `fwp build --grpc`) and of routes generated from `.proto` files
//! (`fwp proto --import`), called by interpreted and native fwp clients in
//! every combination, with streaming, deadlines, metadata, statuses,
//! concurrency, server reflection and health checking; the generated files
//! (`.proto` and fwp modules) against the checked-in ones; and
//! interoperability with Go's HTTP/2 client and, when installed, grpcurl.
//!
//! `FWP_BLESS=1` rewrites the expected outputs and generated files.

use std::io::{BufRead, BufReader, Read};
use std::path::{Path, PathBuf};
use std::process::{Child, Command, Stdio};
use std::sync::{Arc, Mutex};
use std::time::{Duration, Instant};

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

fn build(args: &[&str], cwd: &Path) {
    let mut cmd = Command::new(fwp());
    cmd.arg("build").args(args).arg("-O1").current_dir(cwd);
    let o = run(cmd, 300);
    assert!(o.status.success(), "fwp build {:?}: {}", args, render(&o));
}

/// The greeter served by the interpreter and as a native executable.
fn greeter_servers(native_dir: Option<&Path>) -> Vec<Server> {
    let mut v = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["serve", "--grpc"])
        .arg(dir().join("greeter.fwp"))
        .args(["--listen", "127.0.0.1:0"]);
    v.push(start(cmd));
    if let Some(d) = native_dir {
        build(
            &[
                dir().join("greeter.fwp").to_str().unwrap(),
                "--grpc",
                "-o",
                d.join("greeter").to_str().unwrap(),
            ],
            d,
        );
        let mut cmd = Command::new(d.join("greeter"));
        cmd.args(["--listen", "127.0.0.1:0"]);
        v.push(start(cmd));
    }
    v
}

// ------------------------------------------------------------ generated files

#[test]
fn generated_files_are_current() {
    // the .proto of the greeter
    let mut cmd = Command::new(fwp());
    cmd.args(["proto", "--grpc", "greeter.fwp"])
        .current_dir(dir());
    let o = run(cmd, 120);
    assert!(o.status.success(), "{}", render(&o));
    expect_file(
        &dir().join("greeter.proto"),
        &String::from_utf8_lossy(&o.stdout),
        "fwp proto --grpc",
    );
    // modules generated from .proto files
    for (proto, module) in [
        ("greeter.proto", "roundtrip/gen.fwp"),
        ("hello/hello.proto", "hello/gen.fwp"),
        ("reflection/reflection.proto", "reflection/gen.fwp"),
    ] {
        let mut cmd = Command::new(fwp());
        cmd.args(["proto", "--import", proto]).current_dir(dir());
        let o = run(cmd, 120);
        assert!(o.status.success(), "{}", render(&o));
        expect_file(
            &dir().join(module),
            &String::from_utf8_lossy(&o.stdout),
            "fwp proto --import",
        );
    }
    // protoc accepts the generated .proto, when installed
    if have("protoc", "--version") {
        let out = scratch("protoc");
        let o = run(
            {
                let mut c = Command::new("protoc");
                c.arg("-I")
                    .arg(dir())
                    .arg(format!("--descriptor_set_out={}", out.join("d").display()))
                    .arg(dir().join("greeter.proto"));
                c
            },
            60,
        );
        assert!(o.status.success(), "{}", render(&o));
    }
}

#[test]
fn proto_import_errors() {
    let d = scratch("import-errors");
    for (text, msg) in [
        (
            "syntax = \"proto3\"; message A { B b = 1; }",
            "unknown type `B`",
        ),
        (
            "syntax = \"proto3\"; message A { group G = 1 {} }",
            "groups are not supported",
        ),
        (
            "syntax = \"proto3\"; message A { int32 x = 0; }",
            "invalid number",
        ),
        (
            "syntax = \"proto3\"; import \"missing.proto\";",
            "missing.proto",
        ),
        (
            "syntax = \"proto3\"; message A { int32 x = 1 }",
            "expected `;`",
        ),
    ] {
        std::fs::write(d.join("x.proto"), text).unwrap();
        let mut cmd = Command::new(fwp());
        cmd.args(["proto", "--import", "x.proto"]).current_dir(&d);
        let o = run(cmd, 60);
        let r = render(&o);
        assert!(!o.status.success() && r.contains(msg), "{}: {}", text, r);
    }
}

#[test]
fn grpc_build_errors() {
    let d = scratch("errors");
    for (text, msg) in [
        ("x = 1\n", "exports no functions to serve"),
        (
            "# grpc: Bad Name\nexport f : I64 -> I64\nf = id\n",
            "expected `Method`",
        ),
        (
            "# grpc: A\nexport f : I64 -> I64\nf = id\n\n# grpc: A\nexport g : I64 -> I64\ng = id\n",
            "have the same gRPC method",
        ),
        (
            "export f : (I64 -> I64) -> I64\nf = apply 1\n",
            "cannot be sent to a service",
        ),
    ] {
        std::fs::write(d.join("svc.fwp"), text).unwrap();
        let mut cmd = Command::new(fwp());
        cmd.args(["proto", "--grpc", "svc.fwp"]).current_dir(&d);
        let o = run(cmd, 60);
        let r = render(&o);
        assert!(!o.status.success() && r.contains(msg), "{}: {}", text, r);
    }
    // gRPC needs the native target
    let mut cmd = Command::new(fwp());
    cmd.args(["build", "--target", "wasm32-wasi", "client.fwp", "-o"])
        .arg(d.join("c.wasm"))
        .current_dir(dir().join("hello"));
    let o = run(cmd, 60);
    assert!(!o.status.success(), "{}", render(&o));
}

// ---------------------------------------------- exported functions over gRPC

/// Every kind of call of greeter.fwp: interpreted and native servers,
/// interpreted and native clients.
#[test]
fn exported_functions_are_served() {
    let native = have_cc();
    let d = scratch("served");
    let servers = greeter_servers(native.then_some(d.as_path()));
    let client = dir().join("client.fwp");
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
    let mut outputs = Vec::new();
    for s in &servers {
        let mut cmd = Command::new(fwp());
        cmd.args(["run", "--service", "greeter"])
            .arg(&client)
            .env("FWP_SERVICE_GREETER", &s.addr);
        outputs.push(("interpreted client", render(&run(cmd, 120))));
        if native {
            let mut cmd = Command::new(split.join("client"));
            cmd.env("FWP_SERVICE_GREETER", &s.addr);
            outputs.push(("native client", render(&run(cmd, 120))));
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
        cmd.args(["run", "--service", "greeter"])
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

/// The module `fwp proto --import` generates from the .proto that `fwp
/// proto --grpc` prints calls the service.
#[test]
fn imported_proto_round_trip() {
    let native = have_cc();
    let d = scratch("roundtrip");
    let servers = greeter_servers(native.then_some(d.as_path()));
    let rt = dir().join("roundtrip");
    if native {
        build(
            &["client.fwp", "-o", d.join("client").to_str().unwrap()],
            &rt,
        );
    }
    for s in &servers {
        let mut cmd = Command::new(fwp());
        cmd.args(["run", "client.fwp", &s.addr]).current_dir(&rt);
        let out = render(&run(cmd, 120));
        expect_file(&rt.join("client.out"), &out, "interpreted client");
        if native {
            let mut cmd = Command::new(d.join("client"));
            cmd.arg(&s.addr);
            expect_file(
                &rt.join("client.out"),
                &render(&run(cmd, 120)),
                "native client",
            );
        }
    }
}

/// Server reflection and health checking, by a reflection client written
/// with a module generated from reflection.proto.
#[test]
fn reflection_and_health() {
    let native = have_cc();
    let d = scratch("reflection");
    let servers = greeter_servers(native.then_some(d.as_path()));
    let rd = dir().join("reflection");
    if native {
        build(
            &["client.fwp", "-o", d.join("client").to_str().unwrap()],
            &rd,
        );
    }
    for s in &servers {
        let mut cmd = Command::new(fwp());
        cmd.args(["run", "client.fwp", &s.addr]).current_dir(&rd);
        expect_file(
            &rd.join("client.out"),
            &render(&run(cmd, 120)),
            "interpreted client",
        );
        if native {
            let mut cmd = Command::new(d.join("client"));
            cmd.arg(&s.addr);
            expect_file(
                &rd.join("client.out"),
                &render(&run(cmd, 120)),
                "native client",
            );
        }
    }
}

// --------------------------------------------- services from a .proto file

/// A service implemented from hello.proto with `grpc.serve` and the
/// generated routes, and called with the generated client functions.
#[test]
fn routes_from_a_proto_file() {
    let native = have_cc();
    let d = scratch("hello");
    let hd = dir().join("hello");
    let mut servers = Vec::new();
    let mut cmd = Command::new(fwp());
    cmd.args(["run", "server.fwp", "127.0.0.1:0"])
        .current_dir(&hd);
    servers.push(start(cmd));
    if native {
        build(
            &["server.fwp", "-o", d.join("server").to_str().unwrap()],
            &hd,
        );
        build(
            &["client.fwp", "-o", d.join("client").to_str().unwrap()],
            &hd,
        );
        let mut cmd = Command::new(d.join("server"));
        cmd.arg("127.0.0.1:0");
        servers.push(start(cmd));
    }
    for s in &servers {
        let mut cmd = Command::new(fwp());
        cmd.args(["run", "client.fwp", &s.addr]).current_dir(&hd);
        expect_file(
            &hd.join("client.out"),
            &render(&run(cmd, 120)),
            "interpreted client",
        );
        if native {
            let mut cmd = Command::new(d.join("client"));
            cmd.arg(&s.addr);
            expect_file(
                &hd.join("client.out"),
                &render(&run(cmd, 120)),
                "native client",
            );
        }
    }
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

/// grpcurl (grpc-go), when installed: reflection, calls, streams,
/// metadata, deadlines and health checks.
#[test]
fn grpcurl_interoperates() {
    if !have("grpcurl", "-version") {
        return;
    }
    let d = scratch("grpcurl");
    let servers = greeter_servers(have_cc().then_some(d.as_path()));
    for s in &servers {
        let mut out = String::new();
        let calls: Vec<(Vec<&str>, Vec<&str>)> = vec![
            (vec![], vec!["list"]),
            (vec![], vec!["describe", "test.Greeter.Count"]),
            (
                vec!["-d", r#"{"name": "Ada"}"#],
                vec!["test.Greeter/SayHello"],
            ),
            (vec!["-d", r#"{"arg1": 3}"#], vec!["test.Greeter/Count"]),
            (
                vec!["-d", r#"{"arg1": 1} {"arg1": 2}"#],
                vec!["test.Greeter/Total"],
            ),
            (
                vec!["-d", r#"{"arg1": "a"} {"arg1": "b"}"#],
                vec!["test.Greeter/Shout"],
            ),
            (vec!["-H", "x-user: grpcurl"], vec!["test.Greeter/Whoami"]),
            (
                vec!["-d", r#"{"arg1": "ghost"}"#],
                vec!["test.Greeter/Find"],
            ),
            (
                vec!["-d", r#"{"arg1": 8, "arg2": 0}"#],
                vec!["test.Greeter/Divide"],
            ),
            (
                vec!["-d", r#"{"arg1": 2000}"#, "-max-time", "0.5"],
                vec!["test.Greeter/Nap"],
            ),
            (vec![], vec!["grpc.health.v1.Health/Check"]),
        ];
        for (flags, tail) in calls {
            let mut cmd = Command::new("grpcurl");
            cmd.arg("-plaintext").args(&flags).arg(&s.addr).args(&tail);
            out.push_str(&format!(
                "$ grpcurl {} {}\n",
                flags.join(" "),
                tail.join(" ")
            ));
            // the server or grpcurl may notice the deadline first
            out.push_str(&render(&run(cmd, 60)).replace("context deadline", "deadline"));
        }
        expect_file(&dir().join("grpcurl.out"), &out, "grpcurl");
    }
}
