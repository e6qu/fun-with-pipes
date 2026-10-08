//! Scope completion and explicitly ordered child output survive timer overtaking.
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}: {}",
        out.status,
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}
#[test]
fn channel_orders_prints_even_when_shorter_timer_starts_late() {
    let dir = Scratch(std::env::temp_dir().join(format!("fwp-timer-order-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let source = include_str!("run/tasks.fwp")
        .split("\nmain = [")
        .next()
        .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let expected = b"woke after 20 ms\nwoke after 40 ms\nscope done\n";
    for delayed in [false, true] {
        let body = if delayed {
            // Delay the shorter timer so wake order can differ from print order.
            // The golden fixture joins both children, drains and sorts their results.
            let needle = "    | tap (.1 | duration.from-millis | task.sleep)";
            assert_eq!(source.matches(needle).count(), 1);
            source.replace(needle,
                "    | tap (if (.1 | eq 20) (const 100ms | task.sleep) (const ()))\n    | tap (.1 | duration.from-millis | task.sleep)")
        } else {
            source.to_owned()
        };
        let src = dir.0.join(format!("ordered-{delayed}.fwp"));
        std::fs::write(&src, format!("{body}\nmain = 2 | channel.make | the-ch | tap (scope-wakes | task.scope) | tap channel.close | channel.drain | sort | each (format \"woke after {{}} ms\" | print) | const \"scope done\" | print\n")).unwrap();
        let reference = checked(
            Command::new(fwp)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src),
        );
        assert_eq!(reference.stdout, expected);
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("ordered-{delayed}{opt}"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            for slice in ["1", "37", "1000"] {
                for poison in ["0", "1"] {
                    let native = checked(
                        Command::new(&exe)
                            .env("FWP_PREEMPT", slice)
                            .env("FWP_GC_STRESS", "1")
                            .env("FWP_GC_VERIFY", "1")
                            .env("FWP_REUSE_VERIFY", poison),
                    );
                    assert_eq!(
                        native.stdout, reference.stdout,
                        "delayed={delayed}, {opt}, slice={slice}, poison={poison}"
                    );
                }
            }
        }
    }
}
