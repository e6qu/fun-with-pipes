//! Vector arrays, boxed lanes and partial accumulators have explicit owners.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn emitted(source: &str, arc: bool, dir: &fwp::cgen::TempDir) -> String {
    let input = dir.join("main.fwp");
    let cfile = dir.join("main.c");
    std::fs::write(&input, source).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--gc",
                if arc { "arc" } else { "tracing" },
                "--emit-c",
            ])
            .arg(input)
            .arg("-o")
            .arg(&cfile),
    );
    std::fs::read_to_string(cfile).unwrap()
}
#[test]
fn vector_results_preserve_lanes_aliases_and_checked_failures() {
    let dir = fwp::cgen::TempDir::new("vector-ownership").unwrap();
    let division = "v : Array[I128] -> Option[Vec[4, I128]]\nv = simd.from-array\nmain = [8i128, 4i128, 6i128, 8i128] | array.from-list | v | option.map (simd.div (simd.splat 0i128)) | echo\n";
    for (name, source, status) in [
        ("lanes", include_str!("fixtures/vector_ownership.fwp"), 0),
        ("example", include_str!("../examples/vector-lanes.fwp"), 0),
        ("division", division, 101),
    ] {
        let input = dir.join("main.fwp");
        std::fs::write(&input, source).unwrap();
        let raw = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env("FWP_NO_OPT", "1")
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(raw.status.code(), Some(status), "{raw:?}");
        let optimized = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env_remove("FWP_NO_OPT")
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            (
                &optimized.stdout,
                &optimized.stderr,
                optimized.status.code()
            ),
            (&raw.stdout, &raw.stderr, raw.status.code())
        );
        for arc in [false, true] {
            let code = emitted(source, arc, &dir);
            for opt in ["-O1", "-O2"] {
                let binary = dir.join("vector.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                if opt == "-O2" && name == "lanes" {
                    if let Some(path) = std::env::var_os("FWP_VECTOR_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        let mode = if arc { "arc" } else { "tracing" };
                        std::fs::write(path.join(format!("vector-{mode}.c")), &code).unwrap();
                        std::fs::copy(&binary, path.join(format!("vector-{mode}.exe"))).unwrap();
                        let mut disassemble = Command::new(if cfg!(target_os = "macos") {
                            "otool"
                        } else if cfg!(target_os = "windows") {
                            "llvm-objdump"
                        } else {
                            "objdump"
                        });
                        let output = checked(
                            disassemble
                                .arg(if cfg!(target_os = "macos") {
                                    "-tvV"
                                } else {
                                    "-d"
                                })
                                .arg(&binary),
                        );
                        std::fs::write(path.join(format!("vector-{mode}.asm")), output.stdout)
                            .unwrap();
                    }
                }
                let actual = Command::new(&binary)
                    .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" })
                    .output()
                    .unwrap();
                assert_eq!(
                    (&actual.stdout, &actual.stderr, actual.status.code()),
                    (&raw.stdout, &raw.stderr, raw.status.code()),
                    "{arc}/{opt}"
                );
                if status == 0 {
                    let start = code
                        .find("static void *fwp_main_thread(void *arg) {")
                        .unwrap();
                    let end = start + code[start..].find("\n}\n").unwrap() + 3;
                    let body=code[start..end].replace("    fwp_init_consts();\n","    fwp_init_consts();\n    intptr_t vector_budget=fwp_gc.budget;\n")
                        .replace("    fwp_cl_finish();\n","    fwp_cl_finish();\n    if(fwp_gc.budget!=vector_budget) exit(248);\n");
                    let mut measured = code.clone();
                    measured.replace_range(start..end, &body);
                    fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
                    let output = checked(
                        Command::new(&binary)
                            .env("FWP_GC", "off")
                            .env("FWP_GC_STRESS", "0")
                            .env("FWP_GC_VERIFY", "0")
                            .env("FWP_REUSE_VERIFY", "0"),
                    );
                    assert_eq!(output.stdout, raw.stdout);
                }
            }
        }
    }
}
#[test]
fn vector_partial_construction_and_accumulators_unwind() {
    let dir = fwp::cgen::TempDir::new("vector-cleanup").unwrap();
    for arc in [false, true] {
        let code = emitted("main = 1i128 | echo\n", arc, &dir);
        let start = code.find("static V fwp_simd_finish(").unwrap();
        let end = code.find("static V fwp_array_typed_copy(").unwrap();
        let block = code[start..end]
            .replace("fwp_record(", "vector_record(")
            .replace("fwp_some(", "vector_some(")
            .replace("fwp_wrapping(", "vector_wrapping(");
        let code=code[..start].to_string()+"static V vector_record(size_t,V*);\nstatic V vector_some(V);\nstatic V vector_wrapping(int,int,V,V);\n"+&block+&code[end..];
        let code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
        let code = code[..code.find("int main(").unwrap()].to_string()
            + include_str!("fixtures/vector_cleanup.c");
        let start = code.find("static void fwp_array_builder_release(").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let mut broken = code.clone();
        broken.replace_range(
            start..end,
            &code[start..end].replace("fwp_rc_resource_free_arr(value);", "(void)value;"),
        );
        assert_ne!(code, broken);
        for opt in ["-O1", "-O2"] {
            for (source, expected) in [(&code, 0), (&broken, 248)] {
                let binary = dir.join("cleanup.exe");
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                let output = Command::new(binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{arc}/{opt}: {output:?}"
                );
            }
        }
    }
}
