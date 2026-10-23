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
            .args(["build", "--gc", "tracing"])
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
            assert_eq!(String::from_utf8(out.stdout).unwrap().replace("\r\n", "\n"), "partial argument and capture preparation preserves aliases and releases pending owners\n");
        }
        checked(
            Command::new(fwp)
                .args(["build", "--gc", "tracing"])
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

#[test]
fn unique_closure_captures_move_through_partial_calls_and_failures() {
    let dir = Scratch::new("capture-moves");
    let source = dir.0.join("moves.fwp");
    let cfile = dir.0.join("moves.c");
    let binary = dir.0.join("moves.exe");
    std::fs::write(&source, SOURCE).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    checked(
        Command::new(fwp)
            .args(["build", "--gc", "tracing", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let generated = std::fs::read_to_string(&cfile).unwrap();
    let id = generated[generated.find("/* multi :").unwrap()..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let mut code = generated.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int capture_measuring,capture_retains,capture_trap;\nstatic V capture_first,capture_second;");
    let retain = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
    assert_eq!(code.matches(retain).count(), 1);
    code = code.replace(retain, &format!("{retain}\n        if(capture_measuring&&(v==capture_first||v==capture_second))capture_retains++;"));
    let entry = format!("static V fwp_owned_entry{id}(V *a) {{");
    assert_eq!(code.matches(&entry).count(), 1);
    code = code.replace(&entry, &format!("{entry}\n    capture_measuring=0;"));
    let concat = "static V fwp_p_concat(V t, V s) {";
    assert_eq!(code.matches(concat).count(), 1);
    code = code.replace(
        concat,
        &format!("{concat}\n    if(capture_trap)fwp_trap(\"capture callee trap\");"),
    );
    code = code.replace(
        "int main(int argc, char **argv)",
        "int language_main(int argc, char **argv)",
    );
    code.push_str(&include_str!("fixtures/closure_capture_moves.c").replace("ID", id));
    let transfer = "if (fwp_rc_last(f)) c->n = 0;\n            else fi->owned->captures(f, 1);";
    assert_eq!(code.matches(transfer).count(), 2);
    let old = code.replace(transfer, "fi->owned->captures(f, 1);");
    let stolen = code.replace(transfer, "c->n = 0;");
    let artifacts = std::env::var_os("FWP_STREAM_CLIENT_ARTIFACTS")
        .map(|path| std::path::PathBuf::from(path).join("capture-moves"));
    if let Some(path) = &artifacts {
        std::fs::create_dir_all(path).unwrap();
        std::fs::write(path.join("captures.c"), &code).unwrap();
        std::fs::write(path.join("language.c"), &generated).unwrap();
        std::fs::write(path.join("source.fwp"), SOURCE).unwrap();
    }
    for opt in ["-O1", "-O2"] {
        for control in [&old, &stolen] {
            fwp::cgen::compile_c(control, &binary, opt).unwrap();
            let output = Command::new(&binary)
                .env("FWP_GC", "off")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(output.status.code(), Some(201), "{opt}: {output:?}");
        }
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        if let Some(path) = &artifacts {
            std::fs::copy(&binary, path.join(format!("captures{opt}.exe"))).unwrap();
        }
        for stress in [false, true] {
            let output = checked(
                Command::new(&binary)
                    .env("FWP_GC", if stress { "on" } else { "off" })
                    .env("FWP_GC_STRESS", if stress { "1" } else { "0" })
                    .env("FWP_GC_VERIFY", if stress { "1" } else { "0" })
                    .env("FWP_REUSE_VERIFY", if stress { "1" } else { "0" }),
            );
            if !stress {
                if let Some(path) = &artifacts {
                    std::fs::write(path.join(format!("captures{opt}.tsv")), &output.stdout)
                        .unwrap();
                }
            }
        }
        fwp::cgen::compile_c(&generated, &binary, opt).unwrap();
        let result = checked(
            Command::new(&binary)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(result.stdout, reference.stdout);
    }
}
