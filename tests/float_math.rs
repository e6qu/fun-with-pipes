//! The same fixed-storage math object must execute through C and Rust ABIs.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

const PROBE: &str = r#"
#include <stdint.h>
typedef struct { uint64_t words[2]; } Quad;
#define DECLARE(prefix, Bits) \
Bits prefix##_exp(Bits); Bits prefix##_ln(Bits); Bits prefix##_sin(Bits); \
Bits prefix##_cos(Bits); Bits prefix##_tan(Bits); Bits prefix##_pow(Bits, Bits);
DECLARE(fwp_f16, uint16_t)
DECLARE(fwp_bf16, uint16_t)
DECLARE(fwp_f128, Quad)
int main(void) {
    Quad one = {{0, UINT64_C(0x3fff000000000000)}};
    Quad next = {{1, UINT64_C(0x3fff000000000000)}};
    Quad minus_zero = {{0, UINT64_C(0x8000000000000000)}};
    Quad tiny = {{1, 0}};
    Quad x = fwp_f128_ln(next);
    if (x.words[0] != UINT64_MAX || x.words[1] != UINT64_C(0x3f8effffffffffff)) return 11;
    x = fwp_f128_sin(tiny);
    if (x.words[0] != 1 || x.words[1]) return 12;
    x = fwp_f128_tan(minus_zero);
    if (x.words[0] || x.words[1] != UINT64_C(0x8000000000000000)) return 13;
    x = fwp_f128_cos(minus_zero);
    if (x.words[0] || x.words[1] != one.words[1]) return 14;
    Quad two = {{0, UINT64_C(0x4000000000000000)}};
    Quad thousand = {{0, UINT64_C(0x4008f40000000000)}};
    x = fwp_f128_pow(two, thousand);
    if (x.words[0] || x.words[1] != UINT64_C(0x43e7000000000000)) return 15;
    x = fwp_f128_exp(thousand);
    if (x.words[1] <= UINT64_C(0x4400000000000000) || x.words[1] >= UINT64_C(0x7fff000000000000)) return 16;
    if (fwp_f16_exp(0x3c00) != 0x4170 || fwp_bf16_exp(0x3f80) != 0x402e) return 17;
    if (fwp_f16_ln(0x3c00) || fwp_bf16_ln(0x3f80)) return 18;
    if (fwp_f16_sin(0x8000) != 0x8000 || fwp_bf16_sin(0x8000) != 0x8000) return 19;
    if (fwp_f16_tan(0x8000) != 0x8000 || fwp_bf16_tan(0x8000) != 0x8000) return 20;
    if (fwp_f16_cos(0) != 0x3c00 || fwp_bf16_cos(0) != 0x3f80) return 21;
    if (fwp_f16_pow(0x4000, 0x4200) != 0x4800 || fwp_bf16_pow(0x4000, 0x4040) != 0x4100) return 22;
    return 0;
}
"#;

fn probe(wasi: bool) {
    let dir = fwp::cgen::TempDir::new("fwp-float-math").unwrap();
    let cc = std::env::var(if wasi { "FWP_WASM_CC" } else { "CC" })
        .unwrap_or_else(|_| if wasi { "clang" } else { "cc" }.into());
    let flags: &[&str] = if wasi { &["--target=wasm32-wasi"] } else { &[] };
    if wasi {
        let check = dir.join("check.cpp");
        std::fs::write(&check, "#include <bit>\nint main(){return 0;}\n").unwrap();
        let available = Command::new(&cc)
            .args(flags)
            .args(["-std=c++20", "-c"])
            .arg(&check)
            .arg("-o")
            .arg(dir.join("check.o"))
            .output()
            .is_ok_and(|o| o.status.success());
        if !available {
            assert!(
                std::env::var_os("FWP_REQUIRE_FLOAT_WASI").is_none(),
                "required WASI C++ headers unavailable"
            );
            return;
        }
    }
    let cpp = dir.join("math.cpp");
    let c = dir.join("caller.c");
    let object = dir.join("math.o");
    let binary = dir.join(if wasi {
        "probe.wasm"
    } else if cfg!(windows) {
        "probe.exe"
    } else {
        "probe"
    });
    std::fs::write(&cpp, fwp::softfloat::MATH_SOURCE).unwrap();
    std::fs::write(&c, PROBE).unwrap();
    for opt in ["-O1", "-O2"] {
        checked(
            Command::new(&cc)
                .args(flags)
                .args([
                    "-std=c++20",
                    opt,
                    "-fno-exceptions",
                    "-fno-rtti",
                    "-ffp-contract=off",
                    "-fno-fast-math",
                    "-c",
                ])
                .arg(&cpp)
                .arg("-o")
                .arg(&object),
        );
        let nm = if wasi || cfg!(windows) {
            "llvm-nm"
        } else {
            "nm"
        };
        let symbols = checked(Command::new(nm).arg("-u").arg(&object));
        let symbols = String::from_utf8(symbols.stdout).unwrap();
        for forbidden in [
            "malloc", "calloc", "realloc", "_Zn", "__cxa", "_ZSt", "emutls",
        ] {
            assert!(
                !symbols.contains(forbidden),
                "unexpected runtime dependency {forbidden}: {symbols}"
            );
        }
        // Deliberately link with the C driver and no C++ standard library.
        checked(
            Command::new(&cc)
                .args(flags)
                .args(["-std=c11", opt])
                .arg(&c)
                .arg(&object)
                .arg("-lm")
                .arg("-o")
                .arg(&binary),
        );
        if wasi {
            checked(
                Command::new("node")
                    .arg("--no-warnings")
                    .arg(
                        std::path::Path::new(env!("CARGO_MANIFEST_DIR"))
                            .join("tests/wasm/wasi-run.mjs"),
                    )
                    .arg(&binary),
            );
        } else {
            checked(&mut Command::new(&binary));
        }
    }
}

#[test]
fn format_math_runs_through_native_c_without_heap_or_cpp_runtime() {
    probe(false);
}

#[test]
fn format_math_runs_through_actual_wasi_without_heap_or_cpp_runtime() {
    probe(true);
}

#[cfg(not(windows))]
#[test]
fn zero_numerator_normalization_has_a_sanitized_negative_control() {
    let dir = fwp::cgen::TempDir::new("fwp-math-zero-division").unwrap();
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let source = fwp::softfloat::MATH_SOURCE;
    let missing = source.replace(
        "if (lhs.iszero) return zero(lhs.sign != rhs.sign);",
        "/* omitted zero-numerator guard */",
    );
    assert_ne!(source, missing);
    let cpp = dir.join("math.cpp");
    let object = dir.join("math.o");
    let c = dir.join("caller.c");
    let binary = dir.join("probe");
    std::fs::write(&c, PROBE).unwrap();
    for (code, valid) in [(source, true), (missing.as_str(), false)] {
        std::fs::write(&cpp, code).unwrap();
        checked(
            Command::new(&cc)
                .args([
                    "-std=c++20",
                    "-O1",
                    "-fno-exceptions",
                    "-fno-rtti",
                    "-ffp-contract=off",
                    "-fsanitize=undefined",
                    "-fno-sanitize-recover=all",
                    "-c",
                ])
                .arg(&cpp)
                .arg("-o")
                .arg(&object),
        );
        checked(
            Command::new(&cc)
                .args([
                    "-std=c11",
                    "-O1",
                    "-fsanitize=undefined",
                    "-fno-sanitize-recover=all",
                ])
                .arg(&c)
                .arg(&object)
                .arg("-lm")
                .arg("-o")
                .arg(&binary),
        );
        let result = Command::new(&binary).output().unwrap();
        assert_eq!(result.status.success(), valid, "{result:?}");
        if !valid {
            assert!(
                String::from_utf8_lossy(&result.stderr).contains("shift exponent"),
                "{result:?}"
            );
        }
    }
}
