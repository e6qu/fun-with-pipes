//! Execute both sides of eight abstraction boundaries. These counters describe
//! runtime operation requests, not elapsed time or machine instruction counts.
use std::collections::BTreeMap;
use std::path::PathBuf;
use std::process::Command;

use super::checked;

#[test]
fn functional_call_matrix_counts_executed_work_and_releases_owners() {
    let source = include_str!("../fixtures/functional_costs.fwp");
    let dir = fwp::cgen::TempDir::new("functional-costs").unwrap();
    let input = dir.join("functional.fwp");
    std::fs::write(&input, source).unwrap();
    let raw = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    assert_eq!(
        raw.stdout,
        b"(66, 66)\n(64, 64)\n(528, 528)\n(70, 70)\n(65, 65)\n(496, 496)\n(496, 496)\n(528, 528)\n"
    );
    assert!(raw.stderr.is_empty(), "{raw:?}");
    let (_, program) = fwp::driver::compile_source(
        "functional.fwp",
        source,
        fwp::mono::Roots {
            main: true,
            exports: true,
            ..Default::default()
        },
    )
    .map_err(|e| e.rendered)
    .unwrap();
    let function = |name: &str| {
        let (_, id) = program.exports.iter().find(|(n, _)| n == name).unwrap();
        *id
    };
    let entry = |name| format!("f{}", function(name));
    // Arrow-spine functions use saturated C entries. A caller supplying fewer
    // arguments constructs an owned partial application, not a short C call.
    // All captures in this fixture are scalars or unit, so no child owner moves.
    let partial = |name: &str, argument: &str, arity: u32| {
        let id = function(name);
        assert_eq!(program.funcs[id].arity, arity);
        format!("fwp_rc_fresh(fwp_pap({id}, 1, (V[]){{{argument}}}))")
    };
    let mut code = fwp::cgen::generate(&program).unwrap();
    let declaration = "typedef uint64_t V;";
    assert_eq!(code.matches(declaration).count(), 1);
    code = code.replace(declaration, &format!("{declaration}\nstatic int cost_active;\nstatic unsigned long long cost_requests, cost_bytes, cost_apply, cost_boxes, cost_retains;"));
    for (marker, count) in [
        ("static inline void *fwp_alloc_init(size_t n) {", "cost_requests++; cost_bytes += n;"),
        ("static inline void *fwp_heap_alloc(size_t n, int kind) {", "if(kind != 0) { cost_requests++; cost_bytes += n; }"),
        ("static V fwp_data(uint32_t tag, uint32_t n, const V *f) {", "if(n) cost_boxes++;"),
        ("static V fwp_apply(V f, uint32_t n, V *args) {", "cost_apply++;"),
        ("static V fwp_apply_owned(V f, uint32_t n, V *args) {", "cost_apply++;"),
        ("static V fwp_apply_borrowed_span(V f, uint32_t n, V *args, uint32_t owned_start, uint32_t owned_len) {", "cost_apply++;"),
        ("static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {", "cost_retains++;"),
    ] {
        assert_eq!(code.matches(marker).count(), 1, "{marker}");
        code = code.replace(marker, &format!("{marker} if(cost_active) {{ {count} }}"));
    }
    let mut calls = String::new();
    for (name, control, expected) in [
        (
            "pipe",
            format!(
                "{}({}, n)",
                entry("unknown-pipe"),
                partial("increment", "0", 2)
            ),
            "2 * (n + 1)",
        ),
        (
            "partial",
            format!(
                "fwp_apply_owned({}, 1, (V[]){{n}})",
                partial("escaped-partial", "n", 2)
            ),
            "2 * n",
        ),
        (
            "borrowed",
            format!(
                "{}({}, n)",
                entry("unknown-borrowed"),
                partial("increment", "0", 2)
            ),
            "n * (n + 1) / 2",
        ),
        (
            "captured",
            format!(
                "fwp_apply_owned({}, 1, (V[]){{3}})",
                partial("escaped-captured", "n", 2)
            ),
            "2 * (n + 3)",
        ),
        (
            "result",
            format!("{}({}(n))", entry("consume"), entry("produce")),
            "2 * n + 1",
        ),
        (
            "each-count",
            format!(
                "{}({}, n)",
                entry("unknown-each"),
                partial("accumulate", "0", 2)
            ),
            "n * (n - 1) / 2",
        ),
        (
            "folded",
            format!(
                "{}({}, n)",
                entry("unknown-fold"),
                partial("addition", "0", 3)
            ),
            "n * (n - 1) / 2",
        ),
        (
            "state-loop",
            format!(
                "{}({}, n)",
                entry("unknown-state"),
                partial("state-callback", "0", 2)
            ),
            "n * (n + 1) / 2",
        ),
    ] {
        for (variant, expression) in [
            ("known", format!("{}(n)", entry(name))),
            ("boundary", control),
        ] {
            calls.push_str(&format!(
                r#"
    cost_requests = cost_bytes = cost_apply = cost_boxes = cost_retains = 0;
    cost_active = 1;
    result = {expression};
    fwp_tasks_finish();
    cost_active = 0;
    if(result != (V)({expected})) return 211;
    if(fwp_heap.live != baseline || fwp_cleanups || fwp_state_len || fwp_state_owners) return 212;
    printf("{name} {variant} %llu %llu %llu %llu %llu %llu\n",
        (unsigned long long)n, cost_requests, cost_bytes, cost_apply, cost_boxes, cost_retains);
"#
            ));
        }
    }
    let main = "int main(int argc, char **argv)";
    assert_eq!(code.matches(main).count(), 1);
    code = code.replace(main, "int original_main(int argc, char **argv)");
    let mut callable_checks = String::new();
    for name in [
        "increment",
        "escaped-partial",
        "escaped-captured",
        "accumulate",
        "addition",
        "state-callback",
    ] {
        let id = function(name);
        callable_checks.push_str(&format!(
            "    if(!fwp_fn_table[{id}].entry || !fwp_fn_table[{id}].owned) {{ fputs(\"missing typed callback entry: {name}\\n\", stderr); return 214; }}\n"
        ));
    }
    code.push_str(&format!(
        r#"
int main(int argc, char **argv) {{
    if(argc != 2) return 210;
    {callable_checks}
    V n = (V)strtoull(argv[1], NULL, 10), result;
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    {calls}
    fwp_tasks_finish(); fwp_caf_finish(); fwp_native_tasks_finish();
    if(fwp_heap.live || fwp_cleanups || fwp_state_owners) return 213;
    return 0;
}}
"#
    ));
    for optimization in ["-O0", "-O2"] {
        let binary = dir.join(format!("functional{optimization}.exe"));
        let artifact = std::env::var_os("FWP_ARC_ARTIFACTS").map(|root| {
            let root = PathBuf::from(root).join("functional");
            std::fs::create_dir_all(&root).unwrap();
            std::fs::write(root.join("functional.fwp"), source).unwrap();
            let prefix = root.join(format!("functional{optimization}"));
            std::fs::write(prefix.with_extension("c"), &code).unwrap();
            prefix
        });
        fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
        if let Some(prefix) = &artifact {
            std::fs::copy(&binary, prefix.with_extension("exe")).unwrap();
            let (tool, flag) = if cfg!(target_os = "macos") {
                ("otool", "-tvV")
            } else if cfg!(windows) {
                ("llvm-objdump", "-d")
            } else {
                ("objdump", "-d")
            };
            let listing = checked(Command::new(tool).arg(flag).arg(&binary));
            assert!(!listing.stdout.is_empty());
            std::fs::write(prefix.with_extension("asm"), listing.stdout).unwrap();
        }
        let mut observations = BTreeMap::new();
        let mut report =
            String::from("case variant input allocations bytes applications boxes retains\n");
        for count in [32, 128] {
            let output = Command::new(&binary)
                .arg(count.to_string())
                .output()
                .unwrap();
            if let Some(prefix) = &artifact {
                std::fs::write(
                    prefix.with_extension(format!("{count}.stdout")),
                    &output.stdout,
                )
                .unwrap();
                std::fs::write(
                    prefix.with_extension(format!("{count}.stderr")),
                    &output.stderr,
                )
                .unwrap();
                std::fs::write(
                    prefix.with_extension(format!("{count}.status")),
                    format!("{:?}\n", output.status.code()),
                )
                .unwrap();
            }
            assert!(
                output.status.success(),
                "{optimization} n={count}: {output:?}"
            );
            assert!(output.stderr.is_empty(), "{output:?}");
            let text = String::from_utf8(output.stdout).unwrap();
            report.push_str(&text);
            for line in text.lines() {
                let fields: Vec<_> = line.split_whitespace().collect();
                assert_eq!(fields.len(), 8, "{line}");
                let metrics: Vec<u64> = fields[3..].iter().map(|s| s.parse().unwrap()).collect();
                assert_eq!(fields[2], count.to_string());
                assert!(observations
                    .insert((fields[0].to_owned(), fields[1].to_owned(), count), metrics)
                    .is_none());
            }
        }
        assert_eq!(observations.len(), 32);
        for name in [
            "pipe",
            "partial",
            "borrowed",
            "captured",
            "result",
            "each-count",
            "folded",
            "state-loop",
        ] {
            let small = &observations[&(name.into(), "known".into(), 32)];
            let large = &observations[&(name.into(), "known".into(), 128)];
            assert_eq!(
                small[2], large[2],
                "known callback dispatch grew: {name}: {report}"
            );
            if name != "result" {
                assert!(
                    observations[&(name.into(), "boundary".into(), 32)][2] > 0,
                    "unknown/escaped call was never observed: {name}: {report}"
                );
            }
        }
        eprint!("{optimization}\n{report}");
        if let Some(prefix) = &artifact {
            std::fs::write(prefix.with_extension("txt"), &report).unwrap();
        }
    }
}
