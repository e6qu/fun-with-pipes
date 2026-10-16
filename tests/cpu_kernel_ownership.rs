//! CPU kernels borrow inputs and own results across allocation and worker failures.
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
fn cpu_kernel_results_preserve_values_aliases_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("cpu_kernel-ownership").unwrap();
    let source = include_str!("fixtures/cpu_kernel_ownership.fwp");
    let input = dir.join("main.fwp");
    std::fs::write(&input, source).unwrap();
    let raw = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env("FWP_NO_OPT", "1")
            .arg(&input),
    );
    let optimized = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env_remove("FWP_NO_OPT")
            .arg(&input),
    );
    assert_eq!(
        (&raw.stdout, &raw.stderr),
        (&optimized.stdout, &optimized.stderr)
    );
    for arc in [false, true] {
        let code = emitted(source, arc, &dir);
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("cpu_kernel.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let native = checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" }),
            );
            assert_eq!((&native.stdout, &native.stderr), (&raw.stdout, &raw.stderr));
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let end = start + code[start..].find("\n}\n").unwrap() + 3;
            let body = code[start..end]
                .replace(
                    "    fwp_init_consts();\n",
                    "    fwp_init_consts();\n    intptr_t cpu_kernel_budget=fwp_gc.budget;\n",
                )
                .replace(
                    "    fwp_cl_finish();\n",
                    "    fwp_cl_finish();\n    if(fwp_gc.budget!=cpu_kernel_budget) exit(248);\n",
                );
            let mut measured = code.clone();
            measured.replace_range(start..end, &body);
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            let native = checked(
                Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            assert_eq!(native.stdout, raw.stdout);
        }
    }
}

#[test]
fn kernels_release_output_and_scratch_after_workers_join() {
    let dir = fwp::cgen::TempDir::new("cpu-kernel-cleanup").unwrap();
    let program = include_str!("fixtures/cpu_kernel_ownership.fwp");
    for arc in [false, true] {
        let code = emitted(program, arc, &dir);
        let mut code = code
            .replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1")
            .replace(
                "typedef uint64_t V;",
                "typedef uint64_t V;\nstatic void kernel_allocation(void);",
            );
        for (needle, hook) in [
            (
                "static inline void *fwp_alloc_init(size_t n) {",
                " kernel_allocation();",
            ),
            (
                "static inline void *fwp_gc_alloc(size_t n, int leaf) {",
                " if(leaf!=0) kernel_allocation();",
            ),
        ] {
            assert_eq!(code.matches(needle).count(), 1);
            code = code.replace(needle, &format!("{needle}{hook}"));
        }
        let start = code
            .find("/* ---------------------------------------------------------------- kernels */")
            .unwrap();
        let end = start
            + code[start..]
                .find(
                    "/* ------------------------------------------------------------------ OpenCL",
                )
                .unwrap();
        let kernel = code[start..end]
            .replace("fwp_k_malloc(", "kernel_malloc(")
            .replace("free(", "kernel_free(")
            .replace("CreateThread(", "kernel_create(")
            .replace("WaitForSingleObject(", "kernel_join(")
            .replace("pthread_create(", "kernel_create(")
            .replace("pthread_join(", "kernel_join(");
        code.replace_range(
            start..end,
            &format!("{}\n{kernel}", include_str!("fixtures/cpu_kernel_ledger.c")),
        );
        let code = code[..code.find("int main(").unwrap()].to_string()
            + include_str!("fixtures/cpu_kernel_cleanup.c");
        let missing_inputs = code.replace(
            "kernel_free((void *)owner->kernel.inputs);",
            "/* omitted input-table disposal */",
        );
        let missing_output = code.replace(
            "if (owner->output) fwp_rc_free_arr(owner->output);",
            "/* omitted failed output disposal */",
        );
        assert_ne!(code, missing_inputs);
        assert_ne!(code, missing_output);
        for opt in ["-O1", "-O2"] {
            for (candidate, expected) in
                [(&code, 0), (&missing_inputs, 248), (&missing_output, 248)]
            {
                let binary = dir.join("cleanup.exe");
                fwp::cgen::compile_c(candidate, &binary, opt).unwrap();
                let output = Command::new(&binary)
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
                if expected == 0 && opt == "-O2" {
                    if let Some(path) = std::env::var_os("FWP_KERNEL_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        let label = format!("kernel-{}", if arc { "arc" } else { "tracing" });
                        std::fs::write(path.join(format!("{label}.c")), candidate).unwrap();
                        std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                        std::fs::write(path.join(format!("{label}.txt")), output.stdout).unwrap();
                        let mut command = Command::new(if cfg!(target_os = "macos") {
                            "otool"
                        } else if cfg!(windows) {
                            "llvm-objdump"
                        } else {
                            "objdump"
                        });
                        let assembly = checked(
                            command
                                .arg(if cfg!(target_os = "macos") {
                                    "-tvV"
                                } else {
                                    "-d"
                                })
                                .arg(&binary),
                        );
                        std::fs::write(path.join(format!("{label}.asm")), assembly.stdout).unwrap();
                    }
                }
            }
        }
    }
}
