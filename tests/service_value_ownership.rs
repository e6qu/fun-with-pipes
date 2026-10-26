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

    let cfile = dir.join("main.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let binary = dir.join("main.exe");
    fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
    let output = checked(&mut Command::new(&binary));
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
    let leaf = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
    assert!(code.contains(init) && code.contains(leaf));
    let code = code
        .replace(init, &format!("{init} service_allocation();"))
        .replace(leaf, &format!("{leaf} if(kind!=0) service_allocation();"));
    let code = code[..code.find("int main(").unwrap()].to_string()
        + &types
        + include_str!("fixtures/service_values_cleanup.c");
    let broken = code.replace(
        "if (d && d->drop) d->drop(f->values[i]);",
        "(void)d; /* omit partially copied service fields */",
    );
    assert_ne!(code, broken);
    let missed_failure = code.replace("if(service_left>0 && !--service_left)", "if(0)");
    let unrelated_trap = code.replace(
        "injected service-result allocation failure",
        "unrelated runtime failure",
    );
    assert_ne!(code, missed_failure);
    assert_ne!(code, unrelated_trap);
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [
            (&code, 0),
            (&broken, 248),
            (&missed_failure, 247),
            (&unrelated_trap, 247),
        ] {
            fwp::cgen::compile_c(source, &binary, opt).unwrap();
            let output = Command::new(&binary).output().unwrap();
            if expected == 0 && opt == "-O2" {
                let symbols = {
                    let output = checked(Command::new("nm").arg(&binary));
                    let symbols = String::from_utf8(output.stdout).unwrap();
                    for name in [
                        "fwp_gc_scan",
                        "fwp_gc_mark_all",
                        "fwp_gc_sweep",
                        "fwp_gc_collect",
                        "fwp_heap_scan",
                        "fwp_heap_mark_all",
                        "fwp_heap_sweep",
                    ] {
                        assert!(!symbols.contains(name), "executable contains {name}");
                    }
                    symbols
                };
                if let Some(path) = std::env::var_os("FWP_SERVICE_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    std::fs::write(path.join("service-counted.nm"), &symbols).unwrap();
                    std::fs::write(path.join("service-counted.c"), source).unwrap();
                    std::fs::copy(&binary, path.join("service-counted.exe")).unwrap();
                    std::fs::write(path.join("service-counted.stdout"), &output.stdout).unwrap();
                    std::fs::write(path.join("service-counted.stderr"), &output.stderr).unwrap();
                }
            }
            assert_eq!(
                output.status.code(),
                Some(expected),
                "counted/{opt}: {output:?}"
            );
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
    let leaf = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
    assert!(code.contains(init) && code.contains(leaf));
    let code = code
        .replace(init, &format!("{init} service_allocation();"))
        .replace(leaf, &format!("{leaf} if(kind!=0) service_allocation();"))
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
            let output = Command::new(&binary).output().unwrap();
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
        }
    }
}

#[test]
fn protocol_buffers_preserve_existing_storage_on_allocation_failure() {
    let dir = fwp::cgen::TempDir::new("h2-allocation-failures").unwrap();
    let code = include_str!("fixtures/h2_allocation_failures.c")
        .replace(
            "/* SOCKET_RUNTIME */",
            include_str!("../runtime/fwp_rt_socket.c"),
        )
        .replace("/* H2_RUNTIME */", include_str!("../runtime/fwp_rt_h2.c"));
    let broken = code.replace(
        "free(copy.name); free(copy.value);",
        "/* omit partial header cleanup */",
    );
    assert_ne!(code, broken);
    let binary = dir.join("h2-allocation-failures.exe");
    for opt in ["-O1", "-O2"] {
        for (source, expected) in [(&code, 0), (&broken, 248)] {
            fwp::cgen::compile_c(source, &binary, opt).unwrap();
            let output = Command::new(&binary).output().unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
            if expected == 0 && opt == "-O2" {
                if let Some(path) = std::env::var_os("FWP_SERVICE_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    std::fs::write(path.join("h2-allocation-failures.c"), source).unwrap();
                    std::fs::copy(&binary, path.join("h2-allocation-failures.exe")).unwrap();
                    std::fs::write(path.join("h2-allocation-failures.stdout"), &output.stdout)
                        .unwrap();
                    std::fs::write(path.join("h2-allocation-failures.stderr"), &output.stderr)
                        .unwrap();
                }
            }
        }
    }
}
