//! Linear algebra checks independent output sizes and owns temporary storage.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

#[test]
fn qr_checks_square_output_before_allocation_and_preserves_input_errors() {
    let directory = fwp::cgen::TempDir::new("qr-output-size").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (label, rows, count, expected, error) in [
        ("empty", 0, "id", "0\n", ""),
        ("zero-rows", 0, "add 3", "9\n", ""),
        ("byte-overflow", 0, "add 2147483648", "", "array too large"),
        (
            "square-overflow",
            0,
            "add 4294967296",
            "",
            "array too large",
        ),
        (
            "largest",
            0,
            "add 9223372036854775807",
            "",
            "array too large",
        ),
        ("negative", 0, "sub 1", "", "linalg.qr: negative dimension"),
        (
            "input-error-first",
            1,
            "add 4294967296",
            "",
            "linalg.qr: 0 elements given for a 1x4294967296 matrix",
        ),
    ] {
        let input = directory.join(format!("{label}.fwp"));
        std::fs::write(&input, format!(
            "qr-empty : I64 -> (Array[F64], Array[F64])\nqr-empty = linalg.qr {rows} | apply ([] | array.from-list)\nmain = read-all () | string.length | {count} | qr-empty | .1 | array.length | echo\n"
        )).unwrap();
        let reference = Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            reference.status.code(),
            Some(if error.is_empty() { 0 } else { 101 }),
            "{label}: {reference:?}"
        );
        assert_eq!(reference.stdout, expected.as_bytes(), "{label}");
        let stderr = if error.is_empty() {
            String::new()
        } else {
            format!("fwp: trap: {error}\n")
        };
        assert_eq!(reference.stderr, stderr.as_bytes(), "{label}");
        for (gc, optimization) in [("tracing", "-O1"), ("tracing", "-O2"), ("arc", "-O2")] {
            let binary = directory.join(format!("{label}-{optimization}.exe"));
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .args(["build", "--gc", gc, optimization])
                    .arg(&input)
                    .arg("-o")
                    .arg(&binary),
            );
            let actual = Command::new(binary)
                .env("FWP_GC_STRESS", if gc == "arc" { "0" } else { "1" })
                .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
                .env("FWP_REUSE_VERIFY", if gc == "arc" { "0" } else { "1" })
                .output()
                .unwrap();
            assert_eq!(
                (actual.status.code(), actual.stdout, actual.stderr),
                (
                    reference.status.code(),
                    reference.stdout.clone(),
                    reference.stderr.clone()
                ),
                "{label} {optimization}"
            );
        }
    }
}

#[test]
fn solvers_preserve_values_and_reclaim_scratch_and_partial_results() {
    let dir = fwp::cgen::TempDir::new("linalg-ownership").unwrap();
    let input = dir.join("solvers.fwp");
    std::fs::write(&input, include_str!("fixtures/linalg_ownership.fwp")).unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for gc in ["tracing", "arc"] {
        let cfile = dir.join(format!("{gc}.c"));
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let source = std::fs::read_to_string(&cfile).unwrap();
        let binary = dir.join("program.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&source, &binary, opt).unwrap();
            let output = checked(
                Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", if gc == "arc" { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if gc == "arc" { "0" } else { "1" }),
            );
            assert_eq!(output.stdout, reference.stdout, "{gc} {opt}");
            assert_eq!(output.stderr, reference.stderr, "{gc} {opt}");
        }
        let start = source
            .find("/* ------------------------------------------------------- linear algebra */")
            .unwrap();
        let end = start + source[start..].find("/* Borrow each input row").unwrap();
        let body = source[start..end]
            .replace(
                "owner->scratch[slot] = buffer;",
                "owner->scratch[slot] = buffer; la_event();",
            )
            .replace(
                "owner->results[slot] = r;",
                "owner->results[slot] = r; la_event();",
            )
            .replace(
                "V result = fwp_rc_fresh(fwp_some(",
                "la_event();\n    V result = fwp_rc_fresh(fwp_some(",
            )
            .replace(
                "V result = fwp_rc_fresh(fwp_tuple2(",
                "la_event();\n    V result = fwp_rc_fresh(fwp_tuple2(",
            );
        let measured = format!(
            "{}static void la_event(void);\n{body}{}\n{}",
            &source[..start],
            source[end..].replace(
                "int main(int argc, char **argv)",
                "int original_main(int argc, char **argv)"
            ),
            include_str!("fixtures/linalg_ownership_probe.c")
        );
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            for collect in if gc == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                checked(
                    Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", if gc == "arc" { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", "0")
                        .env("FWP_LINALG_COLLECTION", collect),
                );
            }
        }
        for (before, after, expected) in [
            (
                "if (buffer) { FWP_KEEP_ALIVE(buffer); fwp_mem_free(buffer); }",
                "if (buffer) { FWP_KEEP_ALIVE(buffer); }",
                222,
            ),
            (
                "if (value) { FWP_KEEP_ALIVE(value); fwp_rc_free_arr(value); }",
                "if (value) { FWP_KEEP_ALIVE(value); }",
                224,
            ),
        ] {
            assert_eq!(measured.matches(before).count(), 1);
            fwp::cgen::compile_c(&measured.replacen(before, after, 1), &binary, "-O2").unwrap();
            let result = Command::new(&binary)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .env("FWP_LINALG_COLLECTION", "0")
                .output()
                .unwrap();
            assert_eq!(
                result.status.code(),
                Some(expected),
                "{gc} {before}: {result:?}"
            );
        }
    }
}
