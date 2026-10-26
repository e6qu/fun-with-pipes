//! Direct integer range sets preserve bounds, sharing and cleanup.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn direct_range_sets_preserve_values_and_bound_order() {
    let dir = fwp::cgen::TempDir::new("range-set").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        ("values", include_str!("fixtures/range_sets.fwp"), true, 0),
        ("bounds", "lo : () -> I64 ! {IO}\nlo = const -2 | tap (const \"lower\" | echo)\nhi : () -> I64 ! {IO}\nhi = const 3 | tap (const \"upper\" | echo)\nmain = range (lo ()) (hi ()) | set.from-list | set.to-list | echo\n", true, 0),
        ("trap", "lo : () -> I64\nlo = const 1 | div 0\nhi : () -> I64\nhi = const 9223372036854775807 | add 1\nmain = range (lo ()) (hi ()) | set.from-list | set.to-list | echo\n", true, 101),
        ("wide", "main = [range -2i128 3i128 | set.from-list | echo, range 340282366920938463463374607431768211452u128 340282366920938463463374607431768211455u128 | set.from-list | echo] | ignore\n", false, 0),
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
                .env("FWP_MAP_BUILD", fusion)
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
            for memory in ["arc", "tracing"] {
                let cfile = dir.join("main.c");
                checked(
                    Command::new(compiler)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_MAP_BUILD", fusion)
                        .args(["build", "--gc", memory, "--emit-c"])
                        .arg(&input)
                        .arg("-o")
                        .arg(&cfile),
                );
                let code = std::fs::read_to_string(cfile).unwrap();
                assert_eq!(
                    code.contains("return fwp_p_set_range(l0, l1,"),
                    eligible && fusion == "1",
                    "{name}/{memory}/{fusion}"
                );
                for opt in ["-O0", "-O2"] {
                    let binary = dir.join("main.exe");
                    fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                    let stress = if memory == "arc" { "0" } else { "1" };
                    let actual = Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress)
                        .output()
                        .unwrap();
                    assert_eq!(
                        (&actual.stdout, &actual.stderr, actual.status.code()),
                        (&raw.stdout, &raw.stderr, raw.status.code()),
                        "{name}/{memory}/{fusion}/{opt}"
                    );
                }
            }
        }
    }
}

#[test]
fn direct_range_set_checks_storage_before_allocation_and_cleans_failure() {
    let dir = fwp::cgen::TempDir::new("range-set-cleanup").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, "main = range 0 3 | set.from-list | hash | echo\n").unwrap();
    for memory in ["arc", "tracing"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", memory, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let start = code.find("static V fwp_p_set_range(").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let helper = code[start..end].replace("fwp_map_typed_new(n, 1)", "range_test_new(n, 1)");
        assert_ne!(helper, code[start..end]);
        let code = code[..start].to_string()
            + "static V range_test_new(size_t, size_t);\n"
            + &helper
            + &code[end..];
        let code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
        let code = code[..code.find("int main(").unwrap()].to_string()
            + include_str!("fixtures/range_set_cleanup.c");
        let guard =
            "if (count > (SIZE_MAX - sizeof(fwp_map)) / sizeof(V)) fwp_trap(\"map too large\");";
        assert_eq!(code.matches(guard).count(), 1);
        let unchecked = code.replace(guard, "/* missing size guard */");
        let leaked = code.replace("fwp_rc_free_obj(result);", "/* missing result release */");
        assert_ne!(code, leaked);
        for opt in ["-O0", "-O2"] {
            for (candidate, status) in [(&code, 0), (&unchecked, 245), (&leaked, 243)] {
                let binary = dir.join("probe.exe");
                fwp::cgen::compile_c(candidate, &binary, opt).unwrap();
                let actual = Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    actual.status.code(),
                    Some(status),
                    "{memory}/{opt}: {actual:?}"
                );
            }
        }
    }
}

#[test]
fn direct_range_sets_allocate_only_the_result() {
    let dir = fwp::cgen::TempDir::new("range-set-counts").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(
        &input,
        "export build-set : I64 -> Set[I64]\nbuild-set = range 0 | set.from-list\nmain = ()\n",
    )
    .unwrap();
    for memory in ["arc", "tracing"] {
        for direct in ["0", "1"] {
            let cfile = dir.join("builder.c");
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_MAP_BUILD", direct)
                    .args(["build", "--gc", memory, "--fn", "build-set", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let builder = std::fs::read_to_string(&cfile).unwrap();
            let start = builder.find("/* build-set :").unwrap();
            let function = builder[start..]
                .split("static V ")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap();
            let allocate = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
            let initialized = "static inline void *fwp_alloc_init(size_t n) {";
            assert_eq!(builder.matches(allocate).count(), 1);
            assert_eq!(builder.matches(initialized).count(), 1);
            let code = builder
                .replace(
                    "typedef uint64_t V;",
                    "typedef uint64_t V;\nstatic size_t range_requests, range_bytes;",
                )
                .replace(
                    allocate,
                    &format!("{allocate} if(kind!=0) {{range_requests++; range_bytes+=n;}}"),
                )
                .replace(
                    initialized,
                    &format!("{initialized} range_requests++; range_bytes+=n;"),
                )
                .replace(
                    "int main(int argc, char **argv)",
                    "int original_main(int argc, char **argv)",
                );
            let code = format!(
                "{code}\n{}",
                include_str!("fixtures/range_set_storage.c")
                    .replace("BUILD_SET", function)
                    .replace("DIRECT", direct)
            );
            for opt in ["-O0", "-O2"] {
                let binary = dir.join("probe.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let actual = checked(
                    Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                );
                print!(
                    "{memory}/{opt}/direct={direct}: {}",
                    String::from_utf8_lossy(&actual.stdout)
                );
                if let Some(root) = std::env::var_os("FWP_MAP_FAILURE_ARTIFACTS") {
                    let root = std::path::Path::new(&root).join("range-sets");
                    std::fs::create_dir_all(&root).unwrap();
                    let label = format!("{memory}{opt}-direct-{direct}");
                    std::fs::write(root.join(format!("{label}.c")), &code).unwrap();
                    std::fs::write(root.join(format!("{label}.txt")), &actual.stdout).unwrap();
                    std::fs::copy(&binary, root.join(format!("{label}.exe"))).unwrap();
                }
                if direct == "0" && memory == "arc" && opt == "-O0" {
                    // The ordinary builder must fail the one-allocation budget.
                    let control = code.replace("(0 ?", "(1 ?");
                    assert_ne!(control, code);
                    fwp::cgen::compile_c(&control, &binary, opt).unwrap();
                    let failed = Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    assert_eq!(failed.status.code(), Some(246), "{failed:?}");
                }
            }
        }
    }
}
