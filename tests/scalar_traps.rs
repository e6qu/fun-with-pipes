//! The traps of plain-C arithmetic (`src/cgen.rs`, `Scalar`): overflow,
//! division by zero and `MIN / -1` in every fixed-width integer type, each
//! a program of its own, natively and in the interpreter alike.

use std::path::PathBuf;
use std::process::Command;

fn fwp() -> &'static str {
    env!("CARGO_BIN_EXE_fwp")
}

fn have_cc() -> bool {
    Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok_and(|o| o.status.success())
}

const CASES: &[&str] = &[
    "127i8 | add 1",
    "-128i8 | sub 1",
    "16i8 | mul 8",
    "-128i8 | div -1",
    "-128i8 | rem -1",
    "-128i8 | neg",
    "5i8 | div 0",
    "32767i16 | add 1",
    "-32768i16 | mul -1",
    "2147483647i32 | add 1",
    "-2147483648i32 | div -1",
    "65536i32 | mul 32768",
    "9223372036854775807 | add 1",
    "-9223372036854775807 | sub 2",
    "4294967296 | mul 2147483648",
    "-9223372036854775807 | sub 1 | div -1",
    "-9223372036854775807 | sub 1 | rem -1",
    "-9223372036854775807 | sub 1 | neg",
    "7 | rem 0",
    "255u8 | add 1",
    "0u8 | sub 1",
    "16u8 | mul 16",
    "3u8 | rem 0",
    "65535u16 | add 1",
    "4294967295u32 | add 1",
    "0u32 | sub 1",
    "1u32 | div 0",
    "18446744073709551615u64 | add 1",
    "0u64 | sub 1",
    "4294967296u64 | mul 4294967296",
    "9u64 | div 0",
];

fn outcome(c: &mut Command) -> String {
    let o = c.output().unwrap();
    format!(
        "{}--- stderr\n{}--- exit {:?}",
        String::from_utf8_lossy(&o.stdout),
        String::from_utf8_lossy(&o.stderr),
        o.status.code()
    )
}

#[test]
fn traps_agree() {
    assert!(
        have_cc(),
        "native scalar checks require a working C compiler"
    );
    let dir = std::env::temp_dir().join(format!("fwp-scalar-traps-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let cache = dir.join("cache");
    let threads: Vec<_> = CASES
        .iter()
        .enumerate()
        .map(|(i, case)| {
            let file: PathBuf = dir.join(format!("t{}.fwp", i));
            std::fs::write(
                &file,
                format!("main = [\"before\" | echo, {} | echo] | ignore\n", case),
            )
            .unwrap();
            let cache = cache.clone();
            std::thread::spawn(move || {
                let interp = outcome(Command::new(fwp()).args(["run", "--interp"]).arg(&file));
                let native = outcome(
                    Command::new(fwp())
                        .args(["run", "-O1"])
                        .arg(&file)
                        .env("FWP_CACHE_DIR", &cache),
                );
                (case, interp, native)
            })
        })
        .collect();
    let mut failures = Vec::new();
    for t in threads {
        let (case, interp, native) = t.join().unwrap();
        if !interp.contains("fwp: trap: ") || !interp.contains("--- exit Some(101)") {
            failures.push(format!(
                "{}: the interpreter did not trap:\n{}",
                case, interp
            ));
        } else if interp != native {
            failures.push(format!(
                "{}:\ninterpreter:\n{}\nnative:\n{}",
                case, interp, native
            ));
        }
    }
    let _ = std::fs::remove_dir_all(&dir);
    assert!(failures.is_empty(), "{}", failures.join("\n\n"));
}

#[test]
fn narrow_unsigned_products_check_bounds_before_trapping() {
    let dir = fwp::cgen::TempDir::new("unsigned-products").unwrap();
    let input = dir.join("products.fwp");
    let mut source = String::new();
    let mut cases = Vec::new();
    for (bits, root) in [(8, 15u64), (16, 255), (32, 65535)] {
        let max = (1u64 << bits) - 1;
        source.push_str(&format!(
            "# expose: cli\nexport product{bits} : U{bits} -> U{bits} -> () ! {{IO}}\n\
             product{bits} = curry (tap (const \"before\" | echo) | uncurry mul | tap echo | const \"after\" | echo)\n"
        ));
        let mut pairs = vec![
            (0, max),
            (1, max),
            (max, 1),
            (max, 0),
            (root, root),
            (root + 1, root + 1),
            (max, 2),
            (max, max),
        ];
        if bits == 32 {
            // Products immediately below/above I64::MAX: both must produce
            // the language's U32 overflow trap, without overflowing C first.
            pairs.extend([
                (3037000499, 3037000499),
                (3037000500, 3037000500),
                (max, 2147483648),
                (max, 2147483649),
            ]);
        }
        for (a, b) in pairs {
            let expected = match a.checked_mul(b).filter(|product| *product <= max) {
                Some(product) => format!("before\n{product}\nafter\n--- stderr\n--- exit Some(0)"),
                None => format!("before\n--- stderr\nfwp: trap: arithmetic overflow in U{bits}\n--- exit Some(101)"),
            };
            cases.push((bits, a, b, expected));
        }
    }
    std::fs::write(&input, source).unwrap();
    for (bits, a, b, expected) in &cases {
        let actual = outcome(
            Command::new(fwp())
                .env("FWP_NO_OPT", "1")
                .env_remove("FWP_OUT")
                .env("FWP_TRANSPORT", "stdio")
                .args(["exec", "--interp", "--cli"])
                .arg(&input)
                .args([format!("product{bits}"), a.to_string(), b.to_string()]),
        );
        assert_eq!(&actual, expected, "interpreter U{bits}: {a} * {b}");
    }
    for memory in ["arc", "tracing"] {
        let cfile = dir.join("products.c");
        let emitted = Command::new(fwp())
            .env_remove("FWP_NO_OPT")
            .args(["build", "--cli", "--gc", memory, "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(emitted.status.success(), "{emitted:?}");
        let code = std::fs::read_to_string(&cfile).unwrap();
        for opt in ["-O0", "-O2", "-O3"] {
            let binary = dir.join("products.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let stress = if memory == "arc" { "0" } else { "1" };
            for (bits, a, b, expected) in &cases {
                let actual = outcome(
                    Command::new(&binary)
                        .args([format!("product{bits}"), a.to_string(), b.to_string()])
                        .env_remove("FWP_OUT")
                        .env("FWP_TRANSPORT", "stdio")
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress),
                );
                assert_eq!(&actual, expected, "{memory}/{opt} U{bits}: {a} * {b}");
            }
        }
        if memory == "tracing" {
            continue;
        }
        // Test the emitted primitive itself under UBSan. Dynamic argv operands
        // prevent constant folding from hiding undefined intermediate arithmetic.
        let marker = "/* prim.mul : U32 -> U32 -> U32 */\n";
        let (_, tail) = code.split_once(marker).expect("emitted U32 multiply");
        let (body, _) = tail.split_once("\n}\n").unwrap();
        let primitive = format!("{body}\n}}\n");
        let name = body
            .strip_prefix("static V ")
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let good_product = "uint64_t r = (uint64_t)l1 * (uint64_t)l0;";
        assert_eq!(primitive.matches(good_product).count(), 1);
        let broken = primitive.replace(good_product, "int64_t r = (int64_t)l1 * (int64_t)l0;");
        for (label, implementation) in [("fixed", &primitive), ("negative-control", &broken)] {
            let sanitized = format!(
                r#"#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#ifdef _WIN32
#include <io.h>
#include <fcntl.h>
#endif
typedef uint64_t V;
static void fwp_trap_overflow(const char *type) {{
    fprintf(stderr, "fwp: trap: arithmetic overflow in %s\n", type);
    exit(101);
}}
{implementation}
int main(int argc, char **argv) {{
    if (argc != 3) return 2;
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0 ||
        _setmode(_fileno(stderr), _O_BINARY) < 0) return 3;
#endif
    V a = strtoull(argv[1], 0, 10), b = strtoull(argv[2], 0, 10);
    puts("before");
    printf("%llu\n", (unsigned long long){name}(b, a));
    puts("after");
    return 0;
}}
"#
            );
            std::fs::write(&cfile, &sanitized).unwrap();
            for opt in ["-O1", "-O2"] {
                let binary = dir.join(format!("{label}{opt}.exe"));
                let (cc, flags) = fwp::cgen::c_compiler().unwrap();
                let compiled = Command::new(cc)
                    .args(flags)
                    .args([
                        opt,
                        "-std=gnu11",
                        "-fsanitize=undefined",
                        "-fno-sanitize-recover=undefined",
                    ])
                    .arg(&cfile)
                    .arg("-o")
                    .arg(&binary)
                    .output()
                    .unwrap();
                assert!(compiled.status.success(), "{label}/{opt}: {compiled:?}");
                if label == "fixed" {
                    for (_, a, b, expected) in cases.iter().filter(|case| case.0 == 32) {
                        let actual =
                            outcome(Command::new(&binary).args([a.to_string(), b.to_string()]));
                        assert_eq!(&actual, expected, "UBSan/{opt}: {a} * {b}");
                    }
                } else {
                    let actual = Command::new(&binary)
                        .args(["4294967295", "4294967295"])
                        .output()
                        .unwrap();
                    assert!(!actual.status.success(), "{actual:?}");
                    assert!(
                        String::from_utf8_lossy(&actual.stderr).contains("signed integer overflow"),
                        "{actual:?}"
                    );
                }
            }
        }
    }
}

#[test]
fn full_width_unsigned_products_have_defined_overflow() {
    assert!(
        have_cc(),
        "native scalar checks require a working C compiler"
    );
    let dir = std::env::temp_dir().join(format!("fwp-u64-products-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let input = dir.join("runtime.fwp");
    let cfile = dir.join("products.c");
    std::fs::write(&input, "main = ()\n").unwrap();
    let emitted = Command::new(fwp())
        .args(["build", "--emit-c"])
        .arg(&input)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    // Exercise the shared checked-arithmetic runtime with actual dynamic
    // operands. Language constant folding must not hide C undefined behavior.
    let runtime = std::fs::read_to_string(&cfile).unwrap();
    std::fs::write(
        &cfile,
        format!(
            "#define main saved_main\n{runtime}\n#undef main\n{}",
            r#"
int main(int argc, char **argv) {
    if (argc != 3) return 2;
#ifdef _WIN32
    /* Match generated fwp entries: compare bytes without CRT newline rewriting. */
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 3;
#endif
    V a = strtoull(argv[1], 0, 10), b = strtoull(argv[2], 0, 10), out = 0;
    int err = 0, ok = fwp_arith_raw(K_U64, OP_MUL, a, b, 0, &out, &err);
    printf("%d %d %llu\n", ok, err, (unsigned long long)out);
    return 0;
}
"#
        ),
    )
    .unwrap();
    let values = [
        0u64,
        1,
        2,
        (1u64 << 32) - 1,
        1u64 << 32,
        1u64 << 63,
        u64::MAX,
    ];
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("products{opt}.exe"));
        let compiled = Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
            .args([
                opt,
                "-w",
                "-fsanitize=undefined",
                "-fno-sanitize-recover=undefined",
            ])
            .arg(&cfile)
            .arg("-o")
            .arg(&binary)
            .args(["-lm", "-lpthread"])
            .output()
            .unwrap();
        assert!(compiled.status.success(), "{compiled:?}");
        for a in values {
            for b in values {
                let expected = match a.checked_mul(b) {
                    Some(product) => format!("1 0 {product}\n"),
                    None => "0 1 0\n".into(),
                };
                let actual = Command::new(&binary)
                    .args([a.to_string(), b.to_string()])
                    .output()
                    .unwrap();
                assert!(actual.status.success(), "{opt}: {a} * {b}: {actual:?}");
                assert_eq!(String::from_utf8_lossy(&actual.stdout), expected);
                assert!(actual.stderr.is_empty(), "{actual:?}");
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
