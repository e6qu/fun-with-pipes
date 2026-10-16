//! Clock results and timestamped logging release their Duration records.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn log_fields(output: &[u8]) -> Vec<String> {
    String::from_utf8(output.to_vec())
        .unwrap()
        .lines()
        .map(|line| {
            let (time, fields) = line
                .split_once(' ')
                .unwrap_or_else(|| panic!("invalid log line: {line:?}"));
            assert!(time.starts_with("ts="), "invalid log time: {line:?}");
            assert!(time.strip_prefix("ts=").unwrap().parse::<i64>().unwrap() > 0);
            fields.to_string()
        })
        .collect()
}

#[test]
fn clocks_and_logs_match_observable_behavior_and_reclaim_records() {
    let dir = fwp::cgen::TempDir::new("clock-ownership").unwrap();
    let source = dir.join("clocks.fwp");
    std::fs::write(
        &source,
        r#"
ordered : () -> Bool ! {IO}
ordered = both time.monotonic time.monotonic
    | both (.0 | .nanos) (.1 | .nanos) | uncurry sub | ge 0
exercise : I64 -> () ! {IO}
exercise = const () | tap (ordered | echo)
    | tap (time.unix | .nanos | gt 0 | echo)
    | const "owned clock" | log.info
main = range 0 128 | each exercise
"#,
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(reference.stdout, "True\n".repeat(256).as_bytes());
    let fields = log_fields(&reference.stderr);
    assert_eq!(fields, vec!["level=info msg=\"owned clock\""; 128]);
    for mode in ["tracing", "arc"] {
        let cfile = dir.join("clocks.c");
        checked(
            Command::new(compiler)
                .args(["build", "--gc", mode, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();
        if mode == "arc" {
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
            assert_eq!(main.matches("    fwp_cl_finish();\n").count(), 1);
            let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    intptr_t clock_budget = fwp_gc.budget;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < clock_budget) exit(231);\n");
            code = format!("{runtime}{main}");
        }
        let binary = dir.join("clocks.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let stress = if mode == "arc" { "0" } else { "1" };
            let actual = checked(
                Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress),
            );
            assert_eq!(actual.stdout, reference.stdout, "{mode} {opt}");
            assert_eq!(log_fields(&actual.stderr), fields, "{mode} {opt}");
        }
        if mode == "arc" {
            let counted = "fwp_rc_fresh(fwp_p_time_monotonic())";
            assert!(code.contains(counted));
            let missing_count = code.replace(counted, "fwp_p_time_monotonic()");
            fwp::cgen::compile_c(&missing_count, &binary, "-O2").unwrap();
            let actual = Command::new(&binary).output().unwrap();
            assert_eq!(actual.status.code(), Some(231), "{actual:?}");
        }
    }
}
