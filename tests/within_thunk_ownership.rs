//! Deadline calls retain typed callback ownership across normal and cancelled tasks.
use std::process::Command;

#[test]
fn deadline_thunks_preserve_aliases_and_release_capture_owners() {
    let dir = std::env::temp_dir().join(format!("fwp-within-thunk-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let source = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    std::fs::write(
        &source,
        r#"plain : String -> () -> I64
plain = curry (.0 | string.length)
sleeping : String -> () -> I64 ! {Async}
sleeping = curry (.0 | tap (const 1h | task.sleep) | string.length)
main = [
 task.within 1h (plain ("input" | string.repeat 2)) | echo,
 task.within 0ns (sleeping ("input" | string.repeat 2)) | echo,
] | ignore
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
    let probe = r#"
static int dead(V v){return fwp_reuse_verify?STR(v)->len==0:*fwp_rc_slot(v)==0;}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 for(int cancelled=0;cancelled<2;cancelled++)for(int alias=0;alias<2;alias++){
  V capture=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(capture);
  V fn=fwp_rc_fresh(fwp_pap(cancelled?SLEEPING:PLAIN,1,&capture));
  V duration=fwp_record(1,(V[]){cancelled?0:INT64_C(3600000000000)});
  fwp_rc_dup(fn); /* preserve an independent alias across the consuming call */
  V result=fWITHIN(duration,fn);
  FWP_KEEP_ALIVE(fn);FWP_KEEP_ALIVE(capture);
  if(!fwp_rc_slot(fn)||!fwp_rc_slot(capture)||*fwp_rc_slot(fn)!=1||*fwp_rc_slot(capture)!=alias+1)return 1;
  if(cancelled){if(result!=FWP_NONE)return 2;}
  else{if(result==FWP_NONE||OBJ(result)->f[0]!=5)return 3;fwp_rc_free_obj(result);}
  fwp_closure_drop(fn);
  if(alias){if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 4;fwp_rc_free_obj(capture);}
  else if(!dead(capture))return 5;
 }
 fwp_tasks_finish();return 0;
}
"#.replace("SLEEPING", &id("sleeping")).replace("PLAIN", &id("plain")).replace("WITHIN", &id("task.within"));
    let legacy = runtime.replace(
        "fwp_task *t = fwp_spawn_owned(thunk, at, drop);",
        "(void)drop;fwp_rc_share(thunk);fwp_task *t = fwp_spawn(thunk, at);",
    );
    assert_ne!(legacy, runtime);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{legacy}\n{probe}"), &exe, opt).unwrap();
        let control = Command::new(&exe)
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            control.status.code(),
            Some(1),
            "legacy sharing must lose precise ownership"
        );
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

#[test]
fn clock_failure_releases_the_deadline_callback_and_reports_clock_errors() {
    let dir = fwp::cgen::TempDir::new("task-clock-owner").unwrap();
    let source = dir.join("clock.fwp");
    let cfile = dir.join("clock.c");
    let binary = dir.join("clock.exe");
    std::fs::write(&source, "work : String -> () -> String\nwork = const\nmain = task.within 1h (work (\"clock\" | string.repeat 2)) | echo\n").unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for memory in ["arc", "tracing"] {
        let build = Command::new(compiler)
            .args(["build", "--gc", memory, "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile)
            .output()
            .unwrap();
        assert!(build.status.success(), "{build:?}");
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let start = emitted.find("/* work :").unwrap();
        let id = emitted[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let clock = "static int64_t fwp_now_ns(void) {";
        assert_eq!(emitted.matches(clock).count(), 1);
        let mut runtime = emitted.replace(
            clock,
            r#"static int fail_clock;
#ifdef _WIN32
static BOOL probe_clock_counter(LARGE_INTEGER *p) {
 if(fail_clock)return FALSE;return QueryPerformanceCounter(p);
}
#else
static int probe_clock_read(clockid_t id,struct timespec *p) {
 if(fail_clock){errno=EIO;return -1;}return clock_gettime(id,p);
}
#endif
static int64_t fwp_now_ns(void) {"#,
        );
        for (before, after) in [
            (
                "if (!QueryPerformanceCounter(&counter) ||",
                "if (!probe_clock_counter(&counter) ||",
            ),
            (
                "if (clock_gettime(CLOCK_MONOTONIC, &t) != 0)",
                "if (probe_clock_read(CLOCK_MONOTONIC, &t) != 0)",
            ),
            (
                "if (clock_gettime(CLOCK_REALTIME, &now) != 0)",
                "if (probe_clock_read(CLOCK_REALTIME, &now) != 0)",
            ),
            (
                "int main(int argc, char **argv)",
                "int original_main(int argc, char **argv)",
            ),
        ] {
            assert_eq!(runtime.matches(before).count(), 1, "{before}");
            runtime = runtime.replace(before, after);
        }
        let probe = r#"
static jmp_buf clock_failed;
static int recover_clock(void){return 1;}
static void drop_text(V v){if(fwp_rc_release_last(v))fwp_rc_free_obj(v);}
int main(void){
 fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();fwp_tasks_init();
 for(int alias=0;alias<2;alias++){
  V capture=fwp_rc_fresh(fwp_str_new("clock",5));
  fwp_rc_dup(capture); /* inspect the capture through an independent owner */
  V fn=fwp_rc_fresh(fwp_pap(WORK,1,&capture));if(alias)fwp_rc_dup(fn);
  V duration=fwp_record(1,(V[]){INT64_C(3600000000000)});
  fail_clock=1;fwp_trap_recover=recover_clock;fwp_trap_jb=&clock_failed;fwp_trap_cleanup=0;
  if(setjmp(clock_failed)==0){fwp_p_task_within_owned(duration,fn,drop_text,fwp_rc_dup);return 1;}
  fwp_trap_recover=0;fwp_trap_jb=0;fail_clock=0;
  if(strcmp(fwp_trap_msg,"cannot read monotonic clock"))return 8;
  if(fwp_cleanups||fwp_gc_tasks||fwp_cur->first_child)return 2;
  if(*fwp_rc_slot(capture)!=1+alias)return 3;
  if(alias){if(*fwp_rc_slot(fn)!=1)return 4;fwp_closure_drop(fn);}
  if(*fwp_rc_slot(capture)!=1||STR(capture)->len!=5)return 5;
  drop_text(capture);
 }
#ifndef _WIN32
 fail_clock=1;fwp_trap_recover=recover_clock;fwp_trap_jb=&clock_failed;fwp_trap_cleanup=0;
 if(setjmp(clock_failed)==0){fwp_unix_ns();return 6;}
 fwp_trap_recover=0;fwp_trap_jb=0;fail_clock=0;
 if(strcmp(fwp_trap_msg,"cannot read system clock"))return 9;
 if(fwp_cleanups)return 7;
#endif
 fwp_tasks_finish();return 0;
}
"#
        .replace("WORK", id);
        let broken = runtime
            .replace(
                "fwp_value_protect(&callback, &callback_cleanup);",
                "/* omit incoming callback protection */",
            )
            .replace(
                "fwp_value_finish(&callback, &callback_cleanup);",
                "/* omit incoming callback transfer */",
            );
        assert_ne!(runtime, broken);
        for opt in ["-O0", "-O2"] {
            for (label, code, expected) in
                [("protected", &runtime, 0), ("missing-owner", &broken, 3)]
            {
                let code = format!("{code}\n{probe}");
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let result = Command::new(&binary)
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "1")
                    .output()
                    .unwrap();
                if let Some(path) = std::env::var_os("FWP_QUEUED_FUNCTION_ARTIFACTS") {
                    let path = std::path::PathBuf::from(path).join("clock-owners");
                    std::fs::create_dir_all(&path).unwrap();
                    let label = format!("{memory}{opt}-{label}");
                    std::fs::write(path.join(format!("{label}.c")), &code).unwrap();
                    std::fs::copy(&binary, path.join(format!("{label}.exe"))).unwrap();
                    std::fs::write(path.join(format!("{label}.stdout")), &result.stdout).unwrap();
                    std::fs::write(path.join(format!("{label}.stderr")), &result.stderr).unwrap();
                    std::fs::write(
                        path.join(format!("{label}.status")),
                        format!("{:?}\n", result.status.code()),
                    )
                    .unwrap();
                }
                assert_eq!(
                    result.status.code(),
                    Some(expected),
                    "{memory}/{opt}/{label}: {result:?}"
                );
                assert!(
                    result.stdout.is_empty() && result.stderr.is_empty(),
                    "{result:?}"
                );
            }
        }
    }
}
