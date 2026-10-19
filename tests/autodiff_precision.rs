//! F128 reverse weights, seeds and adjoints retain F128 precision and ownership.
use std::process::{Command, Output};
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}
#[test]
fn quad_reverse_preserves_low_bits_exponent_range_and_reclaims_owned_values() {
    let directory = fwp::cgen::TempDir::new("quad-gradient-precision").unwrap();
    let input = directory.join("precision.fwp");
    std::fs::write(&input, include_str!("fixtures/quad_gradient_precision.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    assert_eq!(reference.stdout, "True\n".repeat(10).as_bytes());
    assert!(reference.stderr.is_empty());
    for gc in ["tracing", "arc"] {
        let cfile = directory.join("precision.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", gc, "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap()
            .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t precision_calls, precision_bytes;")
            .replace("static inline void *fwp_gc_alloc(size_t n, int leaf) {", "static inline void *fwp_gc_alloc(size_t n, int leaf) {\nif(leaf!=0){precision_calls++;precision_bytes+=n;}")
            .replace("static inline void *fwp_alloc_init(size_t n) {", "static inline void *fwp_alloc_init(size_t n) {\nprecision_calls++;precision_bytes+=n;");
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (runtime, entry) = code.split_at(start);
        let entry = entry.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t precision_budget=fwp_gc.budget_given; precision_calls=precision_bytes=0;\n")
            .replace("    fwp_cl_finish();\n", r#"    fwp_cl_finish();
    if(fwp_owned_tapes)exit(193);
    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)exit(194);
#if FWP_ARC_ONLY
    if(fwp_gc.enabled || fwp_gc.ncollect || fwp_gc.budget<precision_budget)exit(195);
#endif
    if(!precision_calls)exit(196);
    fprintf(stderr,"precision-profile {\"managedRequests\":%llu,\"managedRequestedBytes\":%llu,\"finalChargedDelta\":%lld,\"collections\":%zu}\n",
        (unsigned long long)precision_calls,(unsigned long long)precision_bytes,
        (long long)(precision_budget-fwp_gc.budget),fwp_gc.ncollect);
"#);
        let measured = format!("{runtime}{entry}");
        let binary = directory.join("precision.exe");
        for optimization in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&measured, &binary, optimization).unwrap();
            for cache in ["0", "1"] {
                let verify = if gc == "arc" { "0" } else { "1" };
                let output = checked(
                    Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_AD_WORKSPACE", cache)
                        .env("FWP_GC_STRESS", verify)
                        .env("FWP_GC_VERIFY", verify)
                        .env("FWP_REUSE_VERIFY", verify),
                );
                assert_eq!(
                    output.stdout, reference.stdout,
                    "{gc} {optimization} cache={cache}"
                );
                let stderr = String::from_utf8(output.stderr).unwrap();
                let profile = stderr.strip_prefix("precision-profile ").expect(&stderr);
                assert_eq!(profile.lines().count(), 1);
                if let Some(path) = std::env::var_os("FWP_AD_PRECISION_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    std::fs::write(
                        path.join(format!("{gc}{optimization}-cache{cache}.json")),
                        profile,
                    )
                    .unwrap();
                    std::fs::write(path.join(format!("{gc}.c")), &measured).unwrap();
                }
            }
        }
        if gc == "arc" {
            let release =
                "    fwp_mem_free(owner->weights); fwp_mem_free(owner->adj); fwp_mem_free(owner);";
            assert_eq!(measured.matches(release).count(), 1);
            fwp::cgen::compile_c(&measured.replace(release, ""), &binary, "-O2").unwrap();
            let output = Command::new(&binary)
                .env_remove("FWP_GC")
                .env("FWP_AD_WORKSPACE", "0")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                output.status.code(),
                Some(195),
                "missing tape release: {output:?}"
            );
        }
    }
}
