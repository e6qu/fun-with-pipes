//! Compressed bytes and frame decoders own success, error and partially constructed results.
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
fn byte_decoder_results_preserve_values_aliases_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("byte_decoder-ownership").unwrap();
    let source = include_str!("fixtures/byte_decoder_ownership.fwp");
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
            let binary = dir.join("byte_decoder.exe");
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
                    "    fwp_init_consts();\n    intptr_t byte_decoder_budget=fwp_gc.budget;\n",
                )
                .replace(
                    "    fwp_cl_finish();\n",
                    "    fwp_cl_finish();\n    if(fwp_gc.budget!=byte_decoder_budget) exit(248);\n",
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
fn byte_decoders_release_native_buffers_and_partial_results() {
    let dir = fwp::cgen::TempDir::new("byte-decoder-cleanup").unwrap();
    let source = include_str!("fixtures/byte_decoder_ownership.fwp");
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
        let descriptors = format!("#define GZIP_RESULT {}\n#define DEFLATE_RESULT {}\n#define FRAME_RESULT {}\n#define CLOSE_RESULT {}\n#define WS_RESULT {}\n",
            descriptor("fwp_p_zlib_gunzip(l0, l1,"), descriptor("fwp_p_zlib_inflate(l0, l1,"),
            descriptor("fwp_p_ws_parse(l0, l1, l2,"), descriptor("fwp_p_ws_close_parse(l0,"),
            descriptor("fwp_p_ws_inflate(l0, l1,"));
        let mut code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1")
            .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic void byte_allocation(void); static int byte_buffers_live;");
        for (marker, replacement) in [
            (
                "static inline void *fwp_alloc_init(size_t n) {",
                "static inline void *fwp_alloc_init(size_t n) { byte_allocation();",
            ),
            (
                "static inline void *fwp_gc_alloc(size_t n, int leaf) {",
                "static inline void *fwp_gc_alloc(size_t n, int leaf) { if(leaf!=0) byte_allocation();",
            ),
            (
                "    b->d = data;\n    b->cap = c;",
                "    if(!b->d) byte_buffers_live++;\n    b->d = data;\n    b->cap = c;",
            ),
            (
                "static void h2b_free(h2_buf *b) {",
                "static void h2b_free(h2_buf *b) { if(b->d) byte_buffers_live--;",
            ),
        ] {
            assert_eq!(code.matches(marker).count(), 1, "{marker}");
            // Count only HTTP/2 buffers, after checked allocation succeeds.
            code = code.replace(marker, replacement);
        }
        let code = code[..code.find("int main(").unwrap()].to_string()
            + &descriptors
            + include_str!("fixtures/byte_decoder_cleanup.c");
        let fields_broken = code.replace(
            "if (d && d->drop) d->drop(f->values[i]);",
            "(void)d; /* injected missing partial-field cleanup */",
        );
        let buffers_broken = code.replace(
            "static void w_buffer_release(void *value) { h2b_free((h2_buf *)value); }",
            "static void w_buffer_release(void *value) { (void)value; }",
        );
        assert_ne!(code, fields_broken);
        assert_ne!(code, buffers_broken);
        for opt in ["-O1", "-O2"] {
            for (source, expected) in [(&code, 0), (&fields_broken, 248), (&buffers_broken, 248)] {
                let binary = dir.join("cleanup.exe");
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
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
                    if let Some(path) = std::env::var_os("FWP_DECODER_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        let label = format!("bytes-{}", if arc { "arc" } else { "tracing" });
                        std::fs::write(path.join(format!("{label}.c")), source).unwrap();
                        std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                        std::fs::write(path.join(format!("{label}.txt")), output.stdout).unwrap();
                    }
                }
            }
        }
    }
}
