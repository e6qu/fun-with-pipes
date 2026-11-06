//! Gradients own active tape buffers across callback return and nonlocal exits.
use fwp::ir::{Body, Expr, Func, Program, MT};
use fwp::value::Value;
use std::path::PathBuf;
#[path = "support/c_instrument.rs"]
mod c_instrument;
use std::process::{Command, Output};

#[path = "support/exported_probe.rs"]
mod exported_probe;

#[path = "support/record_probe.rs"]
mod record_probe;
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
    std::fs::write(&input,"finish : I64 -> Array[F64]\nfinish = make { 0 = id, 1 = singleton | array.from-list, 2 = const [1.0] | array.from-list } | uncurry3 ad.backward\nmain = 1 | ad.scope (ad.tape | finish) | echo\n").unwrap();

    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "0")
            .args(["build", "--memory", "dynamic", "-O2"])
            .arg(&input)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let original = std::fs::read_to_string(&cfile).unwrap();
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
    let release = "    fwp_rc_free_arr(owned);";
    assert_eq!(probe.matches(release).count(), 1);
    let unreleased_probe = probe.replace(release, "");
    let start = original
        .find("/* ------------------------------------------------------------------ tapes */")
        .unwrap();
    let end = original[start..]
        .find("/* ---------------------------------------------------------------- kernels */")
        .unwrap()
        + start;
    let declarations =
        "static void scope_probe_free(void *);\nstatic void *scope_probe_calloc(size_t,size_t);\n";
    let tape_code = c_instrument::calls(&original[start..end], &[("free", "scope_probe_free")])
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
    let unlink = "    if (t->owned) fwp_trap(FWP_AD_REPRESENTATION);\n    fwp_tape_unlink_scope(t);\n    fwp_tape tp = *t;";
    assert_eq!(runtime.matches(link).count(), 1);
    assert_eq!(runtime.matches(unlink).count(), 1);
    let unlinked = runtime.replace(link, "");
    let unconsumed = runtime.replace(
        unlink,
        "    if (t->owned) fwp_trap(FWP_AD_REPRESENTATION);\n    fwp_tape tp = *t;",
    );
    let fresh = "fwp_rc_fresh(fwp_p_ad_backward(l0, l1, l2))";
    assert_eq!(runtime.matches(fresh).count(), 1);
    let uncounted = runtime.replace(fresh, call);
    let mut cases = vec![
        ("scoped", runtime.clone(), probe.clone(), 0),
        ("unlinked", unlinked, probe.clone(), 61),
        ("unconsumed", unconsumed, probe.clone(), 62),
        ("uncounted", uncounted, probe.clone(), 76),
        ("unreleased", runtime.clone(), unreleased_probe, 77),
    ];

    for (label, old, new) in [
                (
                    "input-release-omitted",
                    "fwp_rc_free_arr(scope_seeds);",
                    "/* omitted input release */",
                ),
                (
                    "result-release-omitted",
                    "fwp_rc_free_arr(fwp_rc_fresh(fwp_p_ad_backward(scope_base,scope_outputs,scope_seeds)));",
                    "fwp_rc_fresh(fwp_p_ad_backward(scope_base,scope_outputs,scope_seeds));",
                ),
            ] {
                assert_eq!(probe.matches(old).count(), 1);
                cases.push((label, runtime.clone(), probe.replace(old, new), 90));
            }

    for opt in ["-O1", "-O2"] {
        for (label, source, observation, expected) in &cases {
            let executable = scratch.0.join(format!("counted{opt}-{label}.exe"));
            let code = format!("{source}\n{observation}");
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();

            let output = Command::new(&executable)
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap();
            let label = format!("counted{opt}-{label}");
            if let Some(directory) = std::env::var_os("FWP_AD_SCOPE_ARTIFACTS") {
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
            record_probe::save("ad_tape_scopes", &label, &code, &executable, &output);
            assert_eq!(output.status.code(), Some(*expected), "{label}: {output:?}");
            assert!(output.stderr.is_empty(), "{label}: {output:?}");
            if *expected == 0 {
                assert!(String::from_utf8_lossy(&output.stdout)
                    .starts_with("scoped autodiff releases callback tapes; tape="));
            } else {
                assert!(output.stdout.is_empty(), "{label}: {output:?}");
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
        if let Some(directory) = std::env::var_os("FWP_ARC_ARTIFACTS") {
            let directory = PathBuf::from(directory).join("record-ownership/ad_tape_scopes");
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

        for opt in ["-O1", "-O2"] {
            let executable = scratch.0.join(format!("counted{opt}-{label}.exe"));
            let cfile = executable.with_extension("c");
            for emit in [true, false] {
                let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
                command
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", "0")
                    .args(["build", "--memory", "dynamic", opt])
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

            let output = Command::new(&executable)
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap();
            let label = format!("counted{opt}-semantics-{label}");
            if let Some(directory) = std::env::var_os("FWP_AD_SCOPE_ARTIFACTS") {
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
            record_probe::save("ad_tape_scopes", &label, &code, &executable, &output);
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
    let label = "aliases";
    let reference = raw;
    if let Some(directory) = std::env::var_os("FWP_ARC_ARTIFACTS") {
        let directory = PathBuf::from(directory).join("record-ownership/ad_tape_scopes");
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

    for opt in ["-O1", "-O2"] {
        let executable = scratch.0.join(format!("counted{opt}-{label}.exe"));
        let cfile = executable.with_extension("c");
        for emit in [true, false] {
            let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
            command
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", "0")
                .args(["build", "--memory", "dynamic", opt])
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

        let output = Command::new(&executable)
            .env("FWP_AD_WORKSPACE", "0")
            .output()
            .unwrap();
        let label = format!("counted{opt}-semantics-{label}");
        if let Some(directory) = std::env::var_os("FWP_AD_SCOPE_ARTIFACTS") {
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
        record_probe::save("ad_tape_scopes", &label, &code, &executable, &output);
        assert_eq!(
            output.status.code(),
            reference.status.code(),
            "{label}: {output:?}"
        );
        assert_eq!(output.stdout, reference.stdout, "{label}");
        assert_eq!(output.stderr, reference.stderr, "{label}");
    }
}

#[path = "support/gradient_call_storage.rs"]
mod gradient_call_storage;

#[test]
fn proved_recording_workers_reuse_only_live_tape_lookups() {
    let scratch = Scratch::new("recording-lookups");
    let i = MT::con("std::I64");
    let f = MT::con("std::F64");
    let parameters = vec![i.clone(), f.clone(), i.clone(), f.clone()];
    let ty = parameters
        .iter()
        .rev()
        .fold(i.clone(), |result, parameter| {
            MT::Fun(Box::new(parameter.clone()), Box::new(result))
        });
    let push = Func {
        name: "push".into(),
        arity: 4,
        ty: ty.clone(),
        locals: parameters.clone(),
        body: Body::Prim("ad.push".into()),
    };
    let helper = Func {
        name: "record-one".into(),
        body: Body::Expr(Expr::Call(0, (0..4).map(Expr::Local).collect())),
        ..push.clone()
    };
    let mut locals = parameters;
    locals.push(i.clone());
    let worker = Func {
        name: "record-two".into(),
        arity: 4,
        ty,
        locals,
        body: Body::Expr(Expr::Let(
            4,
            Box::new(Expr::Call(0, (0..4).map(Expr::Local).collect())),
            Box::new(Expr::Call(
                5,
                vec![
                    Expr::Local(4),
                    Expr::Local(1),
                    Expr::Local(2),
                    Expr::Local(3),
                ],
            )),
        )),
    };
    // Admission must see a real scope even though the C probe replaces main.
    let callback_ty = MT::Fun(Box::new(i.clone()), Box::new(i.clone()));
    let scope = Func {
        name: "scope".into(),
        arity: 2,
        ty: MT::Fun(Box::new(callback_ty.clone()), Box::new(callback_ty.clone())),
        locals: vec![callback_ty.clone(), i.clone()],
        body: Body::Prim("ad.scope".into()),
    };
    let callback = Func {
        name: "scoped-recording".into(),
        arity: 1,
        ty: callback_ty,
        locals: vec![i.clone()],
        body: Body::Expr(Expr::Call(
            1,
            vec![
                Expr::Local(0),
                Expr::Const(Value::F64(0.5)),
                Expr::Local(0),
                Expr::Const(Value::F64(0.5)),
            ],
        )),
    };
    let main = Func {
        name: "main".into(),
        arity: 0,
        ty: i,
        locals: vec![],
        body: Body::Expr(Expr::Call(
            2,
            vec![Expr::Func(3), Expr::Const(Value::I64(-1))],
        )),
    };
    let program = Program {
        funcs: vec![push, worker, scope, callback, main, helper],
        main: Some(4),
        ..Program::default()
    };
    let mut unscoped = program.clone();
    unscoped.funcs[4].body = Body::Expr(Expr::Call(3, vec![Expr::Const(Value::I64(-1))]));
    assert!(fwp::cgen::generate(&unscoped)
        .unwrap_err()
        .contains("outside an autodiff scope"));
    let original = fwp::cgen::generate(&program).unwrap();
    assert!(!original.contains("fwp_ad_recording recording = {-1, NULL};"));
    assert!(original.contains(", recording)"));
    assert!(original.contains(", &(fwp_ad_recording){-1, NULL})"));
    let lookup = "static fwp_tape *fwp_tape_of(int64_t id) {";
    let append = "    t->len = idx + 1;\n";
    assert_eq!(original.matches(lookup).count(), 1);
    assert_eq!(original.matches(append).count(), 1);
    let runtime = original.replace(lookup, &format!(
        "static unsigned recording_lookup_calls;\nstatic int recording_fail_after_append;\n{lookup}\n    recording_lookup_calls++;"))
        .replace(append, &format!("{append}    if (recording_fail_after_append) fwp_trap(\"recording append control\");\n"))
        .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
    let parent = "    if ((ra & 0xffffffff) >= idx || (rb >= 0 && (rb & 0xffffffff) >= idx))\n        fwp_trap(FWP_AD_INVALID_NODE);\n";
    let full = "    if (idx >= fwp_tape_limit()) fwp_trap(\"autodiff: the tape is full\");\n";
    let start = runtime
        .find("static inline __attribute__((always_inline)) V fwp_p_ad_push(")
        .unwrap();
    let end = start + runtime[start..].find("/* the adjoints").unwrap();
    let push = &runtime[start..end];
    assert_eq!(push.matches(parent).count(), 1);
    assert_eq!(push.matches(&format!("{full}{parent}")).count(), 1);
    let no_parent = format!(
        "{}{}{}",
        &runtime[..start],
        push.replace(parent, ""),
        &runtime[end..]
    );
    let wrong_order = format!(
        "{}{}{}",
        &runtime[..start],
        push.replace(&format!("{full}{parent}"), &format!("{parent}{full}")),
        &runtime[end..]
    );
    let non_inlined = runtime.replace(
        "static inline __attribute__((always_inline)) V fwp_p_ad_push(",
        "static V fwp_p_ad_push(",
    );
    let ordinary = runtime.replace(", recording)", ", NULL)");
    let child_call = runtime
        .lines()
        .find(|line| line.contains("w5(") && line.contains(", recording)"))
        .expect("direct nested recording call");
    let no_forward = runtime.replace(
        child_call,
        &child_call.replace(", recording)", ", &(fwp_ad_recording){-1, NULL})"),
    );
    for (label, source, lookups, expected) in [
        ("proved", runtime, 1, 0),
        ("non-inlined", non_inlined, 1, 0),
        ("ordinary", ordinary.clone(), 2, 0),
        ("broken-lookup-observer", ordinary, 1, 61),
        ("broken-context-forwarding", no_forward, 1, 61),
        ("broken-parent-validation", no_parent, 1, 62),
        ("broken-validation-order", wrong_order, 1, 63),
    ] {
        let code = format!(
            "{source}\n#define EXPECTED_LOOKUPS {lookups}\n{}",
            include_str!("fixtures/ad_recording_lookup_probe.c")
        );
        for opt in ["-O0", "-O1", "-O2"] {
            if opt == "-O0" && label != "proved" && label != "non-inlined" {
                continue;
            }
            let executable = scratch.0.join(format!("{label}{opt}.exe"));
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            for reuse in ["0", "1"] {
                let output = Command::new(&executable)
                    .env("FWP_AD_WORKSPACE", reuse)
                    .output()
                    .unwrap();
                let label = format!("recording-{label}{opt}-reuse{reuse}");
                record_probe::save("ad_tape_scopes", &label, &code, &executable, &output);
                assert_eq!(output.status.code(), Some(expected), "{label}: {output:?}");
                assert!(output.stdout.is_empty(), "{label}: {output:?}");
                assert!(output.stderr.is_empty(), "{label}: {output:?}");
            }
        }
    }
}

#[path = "support/recording_context.rs"]
mod recording_context;
