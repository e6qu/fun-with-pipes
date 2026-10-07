//! Spawned tasks retain a callback owner and release captures on completion/cancel.
use std::process::Command;
const SOURCE: &str = r#"plain : String -> () -> I64
plain = curry (.0 | string.length)
sleeping : String -> () -> I64 ! {Async}
sleeping = curry (.0 | tap (const 1h | task.sleep) | string.length)
word : I64 -> () -> I64
word = const
main = [
 task.spawn (plain ("input" | string.repeat 2)) | task.await | echo,
 task.spawn (sleeping ("input" | string.repeat 2)) | tap task.cancel | task.await | echo,
 task.spawn (word 17) | task.await | echo,
] | ignore
"#;
#[test]
fn spawned_thunks_release_captures_and_preserve_external_aliases() {
    let dir = std::env::temp_dir().join(format!("fwp-retained-thunk-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let reference = Command::new(fwp)
        .args(["run", "--interp"])
        .arg(&src)
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
        .arg(&src)
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
    let probe=r#"
static int dead(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 for(int mode=0;mode<3;mode++)for(int alias=0;alias<2;alias++){
  V capture=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(capture);
  V fn=fwp_rc_fresh(fwp_pap(mode==2?SLEEPING:PLAIN,1,&capture));
  fwp_task *t=(fwp_task *)(uintptr_t)fSPAWN(fn);
  if(*fwp_rc_slot(fn)!=2||*fwp_rc_slot(capture)!=alias+1)return 1;
  fwp_closure_drop(fn);
  fwp_gc_collect();FWP_KEEP_ALIVE(capture);FWP_KEEP_ALIVE(PTR(t));
  if(mode==2)fwp_p_task_yield();
  if(mode)fwp_p_task_cancel(PTR(t));
  V result=fwp_await(t);
  if(mode==0){if(result==FWP_NONE||OBJ(result)->f[0]!=5)return 2;fwp_rc_free_obj(fwp_rc_fresh(result));}
  else if(result!=FWP_NONE)return 3;
  if(t->thunk)return 4;
  if(alias){if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 5;fwp_rc_free_obj(capture);}
  else if(!dead(capture))return 6;
 }
 // An integer that resembles a heap pointer remains an uncounted word.
 V scalar=fwp_rc_fresh(fwp_str_new("scalar",6));V fn=fwp_rc_fresh(fwp_pap(WORD,1,&scalar));
 fwp_task *t=(fwp_task *)(uintptr_t)fSPAWN(fn);fwp_closure_drop(fn);V result=fwp_await(t);
 if(result==FWP_NONE||OBJ(result)->f[0]!=scalar||*fwp_rc_slot(scalar)!=1)return 7;
 fwp_rc_free_obj(fwp_rc_fresh(result));fwp_rc_free_obj(scalar);
 // Unknown callback metadata retains the conservative shared fallback.
 fwp_fninfo table[sizeof(fwp_fn_table)/sizeof(fwp_fn_table[0])];
 memcpy(table,fwp_fn_table,sizeof(table));table[PLAIN].owned=0;fwp_fns=table;
 V capture=fwp_rc_fresh(fwp_str_new("input",5));fn=fwp_rc_fresh(fwp_pap(PLAIN,1,&capture));
 t=(fwp_task *)(uintptr_t)fSPAWN(fn);
 if(*fwp_rc_slot(fn)||*fwp_rc_slot(capture))return 8;
 fwp_closure_drop(fn);result=fwp_await(t);
 if(result==FWP_NONE||OBJ(result)->f[0]!=5)return 9;
 fwp_rc_free_obj(fwp_rc_fresh(result));fwp_tasks_finish();fwp_fns=fwp_fn_table;return 0;
}
"#.replace("SLEEPING",&id("sleeping")).replace("PLAIN",&id("plain")).replace("WORD",&id("word")).replace("SPAWN",&id("task.spawn"));
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let o = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                o.status.success(),
                "code {:?}: {}",
                o.status.code(),
                String::from_utf8_lossy(&o.stderr)
            );
        }
        fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
        let o = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(o.status.code(), reference.status.code());
        assert_eq!(o.stdout, reference.stdout);
        assert_eq!(o.stderr, reference.stderr);
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn failing_spawn_preparation_releases_only_its_extra_thunk_owner() {
    let dir =
        std::env::temp_dir().join(format!("fwp-retained-thunk-failure-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let build = Command::new(fwp)
        .arg("build")
        .arg(&src)
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
    let point = "static fwp_task *fwp_spawn_task(";
    let runtime=emitted.replacen(point,r#"static int fail_stack;
static void *task_stack_map(void *a,size_t n,int p,int f,int fd,off_t o){if(fail_stack){fail_stack=0;errno=ENOMEM;return MAP_FAILED;}return mmap(a,n,p,f,fd,o);}
static fwp_task *fwp_spawn_task("#,1)
        .replace("t->stack = (char *)mmap(0, t->stack_size,","t->stack = (char *)task_stack_map(0, t->stack_size,")
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let probe=r#"
static jmp_buf failed;static int recover(void){return 1;}
static int dead(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 fwp_scope scope={0};fwp_cur->scope=&scope;
 for(int mode=0;mode<3;mode++)for(int alias=0;alias<2;alias++){
  V capture=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(capture);V fn=fwp_rc_fresh(fwp_pap(PLAIN,1,&capture));
  fwp_task *gc_before=fwp_gc_tasks;
  if(mode==0)fail_stack=1;else if(mode==2){scope.n=SIZE_MAX;scope.cap=SIZE_MAX;}else{uint8_t *slot=fwp_rc_slot(fn);*slot=254;fwp_rc_dup(fn);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;}
  fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
  if(setjmp(failed)==0){fSPAWN(fn);return 1;}
  fwp_trap_recover=0;fwp_trap_jb=0;
  if(fwp_cleanups||fwp_cur->first_child||fwp_gc_tasks!=gc_before)return 2;
  if(mode==2){if(scope.n!=SIZE_MAX||scope.cap!=SIZE_MAX)return 8;scope.n=0;scope.cap=8;}else if(scope.n)return 9;
  if(mode==1){uint8_t *slot=fwp_rc_slot(fn);if(*slot!=255||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 3;fwp_rc_forget_slot(slot);*slot=1;}
  if(*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=alias+1)return 4;
  fwp_closure_drop(fn);
  if(alias){if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 5;fwp_rc_free_obj(capture);}
  else if(!dead(capture))return 6;
 }
 fwp_cur->scope=0;fwp_mem_free(scope.tasks);return 0;
}
"#.replace("PLAIN",&id("plain")).replace("SPAWN",&id("task.spawn"));
    let publish = r#"    if (!detached) {
        t->parent = fwp_cur;
        t->next_sibling = fwp_cur->first_child;
        if (fwp_cur->first_child) fwp_cur->first_child->prev_sibling = t;
        fwp_cur->first_child = t;
        if (fwp_cur->cancelled) t->cancelled = 1;
    }
    if (s) s->tasks[s->n++] = t;
"#;
    assert!(runtime.contains(publish));
    let early = runtime.replacen(publish, "", 1).replacen(
        "#ifdef FWP_FIBERS\n    if (!fwp_hooks.sw)",
        &format!("{publish}#ifdef FWP_FIBERS\n    if (!fwp_hooks.sw)"),
        1,
    );
    let extra = runtime
        .replacen(
            "fwp_value_protect(&owner, &cleanup);\n    fwp_task *t = fwp_spawn(thunk, 0);",
            "(void)cleanup;\n    fwp_task *t = fwp_spawn(thunk, 0);",
            1,
        )
        .replacen(
            "fwp_value_finish(&owner, &cleanup);\n    return PTR(t);",
            "(void)owner;\n    return PTR(t);",
            1,
        );
    for opt in ["-O1", "-O2"] {
        for (control, expected) in [(&early, 2), (&extra, 4)] {
            fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
            let o = Command::new(&exe)
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(
                o.status.code(),
                Some(expected),
                "missing spawn preparation contract"
            );
        }
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let o = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", poison)
                .output()
                .unwrap();
            assert!(
                o.status.success(),
                "code {:?}: {}",
                o.status.code(),
                String::from_utf8_lossy(&o.stderr)
            );
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
