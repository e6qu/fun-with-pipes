//! Unboxed worker results keep typed owners until boxing succeeds.
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
        let p =
            std::env::temp_dir().join(format!("fwp-worker-boxing-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"Outcome =
    | Value String I64 String
    | Scalar I64
    | Empty
record-maker : String -> I64 -> String -> (String, I64, String)
record-maker = curry3 id
record-other : String -> I64 -> String -> (String, I64, String)
record-other = curry3 (const ("other", 0, "other"))
choose-record : Bool -> (String -> I64 -> String -> (String, I64, String))
choose-record = if id (const record-maker) (const record-other)
variant-maker : String -> I64 -> String -> Outcome
variant-maker = curry3 (uncurry3 Value)
variant-other : String -> I64 -> String -> Outcome
variant-other = curry3 (const Empty)
choose-variant : Bool -> (String -> I64 -> String -> Outcome)
choose-variant = if id (const variant-maker) (const variant-other)
record-rec : String -> I64 -> String -> (String, I64, String)
rec record-rec = curry3 (if (.1 | eq 0) id (make {0 = .0, 1 = .1 | sub 1, 2 = .2} | uncurry3 record-rec))
caller : String -> I64 -> String -> ((String, I64, String), String)
caller = curry3 (both (uncurry3 record-rec) .0)
caller-other : String -> I64 -> String -> ((String, I64, String), String)
caller-other = curry3 (const (("other", 0, "other"), "other"))
choose-caller : Bool -> (String -> I64 -> String -> ((String, I64, String), String))
choose-caller = if id (const caller) (const caller-other)
main = [task.yield (),
    "last" | choose-record (read-all () | string.length | eq 0) "first" 1 | echo,
    "last" | choose-variant (read-all () | string.length | eq 0) "first" 1 | echo,
    "last" | choose-caller (read-all () | string.length | eq 0) "first" 1 | echo,
] | ignore
"#;
fn function_id<'a>(emitted: &'a str, name: &str) -> &'a str {
    let start = emitted
        .find(&format!("/* {name} :"))
        .unwrap_or_else(|| panic!("missing emitted function {name}"));
    emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap()
}
#[test]
fn failed_result_boxing_releases_fields_and_remaining_caller_owners() {
    let dir = Scratch::new("results");
    let src = dir.0.join("results.fwp");
    let cfile = dir.0.join("results.c");
    let exe = dir.0.join("results");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let variant_start = emitted.find("/* variant-maker :").unwrap();
    let vbox = emitted[variant_start..]
        .split("return fwp_vbox")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe=r#"
static volatile V first, last, scalar_word;
static jmp_buf boxing;
static int recover_boxing(void) { return 1; }
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (volatile int mode=0;mode<4;mode++) for (volatile int alias=0;alias<2;alias++) {
        first=fwp_rc_fresh(fwp_str_new("first",5));last=fwp_rc_fresh(fwp_str_new("last",4));
        scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        if (mode<3 && alias) { fwp_rc_dup(first);fwp_rc_dup(last); }
        fail_boxing=1;fwp_trap_recover=recover_boxing;fwp_trap_jb=&boxing;fwp_trap_cleanup=0;
        if (!setjmp(boxing)) {
            if (mode==0) fRECORD(first,scalar_word,last);
            else if (mode==1) fVARIANT(first,scalar_word,last);
            else if (mode==2) fCALLER(first,0,last);
            else fwp_vboxBOX((fwp_u3){1,{scalar_word,0,0}});
            return 1;
        }
        fail_boxing=0;fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if (fwp_cleanups) return 2;
        if (mode<3) {
            if (alias) {
                if (*fwp_rc_slot(first)!=1 || *fwp_rc_slot(last)!=1 || STR(first)->len!=5 || STR(last)->len!=4) return 3;
                fwp_rc_free_obj(first);fwp_rc_free_obj(last);
            } else if (!dead_string(first) || !dead_string(last)) return 4;
        } else { fwp_rc_free_obj(first);fwp_rc_free_obj(last); }
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 5;
        if (fwp_vboxBOX((fwp_u3){2,{scalar_word,scalar_word,scalar_word}})!=2 || fwp_cleanups) return 6;
        fwp_rc_free_obj(scalar_word);
    }
    puts("worker result boxing failure releases typed fields and caller owners without counting scalar bits");
    return 0;
}
"#.replace("RECORD",function_id(&emitted,"record-maker")).replace("VARIANT",function_id(&emitted,"variant-maker")).replace("CALLER",function_id(&emitted,"caller")).replace("BOX",vbox);
    let marker = "static V fwp_data(uint32_t tag, uint32_t n, const V *f) {";
    assert_eq!(emitted.matches(marker).count(), 1);
    let runtime=emitted.replace("typedef uint64_t V;","typedef uint64_t V;\nstatic int fail_boxing; static void fwp_trap(const char *msg);")
        .replace(marker,&format!("{marker}\n    if (fail_boxing && (n==3 || n==1)) fwp_trap(\"injected worker boxing allocation failure\");"))
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    // Restore only the record wrapper's missing result scope. The same
    // real allocation-failure probe must find unreleased returned fields.
    let comment = runtime.find("/* record-maker :").unwrap();
    let header = format!("static V f{}(", function_id(&emitted, "record-maker"));
    let start = comment + runtime[comment..].find(&header).unwrap();
    let wrapper = runtime[start..].lines().next().unwrap();
    let push = wrapper.find("fwp_cleanup_push(&boxing_cleanup,").unwrap();
    let end = push + wrapper[push..].find(';').unwrap() + 1;
    let old_wrapper = wrapper
        .replacen(&wrapper[push..end], "(void)pending_result;", 1)
        .replacen(
            "fwp_cleanup_pop(&boxing_cleanup);",
            "(void)boxing_cleanup;",
            1,
        );
    let unprotected = runtime.replacen(wrapper, &old_wrapper, 1);
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
            Some(4),
            "missing boxing scope must leak returned fields"
        );
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout,b"worker result boxing failure releases typed fields and caller owners without counting scalar bits\n");
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
