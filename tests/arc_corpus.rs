//! Run every eligible golden program in checked ARC mode; report rejections explicitly.
use std::io::Write;
use std::process::{Command, Output, Stdio};

#[test]
fn eligible_golden_programs_preserve_semantics_and_reclaim_values() {
    let root = std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/run");
    let scratch = std::env::temp_dir().join(format!("fwp-arc-corpus-{}", std::process::id()));
    std::fs::create_dir(&scratch).unwrap();
    let mut paths: Vec<_> = std::fs::read_dir(&root)
        .unwrap()
        .map(|p| p.unwrap().path())
        .filter(|p| p.extension().is_some_and(|extension| extension == "fwp"))
        .collect();
    // The raw evaluator exhausts its bounded stack at 100000 non-tail calls.
    // Keep the original deep native/golden control and compare the same program
    // at 100 calls against the raw evaluator without raising resource limits.
    let optimizer = std::fs::read_to_string(root.join("optimizer.fwp")).unwrap();
    assert_eq!(optimizer.matches("100000 | count-down").count(), 1);
    let bounded = scratch.join("optimizer_bounded.fwp");
    std::fs::write(
        &bounded,
        optimizer.replace("100000 | count-down", "100 | count-down"),
    )
    .unwrap();
    paths.push(bounded);
    paths.sort();
    let total = paths.len();
    let mut executed = 0;
    let mut rejected = 0;
    let mut compile_errors = 0;
    let mut failures = Vec::new();
    let mut report =
        String::from("ARC golden corpus: rejected programs are not execution support\n");
    let artifacts = std::env::var_os("FWP_ARC_ARTIFACTS").map(std::path::PathBuf::from);
    if let Some(path) = &artifacts {
        std::fs::create_dir_all(path).unwrap();
    }
    for path in paths {
        let name = path.file_stem().unwrap().to_str().unwrap();
        let cfile = scratch.join(format!("{name}.c"));
        let source_path = if path.parent() == Some(root.as_path()) {
            std::path::Path::new(path.file_name().unwrap())
        } else {
            path.as_path()
        };
        let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", "arc", "--emit-c", "-O1"])
            .arg(source_path)
            .current_dir(&root)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        if name.starts_with("err_") {
            assert_eq!(emitted.status.code(), Some(1), "{name}");
            assert!(emitted.stdout.is_empty(), "{name}");
            let expected = std::fs::read_to_string(path.with_extension("out")).unwrap();
            let actual = format!(
                "--- stderr\n{}--- exit 1\n",
                String::from_utf8_lossy(&emitted.stderr)
            );
            assert_eq!(actual, expected, "front-end diagnostic for {name}");
            report.push_str(&format!(
                "compile-error\t{name}\tverified golden diagnostic\n"
            ));
            compile_errors += 1;
        } else if !emitted.status.success() {
            let reason = String::from_utf8_lossy(&emitted.stderr);
            assert!(
                reason.contains("--gc arc:"),
                "unexpected compilation failure for {name}: {reason}"
            );
            report.push_str(&format!("rejected\t{name}\t{reason:?}\n"));
            rejected += 1;
            if [
                "any_sized",
                "basics",
                "case_of_case",
                "collections_build",
                "comptime",
                "float_literals",
                "forward_aliases",
                "fusion_find_trap",
                "fusion_iter",
                "fusion_lists",
                "fusion_traps",
                "loop_nested_state",
                "map_lookup_match",
                "opt_constant_order",
                "optimizer",
                "reuse_aliasing",
                "show_ints",
                "traits",
                "trap_format_count",
                "unboxed_records",
                "optimizer_bounded",
            ]
            .contains(&name)
            {
                failures.push(format!(
                    "previously eligible ARC program {name} was rejected: {reason}"
                ));
            }
        } else {
            let code = std::fs::read_to_string(&cfile).unwrap();
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
            assert_eq!(main.matches("    fwp_cl_finish();\n").count(), 1);
            // Final teardown must release every charge, including scheduler storage.
            let main = main.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t arc_budget = fwp_gc.budget_given;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if (fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < arc_budget) { fprintf(stderr, \"ARC unreclaimed bytes: %ld\\n\", (long)(arc_budget-fwp_gc.budget)); exit(193); }\n");
            let measured = format!("{runtime}{main}");
            let binary = scratch.join(name);
            fwp::cgen::compile_c(&measured, &binary, "-O1").unwrap();
            let input = match std::fs::read(path.with_extension("in")) {
                Ok(input) => input,
                Err(error) if error.kind() == std::io::ErrorKind::NotFound => Vec::new(),
                Err(error) => panic!("input for {name}: {error}"),
            };
            let execute = |command: &mut Command| -> Output {
                let mut child = command
                    .current_dir(&root)
                    .env("FWP_SEED", "42")
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .stdin(Stdio::piped())
                    .stdout(Stdio::piped())
                    .stderr(Stdio::piped())
                    .spawn()
                    .unwrap();
                child.stdin.take().unwrap().write_all(&input).unwrap();
                child.wait_with_output().unwrap()
            };
            let mut interpreter = Command::new(env!("CARGO_BIN_EXE_fwp"));
            // Preemption counts entries in the selected IR: inlining changes
            // that count. Compare the optimized program with its optimized
            // interpreter and golden. preempt.rs also compares both raw engines.
            let optimized_reference = matches!(name, "optimizer" | "preempt");
            if optimized_reference {
                interpreter.env_remove("FWP_NO_OPT");
            } else {
                interpreter.env("FWP_NO_OPT", "1");
            }
            let reference = execute(interpreter.args(["run", "--interp"]).arg(source_path));
            if optimized_reference {
                assert!(reference.status.success() && reference.stderr.is_empty());
                assert_eq!(
                    reference.stdout,
                    std::fs::read(path.with_extension("out")).unwrap()
                );
            }
            let actual = execute(&mut Command::new(&binary));
            let matches = actual.status.code().is_some()
                && actual.status.code() == reference.status.code()
                && actual.stdout == reference.stdout
                && actual.stderr == reference.stderr;
            if !matches {
                if let Some(path) = &artifacts {
                    std::fs::write(path.join(format!("corpus-failed-{name}.c")), &measured)
                        .unwrap();
                    std::fs::write(path.join("corpus.txt"), &report).unwrap();
                }
            }
            if !matches {
                failures.push(format!("ARC corpus {name}: expected {:?} stdout={} stderr={}; got {:?} stdout={} stderr={}",
                reference.status.code(), String::from_utf8_lossy(&reference.stdout), String::from_utf8_lossy(&reference.stderr),
                actual.status.code(), String::from_utf8_lossy(&actual.stdout), String::from_utf8_lossy(&actual.stderr)));
            }
            report.push_str(&format!(
                "executed\t{name}\tstatus={:?}\treturn-ledger={}\toracle={}\n",
                actual.status.code(),
                actual.status.success(),
                if optimized_reference {
                    "optimized-interpreter-and-golden"
                } else {
                    "raw-interpreter"
                }
            ));
            executed += 1;
        }
        if let Some(path) = &artifacts {
            std::fs::write(path.join("corpus.txt"), &report).unwrap();
        }
    }
    assert!(executed > 0 && rejected > 0);
    assert_eq!(executed + rejected + compile_errors, total);
    report.push_str(&format!(
        "total={total} executed={executed} rejected={rejected} compile-errors={compile_errors}\n"
    ));
    if let Some(path) = &artifacts {
        std::fs::write(path.join("corpus.txt"), &report).unwrap();
    }
    println!("{report}");
    assert!(failures.is_empty(), "{}", failures.join("\n"));
    std::fs::remove_dir_all(scratch).unwrap();
}
