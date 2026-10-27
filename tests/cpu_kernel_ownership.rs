//! CPU kernels borrow inputs and own results across allocation and worker failures.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn emitted(source: &str, dir: &fwp::cgen::TempDir) -> String {
    let input = dir.join("main.fwp");
    let cfile = dir.join("main.c");
    std::fs::write(&input, source).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
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

    let code = emitted(source, &dir);
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("cpu_kernel.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let native = checked(&mut Command::new(&binary));
        assert_eq!((&native.stdout, &native.stderr), (&raw.stdout, &raw.stderr));
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end]
                .replace(
                    "    fwp_init_consts();\n",
                    "    fwp_init_consts();\n    size_t cpu_kernel_live_bytes=fwp_heap.live;\n",
                )
                .replace(
                    "    /* Ownership observation point: before runtime teardown. */\n",
                    "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live!=cpu_kernel_live_bytes) exit(248);\n",
                );
        let mut measured = code.clone();
        measured.replace_range(start..end, &body);
        fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
        let native = checked(&mut Command::new(&binary));
        assert_eq!(native.stdout, raw.stdout);
    }
}

fn probe_code(code: String) -> String {
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
            "static inline void *fwp_heap_alloc(size_t n, int kind) {",
            " if(kind!=0) kernel_allocation();",
        ),
    ] {
        assert_eq!(code.matches(needle).count(), 1);
        code = code.replace(needle, &format!("{needle}{hook}"));
    }
    let start = code
        .find("/* ---------------------------------------------------------------- kernels */")
        .unwrap();
    let end = start + code[start..].find("/* F64 matrix fast path:").unwrap();
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
    code[..code.find("int main(").unwrap()].to_string()
        + include_str!("fixtures/cpu_kernel_cleanup.c")
}

#[test]
fn kernels_release_output_and_scratch_after_workers_join() {
    let dir = fwp::cgen::TempDir::new("cpu-kernel-cleanup").unwrap();
    let program = include_str!("fixtures/cpu_kernel_ownership.fwp");

    let code = emitted(program, &dir);
    let code = probe_code(code);
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
        for (candidate, expected) in [(&code, 0), (&missing_inputs, 248), (&missing_output, 248)] {
            let binary = dir.join("cleanup.exe");
            fwp::cgen::compile_c(candidate, &binary, opt).unwrap();
            let output = Command::new(&binary).output().unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
            if expected == 0 && opt == "-O2" {
                if let Some(path) = std::env::var_os("FWP_KERNEL_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let label = "kernel-counted";
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

#[test]
fn compare_kernel_allocations_with_the_immutable_runtime_baseline() {
    let Some(baseline_path) = std::env::var_os("FWP_KERNEL_BASELINE") else {
        return;
    };
    let baseline = std::fs::read_to_string(baseline_path).unwrap();
    let range = |code: &str, end_marker: &str| {
        let start = code
            .find("/* ---------------------------------------------------------------- kernels */")
            .unwrap();
        let end = start + code[start..].find(end_marker).unwrap();
        start..end
    };
    let old_kernel = &baseline[range(
        &baseline,
        "/* ------------------------------------------------------------------ OpenCL",
    )];
    assert!(old_kernel.contains("double *out = (double *)fwp_k_malloc(n * sizeof(double));"));
    assert!(old_kernel.contains("memcpy(ARR(r)->d, out, n * sizeof(double));"));
    let dir = fwp::cgen::TempDir::new("cpu-kernel-baseline").unwrap();
    // Same compiled probe, inputs and accounting. Only the kernel executor is
    // replaced. Both versions use the current counted allocator.
    let mut code = emitted(include_str!("fixtures/cpu_kernel_ownership.fwp"), &dir);
    code.replace_range(range(&code, "/* F64 matrix fast path:"), old_kernel);
    let code = format!("#define KERNEL_BASELINE 1\n{}", probe_code(code));
    let binary = dir.join("baseline.exe");
    fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
    let output = checked(&mut Command::new(&binary));
    if let Some(path) = std::env::var_os("FWP_KERNEL_ARTIFACTS") {
        let path = std::path::PathBuf::from(path);
        std::fs::create_dir_all(&path).unwrap();
        std::fs::write(path.join("kernel-baseline.c"), code).unwrap();
        std::fs::write(path.join("kernel-baseline-runtime.c"), baseline).unwrap();
        std::fs::write(path.join("kernel-baseline.txt"), output.stdout).unwrap();
        std::fs::copy(&binary, path.join("kernel-baseline.exe")).unwrap();
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
        std::fs::write(path.join("kernel-baseline.asm"), assembly.stdout).unwrap();
    }
}
