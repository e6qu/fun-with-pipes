//! Pointer address arithmetic never dereferences boundary addresses.
use fwp::ffi_interp::pointer_prim;
use fwp::ir::MT;
use fwp::value::Value;
use std::process::Command;

#[test]
fn interpreter_offsets_wrap_at_pointer_width_for_all_numeric_storage_widths() {
    for (name, width) in [
        ("I8", 1usize), ("U8", 1), ("I16", 2), ("U16", 2),
        ("I32", 4), ("U32", 4), ("F32", 4), ("I64", 8),
        ("U64", 8), ("F64", 8), ("ISize", std::mem::size_of::<isize>()),
        ("USize", std::mem::size_of::<usize>()),
    ] {
        let pointer = MT::Con("std::Ptr".into(), vec![MT::con(&format!("std::{name}"))]);
        for address in [0usize, 1, usize::MAX / 2, usize::MAX] {
            for index in [i64::MIN, -2, -1, 0, 1, 2, i64::MAX] {
                let result = pointer_prim("ptr.at", &[Value::I64(index), Value::U64(address as u64)],
                    &[MT::con("std::I64"), pointer.clone()], &pointer).unwrap();
                let expected = address.wrapping_add((index as usize).wrapping_mul(width));
                assert!(matches!(result, Value::U64(actual) if actual == expected as u64),
                    "{name}: address {address}, index {index}: {result:?}");
            }
        }
    }
}

fn checked(cmd: &mut Command) -> std::process::Output {
    let result = cmd.output().unwrap();
    assert!(result.status.success(), "{cmd:?}: {:?}: {}", result.status.code(), String::from_utf8_lossy(&result.stderr));
    result
}

#[test]
fn native_boundary_offsets_match_raw_interpreter_and_reject_signed_overflow() {
    let dir = fwp::cgen::TempDir::new("fwp-pointer-arithmetic").unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let mut text = String::new();
    let names = ["I8", "U8", "I16", "U16", "I32", "U32", "I64", "U64", "F32", "F64", "ISize", "USize"];
    for (id, name) in names.iter().enumerate() {
        text.push_str(&format!("same-{id} : Ptr[{name}] -> Bool\nsame-{id} = fork eq ptr.address (ptr.at 9223372036854775807 | ptr.at -9223372036854775808 | ptr.at 1 | ptr.address)\nprobe-{id} : Ptr[{name}] -> () ! {{IO, Unsafe}}\nprobe-{id} = tap (same-{id} | echo) | mem.free\n"));
    }
    text.push_str("main = [\n");
    for id in 0..names.len() {
        text.push_str(&format!("    16 | mem.alloc | probe-{id},\n"));
    }
    text.push_str("] | ignore\n");
    std::fs::write(&source, text).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).env("FWP_NO_OPT", "1").args(["run", "--interp"]).arg(&source));
    assert_eq!(reference.stdout, b"True\n".repeat(names.len()));
    assert!(reference.stderr.is_empty());
    checked(Command::new(fwp).arg("build").arg(&source).args(["--emit-c", "-o"]).arg(&cfile));
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let corrected = "return (V)((uintptr_t)l1 + (uintptr_t)l0 * sizeof(int16_t));";
    assert!(emitted.contains(corrected), "the I16 offset control must exercise the real generated primitive");
    let control = emitted.replace(corrected, "return (V)((int64_t)l1 + (int64_t)l0 * (int64_t)sizeof(int16_t));");
    let control_file = dir.join("signed-control.c");
    std::fs::write(&control_file, control).unwrap();
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let output = checked(Command::new(&exe).env("FWP_GC_STRESS", "1").env("FWP_GC_VERIFY", "1").env("FWP_REUSE_VERIFY", poison));
            assert_eq!(output.stdout, reference.stdout);
            assert_eq!(output.stderr, reference.stderr);
        }
        let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
        for (file, negative) in [(&cfile, false), (&control_file, true)] {
            checked(Command::new(&cc).args([opt, "-std=gnu11", "-ffp-contract=off", "-w", "-fsanitize=undefined", "-fno-sanitize-recover=undefined", "-o"]).arg(&exe).arg(file).args(["-lm", "-lpthread"]));
            let result = Command::new(&exe).output().unwrap();
            if negative {
                assert_eq!(result.status.code(), Some(1));
                assert!(String::from_utf8_lossy(&result.stderr).contains("signed integer overflow"));
            } else {
                assert!(result.status.success(), "{}", String::from_utf8_lossy(&result.stderr));
                assert_eq!(result.stdout, reference.stdout);
                assert_eq!(result.stderr, reference.stderr);
            }
        }
    }
}
