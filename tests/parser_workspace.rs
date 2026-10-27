//! Semantic and lifetime controls for the A6 parser workspace.
use std::process::{Command, Output};

#[path = "support/allocation_report.rs"]
mod allocation_report;
#[path = "support/parser_region_probe.rs"]
mod parser_region_probe;
#[path = "support/record_probe.rs"]
mod record_probe;

const SOURCE: &str = include_str!("fixtures/parser_workspace.fwp");
const EXPECTED: &str = "14\n45\n-7\nErr \"missing expression\"\nErr \"expected an integer\"\nErr \"trailing input\"\n14\n70\nNone\n(5, 5)\n10\n10\n";

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&output.stderr)
    );
    output
}

#[test]
fn parsing_nested_calls_cancellation_and_escaped_trees_preserve_semantics() {
    let dir = fwp::cgen::TempDir::new("parser-workspace").unwrap();
    let source = dir.join("parser.fwp");
    let cfile = dir.join("parser.c");
    std::fs::write(&source, SOURCE).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(reference.stdout, EXPECTED.as_bytes());
    for stack in ["0", "1"] {
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", stack)
                .args(["build", "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        for name in ["calculate", "nested", "recursive", "suspended"] {
            let marker = format!("/* {name} :");
            let entry = code
                .split(&marker)
                .nth(1)
                .expect("exported parser entry")
                .split("\n}\n")
                .next()
                .unwrap();
            assert!(
                entry.contains("fwp_region region = {0};"),
                "{name} did not select a region"
            );
        }
        for opt in ["-O1", "-O2"] {
            let label = format!("values-stack{stack}{opt}");
            let executable = dir.join(format!("{label}.exe"));
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let output = checked(Command::new(&executable).env("FWP_ALLOC_STATS", "1"));
            record_probe::save("parser_workspace", &label, &code, &executable, &output);
            assert_eq!(output.stdout, reference.stdout, "{label}");
            let report = allocation_report::parse(&String::from_utf8_lossy(&output.stderr))
                .expect("allocation report");
            assert_eq!(report.live, 0, "{label}: {report:?}");
        }
    }
}

#[test]
fn generated_parser_links_avoid_counts_and_release_each_failed_allocation() {
    let dir = fwp::cgen::TempDir::new("parser-generated-owners").unwrap();
    let source = dir.join("parser.fwp");
    let cfile = dir.join("parser.c");
    std::fs::write(&source, SOURCE).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--emit-c",
                "--memory",
                "dynamic",
                "--fn",
                "calculate",
            ])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let measured = parser_region_probe::instrument(&code, "calculate", fwp::cgen::Target::Native);
    for opt in ["-O1", "-O2"] {
        for (name, code, status) in [
            ("ordinary", measured.clone(), 0),
            (
                "extra-count",
                measured.replace("/* extra-link-count */", "fwp_rc_dup(PTR(node));"),
                251,
            ),
            (
                "missing-free",
                measured.replace(
                    "        fwp_mem_free(block);",
                    "        /* omitted block free */",
                ),
                248,
            ),
        ] {
            let label = format!("generated-{name}{opt}");
            let executable = dir.join(format!("{label}.exe"));
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let output = Command::new(&executable).output().unwrap();
            record_probe::save("parser_workspace", &label, &code, &executable, &output);
            assert_eq!(output.status.code(), Some(status), "{label}: {output:?}");
            assert!(
                output.stdout.is_empty() && output.stderr.is_empty(),
                "{label}: {output:?}"
            );
        }
    }
}

#[test]
fn checked_arithmetic_traps_are_not_catchable_parse_errors() {
    let dir = fwp::cgen::TempDir::new("parser-workspace-traps").unwrap();
    let (definitions, _) = SOURCE.split_once("main = [").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (name, input) in [
        ("add", "+ 9223372036854775807 1"),
        ("multiply", "* 9223372036854775807 2"),
    ] {
        let source = dir.join(format!("{name}.fwp"));
        std::fs::write(
            &source,
            format!("{definitions}\nmain = \"{input}\" | attempt calculate | echo\n"),
        )
        .unwrap();
        let reference = Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source)
            .output()
            .unwrap();
        assert_eq!(reference.status.code(), Some(101));
        assert!(reference.stdout.is_empty());
        assert_eq!(reference.stderr, b"fwp: trap: arithmetic overflow in I64\n");
        for opt in ["-O1", "-O2"] {
            let executable = dir.join(format!("{name}{opt}.exe"));
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .arg("build")
                    .arg(&source)
                    .args([opt, "-o"])
                    .arg(&executable),
            );
            let output = Command::new(&executable).output().unwrap();
            assert_eq!(output.status.code(), reference.status.code());
            assert_eq!(output.stdout, reference.stdout);
            assert_eq!(output.stderr, reference.stderr);
        }
    }
}

#[test]
fn region_blocks_free_on_success_nested_calls_and_each_allocation_failure() {
    let dir = fwp::cgen::TempDir::new("parser-region-blocks").unwrap();
    let source = dir.join("empty.fwp");
    let cfile = dir.join("empty.c");
    std::fs::write(&source, "main = ()\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--emit-c", "--memory", "dynamic"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let prefix = &emitted[..emitted.find("int main(").expect("generated main")];
    let probe = include_str!("fixtures/parser_region_probe.c").replace(
        "@region_runtime@",
        include_str!("../runtime/fwp_rt_region.c"),
    );
    let ordinary = format!("{prefix}\n{probe}");
    assert_eq!(ordinary.matches("        fwp_mem_free(block);").count(), 1);
    let retained = ordinary.replace(
        "        fwp_mem_free(block);",
        "        /* missing block release */",
    );
    for opt in ["-O1", "-O2"] {
        for (name, code, status) in [("ordinary", &ordinary, 0), ("missing-free", &retained, 248)] {
            let label = format!("blocks-{name}{opt}");
            let executable = dir.join(format!("{label}.exe"));
            fwp::cgen::compile_c(code, &executable, opt).unwrap();
            let output = Command::new(&executable).output().unwrap();
            record_probe::save("parser_workspace", &label, code, &executable, &output);
            assert_eq!(output.status.code(), Some(status), "{label}: {output:?}");
            assert!(
                output.stdout.is_empty() && output.stderr.is_empty(),
                "{label}: {output:?}"
            );
        }
    }
}

#[test]
fn recursive_public_calls_keep_five_distinct_invocation_owners() {
    let dir = fwp::cgen::TempDir::new("parser-recursive-owners").unwrap();
    let source = dir.join("parser.fwp");
    let cfile = dir.join("parser.c");
    std::fs::write(&source, SOURCE).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--emit-c",
                "--memory",
                "dynamic",
                "--fn",
                "recursive",
            ])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let start = code.find("/* recursive :").expect("recursive entry");
    let id = code[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let mut probe = code[..code.find("int main(").unwrap()].replace(
        "typedef uint64_t V;",
        "typedef uint64_t V;\nstatic size_t parser_owners, parser_peak_owners;",
    );
    assert!(probe.contains("    fwp_region region = {0};"));
    probe = probe.replace("    fwp_region region = {0};",
        "    fwp_region region = {0};\n    if (++parser_owners > parser_peak_owners) parser_peak_owners = parser_owners;");
    probe = probe.replace("static void fwp_region_release(void *context) {",
        "static void fwp_region_release(void *context) {\n    if (!parser_owners) exit(241);\n    parser_owners--;");
    probe.push_str(&format!(
        r#"
int main(void) {{
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts(); fwp_budget = INT32_MAX;
    size_t baseline = fwp_heap.live;
    V text = fwp_rc_fresh(fwp_cstr("+ 2 * 3 4"));
    V input = fwp_rc_fresh(fwp_record(2, (V[]){{4, text}}));
    if (f{id}(input) != 70) return 242;
    if (parser_owners || parser_peak_owners != 5) return 243;
    return fwp_heap.live == baseline ? 0 : 248;
}}
"#
    ));
    for opt in ["-O1", "-O2"] {
        let label = format!("recursive-owners{opt}");
        let binary = dir.join(format!("{label}.exe"));
        fwp::cgen::compile_c(&probe, &binary, opt).unwrap();
        let output = checked(&mut Command::new(&binary));
        record_probe::save("parser_workspace", &label, &probe, &binary, &output);
        assert!(output.stdout.is_empty() && output.stderr.is_empty());
    }
}
