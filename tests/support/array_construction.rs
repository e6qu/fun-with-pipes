//! Moving list elements into arrays must preserve shared tails and every exit path.
use std::io::Write;
use std::path::Path;
use std::process::{Command, Output, Stdio};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn program(command: &mut Command) -> Output {
    let mut child = command
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child
        .stdin
        .take()
        .unwrap()
        .write_all(b"c a b c a\n")
        .unwrap();
    let output = child.wait_with_output().unwrap();
    assert!(output.status.success(), "{output:?}");
    output
}

fn save(label: &str, code: &str, binary: &Path, output: &Output) {
    if let Some(root) = std::env::var_os("FWP_ARC_ARTIFACTS") {
        let directory = Path::new(&root).join("array-construction");
        std::fs::create_dir_all(&directory).unwrap();
        let prefix = directory.join(label);
        std::fs::write(prefix.with_extension("c"), code).unwrap();
        std::fs::copy(binary, prefix.with_extension("exe")).unwrap();
        std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
        std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
        std::fs::write(
            prefix.with_extension("status"),
            format!("{:?}\n", output.status.code()),
        )
        .unwrap();
    }
}

fn allocation_probe(emitted: &str) -> String {
    let code = super::array_probe::instrument(emitted);
    let retain = "static inline void fwp_rc_dup(V v) { array_probe_tick();";
    assert_eq!(code.matches(retain).count(), 1);
    let code = format!(
        "static unsigned array_probe_retains;\n{}",
        code.replace(
            retain,
            "static inline void fwp_rc_dup(V v) { array_probe_retains++; array_probe_tick();"
        )
    );
    let mut probe = include_str!("../fixtures/array_construction_probe.c").to_owned();
    let call = "return fwp_p_array_from_list_typed(";
    for (prefix, kind) in [("STRING", "K_STR"), ("QUAD", "K_F128")] {
        let matches: Vec<_> = emitted
            .match_indices(call)
            .filter_map(|(at, _)| {
                let arguments: Vec<_> = emitted[at + call.len()..]
                    .split(");")
                    .next()
                    .unwrap()
                    .split(", ")
                    .collect();
                assert_eq!(arguments.len(), 4);
                let descriptor = arguments[3].strip_prefix('&').unwrap();
                let definition = format!("static const fwp_desc {descriptor} = {{{kind},");
                if !emitted.contains(&definition) {
                    return None;
                }
                let function = emitted[..at]
                    .rsplit("static V ")
                    .next()
                    .unwrap()
                    .split('(')
                    .next()
                    .unwrap();
                Some((function, arguments[2], arguments[3]))
            })
            .collect();
        assert_eq!(matches.len(), 1, "{prefix} array construction wrapper");
        let (function, drop, descriptor) = matches[0];
        let sorted = "return fwp_p_array_sort_typed(";
        let array_drops: Vec<_> = emitted
            .match_indices(sorted)
            .filter_map(|(at, _)| {
                let args: Vec<_> = emitted[at + sorted.len()..]
                    .split(");")
                    .next()
                    .unwrap()
                    .split(", ")
                    .collect();
                assert_eq!(args.len(), 4);
                (args[3] == descriptor).then_some(args[2])
            })
            .collect();
        assert_eq!(array_drops.len(), 1);
        probe = probe
            .replace(&format!("{prefix}_CONSTRUCT"), function)
            .replace(&format!("{prefix}_LIST_DROP"), drop)
            .replace(&format!("{prefix}_ARRAY_DROP"), array_drops[0])
            .replace(&format!("{prefix}_DESCRIPTOR"), descriptor);
    }
    format!("{code}\n{probe}")
}

#[test]
fn array_construction_moves_only_unshared_prefixes_and_cleans_interruptions() {
    let directory = fwp::cgen::TempDir::new("array-construction-ownership").unwrap();
    let input = directory.join("sort.fwp");
    let cfile = directory.join("sort.c");
    let binary = directory
        .join("sort")
        .with_extension(std::env::consts::EXE_EXTENSION);
    std::fs::write(&input, include_str!("../fixtures/array_sort_reuse.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = program(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );

    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "0")
            .env("FWP_ARRAY_FUSION", "0")
            .env("FWP_PACKED_ARRAYS", "1")
            .args(["build", "--memory", "dynamic", "--emit-c", "-O2", "-o"])
            .arg(&cfile)
            .arg(&input),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let probe = allocation_probe(&emitted);
    let changes = [
        ("shared-tail", "move_prefix = 0;", "move_prefix = 1;", 205),
        (
            "missing-retain",
            "if (dup && elem->kind != K_F128) dup(value);",
            "(void)dup;",
            205,
        ),
        (
            "missing-input",
            "fwp_value_owner input = {xs, drop_list};",
            "fwp_value_owner input = {xs, NULL};",
            211,
        ),
        (
            "missing-result",
            "static void fwp_array_builder_release(void *arg) {",
            "static void fwp_array_builder_release(void *arg) { (void)arg; return;",
            211,
        ),
        ("missing-node", "fwp_rc_free_obj(node);", "(void)node;", 211),
        (
            "missing-wide-release",
            "fwp_array_store_owned(result.value, i, value, elem);",
            "fwp_array_store(result.value, i, value, elem);",
            211,
        ),
    ];
    let mut cases = vec![
        ("program", emitted.clone(), 0),
        ("balanced", probe.clone(), 0),
        ("no-reuse", format!("#define FWP_NO_REUSE 1\n{probe}"), 0),
    ];
    let start = probe.find("static V fwp_p_array_from_list_typed(").unwrap();
    let end = start + probe[start..].find("\n}\n").unwrap() + 3;
    for (name, before, after, status) in changes {
        let mut changed = probe.clone();
        if name == "missing-result" {
            assert_eq!(changed.matches(before).count(), 1);
            changed = changed.replace(before, after);
        } else {
            let body = &probe[start..end];
            assert_eq!(body.matches(before).count(), 1, "{name}");
            changed.replace_range(start..end, &body.replace(before, after));
        }
        cases.push((name, changed, status));
    }
    for optimization in ["-O1", "-O2"] {
        for (case, code, status) in &cases {
            fwp::cgen::compile_c(code, &binary, optimization).unwrap();

            let mut command = Command::new(&binary);
            let output = if *case == "program" {
                program(&mut command)
            } else {
                command.output().unwrap()
            };
            let label = format!("counted{optimization}-{case}");
            save(&label, code, &binary, &output);
            assert_eq!(output.status.code(), Some(*status), "{label}: {output:?}");
            if *case == "program" {
                assert_eq!(output.stdout, reference.stdout, "{label}");
            }
            if *status == 0 {
                assert!(output.stderr.is_empty(), "{label}: {output:?}");
                if *case != "program" {
                    let text = String::from_utf8_lossy(&output.stdout);
                    assert!(
                        text.starts_with("array construction: 208 alias/bit-pattern cases and "),
                        "{label}: {text}"
                    );
                    assert!(
                        text.ends_with(" allocation/retain interruptions cleaned\n"),
                        "{text}"
                    );
                }
            } else {
                assert!(output.stdout.is_empty(), "{label}: {output:?}");
            }
        }
    }
}
