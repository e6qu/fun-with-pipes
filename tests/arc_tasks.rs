//! Task captures and data-only channel queues reclaim without a collector.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn tasks_and_data_channels_reclaim_after_join_and_cancellation() {
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
        // The scheduler root is permanent scratch, created once per runtime.
        // Charge all child owners and results against the initialized baseline.
        let measured = if gc == "arc" {
            let main_start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(main_start);
            assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
            assert_eq!(main.matches("    fwp_cl_finish();\n").count(), 1);
            format!("{runtime}{}", main
                .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t task_budget=fwp_gc.budget;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < task_budget) { fprintf(stderr,\"task bytes left: %ld\\n\",(long)(task_budget-fwp_gc.budget)); exit(193); }\n"))
        } else {
            code
        };
        for opt in ["-O1", "-O2"] {
            let binary = dir.join(format!("{gc}{opt}"));
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
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
                    "c->owner.queue.drop(element);",
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
