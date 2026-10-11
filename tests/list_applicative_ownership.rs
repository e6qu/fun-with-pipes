//! Applicative and flat-map callbacks retain typed ownership and release on unwind.
use std::path::PathBuf;
use std::process::{Command, Output};
struct Scratch(PathBuf);
impl Scratch {
    fn new(label: &str) -> Self {
        let path=std::env::temp_dir().join(format!("fwp-list-ap-{}-{label}",std::process::id()));
        std::fs::create_dir(&path).unwrap();Self(path)
    }
}
impl Drop for Scratch { fn drop(&mut self) { let _=std::fs::remove_dir_all(&self.0); } }
fn checked(command: &mut Command) -> Output {
    let output=command.output().unwrap();
    assert!(output.status.success(),"{command:?}: {}: {}",output.status,String::from_utf8_lossy(&output.stderr));output
}
fn retain(label: &str, source: &str, executable: &std::path::Path, output: &Output) {
    if let Some(directory)=std::env::var_os("FWP_LIST_AP_ARTIFACTS") {
        let directory=PathBuf::from(directory);std::fs::create_dir_all(&directory).unwrap();
        let prefix=directory.join(label);
        std::fs::copy(executable,prefix.with_extension("bin")).unwrap();
        std::fs::write(prefix.with_extension("c"),source).unwrap();
        std::fs::write(prefix.with_extension("stdout"),&output.stdout).unwrap();
        std::fs::write(prefix.with_extension("stderr"),&output.stderr).unwrap();
        std::fs::write(prefix.with_extension("status"),format!("{}\n",output.status)).unwrap();
    }
}
#[test]
fn cartesian_results_and_scratch_release_on_trap_and_cancel() {
    let scratch=Scratch::new("unwind");let input=scratch.0.join("ap.fwp");let cfile=scratch.0.join("ap.c");
    std::fs::write(&input,"main = () | task.yield | const [1, 2] | list.ap [show, show] | echo\n").unwrap();
    checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env_remove("FWP_NO_OPT")
        .arg("build").arg(&input).args(["--emit-c","-o"]).arg(&cfile));
    let original=std::fs::read_to_string(&cfile).unwrap();
    assert!(original.contains("#define FWP_UNWIND 1"),"The native cleanup probe must use real unwind lowering");
    let marker="fwp_p_list_ap_owned(l0, l1, ";assert_eq!(original.matches(marker).count(),1);
    let ops=original.split(marker).nth(1).unwrap().split(')').next().unwrap().split(',').map(str::trim).collect::<Vec<_>>();
    assert_eq!(ops.len(),2);assert!(ops.iter().all(|op|op.starts_with("fwp_drop")));
    let probe=include_str!("fixtures/list_ap_probe.c").replace("DROP_STRING",ops[0]).replace("DROP_LIST",ops[1]);
    let start=original.find("static void fwp_map_release(").unwrap();let end=original.find("static V fwp_p_map_owned(").unwrap();
    let ownership=original[start..end].replace("fwp_mem_free(","list_ap_probe_free(").replace("fwp_data(1, 2, fields)","list_ap_probe_data(1, 2, fields)");
    let original=format!("{}{}{}",&original[..start],ownership,&original[end..]);
    let start=original.find("static V fwp_p_flat_map_owned(").unwrap();let end=original[start..].find("/* ---------------------------------------------------------------- strings */").unwrap()+start;
    let helper=original[start..end].replace("fwp_map_items(","list_ap_probe_items(").replace("fwp_mem_alloc(","list_ap_probe_alloc(");
    let runtime=format!("{}{}{}",&original[..start],helper,&original[end..])
        .replace("static V *fwp_map_items(","static void list_ap_probe_free(void *);\nstatic void *list_ap_probe_alloc(size_t);\nstatic V *list_ap_probe_items(V,size_t *);\nstatic V list_ap_probe_data(uint32_t,uint32_t,const V *);\nstatic V *fwp_map_items(")
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let unprotected_helper=helper.replace("    fwp_map_protect(&owner, &cleanup);","");assert_ne!(unprotected_helper,helper);
    let unprotected=runtime.replace(&helper,&unprotected_helper);
    let uncounted=runtime.replace("V node = fwp_rc_fresh(list_ap_probe_data(1, 2, fields));","V node = list_ap_probe_data(1, 2, fields);");assert_ne!(uncounted,runtime);
    let unchecked=runtime.replace("    if (nf && nx > maximum / nf) fwp_trap(\"list.ap too large\");", "    (void)maximum;");assert_ne!(unchecked,runtime);
    let flat_unprotected_helper=helper.replace("    fwp_map_protect(&chunks, &chunks_cleanup);", "");assert_ne!(flat_unprotected_helper,helper);
    let flat_unprotected=runtime.replace(&helper,&flat_unprotected_helper);
    let flat_unduplicated_helper=helper.replace("            if (element_dup) element_dup(aliases[j]);", "            (void)element_dup;");assert_ne!(flat_unduplicated_helper,helper);
    let flat_unduplicated=runtime.replace(&helper,&flat_unduplicated_helper);
    for opt in ["-O1","-O2"] {
        for (label,source,first,flat_first,expected) in [("owned",&runtime,0,0,0),("unprotected",&unprotected,1,0,81),("uncounted",&uncounted,0,0,86),("unchecked",&unchecked,0,0,88),("flat-unprotected",&flat_unprotected,0,1,99),("flat-unduplicated",&flat_unduplicated,0,0,100)] {
            let executable=scratch.0.join(format!("{label}{}",&opt[1..]));
            let code=format!("{source}\n#define PROBE_FIRST_MODE {first}\n#define FLAT_FIRST_MODE {flat_first}\n{probe}");
            if let Some(directory)=std::env::var_os("FWP_LIST_AP_ARTIFACTS") {
                let directory=PathBuf::from(directory);std::fs::create_dir_all(&directory).unwrap();
                std::fs::write(directory.join(format!("{label}{}.c",&opt[1..])),&code).unwrap();
            }
            fwp::cgen::compile_c(&code,&executable,opt).unwrap();
            for reuse in ["0","1"] {
                let output=Command::new(&executable).env("FWP_GC_STRESS","1").env("FWP_GC_VERIFY","1").env("FWP_REUSE_VERIFY",reuse).output().unwrap();
                retain(&format!("{label}{}-reuse{reuse}",&opt[1..]),&code,&executable,&output);
                assert_eq!(output.status.code(),Some(expected),"{label} {opt} reuse={reuse}: {}",String::from_utf8_lossy(&output.stderr));
                if expected==0 { assert!(String::from_utf8_lossy(&output.stdout).starts_with("list.ap and flat-map callback and spine ownership; real collections=")); }
            }
        }
    }
}
#[test]
fn typed_applicative_aliases_and_evaluation_order_match_raw_interpreter() {
    let scratch=Scratch::new("semantics");let input=scratch.0.join("semantics.fwp");
    let positive=r#"
empty-functions : List[String -> String]
empty-functions = []
empty-chunk : String -> List[String]
empty-chunk = const []
use-functions : List[String -> String] -> (List[String], List[String])
use-functions = make { 0 = flip list.ap ["!", "?"], 1 = map (apply ":") }
main = [
    ["left:", "right:"] | map concat | use-functions | echo,
    "a b" | words | both (list.ap [id, concat "fresh:"]) id | echo,
    [1, 2, 3] | list.ap [add 1, mul 2] | echo,
    "a b" | words | both (list.flat-map (repeat 2)) id | echo,
    "a b" | words | list.flat-map (concat "fresh:" | repeat 2) | echo,
    ["a:", "b:"] | map concat | list.flat-map (repeat 2) | map (apply "!") | echo,
    [1, 2, 3] | list.flat-map (repeat 2) | echo,
    ["a", "b"] | list.flat-map empty-chunk | echo,
    ["a", "b"] | list.ap empty-functions | echo,
    [] | list.ap [concat "unused:"] | echo,
    [] | list.flat-map (concat "unused:" | repeat 2) | echo,
] | ignore
"#;
    let flat_negative="fail : I64 -> List[I64]\nfail = if (eq 2) (const \"list.ap order control\" | prim.trap) (add 10 | repeat 2)\nmain = [1, 2, 3] | list.flat-map fail | echo\n";
    let negative="fail : I64 -> I64\nfail = if (eq 2) (const \"list.ap order control\" | prim.trap) (add 10)\nmain = [1, 2, 3] | list.ap [fail, mul 2] | echo\n";
    for (label,source,invalid) in [("aliases",positive,false),("trap-order",negative,true),("flat-trap-order",flat_negative,true)] {
        std::fs::write(&input,source).unwrap();
        let reference=Command::new(env!("CARGO_BIN_EXE_fwp")).env("FWP_NO_OPT","1").args(["run","--interp"]).arg(&input).output().unwrap();
        assert_eq!(reference.status.success(),!invalid,"{label}: {}",String::from_utf8_lossy(&reference.stderr));
        if invalid {
            assert_eq!(reference.status.code(),Some(101));
            assert!(String::from_utf8_lossy(&reference.stderr).lines().any(|line|line=="fwp: trap: list.ap order control"));
        }
        if let Some(directory)=std::env::var_os("FWP_LIST_AP_ARTIFACTS") {
            let directory=PathBuf::from(directory);std::fs::create_dir_all(&directory).unwrap();
            std::fs::write(directory.join(format!("{label}.fwp")),source).unwrap();
            std::fs::write(directory.join(format!("{label}.raw.stdout")),&reference.stdout).unwrap();
            std::fs::write(directory.join(format!("{label}.raw.stderr")),&reference.stderr).unwrap();
            std::fs::write(directory.join(format!("{label}.raw.status")),format!("{}\n",reference.status)).unwrap();
        }
        for opt in ["-O1","-O2"] {
            let executable=scratch.0.join(format!("{label}{}",&opt[1..]));
            let cfile=executable.with_extension("c");
            checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env_remove("FWP_NO_OPT").arg("build").arg(&input).args(["--emit-c","-o"]).arg(&cfile));
            let code=std::fs::read_to_string(cfile).unwrap();
            if let Some(directory)=std::env::var_os("FWP_LIST_AP_ARTIFACTS") {
                let directory=PathBuf::from(directory);std::fs::create_dir_all(&directory).unwrap();
                std::fs::write(directory.join(format!("{label}{}.c",&opt[1..])),&code).unwrap();
            }
            fwp::cgen::compile_c(&code,&executable,opt).unwrap();
            for reuse in ["0","1"] {
                let output=Command::new(&executable).env("FWP_GC_STRESS","1").env("FWP_GC_VERIFY","1").env("FWP_REUSE_VERIFY",reuse).output().unwrap();
                retain(&format!("{label}{}-reuse{reuse}",&opt[1..]),&code,&executable,&output);
                assert_eq!(output.status.success(),reference.status.success(),"{label} {opt}: {}",String::from_utf8_lossy(&output.stderr));
                assert_eq!(output.stdout,reference.stdout,"{label} {opt}");
                if invalid {
                    assert_eq!(output.status.code(),Some(101));
                    assert!(String::from_utf8_lossy(&output.stderr).lines().any(|line|line=="fwp: trap: list.ap order control"));
                }
            }
        }
    }
}

#[test]
fn closure_drop_context_recovers_after_capture_trap_and_spill_oom() {
    let scratch=Scratch::new("closure-drop");
    let input=scratch.0.join("closure.fwp");let cfile=scratch.0.join("closure.c");
    std::fs::write(&input,"main = () | task.yield | const \"closure cleanup\" | echo\n").unwrap();
    checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env_remove("FWP_NO_OPT")
        .arg("build").arg(&input).args(["--emit-c","-o"]).arg(&cfile));
    let original=std::fs::read_to_string(cfile).unwrap();
    let start=original.find("static void fwp_closure_drop_push(").unwrap();
    let end=original[start..].find("#ifndef FWP_UNWIND").unwrap()+start;
    let region=original[start..end].replace("malloc(","closure_probe_alloc(").replace("free(","closure_probe_free(");
    let declarations="static void *closure_probe_alloc(size_t);\nstatic void closure_probe_free(void *);\nstatic void closure_probe_noop(void *);\n";
    let runtime=format!("{}{}{}{}",&original[..start],declarations,region,&original[end..])
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let registration="fwp_cleanup_push(&cleanup, fwp_closure_drop_release, &work);";
    assert_eq!(runtime.matches(registration).count(),1);
    let uncontrolled=runtime.replace(registration,"fwp_cleanup_push(&cleanup, closure_probe_noop, &work);");
    for opt in ["-O1","-O2"] {
        for (label,source,expected) in [("closure-protected",&runtime,0),("closure-unprotected",&uncontrolled,94)] {
            let code=format!("{source}\n{}",include_str!("fixtures/closure_drop_probe.c"));
            let executable=scratch.0.join(format!("{label}{}",&opt[1..]));
            if let Some(directory)=std::env::var_os("FWP_LIST_AP_ARTIFACTS") {
                let directory=PathBuf::from(directory);std::fs::create_dir_all(&directory).unwrap();
                std::fs::write(directory.join(format!("{label}{}.c",&opt[1..])),&code).unwrap();
            }
            fwp::cgen::compile_c(&code,&executable,opt).unwrap();
            for reuse in ["0","1"] {
                let output=Command::new(&executable).env("FWP_GC_STRESS","1").env("FWP_GC_VERIFY","1")
                    .env("FWP_REUSE_VERIFY",reuse).output().unwrap();
                retain(&format!("{label}{}-reuse{reuse}",&opt[1..]),&code,&executable,&output);
                assert_eq!(output.status.code(),Some(expected),"{label} {opt} reuse={reuse}: {}",String::from_utf8_lossy(&output.stderr));
                if expected==0 { assert!(String::from_utf8_lossy(&output.stdout).starts_with("Closure cleanup context resets after capture trap and spill OOM; real collections=")); }
            }
        }
    }
}

#[test]
fn inactive_state_slots_are_cleared_at_real_collection_and_handler_boundaries() {
    let scratch=Scratch::new("state-slots");
    let input=scratch.0.join("state.fwp");let cfile=scratch.0.join("state.c");
    // Keep both task and gRPC runtime handlers in the emitted translation unit.
    std::fs::write(&input,"main = [task.yield (), grpc.with-metadata [] (const ())] | ignore\n").unwrap();
    checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env_remove("FWP_NO_OPT")
        .arg("build").arg(&input).args(["--emit-c","-o"]).arg(&cfile));
    let original=std::fs::read_to_string(cfile).unwrap();
    assert!(original.contains("#define FWP_UNWIND 1"));
    assert!(original.contains("static int g_apply_user("));
    let scan="    uintptr_t a = ((uintptr_t)lo + 7) & ~(uintptr_t)7;";
    let declaration="__attribute__((no_sanitize_address)) static void fwp_gc_scan(";
    assert_eq!(original.matches(scan).count(),1);
    assert_eq!(original.matches(declaration).count(),1);
    let runtime=original.replace(declaration,&format!("static void state_probe_scan(const char *,const char *,int);\n{declaration}"))
        .replace(scan,&format!("    state_probe_scan(lo,hi,root);\n{scan}"))
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let task_exit="    t->unwinding = 1;\n    fwp_handlers = 0;\n    fwp_state_restore(0);\n    fwp_join_children();";
    assert_eq!(runtime.matches(task_exit).count(),1);
    let runtime=runtime.replace("static void fwp_task_main(void) {","static int state_empty_from(size_t);\nstatic void state_probe_task_exit(void);\nstatic void fwp_task_main(void) {")
        .replace(task_exit,"    t->unwinding = 1;\n    fwp_handlers = 0;\n    fwp_state_restore(0);\n    state_probe_task_exit();\n    fwp_join_children();");
    let pop="    fwp_state[fwp_state_len - 1] = 0;";
    let restore="    while (fwp_state_len > depth) fwp_state[--fwp_state_len] = 0;";
    assert_eq!(runtime.matches(pop).count(),1);assert_eq!(runtime.matches(restore).count(),1);
    let pop_control=runtime.replace(pop,"");let restore_control=runtime.replace(restore,"");
    let task_control=runtime.replace("    fwp_state_restore(0);\n    state_probe_task_exit();","    state_probe_task_exit();");
    assert_ne!(task_control,runtime);
    for opt in ["-O1","-O2"] {
        for (label,source,expected) in [("state-cleared",&runtime,0),("state-pop-retained",&pop_control,104),("state-restore-retained",&restore_control,105),("state-task-retained",&task_control,112)] {
            let code=format!("{source}\n{}",include_str!("fixtures/state_slot_probe.c"));
            let executable=scratch.0.join(format!("{label}{}",&opt[1..]));
            if let Some(directory)=std::env::var_os("FWP_LIST_AP_ARTIFACTS") {
                let directory=PathBuf::from(directory);std::fs::create_dir_all(&directory).unwrap();
                std::fs::write(directory.join(format!("{label}{}.c",&opt[1..])),&code).unwrap();
            }
            fwp::cgen::compile_c(&code,&executable,opt).unwrap();
            for reuse in ["0","1"] {
                let output=Command::new(&executable).env("FWP_GC_STRESS","1").env("FWP_GC_VERIFY","1")
                    .env("FWP_REUSE_VERIFY",reuse).output().unwrap();
                retain(&format!("{label}{}-reuse{reuse}",&opt[1..]),&code,&executable,&output);
                assert_eq!(output.status.code(),Some(expected),"{label} {opt} reuse={reuse}: {}",String::from_utf8_lossy(&output.stderr));
                if expected==0 { assert!(String::from_utf8_lossy(&output.stdout).starts_with("State inactive slots cleared; real collections=")); }
            }
        }
    }
}

#[test]
fn state_aliases_nested_errors_and_task_cancellation_match_raw_interpreter() {
    let scratch=Scratch::new("state-semantics");let input=scratch.0.join("state-semantics.fwp");
    let source=r#"
read-and-change : () -> String ! {State[String]}
read-and-change = both (const () | get) (const "replacement" | put) | .0
fail-change : () -> String ! {State[String], Error[String]}
fail-change = const "changed" | put | const "expected error" | fail
child : () -> String ! {Async}
child = run-state "child" (tap (const 1s | task.sleep) | get) | .0
main = [
    () | run-state "original" read-and-change | echo,
    () | run-state "outer" (both (run-state "inner" get) get) | echo,
    () | run-state "outer" (attempt fail-change) | echo,
    () | run-state "outer" (attempt (run-state "inner" fail-change)) | echo,
    child | task.spawn | tap (const () | task.yield) | tap task.cancel | task.await | echo,
    () | run-state "parent after child" get | echo,
] | ignore
"#;
    std::fs::write(&input,source).unwrap();
    let reference=checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env("FWP_NO_OPT","1")
        .args(["run","--interp"]).arg(&input));
    if let Some(directory)=std::env::var_os("FWP_LIST_AP_ARTIFACTS") {
        let directory=PathBuf::from(directory);std::fs::create_dir_all(&directory).unwrap();
        std::fs::write(directory.join("state-semantics.fwp"),source).unwrap();
        std::fs::write(directory.join("state-semantics.raw.stdout"),&reference.stdout).unwrap();
        std::fs::write(directory.join("state-semantics.raw.stderr"),&reference.stderr).unwrap();
        std::fs::write(directory.join("state-semantics.raw.status"),format!("{}\n",reference.status)).unwrap();
    }
    for opt in ["-O1","-O2"] {
        let executable=scratch.0.join(format!("state-semantics{}",&opt[1..]));let cfile=executable.with_extension("c");
        checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env_remove("FWP_NO_OPT")
            .arg("build").arg(&input).args(["--emit-c","-o"]).arg(&cfile));
        let code=std::fs::read_to_string(cfile).unwrap();
        if let Some(directory)=std::env::var_os("FWP_LIST_AP_ARTIFACTS") {
            let directory=PathBuf::from(directory);std::fs::create_dir_all(&directory).unwrap();
            std::fs::write(directory.join(format!("state-semantics{}.c",&opt[1..])),&code).unwrap();
        }
        fwp::cgen::compile_c(&code,&executable,opt).unwrap();
        for reuse in ["0","1"] {
            let output=Command::new(&executable).env("FWP_GC_STRESS","1").env("FWP_GC_VERIFY","1")
                .env("FWP_REUSE_VERIFY",reuse).output().unwrap();
            retain(&format!("state-semantics{}-reuse{reuse}",&opt[1..]),&code,&executable,&output);
            assert!(output.status.success(),"{opt} reuse={reuse}: {}",String::from_utf8_lossy(&output.stderr));
            assert_eq!(output.stdout,reference.stdout,"{opt} reuse={reuse}");
        }
    }
}
