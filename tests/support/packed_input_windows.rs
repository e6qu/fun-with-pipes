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
    let source = scratch.0.join("values.fwp");
    std::fs::write(
        &source,
        format!(
            "{}\n{VALUE_CHECKS}",
            include_str!("../fixtures/packed_input_windows.fwp")
        ),
    )
    .unwrap();
    for (mode, arguments) in [
        ("raw", vec!["run", "--interp"]),
        ("optimized", vec!["run", "--interp"]),
        ("O1", vec!["run", "--memory", "dynamic", "-O1"]),
        ("O2", vec!["run", "--memory", "dynamic", "-O2"]),
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
        let output = checked(command.args(arguments).arg(&source));
        assert_eq!(output.stdout, b"True\n", "{mode}: {output:?}");
        assert!(output.stderr.is_empty(), "{mode}: {output:?}");
    }
}

#[test]
fn indexed_record_windows_release_every_owner_on_failure_and_cancellation() {
    let scratch = Scratch::new("packed-input-windows");
    for (entry, tail_offset) in [("transform", "0"), ("transform-reversed", "1")] {
        // Both exports are live roots even with --fn. Keep just the selected
        // export so each ownership probe observes exactly one pair of buffers.
        let other = if entry == "transform" {
            "transform-reversed"
        } else {
            "transform"
        };
        let fixture = scratch.0.join(format!("{entry}.fwp"));
        std::fs::write(
            &fixture,
            include_str!("../fixtures/packed_input_windows.fwp")
                .replace(&format!("export {other} :"), &format!("{other} :")),
        )
        .unwrap();
        let cfile = scratch.0.join(format!("{entry}.c"));
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
        let pairs = section(&emitted, "    /* Borrow overlapping windows;");
        let fold = section(&emitted, "    /* Fold after the complete packed map;");
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
                "    fwp_value_owner owner =",
                "    windows_pair_buffer = buffer;\n    fwp_value_owner owner =",
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
            "    return fwp_rc_fresh(fwp_record(",
            "    windows_fail_allocation = windows_mode == 9;\n    return fwp_rc_fresh(fwp_record(",
        );
        assert_ne!(input, input_control);
        assert_ne!(pairs, pair_control);
        assert_ne!(fold, fold_control);
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
        code += &include_str!("../fixtures/packed_input_windows.c")
            .replace("TRANSFORM", &format!("f{}", function_id(&emitted, entry)))
            .replace("TAIL_OFFSET", tail_offset)
            .replace("DROP_POINT", drop_name("Point"))
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
        for opt in ["-O1", "-O2"] {
            for (name, source, expected) in [
                ("complete", &code, 0),
                ("missing-input", &missing_input, 90),
                ("missing-pairs", &missing_pairs, 90),
                ("corrupt-input", &corrupt, 241),
            ] {
                let executable = scratch.0.join(format!("{entry}-{name}-{opt}.exe"));
                fwp::cgen::compile_c(source, &executable, opt).unwrap();
                let output = Command::new(&executable).output().unwrap();
                record_probe::save(
                    "packed_input_windows",
                    &format!("{entry}-{name}-{opt}"),
                    source,
                    &executable,
                    &output,
                );
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{name}/{opt}: {output:?}"
                );
            }
            let source = format!("#define FWP_NO_REUSE 1\n{code}");
            let executable = scratch.0.join(format!("{entry}-no-reuse-{opt}.exe"));
            fwp::cgen::compile_c(&source, &executable, opt).unwrap();
            let output = Command::new(&executable).output().unwrap();
            record_probe::save(
                "packed_input_windows",
                &format!("{entry}-no-reuse-{opt}"),
                &source,
                &executable,
                &output,
            );
            assert!(output.status.success(), "no-reuse/{opt}: {output:?}");
        }
    }
}
