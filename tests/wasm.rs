//! WebAssembly: every golden run test is compiled with
//! `--target wasm32-wasi` and run under node's WASI; the output must match
//! the `.out` file. Programs using effects WASI does not provide (sockets,
//! processes) must be rejected at compile time. Tasks run as fibers, which
//! the JavaScript host switches with JavaScript Promise Integration
//! (web/fibers.js; on by default in node 24, which CI uses).
//! The browser target is run through its JavaScript loader. Skipped when
//! clang cannot target WASI or node is missing.

use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn dir() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("tests")
}

fn available() -> bool {
    let probe = std::env::temp_dir().join(format!("fwp-wasm-probe-{}.wasm", std::process::id()));
    let src = std::env::temp_dir().join(format!("fwp-wasm-probe-{}.c", std::process::id()));
    std::fs::write(&src, "int main(void) { return 0; }\n").unwrap();
    let ok = Command::new(std::env::var("FWP_WASM_CC").unwrap_or_else(|_| "clang".into()))
        .args(["--target=wasm32-wasi", "-o"])
        .arg(&probe)
        .arg(&src)
        .output()
        .map(|o| o.status.success())
        .unwrap_or(false)
        && Command::new("node").arg("--version").output().is_ok();
    let _ = std::fs::remove_file(&probe);
    let _ = std::fs::remove_file(&src);
    if !ok {
        eprintln!("skipping: no clang wasm32-wasi toolchain or node");
    }
    ok
}

fn render(stdout: &[u8], stderr: &[u8], code: i32) -> String {
    let mut s = String::from_utf8_lossy(stdout).to_string();
    if !stderr.is_empty() {
        s.push_str("--- stderr\n");
        s.push_str(&String::from_utf8_lossy(stderr));
    }
    if code != 0 {
        s.push_str(&format!("--- exit {}\n", code));
    }
    s
}

fn build(path: &Path, target: &str, out: &Path) -> std::process::Output {
    Command::new(fwp())
        .arg("build")
        .arg(path.file_name().unwrap())
        .args(["--target", target, "-O1", "-o"])
        .arg(out)
        .current_dir(path.parent().unwrap())
        .output()
        .unwrap()
}

#[test]
fn golden_programs_under_wasi() {
    if !available() {
        return;
    }
    let mut ran = Vec::new();
    let mut failures = Vec::new();
    let mut entries: Vec<_> = std::fs::read_dir(dir().join("run"))
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    entries.sort();
    for path in entries {
        let expected = match std::fs::read_to_string(path.with_extension("out")) {
            Ok(s) => s,
            Err(_) => continue,
        };
        let wasm = std::env::temp_dir().join(format!(
            "fwp-wasm-{}-{}.wasm",
            std::process::id(),
            path.file_stem().unwrap().to_string_lossy()
        ));
        let b = build(&path, "wasm32-wasi", &wasm);
        let stderr = String::from_utf8_lossy(&b.stderr);
        if !b.status.success() {
            if stderr.contains("does not provide the") {
                // tasks and sockets: rejected at compile time, as required
                continue;
            }
            let got = render(b"", &b.stderr, b.status.code().unwrap_or(-1));
            if got != expected {
                failures.push(format!("{}: build failed:\n{}", path.display(), stderr));
            }
            continue;
        }
        let input = std::fs::read(path.with_extension("in")).unwrap_or_default();
        let mut child = Command::new("node")
            .arg("--no-warnings")
            .arg(dir().join("wasm/wasi-run.mjs"))
            .arg(&wasm)
            .current_dir(path.parent().unwrap())
            .env("FWP_SEED", "42")
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()
            .unwrap();
        {
            use std::io::Write;
            child.stdin.take().unwrap().write_all(&input).unwrap();
        }
        let out = child.wait_with_output().unwrap();
        let _ = std::fs::remove_file(&wasm);
        let got = render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1));
        ran.push(path.file_name().unwrap().to_string_lossy().to_string());
        if got != expected {
            failures.push(format!(
                "{}:\n--- expected\n{}--- got\n{}",
                path.display(),
                expected,
                got
            ));
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
    assert!(ran.len() >= 10, "only {} programs ran", ran.len());
    for tasks in ["tasks_local.fwp", "trap_stack_overflow.fwp"] {
        assert!(ran.iter().any(|r| r == tasks), "{} did not run", tasks);
    }
}

fn run_wasi(wasm: &Path, env: &[(&str, &str)]) -> String {
    let out = Command::new("node")
        .arg("--no-warnings")
        .arg(dir().join("wasm/wasi-run.mjs"))
        .arg(wasm)
        .envs(env.iter().copied())
        .stdin(Stdio::null())
        .output()
        .unwrap();
    render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1))
}

/// Tasks as fibers: thousands waiting at once, a deadlock (which traps as
/// in native programs), and a host without JavaScript Promise Integration
/// (where starting a task traps).
#[test]
fn tasks_as_fibers() {
    if !available() {
        return;
    }
    let tmp = std::env::temp_dir().join(format!("fwp-wasm-tasks-{}", std::process::id()));
    std::fs::create_dir_all(&tmp).unwrap();
    let wasm = |name: &str, src: &str| {
        let path = tmp.join(format!("{}.fwp", name));
        std::fs::write(&path, src).unwrap();
        let wasm = tmp.join(format!("{}.wasm", name));
        let b = build(&path, "wasm32-wasi", &wasm);
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        wasm
    };
    let many = wasm(
        "many",
        "main = range 1 3001 | task.map (tap (const 20ms | task.sleep)) \
         | map (option.unwrap-or 0) | sum | echo\n",
    );
    assert_eq!(run_wasi(&many, &[]), "4501500\n");
    let deadlock = wasm(
        "deadlock",
        "the-ch : Channel[I64] -> Channel[I64]\nthe-ch = id\n\n\
         main = [print \"waiting\", 1 | channel.make | the-ch | channel.recv | echo] | ignore\n",
    );
    assert_eq!(
        run_wasi(&deadlock, &[]),
        "waiting\n--- stderr\nfwp: trap: deadlock: every task is waiting\n--- exit 101\n"
    );
    // without fibers: sleeping works, starting a task traps
    let sleep = wasm(
        "sleep",
        "main = [task.sleep 10ms, print \"slept\", task.within 1s (const 1) | echo] | ignore\n",
    );
    assert_eq!(
        run_wasi(&sleep, &[("FWP_NO_JSPI", "1")]),
        "slept\n--- stderr\nfwp: trap: tasks need a WebAssembly host with JavaScript Promise \
         Integration (JSPI), such as the fwp loader in a recent browser\n--- exit 101\n"
    );
    assert_eq!(run_wasi(&sleep, &[]), "slept\nSome 1\n");
    let _ = std::fs::remove_dir_all(&tmp);
}

#[test]
fn unavailable_effects_are_rejected() {
    if !available() {
        return;
    }
    let path = dir().join("run/http.fwp");
    let out = build(
        &path,
        "wasm32-wasi",
        &std::env::temp_dir().join("fwp-wasm-reject.wasm"),
    );
    assert!(!out.status.success());
    assert_eq!(
        String::from_utf8_lossy(&out.stderr),
        "fwp build: the WebAssembly target does not provide the `Network` effect (used by `tcp.listen`)\n"
    );
    let out = build(
        &dir().join("run/cli_process.fwp"),
        "wasm32-wasi",
        &std::env::temp_dir().join("fwp-wasm-reject.wasm"),
    );
    assert!(!out.status.success());
    assert_eq!(
        String::from_utf8_lossy(&out.stderr),
        "fwp build: the WebAssembly target does not provide the `Process` effect (used by `process.call`)\n"
    );
}

#[test]
fn browser_loader() {
    if !available() {
        return;
    }
    for name in ["basics", "tasks_local"] {
        browser_loader_runs(&dir().join(format!("run/{}.fwp", name)));
    }
}

fn browser_loader_runs(path: &Path) {
    let path = path.to_path_buf();
    let wasm = std::env::temp_dir().join(format!("fwp-browser-{}.wasm", std::process::id()));
    let b = build(&path, "wasm32-browser", &wasm);
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let js = wasm.with_extension("js");
    let out = Command::new("node")
        .arg("--no-warnings")
        .arg(dir().join("wasm/browser-run.mjs"))
        .arg(&js)
        .output()
        .unwrap();
    let _ = std::fs::remove_file(&wasm);
    let _ = std::fs::remove_file(&js);
    assert!(out.status.success());
    assert_eq!(
        String::from_utf8_lossy(&out.stdout),
        std::fs::read_to_string(path.with_extension("out")).unwrap()
    );
}

#[test]
fn webassembly_tutorial_runs_under_wasi() {
    if !available() {
        return;
    }
    let tut = Path::new(env!("CARGO_MANIFEST_DIR")).join("docs/tutorials/10-webassembly");
    let wasm = std::env::temp_dir().join(format!("fwp-wasm-tutorial-{}.wasm", std::process::id()));
    let b = build(&tut.join("main.fwp"), "wasm32-wasi", &wasm);
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let out = Command::new("node")
        .arg("--no-warnings")
        .arg(dir().join("wasm/wasi-run.mjs"))
        .arg(&wasm)
        .output()
        .unwrap();
    let _ = std::fs::remove_file(&wasm);
    assert_eq!(
        String::from_utf8_lossy(&out.stdout),
        std::fs::read_to_string(tut.join("main.out")).unwrap()
    );
}

/// A command-line program built for WebAssembly: flags, enumerations,
/// environment variables, optional arguments, exit statuses and the
/// generated completion script, as with the interpreter.
#[test]
fn command_line_program_under_wasi() {
    if !available() {
        return;
    }
    let src = dir().join("cli/features.fwp");
    // the program is named after its file
    let tmp = std::env::temp_dir().join(format!("fwp-wasm-cli-{}", std::process::id()));
    std::fs::create_dir_all(&tmp).unwrap();
    let wasm = tmp.join("features.wasm");
    let b = Command::new(fwp())
        .arg("build")
        .arg(&src)
        .args(["--cli", "--target", "wasm32-wasi", "-o"])
        .arg(&wasm)
        .output()
        .unwrap();
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let run = |cmd: &mut Command, args: &[&str], stdin: &str, env: &[(&str, &str)]| {
        use std::io::Write;
        let mut child = cmd
            .args(args)
            .envs(env.iter().copied())
            .env_remove("FEATURES_FORMAT")
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()
            .unwrap();
        child
            .stdin
            .take()
            .unwrap()
            .write_all(stdin.as_bytes())
            .unwrap();
        let o = child.wait_with_output().unwrap();
        render(&o.stdout, &o.stderr, o.status.code().unwrap_or(-1))
    };
    type Case<'a> = (&'a [&'a str], &'a str, &'a [(&'a str, &'a str)]);
    let cases: &[Case] = &[
        (&["render", "w", "-f", "CSV_LINES", "d"], "", &[]),
        (
            &["render", "w"],
            "",
            &[("FEATURES_COUNT", "7"), ("FEATURES_QUIET", "1")],
        ),
        (&["render", "w"], "", &[("FEATURES_COUNT", "x")]),
        (&["pick", "x"], "", &[]),
        (&["pick", "x", "nope"], "", &[]),
        (&["search", "a", "b"], "", &[]),
        (&["leave", "300"], "", &[]),
        (&["check"], "1\n-2\n", &[]),
        (&["help", "render"], "", &[]),
        (&["--completions", "bash"], "", &[]),
        (&["--man"], "", &[]),
    ];
    for (args, stdin, env) in cases {
        let want = run(
            Command::new(fwp()).args(["exec", "--cli"]).arg(&src),
            args,
            stdin,
            env,
        );
        let got = run(
            Command::new("node")
                .arg("--no-warnings")
                .arg(dir().join("wasm/wasi-run.mjs"))
                .arg(&wasm),
            args,
            stdin,
            env,
        );
        assert_eq!(got, want, "features {:?}", args);
    }
    let _ = std::fs::remove_dir_all(&tmp);
}

/// Tasks without JavaScript Promise Integration: built with
/// `--wasm-async=asyncify` (binaryen's wasm-opt), they run in node without
/// the JSPI flag, with the same output, preemption, cancellation and
/// stack overflow trap. Skipped without wasm-opt.
#[test]
fn tasks_with_asyncify() {
    if !available() {
        return;
    }
    if fwp::asyncify::wasm_opt().is_none() {
        eprintln!("skipping: no wasm-opt (binaryen)");
        return;
    }
    let tmp = std::env::temp_dir().join(format!("fwp-wasm-asyncify-{}", std::process::id()));
    std::fs::create_dir_all(&tmp).unwrap();
    let no_jspi = [("FWP_NO_JSPI", "1"), ("FWP_SEED", "42")];
    for name in ["preempt", "tasks_local", "trap_stack_overflow"] {
        let path = dir().join(format!("run/{}.fwp", name));
        let wasm = tmp.join(format!("{}.wasm", name));
        let b = Command::new(fwp())
            .arg("build")
            .arg(&path)
            .args([
                "--target",
                "wasm32-wasi",
                "--wasm-async=asyncify",
                "-O1",
                "-o",
            ])
            .arg(&wasm)
            .output()
            .unwrap();
        assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
        let out = Command::new("node")
            .arg("--no-warnings")
            .arg(dir().join("wasm/wasi-run.mjs"))
            .arg(&wasm)
            .envs(no_jspi)
            .current_dir(path.parent().unwrap())
            .stdin(Stdio::null())
            .output()
            .unwrap();
        let got = render(&out.stdout, &out.stderr, out.status.code().unwrap_or(-1));
        assert_eq!(
            got,
            std::fs::read_to_string(path.with_extension("out")).unwrap(),
            "{}",
            name
        );
    }
    // many tasks waiting at once, and the browser loader
    let many = tmp.join("many.fwp");
    std::fs::write(
        &many,
        "main = range 1 2001 | task.map (tap (const 20ms | task.sleep)) \
         | map (option.unwrap-or 0) | sum | echo\n",
    )
    .unwrap();
    let wasm = tmp.join("many.wasm");
    let b = Command::new(fwp())
        .arg("build")
        .arg(&many)
        .args([
            "--target",
            "wasm32-browser",
            "--wasm-async",
            "asyncify",
            "-o",
        ])
        .arg(&wasm)
        .output()
        .unwrap();
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let out = Command::new("node")
        .arg("--no-warnings")
        .arg(dir().join("wasm/browser-run.mjs"))
        .arg(wasm.with_extension("js"))
        .output()
        .unwrap();
    assert_eq!(String::from_utf8_lossy(&out.stdout), "2001000\n");
    // a program without tasks needs no wasm-opt
    let plain = tmp.join("plain.wasm");
    let b = Command::new(fwp())
        .arg("build")
        .arg(dir().join("run/basics.fwp"))
        .args(["--target", "wasm32-wasi", "--wasm-async=asyncify", "-o"])
        .arg(&plain)
        .env("FWP_WASM_OPT", "/nonexistent/wasm-opt")
        .output()
        .unwrap();
    assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
    let _ = std::fs::remove_dir_all(&tmp);
}
