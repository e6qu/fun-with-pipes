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
        (
            "ownership-scopes",
            include_str!("../docs/tutorials/23-ownership-scopes/main.fwp"),
        ),
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
            if name == "ownership-scopes" && stack == "0" {
                let release = "    fwp_native_tasks_finish();";
                assert_eq!(measured.matches(release).count(), 1);
                let omitted = measured.replace(release, "    /* omit scheduler shutdown */");
                let binary = dir.join("retained-scheduler.exe");
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
                    "scheduler retention must fail the ledger: {actual:?}"
                );
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
fn arc_checks_reject_counted_owners_at_uncounted_boundaries() {
    let dir = fwp::cgen::TempDir::new("arc-escape-check").unwrap();
    let input = dir.join("main.fwp");
    let cfile = dir.join("main.c");
    std::fs::write(&input, "main = 7 | echo\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc", "arc", "--emit-c", "-o"])
            .arg(&cfile)
            .arg(input),
    );
    let generated = std::fs::read_to_string(cfile).unwrap();
    let entry = "    fwp_init_consts();\n";
    assert_eq!(generated.matches(entry).count(), 1);
    let code = generated.replace(entry, &format!("{entry}\n    V probe = PTR(fwp_alloc_init(16));\n    if (getenv(\"FWP_TEST_COUNTED_ESCAPE\")) fwp_rc_fresh(probe);\n    fwp_rc_share(FWP_UNIT);\n    fwp_rc_share(probe);\n    fwp_mem_free((void *)(uintptr_t)probe);\n"));
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("probe{opt}.exe"));
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for invalid in [false, true] {
            let mut command = Command::new(&binary);
            command
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .env_remove("FWP_TEST_COUNTED_ESCAPE");
            if invalid {
                command.env("FWP_TEST_COUNTED_ESCAPE", "1");
            }
            let out = command.output().unwrap();
            if invalid {
                assert_eq!(out.status.code(), Some(101), "{opt}: {out:?}");
                assert!(String::from_utf8_lossy(&out.stderr)
                    .contains("counted owner escaped ARC contract"));
                assert!(out.stdout.is_empty(), "{out:?}");
            } else {
                assert!(out.status.success(), "{opt}: {out:?}");
                assert_eq!(out.stdout, b"7\n");
                assert!(out.stderr.is_empty(), "{out:?}");
            }
        }
    }
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
        ("http-stream-channel","streams : I64 -> Channel[H2Stream] ! {Async}\nstreams = channel.make\nmain = streams 1 | channel.close\n","channel payloads cannot contain"),
        ("wrapped-http-stream-channel","streams : I64 -> Channel[List[H2Stream]] ! {Async}\nstreams = channel.make\nmain = streams 1 | channel.close\n","channel payloads cannot contain"),
        ("cyclic-channel","Link = | Node (Channel[Link])\nlinks : I64 -> Channel[Link] ! {Async}\nlinks = channel.make\nmain = links 1 | channel.close\n","channel payloads cannot contain"),
        ("record-channel","Event = { callback: Option[I64 -> String] }\nevents : I64 -> Channel[Event] ! {Async}\nevents = channel.make\nmain = events 1 | channel.close\n","payload.callback.Option[0]"),
        ("unscoped-tape","main = 1 | ad.tape | echo\n","tracing-free lifetime policy"),
    ] {
        let input=dir.join(format!("{name}.fwp"));
        std::fs::write(&input,source).unwrap();
        let out=Command::new(env!("CARGO_BIN_EXE_fwp")).args(["build","--gc","arc","--emit-c"]).arg(&input).arg("-o").arg(dir.join("rejected.c")).output().unwrap();
        assert!(!out.status.success());
        let error=String::from_utf8_lossy(&out.stderr);
        assert!(error.contains("--gc arc") && error.contains(reason),"{error}");
        if name.contains("channel") {
            assert!(error.contains("missing cycle-freedom proof, not a demonstrated cycle"), "{error}");
            assert!(error.contains("queue data or non-owning IDs instead"), "{error}");
        }
    }
    let input = dir.join("valid.fwp");
    std::fs::write(&input, "main = 42 | echo\n").unwrap();
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
    for (shape, source, nested) in [
        (
            "optional",
            include_str!("fixtures/wrapped_chain.fwp"),
            false,
        ),
        (
            "tuple",
            include_str!("fixtures/wrapped_chain_tuple.fwp"),
            true,
        ),
    ] {
        let dir =
            std::env::temp_dir().join(format!("fwp-chain-cleanup-{}-{shape}", std::process::id()));
        std::fs::create_dir_all(&dir).unwrap();
        let input = dir.join("wrapped_chain.fwp");
        std::fs::write(&input, source).unwrap();
        let fwp = env!("CARGO_BIN_EXE_fwp");
        let reference = checked(
            Command::new(fwp)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&input),
        );
        assert!(reference.stdout.starts_with(b"(Some \"63\", "));
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
        let option_marker = if nested {
            "/* Option[(String, Link)] */\nstatic void "
        } else {
            "/* Option[Link] */\nstatic void "
        };
        let option_start = code.find(option_marker).unwrap() + option_marker.len();
        let option_drop = code[option_start..].split('(').next().unwrap();
        let tuple_drop = if nested {
            let marker = "/* (String, Link) */\nstatic void ";
            let start = code.find(marker).unwrap() + marker.len();
            Some(code[start..].split('(').next().unwrap())
        } else {
            None
        };
        let string_marker = "/* String */\nstatic void ";
        let string_start = code.find(string_marker).unwrap() + string_marker.len();
        let string_drop = code[string_start..].split('(').next().unwrap();
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
    const int sizes[] = {64, 1024, 16384};
    const int nested = NESTED;
    for (int i = 0; i < 3; i++) for (int mode = 0; mode < 4 + nested; mode++) {
        intptr_t before = fwp_gc.budget;
        V root = 0, alias = 0;
        for (int n = 0; n < sizes[i]; n++) {
            V text = fwp_rc_fresh(fwp_str_new("value", 5));
            V inner = root;
            if (nested && n) inner = fwp_rc_fresh(fwp_tuple2(fwp_rc_fresh(fwp_str_new("extra", 5)), root));
            V next = n ? fwp_rc_fresh(fwp_some(inner)) : FWP_NONE;
            root = fwp_rc_fresh(fwp_record(2, (V[]){text, next}));
            if (n == sizes[i]/2 && mode >= 2) {
                alias = mode == 2 ? root : mode == 3 ? next : inner;
                fwp_rc_dup(alias);
            }
        }
        if (mode == 1) { alias = root; fwp_rc_dup(alias); }
        chain_stack_low = UINTPTR_MAX; chain_stack_high = 0;
        DROP(root);
        if (alias) {
            V kept = mode == 3 ? OBJ(alias)->f[0] : alias;
            if (nested && mode >= 3) {
                V extra = OBJ(kept)->f[0];
                if (STR(extra)->len != 5 || memcmp(STR(extra)->d, "extra", 5)) return 176;
                kept = OBJ(kept)->f[1];
            }
            V text = OBJ(kept)->f[0];
            if (STR(text)->len != 5 || memcmp(STR(text)->d, "value", 5)) return 173;
            if (fwp_gc.budget >= before) return 174;
            if (mode == 4) { TUPLE_RELEASE }
            else if (mode == 3) OPTION_DROP(alias); else DROP(alias);
        }
        if (chain_stack_high-chain_stack_low > 4096) return 175;
        if (fwp_gc.budget != before || fwp_gc.enabled || fwp_gc.ncollect) return 171;
        printf("%d\t%d\t%llu\n", sizes[i], mode, (unsigned long long)(chain_stack_high-chain_stack_low));
    }
    return 0;
}
"#
    .replace("NESTED", if nested { "1" } else { "0" })
    .replace("TUPLE_RELEASE", &tuple_drop.map(|name| format!("{name}(alias);")).unwrap_or_else(|| "abort();".into()))
    .replace("OPTION_DROP", option_drop).replace("DROP", drop);
        measured.push_str(&probe);
        let artifacts = std::env::var_os("FWP_CHAIN_ARTIFACTS")
            .map(|path| std::path::PathBuf::from(path).join(shape));
        if let Some(folder) = &artifacts {
            std::fs::create_dir_all(folder).unwrap();
            std::fs::write(folder.join("chain.c"), &measured).unwrap();
            std::fs::write(folder.join("language.c"), &code).unwrap();
            std::fs::write(
                folder.join("source.txt"),
                checked(Command::new("git").args(["rev-parse", "HEAD"])).stdout,
            )
            .unwrap();
            std::fs::write(
                folder.join("rust.txt"),
                checked(Command::new("rustc").args(["--version", "--verbose"])).stdout,
            )
            .unwrap();
            let hardware = if cfg!(target_os = "linux") {
                checked(&mut Command::new("lscpu"))
            } else if cfg!(target_os = "macos") {
                checked(Command::new("sysctl").args(["machdep.cpu", "hw.memsize"]))
            } else if cfg!(target_os = "windows") {
                checked(Command::new("powershell").args(["-NoProfile", "-Command", "Get-CimInstance Win32_Processor | Format-List Name,Architecture,NumberOfCores,NumberOfLogicalProcessors"]))
            } else {
                panic!("chain artifacts require a supported native measurement host");
            };
            std::fs::write(folder.join("cpu.txt"), hardware.stdout).unwrap();
            let compiler = std::env::var("CC").expect("artifact collection requires the actual CC");
            std::fs::write(
                folder.join("c.txt"),
                checked(Command::new(compiler).arg("--version")).stdout,
            )
            .unwrap();
        }
        for opt in ["-O1", "-O2"] {
            let language = dir.join(format!("language{opt}.exe"));
            fwp::cgen::compile_c(&code, &language, opt).unwrap();
            let actual = checked(
                Command::new(&language)
                    .env("FWP_GC", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            assert_eq!(actual.stdout, reference.stdout);
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
                .map(|line| line.split('\t').nth(2).unwrap().parse().unwrap())
                .collect();
            assert_eq!(spans.len(), if nested { 15 } else { 12 });
            assert!(
                spans.iter().all(|span| *span <= 4096),
                "cleanup stack grew: {text}"
            );
            println!("{opt}: {text}");
            if let Some(folder) = &artifacts {
                std::fs::write(folder.join(format!("stack{opt}.tsv")), text).unwrap();
                std::fs::copy(&binary, folder.join(format!("chain{opt}.exe"))).unwrap();
                std::fs::copy(&language, folder.join(format!("language{opt}.exe"))).unwrap();
            }
        }

        // The real program also keeps its result under collection, poisoning,
        // and count-only execution. Physical reclamation is measured above in
        // checked ARC, where retained-storage poisoning is intentionally illegal.
        for free in ["0", "1"] {
            let hybrid_c = dir.join(format!("hybrid-{free}.c"));
            checked(
                Command::new(fwp)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", "0")
                    .env("FWP_FREE", free)
                    .args(["build", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&hybrid_c),
            );
            let hybrid = std::fs::read_to_string(&hybrid_c).unwrap();
            let binary = dir.join(format!("hybrid-{free}.exe"));
            fwp::cgen::compile_c(&hybrid, &binary, "-O2").unwrap();
            let output = checked(
                Command::new(&binary)
                    .env("FWP_GC", "1")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "1"),
            );
            assert_eq!(output.stdout, reference.stdout, "{shape} free={free}");
        }

        // Restore the old recursive structure for these generated types. The
        // same bound must then fail, proving this probe detects growing stack use.
        let mut recursive = measured.clone();
        let mut recursive_bodies = vec![
            (
                drop,
                format!("{string_drop}(OBJ(v)->f[0]); {option_drop}(OBJ(v)->f[1]);"),
            ),
            (
                option_drop,
                format!("{}(OBJ(v)->f[0]);", tuple_drop.unwrap_or(drop)),
            ),
        ];
        if let Some(tuple) = tuple_drop {
            recursive_bodies.push((
                tuple,
                format!("{string_drop}(OBJ(v)->f[0]); {drop}(OBJ(v)->f[1]);"),
            ));
        }
        for (name, body) in recursive_bodies {
            let marker = format!("static void {name}(V v) {{\n");
            let begin = recursive.find(&marker).unwrap();
            let end = begin + recursive[begin..].find("\n}\n").unwrap() + 3;
            recursive.replace_range(begin..end, &format!("{marker}chain_observe();\nif (!fwp_rc_release_last(v)) return;\n{body}\nfwp_rc_free_obj(v);\n}}\n"));
        }
        let binary = dir.join("recursive-control.exe");
        fwp::cgen::compile_c(&recursive, &binary, "-O2").unwrap();
        let failed = Command::new(&binary)
            .env("FWP_GC", "0")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert_eq!(
            failed.status.code(),
            Some(175),
            "recursive control: {failed:?}"
        );
        std::fs::remove_dir_all(dir).unwrap();
    }
}
