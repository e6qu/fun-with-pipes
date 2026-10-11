//! Ownership of task passthrough values and fresh result wrappers.
use std::path::PathBuf;
use std::process::{Command, Output};

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
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join("tasks");
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        for poison in ["0", "1"] {
            let native = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(native.stdout, reference.stdout, "{opt}, poison={poison}");
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
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
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
    fwp_gc_start(__builtin_frame_address(0));
    V duration = fwp_data(0, 1, (V[]){INT64_MAX});
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    if (SCALAR(duration, bits) != bits || *fwp_rc_slot(bits) != 1) return 1;
    if (OWNED(duration, bits) != bits || *fwp_rc_slot(bits) != 2) return 2;
    fwp_rc_drop(bits);
    V ch = fwp_p_channel_make(1);
    fwp_p_channel_send(ch, bits); /* numeric bits: no reference transfer */
    V opt = RECV(ch);
    if (!opt || OBJ(opt)->f[0] != bits || *fwp_rc_slot(opt) != 1 ||
        *fwp_rc_slot(bits) != 1) return 3;
    fwp_p_channel_close(ch);
    if (RECV(ch) != FWP_NONE || *fwp_rc_slot(bits) != 1) return 4;
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
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        assert_eq!(
            checked(Command::new(&exe).env("FWP_GC_VERIFY", "1")).stdout,
            b"typed task aliases preserved\n"
        );
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
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    let current = std::fs::read_to_string(cfile).unwrap();
    let boundary = "fwp_rc_dup(l1); return fwp_p_task_deadline(l0, l1);";
    assert_eq!(current.matches(boundary).count(), 1);
    let shared = current.replace(
        boundary,
        "fwp_rc_share(l1); fwp_rc_dup(l1); return fwp_p_task_deadline(l0, l1);",
    );
    let mut freed = Vec::new();
    for (name, code) in [("shared", shared), ("owned", current)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(&code, &exe, "-O1").unwrap();
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC", "off")
                .env("FWP_GC_STATS", "1")
                .env("FWP_REUSE_VERIFY", "0"),
        );
        assert_eq!(out.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&out.stderr);
        assert!(stats.contains("fwp gc: 0 collections"), "{stats}");
        freed.push(
            stats
                .split(" MiB freed by counts")
                .next()
                .unwrap()
                .rsplit('(')
                .next()
                .unwrap()
                .parse::<f64>()
                .unwrap(),
        );
    }
    assert!(freed[1] > freed[0] + 0.2, "{freed:?}");
    eprintln!("deadline MiB freed by counts: {freed:?}");
}
