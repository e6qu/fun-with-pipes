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

    let cfile = directory.join("precision.c");
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap()
            .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t precision_calls, precision_bytes;")
            .replace("static inline void *fwp_heap_alloc(size_t n, int kind) {", "static inline void *fwp_heap_alloc(size_t n, int kind) {\nif(kind!=0){precision_calls++;precision_bytes+=n;}")
            .replace("static inline void *fwp_alloc_init(size_t n) {", "static inline void *fwp_alloc_init(size_t n) {\nprecision_calls++;precision_bytes+=n;");
    let start = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    let (runtime, entry) = code.split_at(start);
    let entry = entry.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    size_t precision_live_bytes=0; precision_calls=precision_bytes=0;\n")
            .replace("    /* Ownership observation point: before runtime teardown. */\n", r#"    /* Ownership observation point: before runtime teardown. */
    if(fwp_owned_tapes)exit(193);
    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)exit(194);
    if(fwp_heap.live > precision_live_bytes)exit(195);
    if(!precision_calls)exit(196);
    fprintf(stderr,"precision-profile {\"managedRequests\":%llu,\"managedRequestedBytes\":%llu,\"finalChargedDelta\":%lld}\n",
        (unsigned long long)precision_calls,(unsigned long long)precision_bytes,
        (long long)(fwp_heap.live - precision_live_bytes));
"#);
    let measured = format!("{runtime}{entry}");
    let binary = directory.join("precision.exe");
    for optimization in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&measured, &binary, optimization).unwrap();
        for cache in ["0", "1"] {
            let output = checked(Command::new(&binary).env("FWP_AD_WORKSPACE", cache));
            assert_eq!(
                output.stdout, reference.stdout,
                "counted {optimization} cache={cache}"
            );
            let stderr = String::from_utf8(output.stderr).unwrap();
            let profile = stderr.strip_prefix("precision-profile ").expect(&stderr);
            assert_eq!(profile.lines().count(), 1);
            let report = fwp::json::Json::parse(profile).unwrap();
            let fwp::json::Json::Obj(fields) = &report else {
                panic!("invalid precision report");
            };
            assert_eq!(fields.len(), 3);
            for field in ["managedRequests", "managedRequestedBytes"] {
                let Some(fwp::json::Json::Num(value)) = report.get(field) else {
                    panic!("missing {field}");
                };
                assert!(value.parse::<u64>().unwrap() > 0);
            }
            assert_eq!(
                report.get("finalChargedDelta"),
                Some(&fwp::json::Json::Num("0".to_owned()))
            );
            if let Some(path) = std::env::var_os("FWP_AD_PRECISION_ARTIFACTS") {
                let path = std::path::PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                std::fs::write(
                    path.join(format!("counted{optimization}-cache{cache}.json")),
                    profile,
                )
                .unwrap();
                std::fs::write(path.join("counted.c"), &measured).unwrap();
            }
        }
    }

    let release =
        "    fwp_mem_free(owner->weights); fwp_mem_free(owner->adj); fwp_mem_free(owner);";
    assert_eq!(measured.matches(release).count(), 1);
    fwp::cgen::compile_c(&measured.replace(release, ""), &binary, "-O2").unwrap();
    let output = Command::new(&binary)
        .env("FWP_AD_WORKSPACE", "0")
        .output()
        .unwrap();
    assert_eq!(
        output.status.code(),
        Some(195),
        "missing tape release: {output:?}"
    );
}
