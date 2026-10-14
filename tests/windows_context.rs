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
