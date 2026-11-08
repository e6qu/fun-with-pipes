//! Fresh F64 output stores preserve bits, bounds, input views and other layouts.
use super::{checked, record_probe, Scratch};
use std::process::{Command, Stdio};

#[test]
fn fresh_array_output_preserves_views_bounds_and_packed_values() {
    let dir = Scratch::new("fresh-output");
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let mut source = String::new();
    let mut calls = Vec::new();
    for (name, ty, low, high, zero) in [
        ("i8", "I8", "-128i8", "127i8", "0i8"),
        ("u8", "U8", "0u8", "255u8", "0u8"),
        ("i16", "I16", "-32768i16", "32767i16", "0i16"),
        ("u16", "U16", "0u16", "65535u16", "0u16"),
        ("i32", "I32", "-2147483648i32", "2147483647i32", "0i32"),
        ("u32", "U32", "0u32", "4294967295u32", "0u32"),
        (
            "i64",
            "I64",
            "-9223372036854775808",
            "9223372036854775807",
            "0",
        ),
        ("u64", "U64", "0u64", "18446744073709551615u64", "0u64"),
        (
            "f32",
            "F32",
            "-0.0f32",
            "1.401298464324817e-45f32",
            "0.0f32",
        ),
        ("f64", "F64", "-0.0", "4.9406564584124654e-324", "0.0"),
    ] {
        source.push_str(&format!(
            "
read-{name} : Array[{ty}] -> Array[{ty}] -> I64 -> {ty}
read-{name} = fn left -> fn right -> fn index ->
    index % 2 == 0 | match
        True -> array.get (index - 1) left | option.unwrap-or {zero}
        False -> array.get (index - 1) right | option.unwrap-or {zero}
probe-{name} : I64 -> () ! {{IO}}
probe-{name} = fn count ->
    let original = array.generate count (fn index -> index % 2 == 0 | match
        True -> {low}
        False -> {high})
    in let view = array.slice 8 48 original
    in let copy = array.generate (array.length view + 2) (read-{name} view original)
    in (original, view, copy, array.get 9223372036854775807 view) | echo
"
        ));
        calls.push(format!("probe-{name} count"));
        calls.push(format!("probe-{name} 0"));
    }
    source.push_str(&format!(
        "main = let count = read-all () | string.length | add 64 in [{}] | ignore\n",
        calls.join(", ")
    ));
    let path = dir.0.join("arrays.fwp");
    std::fs::write(&path, source).unwrap();
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&path)
            .stdin(Stdio::null()),
    );
    assert!(reference.stderr.is_empty());
    for packed in ["0", "1"] {
        let cfile = dir.0.join("arrays.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_PACKED_ARRAYS", packed)
                .env("FWP_STACK", "1")
                .env("FWP_ARRAY_FUSION", "1")
                .args(["build", "--emit-c", "-O2"])
                .arg(&path)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        assert!(code.contains("memcpy(result_data + index * sizeof value, &value, sizeof value);"));
        for opt in ["-O0", "-O2"] {
            let executable = dir.0.join("arrays.exe");
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let output = checked(Command::new(&executable).stdin(Stdio::null()));
            record_probe::save(
                "fresh-array-output",
                &format!("packed-{packed}{opt}"),
                &code,
                &executable,
                &output,
            );
            assert_eq!(output.stdout, reference.stdout, "packed={packed} {opt}");
            assert_eq!(output.stderr, reference.stderr, "packed={packed} {opt}");
        }
    }
}
