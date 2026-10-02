//! fwp in the browser: fwp itself (compiler and interpreter) built for
//! `wasm32-wasip1` and run under node, both with node's WASI and with the
//! playground's own WASI (web/wasi.js), which is what the browser uses.
//!
//! * the golden programs of tests/run must print their `.out` files, except
//!   the programs that the WebAssembly build rejects before they start
//!   (tasks, sockets, foreign C functions: see `rejected`);
//! * `fwp check`, `fwp fmt` and `fwp lint` must behave as the native build;
//! * the tutorials must run through the playground's WASI with a stack as
//!   small as a browser's;
//! * commands that need a C compiler, processes or sockets fail clearly.
//!
//! Skipped when the `wasm32-wasip1` Rust target or node is missing. fwp.wasm
//! is built once per run of this test binary, into target/wasm-fwp.

use std::io::Write;
use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};
use std::sync::OnceLock;

fn root() -> &'static Path {
    Path::new(env!("CARGO_MANIFEST_DIR"))
}

fn native_fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

/// fwp.wasm, built on first use; `None` (and a note) when it cannot be.
fn fwp_wasm() -> Option<&'static Path> {
    static WASM: OnceLock<Option<PathBuf>> = OnceLock::new();
    WASM.get_or_init(|| {
        let sysroot = Command::new(std::env::var("RUSTC").unwrap_or_else(|_| "rustc".into()))
            .args(["--print", "sysroot"])
            .output()
            .ok()
            .map(|o| PathBuf::from(String::from_utf8_lossy(&o.stdout).trim()));
        let have_target = sysroot.is_some_and(|s| s.join("lib/rustlib/wasm32-wasip1").is_dir());
        let have_node = Command::new("node").arg("--version").output().is_ok();
        if !have_target || !have_node {
            eprintln!("skipping: needs the wasm32-wasip1 Rust target and node");
            return None;
        }
        let target_dir = root().join("target/wasm-fwp");
        let out = Command::new(std::env::var("CARGO").unwrap_or_else(|_| "cargo".into()))
            .args([
                "build",
                "--release",
                "--bin",
                "fwp",
                "--target",
                "wasm32-wasip1",
            ])
            .arg("--target-dir")
            .arg(&target_dir)
            .current_dir(root())
            .env_remove("RUSTFLAGS")
            .env_remove("CARGO_ENCODED_RUSTFLAGS")
            .output()
            .expect("run cargo");
        assert!(
            out.status.success(),
            "building fwp for wasm32-wasip1 failed:\n{}",
            String::from_utf8_lossy(&out.stderr)
        );
        Some(target_dir.join("wasm32-wasip1/release/fwp.wasm"))
    })
    .as_deref()
}

/// How fwp.wasm is run: node's WASI, or the playground's (web/wasi.js).
#[derive(Clone, Copy)]
enum Host {
    NodeWasi,
    /// with the engine stack of a worker, in MiB
    Playground(u32),
}

struct Run {
    stdout: String,
    stderr: String,
    code: i32,
}

impl Run {
    /// stdout, then stderr and the exit code if any, as in tests/run/*.out
    fn render(&self) -> String {
        let mut s = self.stdout.clone();
        if !self.stderr.is_empty() {
            s.push_str("--- stderr\n");
            s.push_str(&self.stderr);
        }
        if self.code != 0 {
            s.push_str(&format!("--- exit {}\n", self.code));
        }
        s
    }
}

fn output(mut cmd: Command, dir: &Path, stdin: &[u8]) -> Run {
    let mut child = cmd
        .current_dir(dir)
        .env("FWP_SEED", "42")
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(stdin).unwrap();
    let out = child.wait_with_output().unwrap();
    Run {
        stdout: String::from_utf8_lossy(&out.stdout).into_owned(),
        stderr: String::from_utf8_lossy(&out.stderr).into_owned(),
        code: out.status.code().unwrap_or(-1),
    }
}

/// Run fwp.wasm with `args` in `dir`.
fn wasm(wasm: &Path, host: Host, dir: &Path, args: &[&str], stdin: &[u8]) -> Run {
    let mut cmd = Command::new("node");
    cmd.arg("--no-warnings")
        .arg(root().join("tests/wasm/fwp-run.mjs"));
    match host {
        Host::NodeWasi => {
            cmd.arg("wasi");
        }
        Host::Playground(mb) => {
            cmd.arg("shim").env("FWP_STACK_MB", mb.to_string());
        }
    }
    cmd.arg(wasm).args(args);
    output(cmd, dir, stdin)
}

/// Run the native fwp with `args` in `dir`.
fn native(dir: &Path, args: &[&str], stdin: &[u8]) -> Run {
    let mut cmd = Command::new(native_fwp());
    cmd.args(args);
    output(cmd, dir, stdin)
}

/// A program the WebAssembly build of fwp rejects before it starts: one
/// line on stderr naming what is missing, exit code 1.
fn rejected(r: &Run) -> bool {
    r.stdout.is_empty()
        && r.code == 1
        && r.stderr.lines().count() == 1
        && (r
            .stderr
            .contains("is not available in the WebAssembly build of fwp")
            || r.stderr
                .contains("are not available in the WebAssembly build of fwp")
            || r.stderr
                .contains("the WebAssembly build of fwp does not provide the"))
}

fn golden_programs() -> Vec<PathBuf> {
    let mut v: Vec<PathBuf> = std::fs::read_dir(root().join("tests/run"))
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    v.sort();
    v
}

fn run_goldens(host: Host) {
    let Some(w) = fwp_wasm() else { return };
    let (mut ran, mut skipped, mut failures) = (0, Vec::new(), Vec::new());
    for path in golden_programs() {
        let name = path.file_name().unwrap().to_str().unwrap();
        let want = std::fs::read_to_string(path.with_extension("out")).unwrap();
        let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
        let got = wasm(w, host, path.parent().unwrap(), &["run", name], &input);
        if rejected(&got) {
            skipped.push(name.to_string());
            continue;
        }
        ran += 1;
        if got.render() != want {
            failures.push(format!(
                "{}:\n--- expected\n{}--- got\n{}",
                name,
                want,
                got.render()
            ));
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
    // the programs with tasks, sockets or C: nothing else
    assert!(
        skipped.len() <= 6,
        "too many programs rejected: {:?}",
        skipped
    );
    assert!(ran >= 25, "only {} programs ran", ran);
}

#[test]
fn golden_programs_under_node_wasi() {
    run_goldens(Host::NodeWasi);
}

#[test]
fn golden_programs_under_the_playground_wasi() {
    run_goldens(Host::Playground(512));
}

#[test]
fn rejections_name_what_is_missing() {
    let Some(w) = fwp_wasm() else { return };
    let dir = root().join("tests/run");
    for (file, message) in [
        (
            "http.fwp",
            "fwp run: the WebAssembly build of fwp does not provide the `Network` effect (used by `tcp.listen`)\n",
        ),
        (
            "net.fwp",
            "fwp run: the WebAssembly build of fwp does not provide the `Async` effect (used by `task.within`)\n",
        ),
        (
            "ffi.fwp",
            "fwp run: foreign C functions are not available in the WebAssembly build of fwp (`strchr`)\n",
        ),
    ] {
        let r = wasm(w, Host::NodeWasi, &dir, &["run", file], b"");
        assert_eq!((r.stderr.as_str(), r.code), (message, 1), "{}", file);
    }
}

/// Deep recursion still traps as fwp does when the engine's stack, not
/// fwp's, runs out (and the output before it is kept).
#[test]
fn engine_stack_overflow_is_a_trap() {
    let Some(w) = fwp_wasm() else { return };
    let dir = std::env::temp_dir().join(format!("fwp-browser-deep-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    std::fs::write(
        dir.join("deep.fwp"),
        "rec down = match\n    0 -> 0\n    _ -> sub 1 | down | add 1\n\n\
         main = [print \"before\", 1000000 | down | echo] | ignore\n",
    )
    .unwrap();
    let r = wasm(w, Host::Playground(1), &dir, &["run", "deep.fwp"], b"");
    let _ = std::fs::remove_dir_all(&dir);
    assert_eq!(
        r.render(),
        "before\n--- stderr\nfwp: trap: stack overflow\n--- exit 101\n"
    );
}

/// The tutorials (the playground's examples) under the playground's WASI,
/// with a 1 MiB stack, as in a browser.
#[test]
fn tutorials_in_the_playground() {
    let Some(w) = fwp_wasm() else { return };
    let mut ran = 0;
    let mut tutorials: Vec<PathBuf> = std::fs::read_dir(root().join("docs/tutorials"))
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.join("main.fwp").exists())
        .collect();
    tutorials.sort();
    for dir in tutorials {
        let got = wasm(w, Host::Playground(1), &dir, &["run", "main.fwp"], b"");
        if rejected(&got) {
            continue;
        }
        let want = std::fs::read_to_string(dir.join("main.out")).unwrap();
        assert_eq!(got.render(), want, "{}", dir.display());
        ran += 1;
    }
    assert!(ran >= 10, "only {} tutorials ran", ran);
}

/// `fwp check` prints what the native build prints, errors included.
#[test]
fn check_matches_native() {
    let Some(w) = fwp_wasm() else { return };
    let dir = root().join("tests/check");
    let mut files: Vec<String> = std::fs::read_dir(&dir)
        .unwrap()
        .map(|e| e.unwrap().file_name().to_string_lossy().into_owned())
        .filter(|n| n.ends_with(".fwp"))
        .collect();
    files.sort();
    let mut failures = Vec::new();
    for (i, f) in files.iter().enumerate() {
        // node's WASI and the playground's, in turn
        let host = if i % 2 == 0 {
            Host::NodeWasi
        } else {
            Host::Playground(512)
        };
        let got = wasm(w, host, &dir, &["check", f], b"").render();
        let want = native(&dir, &["check", f], b"").render();
        if got != want {
            failures.push(format!("{}:\n--- native\n{}--- wasm\n{}", f, want, got));
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

/// `fwp fmt` and `fwp lint`, on files and on standard input.
#[test]
fn fmt_and_lint() {
    let Some(w) = fwp_wasm() else { return };
    for host in [Host::NodeWasi, Host::Playground(512)] {
        let r = wasm(
            w,
            host,
            root(),
            &["fmt", "--check", "lib", "examples", "docs/tutorials"],
            b"",
        );
        assert_eq!((r.stdout.as_str(), r.stderr.as_str(), r.code), ("", "", 0));

        let r = wasm(w, host, root(), &["fmt", "-"], b"main  =   [1,2] | echo\n");
        assert_eq!(r.render(), "main = [1, 2] | echo\n");
        let r = wasm(w, host, root(), &["fmt", "--check", "-"], b"main  =  1\n");
        assert_eq!(r.render(), "<stdin>\n--- exit 1\n");

        let dir = root().join("tests/lint");
        let got = wasm(w, host, &dir, &["lint", "rules.fwp"], b"").render();
        let want = native(&dir, &["lint", "rules.fwp"], b"").render();
        assert_eq!(got, want);
    }
}

/// The playground formats files in its in-memory file system too.
#[test]
fn fmt_rewrites_files_in_the_playground() {
    let Some(w) = fwp_wasm() else { return };
    let dir = std::env::temp_dir().join(format!("fwp-browser-fmt-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    std::fs::write(dir.join("a.fwp"), "main  =   [1,2] | echo\n").unwrap();
    let mut cmd = Command::new("node");
    cmd.arg("--no-warnings")
        .arg(root().join("tests/wasm/fwp-run.mjs"))
        .arg("shim")
        .arg(w)
        .args(["fmt", "a.fwp"])
        .env("FWP_SHOW_FILE", "a.fwp");
    let r = output(cmd, &dir, b"");
    // the file on disk is not touched: the shim works on a copy
    let on_disk = std::fs::read_to_string(dir.join("a.fwp")).unwrap();
    let _ = std::fs::remove_dir_all(&dir);
    assert_eq!(r.render(), "--- a.fwp\nmain = [1, 2] | echo\n");
    assert_eq!(on_disk, "main  =   [1,2] | echo\n");
}

/// A program on standard input (`-`), and the commands that cannot work
/// without a C compiler, processes or sockets.
#[test]
fn stdin_programs_and_unavailable_commands() {
    let Some(w) = fwp_wasm() else { return };
    let dir = root().join("examples");
    let r = wasm(
        w,
        Host::NodeWasi,
        &dir,
        &["run", "-"],
        b"main = print \"hi\"\n",
    );
    assert_eq!(r.render(), "hi\n");
    let r = wasm(w, Host::NodeWasi, &dir, &["check", "-"], b"twice = mul 2\n");
    assert_eq!(r.render(), "twice : a -> a where Mul[a], IntLit[a]\n");
    let r = wasm(w, Host::NodeWasi, &dir, &["test", "--std"], b"");
    assert!(r.stdout.ends_with(" passed, 0 failed\n"), "{}", r.render());

    for (args, what) in [
        (&["build", "hello.fwp"][..], "compiling with `fwp build`"),
        (&["pipe", "a.fwp:f"][..], "`fwp pipe`"),
        (&["serve", "a.fwp", "m"][..], "`fwp serve`"),
        (
            &["test", "hello.fwp", "--native"][..],
            "`fwp test --native`",
        ),
        (&["run", "--link", "x.c", "hello.fwp"][..], "`--link`"),
    ] {
        let r = wasm(w, Host::NodeWasi, &dir, args, b"");
        assert_eq!(r.code, 2, "{:?}", args);
        assert!(
            r.stderr.starts_with(&format!("fwp: {}", what))
                && r.stderr
                    .ends_with("is not available in the WebAssembly build of fwp\n"),
            "{:?}: {}",
            args,
            r.stderr
        );
    }
}
