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
fn emit(source: &Path, cfile: &Path, entry: &[&str]) -> String {
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--gc",
                "arc",
                "--target",
                "wasm32-wasi",
                "--emit-c",
            ])
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
    let code = emit(source, cfile, &[]).replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
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
            "main = task.yield ()\n",
            vec![],
            "WASI host fibers have no checked retention contract",
        ),
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
        ("hashes", include_str!("fixtures/hash_values.fwp")),
        ("hash-fusion", include_str!("fixtures/hash_fusion.fwp")),
        ("range-arrays", include_str!("fixtures/range_arrays.fwp")),
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
        std::fs::write(&source, program).unwrap();
        let reference = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["run", "--interp"])
                .env("FWP_NO_OPT", "1")
                .arg(&source)
                .current_dir(dir.path()),
        );
        let code = emit(&source, &dir.join("program.c"), &[]);
        let instrumented = measured_program(&code);
        let needle = "    free((void *)(uintptr_t)value);";
        assert_eq!(instrumented.matches(needle).count(), 1);
        let omitted = instrumented.replace(needle, "    (void)value;");
        let missing_shutdown = instrumented.replace("if (atexit(fwp_tape_finish))", "if (0)");
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
        for opt in ["-O1", "-O2"] {
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
    let print = "static V fwp_p_print(V s) {";
    assert_eq!(result.matches(print).count(), 1);
    result.replace(print, &format!("{print} wasm_arc_phase++;"))
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
        let code = measured_program(&emit(&source, &dir.join("entry.c"), &entry));
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
                symbols.contains("<_start>"),
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
    let code = emit(&source, &dir.join("hash.c"), &[]);
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
    let code = emit(&source, &dir.join("main.c"), &[]);
    assert!(code.contains("return fwp_p_array_range(l0, l1,"));
    let guard =
        "    if (count > (SIZE_MAX - sizeof(fwp_arr)) / sizeof(V)) fwp_trap(\"array too large\");";
    assert_eq!(code.matches(guard).count(), 1);
    let truncated = code.replace(guard, "    /* omitted length guard */");
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
