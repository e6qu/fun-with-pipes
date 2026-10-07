//! Generic and specialized loops transfer owned states and typed Step payloads.
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status {}\nstdout {}\nstderr {}",
        out.status,
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p = std::env::temp_dir().join(format!("fwp-loop-owner-{}-{name}", std::process::id()));
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
fn loop_states_and_step_payload_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
record-step : (I64, String) -> Step[(I64, String), String]
record-step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | concat "!" } | Again)
boxed-step : (I64, String) -> Step[(I64, String), String]
boxed-step = if (.0 | eq 0) (.1 | Stop) boxed-next
boxed-next : (I64, String) -> Step[(I64, String), String]
boxed-next = make { 0 = .0 | sub 1, 1 = .1 | concat "?" } | Again
indirect-step : (I64, String) -> Step[(I64, String), (I64, String)]
indirect-step = fork apply
    (make { 0 = .0 | sub 1, 1 = .1 | concat "!" })
    (if (.0 | le 0) (const Stop) (const Again))
Acc = { n: I64, text: String }
whole-step : Acc -> Step[Acc, String]
whole-step = if (.n | eq 0) (.text | Stop)
    (update { n = sub 1, text = concat "." } | Again)
nested-step : (I64, (String, String)) -> Step[(I64, (String, String)), (String, String)]
nested-step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | both (.0 | concat "x") (.1 | concat "y") } | Again)
captured : String -> (I64, String) -> Step[(I64, String), String]
captured = curry (if (.1 | .0 | eq 0) (.1 | .1 | Stop)
    (make { 0 = .1 | .0 | sub 1, 1 = fork concat .0 (.1 | .1) } | Again))
choose : Bool -> ((I64, String) -> Step[(I64, String), String])
choose = if id (const record-step) (const boxed-step)
keep-step : Step[I64, String] -> (String, Step[I64, String])
keep-step = both (const | flip loop 0) id
function-step : (I64, String -> String) -> Step[(I64, String -> String), String -> String]
function-step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 } | Again)
effect-step : (I64, String) -> Step[(I64, String), String] ! {IO}
effect-step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | tap echo | concat "!" } | Again)
main = [
    (3, "a b" | words | join "") | both (loop record-step) id | echo,
    (3, "a b" | words | join "") | loop boxed-step | concat "after:" | echo,
    (3, "a b" | words | join "") | loop indirect-step | .1 | echo,
    Acc { n = 3, text = "a b" | words | join "" } | loop whole-step | echo,
    (3, ("a b" | words | join "", "c d" | words | join "")) | loop nested-step | echo,
    (3, "seed") | loop (captured ("p q" | words | join "")) | echo,
    loop (choose (read-all () | string.length | eq 0)) (3, "dynamic") | echo,
    "a b" | words | join "" | Stop | keep-step | .0 | concat "kept:" | echo,
    apply "!" (loop function-step (3, concat ("a b" | words | join ""))) | echo,
    (3, "trace") | loop effect-step | echo,
    (0, "empty") | loop effect-step | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    for opt in ["-O1", "-O2"] {
        for stack in ["0", "1"] {
            let exe = dir.0.join(format!("aliases{opt}-{stack}"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_STACK", stack),
            );
            for poison in ["0", "1"] {
                let out = checked(
                    Command::new(&exe)
                        .env("FWP_GC_STRESS", "1")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison),
                );
                assert_eq!(
                    out.stdout, reference.stdout,
                    "{opt}, stack {stack}, poison {poison}"
                );
            }
        }
    }
    for flag in ["FWP_REUSE", "FWP_FREE"] {
        let exe = dir.0.join(flag);
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["-O1", "-o"])
                .arg(&exe)
                .env(flag, "0"),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout, "{flag}=0");
    }
}

#[test]
fn fused_loop_consumers_reclaim_sequence_states_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
score : List[String] -> I64
score = map string.length | sum
scan-size : I64 -> I64
scan-size = rem 4 | add 1 | flip take ("a b c d" | words) | scan concat "start:" | score
iterate-size : I64 -> I64
iterate-size = rem 4 | show | concat "seed:" | iterate 4 (concat "!") | score
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | fork add scan-size iterate-size) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    let emitted = dir.0.join("loop.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0"),
    );
    let owned = std::fs::read_to_string(&emitted).unwrap();
    // Restore only initial-state sharing at generated loop call sites.
    // The sequence implementations and loop body/cleanup stay identical.
    let mut changed = 0;
    let shared = owned
        .lines()
        .map(|line| {
            if let Some(call) = line.find(" = fwp_loop").filter(|call| {
                line[*call + " = fwp_loop".len()..].starts_with(|c: char| c.is_ascii_digit())
            }) {
                let start = call + line[call..].find('(').unwrap() + 1;
                let end = line.rfind(");").unwrap();
                changed += 1;
                format!(
                    "{}fwp_rc_shared({}){}",
                    &line[..start],
                    &line[start..end],
                    &line[end..]
                )
            } else {
                line.into()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert!(
        changed >= 3,
        "missing outer/fused loop call sites: {changed}"
    );
    assert_ne!(shared, owned);
    let mut freed = Vec::new();
    for (name, code) in [("shared", &shared), ("owned", &owned)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
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
    eprintln!("fused sequence consumer graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn boxed_callback_arguments_are_released_without_tracing() {
    let dir = Scratch::new("boxed-counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
boxed-step : (I64, String) -> Step[(I64, String), (I64, String)]
boxed-step = fork apply
    (make { 0 = .0 | sub 1, 1 = .1 | concat "!" })
    (if (.0 | le 0) (const Stop) (const Again))
size : I64 -> I64
size = rem 3 | add 1 | both id (show | concat "seed:") | loop boxed-step | .1 | string.length
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
main = (10000, 0) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    let emitted = dir.0.join("loop.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0"),
    );
    let owned = std::fs::read_to_string(&emitted).unwrap();
    assert!(
        owned.contains(" = fwp_k_loop_owned("),
        "fixture bypassed boxed callback entry"
    );
    // Restore only the raw outer decrement after boxed-to-worker calls.
    // Worker field ownership and loop state/Step handling stay identical.
    let mut changed = 0;
    let shared = owned
        .lines()
        .map(|line| {
            if line.contains("static V f") && line.contains(" = w") {
                if let Some(start) = line.find("fwp_drop") {
                    let end = start + line[start..].find(");").unwrap() + 2;
                    let argument = line[start..end]
                        .split('(')
                        .nth(1)
                        .unwrap()
                        .strip_suffix(");")
                        .unwrap();
                    changed += 1;
                    return format!("{}fwp_rc_drop({argument});{}", &line[..start], &line[end..]);
                }
            }
            line.into()
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert!(changed > 0, "missing boxed worker cleanup");
    assert_ne!(shared, owned);
    let mut freed = Vec::new();
    for (name, code) in [("shared", &shared), ("owned", &owned)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
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
    eprintln!("boxed loop callback graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn scalar_loop_payloads_do_not_release_address_shaped_bits() {
    let dir = Scratch::new("scalar");
    let src = dir.0.join("scalar.fwp");
    let cfile = dir.0.join("scalar.c");
    std::fs::write(&src, "main = 1 | loop Stop | echo\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let boundary = emitted
        .find("return fwp_p_loop_own(l0, l1, NULL, NULL,")
        .expect("missing actual scalar loop wrapper");
    let wrapper = emitted[..boundary]
        .rsplit("static V ")
        .next()
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static V scalar_stop_entry(V *a) { return fwp_rc_fresh(fwp_data(1, 1, a)); }
static void scalar_stop_args(V *a, uint32_t start, uint32_t n) {
    (void)a; (void)start; (void)n;
}
static void scalar_stop_caps(V f, int duplicate) { (void)f; (void)duplicate; }
static const fwp_owned_fninfo scalar_owned = {scalar_stop_entry, scalar_stop_caps, scalar_stop_args};
static const fwp_fninfo scalar_fns[] = {{1, scalar_stop_entry, "numeric stop", &scalar_owned}};
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns = scalar_fns;
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    fwp_clo callback = {0, 0};
    V result = WRAPPER(PTR(&callback), bits);
    if (result != bits || *fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;
    puts("scalar loop ownership preserved");
    return 0;
}
"#.replace("WRAPPER", wrapper);
    let source = format!("{runtime}\n{probe}");
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        fwp::cgen::compile_c(&source, &exe, opt).unwrap();
        assert_eq!(
            checked(&mut Command::new(&exe)).stdout,
            b"scalar loop ownership preserved\n"
        );
    }
}

#[test]
fn loop_goldens_keep_trap_and_evaluation_order() {
    let dir = Scratch::new("goldens");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for name in ["loop_state", "loop_nested_state"] {
        let src = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join(format!("tests/run/{name}.fwp"));
        let reference = Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .output()
            .unwrap();
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("{name}{opt}"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            let native = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1")
                .output()
                .unwrap();
            assert_eq!(native.stdout, reference.stdout, "{name}, {opt} stdout");
            assert_eq!(native.stderr, reference.stderr, "{name}, {opt} stderr");
            assert_eq!(
                native.status.code(),
                reference.status.code(),
                "{name}, {opt} exit"
            );
        }
    }
}
