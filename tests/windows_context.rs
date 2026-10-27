//! Native Windows fiber state, host ownership and task-record storage.
#![cfg(windows)]
use std::fs::File;
use std::path::Path;
use std::process::{Command, Output, Stdio};
use std::time::{Duration, Instant};

#[path = "support/client_allocations.rs"]
mod allocations;

fn replace_once(code: &mut String, before: &str, after: &str) {
    assert_eq!(code.matches(before).count(), 1, "{before}");
    *code = code.replacen(before, after, 1);
}

fn execute(command: &mut Command, path: &Path, label: &str) -> Output {
    let stdout = path.join(format!("{label}.stdout"));
    let stderr = path.join(format!("{label}.stderr"));
    command.stdout(Stdio::from(File::create(&stdout).unwrap()));
    command.stderr(Stdio::from(File::create(&stderr).unwrap()));
    let mut child = command.spawn().unwrap();
    let start = Instant::now();
    let status = loop {
        if let Some(status) = child.try_wait().unwrap() {
            break status;
        }
        if start.elapsed() > Duration::from_secs(60) {
            let _ = child.kill();
            let _ = child.wait();
            panic!("{label} exceeded 60 seconds: {command:?}");
        }
        std::thread::sleep(Duration::from_millis(10));
    };
    std::fs::write(
        path.join(format!("{label}.status")),
        format!("{:?}\n", status.code()),
    )
    .unwrap();
    Output {
        status,
        stdout: std::fs::read(stdout).unwrap(),
        stderr: std::fs::read(stderr).unwrap(),
    }
}

#[test]
fn fibers_preserve_live_registers_and_host_ownership() {
    let dir = fwp::cgen::TempDir::new("windows-arc-abi").unwrap();
    let path = std::env::var_os("FWP_WINDOWS_ARC_CONTEXT_ARTIFACTS")
        .map(std::path::PathBuf::from)
        .unwrap_or_else(|| dir.path().to_path_buf());
    std::fs::create_dir_all(&path).unwrap();
    let context = include_str!("../runtime/fwp_rt_context_win.c");
    let snapshot_fault = context.replace(
        "    (void)from;",
        "    (void)from; jmp_buf unused; if (setjmp(unused)) abort();",
    );
    assert_ne!(snapshot_fault, context);
    for opt in ["-O0", "-O1", "-O2"] {
        for (variant, context, expected) in [
            ("counted", context.to_owned(), 0),
            ("injected-snapshot", snapshot_fault.clone(), 211),
        ] {
            let label = format!("abi-{variant}{opt}");
            let code = include_str!("fixtures/windows_arc_context.c")
                .replace("/* WINDOWS_CONTEXT */", &context);
            let binary = path.join(format!("{label}.exe"));
            std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let out = execute(&mut Command::new(&binary), &path, &label);
            assert_eq!(out.status.code(), Some(expected), "{label}: {out:?}");
            assert!(out.stderr.is_empty(), "{label}: {out:?}");
            if expected == 0 {
                assert_eq!(
                    out.stdout,
                    b"fibers preserve registers, stack, rounding and host ownership\r\n"
                );
            } else {
                assert!(out.stdout.is_empty());
            }
        }
    }
}

#[test]
fn task_records_hold_only_fiber_ownership_state() {
    let dir = fwp::cgen::TempDir::new("windows-arc-costs").unwrap();
    let path = std::env::var_os("FWP_WINDOWS_ARC_CONTEXT_ARTIFACTS")
        .map(std::path::PathBuf::from)
        .unwrap_or_else(|| dir.path().to_path_buf());
    std::fs::create_dir_all(&path).unwrap();
    let source = path.join("tasks.fwp");
    let cfile = path.join("tasks.c");
    std::fs::write(&source, include_str!("fixtures/task_channel_ownership.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let interpreted = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(interpreted.status.success(), "{interpreted:?}");
    assert_eq!(
        interpreted.stdout,
        include_bytes!("fixtures/task_channel_ownership.out")
    );
    assert!(interpreted.stderr.is_empty());
    let generated = Command::new(compiler)
        .env_remove("FWP_NO_OPT")
        .args(["build", "--emit-c", "-O1"])
        .arg(&source)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(generated.status.success(), "{generated:?}");
    let original = std::fs::read_to_string(&cfile).unwrap();
    let mut code = allocations::instrument_client_allocations(&original);
    replace_once(
        &mut code,
        "typedef struct {\n    void *fiber;",
        "static size_t fiber_switches;\ntypedef struct {\n    void *fiber;",
    );
    replace_once(
        &mut code,
        "    SwitchToFiber(to->fiber);",
        "    fiber_switches++;\n    SwitchToFiber(to->fiber);",
    );
    replace_once(&mut code, "    client_measure_end();\n",
        "    client_measure_end();\n    fprintf(stderr, \"windows-context\\t%zu\\t%zu\\t%zu\\t%zu\\n\", sizeof(fwp_win_context), _Alignof(fwp_win_context), sizeof(fwp_task), fiber_switches);\n");
    for opt in ["-O0", "-O2"] {
        let label = format!("cost-counted{opt}");
        let binary = path.join(format!("{label}.exe"));
        std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let out = execute(&mut Command::new(&binary), &path, &label);
        assert!(out.status.success(), "{label}: {out:?}");
        assert_eq!(out.stdout, interpreted.stdout, "{label}");
        let stderr = String::from_utf8(out.stderr).unwrap();
        let lines: Vec<_> = stderr.lines().collect();
        assert_eq!(lines.len(), 2, "{label}: {stderr}");
        let numbers = |line: &str, prefix: &str| -> Vec<u64> {
            line.strip_prefix(prefix)
                .unwrap()
                .split('\t')
                .map(|n| n.parse().unwrap())
                .collect()
        };
        let counts = numbers(lines[0], "client-memory\t");
        let sizes = numbers(lines[1], "windows-context\t");
        assert_eq!(counts.len(), 5);
        assert_eq!(counts[4], 0, "task program retained managed storage");
        assert!(counts[0] > 0 && counts[1] > 0);
        assert_eq!(sizes.len(), 4);
        // Both maintained Windows architectures use 64-bit pointers. The
        // context stores one fiber pointer and one host-ownership flag.
        assert_eq!(sizes[0], 16);
        assert_eq!(sizes[1], 8);
        assert!(sizes[2] >= sizes[0] && sizes[3] > 0);
    }
}
