//! Numeric array construction and display avoid temporary lists without changing behavior.
use std::process::{Command, Output};

#[path = "support/record_probe.rs"]
mod record_probe;

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn array_list_text_preserves_values_views_aliases_and_effect_order() {
    let directory = fwp::cgen::TempDir::new("array-list-text").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        ("values", include_str!("fixtures/array_text.fwp"), 0, true),
        ("effects", "main = array.generate 3 (tap echo) | array.to-list | echo\n", 0, true),
        ("trap", "main = array.generate 3 (if (eq 1) (const 1 | div 0) (tap echo)) | array.to-list | echo\n", 101, true),
        ("boxed", "main = [[\"a\", \"b\\n\"] | array.from-list | array.to-list | echo, [1.0000000000000000000000000000000002f128, -0.0f128] | array.from-list | array.to-list | echo] | ignore\n", 0, false),
    ];
    let mut failures = Vec::new();
    for (name, source, status, eligible) in cases {
        let input = directory.join(format!("{name}.fwp"));
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
        if name == "effects" {
            assert_eq!(reference.stdout, b"0\n1\n2\n[0, 1, 2]\n");
        }
        if name == "trap" {
            assert_eq!(reference.stdout, b"0\n");
            assert!(String::from_utf8_lossy(&reference.stderr).contains("division by zero"));
        }
        for fusion in ["0", "1"] {
            let interpreted = Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_ARRAY_FUSION", fusion)
                .args(["run", "--interp"])
                .arg(&input)
                .output()
                .unwrap();
            if (
                &interpreted.stdout,
                &interpreted.stderr,
                interpreted.status.code(),
            ) != (
                &reference.stdout,
                &reference.stderr,
                reference.status.code(),
            ) {
                failures.push(format!(
                    "{name}/fusion{fusion}/interpreter: {interpreted:?}"
                ));
            }
            for (packed, ownership) in [
                ("0", "arc"),
                ("0", "tracing"),
                ("1", "arc"),
                ("1", "tracing"),
            ] {
                let cfile = directory.join("program.c");
                checked(
                    Command::new(compiler)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_ARRAY_FUSION", fusion)
                        .env("FWP_PACKED_ARRAYS", packed)
                        .env("FWP_LTO", "0")
                        .args([
                            "build", "--gc", ownership, "--memory", "dynamic", "--emit-c", "-O2",
                        ])
                        .arg(&input)
                        .arg("-o")
                        .arg(&cfile),
                );
                let code = std::fs::read_to_string(cfile).unwrap();
                assert_eq!(
                    code.contains("fwp_show_array_list(l0,"),
                    eligible && fusion == "1",
                    "{name}/{ownership}/fusion{fusion}: expected display lowering"
                );
                for opt in ["-O1", "-O2"] {
                    let executable = directory.join("program.exe");
                    fwp::cgen::compile_c(&code, &executable, opt).unwrap();
                    let settings: &[&str] = if ownership == "arc" {
                        &["0"]
                    } else {
                        &["0", "1"]
                    };
                    for stress in settings {
                        let actual = Command::new(&executable)
                            .env("FWP_GC_STRESS", stress)
                            .env("FWP_GC_VERIFY", stress)
                            .env("FWP_REUSE_VERIFY", stress)
                            .output()
                            .unwrap();
                        record_probe::save(
                            "array_text",
                            &format!("{name}-fusion{fusion}-packed{packed}-{ownership}{opt}-stress{stress}"),
                            &code,
                            &executable,
                            &actual,
                        );
                        if (&actual.stdout, &actual.stderr, actual.status.code())
                            != (
                                &reference.stdout,
                                &reference.stderr,
                                reference.status.code(),
                            )
                        {
                            failures.push(format!("{name}/fusion{fusion}/{ownership}/{opt}/stress{stress}: {actual:?}"));
                        }
                    }
                }
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn array_text_counts_allocations_and_releases_every_iteration() {
    let directory = fwp::cgen::TempDir::new("array-text-counts").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let literal = (0..129)
        .map(|i| format!("{i}.0"))
        .collect::<Vec<_>>()
        .join(", ");
    let cases = [
        ("literal-show", format!("[{literal}] | array.from-list | array.to-list | echo"), 1),
        ("literal-json", format!("[{literal}] | array.from-list | array.to-list | json.write | echo"), 1),
        ("generated-show", "array.generate 129 int.to-float | array.to-list | echo".into(), 2),
        ("neighbor-fold", format!("[{literal}] | array.from-list | array.map (add 1.0) | array.fold add 0.0 | echo"), 1),
        ("neighbor-iterator", format!("[{literal}] | array.from-list | array.to-list | iter.from-list | iter.map (add 1.0) | iter.fold add 0.0 | echo"), 1),
    ];
    let mut failures = Vec::new();
    for (name, expression, expected) in cases {
        let input = directory.join("counts.fwp");
        std::fs::write(&input, format!("main = {expression}\n")).unwrap();
        let reference = checked(
            Command::new(compiler)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&input),
        );
        for fusion in ["0", "1"] {
            for packed in ["0", "1"] {
                let cfile = directory.join("counts.c");
                checked(
                    Command::new(compiler)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_ARRAY_FUSION", fusion)
                        .env("FWP_PACKED_ARRAYS", packed)
                        .env("FWP_LTO", "0")
                        .args([
                            "build", "--gc", "arc", "--memory", "dynamic", "--emit-c", "-O2",
                        ])
                        .arg(&input)
                        .arg("-o")
                        .arg(&cfile),
                );
                let mut code = std::fs::read_to_string(cfile).unwrap();
                let declarations = "typedef uint64_t V;";
                assert_eq!(code.matches(declarations).count(), 1);
                code = code.replace(declarations, &format!("{declarations}\nstatic size_t text_calls, text_raw_live;\nstatic int text_watch, text_bad;"));
                for (marker, increment) in [
                    (
                        "static inline void *fwp_gc_alloc(size_t n, int leaf) {",
                        "if(text_watch && leaf!=0) text_calls++;",
                    ),
                    (
                        "static inline void *fwp_alloc_init(size_t n) {",
                        "if(text_watch) text_calls++;",
                    ),
                ] {
                    assert_eq!(code.matches(marker).count(), 1);
                    code = code.replace(marker, &format!("{marker} {increment}"));
                }
                let grow = "        b->d = data;\n        b->cap = cap;";
                assert_eq!(code.matches(grow).count(), 1);
                code = code.replace(
                    grow,
                    &format!("        if(text_watch) text_raw_live += cap - b->cap;\n{grow}"),
                );
                let release = "    free(b->d);\n    return r;";
                assert_eq!(code.matches(release).count(), 1);
                code = code.replace(release, "    if(!text_watch || text_bad!=2) {\n        free(b->d);\n        if(text_watch) text_raw_live -= b->cap;\n    }\n    return r;");
                let drop = "static void fwp_rc_free_obj(V v) {";
                assert_eq!(code.matches(drop).count(), 1);
                code = code.replace(
                    drop,
                    &format!("{drop}\n    if(text_watch && text_bad==1)return;"),
                );
                let entry = "    V r = f0();";
                assert_eq!(code.matches(entry).count(), 1);
                let expectation = if fusion == "1" {
                    format!("text_calls!={expected}")
                } else {
                    // The ordinary literal/output list contains 129 nodes.
                    // Neighboring iterator fusion can already remove its output list.
                    "text_calls<129".into()
                };
                let loop_body = format!(
                    r#"    V r = FWP_UNIT;
    for(unsigned iteration=0;iteration<64;iteration++) {{
        intptr_t baseline=fwp_gc.budget;
        text_calls=0; text_watch=1;
        r=f0();
        text_watch=0;
        if({expectation}) {{ fprintf(stderr,"allocation requests: %zu\n",text_calls); _Exit(211); }}
        if(fwp_gc.budget!=baseline || fwp_gc.rc_wide_len || fwp_gc.ncollect) _Exit(212);
        if(text_raw_live) _Exit(213);
    }}
    fprintf(stderr,"managed requests per iteration: %zu; retained managed/raw bytes: 0\n",text_calls);"#
                );
                code = code.replace(entry, &loop_body);
                // Both omission controls must fail the balance checks, even
                // though they leave the printed values unchanged.
                let controls: &[(&str, i32, i32)] = if name == "literal-show" && fusion == "1" {
                    &[
                        ("balanced", 0, 0),
                        ("missing-managed-release", 1, 212),
                        ("missing-buffer-free", 2, 213),
                    ]
                } else {
                    &[("balanced", 0, 0)]
                };
                for opt in ["-O1", "-O2"] {
                    for (control, fault, status) in controls {
                        let candidate = code.replace(
                            "text_calls=0; text_watch=1;",
                            &format!("text_bad={fault}; text_calls=0; text_watch=1;"),
                        );
                        let executable = directory.join("counts.exe");
                        fwp::cgen::compile_c(&candidate, &executable, opt).unwrap();
                        let actual = Command::new(&executable)
                            .env("FWP_GC_STRESS", "0")
                            .env("FWP_GC_VERIFY", "0")
                            .env("FWP_REUSE_VERIFY", "0")
                            .output()
                            .unwrap();
                        let label = format!("{name}-fusion{fusion}-packed{packed}{opt}-{control}");
                        record_probe::save("array_text", &label, &candidate, &executable, &actual);
                        if actual.status.code() != Some(*status)
                            || (*status == 0 && actual.stdout != reference.stdout.repeat(64))
                        {
                            failures.push(format!("{label}: {actual:?}"));
                        }
                    }
                }
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}
