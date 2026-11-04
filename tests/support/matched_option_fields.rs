//! Direct optional fields must own their payload and avoid only the wrapper.
use super::{ownership_ledger, record_probe};
use fwp::ir::{Body, Expr, Func, Pat, Program, TypeShape, MT};
use fwp::value::Value;
use std::process::Command;

fn function(parameters: &[MT], result: MT) -> MT {
    parameters.iter().rev().fold(result, |body, parameter| {
        MT::Fun(Box::new(parameter.clone()), Box::new(body))
    })
}

fn choose(option: u32, payload: u32, otherwise: u32) -> Expr {
    Expr::Match(
        Box::new(Expr::Local(option)),
        vec![
            (Pat::Construct(0, vec![]), Expr::Local(otherwise)),
            (
                Pat::Construct(1, vec![Pat::Bind(payload)]),
                Expr::Local(payload),
            ),
        ],
    )
}

fn program(element: &MT, iteration: bool) -> Program {
    let integer = MT::con("std::I64");
    let list = MT::Con("std::List".into(), vec![element.clone()]);
    let option = MT::Con("std::Option".into(), vec![element.clone()]);
    let mut program = Program::default();
    program.shapes.insert(
        list.clone(),
        TypeShape::Adt(vec![
            ("Nil".into(), vec![]),
            ("Cons".into(), vec![element.clone(), list.clone()]),
        ]),
    );
    program.shapes.insert(
        option.clone(),
        TypeShape::Adt(vec![
            ("None".into(), vec![]),
            ("Some".into(), vec![element.clone()]),
        ]),
    );
    program.funcs = vec![
        Func {
            name: "pick-nth".into(),
            arity: 3,
            locals: vec![
                integer.clone(),
                list.clone(),
                element.clone(),
                option.clone(),
                element.clone(),
            ],
            ty: function(
                &[integer.clone(), list.clone(), element.clone()],
                element.clone(),
            ),
            body: Body::Expr(Expr::Let(
                3,
                Box::new(Expr::Call(2, vec![Expr::Local(0), Expr::Local(1)])),
                Box::new(choose(3, 4, 2)),
            )),
        },
        Func {
            name: "pick-last".into(),
            arity: 2,
            locals: vec![
                list.clone(),
                element.clone(),
                option.clone(),
                element.clone(),
            ],
            ty: function(&[list.clone(), element.clone()], element.clone()),
            body: Body::Expr(Expr::Let(
                2,
                Box::new(Expr::Call(3, vec![Expr::Local(0)])),
                Box::new(choose(2, 3, 1)),
            )),
        },
        Func {
            name: "nth".into(),
            arity: 2,
            locals: vec![integer.clone(), list.clone()],
            ty: function(&[integer.clone(), list.clone()], option.clone()),
            body: Body::Prim("nth".into()),
        },
        Func {
            name: "last".into(),
            arity: 1,
            locals: vec![list.clone()],
            ty: function(std::slice::from_ref(&list), option.clone()),
            body: Body::Prim("last".into()),
        },
        Func {
            name: "drop-element".into(),
            arity: 1,
            locals: vec![element.clone()],
            ty: function(std::slice::from_ref(element), MT::unit()),
            body: Body::Expr(Expr::Const(Value::unit())),
        },
        Func {
            name: "drop-list".into(),
            arity: 1,
            locals: vec![list.clone()],
            ty: function(std::slice::from_ref(&list), MT::unit()),
            body: Body::Expr(Expr::Const(Value::unit())),
        },
        Func {
            name: "checkpoint".into(),
            arity: 1,
            locals: vec![MT::unit()],
            ty: function(&[MT::unit()], MT::unit()),
            body: Body::Prim("task.yield".into()),
        },
    ];
    if iteration {
        let callback = function(std::slice::from_ref(element), element.clone());
        program.funcs.extend([
            Func {
                name: "final-iteration".into(),
                arity: 3,
                locals: vec![integer.clone(), callback.clone(), element.clone()],
                ty: function(
                    &[integer.clone(), callback.clone(), element.clone()],
                    option.clone(),
                ),
                body: Body::Prim("list._iterate-last".into()),
            },
            Func {
                name: "pick-iteration".into(),
                arity: 4,
                locals: vec![
                    integer.clone(),
                    callback.clone(),
                    element.clone(),
                    element.clone(),
                    option,
                    element.clone(),
                ],
                ty: function(
                    &[integer, callback.clone(), element.clone(), element.clone()],
                    element.clone(),
                ),
                body: Body::Expr(Expr::Let(
                    4,
                    Box::new(Expr::Call(
                        7,
                        vec![Expr::Local(0), Expr::Local(1), Expr::Local(2)],
                    )),
                    Box::new(choose(4, 5, 3)),
                )),
            },
            Func {
                name: "identity".into(),
                arity: 1,
                locals: vec![element.clone(), MT::unit()],
                ty: callback,
                body: Body::Expr(Expr::Let(
                    1,
                    Box::new(Expr::Call(6, vec![Expr::Const(Value::unit())])),
                    Box::new(Expr::Local(0)),
                )),
            },
        ]);
    }
    let entry = program.funcs.len();
    let types = program
        .funcs
        .iter()
        .enumerate()
        .map(|(i, f)| (i.to_string(), f.ty.clone()))
        .collect();
    program.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![MT::unit()],
        ty: MT::Record(types),
        body: Body::Expr(Expr::Let(
            0,
            Box::new(Expr::Call(6, vec![Expr::Const(Value::unit())])),
            Box::new(Expr::Record((0..entry).map(Expr::Func).collect())),
        )),
    });
    program.main = Some(entry);
    program
}

#[test]
fn matched_results_move_or_retain_the_right_owner_without_a_wrapper() {
    let directory = fwp::cgen::TempDir::new("fwp-option-fields").unwrap();
    let cases = [
        (
            "scalar",
            "std::F64",
            true,
            false,
            r#"
static V field_new(int seed) { return seed ? UINT64_C(0xfff8000000000040) + seed : 0; }
static int field_check(V value, int seed) { return value == field_new(seed); }
"#,
        ),
        (
            "string",
            "std::String",
            false,
            true,
            r#"
static V field_new(int seed) { char text = 'a' + seed; return fwp_rc_fresh(fwp_str_new(&text, 1)); }
static int field_check(V value, int seed) { return STR(value)->len == 1 && STR(value)->d[0] == 'a' + seed; }
"#,
        ),
        (
            "quad",
            "std::F128",
            true,
            true,
            r#"
static V field_new(int seed) {
    float128_t bits = {{UINT64_C(0x123456789abcdef0) + seed, UINT64_C(0xffff000000000000)}};
    return fwp_rc_fresh(fwp_box_f128(bits));
}
static int field_check(V value, int seed) {
    float128_t bits = fwp_f128(value);
    return bits.v[0] == UINT64_C(0x123456789abcdef0) + seed && bits.v[1] == UINT64_C(0xffff000000000000);
}
"#,
        ),
        (
            "file",
            "std::File",
            false,
            true,
            r#"
static V field_new(int seed) {
    V path = fwp_rc_fresh(fwp_cstr(field_path));
    V handle = fwp_p_file_open(path, 1, NULL);
    fwp_rc_free_obj(path);
    if (fseek(((fwp_file *)(uintptr_t)handle)->f, seed, SEEK_SET)) _Exit(96);
    return handle;
}
static int field_check(V value, int seed) {
    fwp_file *file = (fwp_file *)(uintptr_t)value;
    return file->refs && file->f && ftell(file->f) == seed;
}
"#,
        ),
    ];
    let mut failures = Vec::new();
    for (label, ty, iteration, counted, construction) in cases {
        let program = program(&MT::con(ty), iteration);
        fwp::ir::check_locals(&program).unwrap();
        let code = fwp::cgen::generate(&program).unwrap();
        assert!(code.contains("#define FWP_UNWIND 1"));
        assert!(
            code.contains(" = fwp_list_last_fields(") && code.contains(" = fwp_list_nth_fields(")
        );
        let code = code.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let code = ownership_ledger::instrument_native(&code, 128);
        let code = code.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int field_corrupt_tag, field_fail_box;\nstatic void fwp_trap(const char *);\nstatic V field_checkpoint(V);")
            .replace("return (fwp_option_result){1, OBJ(xs)->f[0]};", "return (fwp_option_result){!field_corrupt_tag, OBJ(xs)->f[0]};");
        let some = "static inline V fwp_some(V x) { return fwp_data(1, 1, &x); }";
        assert_eq!(code.matches(some).count(), 1);
        let mut code = code.replace(some, "static inline V fwp_some(V x) { if (field_fail_box) fwp_trap(\"injected option boxing failure\"); return fwp_data(1, 1, &x); }");
        let start = code.find("static V f6(V l0) {\n").unwrap();
        let end = start + code[start..].find("\n}").unwrap() + 2;
        code.replace_range(
            start..end,
            "static V f6(V l0) { return field_checkpoint(l0); }",
        );
        let emitted = format!("{code}\n#define FIELD_ITERATION {}\n#define FIELD_COUNTED {}\n#define FIELD_RESOURCE {}\nstatic const char *field_path;\n{construction}\n{}",
            u8::from(iteration), u8::from(counted), u8::from(label == "file"), include_str!("../fixtures/matched_option_fields.c"));
        for opt in ["-O1", "-O2"] {
            let binary = directory.join("fields.exe");
            fwp::cgen::compile_c(&emitted, &binary, opt).unwrap();
            let mut controls = vec![("complete", 0), ("corrupt-tag", 82)];
            if counted {
                controls.push(("missing-release", 90));
            }
            for (control, status) in controls {
                let output = Command::new(&binary)
                    .arg(control)
                    .arg(directory.join("file.dat"))
                    .output()
                    .unwrap();
                record_probe::save(
                    "iteration_consumers",
                    &format!("option-fields-{label}{opt}-{control}"),
                    &emitted,
                    &binary,
                    &output,
                );
                if output.status.code() != Some(status) || !output.stderr.is_empty() {
                    failures.push(format!("{label}/{opt}/{control}: {output:?}"));
                }
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn matched_option_source_preserves_values_effects_and_representation_controls() {
    let directory = fwp::cgen::TempDir::new("fwp-option-field-source").unwrap();
    let source = directory.join("fields.fwp");
    std::fs::write(
        &source,
        include_str!("../fixtures/matched_option_fields.fwp"),
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        reference.status.success() && reference.stderr.is_empty(),
        "{reference:?}"
    );
    let interpreted = Command::new(compiler)
        .env_remove("FWP_NO_OPT")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert_eq!(interpreted.status.code(), reference.status.code());
    assert_eq!(interpreted.stdout, reference.stdout);
    assert_eq!(interpreted.stderr, reference.stderr);
    let mut failures = Vec::new();
    for (label, variants, frames, packed, no_reuse) in [
        ("boxed", "0", "1", "1", "0"),
        ("fields", "1", "1", "1", "0"),
        ("separate-storage", "1", "0", "0", "1"),
    ] {
        let cfile = directory.join(format!("{label}.c"));
        let built = Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .env("FWP_VRET", variants)
            .env("FWP_FRAME_FIELDS", frames)
            .env("FWP_PACKED_ARRAYS", packed)
            .env("FWP_NO_REUSE", no_reuse)
            .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        if !built.status.success() {
            failures.push(format!("{label}/build: {built:?}"));
            continue;
        }
        let code = std::fs::read_to_string(&cfile).unwrap();
        let code = if no_reuse == "1" {
            format!("#define FWP_NO_REUSE 1\n{code}")
        } else {
            code
        };
        for opt in ["-O1", "-O2"] {
            let binary = directory.join(format!("{label}{opt}.exe"));
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let observed = Command::new(&binary).output().unwrap();
            record_probe::save(
                "iteration_consumers",
                &format!("option-fields-source-{label}{opt}"),
                &code,
                &binary,
                &observed,
            );
            if observed.status.code() != reference.status.code()
                || observed.stdout != reference.stdout
                || observed.stderr != reference.stderr
            {
                failures.push(format!("{label}/{opt}: {observed:?}"));
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}
