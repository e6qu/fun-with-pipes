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
    let flat_negative="fail : I64 -> List[I64]\nfail = if (eq 2) (const \"list.ap order control\" | panic) (add 10 | repeat 2)\nmain = [1, 2, 3] | list.flat-map fail | echo\n";
    let negative="fail : I64 -> I64\nfail = if (eq 2) (const \"list.ap order control\" | panic) (add 10)\nmain = [1, 2, 3] | list.ap [fail, mul 2] | echo\n";
    for (label,source,invalid) in [("aliases",positive,false),("trap-order",negative,true),("flat-trap-order",flat_negative,true)] {
        std::fs::write(&input,source).unwrap();
        let reference=Command::new(env!("CARGO_BIN_EXE_fwp")).env("FWP_NO_OPT","1").args(["run","--interp"]).arg(&input).output().unwrap();
        assert_eq!(reference.status.success(),!invalid,"{label}: {}",String::from_utf8_lossy(&reference.stderr));
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
                if invalid { assert_eq!(output.status.code(),Some(101));assert!(String::from_utf8_lossy(&output.stderr).contains("list.ap order control")); }
            }
        }
    }
}
