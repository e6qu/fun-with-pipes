//! Known aggregate contexts give nested constructor temporaries typed cleanup.
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
fn later_field_error_releases_nested_constructor_children() {
    let dir = std::env::temp_dir().join(format!("fwp-constructor-types-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src,r#"Inner = | Leaf String
Outer = | Pair Inner I64 I64
Box = { child: Inner, gate: I64, word: I64 }
guard : I64 -> I64 ! {Error[String]}
guard = if (eq 0) (const "expected" | fail) id
variant : String -> I64 -> I64 -> Outer ! {Error[String]}
variant = curry3 (make { 0 = .0 | Leaf, 1 = .1 | guard, 2 = .2 } | uncurry3 Pair)
record : String -> I64 -> I64 -> Box ! {Error[String]}
record = curry3 (make Box { child = .0 | Leaf, gate = .1 | guard, word = .2 })
variant-other : String -> I64 -> I64 -> Outer ! {Error[String]}
variant-other = curry3 (const (Pair (Leaf "other") 1 2))
record-other : String -> I64 -> I64 -> Box ! {Error[String]}
record-other = curry3 (const (Box { child = Leaf "other", gate = 1, word = 2 }))
choose-variant : Bool -> (String -> I64 -> I64 -> Outer ! {Error[String]})
choose-variant = if id (const variant) (const variant-other)
choose-record : Bool -> (String -> I64 -> I64 -> Box ! {Error[String]})
choose-record = if id (const record) (const record-other)
main = [task.yield (),
    "first" | attempt (flip (flip (choose-variant (read-all () | string.length | eq 0)) 1) 17) | echo,
    "first" | attempt (flip (flip (choose-record (read-all () | string.length | eq 0)) 1) 17) | echo,
    "first" | attempt (flip (flip (choose-variant (read-all () | string.length | eq 0)) 0) 17) | echo,
    "first" | attempt (flip (flip (choose-record (read-all () | string.length | eq 0)) 0) 17) | echo,
] | ignore
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
    let id = |name: &str| {
        emitted[emitted.find(&format!("/* {name} :")).unwrap()..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
    };
    let drop = emitted[emitted.find("/* Inner */\nstatic void fwp_drop").unwrap()..]
        .split("static void ")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let probe=r#"
static volatile V input, scalar_word;
static int dead(V v) { return fwp_reuse_verify ? STR(v)->len==0 : *fwp_rc_slot(v)==0; }
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));fwp_fns=fwp_fn_table;fwp_init_consts();
    int record_only=getenv("FWP_PROBE_RECORD")!=NULL;
    for (volatile int mode=record_only;mode<2;mode++) for (volatile int alias=0;alias<2;alias++) {
        input=fwp_rc_fresh(fwp_str_new("input",5));scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        if (alias) fwp_rc_dup(input);
        fwp_handler h;h.prev=fwp_handlers;h.state_depth=fwp_state_len;h.cleanup=fwp_cleanups;fwp_handlers=&h;
        if (!setjmp(h.jb)) { if (mode) fRECORD(input,0,scalar_word); else fVARIANT(input,0,scalar_word);return 1; }
        fwp_handlers=h.prev;
        if (fwp_cleanups) return 2;
        if (alias) { if (*fwp_rc_slot(input)!=1 || STR(input)->len!=5) return 3;fwp_rc_free_obj(input); }
        else if (!dead(input)) return 4;
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 5;
        fwp_rc_free_obj(scalar_word);
    }
    puts("nested constructor temporaries release children before later field errors");return 0;
}
"#.replace("RECORD",id("record")).replace("VARIANT",id("variant"));
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let needle = format!("{drop}(c->");
    assert!(
        runtime.contains(&needle),
        "must protect an actual typed Inner temporary"
    );
    let control = runtime.replace(&needle, "fwp_rc_drop(c->");
    for opt in ["-O1", "-O2"] {
        fwp::cgen::compile_c(&format!("{control}\n{probe}"), &exe, opt).unwrap();
        for record_only in [false, true] {
            let mut command = Command::new(&exe);
            command
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1");
            if record_only {
                command.env("FWP_PROBE_RECORD", "1");
            }
            let out = command.output().unwrap();
            assert_eq!(
                out.status.code(),
                Some(4),
                "outer-count-only cleanup must leave the String child owned, record {record_only}"
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
