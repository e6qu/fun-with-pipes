//! Reconstructed trees and wide numbers must physically reclaim in checked ARC.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

#[test]
fn extended_owners_match_raw_interpreter_and_reclaim() {
    let dir = std::env::temp_dir().join(format!("fwp-arc-extensions-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let cases = [
        (
            "csv",
            r#"
rows : I64 -> List[List[String]]
rows = show | concat "a,b\n\"quoted,field\",\"escaped\"\"quote\"\nlast," | csv.parse
main = [
    range 0 64 | map (rows | both id (map (map string.length)) | show) | length | echo,
    "" | csv.parse | echo,
    "a,b\r\n\n\"open" | csv.parse | echo,
    "a;b\nc;d" | csv.parse-with ";" | echo,
    "aéb\ncé" | csv.parse-with "é" | echo,
] | ignore
"#,
        ),
        (
            "wide",
            r#"
signed : I64 -> I128
signed = from-int
unsigned : I64 -> U128
unsigned = from-int
signed-result : Option[I128] -> Option[I128]
signed-result = id
work : I128 -> (I128, I128, I128, Option[I128], (I128, Bool))
work = make { 0 = add 2i128 | mul 3i128, 1 = neg | abs, 2 = abs,
    3 = checked.add 3i128, 4 = overflowing.mul 2i128 }
main = [
    range 0 129 | map (signed | work | show) | length | echo,
    range 0 129 | map (unsigned | add 1u128 | bit.shl 65 | show) | length | echo,
    range 0i128 33i128 | array.from-list | both id array.to-list | show | string.length | echo,
    range 0u128 33u128 | map (max 3u128 | min 30u128) | show | echo,
    -170141183460469231731687303715884105728i128 | show | echo,
    170141183460469231731687303715884105727i128 | checked.add 1i128 | echo,
    340282366920938463463374607431768211455u128 | wrapping.add 1u128 | echo,
    42 | int.convert | signed-result | echo,
] | ignore
"#,
        ),
        (
            "scoped-ad",
            r#"
loss : List[Rev[F64]] -> Rev[F64]
loss = nth 0 | option.unwrap-or (rev.const 0.0) | fork mul id id
main = [
    range 0 33 | map (int.to-float | singleton | grad loss | sum) | sum | echo,
    range 0 8 | map (ad.scope ad.tape) | length | echo,
    [3.0] | value-and-grad loss | echo,
] | ignore
"#,
        ),
    ];
    for (name, source) in cases {
        let input = dir.join(format!("{name}.fwp"));
        std::fs::write(&input, source).unwrap();
        let reference = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&input),
        );
        for stack in ["0", "1"] {
            let cfile = dir.join(format!("{name}-{stack}.c"));
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", stack)
                    .args(["build", "--gc", "arc", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let emitted = std::fs::read_to_string(&cfile).unwrap();
            let main = emitted
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, body) = emitted.split_at(main);
            let body = body.replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    intptr_t extension_budget = fwp_gc.budget;\n")
                .replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    if(fwp_gc.ncollect || fwp_gc.budget < extension_budget) { fprintf(stderr, \"unreclaimed: %ld\\n\", (long)(extension_budget-fwp_gc.budget)); exit(193); }\n");
            let body = if name == "scoped-ad" {
                body.replace("    fwp_cl_finish();\n", "    fwp_cl_finish();\n    for (int64_t i=0;i<fwp_ntapes;i++) if(fwp_tapes[i].live) exit(194);\n    if(fwp_tape_cached_bytes > FWP_AD_WORKSPACE_BUDGET) exit(195);\n")
            } else {
                body
            };
            let measured = format!("{runtime}{body}");
            for opt in ["-O1", "-O2"] {
                let binary = dir.join(format!("{name}-{stack}{opt}"));
                fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
                if let Some(root) = std::env::var_os("FWP_ARC_ARTIFACTS") {
                    let root = std::path::PathBuf::from(root);
                    std::fs::create_dir_all(&root).unwrap();
                    std::fs::write(root.join(format!("{name}-{stack}{opt}.c")), &measured).unwrap();
                    let asm = checked(
                        Command::new(if cfg!(target_os = "macos") {
                            "otool"
                        } else {
                            "objdump"
                        })
                        .arg(if cfg!(target_os = "macos") {
                            "-tvV"
                        } else {
                            "-d"
                        })
                        .arg(&binary),
                    );
                    std::fs::write(root.join(format!("{name}-{stack}{opt}.asm")), asm.stdout)
                        .unwrap();
                }
                let actual = checked(&mut Command::new(&binary));
                assert_eq!(actual.stdout, reference.stdout, "{name}/{stack}/{opt}");
                assert!(actual.stderr.is_empty(), "{actual:?}");
            }
            // Omitting physical freeing must fail the same live-storage ledger.
            let omitted = measured.replace(
                "static void fwp_rc_free_obj(V v) {",
                "static void fwp_rc_free_obj(V v) { return;",
            );
            assert_ne!(omitted, measured);
            let binary = dir.join(format!("{name}-{stack}-omitted"));
            fwp::cgen::compile_c(&omitted, &binary, "-O1").unwrap();
            assert_eq!(
                Command::new(binary).output().unwrap().status.code(),
                Some(193)
            );
        }
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn raw_ad_cannot_escape_scope_proof_through_callbacks_or_arguments() {
    let dir = std::env::temp_dir().join(format!("fwp-ad-scope-rejections-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    for (name, source) in [
        ("direct", "main = 1 | ad.tape | echo\n"),
        ("before-scope", "main = 1 | ad.tape | ad.scope id | echo\n"),
        (
            "returned-callback",
            "escaped : () -> I64 -> I64\nescaped = ad.scope (const ad.tape)\nmain = escaped () 1 | echo\n",
        ),
        (
            "container-callback",
            "main = [1] | list.ap [ad.tape] | echo\n",
        ),
    ] {
        let source_path = dir.join(format!("{name}.fwp"));
        std::fs::write(&source_path, source).unwrap();
        let result = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&source_path)
            .arg("-o")
            .arg(dir.join("rejected.c"))
            .output()
            .unwrap();
        assert!(!result.status.success(), "{name}");
        let error = String::from_utf8_lossy(&result.stderr);
        assert!(
            error.contains("tracing-free lifetime policy"),
            "{name}: {error}"
        );
    }
    std::fs::remove_dir_all(dir).unwrap();
}

#[test]
fn csv_partial_construction_releases_fields_rows_and_scratch_on_trap() {
    let dir = std::env::temp_dir().join(format!("fwp-csv-unwind-{}", std::process::id()));
    std::fs::create_dir_all(&dir).unwrap();
    let input = dir.join("csv.fwp");
    std::fs::write(&input, "main = \"a,b\\nc,d\" | csv.parse | echo\n").unwrap();
    let cfile = dir.join("csv.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--gc", "arc", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let call = code
        .split("return fwp_p_csv_parse_with(")
        .nth(1)
        .unwrap()
        .split(");")
        .next()
        .unwrap();
    let args: Vec<_> = call.split(", ").collect();
    assert_eq!(args.len(), 5);
    let call = format!(
        "fwp_p_csv_parse_with(separator, text, {}, {}, {})",
        args[2], args[3], args[4]
    );
    let probe = format!(
        r#"
static int csv_recover(void) {{ return 1; }}
int main(void) {{
    fwp_gc_start(__builtin_frame_address(0)); fwp_fns=fwp_fn_table; fwp_init_consts();
    V separator=fwp_cstr(","), text=fwp_cstr("a,b\nc,d\ne,f");
    intptr_t budget=fwp_gc.budget;
    jmp_buf trap; fwp_trap_jb=&trap; fwp_trap_cleanup=0; fwp_trap_recover=csv_recover;
    for(csv_probe_at=1;csv_probe_at<=6;csv_probe_at++) {{
        csv_probe_step=0;
        if(!setjmp(trap)) {{ (void){call}; return 191; }}
        if(strcmp(fwp_trap_msg,"CSV construction control")) return 192;
        if(fwp_cleanups || fwp_gc.budget!=budget) return 193;
    }}
    csv_probe_at=0;
    V rows={call};
    {drop_rows}(rows);
    if(fwp_cleanups || fwp_gc.budget!=budget || fwp_gc.ncollect) return 194;
    puts("CSV partial cleanup verified"); return 0;
}}
"#,
        drop_rows = args[3]
    );
    let declaration = "static int csv_probe_at,csv_probe_step; static void csv_probe_point(void){if(++csv_probe_step==csv_probe_at)fwp_trap(\"CSV construction control\");}\n";
    let code = code
        .replace(
            "static V fwp_p_csv_parse_with(V sepv",
            &format!("{declaration}static V fwp_p_csv_parse_with(V sepv"),
        )
        .replace(
            "owner.row = fwp_rc_fresh(fwp_cons(owner.field, owner.row));",
            "csv_probe_point(); owner.row = fwp_rc_fresh(fwp_cons(owner.field, owner.row));",
        )
        .replace(
            "owner.rows = fwp_rc_fresh(fwp_cons(owner.row, owner.rows));",
            "csv_probe_point(); owner.rows = fwp_rc_fresh(fwp_cons(owner.row, owner.rows));",
        )
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    let code = format!("{code}\n{probe}");
    let omitted = code.replace(
        "    o->drop_field(o->field);",
        "    /* omitted field release */",
    );
    assert_ne!(code, omitted);
    for opt in ["-O1", "-O2"] {
        let binary = dir.join(opt);
        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
        assert_eq!(
            checked(&mut Command::new(&binary)).stdout,
            b"CSV partial cleanup verified\n"
        );
        fwp::cgen::compile_c(&omitted, &binary, opt).unwrap();
        assert_eq!(
            Command::new(&binary).output().unwrap().status.code(),
            Some(193)
        );
    }
    std::fs::remove_dir_all(dir).unwrap();
}
