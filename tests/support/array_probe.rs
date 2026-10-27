//! Allocation, retain, comparison and release hooks for native array probes.

pub(super) fn instrument(emitted: &str) -> String {
    let mut code = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    assert!(code.contains("#define FWP_UNWIND 1"));
    for (name, replacement, header, arguments) in [
        (
            "fwp_heap_alloc",
            "array_probe_allocate",
            "size_t n, int kind",
            "n, kind",
        ),
        (
            "fwp_alloc_init",
            "array_probe_allocate_init",
            "size_t n",
            "n",
        ),
    ] {
        let definition = format!("static inline void *{name}({header}) {{");
        assert_eq!(code.matches(&definition).count(), 1);
        code = code.replace(
            &definition,
            &format!("static inline void *{replacement}({header}) {{"),
        );
        let start = code
            .find(&format!("static inline void *{replacement}("))
            .unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end].replace("fwp_heap_alloc(n, 0)", "array_probe_allocate(n, 0)");
        code.replace_range(start..end, &body);
        code.insert_str(start + body.len(), &format!("\nstatic inline void *{name}({header}) {{ array_probe_tick(); void *p = {replacement}({arguments}); array_probe_record(p); return p; }}\n"));
    }
    for (from, to, count) in [
        (
            "static inline void fwp_rc_dup(V v) {\n",
            "static inline void fwp_rc_dup(V v) { array_probe_tick();\n",
            1,
        ),
        (
            "static void fwp_mem_free(void *p) {\n",
            "static void fwp_mem_free(void *p) { array_probe_release(p);\n",
            1,
        ),
    ] {
        assert_eq!(code.matches(from).count(), count, "{from}");
        code = code.replace(from, to);
    }

    let comparison = "static int fwp_cmp(V a, V b, const fwp_desc *d) {";
    assert_eq!(code.matches(comparison).count(), 1);
    code = code.replace(comparison, &format!("{comparison} array_probe_tick();"));
    format!("static void array_probe_tick(void); static void array_probe_record(void *); static void array_probe_release(void *);\n{code}")
}
