//! Checked WASI ownership must reclaim storage and reject unproved retention.
#![cfg(any(target_os = "linux", target_os = "macos"))]
use std::path::Path;
use std::process::{Command, Output};

#[path = "support/parser_region_probe.rs"]
mod parser_region_probe;

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn available() -> bool {
    let dir = fwp::cgen::TempDir::new("wasi-arc-toolchain").unwrap();
    let source = dir.join("probe.c");
    std::fs::write(&source, "int main(void){return 0;}\n").unwrap();
    let cc = std::env::var("FWP_WASM_CC").unwrap_or_else(|_| "clang".into());
    let compiler = Command::new(&cc)
        .arg("--target=wasm32-wasi")
        .arg(source)
        .arg("-o")
        .arg(dir.join("probe.wasm"))
        .output();
    let node = Command::new("node").arg("--version").output();
    let ready = compiler.as_ref().is_ok_and(|o| o.status.success())
        && node.as_ref().is_ok_and(|o| o.status.success());
    let diagnostic = |output: &std::io::Result<Output>| match output {
        Ok(output) => format!(
            "{}: {}",
            output.status,
            String::from_utf8_lossy(&output.stderr)
        ),
        Err(error) => error.to_string(),
    };
    assert!(
        ready || std::env::var_os("FWP_REQUIRE_WASI_ARC").is_none(),
        "required WASI ARC toolchain unavailable; {cc}: {}; node: {}",
        diagnostic(&compiler),
        diagnostic(&node)
    );
    if !ready {
        eprintln!(
            "skipping actual WASI ARC; {cc}: {}; node: {}",
            diagnostic(&compiler),
            diagnostic(&node)
        );
    }
    ready
}
fn wasi(binary: &Path, root: &Path) -> Command {
    let mut command = Command::new("node");
    command
        .arg("--no-warnings")
        .arg(Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/wasm/wasi-run.mjs"))
        .arg(binary)
        .current_dir(root);
    command
}
fn emit(source: &Path, cfile: &Path, entry: &[&str], target: &str) -> String {
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--target", target, "--emit-c"])
            .args(entry)
            .arg(source)
            .arg("-o")
            .arg(cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    assert!(!code.contains("FWP_ARC_ONLY"));
    assert!(!code.contains("fwp_heap_collect("));
    code
}

#[test]
fn wasi_return_state_table_checks_growth_allocation_and_identifiers() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-return-state").unwrap();
    let tail = r#"
int main(void) {
    uint32_t capacity = PROBE_CASE == 5 ? 0 : 2;
    uintptr_t saved[10] = {0};
    fwp_sj_entry *table = calloc(capacity + 1, sizeof *table);
    if (!table) return 218;
    if (PROBE_CASE == 2) fwp_setjmp_id = UINTPTR_MAX;
    for (uint32_t i = 0; i < 10; i++) {
        table = saveSetjmp(&saved[i], i + 1, table, capacity);
        capacity = getTempRet0();
        if (!saved[i] || table[i + 1].id) return 218;
        for (uint32_t j = 0; j <= i; j++)
            if (testSetjmp(saved[j], table, capacity) != j + 1) return 218;
    }
    if (PROBE_CASE) return 219; /* every failure case must stop in the helper */
    if (capacity != 16 || probe_reallocations != 3) return 218;
    free(table);
    puts("return states preserved");
    return 0;
}
"#;
    for (case, diagnostic) in [
        (0, ""),
        (1, "cannot grow WebAssembly return-state table"),
        (2, "WebAssembly return-state identifiers exhausted"),
        (3, "WebAssembly return-state table too large"),
        (4, "WebAssembly return-state table too large"),
        (5, "WebAssembly return-state table too large"),
    ] {
        let source = format!(
            "#define PROBE_CASE {case}\n{}\n{}\n{tail}",
            include_str!("fixtures/wasm_return_state.c"),
            include_str!("../runtime/wasm/sjlj.c")
        );
        for opt in ["-O1", "-O2"] {
            let label = format!("return-state-{case}{opt}");
            let binary = dir.join(format!("{label}.wasm"));
            fwp::cgen::compile_for(&source, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
            let output = wasi(&binary, dir.path()).output().unwrap();
            if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                std::fs::write(path.join(format!("{label}.c")), &source).unwrap();
                std::fs::copy(&binary, path.join(format!("{label}.wasm"))).unwrap();
                std::fs::write(path.join(format!("{label}.stdout")), &output.stdout).unwrap();
                std::fs::write(path.join(format!("{label}.stderr")), &output.stderr).unwrap();
            }
            assert_eq!(
                output.status.code(),
                Some(if case == 0 { 0 } else { 217 }),
                "{label}: {output:?}"
            );
            if case == 0 {
                assert_eq!(output.stdout, b"return states preserved\n");
                assert!(output.stderr.is_empty());
            } else {
                assert!(output.stdout.is_empty());
                assert_eq!(
                    String::from_utf8_lossy(&output.stderr),
                    format!("fwp: {diagnostic}\n")
                );
            }
        }
    }
}

fn allocator_source(source: &Path, cfile: &Path) -> String {
    let code = emit(source, cfile, &[], "wasm32-wasi")
        .replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
    let fixture = include_str!("fixtures/wasm_arc_counts.c");
    let split = fixture.find("static int wasm_arc_recover").unwrap();
    format!(
        "#include <stdlib.h>\n{}\n#define free wasm_arc_observe_free\n{}{}",
        &fixture[..split],
        &code[..code.find("int main(").unwrap()],
        &fixture[split..]
    )
}

#[test]
fn wasi_range_sets_check_32_bit_storage_before_allocation() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-range-set-limit").unwrap();
    let source = dir.join("main.fwp");
    for bounds in ["0 536870912", "0u64 18446744073709551615u64"] {
        std::fs::write(
            &source,
            format!("main = range {bounds} | set.from-list | set.size | echo\n"),
        )
        .unwrap();
        let code = emit(&source, &dir.join("main.c"), &[], "wasm32-wasi");
        assert!(code.contains("return fwp_p_set_range(l0, l1,"));
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("limit.wasm");
            fwp::cgen::compile_for(&code, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
            let result = wasi(&binary, dir.path()).output().unwrap();
            assert_eq!(
                result.status.code(),
                Some(101),
                "{bounds}/{opt}: {result:?}"
            );
            assert!(result.stdout.is_empty());
            assert!(
                String::from_utf8_lossy(&result.stderr).contains("map too large"),
                "{result:?}"
            );
        }
    }
}

#[test]
fn wasi_allocator_frees_graphs_and_rejects_escaped_counts() {
    let actual_wasi = available();
    let dir = fwp::cgen::TempDir::new("wasi-arc-counts").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, "main = 42 | echo\n").unwrap();
    let code = allocator_source(&source, &dir.join("main.c"));
    let missing_free = code.replace("    free((void *)(uintptr_t)value);", "    (void)value;");
    let missing_guard=code.replace("    if (entry && fwp_wasm_count(entry))\n        fwp_trap(\"internal: counted owner escaped ARC contract\");","    (void)entry;");
    assert_ne!(missing_free, code);
    assert_ne!(missing_guard, code);
    for target in [fwp::cgen::Target::Native, fwp::cgen::Target::Wasi] {
        if target == fwp::cgen::Target::Wasi && !actual_wasi {
            continue;
        }
        let binary = dir.join(if target == fwp::cgen::Target::Wasi {
            "probe.wasm"
        } else {
            "probe.exe"
        });
        for opt in ["-O1", "-O2"] {
            for (candidate, status) in [(&code, 0), (&missing_free, 237), (&missing_guard, 239)] {
                let text = if target == fwp::cgen::Target::Native {
                    format!("#define __wasm__ 1\n{candidate}")
                } else {
                    candidate.clone()
                };
                fwp::cgen::compile_for(&text, &binary, opt, target).unwrap();
                let command = || {
                    if target == fwp::cgen::Target::Wasi {
                        wasi(&binary, dir.path())
                    } else {
                        Command::new(&binary)
                    }
                };
                let result = command().output().unwrap();
                assert_eq!(result.status.code(), Some(status), "{opt}: {result:?}");
            }
        }
    }
}

#[test]
fn wasi_arc_rejects_unproved_entries_and_native_library_flags() {
    let dir = fwp::cgen::TempDir::new("wasi-arc-reject").unwrap();
    let source = dir.join("main.fwp");
    for (program, extra, reason) in [
        (
            "main = 42 | echo\n",
            vec!["--staticlib"],
            "require a native target",
        ),
        (
            "main = 42 | echo\n",
            vec!["--cdylib"],
            "require a native target",
        ),
    ] {
        std::fs::write(&source, program).unwrap();
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--target", "wasm32-wasi", "--emit-c"])
            .args(extra)
            .arg(&source)
            .arg("-o")
            .arg(dir.join("rejected.c"))
            .output()
            .unwrap();
        assert!(!output.status.success());
        assert!(
            String::from_utf8_lossy(&output.stderr).contains(reason),
            "{output:?}"
        );
    }
}

#[test]
fn synchronous_wasi_programs_match_interpretation_and_free_physical_storage() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-arc-programs").unwrap();
    std::fs::write(dir.join("input.txt"), "owned UTF-8: λ\n").unwrap();
    let text_transforms = format!(
        "{}\nmain = range 0 8 | each (show | concat \" AbC, λ. \" | check-text)\n",
        include_str!("fixtures/text_transform_ownership.fwp")
            .split_once("main =")
            .unwrap()
            .0,
    );
    let string_maps = format!(
        "{}\nmain = [\"\", \"One TWO ,Three. λ\", \"AbC abc AbC\", \"A\\tB\\nC\", \"One TWO STOP Four\"] | each (tap (words | check) | words | map normalize | echo)\n",
        include_str!("fixtures/string_map_ownership.fwp")
            .split_once("main =")
            .unwrap()
            .0,
    );
    let programs = [
        ("lists", "main = range 0 64 | map (const [1, 2, 3] | scan add 0 | repeat 4 | flatten | chunks 3 | flatten | sum) | sum | echo\n"),
        ("closures", r#"
choose : I64 -> (String -> String)
choose = if (rem 2 | eq 0)
    (rem 8 | add 1 | flip string.repeat "x" | concat)
    (rem 8 | add 1 | flip string.repeat "y" | flip concat)
checks : (String -> String) -> (String, String, String)
checks = make { 0 = apply "A", 1 = apply "B", 2 = apply "C" }
main = range 0 129 | map (choose | checks) | length | echo
"#),
        ("text", "main = range 0 64 | map (const \"input.txt\" | file.read) | map string.length | sum | echo\n"),
        ("file-errors", "main = range 0 64 | map (const \"missing.txt\" | attempt file.read) | length | echo\n"),
        ("callback-errors", r#"
step : I64 -> String ! {Error[String]}
step = if (eq 2) (const "stop" | fail) show
main = range 0 64 | map (const [1, 2, 3] | attempt (map step)) | length | echo
"#),
        ("nested-derivatives", r#"
square : List[t] -> t where Ring[t], Dup[t]
square = head | option.unwrap-or zero | fork mul id id
main = range 0 32 | map int.to-float | grad (grad square | sum) | sum | echo
"#),
        ("compact-sets", include_str!("fixtures/compact_sets.fwp")),
        ("hashes", include_str!("fixtures/hash_values.fwp")),
        ("numeric-hashes", include_str!("fixtures/numeric_hashes.fwp")),
        ("integer-output", include_str!("fixtures/integer_output.fwp")),
        ("queued-functions", include_str!("fixtures/queued_functions.fwp")),
        ("handled-callbacks", include_str!("fixtures/handled_callbacks.fwp")),
        ("hash-fusion", include_str!("fixtures/hash_fusion.fwp")),
        ("hash-borrowed-fields", include_str!("fixtures/hash_borrowed_fields.fwp")),
        ("range-arrays", include_str!("fixtures/range_arrays.fwp")),
        ("range-sets", include_str!("fixtures/range_sets.fwp")),
        ("vectors", include_str!("fixtures/vector_ownership.fwp")),
        ("ternary", include_str!("fixtures/ternary_ownership.fwp")),
        ("text-decoders", include_str!("fixtures/text_decoder_ownership.fwp")),
        ("text-transforms", text_transforms.as_str()),
        ("string-maps", string_maps.as_str()),
        ("count-boundaries", include_str!("fixtures/count_boundaries.fwp")),
        ("metrics", include_str!("fixtures/metrics_ownership.fwp")),
        ("cpu-kernels", include_str!("fixtures/cpu_kernel_ownership.fwp")),
        ("mixed-tail-recursion", include_str!("fixtures/mixed_tail_recursion.fwp")),
        ("fresh-numerics", r#"
main = [
    range 0 16 | map (const [1u128, 340282366920938463463374607431768211455u128] | map (checked.add 1u128)) | echo,
    range 0 16 | map (const [1i128, -2i128] | map (checked.mul 3i128)) | echo,
    [0.25f128, 1.5f128, 2.0f128] | map (add 0.25f128) | echo,
] | ignore
"#),
        ("derivatives", "main = range 0 16 | map (const (range 0 32 | map int.to-float) | vjp (map (mul 2.0)) (repeat 32 1.0) | sum) | sum | echo\n"),
    ];
    for (name, program) in programs {
        let source = dir.join(format!("{name}.fwp"));
        let reference_program = if name == "mixed-tail-recursion" {
            program.replace("200000", "20").replace("200001", "21")
        } else {
            program.to_string()
        };
        std::fs::write(&source, reference_program).unwrap();
        let reference = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["run", "--interp"])
                .env("FWP_NO_OPT", "1")
                .arg(&source)
                .current_dir(dir.path()),
        );
        std::fs::write(&source, program).unwrap();
        let code = emit(&source, &dir.join("program.c"), &[], "wasm32-wasi");
        if name == "string-maps" {
            assert!(code.contains("fwp_k_map_strings_owned(fwp_owned_entry"));
            assert!(String::from_utf8_lossy(&reference.stdout).contains("Err \"map stopped\""));
        }
        let instrumented = measured_program(&code);
        let needle = "    free((void *)(uintptr_t)value);";
        assert_eq!(instrumented.matches(needle).count(), 1);
        let omitted = instrumented.replace(needle, "    (void)value;");
        let missing_shutdown = instrumented.replace("if (atexit(fwp_tape_finish))", "if (0)");
        let missing_metrics_shutdown =
            instrumented.replace("if (atexit(fwp_metrics_finish))", "if (0)");
        let unclaimed = instrumented.replace(
            "#if FWP_NATIVE_HEAP\n        if (!c) return;\n#endif",
            "        if (!c) return;",
        );
        let mut candidates = vec![(&instrumented, 0), (&omitted, 244)];
        if matches!(name, "hash-fusion" | "fresh-numerics") {
            assert_ne!(unclaimed, instrumented);
            candidates.push((&unclaimed, 244));
        }
        if name.contains("derivatives") {
            assert_ne!(missing_shutdown, instrumented);
            candidates.push((&missing_shutdown, 244));
        }
        if name == "metrics" {
            assert_ne!(missing_metrics_shutdown, instrumented);
            candidates.push((&missing_metrics_shutdown, 244));
        }
        let levels = if matches!(name, "mixed-tail-recursion" | "string-maps") {
            ["-O0", "-O2"]
        } else {
            ["-O1", "-O2"]
        };
        for opt in levels {
            for &(candidate, expected) in &candidates {
                let binary = dir.join("program.wasm");
                fwp::cgen::compile_for(
                    &format!(
                        "{}\n{candidate}",
                        include_str!("fixtures/wasm_arc_allocations.c")
                    ),
                    &binary,
                    opt,
                    fwp::cgen::Target::Wasi,
                )
                .unwrap();
                if expected == 0 && name != "string-maps" {
                    if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        std::fs::write(
                            path.join(format!("{name}{opt}.c")),
                            format!(
                                "{}\n{candidate}",
                                include_str!("fixtures/wasm_arc_allocations.c")
                            ),
                        )
                        .unwrap();
                        std::fs::copy(&binary, path.join(format!("{name}{opt}.wasm"))).unwrap();
                    }
                }
                let output = wasi(&binary, dir.path()).output().unwrap();
                if name == "string-maps" {
                    if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        let label = if expected == 0 {
                            "checked"
                        } else {
                            "missing-free"
                        };
                        let stem = format!("{name}{opt}-{label}");
                        std::fs::write(
                            path.join(format!("{stem}.c")),
                            format!(
                                "{}\n{candidate}",
                                include_str!("fixtures/wasm_arc_allocations.c")
                            ),
                        )
                        .unwrap();
                        std::fs::copy(&binary, path.join(format!("{stem}.wasm"))).unwrap();
                        std::fs::write(path.join(format!("{stem}.stdout")), &output.stdout)
                            .unwrap();
                        std::fs::write(path.join(format!("{stem}.reference")), &reference.stdout)
                            .unwrap();
                        std::fs::write(
                            path.join(format!("{stem}.status")),
                            format!("{}\n", output.status.code().unwrap_or(-1)),
                        )
                        .unwrap();
                    }
                }
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{name}, {opt}: {output:?}"
                );
                if expected == 0 {
                    assert_eq!(output.stdout, reference.stdout, "{name}, {opt}");
                }
            }
        }
    }
}

#[test]
fn synchronous_wasi_vector_lane_counts_do_not_narrow_before_validation() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-vector-counts").unwrap();
    for (name, program, signature) in [
        ("splat", "wide : I64 -> Vec[4294967296, I64]\nwide = simd.splat\nmain = read-all () | string.length | wide | simd.to-array | array.length | echo\n", "static V fwp_p_simd_splat(V x, uint64_t n,"),
        ("from-array", "wide : Array[I64] -> Option[Vec[4294967296, I64]]\nwide = simd.from-array\nmain = read-all () | words | map string.length | array.from-list | wide | option.is-none | echo\n", "static V fwp_p_simd_from_array(V a, uint64_t n,"),
    ] {
        let source = dir.join("lanes.fwp");
        std::fs::write(&source, program).unwrap();
        let code = emit(&source, &dir.join("lanes.c"), &[], "wasm32-wasi");
        assert_eq!(code.matches(signature).count(), 1);
        let narrowed = code.replace(signature, &signature.replace("uint64_t n", "size_t n"));
        for opt in ["-O1", "-O2"] {
            for (label, candidate) in [("checked", &code), ("narrowed", &narrowed)] {
                let binary = dir.join("lanes.wasm");
                fwp::cgen::compile_for(candidate, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
                let output = wasi(&binary, dir.path()).output().unwrap();
                let (status, stdout, stderr) = match (name, label) {
                    ("splat", "checked") => (101, "", "fwp: trap: array too large\n"),
                    ("splat", "narrowed") => (0, "0\n", ""),
                    ("from-array", "checked") => (0, "True\n", ""),
                    ("from-array", "narrowed") => (0, "False\n", ""),
                    _ => unreachable!(),
                };
                assert_eq!(output.status.code(), Some(status), "{name} {label} {opt}: {output:?}");
                assert_eq!(output.stdout, stdout.as_bytes());
                assert_eq!(output.stderr, stderr.as_bytes());
                if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let stem = format!("lane-count-{name}-{label}{opt}");
                    std::fs::write(path.join(format!("{stem}.c")), candidate).unwrap();
                    std::fs::copy(&binary, path.join(format!("{stem}.wasm"))).unwrap();
                }
            }
        }
    }
}

fn measured_program(code: &str) -> String {
    let start = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    let finish = start + code[start..].find("\n}\n").unwrap() + 3;
    let thread = &code[start..finish];
    let begin = "    fwp_init_consts();\n";
    assert_eq!(thread.matches(begin).count(), 1);
    // Register before program work. Later runtime atexit hooks, including the
    // bounded autodiff workspace, must run first without test-forced cleanup.
    let observer = r#"
static size_t wasm_arc_base_live, wasm_arc_base_bytes, wasm_arc_base_counts;
static void wasm_arc_check_shutdown(void) {
    if (wasm_arc_live > wasm_arc_base_live || wasm_arc_bytes > wasm_arc_base_bytes ||
        fwp_wasm_counts_live > wasm_arc_base_counts) {
        fprintf(stderr, "unreleased: %zu/%zu allocations, %zu/%zu bytes, %zu/%zu counts\n",
            wasm_arc_live, wasm_arc_base_live, wasm_arc_bytes, wasm_arc_base_bytes,
            fwp_wasm_counts_live, wasm_arc_base_counts);
        unsigned shown = 0;
        for (size_t i = 0; i < 16384 && shown < 32; i++) {
            if (!wasm_arc_storage[i].address) continue;
            fprintf(stderr, "live allocation: %zu bytes at C line %u, output phase %u\n",
                wasm_arc_storage[i].bytes, wasm_arc_storage[i].line, wasm_arc_storage[i].phase);
            shown++;
        }
        _Exit(244);
    }
}
"#;
    let measured = thread.replace(begin, &format!("{begin}    wasm_arc_base_live = wasm_arc_live; wasm_arc_base_bytes = wasm_arc_bytes; wasm_arc_base_counts = fwp_wasm_counts_live;\n    if (atexit(wasm_arc_check_shutdown)) _Exit(245);\n"));
    let mut result = code.to_owned();
    result.replace_range(start..finish, &format!("{observer}\n{measured}"));
    for print in [
        "static V fwp_p_print(V s) {",
        "static V fwp_print_integer(V value, int is_signed) {",
    ] {
        assert_eq!(result.matches(print).count(), 1);
        result = result.replace(print, &format!("{print} wasm_arc_phase++;"));
    }
    result
}

#[test]
fn wasi_function_and_cli_entries_reclaim_inputs_and_results() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-arc-entries").unwrap();
    let source = dir.join("commands.fwp");
    std::fs::write(
        &source,
        "# expose: cli\nexport repeat-text : I64 -> String -> String\nrepeat-text = string.repeat\n",
    )
    .unwrap();
    for cli in [false, true] {
        let entry = if cli {
            vec!["--cli"]
        } else {
            vec!["--fn", "repeat-text"]
        };
        let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
        command.args(["exec", "--interp"]).env("FWP_NO_OPT", "1");
        if cli {
            command.arg("--cli");
        }
        command.arg(&source).arg("repeat-text").args(["32", "λ"]);
        let reference = checked(&mut command);
        let code = measured_program(&emit(&source, &dir.join("entry.c"), &entry, "wasm32-wasi"));
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("entry.wasm");
            fwp::cgen::compile_for(
                &format!(
                    "{}\n{code}",
                    include_str!("fixtures/wasm_arc_allocations.c")
                ),
                &binary,
                opt,
                fwp::cgen::Target::Wasi,
            )
            .unwrap();
            let mut command = wasi(&binary, dir.path());
            if cli {
                command.arg("repeat-text");
            }
            let output = checked(command.args(["32", "λ"]));
            assert_eq!(output.stdout, reference.stdout, "cli={cli}, {opt}");
            let symbols = checked(Command::new("wasm-objdump").arg("--details").arg(&binary));
            let symbols = String::from_utf8_lossy(&symbols.stdout);
            assert!(
                symbols.contains("<_start>") && symbols.contains("<fwp_"),
                "module symbols missing: {symbols}"
            );
            for collector in ["fwp_heap_scan", "fwp_heap_mark_all", "fwp_heap_sweep"] {
                assert!(
                    !symbols.contains(collector),
                    "WASI ARC contains {collector}"
                );
            }
            if opt == "-O2" {
                if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let name = if cli { "cli" } else { "function" };
                    std::fs::copy(&binary, path.join(format!("{name}.wasm"))).unwrap();
                    std::fs::write(path.join(format!("{name}.symbols")), symbols.as_bytes())
                        .unwrap();
                }
            }
        }
    }
}

#[test]
fn wasi_hash_borrows_values_without_allocating() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-hash-counts").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, "main = 1.0f128 | echo\n").unwrap();
    let code = emit(&source, &dir.join("hash.c"), &[], "wasm32-wasi");
    let code = &code[..code.find("int main(").unwrap()];
    let old=code.replace("return fwp_hash_value(0xcbf29ce484222325ULL, v, d);",
        "fwp_buf b={0};fwp_encode(&b,v,d);uint64_t h=0xcbf29ce484222325ULL;for(size_t i=0;i<b.len;i++){h^=(unsigned char)b.d[i];h*=0x100000001b3ULL;}free(b.d);return h;");
    assert_ne!(code, old);
    for opt in ["-O1", "-O2"] {
        for (candidate, expected) in [(code, 0), (old.as_str(), 247)] {
            let binary = dir.join("hash.wasm");
            fwp::cgen::compile_for(
                &format!(
                    "{}\n{candidate}\n{}",
                    include_str!("fixtures/hash_observer.c"),
                    include_str!("fixtures/hash_counts.c")
                ),
                &binary,
                opt,
                fwp::cgen::Target::Wasi,
            )
            .unwrap();
            let output = wasi(&binary, dir.path()).output().unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
    }
}

#[test]
fn wasi_range_array_rejects_length_before_32_bit_truncation() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-range-limit").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(
        &source,
        "main = range 0 4294967296 | array.from-list | array.length | echo\n",
    )
    .unwrap();
    let code = emit(&source, &dir.join("main.c"), &[], "wasm32-wasi");
    assert!(code.contains("return fwp_p_array_range(l0, l1,"));
    let guard =
        "    if (count > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap(\"array too large\");";
    let start = code.find("static V fwp_p_array_range(").unwrap();
    let end = start + code[start..].find("\n}").unwrap() + 2;
    assert_eq!(code[start..end].matches(guard).count(), 1);
    let mut truncated = code.clone();
    truncated.replace_range(
        start..end,
        &code[start..end].replace(guard, "    /* omitted length guard */"),
    );
    for opt in ["-O1", "-O2"] {
        for (candidate, expected) in [(&code, 101), (&truncated, 0)] {
            let binary = dir.join("main.wasm");
            fwp::cgen::compile_for(candidate, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
            let actual = wasi(&binary, dir.path()).output().unwrap();
            assert_eq!(actual.status.code(), Some(expected), "{opt}: {actual:?}");
            if expected == 101 {
                assert!(String::from_utf8_lossy(&actual.stderr).contains("array too large"));
            } else {
                assert_eq!(actual.stdout, b"0\n");
            }
        }
    }
}

#[test]
fn wasi_cpu_kernel_final_reduction_block_does_not_wrap() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-kernel-final-block").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, "main = ()\n").unwrap();
    let code = emit(&input, &dir.join("main.c"), &[], "wasm32-wasi");
    let probe = r#"
int main(void) {
    const int64_t code[] = {FWP_K_CONST};
    const V constants[] = {fwp_from_f64(2.5)};
    const fwp_kernel kernel = {.code=code, .ncode=1, .consts=constants, .depth=1};
    double sum = 0;
    fwp_kernel_sums(&kernel,SIZE_MAX,SIZE_MAX/FWP_KBLOCK,1,&sum);
    return sum == (FWP_KBLOCK-1)*2.5 ? 0 : 247;
}
"#;
    let code = code[..code.find("int main(").unwrap()].to_string() + probe;
    let end = "start + (n - start < FWP_KBLOCK ? n - start : FWP_KBLOCK)";
    assert_eq!(code.matches(end).count(), 1);
    let wrapped = code.replace(end, "start + FWP_KBLOCK < n ? start + FWP_KBLOCK : n");
    for opt in ["-O1", "-O2"] {
        for (candidate, expected) in [(&code, 0), (&wrapped, 247)] {
            let binary = dir.join("last-block.wasm");
            fwp::cgen::compile_for(candidate, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
            let output = wasi(&binary, dir.path()).output().unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
    }
}

#[test]
fn wasi_cpu_kernels_check_counts_before_32_bit_truncation() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-cpu-count").unwrap();
    for (operation, signature, guard, message) in [
        (
            "run",
            "static V fwp_p_device_run(",
            "if (count > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap(\"array too large\");",
            "array too large",
        ),
        (
            "sum",
            "static V fwp_p_device_sum(",
            "if (count > SIZE_MAX) fwp_trap(\"device: kernel too large\");",
            "device: kernel too large",
        ),
    ] {
        let input = dir.join("main.fwp");
        std::fs::write(&input,format!("main = device.{operation} 1 4294967296 ([1] | array.from-list) ([2.5] | array.from-list) [] | {} | echo\n",if operation=="run" {"array.length"}else{"id"})).unwrap();
        let code = emit(&input, &dir.join("main.c"), &[], "wasm32-wasi");
        let start = code.find(signature).unwrap();
        let end = start + code[start..].find("\n}").unwrap() + 2;
        assert_eq!(code[start..end].matches(guard).count(), 1);
        let mut truncated = code.clone();
        truncated.replace_range(
            start..end,
            &code[start..end].replace(guard, "/* omitted count check */"),
        );
        for opt in ["-O1", "-O2"] {
            for (candidate, expected) in [(&code, 101), (&truncated, 0)] {
                let binary = dir.join("main.wasm");
                fwp::cgen::compile_for(candidate, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
                let output = wasi(&binary, dir.path()).output().unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{operation}/{opt}: {output:?}"
                );
                if expected == 101 {
                    assert!(String::from_utf8_lossy(&output.stderr).contains(message));
                } else {
                    assert_eq!(
                        output.stdout,
                        if operation == "run" {
                            b"0\n".as_slice()
                        } else {
                            b"0.0\n".as_slice()
                        }
                    );
                }
            }
        }
    }
}

#[test]
fn wasi_cpu_kernels_reject_invalid_workers_before_kernel_validation() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-kernel-workers").unwrap();
    for operation in ["run", "sum"] {
        for threads in [0, 257] {
            let input = dir.join("workers.fwp");
            // Malformed code and empty output must not mask an invalid setting.
            let output = if operation == "run" {
                "array.length"
            } else {
                "id"
            };
            std::fs::write(&input, format!("main = device.{operation} {threads} 0 ([99] | array.from-list) ([] | array.from-list) [] | {output} | echo\n")).unwrap();
            let code = emit(&input, &dir.join("workers.c"), &[], "wasm32-wasi");
            for opt in ["-O1", "-O2"] {
                let binary = dir.join("workers.wasm");
                fwp::cgen::compile_for(&code, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
                let actual = wasi(&binary, dir.path()).output().unwrap();
                assert_eq!(
                    actual.status.code(),
                    Some(101),
                    "{operation}/{threads}/{opt}: {actual:?}"
                );
                assert!(actual.stdout.is_empty(), "{actual:?}");
                assert!(
                    String::from_utf8_lossy(&actual.stderr)
                        .contains("device: thread count must be between 1 and 256"),
                    "{actual:?}"
                );
            }
        }
    }
}

#[test]
fn fixed_function_captures_initialize_in_wasi() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-fixed-functions").unwrap();
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let source = root.join("tests/run/static_functions.fwp");
    for stack in ["0", "1"] {
        let cfile = dir.join(format!("fixed-stack{stack}.c"));
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--target", "wasm32-wasi", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile)
                .env("FWP_STACK", stack)
                .env_remove("FWP_NO_OPT"),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        assert!(!code.contains("FWP_ARC_ONLY"));
        assert!(!code.contains("fwp_heap_collect("));
        // With stack promotion disabled, fixed function captures use static
        // storage and must be initialized before entry. With it enabled, the
        // same callbacks can live on the stack or disappear after inlining.
        if stack == "0" {
            assert!(code.contains("static fwp_clo fwp_static_function"));
            assert!(code.contains("fwp_static_function0.a[0] = PTR(&fc"));
        }
        for opt in ["-O1", "-O2"] {
            let binary = dir.join(format!("fixed-stack{stack}{opt}.wasm"));
            fwp::cgen::compile_for(&code, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
            if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                let path = Path::new(&path).join(format!("fixed-functions-stack{stack}{opt}"));
                std::fs::create_dir_all(&path).unwrap();
                std::fs::write(path.join("program.c"), &code).unwrap();
                std::fs::copy(&source, path.join("program.fwp")).unwrap();
                std::fs::copy(&binary, path.join("program.wasm")).unwrap();
            }
            let output = checked(&mut wasi(&binary, root));
            assert_eq!(
                output.stdout,
                include_str!("run/static_functions.out").as_bytes(),
                "stack={stack}, {opt}"
            );
        }
    }
}

#[test]
fn wasm_entries_keep_cycle_checks_for_browser_and_wasi() {
    let dir = fwp::cgen::TempDir::new("wasm-entry-checks").unwrap();
    let source = dir.join("entry.fwp");
    for target in ["wasm32-wasi", "wasm32-browser"] {
        std::fs::write(&source, "main = 42 | echo\n").unwrap();
        emit(&source, &dir.join("entry.c"), &[], target);
        std::fs::write(&source, "functions : I64 -> Channel[() -> String] ! {Async}\nfunctions = channel.make\nmain = functions 1 | channel.close\n").unwrap();
        emit(&source, &dir.join("empty-functions.c"), &[], target);
        // An empty queue has no captured owner. Reject an actual callback
        // retaining its own queue, rather than the old blanket function ban.
        std::fs::write(
            &source,
            r#"
callbacks : I64 -> Channel[() -> () ! {Async}] ! {Async}
callbacks = channel.make
keep : Channel[() -> () ! {Async}] -> () -> () ! {Async}
keep = then2 const channel.close
send-self = fork channel.send id keep
main = callbacks 1 | tap send-self | channel.recv | option.map (apply ()) | ignore
"#,
        )
        .unwrap();
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c", "--target", target])
            .arg(&source)
            .arg("-o")
            .arg(dir.join("rejected.c"))
            .output()
            .unwrap();
        assert!(!output.status.success(), "{target}: {output:?}");
        assert!(
            String::from_utf8_lossy(&output.stderr).contains("queued function's captured"),
            "{target}: {output:?}"
        );
    }
}

#[test]
fn physical_allocator_observer_rejects_duplicates_after_empty_slots() {
    let have_wasi = available();
    let dir = fwp::cgen::TempDir::new("wasi-physical-ledger").unwrap();
    let code = format!(
        "{}\n{}",
        include_str!("fixtures/wasm_arc_allocations.c"),
        r#"
int main(int argc, char **argv) {
    void *first = malloc(7), *second = malloc(11);
    if (!first || !second || wasm_arc_live != 2 || wasm_arc_bytes != 18) return 231;
    free(first); /* leave a hole before second's live entry */
    if (argc > 1 && argv[1][0] == 'd') wasm_arc_register(second, 11, __LINE__);
    if (argc > 1 && argv[1][0] == 'u') {
        wasm_arc_unregister(second);
        wasm_arc_unregister(second);
    }
    void *third = malloc(13);
    if (!third || wasm_arc_live != 2 || wasm_arc_bytes != 24) return 232;
    free(second); free(third);
    if (wasm_arc_live || wasm_arc_bytes) return 233;
    return 0;
}
"#
    );
    for target in [fwp::cgen::Target::Native, fwp::cgen::Target::Wasi] {
        if target == fwp::cgen::Target::Wasi && !have_wasi {
            continue;
        }
        let binary = dir.join(if target == fwp::cgen::Target::Wasi {
            "probe.wasm"
        } else {
            "probe.exe"
        });
        for opt in ["-O1", "-O2"] {
            fwp::cgen::compile_for(&code, &binary, opt, target).unwrap();
            for (mode, status) in [("normal", 0), ("duplicate", 245), ("unregister", 243)] {
                let mut command = if target == fwp::cgen::Target::Wasi {
                    wasi(&binary, dir.path())
                } else {
                    Command::new(&binary)
                };
                let result = command.arg(mode).output().unwrap();
                assert_eq!(
                    result.status.code(),
                    Some(status),
                    "{mode}/{opt}: {result:?}"
                );
            }
        }
    }
}

#[test]
fn wasi_tasks_release_captures_channels_stacks_and_scheduler() {
    if !available() {
        return;
    }
    let have_asyncify = fwp::asyncify::wasm_opt().is_some();
    assert!(
        have_asyncify || std::env::var_os("FWP_REQUIRE_WASI_ARC").is_none(),
        "required Asyncify toolchain unavailable"
    );
    let dir = fwp::cgen::TempDir::new("wasi-task-owners").unwrap();
    let source = dir.join("tasks.fwp");
    let mut failures = Vec::new();
    for (fixture, program, expected, repetitions) in [
        (
            "weak-channels",
            include_str!("fixtures/weak_channels.fwp"),
            include_str!("fixtures/weak_channels.out"),
            1,
        ),
        (
            "tasks",
            include_str!("fixtures/task_channel_ownership.fwp"),
            include_str!("fixtures/task_channel_ownership.out"),
            16,
        ),
        (
            "queued-functions",
            include_str!("fixtures/queued_function_tasks.fwp"),
            include_str!("fixtures/queued_function_tasks.out"),
            16,
        ),
        (
            "queued-data-channels",
            include_str!("fixtures/queued_data_channels.fwp"),
            include_str!("fixtures/queued_data_channels.out"),
            1,
        ),
        (
            "queued-task-handles",
            include_str!("fixtures/queued_task_handles.fwp"),
            include_str!("fixtures/queued_task_handles.out"),
            1,
        ),
        (
            "task-await-fields",
            include_str!("fixtures/task_await_fields.fwp"),
            include_str!("fixtures/task_await_fields.out"),
            1,
        ),
    ] {
        let program = if repetitions == 1 {
            program.to_owned()
        } else {
            assert_eq!(program.matches("main = () | round").count(), 1);
            program.replace(
                "main = () | round",
                &format!("main = range 0 {repetitions} | each (const () | round)"),
            )
        };
        std::fs::write(&source, program).unwrap();
        let reference = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["run", "--interp"])
                .env("FWP_NO_OPT", "1")
                .arg(&source),
        );
        assert_eq!(reference.stdout, expected.as_bytes().repeat(repetitions));
        for target in [fwp::cgen::Target::Wasi, fwp::cgen::Target::Browser] {
            let target_name = if target == fwp::cgen::Target::Wasi {
                "wasm32-wasi"
            } else {
                "wasm32-browser"
            };
            let ordinary = emit(&source, &dir.join("tasks.c"), &["-O1"], target_name);
            if fixture == "task-await-fields" {
                assert!(ordinary.contains("= fwp_task_await_fields("));
            }
            let mut measured = measured_program(&ordinary);
            let retire = "    if (fwp_zombie && fwp_zombie != fwp_cur) {";
            assert_eq!(measured.matches(retire).count(), 1);
            measured = measured.replace(
                retire,
                &format!("{retire}\n        if (fwp_zombie->base) _Exit(246);"),
            );
            let finish = "static void fwp_fiber_tasks_finish(void) {";
            assert_eq!(measured.matches(finish).count(), 1);
            measured = measured.replace(
                finish,
                &format!("{finish}\n    if (fwp_root && fwp_root->base) _Exit(246);"),
            );
            let release = "    fwp_fiber_tasks_finish();";
            assert_eq!(measured.matches(release).count(), 1);
            let omitted = measured.replace(release, "    /* omit scheduler shutdown */");
            let snapshot = "            fwp_leave(t); /* completed fiber storage */";
            assert_eq!(measured.matches(snapshot).count(), 1);
            let missing_state =
                measured.replace(snapshot, "            /* omit finished state owner */");
            let drop = "c->owner.queue_drop(element);";
            assert_eq!(measured.matches(drop).count(), 1);
            let missing_queue = measured.replace(drop, "(void)element;");
            let result_drop = "if (t->result_drop && result) t->result_drop(result);";
            assert_eq!(measured.matches(result_drop).count(), 1);
            let missing_result = measured.replace(result_drop, "/* omit cached result owner */");
            let weak_release = "        fwp_weak_channel_drop(PTR(weak));";
            assert_eq!(measured.matches(weak_release).count(), 1);
            let missing_weak =
                measured.replace(weak_release, "        /* omit weak metadata owner */");
            let (retained_label, retained) = match fixture {
                "weak-channels" => ("missing-weak-metadata", &missing_weak),
                "tasks" => ("missing-state", &missing_state),
                "task-await-fields" => ("missing-result", &missing_result),
                _ => ("missing-queue", &missing_queue),
            };
            for asyncify in [false, true] {
                if asyncify && !have_asyncify {
                    continue;
                }
                let mode = if asyncify { "asyncify" } else { "jspi" };
                for opt in ["-O1", "-O2"] {
                    for (label, candidate, status) in [
                        ("ordinary", &ordinary, 0),
                        ("measured", &measured, 0),
                        ("omitted", &omitted, 244),
                        (retained_label, retained, 244),
                    ] {
                        let mut code = if label == "ordinary" {
                            candidate.clone()
                        } else {
                            format!(
                                "{}\n{candidate}",
                                include_str!("fixtures/wasm_arc_allocations.c")
                            )
                        };
                        if asyncify {
                            code = format!("{}{code}", fwp::asyncify::ASYNCIFY_MARK);
                        }
                        let binary = dir.join("tasks.wasm");
                        fwp::cgen::compile_for(&code, &binary, opt, target).unwrap();
                        if asyncify {
                            fwp::asyncify::apply(&binary, opt).unwrap();
                        }
                        let mut command = wasi(&binary, dir.path());
                        if target == fwp::cgen::Target::Browser {
                            command = Command::new("node");
                            command
                                .arg("--no-warnings")
                                .arg(
                                    Path::new(env!("CARGO_MANIFEST_DIR"))
                                        .join("tests/wasm/browser-run.mjs"),
                                )
                                .arg(binary.with_extension("js"));
                        }
                        if asyncify {
                            command.env("FWP_NO_JSPI", "1");
                        }
                        let output = command.output().unwrap();
                        let name = format!("{fixture}-{target:?}-{mode}-{label}{opt}");
                        if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                            let path = std::path::PathBuf::from(path);
                            std::fs::create_dir_all(&path).unwrap();
                            std::fs::write(path.join(format!("{name}.c")), &code).unwrap();
                            std::fs::copy(&binary, path.join(format!("{name}.wasm"))).unwrap();
                            std::fs::write(path.join(format!("{name}.stdout")), &output.stdout)
                                .unwrap();
                            std::fs::write(path.join(format!("{name}.stderr")), &output.stderr)
                                .unwrap();
                        }
                        if output.status.code() != Some(status)
                            || output.stdout != reference.stdout
                            || (status == 0 && output.stderr != reference.stderr)
                        {
                            failures.push(format!("{name}: status {:?}, expected {status}; stdout matches: {}; stderr: {}",
                            output.status.code(), output.stdout == reference.stdout, String::from_utf8_lossy(&output.stderr)));
                            continue;
                        }
                        if status == 0 {
                            let symbols =
                                checked(Command::new("wasm-objdump").arg("--details").arg(&binary));
                            let symbols = String::from_utf8_lossy(&symbols.stdout);
                            if !symbols.contains("<_start>") || !symbols.contains("<fwp_") {
                                failures.push(format!("{name}: runtime function names missing"));
                            }
                            for collector in
                                ["fwp_heap_scan", "fwp_heap_mark_all", "fwp_heap_sweep"]
                            {
                                if symbols.contains(collector) {
                                    failures.push(format!("{name}: {collector} remains"));
                                }
                            }
                            if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                                let path = std::path::PathBuf::from(path);
                                std::fs::create_dir_all(&path).unwrap();
                                std::fs::write(
                                    path.join(format!("{name}.symbols")),
                                    symbols.as_bytes(),
                                )
                                .unwrap();
                            }
                        }
                    }
                }
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn browser_entries_isolate_outputs_reentrant_calls_and_host_errors() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("browser-host-owners").unwrap();
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    for source in [
        root.join("tests/run/json_exact_numbers.fwp"),
        root.join("tests/fixtures/browser_host_task.fwp"),
    ] {
        let fixture = source.file_stem().unwrap().to_str().unwrap();
        let ordinary = emit(&source, &dir.join("numbers.c"), &[], "wasm32-browser");
        let measured = measured_program(&ordinary);
        for (name, code) in [
            ("ordinary", ordinary),
            (
                "measured",
                format!(
                    "{}\n{measured}",
                    include_str!("fixtures/wasm_arc_allocations.c")
                ),
            ),
        ] {
            let binary = dir.join(format!("{name}.wasm"));
            fwp::cgen::compile_for(&code, &binary, "-O2", fwp::cgen::Target::Browser).unwrap();
            let result = checked(
                Command::new("node")
                    .arg("--no-warnings")
                    .arg(root.join("tests/wasm/browser-owners.mjs"))
                    .arg(binary.with_extension("js"))
                    .arg(source.with_extension("out")),
            );
            assert_eq!(
                result.stdout,
                b"sequential, concurrent, reentrant and throwing sinks pass\n"
            );
            assert!(result.stderr.is_empty(), "{result:?}");
            if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                std::fs::copy(&binary, path.join(format!("browser-{fixture}-{name}.wasm")))
                    .unwrap();
                std::fs::write(path.join(format!("browser-{fixture}-{name}.c")), code).unwrap();
            }
        }
    }
}

#[test]
fn browser_loader_preserves_host_errors_and_engine_stack_traps() {
    let have_node = Command::new("node")
        .arg("--version")
        .output()
        .is_ok_and(|output| output.status.success());
    if !have_node {
        assert!(
            std::env::var_os("FWP_REQUIRE_WASI_ARC").is_none(),
            "required Node unavailable"
        );
        eprintln!("skipping loader exception execution: Node unavailable");
        return;
    }
    let result = checked(
        Command::new("node")
            .arg(Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/wasm/loader-errors.mjs")),
    );
    assert_eq!(
        result.stdout,
        b"host exceptions and actual WebAssembly stack overflow stay distinct\n"
    );
    assert!(result.stderr.is_empty(), "{result:?}");
}

#[test]
fn synchronous_wasi_raw_pointer_width_and_allocation_bounds() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-raw-pointers").unwrap();
    let success = r#"
write-signed : Ptr[U8] -> () ! {Unsafe}
write-signed = ptr.cast | ptr.write -7isize
read-signed : Ptr[U8] -> ISize ! {Unsafe}
read-signed = ptr.cast | ptr.read
write-unsigned : Ptr[U8] -> () ! {Unsafe}
write-unsigned = ptr.cast | ptr.write 4294967295usize
read-unsigned : Ptr[U8] -> USize ! {Unsafe}
read-unsigned = ptr.cast | ptr.read
step-signed : Ptr[ISize] -> Bool
step-signed = fork eq (ptr.at 1 | ptr.address) (ptr.address | add 4u64)
step-unsigned : Ptr[USize] -> Bool
step-unsigned = fork eq (ptr.at 1 | ptr.address) (ptr.address | add 4u64)
check : Ptr[U8] -> () ! {IO, Unsafe}
check = tap (ptr.at 4 | ptr.write 165u8)
    | tap write-signed
    | tap (read-signed | echo)
    | tap (ptr.at 4 | ptr.read | echo)
    | tap write-unsigned
    | tap (read-unsigned | echo)
    | tap (ptr.at 4 | ptr.read | echo)
    | tap (ptr.cast | step-signed | echo)
    | tap (ptr.cast | step-unsigned | echo)
    | mem.free
small : Ptr[U8] -> () ! {IO, Unsafe}
small = tap (ptr.write 37u8) | tap (ptr.read | echo) | mem.free
main = [16 | mem.alloc | check, [0, -1, -9223372036854775808] | each (mem.alloc | small)] | ignore
"#;
    for (name, program, expected) in [
        (
            "wide-integers",
            include_str!("fixtures/raw_integer_widths.fwp").to_owned(),
            include_str!("fixtures/raw_integer_widths.out"),
        ),
        (
            "storage",
            success.to_owned(),
            "-7\n165\n4294967295\n165\nTrue\nTrue\n37\n37\n37\n",
        ),
        (
            "overflow-zero",
            "main = 4294967296 | mem.alloc | mem.free\n".to_owned(),
            "",
        ),
        (
            "overflow-one",
            "main = 4294967297 | mem.alloc | mem.free\n".to_owned(),
            "",
        ),
        (
            "overflow-max",
            "main = 9223372036854775807 | mem.alloc | mem.free\n".to_owned(),
            "",
        ),
    ] {
        let source = dir.join("program.fwp");
        std::fs::write(&source, program).unwrap();
        let code = emit(&source, &dir.join("program.c"), &[], "wasm32-wasi");
        let measured = measured_program(&code);
        for opt in ["-O0", "-O2"] {
            let binary = dir.join("program.wasm");
            let candidate = format!(
                "{}\n{measured}",
                include_str!("fixtures/wasm_arc_allocations.c")
            );
            fwp::cgen::compile_for(&candidate, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
            let output = wasi(&binary, dir.path()).output().unwrap();
            assert_eq!(
                output.stdout,
                expected.as_bytes(),
                "{name}/{opt}: {output:?}"
            );
            if matches!(name, "storage" | "wide-integers") {
                assert!(output.status.success(), "{name}/{opt}: {output:?}");
            } else {
                assert_eq!(output.status.code(), Some(101), "{name}/{opt}: {output:?}");
                assert!(
                    String::from_utf8_lossy(&output.stderr).contains("raw allocation too large"),
                    "{name}/{opt}: {output:?}"
                );
            }
            if let Some(root) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                let path = std::path::PathBuf::from(root);
                std::fs::create_dir_all(&path).unwrap();
                let stem = format!("raw-{name}{opt}");
                std::fs::write(path.join(format!("{stem}.c")), &candidate).unwrap();
                std::fs::copy(&binary, path.join(format!("{stem}.wasm"))).unwrap();
                std::fs::write(path.join(format!("{stem}.stdout")), output.stdout).unwrap();
                std::fs::write(path.join(format!("{stem}.stderr")), output.stderr).unwrap();
            }
            if name == "overflow-one" {
                let guard = "if (count > SIZE_MAX) fwp_trap(\"raw allocation too large\");";
                assert_eq!(candidate.matches(guard).count(), 1);
                let broken = candidate.replace(guard, "/* omitted allocation bound */");
                fwp::cgen::compile_for(&broken, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
                let output = wasi(&binary, dir.path()).output().unwrap();
                assert!(output.status.success(), "missing-bound/{opt}: {output:?}");
                assert!(output.stdout.is_empty());
                if let Some(root) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                    let path = std::path::PathBuf::from(root);
                    let stem = format!("raw-missing-bound{opt}");
                    std::fs::write(path.join(format!("{stem}.c")), &broken).unwrap();
                    std::fs::copy(&binary, path.join(format!("{stem}.wasm"))).unwrap();
                    std::fs::write(path.join(format!("{stem}.stdout")), output.stdout).unwrap();
                    std::fs::write(path.join(format!("{stem}.stderr")), output.stderr).unwrap();
                }
            }
        }
    }
}

#[test]
fn wasi_unique_arrays_have_no_count_entries_and_free_on_failure() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-unique-arrays").unwrap();
    let mut failures = Vec::new();
    let source = dir.join("unique.fwp");
    let synchronous = include_str!("fixtures/unique_array_ownership.fwp")
        .split_once("yield-index :")
        .unwrap()
        .0;
    std::fs::write(&source, synchronous).unwrap();
    for name in ["local", "partial", "completed"] {
        let code = emit(
            &source,
            &dir.join("unique.c"),
            &["--fn", name, "-O2"],
            "wasm32-wasi",
        );
        assert!(code.contains("/* proved unique I64 array: no reference-count metadata */"));
        let start = code.find(&format!("/* {name} :")).unwrap();
        let id = code[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let probe = include_str!("fixtures/unique_array_wasi_probe.c")
            .replace("@ENTRY@", &format!("f{id}"))
            .replace("@PARTIAL@", if name == "local" { "0" } else { "1" })
            .replace("@FAIL_LENGTH@", if name == "completed" { "2" } else { "4" });
        let allocate = "static void *fwp_alloc_unique(size_t n) { return fwp_alloc(n); }";
        let free = "static void fwp_mem_free(void *p) { free(p); }";
        assert_eq!(code.matches(allocate).count(), 1);
        assert_eq!(code.matches(free).count(), 1);
        let mut measured = code
            .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int unique_probe_active;\nstatic V unique_probe_owner;\nstatic size_t unique_probe_allocations, unique_probe_frees, unique_probe_counts;")
            .replace(allocate, "static void *fwp_alloc_unique(size_t n) { void *p = fwp_alloc(n); if (unique_probe_active) { unique_probe_owner = (V)(uintptr_t)p; unique_probe_allocations++; } return p; }")
            .replace(free, "static void fwp_mem_free(void *p) { if (unique_probe_active && (V)(uintptr_t)p == unique_probe_owner) unique_probe_frees++; /* missing-free-control */ free(p); }")
            .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
        for signature in [
            "static inline V fwp_rc_fresh(V value) {",
            "static inline void fwp_rc_dup(V value) {",
            "static inline void fwp_rc_drop(V value) {",
            "static inline int fwp_rc_release_last(V value) {",
            "static inline int fwp_rc_unique(V value) {",
            "static inline int fwp_rc_unique_mut(V value) {",
            "static inline int fwp_rc_last(V value) {",
        ] {
            assert_eq!(measured.matches(signature).count(), 1);
            measured = measured.replace(signature, &format!("{signature} if (unique_probe_active && value == unique_probe_owner) unique_probe_counts++;"));
        }
        let measured = format!(
            "{}\n{measured}\n{probe}",
            include_str!("fixtures/wasm_arc_allocations.c")
        );
        for opt in ["-O1", "-O2"] {
            for (label, candidate, expected) in [
                ("owned", measured.clone(), 0),
                (
                    "extra-count",
                    measured.replace(
                        "/* extra-count-control */",
                        "fwp_rc_fresh(unique_probe_owner);",
                    ),
                    224,
                ),
                (
                    "missing-free",
                    measured.replace(
                        "/* missing-free-control */",
                        "if (unique_probe_active && (V)(uintptr_t)p == unique_probe_owner) return;",
                    ),
                    225,
                ),
            ] {
                let binary = dir.join("probe.wasm");
                fwp::cgen::compile_for(&candidate, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
                let output = wasi(&binary, dir.path()).output().unwrap();
                if let Some(root) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                    let path = std::path::PathBuf::from(root);
                    std::fs::create_dir_all(&path).unwrap();
                    let stem = format!("unique-{name}-{label}{opt}");
                    std::fs::write(path.join(format!("{stem}.c")), &candidate).unwrap();
                    std::fs::copy(&binary, path.join(format!("{stem}.wasm"))).unwrap();
                    std::fs::write(path.join(format!("{stem}.stdout")), &output.stdout).unwrap();
                    std::fs::write(path.join(format!("{stem}.stderr")), &output.stderr).unwrap();
                    std::fs::write(
                        path.join(format!("{stem}.status")),
                        format!("{:?}\n", output.status.code()),
                    )
                    .unwrap();
                }
                if output.status.code() != Some(expected)
                    || !output.stdout.is_empty()
                    || !output.stderr.is_empty()
                {
                    failures.push(format!(
                        "{name}/{label}/{opt}: expected {expected}, got {output:?}"
                    ));
                }
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn wasi_parser_regions_release_blocks_and_keep_links_out_of_count_tables() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-parser-regions").unwrap();
    let source = dir.join("parser.fwp");
    let synchronous = include_str!("fixtures/parser_workspace.fwp")
        .split_once("# Suspend only")
        .unwrap()
        .0;
    std::fs::write(&source, synchronous).unwrap();
    let code = emit(
        &source,
        &dir.join("parser.c"),
        &["--fn", "calculate", "-O2"],
        "wasm32-wasi",
    );
    assert!(code.contains("fwp_region region = {0};"));
    let measured = parser_region_probe::instrument(&code, "calculate", fwp::cgen::Target::Wasi);
    let mut failures = Vec::new();
    for opt in ["-O1", "-O2"] {
        for (name, candidate, expected) in [
            ("ordinary", measured.clone(), 0),
            (
                "extra-count",
                measured.replace("/* extra-link-count */", "fwp_rc_dup(PTR(node));"),
                251,
            ),
            (
                "missing-free",
                measured.replace(
                    "        fwp_mem_free(block);",
                    "        /* omitted block free */",
                ),
                248,
            ),
        ] {
            let label = format!("parser-{name}{opt}");
            let binary = dir.join(format!("{label}.wasm"));
            fwp::cgen::compile_for(&candidate, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
            let output = wasi(&binary, dir.path()).output().unwrap();
            if let Some(path) = std::env::var_os("FWP_WASI_ARC_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                std::fs::write(path.join(format!("{label}.c")), &candidate).unwrap();
                std::fs::copy(&binary, path.join(format!("{label}.wasm"))).unwrap();
                std::fs::write(path.join(format!("{label}.stdout")), &output.stdout).unwrap();
                std::fs::write(path.join(format!("{label}.stderr")), &output.stderr).unwrap();
                std::fs::write(
                    path.join(format!("{label}.status")),
                    format!("{:?}\n", output.status.code()),
                )
                .unwrap();
            }
            if output.status.code() != Some(expected)
                || !output.stdout.is_empty()
                || !output.stderr.is_empty()
            {
                failures.push(format!("{label}: expected {expected}, got {output:?}"));
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}
