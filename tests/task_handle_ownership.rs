//! Task handles, scheduler ownership and repeated awaits own independent references.
use std::process::Command;

#[path = "support/record_probe.rs"]
mod record_probe;

#[test]
fn task_handles_and_cached_results_have_independent_owners() {
    let dir = std::env::temp_dir().join(format!("fwp-task-handle-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
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
static int dead(V v){
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return STR(v)->len==0;
#endif
 uint8_t *slot=fwp_rc_slot(v);return !slot||!*slot;
}
static int dead_option(V v){
#ifndef FWP_ARC_ONLY
 if(fwp_reuse_verify)return OBJ(v)->tag==0xdead;
#endif
 uint8_t *slot=fwp_rc_slot(v);return !slot||!*slot;
}
static void text_drop(V v){if(fwp_rc_release_last(v))fwp_rc_free_obj(v);}
static void option_drop(V v){if(v&&fwp_rc_release_last(v)){text_drop(OBJ(v)->f[0]);fwp_rc_free_obj(v);}}
int main(void){
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 size_t baseline=fwp_heap.live;
 for(int round=0;round<32;round++){
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
 // A counted task cannot lose its ownership contract in ARC.
 capture=fwp_rc_fresh(fwp_str_new("shared",6));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);
#ifdef FWP_ARC_ONLY
 fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
 if(setjmp(failed)==0){fwp_rc_share(PTR(t));return 30;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(strcmp(fwp_trap_msg,"internal: counted owner escaped ARC contract")||*fwp_rc_slot(PTR(t))!=2||*fwp_rc_slot(capture)!=1)return 31;
 V shared=fAWAIT(PTR(t));
 if(OBJ(shared)->f[0]!=capture||*fwp_rc_slot(capture)!=2||STR(capture)->len!=6)return 32;
 option_drop(shared);fwp_task_drop(PTR(t));if(!dead(capture))return 33;
#else
 fwp_rc_share(PTR(t));
 V shared=fAWAIT(PTR(t));
 if(*fwp_rc_slot(PTR(t))||*fwp_rc_slot(capture)||OBJ(shared)->f[0]!=capture)return 24;
 fwp_task_drop(PTR(t));fwp_heap_collect();FWP_KEEP_ALIVE(shared);FWP_KEEP_ALIVE(PTR(t));
 if(STR(OBJ(shared)->f[0])->len!=6)return 25;option_drop(shared);
#endif
 // A finished old task still roots a young result through minor collection.
 fn=fwp_rc_fresh(fwp_pap(FRESH,0,NULL));t=(fwp_task *)(uintptr_t)fSPAWN(fn);
#ifndef FWP_ARC_ONLY
 fwp_heap_collect();fwp_heap_collect();FWP_KEEP_ALIVE(PTR(t));
#endif
 fwp_tasks_finish();
#ifndef FWP_ARC_ONLY
 fwp_heap.major_next=0;size_t minors=fwp_heap.nminor;fwp_heap_collect();FWP_KEEP_ALIVE(PTR(t));
 if(fwp_heap.nminor!=minors+1)return 23;
#endif
 if(!t->result||STR(t->result)->len!=10||*fwp_rc_slot(t->result)!=1)return 23;
 fwp_task_drop(PTR(t));
 // An overflowing await retain releases the partial Option, not the cache.
 capture=fwp_rc_fresh(fwp_str_new("overflow",8));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_tasks_finish();
 uint8_t *slot=fwp_rc_slot(capture);*slot=254;fwp_rc_dup(capture);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;
 fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
 if(setjmp(failed)==0){fAWAIT(PTR(t));return 15;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(fwp_cleanups||*fwp_rc_slot(PTR(t))!=1||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 16;
 if(!dead_option(await_option))return 17;
 // Direct fields allocate no outer Option and preserve the task on retain failure.
 fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
 if(setjmp(failed)==0){fwp_task_await_fields(PTR(t),fwp_rc_dup);return 28;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(fwp_cleanups||*fwp_rc_slot(PTR(t))!=1||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 29;
 fwp_rc_forget_slot(slot);*slot=1;fwp_task_drop(PTR(t));if(!dead(capture))return 18;
 // A failed private await also gives up the deadline helper's task handle.
 capture=fwp_rc_fresh(fwp_str_new("private",7));fn=fwp_rc_fresh(fwp_pap(VALUE,1,&capture));
 V duration=fwp_rc_fresh(fwp_record(1,(V[]){INT64_C(3600000000000)}));fail_result_dup=1;fwp_rc_dup(fn);
 fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
 if(setjmp(failed)==0){fWITHIN(duration,fn);return 19;}
 fwp_trap_recover=0;fwp_trap_jb=0;fail_result_dup=0;
 if(fwp_cleanups||*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=1)return 20;
 if(!dead_option(await_option))return 21;
 fwp_closure_drop(fn);if(!dead(capture))return 22;
 fwp_rc_free_obj(duration);fwp_free_zombie();
#ifdef FWP_ARC_ONLY
 if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len||fwp_heap.ncollect)return 90;
#endif
 }
 fwp_tasks_finish();fwp_native_tasks_finish();
#ifdef FWP_ARC_ONLY
 if(fwp_heap.live!=0)return 90;
#endif
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
static double charged(void){return (double)fwp_heap.live;}
static void finish(void *arg){(void)arg;if(fwp_cur->base)_Exit(206);finished++;}
static void worker(void *arg,int stop){
 (void)arg;if(stop)return;fwp_check_cancel();entered++;
 if(mode==2){fwp_park(0,0);fwp_check_cancel();}
}
int main(void){
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
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
  while(fwp_tasks_active){fwp_make_ready(fwp_root);fwp_block();fwp_free_zombie();}
  fwp_free_zombie();
  if(finished!=1||entered!=(mode==1?0:1)||fwp_zombie){fprintf(stderr,"unique task iteration=%d mode=%d entered=%d finished=%d zombie=%p\n",i,mode,entered,finished,(void*)fwp_zombie);return 203;}
#ifndef FWP_RESOURCE_NO_FREE
  if(measured&&(charged()!=start||fwp_heap.ncollect)){fprintf(stderr,"unique task storage iteration=%d mode=%d before=%.0f after=%.0f collections=%zu\n",i,mode,start,charged(),fwp_heap.ncollect);return 204;}
#else
  if(measured&&(charged()<=start||fwp_heap.ncollect))return 205;
  start=charged();
#endif
 }
 fwp_tasks_finish();fwp_native_tasks_finish();
#if defined(FWP_ARC_ONLY) && !defined(FWP_RESOURCE_NO_FREE)
 if(fwp_heap.live!=0||fwp_heap.rc_wide_len||fwp_heap.ncollect)return 90;
#endif
 return 0;
}
"#;
        let unique_release = "if (ownership == FWP_TASK_UNIQUE) fwp_task_dispose(PTR(finished));";
        assert_eq!(runtime.matches(unique_release).count(), 1);
        for opt in ["-O1", "-O2"] {
            for (case, release) in [
                ("missing", "/* omitted sole owner */"),
                (
                    "counted",
                    "if (ownership == FWP_TASK_UNIQUE) fwp_task_drop(PTR(finished));",
                ),
            ] {
                let broken = runtime.replace(unique_release, release);
                let code = format!("{broken}\n{unique_probe}");
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
                    "task_handle_ownership",
                    &format!("{memory}{opt}-unique-{case}"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(output.status.code(), Some(204), "{output:?}");
            }
            let unique_code = format!("{runtime}\n{unique_probe}");
            fwp::cgen::compile_c(&unique_code, &exe, opt).unwrap();
            for (gc, poison) in if memory == "arc" {
                &[("off", "0")][..]
            } else {
                &[("off", "0"), ("off", "1"), ("on", "0"), ("on", "1")][..]
            } {
                let stress = if memory == "arc" { "0" } else { "1" };
                let output = Command::new(&exe)
                    .env("FWP_GC", gc)
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                record_probe::save(
                    "task_handle_ownership",
                    &format!("{memory}{opt}-unique-normal-gc{gc}-poison{poison}"),
                    &unique_code,
                    &exe,
                    &output,
                );
                assert!(output.status.success(), "{memory} {opt}: {output:?}");
                assert!(
                    output.stdout.is_empty() && output.stderr.is_empty(),
                    "{output:?}"
                );
            }
            if let Some(folder) = std::env::var_os("FWP_REPEATED_CLIENT_ARTIFACTS") {
                let folder = std::path::PathBuf::from(folder).join("task-owners");
                std::fs::create_dir_all(&folder).unwrap();
                std::fs::write(folder.join(format!("{memory}-unique{opt}.c")), &unique_code)
                    .unwrap();
                std::fs::copy(&exe, folder.join(format!("{memory}-unique{opt}.exe"))).unwrap();
            }
            let code = format!("#define FWP_RESOURCE_NO_FREE 1\n{runtime}\n{unique_probe}");
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
                "task_handle_ownership",
                &format!("{memory}{opt}-unique-retained"),
                &code,
                &exe,
                &output,
            );
            assert!(output.status.success(), "{output:?}");
            for (case, control, expected) in [
                ("missing-duplicate", &no_duplicate, 2),
                ("missing-fields", &no_fields_duplicate, 26),
                ("missing-result", &no_result, 6),
                ("missing-scheduler", &no_scheduler, 3),
                ("missing-scope", &no_scope, 11),
                ("missing-option", &no_outer, 17),
                ("missing-private", &no_private, 20),
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
                    "task_handle_ownership",
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
            if memory == "arc" {
                let missing =
                    probe.replace("fwp_rc_free_obj(duration);", "/* omit duration release */");
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
                    "task_handle_ownership",
                    &format!("{memory}{opt}-missing-duration"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(output.status.code(), Some(90), "{output:?}");
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
                    "task_handle_ownership",
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
                "task_handle_ownership",
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
