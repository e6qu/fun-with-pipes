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
    for no_opt in ["0", "1"] {
        for args in [
            vec!["run", "--interp"],
            vec!["build", "--gc", "arc", "--emit-c"],
        ] {
            let result = Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env("FWP_NO_OPT", no_opt)
                .args(&args)
                .arg(&source)
                .output()
                .unwrap();
            assert!(!result.status.success(), "{no_opt} {args:?}: {result:?}");
            assert!(result.stdout.is_empty(), "{result:?}");
            let error = String::from_utf8_lossy(&result.stderr);
            assert!(
                error.contains("ownership:") && error.contains("recursive channel ownership"),
                "{error}"
            );
        }
    }
}
