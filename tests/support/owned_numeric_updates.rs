//! Verify consuming entries, shared ancestors and actual physical cleanup.
use std::process::Command;

use super::{checked, exported_probe, function_id, ownership_ledger, record_probe, Scratch};

fn section<'a>(source: &'a str, marker: &str) -> &'a str {
    assert_eq!(source.matches(marker).count(), 1, "{marker}");
    let start = source.find(marker).unwrap();
    &source[start..start + source[start..].find("\n}\n").unwrap() + 3]
}

#[test]
fn consumed_numeric_values_match_both_interpreters() {
    let directory = Scratch::new("owned-numeric-values");
    let input = directory.0.join("values.fwp");
    std::fs::write(
        &input,
        include_str!("../fixtures/owned_numeric_updates.fwp"),
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for raw in [false, true] {
        let mut command = Command::new(compiler);
        command.env_remove("FWP_NO_OPT");
        if raw {
            command.env("FWP_NO_OPT", "1");
        }
        let output = checked(command.args(["run", "--interp"]).arg(&input));
        assert_eq!(output.stdout, b"True\n");
        assert!(output.stderr.is_empty());
    }
    for opt in ["-O1", "-O2"] {
        let cfile = directory.0.join(format!("values{opt}.c"));
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--memory", "dynamic", "--emit-c", opt])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let executable = directory.0.join(format!("values{opt}.exe"));
        fwp::cgen::compile_c(&code, &executable, opt).unwrap();
        let output = Command::new(&executable).output().unwrap();
        record_probe::save(
            "owned_numeric_updates",
            &format!("values{opt}"),
            &code,
            &executable,
            &output,
        );
        assert!(output.status.success(), "{output:?}");
        assert_eq!(output.stdout, b"True\n");
        assert!(output.stderr.is_empty());
    }
}

#[test]
fn consumed_numeric_owners_survive_sharing_traps_and_allocation_failure() {
    let directory = Scratch::new("owned-numeric-owners");
    let input = directory.0.join("owners.fwp");
    std::fs::write(
        &input,
        include_str!("../fixtures/owned_numeric_updates.fwp"),
    )
    .unwrap();
    let emitted = exported_probe::generate(&input);
    assert!(emitted.contains("#define FWP_UNWIND 1"));
    assert!(emitted.contains("#define FWP_TASK_TICKS 1"));
    assert!(emitted.contains("/* consumed-scalar-array-map :"));
    assert_eq!(
        emitted
            .matches("/* consumed-scalar-array-list-zip :")
            .count(),
        2
    );
    let drop_name = |ty: &str| {
        let start = emitted
            .find(&format!("/* {ty} */\nstatic void fwp_drop"))
            .unwrap();
        emitted[start..]
            .split("static void ")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
    };
    let observed = ownership_ledger::instrument_native(&emitted, 2048);
    let mut code = observed[..observed.find("int main(").unwrap()].to_owned();
    code = code.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int numeric_mode, numeric_calls, numeric_allocations, numeric_fail_after;\nstatic V numeric_alias;\nstatic void fwp_trap(const char *);");
    for signature in [
        "static inline void *fwp_heap_alloc_observed_body(size_t n, int kind) {",
        "static inline void *fwp_alloc_init_observed_body(size_t n) {",
    ] {
        assert_eq!(code.matches(signature).count(), 1);
        code = code.replace(signature, &format!("{signature}\n    if(numeric_fail_after > 0 && ++numeric_allocations == numeric_fail_after) fwp_trap(\"injected numeric allocation failure\");"));
    }
    let yielding = section(&code, "static V fwp_p_task_yield(void) {").to_owned();
    code = code.replace(&yielding, r#"static V fwp_p_task_yield(void) {
    numeric_calls++;
    if(numeric_alias) {
        V p=numeric_alias;
        for(int i=0;p;i++,p=OBJ(p)->f[1])
            if(OBJ(p)->f[0] != (numeric_mode==3 && i==1 ? (V)INT64_MIN : (V)(10 * (i + 1)))) fwp_trap("shared coordinate changed during callback");
    }
    if(numeric_calls==2) {
        if(numeric_mode==1) fwp_trap("injected numeric callback failure");
        if(numeric_mode==2) { fwp_cur->cancelled=1; fwp_check_cancel(); }
    }
    return FWP_UNIT;
}
"#);
    code += &include_str!("../fixtures/owned_numeric_updates.c")
        .replace(
            "MAP_ENTRY",
            &format!("f{}", function_id(&emitted, "mapped")),
        )
        .replace(
            "CAPTURE_ENTRY",
            &format!("f{}", function_id(&emitted, "mapped-capture")),
        )
        .replace(
            "TEMP_ENTRY",
            &format!("f{}", function_id(&emitted, "mapped-produced")),
        )
        .replace(
            "SHARED_ENTRY",
            &format!("f{}", function_id(&emitted, "shared-first")),
        )
        .replace(
            "MAP32_ENTRY",
            &format!("f{}", function_id(&emitted, "mapped32")),
        )
        .replace(
            "MAP64_ENTRY",
            &format!("f{}", function_id(&emitted, "mapped64")),
        )
        .replace(
            "CAP32_ENTRY",
            &format!("f{}", function_id(&emitted, "captured32")),
        )
        .replace(
            "CAP64_ENTRY",
            &format!("f{}", function_id(&emitted, "captured64")),
        )
        .replace(
            "LEFT_ENTRY",
            &format!("f{}", function_id(&emitted, "update-left")),
        )
        .replace(
            "RIGHT_ENTRY",
            &format!("f{}", function_id(&emitted, "update-right")),
        )
        .replace("DROP_ARRAY", drop_name("Array[I64]"))
        .replace("DROP_F32_ARRAY", drop_name("Array[F32]"))
        .replace("DROP_F64_ARRAY", drop_name("Array[F64]"))
        .replace("DROP_LIST", drop_name("List[I64]"));
    let corrupt = code.replace(
        "OBJ(cursor)->f[0] = mapped->items[i];",
        "OBJ(cursor)->f[0] = mapped->items[i] ^ 1;",
    );
    assert_ne!(corrupt, code);
    let leak = code.replace(
        "if (built && owner->list_drop) owner->list_drop(built);",
        "/* deliberately leak partial copied suffix */",
    );
    assert_ne!(leak, code);
    let missing_map_owner = code.replace(
        "fwp_value_owner input = {l2, ",
        "fwp_value_owner input = {0, ",
    );
    assert!(
        missing_map_owner != code,
        "captured consuming worker was not emitted"
    );
    for opt in ["-O1", "-O2"] {
        for (label, text, expected) in [
            ("reuse", code.clone(), 0),
            ("no-reuse", format!("#define FWP_NO_REUSE 1\n{code}"), 0),
            ("corrupt-prefix", corrupt.clone(), 241),
            ("missing-suffix-release", leak.clone(), 90),
            // The retained alias still has two owners: this catches the
            // missing release before the physical-allocation ledger does.
            ("missing-captured-input", missing_map_owner.clone(), 248),
        ] {
            let executable = directory.0.join(format!("{label}{opt}.exe"));
            fwp::cgen::compile_c(&text, &executable, opt).unwrap();
            let output = Command::new(&executable).output().unwrap();
            record_probe::save(
                "owned_numeric_updates",
                &format!("{label}{opt}"),
                &text,
                &executable,
                &output,
            );
            assert_eq!(
                output.status.code(),
                Some(expected),
                "{label}/{opt}: {output:?}"
            );
        }
    }
}
