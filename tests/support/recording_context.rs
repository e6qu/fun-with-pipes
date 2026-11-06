//! Borrow lookup state only through proven calls and complete numeric loops.
use std::process::Command;

use super::{checked, record_probe, Scratch};

#[path = "exported_probe.rs"]
mod exported_probe;

#[test]
fn recording_loops_validate_id_changes_and_release_owners_on_nested_failure() {
    let scratch = Scratch::new("recording-context");
    let input = scratch.0.join("context.fwp");
    std::fs::write(&input, include_str!("../fixtures/ad_recording_context.fwp")).unwrap();
    for raw in [false, true] {
        let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
        command.env_remove("FWP_NO_OPT");
        if raw {
            command.env("FWP_NO_OPT", "1");
        }
        let result = checked(command.args(["run", "--interp"]).arg(&input));
        assert_eq!(result.stdout, b"True\n");
        assert!(result.stderr.is_empty());
    }
    let original = exported_probe::generate(&input);
    assert!(original.contains("/* Consume private overlapping windows;"));
    assert!(original.contains("/* Fold after the complete packed map;"));
    assert_eq!(
        original
            .matches("fwp_ad_recording recording = {-1, NULL};")
            .count(),
        2
    );
    let signature = original
        .split("/* transform :")
        .nth(1)
        .unwrap()
        .lines()
        .nth(1)
        .unwrap();
    let entry = signature
        .split('(')
        .next()
        .unwrap()
        .split_whitespace()
        .last()
        .unwrap();
    let entry = format!("f{}", entry.trim_start_matches(['w', 'f']));
    let drop_list = original
        .split("/* List[I64] */\nstatic void ")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let lookup = "static fwp_tape *fwp_tape_of(int64_t id) {";
    let append = "    t->len = idx + 1;\n";
    assert_eq!(original.matches(lookup).count(), 1);
    assert_eq!(original.matches(append).count(), 1);
    let source = original.replace(lookup, &format!(
        "static unsigned loop_lookups, loop_appends, loop_fail_at;\n{lookup}\n    loop_lookups++;"
    )).replace(append, &format!(
        "{append}    if (++loop_appends == loop_fail_at) fwp_trap(\"injected loop recording failure\");\n"
    )).replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
    let probe = include_str!("../fixtures/ad_recording_context_probe.c")
        .replace("TRANSFORM", &entry)
        .replace("DROP_LIST", drop_list);
    let lost_scope = source.replace(", &recording)", ", &(fwp_ad_recording){-1, NULL})");
    assert_ne!(lost_scope, source);
    let id_check = "if (recording && recording->id == id) {";
    assert_eq!(source.matches(id_check).count(), 1);
    let wrong_id = source.replace(id_check, "if (recording && recording->tape) {");
    for opt in ["-O1", "-O2"] {
        let ordinary = scratch.0.join(format!("ordinary{opt}.exe"));
        fwp::cgen::compile_c(&original, &ordinary, opt).unwrap();
        let result = checked(&mut Command::new(&ordinary));
        assert_eq!(result.stdout, b"True\n");
        record_probe::save(
            "recording_context",
            &format!("ordinary{opt}"),
            &original,
            &ordinary,
            &result,
        );
        for (label, code, status) in [
            ("scoped", &source, 0),
            ("lost-scope", &lost_scope, 82),
            ("wrong-id", &wrong_id, 82),
        ] {
            for reuse in [true, false] {
                let code = format!(
                    "{}{}\n{probe}",
                    if reuse {
                        ""
                    } else {
                        "#define FWP_NO_REUSE 1\n"
                    },
                    code
                );
                let label = format!("{label}{opt}-reuse{reuse}");
                let binary = scratch.0.join(format!("{label}.exe"));
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                for workspace in ["0", "1"] {
                    let result = Command::new(&binary)
                        .env("FWP_AD_WORKSPACE", workspace)
                        .output()
                        .unwrap();
                    record_probe::save(
                        "recording_context",
                        &format!("{label}-workspace{workspace}"),
                        &code,
                        &binary,
                        &result,
                    );
                    assert_eq!(
                        result.status.code(),
                        Some(status),
                        "{label}/{workspace}: {result:?}"
                    );
                    assert!(
                        result.stdout.is_empty() && result.stderr.is_empty(),
                        "{label}: {result:?}"
                    );
                }
            }
        }
    }
}
