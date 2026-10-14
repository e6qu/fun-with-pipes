//! Partial native arrays and consumed accumulators release on callback failure.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn quad_array_callbacks_release_partial_results_without_collection() {
    let dir = fwp::cgen::TempDir::new("fwp-array-unwind").unwrap();
    let source = dir.join("unwind.fwp");
    std::fs::write(
        &source,
        r#"
transform : F128 -> F128 ! {Error[String]}
transform = if (gt 2.0f128) (const "expected" | fail) (add 1.0f128)
to-quad : I64 -> F128
to-quad = int.to-float
sum-step : F128 -> F128 -> F128 ! {Error[String]}
sum-step = curry (if (.1 | gt 2.0f128) (const "expected" | fail) (uncurry add))
export mapped : I64 -> Array[F128] ! {Error[String]}
mapped = flip array.generate to-quad | array.map transform
export generated : I64 -> Array[F128] ! {Error[String]}
generated = flip array.generate (to-quad | transform)
export folded : I64 -> F128 ! {Error[String]}
folded = flip array.generate to-quad | array.fold sum-step 0.0f128
main = [4 | attempt mapped | echo, 4 | attempt generated | echo, 4 | attempt folded | echo] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let cfile = dir.join("unwind.c");
    checked(
        Command::new(fwp)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let mut functions = Vec::new();
    for name in ["mapped", "generated", "folded"] {
        let start = code.find(&format!("/* {name} :")).unwrap();
        let id = code[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        functions.push(format!("f{id}"));
    }
    let probe = format!(
        r#"
static int retained;
static void fail_retain(V value) {{ if(retained++ == 3) fwp_fail(0,NULL); fwp_rc_dup(value); }}
static void drop_leaf(V value) {{ if(fwp_rc_release_last(value)) fwp_rc_free_obj(value); }}
int main(void) {{
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    V (*const functions[])(V)={{{}}};
    for(volatile int i=0;i<3;i++) {{
        intptr_t budget=fwp_gc.budget;
        fwp_handler h; h.prev=fwp_handlers; h.state_depth=fwp_state_len; h.cleanup=fwp_cleanups;
        fwp_handlers=&h;
        if(!setjmp(h.jb)) {{ functions[i](4); return 190; }}
        fwp_handlers=h.prev;
        if(fwp_cleanups != h.cleanup) return 191;
        if(fwp_gc.budget < budget) return 193;
    }}
    V leaf=fwp_rc_fresh(fwp_cstr("retained input"));
    intptr_t budget=fwp_gc.budget;
    const fwp_desc element={{.kind=K_STR,.dup=fail_retain,.drop=drop_leaf}};
    fwp_handler h; h.prev=fwp_handlers; h.state_depth=fwp_state_len; h.cleanup=fwp_cleanups;
    fwp_handlers=&h;
    if(!setjmp(h.jb)) {{ fwp_p_array_make_typed(10,leaf,fail_retain,&element); return 194; }}
    fwp_handlers=h.prev;
    if(fwp_cleanups != h.cleanup || *fwp_rc_slot(leaf)!=1) return 195;
    if(fwp_gc.budget < budget) return 196;
    drop_leaf(leaf);
    return 0;
}}
"#,
        functions.join(",")
    );
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(format!("semantic{opt}"));
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        let output = checked(Command::new(binary).env("FWP_REUSE_VERIFY", "1"));
        assert_eq!(output.stdout, reference.stdout);
        assert_eq!(output.stderr, reference.stderr);
        let measured = code.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        ) + &probe;
        for (label, code, expected) in [
            ("owned", measured.clone(), 0),
            (
                "omitted-release",
                measured.replace(
                    "fwp_array_builder *owner = arg;",
                    "fwp_array_builder *owner = arg; (void)owner; return;",
                ),
                193,
            ),
        ] {
            let binary = dir.join(format!("{label}{opt}"));
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let output = Command::new(binary)
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                output.status.code(),
                Some(expected),
                "{label} {opt}: {output:?}"
            );
        }
    }
}
