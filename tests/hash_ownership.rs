//! Streaming structural hashes preserve canonical bytes and borrow their input.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
const SOURCE: &str = include_str!("fixtures/hash_values.fwp");
const OBSERVER: &str = include_str!("fixtures/hash_observer.c");
#[test]
fn hashes_match_typed_interpretation_and_preserve_aliases() {
    let dir = fwp::cgen::TempDir::new("hash-values").unwrap();
    let source = dir.join("values.fwp");
    std::fs::write(&source, SOURCE).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let raw = checked(
        Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&source)
            .env("FWP_NO_OPT", "1"),
    );
    let optimized = checked(Command::new(fwp).args(["run", "--interp"]).arg(&source));
    assert_eq!(raw.stdout, optimized.stdout);
    for arc in [false, true] {
        for opt in ["-O1", "-O2"] {
            let cfile = dir.join("values.c");
            let binary = dir.join("values.exe");
            let mut command = Command::new(fwp);
            command
                .arg("build")
                .arg(&source)
                .args(["--emit-c", "-o"])
                .arg(&cfile);
            if arc {
                command.args(["--gc", "arc"]);
            }
            checked(&mut command);
            let mut code = std::fs::read_to_string(cfile).unwrap();
            if arc {
                let start = code
                    .find("static void *fwp_main_thread(void *arg) {")
                    .unwrap();
                let finish = start + code[start..].find("\n}\n").unwrap() + 3;
                let thread = code[start..finish]
                    .replace(
                        "    fwp_init_consts();\n",
                        "    fwp_init_consts();\n    intptr_t hash_budget = fwp_gc.budget;\n",
                    )
                    .replace(
                        "    fwp_cl_finish();\n",
                        "    fwp_cl_finish();\n    if(fwp_gc.budget != hash_budget) exit(248);\n",
                    );
                code.replace_range(start..finish, &thread);
            }
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            if opt == "-O2" {
                if let Some(path) = std::env::var_os("FWP_HASH_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let mode = if arc { "arc" } else { "tracing" };
                    std::fs::copy(&binary, path.join(format!("hash-{mode}.exe"))).unwrap();
                    std::fs::write(path.join(format!("hash-{mode}.c")), &code).unwrap();
                    let mut command = Command::new(if cfg!(target_os = "macos") {
                        "otool"
                    } else if cfg!(target_os = "windows") {
                        "llvm-objdump"
                    } else {
                        "objdump"
                    });
                    command
                        .arg(if cfg!(target_os = "macos") {
                            "-tvV"
                        } else {
                            "-d"
                        })
                        .arg(&binary);
                    let assembly = checked(&mut command);
                    assert!(String::from_utf8_lossy(&assembly.stdout).contains("fwp_hash_value"));
                    std::fs::write(path.join(format!("hash-{mode}.asm")), assembly.stdout).unwrap();
                }
            }

            let mut run = Command::new(&binary);
            if arc {
                run.env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0");
            } else {
                run.env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "1");
            }
            let output = checked(&mut run);
            assert_eq!(output.stdout, raw.stdout, "{arc}, {opt}");
        }
    }
}
#[test]
fn hashing_allocates_nothing_and_the_buffered_control_is_detected() {
    let dir = fwp::cgen::TempDir::new("hash-counts").unwrap();
    let source = dir.join("probe.fwp");
    std::fs::write(&source, "main = 1.0f128 | echo\n").unwrap();
    let cfile = dir.join("probe.c");
    let binary = dir.join("probe.exe");
    for arc in [false, true] {
        let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
        command
            .arg("build")
            .arg(&source)
            .args(["--emit-c", "-o"])
            .arg(&cfile);
        if arc {
            command.args(["--gc", "arc"]);
        }
        checked(&mut command);
        let code = std::fs::read_to_string(&cfile).unwrap();
        let code = &code[..code.find("int main(").unwrap()];
        let native = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
        assert_eq!(code.matches(native).count(), 1);
        let code = code.replace(
            native,
            &format!("{native} if(hash_tracking)hash_requests++;"),
        );
        let buffered = r#"fwp_buf b={0};fwp_encode(&b,v,d);uint64_t h=0xcbf29ce484222325ULL;for(size_t i=0;i<b.len;i++){h^=(unsigned char)b.d[i];h*=0x100000001b3ULL;}free(b.d);return h;"#;
        let old = code.replace(
            "return fwp_hash_value(0xcbf29ce484222325ULL, v, d);",
            buffered,
        );
        assert_ne!(old, code);
        for opt in ["-O1", "-O2"] {
            for (candidate, expected) in [(&code, 0), (&old, 247)] {
                // Preserve the generated Windows API selection before observer
                // headers can select the CRT's older default.
                let preamble = "#if defined(_WIN32) && !defined(_WIN32_WINNT)\n#define _WIN32_WINNT 0x0a00\n#endif\n";
                assert_eq!(candidate.matches(preamble).count(), 1);
                let observed = candidate.replacen(preamble, &format!("{preamble}{OBSERVER}\n"), 1);
                fwp::cgen::compile_c(
                    &format!("{observed}\n{}", include_str!("fixtures/hash_counts.c")),
                    &binary,
                    opt,
                )
                .unwrap();
                let result = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    result.status.code(),
                    Some(expected),
                    "{arc}, {opt}: {result:?}"
                );
            }
        }
    }
}

#[test]
fn hash_and_bitwise_fusion_preserve_effects_traps_and_wide_values() {
    let dir = fwp::cgen::TempDir::new("hash-fusion").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        ("values", include_str!("fixtures/hash_fusion.fwp"), true, 0),
        ("borrowed-records", include_str!("fixtures/hash_borrowed_fields.fwp"), false, 0),
        ("effects", "main = range 0 3 | map (tap echo | hash) | fold (curry (tap echo | uncurry bit.xor)) 0u64 | echo\n", false, 0),
        ("distinct-traps", "main = [0, 9223372036854775807] | map (add 1 | hash) | fold (curry (const 0u64 | div 0u64)) 0u64 | echo\n", false, 101),
        ("shift-trap", "main = [1u8, 2u8] | map (bit.shl 8 | hash) | find (const True) | echo\n", false, 101),
        ("capture-order", r#"
left : () -> String ! {IO}
left = const "left" | tap echo
right : () -> String ! {IO}
right = const "right" | tap echo
input : () -> List[I64] ! {IO}
input = const [1, 2, 3] | tap (const "input" | echo)
main = input () | map (both (const (left ())) (const (right ())) | hash) | fold bit.xor 0u64 | echo
"#, true, 0),
        ("consumer-order", r#"
seed : () -> U64 ! {IO}
seed = const 0u64 | tap (const "seed" | echo)
capture : () -> I64 ! {IO}
capture = const 7 | tap (const "capture" | echo)
input : () -> List[I64] ! {IO}
input = const [1, 2, 3] | tap (const "input" | echo)
main = input () | map (both id (const (capture ())) | hash) | fold bit.xor (seed ()) | echo
"#, false, 0),
        ("capture-trap", r#"
input : () -> List[I64] ! {IO}
input = const [] | tap (const "input" | echo)
main = input () | map (both id (const (div 0 1)) | hash) | fold bit.xor 0u64 | echo
"#, true, 101),
    ];
    for (label, source, fused, status) in cases {
        let input = dir.join("main.fwp");
        std::fs::write(&input, source).unwrap();
        let raw = Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(raw.status.code(), Some(status), "{label}: {raw:?}");
        if label == "capture-order" {
            assert!(raw.stdout.starts_with(b"left\nright\ninput\n"));
        }
        if label == "consumer-order" {
            assert!(raw.stdout.starts_with(b"seed\ncapture\ninput\n"));
        }
        if label == "capture-trap" {
            assert!(raw.stdout.is_empty());
            assert!(String::from_utf8_lossy(&raw.stderr).contains("division by zero"));
        }
        if label == "distinct-traps" {
            assert!(String::from_utf8_lossy(&raw.stderr).contains("arithmetic overflow in I64"));
        }
        let interpreted = Command::new(compiler)
            .env_remove("FWP_NO_OPT")
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
            (&raw.stdout, &raw.stderr, raw.status.code()),
            "{label}"
        );
        for arc in [false, true] {
            let cfile = dir.join("main.c");
            let mut build = Command::new(compiler);
            build
                .env_remove("FWP_NO_OPT")
                .args(["build", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile);
            if arc {
                build.args(["--gc", "arc"]);
            }
            checked(&mut build);
            let code = std::fs::read_to_string(cfile).unwrap();
            assert_eq!(code.contains("/* fused :"), fused, "{label}");
            for opt in ["-O1", "-O2"] {
                let binary = dir.join("main.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let actual = Command::new(binary)
                    .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" })
                    .output()
                    .unwrap();
                assert_eq!(
                    (&actual.stdout, &actual.stderr, actual.status.code()),
                    (&raw.stdout, &raw.stderr, raw.status.code()),
                    "{label}/{arc}/{opt}"
                );
            }
        }
    }
}

#[test]
fn hash_reduction_removes_lists_and_temporary_heap_tuples() {
    let dir = fwp::cgen::TempDir::new("hash-fusion-counts").unwrap();
    let input = dir.join("main.fwp");
    std::fs::write(&input, "main = range 0 65 | map (both id (const (range 0 16 | array.from-list)) | hash) | fold bit.xor 0u64 | echo\n").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let raw = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for arc in [false, true] {
        for stack in [true, false] {
            let cfile = dir.join("main.c");
            let mut build = Command::new(compiler);
            build
                .env("FWP_STACK", if stack { "1" } else { "0" })
                .args(["build", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile);
            if arc {
                build.args(["--gc", "arc"]);
            }
            checked(&mut build);
            let mut code = std::fs::read_to_string(cfile).unwrap();
            assert!(code.contains("/* fused :"));
            let marker = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
            assert_eq!(code.matches(marker).count(), 1);
            code = code.replace(
                marker,
                &format!("static unsigned hash_requests, hash_retains;\n{marker} if(leaf!=0) hash_requests++;"),
            );
            let initialized = "static inline void *fwp_alloc_init(size_t n) {";
            assert_eq!(code.matches(initialized).count(), 1);
            code = code.replace(initialized, &format!("{initialized} hash_requests++;"));
            let retain = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
            assert_eq!(code.matches(retain).count(), 1);
            code = code.replace(retain, &format!("{retain} hash_retains++;"));
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let finish = start + code[start..].find("\n}\n").unwrap() + 3;
            let body = code[start..finish].replace("    fwp_init_consts();\n",
            "    fwp_init_consts();\n    hash_requests = 0; hash_retains = 0; intptr_t hash_budget = fwp_gc.budget;\n")
            .replace("    fwp_cl_finish();\n",
            "    fwp_cl_finish();\n    if(hash_requests > 35 || hash_retains || fwp_gc.budget != hash_budget) { fprintf(stderr, \"hash requests=%u retains=%u budget=%lld/%lld\\n\", hash_requests, hash_retains, (long long)fwp_gc.budget, (long long)hash_budget); exit(249); }\n");
            code.replace_range(start..finish, &body);
            if let Some(path) = std::env::var_os("FWP_HASH_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                std::fs::write(
                    path.join(format!("hash-counts-arc-{arc}-stack-{stack}.c")),
                    &code,
                )
                .unwrap();
            }
            // A 35-request budget allows input construction and fixed setup, but
            // excludes 65 per-hash heap tuples. Disabling stack placement must fail.
            for opt in ["-O1", "-O2"] {
                let binary = dir.join("main.exe");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let actual = Command::new(binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    actual.status.code(),
                    Some(if stack { 0 } else { 249 }),
                    "arc={arc} stack={stack} {opt}: {actual:?}"
                );
                assert_eq!(actual.stdout, raw.stdout);
            }
        }
    }
}
