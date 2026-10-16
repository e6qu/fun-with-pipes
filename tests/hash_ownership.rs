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
