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
        "fwp_task *t = fwp_spawn_retained(thunk, at, drop);",
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
