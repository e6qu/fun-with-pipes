//! Detached numeric tape buffers follow the runtime unwind chain.
use std::path::PathBuf;
#[path = "support/c_instrument.rs"]
mod c_instrument;
use std::process::{Command, Output};

#[path = "support/record_probe.rs"]
mod record_probe;

struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let path =
            std::env::temp_dir().join(format!("fwp-ad-unwind-{}-{name}", std::process::id()));
        std::fs::create_dir(&path).unwrap();
        Self(path)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?}: {}: {}",
        output.status,
        String::from_utf8_lossy(&output.stderr)
    );
    output
}
const PROBE: &str = include_str!("fixtures/ad_unwind_probe.c");

#[test]
fn detached_tape_buffers_release_on_return_trap_and_cancellation() {
    let scratch = Scratch::new("cleanup");
    let input = scratch.0.join("runtime.fwp");
    let cfile = scratch.0.join("runtime.c");
    std::fs::write(&input, "main = echo \"runtime\"\n").unwrap();
    for memory in ["arc", "tracing"] {
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", "0")
                .env("FWP_FREE", "1")
                .env("FWP_REUSE", "1")
                .args(["build", "--memory", "dynamic", "--gc", memory, "-O2"])
                .arg(&input)
                .args(["--emit-c", "-o"])
                .arg(&cfile),
        );
        let original = std::fs::read_to_string(&cfile).unwrap();
        let start = original
            .find("/* ------------------------------------------------------------------ tapes */")
            .unwrap();
        let end = original[start..]
            .find("/* ---------------------------------------------------------------- kernels */")
            .unwrap()
            + start;
        let tape_code = c_instrument::calls(&original[start..end], &[("free", "probe_free")])
            .replace("(double *)calloc(", "(double *)probe_calloc(")
            .replace(
                "V r = fwp_arr_new((size_t)tp.leaves);",
                "V r = probe_result_array((size_t)tp.leaves);",
            );
        assert_eq!(tape_code.matches("probe_free(b->").count(), 3);
        let declarations = "static void probe_free(void *);\nstatic void *probe_calloc(size_t,size_t);\nstatic V probe_result_array(size_t);\n";
        let runtime = format!(
            "{}{}{}{}",
            &original[..start],
            declarations,
            tape_code,
            &original[end..]
        )
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let push = "fwp_cleanup_push(&cleanup, fwp_tape_buffers_release, &buffers);";
        assert_eq!(runtime.matches(push).count(), 1);
        // This control removes the detached-buffer unwind registration only.
        let unprotected = runtime
            .replace(push, "(void)cleanup;")
            .replace(
                "fwp_cleanup_pop(&cleanup);\n        fwp_tape_buffers_release(&buffers);",
                "fwp_tape_buffers_release(&buffers);",
            )
            .replace(
                "fwp_cleanup_pop(&cleanup);\n    fwp_tape_buffers_release(&buffers);",
                "fwp_tape_buffers_release(&buffers);",
            );
        let unchecked = runtime.replace(
        "    if ((ra & 0xffffffff) >= idx || (rb >= 0 && (rb & 0xffffffff) >= idx))\n        fwp_trap(FWP_AD_INVALID_NODE);\n", "");
        assert_ne!(unchecked, runtime);
        let missing_release = runtime.replace("probe_free(b->pa);", "(void)b->pa;");
        // Bypass the cursor too: exhausted generations are excluded by both the
        // release cursor and the scan predicate. This control must actually wrap.
        assert_eq!(
            runtime
                .matches("int64_t slot = fwp_tape_next_slot;")
                .count(),
            1
        );
        let wrapping = runtime
        .replace("int64_t slot = fwp_tape_next_slot;", "int64_t slot = 0;")
        .replace("while (slot < fwp_ntapes && (fwp_tapes[slot].live || fwp_tapes[slot].gen >= 32767)) slot++;", "while (slot < fwp_ntapes && fwp_tapes[slot].live) slot++;")
        .replace("t->gen++;", "t->gen = t->gen % 32767 + 1;");
        assert_ne!(wrapping, runtime);
        let mut cases = vec![
            ("registered", runtime.clone(), PROBE.to_owned(), 0),
            ("unregistered", unprotected, PROBE.to_owned(), 41),
            ("missing-release", missing_release, PROBE.to_owned(), 41),
            ("wrapping", wrapping, PROBE.to_owned(), 46),
            ("unchecked", unchecked, PROBE.to_owned(), 31),
        ];
        if memory == "arc" {
            for (label, release) in [
                ("input-release-omitted", "fwp_rc_free_arr(seeds);"),
                ("result-release-omitted", "fwp_rc_free_arr(result);"),
            ] {
                let probe = PROBE.replace(release, "/* omitted release */");
                assert_ne!(probe, PROBE);
                cases.push((label, runtime.clone(), probe, 90));
            }
        }
        for opt in ["-O1", "-O2"] {
            for (label, code, probe, expected) in &cases {
                let executable = scratch.0.join(format!("{memory}{opt}-{label}.exe"));
                let source = format!("{code}\n{probe}");
                fwp::cgen::compile_c(&source, &executable, opt).unwrap();
                for reuse in if memory == "arc" {
                    &["0"][..]
                } else {
                    &["0", "1"][..]
                } {
                    let stress = if memory == "arc" { "0" } else { "1" };
                    let output = Command::new(&executable)
                        .env("FWP_AD_WORKSPACE", "0")
                        .env("FWP_GC", if memory == "arc" { "off" } else { "on" })
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", reuse)
                        .output()
                        .unwrap();
                    let label = format!("{memory}{opt}-{label}-reuse{reuse}");
                    if let Some(directory) = std::env::var_os("FWP_AD_ARTIFACTS") {
                        let directory = PathBuf::from(directory);
                        std::fs::create_dir_all(&directory).unwrap();
                        let prefix = directory.join(&label);
                        std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                        std::fs::write(prefix.with_extension("c"), &source).unwrap();
                        std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                        std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                        std::fs::write(
                            prefix.with_extension("status"),
                            format!("{}\n", output.status),
                        )
                        .unwrap();
                    }
                    record_probe::save("ad_tape_ownership", &label, &source, &executable, &output);
                    assert_eq!(output.status.code(), Some(*expected), "{label}: {output:?}");
                    assert!(output.stderr.is_empty(), "{label}: {output:?}");
                    if *expected == 0 {
                        assert_eq!(String::from_utf8_lossy(&output.stdout).replace("\r\n","\n"),"autodiff releases allocated detached buffers on return, trap and task cancellation\n");
                    } else {
                        assert!(output.stdout.is_empty(), "{label}: {output:?}");
                    }
                }
            }
        }
    }
}

#[test]
fn public_tape_tokens_agree_with_raw_interpreter() {
    let scratch = Scratch::new("tokens");
    let input = scratch.0.join("tokens.fwp");
    let common = "one-output : I64 -> Array[I64]\none-output = both id (const []) | uncurry Cons | array.from-list\nfinish : I64 -> Array[F64]\nfinish = make { 0 = id, 1 = add 1 | one-output, 2 = const [1.0] | array.from-list } | uncurry3 ad.backward\n";
    let cases = [
        ("left", "main = 1 | ad.tape | make { 0 = add 1, 1 = const 1.0, 2 = const -1, 3 = const 0.0 } | ad.push | echo\n", true),
        ("right", "main = 1 | ad.tape | make { 0 = id, 1 = const 1.0, 2 = add 1, 3 = const 1.0 } | ad.push | echo\n", true),
        ("backward", "main = 1 | ad.tape | finish | echo\n", true),
        ("empty", "empty : I64 -> Array[F64]\nempty = make { 0 = id, 1 = const [] | array.from-list, 2 = const [] | array.from-list } | uncurry3 ad.backward\nmain = 0 | ad.tape | empty | echo\n", false),
        ("paired", "paired : I64 -> Array[F64]\npaired = make { 0 = id, 1 = both id (const []) | uncurry Cons | array.from-list, 2 = const [2.0] | array.from-list } | uncurry3 ad.backward\nmain = 1 | ad.tape | paired | echo\n", false),
    ];
    for (label, source, invalid) in cases {
        // Raw tape handles require a lexical lifetime in checked ARC.
        let (declarations, body) = source.split_once("main = ").unwrap();
        let (value, body) = body.trim().split_once(" | ").unwrap();
        let body = body.strip_suffix(" | echo").unwrap();
        let scoped = format!("{common}{declarations}main = {value} | ad.scope ({body}) | echo\n");
        std::fs::write(&input, &scoped).unwrap();
        let reference = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        if invalid {
            assert!(!reference.status.success());
            assert!(
                String::from_utf8_lossy(&reference.stderr).contains("autodiff: invalid node index"),
                "{label}: {}",
                String::from_utf8_lossy(&reference.stderr)
            );
        } else {
            assert!(
                reference.status.success(),
                "{label}: {}",
                String::from_utf8_lossy(&reference.stderr)
            );
        }
        if let Some(directory) = std::env::var_os("FWP_ARC_ARTIFACTS") {
            let directory = PathBuf::from(directory).join("record-ownership/ad_tape_ownership");
            std::fs::create_dir_all(&directory).unwrap();
            let prefix = directory.join(format!("reference-{label}"));
            std::fs::write(prefix.with_extension("fwp"), std::fs::read(&input).unwrap()).unwrap();
            std::fs::write(prefix.with_extension("stdout"), &reference.stdout).unwrap();
            std::fs::write(prefix.with_extension("stderr"), &reference.stderr).unwrap();
            std::fs::write(
                prefix.with_extension("status"),
                format!("{:?}\n", reference.status.code()),
            )
            .unwrap();
        }
        for memory in ["arc", "tracing"] {
            for opt in ["-O1", "-O2"] {
                let executable = scratch.0.join(format!("{memory}{opt}-{label}.exe"));
                let cfile = executable.with_extension("c");
                for emit in [true, false] {
                    let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
                    command
                        .env_remove("FWP_NO_OPT")
                        .env("FWP_STACK", "0")
                        .env("FWP_FREE", "1")
                        .env("FWP_REUSE", "1")
                        .args(["build", "--memory", "dynamic", "--gc", memory, opt])
                        .arg(&input);
                    if emit {
                        command.arg("--emit-c");
                    }
                    command
                        .arg("-o")
                        .arg(if emit { &cfile } else { &executable });
                    checked(&mut command);
                }
                let code = std::fs::read_to_string(cfile).unwrap();
                for reuse in if memory == "arc" {
                    &["0"][..]
                } else {
                    &["0", "1"][..]
                } {
                    let stress = if memory == "arc" { "0" } else { "1" };
                    let output = Command::new(&executable)
                        .env("FWP_AD_WORKSPACE", "0")
                        .env("FWP_GC", if memory == "arc" { "off" } else { "on" })
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", reuse)
                        .output()
                        .unwrap();
                    let label = format!("{memory}{opt}-semantics-{label}-reuse{reuse}");
                    if let Some(directory) = std::env::var_os("FWP_AD_ARTIFACTS") {
                        let directory = PathBuf::from(directory);
                        std::fs::create_dir_all(&directory).unwrap();
                        let prefix = directory.join(&label);
                        std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                        std::fs::write(prefix.with_extension("c"), &code).unwrap();
                        std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                        std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                        std::fs::write(
                            prefix.with_extension("status"),
                            format!("{}\n", output.status),
                        )
                        .unwrap();
                    }
                    record_probe::save("ad_tape_ownership", &label, &code, &executable, &output);
                    assert_eq!(
                        output.status.code(),
                        reference.status.code(),
                        "{label}: {output:?}"
                    );
                    assert_eq!(output.stdout, reference.stdout, "{label}");
                    assert_eq!(output.stderr, reference.stderr, "{label}");
                }
            }
        }
    }
}
