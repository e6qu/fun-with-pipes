//! `fwp run`, `fwp exec`, `fwp test` and `fwp serve --rest` compile
//! programs to native executables by default, cached by content; the
//! interpreter runs them only when explicitly selected. A missing native
//! compiler fails before execution. Both engines must print the same.

use std::io::{BufRead, BufReader, Read, Write};
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};
use std::time::{Duration, Instant, SystemTime};

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

/// Keep the server alive only for its test, including when assertions panic.
/// Windows retains a launcher process, so stopping it must include its child.
struct ChildProcess(std::process::Child);

impl Drop for ChildProcess {
    fn drop(&mut self) {
        if matches!(self.0.try_wait(), Ok(Some(_))) {
            return;
        }
        #[cfg(windows)]
        let _ = Command::new("taskkill")
            .args(["/PID", &self.0.id().to_string(), "/T", "/F"])
            .output();
        #[cfg(not(windows))]
        let _ = self.0.kill();
        let _ = self.0.wait();
    }
}

/// Start a server and read its `listening on [http://]host:port` diagnostic.
fn start(c: &mut Command) -> (ChildProcess, String) {
    let mut server = ChildProcess(
        c.stdout(Stdio::null())
            .stderr(Stdio::piped())
            .spawn()
            .unwrap(),
    );
    let mut err = BufReader::new(server.0.stderr.take().unwrap());
    let mut seen = String::new();
    for _ in 0..20 {
        let mut line = String::new();
        if err.read_line(&mut line).unwrap() == 0 {
            break;
        }
        seen.push_str(&line);
        if let Some(a) = line.trim().split("listening on ").nth(1) {
            let a = a.strip_prefix("http://").unwrap_or(a);
            return (server, a.to_string());
        }
    }
    panic!("no address in the server's output:\n{}", seen);
}

#[test]
fn run_compiles_once_and_matches_the_interpreter() {
    assert!(have_cc(), "native command checks require a C compiler");
    let cache = Cache::new("run");
    let dir = root().join("tests/run");
    let mut basics = None;
    for name in ["basics.fwp", "effects.fwp", "cli_parse.fwp"] {
        let before = cache.entries().len();
        let interp = output(cache.fwp(&["run", "--interp", name]).current_dir(&dir), b"");
        assert_eq!(cache.entries().len(), before, "--interp compiled {}", name);
        let native = output(cache.fwp(&["run", name]).current_dir(&dir), b"");
        assert_eq!(render(&native), render(&interp), "{}", name);
        if name == "basics.fwp" {
            basics = Some(cache.entries().into_iter().next().unwrap());
        }
    }
    let built = cache.entries();
    assert_eq!(built.len(), 3);
    // a second run uses the cached executable
    let before: Vec<_> = built
        .iter()
        .map(|p| std::fs::metadata(p).unwrap().len())
        .collect();
    let basics = basics.unwrap();
    let old = SystemTime::UNIX_EPOCH + Duration::from_secs(60);
    std::fs::OpenOptions::new()
        .write(true)
        .open(&basics)
        .unwrap()
        .set_modified(old)
        .unwrap();
    let again = output(cache.fwp(&["run", "basics.fwp"]).current_dir(&dir), b"");
    assert!(again.status.success());
    assert_eq!(cache.entries().len(), 3);
    let after: Vec<_> = built
        .iter()
        .map(|p| std::fs::metadata(p).unwrap().len())
        .collect();
    assert_eq!(before, after);
    assert!(
        std::fs::metadata(basics).unwrap().modified().unwrap() > old,
        "cache hits must refresh eviction timestamps without writing executable data"
    );
}

#[test]
fn concurrent_compilers_publish_one_immutable_cached_executable() {
    assert!(have_cc(), "native publication checks require a C compiler");
    let cache = Cache::new("publication");
    let native = cache.0.join("native");
    std::fs::create_dir_all(&native).unwrap();
    let publication = std::fs::OpenOptions::new()
        .create(true)
        .truncate(false)
        .read(true)
        .write(true)
        .open(native.join(".publish.lock"))
        .unwrap();
    publication.lock().unwrap();
    let mut children: Vec<_> = (0..2)
        .map(|_| {
            ChildProcess(
                cache
                    .fwp(&["run", "--native", "-O0"])
                    .arg(root().join("examples/hello.fwp"))
                    .stdout(Stdio::piped())
                    .stderr(Stdio::piped())
                    .spawn()
                    .unwrap(),
            )
        })
        .collect();
    let deadline = Instant::now() + Duration::from_secs(60);
    loop {
        for child in &mut children {
            assert!(
                child.0.try_wait().unwrap().is_none(),
                "compiler bypassed the publication lock"
            );
        }
        let ready = std::fs::read_dir(&native)
            .unwrap()
            .filter(|entry| {
                let entry = entry.as_ref().unwrap();
                entry.file_name().to_string_lossy().ends_with(".tmp")
                    && entry.metadata().unwrap().len() > 0
            })
            .count();
        if ready == 2 {
            break;
        }
        assert!(
            Instant::now() < deadline,
            "compilers did not prepare both private images"
        );
        std::thread::sleep(Duration::from_millis(10));
    }
    assert!(
        cache.entries().is_empty(),
        "published an image while its lock was held"
    );
    drop(publication);
    for mut child in children {
        let status = child.0.wait().unwrap();
        let mut stdout = Vec::new();
        let mut stderr = Vec::new();
        child
            .0
            .stdout
            .take()
            .unwrap()
            .read_to_end(&mut stdout)
            .unwrap();
        child
            .0
            .stderr
            .take()
            .unwrap()
            .read_to_end(&mut stderr)
            .unwrap();
        assert!(status.success(), "{}", String::from_utf8_lossy(&stderr));
        assert_eq!(stdout, b"hello, world\n");
        assert!(stderr.is_empty());
    }
    assert_eq!(cache.entries().len(), 1);
    assert!(std::fs::read_dir(&native).unwrap().all(|entry| !entry
        .unwrap()
        .file_name()
        .to_string_lossy()
        .ends_with(".tmp")));
}

#[test]
fn the_mode_comes_from_options_and_fwp_run() {
    assert!(have_cc(), "native command checks require a C compiler");
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
fn missing_native_compiler_fails_without_running_the_program() {
    let cache = Cache::new("nocc");
    let dir = root().join("tests/run");
    let want = output(
        cache
            .fwp(&["run", "--interp", "basics.fwp"])
            .current_dir(&dir)
            .env("CC", "/nonexistent/cc"),
        b"",
    );
    assert!(want.status.success() && !want.stdout.is_empty());
    for mode in [None, Some("native"), Some("interp")] {
        let mut command = cache.fwp(&["run", "--native", "basics.fwp"]);
        command.current_dir(&dir).env("CC", "/nonexistent/cc");
        if let Some(mode) = mode {
            command.env("FWP_RUN", mode);
        }
        let got = output(&mut command, b"");
        assert_eq!(got.status.code(), Some(1), "{}", render(&got));
        assert!(
            got.stdout.is_empty(),
            "missing compiler executed program effects"
        );
        assert!(
            String::from_utf8_lossy(&got.stderr).contains("no C compiler"),
            "{}",
            render(&got)
        );
    }
    assert!(cache.entries().is_empty());
}

#[test]
fn integer_cache_tracks_header_search_paths() {
    assert!(have_cc(), "native cache checks require a C compiler");
    let cache = Cache::new("integer-header-paths");
    let dir = fwp::cgen::TempDir::new("integer-header-paths").unwrap();
    let first = dir.join("first");
    let second = dir.join("second");
    std::fs::create_dir(&first).unwrap();
    std::fs::create_dir(&second).unwrap();
    std::fs::write(first.join("answer.h"), "#define ANSWER 41\n").unwrap();
    std::fs::write(second.join("answer.h"), "#define ANSWER 42\n").unwrap();
    let host = dir.join("answer.c");
    std::fs::write(&host, "#include <stdint.h>\n#include <answer.h>\nint64_t cached_answer(int64_t n) { return n + ANSWER; }\n").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(
        &source,
        "foreign \"C\" answer : I64 -> I64 = \"cached_answer\"\nmain = 0 | answer | echo\n",
    )
    .unwrap();
    let cfile = dir.join("main.c");
    let emitted = Command::new(fwp())
        .args(["build", "--emit-c"])
        .arg(&source)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{}", render(&emitted));
    assert!(!std::fs::read_to_string(cfile)
        .unwrap()
        .contains(fwp::float_codegen::MARK));
    for (headers, expected, entries) in [
        (&first, b"41\n", 1),
        (&second, b"42\n", 2),
        (&second, b"42\n", 2),
    ] {
        let result = output(
            cache
                .fwp(&["run", "--native", "--link"])
                .arg(&host)
                .arg(&source)
                .env("C_INCLUDE_PATH", headers)
                .env("CXX", "/nonexistent/cxx"),
            b"",
        );
        assert!(result.status.success(), "{}", render(&result));
        assert_eq!(result.stdout, expected, "{}", render(&result));
        assert_eq!(cache.entries().len(), entries);
    }
    std::fs::write(second.join("answer.h"), "#define ANSWER 43\n").unwrap();
    let changed = output(
        cache
            .fwp(&["run", "--native", "--link"])
            .arg(&host)
            .arg(&source)
            .env("C_INCLUDE_PATH", &second),
        b"",
    );
    assert!(changed.status.success(), "{}", render(&changed));
    assert_eq!(changed.stdout, b"43\n", "{}", render(&changed));
    assert_eq!(cache.entries().len(), 3);
    let selected = dir.join("selected");
    std::fs::create_dir(&selected).unwrap();
    let include = format!("-I{}", selected.display());
    for (answer, entries) in [(44, 4), (45, 5)] {
        std::fs::write(
            selected.join("answer.h"),
            format!("#define ANSWER {answer}\n"),
        )
        .unwrap();
        let explicit = output(
            cache
                .fwp(&["run", "--native", "--link"])
                .arg(&host)
                .arg("--link")
                .arg(&include)
                .arg(&source)
                .env("C_INCLUDE_PATH", &second),
            b"",
        );
        assert!(explicit.status.success(), "{}", render(&explicit));
        assert_eq!(explicit.stdout, format!("{answer}\n").as_bytes());
        assert_eq!(cache.entries().len(), entries);
    }
    std::fs::remove_file(second.join("answer.h")).unwrap();
    let missing = output(
        cache
            .fwp(&["run", "--native", "--link"])
            .arg(&host)
            .arg(&source)
            .env("C_INCLUDE_PATH", &second),
        b"",
    );
    assert!(!missing.status.success(), "{}", render(&missing));
    assert!(String::from_utf8_lossy(&missing.stderr).contains("answer.h"));
    assert!(missing.stdout.is_empty());
}

#[test]
fn exec_runs_exported_functions_natively() {
    assert!(have_cc(), "native command checks require a C compiler");
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
    assert!(have_cc(), "native command checks require a C compiler");
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
    assert!(have_cc(), "native command checks require a C compiler");
    let cache = Cache::new("rest");
    let dir = std::env::temp_dir().join(format!("fwp-aot-api-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let file = dir.join("api.fwp");
    std::fs::write(
        &file,
        "# expose: rest\n# route: GET /double/{n}\nexport double : I64 -> I64\ndouble = mul 2\n",
    )
    .unwrap();
    let (server, addr) = start(&mut cache.fwp(&[
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
    drop(server);
    assert!(
        std::net::TcpStream::connect(&addr).is_err(),
        "REST server survived cleanup"
    );
    let _ = std::fs::remove_dir_all(&dir);
    assert!(resp.starts_with("HTTP/1.1 200"), "{}", resp);
    assert!(resp.ends_with("42"), "{}", resp);
    assert_eq!(cache.entries().len(), 1, "the server ran interpreted");
}

#[test]
fn the_cache_has_a_directory_a_size_and_can_be_cleaned() {
    assert!(have_cc(), "native command checks require a C compiler");
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
    assert!(have_cc(), "native command checks require a C compiler");
    let cache = Cache::new("service");
    let dir = root().join("examples/services");
    let want = output(
        cache
            .fwp(&["run", "--interp", "main.fwp"])
            .current_dir(&dir),
        b"",
    );
    assert!(want.status.success());
    let (server, addr) = start(
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
    drop(server);
    assert!(
        std::net::TcpStream::connect(&addr).is_err(),
        "service survived cleanup"
    );
    assert_eq!(render(&got), render(&want));
    // the service and the client, each compiled once
    assert_eq!(cache.entries().len(), 2);
}

#[test]
fn pipe_reuses_the_same_native_executable() {
    assert!(have_cc(), "native command checks require a C compiler");
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
        let got = output(
            cache
                .fwp(&["pipe", "--native", &spec])
                .env("FWP_RUN", "interp"),
            b"3\n",
        );
        assert_eq!(render(&got), render(&want), "native run {i}");
        assert_eq!(cache.entries().len(), 1);
    }
}

#[test]
fn pipe_runs_native_stages() {
    assert!(have_cc(), "native command checks require a C compiler");
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

#[test]
fn native_ownership_modes_are_explicit_and_part_of_the_cache() {
    assert!(have_cc(), "native ownership checks require a C compiler");
    let cache = Cache::new("ownership-mode");
    let dir = fwp::cgen::TempDir::new("ownership-mode").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, "main = \"abc\" | string.repeat 7 | echo\n").unwrap();
    let mut cached = Vec::new();
    for mode in ["arc", "tracing", "arc"] {
        let actual = output(cache.fwp(&["run", "--gc", mode]).arg(&source), b"");
        assert!(actual.status.success(), "{}", render(&actual));
        assert_eq!(actual.stdout, b"abcabcabcabcabcabcabc\n");
        let entries = cache.entries();
        assert_eq!(entries.len(), if cached.is_empty() { 1 } else { 2 });
        if cached.is_empty() {
            let symbols = Command::new("nm").arg(&entries[0]).output().unwrap();
            assert!(symbols.status.success(), "{}", render(&symbols));
            for name in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                assert!(!String::from_utf8_lossy(&symbols.stdout).contains(name));
            }
            cached = entries;
        }
    }
    let bad = dir.join("bad.fwp");
    std::fs::write(
        &bad,
        "test \"good\" = True\ntest \"missing scope\" = () | get | eq 0\n",
    )
    .unwrap();
    let rejected = output(cache.fwp(&["test", "--gc", "arc"]).arg(&bad), b"");
    assert_eq!(rejected.status.code(), Some(1), "{}", render(&rejected));
    assert!(
        rejected.stdout.is_empty(),
        "a test ran before ownership validation"
    );
    assert!(
        String::from_utf8_lossy(&rejected.stderr).contains("outside a State scope"),
        "{}",
        render(&rejected)
    );
    for options in [
        vec!["--gc"],
        vec!["--gc=unknown"],
        vec!["--gc=arc", "--gc=tracing"],
        vec!["--interp", "--gc=arc"],
    ] {
        let rejected = output(cache.fwp(&["run"]).args(&options).arg(&source), b"");
        assert_eq!(
            rejected.status.code(),
            Some(2),
            "{options:?}: {}",
            render(&rejected)
        );
        assert!(rejected.stdout.is_empty());
    }
    let tools = root().join("tests/exec/tools.fwp");
    let spec = format!("{t}:scale 2 | {t}:total", t = tools.display());
    let pipeline = output(&mut cache.fwp(&["pipe", "--gc", "arc", &spec]), b"1\n2\n");
    assert!(pipeline.status.success(), "{}", render(&pipeline));
    assert_eq!(pipeline.stdout, b"6\n");
}

#[test]
fn failed_native_tests_release_errors_and_print_buffers() {
    assert!(have_cc(), "native cleanup checks require a C compiler");
    fwp::driver::with_big_stack(|| {
        let cache = Cache::new("test-cleanup");
        let directory = fwp::cgen::TempDir::new("test-cleanup").unwrap();
        let file = directory.join("tests.fwp");
        let mut source = String::from("test \"before\" = True\n");
        for i in 0..64 {
            source.push_str(&format!(
                "test \"owned error {i}\" = \"owned\" | string.repeat 7 | fail\n"
            ));
        }
        source.push_str(
            "test \"scalar error\" = fail 7\ntest \"false\" = False\ntest \"after\" = True\n",
        );
        source.push_str(include_str!("fixtures/test_recovery.fwp"));
        std::fs::write(&file, &source).unwrap();
        let reference = output(cache.fwp(&["test", "--interp"]).arg(&file), b"");
        assert_eq!(reference.status.code(), Some(1), "{}", render(&reference));
        assert!(String::from_utf8_lossy(&reference.stdout).contains("5 passed, 71 failed"));
        assert!(String::from_utf8_lossy(&reference.stdout)
            .contains("visible output\ntest output ... ok"));
        let (_, program) = fwp::driver::compile_source(
            "native-test-cleanup.fwp",
            &source,
            fwp::mono::Roots {
                tests: true,
                ..Default::default()
            },
        )
        .unwrap_or_else(|failure| panic!("{}", failure.rendered));
        let artifacts = std::env::var_os("FWP_NATIVE_COMMAND_ARTIFACTS").map(PathBuf::from);
        if let Some(path) = &artifacts {
            std::fs::create_dir_all(path).unwrap();
        }
        for arc in [false, true] {
            let mode = if arc { "arc" } else { "tracing" };
            let native = output(cache.fwp(&["test", "--gc", mode]).arg(&file), b"");
            assert_eq!(render(&native), render(&reference), "{mode}");
            fwp::cgen::set_native_options(fwp::cgen::NativeOptions {
                arc,
                ..Default::default()
            });
            let code = fwp::cgen::generate_tests(&program).unwrap();
            let marker = "static void fwp_buf_release(void *arg) { free(((fwp_buf *)arg)->d); }";
            assert_eq!(code.matches(marker).count(), 1);
            let measured = code.replace(marker, r#"
static void *test_buffers[128];
static size_t test_live_buffers;
static void test_buffer_register(void *pointer) {
    if (!pointer) return;
    for (size_t i=0; i<128; i++) if (!test_buffers[i]) {
        test_buffers[i]=pointer; test_live_buffers++; return;
    }
    exit(235);
}
static void test_buffer_free(void *pointer) {
    for (size_t i=0; i<128; i++) if (pointer && test_buffers[i]==pointer) {
        test_buffers[i]=NULL; test_live_buffers--; break;
    }
    free(pointer);
}
static void fwp_buf_release(void *arg) { test_buffer_free(((fwp_buf *)arg)->d); }
"#).replace("            fwp_write(&b, h.value, h.desc, 1);",
               "            fwp_write(&b, h.value, h.desc, 1); test_buffer_register(b.d);")
                .replace("memcpy(fwp_test_message, message, bytes);",
                    "memcpy(fwp_test_message, message, bytes); test_buffer_register(fwp_test_message);")
                .replace("free(fwp_test_message);", "test_buffer_free(fwp_test_message);")
                .replace("    /* Ownership observation point: before runtime teardown. */",
                    "    /* Ownership observation point: before runtime teardown. */\n    if(test_live_buffers)exit(234);\n    if(fwp_gc.budget < fwp_gc.budget_given)exit(233);");
            for opt in ["-O0", "-O2"] {
                let mut cases = vec![("protected", measured.clone(), 1)];
                // Exercise the root cancellation path at the exit primitive.
                // Its expected diagnostic differs; later tests must still run.
                let cancellation = measured.replace(
                    "fwp_test_abort(2, NULL, (int32_t)code);",
                    "test_cancel_root();",
                );
                assert_ne!(cancellation, measured);
                let cancellation = format!("static void test_cancel_root(void);\n{cancellation}\nstatic void test_cancel_root(void) {{ fwp_tasks_init(); fwp_cur->cancelled = 1; fwp_check_cancel(); }}\n");
                cases.push(("root-cancellation", cancellation, 1));
                if arc {
                    cases.push((
                        "missing-error",
                        measured.replace("fwp_value_release(&error);", "/* omit error release */"),
                        233,
                    ));
                    cases.push((
                        "missing-buffer",
                        measured.replace(
                            "test_buffer_free(((fwp_buf *)arg)->d);",
                            "/* omit actual buffer free */",
                        ),
                        234,
                    ));
                    cases.push((
                        "missing-trap-message",
                        measured.replace(
                            "test_buffer_free(fwp_test_message);",
                            "/* omit actual trap message free */",
                        ),
                        234,
                    ));
                }
                for (control, generated, status) in cases {
                    let label = format!("tests-{mode}{opt}-{control}");
                    let binary = directory.join(format!("{label}.exe"));
                    fwp::cgen::compile_c(&generated, &binary, opt).unwrap();
                    let actual = Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    assert_eq!(
                        actual.status.code(),
                        Some(status),
                        "{label}: {}",
                        render(&actual)
                    );
                    let expected = if control == "root-cancellation" {
                        String::from_utf8_lossy(&reference.stdout)
                            .replace(
                                "test exit ... FAILED (exit -7)",
                                "test exit ... FAILED (cancelled)",
                            )
                            .into_bytes()
                    } else {
                        reference.stdout.clone()
                    };
                    assert_eq!(actual.stdout, expected, "{label}");
                    assert_eq!(actual.stderr, reference.stderr, "{label}");
                    if !arc && control == "protected" {
                        let stressed = Command::new(&binary)
                            .env_remove("FWP_GC")
                            .env("FWP_GC_STRESS", "1")
                            .env("FWP_GC_VERIFY", "1")
                            .env("FWP_REUSE_VERIFY", "0")
                            .output()
                            .unwrap();
                        assert_eq!(render(&stressed), render(&reference), "{label}, GC stress");
                        if let Some(path) = &artifacts {
                            std::fs::write(
                                path.join(format!("{label}-stress.stdout")),
                                stressed.stdout,
                            )
                            .unwrap();
                            std::fs::write(path.join(format!("{label}-stress.status")), "1\n")
                                .unwrap();
                        }
                    }
                    let symbols = Command::new("nm").arg(&binary).output().unwrap();
                    assert!(symbols.status.success(), "{}", render(&symbols));
                    if arc {
                        for symbol in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                            assert!(
                                !String::from_utf8_lossy(&symbols.stdout).contains(symbol),
                                "{label}: {symbol}"
                            );
                        }
                    }
                    if let Some(path) = &artifacts {
                        std::fs::write(path.join(format!("{label}.c")), generated).unwrap();
                        std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                        std::fs::write(path.join(format!("{label}.stdout")), actual.stdout)
                            .unwrap();
                        std::fs::write(path.join(format!("{label}.status")), format!("{status}\n"))
                            .unwrap();
                        std::fs::write(path.join(format!("{label}.symbols")), symbols.stdout)
                            .unwrap();
                    }
                }
            }
        }
        fwp::cgen::set_native_options(Default::default());
    });
}

#[test]
fn child_task_failures_still_terminate_test_processes() {
    assert!(
        have_cc(),
        "native child failure checks require a C compiler"
    );
    let cache = Cache::new("test-child-failure");
    let directory = fwp::cgen::TempDir::new("test-child-failure").unwrap();
    let file = directory.join("tests.fwp");
    for body in ["const \"child trap\" | prim.trap", "const 7 | exit"] {
        std::fs::write(&file, format!(
            "test \"child\" = task.spawn ({body} | const ()) | task.await | eq (Some ())\ntest \"unreachable\" = True\n"
        )).unwrap();
        let reference = output(cache.fwp(&["test", "--interp"]).arg(&file), b"");
        assert!(
            !reference.status.success(),
            "{body}: {}",
            render(&reference)
        );
        assert!(!String::from_utf8_lossy(&reference.stdout).contains("unreachable"));
        for mode in ["arc", "tracing"] {
            let native = output(cache.fwp(&["test", "--gc", mode]).arg(&file), b"");
            assert_eq!(render(&native), render(&reference), "{body}, {mode}");
        }
    }
}
