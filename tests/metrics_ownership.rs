//! Process snapshots own copied values; syntax rendering releases native scratch.
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
fn metrics_results_preserve_values_aliases_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("metrics-ownership").unwrap();
    let source = include_str!("fixtures/metrics_ownership.fwp");
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
            let binary = dir.join("metrics.exe");
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
                    "    fwp_init_consts();\n    intptr_t metrics_budget=fwp_gc.budget;\n",
                )
                .replace(
                    "    fwp_cl_finish();\n",
                    "    fwp_cl_finish();\n    if(fwp_gc.budget!=metrics_budget) exit(248);\n",
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
fn snapshots_and_syntax_release_partial_fields_and_native_scratch() {
    let dir = fwp::cgen::TempDir::new("metrics-cleanup").unwrap();
    let source = include_str!("fixtures/metrics_ownership.fwp");
    for arc in [false, true] {
        let code = emitted(source, arc, &dir);
        let line = code
            .lines()
            .find(|line| line.contains("return fwp_p_metrics_snapshot("))
            .unwrap();
        let descriptor = line
            .split("fwp_p_metrics_snapshot(")
            .nth(1)
            .unwrap()
            .strip_suffix(");")
            .unwrap();
        let declaration = format!("#define METRICS_LIST ({descriptor})\n");
        let mut code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1")
            .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic void metrics_allocation(void); static int metrics_buffers;");
        let hooks = [
            ("static inline void *fwp_alloc_init(size_t n) {", "static inline void *fwp_alloc_init(size_t n) { metrics_allocation();"),
            ("static inline void *fwp_gc_alloc(size_t n, int leaf) {", "static inline void *fwp_gc_alloc(size_t n, int leaf) { if(leaf!=0) metrics_allocation();"),
            ("        b->d = data;", "        if(!b->d) metrics_buffers++;\n        b->d = data;"),
            ("    free(b->d);\n    return r;", "    if(b->d) metrics_buffers--;\n    free(b->d);\n    return r;"),
            ("static void fwp_buf_release(void *arg) { free(((fwp_buf *)arg)->d); }", "static void fwp_buf_release(void *arg) { if(((fwp_buf *)arg)->d) metrics_buffers--; free(((fwp_buf *)arg)->d); }"),
        ];
        for (needle, replacement) in hooks {
            assert_eq!(code.matches(needle).count(), 1, "{needle}");
            code = code.replace(needle, replacement);
        }
        let code = code[..code.find("int main(").unwrap()].to_string()
            + &declaration
            + include_str!("fixtures/metrics_cleanup.c");
        let missing_fields = code.replace("if (d && d->drop) d->drop(f->values[i]);", "(void)d;");
        let missing_buffer = code.replace(
            "if(((fwp_buf *)arg)->d) metrics_buffers--; free(((fwp_buf *)arg)->d);",
            "(void)arg;",
        );
        assert_ne!(code, missing_fields);
        assert_ne!(code, missing_buffer);
        for opt in ["-O1", "-O2"] {
            for (candidate, expected) in
                [(&code, 0), (&missing_fields, 248), (&missing_buffer, 248)]
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
                    if let Some(path) = std::env::var_os("FWP_DECODER_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        let label = format!("metrics-{}", if arc { "arc" } else { "tracing" });
                        std::fs::write(path.join(format!("{label}.c")), candidate).unwrap();
                        std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                        std::fs::write(path.join(format!("{label}.txt")), output.stdout).unwrap();
                    }
                }
            }
        }
    }
}
