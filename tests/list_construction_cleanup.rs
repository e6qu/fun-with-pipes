//! Structural copies and state sequences protect pending and partial results.
use std::process::Command;

#[test]
fn list_construction_releases_on_retain_callback_and_allocation_failure() {
    let dir = fwp::cgen::TempDir::new("list-construction-cleanup").unwrap();
    let source = dir.join("main.fwp");
    std::fs::write(&source, "main = [task.yield (), echo \"probe\"] | ignore\n").unwrap();
    {
        let cfile = dir.join("main.c");
        let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(emitted.status.success(), "{emitted:?}");
        let mut code = std::fs::read_to_string(cfile).unwrap();
        for name in ["repeat", "chunks", "scan", "iterate"] {
            let start = code.find(&format!("static V fwp_p_{name}_owned(")).unwrap();
            let end = start + code[start..].find("\n}\n").unwrap() + 3;
            let helper = code[start..end]
                .replace("fwp_map_items(", "generation_items(")
                .replace("fwp_mem_alloc(", "generation_scratch(")
                .replace("fwp_callback_argument_dup(", "generation_initial(")
                .replace("fwp_apply_borrowed(", "generation_call(");
            code.replace_range(start..end, &helper);
        }
        let declarations="static V generation_node(V *);static V *generation_items(V,size_t *);static void *generation_scratch(size_t);static void generation_initial(V,V);static V generation_call(V,uint32_t,V *);\n";
        code = code
            .replace(
                "static V fwp_map_finish_protected(",
                &format!("{declarations}static V fwp_map_finish_protected("),
            )
            .replace(
                "fwp_rc_fresh(fwp_data(1, 2, fields))",
                "fwp_rc_fresh(generation_node(fields))",
            );
        code = code[..code.find("int main(").unwrap()].to_string()
            + include_str!("fixtures/list_construction_cleanup.c");
        let missing_pending = code.replace("pending = {0, drop_element};", "pending = {0, NULL};");
        let missing_chunk = code.replace("chunk = {0, drop_chunk}", "chunk = {0, NULL}");
        let missing_state = code.replace(
            "owner = {out, 0, 0, element_drop, list_drop}",
            "owner = {out, 0, 0, NULL, list_drop}",
        );
        let missing_spine = code.replace(
            "owner = {a, 0, 0, element_drop, list_drop}",
            "owner = {a, 0, 0, element_drop, NULL}",
        );
        let missing_scratch = code.replace(
            "fwp_scratch_finish(&a, &scratch_cleanup);",
            "fwp_cleanup_pop(&scratch_cleanup);",
        );
        for opt in ["-O1", "-O2"] {
            for (candidate, operations, expected) in [
                (&code, &[0, 1, 2, 3][..], 0),
                (&missing_pending, &[0][..], 248),
                (&missing_chunk, &[1][..], 248),
                (&missing_state, &[2][..], 248),
                (&missing_spine, &[3][..], 249),
                (&missing_scratch, &[1][..], 249),
            ] {
                if expected != 0 {
                    assert_ne!(candidate, &code);
                }
                let binary = dir.join("probe.exe");
                fwp::cgen::compile_c(candidate, &binary, opt).unwrap();
                for operation in operations {
                    let result = Command::new(&binary)
                        .arg(operation.to_string())
                        .output()
                        .unwrap();
                    assert_eq!(
                        result.status.code(),
                        Some(expected),
                        "counted {opt} op={operation}: {result:?}"
                    );
                }
            }
        }
    }
}
