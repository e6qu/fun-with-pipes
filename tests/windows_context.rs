//! Native Windows ABI and conservative roots of suspended fibers.
#![cfg(windows)]
use std::process::Command;

#[test]
fn fiber_registers_stacks_and_host_context_are_preserved() {
    let allocator = include_str!("../runtime/fwp_rt_gc.c");
    let end = allocator.find("#endif /* FWP_GC */").unwrap() + "#endif /* FWP_GC */".len();
    // Isolate fiber roots from PE data roots, which have their own native probe.
    let allocator = allocator[..end].replace("    fwp_gc_scan_data();", "");
    let context = include_str!("../runtime/fwp_rt_context_win.c");
    let missing_registers = context.replace(
        "    fwp_gc_scan_root((char *)context->registers,\n                     (char *)context->registers + sizeof context->registers);",
        "",
    );
    let missing_stack = context.replace("    fwp_gc_scan_root(context->sp, context->top);", "");
    assert_ne!(missing_registers, context);
    assert_ne!(missing_stack, context);
    let dir = fwp::cgen::TempDir::new("windows-context").unwrap();
    let executable = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        for (code, expected) in [
            (context, 0),
            (missing_registers.as_str(), 23),
            (missing_stack.as_str(), 24),
        ] {
            let source = include_str!("fixtures/windows_context_probe.c")
                .replace("/* NATIVE_ALLOCATOR */", &allocator)
                .replace("/* WINDOWS_CONTEXT */", code);
            fwp::cgen::compile_c(&source, &executable, opt).unwrap();
            let out = Command::new(&executable)
                .env("FWP_GC", "on")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(out.status.code(), Some(expected), "{opt}: {out:?}");
        }
    }
}

#[test]
fn active_stack_roots_extend_above_the_frame_marker() {
    let allocator = include_str!("../runtime/fwp_rt_gc.c");
    let end = allocator.find("#endif /* FWP_GC */").unwrap() + "#endif /* FWP_GC */".len();
    let allocator = allocator[..end].replace("    fwp_gc_scan_data();", "");
    let old_bound = allocator.replace(
        "fwp_gc.main_top = (char *)high;",
        "fwp_gc.main_top = (char *)top;",
    );
    assert_ne!(old_bound, allocator);
    let prefix = include_str!("fixtures/windows_context_probe.c")
        .split("/* NATIVE_ALLOCATOR */")
        .next()
        .unwrap();
    let probe = r#"
static char *active_root;
static void fwp_gc_scan_stacks(char *sp) {
    (void)sp;
    /* Isolate a live slot above the supplied frame marker. Do not let
     * incidental register copies hide an incorrect upper stack bound. */
    fwp_gc_scan_root(active_root, fwp_gc.main_top);
}
int main(void) {
    volatile V slots[8192] = {0};
    fwp_gc_start((void *)&slots[0]);
    active_root = (char *)&slots[8191];
    slots[8191] = (V)(uintptr_t)fwp_alloc_leaf(32);
    fwp_gc.major_next = 1;
    fwp_gc_collect();
    if (!fwp_gc_marked((void *)(uintptr_t)slots[8191])) return 23;
    fwp_gc_finish();
    return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("windows-active-stack").unwrap();
    let binary = dir.join("probe.exe");
    for opt in ["-O1", "-O2"] {
        for (runtime, expected) in [(&allocator, 0), (&old_bound, 23)] {
            fwp::cgen::compile_c(&format!("{prefix}{runtime}{probe}"), &binary, opt).unwrap();
            let output = Command::new(&binary)
                .env("FWP_GC", "on")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(output.status.code(), Some(expected), "{opt}: {output:?}");
        }
    }
}
