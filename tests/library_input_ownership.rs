//! Typed C library input copies and partial preparation own their allocations.
use fwp::ir::*;
use fwp::value::Value;
use std::process::Command;

fn program() -> Program {
    let int = MT::con("std::I64");
    let string = MT::con("std::String");
    let ptr = MT::Con("std::Ptr".into(), vec![MT::con("std::U8")]);
    let option = MT::Con("std::Option".into(), vec![ptr.clone()]);
    let input = MT::con("Input");
    let make = |name: &str, params: Vec<MT>, result: MT, body: Body| Func {
        name: name.into(),
        arity: params.len() as u32,
        locals: params.clone(),
        ty: params
            .into_iter()
            .rev()
            .fold(result, |r, p| MT::Fun(Box::new(p), Box::new(r))),
        body,
    };
    let p = Program {
        funcs: vec![
            make(
                "length",
                vec![string.clone()],
                int.clone(),
                Body::Prim("string.length".into()),
            ),
            make(
                "wrapped",
                vec![string.clone()],
                int.clone(),
                Body::Expr(Expr::Call(0, vec![Expr::Local(0)])),
            ),
            make(
                "identity",
                vec![string.clone()],
                string.clone(),
                Body::Expr(Expr::Local(0)),
            ),
            make(
                "record-length",
                vec![input.clone()],
                int.clone(),
                Body::Expr(Expr::Call(
                    0,
                    vec![Expr::Field(Box::new(Expr::Local(0)), 1)],
                )),
            ),
            make(
                "record-alias",
                vec![input.clone()],
                input.clone(),
                Body::Expr(Expr::Local(0)),
            ),
            make(
                "second",
                vec![string.clone(), string.clone()],
                string.clone(),
                Body::Expr(Expr::Local(1)),
            ),
            make(
                "prepare",
                vec![string.clone(), input.clone()],
                int.clone(),
                Body::Expr(Expr::Const(Value::I64(42))),
            ),
            make("some", vec![ptr.clone()], option.clone(), Body::Ctor(1)),
            make(
                "repeat",
                vec![int.clone(), string.clone()],
                string.clone(),
                Body::Prim("string.repeat".into()),
            ),
            make(
                "trap",
                vec![string.clone()],
                int.clone(),
                Body::Expr(Expr::Call(
                    10,
                    vec![Expr::Const(Value::I64(0)), Expr::Const(Value::I64(1))],
                )),
            ),
            make(
                "divide",
                vec![int.clone(), int.clone()],
                int.clone(),
                Body::Prim("prim.div".into()),
            ),
            make(
                "optional",
                vec![option.clone()],
                option.clone(),
                Body::Expr(Expr::Local(0)),
            ),
            make(
                "discard",
                vec![string.clone()],
                MT::unit(),
                Body::Expr(Expr::Record(vec![])),
            ),
            make(
                "print-line",
                vec![string.clone()],
                MT::unit(),
                Body::Prim("print".into()),
            ),
        ],
        shapes: [
            (
                input,
                TypeShape::Record(vec![
                    ("p".into(), option.clone()),
                    ("s".into(), string.clone()),
                    ("t".into(), string),
                    ("word".into(), int),
                ]),
            ),
            (
                option,
                TypeShape::Adt(vec![("None".into(), vec![]), ("Some".into(), vec![ptr])]),
            ),
        ]
        .into(),
        // C declaration order differs from the canonical record order.
        repr_c: [(
            "Input".into(),
            vec!["word".into(), "p".into(), "s".into(), "t".into()],
        )]
        .into(),
        exports: [
            ("length", 0),
            ("wrapped", 1),
            ("identity", 2),
            ("record_length", 3),
            ("record_alias", 4),
            ("second", 5),
            ("prepare", 6),
            ("some", 7),
            ("repeat", 8),
            ("trap", 9),
            ("optional", 11),
            ("discard", 12),
            ("print_line", 13),
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
fn library_input_copies_transfer_or_release_exactly_once() {
    let p = program();
    let mut interp = fwp::interp::Interp::new(&p, Box::new(Vec::new()));
    assert_eq!(
        interp.call(0, vec![Value::Str("héllo".into())]).unwrap(),
        Value::I64(5)
    );
    assert_eq!(
        interp.call(1, vec![Value::Str("héllo".into())]).unwrap(),
        Value::I64(5)
    );
    assert_eq!(
        interp
            .call(
                5,
                vec![Value::Str("first".into()), Value::Str("second".into())]
            )
            .unwrap(),
        Value::Str("second".into())
    );
    assert!(interp.call(9, vec![Value::Str("prior".into())]).is_err());
    let (source, _) = fwp::cgen::generate_library(&p, "inputs").unwrap();
    let observed = source
        .replace("static V fwp_data(uint32_t", "static V strings[32], data[32]; static unsigned drops[32]; static int ns, nd, fail_record;\nstatic V fwp_data(uint32_t")
        .replacen("return PTR(o);", "if(nd<32) data[nd++]=PTR(o); return PTR(o);", 1)
        .replacen("return PTR(r);", "if(ns<32) strings[ns++]=PTR(r); return PTR(r);", 1)
        .replace("static V fwp_record(uint32_t n, const V *f) {", "static void fwp_trap(const char *);\nstatic V fwp_record(uint32_t n, const V *f) { if(fail_record){fail_record=0;fwp_trap(\"injected record allocation failure\");}")
        .replace("/* ---- program ---- */", "static void observe_drop(V v) { for(int i=0;i<ns;i++)if(strings[i]==v)drops[i]++; }\n/* ---- program ---- */")
        .replace("if (!fwp_rc_release_last(v)) return;", "observe_drop(v); if (!fwp_rc_release_last(v)) return;");
    let probe = r#"
static jmp_buf failure; static int recover(void) { return 1; }
static void reset(void){ns=nd=0;memset(drops,0,sizeof drops);}
static int dead_string(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
static int dead_data(V v){return fwp_reuse_verify?OBJ(v)->tag==0xdead:*fwp_rc_slot(v)==0;}
static int strings_released_once(void){for(int i=0;i<ns;i++)if(!dead_string(strings[i])||drops[i]!=1)return 0;return 1;}
static int data_released(void){for(int i=0;i<nd;i++)if(!dead_data(data[i]))return 0;return 1;}
int main(void){
 fwp_lib_init(); V bits=fwp_rc_fresh(fwp_str_new("bits",4));
 reset(); double freed=fwp_gc.freed;
 if(length("héllo")!=5||ns!=1||!strings_released_once())return 1;
 if(!fwp_reuse_verify&&fwp_gc.freed<=freed)return 1;
 reset(); if(wrapped("héllo")!=5||ns!=1||!strings_released_once())return 2;
 reset(); const char *held=identity("host");
 if(strcmp(held,"host")||ns!=1||*fwp_rc_slot(strings[0])!=0)return 3;
 struct fwp_c_Input input={.word=(int64_t)bits,.p=(void *)(uintptr_t)bits,.s="first",.t="second"};
 reset(); if(record_length(input)!=5||ns!=2||nd!=2||!data_released())return 4;
 for(int i=0;i<ns;i++)if(!dead_string(strings[i]))return 4;
 if(*fwp_rc_slot(bits)!=1)return 5;
 reset(); struct fwp_c_Input alias=record_alias(input);
 if(alias.word!=(int64_t)bits||alias.p!=(void *)(uintptr_t)bits||strcmp(alias.s,"first")||strcmp(alias.t,"second")||ns!=2||nd!=3||!data_released())return 6;
 for(int i=0;i<ns;i++)if(*fwp_rc_slot(strings[i])!=0)return 6;
 if(*fwp_rc_slot(bits)!=1)return 5;
 reset(); const char *second_host=second("first","second");
 if(strcmp(second_host,"second")||ns!=2||!dead_string(strings[0])||drops[0]!=1||*fwp_rc_slot(strings[1])!=0)return 7;
 reset(); const char *grown=repeat(2,"hi");
 if(strcmp(grown,"hihi")||ns!=2||!dead_string(strings[0])||drops[0]!=1)return 8;
 reset(); if(prepare("prior",input)!=42||ns!=3||nd!=2||!data_released())return 9;
 // The record worker duplicates fields, then releases them and their box.
 if(drops[0]!=1||drops[1]!=2||drops[2]!=2)return 9;
 for(int i=0;i<ns;i++)if(!dead_string(strings[i]))return 9;
 fwp_cleanup *boundary=fwp_cleanups;
 fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=boundary;
 reset(); if(setjmp(failure)==0){(void)second("prior",NULL);return 20;}
 if(fwp_cleanups!=boundary||ns!=1||!strings_released_once())return 11;
 reset(); input.t="\xff";
 if(setjmp(failure)==0){(void)prepare("prior",input);return 21;}
 if(fwp_cleanups!=boundary||ns!=2||nd!=1||!strings_released_once()||!data_released())return 12;
 reset(); input.t="second"; fail_record=1;
 if(setjmp(failure)==0){(void)prepare("prior",input);return 22;}
 if(fwp_cleanups!=boundary||ns!=3||nd!=1||!strings_released_once()||!data_released())return 13;
 reset(); if(setjmp(failure)==0){(void)trap("prior");return 23;}
 if(fwp_cleanups!=boundary||ns!=1||!strings_released_once())return 14;
 fwp_trap_recover=0;fwp_trap_jb=0;
 reset(); if(some((void *)(uintptr_t)bits)!=(void *)(uintptr_t)bits||!data_released()||*fwp_rc_slot(bits)!=1)return 15;
 if(some(NULL)!=NULL)return 15;
 reset(); if(optional((void *)(uintptr_t)bits)!=(void *)(uintptr_t)bits||!nd||!data_released()||*fwp_rc_slot(bits)!=1)return 17;
 reset(); if(optional(NULL)!=NULL||nd)return 17;
 reset(); discard("discard");if(ns!=1||!strings_released_once())return 18;
 reset(); print_line("unit");if(ns!=1||!strings_released_once())return 19;
 if(strcmp(held,"host")||strcmp(second_host,"second")||strcmp(alias.s,"first")||strcmp(alias.t,"second")||fwp_gc.armed||fwp_gc.ncollect)return 16;
 return 0;
}
"#;
    let dir = std::env::temp_dir().join(format!("fwp-library-input-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let exe = dir.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{observed}\n{probe}"), &exe, opt).unwrap();
        for poison in ["1", "0"] {
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
        let missing_release = observed.replace("inputs_cleanup.release(inputs_cleanup.arg);", "");
        let wrapped = observed.find("int64_t wrapped(const char * a0)").unwrap();
        let transfer = wrapped
            + observed[wrapped..]
                .find("    inputs_owner.v0 = 0;")
                .unwrap();
        let mut missing_transfer = observed.clone();
        missing_transfer.replace_range(transfer..transfer + "    inputs_owner.v0 = 0;".len(), "");
        let second = observed
            .find("const char * second(const char * a0, const char * a1)")
            .unwrap();
        let argument = second
            + observed[second..]
                .find("    inputs_owner.v0 = input_arg0;")
                .unwrap();
        let mut missing_argument = observed.clone();
        missing_argument.replace_range(
            argument..argument + "    inputs_owner.v0 = input_arg0;".len(),
            "",
        );
        let missing_field =
            observed.replace("    input_arg1_fields_owner.v1 = input_arg1_fields[1];", "");
        for (broken, expected) in [
            (missing_release, 1),
            (missing_transfer, 2),
            (missing_argument, 11),
            (missing_field, 12),
        ] {
            assert_ne!(broken, observed, "negative control must change code");
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

#[test]
fn byte_pointer_export_parameters_report_the_missing_length() {
    let f = Func {
        name: "size".into(),
        arity: 1,
        locals: vec![MT::con("std::Bytes")],
        ty: MT::Fun(
            Box::new(MT::con("std::Bytes")),
            Box::new(MT::con("std::I64")),
        ),
        body: Body::Prim("bytes.length".into()),
    };
    let p = Program {
        funcs: vec![f],
        exports: vec![("size".into(), 0)],
        ..Program::default()
    };
    // Ordinary foreign C calls can still receive a byte payload pointer.
    assert_eq!(
        fwp::ffi::signature(&p, &p.funcs[0]).unwrap().0[0].1,
        fwp::ffi::CType::Bytes
    );
    assert_eq!(
        fwp::cgen::generate_library(&p, "bytes").unwrap_err(),
        "exported function `size`: `Bytes` parameters have no length in the C export ABI"
    );
}
