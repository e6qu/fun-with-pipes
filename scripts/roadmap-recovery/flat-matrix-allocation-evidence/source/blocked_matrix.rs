//! Specialized F64 matrix storage must retain raw language behavior.
use std::process::{Command, Output};
fn checked(c: &mut Command) -> Output {
    let o = c.output().unwrap();
    assert!(
        o.status.success(),
        "{c:?}: {} {}",
        String::from_utf8_lossy(&o.stdout),
        String::from_utf8_lossy(&o.stderr)
    );
    o
}
#[test]
fn blocked_matrix_preserves_raw_products_and_cast_shape_behavior() {
    let d = std::env::temp_dir().join(format!("fwp-blocked-matrix-{}", std::process::id()));
    std::fs::create_dir(&d).unwrap();
    let input = d.join("matrix.fwp");
    std::fs::write(&input, include_str!("fixtures/blocked_matrix.fwp")).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for mode in ["0", "1"] {
        let interp = checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_MATRIX_BLOCKING", mode)
                .args(["run", "--interp"])
                .arg(&input),
        );
        assert_eq!(
            (&interp.stdout, &interp.stderr),
            (&reference.stdout, &reference.stderr)
        );
        let generated = d.join(format!("matrix-{mode}.c"));
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_MATRIX_BLOCKING", mode)
                .args(["build", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&generated),
        );
        let code = std::fs::read_to_string(&generated).unwrap();
        assert_eq!(
            code.contains("/* matrix._mul-f64 :"),
            mode == "1",
            "matrix specialization absent or active when disabled"
        );
        for opt in ["-O1", "-O2"] {
            let exe = d.join(format!("matrix-{mode}{opt}"));
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            let actual = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "1"),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr),
                "mode={mode} {opt}"
            );
        }
    }
    std::fs::remove_dir_all(d).unwrap();
}
#[test]
fn blocked_matrix_uses_only_output_storage_and_preserves_scalar_order() {
    let d = std::env::temp_dir().join(format!("fwp-blocked-matrix-alloc-{}", std::process::id()));
    std::fs::create_dir(&d).unwrap();
    let input = d.join("matrix.fwp");
    let source=format!("{}\nexport product-data : Matrix[F64, 3, 2] -> Matrix[F64, 2, 3] -> Array[F64]\nproduct-data = curry (uncurry matmul | .data)\n",include_str!("fixtures/blocked_matrix.fwp"));
    std::fs::write(&input, source).unwrap();
    for mode in ["0", "1"] {
        let generated = d.join(format!("matrix-{mode}.c"));
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_MATRIX_BLOCKING", mode)
                .args(["build", "--fn", "product-data", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&generated),
        );
        let source = std::fs::read_to_string(&generated).unwrap();
        let start = source.find("/* product-data :").unwrap();
        let id = source[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let probe = include_str!("fixtures/matrix_allocation_probe.c")
            .replace("fPRODUCT_DATA", &format!("f{id}"))
            .replace("BLOCKED", mode);
        let runtime=source.replace("typedef uint64_t V;","typedef uint64_t V;\nstatic uint64_t matrix_calls,matrix_bytes;")
            .replace("static inline void *fwp_gc_alloc(size_t n, int leaf) {","static inline void *fwp_gc_alloc(size_t n, int leaf) {\nif(leaf!=0){matrix_calls++;matrix_bytes+=n;}")
            .replace("static inline void *fwp_alloc_init(size_t n) {","static inline void *fwp_alloc_init(size_t n) {\nmatrix_calls++;matrix_bytes+=n;")
            .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        let code = format!("{runtime}\n{probe}");
        for opt in ["-O1", "-O2"] {
            let executable = d.join(format!("profile-{mode}{opt}"));
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let out = checked(
                Command::new(&executable)
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            if let Some(destination) = std::env::var_os("FWP_ARRAY_FUSION_ARTIFACTS") {
                let destination = std::path::PathBuf::from(destination);
                std::fs::create_dir_all(&destination).unwrap();
                std::fs::write(
                    destination.join(format!("matrix-{mode}{opt}.json")),
                    out.stdout,
                )
                .unwrap();
                if opt == "-O2" {
                    std::fs::write(
                        destination.join(format!("matrix-original-{mode}.c")),
                        &source,
                    )
                    .unwrap();
                    std::fs::write(destination.join(format!("matrix-measured-{mode}.c")), &code)
                        .unwrap();
                }
            }
        }
    }
    std::fs::remove_dir_all(d).unwrap();
}

#[test]
fn source_cannot_bypass_matrix_shape_checks_with_internal_primitives() {
    let d = std::env::temp_dir().join(format!("fwp-matrix-internal-{}", std::process::id()));
    std::fs::create_dir(&d).unwrap();
    for symbol in ["matrix._valid-f64", "matrix._mul-f64"] {
        let input = d.join("forged.fwp");
        std::fs::write(
            &input,
            format!(
                "foreign \"fwp\" forged : I64 -> I64 = \"{symbol}\"\nmain = 0 | forged | echo\n"
            ),
        )
        .unwrap();
        for raw in [false, true] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command.args(["run", "--interp"]).arg(&input);
            if raw {
                command.env("FWP_NO_OPT", "1");
            } else {
                command.env_remove("FWP_NO_OPT");
            }
            let out = command.output().unwrap();
            assert!(!out.status.success());
            assert!(
                String::from_utf8_lossy(&out.stderr)
                    .contains("matrix specialization primitives are compiler-internal"),
                "{}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    std::fs::remove_dir_all(d).unwrap();
}
