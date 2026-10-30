//! Initial flattened loop state must retain exact partial owners on unwind.
use std::process::Command;
#[path = "support/record_probe.rs"]
mod record_probe;
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
fn flattened_loop_preparation_releases_original_and_partial_fields() {
    let dir = std::env::temp_dir().join(format!("fwp-loop-preparation-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let src = dir.join("probe.fwp");
    let cfile = dir.join("probe.c");
    let exe = dir.join("probe.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(
        &src,
        r#"step : (I64, String, String, F64) -> Step[(I64, String, String, F64), String]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | concat "x", 2 = .2 | concat "y", 3 = .3 } | Again)
main = [task.yield (), (1, "left", "right", 17.0) | loop step | echo] | ignore
"#,
    )
    .unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    {
        checked(
            Command::new(fwp)
                .args(["build", "--memory", "dynamic"])
                .env("FWP_STACK", "1")
                .arg(&src)
                .args(["--emit-c", "-O2", "-o"])
                .arg(&cfile),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let start = emitted.find("/* loop of step :").unwrap();
        let body = &emitted[start..];
        let id = body
            .split("static V fwp_loop")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let start = emitted
            .find(&format!("static V fwp_loop{id}(V s) {{"))
            .unwrap();
        let end = start + emitted[start..].find("\n}\n").unwrap() + 3;
        let original = &emitted[start..end];
        assert!(
            emitted.contains(&format!(
                "typedef struct {{ V v0; V v1; V v2; double v3; }} fwp_loop_state{id};"
            )),
            "state must flatten: {original}"
        );
        assert!(
            original.contains("prepared.v0 = st.v1") && original.contains("prepared.v1 = st.v2")
        );
        let probe = r#"
static volatile V first, second, scalar_word, state_box;
static jmp_buf failed_preparation;
static int recover_preparation(void) { return 1; }
static int dead(V v) {
    return *fwp_rc_slot(v) == 0;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 100;
#endif
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    for (volatile int round=0; round<32; round++) {
    for (volatile int fail=0; fail<2; fail++) for (volatile int box_alias=0;box_alias<2;box_alias++)
    for (volatile int leaf_alias=0;leaf_alias<2;leaf_alias++) for (volatile int same=0;same<2;same++) {
        first=fwp_rc_fresh(fwp_str_new("first",5));
        if (same) { second=first; fwp_rc_dup(second); }
        else second=fwp_rc_fresh(fwp_str_new("other",5));
        if (leaf_alias) { fwp_rc_dup(first); fwp_rc_dup(second); }
        scalar_word=fwp_rc_fresh(fwp_str_new("scalar bits",11));
        state_box=fwp_rc_fresh(fwp_record(4,(V[]){1,first,second,scalar_word}));
        if (box_alias) fwp_rc_dup(state_box);
        wanted_dup=fail; current_dup=0;
        fwp_trap_recover=recover_preparation; fwp_trap_jb=&failed_preparation; fwp_trap_cleanup=0;
        if (!setjmp(failed_preparation)) { LOOP(state_box); return 1; }
        fwp_trap_recover=0;fwp_trap_jb=0;
        if (fwp_cleanups || current_dup!=fail+1) return 2;
        uint32_t expected=(box_alias+leaf_alias)*(same?2:1);
        if (expected) {
            if (*fwp_rc_slot(first)!=expected || STR(first)->len!=5) return 3;
            if (*fwp_rc_slot(second)!=expected || STR(second)->len!=5) return 4;
        } else if (!dead(first) || !dead(second)) return 5;
        if (*fwp_rc_slot(scalar_word)!=1 || STR(scalar_word)->len!=11) return 6;
        if (box_alias) INPUT_DROP(state_box);
        if (leaf_alias) { STRING_DROP(first);STRING_DROP(second); }
        fwp_rc_free_obj(scalar_word);
    }
    if (fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 90;
    }
    puts("flattened preparation releases partial fields and preserves aliases and scalar bits");return 0;
}
"#;
        let input_scope = original
            .split("fwp_cleanup_push(&input_cleanup, fwp_owner_release")
            .nth(1)
            .unwrap()
            .split(',')
            .next()
            .unwrap();
        let cleanup = emitted
            .split(&format!(
                "static void fwp_owner_release{input_scope}(void *arg) {{"
            ))
            .nth(1)
            .unwrap()
            .split('}')
            .next()
            .unwrap();
        let input_drop = cleanup
            .split("; ")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
            .trim();
        let scope = original
            .split("fwp_cleanup_push(&preparation_cleanup, fwp_owner_release")
            .nth(1)
            .unwrap()
            .split(',')
            .next()
            .unwrap();
        let cleanup = emitted
            .split(&format!(
                "static void fwp_owner_release{scope}(void *arg) {{"
            ))
            .nth(1)
            .unwrap()
            .split('}')
            .next()
            .unwrap();
        let string_drop = cleanup
            .split("; ")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
            .trim();
        let probe = probe
            .replace("LOOP", &format!("fwp_loop{id}"))
            .replace("INPUT_DROP", input_drop)
            .replace("STRING_DROP", string_drop);
        let failing = original
        .replace(
            "fwp_rc_dup(st.v1);",
            "if (current_dup++==wanted_dup) fwp_trap(\"preparation fault\"); fwp_rc_dup(st.v1);",
        )
        .replace(
            "fwp_rc_dup(st.v2);",
            "if (current_dup++==wanted_dup) fwp_trap(\"preparation fault\"); fwp_rc_dup(st.v2);",
        );
        let runtime = "static int wanted_dup, current_dup;\n".to_string()
            + &emitted.replacen(original, &failing, 1).replace(
                "int main(int argc, char **argv)",
                "int original_main(int argc, char **argv)",
            );
        let old = failing
            .replace(
                &format!(
                    "fwp_cleanup_push(&preparation_cleanup, fwp_owner_release{scope}, &prepared);"
                ),
                "",
            )
            .replace("prepared.v0 = st.v1;", "")
            .replace("prepared.v1 = st.v2;", "")
            .replace("fwp_cleanup_pop(&preparation_cleanup);", "");
        let old_runtime = runtime.replacen(&failing, &old, 1);
        for opt in ["-O1", "-O2"] {
            {
                let missing = probe.replace("fwp_rc_free_obj(scalar_word);", "");
                assert_ne!(missing, probe);
                fwp::cgen::compile_c(&format!("{runtime}\n{missing}"), &exe, opt).unwrap();
                let out = Command::new(&exe).output().unwrap();
                record_probe::save(
                    "loop_preparation_ownership",
                    &format!("counted{opt}-missing-release"),
                    &format!("{runtime}\n{missing}"),
                    &exe,
                    &out,
                );
                assert_eq!(out.status.code(), Some(90), "counted {opt}: {out:?}");
            }
            fwp::cgen::compile_c(&format!("{old_runtime}\n{probe}"), &exe, opt).unwrap();
            let control = Command::new(&exe).output().unwrap();
            record_probe::save(
                "loop_preparation_ownership",
                &format!("counted{opt}-missing-scope"),
                &format!("{old_runtime}\n{probe}"),
                &exe,
                &control,
            );
            assert_eq!(
                control.status.code(),
                Some(5),
                "missing partial cleanup must retain an extra field"
            );
            fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
            {
                let out = Command::new(&exe).output().unwrap();
                record_probe::save(
                    "loop_preparation_ownership",
                    &format!("counted{opt}-normal"),
                    &format!("{runtime}\n{probe}"),
                    &exe,
                    &out,
                );
                assert!(out.status.success(), "counted {opt}: {out:?}");
                assert_eq!(out.stdout, b"flattened preparation releases partial fields and preserves aliases and scalar bits\n");
            }
            checked(
                Command::new(fwp)
                    .args(["build", "--memory", "dynamic"])
                    .env("FWP_STACK", "1")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            let out = checked(&mut Command::new(&exe));
            assert_eq!(out.stdout, reference.stdout);
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}
