//! Numeric map-to-array construction preserves order and owns its scratch.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn direct_scalar_array_maps_preserve_values_order_aliases_and_exclusions() {
    let dir = fwp::cgen::TempDir::new("direct-array-maps").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let marker = "direct known scalar array map; input stays borrowed";
    for (label, program, status) in [
        ("values", include_str!("fixtures/direct_array_maps.fwp"), 0),
        (
            "capture-order",
            r#"
coefficient : I64 -> I64 ! {IO}
coefficient = tap echo
input : () -> Array[I64] ! {IO}
input = fn () -> let shown = echo 30 in array.from-list [1, 2]
export adjust : I64 -> I64 -> Array[I64] -> Array[I64] ! {IO}
adjust = fn scale -> fn offset -> fn values ->
    values | array.map (fn value -> let shown = echo value in value * scale + offset)
main = adjust (coefficient 2) (coefficient 3) (input ()) | array.to-list | echo
"#,
            0,
        ),
        (
            "computed-capture",
            r#"
coefficient : I64 -> I64 ! {IO}
coefficient = tap echo
export adjust : I64 -> Array[I64] -> Array[I64] ! {IO}
adjust = fn offset -> fn values -> array.map (add (coefficient offset)) values
main = array.from-list [1, 2] | adjust 3 | array.to-list | echo
"#,
            0,
        ),
        (
            "trap",
            r#"
step : I8 -> I8 ! {IO}
step = fn value -> let shown = echo value in value + 1i8
export mapped : Array[I8] -> Array[I8] ! {IO}
mapped = array.map step
main = array.from-list [1i8, 127i8, 2i8] | mapped | array.to-list | echo
"#,
            101,
        ),
    ] {
        let input = dir.join(format!("{label}.fwp"));
        std::fs::write(&input, program).unwrap();
        let reference = Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            reference.status.code(),
            Some(status),
            "{label}: {reference:?}"
        );
        if label == "trap" {
            assert_eq!(reference.stdout, b"1\n127\n");
        } else if label == "computed-capture" {
            assert_eq!(reference.stdout, b"3\n[4, 5]\n");
        } else if label == "capture-order" {
            assert_eq!(reference.stdout, b"2\n3\n30\n1\n2\n[5, 7]\n");
        } else {
            assert!(reference.stdout.starts_with(b"[2, -1]\n[0.5, 1.0]"));
        }
        for packing in ["0", "1"] {
            let interpreted = Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_PACKED_ARRAYS", packing)
                .args(["run", "--interp"])
                .arg(&input)
                .output()
                .unwrap();
            assert_eq!(interpreted.stdout, reference.stdout, "{label}");
            assert_eq!(interpreted.stderr, reference.stderr, "{label}");
            assert_eq!(interpreted.status.code(), Some(status), "{label}");
            let cfile = dir.join(format!("{label}-{packing}.c"));
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_PACKED_ARRAYS", packing)
                    .args(["build", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            let artifacts = std::env::var_os("FWP_ARC_ARTIFACTS")
                .map(|root| PathBuf::from(root).join("direct-array-map-sources"));
            if let Some(directory) = &artifacts {
                std::fs::create_dir_all(directory).unwrap();
                std::fs::write(directory.join(format!("{label}.fwp")), program).unwrap();
                std::fs::write(directory.join(format!("{label}-{packing}.c")), &code).unwrap();
            }
            if label == "values" {
                // Main-only compilation may inline or remove these functions.
                // Request exported roots explicitly for selection inspection;
                // native semantic checks below still execute the ordinary main.
                let exported_file = dir.join(format!("exports-{packing}.c"));
                checked(
                    Command::new(compiler)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_PACKED_ARRAYS", packing)
                        .args(["build", "--fn", "small", "--emit-c"])
                        .arg(&input)
                        .arg("-o")
                        .arg(&exported_file),
                );
                let exported = std::fs::read_to_string(exported_file).unwrap();
                if let Some(directory) = &artifacts {
                    std::fs::write(directory.join(format!("exports-{packing}.c")), &exported)
                        .unwrap();
                }
                for (name, selected) in [
                    ("small", true),
                    ("signed", true),
                    ("unsigned", true),
                    ("scaled", true),
                    ("rounded", true),
                    ("converted", true),
                    ("observed", true),
                    ("dynamic", false),
                    ("captured", true),
                    ("wide", false),
                    ("text-lengths", false),
                    ("record-sums", false),
                ] {
                    let start = exported
                        .find(&format!("/* {name} :"))
                        .unwrap_or_else(|| panic!("missing exported map probe `{name}`"));
                    let body = &exported[start..start + exported[start..].find("\n}\n").unwrap()];
                    let owned = exported
                        .match_indices("/* consumed-scalar-array-map :")
                        .filter_map(|(start, _)| {
                            let worker =
                                &exported[start..start + exported[start..].find("\n}\n").unwrap()];
                            let id = worker
                                .split("static V f")
                                .nth(1)
                                .unwrap()
                                .split('(')
                                .next()
                                .unwrap();
                            body.contains(&format!("f{id}(")).then_some(worker)
                        })
                        .collect::<Vec<_>>();
                    assert!(owned.len() <= 1, "ambiguous scalar map worker: {name}");
                    assert_eq!(
                        body.contains(marker) || !owned.is_empty(),
                        selected,
                        "{name}: {body}"
                    );
                    if selected {
                        let implementation = owned.first().copied().unwrap_or(body);
                        assert!(
                            implementation.contains("fwp_array_store_owned(")
                                || implementation.contains("fwp_array_store(")
                        );
                        assert!(implementation.contains("fwp_array_load("));
                        assert!(!implementation.contains("fwp_apply"));
                    }
                }
            } else {
                assert!(
                    code.contains(marker) || code.contains("/* Consume one scalar array owner;")
                );
            }
            for opt in ["-O1", "-O2"] {
                let binary = dir.join(format!("{label}-{packing}-{opt}.exe"));
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let output = Command::new(&binary).output().unwrap();
                record_probe::save(
                    "direct-array-maps",
                    &format!("{label}-{packing}-{opt}"),
                    &code,
                    &binary,
                    &output,
                );
                assert_eq!(output.stdout, reference.stdout, "{label} {packing} {opt}");
                assert_eq!(output.stderr, reference.stderr, "{label} {packing} {opt}");
                assert_eq!(
                    output.status.code(),
                    Some(status),
                    "{label} {packing} {opt}"
                );
            }
        }
    }
}

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status {:?}\n{}\n{}",
        out.status.code(),
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
fn emitted(
    compiler: &str,
    source: &std::path::Path,
    cfile: &std::path::Path,
    fused: &str,
) -> String {
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .env("FWP_ARRAY_FUSION", fused)
            .args(["build", "--emit-c"])
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
        ("dynamic", "pick : I64 -> (F64 -> F64)\npick = if (eq 0) (const (mul 2.0)) (const (add 3.0))\nmain = [1.0, 2.0] | map (args () | length | pick) | array.from-list | array.to-list | echo\n", true, 0),
        ("captured", "main = [1.0, 2.0] | map (args () | length | int.to-float | add) | array.from-list | array.to-list | echo\n", true, 0),
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

            let code = emitted(compiler, &input, &dir.join("main.c"), fused);
            assert_eq!(
                code.contains("return fwp_p_array_map_list(l0, l1,")
                    || code.contains("/* numeric mapped array: direct callback */"),
                eligible && fused == "1",
                "{name} counted {fused}"
            );
            if eligible && fused == "1" && name != "dynamic" {
                assert!(
                    code.contains("/* numeric mapped array: direct callback */"),
                    "known callback lost direct call: {name}"
                );
            }
            for body in code
                .split("/* numeric mapped array: direct callback */")
                .skip(1)
            {
                let loop_body = body.split("fwp_scratch_finish").next().unwrap();
                assert!(loop_body.contains("fwp_owned_entry") && !loop_body.contains("fwp_apply_"));
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
                    "{name} counted {fused} {opt}"
                );
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

    let code = emitted(env!("CARGO_BIN_EXE_fwp"), &input, &dir.join("main.c"), "1");
    let start = code.find("static V fwp_p_array_map_list(").unwrap();
    let end = start + code[start..].find("\n}\n").unwrap() + 3;
    let helper = code[start..end]
        .replace(
            "fwp_apply_borrowed(f, 1, &items[i])",
            "mapped_test_apply(items[i])",
        )
        .replace("fwp_array_typed_new(n, elem)", "mapped_test_array(n, elem)");
    let code = code[..start].to_string()
        + "static V mapped_test_apply(V);\nstatic V mapped_test_array(size_t, const fwp_desc *);\n"
        + &helper
        + &code[end..];
    let code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
    let main = code.find("int main(").unwrap();
    let code = code[..main].to_string() + include_str!("fixtures/mapped_array_cleanup.c");
    for opt in ["-O1", "-O2"] {
        let binary = dir.join("probe.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        checked(&mut Command::new(&binary));
        let missing_scratch = code.replace(
            "    fwp_scratch_finish(&items, &cleanup);",
            "    fwp_cleanup_pop(&cleanup);",
        );
        let missing_input = code.replace("        fwp_rc_free_obj(source);", "");
        for (broken, expected) in [(missing_scratch, 231), (missing_input, 235)] {
            assert_ne!(broken, code);
            fwp::cgen::compile_c(&broken, &binary, opt).unwrap();
            assert_eq!(
                Command::new(&binary).status().unwrap().code(),
                Some(expected)
            );
        }
    }
}

#[test]
fn numeric_materialization_removes_list_nodes_without_retaining_inputs() {
    let dir = fwp::cgen::TempDir::new("mapped-array-counts").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(
        &input,
        "export transform : List[F64] -> Array[F64]\ntransform = map (mul 2.0) | array.from-list\n",
    )
    .unwrap();

    let mut measurements = Vec::new();
    for fused in ["0", "1"] {
        let cfile = dir.join("main.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_ARRAY_FUSION", fused)
                .args(["build", "--fn", "transform", "--emit-c"])
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
        let probe =
            include_str!("fixtures/mapped_array_counts.c").replace("fTRANSFORM", &format!("f{id}"));
        let source = source[..source.find("int main(").unwrap()].to_string();
        assert!(source.contains("static inline void *fwp_heap_alloc(size_t n, int kind) {"));
        assert!(source.contains("static inline void *fwp_alloc_init(size_t n) {"));
        let code = source.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t mapped_calls, mapped_bytes;")
                .replace("static inline void *fwp_heap_alloc(size_t n, int kind) {", "static inline void *fwp_heap_alloc(size_t n, int kind) {\nif(kind!=0){mapped_calls++;mapped_bytes+=n;}")
                .replace("static inline void *fwp_alloc_init(size_t n) {", "static inline void *fwp_alloc_init(size_t n) {\nmapped_calls++;mapped_bytes+=n;") + &probe;
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("counts.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let output = checked(&mut Command::new(&binary));
            let counts: Vec<u64> = String::from_utf8(output.stdout)
                .unwrap()
                .split_whitespace()
                .map(|s| s.parse().unwrap())
                .collect();
            assert_eq!(counts.len(), 12);
            measurements.push(counts);
        }
    }
    assert_eq!(measurements[0], measurements[1]);
    assert_eq!(measurements[2], measurements[3]);
    for (unfused, fused) in measurements[0]
        .as_chunks::<3>()
        .0
        .iter()
        .zip(measurements[2].as_chunks::<3>().0)
    {
        assert_eq!(unfused[0], fused[0]);
        assert!(
            unfused[1] >= fused[1] + fused[0],
            "counted: {unfused:?} vs {fused:?}"
        );
        assert!(unfused[2] >= fused[2] + 24 * fused[0]);
    }
}
