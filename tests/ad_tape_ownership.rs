//! Detached numeric tape buffers follow the runtime unwind chain.
use std::path::PathBuf;
#[path = "support/c_instrument.rs"]
mod c_instrument;
use std::process::{Command, Output};

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
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .arg("build")
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
    assert_eq!(tape_code.matches("probe_free(b->").count(), 5);
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
    let wrapping = runtime
        .replace("while (slot < fwp_ntapes && (fwp_tapes[slot].live || fwp_tapes[slot].gen >= 32767)) slot++;", "while (slot < fwp_ntapes && fwp_tapes[slot].live) slot++;")
        .replace("t->gen++;", "t->gen = t->gen % 32767 + 1;");
    assert_ne!(wrapping, runtime);
    for opt in ["-O1", "-O2"] {
        for (label, code, expected) in [
            ("registered", &runtime, 0),
            ("unregistered", &unprotected, 41),
            ("missing-release", &missing_release, 41),
            ("wrapping", &wrapping, 46),
            ("unchecked", &unchecked, 31),
        ] {
            let executable = scratch.0.join(format!("{label}{}", &opt[1..]));
            let source = format!("{code}\n{PROBE}");
            std::fs::write(executable.with_extension("c"), &source).unwrap();
            fwp::cgen::compile_c(&source, &executable, opt).unwrap();
            for reuse in ["0", "1"] {
                let output = Command::new(&executable)
                    .env("FWP_AD_WORKSPACE", "0")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", reuse)
                    .output()
                    .unwrap();
                if let Some(path) = std::env::var_os("FWP_AD_ARTIFACTS") {
                    let directory = PathBuf::from(path);
                    std::fs::create_dir_all(&directory).unwrap();
                    let prefix = directory.join(format!("{label}{}-reuse{reuse}", &opt[1..]));
                    std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                    std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                    std::fs::write(
                        prefix.with_extension("status"),
                        format!("{}\n", output.status),
                    )
                    .unwrap();
                    std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                    std::fs::write(prefix.with_extension("c"), &source).unwrap();
                }
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{label} {opt} reuse={reuse}: {}",
                    String::from_utf8_lossy(&output.stderr)
                );
                if expected == 0 {
                    assert_eq!(output.stdout, b"autodiff releases five detached buffers on return, trap and task cancellation\n");
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
        std::fs::write(&input, format!("{common}{source}")).unwrap();
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
        for opt in ["-O1", "-O2"] {
            let executable = scratch.0.join(format!("{label}{}", &opt[1..]));
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .arg("build")
                    .arg(&input)
                    .args([opt, "-o"])
                    .arg(&executable),
            );
            let native = Command::new(&executable)
                .env("FWP_AD_WORKSPACE", "0")
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(
                native.status.success(),
                reference.status.success(),
                "{label} {opt}"
            );
            assert_eq!(native.stdout, reference.stdout, "{label} {opt}");
            if invalid {
                assert_eq!(native.status.code(), Some(101));
                assert!(
                    String::from_utf8_lossy(&native.stderr)
                        .contains("autodiff: invalid node index"),
                    "{label} {opt}: {}",
                    String::from_utf8_lossy(&native.stderr)
                );
            }
        }
    }
}
