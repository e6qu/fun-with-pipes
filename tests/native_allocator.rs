//! Exercise native allocation and image roots independently of the task runtime.
#![cfg(any(target_os = "linux", target_os = "macos", target_os = "windows"))]
use std::process::Command;

#[test]
fn first_allocation_and_free_balance_without_explicit_initialization() {
    let source = include_str!("../runtime/fwp_rt_gc.c");
    let end = source.find("#endif /* FWP_GC */").unwrap() + "#endif /* FWP_GC */".len();
    let prefix = include_str!("fixtures/native_allocator_probe.c")
        .split("/* NATIVE_ALLOCATOR */")
        .next()
        .unwrap();
    let probe = r#"
static void fwp_gc_scan_stacks(char *sp) { (void)sp; }
int main(void) {
    size_t sizes[] = {1, 17, 1024, GC_MAX_SMALL + 16};
    for (int mode = 0; mode < 3; ++mode) {
        for (size_t i = 0; i < sizeof sizes / sizeof *sizes; ++i) {
            size_t size = sizes[i];
            void *value = mode == 0 ? fwp_alloc_leaf(size) :
                mode == 1 ? fwp_alloc(size) : fwp_alloc_init(size);
            size_t expected = size > GC_MAX_SMALL ? size :
                fwp_gc.slot[fwp_gc.cls_of[(size + 15) >> 4]];
            if (fwp_gc.budget_given - fwp_gc.budget != (intptr_t)expected) return 35;
            fwp_mem_free(value);
            if (fwp_gc.budget != fwp_gc.budget_given) return 36;
            fwp_gc_finish();
        }
    }
    return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("first-allocation").unwrap();
    let binary = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(
            &format!("{prefix}\n{}{probe}", &source[..end]),
            &binary,
            opt,
        )
        .unwrap();
        let output = Command::new(&binary)
            .env("FWP_GC", "off")
            .env("FWP_GC_STRESS", "0")
            .env("FWP_GC_VERIFY", "0")
            .env("FWP_REUSE_VERIFY", "0")
            .output()
            .unwrap();
        assert!(output.status.success(), "{opt}: {output:?}");
    }
}

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

#[test]
fn static_heap_pressure_reclaims_old_pages_and_partly_live_slots() {
    let dir = fwp::cgen::TempDir::new("static-heap-pressure").unwrap();
    let source = dir.join("pressure.fwp");
    let generated = dir.join("pressure.c");
    std::fs::write(&source, "main = ()\n").unwrap();
    let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args([
            "build", "--gc", "tracing", "--memory", "static", "--heap", "1M", "--emit-c",
        ])
        .arg(&source)
        .arg("-o")
        .arg(&generated)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let code = std::fs::read_to_string(&generated).unwrap();
    let entry = "static void *fwp_main_thread(void *arg) {";
    let start = "    fwp_gc_start(__builtin_frame_address(0));\n";
    assert_eq!(code.matches(entry).count(), 1);
    assert_eq!(code.matches(start).count(), 1);
    let slots = "            /* A partly live chunk can supply slots without becoming free. */\n            char *p = l->free;\n            if (p) { l->free = (char *)~*(uintptr_t *)p; return p; }";
    let major = "            fwp_gc.major_next = 1;\n";
    assert_eq!(code.matches(slots).count(), 1);
    assert_eq!(code.matches(major).count(), 2);
    for (variant, program) in [
        ("repaired", code.clone()),
        (
            "missing-slots",
            code.replace(slots, "            /* omit reclaimed slots */"),
        ),
        ("missing-major", code.replace(major, "")),
    ] {
        let program = program
            .replace(
                entry,
                &format!(
                    "{}\n{entry}",
                    include_str!("fixtures/static_heap_pressure.c")
                ),
            )
            .replace(
                start,
                &format!("{start}    static_heap_pressure_probe();\n"),
            );
        for opt in ["-O0", "-O1", "-O2"] {
            let binary = dir.join(format!("{variant}{opt}.exe"));
            fwp::cgen::compile_c(&program, &binary, opt).unwrap();
            for kind in ["slots", "pages"] {
                for collector in ["on", "full", "off"] {
                    let output = Command::new(&binary)
                        .env("FWP_STATIC_PROBE", kind)
                        .env("FWP_GC", collector)
                        .env("FWP_GC_STATS", "0")
                        .env_remove("FWP_MEMORY_REPORT")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    let exhausted = collector == "off"
                        || (variant == "missing-slots" && kind == "slots")
                        || (variant == "missing-major" && kind == "pages" && collector == "on");
                    assert_eq!(
                        output.status.code(),
                        Some(if exhausted { 102 } else { 0 }),
                        "{variant}/{opt}/{kind}/{collector}: {output:?}"
                    );
                    assert!(output.stdout.is_empty(), "{output:?}");
                    if exhausted {
                        assert!(
                            String::from_utf8_lossy(&output.stderr)
                                .contains("the static heap (1024 KiB) is full"),
                            "{output:?}"
                        );
                    } else {
                        assert!(output.stderr.is_empty(), "{output:?}");
                    }
                }
            }
        }
    }
}
