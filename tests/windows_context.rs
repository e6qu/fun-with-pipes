//! Native Windows ABI and conservative roots of suspended fibers.
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

/// Restore the preceding collector-only snapshot for the measured control.
fn collector_snapshot(code: &str) -> String {
    let mut code = code.to_owned();
    for (before, after) in [
        ("    char *top;\n#if FWP_GC && !defined(FWP_ARC_ONLY)\n    char *sp;\n    jmp_buf registers;\n#endif",
         "    char *top, *sp;\n    jmp_buf registers;"),
        ("#if FWP_GC && !defined(FWP_ARC_ONLY)\n    /* setjmp captures", "    /* setjmp captures"),
        ("    from->sp = fwp_gc_sp();\n#else\n    (void)from;\n#endif",
         "    from->sp = fwp_gc_sp();"),
        ("#if FWP_GC && !defined(FWP_ARC_ONLY)\n    from->sp = NULL;\n    memset(from->registers, 0, sizeof from->registers);\n#endif",
         "    from->sp = NULL;\n    memset(from->registers, 0, sizeof from->registers);"),
    ] {
        replace_once(&mut code, before, after);
    }
    code
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
fn arc_fibers_preserve_live_registers_without_collector_snapshots() {
    let dir = fwp::cgen::TempDir::new("windows-arc-abi").unwrap();
    let path = std::env::var_os("FWP_WINDOWS_ARC_CONTEXT_ARTIFACTS")
        .map(std::path::PathBuf::from)
        .unwrap_or_else(|| dir.path().to_path_buf());
    std::fs::create_dir_all(&path).unwrap();
    let context = include_str!("../runtime/fwp_rt_context_win.c");
    for opt in ["-O0", "-O1", "-O2"] {
        for (variant, context, expected) in [
            ("arc", context.to_owned(), 0),
            ("restored-snapshot", collector_snapshot(context), 211),
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
                    b"ARC fibers preserve registers, stack, rounding and host ownership\r\n"
                );
            } else {
                assert!(out.stdout.is_empty());
            }
        }
    }
}

#[test]
fn arc_task_records_omit_collector_storage_and_switch_copies() {
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
        .args(["build", "--gc", "arc", "--emit-c", "-O1"])
        .arg(&source)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(generated.status.success(), "{generated:?}");
    let original = std::fs::read_to_string(&cfile).unwrap();
    let mut instrumented = allocations::instrument_client_allocations(&original);
    replace_once(
        &mut instrumented,
        "typedef struct {\n    void *fiber;",
        "static size_t collector_snapshots, fiber_switches;\ntypedef struct {\n    void *fiber;",
    );
    replace_once(
        &mut instrumented,
        "    if (setjmp(from->registers)) abort();",
        "    collector_snapshots++;\n    if (setjmp(from->registers)) abort();",
    );
    replace_once(
        &mut instrumented,
        "    SwitchToFiber(to->fiber);",
        "    fiber_switches++;\n    SwitchToFiber(to->fiber);",
    );
    replace_once(&mut instrumented, "    client_measure_end();\n",
        "    client_measure_end();\n    fprintf(stderr, \"windows-context\\t%zu\\t%zu\\t%zu\\t%zu\\t%zu\\n\", sizeof(fwp_win_context), _Alignof(fwp_win_context), sizeof(fwp_task), collector_snapshots, fiber_switches);\n");
    for opt in ["-O0", "-O2"] {
        let mut rows = Vec::new();
        for (variant, code) in [
            ("snapshot", collector_snapshot(&instrumented)),
            ("arc", instrumented.clone()),
        ] {
            let label = format!("cost-{variant}{opt}");
            let binary = path.join(format!("{label}.exe"));
            std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let out = execute(
                Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_FREE", "1")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .env("FWP_GC_STATS", "0"),
                &path,
                &label,
            );
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
            assert_eq!(counts.len(), 6);
            assert_eq!(sizes.len(), 5);
            assert_eq!(counts[4..], [0, 0]);
            rows.push((counts, sizes));
        }
        let (before, old_sizes) = &rows[0];
        let (after, new_sizes) = &rows[1];
        assert_eq!(before[0], after[0], "allocation requests changed");
        assert_eq!(before[2], after[2], "retain operations changed");
        assert!(
            after[1] < before[1] && after[3] < before[3],
            "heap costs did not shrink"
        );
        assert!(
            new_sizes[0] < old_sizes[0] && new_sizes[2] < old_sizes[2],
            "records did not shrink"
        );
        assert!(old_sizes[3] > 0);
        assert_eq!(
            old_sizes[3], old_sizes[4],
            "preceding switches must take a snapshot"
        );
        assert_eq!(new_sizes[3], 0, "ARC still saves collector-only registers");
        assert_eq!(old_sizes[4], new_sizes[4], "scheduler work changed");
    }
}

#[test]
fn fiber_registers_stacks_and_host_context_are_preserved() {
    let allocator = include_str!("../runtime/fwp_rt_gc.c");
    let end = allocator.find("#endif /* FWP_GC */").unwrap() + "#endif /* FWP_GC */".len();
    // Isolate fiber roots from PE data roots, which have their own native probe.
    let allocator = allocator[..end].replace("    fwp_gc_scan_data();", "");
    let context = include_str!("../runtime/fwp_rt_context_win.c");
    let missing_registers = context.replace(
        "    fwp_gc_scan_root((char *)context->registers,\n                     (char *)context->registers + sizeof context->registers);",
        "",
    );
    let missing_stack = context.replace("    fwp_gc_scan_root(context->sp, context->top);", "");
    assert_ne!(missing_registers, context);
    assert_ne!(missing_stack, context);
    let dir = fwp::cgen::TempDir::new("windows-context").unwrap();
    let executable = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [
            (context, 0),
            (missing_registers.as_str(), 23),
            (missing_stack.as_str(), 24),
        ] {
            let source = include_str!("fixtures/windows_context_probe.c")
                .replace("/* NATIVE_ALLOCATOR */", &allocator)
                .replace("/* WINDOWS_CONTEXT */", code);
            fwp::cgen::compile_c(&source, &executable, opt).unwrap();
            let out = Command::new(&executable)
                .env("FWP_GC", "on")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(out.status.code(), Some(expected), "{opt}: {out:?}");
        }
    }
}

#[test]
fn active_stack_roots_extend_above_the_frame_marker() {
    let allocator = include_str!("../runtime/fwp_rt_gc.c");
    let end = allocator.find("#endif /* FWP_GC */").unwrap() + "#endif /* FWP_GC */".len();
    let allocator = allocator[..end].replace("    fwp_gc_scan_data();", "");
    let old_bound = allocator.replace(
        "fwp_gc.main_top = (char *)high;",
        "fwp_gc.main_top = (char *)top;",
    );
    assert_ne!(old_bound, allocator);
    let prefix = include_str!("fixtures/windows_context_probe.c")
        .split("/* NATIVE_ALLOCATOR */")
        .next()
        .unwrap();
    let probe = r#"
static char *active_root;
static void fwp_gc_scan_stacks(char *sp) {
    (void)sp;
    /* Isolate a live slot above the supplied frame marker. Do not let
     * incidental register copies hide an incorrect upper stack bound. */
    fwp_gc_scan_root(active_root, fwp_gc.main_top);
}
int main(void) {
    volatile V slots[8192] = {0};
    fwp_gc_start((void *)&slots[0]);
    active_root = (char *)&slots[8191];
    slots[8191] = (V)(uintptr_t)fwp_alloc_leaf(32);
    fwp_gc.major_next = 1;
    fwp_gc_collect();
    if (!fwp_gc_marked((void *)(uintptr_t)slots[8191])) return 23;
    fwp_gc_finish();
    return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("windows-active-stack").unwrap();
    let binary = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        for (runtime, expected) in [(&allocator, 0), (&old_bound, 23)] {
            fwp::cgen::compile_c(&format!("{prefix}{runtime}{probe}"), &binary, opt).unwrap();
            let output = Command::new(&binary)
                .env("FWP_GC", "on")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
    }
}
