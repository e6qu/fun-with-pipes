//! Queue ownership includes a proved function's captured values and call scope.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

#[test]
fn queued_functions_preserve_results_and_release_undrained_captures() {
    let dir = fwp::cgen::TempDir::new("queued-functions").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, include_str!("fixtures/queued_functions.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(
        reference.stdout,
        include_bytes!("fixtures/queued_functions.out")
    );
    for memory in ["arc", "tracing"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", memory, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();
        if memory == "arc" {
            let finish = "\n    fwp_cl_finish();\n";
            assert_eq!(code.matches(finish).count(), 1);
            code = code.replace(finish, &format!("{finish}    if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget_given != fwp_gc.budget) exit(193);\n"));
        }
        let drop = "            c->owner.queue.drop(element);";
        assert_eq!(code.matches(drop).count(), 1);
        let missing_drop = code.replace(drop, "            (void)element;");
        for opt in ["-O0", "-O2"] {
            let binary = dir.join("main.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let stress = if memory == "arc" { "0" } else { "1" };
            let run = || {
                let mut command = Command::new(&binary);
                command
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress);
                command
            };
            let actual = checked(&mut run());
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr),
                "{memory}/{opt}"
            );
            if memory == "arc" {
                let symbols = checked(Command::new("nm").arg(&binary));
                let symbols = String::from_utf8_lossy(&symbols.stdout);
                for symbol in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                    assert!(!symbols.contains(symbol), "ARC binary retains {symbol}");
                }
                fwp::cgen::compile_c(&missing_drop, &binary, opt).unwrap();
                let omitted = run().output().unwrap();
                assert_eq!(omitted.status.code(), Some(193), "{opt}: {omitted:?}");
            }
        }
    }
}

#[test]
fn queued_functions_reject_channel_captures_including_returned_and_nested_values() {
    let dir = fwp::cgen::TempDir::new("queued-cycles").unwrap();
    let prefix = r#"
callbacks : I64 -> Channel[() -> () ! {Async}] ! {Async}
callbacks = channel.make
keep : Channel[() -> () ! {Async}] -> () -> () ! {Async}
keep = then2 const channel.close
"#;
    for (name, body) in [
        ("self", "send-self = fork channel.send id keep\nmain = callbacks 1 | tap send-self | channel.recv | option.map (apply ()) | ignore\n"),
        ("returned", "returned = keep | const | apply ()\nsend-self = fork channel.send id returned\nmain = callbacks 1 | tap send-self | channel.recv | option.map (apply ()) | ignore\n"),
        ("nested", "lists : I64 -> Channel[List[() -> () ! {Async}]] ! {Async}\nlists = channel.make\nmain = lists 1 | tap (flip channel.send [keep (callbacks 1)]) | channel.recv | ignore\n"),
    ] {
        let source = dir.join(format!("{name}.fwp"));
        std::fs::write(&source, format!("{prefix}\n{body}")).unwrap();
        checked(Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1").args(["run", "--interp"]).arg(&source));
        let build = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source).arg("-o").arg(dir.join("rejected.c"))
            .output().unwrap();
        assert!(!build.status.success(), "{name}: accepted an unproved captured channel");
        let error = String::from_utf8_lossy(&build.stderr);
        assert!(error.contains("queued function") && error.contains("captured") && error.contains("Channel"), "{name}: {error}");
    }
}
