//! Checked WASI ownership must reclaim storage and reject unproved retention.
#![cfg(any(target_os = "linux", target_os = "macos"))]
use std::path::Path;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn available() -> bool {
    let dir = fwp::cgen::TempDir::new("wasi-arc-toolchain").unwrap();
    let source = dir.join("probe.c");
    std::fs::write(&source, "int main(void){return 0;}\n").unwrap();
    let ready = Command::new(std::env::var("FWP_WASM_CC").unwrap_or_else(|_| "clang".into()))
        .arg("--target=wasm32-wasi")
        .arg(source)
        .arg("-o")
        .arg(dir.join("probe.wasm"))
        .output()
        .is_ok_and(|o| o.status.success())
        && Command::new("node")
            .arg("--version")
            .output()
            .is_ok_and(|o| o.status.success());
    assert!(
        ready || std::env::var_os("FWP_REQUIRE_WASI_ARC").is_none(),
        "required WASI ARC toolchain unavailable"
    );
    if !ready {
        eprintln!("skipping actual WASI ARC: toolchain unavailable");
    }
    ready
}
fn wasi(binary: &Path, root: &Path) -> Command {
    let mut command = Command::new("node");
    command
        .arg("--no-warnings")
        .arg(Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/wasm/wasi-run.mjs"))
        .arg(binary)
        .current_dir(root)
        .env("FWP_GC", "off")
        .env("FWP_GC_STRESS", "0")
        .env("FWP_GC_VERIFY", "0")
        .env("FWP_REUSE_VERIFY", "0");
    command
}
fn emit(source: &Path, cfile: &Path, entry: &[&str], target: &str) -> String {
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc", "arc", "--target", target, "--emit-c"])
            .args(entry)
            .arg(source)
            .arg("-o")
            .arg(cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    assert!(
        code.contains("#define FWP_ARC_ONLY 1") && code.contains("#define FWP_RESOURCE_OWNERS 1")
    );
    code
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
            "probe"
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
                        let mut c = Command::new(&binary);
                        c.env("FWP_GC", "off")
                            .env("FWP_GC_STRESS", "0")
                            .env("FWP_GC_VERIFY", "0")
                            .env("FWP_REUSE_VERIFY", "0");
                        c
                    }
                };
                let result = command().output().unwrap();
                assert_eq!(result.status.code(), Some(status), "{opt}: {result:?}");
                if status == 0 {
                    for (key, value) in [
                        ("FWP_GC", "full"),
                        ("FWP_GC_STRESS", "1"),
                        ("FWP_GC_VERIFY", "1"),
                        ("FWP_REUSE_VERIFY", "1"),
                    ] {
                        let result = command().env(key, value).output().unwrap();
                        assert_eq!(result.status.code(), Some(101), "{key}: {result:?}");
                        assert!(
                            String::from_utf8_lossy(&result.stderr).contains("--gc arc cannot"),
                            "{result:?}"
                        );
                    }
                }
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
            .args([
                "build",
                "--gc",
                "arc",
                "--target",
                "wasm32-wasi",
                "--emit-c",
            ])
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
        let instrumented = measured_program(&code);
        let needle = "    free((void *)(uintptr_t)value);";
        assert_eq!(instrumented.matches(needle).count(), 1);
        let omitted = instrumented.replace(needle, "    (void)value;");
        let missing_shutdown = instrumented.replace("if (atexit(fwp_tape_finish))", "if (0)");
        let missing_metrics_shutdown =
            instrumented.replace("if (atexit(fwp_metrics_finish))", "if (0)");
        let unclaimed = instrumented.replace(
            "#if FWP_GC\n        if (!c) return;\n#endif",
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
        let levels = if name == "mixed-tail-recursion" {
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
                if expected == 0 {
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
            for collector in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
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
fn fixed_function_captures_initialize_in_wasi() {
    if !available() {
        return;
    }
    let dir = fwp::cgen::TempDir::new("wasi-fixed-functions").unwrap();
    let root = Path::new(env!("CARGO_MANIFEST_DIR"));
    let source = root.join("tests/run/static_functions.fwp");
    let cfile = dir.join("fixed.c");
    let code = emit(&source, &cfile, &[], "wasm32-wasi");
    assert!(code.contains("static fwp_clo fwp_static_function"));
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("fixed{opt}.wasm"));
        fwp::cgen::compile_for(&code, &binary, opt, fwp::cgen::Target::Wasi).unwrap();
        let output = checked(&mut wasi(&binary, root));
        assert_eq!(
            output.stdout,
            include_str!("run/static_functions.out").as_bytes()
        );
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
            .args(["build", "--gc", "arc", "--emit-c", "--target", target])
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
            let ordinary = emit(&source, &dir.join("tasks.c"), &[], target_name);
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
            let (retained_label, retained) = if fixture == "tasks" {
                ("missing-state", &missing_state)
            } else {
                ("missing-queue", &missing_queue)
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
                                .arg(binary.with_extension("js"))
                                .env("FWP_GC", "off")
                                .env("FWP_GC_STRESS", "0")
                                .env("FWP_GC_VERIFY", "0")
                                .env("FWP_REUSE_VERIFY", "0");
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
                            for collector in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
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
