// Managed allocation counters shared by remote clients and HTTP clients/servers.
pub fn instrument_client_allocations(generated: &str) -> String {
    fn wrap(code: &mut String, signature: &str, name: &str, arguments: &str, count: &str) {
        assert_eq!(code.matches(signature).count(), 1);
        let begin = code.find(signature).unwrap();
        let mut end = begin + signature.len();
        let mut depth = 1;
        while depth != 0 {
            match code.as_bytes()[end] {
                b'{' => depth += 1,
                b'}' => depth -= 1,
                _ => {}
            }
            end += 1;
        }
        let original = code[begin..end].replacen(name, &format!("{name}_measured_body"), 1);
        let replacement = format!("{original}\n{signature}\n{count}\nvoid *result = {name}_measured_body({arguments});\nclient_sample();\nreturn result;\n}}\n");
        code.replace_range(begin..end, &replacement);
    }
    let mut code = generated.to_string();
    let declaration = "typedef uint64_t V;";
    assert_eq!(code.matches(declaration).count(), 1);
    code = code.replacen(declaration, &format!("{declaration}\nstatic int client_active;\nstatic uint64_t client_requests, client_requested_bytes, client_retains;\nstatic double client_start_charge, client_peak_charge;\nstatic void client_sample(void);\n"), 1);
    wrap(
        &mut code,
        "static inline void *fwp_gc_alloc(size_t n, int leaf) {",
        "fwp_gc_alloc",
        "n, leaf",
        "if(client_active && leaf != 0){client_requests++;client_requested_bytes+=n;}",
    );
    wrap(
        &mut code,
        "static inline void *fwp_alloc_init(size_t n) {",
        "fwp_alloc_init",
        "n",
        "if(client_active){client_requests++;client_requested_bytes+=n;}",
    );
    let retain = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
    assert_eq!(code.matches(retain).count(), 1);
    code = code.replacen(
        retain,
        &format!("{retain}\nif(client_active)client_retains++;"),
        1,
    );
    let main = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    code.insert_str(main, include_str!("../fixtures/grpc_client_memory.c"));
    let main = code
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    let mut entry = code[main..].to_owned();
    for (before, after) in [
        (
            "    fwp_init_consts();\n",
            "    fwp_init_consts();\n    client_measure_begin();\n",
        ),
        (
            "    /* Ownership observation point: before runtime teardown. */\n",
            "    /* Ownership observation point: before runtime teardown. */\n    client_measure_end();\n",
        ),
    ] {
        assert_eq!(entry.matches(before).count(), 1);
        entry = entry.replacen(before, after, 1);
    }
    code.replace_range(main.., &entry);
    code
}
