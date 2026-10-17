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
    let files = format!("main = [{:?} | attempt (flip file.with file.read-all) | echo, {:?} | attempt (flip file.with file.read-all) | echo] | ignore\n", data.to_string_lossy(), dir.join("missing").to_string_lossy());
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
                let binary = dir.join(format!("{name}-{stack}-{memory}{opt}.exe"));
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
                        } else if cfg!(target_os = "windows") {
                            "llvm-objdump"
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
                let binary = dir.join("omitted-free.exe");
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
                let binary = dir.join("forced-trace.exe");
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
        ("foreign-callback","foreign \"C\" invoke : (I64 -> String) -> I64\nmain = invoke show | echo\n","foreign boundary has no checked ownership contract"),
        ("foreign-address","foreign \"C\" lookup : () -> Ptr[I64]\nmain = lookup () | ignore\n","tracing-free ownership contract"),
        ("channel","fn-channel : I64 -> Channel[() -> String] ! {Async}\nfn-channel = channel.make\nmain = fn-channel 1 | channel.close\n","channel payloads cannot contain"),
        ("task-channel","tasks : I64 -> Channel[Task[String]] ! {Async}\ntasks = channel.make\nmain = tasks 1 | channel.close\n","channel payloads cannot contain"),
        ("nested-channel","nested : I64 -> Channel[List[Channel[String]]] ! {Async}\nnested = channel.make\nmain = nested 1 | channel.close\n","channel payloads cannot contain"),
        ("cyclic-channel","Link = | Node (Channel[Link])\nlinks : I64 -> Channel[Link] ! {Async}\nlinks = channel.make\nmain = links 1 | channel.close\n","channel payloads cannot contain"),
        ("unscoped-tape","main = 1 | ad.tape | echo\n","tracing-free lifetime policy"),
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
    for boundary in [&["--target", "wasm32-browser"][..], &["--rest"]] {
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
            .contains("--gc arc requires a checked executable or C library"));
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

#[test]
fn wrapped_chain_cleanup_stack_measurement() {
    let dir = std::env::temp_dir().join(format!("fwp-chain-cleanup-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let input = dir.join("wrapped_chain.fwp");
    std::fs::write(&input, include_str!("fixtures/wrapped_chain.fwp")).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    assert_eq!(reference.stdout, b"Some \"63\"\n");
    let cfile = dir.join("chain.c");
    checked(
        Command::new(fwp)
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "0")
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(&cfile).unwrap();
    let marker = "/* Link */\nstatic void ";
    let start = code.find(marker).expect("typed Link destructor") + marker.len();
    let drop = code[start..].split('(').next().unwrap();
    assert!(drop.starts_with("fwp_drop"));
    // Observe the stack address at each generated destructor entry. The same
    // instrumentation is used for both chain lengths and both compiler flags.
    let observe = r#"
static uintptr_t chain_stack_low, chain_stack_high;
static __attribute__((noinline)) void chain_observe(void) {
    volatile unsigned char marker = 0;
    uintptr_t address = (uintptr_t)&marker;
    if (address < chain_stack_low) chain_stack_low = address;
    if (address > chain_stack_high) chain_stack_high = address;
}
"#;
    let first_drop = code.find("static void fwp_drop").unwrap();
    let mut measured = code[..first_drop].to_string() + observe;
    for line in code[first_drop..].lines() {
        measured.push_str(line);
        measured.push('\n');
        if line.starts_with("static void fwp_drop") && line.ends_with("(V v) {") {
            measured.push_str("    chain_observe();\n");
        }
    }
    measured = measured.replace(
        "int main(int argc, char **argv)",
        "int language_main(int argc, char **argv)",
    );
    let probe = r#"
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns = fwp_fn_table; fwp_init_consts();
    const int sizes[] = {64, 1024};
    for (int i = 0; i < 2; i++) {
        intptr_t before = fwp_gc.budget;
        V root = 0;
        for (int n = 0; n < sizes[i]; n++) {
            V text = fwp_rc_fresh(fwp_str_new("value", 5));
            V next = n ? fwp_rc_fresh(fwp_some(root)) : FWP_NONE;
            root = fwp_rc_fresh(fwp_record(2, (V[]){text, next}));
        }
        chain_stack_low = UINTPTR_MAX; chain_stack_high = 0;
        DROP(root);
        if (fwp_gc.budget != before || fwp_gc.enabled || fwp_gc.ncollect) return 171;
        printf("%d\t%llu\n", sizes[i], (unsigned long long)(chain_stack_high-chain_stack_low));
    }
    return 0;
}
"#
    .replace("DROP", drop);
    measured.push_str(&probe);
    let artifacts = std::env::var_os("FWP_CHAIN_ARTIFACTS").map(std::path::PathBuf::from);
    if let Some(folder) = &artifacts {
        std::fs::create_dir_all(folder).unwrap();
        std::fs::write(folder.join("chain.c"), &measured).unwrap();
    }
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("chain{opt}.exe"));
        fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
        let output = checked(
            Command::new(&binary)
                .env("FWP_GC", "0")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0"),
        );
        let text = String::from_utf8(output.stdout).unwrap();
        let spans: Vec<u64> = text
            .lines()
            .map(|line| line.split('\t').nth(1).unwrap().parse().unwrap())
            .collect();
        assert_eq!(spans.len(), 2);
        assert!(
            spans[1] > spans[0] * 4,
            "baseline should expose growing stack usage: {text}"
        );
        println!("{opt}: {text}");
        if let Some(folder) = &artifacts {
            std::fs::write(folder.join(format!("stack{opt}.tsv")), text).unwrap();
            std::fs::copy(&binary, folder.join(format!("chain{opt}.exe"))).unwrap();
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
