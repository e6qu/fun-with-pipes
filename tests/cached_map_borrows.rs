//! Scoped cached reads preserve initialization, ownership and reentrant callers.
use std::io::{ErrorKind, Write};
use std::process::{Command, Output, Stdio};

fn run(command: &mut Command, input: &[u8]) -> Output {
    let mut child = command
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    if let Err(error) = child.stdin.take().unwrap().write_all(input) {
        // Rejected runtime settings exit before reading stdin. Keep the exit
        // status and diagnostic so each caller still checks the actual failure.
        assert_eq!(error.kind(), ErrorKind::BrokenPipe, "{error}");
    }
    child.wait_with_output().unwrap()
}

#[test]
fn cached_numeric_map_reads_borrow_and_preserve_reentrant_owners() {
    let directory = fwp::cgen::TempDir::new("cached-map-borrows").unwrap();
    let source = directory.join("program.fwp");
    std::fs::write(
        &source,
        r#"
key : I64 -> I64
key = mul 3 | rem 17
table : Map[I64, I64]
table = range 0 8 | map (fork (curry id) key id) | map.from-list
hit : I64 -> I64
hit = key | flip map.get table | option.unwrap-or 0
main = read-all () | string.length | range 0 | map hit | sum | echo
"#,
    )
    .unwrap();
    let inputs: [&[u8]; 2] = [b"", b"abcdefghijklmnop"];
    let reference: Vec<_> = inputs
        .iter()
        .map(|input| {
            let result = run(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env("FWP_NO_OPT", "1")
                    .args(["run", "--interp"])
                    .arg(&source),
                input,
            );
            assert!(result.status.success(), "{result:?}");
            result.stdout
        })
        .collect();
    for mode in ["arc", "tracing"] {
        let generated = directory.join(format!("{mode}.c"));
        let build = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", mode, "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&generated)
            .output()
            .unwrap();
        assert!(build.status.success(), "{build:?}");
        let code = std::fs::read_to_string(&generated).unwrap();
        let start = "static __attribute__((noinline)) V fwp_caf_init";
        assert!(
            code.contains(start),
            "numeric lookup must use a proved cached borrow"
        );
        let id = code.split(start).nth(1).unwrap().split('(').next().unwrap();
        let init = format!("{start}{id}(void) {{ V next = f{id}();");
        assert_eq!(code.matches(&init).count(), 1);
        let init_body = code
            .split(&init)
            .nth(1)
            .unwrap()
            .split('\n')
            .next()
            .unwrap();
        let drop = init_body
            .split("(previous);")
            .next()
            .unwrap()
            .split_whitespace()
            .next_back()
            .unwrap();
        let mut instrumented = code.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic V borrow_seen, borrow_held; static unsigned borrow_initializations, borrow_retains; static int borrow_reenter, borrow_entered;");
        instrumented = instrumented.replace(&init, &format!(
            "static V caf{id}(void);\n{start}{id}(void) {{ borrow_initializations++; if (borrow_reenter && !borrow_entered) {{ borrow_entered=1; borrow_held=caf{id}(); }} V next = f{id}();"));
        instrumented = instrumented.replace(
            &format!("fwp_caf_value{id} = next;"),
            &format!("borrow_seen=next; borrow_retains=0; fwp_caf_value{id} = next;"),
        );
        instrumented = instrumented.replace("static inline void fwp_rc_dup(V v) {", "static inline void fwp_rc_dup(V v) { if (borrow_seen && v==borrow_seen) borrow_retains++;");
        instrumented = instrumented.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let probe = format!(
            r#"
int main(int argc, char **argv) {{
    int inputs=atoi(argv[1]); borrow_reenter=atoi(argv[2]);
    int result=original_main(1,argv); if(result)return result;
    if(borrow_initializations!=(unsigned)(inputs ? 1+borrow_reenter : 0))return 201;
    if(borrow_seen) {{
        uint8_t *slot=fwp_rc_slot(borrow_seen);
        if(slot && *slot)return 202;
    }}
    if(borrow_held) {{
        uint8_t *slot=fwp_rc_slot(borrow_held);
        if(!slot || *slot!=1 || MAP(borrow_held)->len!=8)return 203;
        {drop}(borrow_held);
    }}
    if(borrow_retains)return 204;
    return 0;
}}
"#
        );
        for optimization in ["-O1", "-O2"] {
            let executable = directory
                .join(format!("{mode}{optimization}"))
                .with_extension(std::env::consts::EXE_EXTENSION);
            fwp::cgen::compile_c(
                &format!("{instrumented}\n{probe}"),
                &executable,
                optimization,
            )
            .unwrap();
            for reenter in ["0", "1"] {
                for poison in ["0", "1"] {
                    for (input, expected) in inputs.iter().zip(&reference) {
                        let actual = run(
                            Command::new(&executable)
                                .args([&input.len().to_string(), reenter])
                                .env_remove("FWP_GC")
                                .env("FWP_GC_STRESS", if mode == "arc" { "0" } else { "1" })
                                .env("FWP_GC_VERIFY", if mode == "arc" { "0" } else { "1" })
                                .env("FWP_REUSE_VERIFY", poison),
                            input,
                        );
                        if mode == "arc" && poison == "1" {
                            assert_eq!(actual.status.code(), Some(101));
                            assert!(String::from_utf8_lossy(&actual.stderr).contains(
                                "--gc arc cannot retain released storage for reuse verification"
                            ));
                            continue;
                        }
                        assert!(
                            actual.status.success(),
                            "{mode} {optimization} reenter={reenter} poison={poison}: {actual:?}"
                        );
                        assert_eq!(&actual.stdout, expected);
                        assert!(actual.stderr.is_empty());
                    }
                }
            }
            for (broken, expected) in [
                (instrumented.replace("    fwp_caf_finish();", ""), 202),
                (instrumented.replace(&format!("{drop}(previous);"), ""), 203),
            ] {
                fwp::cgen::compile_c(&format!("{broken}\n{probe}"), &executable, optimization)
                    .unwrap();
                let actual = run(
                    Command::new(&executable)
                        .args(["16", "1"])
                        .env("FWP_REUSE_VERIFY", "0"),
                    inputs[1],
                );
                assert_eq!(
                    actual.status.code(),
                    Some(expected),
                    "missing cleanup must fail: {actual:?}"
                );
            }
        }
    }
}

#[test]
fn cached_map_initialization_failure_releases_caller_owners() {
    let directory = fwp::cgen::TempDir::new("cached-map-trap").unwrap();
    let source = directory.join("program.fwp");
    std::fs::write(
        &source,
        r#"
cached : Map[I64, I64]
cached = 1 | div 0 | range 0 | map (fork (curry id) id id) | map.from-list
holder : String -> I64
holder = fork add (const cached | map.size) string.length
other : String -> I64
other = string.length
choose : Bool -> (String -> I64)
choose = if id (const holder) (const other)
main = [task.yield (), "input" | choose (read-all () | string.length | eq 0) | echo] | ignore
"#,
    )
    .unwrap();
    let reference = run(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
        b"",
    );
    assert!(!reference.status.success());
    for mode in ["arc", "tracing"] {
        let generated = directory.join(format!("{mode}.c"));
        let build = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .args(["build", "--gc", mode, "--emit-c"])
            .arg(&source)
            .arg("-o")
            .arg(&generated)
            .output()
            .unwrap();
        assert!(build.status.success(), "{build:?}");
        let code = std::fs::read_to_string(&generated).unwrap();
        let start = code.find("/* holder :").unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = &code[start..end];
        let id = body
            .lines()
            .find(|line| line.starts_with("static ") && line.contains('('))
            .unwrap()
            .split('(')
            .next()
            .unwrap()
            .split_whitespace()
            .next_back()
            .unwrap();
        let call = body
            .find(" = fwp_caf_borrow")
            .expect("holder must exercise borrowed initialization");
        let point = body[..call]
            .rfind("fwp_cleanup_push(")
            .expect("initializer must protect the caller");
        let stop = point + body[point..].find(';').unwrap() + 1;
        let push = &body[point..stop];
        let node = push.split('&').nth(1).unwrap().split(',').next().unwrap();
        let control_body =
            body.replacen(push, "", 1)
                .replacen(&format!("fwp_cleanup_pop(&{node});"), "", 1);
        let runtime = code.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let control = runtime.replacen(body, &control_body, 1);
        let probe = r#"
static jmp_buf trapped; static int recover(void){return 1;}
int main(void){
 fwp_heap_start();fwp_fns=fwp_fn_table;fwp_init_consts();
 for(int alias=0;alias<2;alias++){
  V input=fwp_rc_fresh(fwp_str_new("input",5));if(alias)fwp_rc_dup(input);
  fwp_trap_recover=recover;fwp_trap_jb=&trapped;fwp_trap_cleanup=0;
  if(setjmp(trapped)==0){FUNCTION(input);return 1;}
  fwp_trap_recover=0;fwp_trap_jb=0;
  if(fwp_cleanups)return 2;
  if(alias){if(*fwp_rc_slot(input)!=1||STR(input)->len!=5)return 3;fwp_rc_free_obj(input);}
  else {
   if(*fwp_rc_slot(input)!=0)return 4;
  }
 }
 fwp_caf_finish();return 0;
}
"#
        .replace("FUNCTION", id);
        let executable = directory
            .join(mode)
            .with_extension(std::env::consts::EXE_EXTENSION);
        for optimization in ["-O1", "-O2"] {
            fwp::cgen::compile_c(&format!("{control}\n{probe}"), &executable, optimization)
                .unwrap();
            let broken = Command::new(&executable)
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                broken.status.code(),
                Some(4),
                "missing caller cleanup must fail: {broken:?}"
            );
            fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &executable, optimization)
                .unwrap();
            for poison in if mode == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                let result = Command::new(&executable)
                    .env("FWP_REUSE_VERIFY", poison)
                    .env("FWP_GC_STRESS", if mode == "arc" { "0" } else { "1" })
                    .env("FWP_GC_VERIFY", if mode == "arc" { "0" } else { "1" })
                    .output()
                    .unwrap();
                assert!(result.status.success(), "{mode} {optimization}: {result:?}");
            }
            fwp::cgen::compile_c(&code, &executable, optimization).unwrap();
            let native = run(Command::new(&executable).env("FWP_REUSE_VERIFY", "0"), b"");
            assert_eq!(native.status.code(), reference.status.code());
            assert_eq!(native.stdout, reference.stdout);
            assert_eq!(native.stderr, reference.stderr);
        }
    }
}

#[test]
fn cached_borrows_preserve_direct_record_and_variant_results() {
    let directory = fwp::cgen::TempDir::new("cached-map-results").unwrap();
    for (ty, result, missing) in [
        ("(I64, I64)", "both id (add 1)", "both id id"),
        (
            "AnswerResult",
            "fork Answer id (add 1)",
            "const (Answer 0 0)",
        ),
    ] {
        let source = directory.join("program.fwp");
        std::fs::write(
            &source,
            format!(
                r#"
AnswerResult = | Answer I64 I64
table : Map[I64, I64]
table = [(1, 7), (2, 9)] | map.from-list
lookup : I64 -> {ty}
lookup = flip map.get table | option.unwrap-or 0 | {result}
missing : I64 -> {ty}
missing = {missing}
choose : Bool -> (I64 -> {ty})
choose = if id (const lookup) (const missing)
main = 1 | choose (read-all () | string.length | eq 0) | echo
"#
            ),
        )
        .unwrap();
        let inputs: [&[u8]; 2] = [b"", b"x"];
        let reference: Vec<_> = inputs
            .iter()
            .map(|input| {
                let result = run(
                    Command::new(env!("CARGO_BIN_EXE_fwp"))
                        .env("FWP_NO_OPT", "1")
                        .args(["run", "--interp"])
                        .arg(&source),
                    input,
                );
                assert!(result.status.success(), "{result:?}");
                result.stdout
            })
            .collect();
        for mode in ["arc", "tracing"] {
            let generated = directory.join("program.c");
            let build = Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", mode, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&generated)
                .output()
                .unwrap();
            assert!(build.status.success(), "{build:?}");
            let code = std::fs::read_to_string(&generated).unwrap();
            let worker = code
                .split("/* lookup :")
                .nth(1)
                .unwrap()
                .split("\n}\n")
                .next()
                .unwrap();
            assert!(worker.contains("fwp_caf_borrow"), "{worker}");
            for allocation in ["fwp_record(", "fwp_some(", "fwp_vbox", "fwp_vunbox"] {
                assert!(
                    !worker.contains(allocation),
                    "borrow must preserve direct {ty} results: {worker}"
                );
            }
            for optimization in ["-O1", "-O2"] {
                let executable = directory
                    .join("program")
                    .with_extension(std::env::consts::EXE_EXTENSION);
                fwp::cgen::compile_c(&code, &executable, optimization).unwrap();
                for (input, expected) in inputs.iter().zip(&reference) {
                    let actual = run(
                        Command::new(&executable)
                            .env_remove("FWP_GC")
                            .env("FWP_GC_STRESS", if mode == "arc" { "0" } else { "1" })
                            .env("FWP_GC_VERIFY", if mode == "arc" { "0" } else { "1" })
                            .env("FWP_REUSE_VERIFY", if mode == "arc" { "0" } else { "1" }),
                        input,
                    );
                    assert!(actual.status.success(), "{mode} {optimization}: {actual:?}");
                    assert_eq!(&actual.stdout, expected);
                    assert!(actual.stderr.is_empty());
                }
            }
        }
    }
}
