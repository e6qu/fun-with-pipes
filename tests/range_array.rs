//! Immediate integer range arrays preserve values, bounds and ownership.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn direct_range_arrays_preserve_values_and_bound_order() {
    let dir = fwp::cgen::TempDir::new("range-array").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        ("values", include_str!("fixtures/range_arrays.fwp"), true, 0),
        ("bounds", "lo : () -> I64 ! {IO}\nlo = const -2 | tap (const \"lower\" | echo)\nhi : () -> I64 ! {IO}\nhi = const 3 | tap (const \"upper\" | echo)\nmain = range (lo ()) (hi ()) | array.from-list | array.to-list | echo\n", true, 0),
        ("trap", "lo : () -> I64\nlo = const 1 | div 0\nhi : () -> I64\nhi = const 9223372036854775807 | add 1\nmain = range (lo ()) (hi ()) | array.from-list | array.to-list | echo\n", true, 101),
        ("wide", "main = range -2i128 3i128 | array.from-list | array.to-list | echo\n", false, 0),
    ];
    for (name, source, eligible, status) in cases {
        let input = dir.join("main.fwp");
        std::fs::write(&input, source).unwrap();
        let raw = Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(raw.status.code(), Some(status), "{name}: {raw:?}");
        if name == "bounds" {
            assert!(raw.stdout.starts_with(b"lower\nupper\n"));
        }
        for fusion in ["0", "1"] {
            let interpreted = Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_ARRAY_FUSION", fusion)
                .args(["run", "--interp"])
                .arg(&input)
                .output()
                .unwrap();
            assert_eq!(
                (
                    &interpreted.stdout,
                    &interpreted.stderr,
                    interpreted.status.code()
                ),
                (&raw.stdout, &raw.stderr, raw.status.code()),
                "{name} interp/{fusion}"
            );
            for arc in [false, true] {
                let cfile = dir.join("main.c");
                let mut build = Command::new(compiler);
                build
                    .env("FWP_ARRAY_FUSION", fusion)
                    .args(["build", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile);
                if arc {
                    build.args(["--gc", "arc"]);
                }
                checked(&mut build);
                let code = std::fs::read_to_string(cfile).unwrap();
                assert_eq!(
                    code.contains("return fwp_p_array_range(l0, l1,"),
                    eligible && fusion == "1",
                    "{name}/{arc}/{fusion}"
                );
                for opt in ["-O1", "-O2"] {
                    let binary = dir.join("main.exe");
                    fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                    let actual = Command::new(&binary)
                        .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                        .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                        .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" })
                        .output()
                        .unwrap();
                    assert_eq!(
                        (&actual.stdout, &actual.stderr, actual.status.code()),
                        (&raw.stdout, &raw.stderr, raw.status.code()),
                        "{name}/{arc}/{fusion}/{opt}"
                    );
                }
            }
        }
    }
}

#[test]
fn direct_range_array_has_no_per_element_heap_allocations() {
    let dir = fwp::cgen::TempDir::new("range-array-counts").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let input = dir.join("main.fwp");
    std::fs::write(
        &input,
        "main = range 0 257 | array.from-list | hash | echo\n",
    )
    .unwrap();
    let raw = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for arc in [false, true] {
        for fusion in ["0", "1"] {
            let cfile = dir.join("main.c");
            let mut build = Command::new(compiler);
            build
                .env("FWP_ARRAY_FUSION", fusion)
                .args(["build", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile);
            if arc {
                build.args(["--gc", "arc"]);
            }
            checked(&mut build);
            let mut code = std::fs::read_to_string(cfile).unwrap();
            let marker = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
            assert_eq!(code.matches(marker).count(), 1);
            code = code.replace(
                marker,
                &format!("static unsigned range_requests;\n{marker} if(leaf!=0) range_requests++;"),
            );
            let initialized = "static inline void *fwp_alloc_init(size_t n) {";
            assert_eq!(code.matches(initialized).count(), 1);
            code = code.replace(initialized, &format!("{initialized} range_requests++;"));
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let finish = start + code[start..].find("\n}\n").unwrap() + 3;
            let body = code[start..finish].replace("    fwp_init_consts();\n",
                "    fwp_init_consts();\n    range_requests = 0; intptr_t range_budget = fwp_gc.budget;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n",
                "    /* Ownership observation point: before runtime teardown. */\n    if(range_requests > 6 || fwp_gc.budget != range_budget) exit(246);\n");
            code.replace_range(start..finish, &body);
            for opt in ["-O1", "-O2"] {
                let binary = dir.join("main.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let actual = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    actual.status.code(),
                    Some(if fusion == "1" { 0 } else { 246 }),
                    "{arc}/{fusion}/{opt}: {actual:?}"
                );
                assert_eq!(actual.stdout, raw.stdout);
            }
        }
    }
}

#[test]
fn direct_range_array_checks_storage_before_allocation_and_cleans_failure() {
    let dir = fwp::cgen::TempDir::new("range-array-cleanup").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, "main = range 0 3 | array.from-list | hash | echo\n").unwrap();
    for gc in ["tracing", "arc"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let start = code.find("static V fwp_p_array_range(").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let helper =
            code[start..end].replace("fwp_array_typed_new(n, elem)", "range_test_new(n, elem)");
        assert_ne!(helper, code[start..end]);
        let code = code[..start].to_string()
            + "static V range_test_new(size_t, const fwp_desc *);\n"
            + &helper
            + &code[end..];
        let code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
        let code = code[..code.find("int main(").unwrap()].to_string()
            + include_str!("fixtures/range_array_cleanup.c");
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("probe.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
        }
    }
}
