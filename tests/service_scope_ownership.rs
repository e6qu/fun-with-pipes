//! Service scopes borrow callbacks and own returned values, including aliases.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn scope_results_preserve_aliases_and_release_partial_captures() {
    let dir = fwp::cgen::TempDir::new("service-scope-ownership").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, include_str!("fixtures/service_scope_ownership.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let raw = checked(
        Command::new(compiler)
            .args(["run", "--interp"])
            .env("FWP_NO_OPT", "1")
            .arg(&input),
    );
    let optimized = checked(
        Command::new(compiler)
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
            Command::new(compiler)
                .args(["build", "--gc", mode, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (runtime, main) = code.split_at(start);
        let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    intptr_t scope_budget=fwp_gc.budget;\n")
            .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.budget!=scope_budget || fwp_gc.ncollect) exit(248);\n");
        let measured = format!("{runtime}{main}");
        let borrowed = "V r = fwp_apply_borrowed(f, 1, &unit);";
        assert_eq!(measured.matches(borrowed).count(), 1);
        let broken = measured.replace(borrowed, "V r = fwp_apply1(f, FWP_UNIT);");
        let binary = dir.join("scope.exe");
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let out = checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", if mode == "tracing" { "1" } else { "0" })
                    .env("FWP_GC_VERIFY", if mode == "tracing" { "1" } else { "0" })
                    .env(
                        "FWP_REUSE_VERIFY",
                        if mode == "tracing" { "1" } else { "0" },
                    ),
            );
            assert_eq!((&out.stdout, &out.stderr), (&raw.stdout, &raw.stderr));
            for (source, passes) in [(&measured, true), (&broken, false)] {
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                let out = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    out.status.success(),
                    passes,
                    "{mode}/{opt}/borrowed={passes}: {out:?}"
                );
                if passes {
                    assert_eq!((&out.stdout, &out.stderr), (&raw.stdout, &raw.stderr));
                    if mode == "arc" {
                        let symbols = checked(Command::new("nm").arg(&binary));
                        let symbols = String::from_utf8_lossy(&symbols.stdout);
                        for tracing in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                            assert!(!symbols.contains(tracing), "{symbols}");
                        }
                    }
                    if opt == "-O2" {
                        if let Some(path) = std::env::var_os("FWP_CONTEXT_ARTIFACTS") {
                            let path = std::path::PathBuf::from(path);
                            std::fs::create_dir_all(&path).unwrap();
                            std::fs::write(path.join(format!("scope-{mode}.c")), source).unwrap();
                            std::fs::copy(&binary, path.join(format!("scope-{mode}.exe"))).unwrap();
                        }
                    }
                }
            }
        }
        let descriptor = code
            .lines()
            .find_map(|line| {
                line.trim()
                    .strip_prefix("return fwp_p_grpc_with_response_metadata(l0, ")
                    .and_then(|line| line.strip_suffix(");"))
            })
            .unwrap();
        let mut instrumented=code.replace("#define FWP_UNWIND 0","#define FWP_UNWIND 1")
            .replace("typedef uint64_t V;","typedef uint64_t V;\nstatic void capture_allocation(void);static V capture_callback(void);static int capture_live;");
        for (marker,replacement) in [
            ("static inline void *fwp_alloc_init(size_t n) {","static inline void *fwp_alloc_init(size_t n) { capture_allocation();"),
            ("static inline void *fwp_gc_alloc(size_t n, int leaf) {","static inline void *fwp_gc_alloc(size_t n, int leaf) { if(leaf)capture_allocation();"),
            ("    owner->users = 1;\n    fwp_cleanup capture_cleanup;","    owner->users = 1; capture_live++;\n    fwp_cleanup capture_cleanup;"),
            ("if (--cap->users == 0) { h2_hdrs_free", "if (--cap->users == 0) { capture_live--; h2_hdrs_free"),
            (borrowed,"V r = capture_callback();"),
        ] {assert_eq!(instrumented.matches(marker).count(),1,"{marker}");instrumented=instrumented.replace(marker,replacement);}
        let instrumented = instrumented[..instrumented.find("int main(").unwrap()].to_string()
            + &format!("\n#define CAPTURE_TYPE ({descriptor})\n")
            + include_str!("fixtures/service_scope_cleanup.c");
        let broken = instrumented.replace(
            "if (d && d->drop) d->drop(f->values[i]);",
            "(void)d; /* omit partial captured result cleanup */",
        );
        assert_ne!(instrumented, broken);
        for opt in ["-O1", "-O2"] {
            for (source, expected) in [(&instrumented, 0), (&broken, 248)] {
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                let out = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(out.status.code(), Some(expected), "{mode}/{opt}: {out:?}");
                if expected == 0 && opt == "-O2" {
                    if let Some(path) = std::env::var_os("FWP_CONTEXT_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        std::fs::write(path.join(format!("capture-{mode}.c")), source).unwrap();
                        std::fs::write(path.join(format!("capture-{mode}.txt")), out.stdout)
                            .unwrap();
                        std::fs::copy(&binary, path.join(format!("capture-{mode}.exe"))).unwrap();
                    }
                }
            }
        }
    }
}
