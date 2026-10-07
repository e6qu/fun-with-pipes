//! Constructor allocation transfers typed fields only after success.
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
            "fwp-constructor-unwind-{}-{name}",
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

const SOURCE: &str = r#"Payload =
    | Leaf String I64 String
    | Link Payload
variant : String -> I64 -> String -> Payload
variant = curry3 (make { 0 = .0 | concat "!", 1 = .1, 2 = .2 } | uncurry3 Leaf)
choose-leaf : Bool -> (String -> I64 -> String -> Payload)
choose-leaf = if id (const Leaf) (const variant)
record : String -> I64 -> String -> (String, I64, String, I64, I64, I64, I64, I64, I64)
record = curry3 (make { 0 = .0, 1 = .1, 2 = .2, 3 = const 0, 4 = const 0, 5 = const 0, 6 = const 0, 7 = const 0, 8 = const 0 })
record-other : String -> I64 -> String -> (String, I64, String, I64, I64, I64, I64, I64, I64)
record-other = curry3 (const ("other", 0, "other", 0, 0, 0, 0, 0, 0))
choose-record : Bool -> (String -> I64 -> String -> (String, I64, String, I64, I64, I64, I64, I64, I64))
choose-record = if id (const record) (const record-other)
continued : String -> I64 -> String -> ((String, I64, String, I64, I64, I64, I64, I64, I64), String)
continued = curry3 (both (make { 0 = .0, 1 = .1, 2 = .2, 3 = const 0, 4 = const 0, 5 = const 0, 6 = const 0, 7 = const 0, 8 = const 0 }) .0)
continued-other : String -> I64 -> String -> ((String, I64, String, I64, I64, I64, I64, I64, I64), String)
continued-other = curry3 (const (("other", 0, "other", 0, 0, 0, 0, 0, 0), "other"))
choose-continued : Bool -> (String -> I64 -> String -> ((String, I64, String, I64, I64, I64, I64, I64, I64), String))
choose-continued = if id (const continued) (const continued-other)
main = [task.yield (),
    "last" | choose-leaf (read-all () | string.length | eq 0) "first" 1 | echo,
    "last" | variant "first" 1 | echo,
    "last" | choose-continued (read-all () | string.length | eq 0) "first" 1 | echo,
    "last" | choose-record (read-all () | string.length | eq 0) "first" 1 | echo,
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
fn failed_constructor_allocation_releases_typed_fields_and_preserves_aliases() {
    let dir = Scratch::new("allocation");
    let src = dir.0.join("allocation.fwp");
    let cfile = dir.0.join("allocation.c");
    let exe = dir.0.join("allocation");
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
    let probe=r#"
static volatile V first, last, scalar_word;
static jmp_buf allocating;
static int recover_allocation(void) { return 1; }
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (volatile int mode=0;mode<4;mode++) for (volatile int alias=0;alias<2;alias++) {
        first=fwp_rc_fresh(fwp_str_new("first",5));last=fwp_rc_fresh(fwp_str_new("last",4));
        if (alias) { fwp_rc_dup(first);fwp_rc_dup(last); }
        scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        observed_field=0;fail_allocation=1;
        fwp_trap_recover=recover_allocation;fwp_trap_jb=&allocating;fwp_trap_cleanup=0;
        if (!setjmp(allocating)) {
            if (mode==0) fLEAF(first,scalar_word,last);
            else if (mode==1) fVARIANT(first,scalar_word,last);
            else if (mode==2) fRECORD(first,scalar_word,last);
            else fCONTINUED(first,scalar_word,last);
            return 1;
        }
        fail_allocation=0;fwp_trap_recover=NULL;fwp_trap_jb=NULL;
        if (fwp_cleanups || !observed_field) return 2;
        if (mode==1 && !dead_string(observed_field)) return 3;
        if (alias) {
            if (*fwp_rc_slot(first)!=1 || *fwp_rc_slot(last)!=1 || STR(first)->len!=5 || STR(last)->len!=4) return 4;
            fwp_rc_free_obj(first);fwp_rc_free_obj(last);
        } else if (!dead_string(first) || !dead_string(last)) return 5;
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 6;
        fwp_rc_free_obj(scalar_word);
    }
    puts("constructor allocation failure releases typed fields without losing aliases or scalar bits");
    return 0;
}
"#.replace("LEAF",function_id(&emitted,"Payload.Leaf")).replace("VARIANT",function_id(&emitted,"variant")).replace("RECORD",function_id(&emitted,"record")).replace("CONTINUED",function_id(&emitted,"continued"));
    let marker = "static V fwp_data(uint32_t tag, uint32_t n, const V *f) {";
    assert_eq!(emitted.matches(marker).count(), 1);
    let runtime=emitted.replace("typedef uint64_t V;","typedef uint64_t V;\nstatic int fail_allocation; static volatile V observed_field; static void fwp_trap(const char *msg);")
        .replace(marker,&format!("{marker}\n    if (fail_allocation && (n==3 || n==9)) {{ observed_field=f[0]; fwp_trap(\"injected constructor allocation failure\"); }}"))
        .replace("int main(int argc, char **argv)","int original_main(int argc, char **argv)");
    // Removing only the constructor-function allocation scope restores the
    // missing field release; the same probe must detect it.
    let start = runtime
        .find("fwp_cleanup_push(&allocation_cleanup,")
        .unwrap();
    let end = start + runtime[start..].find(';').unwrap() + 1;
    let unprotected = runtime
        .replacen(&runtime[start..end], "(void)pending;", 1)
        .replacen(
            "fwp_cleanup_pop(&allocation_cleanup);",
            "(void)allocation_cleanup;",
            1,
        );
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
            "missing constructor scope must leak its fields"
        );
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout,b"constructor allocation failure releases typed fields without losing aliases or scalar bits\n");
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
