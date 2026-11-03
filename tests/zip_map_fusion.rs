//! Eliminate numeric zip intermediates without moving effects or ownership.
use std::process::{Command, Output};

#[path = "support/allocation_report.rs"]
mod allocation_report;
#[path = "support/record_probe.rs"]
mod record_probe;
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
        ("numeric-records", r#"
Point = {x: F64, index: I64}
main = [
    [Point {x = 1.5, index = 2}, Point {x = 3.0, index = 4}]
    | zip [Point {x = 10.0, index = 20}]
    | map (fn (a, b) -> ((a | .x) - (b | .x), (a | .index) + (b | .index)))
    | echo,
    [(1, 2.0), (3, 4.0)] | zip [(5, 6.0)] | map (fn (a, b) -> (a | .0) + (b | .0)) | echo,
    [Point {x = 1.5, index = 2}] | zip [10.0, 20.0]
    | map (fn (a, b) -> (a | .x) + b) | echo,
    [] | zip [Point {x = 1.0, index = 2}]
    | map (fn (a, b) -> (a | .x) + (b | .x)) | echo,
] | ignore
"#, true, 0),
        ("record-alias", r#"
Point = {x: F64, index: I64}
work : List[Point] -> (List[(Point, Point)], List[Point])
work = both (zip [Point {x = 10.0, index = 20}] | map id) id
main = [Point {x = 1.0, index = 2}, Point {x = 3.0, index = 4}] | work | echo
"#, true, 0),
        ("record-trap", r#"
Small = {value: I8}
main = [Small {value = 1i8}, Small {value = 127i8}, Small {value = 2i8}]
    | zip [Small {value = 1i8}, Small {value = 1i8}, Small {value = 1i8}]
    | map (tap echo | fn (a, b) -> (a | .value) + (b | .value)) | echo
"#, true, 101),
        ("record-capture", r#"
Point = {x: F64, index: I64}
offset : F64 -> (Point, Point) -> F64
offset = fn extra -> fn (a, b) -> extra + (a | .x) + (b | .x)
work : F64 -> List[Point] -> List[F64]
work = curry (both (.0 | offset) (.1 | zip [Point {x = 10.0, index = 20}]) | uncurry map)
main = [Point {x = 1.0, index = 2}] | work (args () | length | int.to-float) | echo
"#, true, 0),
        ("nested-record-excluded", r#"
Point = {x: F64}
Nested = {point: Point}
main = [Nested {point = Point {x = 1.0}}] | zip [Nested {point = Point {x = 2.0}}]
    | map (fn (a, b) -> (a | .point | .x) + (b | .point | .x)) | echo
"#, false, 0),
        ("managed-record-excluded", r#"
Text = {value: String}
main = [Text {value = "a"}] | zip [Text {value = "b"}]
    | map (fn (a, b) -> (a | .value) | concat (b | .value)) | echo
"#, false, 0),
        ("wide-record-excluded", r#"
Wide = {value: F128}
main = [Wide {value = 1.0f128}] | zip [Wide {value = 2.0f128}]
    | map (fn (a, b) -> (a | .value) + (b | .value)) | echo
"#, false, 0),
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

            let cfile = dir.join("main.c");
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_ZIP_MAP", enabled)
                    .args(["build", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(cfile).unwrap();
            assert_eq!(
                code.contains("/* fused-zip-map :"),
                eligible && enabled == "1",
                "{name} counted {enabled}"
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

                let actual = Command::new(&binary).output().unwrap();
                assert_eq!(
                    (&actual.stdout, &actual.stderr, actual.status.code()),
                    (
                        &reference.stdout,
                        &reference.stderr,
                        reference.status.code()
                    ),
                    "{name} counted {enabled} {opt}"
                );
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

    let mut measured = Vec::new();
    for enabled in ["0", "1"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_ZIP_MAP", enabled)
                .args(["build", "--fn", "transform", "--emit-c"])
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
            let output = checked(&mut Command::new(&binary));
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
            assert_eq!(Command::new(&binary).status().unwrap().code(), Some(238));
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
            "counted: {before:?} vs {after:?}"
        );
        assert!(
            before[2] >= after[2] + 48 * after[0],
            "counted: {before:?} vs {after:?}"
        );
        assert!(before[3] >= after[3], "counted: {before:?} vs {after:?}");
    }
}

#[test]
fn numeric_record_zip_maps_remove_temporary_owners_and_preserve_both_aliases() {
    let dir = fwp::cgen::TempDir::new("zip-map-record-counts").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(
        &input,
        r#"
Point = {index: I64, value: F64}
export transform : List[Point] -> List[Point] -> List[I64]
transform = curry (uncurry zip | map (fn (a, b) -> (b | .index) - (a | .index)))
"#,
    )
    .unwrap();
    let mut measured = Vec::new();
    for enabled in ["0", "1"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_ZIP_MAP", enabled)
                .args(["build", "--fn", "transform", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        assert_eq!(code.contains("/* fused-zip-map :"), enabled == "1");
        let start = code.find("/* transform :").unwrap();
        let entry = code[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let drop_name = |ty: &str| {
            let start = code
                .find(&format!("/* {ty} */\nstatic void fwp_drop"))
                .unwrap();
            code[start..]
                .split("static void ")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap()
                .to_string()
        };
        let drop_result = drop_name("List[I64]");
        let drop_input = drop_name("List[Point]");
        let probe = include_str!("fixtures/zip_map_record_counts.c")
            .replace("fTRANSFORM", &format!("f{entry}"))
            .replace("fDROP_RESULT", &drop_result)
            .replace("fDROP_INPUT", &drop_input);
        let prefix = &code[..code.find("int main(").unwrap()];
        let mut source = prefix.replace("typedef uint64_t V;",
            "typedef uint64_t V;\nstatic uint64_t zip_calls,zip_bytes,zip_retains;")
            .replace("static inline void *fwp_heap_alloc(size_t n, int kind) {",
                "static inline void *fwp_heap_alloc(size_t n, int kind) {\nif(kind!=0){zip_calls++;zip_bytes+=n;}")
            .replace("static inline void *fwp_alloc_init(size_t n) {",
                "static inline void *fwp_alloc_init(size_t n) {\nzip_calls++;zip_bytes+=n;");
        let retain = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
        assert_eq!(source.matches(retain).count(), 1);
        source = source.replace(retain, &(retain.to_string() + "\nzip_retains++;"));
        source += &probe;
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("counts.exe");
            fwp::cgen::compile_c(&source, &binary, opt).unwrap();
            let output = Command::new(&binary).output().unwrap();
            let label = format!("records-{enabled}-{}", opt.trim_start_matches('-'));
            record_probe::save("zip_map_fusion", &label, &source, &binary, &output);
            assert!(output.status.success(), "{label}: {output:?}");
            let counts: Vec<u64> = String::from_utf8(output.stdout)
                .unwrap()
                .split_whitespace()
                .map(|value| value.parse().unwrap())
                .collect();
            assert_eq!(counts.len(), 112);
            measured.push(counts);
            let marker = format!("/* negative control: remove the result's last-owner destruction */\n        {drop_result}(result);");
            assert_eq!(source.matches(&marker).count(), 1);
            let broken = source.replace(&marker, "/* result cleanup deliberately omitted */");
            fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
            let failed = Command::new(&binary).output().unwrap();
            record_probe::save(
                "zip_map_fusion",
                &(label + "-missing-cleanup"),
                &broken,
                &binary,
                &failed,
            );
            assert_eq!(failed.status.code(), Some(238), "{failed:?}");
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
            "requests: {before:?} vs {after:?}"
        );
        assert!(
            before[2] >= after[2] + 48 * after[0],
            "bytes: {before:?} vs {after:?}"
        );
        assert!(
            before[3] >= after[3] + 3 * after[0],
            "retains: {before:?} vs {after:?}"
        );
    }
}

#[test]
fn zip_reclaims_partial_pairs_pending_fields_and_scratch_on_failure() {
    let dir = fwp::cgen::TempDir::new("zip-cleanup").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, "main = [\"x\"] | zip [\"y\"] | echo\n").unwrap();

    let cfile = dir.join("main.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
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
            assert_eq!(
                actual.status.code(),
                Some(status),
                "counted {opt}: {actual:?}"
            );
        }
    }
}

#[test]
fn scalar_map_buffers_preserve_eager_order_aliases_and_both_zip_slots() {
    let dir = fwp::cgen::TempDir::new("scalar-map-zip-order").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, include_str!("fixtures/scalar_map_zip_order.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    assert!(reference
        .stdout
        .starts_with(b"77\n1\n2\n77\n1\n2\n77\n(10, 101)\n"));
    let interpreted = checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["run", "--interp"])
            .arg(&input),
    );
    assert_eq!(interpreted.stdout, reference.stdout);
    assert_eq!(interpreted.stderr, reference.stderr);
    for stack in ["0", "1"] {
        for opt in ["-O1", "-O2"] {
            let path = dir.join(format!("scalar-{stack}-{opt}.c"));
            checked(
                Command::new(compiler)
                    .env("FWP_STACK", stack)
                    .args(["build", "--memory", "dynamic", "--emit-c", opt])
                    .arg(&input)
                    .arg("-o")
                    .arg(&path),
            );
            let code = std::fs::read_to_string(&path).unwrap();
            assert!(
                code.contains("Eager scalar buffer"),
                "{stack}/{opt}: map not selected"
            );
            assert!(code.contains("Zip after the complete scalar map"));
            let executable = dir.join(format!("scalar-{stack}-{opt}.exe"));
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let output = checked(Command::new(&executable).env("FWP_ALLOC_STATS", "1"));
            record_probe::save(
                "scalar_map_zip_order",
                &format!("{stack}-{opt}"),
                &code,
                &executable,
                &output,
            );
            assert_eq!(output.stdout, reference.stdout, "{stack}/{opt}");
            let stats =
                allocation_report::parse(std::str::from_utf8(&output.stderr).unwrap()).unwrap();
            assert_eq!(stats.live, 0, "{stack}/{opt}: {stats:?}");
        }
    }
}

#[test]
fn scalar_map_buffers_exclude_shared_results_captures_and_wide_values() {
    let dir = fwp::cgen::TempDir::new("scalar-map-zip-exclusions").unwrap();
    let cases = [
        ("shared", "export run : List[I64] -> (List[I64], List[I64]) ! {IO}\nrun = fn xs -> let ys = map mapped xs in (zip-with sub ys xs, ys)\n", "mapped : I64 -> I64 ! {IO}\nmapped = fn n -> let printed = n | echo in n + 1\n"),
        ("escape", "export run : List[I64] -> List[I64] ! {IO}\nrun = map mapped\n", "mapped : I64 -> I64 ! {IO}\nmapped = fn n -> let printed = n | echo in n + 1\n"),
        ("capture", "export run : I64 -> List[I64] -> List[I64] ! {IO}\nrun = fn offset -> fn xs -> let ys = map (fn n -> let printed = n | echo in n + offset) xs in zip-with sub ys xs\n", ""),
        ("dynamic", "export run : (I64 -> I64) -> List[I64] -> List[I64]\nrun = fn callback -> fn xs -> let ys = map callback xs in zip-with sub ys xs\n", ""),
        ("dynamic-zip", "export run : (I64 -> I64 -> I64) -> List[I64] -> List[I64] ! {IO}\nrun = fn callback -> fn xs -> let ys = map mapped xs in zip-with callback ys xs\n", "mapped : I64 -> I64 ! {IO}\nmapped = fn n -> let printed = n | echo in n + 1\n"),
        ("wide", "export run : List[F128] -> List[F128] ! {IO}\nrun = fn xs -> let ys = map mapped xs in zip-with sub ys xs\n", "mapped : F128 -> F128 ! {IO}\nmapped = fn n -> let printed = n | echo in n + 1.0f128\n"),
    ];
    for (name, body, helper) in cases {
        let source = dir.join(format!("{name}.fwp"));
        let output = dir.join(format!("{name}.c"));
        std::fs::write(&source, format!("{helper}{body}")).unwrap();
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--fn", "run", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&output),
        );
        let code = std::fs::read_to_string(output).unwrap();
        assert!(!code.contains("Eager scalar buffer"), "{name}");
        assert!(
            !code.contains("Zip after the complete scalar map"),
            "{name}"
        );
    }
}

#[test]
fn scalar_map_buffers_keep_each_machine_number_representation() {
    let dir = fwp::cgen::TempDir::new("scalar-map-zip-numbers").unwrap();
    let types = [
        ("I8", "i8"),
        ("I16", "i16"),
        ("I32", "i32"),
        ("I64", "i64"),
        ("ISize", "isize"),
        ("U8", "u8"),
        ("U16", "u16"),
        ("U32", "u32"),
        ("U64", "u64"),
        ("USize", "usize"),
        ("F32", "f32"),
        ("F64", "f64"),
    ];
    let mut source = String::new();
    let mut calls = Vec::new();
    for (ty, suffix) in types {
        let one = if ty.starts_with('F') {
            format!("1.0{suffix}")
        } else {
            format!("1{suffix}")
        };
        let two = if ty.starts_with('F') {
            format!("2.0{suffix}")
        } else {
            format!("2{suffix}")
        };
        source += &format!("mapped-{suffix} : {ty} -> {ty} ! {{IO}}\nmapped-{suffix} = fn n -> let printed = n | echo in n + {one}\nrun-{suffix} : List[{ty}] -> List[{ty}] ! {{IO}}\nrun-{suffix} = fn xs -> let ys = map mapped-{suffix} xs in zip-with add ys xs\n");
        calls.push(format!("[{one}, {two}] | run-{suffix} | show"));
    }
    source += &format!("main = [{}] | each print\n", calls.join(", "));
    let input = dir.join("numbers.fwp");
    std::fs::write(&input, source).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    let interpreted = checked(Command::new(compiler).args(["run", "--interp"]).arg(&input));
    assert_eq!(interpreted.stdout, reference.stdout);
    for opt in ["-O1", "-O2"] {
        let cfile = dir.join(format!("numbers-{opt}.c"));
        checked(
            Command::new(compiler)
                .args(["build", "--memory", "dynamic", "--emit-c", opt])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        assert_eq!(code.matches("Eager scalar buffer").count(), types.len());
        let exe = dir.join(format!("numbers-{opt}.exe"));
        fwp::cgen::compile_c(&code, &exe, opt).unwrap();
        let output = checked(Command::new(&exe).env("FWP_ALLOC_STATS", "1"));
        record_probe::save("scalar_map_zip_numbers", opt, &code, &exe, &output);
        assert_eq!(output.stdout, reference.stdout, "{opt}");
        let stats = allocation_report::parse(std::str::from_utf8(&output.stderr).unwrap()).unwrap();
        assert_eq!(stats.live, 0, "{stats:?}");
    }
}

#[test]
fn private_ranges_preserve_bounds_order_callbacks_and_aliases() {
    let dir = fwp::cgen::TempDir::new("range-zip-semantics").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        (
            "bounds",
            r#"
left : I64 -> I64 -> List[I64] -> List[I64]
left = fn lo -> fn hi -> fn xs -> let indices = range lo hi in zip-with sub indices xs
right : I64 -> I64 -> List[I64] -> List[I64]
right = fn lo -> fn hi -> fn xs -> let indices = range lo hi in zip-with sub xs indices
main = [
    left -2 2 [10, 20, 30] | echo,
    right -2 2 [10, 20, 30] | echo,
    left 4 2 [1, 2] | echo,
    left 2 2 [1, 2] | echo,
    left -2 2 [] | echo,
    left -9223372036854775808 -9223372036854775806 [-9223372036854775808, -9223372036854775808] | echo,
    right 9223372036854775805 9223372036854775807 [0, 0] | echo,
] | ignore
"#,
            true,
            0,
        ),
        (
            "capture-record",
            r#"
work : I64 -> List[I64] -> (List[(I64, I64)], List[I64])
work = fn offset -> fn xs ->
    let indices = range 0 (length xs)
    in let result = zip-with (fn index -> fn value -> (index + offset, value)) indices xs
    in (result, xs)
main = [10, 20, 30] | work (args () | length) | echo
"#,
            true,
            0,
        ),
        (
            "order",
            r#"
mark : String -> I64 -> I64 ! {IO}
mark = fn name -> tap (const name | echo)
work : List[I64] -> List[(I64, I64)] ! {IO}
work = fn xs ->
    let indices = range (mark "lo" -2) (mark "hi" 2)
    in let offset = mark "capture" 10
    in let ready = echo "between"
    in zip-with (fn index -> fn value -> let printed = echo index in (index + offset, value)) indices (xs | tap (const "input" | echo))
main = [10, 20] | work | echo
"#,
            true,
            0,
        ),
        (
            "trap",
            r#"
work : I64 -> List[I64] -> List[I64] ! {IO}
work = fn count -> fn xs ->
    let indices = range 0 count
    in zip-with (fn index -> fn value -> let printed = echo index in value / index) indices xs
main = work 3 [10, 20, 30] | echo
"#,
            true,
            101,
        ),
        (
            "inline-order",
            r#"
mark : String -> I64 -> I64 ! {IO}
mark = fn name -> tap (const name | echo)
combine : I64 -> I64 -> I64 -> (I64, I64)
combine = fn offset -> fn index -> fn value -> (index + offset, value)
main = zip-with (combine (mark "callback" 10))
    (range (mark "lo" -2) (mark "hi" 2))
    ([10, 20] | tap (const "input" | echo)) | echo
"#,
            true,
            0,
        ),
        (
            "shared",
            r#"
work : I64 -> List[I64] -> (List[I64], List[I64])
work = fn count -> fn xs -> let indices = range 0 count in (zip-with add indices xs, indices)
main = work 3 [10, 20] | echo
"#,
            false,
            0,
        ),
        (
            "managed-result",
            r#"
work : I64 -> List[I64] -> List[String]
work = fn count -> fn xs -> let indices = range 0 count in zip-with (fn index -> fn value -> show (index + value)) indices xs
main = work 3 [10, 20] | echo
"#,
            false,
            0,
        ),
    ];
    for (name, source, selected, status) in cases {
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
                b"lo\nhi\ncapture\nbetween\ninput\n-2\n-1\n[(8, 10), (9, 20)]\n"
            );
        }
        if name == "inline-order" {
            assert_eq!(
                reference.stdout,
                b"callback\nlo\nhi\ninput\n[(8, 10), (9, 20)]\n"
            );
        }
        let ordinary = Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            (&ordinary.stdout, &ordinary.stderr, ordinary.status.code()),
            (
                &reference.stdout,
                &reference.stderr,
                reference.status.code()
            ),
            "{name} optimized interpreter"
        );
        let cfile = dir.join("main.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        assert_eq!(
            code.contains("/* Generate private range indices;"),
            selected,
            "{name}"
        );
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("main.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let output = Command::new(&binary).output().unwrap();
            record_probe::save(
                "range_zip_semantics",
                &format!("{name}-{opt}"),
                &code,
                &binary,
                &output,
            );
            assert_eq!(
                (&output.stdout, &output.stderr, output.status.code()),
                (
                    &reference.stdout,
                    &reference.stderr,
                    reference.status.code()
                ),
                "{name} {opt}"
            );
        }
    }
}
