//! Whole match binders retain stack aggregate children before scrutinee release.
use std::io::Write;
use std::process::{Command, Output, Stdio};

fn run(command: &mut Command, input: &[u8]) -> Output {
    let mut child = command
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child.stdin.take().unwrap().write_all(input).unwrap();
    child.wait_with_output().unwrap()
}

#[test]
fn whole_stack_match_binders_own_children_and_return_aliases() {
    let dir = fwp::cgen::TempDir::new("stack-match-owners").unwrap();
    let source = dir.join("probe.fwp");
    std::fs::write(
        &source,
        r#"
choose : (String, String) -> String
choose = match
    ("never", _) -> id
    _ -> .1
main = read-all () | make { 0 = id, 1 = concat "payload" } | choose | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let inputs: [&[u8]; 2] = [b"tag", b"never"];
    let references: Vec<_> = inputs
        .iter()
        .map(|input| {
            let out = run(
                Command::new(fwp)
                    .env("FWP_NO_OPT", "1")
                    .args(["run", "--interp"])
                    .arg(&source),
                input,
            );
            assert!(out.status.success(), "{out:?}");
            out
        })
        .collect();
    assert_eq!(references[0].stdout, b"tagpayload\n");
    assert_eq!(references[1].stdout, b"neverpayload\n");
    let cfile = dir.join("probe.c");
    let build = Command::new(fwp)
        .arg("build")
        .arg(&source)
        .args(["--emit-c", "-o"])
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(build.status.success(), "{build:?}");
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    // Remove only the whole binder's child retains. This restores its previous
    // no-op outer-pointer retain, leaving every child release and allocation.
    let mut erased = String::new();
    let mut omitted = 0;
    for line in emitted.lines() {
        if line.trim_start().starts_with("fwp_rc_dup(") && line.matches("fwp_rc_dup(").count() == 2
        {
            omitted += 1;
            erased.push_str("/* omitted whole binder child retains */\n");
        } else {
            erased.push_str(line);
            erased.push('\n');
        }
    }
    assert_eq!(omitted, 1, "expected one whole stack binder retain");
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&erased, &exe, opt).unwrap();
        let broken = run(Command::new(&exe).env("FWP_REUSE_VERIFY", "1"), inputs[0]);
        assert!(
            !broken.status.success() || broken.stdout != references[0].stdout,
            "omitting retains must expose the released child: {broken:?}"
        );
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
        for gc in ["off", "on"] {
            for poison in ["0", "1"] {
                for (input, reference) in inputs.iter().zip(&references) {
                    let out = run(
                        Command::new(&exe)
                            .env("FWP_GC", gc)
                            .env("FWP_GC_STRESS", "1")
                            .env("FWP_GC_VERIFY", "1")
                            .env("FWP_REUSE_VERIFY", poison),
                        input,
                    );
                    assert!(out.status.success(), "{opt}/{gc}/{poison}: {out:?}");
                    assert_eq!(out.stdout, reference.stdout);
                    assert_eq!(out.stderr, reference.stderr);
                }
            }
        }
    }
}
