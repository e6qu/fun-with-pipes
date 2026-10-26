//! Native Linux task records with saved CPU state in their existing stacks.
#![cfg(all(target_os = "linux", target_env = "gnu"))]

use std::fs::File;
use std::path::{Path, PathBuf};
use std::process::{Command, Output, Stdio};
use std::time::{Duration, Instant};

#[path = "support/client_allocations.rs"]
mod allocations;

const PROGRAM: &str = "worker : I64 -> I64 ! {Async}\nworker = tap (const () | task.yield) | add 1\nmain = range 0 32 | task.map worker | map (option.unwrap-or 0) | sum | echo\n";

#[test]
fn task_stack_pages_guard_reuse_and_setup_failures() {
    let runtime = include_str!("../runtime/fwp_rt_task.c");
    let begin = "    t->stack_size = FWP_NATIVE_TASK_STACK;\n    if (fwp_stack_pool_n > 0)";
    assert_eq!(runtime.matches(begin).count(), 1);
    let block = &runtime[runtime.find(begin).unwrap()..];
    let block = &block[..block.find("#endif\n    t->all_next").unwrap()];
    let code = include_str!("fixtures/task_stack_pages.c")
        .replace("    /* PRODUCTION_STACK_ALLOCATION */", block);
    let path = directory("pages");
    for opt in ["-O1", "-O2"] {
        let binary = compile(&code, &path, opt, opt, false);
        for (mode, status) in [
            ("ordinary", 0),
            ("no-thp", 0),
            ("map-error", 0),
            ("advice-error", 0),
            ("guard-error", 0),
            ("missing-advice", 211),
            ("missing-guard", 212),
        ] {
            let output = run(
                Command::new(&binary).arg(mode),
                &path,
                &format!("{opt}-{mode}"),
                10,
            );
            assert_eq!(output.status.code(), Some(status), "{mode}: {output:?}");
            if status == 0 {
                assert!(output.stderr.is_empty(), "{output:?}");
            }
        }
    }
}

fn directory(case: &str) -> PathBuf {
    let root = std::env::var_os("FWP_TASK_CONTEXT_ARTIFACTS")
        .map(PathBuf::from)
        .unwrap_or_else(|| {
            std::env::temp_dir().join(format!("fwp-task-context-{}", std::process::id()))
        });
    let path = root.join(case);
    std::fs::create_dir_all(&path).unwrap();
    path
}

fn run(command: &mut Command, path: &Path, label: &str, seconds: u64) -> Output {
    let stdout = path.join(format!("{label}.stdout"));
    let stderr = path.join(format!("{label}.stderr"));
    command.stdout(Stdio::from(File::create(&stdout).unwrap()));
    command.stderr(Stdio::from(File::create(&stderr).unwrap()));
    let mut child = command.spawn().unwrap();
    let started = Instant::now();
    let status = loop {
        if let Some(status) = child.try_wait().unwrap() {
            break status;
        }
        if started.elapsed() > Duration::from_secs(seconds) {
            let _ = child.kill();
            let _ = child.wait();
            panic!("{label} exceeded {seconds} seconds: {command:?}");
        }
        std::thread::sleep(Duration::from_millis(10));
    };
    std::fs::write(path.join(format!("{label}.status")), format!("{status}\n")).unwrap();
    Output {
        status,
        stdout: std::fs::read(stdout).unwrap(),
        stderr: std::fs::read(stderr).unwrap(),
    }
}

fn generated(path: &Path, memory: &str, program: &str) -> String {
    let source = path.join("tasks.fwp");
    std::fs::write(&source, program).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = run(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
        path,
        "interpreter",
        60,
    );
    assert!(
        reference.status.success(),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    assert_eq!(reference.stdout, b"528\n");
    assert!(reference.stderr.is_empty());
    let cfile = path.join("generated.c");
    let result = run(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", memory, "--emit-c", "-O1"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
        path,
        "generate",
        120,
    );
    assert!(
        result.status.success(),
        "{}",
        String::from_utf8_lossy(&result.stderr)
    );
    std::fs::read_to_string(cfile).unwrap()
}

fn replace(code: &mut String, before: &str, after: &str, count: usize) {
    assert_eq!(code.matches(before).count(), count, "{before}");
    *code = code.replace(before, after);
}

/// Reconstruct the preceding layout in otherwise identical generated C.
/// This is an experimental control, not a production configuration or fallback.
fn heap_context(code: &str) -> String {
    let mut code = code.to_owned();
    replace(
        &mut code,
        "ucontext_t *ctx; /* saved in the existing stack allocation */",
        "ucontext_t ctx;",
        1,
    );
    replace(&mut code, "static ucontext_t fwp_root_context;", "", 1);
    for clear in [
        "        memset(&fwp_root_context, 0, sizeof fwp_root_context);\n",
        "    if (fwp_root) memset(&fwp_root_context, 0, sizeof fwp_root_context);\n",
        "    memset(&fwp_root_context, 0, sizeof fwp_root_context);\n",
    ] {
        replace(&mut code, clear, "", 1);
    }
    replace(&mut code, "    fwp_root->ctx = &fwp_root_context;\n", "", 1);
    replace(
        &mut code,
        "        fwp_zombie->ctx = 0; /* a retained result cannot refer to a recycled stack */\n",
        "",
        1,
    );
    replace(
        &mut code,
        "    swapcontext(from->ctx, to->ctx);",
        "    swapcontext(&from->ctx, &to->ctx);",
        1,
    );
    let begin = code
        .find("    /* Keep the large register image out of the frequently accessed task record.")
        .unwrap();
    let end = begin + code[begin..].find("\n#endif").unwrap();
    code.replace_range(begin..end, "    getcontext(&t->ctx);\n    t->ctx.uc_stack.ss_sp = t->stack;\n    t->ctx.uc_stack.ss_size = t->stack_size;\n    t->ctx.uc_link = 0;\n    makecontext(&t->ctx, fwp_task_main, 0);");
    code
}

fn compile(code: &str, path: &Path, label: &str, opt: &str, uses_context: bool) -> PathBuf {
    std::fs::write(path.join(format!("{label}.c")), code).unwrap();
    let binary = path.join(format!("{label}.exe"));
    fwp::cgen::compile_c(code, &binary, opt).unwrap();
    let bytes = std::fs::read(&binary).unwrap();
    assert_eq!(&bytes[..6], b"\x7fELF\x02\x01");
    let machine = u16::from_le_bytes(bytes[18..20].try_into().unwrap());
    let expected = match std::env::consts::ARCH {
        "x86_64" => 62,
        "aarch64" => 183,
        _ => panic!("unsupported native host"),
    };
    assert_eq!(machine, expected);
    for (tool, flag, suffix) in [
        ("objdump", "-d", "asm"),
        ("nm", "-S", "nm"),
        ("size", "-A", "sections"),
    ] {
        let result = run(
            Command::new(tool).arg(flag).arg(&binary),
            path,
            &format!("{label}-{suffix}"),
            30,
        );
        assert!(
            result.status.success(),
            "{}",
            String::from_utf8_lossy(&result.stderr)
        );
        if tool == "nm" {
            let symbols = String::from_utf8_lossy(&result.stdout);
            if uses_context {
                assert!(
                    symbols.contains("swapcontext"),
                    "{label} changed the context implementation"
                );
            }
            if code.contains("#define FWP_ARC_ONLY 1") {
                for collector in ["fwp_heap_scan", "fwp_heap_mark_all", "fwp_heap_sweep"] {
                    assert!(!symbols.contains(collector), "{label} retains {collector}");
                }
            }
        }
    }
    binary
}

#[test]
fn saved_context_roots_and_machine_state() {
    let path = directory("roots");
    let code = generated(&path, "tracing", PROGRAM);
    for opt in ["-O0", "-O2"] {
        for (layout, original) in [("heap", heap_context(&code)), ("stack", code.clone())] {
            let mut instrumented = original;
            let declarations = instrumented
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            instrumented.insert_str(declarations, include_str!("fixtures/task_context_roots.c"));
            replace(
                &mut instrumented,
                "    fwp_init_consts();\n",
                "    fwp_init_consts();\n    probe_context_roots();\n",
                1,
            );
            let instrumented = format!(
                "#define PROBE_CONTEXT_STACK {}\n{instrumented}",
                usize::from(layout == "stack")
            );
            let mut variants = vec![("ordinary", instrumented.clone(), 0)];
            if layout == "stack" {
                variants.push((
                    "missing-root",
                    format!("#define PROBE_BROKEN_ROOT 1\n{instrumented}"),
                    191,
                ));
                let mut missing_child = instrumented.clone();
                replace(
                    &mut missing_child,
                    "fwp_heap_scan_root(FWP_TASK_LOW(t), t->stack + t->stack_size);",
                    "fwp_heap_scan_root(FWP_TASK_LOW(t), (char *)t->ctx);",
                    1,
                );
                variants.push(("missing-child", missing_child, 192));
            }
            for (variant, text, expected) in variants {
                let label = format!("{layout}{opt}-{variant}");
                let binary = compile(&text, &path, &label, opt, true);
                let actual = run(
                    Command::new(binary)
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", "0")
                        .env_remove("FWP_GC"),
                    &path,
                    &label,
                    30,
                );
                assert_eq!(
                    actual.status.code(),
                    Some(expected),
                    "{label}: {}",
                    String::from_utf8_lossy(&actual.stderr)
                );
                if expected == 0 {
                    assert_eq!(
                        actual.stdout,
                        b"saved context roots and machine state pass\n528\n"
                    );
                    assert!(
                        actual.stderr.is_empty(),
                        "{label}: {}",
                        String::from_utf8_lossy(&actual.stderr)
                    );
                }
            }
        }
    }
}

#[test]
fn task_context_storage_preserves_output_and_cleanup() {
    for memory in ["arc", "tracing"] {
        let path = directory(memory);
        let code = generated(&path, memory, PROGRAM);
        for (layout, original) in [("heap", heap_context(&code)), ("stack", code.clone())] {
            let mut measured = allocations::instrument_client_allocations(&original);
            let layout_report = format!("    fprintf(stderr, \"task-layout\\t%zu\\t%zu\\t%zu\\t%zu\\n\", sizeof(fwp_task), _Alignof(fwp_task), sizeof(ucontext_t), (size_t){});\n", if layout == "stack" { "sizeof(ucontext_t)" } else { "0" });
            replace(
                &mut measured,
                "    client_measure_end();\n",
                &format!("    client_measure_end();\n{layout_report}    fprintf(stderr, \"process-peak-kib\\t%ld\\n\", fwp_heap_status_kb(\"VmHWM\"));\n"),
                1,
            );
            let verified = if layout == "stack" {
                let mut checked = measured.clone();
                replace(&mut checked, "    fwp_native_tasks_finish();\n", "    fwp_native_tasks_finish();\n    for(size_t i=0;i<sizeof fwp_root_context;i++)if(((unsigned char *)&fwp_root_context)[i])_Exit(193);\n", 1);
                replace(&mut checked, "    makecontext(t->ctx, fwp_task_main, 0);", "    makecontext(t->ctx, fwp_task_main, 0);\n    if((uintptr_t)t->ctx % _Alignof(ucontext_t) || (char *)t->ctx < t->stack || (char *)(t->ctx+1) > t->stack+t->stack_size || t->ctx->uc_stack.ss_size != (size_t)((char *)t->ctx-t->stack))_Exit(195);", 1);
                replace(&mut checked, "        fwp_zombie->all_prev = fwp_zombie->all_next = 0;", "        fwp_zombie->all_prev = fwp_zombie->all_next = 0;\n        if(fwp_zombie->ctx || fwp_zombie->stack)_Exit(196);", 1);
                Some(checked)
            } else {
                None
            };
            for opt in ["-O0", "-O2"] {
                let mut variants = vec![(format!("{layout}{opt}"), &measured)];
                if let Some(checked) = &verified {
                    variants.push((format!("{layout}{opt}-verified"), checked));
                }
                for (label, source) in variants {
                    let binary = compile(source, &path, &label, opt, true);
                    let actual = run(
                        Command::new(binary)
                            .env("FWP_GC", "off")
                            .env("FWP_FREE", "1")
                            .env("FWP_GC_STRESS", "0")
                            .env("FWP_GC_VERIFY", "0")
                            .env("FWP_REUSE_VERIFY", "0"),
                        &path,
                        &label,
                        30,
                    );
                    assert!(
                        actual.status.success(),
                        "{memory}/{label}: {}",
                        String::from_utf8_lossy(&actual.stderr)
                    );
                    assert_eq!(actual.stdout, b"528\n");
                    let stderr = String::from_utf8_lossy(&actual.stderr);
                    let counts = stderr
                        .lines()
                        .find(|line| line.starts_with("client-memory\t"))
                        .unwrap();
                    let values: Vec<u64> = counts
                        .split('\t')
                        .skip(1)
                        .map(|v| v.parse().unwrap())
                        .collect();
                    assert_eq!(values.len(), 6);
                    assert_eq!(values[4..], [0, 0], "{memory}/{label}: {stderr}");
                    let peak: u64 = stderr
                        .lines()
                        .find_map(|line| line.strip_prefix("process-peak-kib\t"))
                        .unwrap()
                        .parse()
                        .unwrap();
                    assert!(peak > 0, "whole-process peak memory unavailable: {stderr}");
                    assert_eq!(stderr.lines().count(), 3, "{stderr}");
                }
            }
            if memory == "arc" && layout == "stack" {
                let mut broken = verified.unwrap();
                replace(
                    &mut broken,
                    "        memset(&fwp_root_context, 0, sizeof fwp_root_context);\n",
                    "",
                    1,
                );
                let label = "missing-root-clear-O2";
                let binary = compile(&broken, &path, label, "-O2", true);
                let actual = run(
                    Command::new(binary)
                        .env("FWP_GC", "off")
                        .env("FWP_FREE", "1")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                    &path,
                    label,
                    30,
                );
                assert_eq!(
                    actual.status.code(),
                    Some(193),
                    "{}",
                    String::from_utf8_lossy(&actual.stderr)
                );
            }
        }
    }
}

#[test]
fn taskless_entry_does_not_clear_unused_context_storage() {
    for memory in ["arc", "tracing"] {
        let path = directory(&format!("taskless-{memory}"));
        let mut code = generated(&path, memory, "main = 528 | echo\n");
        let clear = "memset(&fwp_root_context, 0, sizeof fwp_root_context);";
        replace(
            &mut code,
            clear,
            "(probe_context_clears++, memset(&fwp_root_context, 0, sizeof fwp_root_context));",
            3,
        );
        replace(
            &mut code,
            "    fwp_native_tasks_finish();\n",
            "    fwp_native_tasks_finish();\n    if (probe_context_clears || fwp_root || fwp_cur) _Exit(197);\n",
            1,
        );
        code = format!("static int probe_context_clears;\n{code}");
        for opt in ["-O0", "-O2"] {
            let mut variants = vec![("ordinary", code.clone(), 0)];
            if memory == "arc" && opt == "-O2" {
                let mut broken = code.clone();
                replace(
                    &mut broken,
                    "    fwp_native_tasks_finish();\n",
                    "    fwp_native_tasks_finish();\n    (probe_context_clears++, memset(&fwp_root_context, 0, sizeof fwp_root_context));\n",
                    1,
                );
                variants.push(("unconditional-clear", broken, 197));
            }
            for (variant, source, status) in variants {
                let label = format!("{variant}{opt}");
                let binary = compile(&source, &path, &label, opt, false);
                let actual = run(
                    Command::new(binary)
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                    &path,
                    &label,
                    30,
                );
                assert_eq!(
                    actual.status.code(),
                    Some(status),
                    "{memory}/{label}: {}",
                    String::from_utf8_lossy(&actual.stderr)
                );
                assert!(actual.stderr.is_empty());
                if status == 0 {
                    assert_eq!(actual.stdout, b"528\n");
                }
            }
        }
    }
}
