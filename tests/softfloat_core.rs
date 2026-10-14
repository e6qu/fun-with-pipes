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
    float128_t above_bfloat_midpoint = {{1, UINT64_C(0x3fff010000000000)}};
    if (fwp_f128_to_bf16(above_bfloat_midpoint) != 0x3f81) return 16;
    if (fwp_bf16_div(0x3f80, 0x4040) != 0x3eab) return 17;
    if (fwp_bf16_sqrt(0x4000) != 0x3fb5) return 18;
    if (fwp_bf16_add(0x3f80, 0x3b80) != 0x3f80) return 19;
    if (fwp_bf16_add(0x3f81, 0x3b80) != 0x3f82) return 20;
    if (fwp_bf16_div(1, 0x4000) != 0) return 21;
    if (fwp_bf16_mul(0x7f7f, 0x4000) != 0x7f80) return 22;
    if (softfloat_roundingMode != softfloat_round_near_even) return 23;
    for (uint32_t bits = 0; bits <= 0xffff; bits++) {
        if ((bits & 0x7f80) == 0x7f80 && (bits & 0x7f)) continue;
        if (fwp_f128_to_bf16(fwp_bf16_to_f128((uint16_t)bits)) != bits) return 24;
    }
    uint64_t low, high;
    if (fwp_decimal_parse("1.0000000000000000000000000000000002", 128, &low, &high) != 1 ||
        low != 1 || high != UINT64_C(0x3fff000000000000)) return 31;
    if (fwp_decimal_parse("1.0004882812500000000000000000000001", 16, &low, &high) != 1 || low != 0x3c01 || high) return 32;
    if (fwp_decimal_parse("1.0039062500000000000000000000000001", 17, &low, &high) != 1 || low != 0x3f81 || high) return 33;
    if (fwp_decimal_parse("4.5e-6", 16, &low, &high) != 1 || low != 0x4b || high) return 34;
    char text[64];
    for (int format = 16; format <= 17; format++) {
        uint32_t expmask = format == 16 ? 0x7c00 : 0x7f80, fracmask = format == 16 ? 0x3ff : 0x7f;
        for (uint32_t bits = 0; bits <= 0xffff; bits++) {
            if ((bits & expmask) == expmask && (bits & fracmask)) continue;
            if (fwp_decimal_show(bits, 0, format, text, sizeof text) < 1) return 35;
            if (fwp_decimal_parse(text, format, &low, &high) != 1 || low != bits || high) return 36;
        }
    }
    if (fwp_decimal_show(1, UINT64_C(0x3fff000000000000), 128, text, sizeof text) < 1) return 37;
    if (strcmp(text, "1.0000000000000000000000000000000002")) return 38;
    uint64_t state = UINT64_C(0x123456789abcdef0);
    for (unsigned i = 0; i < 1000; i++) {
        state ^= state << 13; state ^= state >> 7; state ^= state << 17;
        uint64_t original_high = state;
        state ^= state << 13; state ^= state >> 7; state ^= state << 17;
        uint64_t original_low = state;
        if (((original_high >> 48) & 0x7fff) == 0x7fff) continue;
        if (fwp_decimal_show(original_low, original_high, 128, text, sizeof text) < 1) return 48;
        if (fwp_decimal_parse(text, 128, &low, &high) != 1 || low != original_low || high != original_high) return 49;
    }
    if (fwp_decimal_parse("6.4751751194380251109244389582276465525e-4966", 128, &low, &high) != 1 || low != 1 || high) return 39;
    if (fwp_decimal_parse("1.1897314953572317650857593266280070162e4932", 128, &low, &high) != 1 || low != UINT64_MAX || high != UINT64_C(0x7ffeffffffffffff)) return 40;
    if (fwp_u128_to_bf16(1, UINT64_C(0x0101000000000000)) != 0x7b81) return 51;
    if (fwp_f128_to_bf16(fwp_u128_to_f128(1, UINT64_C(0x0101000000000000))) != 0x7b80) return 52;
    if (fwp_u128_to_f16(2051, 0) != 0x6802) return 53;
    int negative;
    float128_t p127 = fwp_u128_to_f128(0, UINT64_C(0x8000000000000000));
    if (!fwp_f128_to_integer(p127, &low, &high, &negative) || low || high != UINT64_C(0x8000000000000000) || negative) return 54;
    if (fwp_f128_to_integer(fwp_u128_to_f128(UINT64_MAX, UINT64_MAX), &low, &high, &negative)) return 55;
    if (fwp_f128_compare(one, next) != -1 || fwp_f128_compare(next, one) != 1) return 56;
    float128_t minus_zero = {{0, UINT64_C(0x8000000000000000)}}, zero = {{0, 0}};
    if (fwp_f128_compare(minus_zero, zero)) return 57;
    float128_t nan = {{1, UINT64_C(0x7fff000000000000)}};
    if (fwp_f128_compare(nan, one) != 2 || fwp_f128_compare(one, nan) != 2) return 58;
    return 0;
}
"#;

fn wasi_available(dir: &fwp::cgen::TempDir) -> bool {
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
    }
    available
}

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
    if !wasi_available(&dir) {
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

#[test]
fn decimal_temporary_storage_is_released_on_success_and_every_allocation_failure() {
    let observer = r#"
#include <stdlib.h>
static size_t live_blocks, attempts, fail_after = (size_t)-1;
static void *observed_malloc(size_t bytes) {
    if (attempts++ == fail_after) return NULL;
    void *p = malloc(bytes);
    if (p) live_blocks++;
    return p;
}
static void observed_free(void *p) {
    if (p) live_blocks--;
    free(p);
}
"#;
    let probe = r#"
int main(void) {
    fwp_decimal_set_allocator(observed_malloc, observed_free);
    uint64_t low, high;
    char shown[64];
    if (fwp_decimal_parse("1.25", 128, &low, &high) != 1 || attempts || live_blocks) return 41;
    if (fwp_decimal_show(low, high, 128, shown, sizeof shown) < 1 || attempts || live_blocks) return 42;
    char exact[5004]; exact[0] = '1'; exact[1] = '.';
    memset(exact + 2, '0', 5000); exact[5002] = '1'; exact[5003] = 0;
    attempts = 0;
    if (fwp_decimal_parse(exact, 128, &low, &high) != 1 || low || high != UINT64_C(0x3fff000000000000) || live_blocks) return 43;
    size_t allocations = attempts;
    if (!allocations) return 44;
    for (size_t fail = 0; fail < allocations; fail++) {
        fail_after = fail; attempts = 0;
        if (fwp_decimal_parse(exact, 128, &low, &high) != -1 || live_blocks) return 45;
    }
    fail_after = (size_t)-1; attempts = 0;
    if (fwp_decimal_show(UINT64_MAX, UINT64_C(0x7ffeffffffffffff), 128, shown, sizeof shown) < 1 || live_blocks) return 46;
    allocations = attempts;
    for (size_t fail = 0; fail < allocations; fail++) {
        fail_after = fail; attempts = 0;
        if (fwp_decimal_show(UINT64_MAX, UINT64_C(0x7ffeffffffffffff), 128, shown, sizeof shown) != -1 || live_blocks) return 47;
    }
    return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("fwp-decimal-storage").unwrap();
    let binary = dir.join(if cfg!(windows) { "probe.exe" } else { "probe" });
    let source = format!("{observer}\n{}\n{probe}", fwp::softfloat::C_SOURCE);
    let leaked = source.replace(
        "    fwp_decimal_release(&context);",
        "    /* omit scoped release */",
    );
    assert_ne!(leaked, source);
    let wasi = wasi_available(&dir);
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(&source, 0), (&leaked, 43)] {
            fwp::cgen::compile_c(code, &binary, opt).unwrap();
            let output = Command::new(&binary).output().unwrap();
            assert_eq!(
                output.status.code(),
                Some(expected),
                "native {opt}: {output:?}"
            );
            if wasi {
                let wasm = dir.join("storage.wasm");
                fwp::cgen::compile_for(code, &wasm, opt, fwp::cgen::Target::Wasi).unwrap();
                let output = Command::new("node")
                    .arg("--no-warnings")
                    .arg(
                        std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
                            .join("tests/wasm/wasi-run.mjs"),
                    )
                    .arg(wasm)
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "WASI {opt}: {output:?}"
                );
            }
        }
    }
}
