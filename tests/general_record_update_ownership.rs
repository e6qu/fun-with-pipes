//! Record copies retain typed kept fields; updates release overwritten owners.
use std::process::Command;
fn checked(c: &mut Command) -> std::process::Output {
    let o = c.output().unwrap();
    assert!(
        o.status.success(),
        "{c:?}: {:?}: {}",
        o.status.code(),
        String::from_utf8_lossy(&o.stderr)
    );
    o
}
#[test]
fn general_copies_keep_original_and_release_partial_work() {
    let dir =
        std::env::temp_dir().join(format!("fwp-general-record-update-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, r#"Box = { first: String, last: String, old: String, word: I64 }
keep : Box -> (Box, Box)
keep = both (with { old = "new" }) id
other : Box -> (Box, Box)
other = both id id
choose : Bool -> (Box -> (Box, Box))
choose = if id (const keep) (const other)
main = [task.yield (), Box { first = "first", last = "last", old = "old", word = 17 } | choose (read-all () | string.length | eq 0) | echo] | ignore
"#).unwrap();
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
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let start = emitted.find("/* keep :").unwrap();
    let end = start + emitted[start..].find("/* other :").unwrap();
    let function = &emitted[start..end];
    let id = function
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let replacement = function
        .lines()
        .find(|l| l.contains("->f[2] = "))
        .unwrap()
        .split(" = ")
        .nth(1)
        .unwrap()
        .trim_end_matches(';');
    let copy_line = function
        .lines()
        .find(|l| l.contains(" = fwp_rc_fresh(fwp_data("))
        .unwrap();
    let copy = copy_line.split_whitespace().nth(1).unwrap();
    assert!(function.contains("fwp_rc_dup(OBJ("));
    assert!(
        !function.contains("fwp_rc_unique"),
        "fixture must exercise the general copy path"
    );
    assert!(
        !function.contains("for (uint32_t k"),
        "scalar words must never be retained"
    );
    let drop = emitted[emitted.find("/* Box */\nstatic void fwp_drop").unwrap()..]
        .split("static void ")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    // Replace the static captured field with a counted value supplied by the C
    // probe. This exercises the same consumed replacement slot and typed scope.
    let modified = function.replace(replacement, "replacement_value").replace(
        copy_line,
        &format!("{copy_line} observed_copy={copy}; arm_update();"),
    );
    let runtime = emitted[..start].to_string() + &modified + &emitted[end..];
    let runtime = runtime.replacen("/* keep :", "static V replacement_value, observed_copy; static int failing; static void arm_update(void);\n/* keep :", 1)
        .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
    let probe = r#"
static volatile V first, last, old, word, box;
static int fail_field;
static jmp_buf overflow;
static int recover(void) { return 1; }
static int dead(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
static size_t count(V v) { uint8_t n=*fwp_rc_slot(v); return n==255?(*fwp_rc_wide_link(fwp_rc_slot(v)))->count:n; }
static void single(V v) { if (*fwp_rc_slot(v)==255) (*fwp_rc_wide_link(fwp_rc_slot(v)))->count=1;else *fwp_rc_slot(v)=1; }
static void arm_update(void) {
    if (!failing) return;
    for (int i=1;i<255;i++) { fwp_rc_dup(first);fwp_rc_dup(last); }
    (*fwp_rc_wide_link(fwp_rc_slot(fail_field?last:first)))->count=SIZE_MAX;
}
static void setup(void) {
    first=fwp_rc_fresh(fwp_str_new("first",5));last=fwp_rc_fresh(fwp_str_new("last",4));
    old=fwp_rc_fresh(fwp_str_new("old",3));word=fwp_rc_fresh(fwp_str_new("scalar",6));
    replacement_value=fwp_rc_fresh(fwp_str_new("new",3)); observed_copy=0;
    box=fwp_rc_fresh(fwp_record(4,(V[]){first,last,old,word}));
}
int main(void) {
    fwp_prog_out=stdout; fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (int alias=0;alias<2;alias++) {
        setup(); failing=0; if (alias) fwp_rc_dup(box);
        V result=fFUNCTION(box);
        if (*fwp_rc_slot(word)!=1 || STR(word)->len!=6) return 1;
        if (OBJ(result)->f[1]!=box || count(box)!=(alias?2:1) || count(old)!=1 || count(first)!=2 || count(last)!=2) return 2;
        if (alias) RECORD_DROP(box);
        if (count(first)!=2 || count(last)!=2 || count(replacement_value)!=1) return 4;
        RECORD_DROP(OBJ(result)->f[0]); RECORD_DROP(OBJ(result)->f[1]);fwp_rc_free_obj(result);
        if (!dead(first) || !dead(last) || !dead(old) || !dead(replacement_value)) return 5;
        fwp_rc_free_obj(word);
    }
    for (volatile int field=0;field<2;field++) for (volatile int alias=0;alias<2;alias++) {
        setup(); failing=1; fail_field=field; if (alias) fwp_rc_dup(box);
        fwp_trap_recover=recover;fwp_trap_jb=&overflow;fwp_trap_cleanup=0;
        if (!setjmp(overflow)) { fFUNCTION(box);return 6; }
        fwp_trap_recover=0;fwp_trap_jb=0;failing=0;
        if (fwp_cleanups || !observed_copy || !dead(replacement_value)) return 7;
        if (fwp_reuse_verify ? OBJ(observed_copy)->tag!=0xdead : *fwp_rc_slot(observed_copy)!=0) return 8;
        size_t a=field?255:SIZE_MAX,b=field?SIZE_MAX:255;
        if (!alias) {a--;b--; if (!dead(old)) return 9;}
        else if (count(box)!=1 || count(old)!=1) return 10;
        if (count(first)!=a || count(last)!=b) return 11;
        if (*fwp_rc_slot(word)!=1 || STR(word)->len!=6) return 12;
        if (alias) RECORD_DROP(box);
        single(first);single(last);fwp_rc_free_obj(first);fwp_rc_free_obj(last);fwp_rc_free_obj(word);
    }
    puts("record updates preserve typed kept fields and release replaced owners");return 0;
}
"#.replace("FUNCTION", id).replace("RECORD_DROP", drop);
    let remove_scope = |function: &str, needle: &str| {
        let line = function.lines().find(|l| l.contains(needle)).unwrap();
        let push = line.find("fwp_cleanup_push(&").unwrap();
        let node = line[push + "fwp_cleanup_push(&".len()..]
            .split(',')
            .next()
            .unwrap();
        let end = push + line[push..].find(';').unwrap() + 1;
        function
            .replace(&line[push..end], "")
            .replace(&format!("fwp_cleanup_pop(&{node});"), "")
    };
    let remaining_ctx = modified
        .lines()
        .rfind(|l| l.contains(" = {l0};"))
        .unwrap()
        .split_whitespace()
        .nth(1)
        .unwrap();
    let remaining_line = modified
        .lines()
        .find(|l| l.contains(&format!(", &{remaining_ctx});")))
        .unwrap();
    let controls = [
        (remove_scope(&modified, remaining_line), 9),
        (remove_scope(&modified, "fwp_rc_cleanup_cell"), 8),
        (remove_scope(&modified, "= {0, 0}"), 11),
        (remove_scope(&modified, "= {replacement_value}"), 7),
    ];
    for opt in ["-O1", "-O2"] {
        for (control, expected) in &controls {
            let controlled = runtime.replace(&modified, control);
            fwp::cgen::compile_c(&format!("{controlled}\n{probe}"), &exe, opt).unwrap();
            let out = Command::new(&exe)
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(*expected),
                "missing ownership control: {}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
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
                .arg(&exe)
                .env("FWP_STACK", "0"),
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
