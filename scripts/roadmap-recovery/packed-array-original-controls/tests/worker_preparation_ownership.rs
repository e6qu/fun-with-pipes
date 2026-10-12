//! Boxed-to-worker preparation owns originals and completed duplicates.
use std::path::PathBuf;
use std::process::{Command, Output};

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
        let p = std::env::temp_dir().join(format!(
            "fwp-worker-preparation-{}-{name}",
            std::process::id()
        ));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"Box = { a: String, b: String, word: I64 }
work : String -> Box -> String ! {Error[String]}
work = curry (fork concat .0 (fork concat (.1 | .a) (.1 | .b)))
other : String -> Box -> String ! {Error[String]}
other = curry (const "other")
choose : Bool -> (String -> Box -> String ! {Error[String]})
choose = if id (const work) (const other)
main = [task.yield (),
    Box { a = "first" | concat "!", b = "second" | concat "!", word = 1 }
    | choose (read-all () | string.length | eq 0) "extra" | echo,
] | ignore
"#;
fn function_id<'a>(emitted: &'a str, name: &str) -> &'a str {
    let start = emitted
        .find(&format!("/* {name} :"))
        .unwrap_or_else(|| panic!("missing generated function {name}"));
    emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap()
}
#[test]
fn wrapper_preparation_failures_and_worker_entry_preserve_exact_owners() {
    let dir = Scratch::new("fields");
    let src = dir.0.join("fields.fwp");
    let cfile = dir.0.join("fields.c");
    let exe = dir.0.join("fields");
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
    let id = function_id(&emitted, "work");
    let comment = emitted.find("/* work :").unwrap();
    let header = format!("static V f{id}(");
    let start = comment + emitted[comment..].find(&header).unwrap();
    let wrapper = emitted[start..].lines().next().unwrap();
    assert!(wrapper.contains("prepared.v0 = OBJ(l1)->f[0]"));
    assert!(wrapper.contains("prepared.v1 = OBJ(l1)->f[1]"));
    assert!(wrapper.contains("owned.v0 = 0"));
    let preparing=wrapper.replace("fwp_rc_dup(OBJ(l1)->f[0]);", "if (fail_field==0) fwp_trap(\"injected first field duplication failure\"); fwp_rc_dup(OBJ(l1)->f[0]);")
        .replace("fwp_rc_dup(OBJ(l1)->f[1]);", "if (fail_field==1) fwp_trap(\"injected later field duplication failure\"); fwp_rc_dup(OBJ(l1)->f[1]);");
    assert_ne!(wrapper, preparing);
    let start = comment
        + emitted[comment..]
            .find(&format!("static V w{id}("))
            .unwrap();
    let end = start + emitted[start..].find("\n}\n").unwrap() + 3;
    let worker = &emitted[start..end];
    assert!(worker.contains("FWP_TICK();"));
    let ticking = worker.replace("FWP_TICK();", "cancel_worker_tick(); FWP_TICK();");
    let runtime=emitted.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int fail_field, cancel_in_worker; static void cancel_worker_tick(void);")
        .replace(wrapper,&preparing).replace(worker,&ticking)
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    let probe=r#"
static volatile V first, second, extra, scalar_word, boxed;
static jmp_buf preparation;
static fwp_task cancelled_worker;
static int recover_preparation(void) { return 1; }
static void cancel_worker_tick(void) {
    if (cancel_in_worker && fwp_cur) { fwp_cur->cancelled=1;fwp_budget=0; }
}
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (volatile int mode=0;mode<4;mode++) for (volatile int box_alias=0;box_alias<2;box_alias++) for (volatile int leaf_alias=0;leaf_alias<2;leaf_alias++) {
        first=fwp_rc_fresh(fwp_str_new("first",5));second=fwp_rc_fresh(fwp_str_new("second",6));
        extra=fwp_rc_fresh(fwp_str_new("extra",5));scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        if (leaf_alias) { fwp_rc_dup(first);fwp_rc_dup(second);fwp_rc_dup(extra); }
        boxed=fwp_rc_fresh(fwp_record(3,(V[]){first,second,scalar_word}));
        if (box_alias) fwp_rc_dup(boxed);
        fail_field=mode<2 ? mode : -1;cancel_in_worker=mode==2;
        fwp_trap_recover=recover_preparation;fwp_trap_jb=&preparation;fwp_trap_cleanup=0;
        memset(&cancelled_worker,0,sizeof cancelled_worker);
        if (mode==2) { fwp_cur=&cancelled_worker;fwp_budget=1000000; }
        if (!setjmp(preparation) && !setjmp(cancelled_worker.base)) {
            V result=fWORK(extra,boxed);
            if (mode!=3 || STR(result)->len!=16) return 1;
            fwp_dropSTRING(result);
        } else if (mode==3) return 2;
        fwp_cur=NULL;fail_field=-1;cancel_in_worker=0;fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if (fwp_cleanups || (mode==2 && !cancelled_worker.unwinding)) return 3;
        int expected=box_alias+leaf_alias;
        if (expected) {
            if (*fwp_rc_slot(first)!=expected || *fwp_rc_slot(second)!=expected || STR(first)->len!=5 || STR(second)->len!=6) return 4;
        } else if (!dead_string(first) || !dead_string(second)) return 5;
        if (leaf_alias) { if (*fwp_rc_slot(extra)!=1 || STR(extra)->len!=5) return 6; fwp_rc_free_obj(extra); }
        else if (!dead_string(extra)) return 7;
        if (box_alias) {
            if (*fwp_rc_slot(boxed)!=1 || OBJ(boxed)->n!=3 || OBJ(boxed)->f[2]!=scalar_word) return 8;
            fwp_dropBOX(boxed);
        }
        if (leaf_alias) {
            if (*fwp_rc_slot(first)!=1 || *fwp_rc_slot(second)!=1) return 9;
            fwp_rc_free_obj(first);fwp_rc_free_obj(second);
        }
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 10;
        fwp_rc_free_obj(scalar_word);
    }
    puts("worker preparation and entry release exact owners while preserving aliases and scalar bits");
    return 0;
}
"#.replace("WORK",id);
    // Read release IDs from the exact original-owner scope, not descriptor order.
    let owner_id = wrapper
        .split("fwp_cleanup_push(&cleanup, fwp_owner_release")
        .nth(1)
        .unwrap()
        .split(',')
        .next()
        .unwrap();
    let release = format!("static void fwp_owner_release{owner_id}(void *arg)");
    let at = emitted.find(&release).unwrap();
    let release = emitted[at..].lines().next().unwrap();
    let string_drop = release
        .split("fwp_drop")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let box_drop = release
        .split("fwp_drop")
        .nth(2)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe = probe
        .replace("STRING", string_drop)
        .replace("BOX", box_drop);
    // Restore only the missing partial-preparation owner. Original argument
    // cleanup still runs, but the first successful duplicate must leak.
    let push = preparing
        .find("fwp_cleanup_push(&preparation_cleanup,")
        .unwrap();
    let end = push + preparing[push..].find(';').unwrap() + 1;
    let old_wrapper = preparing
        .replacen(&preparing[push..end], "(void)prepared;", 1)
        .replacen(
            "fwp_cleanup_pop(&preparation_cleanup);",
            "(void)preparation_cleanup;",
            1,
        );
    let unprotected = runtime.replacen(&preparing, &old_wrapper, 1);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{unprotected}\n{probe}"), &exe, opt).unwrap();
        let old = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            old.status.code(),
            Some(5),
            "missing partial scope must leave an earlier duplicate owned"
        );
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout,b"worker preparation and entry release exact owners while preserving aliases and scalar bits\n");
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
