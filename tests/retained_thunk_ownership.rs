//! Spawned tasks take a callback owner and release captures on completion/cancel.
use std::process::Command;

#[path = "support/client_allocations.rs"]
mod allocations;

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
 task.within 1h (plain ("deadline" | string.repeat 2)) | echo,
 task.within 0ns (sleeping ("deadline" | string.repeat 2)) | echo,
] | ignore
"#;

#[path = "support/record_probe.rs"]
mod record_probe;
#[test]
fn spawned_thunks_release_captures_and_preserve_external_aliases() {
    let dir = std::env::temp_dir().join(format!("fwp-retained-thunk-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
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
    for memory in ["arc", "tracing"] {
        let build = Command::new(fwp)
            .env("FWP_STACK", "0")
            .env_remove("FWP_NO_OPT")
            .args([
                "build", "--memory", "dynamic", "--gc", memory, "-O2", "--emit-c",
            ])
            .arg(&src)
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
        let probe=r#"
static jmp_buf rejected;static int recover(void){return 1;}
static int dead(V v){
 uint8_t *slot=fwp_rc_slot(v);return !slot||!*slot;
}
int main(void){
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 size_t baseline=fwp_heap.live;
 for(int round=0;round<32;round++){
 for(int mode=0;mode<3;mode++)for(int alias=0;alias<2;alias++){
  V capture=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(capture);
  V fn=fwp_rc_fresh(fwp_pap(mode==2?SLEEPING:PLAIN,1,&capture));
  fwp_task *t=(fwp_task *)(uintptr_t)fSPAWN(fn);
  if(*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=alias+1)return 1;
  FWP_KEEP_ALIVE(capture);FWP_KEEP_ALIVE(PTR(t));
  if(mode==2)fwp_p_task_yield();
  if(mode)fwp_p_task_cancel(PTR(t));
  V result=fwp_await(t);
  if(mode==0){if(result==FWP_NONE||OBJ(result)->f[0]!=5)return 2;fwp_rc_free_obj(fwp_rc_fresh(result));}
  else if(result!=FWP_NONE)return 3;
  if(t->thunk)return 4;
  fwp_task_drop(PTR(t));
  if(alias){if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 5;fwp_rc_free_obj(capture);}
  else if(!dead(capture))return 6;
 }
 // An integer that resembles a heap pointer remains an uncounted word.
 V scalar=fwp_rc_fresh(fwp_str_new("scalar",6));V fn=fwp_rc_fresh(fwp_pap(WORD,1,&scalar));
 fwp_task *t=(fwp_task *)(uintptr_t)fSPAWN(fn);V result=fwp_await(t);
 if(result==FWP_NONE||OBJ(result)->f[0]!=scalar||*fwp_rc_slot(scalar)!=1)return 7;
 fwp_option_result fields=fwp_task_await_fields(PTR(t),NULL);
 if(fields.tag!=1||fields.value!=scalar||*fwp_rc_slot(scalar)!=1)return 10;
 fwp_rc_free_obj(fwp_rc_fresh(result));fwp_task_drop(PTR(t));fwp_rc_free_obj(scalar);
 fwp_free_zombie();
 if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
 }
 // A callback without an ownership contract cannot consume counted captures.

 fwp_fninfo table[sizeof(fwp_fn_table)/sizeof(fwp_fn_table[0])];
 memcpy(table,fwp_fn_table,sizeof(table));table[PLAIN].owned=0;fwp_fns=table;
 V capture=fwp_rc_fresh(fwp_str_new("input",5));V fn=fwp_rc_fresh(fwp_pap(PLAIN,1,&capture));
 fwp_trap_recover=recover;fwp_trap_jb=&rejected;fwp_trap_cleanup=0;
 if(setjmp(rejected)==0){fSPAWN(fn);return 11;}
 fwp_trap_recover=0;fwp_trap_jb=0;
 if(strcmp(fwp_trap_msg,"internal: counted owner escaped ARC contract"))return 12;
 if(*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=1||fwp_tasks_active||fwp_cleanups)return 13;
 fwp_fns=fwp_fn_table;fwp_closure_drop(fn);
 fwp_tasks_finish();fwp_native_tasks_finish();
 if(fwp_heap.live!=0||fwp_heap.rc_wide_len)return 90;
 return 0;
}
"#.replace("SLEEPING",&id("sleeping")).replace("PLAIN",&id("plain")).replace("WORD",&id("word")).replace("SPAWN",&id("task.spawn"));
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
                    "retained_thunk_ownership",
                    &format!("{memory}{opt}-completion-missing"),
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
                    "retained_thunk_ownership",
                    &format!("{memory}{opt}-completion-normal-stress{stress}-poison{poison}"),
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
                "retained_thunk_ownership",
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

#[test]
fn failing_spawn_preparation_releases_transferred_owner_and_preserves_alias() {
    let dir =
        std::env::temp_dir().join(format!("fwp-retained-thunk-failure-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    for memory in ["arc", "tracing"] {
        let build = Command::new(fwp)
            .env("FWP_STACK", "0")
            .env_remove("FWP_NO_OPT")
            .args([
                "build", "--memory", "dynamic", "--gc", memory, "-O2", "--emit-c",
            ])
            .arg(&src)
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
        let point = "static fwp_task *fwp_spawn_task(";
        let windows_stack = "t->ctx.fiber = CreateFiberEx(65536, FWP_NATIVE_TASK_STACK,";
        let unix_stack = "t->stack = (char *)mmap(0, t->stack_size,";
        assert_eq!(emitted.matches(windows_stack).count(), 1);
        assert_eq!(emitted.matches(unix_stack).count(), 1);
        let runtime=emitted.replacen(point,r#"static int fail_stack;
#ifdef _WIN32
static void *task_stack_fiber(SIZE_T commit,SIZE_T reserve,DWORD flags,LPFIBER_START_ROUTINE entry,void *arg){if(fail_stack){fail_stack=0;SetLastError(ERROR_NOT_ENOUGH_MEMORY);return NULL;}return CreateFiberEx(commit,reserve,flags,entry,arg);}
#else
static void *task_stack_map(void *a,size_t n,int p,int f,int fd,off_t o){if(fail_stack){fail_stack=0;errno=ENOMEM;return MAP_FAILED;}return mmap(a,n,p,f,fd,o);}
#endif
static fwp_task *fwp_spawn_task("#,1)
        .replace(windows_stack,"t->ctx.fiber = task_stack_fiber(65536, FWP_NATIVE_TASK_STACK,")
        .replace(unix_stack,"t->stack = (char *)task_stack_map(0, t->stack_size,")
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
        let probe=r#"
static jmp_buf failed;static int recover(void){return 1;}
static int dead(V v){
 uint8_t *slot=fwp_rc_slot(v);return !slot||!*slot;
}
int main(void){
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 size_t baseline=fwp_heap.live;
 for(int round=0;round<32;round++){
 fwp_scope scope={0};scope.cap=8;scope.tasks=fwp_mem_alloc(scope.cap*sizeof(*scope.tasks));fwp_cur->scope=&scope;
 for(int mode=0;mode<3;mode++)for(int alias=0;alias<2;alias++){
  V capture=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(capture);V fn=fwp_rc_fresh(fwp_pap(PLAIN,1,&capture));
  fwp_task *heap_before=fwp_tasks_active;
  size_t live_bytes_before=fwp_heap.live;
  if(mode==0)fail_stack=1;else if(mode==2){scope.n=SIZE_MAX;scope.cap=SIZE_MAX;}else{uint8_t *slot=fwp_rc_slot(fn);*slot=254;fwp_rc_dup(fn);(*fwp_rc_wide_link(slot))->count=SIZE_MAX;}
  fwp_trap_recover=recover;fwp_trap_jb=&failed;fwp_trap_cleanup=0;
  if(setjmp(failed)==0){fwp_rc_dup(fn);fSPAWN(fn);return 1;}
  if(mode==0&&fail_stack)return 11;
  fwp_trap_recover=0;fwp_trap_jb=0;
  if(fwp_cleanups||fwp_cur->first_child||fwp_tasks_active!=heap_before)return 2;
  if(mode==2){if(scope.n!=SIZE_MAX||scope.cap!=SIZE_MAX)return 8;scope.n=0;scope.cap=8;}else if(scope.n)return 9;
  if(mode==1){uint8_t *slot=fwp_rc_slot(fn);if(*slot!=255||(*fwp_rc_wide_link(slot))->count!=SIZE_MAX)return 3;fwp_rc_forget_slot(slot);*slot=1;}
  if(*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=alias+1)return 4;
  if(fwp_heap.live!=live_bytes_before)return 10;
  fwp_closure_drop(fn);
  if(alias){if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 5;fwp_rc_free_obj(capture);}
  else if(!dead(capture))return 6;
 }
 fwp_cur->scope=0;fwp_mem_free(scope.tasks);
 if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
 }
 fwp_tasks_finish();fwp_native_tasks_finish();
 if(fwp_heap.live!=0)return 90;
 return 0;
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
        assert_eq!(runtime.matches(publish).count(), 1);
        let stack_start =
            "#ifdef _WIN32\n#ifdef FWP_STATIC_MEMORY\n    if (!fwp_static.ntask_free)";
        assert_eq!(runtime.matches(stack_start).count(), 1);
        let early = runtime.replacen(publish, "", 1).replacen(
            stack_start,
            &format!("{publish}{stack_start}"),
            1,
        );
        assert_eq!(early.matches(publish).count(), 1);
        let extra = runtime
        .replacen(
            "fwp_value_protect(&owner, &cleanup);\n    fwp_task *t = fwp_spawn(thunk, deadline);",
            "(void)cleanup;\n    fwp_task *t = fwp_spawn(thunk, deadline);",
            1,
        )
        .replacen(
            "fwp_value_finish(&owner, &cleanup);\n    return t;",
            "(void)owner;\n    return t;",
            1,
        );
        let task_owner = "    fwp_cleanup_push(&task_cleanup, fwp_mem_free, t);";
        assert_eq!(runtime.matches(task_owner).count(), 1);
        let leaked_task = runtime.replace(task_owner, "").replace(
            "    fwp_cleanup_pop(&task_cleanup);",
            "    (void)task_cleanup;",
        );
        for opt in ["-O1", "-O2"] {
            for (case, control, expected) in [
                ("early-publication", &early, 2),
                ("missing-callback", &extra, 4),
                ("missing-task", &leaked_task, 10),
            ] {
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
                    "retained_thunk_ownership",
                    &format!("{memory}{opt}-preparation-{case}"),
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
                    "retained_thunk_ownership",
                    &format!("{memory}{opt}-preparation-normal-stress{stress}-poison{poison}"),
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
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn transferred_callbacks_remove_a_retain_release_pair() {
    let dir = fwp::cgen::TempDir::new("task-callback-transfer").unwrap();
    let source = dir.join("callbacks.fwp");
    let cfile = dir.join("callbacks.c");
    let binary = dir.join("callbacks.exe");
    std::fs::write(&source, SOURCE).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        reference.status.success() && reference.stderr.is_empty(),
        "{reference:?}"
    );
    for memory in ["arc", "tracing"] {
        let build = Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "-O1", "--gc", memory, "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(build.status.success(), "{build:?}");
        let generated = std::fs::read_to_string(&cfile).unwrap();
        let measured = allocations::instrument_client_allocations(&generated);
        let begin = "    fwp_value_owner owner = {thunk, fwp_closure_drop};";
        let end = "    fwp_value_finish(&owner, &cleanup);\n    return t;";
        assert_eq!(measured.matches(begin).count(), 1);
        assert_eq!(measured.matches(end).count(), 1);
        // Isolate the redundant runtime retain + caller release in identical C.
        // This is not a comparison with a separately compiled old revision.
        let redundant = measured.replace(begin, &format!("    if (client_active && fwp_rc_slot(thunk) && *fwp_rc_slot(thunk)) callback_pairs++;\n    fwp_rc_dup(thunk);\n{begin}"))
            .replace(end, "    fwp_value_finish(&owner, &cleanup);\n    fwp_closure_drop(thunk);\n    return t;");
        for opt in ["-O0", "-O2"] {
            let mut results = Vec::new();
            for (label, code) in [("transfer", &measured), ("redundant-pair", &redundant)] {
                let code = code.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t callback_pairs;")
                    .replace("    client_measure_end();", "    client_measure_end();\n    fprintf(stderr, \"callback-pairs\\t%llu\\n\", (unsigned long long)callback_pairs);");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let output = Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert!(
                    output.status.success(),
                    "{memory}/{opt}/{label}: {output:?}"
                );
                assert_eq!(output.stdout, reference.stdout);
                let stderr = String::from_utf8(output.stderr.clone()).unwrap();
                let lines: Vec<_> = stderr.lines().collect();
                assert_eq!(lines.len(), 2, "{stderr}");
                let counts: Vec<u64> = lines[0]
                    .strip_prefix("client-memory\t")
                    .unwrap()
                    .split('\t')
                    .map(|v| v.parse().unwrap())
                    .collect();
                assert_eq!(counts.len(), 6);
                let pairs: u64 = lines[1]
                    .strip_prefix("callback-pairs\t")
                    .unwrap()
                    .parse()
                    .unwrap();
                if memory == "arc" {
                    assert_eq!(counts[4..], [0, 0]);
                }
                if let Some(path) = std::env::var_os("FWP_QUEUED_FUNCTION_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path).join("callback-transfer");
                    std::fs::create_dir_all(&path).unwrap();
                    let label = format!("{memory}{opt}-{label}");
                    std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
                    std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                    std::fs::write(path.join(format!("{label}.stdout")), &output.stdout).unwrap();
                    std::fs::write(path.join(format!("{label}.stderr")), &output.stderr).unwrap();
                    std::fs::write(
                        path.join(format!("{label}.status")),
                        format!("{:?}\n", output.status.code()),
                    )
                    .unwrap();
                }
                results.push((counts, pairs));
            }
            let (moved, no_pairs) = &results[0];
            let (retained, pairs) = &results[1];
            assert_eq!(*no_pairs, 0);
            assert!(
                *pairs > 0,
                "the workload must include counted callback owners"
            );
            assert_eq!(
                moved[0..2],
                retained[0..2],
                "same allocation requests/bytes"
            );
            assert_eq!(
                moved[3..],
                retained[3..],
                "same peak/final charge and collections"
            );
            assert_eq!(
                retained[2] - moved[2],
                *pairs,
                "one retain per counted callback"
            );
        }
    }
}

#[test]
fn immediate_await_matches_remove_only_the_temporary_option_box() {
    let dir = fwp::cgen::TempDir::new("task-await-fields").unwrap();
    let source = dir.join("await.fwp");
    let cfile = dir.join("await.c");
    let binary = dir.join("await.exe");
    std::fs::write(&source, include_str!("fixtures/task_await_fields.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = Command::new(compiler)
        .env("FWP_NO_OPT", "1")
        .args(["run", "--interp"])
        .arg(&source)
        .output()
        .unwrap();
    assert!(
        reference.status.success() && reference.stderr.is_empty(),
        "{reference:?}"
    );
    assert_eq!(
        reference.stdout,
        b"44\n0\n17\n2.0\n[Some \"escapeescape\"]\n"
    );
    for memory in ["arc", "tracing"] {
        let build = Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "-O1", "--gc", memory, "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(build.status.success(), "{build:?}");
        let generated = std::fs::read_to_string(&cfile).unwrap();
        assert!(
            generated.contains("= fwp_task_await_fields("),
            "no direct await calls"
        );
        let measured = allocations::instrument_client_allocations(&generated);
        let start = measured
            .find("static fwp_option_result fwp_task_await_fields(")
            .unwrap();
        let end = measured[start..]
            .find("\nstatic V fwp_p_task_spawn(")
            .unwrap()
            + start;
        // Restore the former temporary box in identical generated C. The task,
        // result retain, output and escaping Option all do the same work.
        let mut boxed = measured.clone();
        boxed.replace_range(
            start..end,
            r#"static V fwp_await_owned(fwp_task *t, void (*dup)(V));
static fwp_option_result fwp_task_await_fields(V handle, void (*dup)(V)) {
    fwp_tasks_init();
    V option = fwp_await_owned((fwp_task *)(uintptr_t)handle, dup);
    if (option == FWP_NONE) return (fwp_option_result){0, FWP_NONE};
    if (client_active) await_boxes++;
    V value = OBJ(option)->f[0];
    fwp_rc_free_obj(option);
    return (fwp_option_result){1, value};
}
"#,
        );
        for opt in ["-O0", "-O2"] {
            let mut results = Vec::new();
            for (label, code) in [("fields", &measured), ("boxed-control", &boxed)] {
                let code = code.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic uint64_t await_boxes;")
                    .replace("    client_measure_end();", "    client_measure_end();\n    fprintf(stderr, \"await-boxes\\t%llu\\n\", (unsigned long long)await_boxes);");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let output = Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert!(
                    output.status.success(),
                    "{memory}/{opt}/{label}: {output:?}"
                );
                assert_eq!(output.stdout, reference.stdout);
                let stderr = String::from_utf8(output.stderr.clone()).unwrap();
                let lines: Vec<_> = stderr.lines().collect();
                assert_eq!(lines.len(), 2, "{stderr}");
                let counts: Vec<u64> = lines[0]
                    .strip_prefix("client-memory\t")
                    .unwrap()
                    .split('\t')
                    .map(|v| v.parse().unwrap())
                    .collect();
                assert_eq!(counts.len(), 6);
                let boxes: u64 = lines[1]
                    .strip_prefix("await-boxes\t")
                    .unwrap()
                    .parse()
                    .unwrap();
                if memory == "arc" {
                    assert_eq!(counts[4..], [0, 0]);
                }
                if let Some(path) = std::env::var_os("FWP_QUEUED_FUNCTION_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path).join("await-fields");
                    std::fs::create_dir_all(&path).unwrap();
                    let label = format!("{memory}{opt}-{label}");
                    std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
                    std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                    std::fs::write(path.join(format!("{label}.stdout")), &output.stdout).unwrap();
                    std::fs::write(path.join(format!("{label}.stderr")), &output.stderr).unwrap();
                    std::fs::write(
                        path.join(format!("{label}.status")),
                        format!("{:?}\n", output.status.code()),
                    )
                    .unwrap();
                }
                results.push((counts, boxes));
                // Verify the same program under collection/reuse stress separately
                // from the count comparison, whose collector is inactive.
                if memory == "tracing" {
                    let stressed = Command::new(&binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", "1")
                        .output()
                        .unwrap();
                    assert!(
                        stressed.status.success(),
                        "{memory}/{opt}/{label}: {stressed:?}"
                    );
                    assert_eq!(stressed.stdout, reference.stdout);
                }
            }
            let (fields, removed) = &results[0];
            let (boxed, restored) = &results[1];
            assert_eq!(*removed, 0);
            assert_eq!(
                *restored, 34,
                "32 repeated text awaits, one integer and one wide result"
            );
            assert_eq!(boxed[0] - fields[0], *restored);
            assert!(boxed[1] > fields[1], "restored boxes require storage");
            assert_eq!(
                boxed[2], fields[2],
                "shared results keep their required retains"
            );
            assert_eq!(
                boxed[5], fields[5],
                "same collections during count comparison"
            );
        }
    }
}
