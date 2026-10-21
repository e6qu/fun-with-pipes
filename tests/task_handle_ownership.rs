//! Task handles, scheduler ownership and repeated awaits own independent references.
use std::process::Command;

#[test]
fn task_handles_and_cached_results_have_independent_owners() {
    let dir = std::env::temp_dir().join(format!("fwp-task-handle-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join(if cfg!(windows) { "probe.exe" } else { "probe" });
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
    assert!(runtime.contains("static void fwp_task_drop("));
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
 fwp_task *t=(fwp_task *)(uintptr_t)fSPAWN(fn);
 if(*fwp_rc_slot(PTR(t))!=2)return 1; // caller and scheduler
 fwp_rc_dup(PTR(t));V first=fAWAIT(PTR(t));
 if(first==FWP_NONE||OBJ(first)->f[0]!=capture||*fwp_rc_slot(capture)!=2)return 2;
 if(*fwp_rc_slot(PTR(t))!=2||t->stack||t->base)return 3; // two caller aliases, no scheduler or stack borrow
 V second=fAWAIT(PTR(t));if(OBJ(second)->f[0]!=capture||*fwp_rc_slot(capture)!=3)return 4;
 fwp_option_result fields=fwp_task_await_fields(PTR(t),fwp_rc_dup);
 if(fields.tag!=1||fields.value!=capture||*fwp_rc_slot(capture)!=4)return 26;
 text_drop(fields.value);
 fwp_task_drop(PTR(t));if(*fwp_rc_slot(PTR(t))!=1)return 5;
 fwp_task_drop(PTR(t));if(*fwp_rc_slot(capture)!=2)return 6;
 option_drop(first);if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 7;
 option_drop(second);if(!dead(capture))return 8;
 // Giving up the only handle before entry leaves the scheduler owner alive.
 capture=fwp_rc_fresh(fwp_str_new("early",5));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_task_drop(PTR(t));
 if(*fwp_rc_slot(PTR(t))!=1)return 9;
 fwp_tasks_finish();if(!dead(capture))return 10;
 // The scope array holds done tasks after external handles are discarded.
 fwp_scope scope={0};fwp_cur->scope=&scope;
 capture=fwp_rc_fresh(fwp_str_new("scope",5));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);
 if(*fwp_rc_slot(PTR(t))!=3)return 11;
 fwp_task_drop(PTR(t));fwp_tasks_finish();
 if(*fwp_rc_slot(PTR(t))!=1||*fwp_rc_slot(capture)!=1||t->stack||t->base||scope.tasks[0]!=t)return 12;
 fwp_scope_owner scope_owner={fwp_cur,&scope,fwp_handlers};fwp_scope_release(&scope_owner);
 if(!dead(capture)||fwp_cur->scope)return 13;
 for(int suspended=0;suspended<2;suspended++){
  capture=fwp_rc_fresh(fwp_str_new("cancel",6));fn=fwp_rc_fresh(fwp_pap(SLEEPING,1,&capture));
  t=(fwp_task *)(uintptr_t)fSPAWN(fn);
  if(suspended)fwp_p_task_yield();fwp_p_task_cancel(PTR(t));
  if(fAWAIT(PTR(t))!=FWP_NONE||!dead(capture)||*fwp_rc_slot(PTR(t))!=1||t->base)return 14;
  fields=fwp_task_await_fields(PTR(t),fwp_rc_dup);
  if(fields.tag||fields.value!=FWP_NONE)return 27;
  fwp_task_drop(PTR(t));
 }
 // Unmodeled boundaries promote the task graph to the tracing fallback.
 capture=fwp_rc_fresh(fwp_str_new("shared",6));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_rc_share(PTR(t));
 V shared=fAWAIT(PTR(t));
 if(*fwp_rc_slot(PTR(t))||*fwp_rc_slot(capture)||OBJ(shared)->f[0]!=capture)return 24;
 fwp_task_drop(PTR(t));fwp_gc_collect();FWP_KEEP_ALIVE(shared);FWP_KEEP_ALIVE(PTR(t));
 if(STR(OBJ(shared)->f[0])->len!=6)return 25;option_drop(shared);
 // A finished old task still roots a young result through minor collection.
 fn=fwp_rc_fresh(fwp_pap(FRESH,0,NULL));t=(fwp_task *)(uintptr_t)fSPAWN(fn);
 fwp_gc_collect();fwp_gc_collect();FWP_KEEP_ALIVE(PTR(t));fwp_tasks_finish();
 fwp_gc.major_next=0;size_t minors=fwp_gc.nminor;fwp_gc_collect();FWP_KEEP_ALIVE(PTR(t));
 if(fwp_gc.nminor!=minors+1||!t->result||STR(t->result)->len!=10||*fwp_rc_slot(t->result)!=1)return 23;
 fwp_task_drop(PTR(t));
 // An overflowing await retain releases the partial Option, not the cache.
 capture=fwp_rc_fresh(fwp_str_new("overflow",8));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_tasks_finish();
 uint8_t *slot=fwp_rc_slot(capture);*slot=254;fwp_rc_dup(capture);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;
 fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
 if(setjmp(failed)==0){fAWAIT(PTR(t));return 15;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(fwp_cleanups||*fwp_rc_slot(PTR(t))!=1||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 16;
 if(fwp_reuse_verify?OBJ(await_option)->tag!=0xdead:*fwp_rc_slot(await_option)!=0)return 17;
 // Direct fields allocate no outer Option and preserve the task on retain failure.
 fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
 if(setjmp(failed)==0){fwp_task_await_fields(PTR(t),fwp_rc_dup);return 28;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(fwp_cleanups||*fwp_rc_slot(PTR(t))!=1||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 29;
 fwp_rc_forget_slot(slot);*slot=1;fwp_task_drop(PTR(t));if(!dead(capture))return 18;
 // A failed private await also gives up the deadline helper's task handle.
 capture=fwp_rc_fresh(fwp_str_new("private",7));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 V duration=fwp_record(1,(V[]){INT64_C(3600000000000)});fail_result_dup=1;fwp_rc_dup(fn);
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
    let direct_retain = "if (dup) dup(value);\n    return (fwp_option_result){1, value};";
    assert_eq!(runtime.matches(direct_retain).count(), 1);
    let no_fields_duplicate = runtime.replace(
        direct_retain,
        "/* omit direct await result retain */\n    return (fwp_option_result){1, value};",
    );
    let no_scheduler = runtime.replace(
        "if (ownership == FWP_TASK_SHARED) fwp_task_drop(PTR(finished));",
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
    // Detached C tasks have a single scheduler owner and no language handle.
    let unique_probe = r#"
static int entered,finished,mode;
static double charged(void){return fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);}
static void finish(void *arg){(void)arg;if(fwp_cur->base)_Exit(206);finished++;}
static void worker(void *arg,int stop){
 (void)arg;if(stop)return;fwp_check_cancel();entered++;
 if(mode==2){fwp_park(0,0);fwp_check_cancel();}
}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 int measured=!strcmp(getenv("FWP_GC"),"off");
 double start=charged();
 for(int i=0;i<64;i++)for(mode=0;mode<3;mode++){
  entered=finished=0;
  fwp_task *t=fwp_spawn_task(0,worker,0,0,1);
  t->ownership=FWP_TASK_UNIQUE;t->cfinish=finish;
  if(*fwp_rc_slot(PTR(t)))return 201;
  if(mode==2){fwp_p_task_yield();if(entered!=1)return 202;}
  if(mode)fwp_cancel_tree(t);
  // Await would read a freed task; only the scheduler's live list is borrowed.
  while(fwp_gc_tasks){fwp_make_ready(fwp_root);fwp_block();fwp_free_zombie();}
  fwp_free_zombie();
  if(finished!=1||entered!=(mode==1?0:1)||fwp_zombie){fprintf(stderr,"unique task iteration=%d mode=%d entered=%d finished=%d zombie=%p\n",i,mode,entered,finished,(void*)fwp_zombie);return 203;}
#ifndef FWP_RESOURCE_NO_FREE
  if(measured&&(charged()!=start||fwp_gc.ncollect)){fprintf(stderr,"unique task storage iteration=%d mode=%d before=%.0f after=%.0f collections=%zu\n",i,mode,start,charged(),fwp_gc.ncollect);return 204;}
#else
  if(measured&&(charged()<=start||fwp_gc.ncollect))return 205;
  start=charged();
#endif
 }
 return 0;
}
"#;
    let unique_release = "if (ownership == FWP_TASK_UNIQUE) fwp_task_dispose(PTR(finished));";
    assert_eq!(runtime.matches(unique_release).count(), 1);
    for opt in ["-O1", "-O2"] {
        for release in [
            "/* omitted sole owner */",
            "if (ownership == FWP_TASK_UNIQUE) fwp_task_drop(PTR(finished));",
        ] {
            let broken = runtime.replace(unique_release, release);
            fwp::cgen::compile_c(&format!("{broken}\n{unique_probe}"), &exe, opt).unwrap();
            let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
            assert_eq!(out.status.code(), Some(204), "unique task release: {out:?}");
        }
        let unique_code = format!("{runtime}\n{unique_probe}");
        fwp::cgen::compile_c(&unique_code, &exe, opt).unwrap();
        if let Some(folder) = std::env::var_os("FWP_REPEATED_CLIENT_ARTIFACTS") {
            let folder = std::path::PathBuf::from(folder).join("task-owners");
            std::fs::create_dir_all(&folder).unwrap();
            std::fs::write(folder.join(format!("unique{opt}.c")), &unique_code).unwrap();
            std::fs::copy(&exe, folder.join(format!("unique{opt}.exe"))).unwrap();
        }
        for gc in ["off", "on"] {
            for poison in ["0", "1"] {
                let out = Command::new(&exe)
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                assert!(
                    out.status.success(),
                    "unique task {opt}/{gc}/{poison}: {out:?}"
                );
            }
        }
    }
    for opt in ["-O1", "-O2"] {
        let retained = format!("#define FWP_RESOURCE_NO_FREE 1\n{runtime}\n{unique_probe}");
        fwp::cgen::compile_c(&retained, &exe, opt).unwrap();
        let out = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
        assert!(out.status.success(), "disabled task freeing {opt}: {out:?}");
        for (control, code) in [
            (&no_duplicate, 2),
            (&no_fields_duplicate, 26),
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
