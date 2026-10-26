//! Ternary conversions own results without collector-dependent scratch.
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
fn ternary_results_preserve_values_aliases_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("ternary-ownership").unwrap();
    let source = include_str!("fixtures/ternary_ownership.fwp");
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
        let binary = dir.join("ternary.exe");
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
                    "    fwp_init_consts();\n    size_t ternary_live_bytes=fwp_heap.live;\n",
                )
                .replace(
                    "    /* Ownership observation point: before runtime teardown. */\n",
                    "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live!=ternary_live_bytes) exit(248);\n",
                );
        let mut measured = code.clone();
        measured.replace_range(start..end, &body);
        fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
        let native = checked(&mut Command::new(&binary));
        assert_eq!(native.stdout, raw.stdout);
    }
}

#[test]
fn partial_ternary_lists_unwind_without_a_collector() {
    let dir = fwp::cgen::TempDir::new("ternary-cleanup").unwrap();

    let code = emitted("main = 1 | echo\n", &dir);
    let start = code.find("static V fwp_p_tint_trits(").unwrap();
    let end = code.find("static V fwp_p_fold(").unwrap();
    let block = code[start..end].replace("fwp_cons(", "ternary_cons(");
    let code = code[..start].to_string() + "static V ternary_cons(V,V);\n" + &block + &code[end..];
    let code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
    let code = code.replace(
        "typedef uint64_t V;",
        "typedef uint64_t V;\nstatic int ternary_count_active; static size_t ternary_allocations;",
    );
    let init = "static inline void *fwp_alloc_init(size_t n) {";
    let slow = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
    assert!(code.contains(init) && code.contains(slow));
    let code = code
        .replace(
            init,
            &format!("{init} if(ternary_count_active) ternary_allocations++;"),
        )
        .replace(
            slow,
            &format!("{slow} if(ternary_count_active && kind!=0) ternary_allocations++;"),
        );
    let code = code[..code.find("int main(").unwrap()].to_string()
        + include_str!("fixtures/ternary_cleanup.c");
    let broken = code.replace(
        "fwp_rc_resource_free_obj(value);\n        value=next;",
        "(void)value;\n        value=next;",
    );
    assert_ne!(code, broken);
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [(&code, 0), (&broken, 248)] {
            let binary = dir.join("cleanup.exe");
            fwp::cgen::compile_c(source, &binary, opt).unwrap();
            let output = Command::new(&binary).output().unwrap();
            if expected == 0 && opt == "-O2" {
                if let Some(path) = std::env::var_os("FWP_DECODER_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let label = "ternary-counted";
                    std::fs::write(path.join(format!("{label}.c")), source).unwrap();
                    std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                    std::fs::write(path.join(format!("{label}.txt")), &output.stdout).unwrap();
                    let mut command = Command::new(if cfg!(target_os = "macos") {
                        "otool"
                    } else if cfg!(target_os = "windows") {
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
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
    }
}
