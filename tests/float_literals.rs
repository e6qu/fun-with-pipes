//! Literal and macro precision must survive formatting and both engines.
use std::process::Command;

#[test]
fn decimal_source_survives_formatting_and_macro_expansion() {
    let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR"));
    let source = std::fs::read_to_string(root.join("tests/run/float_macro_precision.fwp")).unwrap();
    let expected = std::fs::read(root.join("tests/run/float_macro_precision.out")).unwrap();
    let formatted = fwp::fmt::format_source(&source).unwrap();
    assert!(formatted.contains("1.00000005960464477539062500001f32"));
    assert!(formatted.contains("1.0000000000000000000000000000000002f128"));
    assert_eq!(fwp::fmt::format_source(&formatted).unwrap(), formatted);
    assert!(fwp::fmt::same_program(&source, &formatted));
    let dir = fwp::cgen::TempDir::new("fwp-literal-precision").unwrap();
    for (name, text) in [("original", source), ("formatted", formatted)] {
        let path = dir.join(format!("{name}.fwp"));
        std::fs::write(&path, text).unwrap();
        let raw = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&path)
            .output()
            .unwrap();
        assert!(raw.status.success(), "{raw:?}");
        assert!(raw.stderr.is_empty(), "{raw:?}");
        assert_eq!(raw.stdout, expected);
        for opt in ["-O1", "-O2"] {
            let binary = dir.join(format!("{name}-{opt}"));
            let built = Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .args(["build", opt])
                .arg(&path)
                .arg("-o")
                .arg(&binary)
                .output()
                .unwrap();
            assert!(built.status.success(), "{built:?}");
            let native = Command::new(&binary).output().unwrap();
            assert!(native.status.success(), "{native:?}");
            assert!(native.stderr.is_empty(), "{native:?}");
            assert_eq!(native.stdout, expected);
        }
    }
}
