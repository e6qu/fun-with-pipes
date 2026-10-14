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

#[test]
fn collector_scratch_is_excluded_from_the_mutator_root_range() {
    let source = include_str!("../runtime/fwp_rt_gc.c");
    let end = source.find("#endif /* FWP_GC */").unwrap() + "#endif /* FWP_GC */".len();
    let allocator = source[..end]
        .replace("    fwp_gc_scan_data();", "")
        .replace(
            "    fwp_gc_scan_stacks(stack_start);",
            "    volatile V scratch[32] = {0};\n    if (!garbage) garbage = (V)(uintptr_t)fwp_alloc_leaf(64);\n    scratch[0] = garbage;\n    __asm__ volatile(\"\" : : \"m\"(scratch) : \"memory\");\n    fwp_gc_scan_stacks(stack_start);\n    __asm__ volatile(\"\" : : \"m\"(scratch) : \"memory\");",
        );
    let old_range = allocator.replace(
        "    fwp_gc_scan_stacks(stack_start);",
        "    fwp_gc_scan_stacks(fwp_gc_sp());",
    );
    assert_ne!(old_range, allocator);
    let prefix = include_str!("fixtures/native_allocator_probe.c")
        .split("/* NATIVE_ALLOCATOR */")
        .next()
        .unwrap();
    let probe = r#"
static void fwp_gc_scan_stacks(char *sp) { fwp_gc_scan_root(sp, fwp_gc.main_top); }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    volatile V live = (V)(uintptr_t)fwp_alloc_leaf(32);
    fwp_gc.major_next = 1;
    fwp_gc_collect();
    __asm__ volatile("" : : "m"(live) : "memory");
    if (!fwp_gc_marked((void *)(uintptr_t)live)) return 24;
    if (fwp_gc_marked((void *)(uintptr_t)garbage)) return 23;
    fwp_gc_finish();
    return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("collector-stack").unwrap();
    // Create garbage only inside the injected collector frame: allocating it
    // in a prior mutator call can leave a legitimate stale register/stack root.
    let binary = dir.join(if cfg!(windows) { "probe.exe" } else { "probe" });
    for opt in ["-O1", "-O2"] {
        for (runtime, expected) in [(&allocator, 0), (&old_range, 23)] {
            let c = format!("{prefix}\nstatic volatile V garbage;\n{runtime}{probe}");
            fwp::cgen::compile_c(&c, &binary, opt).unwrap();
            for attempt in 0..8 {
                let output = Command::new(&binary)
                    .env("FWP_GC", "on")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "1")
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{opt}, attempt {attempt}: {output:?}"
                );
            }
        }
    }
}
