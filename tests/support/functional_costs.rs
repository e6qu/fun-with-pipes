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
        b"(66, 66)\n(64, 64)\n(528, 528)\n(70, 70)\n(65, 65)\n(496, 496)\n(496, 496)\n(528, 528)\n(66, 66)\n(64, 64)\n(528, 528)\n(70, 70)\n(65, 65)\n(496, 496)\n(496, 496)\n(528, 528)\n65\n65\n34\n65\n4\n64\n66\n272\n"
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
    let entry = |name: &str| format!("f{}", function(name));
    // Use the current native stage, not the number of arrows in the source type.
    // A saturated entry may return a function; further inputs call that result.
    // Fewer inputs construct an owned partial application. These constructor
    // captures are scalars/unit; the outer calls consume their callback owners.
    let call = |name: &str, arguments: &[&str]| {
        let id = function(name);
        let arity = program.funcs[id].arity as usize;
        assert!(arity > 0, "expected a callable entry: {name}");
        if arguments.len() < arity {
            return format!(
                "fwp_rc_fresh(fwp_pap({id}, {}, (V[]){{{}}}))",
                arguments.len(),
                arguments.join(", ")
            );
        }
        let mut result = format!("f{id}({})", arguments[..arity].join(", "));
        for argument in &arguments[arity..] {
            result = format!("fwp_apply_owned({result}, 1, (V[]){{{argument}}})");
        }
        result
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
            call("unknown-pipe", &[&call("increment", &["0"]), "n"]),
            "2 * (n + 1)",
        ),
        (
            "partial",
            format!(
                "fwp_apply_owned({}, 1, (V[]){{n}})",
                call("escaped-partial", &["n"])
            ),
            "2 * n",
        ),
        (
            "borrowed",
            call("unknown-borrowed", &[&call("increment", &["0"]), "n"]),
            "n * (n + 1) / 2",
        ),
        (
            "captured",
            format!(
                "fwp_apply_owned({}, 1, (V[]){{3}})",
                call("escaped-captured", &["n"])
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
            call("unknown-each", &[&call("accumulate", &["0"]), "n"]),
            "n * (n - 1) / 2",
        ),
        (
            "folded",
            call("unknown-fold", &[&call("addition", &["0"]), "n"]),
            "n * (n - 1) / 2",
        ),
        (
            "state-loop",
            call("unknown-state", &[&call("state-callback", &["0"]), "n"]),
            "n * (n + 1) / 2",
        ),
    ] {
        for (variant, expression) in [
            ("known", format!("{}(n)", entry(name))),
            ("named", format!("{}(n)", entry(&format!("named-{name}")))),
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
    for (name, expected) in [
        ("local-tuple", "2 * n + 1"),
        ("local-record", "2 * n + 1"),
        ("local-text-record", "n + digits"),
        ("local-variant", "2 * n + 1"),
        ("local-alias", "2 * digits"),
        ("local-owner-loop", "n * digits"),
        ("local-loop-alias", "(n + 1) * digits"),
        ("local-map-filter", "(n / 2) * (n / 2 + 1)"),
    ] {
        let function = entry(name);
        calls.push_str(&format!(
            r#"
    cost_requests = cost_bytes = cost_apply = cost_boxes = cost_retains = 0;
    cost_active = 1;
    result = {function}(n);
    fwp_tasks_finish();
    cost_active = 0;
    if(result != (V)({expected})) return 215;
    if(fwp_heap.live != baseline || fwp_cleanups || fwp_state_len || fwp_state_owners) return 216;
    printf("{name} local %llu %llu %llu %llu %llu %llu\n",
        (unsigned long long)n, cost_requests, cost_bytes, cost_apply, cost_boxes, cost_retains);
"#
        ));
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
    char decimal[32];
    V digits = (V)snprintf(decimal, sizeof decimal, "%llu", (unsigned long long)n);
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    {calls}
    fwp_tasks_finish(); fwp_caf_finish(); fwp_native_tasks_finish();
    if(fwp_heap.live || fwp_cleanups || fwp_state_owners) return 213;
    return 0;
}}
"#
    ));
    let mut failures = Vec::new();
    for optimization in ["-O0", "-O2"] {
        let binary = dir.join(format!("functional{optimization}.exe"));
        let artifact = std::env::var_os("FWP_ARC_ARTIFACTS").map(|root| {
            let root = PathBuf::from(root).join("functional");
            std::fs::create_dir_all(&root).unwrap();
            std::fs::write(root.join("functional.fwp"), source).unwrap();
            std::fs::write(root.join("program.ir"), format!("{program:#?}")).unwrap();
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
        for count in [0, 32, 128] {
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
        assert_eq!(observations.len(), 96);
        // Freeze the measured known-call costs, including costs still present.
        // All supported native targets use 64-bit values. These are runtime
        // requests, not C instructions; changing them needs a measured decision.
        for n in [32_u64, 128] {
            for (name, expected) in [
                ("pipe", [0, 0, 0, 0, 0]),
                ("partial", [0, 0, 0, 0, 0]),
                ("borrowed", [0, 0, 0, 0, 0]),
                ("captured", [0, 0, 0, 0, 0]),
                ("result", [1, 24, 0, 1, 1]),
                ("each-count", [2, 152, 1, 1, 0]),
                ("folded", [0, 0, 0, 0, 0]),
                ("state-loop", [2, 152, 1, 1, 0]),
            ] {
                let known = &observations[&(name.into(), "known".into(), n)];
                if known != &expected {
                    failures.push(format!(
                        "{optimization} known {name} n={n}: {known:?} != {expected:?}"
                    ));
                }
                let named = &observations[&(name.into(), "named".into(), n)];
                if named.iter().zip(expected).any(|(got, limit)| *got > limit) {
                    failures.push(format!(
                        "{optimization} named {name} n={n}: {named:?} exceeds {expected:?}"
                    ));
                }
            }
        }
        for n in [0_u64, 32, 128] {
            let digits = n.to_string().len() as u64;
            for (name, expected) in [
                ("local-tuple", [0, 0, 0, 0, 0]),
                ("local-map-filter", [0, 0, 0, 0, 0]),
                ("local-record", [0, 0, 0, 0, 0]),
                ("local-variant", [0, 0, 0, 0, 0]),
                ("local-text-record", [1, 9 + digits, 0, 0, 0]),
                ("local-alias", [1, 9 + digits, 0, 0, 0]),
            ] {
                let got = &observations[&(name.into(), "local".into(), n)];
                if got != &expected {
                    failures.push(format!(
                        "{optimization} {name} n={n}: {got:?} != {expected:?}"
                    ));
                }
            }
            for (name, retain_limit) in [("local-owner-loop", 0), ("local-loop-alias", 1)] {
                let got = &observations[&(name.into(), "local".into(), n)];
                if got[4] > retain_limit {
                    failures.push(format!(
                        "{optimization} {name} n={n}: {} retains exceed {retain_limit}",
                        got[4]
                    ));
                }
            }
        }
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
            if small[2] != large[2] {
                failures.push(format!(
                    "{optimization} known callback dispatch grew: {name}: {} -> {}",
                    small[2], large[2]
                ));
            }
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
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}
