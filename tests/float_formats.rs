//! Declared precision must survive the interpreter, C ABI, text and wire paths.
use std::process::Command;

#[test]
fn declared_formats_agree_in_raw_and_native_execution() {
    let directory = fwp::cgen::TempDir::new("fwp-float-formats").unwrap();
    let source = directory.join("formats.fwp");
    std::fs::write(&source, r#"
quad-half : F128 -> F16
quad-half = float.convert
read-wide : String -> Result[F128, String]
read-wide = json.read
main = [
    1.0001f16 | eq 1.0f16 | echo,
    1.001bf16 | eq 1.0bf16 | echo,
    9007199254740993.0f128 | gt 9007199254740992.0f128 | echo,
    1.0004882812500000000000000000000002f128 | quad-half | gt 1.0f16 | echo,
    "1e400" | parse-float | option.unwrap-or 0.0f128 | ln | gt 900.0f128 | echo,
    1.0000000000000000000000000000000002f128 | ln | gt 0.0f128 | echo,
    7.0f128 | rem 4.0f128 | eq 3.0f128 | echo,
    -2.5f16 | round | eq -3.0f16 | echo,
    1.0e-40bf16 | gt 0.0bf16 | echo,
    1.0000000000000000000000000000000002f128 | json.write | read-wide | result.unwrap-or 0.0f128 | gt 1.0f128 | echo,
    [1.0001f16, 2.0f16] | array.from-list | array.to-list | head | eq (Some 1.0f16) | echo,
] | ignore
"#).unwrap();
    let expected = "True\n".repeat(11).into_bytes();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let raw = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(raw.status.success(), "{raw:?}");
    assert_eq!(raw.stdout, expected, "{raw:?}");
    assert!(raw.stderr.is_empty(), "{raw:?}");
    for opt in ["-O1", "-O2"] {
        let binary = directory.join(format!("formats-{}", &opt[1..]));
        let built = Command::new(fwp)
            .env_remove("FWP_NO_OPT")
            .env("FWP_CACHE_DIR", directory.join("cache"))
            .args(["build", opt])
            .arg(&source)
            .arg("-o")
            .arg(&binary)
            .output()
            .unwrap();
        assert!(built.status.success(), "{built:?}");
        let native = Command::new(&binary).output().unwrap();
        assert!(native.status.success(), "{native:?}");
        assert!(native.stderr.is_empty(), "{native:?}");
        assert_eq!(native.stdout, expected, "{native:?}");
    }
}
