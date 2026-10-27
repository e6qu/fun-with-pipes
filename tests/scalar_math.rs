//! Scalar math preserves each floating format and agrees across execution modes.
use std::process::{Command, Stdio};

#[test]
fn scalar_math_domains_precision_and_native_ownership() {
    let directory = fwp::cgen::TempDir::new("scalar-math").unwrap();
    let source = directory.join("program.fwp");
    let mut program =
        String::from("seed : () -> I64 ! {IO}\nseed = read-all | string.length\nmain = [\n");
    let mut checks = 0;
    for (suffix, tiny, large) in [
        ("f16", "0.000001", "1000"),
        ("bf16", "1e-20", "1e20"),
        ("f32", "1e-20", "1e20"),
        ("f64", "1e-100", "1e200"),
        ("f128", "1e-4000", "1e4000"),
    ] {
        let zero = format!("(seed () | int.to-float | add 0.0{suffix})");
        for (function, input, expected) in [
            ("asin", "0", "0"),
            ("acos", "1", "0"),
            ("atan", "0", "0"),
            ("sinh", "0", "0"),
            ("cosh", "0", "1"),
            ("tanh", "0", "0"),
            ("asinh", "0", "0"),
            ("acosh", "1", "0"),
            ("atanh", "0", "0"),
            ("log2", "8", "3"),
            ("log10", "1000", "3"),
            ("log1p", "0", "0"),
            ("exp2", "3", "8"),
            ("expm1", "0", "0"),
        ] {
            program += &format!(
                "    (({zero} + {input}.0{suffix}) | {function}) == {expected}.0{suffix} | echo,\n"
            );
            checks += 1;
        }
        for expression in [
            format!("(({zero} + 3.0{suffix}) | hypot 4.0{suffix}) == 5.0{suffix}"),
            format!("({zero} | atan2 1.0{suffix}) == 0.0{suffix}"),
            format!("({zero} | atan2 -1.0{suffix}) > 3.0{suffix}"),
            format!("({zero} | atan2 -1.0{suffix}) < 4.0{suffix}"),
            format!("(({zero} - 2.0{suffix}) | acosh | fork ne id id)"),
            format!("(({zero} + 2.0{suffix}) | asin | fork ne id id)"),
            format!("(({zero} + 2.0{suffix}) | atanh | fork ne id id)"),
            format!("(({zero} + {tiny}{suffix}) | log1p) == {tiny}{suffix}"),
            format!("(({zero} + {tiny}{suffix}) | expm1) == {tiny}{suffix}"),
            format!("(({zero} + {large}{suffix}) | hypot {large}{suffix} | div {large}{suffix}) < 1.5{suffix}"),
            format!("(({zero} + {large}{suffix}) | hypot {large}{suffix} | div {large}{suffix}) > 1.4{suffix}"),
            format!("(1.0{suffix} / (atan -0.0{suffix})) == -(1.0{suffix} / 0.0{suffix})"),
            // A nontrivial independent reference, rounded to each input format.
            format!("(({zero} + 0.5{suffix}) | asin | sub 0.5235987755982988730771072305465838{suffix} | abs) < 0.001{suffix}"),
        ] {
            program += &format!("    {expression} | echo,\n");
            checks += 1;
        }
    }
    program += "] | ignore\n";
    std::fs::write(&source, program).unwrap();
    let expected = "True\n".repeat(checks);
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let interpreted = Command::new(compiler)
        .args(["run", "--interp"])
        .arg(&source)
        .env("FWP_NO_OPT", "1")
        .stdin(Stdio::null())
        .output()
        .unwrap();
    assert!(interpreted.status.success(), "{interpreted:?}");
    assert_eq!(String::from_utf8(interpreted.stdout).unwrap(), expected);
    {
        for optimization in ["-O1", "-O2"] {
            let executable = directory.join(format!(
                "counted{optimization}{}",
                std::env::consts::EXE_SUFFIX
            ));
            let built = Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", optimization])
                .arg(&source)
                .arg("-o")
                .arg(&executable)
                .output()
                .unwrap();
            assert!(built.status.success(), "{built:?}");
            let result = Command::new(&executable)
                .stdin(Stdio::null())
                .output()
                .unwrap();
            assert!(
                result.status.success(),
                "counted {optimization}: {result:?}"
            );
            assert_eq!(
                std::str::from_utf8(&result.stdout).unwrap(),
                expected,
                "counted {optimization}"
            );
            assert!(result.stderr.is_empty(), "{result:?}");
        }
    }
}
