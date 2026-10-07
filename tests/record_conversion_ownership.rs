//! Boxed-to-worker field conversion retains precise typed owners.
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
fn record_conversion_overflow_releases_box_and_remaining_callers() {
    let dir = std::env::temp_dir().join(format!("fwp-record-conversion-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, r#"Box = { first: String, last: String, word: I64 }
rec work : Box -> String
work = if (.word | eq 0) (fork concat .first .last) (make Box { first = .first, last = .last, word = .word | sub 1 } | work)
holder : Box -> String -> String ! {IO}
holder = curry (fork concat (.0 | tap (show | echo) | work) .1)
other : Box -> String -> String ! {IO}
other = curry (const "other")
choose : Bool -> (Box -> String -> String ! {IO})
choose = if id (const holder) (const other)
main = [task.yield (), "later" | choose (read-all () | string.length | eq 0) (Box { first = "first", last = "last", word = 17 }) | echo] | ignore
"#).unwrap();
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let start = emitted.find("/* holder :").unwrap();
    let end = start + emitted[start..].find("/* other :").unwrap();
    let function = &emitted[start..end];
    let holder = function
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let retained = function
        .lines()
        .filter(|line| line.contains("= {0, 0}") && line.contains("fwp_rc_dup("))
        .collect::<Vec<_>>();
    assert_eq!(
        retained.len(),
        1,
        "fixture must perform one boxed record field conversion"
    );
    assert!(
        !retained[0].contains(".v2"),
        "scalar field must have no owner slot"
    );
    let field_read = function
        .lines()
        .filter(|l| l.contains(" = OBJ(") && l.contains("->f[2];"))
        .collect::<Vec<_>>();
    assert_eq!(field_read.len(), 1, "fixture must read boxed scalar field");
    let line = field_read[0];
    let boxed = line
        .split("OBJ(")
        .nth(1)
        .unwrap()
        .split(')')
        .next()
        .unwrap();
    let mut runtime = emitted.replacen(line, &format!("{line} arm_conversion({boxed});"), 1);
    runtime = runtime
        .replacen(
            "/* holder :",
            "static void arm_conversion(V boxed);\n/* holder :",
            1,
        )
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    let probe = r#"
static volatile V first, last, other, scalar_word, observed_box;
static int converting, fail_field, retain_box;
static jmp_buf overflow;
static int recover_overflow(void) { return 1; }
static int dead_string(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
static gc_rc_wide *wide(V v) { return *fwp_rc_wide_link(fwp_rc_slot(v)); }
static size_t count(V v) { uint8_t c=*fwp_rc_slot(v);return c==255?wide(v)->count:c; }
static void single(V v) { if (*fwp_rc_slot(v)==255) wide(v)->count=1;else *fwp_rc_slot(v)=1; }
static void arm_conversion(V boxed) {
    if (!converting) return;
    observed_box=boxed;
    if (retain_box) fwp_rc_dup(boxed);
    for (int i=1;i<255;i++) { fwp_rc_dup(OBJ(boxed)->f[0]);fwp_rc_dup(OBJ(boxed)->f[1]); }
    if (OBJ(boxed)->f[0]!=first || OBJ(boxed)->f[1]!=last) { fprintf(stderr,"conversion fields differ\n");exit(8); }
    if (!wide(first) || !wide(last)) { fprintf(stderr,"counts %u %u\n",*fwp_rc_slot(first),*fwp_rc_slot(last));exit(9); }
    wide(fail_field?OBJ(boxed)->f[1]:OBJ(boxed)->f[0])->count=SIZE_MAX;
    if (OBJ(boxed)->f[2]!=scalar_word) exit(10);
}
int main(void) {
    fwp_prog_out=stdout;fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    for (volatile int field=0;field<2;field++) for (volatile int box_alias=0;box_alias<2;box_alias++)
    for (volatile int other_alias=0;other_alias<2;other_alias++) {
        first=fwp_rc_fresh(fwp_str_new("first",5));last=fwp_rc_fresh(fwp_str_new("other",5));
        other=fwp_rc_fresh(fwp_str_new("later",5));scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        if (other_alias) fwp_rc_dup(other);
        converting=1;fail_field=field;retain_box=box_alias;observed_box=0;
        fwp_trap_recover=recover_overflow;fwp_trap_jb=&overflow;fwp_trap_cleanup=0;
        if (!setjmp(overflow)) { fHOLDER(fwp_rc_fresh(fwp_record(3,(V[]){first,last,scalar_word})),other);return 1; }
        fwp_trap_recover=0;fwp_trap_jb=0;converting=0;
        if (!observed_box || fwp_cleanups) return 2;
        if (box_alias) { if (*fwp_rc_slot(observed_box)!=1) return 3; }
        else if (fwp_reuse_verify ? OBJ(observed_box)->tag!=0xdead : *fwp_rc_slot(observed_box)!=0) return 3;
        size_t first_expected=field?255:SIZE_MAX,last_expected=field?SIZE_MAX:255;
        if (!box_alias) {first_expected--;last_expected--;}
        if (count(first)!=first_expected || STR(first)->len!=5) return 4;
        if (count(last)!=last_expected || STR(last)->len!=5) return 5;
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 6;
        if (other_alias) { if (*fwp_rc_slot(other)!=1 || STR(other)->len!=5) return 7;fwp_rc_free_obj(other); }
        else if (!dead_string(other)) return 7;
        if (box_alias) RECORD_DROP(observed_box);
        single(first);single(last);
        fwp_rc_free_obj(first);fwp_rc_free_obj(last);fwp_rc_free_obj(scalar_word);
    }
    puts("boxed conversion overflow releases original and remaining caller owners");return 0;
}
"#;
    let drop = emitted[emitted.find("/* Box */\nstatic void fwp_drop").unwrap()..]
        .split("static void ")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe = probe.replace("HOLDER", holder).replace("RECORD_DROP", drop);
    let header = format!("static V f{holder}(V l0, V l1) {{");
    let start = runtime.find(&header).unwrap();
    let end = start + runtime[start..].find("\n}").unwrap() + 2;
    let worker = &runtime[start..end];
    let point = worker.find(retained[0]).unwrap();
    let pushes = worker[..point]
        .match_indices("fwp_cleanup_push(")
        .map(|(i, _)| i)
        .collect::<Vec<_>>();
    assert!(pushes.len() >= 2);
    let without_scope = |push: usize| {
        let end = push + worker[push..].find(';').unwrap() + 1;
        let node = worker[push..end]
            .split('&')
            .nth(1)
            .unwrap()
            .split(',')
            .next()
            .unwrap();
        let old = worker.replacen(&worker[push..end], "", 1).replacen(
            &format!("fwp_cleanup_pop(&{node});"),
            "",
            1,
        );
        runtime.replacen(worker, &old, 1)
    };
    let original_control = without_scope(*pushes.last().unwrap());
    let remaining_control = without_scope(pushes[pushes.len() - 2]);
    let partial_push = point + worker[point..].find("fwp_cleanup_push(").unwrap();
    let partial_control = without_scope(partial_push);
    for opt in ["-O1", "-O2"] {
        for (control, expected) in [
            (&original_control, 3),
            (&remaining_control, 7),
            (&partial_control, 4),
        ] {
            fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
            let out = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(expected),
                "missing conversion scope must leave its owner unreleased: {}",
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
        assert_eq!(out.stdout, reference.stdout, "holder {holder}");
    }
    std::fs::remove_dir_all(dir).unwrap();
}
