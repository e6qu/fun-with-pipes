//! Direct iterator fusion must preserve lazy forcing and callback ordering.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

#[test]
fn fused_consumers_preserve_raw_effects_early_stop_and_owned_captures() {
    let dir = std::env::temp_dir().join(format!("fwp-iterator-fusion-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let input = dir.join("consumers.fwp");
    std::fs::write(&input, r#"
poison : Iterator[I64]
poison = Yield 7 (fork Yield (const 1 | div 0) (const (const Done)))
fail-step : I64 -> I64 -> I64 ! {Error[String]}
fail-step = curry (const "callback first" | fail)
main = [
    0 | iter.count-from | iter.take 1000 | iter.map (add 1) | iter.filter (rem 2 | eq 0) | iter.fold add 0 | echo,
    poison | iter.map (add 1) | iter.find (eq 8) | echo,
    poison | iter.take 1 | iter.fold add 0 | echo,
    poison | iter.map (add 1) | attempt (iter.fold fail-step 0) | echo,
    poison | iter.take 0 | iter.each (div 0 | ignore) | echo,
    ["a", "b", "c"] | iter.from-list | iter.map upper | iter.fold (flip concat) "seed:" | echo,
    [1, 2, 3] | iter.from-list | iter.take 2 | run-state [] (iter.each (Cons | modify)) | echo,
    [1, 2, 3] | iter.from-list | iter.map (add 1) | run-state [] (iter.find (tap (Cons | modify) | gt 2)) | echo,
    [] | list._test-ints | iter.from-list | iter.fold add 17 | echo,
] | ignore
"#).unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for enabled in ["0", "1"] {
        let cfile = dir.join(format!("fusion-{enabled}.c"));
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_ITER_CONSUMERS", enabled)
                .args(["build", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        assert_eq!(code.contains("/* fused-iter :"), enabled == "1");
        for opt in ["-O1", "-O2"] {
            let binary = dir.join(format!("fusion-{enabled}{opt}"));
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            for stress in ["0", "1"] {
                let actual = checked(
                    Command::new(&binary)
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress),
                );
                assert_eq!(
                    actual.stdout, reference.stdout,
                    "fusion={enabled} opt={opt} stress={stress}"
                );
                assert!(actual.stderr.is_empty(), "{actual:?}");
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
