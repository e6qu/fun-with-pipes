//! Exact-format core execution in native C and actual wasm32, before language
//! representation migration. Raw bits are independent mathematical goldens.
use std::process::Command;

const PROBE: &str = r#"
int main(void) {
    float128_t one = {{0, UINT64_C(0x3fff000000000000)}};
    float128_t next = {{1, UINT64_C(0x3fff000000000000)}};
    float128_t difference = f128_sub(next, one);
    if (difference.v[0] || difference.v[1] != UINT64_C(0x3f8f000000000000)) return 11;
    float128_t third = f128_div(one, ui64_to_f128(3));
    if (third.v[0] != UINT64_C(0x5555555555555555) || third.v[1] != UINT64_C(0x3ffd555555555555)) return 12;
    float128_t root = f128_sqrt(ui64_to_f128(2));
    if (root.v[0] != UINT64_C(0xc908b2fb1366ea95) || root.v[1] != UINT64_C(0x3fff6a09e667f3bc)) return 13;
    float128_t above_half_midpoint = {{1, UINT64_C(0x3fff002000000000)}};
    if (f128_to_f16(above_half_midpoint).v != 0x3c01) return 14;
    for (uint32_t bits = 0; bits <= 0xffff; bits++) {
        if ((bits & 0x7c00) == 0x7c00 && (bits & 0x3ff)) continue;
        float16_t half = {(uint16_t)bits};
        if (f128_to_f16(f16_to_f128(half)).v != bits) return 15;
    }
    return 0;
}
"#;

#[test]
fn exact_format_core_runs_as_native_c() {
    let dir = fwp::cgen::TempDir::new("fwp-softfloat-native").unwrap();
    let binary = dir.join(if cfg!(windows) { "probe.exe" } else { "probe" });
    let source = format!("{}\n{PROBE}", fwp::softfloat::C_SOURCE);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&source, &binary, opt).unwrap();
        let out = Command::new(&binary).output().unwrap();
        assert!(out.status.success(), "{opt}: {out:?}");
    }
}

#[test]
fn exact_format_core_runs_as_wasm32() {
    let dir = fwp::cgen::TempDir::new("fwp-softfloat-wasi").unwrap();
    let check = dir.join("check.c");
    std::fs::write(&check, "int main(void){return 0;}").unwrap();
    let available = Command::new(std::env::var("FWP_WASM_CC").unwrap_or_else(|_| "clang".into()))
        .args(["--target=wasm32-wasi", "-o"])
        .arg(dir.join("check.wasm"))
        .arg(check)
        .output()
        .is_ok_and(|o| o.status.success())
        && Command::new("node")
            .arg("--version")
            .output()
            .is_ok_and(|o| o.status.success());
    if !available {
        assert!(
            std::env::var_os("FWP_REQUIRE_FLOAT_WASI").is_none(),
            "required wasm32 float core toolchain unavailable"
        );
        return;
    }
    let wasm = dir.join("probe.wasm");
    let source = format!("{}\n{PROBE}", fwp::softfloat::C_SOURCE);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_for(&source, &wasm, opt, fwp::cgen::Target::Wasi).unwrap();
        let out = Command::new("node")
            .arg("--no-warnings")
            .arg(std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/wasm/wasi-run.mjs"))
            .arg(&wasm)
            .output()
            .unwrap();
        assert!(out.status.success(), "{opt}: {out:?}");
    }
}
