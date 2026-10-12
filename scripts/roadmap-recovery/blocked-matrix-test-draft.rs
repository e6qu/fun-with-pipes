//! Specialized F64 matrix storage must retain raw language behavior.
use std::process::{Command,Output};
fn checked(c:&mut Command)->Output {let o=c.output().unwrap();assert!(o.status.success(),"{c:?}: {} {}",String::from_utf8_lossy(&o.stdout),String::from_utf8_lossy(&o.stderr));o}
#[test]
fn blocked_matrix_preserves_raw_products_and_cast_shape_behavior(){
    let d=std::env::temp_dir().join(format!("fwp-blocked-matrix-{}",std::process::id()));std::fs::create_dir(&d).unwrap();
    let input=d.join("matrix.fwp");std::fs::write(&input,include_str!("fixtures/blocked_matrix.fwp")).unwrap();let fwp=env!("CARGO_BIN_EXE_fwp");
    let reference=checked(Command::new(fwp).env("FWP_NO_OPT","1").args(["run","--interp"]).arg(&input));
    for mode in ["0","1"] {
        let interp=checked(Command::new(fwp).env_remove("FWP_NO_OPT").env("FWP_MATRIX_BLOCKING",mode).args(["run","--interp"]).arg(&input));
        assert_eq!((&interp.stdout,&interp.stderr),(&reference.stdout,&reference.stderr));
        let generated=d.join(format!("matrix-{mode}.c"));
        checked(Command::new(fwp).env_remove("FWP_NO_OPT").env("FWP_MATRIX_BLOCKING",mode).args(["build","--emit-c"]).arg(&input).arg("-o").arg(&generated));
        let code=std::fs::read_to_string(&generated).unwrap();
        assert_eq!(code.contains("/* matrix._mul-f64 :"),mode=="1","matrix specialization absent or active when disabled");
        for opt in ["-O1","-O2"] {
            let exe=d.join(format!("matrix-{mode}{opt}"));fwp::cgen::compile_c(&code,&exe,opt).unwrap();
            let actual=checked(Command::new(&exe).env("FWP_GC_STRESS","1").env("FWP_GC_VERIFY","1").env("FWP_REUSE_VERIFY","1"));
            assert_eq!((&actual.stdout,&actual.stderr),(&reference.stdout,&reference.stderr),"mode={mode} {opt}");
        }
    }
    std::fs::remove_dir_all(d).unwrap();
}
