//! Invalid build options must fail before emitting an unintended artifact.
use std::path::Path;
use std::process::Command;

use fwp::json::Json;

#[test]
fn build_rejects_unknown_options_in_either_position() {
    let dir = fwp::cgen::TempDir::new("compiler-options").unwrap();
    let input = dir.join("input.fwp");
    let artifact = dir.join("unintended.c");
    std::fs::write(&input, "main = ()\n").unwrap();
    for option in ["--sharedlib", "--unknown", "--gc=banana", "-O99"] {
        for first in [false, true] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command
                .current_dir(dir.path())
                .args(["build", "--emit-c", "-o"])
                .arg(&artifact);
            if first {
                command.arg(option).arg(&input);
            } else {
                command.arg(&input).arg(option);
            }
            let output = command.output().unwrap();
            assert_eq!(output.status.code(), Some(2), "{output:?}");
            let expected = format!("unknown option `{option}`");
            assert!(
                String::from_utf8_lossy(&output.stderr).contains(&expected),
                "{output:?}"
            );
            assert!(!artifact.exists(), "bad option emitted an artifact");
        }
    }
}

#[test]
fn build_requires_one_input_and_values_for_value_options() {
    let dir = fwp::cgen::TempDir::new("compiler-values").unwrap();
    let input = dir.join("input.fwp");
    std::fs::write(&input, "main = ()\n").unwrap();
    for option in [
        "-o",
        "--fn",
        "--link",
        "--service",
        "--pgo-input",
        "--profile-compile",
    ] {
        let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .current_dir(dir.path())
            .args(["build", "--emit-c"])
            .arg(&input)
            .arg(option)
            .output()
            .unwrap();
        assert_eq!(output.status.code(), Some(2), "{output:?}");
        assert!(
            String::from_utf8_lossy(&output.stderr).contains(&format!("{option} needs a value"))
        );
        assert!(!input.with_extension("c").exists());
    }
    let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .current_dir(dir.path())
        .args(["build", "--emit-c"])
        .arg(&input)
        .arg(&input)
        .output()
        .unwrap();
    assert_eq!(output.status.code(), Some(2), "{output:?}");
    assert!(String::from_utf8_lossy(&output.stderr).contains("expected one input file"));
    assert!(!input.with_extension("c").exists());
}

fn field<'a>(value: &'a Json, name: &str) -> &'a Json {
    let Json::Obj(fields) = value else {
        panic!("expected object: {value:?}")
    };
    &fields.iter().find(|(key, _)| key == name).unwrap().1
}

fn number(value: &Json) -> u128 {
    let Json::Num(value) = value else {
        panic!("expected number: {value:?}")
    };
    value.parse().unwrap()
}

fn verify_profile(path: &Path, status: u8) -> Vec<Json> {
    let report = Json::parse(&std::fs::read_to_string(path).unwrap()).unwrap();
    assert_eq!(
        field(&report, "format"),
        &Json::Str("fwp-compile-profile".into())
    );
    assert_eq!(number(field(&report, "status")), status as u128);
    let Json::Arr(events) = field(&report, "phases") else {
        panic!("missing phases")
    };
    assert!(!events.is_empty());
    let mut exclusive_total = 0;
    for (index, event) in events.iter().enumerate() {
        assert_eq!(number(field(event, "id")), index as u128);
        let start = number(field(event, "start_ns"));
        let end = number(field(event, "end_ns"));
        assert!(start <= end && end <= number(field(&report, "wall_ns")));
        assert_eq!(number(field(event, "inclusive_ns")), end - start);
        let children: u128 = events
            .iter()
            .filter(|child| field(child, "parent") == field(event, "id"))
            .map(|child| number(field(child, "inclusive_ns")))
            .sum();
        assert_eq!(number(field(event, "exclusive_ns")) + children, end - start);
        exclusive_total += number(field(event, "exclusive_ns"));
        if field(event, "parent") != &Json::Null {
            let parent = number(field(event, "parent")) as usize;
            assert!(parent < index);
            assert!(number(field(&events[parent], "start_ns")) <= start);
            assert!(end <= number(field(&events[parent], "end_ns")));
        }
    }
    assert_eq!(
        exclusive_total + number(field(&report, "unassigned_ns")),
        number(field(&report, "wall_ns"))
    );
    events.clone()
}

#[test]
fn compile_reports_preserve_code_results_errors_and_nested_macro_accounting() {
    let dir = fwp::cgen::TempDir::new("compile-profile").unwrap();
    let source = dir.join("input.fwp");
    std::fs::write(
        &source,
        "macro twice = quote (unquote!(0) | unquote!(0))\nmain = 40 | twice!(add 1) | echo\n",
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let mut generated = Vec::new();
    for observed in [false, true] {
        let output = dir.join(if observed { "observed.c" } else { "ordinary.c" });
        let report = dir.join("emit.json");
        let mut command = Command::new(compiler);
        command
            .env_remove("FWP_NO_OPT")
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&output);
        if observed {
            command.arg("--profile-compile").arg(&report);
        }
        let result = command.output().unwrap();
        assert!(
            result.status.success() && result.stdout.is_empty() && result.stderr.is_empty(),
            "{result:?}"
        );
        generated.push(std::fs::read(output).unwrap());
        if observed {
            let events = verify_profile(&report, 0);
            let macro_id = events
                .iter()
                .position(|e| field(e, "phase") == &Json::Str("macro-expansion".into()))
                .unwrap();
            assert!(events
                .iter()
                .any(|e| field(e, "parent") == &Json::Num(macro_id.to_string())
                    && field(e, "phase") == &Json::Str("type-check".into())));
            assert!(events
                .iter()
                .any(|e| field(e, "phase") == &Json::Str("representation-and-ownership".into())));
            assert!(!events
                .iter()
                .any(|e| field(e, "phase") == &Json::Str("native-build".into())));
        }
    }
    assert_eq!(
        generated[0], generated[1],
        "observation changed generated C"
    );
    let binary = dir.join("program.exe");
    let report = dir.join("native.json");
    let result = Command::new(compiler)
        .env_remove("FWP_NO_OPT")
        .env("FWP_LTO", "0")
        .args(["build", "-O2"])
        .arg(&source)
        .arg("-o")
        .arg(&binary)
        .arg("--profile-compile")
        .arg(&report)
        .output()
        .unwrap();
    assert!(
        result.status.success() && result.stderr.is_empty(),
        "{result:?}"
    );
    let result = Command::new(binary).output().unwrap();
    assert!(
        result.status.success() && result.stderr.is_empty(),
        "{result:?}"
    );
    assert_eq!(result.stdout, b"42\n");
    let events = verify_profile(&report, 0);
    assert!(events
        .iter()
        .any(|e| field(e, "phase") == &Json::Str("c-toolchain-process".into())));
    std::fs::write(&source, "main = missing-definition\n").unwrap();
    let ordinary = Command::new(compiler)
        .args(["build", "--emit-c"])
        .arg(&source)
        .output()
        .unwrap();
    let report = dir.join("error.json");
    let observed = Command::new(compiler)
        .args(["build", "--emit-c"])
        .arg(&source)
        .arg("--profile-compile")
        .arg(&report)
        .output()
        .unwrap();
    assert_eq!(ordinary.status.code(), Some(1));
    assert_eq!(
        (observed.status.code(), observed.stdout, observed.stderr),
        (ordinary.status.code(), ordinary.stdout, ordinary.stderr)
    );
    verify_profile(&report, 1);
}

#[test]
fn compile_reports_do_not_replace_inputs_or_build_outputs() {
    let dir = fwp::cgen::TempDir::new("compile-profile-paths").unwrap();
    let source = dir.join("input.fwp");
    let text = "main = ()\n";
    std::fs::write(&source, text).unwrap();
    for report in [
        source.clone(),
        dir.join("artifact.c"),
        dir.join("artifact.float.c"),
        dir.join("artifact.float.cpp"),
    ] {
        let result = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(dir.join("artifact.c"))
            .arg("--profile-compile")
            .arg(&report)
            .output()
            .unwrap();
        assert!(!result.status.success(), "{result:?}");
        assert_eq!(std::fs::read_to_string(&source).unwrap(), text);
        assert!(!dir.join("artifact.c").exists());
        if report != source {
            assert!(!report.exists());
        }
    }
}
