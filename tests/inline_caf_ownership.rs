//! Inlining must evaluate CAF arguments before entering the callee.
use std::process::Command;
#[test]
fn ignored_caf_arguments_still_trap_in_evaluation_order() {
    let dir = std::env::temp_dir().join(format!("fwp-inline-caf-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let src = dir.join("probe.fwp");
    let exe = dir.join("probe");
    let cases=[
        "bad : I64\nbad = 1 | div 0\ndiscard : I64 -> I64\ndiscard = const 17\nmain = bad | discard | echo\n",
        "bad : I64\nbad = 1 | div 0\nlater : I64\nlater = 9223372036854775807 | add 1\ndiscard : I64 -> I64\ndiscard = const later\nmain = bad | discard | echo\n",
        "bad : String\nbad = 1 | div 0 | show\ndiscard : String -> I64\ndiscard = const 17\nmain = bad | discard | echo\n",
    ];
    for (case, text) in cases.iter().enumerate() {
        std::fs::write(&src, text).unwrap();
        let reference = Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1")
            .output()
            .unwrap();
        assert_eq!(
            reference.status.code(),
            Some(101),
            "case {case}: {}",
            String::from_utf8_lossy(&reference.stderr)
        );
        let optimized = Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .output()
            .unwrap();
        assert_eq!(
            optimized.status.code(),
            reference.status.code(),
            "optimized interpreter, case {case}"
        );
        assert_eq!(optimized.stdout, reference.stdout);
        assert_eq!(optimized.stderr, reference.stderr);
        for opt in ["-O1", "-O2"] {
            let build = Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe)
                .output()
                .unwrap();
            assert!(
                build.status.success(),
                "{}",
                String::from_utf8_lossy(&build.stderr)
            );
            for poison in ["0", "1"] {
                let native = Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert_eq!(
                    native.status.code(),
                    reference.status.code(),
                    "case {case}, {opt}, poison {poison}: {}",
                    String::from_utf8_lossy(&native.stdout)
                );
                assert_eq!(native.stdout, reference.stdout, "case {case}");
                assert_eq!(native.stderr, reference.stderr, "case {case}");
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn unused_counted_caf_argument_evaluates_and_releases_its_temporary() {
    let dir = std::env::temp_dir().join(format!("fwp-inline-caf-owner-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    std::fs::write(&src,"cached = \"input\" | string.repeat 2\ndiscard : String -> I64\ndiscard = const 17\nmain = cached | discard | echo\n").unwrap();
    let reference = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&src)
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    assert!(reference.status.success());
    assert_eq!(reference.stdout, b"17\n");
    let build = Command::new(fwp)
        .arg("build")
        .arg(&src)
        .args(["--emit-c", "-o"])
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(
        build.status.success(),
        "{}",
        String::from_utf8_lossy(&build.stderr)
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    assert!(
        emitted.contains("/* string.repeat :"),
        "the CAF must still be evaluated"
    );
    let runtime=emitted.replace("fwp_p_str_repeat(l0, l1)","observe_repeat(l0, l1)")
        .replacen("/* ---- program ---- */","static volatile V observed; static int calls, before_count; static V observe_repeat(V n,V s){calls++;V r=fwp_p_str_repeat(n,s);observed=r;return r;}\n/* ---- program ---- */",1)
        .replace("static void fwp_caf_finish(void) {","static void fwp_caf_finish(void) { before_count=observed?*fwp_rc_slot(observed):0;")
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let probe = r#"
int main(int argc,char **argv){int result=original_main(argc,argv);if(result)return result;
 if(calls!=1)return 2;if(before_count!=1)return 4;
 if(!observed||!(fwp_reuse_verify?STR(observed)->len==0:*fwp_rc_slot(observed)==0))return 3;
 return 0;}
"#;
    let start = runtime.find("/* main :").unwrap();
    let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
    let body = &runtime[start..end];
    let at = body
        .find("fwp_drop")
        .expect("unused CAF argument must be released");
    let stop = at + body[at..].find(';').unwrap() + 1;
    let control_body = body.replacen(&body[at..stop], "", 1);
    let control = runtime.replacen(body, &control_body, 1);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
        let old = Command::new(&exe)
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            old.status.code(),
            Some(4),
            "missing argument release must leave an extra owner"
        );
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let o = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                o.status.success(),
                "code {:?}: {}\n{body}",
                o.status.code(),
                String::from_utf8_lossy(&o.stderr)
            );
            assert_eq!(o.stdout, reference.stdout);
            assert_eq!(o.stderr, reference.stderr);
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
