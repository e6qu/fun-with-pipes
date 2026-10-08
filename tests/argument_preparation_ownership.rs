//! Partial typed argument/capture preparation preserves original aliases.
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
            "fwp-argument-preparation-{}-{name}",
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

const SOURCE: &str = r#"multi : String -> String -> (I64, String) -> String ! {Error[String]}
multi = curry3 (if (.2 | .0 | eq 0) (const "expected" | fail) (fork concat .0 (fork concat .1 (.2 | .1))))
other : String -> String -> (I64, String) -> String ! {Error[String]}
other = curry3 (const "other")
choose : Bool -> (String -> String -> (I64, String) -> String ! {Error[String]})
choose = if id (const multi) (const other)
main = (1, "tail") | attempt (choose (read-all () | string.length | eq 0) ("first" | concat "!") ("second" | concat "!")) | echo
"#;
#[test]
fn partial_duplicate_failures_preserve_aliases_and_pending_owned_arguments() {
    let dir = Scratch::new("failures");
    let src = dir.0.join("failures.fwp");
    let cfile = dir.0.join("failures.c");
    let exe = dir.0.join("failures");
    std::fs::write(&src, SOURCE).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
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
    let start = emitted.find("/* multi :").unwrap();
    let id = emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let marker = format!("static void fwp_args{id}(V *a, uint32_t start, uint32_t n) {{");
    let start = emitted.find(&marker).unwrap();
    let end = start + emitted[start..].find("\n}\n").unwrap() + 3;
    let helper = &emitted[start..end];
    assert!(helper.contains("fwp_cleanup_push(&preparation"));
    let fail_second=helper.replace("fwp_rc_dup(a[1 - start]);","if (fail_at == 1) fwp_trap(\"injected second duplicate failure\"); fwp_rc_dup(a[1 - start]);");
    let fail_last=fail_second.replace("fwp_rc_dup(a[2 - start]);","if (fail_at == 2) fwp_trap(\"injected later duplicate failure\"); fwp_rc_dup(a[2 - start]);");
    assert_ne!(helper, fail_second);
    assert_ne!(fail_second, fail_last);
    let mut runtime = emitted
        .replace(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic int fail_at; static volatile V observed_building;",
        )
        .replace(helper, &fail_last)
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    let allocation = "            V building = fwp_rc_fresh(PTR(r));";
    assert_eq!(runtime.matches(allocation).count(), 1);
    runtime = runtime.replace(
        allocation,
        &format!("{allocation} observed_building = PTR(r);"),
    );
    let allocating = "            fwp_clo *r = (fwp_clo *)fwp_alloc_init(sizeof(fwp_clo) + (have + n) * sizeof(V));";
    assert_eq!(runtime.matches(allocating).count(), 1);
    runtime = runtime.replace(allocating, &format!("            if (fail_at == 5) fwp_trap(\"injected partial allocation failure\");\n{allocating}"));
    let probe=r#"
static volatile V first, second, last, scalar_word, function_value, argument;
static jmp_buf preparing;
static int recover_preparation(void) { return 1; }
static int dead_cell(V v) {
    if (fwp_reuse_verify) return OBJ(v)->tag==0xdead;
    size_t ci;
    gc_chunk *chunk=fwp_gc_chunk_of((uintptr_t)v,&ci);
    if (!chunk || chunk->type==GC_FREE) return 1;
    if (chunk->type!=GC_SMALL) return 0;
    for (char *p=fwp_gc.lists[chunk->leaf][chunk->cls].free;p;p=(char *)~*(uintptr_t *)p)
        if (PTR(p)==v) return 1;
    return 0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (volatile int mode=0;mode<6;mode++) {
        first=fwp_rc_fresh(fwp_str_new("first",5));second=fwp_rc_fresh(fwp_str_new("second",6));
        last=fwp_rc_fresh(fwp_str_new("last",4));scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        fwp_rc_dup(last);argument=fwp_rc_fresh(fwp_data(0,2,(V[]){scalar_word,last}));
        observed_building=0;function_value=0;fail_at=mode==5 ? 5 : mode==1 ? 2 : 1;
        struct { uint32_t fn, n; V a[2]; } stack_function = {ID, 2, {first, second}};
        if (mode==2 || mode==3 || mode==5) {
            fwp_rc_dup(first);fwp_rc_dup(second);
            function_value=fwp_rc_fresh(fwp_pap(ID,2,(V[]){first,second}));fwp_rc_dup(function_value);
            if (mode==2) fwp_rc_dup(argument);
        } else if (mode==4) { function_value=PTR(&stack_function); fwp_rc_dup(argument); }
        fwp_trap_recover=recover_preparation;fwp_trap_jb=&preparing;fwp_trap_cleanup=0;
        if (!setjmp(preparing)) {
            if (mode==0) fwp_argsID((V[]){first,second,argument},0,3);
            else if (mode==1) fwp_argsID((V[]){second,argument},1,2);
            else if (mode==2 || mode==4) fwp_apply_owned(function_value,1,(V[]){argument});
            else fwp_apply_owned(function_value,0,NULL);
            return 1;
        }
        fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if (fwp_cleanups || *fwp_rc_slot(first)!=(mode==2 || mode==3 || mode==5 ? 2 : 1) || *fwp_rc_slot(second)!=(mode==2 || mode==3 || mode==5 ? 2 : 1)) return 2;
        if (*fwp_rc_slot(last)!=2 || *fwp_rc_slot(argument)!=1 || *fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 3;
        if (STR(first)->len!=5 || STR(second)->len!=6 || STR(last)->len!=4) return 4;
        if (mode==2 || mode==3 || mode==5) {
            if (*fwp_rc_slot(function_value)!=1) return 5;
            fwp_closure_drop(function_value);
            if (*fwp_rc_slot(first)!=1 || *fwp_rc_slot(second)!=1) return 6;
        }
        if (mode==3 && (!observed_building || !dead_cell(observed_building))) return 7;
        V final_arg=argument;fwp_arg_dropID(&final_arg,2,1);
        if (*fwp_rc_slot(last)!=1 || *fwp_rc_slot(scalar_word)!=1) return 8;
        fwp_rc_free_obj(first);fwp_rc_free_obj(second);fwp_rc_free_obj(last);fwp_rc_free_obj(scalar_word);
    }
    puts("partial argument and capture preparation preserves aliases and releases pending owners");
    return 0;
}
"#.replace("ID",id);
    // Restore only the missing helper scope: the same probe must detect
    // the extra reference left by a completed earlier duplicate.
    let unprotected = runtime
        .replace(
            "fwp_cleanup_push(&preparation, fwp_args_release, &owner);",
            "(void)preparation;",
        )
        .replace("fwp_cleanup_pop(&preparation);", "(void)owner;");
    assert_ne!(unprotected, runtime);
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
            Some(2),
            "missing preparation scope must leak an earlier duplicate"
        );
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout,b"partial argument and capture preparation preserves aliases and releases pending owners\n");
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
