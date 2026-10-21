//! Task captures and acyclic nested channel queues reclaim without a collector.
use std::fs::File;
use std::path::Path;
use std::process::{Command, Output, Stdio};
use std::time::{Duration, Instant};

#[path = "support/client_allocations.rs"]
mod allocations;

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn replace_once(code: &mut String, before: &str, after: &str) {
    assert_eq!(code.matches(before).count(), 1, "{before}");
    *code = code.replacen(before, after, 1);
}

fn run_probe(command: &mut Command, path: &Path, label: &str, seconds: u64) -> Output {
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
        if start.elapsed() > Duration::from_secs(seconds) {
            let _ = child.kill();
            let _ = child.wait();
            panic!("{label} exceeded {seconds} seconds: {command:?}");
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

/// Reconstruct the preceding layout for comparison, never for production use.
fn heap_cancellation(code: &str) -> String {
    let mut code = code.to_owned();
    for (before, after) in [
        (
            "jmp_buf *base; /* borrowed from the live task entry frame; null after unwind */",
            "jmp_buf base;",
        ),
        ("    longjmp(*t->base, 1);", "    longjmp(t->base, 1);"),
        (
            "    jmp_buf base;\n    t->base = &base;\n    if (setjmp(base) == 0) {",
            "    if (setjmp(t->base) == 0) {",
        ),
        (
            "    t->base = 0; /* no cancellation jump can outlive this entry frame */\n",
            "",
        ),
    ] {
        replace_once(&mut code, before, after);
    }
    code
}

fn check_cancellation_lifetime(code: &str) -> String {
    let mut code = code.to_owned();
    replace_once(
        &mut code,
        "    t->base = &base;",
        r#"    t->base = &base;
    if (fwp_root->base || t == fwp_root || !t->base ||
        (uintptr_t)t->base % _Alignof(jmp_buf)) _Exit(194);
#ifdef _WIN32
    ULONG_PTR probe_low, probe_high;
    GetCurrentThreadStackLimits(&probe_low, &probe_high);
#else
    uintptr_t probe_low = (uintptr_t)t->stack;
    uintptr_t probe_high = probe_low + t->stack_size;
#endif
    if ((uintptr_t)t->base < probe_low ||
        (uintptr_t)t->base + sizeof(jmp_buf) > probe_high) _Exit(194);"#,
    );
    replace_once(
        &mut code,
        "    if (fwp_zombie && fwp_zombie != fwp_cur) {",
        "    if (fwp_zombie && fwp_zombie != fwp_cur) {\n        if (fwp_zombie->base) _Exit(195);",
    );
    code
}

#[test]
fn cancellation_state_uses_the_entry_stack_and_preserves_cleanup() {
    let temporary = fwp::cgen::TempDir::new("task-cancellation-storage").unwrap();
    let path = std::env::var_os("FWP_TASK_CANCELLATION_ARTIFACTS")
        .map(std::path::PathBuf::from)
        .unwrap_or_else(|| temporary.path().to_path_buf());
    std::fs::create_dir_all(&path).unwrap();
    let source = path.join("tasks.fwp");
    std::fs::write(&source, include_str!("fixtures/task_channel_ownership.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(
        reference.stdout,
        include_bytes!("fixtures/task_channel_ownership.out")
    );
    assert!(reference.stderr.is_empty());
    for memory in ["arc", "tracing"] {
        let cfile = path.join(format!("{memory}.c"));
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", memory, "--emit-c", "-O1"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O0", "-O2"] {
            let mut results = Vec::new();
            for (layout, original) in [("heap", heap_cancellation(&code)), ("stack", code.clone())]
            {
                let mut measured = allocations::instrument_client_allocations(&original);
                replace_once(
                    &mut measured,
                    "    client_measure_end();\n",
                    "    client_measure_end();\n    fprintf(stderr, \"cancellation-layout\\t%zu\\t%zu\\t%zu\\n\", sizeof(fwp_task), _Alignof(fwp_task), sizeof(jmp_buf));\n",
                );
                let label = format!("{memory}-{layout}{opt}");
                let binary = path.join(format!("{label}.exe"));
                std::fs::write(path.join(format!("{label}.c")), &measured).unwrap();
                fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
                let output = run_probe(
                    Command::new(&binary)
                        .env("FWP_GC", "off")
                        .env("FWP_FREE", "1")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                    &path,
                    &label,
                    60,
                );
                assert!(output.status.success(), "{label}: {output:?}");
                assert_eq!(output.stdout, reference.stdout, "{label}");
                let stderr = String::from_utf8(output.stderr).unwrap();
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
                let sizes = numbers(lines[1], "cancellation-layout\t");
                assert_eq!(counts.len(), 6);
                assert_eq!(sizes.len(), 3);
                assert_eq!(counts[4..], [0, 0], "{label}: {stderr}");
                results.push((counts, sizes));
                let symbols = checked(Command::new("nm").arg(&binary));
                if memory == "arc" {
                    let symbols = String::from_utf8_lossy(&symbols.stdout);
                    for collector in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                        assert!(!symbols.contains(collector), "{label} retains {collector}");
                    }
                }
                std::fs::write(path.join(format!("{label}.symbols")), symbols.stdout).unwrap();
            }
            let (heap_counts, heap_sizes) = &results[0];
            let (stack_counts, stack_sizes) = &results[1];
            assert_eq!(
                heap_counts[0], stack_counts[0],
                "allocation requests changed"
            );
            assert_eq!(heap_counts[2], stack_counts[2], "retain operations changed");
            assert!(
                stack_counts[1] < heap_counts[1],
                "requested bytes did not shrink"
            );
            assert!(
                stack_counts[3] < heap_counts[3],
                "peak charged bytes did not shrink"
            );
            assert!(stack_sizes[0] < heap_sizes[0], "task record did not shrink");
            assert_eq!(stack_sizes[2], heap_sizes[2], "saved state changed");
            if opt == "-O2" {
                let verified = check_cancellation_lifetime(&code);
                let missing_clear = verified.replace(
                    "    t->base = 0; /* no cancellation jump can outlive this entry frame */",
                    "    /* deliberately omit clearing the borrowed pointer */",
                );
                let missing_entry = verified.replace("    t->base = &base;", "    t->base = 0;");
                for (variant, source, expected) in [
                    ("verified", verified, 0),
                    ("missing-clear", missing_clear, 195),
                    ("missing-entry", missing_entry, 194),
                ] {
                    let label = format!("{memory}-{variant}{opt}");
                    let binary = path.join(format!("{label}.exe"));
                    std::fs::write(path.join(format!("{label}.c")), &source).unwrap();
                    fwp::cgen::compile_c(&source, &binary, opt).unwrap();
                    let stress = if memory == "tracing" { "1" } else { "0" };
                    let output = run_probe(
                        Command::new(&binary)
                            .env_remove("FWP_GC")
                            .env("FWP_FREE", "1")
                            .env("FWP_GC_STRESS", stress)
                            .env("FWP_GC_VERIFY", stress)
                            .env("FWP_GC_STATS", "0")
                            .env("FWP_REUSE_VERIFY", stress),
                        &path,
                        &label,
                        60,
                    );
                    assert_eq!(output.status.code(), Some(expected), "{label}: {output:?}");
                    if expected == 0 {
                        assert_eq!(output.stdout, reference.stdout, "{label}");
                        assert!(output.stderr.is_empty(), "{label}: {output:?}");
                    }
                }
            }
        }
    }
}

#[test]
fn tasks_and_acyclic_channels_reclaim_after_join_and_cancellation() {
    let dir = fwp::cgen::TempDir::new("fwp-arc-tasks").unwrap();
    let source = dir.join("tasks.fwp");
    std::fs::write(&source, include_str!("fixtures/task_channel_ownership.fwp")).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(
        reference.stdout,
        include_bytes!("fixtures/task_channel_ownership.out")
    );
    for gc in ["tracing", "arc"] {
        let cfile = dir.join(format!("{gc}.c"));
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        // Final teardown must release every charge, including scheduler storage.
        let measured = if gc == "arc" {
            let main_start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(main_start);
            assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
            assert_eq!(main.matches("    fwp_cl_finish();\n").count(), 1);
            format!("{runtime}{}", main
                .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t task_budget=fwp_gc.budget_given;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < task_budget) { fprintf(stderr,\"task bytes left: %ld\\n\",(long)(task_budget-fwp_gc.budget)); exit(193); }\n"))
        } else {
            code
        };
        for opt in ["-O1", "-O2"] {
            // Windows execution can infer .exe; symbol readers and file copies
            // cannot. Use the actual filename for every consumer.
            let binary = dir.join(format!("{gc}{opt}.exe"));
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            assert!(binary.is_file(), "compiler did not create {binary:?}");
            if gc == "arc" {
                let symbols = checked(Command::new("nm").arg(&binary));
                let text = String::from_utf8_lossy(&symbols.stdout);
                for name in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                    assert!(!text.contains(name), "ARC binary contains {name}");
                }
                if let Some(path) = std::env::var_os("FWP_ARC_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let name = format!("nested-channels{opt}");
                    std::fs::copy(&binary, path.join(format!("{name}.exe"))).unwrap();
                    std::fs::write(path.join(format!("{name}.c")), &measured).unwrap();
                    std::fs::write(path.join(format!("{name}.symbols")), symbols.stdout).unwrap();
                }
            }
            let verify = if gc == "arc" { "0" } else { "1" };
            let output = checked(
                Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", verify),
            );
            assert_eq!(output.stdout, reference.stdout, "{gc} {opt}");
            assert_eq!(output.stderr, reference.stderr, "{gc} {opt}");
            if gc == "arc" {
                for needle in [
                    "if (t->result_drop && result) t->result_drop(result);",
                    "if (ownership == FWP_TASK_SHARED) fwp_task_drop(PTR(finished));",
                    "c->owner.queue_drop(element);",
                ] {
                    assert_eq!(measured.matches(needle).count(), 1);
                    let omitted = measured.replace(needle, "/* omitted owner release */");
                    fwp::cgen::compile_c(&omitted, &binary, opt).unwrap();
                    let output = Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    assert_eq!(output.status.code(), Some(193), "{needle}: {output:?}");
                }
            }
        }
    }
}

/// Restore the preceding task layout and ARC stack-marker writes in the same C.
fn preceding_task_record(code: &str) -> String {
    let mut code = code.to_owned();
    for (before, after) in [
        ("    _Bool done, cancelled, unwinding, has_result, ready, timed, timed_out, io_ready;\n    _Bool owns_thunk;\n    enum fwp_task_ownership ownership;",
         "    int done, cancelled, unwinding, has_result, ready, timed, timed_out, io_ready;"),
        ("    V thunk, result;\n", "    V thunk, result;\n    int owns_thunk;\n    enum fwp_task_ownership ownership;\n"),
        ("#if FWP_GC && !defined(FWP_ARC_ONLY)\n    char *gc_sp; /* suspended stack bound used only by tracing */\n#endif",
         "    char *gc_sp; /* preceding layout */"),
        ("#if FWP_GC && !defined(FWP_ARC_ONLY)\n    from->gc_sp = fwp_gc_sp();",
         "#if FWP_GC\n    from->gc_sp = fwp_gc_sp();"),
    ] {
        replace_once(&mut code, before, after);
    }
    code
}

#[test]
fn compact_task_records_preserve_scheduling_and_remove_arc_stack_markers() {
    let temporary = fwp::cgen::TempDir::new("task-record-storage").unwrap();
    let path = std::env::var_os("FWP_TASK_RECORD_ARTIFACTS")
        .map(std::path::PathBuf::from)
        .unwrap_or_else(|| temporary.path().to_path_buf());
    std::fs::create_dir_all(&path).unwrap();
    let source = path.join("tasks.fwp");
    std::fs::write(&source, include_str!("fixtures/task_channel_ownership.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(
        reference.stdout,
        include_bytes!("fixtures/task_channel_ownership.out")
    );
    assert!(reference.stderr.is_empty());
    for memory in ["arc", "tracing"] {
        let cfile = path.join(format!("{memory}.c"));
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", memory, "--emit-c", "-O1"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let mut instrumented = allocations::instrument_client_allocations(&code);
        replace_once(
            &mut instrumented,
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic size_t task_stack_markers;",
        );
        replace_once(
            &mut instrumented,
            "    from->gc_sp = fwp_gc_sp();",
            "    from->gc_sp = fwp_gc_sp();\n    task_stack_markers++;",
        );
        replace_once(&mut instrumented, "    client_measure_end();\n",
            "    client_measure_end();\n    fprintf(stderr, \"task-record\\t%zu\\t%zu\\t%zu\\t%zu\\t%zu\\n\", sizeof(fwp_task), _Alignof(fwp_task), sizeof(((fwp_task *)0)->done), sizeof(((fwp_task *)0)->owns_thunk), task_stack_markers);\n");
        for opt in ["-O0", "-O2"] {
            let mut rows = Vec::new();
            for (layout, c) in [
                ("preceding", preceding_task_record(&instrumented)),
                ("compact", instrumented.clone()),
            ] {
                let label = format!("{memory}-{layout}{opt}");
                let binary = path.join(format!("{label}.exe"));
                std::fs::write(path.join(format!("{label}.c")), &c).unwrap();
                fwp::cgen::compile_c(&c, &binary, opt).unwrap();
                let output = run_probe(
                    Command::new(&binary)
                        .env("FWP_GC", "off")
                        .env("FWP_FREE", "1")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                    &path,
                    &label,
                    60,
                );
                assert!(output.status.success(), "{label}: {output:?}");
                assert_eq!(output.stdout, reference.stdout, "{label}");
                let stderr = String::from_utf8(output.stderr).unwrap();
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
                let sizes = numbers(lines[1], "task-record\t");
                assert_eq!(counts.len(), 6);
                assert_eq!(sizes.len(), 5);
                assert_eq!(counts[4..], [0, 0], "{label}: {stderr}");
                rows.push((counts, sizes));
            }
            let (old_counts, old_sizes) = &rows[0];
            let (counts, sizes) = &rows[1];
            assert_eq!(counts[0], old_counts[0], "allocation requests changed");
            assert_eq!(counts[2], old_counts[2], "retains changed");
            assert!(counts[1] < old_counts[1], "requested bytes did not shrink");
            assert!(counts[3] <= old_counts[3], "peak managed charge grew");
            assert!(sizes[0] < old_sizes[0], "record did not shrink");
            assert_eq!(sizes[1], old_sizes[1], "alignment changed");
            assert_eq!(sizes[2..4], [1, 1]);
            assert_eq!(old_sizes[2..4], [4, 4]);
            assert!(old_sizes[4] > 0, "control never saved a stack marker");
            if memory == "arc" {
                assert_eq!(sizes[4], 0, "ARC still saves a tracing-only stack marker");
            } else {
                assert_eq!(sizes[4], old_sizes[4], "tracing switches changed");
            }
        }
        let label = format!("{memory}-verified-O2");
        let binary = path.join(format!("{label}.exe"));
        std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
        fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
        let verify = if memory == "tracing" { "1" } else { "0" };
        let output = run_probe(
            Command::new(&binary)
                .env_remove("FWP_GC")
                .env("FWP_FREE", "1")
                .env("FWP_GC_STRESS", verify)
                .env("FWP_GC_VERIFY", verify)
                .env("FWP_REUSE_VERIFY", verify)
                .env("FWP_GC_STATS", "0"),
            &path,
            &label,
            60,
        );
        assert!(output.status.success(), "{label}: {output:?}");
        assert_eq!(output.stdout, reference.stdout, "{label}");
        assert!(output.stderr.is_empty(), "{label}: {output:?}");
    }
}
