//! Record locals can move directly between compatible worker ABIs.
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[test]
fn recursive_record_workers_keep_results_unboxed() {
    let dir =
        Scratch(std::env::temp_dir().join(format!("fwp-unboxed-worker-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let source =
        std::fs::read_to_string(concat!(env!("CARGO_MANIFEST_DIR"), "/tests/stack/wide.fwp"))
            .unwrap()
            .replace("range 0 300", "range 0 3")
            .replace("const 20000", "const 30");
    let src = dir.0.join("wide.fwp");
    std::fs::write(&src, source).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1"),
    );
    assert_eq!(reference.stdout, b"1395\n");
    let cfile = dir.0.join("wide.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let generated = std::fs::read_to_string(cfile).unwrap();
    let start = generated.find("/* stats :").unwrap();
    let end = start + generated[start..].find("\n}\n").unwrap();
    assert!(
        !generated[start..end].contains("fwp_record("),
        "recursive worker boxed a returned record"
    );
    let exe = dir.0.join("wide");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&generated, &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let native = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(native.stdout, reference.stdout);
        }
    }
}

#[test]
fn transferred_record_fields_preserve_aliases_and_trap_cleanup() {
    use fwp::ir::*;
    use fwp::value::Value;
    fn fun(args: &[MT], ret: MT) -> MT {
        args.iter()
            .rev()
            .fold(ret, |r, a| MT::Fun(Box::new(a.clone()), Box::new(r)))
    }
    let string = MT::con("std::String");
    let int = MT::con("std::I64");
    let payload = MT::con("Payload");
    let pair = MT::Record(vec![
        ("0".into(), string.clone()),
        ("1".into(), string.clone()),
    ]);
    let mut p = Program::default();
    p.shapes.insert(
        payload.clone(),
        TypeShape::Record(vec![
            ("text".into(), string.clone()),
            ("word".into(), int.clone()),
            ("a".into(), int.clone()),
            ("b".into(), int.clone()),
            ("c".into(), int.clone()),
            ("d".into(), int.clone()),
        ]),
    );
    p.funcs.push(Func {
        name: "maker".into(),
        arity: 2,
        locals: vec![string.clone(), int.clone()],
        ty: fun(&[string.clone(), int.clone()], payload.clone()),
        body: Body::Expr(Expr::Record(vec![
            Expr::Local(0),
            Expr::Local(1),
            Expr::Const(Value::I64(1)),
            Expr::Const(Value::I64(2)),
            Expr::Const(Value::I64(3)),
            Expr::Const(Value::I64(4)),
        ])),
    });
    p.funcs.push(Func {
        name: "take".into(),
        arity: 1,
        locals: vec![payload.clone()],
        ty: fun(std::slice::from_ref(&payload), string.clone()),
        body: Body::Expr(Expr::Field(Box::new(Expr::Local(0)), 0)),
    });
    let transfer = |id| {
        Expr::Let(
            2,
            Box::new(Expr::Call(0, vec![Expr::Local(0), Expr::Local(1)])),
            Box::new(Expr::Call(id, vec![Expr::Local(2)])),
        )
    };
    p.funcs.push(Func {
        name: "transfer".into(),
        arity: 2,
        locals: vec![string.clone(), int.clone(), payload.clone()],
        ty: fun(&[string.clone(), int.clone()], string.clone()),
        body: Body::Expr(transfer(1)),
    });
    p.funcs.push(Func {
        name: "aliases".into(),
        arity: 2,
        locals: vec![string.clone(), int.clone(), payload.clone()],
        ty: fun(&[string.clone(), int.clone()], pair),
        body: Body::Expr(Expr::Let(
            2,
            Box::new(Expr::Call(0, vec![Expr::Local(0), Expr::Local(1)])),
            Box::new(Expr::Record(vec![
                Expr::Call(1, vec![Expr::Local(2)]),
                Expr::Field(Box::new(Expr::Local(2)), 0),
            ])),
        )),
    });
    p.funcs.push(Func {
        name: "divide".into(),
        arity: 2,
        locals: vec![int.clone(), int.clone()],
        ty: fun(&[int.clone(), int.clone()], int.clone()),
        body: Body::Prim("prim.div".into()),
    });
    p.funcs.push(Func {
        name: "fail".into(),
        arity: 1,
        locals: vec![payload.clone(), int.clone()],
        ty: fun(std::slice::from_ref(&payload), string.clone()),
        body: Body::Expr(Expr::Let(
            1,
            Box::new(Expr::Call(
                4,
                vec![Expr::Const(Value::I64(0)), Expr::Const(Value::I64(1))],
            )),
            Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)),
        )),
    });
    p.funcs.push(Func {
        name: "fail_transfer".into(),
        arity: 2,
        locals: vec![string.clone(), int.clone(), payload.clone()],
        ty: fun(&[string.clone(), int.clone()], string.clone()),
        body: Body::Expr(transfer(5)),
    });
    p.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![],
        ty: string.clone(),
        body: Body::Expr(Expr::Call(
            2,
            vec![
                Expr::Const(Value::Str("hello".into())),
                Expr::Const(Value::I64(0)),
            ],
        )),
    });
    p.funcs.push(Func {
        name: "partial".into(),
        arity: 2,
        locals: vec![string.clone(), int.clone(), payload.clone()],
        ty: fun(
            &[string.clone(), int.clone()],
            fun(std::slice::from_ref(&int), string.clone()),
        ),
        body: Body::Expr(Expr::Let(
            2,
            Box::new(Expr::Call(0, vec![Expr::Local(0), Expr::Local(1)])),
            Box::new(Expr::Apply(Box::new(Expr::Func(9)), vec![Expr::Local(2)])),
        )),
    });
    p.funcs.push(Func {
        name: "partial_target".into(),
        arity: 2,
        locals: vec![payload, int.clone()],
        ty: fun(&[MT::con("Payload"), int], string),
        body: Body::Expr(Expr::Field(Box::new(Expr::Local(0)), 0)),
    });
    let unit = MT::Record(vec![]);
    p.funcs.push(Func {
        name: "yield".into(),
        arity: 1,
        locals: vec![unit.clone()],
        ty: fun(std::slice::from_ref(&unit), unit.clone()),
        body: Body::Prim("task.yield".into()),
    });
    p.named = vec![
        ("aliases".into(), 3),
        ("fail_transfer".into(), 6),
        ("partial".into(), 8),
    ];
    p.main = Some(7);
    fwp::ir::check_locals(&p).unwrap();
    let mut interp = fwp::interp::Interp::new(&p, Box::new(Vec::new()));
    assert_eq!(
        interp
            .call(2, vec![Value::Str("hello".into()), Value::I64(17)])
            .unwrap(),
        Value::Str("hello".into())
    );
    assert_eq!(
        interp
            .call(3, vec![Value::Str("hello".into()), Value::I64(17)])
            .unwrap(),
        Value::Record(vec![Value::Str("hello".into()), Value::Str("hello".into())].into())
    );
    assert!(interp
        .call(6, vec![Value::Str("hello".into()), Value::I64(17)])
        .is_err());
    let generated = fwp::cgen::generate(&p).unwrap();
    for name in ["transfer", "aliases", "fail_transfer"] {
        let start = generated.find(&format!("/* {name} :")).unwrap();
        let end = start + generated[start..].find("\n}\n").unwrap();
        assert!(
            !generated[start..end].contains("fwp_record(6"),
            "{name} boxed a worker argument"
        );
    }
    let start = generated.find("/* partial :").unwrap();
    let end = start + generated[start..].find("\n}\n").unwrap();
    assert!(
        generated[start..end].contains("fwp_record(6"),
        "partial application must retain a boxed capture"
    );
    let runtime = generated.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let fixture = r#"
static volatile V input,word;static jmp_buf failure;
static int recover(void){return 1;}
static void drop_leaf(V v){if(fwp_rc_release_last(v))fwp_rc_free_obj(v);}
static int dead(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
 for(int mode=0;mode<4;mode++)for(int alias=0;alias<2;alias++){
  input=fwp_rc_fresh(fwp_str_new("hello",5));word=fwp_rc_fresh(fwp_str_new("scalar",6));if(alias)fwp_rc_dup(input);
  if(mode==0){V result=f2(input,word);if(result!=input||*fwp_rc_slot(input)!=1+alias)return 1;drop_leaf(result);}
  if(mode==1){fwp_r2 results=w3(input,word);if(results.f[0]!=input||results.f[1]!=input||*fwp_rc_slot(input)!=2+alias)return 2;drop_leaf(results.f[0]);drop_leaf(results.f[1]);}
  if(mode==2){
   fwp_trap_recover=recover;fwp_trap_jb=&failure;fwp_trap_cleanup=0;
   if(!setjmp(failure)){(void)f6(input,word);return 3;}fwp_trap_recover=0;fwp_trap_jb=0;
  }
  if(mode==3){V fn=f8(input,word),argument=4;V result=fwp_apply_owned(fn,1,&argument);if(result!=input||*fwp_rc_slot(input)!=1+alias)return 4;drop_leaf(result);}
  if(fwp_cleanups||*fwp_rc_slot(word)!=1||STR(word)->len!=6)return 5;
  if(alias){if(*fwp_rc_slot(input)!=1||STR(input)->len!=5)return 6;drop_leaf(input);}else if(!dead(input))return 7;
  drop_leaf(word);
 }
 return 0;
}
"#;
    let dir =
        Scratch(std::env::temp_dir().join(format!("fwp-unboxed-owners-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let exe = dir.0.join("probe");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{fixture}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
        }
    }
}
