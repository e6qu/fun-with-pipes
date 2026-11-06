//! Observe scoped caller ownership through normal return and nonlocal exits.
use std::process::Command;

use super::{checked, exported_probe, record_probe, Scratch};
#[path = "ownership_ledger.rs"]
mod ownership_ledger;

#[test]
fn scoped_input_borrows_and_single_root_seeds_preserve_values_and_cleanup() {
    let directory = Scratch::new("gradient-call-storage");
    let input = directory.0.join("input.fwp");
    std::fs::write(
        &input,
        include_str!("../fixtures/gradient_call_storage.fwp"),
    )
    .unwrap();
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
    let emitted = exported_probe::generate(&input);
    assert_eq!(emitted.matches("/* Direct AD scope;").count(), 1);
    assert!(emitted.contains("/* caller-owned parameters: 0 */"));
    assert!(emitted.contains("fwp_rc_fresh(fwp_p_ad_backward_one(l0, l1, l2))"));
    let signature = emitted
        .split("/* scoped-input :")
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
    // The ordinary owned entry boxes its result; it has the same function ID.
    let id = entry
        .split('(')
        .next()
        .unwrap()
        .trim_start_matches(['w', 'f']);
    let list = emitted
        .split("/* List[F64] */\nstatic void ")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    for opt in ["-O1", "-O2"] {
        let binary = directory.0.join(format!("ordinary{opt}.exe"));
        fwp::cgen::compile_c(&emitted, &binary, opt).unwrap();
        let result = checked(&mut Command::new(&binary));
        assert_eq!(result.stdout, b"True\n");
        record_probe::save(
            "gradient_call_storage",
            &format!("ordinary{opt}"),
            &emitted,
            &binary,
            &result,
        );
    }
    let observed = ownership_ledger::instrument_native(&emitted, 2048);
    let mut code = observed[..observed.find("int main(").unwrap()].to_owned();
    code = code.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic V storage_input;\nstatic int storage_mode, storage_retains, storage_allocations, storage_fail_after;\nstatic void fwp_trap(const char *);");
    let retain = "static inline void fwp_rc_dup(V v) {";
    assert_eq!(code.matches(retain).count(), 1);
    code = code.replace(
        retain,
        &format!("{retain}\n    if (storage_input && v == storage_input) storage_retains++;"),
    );
    for signature in [
        "static inline void *fwp_heap_alloc_observed_body(size_t n, int kind) {",
        "static inline void *fwp_alloc_init_observed_body(size_t n) {",
    ] {
        assert_eq!(code.matches(signature).count(), 1);
        code = code.replace(signature, &format!("{signature}\n    if(storage_fail_after && ++storage_allocations == storage_fail_after) fwp_trap(\"injected scoped allocation failure\");"));
    }
    let start = code.find("static V fwp_p_task_yield(void) {").unwrap();
    let end = start + code[start..].find("\n}\n").unwrap() + 3;
    // The source yields outside the pure AD callback. Inject nonlocal exits
    // after tape creation, while the scope and caller input owners are live.
    code.replace_range(
        start..end,
        "static V fwp_p_task_yield(void) {\n    return FWP_UNIT;\n}\n",
    );
    let backward = "static V fwp_p_ad_backward_one(V base, V root, V seed) {";
    assert_eq!(code.matches(backward).count(), 1);
    code = code.replace(backward, &format!("{backward}\n    if(storage_mode == 1) fwp_trap(\"injected scoped callback failure\");\n    if(storage_mode == 2) {{ fwp_cur->cancelled=1; fwp_check_cancel(); }}"));
    code += &include_str!("../fixtures/gradient_call_storage.c")
        .replace("SCOPED_ENTRY", &format!("f{id}"))
        .replace("DROP_LIST", list);
    let marker = "    /* Direct AD scope; caller keeps borrowed worker inputs. */";
    assert_eq!(code.matches(marker).count(), 1);
    let retained = code.replace(marker, &format!("{marker}\n    fwp_rc_dup(l0);"));
    let release = "static void fwp_rc_free_arr(V v) {\n    if (fwp_rc_last(v)) fwp_mem_free((void *)(uintptr_t)v);\n}";
    assert_eq!(code.matches(release).count(), 1);
    let leaked = code.replace(release, "static void fwp_rc_free_arr(V v) { (void)v; }");
    for opt in ["-O1", "-O2"] {
        for (label, source, status) in [
            ("owners", &code, 0),
            ("extra-retain", &retained, 231),
            ("missing-release", &leaked, 90),
        ] {
            let binary = directory.0.join(format!("{label}{opt}.exe"));
            fwp::cgen::compile_c(source, &binary, opt).unwrap();
            let result = Command::new(&binary).output().unwrap();
            record_probe::save(
                "gradient_call_storage",
                &format!("{label}{opt}"),
                source,
                &binary,
                &result,
            );
            assert_eq!(
                result.status.code(),
                Some(status),
                "{label}/{opt}: {result:?}"
            );
        }
    }
}
