//! Actual wide-count overflow must release partial retains and caller owners.
use std::process::Command;
fn checked(command: &mut Command) -> std::process::Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
#[test]
fn wide_count_overflow_releases_partial_variant_retains_and_live_callers() {
    let dir = std::env::temp_dir().join(format!("fwp-retain-unwind-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"Outcome =
    | Value String I64 String
    | Scalar I64
    | Empty
maker : String -> I64 -> String -> Outcome
maker = curry3 (uncurry3 Value)
other : String -> I64 -> String -> Outcome
other = curry3 (const Empty)
choose : Bool -> (String -> I64 -> String -> Outcome)
choose = if id (const maker) (const other)
repeat : String -> (String, String)
repeat = both id id
choose-repeat : Bool -> (String -> (String, String))
choose-repeat = if id (const repeat) (const (const ("a", "b")))
main = [task.yield (),
    "last" | choose (read-all () | string.length | eq 0) "first" 1 | echo,
    "retained" | choose-repeat (read-all () | string.length | eq 0) | echo,
] | ignore
"#,
    )
    .unwrap();
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
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let start = emitted.find("/* Outcome */\nstatic V fwp_vbox").unwrap();
    let helper = emitted[start..]
        .split("static void fwp_vdup")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let start = emitted
        .find(&format!("static void fwp_vdup{helper}(fwp_u3 *u) {{"))
        .unwrap();
    let end = start + emitted[start..].find("\n}\n").unwrap() + 3;
    let retaining = &emitted[start..end];
    assert!(
        retaining.contains("retained.v0 = u->f[0]") && retaining.contains("retained.v1 = u->f[2]")
    );
    let repeat = emitted[emitted.find("/* repeat :").unwrap()..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe=r#"
static volatile V first, last, scalar_word;
static jmp_buf overflow;
static int recover_overflow(void) { return 1; }
static gc_rc_wide *wide(V v) { return *fwp_rc_wide_link(fwp_rc_slot(v)); }
static V counted(const char *s) { V v=fwp_rc_fresh(fwp_str_new(s,5));for(int i=1;i<255;i++)fwp_rc_dup(v);return v; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (volatile int mode=0;mode<2;mode++) {
        first=counted("first");last=counted("other");scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        wide(mode?last:first)->count=SIZE_MAX;
        fwp_trap_recover=recover_overflow;fwp_trap_jb=&overflow;fwp_trap_cleanup=0;
        if (!setjmp(overflow)) { fwp_u3 u={0,{first,scalar_word,last}};fwp_vdupHELPER(&u);return 1; }
        fwp_trap_recover=0;fwp_trap_jb=0;
        if (fwp_cleanups) return 2;
        if (wide(first)->count!=(mode?255:SIZE_MAX)) return 3;
        if (wide(last)->count!=(mode?SIZE_MAX:255)) return 4;
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11 || STR(first)->len!=5 || STR(last)->len!=5) return 5;
        wide(first)->count=1;wide(last)->count=1;
        fwp_rc_free_obj(first);fwp_rc_free_obj(last);fwp_rc_free_obj(scalar_word);
    }
    first=counted("input");wide(first)->count=SIZE_MAX;
    fwp_trap_recover=recover_overflow;fwp_trap_jb=&overflow;fwp_trap_cleanup=0;
    if (!setjmp(overflow)) { fREPEAT(first);return 6; }
    fwp_trap_recover=0;fwp_trap_jb=0;
    if (fwp_cleanups || wide(first)->count!=SIZE_MAX-1 || STR(first)->len!=5) return 7;
    wide(first)->count=1;fwp_rc_free_obj(first);
    puts("wide-count overflow releases exact partial retains and caller owners");return 0;
}
"#.replace("HELPER",helper).replace("REPEAT",repeat);
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let push = retaining
        .find("fwp_cleanup_push(&retaining_cleanup,")
        .unwrap();
    let end = push + retaining[push..].find(';').unwrap() + 1;
    let old = retaining
        .replacen(&retaining[push..end], "", 1)
        .replace("fwp_cleanup_pop(&retaining_cleanup);", "");
    let control = runtime.replacen(retaining, &old, 1);
    let start = emitted
        .find(&format!("static fwp_r2 w{repeat}(V l0) {{"))
        .unwrap();
    let end = start + emitted[start..].find("\n}").unwrap() + 2;
    let worker = &emitted[start..end];
    let point = worker.find("fwp_rc_dup(l0);").unwrap();
    let push = worker[..point].rfind("fwp_cleanup_push(").unwrap();
    let end = push + worker[push..].find(';').unwrap() + 1;
    let node = worker[push..end]
        .split('&')
        .nth(1)
        .unwrap()
        .split(',')
        .next()
        .unwrap();
    let old_worker = worker.replacen(&worker[push..end], "", 1).replacen(
        &format!("fwp_cleanup_pop(&{node});"),
        "",
        1,
    );
    let caller_control = runtime.replacen(worker, &old_worker, 1);
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{caller_control}\n{probe}"), &exe, opt).unwrap();
        let out = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            out.status.code(),
            Some(7),
            "missing Dup owner scope must retain the caller reference"
        );

        fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
        let out = Command::new(&exe)
            .env("FWP_GC_STRESS", "1")
            .env("FWP_GC_VERIFY", "1")
            .env("FWP_REUSE_VERIFY", "1")
            .output()
            .unwrap();
        assert_eq!(
            out.status.code(),
            Some(3),
            "missing partial scope must leak the first retain"
        );
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
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
    std::fs::remove_dir_all(dir).unwrap();
}
