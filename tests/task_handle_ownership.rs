//! Task handles, scheduler ownership and repeated awaits own independent references.
use std::process::Command;

#[test]
fn task_handles_and_cached_results_have_independent_owners() {
    let dir = std::env::temp_dir().join(format!("fwp-task-handle-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    std::fs::write(&source, r#"value : String -> () -> String
value = const
fresh : () -> String
fresh = const "fresh" | string.repeat 2
sleeping : String -> () -> String ! {Async}
sleeping = curry (.0 | tap (const 1h | task.sleep))
main = [ task.spawn (value ("input" | string.repeat 2)) | tap (task.await | echo) | task.await | echo,
 task.spawn (sleeping ("cancel" | string.repeat 2)) | tap task.cancel | task.await | echo,
 task.within 1h (value ("within" | string.repeat 2)) | echo,
 task.spawn fresh | task.await | echo] | ignore
"#).unwrap();
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
        let start = emitted.find(&format!("/* {name} :")).unwrap();
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
    let runtime = if runtime.contains("static void fwp_task_drop(") {
        runtime
    } else {
        format!("{runtime}\nstatic void fwp_task_drop(V v){{fwp_rc_drop(v);}}\n")
    };
    let runtime = runtime
        .replace(
            "static V fwp_await_owned(",
            "static V await_option;static int fail_result_dup;\nstatic V fwp_await_owned(",
        )
        .replace(
            "V result = fwp_rc_fresh(fwp_await(t));",
            "V result = fwp_rc_fresh(fwp_await(t));await_option=result;",
        )
        .replace(
            "if (dup) dup(OBJ(result)->f[0]);",
            "if (dup) {if(fail_result_dup)fwp_trap(\"duplicate probe\");dup(OBJ(result)->f[0]);}",
        );
    let probe = r#"
static jmp_buf failed;static int recover(void){return 1;}
static int dead(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
static void text_drop(V v){if(fwp_rc_release_last(v))fwp_rc_free_obj(v);}
static void option_drop(V v){if(v&&fwp_rc_release_last(v)){text_drop(OBJ(v)->f[0]);fwp_rc_free_obj(v);}}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 V capture=fwp_rc_fresh(fwp_str_new("input",5));V fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 fwp_task *t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_closure_drop(fn);
 if(*fwp_rc_slot(PTR(t))!=2)return 1; // caller and scheduler
 fwp_rc_dup(PTR(t));V first=fAWAIT(PTR(t));
 if(first==FWP_NONE||OBJ(first)->f[0]!=capture||*fwp_rc_slot(capture)!=2)return 2;
 if(*fwp_rc_slot(PTR(t))!=2||t->stack)return 3; // two caller aliases, no scheduler
 V second=fAWAIT(PTR(t));if(OBJ(second)->f[0]!=capture||*fwp_rc_slot(capture)!=3)return 4;
 fwp_task_drop(PTR(t));if(*fwp_rc_slot(PTR(t))!=1)return 5;
 fwp_task_drop(PTR(t));if(*fwp_rc_slot(capture)!=2)return 6;
 option_drop(first);if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 7;
 option_drop(second);if(!dead(capture))return 8;
 // Giving up the only handle before entry leaves the scheduler owner alive.
 capture=fwp_rc_fresh(fwp_str_new("early",5));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_closure_drop(fn);fwp_task_drop(PTR(t));
 if(*fwp_rc_slot(PTR(t))!=1)return 9;
 fwp_tasks_finish();if(!dead(capture))return 10;
 // The scope array holds done tasks after external handles are discarded.
 fwp_scope scope={0};fwp_cur->scope=&scope;
 capture=fwp_rc_fresh(fwp_str_new("scope",5));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_closure_drop(fn);
 if(*fwp_rc_slot(PTR(t))!=3)return 11;
 fwp_task_drop(PTR(t));fwp_tasks_finish();
 if(*fwp_rc_slot(PTR(t))!=1||*fwp_rc_slot(capture)!=1||t->stack||scope.tasks[0]!=t)return 12;
 fwp_scope_owner scope_owner={fwp_cur,&scope,fwp_handlers};fwp_scope_release(&scope_owner);
 if(!dead(capture)||fwp_cur->scope)return 13;
 for(int suspended=0;suspended<2;suspended++){
  capture=fwp_rc_fresh(fwp_str_new("cancel",6));fn=fwp_rc_fresh(fwp_pap(SLEEPING,1,&capture));
  t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_closure_drop(fn);
  if(suspended)fwp_p_task_yield();fwp_p_task_cancel(PTR(t));
  if(fAWAIT(PTR(t))!=FWP_NONE||!dead(capture)||*fwp_rc_slot(PTR(t))!=1)return 14;
  fwp_task_drop(PTR(t));
 }
 // Unmodeled boundaries promote the task graph to the tracing fallback.
 capture=fwp_rc_fresh(fwp_str_new("shared",6));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_closure_drop(fn);fwp_rc_share(PTR(t));
 V shared=fAWAIT(PTR(t));
 if(*fwp_rc_slot(PTR(t))||*fwp_rc_slot(capture)||OBJ(shared)->f[0]!=capture)return 24;
 fwp_task_drop(PTR(t));fwp_gc_collect();FWP_KEEP_ALIVE(shared);FWP_KEEP_ALIVE(PTR(t));
 if(STR(OBJ(shared)->f[0])->len!=6)return 25;option_drop(shared);
 // A finished old task still roots a young result through minor collection.
 fn=fwp_rc_fresh(fwp_pap(FRESH,0,NULL));t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_closure_drop(fn);
 fwp_gc_collect();fwp_gc_collect();FWP_KEEP_ALIVE(PTR(t));fwp_tasks_finish();
 fwp_gc.major_next=0;size_t minors=fwp_gc.nminor;fwp_gc_collect();FWP_KEEP_ALIVE(PTR(t));
 if(fwp_gc.nminor!=minors+1||!t->result||STR(t->result)->len!=10||*fwp_rc_slot(t->result)!=1)return 23;
 fwp_task_drop(PTR(t));
 // An overflowing await retain releases the partial Option, not the cache.
 capture=fwp_rc_fresh(fwp_str_new("overflow",8));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_closure_drop(fn);fwp_tasks_finish();
 uint8_t *slot=fwp_rc_slot(capture);*slot=254;fwp_rc_dup(capture);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;
 fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
 if(setjmp(failed)==0){fAWAIT(PTR(t));return 15;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(fwp_cleanups||*fwp_rc_slot(PTR(t))!=1||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 16;
 if(fwp_reuse_verify?OBJ(await_option)->tag!=0xdead:*fwp_rc_slot(await_option)!=0)return 17;
 fwp_rc_forget_slot(slot);*slot=1;fwp_task_drop(PTR(t));if(!dead(capture))return 18;
 // A failed private await also gives up the deadline helper's task handle.
 capture=fwp_rc_fresh(fwp_str_new("private",7));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 V duration=fwp_record(1,(V[]){INT64_C(3600000000000)});fail_result_dup=1;
 fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
 if(setjmp(failed)==0){fWITHIN(duration,fn);return 19;}
 fwp_trap_recover=0;fwp_trap_jb=0;fail_result_dup=0;
 if(fwp_cleanups||*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=1)return 20;
 if(fwp_reuse_verify?OBJ(await_option)->tag!=0xdead:*fwp_rc_slot(await_option)!=0)return 21;
 fwp_closure_drop(fn);if(!dead(capture))return 22;
 return 0;
}
"#.replace("FRESH", &id("fresh")).replace("SLEEPING", &id("sleeping")).replace("VALUE", &id("value")).replace("SPAWN", &id("task.spawn")).replace("AWAIT", &id("task.await")).replace("WITHIN", &id("task.within"));
    let no_duplicate = runtime.replace(
        "if (dup) {if(fail_result_dup)fwp_trap(\"duplicate probe\");dup(OBJ(result)->f[0]);}",
        "/* omit await result retain */",
    );
    let no_result = runtime.replace(
        "if (t->result_drop && result) t->result_drop(result);",
        "/* omit cached result destruction */",
    );
    let no_scheduler = runtime.replace(
        "if (finished->counted) fwp_task_drop(PTR(finished));",
        "/* omit scheduler release */",
    );
    let no_scope = runtime.replace(
        "if (fwp_cur->scope) fwp_rc_dup(PTR(t));",
        "/* omit scope owner */",
    );
    let no_outer = runtime.replace(
        "fwp_value_owner owner = {result, fwp_task_option_outer_drop};",
        "fwp_value_owner owner = {result, NULL};",
    );
    let no_private = runtime.replace(
        "fwp_value_owner owner = {PTR(t), fwp_task_drop};",
        "fwp_value_owner owner = {PTR(t), NULL};",
    );
    for opt in ["-O1", "-O2"] {
        for (control, code) in [
            (&no_duplicate, 2),
            (&no_result, 6),
            (&no_scheduler, 3),
            (&no_scope, 11),
            (&no_outer, 17),
            (&no_private, 20),
        ] {
            fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
            let out = Command::new(&exe)
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(out.status.code(), Some(code));
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
