//! Interrupt each allocation/retain and callback while copied lists are live.
use std::path::Path;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

fn save(label: &str, code: &str, binary: &Path, output: &Output) {
    if let Some(root) = std::env::var_os("FWP_ARC_ARTIFACTS") {
        let directory = Path::new(&root).join("list-copy");
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
    let line = emitted
        .lines()
        .find(|line| line.contains("V result = fwp_p_sort_copied(l"))
        .unwrap();
    let descriptor = line
        .split("; return result;")
        .next()
        .unwrap()
        .rsplit(", ")
        .next()
        .unwrap()
        .trim_end_matches(')');
    assert!(descriptor.starts_with("&d"), "{line}");
    let mut code = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    assert!(code.contains("#define FWP_UNWIND 1"));
    for (name, replacement, header, arguments) in [
        (
            "fwp_heap_alloc",
            "copy_allocate",
            "size_t n, int kind",
            "n, kind",
        ),
        ("fwp_alloc_init", "copy_allocate_init", "size_t n", "n"),
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
        let body = code[start..end].replace("fwp_heap_alloc(n, 0)", "copy_allocate(n, 0)");
        code.replace_range(start..end, &body);
        code.insert_str(start + body.len(), &format!("\nstatic inline void *{name}({header}) {{ copy_tick(); void *p = {replacement}({arguments}); copy_record(p); return p; }}\n"));
    }
    for (from, to, count) in [
        (
            "static inline void fwp_rc_dup(V v) {\n",
            "static inline void fwp_rc_dup(V v) { copy_tick();\n",
            1,
        ),
        (
            "static void fwp_mem_free(void *p) {\n",
            "static void fwp_mem_free(void *p) { copy_release(p);\n",
            1,
        ),
    ] {
        assert_eq!(code.matches(from).count(), count, "{from}");
        code = code.replace(from, to);
    }
    let probe =
        include_str!("../fixtures/list_copy_probe.c").replace("LIST_DESCRIPTOR", descriptor);
    format!("static void copy_tick(void); static void copy_record(void *); static void copy_release(void *);\n{code}\n{probe}")
}

#[test]
fn partial_lists_keys_and_scratch_release_on_every_exit() {
    let directory = fwp::cgen::TempDir::new("list-copy-failures").unwrap();
    let input = directory.join("copies.fwp");
    let cfile = directory.join("copies.c");
    let binary = directory
        .join("copies")
        .with_extension(std::env::consts::EXE_EXTENSION);
    std::fs::write(&input, include_str!("../fixtures/list_copy.fwp")).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for memory in ["arc", "tracing"] {
        checked(
            Command::new(fwp)
                .args([
                    "build", "--gc", memory, "--memory", "dynamic", "--emit-c", "-O2", "-o",
                ])
                .arg(&cfile)
                .arg(&input),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let probe = allocation_probe(&emitted);
        for optimization in ["-O1", "-O2"] {
            for (case, code, status) in [
                ("program", emitted.clone(), 0),
                ("balanced", probe.clone(), 0),
                (
                    "missing-key",
                    probe.replace(
                        "fwp_map_owner owner = {keys, 0, 0, drop_key, NULL};",
                        "fwp_map_owner owner = {keys, 0, 0, NULL, NULL};",
                    ),
                    213,
                ),
                (
                    "missing-scratch",
                    probe.replace(
                        "static void fwp_scratch_release(void *arg) {",
                        "static void fwp_scratch_release(void *arg) { (void)arg; return;",
                    ),
                    213,
                ),
                (
                    "missing-partial",
                    probe.replace(
                        "fwp_value_owner result = {owned_tail, list->drop};",
                        "fwp_value_owner result = {owned_tail, NULL};",
                    ),
                    213,
                ),
            ] {
                if status != 0 {
                    assert_ne!(code, probe, "{case}");
                }
                fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
                for reuse in if memory == "arc" || status != 0 {
                    &["0"][..]
                } else {
                    &["0", "1"][..]
                } {
                    let stress = if memory == "tracing" && status == 0 {
                        "1"
                    } else {
                        "0"
                    };
                    let output = Command::new(&binary)
                        .env("FWP_GC", if memory == "arc" { "off" } else { "on" })
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", reuse)
                        .output()
                        .unwrap();
                    save(
                        &format!("{memory}{optimization}-{case}-reuse{reuse}"),
                        &code,
                        &binary,
                        &output,
                    );
                    assert_eq!(
                        output.status.code(),
                        Some(status),
                        "{memory} {optimization} {case} reuse{reuse}: {output:?}"
                    );
                    if case == "program" {
                        assert_eq!(output.stdout, reference.stdout);
                    }
                    if case == "balanced" {
                        let text = String::from_utf8_lossy(&output.stdout);
                        assert!(text.starts_with("7 copied-list operations: "), "{text}");
                        assert!(text.ends_with(" allocation/retain failures and 6 callback exits cleaned; aliases preserved\n"), "{text}");
                        eprint!("{memory} {optimization} reuse{reuse}: {text}");
                    }
                    if status == 0 {
                        assert!(output.stderr.is_empty(), "{output:?}");
                    } else {
                        assert!(
                            String::from_utf8_lossy(&output.stderr)
                                .contains("copied-list live allocations:"),
                            "{output:?}"
                        );
                    }
                }
            }
        }
    }
}
