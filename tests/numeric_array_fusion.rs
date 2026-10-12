//! Actual numeric Array fusion, trap order, raw semantics and allocation controls.
use std::process::{Command,Output};
fn checked(command:&mut Command)->Output {
    let out=command.output().unwrap();assert!(out.status.success(),"{command:?}: {}",String::from_utf8_lossy(&out.stderr));out
}
#[test]
fn numeric_array_fusion_preserves_effects_checked_traps_and_raw_semantics() {
    let directory=std::env::temp_dir().join(format!("fwp-array-fusion-semantics-{}",std::process::id()));std::fs::create_dir(&directory).unwrap();
    let fwp=env!("CARGO_BIN_EXE_fwp");
    let basic=include_str!("fixtures/numeric_array_fusion.fwp");
    let cases=[
      ("numeric",basic,0),
      ("effect-order","main = [1i8, 2i8] | array.from-list | array.map (tap echo) | array.fold add 127i8 | echo\n",101),
      ("distinct-traps","main = [0, 9223372036854775807] | array.from-list | array.map (add 1) | array.fold div 0 | echo\n",101),
      ("length-overflow","main = [127i8] | array.from-list | array.map (add 1i8) | array.length | echo\n",101),
      ("recursive-callback","descend : I64 -> I64\ndescend = if (le 0) id (sub 1 | descend)\nmain = [3, 2] | array.from-list | array.map descend | array.fold add 0 | echo\n",0),
    ];
    for (label,source,status) in cases {
        let input=directory.join(format!("{label}.fwp"));std::fs::write(&input,source).unwrap();
        let reference=Command::new(fwp).env("FWP_NO_OPT","1").args(["run","--interp"]).arg(&input).output().unwrap();
        assert_eq!(reference.status.code(),Some(status),"{label}: {}",String::from_utf8_lossy(&reference.stderr));
        if label=="effect-order" {assert_eq!(reference.stdout,b"1\n2\n");}
        if label=="distinct-traps" {assert!(String::from_utf8_lossy(&reference.stderr).contains("arithmetic overflow in I64"));}
        for mode in ["0","1"] {for opt in ["-O1","-O2"] {
            let binary=directory.join(format!("{label}-{mode}{}",&opt[1..]));
            checked(Command::new(fwp).env_remove("FWP_NO_OPT").env("FWP_ARRAY_FUSION",mode).args(["build",opt]).arg(&input).arg("-o").arg(&binary));
            let actual=Command::new(&binary).env("FWP_GC_STRESS","1").env("FWP_GC_VERIFY","1").env("FWP_REUSE_VERIFY","1").output().unwrap();
            assert_eq!((&actual.stdout,&actual.stderr,actual.status.code()),(&reference.stdout,&reference.stderr,reference.status.code()),"{label} {mode} {opt}");
        }}
    }
    std::fs::remove_dir_all(directory).unwrap();
}
#[test]
fn numeric_array_fusion_eliminates_intermediates_and_reclaims_inputs() {
    let directory=std::env::temp_dir().join(format!("fwp-array-fusion-allocation-{}",std::process::id()));std::fs::create_dir(&directory).unwrap();
    let input=directory.join("numeric.fwp");std::fs::write(&input,include_str!("fixtures/numeric_array_fusion.fwp")).unwrap();
    let mut results=Vec::new();
    for mode in ["0","1"] {
        let cfile=directory.join(format!("mode-{mode}.c"));
        checked(Command::new(env!("CARGO_BIN_EXE_fwp")).env_remove("FWP_NO_OPT").env("FWP_ARRAY_FUSION",mode).args(["build","--fn","reduce64","--emit-c"]).arg(&input).arg("-o").arg(&cfile));
        let source=std::fs::read_to_string(&cfile).unwrap();let start=source.find("/* reduce64 :").unwrap();
        let id=source[start..].split("static V f").nth(1).unwrap().split('(').next().unwrap();
        let probe=include_str!("fixtures/array_fusion_allocation_probe.c").replace("fREDUCE64",&format!("f{id}")).replace("FUSED",mode);
        assert!(source.contains("static inline void *fwp_gc_alloc(size_t n, int leaf) {"));assert!(source.contains("static inline void *fwp_alloc_init(size_t n) {"));
        let code=source.replace("typedef uint64_t V;","typedef uint64_t V;\nstatic uint64_t measured_calls,measured_bytes;")
          .replace("static inline void *fwp_gc_alloc(size_t n, int leaf) {","static inline void *fwp_gc_alloc(size_t n, int leaf) {\nif(leaf!=0){measured_calls++;measured_bytes+=n;}")
          .replace("static inline void *fwp_alloc_init(size_t n) {","static inline void *fwp_alloc_init(size_t n) {\nmeasured_calls++;measured_bytes+=n;")
          .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        for opt in ["-O1","-O2"] {
            let executable=directory.join(format!("profile-{mode}{}",&opt[1..]));fwp::cgen::compile_c(&format!("{code}\n{probe}"),&executable,opt).unwrap();
            let out=checked(Command::new(&executable).env("FWP_GC_STRESS","0").env("FWP_GC_VERIFY","1").env("FWP_REUSE_VERIFY","0"));
            let report:serde_json::Value=serde_json::from_slice(&out.stdout).unwrap();
            let bits:Vec<_>=report["cases"].as_array().unwrap().iter().map(|case| (case["elements"].clone(),case["resultBits"].clone())).collect();
            results.push(bits);
        }
    }
    assert!(results.windows(2).all(|pair| pair[0]==pair[1]),"Floating result bits changed with fusion or optimization");
    std::fs::remove_dir_all(directory).unwrap();
}
