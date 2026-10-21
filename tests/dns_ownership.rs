//! DNS owns address lists and temporary operating-system resolver storage.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
fn emitted(source: &str, arc: bool, dir: &fwp::cgen::TempDir) -> String {
    let input = dir.join("main.fwp");
    let cfile = dir.join("main.c");
    std::fs::write(&input, source).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--gc",
                if arc { "arc" } else { "tracing" },
                "--emit-c",
            ])
            .arg(input)
            .arg("-o")
            .arg(&cfile),
    );
    std::fs::read_to_string(cfile).unwrap()
}

#[test]
fn dns_results_preserve_values_aliases_and_release_storage() {
    let dir = fwp::cgen::TempDir::new("dns-ownership").unwrap();
    let source = include_str!("fixtures/dns_ownership.fwp");
    let input = dir.join("main.fwp");
    std::fs::write(&input, source).unwrap();
    let raw = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env("FWP_NO_OPT", "1")
            .arg(&input),
    );
    let optimized = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .env_remove("FWP_NO_OPT")
            .arg(&input),
    );
    assert_eq!(
        (&raw.stdout, &raw.stderr),
        (&optimized.stdout, &optimized.stderr)
    );
    for arc in [false, true] {
        let code = emitted(source, arc, &dir);
        for opt in ["-O1", "-O2"] {
            let binary = dir.join("dns.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let native = checked(
                Command::new(&binary)
                    .env("FWP_GC_STRESS", if arc { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if arc { "0" } else { "1" })
                    .env("FWP_REUSE_VERIFY", if arc { "0" } else { "1" }),
            );
            assert_eq!((&native.stdout, &native.stderr), (&raw.stdout, &raw.stderr));
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let end = start + code[start..].find("\n}\n").unwrap() + 3;
            let body = code[start..end]
                .replace(
                    "    fwp_init_consts();\n",
                    "    fwp_init_consts();\n    intptr_t dns_budget=fwp_gc.budget;\n",
                )
                .replace(
                    "    /* Ownership observation point: before runtime teardown. */\n",
                    "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_gc.budget!=dns_budget) exit(248);\n",
                );
            let mut measured = code.clone();
            measured.replace_range(start..end, &body);
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            let native = checked(
                Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            assert_eq!(native.stdout, raw.stdout);
        }
    }
}

#[test]
fn dns_releases_partial_lists_and_resolver_storage() {
    let dir = fwp::cgen::TempDir::new("dns-cleanup").unwrap();
    for arc in [false, true] {
        let code = emitted(include_str!("fixtures/dns_ownership.fwp"), arc, &dir);
        let line = code
            .lines()
            .find(|line| line.contains("return fwp_p_dns_resolve(l0,"))
            .unwrap();
        let args = line
            .trim()
            .strip_prefix("return fwp_p_dns_resolve(l0, ")
            .unwrap()
            .strip_suffix(");")
            .unwrap();
        let (err, list) = args.split_once(", ").unwrap();
        let descriptors = format!("#define DNS_ERROR ({err})\n#define DNS_LIST ({list})\n");
        let mut code = code.replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1");
        let declaration = "typedef uint64_t V;";
        code = code.replace(
            declaration,
            &format!("{declaration}\nstatic void dns_allocation(void);"),
        );
        let init = "static inline void *fwp_alloc_init(size_t n) {";
        let slow = "static inline void *fwp_gc_alloc(size_t n, int leaf) {";
        assert!(code.contains(init) && code.contains(slow));
        code = code
            .replace(init, &format!("{init} dns_allocation();"))
            .replace(slow, &format!("{slow} if(leaf!=0) dns_allocation();"));
        for (marker, ending) in [
            ("static void fwp_addrinfo_release(", "\n}\n"),
            ("static V fwp_p_dns_resolve(", "\n}\n"),
        ] {
            let start = code.find(marker).unwrap();
            let end = start + code[start..].find(ending).unwrap() + ending.len();
            let resolver = code[start..end]
                .replace("getaddrinfo(", "dns_getaddrinfo(")
                .replace("freeaddrinfo(", "dns_freeaddrinfo(");
            code.replace_range(start..end, &resolver);
        }
        let start = code.find("static void fwp_addrinfo_release(").unwrap();
        code.insert_str(start, include_str!("fixtures/dns_resolver.c"));
        let code = code[..code.find("int main(").unwrap()].to_string()
            + &descriptors
            + include_str!("fixtures/dns_cleanup.c");
        let no_os_cleanup = code.replace("dns_freeaddrinfo(*result);", "(void)*result;");
        let no_list_cleanup = code.replace(
            "fwp_value_owner list = {0, list_type->drop};",
            "fwp_value_owner list = {0, NULL};",
        );
        assert_ne!(code, no_os_cleanup);
        assert_ne!(code, no_list_cleanup);
        for opt in ["-O1", "-O2"] {
            for (source, expected) in [(&code, 0), (&no_os_cleanup, 248), (&no_list_cleanup, 248)] {
                let binary = dir.join("dns-cleanup.exe");
                fwp::cgen::compile_c(source, &binary, opt).unwrap();
                let output = Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{arc}/{opt}: {output:?}"
                );
                if expected == 0 && opt == "-O2" {
                    if let Some(path) = std::env::var_os("FWP_DECODER_ARTIFACTS") {
                        let path = std::path::PathBuf::from(path);
                        std::fs::create_dir_all(&path).unwrap();
                        let label = format!("dns-{}", if arc { "arc" } else { "tracing" });
                        std::fs::write(path.join(format!("{label}.c")), source).unwrap();
                        std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                        std::fs::write(path.join(format!("{label}.txt")), output.stdout).unwrap();
                    }
                }
            }
        }
    }
}
