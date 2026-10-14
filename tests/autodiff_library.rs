//! Actual dynamic unload must retire cached and live private tape owners.
#[path = "support/c_instrument.rs"]
mod c_instrument;
use std::process::Command;
#[test]
fn autodiff_library_unload_releases_live_and_cached_buffers() {
    let dir = std::env::temp_dir().join(format!("fwp-ad-library-{}", std::process::id()));
    std::fs::create_dir(&dir).unwrap();
    let input = dir.join("workspace.fwp");
    let output = dir.join(format!(
        "workspace.{}",
        fwp::cgen::shared_library_extension()
    ));
    std::fs::write(&input,"export probe : I64 -> I64\nprobe = ad.scope ad.tape\nexport live : I64 -> I64\nlive = ad.tape\n").unwrap();
    let build = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--cdylib", "--emit-c"])
        .arg(&input)
        .arg("-o")
        .arg(&output)
        .output()
        .unwrap();
    assert!(
        build.status.success(),
        "{}",
        String::from_utf8_lossy(&build.stderr)
    );
    let source = std::fs::read_to_string(output.with_extension("c")).unwrap();
    let header = std::fs::read_to_string(output.with_extension("h")).unwrap();
    let a = source
        .find("/* ------------------------------------------------------------------ tapes */")
        .unwrap();
    let b = a + source[a..]
        .find("/* ---------------------------------------------------------------- kernels */")
        .unwrap();
    let tape = c_instrument::calls(
        &source[a..b],
        &[("realloc", "library_realloc"), ("free", "library_free")],
    )
    .replace("(double *)calloc(", "(double *)library_calloc(");
    let code=format!("{}\nstatic void *library_realloc(void *,size_t);\nstatic void *library_calloc(size_t,size_t);\nstatic void library_free(void *);\nstatic void library_finished(void);\n{}{}\n{}",&source[..a],tape,&source[b..],include_str!("fixtures/autodiff_library_ledger.c"))
        .replace("    fwp_tape_finish();\n    fwp_gc_finish();", "    fwp_tape_finish();library_finished();\n    fwp_gc_finish();");
    assert!(code.contains("fwp_tape_finish();library_finished();"));
    let host = dir.join("host.c");
    let exe = dir.join("host");
    std::fs::write(&host, include_str!("fixtures/autodiff_library_host.c")).unwrap();
    let mut cc = Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()));
    cc.arg(&host).arg("-o").arg(&exe);
    if cfg!(target_os = "linux") {
        cc.arg("-ldl");
    }
    let built = cc.output().unwrap();
    assert!(
        built.status.success(),
        "{}",
        String::from_utf8_lossy(&built.stderr)
    );
    for opt in ["-O1", "-O2"] {
        for omit in [false, true] {
            let c = if omit {
                code.replace("fwp_tape_finish();library_finished();", "")
            } else {
                code.clone()
            };
            fwp::cgen::compile_library(&c, &header, &output, opt, fwp::cgen::LibKind::Shared)
                .unwrap();
            for cache in ["0", "1"] {
                let report = dir.join(format!("report{opt}{omit}{cache}"));
                let result = Command::new(&exe)
                    .arg(&output)
                    .arg(&report)
                    .env("FWP_AD_WORKSPACE", cache)
                    .env("FWP_AD_LIBRARY_REPORT", &report)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .output()
                    .unwrap();
                assert_eq!(
                    result.status.code(),
                    Some(if omit { 182 } else { 0 }),
                    "{opt} omit={omit} cache={cache}: {}",
                    String::from_utf8_lossy(&result.stderr)
                );
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
