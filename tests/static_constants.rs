//! Compile-time graphs use static storage and preserve immutable updates.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(out.status.success(), "{command:?}: {out:?}");
    out
}

#[test]
fn constants_need_no_startup_heap_and_preserve_layout_and_aliases() {
    let dir = fwp::cgen::TempDir::new("static-constants").unwrap();
    let source = dir.join("constants.fwp");
    std::fs::write(&source, include_str!("fixtures/static_constants.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    {
        for packed in ["0", "1"] {
            let cfile = dir.join("constants.c");
            checked(
                Command::new(compiler)
                    .env("FWP_PACKED_ARRAYS", packed)
                    .args(["build", "--emit-c"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            assert!(code.contains("fwp_constant"));
            let init = "static void fwp_init_consts(void) {\n";
            let start = code.find(init).unwrap() + init.len();
            let end = start + code[start..].find("\n}").unwrap();
            let mut measured = code.clone();
            measured.insert_str(
                end,
                "\n    constant_watch=0; if(constant_requests)exit(213);\n",
            );
            measured.insert_str(start, "    constant_watch=1;\n");
            measured = measured.replace(
                "typedef uint64_t V;",
                "typedef uint64_t V;\nstatic int constant_watch; static size_t constant_requests;",
            );
            for marker in [
                "static inline void *fwp_heap_alloc(size_t n, int kind) {",
                "static inline void *fwp_alloc_init(size_t n) {",
            ] {
                assert_eq!(measured.matches(marker).count(), 1);
                measured = measured.replace(
                    marker,
                    &format!("{marker} if(constant_watch)constant_requests++;"),
                );
            }
            let main = measured
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, entry) = measured.split_at(main);
            let finish = "    /* Ownership observation point: before runtime teardown. */\n";
            assert_eq!(entry.matches(finish).count(), 1);
            let entry = {
                entry.replace(
                    finish,
                    &format!("{finish}    if(fwp_heap.live != 0)exit(214);\n"),
                )
            };
            let measured = format!("{runtime}{entry}");
            for opt in ["-O0", "-O2"] {
                let binary = dir.join("constants.exe");
                fwp::cgen::compile_c(&measured, &binary, opt).unwrap();

                let out = checked(&mut Command::new(&binary));
                assert_eq!(out.stdout, reference.stdout, "counted/{packed}/{opt}");
                assert_eq!(out.stderr, reference.stderr, "counted/{packed}/{opt}");
                if let Some(path) = std::env::var_os("FWP_CONSTANT_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let name = format!("counted-packed{packed}{opt}");
                    std::fs::write(path.join(format!("{name}.c")), &measured).unwrap();
                    std::fs::copy(&binary, path.join(format!("{name}.exe"))).unwrap();
                    let symbols = checked(Command::new("nm").arg(&binary));
                    std::fs::write(path.join(format!("{name}.symbols")), symbols.stdout).unwrap();
                }
                if packed == "1" && opt == "-O0" {
                    // A startup allocation must still fail the zero-request check.
                    let broken = measured.replace(
                        "constant_watch=1;",
                        "constant_watch=1; (void)fwp_alloc_init(16);",
                    );
                    fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
                    let out = Command::new(&binary).output().unwrap();
                    assert_eq!(out.status.code(), Some(213), "{out:?}");
                }
            }
        }
    }
}
