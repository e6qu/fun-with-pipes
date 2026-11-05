//! Exercise the actual generated buffer owners, including failing observers.
use super::{checked, function_id, ownership_ledger, record_probe, Scratch};
use std::process::Command;

fn section<'a>(source: &'a str, marker: &str) -> &'a str {
    assert_eq!(source.matches(marker).count(), 1, "{marker}");
    let start = source.find(marker).unwrap();
    let end = start + source[start..].find("\n}\n").unwrap() + 3;
    &source[start..end]
}

const VALUE_CHECKS: &str = r#"
main = [
    (transform 0 10 7 (Point {index = 99, value = 5}) [] | both .index .value | eq (99, 5)),
    (transform 0 10 7 (Point {index = 99, value = 5}) [10] | both .index .value | eq (99, 5)),
    (transform 0 10 7 (Point {index = 99, value = 5}) [10, 20] | both .index .value | eq (0, 49)),
    (transform 0 10 7 (Point {index = 99, value = 5}) [10, 20, 30] | both .index .value | eq (1, 113)),
    (transform-reversed 0 10 7 (Point {index = 99, value = 5}) [10, 20, 30] | both .index .value | eq (2, 113)),
    (transform 0 1 7 (Point {index = 99, value = 5}) [10, 20, 30] | both .index .value | eq (99, 5)),
] | all id | echo
"#;

#[test]
fn packed_input_values_agree_with_both_interpreters_and_native_levels() {
    let scratch = Scratch::new("packed-input-values");
    let narrow_checks = VALUE_CHECKS
        .replace("both .index .value", ".value")
        .replace("eq (99, 5)", "eq 5")
        .replace("eq (0, 49)", "eq 49")
        .replace("eq (1, 113)", "eq 113")
        .replace("eq (2, 113)", "eq 113")
        .replace("Point {index = 99, value = 5}", "Total {value = 5}");
    for (layout, fixture, checks) in [
        (
            "equal",
            include_str!("../fixtures/packed_input_windows.fwp"),
            VALUE_CHECKS,
        ),
        (
            "narrow",
            include_str!("../fixtures/packed_input_narrow.fwp"),
            narrow_checks.as_str(),
        ),
    ] {
        let source = scratch.0.join(format!("values-{layout}.fwp"));
        std::fs::write(&source, format!("{fixture}\n{checks}")).unwrap();
        for (mode, arguments) in [
            ("raw", vec!["run", "--interp"]),
            ("optimized", vec!["run", "--interp"]),
            ("O1", vec!["build", "--memory", "dynamic", "-O1"]),
            ("O2", vec!["build", "--memory", "dynamic", "-O2"]),
        ] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command
                .env_remove("FWP_NO_OPT")
                .env("FWP_LTO", "0")
                .env("FWP_VRET", "1")
                .env("FWP_FRAME_FIELDS", "1")
                .env("FWP_PACKED_ARRAYS", "1")
                .env("FWP_STACK", "1");
            if mode == "raw" {
                command.env("FWP_NO_OPT", "1");
            }
            command.args(arguments).arg(&source);
            let output = if mode.starts_with('O') {
                let executable = scratch.0.join(format!("values-{layout}-{mode}.exe"));
                checked(command.arg("-o").arg(&executable));
                checked(&mut Command::new(executable))
            } else {
                checked(&mut command)
            };
            assert_eq!(output.stdout, b"True\n", "{mode}: {output:?}");
            assert!(output.stderr.is_empty(), "{mode}: {output:?}");
        }
    }
}

#[test]
fn indexed_record_windows_release_every_owner_on_failure_and_cancellation() {
    let scratch = Scratch::new("packed-input-windows");
    for (layout, result_type, result_width, fixture_source) in [
        (
            "equal",
            "Point",
            2,
            include_str!("../fixtures/packed_input_windows.fwp"),
        ),
        (
            "narrow",
            "Total",
            1,
            include_str!("../fixtures/packed_input_narrow.fwp"),
        ),
    ] {
        for (entry, tail_offset) in [("transform", "0"), ("transform-reversed", "1")] {
            // Both exports are live roots even with --fn. Keep just the selected
            // export so each ownership probe observes exactly one pair of buffers.
            let other = if entry == "transform" {
                "transform-reversed"
            } else {
                "transform"
            };
            let fixture = scratch.0.join(format!("{layout}-{entry}.fwp"));
            std::fs::write(
                &fixture,
                fixture_source.replace(&format!("export {other} :"), &format!("{other} :")),
            )
            .unwrap();
            let cfile = scratch.0.join(format!("{layout}-{entry}.c"));
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_VRET", "1")
                    .env("FWP_FRAME_FIELDS", "1")
                    .env("FWP_PACKED_ARRAYS", "1")
                    .env("FWP_STACK", "1")
                    .env("FWP_LTO", "0")
                    .args([
                        "build", "--fn", entry, "--memory", "dynamic", "--emit-c", "-O2",
                    ])
                    .arg(&fixture)
                    .arg("-o")
                    .arg(&cfile),
            );
            let emitted = std::fs::read_to_string(cfile).unwrap();
            assert!(emitted.contains("#define FWP_UNWIND 1"));
            assert!(emitted.contains("#define FWP_TASK_TICKS 1"));
            let input = section(&emitted, "    /* Finish indexed input records before");
            let pairs = section(&emitted, "    /* Consume private overlapping windows;");
            let fold = section(&emitted, "    /* Fold after the complete packed map;");
            assert_eq!(pairs.contains("V buffer = l0;"), result_width == 2);
            assert!(!pairs.contains("input.value = 0;"));
            assert_eq!(
                pairs.contains("return fwp_value_finish(&input, &input_cleanup);"),
                result_width == 2
            );
            if result_width == 2 {
                let allocating = pairs
                    .split("#ifdef FWP_NO_REUSE\n")
                    .nth(1)
                    .unwrap()
                    .split("#endif")
                    .next()
                    .unwrap();
                assert!(allocating.contains("fwp_value_protect(&owner, &cleanup);"));
                assert_eq!(
                    pairs
                        .matches("fwp_value_protect(&owner, &cleanup);")
                        .count(),
                    1
                );
            }
            assert!(!pairs.contains("fwp_rc_unique"));

            let input_control = input
                .replace(
                    "    V buffer =",
                    "    windows_fail_allocation = windows_mode == 7;\n    V buffer =",
                )
                .replace(
                    "    fwp_value_owner owner =",
                    "    windows_input_buffer = buffer;\n    fwp_value_owner owner =",
                )
                .replace(
                    "        V index =",
                    "        windows_phase = 1; windows_inputs++;\n        V index =",
                )
                .replace(
                    "    return fwp_value_finish",
                    "    windows_phase = 10;\n    return fwp_value_finish",
                );
            let pair_control = pairs
                .replace(
                    "    V buffer =",
                    "    windows_fail_allocation = windows_mode == 8;\n    V buffer =",
                )
                .replace(
                    "    for (size_t i = 0;",
                    "    windows_pair_buffer = buffer;\n    for (size_t i = 0;",
                )
                .replace(
                    "        fwp_wr",
                    "        windows_phase = 2; windows_pairs++;\n        fwp_wr",
                );
            let fold_control = fold
                .replace(
                    "        accumulator = w",
                    "        windows_phase = 3; windows_folds++;\n        accumulator = w",
                )
                .replace(
                    "    return (fwp_wr",
                    "    windows_fail_allocation = windows_mode == 9;\n    return (fwp_wr",
                );
            assert_ne!(input, input_control);
            assert_ne!(pairs, pair_control);
            // Observe either storage path before iteration, including empty input.
            assert_eq!(
                pair_control
                    .matches("windows_pair_buffer = buffer;")
                    .count(),
                1
            );
            assert_ne!(fold, fold_control);
            assert_eq!(
                fold_control
                    .matches("windows_fail_allocation = windows_mode == 9;")
                    .count(),
                1
            );
            let observed = ownership_ledger::instrument_native(&emitted, 256);
            let mut code = observed[..observed.find("int main(").unwrap()]
        .replace(input, &input_control).replace(pairs, &pair_control).replace(fold, &fold_control)
        .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int windows_mode, windows_phase, windows_inputs, windows_pairs, windows_folds, windows_fail_allocation;\nstatic V windows_input_buffer, windows_pair_buffer;\nstatic void fwp_trap(const char *);");
            for signature in [
                "static inline void *fwp_heap_alloc_observed_body(size_t n, int kind) {",
                "static inline void *fwp_alloc_init_observed_body(size_t n) {",
            ] {
                assert_eq!(code.matches(signature).count(), 1);
                code = code.replace(signature, &format!("{signature}\n    if(windows_fail_allocation) {{ windows_fail_allocation=0; fwp_trap(\"injected packed allocation failure\"); }}"));
            }
            let yielding = section(&code, "static V fwp_p_task_yield(void) {").to_owned();
            code = code.replace(
                &yielding,
                r#"static V fwp_p_task_yield(void) {
    if(windows_phase == 10 && windows_mode == 10) fwp_trap("injected between-stage failure");
    if(windows_phase == 1 && windows_inputs == 2) {
        if(windows_mode == 1) fwp_trap("injected input callback failure");
        if(windows_mode == 2) { fwp_cur->cancelled=1; fwp_check_cancel(); }
    }
    if(windows_phase == 2 && windows_pairs == 2) {
        if(windows_mode == 3) fwp_trap("injected pair callback failure");
        if(windows_mode == 4) { fwp_cur->cancelled=1; fwp_check_cancel(); }
    }
    if(windows_phase == 3 && windows_folds == 2) {
        if(windows_mode == 5) fwp_trap("injected fold callback failure");
        if(windows_mode == 6) { fwp_cur->cancelled=1; fwp_check_cancel(); }
    }
    return FWP_UNIT;
}
"#,
            );
            let drop_name = |ty: &str| {
                let start = emitted
                    .find(&format!("/* {ty} */\nstatic void fwp_drop"))
                    .unwrap();
                emitted[start..]
                    .split("static void ")
                    .nth(1)
                    .unwrap()
                    .split('(')
                    .next()
                    .unwrap()
            };
            code = format!("#define WINDOWS_RESULT_WIDTH {result_width}\n{code}");
            code += &include_str!("../fixtures/packed_input_windows.c")
                .replace("TRANSFORM", &format!("f{}", function_id(&emitted, entry)))
                .replace("TAIL_OFFSET", tail_offset)
                .replace("DROP_POINT", drop_name(result_type))
                .replace("DROP_LIST", drop_name("List[I64]"));
            let destroy = "static void fwp_rc_free_arr(V v) {";
            assert_eq!(code.matches(destroy).count(), 1);
            let missing_input = code.replace(
                destroy,
                &format!("{destroy}\n    if(v == windows_input_buffer) return;"),
            );
            let missing_pairs = code.replace(
                destroy,
                &format!("{destroy}\n    if(v == windows_pair_buffer) return;"),
            );
            let corrupt = code.replace(
                "windows_phase = 10;",
                "if(ARR(buffer)->len) ARR(buffer)->d[1] ^= 1; windows_phase = 10;",
            );
            assert_ne!(corrupt, code);
            let extra_allocation = code.replace(
            "size_t added = owner_ledger_allocations - allocations;",
            "V extra = fwp_rc_fresh(fwp_arr_new(0)); fwp_rc_free_arr(extra);\n            size_t added = owner_ledger_allocations - allocations;",
        );
            assert_ne!(extra_allocation, code);
            for opt in ["-O1", "-O2"] {
                for (name, source, expected) in [
                    ("complete", &code, 0),
                    ("missing-input", &missing_input, 90),
                    ("missing-pairs", &missing_pairs, 90),
                    ("corrupt-input", &corrupt, 241),
                    ("extra-allocation", &extra_allocation, 248),
                ] {
                    let executable = scratch.0.join(format!("{layout}-{entry}-{name}-{opt}.exe"));
                    fwp::cgen::compile_c(source, &executable, opt).unwrap();
                    let output = Command::new(&executable).output().unwrap();
                    record_probe::save(
                        "packed_input_windows",
                        &format!("{layout}-{entry}-{name}-{opt}"),
                        source,
                        &executable,
                        &output,
                    );
                    assert_eq!(
                        output.status.code(),
                        Some(expected),
                        "{name}/{opt}: {output:?}"
                    );
                    if name == "extra-allocation" {
                        let expected = if result_width == 2 {
                            "expected=2 actual=3"
                        } else {
                            "expected=3 actual=4"
                        };
                        assert!(String::from_utf8_lossy(&output.stderr).contains(expected));
                    } else {
                        assert!(output.stderr.is_empty(), "{name}/{opt}: {output:?}");
                    }
                }
                let source = format!("#define FWP_NO_REUSE 1\n{code}");
                let executable = scratch
                    .0
                    .join(format!("{layout}-{entry}-no-reuse-{opt}.exe"));
                fwp::cgen::compile_c(&source, &executable, opt).unwrap();
                let output = Command::new(&executable).output().unwrap();
                record_probe::save(
                    "packed_input_windows",
                    &format!("{layout}-{entry}-no-reuse-{opt}"),
                    &source,
                    &executable,
                    &output,
                );
                assert!(output.status.success(), "no-reuse/{opt}: {output:?}");
            }
        }
    }
}

#[test]
fn packed_input_windows_preserve_float_bits_in_both_orders() {
    let scratch = Scratch::new("packed-input-bits");
    for (name, scalar, width) in [("f64", "F64", 64), ("f32", "F32", 32)] {
        for reversed in [false, true] {
            let mut source =
                include_str!("../fixtures/packed_input_bits.fwp").replace("F64", scalar);
            if reversed {
                source = source.replace(
                    "pair-point (drop 1 records) records",
                    "pair-point records (drop 1 records)",
                );
            }
            let label = format!("{name}-reversed-{reversed}");
            let fixture = scratch.0.join(format!("{label}.fwp"));
            let cfile = scratch.0.join(format!("{label}.c"));
            std::fs::write(&fixture, source).unwrap();
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_VRET", "1")
                    .env("FWP_FRAME_FIELDS", "1")
                    .env("FWP_PACKED_ARRAYS", "1")
                    .env("FWP_STACK", "1")
                    .env("FWP_LTO", "0")
                    .args([
                        "build",
                        "--fn",
                        "transform",
                        "--memory",
                        "dynamic",
                        "--emit-c",
                        "-O2",
                    ])
                    .arg(&fixture)
                    .arg("-o")
                    .arg(&cfile),
            );
            let emitted = std::fs::read_to_string(cfile).unwrap();
            section(&emitted, "    /* Finish indexed input records before");
            section(&emitted, "    /* Consume private overlapping windows;");
            let observed = ownership_ledger::instrument_native(&emitted, 64);
            let prefix = &observed[..observed.find("int main(").unwrap()];
            let drop_start = emitted.find("/* Point */\nstatic void fwp_drop").unwrap();
            let drop_point = emitted[drop_start..]
                .split("static void ")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap();
            let probe = include_str!("../fixtures/packed_input_bits.c")
                .replace(
                    "TRANSFORM",
                    &format!("f{}", function_id(&emitted, "transform")),
                )
                .replace("DROP_POINT", drop_point)
                .replace("FLOAT_WIDTH", &width.to_string())
                .replace("SELECTED_INDEX", if reversed { "0" } else { "1" });
            let code = format!("{prefix}{probe}");
            for opt in ["-O1", "-O2"] {
                let executable = scratch.0.join(format!("{label}-{opt}.exe"));
                fwp::cgen::compile_c(&code, &executable, opt).unwrap();
                let output = Command::new(&executable).output().unwrap();
                record_probe::save(
                    "packed_input_bits",
                    &format!("{label}-{opt}"),
                    &code,
                    &executable,
                    &output,
                );
                assert!(output.status.success(), "{label}/{opt}: {output:?}");
            }
        }
    }
}

#[test]
fn single_field_input_buffers_agree_with_interpreters_and_native_levels() {
    let scratch = Scratch::new("packed-input-single-field");
    let source = scratch.0.join("single.fwp");
    std::fs::write(
        &source,
        include_str!("../fixtures/packed_input_single_field.fwp"),
    )
    .unwrap();
    for raw in [false, true] {
        let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
        command.env_remove("FWP_NO_OPT");
        if raw {
            command.env("FWP_NO_OPT", "1");
        }
        let output = checked(command.args(["run", "--interp"]).arg(&source));
        assert_eq!(output.stdout, b"True\n", "raw={raw}: {output:?}");
        assert!(output.stderr.is_empty(), "{output:?}");
    }
    let cfile = scratch.0.join("single.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .env("FWP_VRET", "1")
            .env("FWP_FRAME_FIELDS", "1")
            .env("FWP_PACKED_ARRAYS", "1")
            .env("FWP_STACK", "1")
            .env("FWP_LTO", "0")
            .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    assert!(emitted.contains("/* packed-indexed-records :"));
    assert!(emitted.contains("/* packed-neighbor-pairs :"));
    let code = ownership_ledger::instrument_native(&emitted, 128);
    for opt in ["-O1", "-O2"] {
        let executable = scratch.0.join(format!("single-{opt}.exe"));
        fwp::cgen::compile_c(&code, &executable, opt).unwrap();
        let output = Command::new(&executable).output().unwrap();
        record_probe::save(
            "packed_input_single_field",
            opt,
            &code,
            &executable,
            &output,
        );
        assert!(output.status.success(), "{opt}: {output:?}");
        assert_eq!(output.stdout, b"True\n", "{opt}: {output:?}");
        assert!(output.stderr.is_empty(), "{opt}: {output:?}");
    }
}
