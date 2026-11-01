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
    std::fs::write(
        &input,
        r#"
record : I64 -> I64
record = ad.tape | (fn node -> ad.push node 1.0 -1 0.0)
export probe : I64 -> I64
probe = ad.scope record
export managed : I64 -> I64
managed = ad.scope (const [0.0] | rev._seed | .1 | rev._seed | .1
    | map (fork mul id id) | head | option.unwrap-or zero | .vertex)
"#,
    )
    .unwrap();
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
        &[
            ("realloc", "library_realloc"),
            ("free", "library_free"),
            ("fwp_mem_alloc", "library_mem_alloc"),
            ("fwp_mem_realloc", "library_mem_realloc"),
            ("fwp_mem_free", "library_mem_free"),
        ],
    )
    .replace("(double *)calloc(", "(double *)library_calloc(");
    let code=format!("{}\nstatic void *library_realloc(void *,size_t);\nstatic void *library_calloc(size_t,size_t);\nstatic void library_free(void *);\nstatic void *library_mem_alloc(size_t);\nstatic void *library_mem_realloc(void *,size_t,size_t);\nstatic void library_mem_free(void *);\nstatic void library_finished(void);\n{}{}\n{}",&source[..a],tape,&source[b..],include_str!("fixtures/autodiff_library_ledger.c"))
        .replace("    fwp_tape_finish();\n    fwp_heap_finish();", "    fwp_tape_finish();library_finished();\n    fwp_heap_finish();");
    assert!(code.contains("fwp_tape_finish();library_finished();"));
    let host = dir.join("host.c");
    let exe = dir.join(if cfg!(windows) { "host.exe" } else { "host" });
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
        for omit in ["none", "finish", "weights", "scope"] {
            let c = match omit {
                "finish" => code.replace("fwp_tape_finish();library_finished();", ""),
                "weights" => code.replace("library_mem_free(owner->weights);", ""),
                "scope" => code.replace(
                    "        fwp_tape_unlink_scope(t);\n        fwp_tape_buffers buffers",
                    "        fwp_tape_buffers buffers",
                ),
                _ => code.clone(),
            };
            assert_eq!(c == code, omit == "none");
            fwp::cgen::compile_library(&c, &header, &output, opt, fwp::cgen::LibKind::Shared)
                .unwrap();
            for cache in ["0", "1"] {
                let report = dir.join(format!("report{opt}{omit}{cache}"));
                let result = Command::new(&exe)
                    .arg(&output)
                    .arg(&report)
                    .env("FWP_AD_WORKSPACE", cache)
                    .env("FWP_AD_LIBRARY_REPORT", &report)
                    .output()
                    .unwrap();
                assert_eq!(
                    result.status.code(),
                    Some(match omit {
                        "finish" => 182,
                        "weights" => 183,
                        "scope" => 186,
                        _ => 0,
                    }),
                    "{opt} omit={omit} cache={cache}: {}",
                    String::from_utf8_lossy(&result.stderr)
                );
            }
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
