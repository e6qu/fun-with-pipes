//! `fwp run`, `fwp exec`, `fwp test` and `fwp serve --rest` compile
//! programs to native executables by default, cached by content; the
//! interpreter runs them with `--interp` or `FWP_RUN=interp`, and when no C
//! compiler is found. Both must print the same.

use std::io::{BufRead, BufReader, Read, Write};
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};

fn fwp() -> &'static str {
    env!("CARGO_BIN_EXE_fwp")
}

fn root() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

fn have_cc() -> bool {
    Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok_and(|o| o.status.success())
}

struct Cache(PathBuf);

impl Cache {
    fn new(name: &str) -> Cache {
        let d = std::env::temp_dir().join(format!("fwp-aot-{}-{}", name, std::process::id()));
        let _ = std::fs::remove_dir_all(&d);
        Cache(d)
    }
    fn entries(&self) -> Vec<PathBuf> {
        match std::fs::read_dir(self.0.join("native")) {
            Ok(rd) => rd
                .map(|e| e.unwrap().path())
                .filter(|p| !p.file_name().unwrap().to_string_lossy().starts_with('.'))
                .collect(),
            Err(_) => Vec::new(),
        }
    }
    fn fwp(&self, args: &[&str]) -> Command {
        let mut c = Command::new(fwp());
        c.args(args)
            .env("FWP_CACHE_DIR", &self.0)
            .env_remove("FWP_RUN")
            .env("FWP_SEED", "42");
        c
    }
}

impl Drop for Cache {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

fn output(c: &mut Command, stdin: &[u8]) -> Output {
    let mut child = c
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(stdin).unwrap();
    child.wait_with_output().unwrap()
}

fn render(o: &Output) -> String {
    format!(
        "{}--- stderr\n{}--- exit {:?}\n",
        String::from_utf8_lossy(&o.stdout),
        String::from_utf8_lossy(&o.stderr),
        o.status.code()
    )
}

/// A server started by `fwp`, and the address it prints on stderr
/// (`... listening on [http://]host:port`). The caller kills and waits for
/// it.
#[allow(clippy::zombie_processes)]
fn start(c: &mut Command) -> (std::process::Child, String) {
    let mut child = c
        .stdout(Stdio::null())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    let mut err = BufReader::new(child.stderr.take().unwrap());
    let mut seen = String::new();
    for _ in 0..20 {
        let mut line = String::new();
        if err.read_line(&mut line).unwrap() == 0 {
            break;
        }
        seen.push_str(&line);
        if let Some(a) = line.trim().split("listening on ").nth(1) {
            let a = a.strip_prefix("http://").unwrap_or(a);
            return (child, a.to_string());
        }
    }
    let _ = child.kill();
    let _ = child.wait();
    panic!("no address in the server's output:\n{}", seen);
}

#[test]
fn run_compiles_once_and_matches_the_interpreter() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("run");
    let dir = root().join("tests/run");
    for name in ["basics.fwp", "effects.fwp", "cli_parse.fwp"] {
        let before = cache.entries().len();
        let interp = output(cache.fwp(&["run", "--interp", name]).current_dir(&dir), b"");
        assert_eq!(cache.entries().len(), before, "--interp compiled {}", name);
        let native = output(cache.fwp(&["run", name]).current_dir(&dir), b"");
        assert_eq!(render(&native), render(&interp), "{}", name);
    }
    let built = cache.entries();
    assert_eq!(built.len(), 3);
    // a second run uses the cached executable
    let before: Vec<_> = built
        .iter()
        .map(|p| std::fs::metadata(p).unwrap().len())
        .collect();
    let again = output(cache.fwp(&["run", "basics.fwp"]).current_dir(&dir), b"");
    assert!(again.status.success());
    assert_eq!(cache.entries().len(), 3);
    let after: Vec<_> = built
        .iter()
        .map(|p| std::fs::metadata(p).unwrap().len())
        .collect();
    assert_eq!(before, after);
}

#[test]
fn the_mode_comes_from_options_and_fwp_run() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("mode");
    let hello = root().join("examples/hello.fwp");
    let hello = hello.to_str().unwrap();
    let o = output(cache.fwp(&["run", hello]).env("FWP_RUN", "interp"), b"");
    assert!(o.status.success());
    assert!(cache.entries().is_empty());
    let o = output(
        cache
            .fwp(&["run", "--native", hello])
            .env("FWP_RUN", "interp"),
        b"",
    );
    assert!(o.status.success());
    assert_eq!(cache.entries().len(), 1);
    let o = output(cache.fwp(&["run", hello]).env("FWP_RUN", "jit"), b"");
    assert_eq!(o.status.code(), Some(2));
    assert!(String::from_utf8_lossy(&o.stderr).contains("FWP_RUN"));
}

#[test]
fn programs_are_interpreted_without_a_c_compiler() {
    let cache = Cache::new("nocc");
    let dir = root().join("tests/run");
    let want = output(
        cache
            .fwp(&["run", "--interp", "basics.fwp"])
            .current_dir(&dir),
        b"",
    );
    let got = output(
        cache
            .fwp(&["run", "basics.fwp"])
            .current_dir(&dir)
            .env("CC", "/nonexistent/cc"),
        b"",
    );
    assert_eq!(got.stdout, want.stdout);
    assert_eq!(got.status.code(), want.status.code());
    let err = String::from_utf8_lossy(&got.stderr);
    assert!(err.contains("no C compiler"), "{}", err);
    assert!(cache.entries().is_empty());
}

#[test]
fn exec_runs_exported_functions_natively() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("exec");
    let tools = root().join("tests/exec/tools.fwp");
    let tools = tools.to_str().unwrap();
    let cases: &[(&[&str], &[u8])] = &[
        (&["normalize"], b"  Hello\n WORLD \n"),
        (&["scale", "3"], b"1\n2\n"),
        (&["total"], b"1\n2\n3\n"),
        (&["norm", "--help"], b""),
    ];
    for (args, stdin) in cases {
        let mut a = vec!["exec", "--interp", tools];
        a.extend_from_slice(args);
        let want = output(&mut cache.fwp(&a), stdin);
        a.remove(1);
        let got = output(&mut cache.fwp(&a), stdin);
        assert_eq!(render(&got), render(&want), "{:?}", args);
    }
    assert_eq!(cache.entries().len(), 4);
}

#[test]
fn test_runs_tests_natively() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("test");
    let dir = std::env::temp_dir().join(format!("fwp-aot-testfile-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let file = dir.join("t.fwp");
    std::fs::write(
        &file,
        "double : I64 -> I64\ndouble = mul 2\n\ntest \"double\" = 2 | double | eq 4\ntest \"wrong\" = 2 | double | eq 5\n",
    )
    .unwrap();
    let f = file.to_str().unwrap();
    let want = output(&mut cache.fwp(&["test", "--interp", f]), b"");
    let got = output(&mut cache.fwp(&["test", f]), b"");
    let _ = std::fs::remove_dir_all(&dir);
    assert_eq!(render(&got), render(&want));
    assert_eq!(got.status.code(), Some(1));
    assert!(String::from_utf8_lossy(&got.stdout).contains("1 passed, 1 failed"));
    assert_eq!(cache.entries().len(), 1);
}

#[test]
fn serve_rest_runs_a_native_server() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("rest");
    let dir = std::env::temp_dir().join(format!("fwp-aot-api-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let file = dir.join("api.fwp");
    std::fs::write(
        &file,
        "# expose: rest\n# route: GET /double/{n}\nexport double : I64 -> I64\ndouble = mul 2\n",
    )
    .unwrap();
    let (mut child, addr) = start(&mut cache.fwp(&[
        "serve",
        "--rest",
        file.to_str().unwrap(),
        "--listen",
        "127.0.0.1:0",
    ]));
    let mut s = std::net::TcpStream::connect(&addr).unwrap();
    write!(
        s,
        "GET /double/21 HTTP/1.1\r\nHost: x\r\nConnection: close\r\n\r\n"
    )
    .unwrap();
    let mut resp = String::new();
    s.read_to_string(&mut resp).unwrap();
    let _ = child.kill();
    let _ = child.wait();
    let _ = std::fs::remove_dir_all(&dir);
    assert!(resp.starts_with("HTTP/1.1 200"), "{}", resp);
    assert!(resp.ends_with("42"), "{}", resp);
    assert_eq!(cache.entries().len(), 1, "the server ran interpreted");
}

#[test]
fn the_cache_has_a_directory_a_size_and_can_be_cleaned() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("clean");
    let o = cache.fwp(&["cache", "dir"]).output().unwrap();
    assert_eq!(
        String::from_utf8_lossy(&o.stdout).trim(),
        cache.0.to_string_lossy()
    );
    let tools = root().join("tests/exec/tools.fwp");
    let tools = tools.to_str().unwrap();
    for (f, input) in [
        ("normalize", "a b\n"),
        ("total", "1\n2\n"),
        ("words-of", "a b\n"),
    ] {
        let o = output(
            cache.fwp(&["exec", tools, f]).env("FWP_CACHE_MAX", "2"),
            input.as_bytes(),
        );
        assert!(o.status.success(), "{}", String::from_utf8_lossy(&o.stderr));
    }
    assert_eq!(cache.entries().len(), 2);
    assert!(cache.fwp(&["cache", "clean"]).status().unwrap().success());
    assert!(cache.entries().is_empty());
}

#[test]
fn serve_runs_a_native_service() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("service");
    let dir = root().join("examples/services");
    let want = output(
        cache
            .fwp(&["run", "--interp", "main.fwp"])
            .current_dir(&dir),
        b"",
    );
    assert!(want.status.success());
    let (mut server, addr) = start(
        cache
            .fwp(&["serve", "main.fwp", "inventory", "--listen", "127.0.0.1:0"])
            .current_dir(&dir),
    );
    let got = output(
        cache
            .fwp(&["run", "--service", "inventory", "main.fwp"])
            .current_dir(&dir)
            .env("FWP_SERVICE_INVENTORY", &addr),
        b"",
    );
    let _ = server.kill();
    let _ = server.wait();
    assert_eq!(render(&got), render(&want));
    // the service and the client, each compiled once
    assert_eq!(cache.entries().len(), 2);
}

#[test]
fn pipe_reuses_the_same_native_executable() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("pipe-same-executable");
    let spec = format!(
        "{t}:scale 2 | {t}:scale 5",
        t = root().join("tests/exec/tools.fwp").display()
    );
    let want = output(&mut cache.fwp(&["pipe", "--interp", &spec]), b"3\n");
    assert!(want.status.success(), "{}", render(&want));
    assert_eq!(want.stdout, b"30\n");
    // The cold run publishes the same cache key from both stages; warm runs
    // execute that same file while another stage updates its usage timestamp.
    for i in 0..8 {
        let got = output(&mut cache.fwp(&["pipe", &spec]), b"3\n");
        assert_eq!(render(&got), render(&want), "native run {i}");
        assert_eq!(cache.entries().len(), 1);
    }
}

#[test]
fn pipe_runs_native_stages() {
    if !have_cc() {
        return;
    }
    let cache = Cache::new("pipe");
    let spec = format!(
        "{t}:scale 10 | {t}:total",
        t = root().join("tests/exec/tools.fwp").display()
    );
    let o = output(&mut cache.fwp(&["pipe", &spec]), b"1\n2\n3\n");
    assert_eq!(
        String::from_utf8_lossy(&o.stdout),
        "60\n",
        "{}",
        String::from_utf8_lossy(&o.stderr)
    );
    assert_eq!(cache.entries().len(), 2);
}
