//! F128 reverse weights, seeds and adjoints retain F128 precision and ownership.
use std::process::{Command, Output};
#[path = "support/record_probe.rs"]
mod record_probe;
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

#[test]
fn analytic_numerical_and_branch_derivatives_agree_in_both_formats() {
    let directory = fwp::cgen::TempDir::new("derivative-domains").unwrap();
    let input = directory.join("domains.fwp");
    let mut source = String::from(
        "quartic : t -> t where Ring[t], Dup[t]\nquartic = fork mul id id | fork mul id id\n\
         loss : List[t] -> t where Ring[t], Dup[t]\nloss = head | option.unwrap-or zero | quartic\n",
    );
    let mut checks = Vec::new();
    for (name, ty, suffix, denominator, tolerance) in [
        ("double", "F64", "", "65536.0", "8e-9"),
        ("quad", "F128", "f128", "1099511627776.0f128", "1e-20f128"),
    ] {
        source.push_str(&format!(
            "h-{name} : {ty}\nh-{name} = 1.0{suffix} | div {denominator}\n\
             analytic-{name} : {ty} -> {ty}\n\
             analytic-{name} = fork mul id (fork mul id id) | mul 4.0{suffix}\n\
             numerical-{name} : {ty} -> {ty}\n\
             numerical-{name} = fork sub (sub h-{name} | quartic) (add h-{name} | quartic) | div (h-{name} | mul 2.0{suffix})\n\
             reverse-{name} : {ty} -> {ty}\n\
             reverse-{name} = singleton | grad loss | head | option.unwrap-or 0.0{suffix}\n\
             branch-{name} : List[Rev[{ty}]] -> Rev[{ty}]\n\
             branch-{name} = head | option.unwrap-or (rev.const 0.0{suffix}) | if (.value | lt 0.0{suffix}) neg id\n"
        ));
        let points = format!("[-2.0{suffix}, -0.5{suffix}, 0.5{suffix}, 2.0{suffix}]");
        checks.push(format!(
            "{points} | all (fork eq analytic-{name} reverse-{name})"
        ));
        checks.push(format!(
            "{points} | all (fork eq analytic-{name} (derivative quartic))"
        ));
        checks.push(format!(
            "{points} | all (fork sub numerical-{name} reverse-{name} | abs | lt {tolerance})"
        ));
        for (call, expected) in [
            ("grad loss", "0.5"),
            ("grad (grad loss | sum)", "3.0"),
            ("grad (grad (grad loss | sum) | sum)", "12.0"),
        ] {
            checks.push(format!("[0.5{suffix}] | {call} | eq [{expected}{suffix}]"));
        }
        for (value, derivative) in [("-0.5", "-1.0"), ("0.5", "1.0")] {
            checks.push(format!(
                "[{value}{suffix}] | grad branch-{name} | eq [{derivative}{suffix}]"
            ));
        }
        for (value, derivative) in [
            (format!("h-{name} | neg"), "-1.0"),
            (format!("h-{name}"), "1.0"),
            (format!("0.0{suffix}"), "1.0"),
        ] {
            // At zero this checks the selected branch, not differentiability.
            checks.push(format!(
                "[{value}] | grad branch-{name} | eq [{derivative}{suffix}]"
            ));
        }
        checks.push(format!(
            "[0.5{suffix}] | fork eq (vjp (rev._replay 3 (map quartic)) [1.0{suffix}]) \
             (vjp-checkpointed {{steps = 3, every = 2}} (map quartic) [1.0{suffix}])"
        ));
    }
    source.push_str("main = [\n");
    for check in &checks {
        source.push_str(&format!("    {check} | echo,\n"));
    }
    source.push_str("] | ignore\n");
    std::fs::write(&input, &source).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&input)
        .output()
        .unwrap();
    if let Some(path) = std::env::var_os("FWP_AD_PRECISION_ARTIFACTS") {
        let path = std::path::PathBuf::from(path);
        std::fs::create_dir_all(&path).unwrap();
        std::fs::write(path.join("domains.fwp"), &source).unwrap();
        std::fs::write(path.join("domains.raw.stdout"), &reference.stdout).unwrap();
        std::fs::write(path.join("domains.raw.stderr"), &reference.stderr).unwrap();
    }
    assert!(
        reference.status.success(),
        "raw derivative domains: {reference:?}"
    );
    assert_eq!(reference.stdout, "True\n".repeat(checks.len()).as_bytes());
    assert!(reference.stderr.is_empty());
    let cfile = directory.join("domains.c");
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--emit-c", "-O2"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    for optimization in ["-O1", "-O2"] {
        let binary = directory.join("domains.exe");
        fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
        for workspace in ["0", "1"] {
            let result = Command::new(&binary)
                .env("FWP_AD_WORKSPACE", workspace)
                .output()
                .unwrap();
            record_probe::save(
                "autodiff_precision",
                &format!("domains{optimization}-workspace{workspace}"),
                &code,
                &binary,
                &result,
            );
            assert!(
                result.status.success(),
                "{optimization}, workspace={workspace}: {result:?}"
            );
            assert_eq!(result.stdout, reference.stdout);
            assert!(result.stderr.is_empty());
        }
    }
}
