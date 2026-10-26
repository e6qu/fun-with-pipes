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
fn numeric_hash_loops_preserve_widths_slices_and_shared_values() {
    let dir = fwp::cgen::TempDir::new("numeric-hashes").unwrap();
    let input = dir.join("values.fwp");
    std::fs::write(&input, include_str!("fixtures/numeric_hashes.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let raw = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for typed in ["0", "1"] {
        for packed in ["0", "1"] {
            for memory in ["arc", "tracing"] {
                let cfile = dir.join("values.c");
                checked(
                    Command::new(compiler)
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_TYPED_HASH", typed)
                        .env("FWP_PACKED_ARRAYS", packed)
                        .args(["build", "--gc", memory, "--emit-c"])
                        .arg(&input)
                        .arg("-o")
                        .arg(&cfile),
                );
                let code = std::fs::read_to_string(cfile).unwrap();
                assert_eq!(
                    code.contains("/* numeric hash without type dispatch */"),
                    typed == "1"
                );
                for opt in ["-O0", "-O2"] {
                    let binary = dir.join("values.exe");
                    fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                    let stress = if memory == "arc" { "0" } else { "1" };
                    let actual = checked(
                        Command::new(&binary)
                            .env_remove("FWP_GC")
                            .env("FWP_GC_STRESS", stress)
                            .env("FWP_GC_VERIFY", stress)
                            .env("FWP_REUSE_VERIFY", stress),
                    );
                    assert_eq!(actual.stdout, raw.stdout, "{typed}/{packed}/{memory}/{opt}");
                    assert_eq!(actual.stderr, raw.stderr, "{typed}/{packed}/{memory}/{opt}");
                    if let Some(root) = std::env::var_os("FWP_HASH_ARTIFACTS") {
                        let root = std::path::Path::new(&root).join("numeric");
                        std::fs::create_dir_all(&root).unwrap();
                        let label = format!("typed-{typed}-packed-{packed}-{memory}{opt}");
                        std::fs::write(root.join(format!("{label}.c")), &code).unwrap();
                        std::fs::copy(&binary, root.join(format!("{label}.exe"))).unwrap();
                    }
                }
            }
        }
    }
}

#[test]
fn numeric_hash_loops_allocate_nothing_and_do_not_adjust_reference_counts() {
    let dir = fwp::cgen::TempDir::new("numeric-hash-counts").unwrap();
    let input = dir.join("values.fwp");
    std::fs::write(&input, include_str!("fixtures/numeric_hashes.fwp")).unwrap();
    for memory in ["arc", "tracing"] {
        let cfile = dir.join("values.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_TYPED_HASH", "1")
                .env("FWP_PACKED_ARRAYS", "1")
                .args(["build", "--gc", memory, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let preamble =
            "#if defined(_WIN32) && !defined(_WIN32_WINNT)\n#define _WIN32_WINNT 0x0a00\n#endif\n";
        assert_eq!(code.matches(preamble).count(), 1);
        let mut code = code.replacen(
            preamble,
            &format!("{preamble}{OBSERVER}\nstatic volatile uint64_t hash_refops;\n"),
            1,
        );
        for signature in [
            "static inline void fwp_rc_dup(V v) {",
            "static inline void fwp_rc_drop(V v) {",
            "static inline int fwp_rc_release_last(V v) {",
            "static void fwp_rc_share(V v) {",
        ] {
            assert!(code.contains(signature));
            code = code.replace(
                signature,
                &format!("{signature} if(hash_tracking)hash_refops++;"),
            );
        }
        for signature in [
            "static inline void *fwp_heap_alloc(size_t n, int kind) {",
            "static inline void *fwp_alloc_init(size_t n) {",
        ] {
            assert!(code.contains(signature));
            code = code.replace(
                signature,
                &format!("{signature} if(hash_tracking)hash_requests++;"),
            );
        }
        let begin = "/* numeric hash without type dispatch */";
        assert!(code.contains(begin));
        let start = "hash_tracking=1; hash_requests=0; hash_refops=0;";
        code = code.replace(begin, &format!("{begin} {start}"));
        code = code.replace("return hash_state;",
            "if(hash_requests)exit(247); if(hash_refops)exit(248); hash_tracking=0; return hash_state;");
        let allocated = code.replace(
            start,
            &format!("{start} void *unneeded=malloc(1); free(unneeded);"),
        );
        let counted = code.replace(start, &format!("{start} fwp_rc_dup(0);"));
        for opt in ["-O0", "-O2"] {
            for (candidate, status) in [(&code, 0), (&allocated, 247), (&counted, 248)] {
                let binary = dir.join("probe.exe");
                fwp::cgen::compile_c(candidate, &binary, opt).unwrap();
                let actual = Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    actual.status.code(),
                    Some(status),
                    "{memory}/{opt}: {actual:?}"
                );
            }
        }
    }
}

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
            command.args(["--gc", if arc { "arc" } else { "tracing" }]);
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
                        "    fwp_init_consts();\n    size_t hash_live_bytes = fwp_heap.live;\n",
                    )
                    .replace(
                        "    /* Ownership observation point: before runtime teardown. */\n",
                        "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.live != hash_live_bytes) exit(248);\n",
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
        command.args(["--gc", if arc { "arc" } else { "tracing" }]);
        checked(&mut command);
        let code = std::fs::read_to_string(&cfile).unwrap();
        let code = &code[..code.find("int main(").unwrap()];
        let native = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
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
        ("consumer-order", include_str!("fixtures/hash_capture_order.fwp"), false, 0),
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
            build.args(["--gc", if arc { "arc" } else { "tracing" }]);
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
            build.args(["--gc", if arc { "arc" } else { "tracing" }]);
            checked(&mut build);
            let mut code = std::fs::read_to_string(cfile).unwrap();
            assert!(code.contains("/* fused :"));
            let marker = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
            assert_eq!(code.matches(marker).count(), 1);
            code = code.replace(
                marker,
                &format!("static unsigned hash_requests, hash_retains;\n{marker} if(kind!=0) hash_requests++;"),
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
            "    fwp_init_consts();\n    hash_requests = 0; hash_retains = 0; size_t hash_live_bytes = fwp_heap.live;\n")
            .replace("    /* Ownership observation point: before runtime teardown. */\n",
            "    /* Ownership observation point: before runtime teardown. */\n    if(hash_requests > 35 || hash_retains || fwp_heap.live != hash_live_bytes) { fprintf(stderr, \"hash requests=%u retains=%u budget=%lld/%lld\\n\", hash_requests, hash_retains, (long long)fwp_heap.live, (long long)hash_live_bytes); exit(249); }\n");
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
