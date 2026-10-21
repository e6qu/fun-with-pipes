//! Live caller owners survive normal calls and release on nonlocal unwind.
use fwp::ir::*;
use fwp::value::Value;
use std::path::PathBuf;
use std::process::{Command, Output};

#[test]
fn temporary_channel_fields_preserve_owners_and_nonlocal_cleanup() {
    let channel = MT::Con("std::Channel".into(), vec![MT::con("std::String")]);
    let integer = MT::con("std::I64");
    let pair = MT::Record(vec![
        ("0".into(), channel.clone()),
        ("1".into(), integer.clone()),
    ]);
    let arrow = |input: MT, output: MT| MT::Fun(Box::new(input), Box::new(output));
    let program = Program {
        main: Some(3),
        funcs: vec![
            Func {
                name: "close".into(),
                arity: 1,
                locals: vec![channel.clone()],
                ty: arrow(channel.clone(), MT::unit()),
                body: Body::Prim("channel.close".into()),
            },
            Func {
                name: "keep-field".into(),
                arity: 1,
                locals: vec![
                    pair.clone(),
                    channel.clone(),
                    MT::Record(vec![
                        ("0".into(), MT::unit()),
                        ("1".into(), integer.clone()),
                    ]),
                ],
                ty: arrow(pair, channel.clone()),
                body: Body::Expr(Expr::Let(
                    1,
                    Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)),
                    Box::new(Expr::Let(
                        2,
                        Box::new(Expr::Record(vec![
                            Expr::Call(0, vec![Expr::Local(1)]),
                            Expr::Const(Value::I64(42)),
                        ])),
                        Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)),
                    )),
                )),
            },
            Func {
                name: "make".into(),
                arity: 1,
                locals: vec![integer.clone()],
                ty: arrow(integer, channel),
                body: Body::Prim("channel.make".into()),
            },
            Func {
                name: "main".into(),
                arity: 0,
                locals: vec![],
                ty: MT::unit(),
                body: Body::Expr(Expr::Call(
                    0,
                    vec![Expr::Call(
                        1,
                        vec![Expr::Record(vec![
                            Expr::Call(2, vec![Expr::Const(Value::I64(1))]),
                            Expr::Const(Value::I64(42)),
                        ])],
                    )],
                )),
            },
        ],
        ..Program::default()
    };
    let mut interpreter = fwp::interp::Interp::new(&program, Box::new(std::io::sink())).unwrap();
    assert_eq!(interpreter.call(3, vec![]).unwrap(), Value::unit());
    let code = fwp::cgen::generate(&program).unwrap().replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let close = "static V fwp_p_channel_close(V ch) {";
    assert_eq!(code.matches(close).count(), 1);
    let code = code.replace(
        close,
        &format!(
            "static int expected_owners, close_mode;\n\
             static fwp_task cancelled_alias_task;\n{close}\n\
             if(expected_owners && *fwp_rc_slot(ch)!=expected_owners)exit(71);\n\
             if(close_mode==1)fwp_fail(0,0);\n\
             if(close_mode==2){{fwp_cur=&cancelled_alias_task;\
             cancelled_alias_task.cancelled=1;fwp_check_cancel();}}"
        ),
    );
    let probe = r#"
/* These changed automatic subobjects must survive longjmp even when a
 * particular compiler happens to preserve their unqualified versions. */
_Static_assert(_Generic(&((fwp_handler*)0)->value,volatile V*:1,default:0),"error value must survive longjmp");
_Static_assert(_Generic(&((fwp_handler*)0)->desc,const fwp_desc *volatile *:1,default:0),"error type must survive longjmp");
_Static_assert(_Generic(&((fwp_scope*)0)->tasks,fwp_task **volatile *:1,default:0),"scope tasks must survive longjmp");
_Static_assert(_Generic(&((fwp_scope*)0)->n,volatile size_t*:1,default:0),"scope count must survive longjmp");
_Static_assert(_Generic(&((fwp_scope*)0)->cap,volatile size_t*:1,default:0),"scope capacity must survive longjmp");
static int destroyed;
static volatile V live_channel;
static int probe_sink(void *context,V value){(void)context;(void)value;return 0;}
static void probe_drop(void *context){if(context!=&destroyed)abort();destroyed++;}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_init_consts();fwp_fns=fwp_fn_table;fwp_tasks_init();
 for(volatile int mode=0;mode<3;mode++)for(volatile int alias=0;alias<2;alias++){
  destroyed=0;
  live_channel=fwp_p_channel_make_owned(1,0);
  fwp_chan *queue=(fwp_chan *)(uintptr_t)live_channel;
  queue->sink=probe_sink;queue->sink_ctx=&destroyed;queue->owner.sink_drop=probe_drop;
  if(alias)fwp_rc_dup(live_channel);
  expected_owners=1+alias;
  close_mode=mode;
  fwp_task *previous=fwp_cur;
  static fwp_handler h;h.prev=fwp_handlers;h.state_depth=fwp_state_len;h.cleanup=fwp_cleanups;
  fwp_handlers=&h;
  memset(&cancelled_alias_task,0,sizeof cancelled_alias_task);
  if(mode==2){
   jmp_buf cancelled_alias_task_base; cancelled_alias_task.base = &cancelled_alias_task_base;
   if (!setjmp(cancelled_alias_task_base)){
    (void)f1(fwp_rc_fresh(fwp_record(2,(V[]){live_channel,42})));return 76;
   }
   cancelled_alias_task.base=NULL;
   if(!cancelled_alias_task.unwinding)return 76;
  }else if(!setjmp(h.jb)){
   V returned=f1(fwp_rc_fresh(fwp_record(2,(V[]){live_channel,42})));
   if(mode || returned!=live_channel||destroyed||!queue->closed)return 72;
   if(*fwp_rc_slot(returned)!=expected_owners)return 73;
   fwp_channel_drop(returned);
  }else{
   if(mode!=1)return 76;
  }
  if(mode && alias && *fwp_rc_slot(live_channel)!=1)return 77;
  fwp_cur=previous;fwp_handlers=h.prev;close_mode=0;
  if(alias){if(destroyed)return 74;fwp_channel_drop(live_channel);}
  if(destroyed!=1||fwp_cleanups)return 75;
 }
 return 0;
}
"#;
    let control = code.replace(close, &format!("{close}\nfwp_rc_dup(ch);"));
    let leaked = probe.replace("fwp_channel_drop(returned);", "(void)returned;");
    let dir = fwp::cgen::TempDir::new("borrowed-field-context").unwrap();
    let exe = dir.join("probe.exe");
    for opt in ["-O0", "-O2", "-O3"] {
        for (candidate, case_probe, status) in [
            (&code, probe, 0),
            (&control, probe, 71),
            (&code, leaked.as_str(), 75),
        ] {
            fwp::cgen::compile_c(&format!("{candidate}\n{case_probe}"), &exe, opt).unwrap();
            for poison in ["0", "1"] {
                let output = Command::new(&exe)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(status),
                    "{opt}/{poison}: {output:?}"
                );
            }
        }
    }
}

#[test]
fn borrowed_function_channels_preserve_native_context_destruction() {
    let channel = MT::Con(
        "std::Channel".into(),
        vec![MT::Fun(
            Box::new(MT::unit()),
            Box::new(MT::con("std::String")),
        )],
    );
    let integer = MT::con("std::I64");
    let arrow = |input: MT, output: MT| MT::Fun(Box::new(input), Box::new(output));
    let program = Program {
        main: Some(4),
        funcs: vec![
            Func {
                name: "close".into(),
                arity: 1,
                locals: vec![channel.clone()],
                ty: arrow(channel.clone(), MT::unit()),
                body: Body::Prim("channel.close".into()),
            },
            Func {
                name: "observe".into(),
                arity: 1,
                locals: vec![channel.clone(), MT::unit()],
                ty: arrow(channel.clone(), integer.clone()),
                body: Body::Expr(Expr::Let(
                    1,
                    Box::new(Expr::Call(0, vec![Expr::Local(0)])),
                    Box::new(Expr::Const(Value::I64(7))),
                )),
            },
            Func {
                name: "keep".into(),
                arity: 1,
                locals: vec![channel.clone(), integer.clone()],
                ty: arrow(channel.clone(), channel.clone()),
                body: Body::Expr(Expr::Let(
                    1,
                    Box::new(Expr::Call(1, vec![Expr::Local(0)])),
                    Box::new(Expr::Local(0)),
                )),
            },
            Func {
                name: "make".into(),
                arity: 1,
                locals: vec![integer.clone()],
                ty: arrow(integer, channel.clone()),
                body: Body::Prim("channel.make".into()),
            },
            Func {
                name: "main".into(),
                arity: 0,
                locals: vec![channel.clone(), channel],
                ty: MT::unit(),
                body: Body::Expr(Expr::Let(
                    0,
                    Box::new(Expr::Call(3, vec![Expr::Const(Value::I64(1))])),
                    Box::new(Expr::Let(
                        1,
                        Box::new(Expr::Call(2, vec![Expr::Local(0)])),
                        Box::new(Expr::Call(0, vec![Expr::Local(1)])),
                    )),
                )),
            },
        ],
        ..Program::default()
    };
    let mut interpreter = fwp::interp::Interp::new(&program, Box::new(std::io::sink())).unwrap();
    assert_eq!(interpreter.call(4, vec![]).unwrap(), Value::unit());
    let emitted = fwp::cgen::generate(&program).unwrap();
    let marker = "/* caller-owned parameters: 0 */";
    assert_eq!(emitted.matches(marker).count(), 1, "{emitted}");
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static int destroyed;
static int probe_sink(void *context, V value) {(void)context;(void)value;return 0;}
static void probe_drop(void *context) {if(context!=&destroyed)abort();destroyed++;}
static V native_channel(void) {
 V value=fwp_p_channel_make_owned(1,fwp_closure_drop);
 fwp_chan *channel=(fwp_chan *)(uintptr_t)value;
 channel->sink=probe_sink;channel->sink_ctx=&destroyed;channel->owner.sink_drop=probe_drop;
 return value;
}
int main(void) {
 fwp_gc_start(__builtin_frame_address(0));fwp_init_consts();fwp_fns=fwp_fn_table;fwp_tasks_init();
 for(int alias=0;alias<2;alias++){
  destroyed=0;V channel=native_channel();
  if(alias)fwp_rc_dup(channel);
  V returned=f2(channel);
  if(destroyed||returned!=channel)return 10;
  if(*fwp_rc_slot(channel)!=1+alias)return 11;
  if(!((fwp_chan *)(uintptr_t)channel)->closed)return 12;
  fwp_channel_drop(returned);
  if(alias){if(destroyed)return 13;fwp_channel_drop(channel);}
  if(destroyed!=1)return 14;
 }
 /* The existing generic entry still consumes its input after the borrowed
  * worker finishes, so a last owner destroys its context before return. */
 destroyed=0;V channel=native_channel();
 if(f1(channel)!=7||destroyed!=1)return 15;
 if(fwp_cleanups)return 16;
 return 0;
}
"#;
    let control = runtime.replace(marker, &format!("{marker}\nfwp_rc_dup(l0);"));
    let dir = fwp::cgen::TempDir::new("borrowed-channel-context").unwrap();
    let exe = dir.join("probe.exe");
    for opt in ["-O0", "-O2"] {
        for (code, status) in [(&runtime, 0), (&control, 11)] {
            fwp::cgen::compile_c(&format!("{code}\n{probe}"), &exe, opt).unwrap();
            for poison in ["0", "1"] {
                let output = Command::new(&exe)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(status),
                    "{opt}, poison {poison}: {output:?}"
                );
            }
        }
    }
}

#[test]
fn direct_borrowed_fields_preserve_owners_on_success_failure_and_cancellation() {
    let string = MT::con("std::String");
    let integer = MT::con("std::I64");
    let pair = MT::Record(vec![
        ("0".into(), string.clone()),
        ("1".into(), integer.clone()),
    ]);
    let function_type = |parameters: &[MT], result: MT| {
        parameters.iter().rev().fold(result, |result, parameter| {
            MT::Fun(Box::new(parameter.clone()), Box::new(result))
        })
    };
    let mut p = Program::default();
    p.funcs.push(Func {
        name: "length".into(),
        arity: 1,
        locals: vec![string.clone()],
        ty: function_type(std::slice::from_ref(&string), integer.clone()),
        body: Body::Prim("string.length".into()),
    });
    p.funcs.push(Func {
        name: "read".into(),
        arity: 1,
        locals: vec![pair.clone(), string.clone(), integer.clone(), MT::unit()],
        ty: function_type(&[pair], integer.clone()),
        body: Body::Expr(Expr::Let(
            1,
            Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)),
            Box::new(Expr::Let(
                2,
                Box::new(Expr::Field(Box::new(Expr::Local(0)), 1)),
                Box::new(Expr::Match(
                    Box::new(Expr::Local(2)),
                    vec![
                        (Pat::Lit(Value::I64(0)), Expr::Call(0, vec![Expr::Local(1)])),
                        (
                            Pat::Lit(Value::I64(2)),
                            Expr::Let(
                                3,
                                Box::new(Expr::Call(5, vec![Expr::Const(Value::unit())])),
                                Box::new(Expr::Call(0, vec![Expr::Local(1)])),
                            ),
                        ),
                        (
                            Pat::Wild,
                            Expr::Call(3, vec![Expr::Const(Value::str("expected"))]),
                        ),
                    ],
                )),
            )),
        )),
    });
    p.funcs.push(Func {
        name: "caller".into(),
        arity: 2,
        locals: vec![string.clone(), integer.clone(), integer.clone()],
        ty: function_type(&[string.clone(), integer.clone()], string.clone()),
        body: Body::Expr(Expr::Let(
            2,
            Box::new(Expr::Call(
                1,
                vec![Expr::Record(vec![Expr::Local(0), Expr::Local(1)])],
            )),
            Box::new(Expr::Local(0)),
        )),
    });
    p.funcs.push(Func {
        name: "fail".into(),
        arity: 1,
        locals: vec![string.clone()],
        ty: function_type(std::slice::from_ref(&string), integer),
        body: Body::Prim("fail".into()),
    });
    p.funcs.push(Func {
        name: "main".into(),
        arity: 0,
        locals: vec![],
        ty: string,
        body: Body::Expr(Expr::Call(
            2,
            vec![Expr::Const(Value::str("input")), Expr::Const(Value::I64(0))],
        )),
    });
    p.funcs.push(Func {
        name: "yield".into(),
        arity: 1,
        locals: vec![MT::unit()],
        ty: function_type(&[MT::unit()], MT::unit()),
        body: Body::Prim("task.yield".into()),
    });
    p.main = Some(4);
    fwp::ir::check_locals(&p).unwrap();
    let mut interpreter = fwp::interp::Interp::new(&p, Box::new(Vec::new())).unwrap();
    assert_eq!(
        interpreter
            .call(2, vec![Value::str("input"), Value::I64(0)])
            .unwrap(),
        Value::str("input")
    );
    assert!(interpreter
        .call(2, vec![Value::str("input"), Value::I64(1)])
        .is_err());
    let emitted = fwp::cgen::generate(&p).unwrap();
    let borrowed = "/* caller-owned parameters: 0 */";
    assert_eq!(emitted.matches(borrowed).count(), 1);
    let entry = "static V f0(V l0) {\n";
    assert_eq!(emitted.matches(entry).count(), 1);
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    ).replace(entry, &format!(
        "static volatile unsigned expected_owners;\nstatic volatile int cancel_borrowed_entry;\nstatic fwp_task cancelled_borrowed_task;\n{entry}if (*fwp_rc_slot(l0) != expected_owners) exit(20);\n"
    )).replace(borrowed, &format!(
        "{borrowed}\nif (cancel_borrowed_entry) {{ fwp_cur=&cancelled_borrowed_task; cancelled_borrowed_task.cancelled=1; fwp_budget=0; }}\n"
    ));
    let probe = r#"
static volatile V input_value;
static int dead(V value) { return fwp_reuse_verify ? STR(value)->len==0 : *fwp_rc_slot(value)==0; }
int main(void) {
 fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns=fwp_fn_table;
 for(volatile int mode=0;mode<2;mode++) for(volatile int alias=0;alias<2;alias++) {
  input_value=fwp_rc_fresh(fwp_str_new("input",5)); expected_owners=1+alias;
  if(alias) fwp_rc_dup(input_value);
  fwp_handler h; h.prev=fwp_handlers; h.state_depth=fwp_state_len; h.cleanup=fwp_cleanups;
  fwp_handlers=&h;
  if(!setjmp(h.jb)) {
   V result=f2(input_value,mode);
   if(mode || result!=input_value || *fwp_rc_slot(result)!=expected_owners) return 1;
   if(alias && fwp_rc_release_last(input_value)) return 2;
   if(!fwp_rc_release_last(result)) return 3;
   fwp_rc_free_obj(result);
  } else {
   if(!mode) return 4;
   if(alias) {
    if(*fwp_rc_slot(input_value)!=1 || STR(input_value)->len!=5) return 5;
    if(!fwp_rc_release_last(input_value)) return 6;
    fwp_rc_free_obj(input_value);
   }
  }
  fwp_handlers=h.prev;
  if(fwp_cleanups || !dead(input_value)) return 7;
 }
 for(volatile int mode=0;mode<2;mode++) {
  input_value=fwp_rc_fresh(fwp_str_new("input",5)); expected_owners=1;
  V boxed=fwp_rc_fresh(fwp_record(2,(V[]){input_value,mode}));
  fwp_handler h; h.prev=fwp_handlers; h.state_depth=fwp_state_len; h.cleanup=fwp_cleanups;
  fwp_handlers=&h;
  if(!setjmp(h.jb)) {
   if(f1(boxed)!=5 || mode) return 8;
  } else if(!mode) return 9;
  fwp_handlers=h.prev;
  if(fwp_cleanups || !dead(input_value)) return 10;
 }
 for(int alias=0;alias<2;alias++) {
  input_value=fwp_rc_fresh(fwp_str_new("input",5));
  if(alias) fwp_rc_dup(input_value);
  memset(&cancelled_borrowed_task,0,sizeof cancelled_borrowed_task);
  cancel_borrowed_entry=1;
  jmp_buf cancelled_borrowed_task_base; cancelled_borrowed_task.base = &cancelled_borrowed_task_base;
  if (!setjmp(cancelled_borrowed_task_base)) { f2(input_value,0); return 11; }
  cancelled_borrowed_task.base=NULL; fwp_cur=0; cancel_borrowed_entry=0;
  if(!cancelled_borrowed_task.unwinding || fwp_cleanups) return 12;
  if(alias) {
   if(*fwp_rc_slot(input_value)!=1 || STR(input_value)->len!=5) return 13;
   if(!fwp_rc_release_last(input_value)) return 14;
   fwp_rc_free_obj(input_value);
  }
  if(!dead(input_value)) return 15;
 }
 return 0;
}
"#;
    let dir = fwp::cgen::TempDir::new("direct-borrowed-fields").unwrap();
    let exe = dir.join("probe.exe");
    let control = runtime.replace(entry, &format!("{entry}fwp_rc_dup(l0);\n"));
    for opt in ["-O0", "-O2"] {
        for (code, status) in [(&control, 20), (&runtime, 0)] {
            fwp::cgen::compile_c(&format!("{code}\n{probe}"), &exe, opt).unwrap();
            for poison in ["0", "1"] {
                let output = Command::new(&exe)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(status),
                    "{opt}, poison {poison}: {output:?}"
                );
            }
        }
    }
}

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p = std::env::temp_dir().join(format!("fwp-call-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"guard : I64 -> I64 ! {Error[String]}
guard = if (eq 0) (const "expected" | fail) (add 1)
hold : (I64 -> I64 ! {Error[String]}) -> String -> String ! {Error[String]}
hold = curry (both (.0 | apply 0) .1 | .1)
main = "owned" | concat " input" | attempt (hold guard) | echo
"#;
#[test]
fn actual_caller_releases_owned_values_and_preserves_aliases() {
    let dir = Scratch::new("caller");
    let src = dir.0.join("caller.fwp");
    let cfile = dir.0.join("caller.c");
    let exe = dir.0.join("caller");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        let suffix = emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        format!("f{suffix}")
    };
    let probe = r#"
static volatile int fail_call;
static volatile V input_value;
static V caller_entry(V *args) { return fail_call ? GUARD(args[0]) : (V)7; }
static const fwp_fninfo caller_fns[] = {{1, caller_entry, "caller probe", 0}};
static fwp_clo caller_fn = {0, 0};
static int released(V v) { return fwp_reuse_verify ? STR(v)->len == 0 : *fwp_rc_slot(v) == 0; }
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 100;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = caller_fns;
    input_value = fwp_rc_fresh(fwp_str_new("normal", 6));
    if (HOLD(PTR(&caller_fn), input_value) != input_value || fwp_cleanups ||
        *fwp_rc_slot(input_value) != 1) return 1;
    if (!fwp_rc_release_last(input_value)) return 2;
    fwp_mem_free((void *)(uintptr_t)input_value);
    for (int alias = 0; alias < 2; alias++) {
        input_value = fwp_rc_fresh(fwp_str_new("retained", 8));
        if (alias) fwp_rc_dup(input_value);
        double before = fwp_gc.freed;
        fwp_handler h;
        h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
        fwp_handlers = &h; fail_call = 1;
        if (!setjmp(h.jb)) { HOLD(PTR(&caller_fn), input_value); return 3; }
        fwp_handlers = h.prev; fail_call = 0;
        if (fwp_cleanups) return 4;
        if (alias) {
            if (*fwp_rc_slot(input_value) != 1 || STR(input_value)->len != 8 ||
                memcmp(STR(input_value)->d, "retained", 8)) return 5;
            if (!fwp_rc_release_last(input_value)) return 6;
            fwp_mem_free((void *)(uintptr_t)input_value);
        } else {
            if (!released(input_value)) return 7;
            if (!fwp_reuse_verify && fwp_gc.freed <= before) return 8;
        }
    }
    puts("live caller owners release exactly once");
    return 0;
}
"#
    .replace("GUARD", &wrapper("guard"))
    .replace("HOLD", &wrapper("hold"));
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, b"live caller owners release exactly once\n");
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn earlier_argument_is_released_when_later_argument_fails() {
    for scalar in [false, true] {
        check_later_argument_failure(scalar);
    }
}

fn check_later_argument_failure(scalar: bool) {
    let dir = Scratch::new(if scalar {
        "scalar-arguments"
    } else {
        "arguments"
    });
    let src = dir.0.join("arguments.fwp");
    let cfile = dir.0.join("arguments.c");
    let exe = dir.0.join("arguments");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let source = r#"guard : I64 -> String ! {Error[String]}
guard = if (eq 0) (const "expected" | fail) show
pair : (I64 -> String ! {Error[String]}) -> I64 -> (String, String) ! {Error[String]}
pair = curry (both (fork apply .1 .0) (fork apply (const 0) .0))
main = 2 | attempt (pair guard) | echo
"#;
    let source = if scalar {
        source.replace("(String, String)", "(String, I64)").replace(
            "(fork apply (const 0) .0)",
            "(fork apply (const 0) .0 | string.length)",
        )
    } else {
        source.to_owned()
    };
    std::fs::write(&src, source).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        let suffix = emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        format!("f{suffix}")
    };
    let probe = r#"
static volatile V first_argument;
static V argument_entry(V *args) {
    if (!args[0]) return GUARD(args[0]);
    first_argument = fwp_rc_fresh(fwp_str_new("first", 5));
    return first_argument;
}
static const fwp_fninfo argument_fns[] = {{1, argument_entry, "argument probe", 0}};
static fwp_clo argument_fn = {0, 0};
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 100;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = argument_fns;
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) { PAIR(PTR(&argument_fn), 2); return 1; }
    fwp_handlers = h.prev;
    if (!first_argument || fwp_cleanups) return 2;
    if (fwp_reuse_verify ? STR(first_argument)->len != 0 : *fwp_rc_slot(first_argument) != 0) return 3;
    puts("pending arguments release on later failure");
    return 0;
}
"#.replace("GUARD", &wrapper("guard")).replace("PAIR", &wrapper("pair"));
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, b"pending arguments release on later failure\n");
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn boxed_wrapper_and_unboxed_worker_release_separate_owners() {
    let dir = Scratch::new("worker");
    let src = dir.0.join("worker.fwp");
    let cfile = dir.0.join("worker.c");
    let exe = dir.0.join("worker");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let source = format!(
        "Box = {{ text: String }}\n{}",
        SOURCE
            .replace("-> String -> String !", "-> Box -> String !")
            .replace("both (.0 | apply 0) .1", "both (.0 | apply 0) (.1 | .text)")
            .replace(
                "main = \"owned\" | concat \" input\"",
                "main = Box { text = \"owned\" | concat \" input\" }"
            )
    );
    std::fs::write(&src, source).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        let suffix = emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        format!("f{suffix}")
    };
    assert!(emitted.contains("fwp_cleanup_push(&cleanup, fwp_owner_release"));
    let probe = r#"
static volatile V boxed_input, text_input;
static V worker_entry(V *args) { return GUARD(args[0]); }
static const fwp_fninfo worker_fns[] = {{1, worker_entry, "worker probe", 0}};
static fwp_clo worker_fn = {0, 0};
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 100;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = worker_fns;
    text_input = fwp_rc_fresh(fwp_str_new("child", 5));
    boxed_input = fwp_rc_fresh(fwp_record(1, (V[]){text_input}));
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) { HOLD(PTR(&worker_fn), boxed_input); return 1; }
    fwp_handlers = h.prev;
    if (fwp_cleanups) return 2;
    if (fwp_reuse_verify) {
        if (OBJ(boxed_input)->tag != 0xdead || STR(text_input)->len != 0) return 3;
    } else if (*fwp_rc_slot(boxed_input) || *fwp_rc_slot(text_input)) return 4;
    puts("wrapper and worker owners release exactly once");
    return 0;
}
"#
    .replace("GUARD", &wrapper("guard"))
    .replace("HOLD", &wrapper("hold"));
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(
                out.stdout,
                b"wrapper and worker owners release exactly once\n"
            );
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn incoming_parameters_release_before_cancelled_entry_tick() {
    let dir = Scratch::new("cancel-entry");
    let src = dir.0.join("entry.fwp");
    let cfile = dir.0.join("entry.c");
    let exe = dir.0.join("entry");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let source = SOURCE.replace("main = \"owned\" | concat \" input\" | attempt (hold guard) | echo",
        "main = [task.yield (), \"owned\" | concat \" input\" | attempt (hold guard) | echo] | ignore");
    std::fs::write(&src, source).unwrap();
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let start = emitted.find("/* hold :").unwrap();
    let hold = format!(
        "f{}",
        emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
    );
    let probe = r#"
static volatile V incoming;
static volatile int entered_callback;
static V entry_callback(V *args) { (void)args; entered_callback++; return 7; }
static const fwp_fninfo entry_fns[] = {{1, entry_callback, "entry probe", 0}};
static fwp_clo entry_fn = {0, 0};
static fwp_task cancelled_task;
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 100;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = entry_fns;
    incoming = fwp_rc_fresh(fwp_str_new("incoming", 8));
    cancelled_task.cancelled = 1;
    fwp_cur = &cancelled_task;
    fwp_budget = 0;
    jmp_buf cancelled_task_base; cancelled_task.base = &cancelled_task_base;
    if (!setjmp(cancelled_task_base)) { HOLD(PTR(&entry_fn), incoming); return 1; }
    fwp_cur = 0;
    cancelled_task.base=NULL;
    if (entered_callback || fwp_cleanups || !cancelled_task.unwinding) return 2;
    if (fwp_reuse_verify ? STR(incoming)->len != 0 : *fwp_rc_slot(incoming) != 0) return 3;
    puts("incoming owners release before cancellation");
    return 0;
}
"#
    .replace("HOLD", &hold);
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, b"incoming owners release before cancellation\n");
        }
    }
}

#[test]
fn struct_variant_owner_releases_its_typed_payload() {
    let dir = Scratch::new("variant");
    let src = dir.0.join("variant.fwp");
    let cfile = dir.0.join("variant.c");
    let exe = dir.0.join("variant");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"Wrapped = | Empty | Wrapped String
guard : I64 -> I64 ! {Error[String]}
guard = if (eq 0) (const "expected" | fail) (add 1)
choose : String -> Wrapped
choose = if (string.length | eq 0) (const Empty) Wrapped
hold : (I64 -> I64 ! {Error[String]}) -> String -> String ! {Error[String]}
hold = curry (both (.1 | choose) (.0 | apply 0) | .0 | match
    Empty -> ""
    Wrapped _ -> id)
main = "owned" | concat " input" | attempt (hold guard) | echo
"#,
    )
    .unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        format!(
            "f{}",
            emitted[start..]
                .split("static V f")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap()
        )
    };
    assert!(
        emitted.contains("fwp_u1 v0;"),
        "fixture must exercise a struct variant cleanup owner"
    );
    let probe = r#"
static volatile V payload;
static V variant_entry(V *args) { return GUARD(args[0]); }
static const fwp_fninfo variant_fns[] = {{1, variant_entry, "variant probe", 0}};
static fwp_clo variant_fn = {0, 0};
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 100;
#endif
    fwp_gc_start(__builtin_frame_address(0)); fwp_init_consts(); fwp_fns = variant_fns;
    payload = fwp_rc_fresh(fwp_str_new("payload", 7));
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) { HOLD(PTR(&variant_fn), payload); return 1; }
    fwp_handlers = h.prev;
    if (fwp_cleanups) return 2;
    if (fwp_reuse_verify ? STR(payload)->len != 0 : *fwp_rc_slot(payload) != 0) return 3;
    puts("struct variant payload releases on unwind");
    return 0;
}
"#
    .replace("GUARD", &wrapper("guard"))
    .replace("HOLD", &wrapper("hold"));
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, b"struct variant payload releases on unwind\n");
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
    // Normal transfer must also preserve the payload through the new struct
    // moves, including the nullary branch where there is no payload to count.
    let original = std::fs::read_to_string(&src).unwrap();
    for text in ["owned", ""] {
        let normal = original
            .replace("(.0 | apply 0)", "(.0 | apply 1)")
            .replace(
                "\"owned\" | concat \" input\"",
                &format!("\"{text}\" | concat \"\""),
            );
        std::fs::write(&src, normal).unwrap();
        let reference = checked(
            Command::new(fwp)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src),
        );
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["-O2", "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}
