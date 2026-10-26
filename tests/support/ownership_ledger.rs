//! Observe native ARC allocation identities without retaining freed storage.
//! This is test instrumentation, not a production runtime mode.

fn replace_once(code: &mut String, before: &str, after: &str) {
    assert_eq!(code.matches(before).count(), 1, "{before}");
    *code = code.replacen(before, after, 1);
}

fn wrap(code: &mut String, signature: &str, name: &str, body: &str) {
    assert_eq!(code.matches(signature).count(), 1, "{signature}");
    let start = code.find(signature).unwrap();
    let mut end = start + signature.len();
    let mut depth = 1;
    while depth != 0 {
        match code.as_bytes()[end] {
            b'{' => depth += 1,
            b'}' => depth -= 1,
            _ => {}
        }
        end += 1;
    }
    let original = code[start..end].replacen(name, &format!("{name}_observed_body"), 1);
    code.replace_range(start..end, &format!("{original}\n{signature}\n{body}\n}}"));
}

/// Instrument native allocator paths, including static-pool native builds.
/// `capacity` is an explicit upper bound on simultaneous managed allocations;
/// the fixed address table is outside the program's managed allocator.
pub fn instrument_native(code: &str, capacity: usize) -> String {
    assert!(capacity >= 2 && capacity.is_power_of_two());
    let mut code = code.to_owned();
    let ledger =
        include_str!("../fixtures/ownership_ledger.c").replace("@CAPACITY@", &capacity.to_string());
    replace_once(
        &mut code,
        "typedef uint64_t V;",
        &format!("typedef uint64_t V;\n{ledger}"),
    );
    wrap(
        &mut code,
        "static inline void *fwp_heap_alloc(size_t n, int kind) {",
        "fwp_heap_alloc",
        "    void *result = fwp_heap_alloc_observed_body(n, kind);\n    if (kind != 0) owner_ledger_alloc(result);\n    return result;",
    );
    // alloc_init can bypass heap_alloc; its slow path uses kind == 0, so the
    // outer observation owns exactly one registration on either path.
    wrap(
        &mut code,
        "static inline void *fwp_alloc_init(size_t n) {",
        "fwp_alloc_init",
        "    void *result = fwp_alloc_init_observed_body(n);\n    owner_ledger_alloc(result);\n    return result;",
    );
    replace_once(
        &mut code,
        "static void fwp_mem_free(void *p) {\n",
        "static void fwp_mem_free(void *p) {\n    owner_ledger_free(p);\n",
    );
    // Stack/constant values are not managed allocations. For heap addresses,
    // check identity before count metadata can silently ignore a stale owner.
    let guard = "    uintptr_t offset = (uintptr_t)v - (uintptr_t)fwp_heap.base;\n    if (offset < (fwp_heap.top << HEAP_SHIFT) && !owner_ledger_slots[owner_ledger_find((uintptr_t)v)])\n        owner_ledger_error(203, \"count operation on a dead or interior allocation\");\n";
    for signature in [
        "static inline void fwp_rc_dup(V v) {\n",
        "static inline void fwp_rc_drop(V v) {\n",
        "static inline int fwp_rc_release_last(V v) {\n",
    ] {
        replace_once(&mut code, signature, &format!("{signature}{guard}"));
    }
    for name in ["fwp_rc_unique", "fwp_rc_unique_mut"] {
        wrap(
            &mut code,
            &format!("static inline int {name}(V v) {{\n"),
            name,
            &format!("    int result = {name}_observed_body(v);\n    if (result && (!owner_ledger_slots[owner_ledger_find((uintptr_t)v)] || !fwp_rc_slot(v) || *fwp_rc_slot(v) != 1))\n        owner_ledger_error(204, \"reuse selected without one live counted owner\");\n    return result;"),
        );
    }
    replace_once(
        &mut code,
        "    /* Ownership observation point: before runtime teardown. */\n",
        "    /* Ownership observation point: before runtime teardown. */\n    owner_ledger_finish();\n",
    );
    code
}
