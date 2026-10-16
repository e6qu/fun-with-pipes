//! Numeric map-to-array construction preserves order and owns its scratch.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(out.status.success(), "{command:?}: {out:?}");
    out
}
fn emitted(
    compiler: &str,
    source: &std::path::Path,
    cfile: &std::path::Path,
    gc: &str,
    fused: &str,
) -> String {
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .env("FWP_ARRAY_FUSION", fused)
            .args(["build", "--gc", gc, "--emit-c"])
            .arg(source)
            .arg("-o")
            .arg(cfile),
    );
    std::fs::read_to_string(cfile).unwrap()
}
#[test]
fn numeric_materialization_preserves_raw_values_effects_and_traps() {
    let dir = fwp::cgen::TempDir::new("mapped-array-semantics").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        ("numeric", r#"
main = [
    [1i8, -2i8, 127i8] | map id | array.from-list | array.to-list | echo,
    [0u64, 18446744073709551615u64] | map id | array.from-list | array.to-list | echo,
    [1.5f32, -0.0f32] | map (mul 2.0f32) | array.from-list | array.to-list | echo,
    [1.5, -0.0] | map (mul 2.0) | array.from-list | array.to-list | echo,
    [] | map (add 1) | array.from-list | array.to-list | echo,
    ["a", "héllo", ""] | both (map string.length | array.from-list | array.to-list) id | echo,
] | ignore
"#, true, 0),
        ("effects", "main = [1, 2, 3] | map (tap echo | add 4) | array.from-list | array.to-list | echo\n", true, 0),
        ("trap", "main = [1i8, 127i8, 2i8] | map (tap echo | add 1i8) | array.from-list | array.to-list | echo\n", true, 101),
        ("managed", "main = [\"a\", \"b\"] | map (concat \"!\") | array.from-list | array.to-list | echo\n", false, 0),
    ];
    for (name, source, eligible, status) in cases {
        let input = dir.join("main.fwp");
        std::fs::write(&input, source).unwrap();
        let reference = Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            reference.status.code(),
            Some(status),
            "{name}: {reference:?}"
        );
        if name == "trap" {
            assert_eq!(reference.stdout, b"1\n127\n");
        }
        for fused in ["0", "1"] {
            let interpreted = Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_ARRAY_FUSION", fused)
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
                (
                    &reference.stdout,
                    &reference.stderr,
                    reference.status.code()
                ),
                "{name} interpreter {fused}"
            );
            for gc in ["tracing", "arc"] {
                let code = emitted(compiler, &input, &dir.join("main.c"), gc, fused);
                assert_eq!(
                    code.contains("return fwp_p_array_map_list(l0, l1,"),
                    eligible && fused == "1",
                    "{name} {gc} {fused}"
                );
                for opt in ["-O1", "-O2"] {
                    let binary = dir.join("main.exe");
                    fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                    let verify = if gc == "arc" { "0" } else { "1" };
                    let actual = Command::new(&binary)
                        .env("FWP_GC_STRESS", verify)
                        .env("FWP_GC_VERIFY", verify)
                        .env("FWP_REUSE_VERIFY", "1")
                        .output()
                        .unwrap();
                    assert_eq!(
                        (&actual.stdout, &actual.stderr, actual.status.code()),
                        (
                            &reference.stdout,
                            &reference.stderr,
                            reference.status.code()
                        ),
                        "{name} {gc} {fused} {opt}"
                    );
                }
            }
        }
    }
}

#[test]
fn mapped_array_scratch_releases_on_success_and_callback_failure() {
    let dir = fwp::cgen::TempDir::new("mapped-array-cleanup").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(
        &input,
        "main = [1.0, 2.0] | map (mul 2.0) | array.from-list | array.to-list | echo\n",
    )
    .unwrap();
    for gc in ["tracing", "arc"] {
        let code = emitted(
            env!("CARGO_BIN_EXE_fwp"),
            &input,
            &dir.join("main.c"),
            gc,
            "1",
        );
        let start = code.find("static V fwp_p_array_map_list(").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let helper = code[start..end].replace(
            "fwp_apply_borrowed(f, 1, &items[i])",
            "mapped_test_apply(items[i])",
        );
        let code =
            code[..start].to_string() + "static V mapped_test_apply(V);\n" + &helper + &code[end..];
        let code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
        let main = code.find("int main(").unwrap();
        let code = code[..main].to_string() + include_str!("fixtures/mapped_array_cleanup.c");
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("probe.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            checked(Command::new(&binary));
            let broken = code.replace(
                "    fwp_scratch_finish(&items, &cleanup);",
                "    fwp_cleanup_pop(&cleanup);",
            );
            assert_ne!(broken, code);
            fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
            assert_eq!(Command::new(&binary).status().unwrap().code(), Some(231));
        }
    }
}

#[test]
fn numeric_materialization_removes_list_nodes_without_retaining_inputs() {
    let dir = fwp::cgen::TempDir::new("mapped-array-counts").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(
        &input,
        "transform : List[F64] -> Array[F64]\ntransform = map (mul 2.0) | array.from-list\n",
    )
    .unwrap();
    for gc in ["tracing", "arc"] {
        let mut measurements = Vec::new();
        for fused in ["0", "1"] {
            let cfile = dir.join("main.c");
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_ARRAY_FUSION", fused)
                    .args(["build", "--gc", gc, "--fn", "transform", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let source = std::fs::read_to_string(cfile).unwrap();
            let start = source.find("/* transform :").unwrap();
            let id = source[start..]
                .split("static V f")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap();
            let probe = include_str!("fixtures/mapped_array_counts.c")
                .replace("fTRANSFORM", &format!("f{id}"));
            let source = source[..source.find("int main(").unwrap()].to_string();
            assert!(source.contains("static inline void *fwp_gc_alloc(size_t n, int leaf) {"));
            assert!(source.contains("static inline void *fwp_alloc_init(size_t n) {"));
            let code = source.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t mapped_calls, mapped_bytes;")
                .replace("static inline void *fwp_gc_alloc(size_t n, int leaf) {", "static inline void *fwp_gc_alloc(size_t n, int leaf) {\nif(leaf!=0){mapped_calls++;mapped_bytes+=n;}")
                .replace("static inline void *fwp_alloc_init(size_t n) {", "static inline void *fwp_alloc_init(size_t n) {\nmapped_calls++;mapped_bytes+=n;") + &probe;
            for opt in ["-O1", "-O2"] {
                let binary = dir.join("counts.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let output = checked(Command::new(&binary).env("FWP_GC_STRESS", "0"));
                let counts: Vec<u64> = String::from_utf8(output.stdout)
                    .unwrap()
                    .split_whitespace()
                    .map(|s| s.parse().unwrap())
                    .collect();
                measurements.push(counts);
            }
        }
        assert_eq!(measurements[0], measurements[1]);
        assert_eq!(measurements[2], measurements[3]);
        for (unfused, fused) in measurements[0]
            .chunks_exact(3)
            .zip(measurements[2].chunks_exact(3))
        {
            assert_eq!(unfused[0], fused[0]);
            assert!(
                unfused[1] >= fused[1] + fused[0],
                "{gc}: {unfused:?} vs {fused:?}"
            );
            assert!(unfused[2] >= fused[2] + 24 * fused[0]);
        }
    }
}
