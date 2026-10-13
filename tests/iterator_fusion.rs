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
strings : String -> String
strings = concat | flip iter.iterate "seed" | iter.take 4 | iter.fold (flip concat) ""
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
    1 | iter.iterate (mul 3) | iter.take 6 | iter.fold add 0 | echo,
    "seed" | iter.iterate (concat "x") | iter.take 8 | iter.fold (flip concat) "" | echo,
    0 | iter.iterate (add 3) | iter.find (gt 19) | echo,
    "x" | string.repeat 3 | strings | echo,
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

#[test]
fn producer_lookahead_and_exhausted_stage_order_match_raw_interpreter() {
    let dir = std::env::temp_dir().join(format!("fwp-producer-order-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let cases = [
        "9223372036854775807 | iter.count-from | iter.take 0 | iter.fold add 0 | echo",
        "9223372036854775806 | iter.count-from | iter.take 1 | iter.fold add 0 | echo",
        "9223372036854775806 | iter.count-from | iter.take 2 | iter.fold add 0 | echo",
        "0 | iter.count-from | iter.map (div 0) | iter.take 0 | iter.fold add 0 | echo",
        "0 | iter.count-from | iter.filter (div 0 | eq 1) | iter.take 0 | iter.fold add 0 | echo",
        "0 | iter.count-from | iter.take 0 | iter.map (div 0) | iter.fold add 0 | echo",
        "0 | iter.count-from | iter.filter (gt 2) | iter.take 0 | iter.fold add 0 | echo",
        "0 | iter.iterate (div 0) | iter.take 0 | iter.fold add 0 | echo",
        "9223372036854775806 | iter.iterate (add 1) | iter.take 1 | iter.fold add 0 | echo",
        "9223372036854775806 | iter.iterate (add 1) | iter.take 2 | iter.fold add 0 | echo",
        "9223372036854775806 | iter.iterate (add 1) | iter.find (const True) | echo",
        "0 | iter.iterate (add 2) | iter.filter (div 0 | eq 1) | iter.take 0 | iter.fold add 0 | echo",
        "[1, 2, 3] | iter.from-list | iter.map (add 1) | iter.fold add 0 | echo",
        "[1, 2, 3] | iter.from-list | iter.take 1 | iter.filter (gt 2) | iter.fold add 0 | echo",
    ];
    for (i, body) in cases.iter().enumerate() {
        let input = dir.join(format!("case-{i}.fwp"));
        std::fs::write(&input, format!("main = {body}\n")).unwrap();
        let reference = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert!(
            reference.status.success() || reference.status.code() == Some(101),
            "{reference:?}"
        );
        for producers in ["0", "1"] {
            let binary = dir.join(format!("case-{i}-{producers}"));
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_ITER_PRODUCERS", producers)
                    .args(["build", "-O2"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&binary),
            );
            let native = Command::new(&binary)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(
                native.status.code(),
                reference.status.code(),
                "case {i}/{producers}: {native:?}"
            );
            assert_eq!(native.stdout, reference.stdout, "case {i}/{producers}");
            assert_eq!(native.stderr, reference.stderr, "case {i}/{producers}");
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
