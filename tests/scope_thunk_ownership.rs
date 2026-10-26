//! Scoped callbacks keep typed captures and protect results until cancellation checks finish.
use std::process::Command;

#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn scoped_callbacks_own_results_and_release_them_on_cancellation() {
    let dir = std::env::temp_dir().join(format!("fwp-scope-thunk-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
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
    for memory in ["arc", "tracing"] {
        let build = Command::new(fwp)
            .env("FWP_STACK", "0")
            .env_remove("FWP_NO_OPT")
            .args([
                "build", "--memory", "dynamic", "--gc", memory, "-O2", "--emit-c",
            ])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(build.status.success(), "{build:?}");
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
static int dead(V v){
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return STR(v)->len==0;
#endif
 uint8_t *slot=fwp_rc_slot(v);return !slot||!*slot;
}
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
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 size_t baseline=fwp_heap.live;
 for(int round=0;round<32;round++){
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
  fwp_task *t=fwp_spawn_task(0,worker,0,0,0);
  t->ownership=FWP_TASK_SHARED;fwp_rc_fresh(PTR(t));fwp_rc_dup(PTR(t));
  V result=fwp_await(t);
  if(result!=FWP_NONE||t->scope||t->cleanups||bad_handler)return 4;
  if(!dead(capture))return 5;
  if(scope_freed!=before+1)return 6;
  fwp_task_drop(PTR(t));fwp_free_zombie();
 }
 cancel_after_scope_result=0;
 V scalar=fwp_rc_fresh(fwp_str_new("scalar",6));fn=fwp_rc_fresh(fwp_pap(WORD,1,&scalar));
 V result=fSCALAR(fn);if(result!=scalar||*fwp_rc_slot(scalar)!=1)return 7;
 fwp_closure_drop(fn);fwp_rc_free_obj(scalar);
#ifdef FWP_ARC_ONLY
 if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
#endif
 }
 fwp_fninfo table[sizeof(fwp_fn_table)/sizeof(fwp_fn_table[0])];memcpy(table,fwp_fn_table,sizeof(table));
 table[PLAIN].owned=0;fwp_fns=table;
 capture=fwp_rc_fresh(fwp_str_new("shared",6));fn=fwp_rc_fresh(fwp_pap(PLAIN,1,&capture));
#ifdef FWP_ARC_ONLY
 fwp_trap_recover=recover;fwp_trap_jb=&recovered;fwp_trap_cleanup=0;
 if(setjmp(recovered)==0){fSCOPE(fn);return 11;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(strcmp(fwp_trap_msg,"internal: counted owner escaped ARC contract"))return 12;
 if(*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=1||fwp_handlers||fwp_cleanups||fwp_cur->scope)return 13;
 fwp_fns=fwp_fn_table;fwp_closure_drop(fn);
#else
 V result=fSCOPE(fn);
 if(result!=capture||*fwp_rc_slot(fn)||*fwp_rc_slot(capture))return 8;
 fwp_closure_drop(fn);fwp_fns=fwp_fn_table;
#endif
 fwp_tasks_finish();fwp_native_tasks_finish();
#ifdef FWP_ARC_ONLY
 if(fwp_heap.live!=0||fwp_heap.rc_wide_len)return 90;
#endif
 return 0;
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
            "V unit = FWP_UNIT;\n        if(cancel_after_scope_result>=2){fwp_task *child=fwp_spawn_task(0,idle,0,0,0);child->ownership=FWP_TASK_SHARED;fwp_rc_fresh(PTR(child));fwp_rc_dup(PTR(child));if(cancel_after_scope_result==3)fwp_trap(\"scope probe\");fwp_cancel_tree(fwp_cur);fwp_check_cancel();}\n        r = borrowed ?")
        .replace("result_owner.value = r;",
            "result_owner.value = r;\n        if(cancel_after_scope_result==1){fwp_task *child=fwp_spawn_task(0,idle,0,0,0);child->ownership=FWP_TASK_SHARED;fwp_rc_fresh(PTR(child));fwp_rc_dup(PTR(child));fwp_cancel_tree(fwp_cur);}");
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
            if memory == "arc" {
                let missing = probe.replace(
                    "fwp_rc_free_obj(scalar);",
                    "/* omit scalar owner release */",
                );
                assert_ne!(missing, probe);
                let code = format!("{runtime}\n{missing}");
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                record_probe::save(
                    "scope_thunk_ownership",
                    &format!("{memory}{opt}-missing-scalar"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(output.status.code(), Some(90), "{output:?}");
            }
            for (case, control, expected) in [
                ("missing-result", &no_result, 5),
                ("missing-scope", &no_scope, 6),
                ("missing-handler", &no_handler, 4),
            ] {
                assert_ne!(control, &runtime);
                let code = format!("{control}\n{probe}");
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let output = Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", if memory == "arc" { "0" } else { "1" })
                    .output()
                    .unwrap();
                record_probe::save(
                    "scope_thunk_ownership",
                    &format!("{memory}{opt}-{case}"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(
                    output.status.code(),
                    Some(expected),
                    "{memory} {opt} {case}: {output:?}"
                );
            }
            let code = format!("{runtime}\n{probe}");
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for (stress, poison) in if memory == "arc" {
                &[("0", "0")][..]
            } else {
                &[("0", "0"), ("1", "0"), ("1", "1")][..]
            } {
                let output = Command::new(&exe)
                    .env("FWP_GC", if memory == "arc" { "off" } else { "on" })
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                record_probe::save(
                    "scope_thunk_ownership",
                    &format!("{memory}{opt}-normal-stress{stress}-poison{poison}"),
                    &code,
                    &exe,
                    &output,
                );
                assert!(output.status.success(), "{memory} {opt}: {output:?}");
                assert!(
                    output.stdout.is_empty() && output.stderr.is_empty(),
                    "{output:?}"
                );
            }
            fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
            let stress = if memory == "arc" { "0" } else { "1" };
            let output = Command::new(&exe)
                .env("FWP_GC", if memory == "arc" { "off" } else { "on" })
                .env("FWP_GC_STATS", "0")
                .env("FWP_GC_STRESS", stress)
                .env("FWP_GC_VERIFY", stress)
                .env("FWP_REUSE_VERIFY", stress)
                .output()
                .unwrap();
            record_probe::save(
                "scope_thunk_ownership",
                &format!("{memory}{opt}-program"),
                &emitted,
                &exe,
                &output,
            );
            assert_eq!(output.status.code(), reference.status.code(), "{output:?}");
            assert_eq!(output.stdout, reference.stdout);
            assert_eq!(output.stderr, reference.stderr);
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
