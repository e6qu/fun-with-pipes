//! Scoped State keeps typed owners through replacement, unwind and task switches.
use std::path::{Path, PathBuf};
use std::process::{Command, Output};
struct Scratch(PathBuf);
impl Scratch {
    fn new(label: &str) -> Self {
        let path = std::env::temp_dir().join(format!("fwp-typed-state-{}-{label}", std::process::id()));
        std::fs::create_dir(&path).unwrap(); Self(path)
    }
}
impl Drop for Scratch { fn drop(&mut self) { let _ = std::fs::remove_dir_all(&self.0); } }
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {}: {}", output.status, String::from_utf8_lossy(&output.stderr));
    output
}
fn retain(label: &str, code: &str, executable: &Path, output: &Output) {
    if let Some(directory) = std::env::var_os("FWP_TYPED_STATE_ARTIFACTS") {
        let directory = PathBuf::from(directory); std::fs::create_dir_all(&directory).unwrap();
        std::fs::write(directory.join(format!("{label}.c")), code).unwrap();
        std::fs::copy(executable, directory.join(format!("{label}.bin"))).unwrap();
        std::fs::write(directory.join(format!("{label}.stdout")), &output.stdout).unwrap();
        std::fs::write(directory.join(format!("{label}.stderr")), &output.stderr).unwrap();
        std::fs::write(directory.join(format!("{label}.status")), format!("{}\n", output.status)).unwrap();
    }
}
#[test]
fn state_owners_reclaim_aliases_and_unwind_on_actual_runtime_boundaries() {
    let scratch = Scratch::new("owners"); let input = scratch.0.join("owners.fwp");
    let cfile = scratch.0.join("owners.c");
    std::fs::write(&input, r#"
read-state : () -> String ! {State[String]}
read-state = get
main = [
    () | run-state ("owned" | concat " State") read-state | ignore,
    task.yield (),
    grpc.with-metadata [] (const ()),
] | ignore
"#).unwrap();
    checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env_remove("FWP_NO_OPT")
        .env("FWP_REUSE", "1").env("FWP_FREE", "1")
        .arg("build").arg(&input).args(["--emit-c", "-o"]).arg(&cfile));
    let original = std::fs::read_to_string(cfile).unwrap();
    assert!(original.contains("#define FWP_UNWIND 1"));
    let marker = "fwp_p_run_state_owned(l0, l1, l2, ";
    assert_eq!(original.matches(marker).count(), 1);
    let operations = original.split(marker).nth(1).unwrap().split(')').next().unwrap()
        .split(',').map(str::trim).collect::<Vec<_>>();
    assert_eq!(operations.len(), 3);
    assert_eq!(operations[0], "fwp_rc_dup");
    assert_eq!(operations[1], operations[2]);
    assert!(operations[1].starts_with("fwp_drop"));
    let probe = include_str!("fixtures/typed_state_probe.c").replace("DROP_STRING", operations[1]);
    let start = original.find("static V fwp_p_run_state_owned(").unwrap();
    let end = original[start..].find("static V fwp_p_put(V s)").unwrap() + start;
    let owned = original[start..end].replace("fwp_tuple2(result, state)", "typed_tuple(result, state)");
    assert_ne!(owned.as_str(), &original[start..end]);
    let runtime = format!("{}static V typed_tuple(V,V);\n{}{}", &original[..start], owned, &original[end..])
        .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
    let controls = [
        ("state-retain-omitted", "    if (duplicate) duplicate(initial);", "", 120),
        ("getter-retain-omitted", "static V fwp_p_get_owned(void (*duplicate)(V)) {\n    V value = fwp_p_get();\n    if (duplicate) duplicate(value);", "static V fwp_p_get_owned(void (*duplicate)(V)) {\n    V value = fwp_p_get();", 120),
        ("put-retain-omitted", "        if (owner->duplicate) owner->duplicate(value);", "", 127),
        ("state-unwind-omitted", "fwp_cleanup_push(&state_cleanup, fwp_state_owner_release, &owner);", "fwp_cleanup_push(&state_cleanup, typed_no_release, &owner);", 125),
        ("pair-owner-omitted", "V pair = fwp_rc_fresh(typed_tuple(result, state));", "V pair = typed_tuple(result, state);", 126),
        ("task-owner-save-omitted", "    from->state_owners = fwp_state_owners;", "", 128),
    ];
    let runtime = format!("static void typed_no_release(void *p) {{ (void)p; }}\n{runtime}");
    let mut variants = vec![("typed-state", runtime.clone(), 0)];
    for (label, old, new, expected) in controls {
        assert_eq!(runtime.matches(old).count(), 1, "{label}");
        variants.push((label, runtime.replace(old, new), expected));
    }
    for opt in ["-O1", "-O2"] {
        for (label, source, expected) in &variants {
            let code = format!("{source}\n{probe}");
            let executable = scratch.0.join(format!("{label}{opt}"));
            if let Some(directory) = std::env::var_os("FWP_TYPED_STATE_ARTIFACTS") {
                let directory = PathBuf::from(directory); std::fs::create_dir_all(&directory).unwrap();
                std::fs::write(directory.join(format!("{label}{opt}.c")), &code).unwrap();
            }
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            for reuse in ["0", "1"] {
                let output = Command::new(&executable).env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1").env("FWP_REUSE_VERIFY", reuse).output().unwrap();
                retain(&format!("{label}{opt}-reuse{reuse}"), &code, &executable, &output);
                assert_eq!(output.status.code(), Some(*expected), "{label}{opt} reuse={reuse}: {}", String::from_utf8_lossy(&output.stderr));
            }
        }
    }
}

#[test]
fn typed_state_changes_preserve_pipe_semantics_and_suspended_tasks() {
    let scratch = Scratch::new("semantics"); let input = scratch.0.join("semantics.fwp");
    let source = r#"
read-change : () -> String ! {State[String]}
read-change = both (const () | get) (const (concat "!") | modify) | .0
fail-change : () -> String ! {State[String], Error[String]}
fail-change = const "changed" | put | const "expected error" | fail
child : () -> String ! {Async}
child = run-state ("child" | concat " State") (tap (const () | task.yield) | get) | .0
parent : () -> String ! {State[String], Async, IO}
parent = const child | task.spawn | tap (const () | task.yield) | task.await | tap echo | const () | get
cancelled-child : () -> String ! {Async}
cancelled-child = run-state ("cancelled" | concat " State") (tap (const 1s | task.sleep) | get) | .0
change-closure : () -> String ! {State[(String -> String)]}
change-closure = const ("captured" | concat ":") | concat | put | get | apply "!"
change-runtime-closure : () -> String ! {State[(String -> String)]}
change-runtime-closure = get | apply ":" | concat | put | get | apply "!"
main = [
    () | run-state ("initial" | concat " State") read-change | echo,
    () | run-state "outer" (both (run-state "inner" get) get) | echo,
    () | run-state "outer" (attempt fail-change) | echo,
    () | run-state "outer" (attempt (run-state "inner" fail-change)) | echo,
    () | run-state ("parent" | concat " State") parent | echo,
    task.spawn cancelled-child | tap (const () | task.yield) | tap task.cancel | task.await | echo,
    () | run-state ("after" | concat " cancellation") get | echo,
    [1, 2, 3] | run-state 0 (map (const (add 1) | modify)) | echo,
    () | run-state (["a", "b"] | array.from-list) (both get (const (array.map (concat "!")) | modify) | .0) | echo,
    () | run-state ("left", ["right"]) get | echo,
    () | run-state (concat "initial:") change-closure | .0 | echo,
    () | run-state (concat "initial:") change-closure | .1 | apply "!" | echo,
    () | run-state (concat "runtime:") change-runtime-closure | .0 | echo,
    () | run-state (concat "runtime:") change-runtime-closure | .1 | apply "!" | echo,
] | ignore
"#;
    std::fs::write(&input, source).unwrap();
    let reference = checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env("FWP_NO_OPT", "1")
        .args(["run", "--interp"]).arg(&input));
    for opt in ["-O1", "-O2"] {
        for stack in ["0", "1"] {
            let executable = scratch.0.join(format!("semantics{opt}-stack{stack}"));
            checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env_remove("FWP_NO_OPT")
                .env("FWP_STACK", stack).env("FWP_REUSE", "1").env("FWP_FREE", "1")
                .arg("build").arg(&input).args([opt, "-o"]).arg(&executable));
            for reuse in ["0", "1"] {
                let output = checked(Command::new(&executable).env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1").env("FWP_REUSE_VERIFY", reuse));
                assert_eq!(output.stdout, reference.stdout, "{opt} stack={stack} reuse={reuse}");
                retain(&format!("semantics{opt}-stack{stack}-reuse{reuse}"), source, &executable, &output);
            }
        }
    }
}
