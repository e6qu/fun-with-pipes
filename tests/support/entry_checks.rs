// Separate instrumented binaries count generic ownership checks. They are never
// used for elapsed-time or code-size comparisons.
pub const SIGNATURE: &str = "static void fwp_rc_share(V v) {";

pub fn instrument(code: &str, definition: &str) -> String {
    assert_eq!(code.matches(definition).count(), 1);
    assert_eq!(code.matches("typedef uint64_t V;").count(), 1);
    let mut counted = code
        .replace(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic uint64_t measured_entry_checks;",
        )
        .replace(
            definition,
            &format!("{definition}\n    measured_entry_checks++;"),
        );
    let main = counted
        .find("static void *fwp_main_thread(void *arg) {")
        .unwrap();
    let entry = &counted[main..];
    assert_eq!(
        entry
            .matches("    /* Ownership observation point: before runtime teardown. */")
            .count(),
        1
    );
    let tail = entry.replacen("    /* Ownership observation point: before runtime teardown. */", "    /* Ownership observation point: before runtime teardown. */\n    fprintf(stderr, \"entry-checks\\t%llu\\n\", (unsigned long long)measured_entry_checks);", 1);
    counted.replace_range(main.., &tail);
    counted
}

pub fn count(stderr: &str) -> u64 {
    let mut rows = stderr
        .lines()
        .filter_map(|line| line.strip_prefix("entry-checks\t"));
    let count = rows.next().expect("entry check counter").parse().unwrap();
    assert!(rows.next().is_none(), "duplicate counter: {stderr}");
    count
}
