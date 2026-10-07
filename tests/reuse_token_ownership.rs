//! Compiler-held reuse cells have a lifetime independent of their dead fields.
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p = std::env::temp_dir().join(format!("fwp-token-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"Box = | Empty | Box I64
guard : I64 -> I64 ! {Error[String]}
guard = if (eq 0) (const "expected" | fail) (add 1)
build : (I64 -> I64 ! {Error[String]}) -> Box -> Box ! {Error[String]}
build = curry (match
    (_, Empty) -> const Empty
    (_, Box _) -> curry (fork apply .1 .0 | if (lt 0) (const Empty) Box))
main = Box 2 | attempt (build guard) | echo
"#;
#[test]
fn compiler_tokens_transfer_release_and_unwind() {
    let dir = Scratch::new("lifetime");
    let src = dir.0.join("token.fwp");
    let cfile = dir.0.join("token.c");
    std::fs::write(&src, SOURCE).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0")
            .env("FWP_VRET", "0"),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    assert!(emitted.contains("fwp_cleanup_push(&t"));
    let wrapper = |name: &str| {
        let start = emitted.find(&format!("/* {name} :")).unwrap();
        emitted[start..]
            .split("static V ")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
    };
    let probe = r#"
static volatile int force_old;
static volatile V input_cell;
static V token_entry(V *args) {
    if (force_old) {
        if (OBJ(input_cell)->f[0]) abort(); /* dead fields were cleared */
        fwp_gc.major_next = 1;
        fwp_gc_collect();
        if (!fwp_gc_marked((void *)(uintptr_t)input_cell)) abort();
    }
    return GUARD(args[0]);
}
static const fwp_fninfo token_fns[] = {{1, token_entry, "token callback", 0}};
static fwp_clo token_fn = {0, 0};
static int released(V v) {
    return fwp_reuse_verify ? OBJ(v)->tag == 0xdead : *fwp_rc_slot(v) == 0;
}
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    fwp_init_consts();
    fwp_fns = token_fns;
    input_cell = fwp_rc_fresh(fwp_data(1, 1, (V[]){0}));
    fwp_handler h;
    h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
    fwp_handlers = &h;
    if (!setjmp(h.jb)) { BUILD(PTR(&token_fn), input_cell); return 1; }
    fwp_handlers = h.prev;
    if (!released(input_cell) || fwp_cleanups) return 2;
    input_cell = fwp_rc_fresh(fwp_data(1, 1, (V[]){2}));
    V result = BUILD(PTR(&token_fn), input_cell);
    if (!result || OBJ(result)->tag != 1 || OBJ(result)->f[0] != 3 || fwp_cleanups) return 3;
    if (!fwp_reuse_verify && result != input_cell) return 4;
    if (fwp_reuse_verify && !released(input_cell)) return 5;
    if (!fwp_rc_release_last(result)) return 6;
    fwp_rc_free_obj(result);
    input_cell = fwp_rc_fresh(fwp_data(1, 1, (V[]){2}));
    force_old = 1;
    result = BUILD(PTR(&token_fn), input_cell);
    force_old = 0;
    if (!result || result == input_cell || OBJ(result)->f[0] != 3 ||
        !released(input_cell) || fwp_cleanups) return 7;
    if (!fwp_rc_release_last(result)) return 8;
    fwp_rc_free_obj(result);
    input_cell = fwp_rc_fresh(fwp_data(1, 1, (V[]){(V)(int64_t)-2}));
    double before = fwp_gc.freed;
    result = BUILD(PTR(&token_fn), input_cell); /* Empty: constructor never takes the cell */
    if (result || !released(input_cell) || fwp_cleanups) return 9;
    if (!fwp_reuse_verify && fwp_gc.freed <= before) return 10;
    puts("compiler token owners release and transfer exactly once");
    return 0;
}
"#
    .replace("GUARD", wrapper("guard"))
    .replace("BUILD", wrapper("build"));
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        fwp::cgen::compile_c(&format!("{runtime}\n{probe}"), &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(
                out.stdout,
                b"compiler token owners release and transfer exactly once\n"
            );
        }
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", "1"),
        );
        assert_eq!(out.stdout, reference.stdout);
    }
}

#[test]
fn compiler_token_cleanup_respects_ownership_switches() {
    let dir = Scratch::new("switches");
    let src = dir.0.join("token.fwp");
    let exe = dir.0.join("token");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    // The failing and unused branches also exercise lexical release when
    // physical freeing or reuse is disabled for comparison measurements.
    for input in ["2", "0", "(-2)"] {
        std::fs::write(
            &src,
            SOURCE.replace("main = Box 2", &format!("main = Box {input}")),
        )
        .unwrap();
        let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
        for (flag, value) in [("FWP_FREE", "0"), ("FWP_REUSE", "0"), ("FWP_STACK", "0")] {
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args(["-O1", "-o"])
                    .arg(&exe)
                    .env(flag, value),
            );
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "1"),
            );
            assert_eq!(
                out.stdout, reference.stdout,
                "input {input}, {flag}={value}"
            );
        }
    }
}

#[test]
fn bump_allocator_still_compiles_token_cleanup() {
    let dir = Scratch::new("bump");
    let src = dir.0.join("token.fwp");
    let cfile = dir.0.join("token.c");
    let exe = dir.0.join("token");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE.replace("main = Box 2", "main = Box (-2)")).unwrap();
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0")
            .env("FWP_VRET", "0"),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    fwp::cgen::compile_c(&format!("#define FWP_GC 0\n{emitted}"), &exe, "-O1").unwrap();
    assert_eq!(checked(&mut Command::new(&exe)).stdout, reference.stdout);
}
