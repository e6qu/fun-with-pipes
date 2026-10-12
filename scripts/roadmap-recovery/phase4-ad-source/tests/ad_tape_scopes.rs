//! Gradients own active tape buffers across callback return and nonlocal exits.
use std::path::PathBuf;
use std::process::{Command, Output};
struct Scratch(PathBuf);
impl Scratch {
    fn new(label: &str) -> Self {
        let path =
            std::env::temp_dir().join(format!("fwp-ad-scope-{}-{label}", std::process::id()));
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
const PROBE: &str = include_str!("fixtures/ad_scope_probe.c");
#[test]
fn callback_scopes_release_live_tapes_without_per_scope_heap_owners() {
    let scratch = Scratch::new("unwind");
    let input = scratch.0.join("runtime.fwp");
    let cfile = scratch.0.join("runtime.c");
    std::fs::write(&input,"finish : I64 -> Array[F64]\nfinish = make { 0 = id, 1 = singleton | array.from-list, 2 = const [1.0] | array.from-list } | uncurry3 ad.backward\nmain = 1 | ad.tape | finish | echo\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .arg("build")
            .arg(&input)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let original = std::fs::read_to_string(cfile).unwrap();
    let call = "fwp_p_ad_backward(l0, l1, l2)";
    assert_eq!(original.matches(call).count(), 1);
    let call_start = original.find(call).unwrap();
    let backward_worker = format!(
        "f{}",
        original[..call_start]
            .rsplit("static V f")
            .next()
            .unwrap()
            .split('(')
            .next()
            .unwrap()
    );
    let probe = PROBE.replace("AD_BACKWARD", &backward_worker);
    let start = original
        .find("/* ------------------------------------------------------------------ tapes */")
        .unwrap();
    let end = original[start..]
        .find("/* ---------------------------------------------------------------- kernels */")
        .unwrap()
        + start;
    let declarations =
        "static void scope_probe_free(void *);\nstatic void *scope_probe_calloc(size_t,size_t);\n";
    let tape_code = original[start..end]
        .replace("free(", "scope_probe_free(")
        .replace("(double *)calloc(", "(double *)scope_probe_calloc(");
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
    let link = "    fwp_tape_link_scope(t, (int32_t)slot);";
    let unlink = "    fwp_tape_unlink_scope(t);\n    fwp_tape tp = *t;";
    assert_eq!(runtime.matches(link).count(), 1);
    assert_eq!(runtime.matches(unlink).count(), 1);
    let unlinked = runtime.replace(link, "");
    let unconsumed = runtime.replace(unlink, "    fwp_tape tp = *t;");
    let fresh = "fwp_rc_fresh(fwp_p_ad_backward(l0, l1, l2))";
    assert_eq!(runtime.matches(fresh).count(), 1);
    let uncounted = runtime.replace(fresh, call);
    for opt in ["-O1", "-O2"] {
        for (label, source, expected) in [
            ("scoped", &runtime, 0),
            ("unlinked", &unlinked, 61),
            ("unconsumed", &unconsumed, 62),
            ("uncounted", &uncounted, 76),
        ] {
            let executable = scratch.0.join(format!("{label}{}", &opt[1..]));
            let code = format!("{source}\n{probe}");
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            for reuse in ["0", "1"] {
                let output = Command::new(&executable)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", reuse)
                    .output()
                    .unwrap();
                if let Some(directory) = std::env::var_os("FWP_AD_SCOPE_ARTIFACTS") {
                    let directory = PathBuf::from(directory);
                    std::fs::create_dir_all(&directory).unwrap();
                    let prefix = directory.join(format!("{label}{}-reuse{reuse}", &opt[1..]));
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
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{label} {opt} reuse={reuse}: {}",
                    String::from_utf8_lossy(&output.stderr)
                );
                if expected == 0 {
                    assert!(String::from_utf8_lossy(&output.stdout)
                        .starts_with("scoped autodiff releases callback tapes; tape="));
                }
            }
        }
    }
}

#[test]
fn scoped_gradient_functions_agree_with_raw_interpreter() {
    let scratch = Scratch::new("semantics");
    let input = scratch.0.join("gradient.fwp");
    let original = std::fs::read_to_string(
        PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("tests/run/autodiff_reverse.fwp"),
    )
    .unwrap();
    let cases=[("gradients",original,false),
        ("callback-error","bad : List[Rev[F64]] -> Rev[F64]\nbad = const \"gradient callback control\" | prim.trap\nmain = [1.0, 2.0] | grad bad | echo\n".into(),true),
        ("vjp-error","bad : List[Rev[F64]] -> List[Rev[F64]]\nbad = const \"gradient callback control\" | prim.trap\nmain = [1.0, 2.0] | vjp bad [1.0] | echo\n".into(),true)];
    for (label, source, invalid) in cases {
        std::fs::write(&input, &source).unwrap();
        let reference = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        if let Some(directory) = std::env::var_os("FWP_AD_SCOPE_ARTIFACTS") {
            let directory = PathBuf::from(directory);
            std::fs::create_dir_all(&directory).unwrap();
            std::fs::write(directory.join(format!("{label}.fwp")), &source).unwrap();
            std::fs::write(
                directory.join(format!("{label}.raw.stdout")),
                &reference.stdout,
            )
            .unwrap();
            std::fs::write(
                directory.join(format!("{label}.raw.stderr")),
                &reference.stderr,
            )
            .unwrap();
            std::fs::write(
                directory.join(format!("{label}.raw.status")),
                format!("{}\n", reference.status),
            )
            .unwrap();
        }
        assert_eq!(
            reference.status.success(),
            !invalid,
            "{label}: {}",
            String::from_utf8_lossy(&reference.stderr)
        );
        if invalid {
            assert_eq!(reference.status.code(), Some(101));
            assert!(String::from_utf8_lossy(&reference.stderr)
                .lines()
                .any(|line| line == "fwp: trap: gradient callback control"));
        }
        for opt in ["-O1", "-O2"] {
            let executable = scratch.0.join(format!("{label}{}", &opt[1..]));
            let cfile = executable.with_extension("c");
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .arg("build")
                    .arg(&input)
                    .args(["--emit-c", "-o"])
                    .arg(&cfile),
            );
            let code = std::fs::read_to_string(cfile).unwrap();
            if let Some(directory) = std::env::var_os("FWP_AD_SCOPE_ARTIFACTS") {
                let directory = PathBuf::from(directory);
                std::fs::create_dir_all(&directory).unwrap();
                std::fs::write(directory.join(format!("{label}{}.c", &opt[1..])), &code).unwrap();
            }
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            for reuse in ["0", "1"] {
                let output = Command::new(&executable)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", reuse)
                    .output()
                    .unwrap();
                if let Some(directory) = std::env::var_os("FWP_AD_SCOPE_ARTIFACTS") {
                    let directory = PathBuf::from(directory);
                    std::fs::create_dir_all(&directory).unwrap();
                    let prefix = directory.join(format!("{label}{}-reuse{reuse}", &opt[1..]));
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
                assert_eq!(
                    output.status.success(),
                    reference.status.success(),
                    "{label} {opt}: {}",
                    String::from_utf8_lossy(&output.stderr)
                );
                assert_eq!(output.stdout, reference.stdout, "{label} {opt}");
                if invalid {
                    assert_eq!(output.status.code(), Some(101));
                    assert!(String::from_utf8_lossy(&output.stderr)
                        .lines()
                        .any(|line| line == "fwp: trap: gradient callback control"));
                }
            }
        }
    }
}

#[test]
fn borrowed_scope_inputs_reject_affine_files() {
    for source in [
        "bad : File -> File\nbad = ad.scope id\nmain = ()\n",
        "bad : File -> () -> File\nbad = ad.scope2 const\nmain = ()\n",
    ] {
        match fwp::driver::check_source("affine-scopes.fwp", source, None) {
            Ok(_) => panic!("borrowed scope duplicated an affine File"),
            Err(error) => assert!(
                error.rendered.contains("File") && error.rendered.contains("Dup"),
                "{}",
                error.rendered
            ),
        }
    }
}

#[test]
fn scoped_callbacks_return_independently_owned_input_aliases() {
    let scratch = Scratch::new("input-aliases");
    let input = scratch.0.join("input-aliases.fwp");
    std::fs::write(
        &input,
        r#"
main = read-all () | concat "runtime-owned scope input" | make {
    single = ad.scope id | both id string.length,
    pair = flip (ad.scope2 const) () | both id string.length,
} | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let raw = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for opt in ["-O1", "-O2"] {
        let executable = scratch.0.join(format!("aliases{opt}"));
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .args(["build"])
                .arg(&input)
                .args([opt, "-o"])
                .arg(&executable),
        );
        for reuse in ["0", "1"] {
            let output = checked(
                Command::new(&executable)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", reuse),
            );
            assert_eq!(output.stdout, raw.stdout, "{opt} reuse={reuse}");
            assert_eq!(output.stderr, raw.stderr);
        }
    }
}
