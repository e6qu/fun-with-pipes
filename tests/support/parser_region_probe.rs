//! Instrument actual generated parser nodes and every count operation.
use fwp::cgen::Target;

pub fn instrument(code: &str, name: &str, target: Target) -> String {
    let (argument, storage, depths, save_counts, check_counts) = match target {
        Target::Native => ("v", "fwp_heap.live", "5, 9, 13", "", ""),
        Target::Wasi => (
            "value",
            "wasm_arc_bytes",
            "5, 9",
            "size_t counts = fwp_wasm_counts_live;",
            "if (fwp_wasm_counts_live != counts) return 250;",
        ),
        Target::Browser => panic!("this probe requires a process exit status"),
    };
    let marker = code.find(&format!("/* {name} :")).expect("parser entry");
    let entry = code[marker..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let (declarations, main) = include_str!("../fixtures/parser_generated_probe.c")
        .split_once("/* GENERATED-PARSER-MAIN */")
        .unwrap();
    let mut measured = code[..code.find("int main(").unwrap()].replace(
        "typedef uint64_t V;",
        &format!("typedef uint64_t V;\n{declarations}"),
    );
    for (return_type, function) in [
        ("V", "fwp_rc_fresh"),
        ("void", "fwp_rc_dup"),
        ("void", "fwp_rc_drop"),
        ("int", "fwp_rc_release_last"),
        ("int", "fwp_rc_unique"),
        ("int", "fwp_rc_unique_mut"),
        ("int", "fwp_rc_last"),
        ("void", "fwp_rc_share"),
        ("void", "fwp_rc_free_obj"),
    ] {
        let inline =
            if target == Target::Native && matches!(function, "fwp_rc_share" | "fwp_rc_free_obj") {
                ""
            } else {
                "inline "
            };
        let signature = format!("static {inline}{return_type} {function}(V {argument}) {{");
        assert_eq!(measured.matches(&signature).count(), 1, "{signature}");
        measured = measured.replace(
            &signature,
            &format!("{signature}\n    parser_link_operation({argument});"),
        );
    }
    for (old, new) in [
        ("        fwp_region_block *fresh =", "        if (++parser_allocations == parser_failure) fwp_fail(0, NULL);\n        fwp_region_block *fresh ="),
        ("        fresh->capacity = capacity;", "        fresh->capacity = capacity;\n        parser_add_block(fresh->data, capacity);"),
        ("        fwp_mem_free(block);", "        parser_remove_block(block->data);\n        fwp_mem_free(block);"),
        ("    return PTR(node);", "    if (PTR(node) % 8 || fwp_rc_slot(PTR(node))) exit(250);\n    parser_nodes++;\n    /* extra-link-count */\n    return PTR(node);"),
    ] {
        assert_eq!(measured.matches(old).count(), 1, "{old}");
        measured = measured.replace(old, new);
    }
    measured.push_str(
        &main
            .replace("@entry@", &format!("f{entry}"))
            .replace("@storage@", storage)
            .replace("@depths@", depths)
            .replace("@save_counts@", save_counts)
            .replace("@check_counts@", check_counts),
    );
    if target == Target::Wasi {
        measured = format!(
            "{}\n{measured}",
            include_str!("../fixtures/wasm_arc_allocations.c")
        );
    }
    measured
}
