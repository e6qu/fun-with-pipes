//! Declared precision must survive the interpreter, C ABI, text and wire paths.
use fwp::ir::{Body, Expr, Func, Program, TypeShape, MT};
use fwp::softfloat::{BFloat16, Binary128, Binary16};
use fwp::value::Value;
use std::fmt::Write;
use std::process::Command;

#[path = "support/ownership_ledger.rs"]
mod ownership_ledger;

#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn canonical_float_text_preserves_values_and_output_order() {
    let directory = fwp::cgen::TempDir::new("float-text-program").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let input =
        std::path::Path::new(env!("CARGO_MANIFEST_DIR")).join("tests/fixtures/float_text.fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&input)
        .output()
        .unwrap();
    assert!(reference.status.success(), "{reference:?}");
    assert!(reference.stderr.is_empty(), "{reference:?}");
    {
        let cfile = directory.join("text.c");
        let emitted = Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .env("FWP_LTO", "0")
            .env("FWP_STACK", "1")
            .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(emitted.status.success(), "counted: {emitted:?}");
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O1", "-O2"] {
            let executable = directory.join("text.exe");
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let actual = Command::new(&executable).output().unwrap();
            record_probe::save(
                "float_formats",
                &format!("program{opt}"),
                &code,
                &executable,
                &actual,
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr, actual.status.code()),
                (
                    &reference.stdout,
                    &reference.stderr,
                    reference.status.code()
                ),
                "{opt}"
            );
        }
    }
}

#[test]
fn float_text_matches_frozen_precision_and_detects_corruption() {
    let directory = fwp::cgen::TempDir::new("float-text-precision").unwrap();
    let input = directory.join("main.fwp");
    std::fs::write(&input, "main = 0.1 | echo\n").unwrap();
    let cfile = directory.join("main.c");
    let emitted = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .env_remove("FWP_NO_OPT")
        .env("FWP_LTO", "0")
        .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
        .arg(&input)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let generated = std::fs::read_to_string(cfile).unwrap();
    assert_eq!(
        generated.matches("int main(int argc, char **argv)").count(),
        1
    );
    let generated = generated.replace(
        "int main(int argc, char **argv)",
        "int saved_main(int argc, char **argv)",
    );
    let mut failures = Vec::new();
    for opt in ["-O1", "-O2"] {
        for (label, control, status) in [
            ("checked", 0, 0),
            ("changed-digit", 1, 77),
            ("changed-boundary", 2, 78),
        ] {
            let code = format!("{generated}\n{}\n#define FORMAT_CONTROL {control}\n#define FORMAT_SAMPLES 4096\n{}",
                include_str!("fixtures/float_text_baseline.c"), include_str!("fixtures/float_text_probe.c"));
            let executable = directory.join("probe.exe");
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            let actual = Command::new(&executable).output().unwrap();
            record_probe::save(
                "float_formats",
                &format!("precision-{label}{opt}"),
                &code,
                &executable,
                &actual,
            );
            let text = std::str::from_utf8(&actual.stdout);
            let summary_ok = text.is_ok_and(|text| {
                let lines: Vec<_> = text.lines().collect();
                matches!(lines.as_slice(), [line]
                    if line.starts_with("float-text values=119768 precisions=")
                    && (status != 0 || line.ends_with("mismatches=0 bounds=0")))
            });
            if actual.status.code() != Some(status)
                || !summary_ok
                || (status == 0 && !actual.stderr.is_empty())
            {
                failures.push(format!("{label} {opt}: {actual:?}"));
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn declared_formats_agree_in_raw_and_native_execution() {
    let directory = fwp::cgen::TempDir::new("fwp-float-formats").unwrap();
    let source = directory.join("formats.fwp");
    std::fs::write(&source, r#"
quad-half : F128 -> F16
quad-half = float.convert
read-wide : String -> Result[F128, String]
read-wide = json.read
input : () -> F128 ! {IO}
input = const "FWP_FLOAT_INPUT" | env.get | option.unwrap-or "4" | parse-float | option.unwrap-or 4.0f128
values : F128 -> Array[F128]
values = fork array.make (const 8) id
get-first : Array[F128] -> F128
get-first = array.get 0 | option.unwrap-or 0.0f128
read-array : String -> Result[Array[F128], String]
read-array = json.read
main = [
    1.0001f16 | eq 1.0f16 | echo,
    1.001bf16 | eq 1.0bf16 | echo,
    9007199254740993.0f128 | gt 9007199254740992.0f128 | echo,
    1.0004882812500000000000000000000002f128 | quad-half | gt 1.0f16 | echo,
    "1e400" | parse-float | option.unwrap-or 0.0f128 | ln | gt 900.0f128 | echo,
    1.0000000000000000000000000000000002f128 | ln | gt 0.0f128 | echo,
    7.0f128 | rem 4.0f128 | eq 3.0f128 | echo,
    -2.5f16 | round | eq -3.0f16 | echo,
    1.0e-40bf16 | gt 0.0bf16 | echo,
    1.0000000000000000000000000000000002f128 | json.write | read-wide | result.unwrap-or 0.0f128 | gt 1.0f128 | echo,
    [1.0001f16, 2.0f16] | array.from-list | array.to-list | head | eq (Some 1.0f16) | echo,
    () | input | values | get-first | eq 4.0f128 | echo,
    () | input | values | array.to-list | head | eq (Some 4.0f128) | echo,
    () | input | values | array.slice 2 4 | get-first | eq 4.0f128 | echo,
    () | input | values | array.map (add 1.0f128) | array.fold add 0.0f128 | eq 40.0f128 | echo,
    () | input | values | array.set 0 9.0f128 | option.map get-first | eq (Some 9.0f128) | echo,
    () | input | values | array.push 1.0f128 | array.sort | get-first | eq 1.0f128 | echo,
    () | input | values | json.write | read-array | result.map get-first | eq (Ok 4.0f128) | echo,
] | ignore
"#).unwrap();
    let expected = "True\n".repeat(18).into_bytes();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let raw = Command::new(fwp)
        .env("FWP_NO_OPT", "1")
        .env("FWP_FLOAT_INPUT", "4")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(raw.status.success(), "{raw:?}");
    assert_eq!(raw.stdout, expected, "{raw:?}");
    assert!(raw.stderr.is_empty(), "{raw:?}");
    for opt in ["-O1", "-O2"] {
        let binary = directory.join(format!("formats-{}", &opt[1..]));
        let built = Command::new(fwp)
            .env_remove("FWP_NO_OPT")
            .env("FWP_CACHE_DIR", directory.join("cache"))
            .args(["build", opt])
            .arg(&source)
            .arg("-o")
            .arg(&binary)
            .output()
            .unwrap();
        assert!(built.status.success(), "{built:?}");
        let native = Command::new(&binary)
            .env("FWP_FLOAT_INPUT", "4")
            .output()
            .unwrap();
        assert!(native.status.success(), "{native:?}");
        assert!(native.stderr.is_empty(), "{native:?}");
        assert_eq!(native.stdout, expected, "{native:?}");
    }
}

#[test]
fn quad_array_bytes_and_escaping_owners_are_independent() {
    let directory = fwp::cgen::TempDir::new("fwp-quad-array-bits").unwrap();
    let path = directory.join("quad.fwp");
    std::fs::write(
        &path,
        "export quad : F128 -> Array[F128]\nquad = array.make 8\n",
    )
    .unwrap();
    let c = directory.join("quad.c");
    let output = Command::new(env!("CARGO_BIN_EXE_fwp"))
        .args(["build", "--fn", "quad", "--emit-c"])
        .arg(&path)
        .arg("-o")
        .arg(&c)
        .output()
        .unwrap();
    assert!(output.status.success(), "{output:?}");
    let source = std::fs::read_to_string(&c).unwrap().replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static void quad_drop(V v) { if (fwp_rc_release_last(v)) fwp_rc_free_obj(v); }
int main(void) {
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    const fwp_desc quad={.kind=K_F128,.dup=fwp_rc_dup,.drop=quad_drop};
    const float128_t words[]={{{1,0}},{{0,UINT64_C(0x8000000000000000)}},
        {{UINT64_C(0x1234),UINT64_C(0x7fff800000000000)}}};
    V a=fwp_array_typed_new(3,&quad);
    if(fwp_array_stride(&quad)!=16 || (uintptr_t)fwp_array_data(a)%8) return 180;
    for(size_t i=0;i<3;i++) fwp_array_store(a,i,PTR(&words[i]),&quad);
    if(memcmp(fwp_array_data(a),words,sizeof words)) return 181;
    V saved=fwp_array_retain(fwp_array_load(a,2,&quad),fwp_rc_dup,&quad);
    if(saved>=a && saved<a+sizeof(fwp_arr)+sizeof words) return 182;
    V original=saved;
    fwp_rc_free_arr(a);
    float128_t value=fwp_f128(saved);
    if(memcmp(&value,&words[2],16)) return 183;
    if(!fwp_rc_slot(saved) || *fwp_rc_slot(saved)!=1) return 184;
    quad_drop(saved);

    return 0;
}
"#;
    let source = source + probe;
    for (name, code, expected) in [
        ("owned", source.clone(), 0),
        (
            "missing-copy",
            source.replace("return fwp_box_f128(fwp_f128(value));", "return value;"),
            182,
        ),
    ] {
        let binary = directory.join(name);
        fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
        let output = Command::new(binary).output().unwrap();
        assert_eq!(output.status.code(), Some(expected), "{name}: {output:?}");
    }
}

// Compare bits, not float equality: NaNs are unequal even to themselves, and
// numeric equality does not distinguish positive and negative zero.
#[test]
fn same_type_conversion_agrees_across_interpreter_and_native_entries() {
    let mut program = Program::default();
    let mut cases = Vec::new();
    for (name, width, fraction) in [
        ("F16", 16u32, 10u32),
        ("BF16", 16, 7),
        ("F32", 32, 23),
        ("F64", 64, 52),
        ("F128", 128, 112),
    ] {
        let ty = MT::con(&format!("std::{name}"));
        let function = MT::Fun(Box::new(ty.clone()), Box::new(ty.clone()));
        let primitive = program.funcs.len();
        for (suffix, body) in [
            ("primitive", Body::Prim("float.convert".into())),
            (
                "worker",
                Body::Expr(Expr::Call(primitive, vec![Expr::Local(0)])),
            ),
        ] {
            let exported = format!("convert_{}_{}", name.to_lowercase(), suffix);
            program
                .exports
                .push((exported.clone(), program.funcs.len()));
            program.funcs.push(Func {
                name: exported,
                arity: 1,
                locals: vec![ty.clone()],
                ty: function.clone(),
                body,
            });
        }
        let sign = 1u128 << (width - 1);
        let infinity = ((1u128 << (width - fraction - 1)) - 1) << fraction;
        let quiet = 1u128 << (fraction - 1);
        // Both signs of zero, subnormal boundaries, normal boundaries,
        // infinities, and quiet/signaling NaNs with distinct payloads.
        let magnitudes = [
            0,
            1,
            (1u128 << fraction) - 1,
            1u128 << fraction,
            infinity - 1,
            infinity,
            infinity | 1,
            // Keep the second payload below BF16's quiet bit (0x40).
            infinity | 0x21,
            infinity | quiet,
            infinity | quiet | 0x21,
        ];
        for (index, magnitude) in magnitudes.into_iter().enumerate() {
            assert!(
                !magnitudes[..index].contains(&magnitude),
                "{name} conversion input patterns must be distinct"
            );
            for bits in [magnitude, magnitude | sign] {
                let value = match name {
                    "F16" => Value::F16(Binary16::from_bits(bits as u16)),
                    "BF16" => Value::BF16(BFloat16::from_bits(bits as u16)),
                    "F32" => Value::F32(f32::from_bits(bits as u32)),
                    "F64" => Value::F64(f64::from_bits(bits as u64)),
                    "F128" => Value::F128(Binary128::from_bits(bits)),
                    _ => unreachable!(),
                };
                for id in [primitive, primitive + 1] {
                    cases.push((name, bits, value.clone(), id));
                }
            }
        }
    }
    fwp::ir::check_locals(&program).unwrap();
    let directory = fwp::cgen::TempDir::new("same-type-float-conversion").unwrap();
    let mut failures = Vec::new();
    let mut raw_transcript = None;
    for optimized in [false, true] {
        let mut current = program.clone();
        if optimized {
            fwp::opt::optimize(&mut current);
        }
        fwp::ir::check_locals(&current).unwrap();
        let mut interpreter =
            fwp::interp::Interp::new(&current, Box::new(std::io::sink())).unwrap();
        let mut expected = String::new();
        let mut probe = String::from(
            r#"
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0 ||
        _setmode(_fileno(stderr), _O_BINARY) < 0) return 253;
#endif
    fwp_lib_init(); size_t before = fwp_heap.live;
"#,
        );
        for (name, bits, value, id) in &cases {
            let converted = interpreter.call_root(*id, vec![value.clone()]).unwrap();
            let output = match &converted {
                Value::F16(v) => u128::from(v.to_bits()),
                Value::BF16(v) => u128::from(v.to_bits()),
                Value::F32(v) => u128::from(v.to_bits()),
                Value::F64(v) => u128::from(v.to_bits()),
                Value::F128(v) => v.to_bits(),
                other => panic!("unexpected conversion result: {other:?}"),
            };
            assert_eq!(output, *bits, "{name} same-type conversion changed bits");
            let exported = &program.funcs[*id].name;
            writeln!(expected, "{exported} {bits:032x} {output:032x}").unwrap();
            let low = *bits as u64;
            let high = (*bits >> 64) as u64;
            let result = match *name {
                "F16" | "BF16" => format!(
                    "uint64_t lo = {exported}(UINT16_C(0x{low:04x})), hi = 0;"
                ),
                "F32" => format!(
                    "uint64_t lo = fwp_from_f32({exported}(fwp_f32(UINT32_C(0x{low:08x})))), hi = 0;"
                ),
                "F64" => format!(
                    "uint64_t lo = fwp_from_f64({exported}(fwp_f64(UINT64_C(0x{low:016x})))), hi = 0;"
                ),
                "F128" => format!(
                    "struct fwp_binary128 out = {exported}((struct fwp_binary128){{UINT64_C(0x{low:016x}),UINT64_C(0x{high:016x})}}); uint64_t lo = out.low, hi = out.high;"
                ),
                _ => unreachable!(),
            };
            writeln!(probe,
                "{{ {result} printf(\"{exported} {bits:032x} %016llx%016llx\\n\", (unsigned long long)hi, (unsigned long long)lo); }}"
            ).unwrap();
            probe.push_str("if (fwp_heap.live != before || fwp_heap.rc_wide_len) return 90;\n");
        }
        probe.push_str("return 0; }\n");
        if let Some(raw) = &raw_transcript {
            assert_eq!(&expected, raw, "optimizer changed conversion bits");
        } else {
            raw_transcript = Some(expected.clone());
        }
        let (generated, _) = fwp::cgen::generate_library(&current, "convert", &[]).unwrap();
        let source = format!("{generated}\n{probe}");
        for opt in ["-O1", "-O2"] {
            let executable = directory.join("convert.exe");
            fwp::cgen::compile_c(&source, &executable, opt).unwrap();
            let actual = Command::new(&executable).output().unwrap();
            record_probe::save(
                "float_formats",
                &format!("same-type-optimized-{optimized}{opt}"),
                &source,
                &executable,
                &actual,
            );
            if !actual.status.success()
                || !actual.stderr.is_empty()
                || actual.stdout != expected.as_bytes()
            {
                failures.push(format!(
                    "optimized={optimized} {opt}: {actual:?}; expected {expected}"
                ));
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn scalar_array_identity_moves_owners_and_preserves_aliases() {
    let scalar = MT::con("std::F64");
    let array = MT::Con("std::Array".into(), vec![scalar.clone()]);
    let conversion = MT::Fun(Box::new(scalar.clone()), Box::new(scalar.clone()));
    let mapping = MT::Fun(Box::new(array.clone()), Box::new(array.clone()));
    let option = MT::Con("std::Option".into(), vec![scalar.clone()]);
    let consuming = MT::Fun(Box::new(array.clone()), Box::new(option.clone()));
    let yielding = MT::Fun(Box::new(MT::unit()), Box::new(MT::unit()));
    let mut program = Program {
        funcs: vec![
            Func {
                name: "convert".into(),
                arity: 1,
                locals: vec![scalar],
                ty: conversion.clone(),
                body: Body::Prim("float.convert".into()),
            },
            Func {
                name: "map".into(),
                arity: 2,
                locals: vec![conversion.clone(), array.clone()],
                ty: MT::Fun(Box::new(conversion), Box::new(mapping.clone())),
                body: Body::Prim("array.map".into()),
            },
            Func {
                name: "identity-array".into(),
                arity: 1,
                locals: vec![array.clone()],
                ty: mapping.clone(),
                body: Body::Expr(Expr::Call(1, vec![Expr::Func(0), Expr::Local(0)])),
            },
            Func {
                name: "main".into(),
                arity: 0,
                locals: vec![],
                ty: MT::Record(vec![
                    ("0".into(), mapping),
                    ("1".into(), consuming.clone()),
                    ("2".into(), yielding.clone()),
                ]),
                // Keep owned entries and the real task/unwind execution mode.
                body: Body::Expr(Expr::Record(vec![
                    Expr::Func(2),
                    Expr::Func(5),
                    Expr::Func(6),
                ])),
            },
            Func {
                name: "get".into(),
                arity: 2,
                locals: vec![MT::con("std::I64"), array.clone()],
                ty: MT::Fun(Box::new(MT::con("std::I64")), Box::new(consuming.clone())),
                body: Body::Prim("array.get".into()),
            },
            Func {
                name: "consume-identity".into(),
                arity: 1,
                locals: vec![array],
                ty: consuming,
                body: Body::Expr(Expr::Call(
                    4,
                    vec![
                        Expr::Const(Value::I64(0)),
                        Expr::Call(2, vec![Expr::Local(0)]),
                    ],
                )),
            },
            Func {
                name: "yield".into(),
                arity: 1,
                locals: vec![MT::unit()],
                ty: yielding,
                body: Body::Prim("task.yield".into()),
            },
        ],
        main: Some(3),
        ..Program::default()
    };
    program.shapes.insert(
        option,
        TypeShape::Adt(vec![
            ("None".into(), vec![]),
            ("Some".into(), vec![MT::con("std::F64")]),
        ]),
    );
    fwp::ir::check_locals(&program).unwrap();
    let directory = fwp::cgen::TempDir::new("scalar-array-identity").unwrap();
    let mut failures = Vec::new();
    for selected in [false, true] {
        let mut current = program.clone();
        if selected {
            fwp::opt::optimize(&mut current);
            assert!(matches!(&current.funcs[2].body, Body::Expr(Expr::Local(0))));
        }
        fwp::ir::check_locals(&current).unwrap();
        let generated = fwp::cgen::generate(&current).unwrap();
        assert_eq!(
            generated.contains("/* consumed-scalar-array-map :"),
            !selected,
            "the identity rewrite removes the map; native ownership lowering consumes the remaining map"
        );
        assert!(
            generated.contains("#define FWP_UNWIND 1"),
            "fault probe needs a task-capable program"
        );
        let generated = generated.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let generated = ownership_ledger::instrument_native(&generated, 256);
        let generated = generated.replacen(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic size_t identity_retains;\nstatic int identity_fault;\nstatic void identity_fail(void);",
            1,
        );
        let generated = generated.replacen(
            "static inline void fwp_rc_dup(V v) {\n",
            "static inline void fwp_rc_dup(V v) {\n    identity_retains++;\n",
            1,
        );
        let boundary = "static V f4(V l0, V l1) {\n";
        assert_eq!(generated.matches(boundary).count(), 1);
        let generated = generated.replace(
            boundary,
            &format!("{boundary}    if (identity_fault) identity_fail();\n"),
        );
        for packed in [false, true] {
            let marker = if generated.contains("#define FWP_PACKED_ARRAYS 1") {
                "#define FWP_PACKED_ARRAYS 1"
            } else {
                "#define FWP_PACKED_ARRAYS 0"
            };
            assert_eq!(generated.matches(marker).count(), 1);
            let generated = generated.replace(
                marker,
                &format!("#define FWP_PACKED_ARRAYS {}", u8::from(packed)),
            );
            for reuse in [false, true] {
                let code = format!(
                    "{}\n{generated}\n#define IDENTITY_SELECTED {}\n#define IDENTITY_REUSE {}\n{}",
                    if reuse { "" } else { "#define FWP_NO_REUSE 1" },
                    u8::from(selected),
                    u8::from(reuse),
                    include_str!("fixtures/scalar_array_identity.c"),
                );
                for opt in ["-O1", "-O2"] {
                    let executable = directory.join("identity.exe");
                    fwp::cgen::compile_c(&code, &executable, opt).unwrap();
                    for (control, status, diagnostic) in [
                        ("complete", 0, ""),
                        ("missing-release", 90, ""),
                        ("allocation-failure", 102, "fwp: out of memory\n"),
                    ] {
                        let mut command = Command::new(&executable);
                        command.arg(control);
                        let actual = command.output().unwrap();
                        let label = format!("array-identity-{selected}-packed-{packed}-reuse-{reuse}{opt}-{control}");
                        record_probe::save("float_formats", &label, &code, &executable, &actual);
                        if actual.status.code() != Some(status)
                            || actual.stderr != diagnostic.as_bytes()
                        {
                            failures.push(format!("{label}: {actual:?}"));
                        }
                    }
                }
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn conversion_maps_preserve_source_evaluation_and_effects() {
    let directory = fwp::cgen::TempDir::new("conversion-map-order").unwrap();
    let source = directory.join("main.fwp");
    std::fs::write(&source, include_str!("fixtures/scalar_array_identity.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let raw = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(raw.status.success() && raw.stderr.is_empty(), "{raw:?}");
    assert_eq!(
        String::from_utf8_lossy(&raw.stdout)
            .matches("input\n")
            .count(),
        1
    );
    let interpreted = Command::new(compiler)
        .env_remove("FWP_NO_OPT")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        interpreted.status.success() && interpreted.stderr.is_empty(),
        "{interpreted:?}"
    );
    assert_eq!(interpreted.stdout, raw.stdout);
    let cfile = directory.join("main.c");
    let emitted = Command::new(compiler)
        .env_remove("FWP_NO_OPT")
        .env("FWP_LTO", "0")
        .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
        .arg(&source)
        .arg("-o")
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(emitted.status.success(), "{emitted:?}");
    let generated = std::fs::read_to_string(&cfile).unwrap();
    for opt in ["-O1", "-O2"] {
        let executable = directory.join("order.exe");
        fwp::cgen::compile_c(&generated, &executable, opt).unwrap();
        let actual = Command::new(&executable).output().unwrap();
        record_probe::save(
            "float_formats",
            &format!("conversion-map-order{opt}"),
            &generated,
            &executable,
            &actual,
        );
        assert!(
            actual.status.success() && actual.stderr.is_empty(),
            "{actual:?}"
        );
        assert_eq!(actual.stdout, raw.stdout);
    }
}
