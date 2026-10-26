//! Text decoders own success, error and partially constructed results.
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
fn text_decoder_results_preserve_values_aliases_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("text_decoder-ownership").unwrap();
    let source = include_str!("fixtures/text_decoder_ownership.fwp");
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
            let binary = dir.join("text_decoder.exe");
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
                    "    fwp_init_consts();\n    size_t text_decoder_live_bytes=fwp_heap.live;\n",
                )
                .replace(
                    "    /* Ownership observation point: before runtime teardown. */\n",
                    "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live!=text_decoder_live_bytes) exit(248);\n",
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
fn partial_text_decoders_release_fields_and_scratch_on_failure() {
    let dir = fwp::cgen::TempDir::new("text-decoder-cleanup").unwrap();
    let source = include_str!("fixtures/text_decoder_ownership.fwp");
    for arc in [false, true] {
        let code = emitted(source, arc, &dir);
        let descriptor = |call: &str| {
            let line = code
                .lines()
                .find(|line| line.contains(call) && line.contains("return "))
                .unwrap();
            line.trim()
                .rsplit(", ")
                .next()
                .unwrap()
                .strip_suffix(");")
                .unwrap()
                .to_string()
        };
        let descriptors=format!("#define URL_OPTION {}\n#define URL_PARTS {}\n#define HTTP_REQUEST {}\n#define HTTP_RESPONSE {}\n",
            descriptor("fwp_p_url_decode(l0, 0,"),descriptor("fwp_p_url_split(l0,"),
            descriptor("fwp_p_parse_request_head(l0,"),descriptor("fwp_p_parse_response_head(l0,"));
        let code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
        let declaration = "typedef uint64_t V;";
        let mut code = code.replace(
            declaration,
            &format!("{declaration}\nstatic void decoder_allocation(void);"),
        );
        let init = "static inline void *fwp_alloc_init(size_t n) {";
        let slow = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
        assert!(code.contains(init) && code.contains(slow));
        code = code
            .replace(init, &format!("{init} decoder_allocation();"))
            .replace(slow, &format!("{slow} if(kind!=0) decoder_allocation();"));
        let code = code[..code.find("int main(").unwrap()].to_string()
            + &descriptors
            + include_str!("fixtures/text_decoder_cleanup.c");
        let broken = code.replace(
            "if (d && d->drop) d->drop(f->values[i]);",
            "(void)d; /* injected missing field cleanup */",
        );
        assert_ne!(code, broken);
        for opt in ["-O1", "-O2"] {
            for (source, expected) in [(&code, 0), (&broken, 248)] {
                let binary = dir.join("cleanup.exe");
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                let output = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                if expected == 0 && opt == "-O2" {
                    if let Some(path) = std::env::var_os("FWP_DECODER_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        let label = format!("text-{}", if arc { "arc" } else { "tracing" });
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
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{arc}/{opt}: {output:?}"
                );
            }
        }
    }
}
