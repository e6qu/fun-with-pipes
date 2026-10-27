//! Known String maps move input owners; aliases and callback exits remain safe.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn string_maps_preserve_values_and_release_each_exit() {
    let dir = fwp::cgen::TempDir::new("string-map").unwrap();
    let source = dir.join("strings.fwp");
    std::fs::write(&source, include_str!("fixtures/string_map_ownership.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let inputs = [
        "",
        "One TWO ,Three. λ",
        "AbC abc AbC",
        "A\tB\nC",
        "One TWO STOP Four",
    ];
    let references: Vec<_> = inputs
        .iter()
        .map(|input| {
            let raw = checked(
                Command::new(compiler)
                    .env("FWP_NO_OPT", "1")
                    .env("FWP_TEXT_INPUT", input)
                    .args(["run", "--interp"])
                    .arg(&source),
            );
            let optimized = checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_TEXT_INPUT", input)
                    .args(["run", "--interp"])
                    .arg(&source),
            );
            assert_eq!(
                (&raw.stdout, &raw.stderr),
                (&optimized.stdout, &optimized.stderr)
            );
            assert!(!raw.stdout.is_empty() && raw.stderr.is_empty());
            raw
        })
        .collect();

    let cfile = dir.join("strings.c");
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(&cfile).unwrap();
    let code = {
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (runtime, main) = code.split_at(start);
        let init = "    fwp_init_consts();\n";
        let observation = "    /* Ownership observation point: before runtime teardown. */\n";
        assert_eq!(main.matches(init).count(), 1);
        assert_eq!(main.matches(observation).count(), 1);
        let main = main.replace(init, &format!("{init}    size_t map_live_bytes = fwp_heap.live;\n"))
                .replace(observation, &format!("{observation}    if(fwp_heap.live != map_live_bytes) {{ fprintf(stderr, \"string-map owners remain after language execution\\n\"); exit(246); }}\n"));
        format!("{runtime}{main}")
    };
    assert!(
        code.contains("fwp_k_map_strings_owned(fwp_owned_entry"),
        "known callback was not selected"
    );
    let prefix = "FWP_K V fwp_k_map_strings_owned(";
    let start = code.find(prefix).unwrap();
    let end = start + code[start..].find("\n}").unwrap() + 2;
    let helper = &code[start..end];
    let source_guard = "fwp_value_protect(&source, &source_cleanup);";
    let finish = "V result = fwp_map_finish_protected(&owner, &cleanup);";
    assert_eq!(helper.matches(source_guard).count(), 1);
    assert_eq!(helper.matches(finish).count(), 1);
    let observed = helper
        .replace(
            source_guard,
            &format!("{source_guard}\n    if(map_force==3)fwp_trap(\"map allocation control\");"),
        )
        .replace(
            finish,
            &format!("if(map_force==4)fwp_trap(\"map allocation control\");\n    {finish}"),
        );
    let build_step = "\n        V fields[] = {owner->items[owner->count - 1], owner->built};";
    assert_eq!(code.matches(build_step).count(), 1);
    let build_guard = "if(map_force==5 && owner->count==1)fwp_trap(\"map allocation control\");";
    let probe = code
        .replace(build_step, &format!("\n        {build_guard}{build_step}"))
        .replace(helper, &observed)
        .replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1")
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        )
        .replace(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic int map_force;",
        );
    let probe = format!("{probe}\n{}", include_str!("fixtures/string_map_probe.c"));
    let missing_source = probe.replace(
        &observed,
        &observed.replace(
            source_guard,
            "if(map_force!=3)fwp_value_protect(&source, &source_cleanup);",
        ),
    );
    let missing_results = probe.replace(
        &observed,
        &observed.replace(
            "if(map_force==4)fwp_trap",
            "if(map_force==4)owner.count=0;\n    if(map_force==4)fwp_trap",
        ),
    );
    let missing_built = probe.replace(
        build_guard,
        &format!("if(map_force==5 && owner->count==1)owner->built=0; {build_guard}"),
    );
    for opt in ["-O0", "-O2"] {
        let binary = dir.join("strings.exe");
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        for (input_index, (input, reference)) in inputs.iter().zip(&references).enumerate() {
            {
                let actual = checked(Command::new(&binary).env("FWP_TEXT_INPUT", input));
                assert_eq!(
                    (&actual.stdout, &actual.stderr),
                    (&reference.stdout, &reference.stderr),
                    "counted {opt}"
                );
                if let Some(destination) = std::env::var_os("FWP_STRING_MAP_ARTIFACTS") {
                    let destination = std::path::PathBuf::from(destination);
                    std::fs::create_dir_all(&destination).unwrap();
                    let stem = format!("language-counted-{}-{input_index}", &opt[1..]);
                    std::fs::write(destination.join(format!("{stem}.stdout")), actual.stdout)
                        .unwrap();
                    std::fs::write(destination.join(format!("{stem}.input")), input).unwrap();
                    std::fs::write(
                        destination.join(format!("{stem}.reference")),
                        &reference.stdout,
                    )
                    .unwrap();
                }
            }
        }
        if let Some(destination) = std::env::var_os("FWP_STRING_MAP_ARTIFACTS") {
            let destination = std::path::PathBuf::from(destination);
            std::fs::create_dir_all(&destination).unwrap();
            let stem = format!("language-counted-{}", &opt[1..]);
            std::fs::write(destination.join(format!("{stem}.c")), &code).unwrap();
            std::fs::copy(&binary, destination.join(format!("{stem}.exe"))).unwrap();
        }
        for (label, measured, status) in [
            ("protected", &probe, 0),
            ("missing-source", &missing_source, 245),
            ("missing-results", &missing_results, 245),
            ("missing-built", &missing_built, 245),
        ] {
            fwp::cgen::compile_c(measured, &binary, opt).unwrap();
            let actual = Command::new(&binary).output().unwrap();
            assert_eq!(
                actual.status.code(),
                Some(status),
                "counted {opt} {label}: {actual:?}"
            );
            assert!(actual.stderr.is_empty(), "{actual:?}");
            if status == 0 {
                assert_eq!(
                    String::from_utf8_lossy(&actual.stdout).trim(),
                    "string maps preserve aliases and release source, results and scratch"
                );
            }
            if let Some(destination) = std::env::var_os("FWP_STRING_MAP_ARTIFACTS") {
                let destination = std::path::PathBuf::from(destination);
                std::fs::create_dir_all(&destination).unwrap();
                let stem = format!("counted-{}-{label}", &opt[1..]);
                std::fs::write(
                    destination.join(format!("{stem}.status")),
                    format!("{status}\n"),
                )
                .unwrap();
                std::fs::write(destination.join(format!("{stem}.c")), measured).unwrap();
                std::fs::copy(&binary, destination.join(format!("{stem}.exe"))).unwrap();
                std::fs::write(destination.join(format!("{stem}.stdout")), actual.stdout).unwrap();
            }
        }
    }
}
