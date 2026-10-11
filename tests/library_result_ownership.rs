//! C export results release their boxes without invalidating host strings.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

fn program() -> Program {
    let int = MT::con("std::I64");
    let string = MT::con("std::String");
    let ptr = MT::Con("std::Ptr".into(), vec![MT::con("std::U8")]);
    let option = MT::Con("std::Option".into(), vec![ptr.clone()]);
    let pair = MT::con("Pair");
    let text = MT::con("Text");
    let function = |name: &str, parameter: MT, result: MT, body: Expr| Func {
        name: name.into(),
        arity: 1,
        locals: vec![parameter.clone()],
        ty: MT::Fun(Box::new(parameter), Box::new(result)),
        body: Body::Expr(body),
    };
    let repeated = |s: &str| {
        Expr::Call(
            3,
            vec![
                Expr::Const(Value::I64(2)),
                Expr::Const(Value::Str(s.into())),
            ],
        )
    };
    let p = Program {
        funcs: vec![
            function(
                "pair",
                int.clone(),
                pair.clone(),
                Expr::Record(vec![Expr::Local(0), Expr::Local(0)]),
            ),
            function(
                "pointer",
                ptr.clone(),
                option.clone(),
                Expr::Construct(1, vec![Expr::Local(0)]),
            ),
            function(
                "text",
                int.clone(),
                text.clone(),
                Expr::Record(vec![Expr::Local(0), repeated("hi")]),
            ),
            Func {
                name: "repeat".into(),
                arity: 2,
                locals: vec![int.clone(), string.clone()],
                ty: MT::Fun(
                    Box::new(int.clone()),
                    Box::new(MT::Fun(Box::new(string.clone()), Box::new(string.clone()))),
                ),
                body: Body::Prim("string.repeat".into()),
            },
            function(
                "bad",
                int.clone(),
                text.clone(),
                Expr::Record(vec![Expr::Local(0), repeated("bad\0text")]),
            ),
            Func {
                name: "cached".into(),
                arity: 0,
                locals: vec![],
                ty: pair.clone(),
                body: Body::Expr(Expr::Record(vec![
                    Expr::Const(Value::I64(17)),
                    Expr::Const(Value::I64(42)),
                ])),
            },
            function("string", int.clone(), string.clone(), repeated("ok")),
            function(
                "bad-string",
                int.clone(),
                string.clone(),
                repeated("bad\0text"),
            ),
        ],
        shapes: [
            (
                pair,
                TypeShape::Record(vec![("a".into(), int.clone()), ("b".into(), int.clone())]),
            ),
            (
                text,
                TypeShape::Record(vec![("number".into(), int), ("text".into(), string)]),
            ),
            (
                option,
                TypeShape::Adt(vec![("None".into(), vec![]), ("Some".into(), vec![ptr])]),
            ),
        ]
        .into(),
        repr_c: [
            ("Pair".into(), vec!["a".into(), "b".into()]),
            ("Text".into(), vec!["number".into(), "text".into()]),
        ]
        .into(),
        exports: [
            ("pair", 0),
            ("pointer", 1),
            ("text", 2),
            ("bad", 4),
            ("cached", 5),
            ("string", 6),
            ("bad_string", 7),
        ]
        .into_iter()
        .map(|(n, f)| (n.into(), f))
        .collect(),
        ..Program::default()
    };
    fwp::ir::check_locals(&p).unwrap();
    p
}

#[test]
fn exported_boxes_are_reclaimed_and_host_strings_survive() {
    let program = program();
    let mut interp = fwp::interp::Interp::new(&program, Box::new(Vec::new()));
    assert_eq!(
        interp.call(0, vec![Value::I64(17)]).unwrap(),
        Value::Record(vec![Value::I64(17), Value::I64(17)].into())
    );
    assert_eq!(
        interp.call(2, vec![Value::I64(17)]).unwrap(),
        Value::Record(vec![Value::I64(17), Value::Str("hihi".into())].into())
    );
    assert_eq!(
        interp.call(5, vec![]).unwrap(),
        Value::Record(vec![Value::I64(17), Value::I64(42)].into())
    );
    assert_eq!(
        interp.call(6, vec![Value::I64(0)]).unwrap(),
        Value::Str("okok".into())
    );
    let (source, _) = fwp::cgen::generate_library(&program, "ownership").unwrap();
    let observed = source
        .replace("static V fwp_data(uint32_t", "static V observed_data, observed_string; static size_t data_calls;\nstatic V fwp_data(uint32_t")
        .replacen("return PTR(o);", "data_calls++; observed_data = PTR(o); return PTR(o);", 1)
        .replacen("return PTR(r);", "observed_string = PTR(r); return PTR(r);", 1);
    let probe = r#"
static jmp_buf failure; static int recover(void) { return 1; }
static int dead(V v) { return fwp_reuse_verify ? OBJ(v)->tag == 0xdead : *fwp_rc_slot(v) == 0; }
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len == 0 : *fwp_rc_slot(v) == 0; }
int main(void) {
 fwp_lib_init();
 V bits = fwp_rc_fresh(fwp_str_new("bits",4));
 struct fwp_c_Pair p = pair((int64_t)bits);
 if(p.a != (int64_t)bits || p.b != (int64_t)bits || !dead(observed_data)) return 1;
 if(*fwp_rc_slot(bits) != 1) return 2;
 size_t before = data_calls;
 void *raw = pointer((void *)(uintptr_t)bits);
 if(data_calls != before + 1) return 11;
 if(raw != (void *)(uintptr_t)bits || !dead(observed_data)) return 3;
 if(*fwp_rc_slot(bits) != 1) return 2;
 const char *held = string(0);
 struct fwp_c_Text t = text(17);
 if(t.number != 17 || strcmp(t.text,"hihi") || !dead(observed_data)) return 5;
 if(*fwp_rc_slot(observed_string) != 0 || strcmp(held,"okok")) return 6;
 for(int i=0; i<1000; i++) { p=cached(); if(p.a!=17 || p.b!=42 || *fwp_rc_slot(observed_data)!=1) return 7; }
 fwp_cleanup *boundary = fwp_cleanups;
 fwp_trap_recover=recover; fwp_trap_jb=&failure; fwp_trap_cleanup=boundary;
 if(setjmp(failure)==0) { (void)bad(0); return 8; }
 if(fwp_cleanups!=boundary || !dead(observed_data) || !dead_string(observed_string)) return 4;
 if(setjmp(failure)==0) { (void)bad_string(0); return 8; }
 if(fwp_cleanups!=boundary || !dead_string(observed_string)) return 4;
 fwp_trap_recover=0; fwp_trap_jb=0;
 if(strcmp(held,"okok") || strcmp(t.text,"hihi") || fwp_gc.armed || fwp_gc.ncollect) return 9;
 if(!fwp_reuse_verify && fwp_gc.freed < 32) return 10;
 return 0;
}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-library-results-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{observed}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .env("FWP_REUSE_VERIFY", poison)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "{opt}, poison {poison}: {:?}: {}",
                out.status.code(),
                String::from_utf8_lossy(&out.stderr)
            );
        }
        let missing_drop = observed.replace("owner.value = result; fwp_value_release(&owner);", "");
        let missing_share = observed.replace("    fwp_rc_share(result);\n", "");
        let extra_evaluation = observed.replace(
            "    V result = f1(input_arg0);",
            "    V result = f1(input_arg0); (void)f1(input_arg0);",
        );
        let bad_start = observed.find("struct fwp_c_Text bad(int64_t a0)").unwrap();
        let mut missing_guard = observed.clone();
        let guard = bad_start
            + observed[bad_start..]
                .find("    fwp_value_protect(&owner, &cleanup);")
                .unwrap();
        missing_guard.replace_range(
            guard..guard + "    fwp_value_protect(&owner, &cleanup);".len(),
            "",
        );
        for (broken, expected) in [
            (missing_drop, 1),
            (missing_share, 6),
            (missing_guard, 4),
            (extra_evaluation, 11),
        ] {
            assert_ne!(
                broken, observed,
                "negative control must change generated code"
            );
            fwp::cgen::compile_c(&format!("{broken}\n{probe}"), &exe, opt).unwrap();
            let out = Command::new(&exe)
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "negative control: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
