//! Owning queue cycles are rejected before execution, even if later drained.
use std::process::Command;

#[test]
fn owning_cycle_is_rejected_before_effects_in_both_engines() {
    let dir = fwp::cgen::TempDir::new("channel-cycle").unwrap();
    let source = dir.join("probe.fwp");
    std::fs::write(&source, r#"
Link = | Node (Channel[Link])
link-channel : I64 -> Channel[Link] ! {Async}
link-channel = channel.make
send-self : Channel[Link] -> Bool ! {Async}
send-self = fork channel.send id Node
receive : Channel[Link] -> Option[Link] ! {Async}
receive = channel.recv
discard-option : Option[Link] -> ()
discard-option = ignore
main = "must not print" | echo | const 1 | link-channel | tap send-self | tap channel.close | receive | discard-option | const "drained" | echo
"#).unwrap();
    for raw in [false, true] {
        for args in [vec!["run", "--interp"], vec!["build", "--emit-c"]] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command.env_remove("FWP_NO_OPT");
            if raw {
                command.env("FWP_NO_OPT", "1");
            }
            let result = command.args(&args).arg(&source).output().unwrap();
            assert!(!result.status.success(), "{raw} {args:?}: {result:?}");
            assert!(result.stdout.is_empty(), "{result:?}");
            let error = String::from_utf8_lossy(&result.stderr);
            assert!(
                error.contains("ownership:") && error.contains("recursive channel ownership"),
                "{error}"
            );
        }
    }
}

#[test]
fn compile_time_calls_and_macro_expansion_obey_lifetime_admission() {
    let dir = fwp::cgen::TempDir::new("compile-time-admission").unwrap();
    for (name, source) in [
        (
            "constant",
            "value = comptime (1 | ad.tape)\nmain = value | echo\n",
        ),
        (
            "macro",
            "macro bad = tap (const 1 | ad.tape | ignore)\nmain = bad!(42) | echo\n",
        ),
    ] {
        let path = dir.join(format!("{name}.fwp"));
        std::fs::write(&path, source).unwrap();
        for raw in [false, true] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command.env_remove("FWP_NO_OPT");
            if raw {
                command.env("FWP_NO_OPT", "1");
            }
            let result = command
                .args(["run", "--interp"])
                .arg(&path)
                .output()
                .unwrap();
            assert!(!result.status.success(), "{name}: {result:?}");
            assert!(result.stdout.is_empty(), "{name}: {result:?}");
            let error = String::from_utf8_lossy(&result.stderr);
            assert!(
                error.contains("outside an autodiff scope"),
                "{name}: {error}"
            );
        }
    }
}
