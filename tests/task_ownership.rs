//! Ownership of task passthrough values and fresh result wrappers.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/allocation_report.rs"]
mod allocation_report;

#[path = "support/record_probe.rs"]
mod record_probe;

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: {}",
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p =
            std::env::temp_dir().join(format!("fwp-task-contract-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[test]
fn failed_scopes_keep_error_values_and_all_spawned_children() {
    let dir = Scratch::new("failed-scope");
    let source = dir.0.join("scope.fwp");
    std::fs::write(
        &source,
        r#"
sleeping : I64 -> () -> I64 ! {Async}
sleeping = curry (.0 | tap (const 1h | task.sleep))
start : I64 -> () ! {Async}
start = sleeping | task.spawn | ignore
scope-failure : () -> () ! {Async, Error[String]}
scope-failure =
    const 0 | flip range 65 | each start
    | const "scope error" | string.repeat 2 | fail
round : I64 -> () ! {Async, IO}
round = const () | attempt (const scope-failure | task.scope) | echo
main = range 0 4 | each round
"#,
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert_eq!(
        reference.stdout,
        b"Err \"scope errorscope error\"\n".repeat(4)
    );
    assert!(reference.stderr.is_empty());
    for memory in ["arc", "tracing"] {
        let cfile = dir.0.join("scope.c");
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .args(["build", "--gc", memory, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(&cfile).unwrap();
        if memory == "arc" {
            let finish = "\n    /* Ownership observation point: before runtime teardown. */\n";
            assert_eq!(code.matches(finish).count(), 1);
            code = code.replace(
                finish,
                &format!("{finish}    if(fwp_heap.ncollect || 0!=fwp_heap.live)exit(83);\n"),
            );
        }
        for opt in ["-O0", "-O2", "-O3"] {
            let binary = dir.0.join("scope.exe");
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();
            let stress = if memory == "arc" { "0" } else { "1" };
            let actual = checked(
                Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress),
            );
            assert_eq!(
                (&actual.stdout, &actual.stderr),
                (&reference.stdout, &reference.stderr),
                "{memory}/{opt}"
            );
        }
    }
}

#[test]
fn task_values_and_channel_aliases_under_stress() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("tasks.fwp");
    std::fs::write(
        &src,
        r#"
Box = { text: String }
pass : String -> (String, String) ! {Async}
pass = both (task.deadline 1h) id
pass-box : Box -> (Box, Box) ! {Async}
pass-box = both (task.deadline 1h) id
pass-fn : (I64 -> I64 ! {Async | e}) -> (I64, I64) ! {Async | e}
pass-fn = both (task.deadline 1h | apply 2) (apply 3)
result : String -> () -> String
result = const
main = [
    "owned" | concat " value" | pass | echo,
    Box { text = "kept" | concat " record" } | pass-box | echo,
    pass-fn (add 40) | echo,
    42 | task.deadline 1h | echo,
    task.spawn (result ("result" | concat " alias"))
    | both task.await task.await | echo,
    2 | channel.make
    | tap (flip channel.send ("channel" | concat " alias") | ignore)
    | both channel.recv (tap channel.close | channel.recv) | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    for memory in ["arc", "tracing"] {
        let cfile = dir.0.join(format!("{memory}.c"));
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", "0")
                .env("FWP_FREE", "1")
                .env("FWP_REUSE", "1")
                .args([
                    "build", "--memory", "dynamic", "--gc", memory, "-O2", "--emit-c",
                ])
                .arg(&src)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("{memory}{opt}.exe"));
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for poison in if memory == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                let stress = if memory == "arc" { "0" } else { "1" };
                let native = Command::new(&exe)
                    .env("FWP_GC", if memory == "arc" { "off" } else { "on" })
                    .env("FWP_ALLOC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", poison)
                    .output()
                    .unwrap();
                let label = format!("{memory}{opt}-aliases-poison{poison}");
                record_probe::save("task_ownership", &label, &code, &exe, &native);
                assert_eq!(
                    native.status.code(),
                    reference.status.code(),
                    "{label}: {native:?}"
                );
                assert_eq!(native.stdout, reference.stdout, "{label}");
                assert_eq!(native.stderr, reference.stderr, "{label}");
            }
        }
    }
}

#[test]
fn deadline_aliases_count_only_owned_types() {
    let dir = Scratch::new("typed");
    let src = dir.0.join("typed.fwp");
    let cfile = dir.0.join("typed.c");
    std::fs::write(
        &src,
        r#"
main = [
    "owned" | concat " alias" | task.deadline 1h | echo,
    42 | task.deadline 1h | echo,
    1 | channel.make | tap (flip channel.send 42 | ignore) | channel.recv | echo,
] | ignore
"#,
    )
    .unwrap();
    for memory in ["arc", "tracing"] {
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", "0")
                .env("FWP_FREE", "1")
                .env("FWP_REUSE", "1")
                .args(["build", "--memory", "dynamic", "--gc", memory, "-O2"])
                .arg(&src)
                .args(["--emit-c", "-o"])
                .arg(&cfile),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let mut scalar = None;
        let mut owned = None;
        for (boundary, _) in emitted.match_indices("return fwp_p_task_deadline(l0, l1);") {
            let function = emitted[..boundary].rsplit("static V ").next().unwrap();
            let name = function.split('(').next().unwrap();
            if function.contains("fwp_rc_dup(l1)") {
                owned = Some(name);
            } else {
                scalar = Some(name);
            }
        }
        let recv_boundary = emitted.find("fwp_p_channel_recv_owned(l0, NULL)").unwrap();
        let recv = emitted[..recv_boundary]
            .rsplit("static V ")
            .next()
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let probe = r#"
int main(void) {
    fwp_heap_start();
    fwp_tasks_init();
    size_t baseline = fwp_heap.live;
    for (int round=0; round<32; round++) {
    V duration = fwp_rc_fresh(fwp_data(0, 1, (V[]){INT64_MAX}));
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    if (SCALAR(duration, bits) != bits || *fwp_rc_slot(bits) != 1) return 1;
    if (OWNED(duration, bits) != bits || *fwp_rc_slot(bits) != 2) return 2;
    fwp_rc_drop(bits);
    V ch = fwp_p_channel_make_owned(1, NULL);
    fwp_p_channel_send(ch, bits); /* numeric bits: no reference transfer */
    V opt = RECV(ch);
    if (!opt || OBJ(opt)->f[0] != bits || *fwp_rc_slot(opt) != 1 ||
        *fwp_rc_slot(bits) != 1) return 3;
    fwp_p_channel_close(ch);
    if (RECV(ch) != FWP_NONE || *fwp_rc_slot(bits) != 1) return 4;
    fwp_rc_free_obj(opt);
    fwp_channel_drop(ch);
    fwp_rc_free_obj(bits);
    fwp_rc_free_obj(duration);
#ifdef FWP_ARC_ONLY
    if (fwp_heap.live!=baseline || fwp_heap.rc_wide_len || fwp_heap.ncollect) return 90;
#endif
    }
    fwp_native_tasks_finish();
#ifdef FWP_ARC_ONLY
    if (fwp_heap.live!=0 || fwp_heap.rc_wide_len || fwp_heap.ncollect) return 90;
#endif
    puts("typed task aliases preserved");
    return 0;
}
"#
        .replace("SCALAR", scalar.expect("missing scalar deadline wrapper"))
        .replace("OWNED", owned.expect("missing owned deadline wrapper"))
        .replace("RECV", recv);
        let runtime = emitted.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let mut cases = vec![("typed", format!("{runtime}\n{probe}"), 0)];
        let boundary = "fwp_rc_dup(l1); return fwp_p_task_deadline(l0, l1);";
        assert_eq!(runtime.matches(boundary).count(), 1);
        cases.push((
            "missing-retain",
            format!(
                "{}\n{probe}",
                runtime.replace(boundary, "return fwp_p_task_deadline(l0, l1);")
            ),
            2,
        ));
        if memory == "arc" {
            for (label, release) in [
                ("missing-option", "fwp_rc_free_obj(opt);"),
                ("missing-channel", "fwp_channel_drop(ch);"),
                ("missing-scalar", "fwp_rc_free_obj(bits);"),
                ("missing-duration", "fwp_rc_free_obj(duration);"),
            ] {
                assert_eq!(probe.matches(release).count(), 1);
                cases.push((
                    label,
                    format!(
                        "{runtime}\n{}",
                        probe.replace(release, "/* omitted owner */")
                    ),
                    90,
                ));
            }
        }
        for opt in ["-O1", "-O2"] {
            for (label, code, expected) in &cases {
                let label = format!("{memory}{opt}-{label}");
                let exe = dir.0.join(format!("{label}.exe"));
                fwp::cgen::compile_c(code, &exe, opt).unwrap();
                let output = Command::new(&exe)
                    .env("FWP_ALLOC_STATS", "0")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                record_probe::save("task_ownership", &label, code, &exe, &output);
                assert_eq!(output.status.code(), Some(*expected), "{label}: {output:?}");
                assert!(output.stderr.is_empty(), "{output:?}");
                let stdout = String::from_utf8(output.stdout)
                    .unwrap()
                    .replace("\r\n", "\n");
                assert_eq!(
                    stdout,
                    if *expected == 0 {
                        "typed task aliases preserved\n"
                    } else {
                        ""
                    }
                );
            }
        }
    }
}

#[test]
fn deadline_passthrough_preserves_count_reclamation() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("counts.fwp");
    let cfile = dir.0.join("counts.c");
    std::fs::write(
        &src,
        r#"
size : I64 -> I64 ! {Async}
size = rem 64 | flip string.repeat "x" | task.deadline 1h | string.length
step : (I64, I64) -> Step[(I64, I64), I64] ! {Async}
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    for memory in ["arc", "tracing"] {
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_FREE", "1")
                .env("FWP_REUSE", "1")
                .args(["build", "--memory", "dynamic", "--gc", memory, "-O2"])
                .arg(&src)
                .args(["--emit-c", "-o"])
                .arg(&cfile)
                .env("FWP_STACK", "0"),
        );
        let current = std::fs::read_to_string(&cfile).unwrap();
        let boundary = "fwp_rc_dup(l1); return fwp_p_task_deadline(l0, l1);";
        assert_eq!(current.matches(boundary).count(), 1);
        if memory == "arc" {
            let finish = "\n    /* Ownership observation point: before runtime teardown. */\n";
            assert_eq!(current.matches(finish).count(), 1);
            let balanced = current.replace(finish, &format!("{finish}    if(fwp_heap.live!=0 || fwp_heap.rc_wide_len || fwp_heap.ncollect)exit(90);\n"));
            let missing = balanced.replace(
                boundary,
                "fwp_rc_dup(l1); fwp_rc_dup(l1); return fwp_p_task_deadline(l0, l1);",
            );
            for opt in ["-O1", "-O2"] {
                for (label, code, expected) in
                    [("reclamation", &balanced, 0), ("extra-owner", &missing, 90)]
                {
                    let label = format!("{memory}{opt}-{label}");
                    let exe = dir.0.join(format!("{label}.exe"));
                    fwp::cgen::compile_c(code, &exe, opt).unwrap();
                    let out = Command::new(&exe)
                        .env("FWP_ALLOC_STATS", "0")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    record_probe::save("task_ownership", &label, code, &exe, &out);
                    assert_eq!(out.status.code(), Some(expected), "{label}: {out:?}");
                    assert_eq!(out.stdout, reference.stdout, "{label}");
                    assert!(out.stderr.is_empty(), "{out:?}");
                }
            }
            continue;
        }
        let shared = current.replace(
            boundary,
            "fwp_rc_share(l1); fwp_rc_dup(l1); return fwp_p_task_deadline(l0, l1);",
        );
        let mut freed = Vec::new();
        for (name, code) in [("shared", shared), ("owned", current)] {
            let exe = dir.0.join(format!("{name}.exe"));
            fwp::cgen::compile_c(&code, &exe, "-O1").unwrap();
            let out = checked(
                Command::new(&exe)
                    .env("FWP_ALLOC_STATS", "1")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            record_probe::save(
                "task_ownership",
                &format!("tracing-O1-reclamation-{name}"),
                &code,
                &exe,
                &out,
            );
            assert_eq!(out.stdout, reference.stdout);
            let stats = String::from_utf8_lossy(&out.stderr);

            freed.push(
                allocation_report::parse(&stats)
                    .expect("allocation report")
                    .released as f64
                    / 1_048_576.0,
            );
        }
        assert!(freed[1] > freed[0] + 0.2, "{freed:?}");
        eprintln!("deadline MiB freed by counts: {freed:?}");
    }
}
