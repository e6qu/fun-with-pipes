//! Eliminate numeric zip intermediates without moving effects or ownership.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(out.status.success(), "{command:?}: {out:?}");
    out
}
#[test]
fn numeric_zip_maps_preserve_values_order_traps_and_exclusions() {
    let dir = fwp::cgen::TempDir::new("zip-map-semantics").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        ("numeric", r#"
main = [
    [10, 20, 30] | zip [1, 2] | map (uncurry sub) | echo,
    [1i8, -2i8] | zip [3i8, 4i8, 5i8] | map (uncurry add) | echo,
    [1.5f32, -0.0f32] | zip [2.0f32, 1.0f32] | map (uncurry mul) | echo,
    [] | zip [1, 2] | map (uncurry add) | echo,
    [1, 2] | zip [] | map (uncurry add) | echo,
    [1.0, 2.0] | both (zip [10.0, 20.0] | map id) id | echo,
    [1, 2] | zip [10, 20] | map (uncurry add | show) | echo,
] | ignore
"#, true, 0),
        ("consumers", r#"
main = [
    [1, 2] | zip [10, 20] | map (uncurry add) | sum | echo,
    [1, 2] | zip [10, 20] | map (uncurry add) | array.from-list | array.to-list | echo,
] | ignore
"#, false, 0),
        ("bindings", r#"
work : List[F64] -> List[F64]
work = both id (map (add 1.0)) | uncurry zip | map (uncurry mul)
main = [1.0, 2.0, 3.0] | work | echo
"#, true, 0),
        ("capture", r#"
offset : F64 -> (F64, F64) -> F64
offset = add | compose (uncurry add)
work : F64 -> List[F64] -> List[F64]
work = curry (both (.0 | offset) (.1 | zip [10.0, 20.0]) | uncurry map)
main = [1.0, 2.0] | work (args () | length | int.to-float) | echo
"#, true, 0),
        ("order", r#"
first : () -> List[I64] ! {IO}
first = const [1, 2] | tap (const "first" | echo)
second : () -> List[I64] ! {IO}
second = const [10, 20] | tap (const "second" | echo)
main = first () | zip (second ()) | map (tap echo | uncurry sub) | echo
"#, true, 0),
        ("trap", "main = [1i8, 127i8, 2i8] | zip [1i8, 1i8, 1i8] | map (tap echo | uncurry add) | echo\n", true, 101),
        ("prefix-effect", "main = [1, 2] | zip [10, 20] | both (const \"before\" | echo) (map (tap echo | uncurry add)) | .1 | echo\n", false, 0),
        ("managed-input", "main = [\"a\", \"b\"] | zip [\"c\", \"d\"] | map (uncurry concat) | echo\n", false, 0),
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
        if name == "order" {
            assert_eq!(
                reference.stdout,
                b"second\nfirst\n(1, 10)\n(2, 20)\n[9, 18]\n"
            );
        }
        if name == "trap" {
            assert_eq!(reference.stdout, b"(1, 1)\n(127, 1)\n");
        }
        for enabled in ["0", "1"] {
            let interpreted = Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_ZIP_MAP", enabled)
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
                "{name} interpreter {enabled}"
            );
            for gc in ["tracing", "arc"] {
                let cfile = dir.join("main.c");
                checked(
                    Command::new(compiler)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_ZIP_MAP", enabled)
                        .args(["build", "--gc", gc, "--emit-c"])
                        .arg(&input)
                        .arg("-o")
                        .arg(&cfile),
                );
                let code = std::fs::read_to_string(cfile).unwrap();
                assert_eq!(
                    code.contains("/* fused-zip-map :"),
                    eligible && enabled == "1",
                    "{name} {gc} {enabled}"
                );
                if name == "consumers" {
                    assert!(
                        code.contains("/* numeric mapped array: direct callback */")
                            || code.contains("return fwp_p_array_map_list(l0, l1,"),
                        "zip/map optimization hid existing numeric array construction"
                    );
                }
                for opt in ["-O1", "-O2"] {
                    let binary = dir.join("main.exe");
                    fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                    let verify = if gc == "tracing" { "1" } else { "0" };
                    let actual = Command::new(&binary)
                        .env("FWP_GC_STRESS", verify)
                        .env("FWP_GC_VERIFY", verify)
                        .env("FWP_REUSE_VERIFY", verify)
                        .output()
                        .unwrap();
                    assert_eq!(
                        (&actual.stdout, &actual.stderr, actual.status.code()),
                        (
                            &reference.stdout,
                            &reference.stderr,
                            reference.status.code()
                        ),
                        "{name} {gc} {enabled} {opt}"
                    );
                }
            }
        }
    }
}

#[test]
fn numeric_zip_maps_remove_pairs_and_nodes_and_preserve_input_aliases() {
    let dir = fwp::cgen::TempDir::new("zip-map-counts").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input,
        "export transform : List[I64] -> List[I64] -> List[I64]\ntransform = curry (uncurry zip | map (uncurry sub))\n").unwrap();
    for gc in ["tracing", "arc"] {
        let mut measured = Vec::new();
        for enabled in ["0", "1"] {
            let cfile = dir.join("main.c");
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_ZIP_MAP", enabled)
                    .args(["build", "--gc", gc, "--fn", "transform", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(cfile).unwrap();
            let start = code.find("/* transform :").unwrap();
            let entry = code[start..]
                .split("static V f")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap();
            let start = code.find("/* List[I64] */\nstatic void fwp_drop").unwrap();
            let drop = code[start..]
                .split("static void ")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap();
            let probe = include_str!("fixtures/zip_map_counts.c")
                .replace("fTRANSFORM", &format!("f{entry}"))
                .replace("fDROP", drop);
            let prefix = &code[..code.find("int main(").unwrap()];
            let mut code = prefix.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t zip_calls,zip_bytes,zip_retains;")
                .replace("static inline void *fwp_heap_alloc(size_t n, int kind) {", "static inline void *fwp_heap_alloc(size_t n, int kind) {\nif(kind!=0){zip_calls++;zip_bytes+=n;}")
                .replace("static inline void *fwp_alloc_init(size_t n) {", "static inline void *fwp_alloc_init(size_t n) {\nzip_calls++;zip_bytes+=n;");
            assert!(code.contains("if(kind!=0){zip_calls++"));
            for parameter in ["v", "value"] {
                let marker = format!("static inline void fwp_rc_dup(V {parameter}) {{");
                code = code.replace(&marker, &(marker.clone() + "\nzip_retains++;"));
            }
            code += &probe;
            for opt in ["-O1", "-O2"] {
                let binary = dir.join("counts.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let output = checked(
                    Command::new(&binary)
                        .env("FWP_GC", "off")
                        .env("FWP_GC_STRESS", "0"),
                );
                let counts: Vec<u64> = String::from_utf8(output.stdout)
                    .unwrap()
                    .split_whitespace()
                    .map(|s| s.parse().unwrap())
                    .collect();
                assert_eq!(counts.len(), 56);
                measured.push(counts);
                let marker = format!("/* negative control: remove the result's last-owner destruction */\n        {drop}(result);");
                let broken = code.replace(&marker, "/* result cleanup deliberately omitted */");
                assert_ne!(broken, code);
                fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
                assert_eq!(
                    Command::new(&binary)
                        .env("FWP_GC", "off")
                        .status()
                        .unwrap()
                        .code(),
                    Some(238)
                );
            }
        }
        assert_eq!(measured[0], measured[1]);
        assert_eq!(measured[2], measured[3]);
        for (before, after) in measured[0]
            .as_chunks::<4>()
            .0
            .iter()
            .zip(measured[2].as_chunks::<4>().0)
        {
            assert_eq!(before[0], after[0]);
            assert!(
                before[1] >= after[1] + 2 * after[0],
                "{gc}: {before:?} vs {after:?}"
            );
            assert!(
                before[2] >= after[2] + 48 * after[0],
                "{gc}: {before:?} vs {after:?}"
            );
            assert!(before[3] >= after[3], "{gc}: {before:?} vs {after:?}");
        }
    }
}

#[test]
fn zip_reclaims_partial_pairs_pending_fields_and_scratch_on_failure() {
    let dir = fwp::cgen::TempDir::new("zip-cleanup").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, "main = [\"x\"] | zip [\"y\"] | echo\n").unwrap();
    for gc in ["tracing", "arc"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        let start = code.find("static V fwp_p_zip_owned(").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let helper = code[start..end]
            .replace("fwp_map_items(", "zip_probe_items(")
            .replace("fwp_tuple2(", "zip_probe_pair(");
        let code = code[..start].to_string()
            + "static V *zip_probe_items(V,size_t *);\nstatic V zip_probe_pair(V,V);\n"
            + &helper
            + &code[end..];
        let code = code
            .replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1")
            .replace(
                "static V fwp_map_finish_protected(",
                "static V zip_probe_node(V *);\nstatic V fwp_map_finish_protected(",
            )
            .replace(
                "V node = fwp_rc_fresh(fwp_data(1, 2, fields));",
                "V node = fwp_rc_fresh(zip_probe_node(fields));",
            );
        assert!(code.contains("V node = fwp_rc_fresh(zip_probe_node(fields));"));
        let code = code[..code.find("int main(").unwrap()].to_string()
            + include_str!("fixtures/zip_cleanup.c");
        let broken_left = code.replace(
            "fwp_value_owner left = {a[i], drop_x};",
            "fwp_value_owner left = {a[i], NULL};",
        );
        let broken_pairs = code.replace(
            "fwp_map_owner owner = {a, 0, 0, drop_pair, drop_list};",
            "fwp_map_owner owner = {a, 0, 0, NULL, drop_list};",
        );
        let broken_scratch = code.replace(
            "fwp_scratch_finish(&b, &scratch_cleanup);",
            "fwp_cleanup_pop(&scratch_cleanup);",
        );
        assert_ne!(broken_left, code);
        assert_ne!(broken_pairs, code);
        assert_ne!(broken_scratch, code);
        for opt in ["-O1", "-O2"] {
            for (source, status) in [
                (&code, 0),
                (&broken_left, 248),
                (&broken_pairs, 248),
                (&broken_scratch, 249),
            ] {
                let binary = dir.join("probe.exe");
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                let actual = Command::new(&binary).output().unwrap();
                assert_eq!(actual.status.code(), Some(status), "{gc} {opt}: {actual:?}");
            }
        }
    }
}
