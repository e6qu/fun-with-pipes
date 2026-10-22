//! Scoped C borrows and callbacks retain typed owners through reentry/unwind.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn scoped_foreign_graphs_reclaim_after_callbacks_suspend_or_fail() {
    let dir = fwp::cgen::TempDir::new("fwp-foreign-owners").unwrap();
    let host = dir.join("host.c");
    std::fs::write(&host, r#"
#include <stdint.h>
#include <string.h>
const char *text_alias(const char *s) { return s; }
int64_t invoke(int64_t (*f)(int64_t),int64_t x) { return f(x)+f(x+1); }
int64_t byte_sum(const uint8_t *s, int64_t n) { int64_t r=0;for(int64_t i=0;i<n;i++)r+=s[i];return r; }
struct fwp_binary128 { uint64_t low, high; };
struct fwp_binary128 invoke_quad(struct fwp_binary128 (*f)(struct fwp_binary128),struct fwp_binary128 x) { return f(f(x)); }
/* The stack buffer belongs to C for this call, including nested callbacks. */
int64_t invoke_pointer(void *(*f)(void *)) {
    int64_t value=37;
    return f(&value)==&value && f(NULL)==NULL ? value : -1;
}
int64_t invoke_pointer_error(void *(*f)(void *)) {
    int64_t value=37;
    (void)f(&value);
    return 0;
}
"#).unwrap();
    let source = dir.join("owners.fwp");
    std::fs::write(
        &source,
        r#"
foreign "C" text-alias : String -> String = "text_alias"
foreign "C" invoke : (I64 -> I64) -> I64 -> I64
foreign "C" invoke-error : (I64 -> I64 ! {Error[String]}) -> I64 -> I64 ! {Error[String]} = "invoke"
foreign "C" invoke-async : (I64 -> I64 ! {Async}) -> I64 -> I64 ! {Async} = "invoke"
foreign "C" byte-sum : Bytes -> I64 -> I64 = "byte_sum"
foreign "C" invoke-quad : (F128 -> F128) -> F128 -> F128 = "invoke_quad"
foreign "C" invoke-pointer : (Option[Ptr[I64]] -> Option[Ptr[I64]]) -> I64 = "invoke_pointer"
foreign "C" invoke-pointer-error : (Option[Ptr[I64]] -> Option[Ptr[I64]] ! {Error[String]}) -> I64 ! {Error[String]} = "invoke_pointer_error"
foreign "C" invoke-pointer-async : (Option[Ptr[I64]] -> Option[Ptr[I64]] ! {Async}) -> I64 ! {Async} = "invoke_pointer"
pointer-error : Option[Ptr[I64]] -> Option[Ptr[I64]] ! {Error[String]}
pointer-error = const "pointer callback error" | fail
pointer-yield : Option[Ptr[I64]] -> Option[Ptr[I64]] ! {Async}
pointer-yield = tap (const () | task.yield)
pointer-block : Option[Ptr[I64]] -> Option[Ptr[I64]] ! {Async}
pointer-block = tap (const 1h | task.sleep)
pointer-work : () -> I64 ! {Async}
pointer-work = const pointer-block | invoke-pointer-async
pointer-nested : Option[Ptr[I64]] -> Option[Ptr[I64]]
pointer-nested = tap (const id | invoke-pointer | ignore)
quad-work : F128 -> F128
quad-work = invoke-quad (mul 2.0f128)
capture : String -> I64 -> I64
capture = curry (fork add (.0 | string.length) .1)
nested : I64 -> I64
nested = invoke (add 10) | add 1
raising : I64 -> I64 ! {Error[String]}
raising = const "foreign error" | fail
delayed-add : I64 -> I64 -> I64 ! {Async}
delayed-add = curry (tap (const () | task.yield) | uncurry add)
async-work : I64 -> I64 ! {Async}
async-work = compose delayed-add (flip invoke-async 7)
blocked : I64 -> I64 ! {Async}
blocked = tap (const 1h | task.sleep)
blocked-work : () -> I64 ! {Async}
blocked-work = const 1 | invoke-async blocked
main = [
    range 0 65 | map (const id | invoke-pointer) | sum | echo,
    invoke-pointer pointer-nested | echo,
    attempt invoke-pointer-error pointer-error | echo,
    invoke-pointer-async pointer-yield | echo,
    task.spawn pointer-work | tap (const () | task.yield) | tap task.cancel | task.await | echo,
    range 0 65 | map (show | string.repeat 3 | text-alias | both id string.length) | length | echo,
    invoke (capture ("captured" | string.repeat 3)) 7 | echo,
    invoke nested 5 | echo,
    1 | attempt (invoke-error raising) | echo,
    invoke (add 1) 7 | echo,
    range 0 3 | task.map async-work | echo,
    task.spawn blocked-work | tap (const () | task.yield) | tap task.cancel | task.await | echo,
    byte-sum ("ABC" | string.to-bytes) 3 | echo,
    range 0 65 | map (int.to-float | quad-work) | sum | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp", "--link"])
            .arg(&host)
            .arg(&source),
    );
    for gc in ["tracing", "arc"] {
        let cfile = dir.join(format!("{gc}.c"));
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--emit-c", "--gc", gc])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(cfile).unwrap();
        code.push_str(
            &std::fs::read_to_string(&host)
                .unwrap()
                .replace("struct fwp_binary128 { uint64_t low, high; };", ""),
        );
        if gc == "arc" {
            let start = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (runtime, main) = code.split_at(start);
            assert_eq!(main.matches("    fwp_init_consts();\n").count(), 1);
            assert_eq!(
                main.matches("    /* Ownership observation point: before runtime teardown. */\n")
                    .count(),
                1
            );
            code = format!("{runtime}{}", main
                .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    fwp_tasks_init();\n    intptr_t foreign_budget=fwp_gc.budget_given;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_foreign_callbacks || fwp_gc.ncollect || fwp_gc.enabled || fwp_gc.budget < foreign_budget) { fprintf(stderr,\"foreign bytes left: %ld\\n\",(long)(foreign_budget-fwp_gc.budget)); exit(193); }\n"));
        }
        for opt in ["-O1", "-O2"] {
            let binary = dir.join(format!("{gc}{opt}"));
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let verify = if gc == "arc" { "0" } else { "1" };
            let output = checked(
                Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", verify),
            );
            assert_eq!(output.stdout, reference.stdout, "{gc} {opt}");
            assert_eq!(output.stderr, reference.stderr, "{gc} {opt}");
            if let Some(root) = std::env::var_os("FWP_POINTER_ARTIFACTS") {
                let root = std::path::PathBuf::from(root);
                std::fs::create_dir_all(&root).unwrap();
                let stem = format!("callbacks-{gc}{opt}");
                std::fs::write(root.join(format!("{stem}.c")), &code).unwrap();
                std::fs::copy(&binary, root.join(format!("{stem}.exe"))).unwrap();
                std::fs::write(root.join(format!("{stem}.stdout")), &output.stdout).unwrap();
                std::fs::write(root.join(format!("{stem}.stderr")), &output.stderr).unwrap();
                std::fs::write(root.join(format!("{stem}.status")), "0\n").unwrap();
            }

            if gc == "arc" {
                let release = code
                    .lines()
                    .find(|line| line.contains("/* foreign callback result owner */"))
                    .unwrap();
                let omitted_release =
                    code.replace(release, "    /* omit callback result release */");
                fwp::cgen::compile_c(&omitted_release, &binary, opt).unwrap();
                let output = Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(193),
                    "omitted callback release: {output:?}"
                );
                let needle = "    from->foreign_callbacks = fwp_foreign_callbacks;";
                assert_eq!(code.matches(needle).count(), 1);
                let omitted = code.replace(needle, "    /* omit suspended C callback context */");
                fwp::cgen::compile_c(&omitted, &binary, opt).unwrap();
                let output = Command::new(binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert!(
                    !output.status.success(),
                    "omitted context must fail: {output:?}"
                );
            }
        }
    }
}
