//! Reconstructed trees and wide numbers must physically reclaim in checked ARC.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let result = command.output().unwrap();
    assert!(result.status.success(), "{command:?}: {result:?}");
    result
}

#[test]
fn csv_and_wide_values_match_raw_interpreter_and_reclaim() {
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
            let measured = format!("{runtime}{body}");
            for opt in ["-O1", "-O2"] {
                let binary = dir.join(format!("{name}-{stack}{opt}"));
                fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
                let actual = checked(&mut Command::new(&binary));
                assert_eq!(actual.stdout, reference.stdout, "{name}/{stack}/{opt}");
                assert!(actual.stderr.is_empty(), "{actual:?}");
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
