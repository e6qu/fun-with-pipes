//! Checked ARC eligibility, escaping owners, physical reclamation and diagnostics.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&output.stderr)
    );
    output
}

#[test]
fn arc_programs_match_raw_interpreter_and_reclaim_escaped_values() {
    let dir = std::env::temp_dir().join(format!("fwp-arc-{}", std::process::id()));
    std::fs::create_dir(&dir).unwrap();
    let data = dir.join("input.txt");
    std::fs::write(&data, "owned file contents").unwrap();
    let closures = r#"
choose : I64 -> (String -> String)
choose = if (rem 2 | eq 0)
    (rem 8 | add 1 | flip string.repeat "x" | concat)
    (rem 8 | add 1 | flip string.repeat "y" | flip concat)
checks : (String -> String) -> (String, String, String)
checks = make { 0 = apply "A", 1 = apply "B", 2 = apply "C" }
main = range 0 129 | map (choose | checks) | length | echo
"#;
    let files = format!("main = [\"{}\" | attempt (flip file.with file.read-all) | echo, \"{}/missing\" | attempt (flip file.with file.read-all) | echo] | ignore\n",data.display(),dir.display());
    let sources = [
        ("arrays", include_str!("fixtures/numeric_array_fusion.fwp")),
        ("closures", closures),
        ("files", files.as_str()),
        // abs has a portable C int signature, including Windows LLP64.
        // The surrounding list forces allocation/reclamation so the existing
        // ledger also checks the foreign call inside an owned graph.
        (
            "foreign-scalars",
            "foreign \"C\" abs : I32 -> I32\nmain = [-7, -3, 0, 11] | map abs | echo\n",
        ),
    ];
    for (name, source) in sources {
        let input = dir.join(format!("{name}.fwp"));
        std::fs::write(&input, source).unwrap();
        let reference = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&input),
        );
        for (stack, memory) in [("0", "dynamic"), ("1", "dynamic"), ("1", "static")] {
            if memory == "static" && name != "arrays" {
                continue;
            }
            let cfile = dir.join(format!("{name}-{stack}-{memory}.c"));
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", stack)
                    .args(["build", "--gc", "arc", "--memory", memory, "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            assert!(code.contains("#define FWP_ARC_ONLY 1"));
            let main_start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(main_start);
            assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
            assert_eq!(main.matches("    fwp_cl_finish();\n").count(), 1);
            let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    intptr_t arc_budget = fwp_gc.budget;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < arc_budget || fwp_gc.freed <= 0) { fprintf(stderr,\"ARC unreclaimed bytes: %ld\\n\",(long)(arc_budget-fwp_gc.budget)); exit(193); }\n");
            let measured = format!("{runtime}{main}");
            if let Some(path) = std::env::var_os("FWP_ARC_ARTIFACTS") {
                let destination = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&destination).unwrap();
                std::fs::write(
                    destination.join(format!("{name}-{stack}-{memory}.c")),
                    &measured,
                )
                .unwrap();
            }
            for opt in ["-O1", "-O2"] {
                let binary = dir.join(format!("{name}-{stack}-{memory}{opt}"));
                fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
                let symbols = checked(Command::new("nm").arg(&binary));
                let symbols = String::from_utf8_lossy(&symbols.stdout);
                for tracing_function in ["fwp_gc_scan", "fwp_gc_mark_all", "fwp_gc_sweep"] {
                    assert!(
                        !symbols.contains(tracing_function),
                        "ARC binary contains {tracing_function}"
                    );
                }
                if opt == "-O2" {
                    if let Some(path) = std::env::var_os("FWP_ARC_ARTIFACTS") {
                        let mut disassemble = Command::new(if cfg!(target_os = "macos") {
                            "otool"
                        } else {
                            "objdump"
                        });
                        disassemble
                            .arg(if cfg!(target_os = "macos") {
                                "-tvV"
                            } else {
                                "-d"
                            })
                            .arg(&binary);
                        let assembly = checked(&mut disassemble);
                        std::fs::write(
                            std::path::PathBuf::from(path)
                                .join(format!("{name}-{stack}-{memory}.asm")),
                            assembly.stdout,
                        )
                        .unwrap();
                    }
                }
                let actual = checked(
                    Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0"),
                );
                assert_eq!(actual.stdout, reference.stdout, "{name} {stack} {opt}");
                assert_eq!(actual.stderr, reference.stderr, "{name} {stack} {opt}");
                let conflict = Command::new(&binary)
                    .env("FWP_GC_STRESS", "1")
                    .output()
                    .unwrap();
                assert_eq!(conflict.status.code(), Some(101));
                assert!(String::from_utf8_lossy(&conflict.stderr)
                    .contains("--gc arc cannot enable tracing"));
            }
            if name == "arrays" && stack == "0" {
                let needle = "    fwp_mem_free((void *)(uintptr_t)v);";
                assert_eq!(measured.matches(needle).count(), 2);
                let omitted = measured.replace(
                    needle,
                    "    /* negative control: omitted physical reclamation */",
                );
                let binary = dir.join("omitted-free");
                fwp::cgen::compile_c(&omitted, &binary, "-O2").unwrap();
                let actual = Command::new(binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    actual.status.code(),
                    Some(193),
                    "physical-free omission must fail the ledger"
                );
                let forced = measured.replace(
                    "    intptr_t arc_budget = fwp_gc.budget;",
                    "    fwp_gc_collect();\n    intptr_t arc_budget = fwp_gc.budget;",
                );
                let binary = dir.join("forced-trace");
                fwp::cgen::compile_c(&forced, &binary, "-O2").unwrap();
                let out = Command::new(binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(out.status.code(), Some(101));
                assert!(String::from_utf8_lossy(&out.stderr)
                    .contains("tracing requested in an ARC executable"));
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn arc_rejects_unproved_runtime_boundaries_and_disabled_counting() {
    let dir = std::env::temp_dir().join(format!("fwp-arc-reject-{}", std::process::id()));
    std::fs::create_dir(&dir).unwrap();
    for (name,source,reason) in [
        ("custom-native","foreign \"fwp\" string.repeat : I64 -> I64 -> I64\nmain = 1 | string.repeat 2 | echo\n","no checked ownership signature"),
        ("foreign-string","foreign \"C\" strlen : String -> USize\nmain = \"owned\" | strlen | echo\n","foreign boundary has no checked ownership contract"),
        ("foreign-callback","foreign \"C\" invoke : (I64 -> I64) -> I64\nmain = invoke (add 1) | echo\n","foreign boundary has no checked ownership contract"),
        ("channel","text-channel : I64 -> Channel[String] ! {Async}\ntext-channel = channel.make\nmain = text-channel 1 | channel.close\n","tracing-free ownership contract"),
        ("unscoped-tape","main = 1 | ad.tape | echo\n","tracing-free lifetime policy"),
        ("input","main = read-all () | echo\n","tracing-free ownership contract"),
    ] {
        let input=dir.join(format!("{name}.fwp"));
        std::fs::write(&input,source).unwrap();
        let out=Command::new(env!("CARGO_BIN_EXE_fwp")).args(["build","--gc","arc","--emit-c"]).arg(&input).arg("-o").arg(dir.join("rejected.c")).output().unwrap();
        assert!(!out.status.success());
        let error=String::from_utf8_lossy(&out.stderr);
        assert!(error.contains("--gc arc") && error.contains(reason),"{error}");
    }
    let input = dir.join("valid.fwp");
    std::fs::write(&input, "main = 42 | echo\n").unwrap();
    for boundary in [["--target", "wasm32-wasi"], ["--fn", "main"]] {
        let out = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc=arc", "--emit-c"])
            .args(boundary)
            .arg(&input)
            .arg("-o")
            .arg(dir.join("boundary.c"))
            .output()
            .unwrap();
        assert!(!out.status.success());
        assert!(String::from_utf8_lossy(&out.stderr)
            .contains("--gc arc currently requires a native main program"));
    }
    for flag in ["FWP_FREE", "FWP_REUSE"] {
        let out = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env(flag, "0")
            .args(["build", "--gc=arc", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(dir.join("disabled.c"))
            .output()
            .unwrap();
        assert!(!out.status.success());
        assert!(String::from_utf8_lossy(&out.stderr)
            .contains("--gc arc requires counted ownership and freeing"));
    }
    std::fs::remove_dir_all(dir).unwrap();
}
