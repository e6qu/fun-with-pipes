//! Scoped callbacks keep typed captures and protect results until cancellation checks finish.
use std::process::Command;

#[test]
fn scoped_callbacks_own_results_and_release_them_on_cancellation() {
    let dir = std::env::temp_dir().join(format!("fwp-scope-thunk-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    std::fs::write(
        &source,
        r#"plain : String -> () -> String
plain = const
word : I64 -> () -> I64
word = const
later : I64 -> () -> () ! {Async}
later = curry (.0 | duration.from-millis | task.sleep)
with-child : String -> () -> String ! {Async}
with-child = curry (.0 | tap (const [1] | each (later | task.spawn | ignore)))
main = [task.scope (plain ("input" | string.repeat 2)) | echo,
 task.scope (word 17) | echo,
 task.scope (with-child ("joined" | string.repeat 2)) | echo] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&source)
        .env("FWP_NO_OPT", "1")
        .output()
        .unwrap();
    assert!(
        reference.status.success(),
        "{}",
        String::from_utf8_lossy(&reference.stderr)
    );
    let build = Command::new(fwp)
        .arg("build")
        .arg(&source)
        .args(["--emit-c", "-o"])
        .arg(&cfile)
        .output()
        .unwrap();
    assert!(
        build.status.success(),
        "{}",
        String::from_utf8_lossy(&build.stderr)
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let id = |name: &str| {
        let start = emitted.find(&format!("/* {name}")).unwrap();
        emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
            .to_string()
    };
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static V capture, fn;static jmp_buf recovered;static int bad_handler;
static int recover(void){return 1;}
static int dead(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
static void worker(void *arg,int failed){
 (void)arg;if(failed)return;
 fwp_value_owner owner={fn,fwp_closure_drop};fwp_cleanup cleanup;fwp_value_protect(&owner,&cleanup);
 if(cancel_after_scope_result==3){
  fwp_trap_recover=recover;fwp_trap_jb=&recovered;fwp_trap_cleanup=0;
  if(setjmp(recovered)==0){fSCOPE(fn);bad_handler=1;}
  else if(fwp_handlers)bad_handler=1;
  fwp_trap_recover=0;fwp_trap_jb=0;return;
 }
 fSCOPE(fn);fwp_trap("expected cancellation");
}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 for(int alias=0;alias<2;alias++){
  capture=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(capture);
  fn=fwp_rc_fresh(fwp_pap(PLAIN,1,&capture));V result=fSCOPE(fn);
  if(*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=alias+2||result!=capture)return 1;
  if(fwp_rc_release_last(result))fwp_rc_free_obj(result);fwp_closure_drop(fn);
  if(alias){if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 2;fwp_rc_free_obj(capture);}
  else if(!dead(capture))return 3;
 }
 for(int mode=1;mode<4;mode++){
  capture=fwp_rc_fresh(fwp_str_new("cancel",6));fn=fwp_rc_fresh(fwp_pap(PLAIN,1,&capture));
  int before=scope_freed;cancel_after_scope_result=mode;
  fwp_task *t=fwp_spawn_task(0,worker,0,0,0);V result=fwp_await(t);
  if(result!=FWP_NONE||t->scope||t->cleanups||bad_handler)return 4;
  if(!dead(capture))return 5;
  if(scope_freed!=before+1)return 6;
 }
 cancel_after_scope_result=0;
 V scalar=fwp_rc_fresh(fwp_str_new("scalar",6));fn=fwp_rc_fresh(fwp_pap(WORD,1,&scalar));
 V result=fSCALAR(fn);if(result!=scalar||*fwp_rc_slot(scalar)!=1)return 7;
 fwp_closure_drop(fn);fwp_rc_free_obj(scalar);
 fwp_fninfo table[sizeof(fwp_fn_table)/sizeof(fwp_fn_table[0])];memcpy(table,fwp_fn_table,sizeof(table));
 table[PLAIN].owned=0;fwp_fns=table;
 capture=fwp_rc_fresh(fwp_str_new("shared",6));fn=fwp_rc_fresh(fwp_pap(PLAIN,1,&capture));result=fSCOPE(fn);
 if(result!=capture||*fwp_rc_slot(fn)||*fwp_rc_slot(capture))return 8;
 fwp_closure_drop(fn);fwp_tasks_finish();fwp_fns=fwp_fn_table;return 0;
}
"#.replace("PLAIN", &id("plain")).replace("SCOPE", &id("task.scope : (() -> String) -> String"))
    .replace("SCALAR", &id("task.scope : (() -> I64) -> I64"))
    .replace("WORD", &id("word"));
    // Probe both result cancellation and cancellation before callback entry.
    let runtime = runtime.replace("typedef struct { fwp_task *task; fwp_scope *scope; fwp_handler *handlers; }",
        "static int cancel_after_scope_result,scope_freed;\nstatic void idle(void *a,int failed){(void)a;(void)failed;}\ntypedef struct { fwp_task *task; fwp_scope *scope; fwp_handler *handlers; }")
        .replace("fwp_mem_free(owner->scope->tasks);",
            "if(owner->scope->tasks)scope_freed++;fwp_mem_free(owner->scope->tasks);")
        .replace("V unit = FWP_UNIT;\n        r = borrowed ?",
            "V unit = FWP_UNIT;\n        if(cancel_after_scope_result>=2){fwp_spawn_task(0,idle,0,0,0);if(cancel_after_scope_result==3)fwp_trap(\"scope probe\");fwp_cancel_tree(fwp_cur);fwp_check_cancel();}\n        r = borrowed ?")
        .replace("result_owner.value = r;",
            "result_owner.value = r;\n        if(cancel_after_scope_result==1){fwp_spawn_task(0,idle,0,0,0);fwp_cancel_tree(fwp_cur);}");
    assert!(runtime.contains("static int cancel_after_scope_result,scope_freed;"));
    let no_result = runtime.replace(
        "fwp_value_owner result_owner = {0, drop};",
        "(void)drop;fwp_value_owner result_owner = {0, NULL};",
    );
    let no_scope = runtime.replace(
        "if(owner->scope->tasks)scope_freed++;fwp_mem_free(owner->scope->tasks);",
        "/* deliberately omit scope array cleanup */",
    );
    let no_handler = runtime.replace(
        "fwp_handlers = owner->handlers;",
        "/* omit handler restoration */",
    );
    for opt in ["-O1", "-O2"] {
        for (control, exit) in [(&no_result, 5), (&no_scope, 6), (&no_handler, 4)] {
            fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
            let out = Command::new(&exe)
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(out.status.code(), Some(exit));
        }
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                out.status.success(),
                "exit {:?}: {}",
                out.status.code(),
                String::from_utf8_lossy(&out.stderr)
            );
        }
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
        let out = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(out.status.code(), reference.status.code());
        assert_eq!(out.stdout, reference.stdout);
        assert_eq!(out.stderr, reference.stderr);
    }
    std::fs::remove_dir_all(dir).unwrap();
}
