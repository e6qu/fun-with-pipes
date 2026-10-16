//! Copies of incoming service metadata own their strings and partial results.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn copied_service_values_release_partial_results_and_preserve_aliases() {
    let dir = fwp::cgen::TempDir::new("service-values").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, include_str!("fixtures/service_values.fwp")).unwrap();
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
    for mode in ["tracing", "arc"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", mode, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let binary = dir.join("main.exe");
        fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
        let output = checked(
            Command::new(&binary)
                .env("FWP_GC_STRESS", if mode == "tracing" { "1" } else { "0" })
                .env("FWP_GC_VERIFY", if mode == "tracing" { "1" } else { "0" })
                .env(
                    "FWP_REUSE_VERIFY",
                    if mode == "tracing" { "1" } else { "0" },
                ),
        );
        assert_eq!((&output.stdout, &output.stderr), (&raw.stdout, &raw.stderr));
        let descriptor = |function: &str| {
            let prefix = format!("return {function}(");
            code.lines()
                .find_map(|line| {
                    line.trim()
                        .strip_prefix(&prefix)
                        .and_then(|line| line.strip_suffix(");"))
                })
                .unwrap()
                .to_string()
        };
        let types = format!(
            "#define METADATA_TYPE ({})\n#define SUBJECT_TYPE ({})\n",
            descriptor("fwp_p_grpc_metadata"),
            descriptor("fwp_p_grpc_peer_subject")
        );
        let code = code
            .replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1")
            .replace(
                "typedef uint64_t V;",
                "typedef uint64_t V;\nstatic void service_allocation(void);",
            );
        let init = "static inline void *fwp_alloc_init(size_t n) {";
        let leaf = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
        assert!(code.contains(init) && code.contains(leaf));
        let code = code
            .replace(init, &format!("{init} service_allocation();"))
            .replace(leaf, &format!("{leaf} if(leaf!=0) service_allocation();"));
        let code = code[..code.find("int main(").unwrap()].to_string()
            + &types
            + include_str!("fixtures/service_values_cleanup.c");
        let broken = code.replace(
            "if (d && d->drop) d->drop(f->values[i]);",
            "(void)d; /* omit partially copied service fields */",
        );
        assert_ne!(code, broken);
        for opt in ["-O1", "-O2"] {
            for (source, expected) in [(&code, 0), (&broken, 248)] {
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                let output = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                if expected == 0 && opt == "-O2" {
                    if let Some(path) = std::env::var_os("FWP_SERVICE_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        std::fs::write(path.join(format!("service-{mode}.c")), source).unwrap();
                        std::fs::copy(&binary, path.join(format!("service-{mode}.exe"))).unwrap();
                        std::fs::write(path.join(format!("service-{mode}.stdout")), &output.stdout)
                            .unwrap();
                        std::fs::write(path.join(format!("service-{mode}.stderr")), &output.stderr)
                            .unwrap();
                    }
                }
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{mode}/{opt}: {output:?}"
                );
                if expected == 0 && opt == "-O2" && mode == "tracing" {
                    checked(
                        Command::new(&binary)
                            .env("FWP_SERVICE_STRESS", "1")
                            .env("FWP_GC_STRESS", "1")
                            .env("FWP_GC_VERIFY", "1")
                            .env("FWP_REUSE_VERIFY", "1"),
                    );
                }
            }
        }
    }
}

#[path = "support/http2_values.rs"]
mod http2_values;

#[test]
fn http2_request_and_body_copies_release_every_partial_result() {
    let dir = fwp::cgen::TempDir::new("http2-values").unwrap();
    let code = http2_values::generated().replace(
        "typedef uint64_t V;",
        "typedef uint64_t V;\nstatic void service_allocation(void);",
    );
    let init = "static inline void *fwp_alloc_init(size_t n) {";
    let leaf = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
    assert!(code.contains(init) && code.contains(leaf));
    let code = code
        .replace(init, &format!("{init} service_allocation();"))
        .replace(leaf, &format!("{leaf} if(leaf!=0) service_allocation();"))
        + include_str!("fixtures/http2_values_cleanup.c");
    let broken = code.replace(
        "if (d && d->drop) d->drop(f->values[i]);",
        "(void)d; /* omit partially copied HTTP/2 fields */",
    );
    assert_ne!(code, broken);
    let binary = dir.join("http2-values.exe");
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [(&code, 0), (&broken, 248)] {
            fwp::cgen::compile_c(source, &binary, opt).unwrap();
            let output = Command::new(&binary)
                .env("FWP_GC", "off")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            if expected == 0 && opt == "-O2" {
                if let Some(path) = std::env::var_os("FWP_SERVICE_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    std::fs::write(path.join("http2-values.c"), source).unwrap();
                    std::fs::copy(&binary, path.join("http2-values.exe")).unwrap();
                    std::fs::write(path.join("http2-values.stdout"), &output.stdout).unwrap();
                    std::fs::write(path.join("http2-values.stderr"), &output.stderr).unwrap();
                }
            }
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
            if expected == 0 && opt == "-O2" {
                checked(
                    Command::new(&binary)
                        .env("FWP_SERVICE_STRESS", "1")
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", "1"),
                );
            }
        }
    }
}
