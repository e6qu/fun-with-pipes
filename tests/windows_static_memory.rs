//! Native Windows storage budgets, reusable stacks and startup-only allocation.
#![cfg(windows)]
use std::process::{Command, Output};
#[path = "support/c_instrument.rs"]
mod c_instrument;

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(out.status.success(), "{command:?}: {out:?}");
    out
}

const PROBE: &str = r#"
static int static_started, static_mappings, static_threads, static_fibers;
static void *static_probe_alloc(void *at, SIZE_T n, DWORD kind, DWORD protect) {
    if (static_started) ExitProcess(181);
    static_mappings++;
    return VirtualAlloc(at,n,kind,protect);
}
static HANDLE static_probe_thread(LPSECURITY_ATTRIBUTES sa, SIZE_T n,
    LPTHREAD_START_ROUTINE fn, void *arg, DWORD flags, LPDWORD id) {
    if (static_started) ExitProcess(182);
    if (flags & STACK_SIZE_PARAM_IS_A_RESERVATION) ExitProcess(184);
    static_threads++;
    return CreateThread(sa,n,fn,arg,flags,id);
}
static void *static_probe_fiber(SIZE_T commit, SIZE_T reserve, DWORD flags,
    LPFIBER_START_ROUTINE fn, void *arg) {
    if (static_started) ExitProcess(183);
    if (commit != reserve || commit != FWP_STATIC_TASK_STACK) ExitProcess(185);
    static_fibers++;
    return CreateFiberEx(commit,reserve,flags,fn,arg);
}
"#;

#[test]
fn fixed_storage_reuses_tasks_workers_and_decimal_scratch() {
    let dir = fwp::cgen::TempDir::new("windows-static").unwrap();
    let helper = dir.join("child λ.exe");
    fwp::cgen::compile_c(
        include_str!("fixtures/windows_process_child.c"),
        &helper,
        "-O1",
    )
    .unwrap();
    let source = dir.join("static.fwp");
    std::fs::write(
        &source,
        format!(
            r#"
xs : Vector[F64, _]
xs = array.generate 100000 (int.to-float | mul 0.0001) | vector.wrap

main = [
    range 0 1000 | each (singleton | task.map (add 1) | ignore),
    xs | tensor.lazy | add 1.0 | tensor.sum-on (CpuParallel 4) | echo,
    range 0 5 | each (const [{:?}, "pump"]
        | process.run-input (string.repeat 200000 "x")
        | both .status (both (.stdout | string.length) (.stderr | string.length)) | echo),
    "6.4751751194380251109244389582276465525e-4966" | parse-float
        | option.unwrap-or 0.0f128 | show | echo,
    ["1.", string.repeat 5000 "0", "1"] | join "" | parse-float
        | option.unwrap-or 0.0f128 | eq 1.0f128 | echo,
] | ignore
"#,
            helper.to_string_lossy()
        ),
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .args(["run", "--interp"])
            .arg(&source)
            .env("FWP_NO_OPT", "1"),
    );
    let cfile = dir.join("static.c");
    checked(
        Command::new(compiler)
            .args([
                "build",
                "--emit-c",
                "--memory",
                "static",
                "--tasks",
                "2",
                "--threads",
                "3",
                "--heap",
                "16M",
            ])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let original = std::fs::read_to_string(cfile).unwrap();
    let mut code = c_instrument::calls(
        &original,
        &[
            ("VirtualAlloc", "static_probe_alloc"),
            ("CreateThread", "static_probe_thread"),
            ("CreateFiberEx", "static_probe_fiber"),
        ],
    );
    code = code.replace(
        "typedef uint64_t V;",
        &format!("{PROBE}\ntypedef uint64_t V;"),
    );
    let startup = "    fwp_init_consts();";
    assert_eq!(code.matches(startup).count(), 1);
    code = code.replace(startup, "    if(static_mappings!=1 || static_threads!=4 || static_fibers!=2)exit(186);\n    static_started=1;\n    char *copied=strdup(\"runtime scratch\");\n    if((uintptr_t)copied<(uintptr_t)fwp_static.pool || (uintptr_t)copied>=(uintptr_t)fwp_static.pool_end)exit(187);\n    free(copied);\n    fwp_init_consts();");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("static.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for stress in ["0", "1"] {
            let out = checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress)
                    .env("FWP_MEMORY_REPORT", "1"),
            );
            assert_eq!(out.stdout, reference.stdout);
            let report = String::from_utf8_lossy(&out.stderr);
            assert!(report.contains("stacks committed separately"), "{report}");
            assert!(
                report.contains("2 stacks of 1024 KiB, 1 used at most"),
                "{report}"
            );
        }
        let broken = code.replace(startup,
            "    static_probe_alloc(NULL,4096,MEM_RESERVE|MEM_COMMIT,PAGE_READWRITE);\n    fwp_init_consts();");
        fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
        assert_eq!(Command::new(&binary).status().unwrap().code(), Some(181));
    }
}

#[test]
fn fixed_storage_exhaustion_names_the_configured_part() {
    let dir = fwp::cgen::TempDir::new("windows-static-limits").unwrap();
    for (program, options, diagnostic) in [
        (
            "main = range 0 1000000 | reverse | sum | echo",
            vec!["--heap", "1M"],
            "--heap",
        ),
        (
            "main = range 0 100 | task.map (add 1) | length | echo",
            vec!["--tasks", "1"],
            "--tasks",
        ),
    ] {
        let source = dir.join("limit.fwp");
        let binary = dir.join("limit.exe");
        std::fs::write(&source, program).unwrap();
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--memory", "static", "-O1"])
                .args(options)
                .arg(&source)
                .arg("-o")
                .arg(&binary),
        );
        let out = Command::new(&binary).output().unwrap();
        assert_eq!(out.status.code(), Some(102), "{out:?}");
        assert!(
            String::from_utf8_lossy(&out.stderr).contains(diagnostic),
            "{out:?}"
        );
    }
}

#[test]
fn fatal_task_traps_keep_their_exit_status_with_static_fibers() {
    let dir = fwp::cgen::TempDir::new("windows-static-trap").unwrap();
    let source = dir.join("trap.fwp");
    std::fs::write(&source, "bad : () -> I64\nbad = const \"static task trap\" | prim.trap\nmain = task.spawn bad | task.await | ignore\n").unwrap();
    for gc in ["tracing", "arc"] {
        let binary = dir.join("trap.exe");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--memory", "static", "--gc", gc, "-O2"])
                .arg(&source)
                .arg("-o")
                .arg(&binary),
        );
        let out = Command::new(binary).output().unwrap();
        assert_eq!(out.status.code(), Some(101), "{gc}: {out:?}");
        assert_eq!(out.stderr, b"fwp: trap: static task trap\n");
    }
}
