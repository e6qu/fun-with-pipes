//! Exercise native allocation and image roots independently of the task runtime.
#![cfg(any(target_os = "linux", target_os = "macos", target_os = "windows"))]
use std::process::Command;

#[test]
fn native_pages_image_roots_counts_and_release() {
    let source = include_str!("../runtime/fwp_rt_gc.c");
    let end = source.find("#endif /* FWP_GC */").unwrap() + "#endif /* FWP_GC */".len();
    let allocator = &source[..end];
    let omitted = allocator.replace("    fwp_gc_scan_data();", "    /* omit image roots */");
    assert_ne!(omitted, allocator);
    let dir = fwp::cgen::TempDir::new("native-allocator").unwrap();
    let binary = dir.join(if cfg!(windows) { "probe.exe" } else { "probe" });
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [(allocator, 0), (omitted.as_str(), 23)] {
            let c = include_str!("fixtures/native_allocator_probe.c")
                .replace("/* NATIVE_ALLOCATOR */", code);
            fwp::cgen::compile_c(&c, &binary, opt).unwrap();
            for verify in ["0", "1"] {
                let out = Command::new(&binary)
                    .env("FWP_GC", "on")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    out.status.code(),
                    Some(expected),
                    "{opt}, verify={verify}: {out:?}"
                );
            }
        }
    }
}
