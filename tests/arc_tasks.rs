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
    std::fs::write(
        &source,
        r#"
value : String -> () -> String
value = const
sleeping : String -> () -> String ! {Async}
sleeping = curry (.0 | tap (const 1h | task.sleep))
awaiting : Task[String] -> () -> Option[String] ! {Async}
awaiting = curry (.0 | task.await)
start-sleeping : String -> Task[String] ! {Async}
start-sleeping = compose sleeping task.spawn
start-value : String -> Task[String] ! {Async}
start-value = compose value task.spawn
own-state : () -> String
own-state = run-state "initial" (const "owned" | tap put | const () | get) | .0
scope-failure : () -> () ! {Async, Error[String]}
scope-failure = tap (const "scope" | string.repeat 2 | start-sleeping | ignore)
    | const "expected" | fail
text-channel : I64 -> Channel[String] ! {Async}
text-channel = channel.make
Data = | End | Cell String Data
data-channel : I64 -> Channel[Data] ! {Async}
data-channel = channel.make
receive : Channel[String] -> () -> Option[String] ! {Async}
receive = curry (.0 | channel.recv)
send : Channel[String] -> () -> Bool ! {Async}
send = curry (.0 | flip channel.send ("pending" | string.repeat 2))
start-receive : Channel[String] -> Task[Option[String]] ! {Async}
start-receive = compose receive task.spawn
start-send : Channel[String] -> Task[Bool] ! {Async}
start-send = compose send task.spawn
undrained : I64 -> () ! {Async}
undrained = text-channel | tap (flip channel.send ("queued" | string.repeat 2))
    | tap channel.close | ignore
queue-failure : I64 -> () ! {Async, Error[String]}
queue-failure = text-channel | tap (flip channel.send ("failed" | string.repeat 2))
    | const "expected" | fail
main = [
    task.spawn (value ("input" | string.repeat 2)) | both task.await task.await | echo,
    task.spawn (sleeping ("early" | string.repeat 2)) | tap task.cancel | task.await | echo,
    task.spawn (sleeping ("entered" | string.repeat 2))
        | tap (const () | task.yield) | tap task.cancel | task.await | echo,
    task.within 1h (value ("within" | string.repeat 2)) | echo,
    task.spawn (awaiting (task.spawn (value ("older" | string.repeat 2)))) | task.await | echo,
    task.spawn own-state | task.await | echo,
    () | attempt (const scope-failure | task.scope) | echo,
    task.scope (const "joined" | string.repeat 2 | start-value | ignore),
    range 0 65 | map show | task.map (string.repeat 3) | length | echo,
    text-channel 2 | tap (flip channel.send ("kept" | string.repeat 2))
        | tap channel.close | channel.recv | echo,
    text-channel 1 | channel.recv-for 0ns | echo,
    text-channel 1 | tap channel.close | flip channel.send "rejected" | echo,
    data-channel 1 | tap (flip channel.send (Cell ("data" | string.repeat 2) End))
        | tap channel.close | channel.recv | echo,
    text-channel 1 | start-receive | tap (const () | task.yield)
        | tap task.cancel | task.await | echo,
    text-channel 1 | tap (flip channel.send ("full" | string.repeat 2))
        | start-send | tap (const () | task.yield)
        | tap task.cancel | task.await | echo,
    range 1 65 | each undrained,
    1 | attempt queue-failure | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
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
