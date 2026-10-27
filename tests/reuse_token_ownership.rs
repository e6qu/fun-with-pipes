//! Compiler-held reuse cells have a lifetime independent of their dead fields.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/ownership_ledger.rs"]
mod ownership_ledger;

#[path = "support/record_probe.rs"]
mod record_probe;

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
                .arg(&src)
                .args(["--emit-c", "-O2", "-o"])
                .arg(&cfile)
                .env("FWP_STACK", "0")
                .env("FWP_VRET", "0"),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let emitted = ownership_ledger::instrument_native(&emitted, 1 << 16);
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
static volatile V input_cell;
static V token_entry(V *args) {
    if (OBJ(input_cell)->f[0] || *fwp_rc_slot(input_cell) != 1) abort();
    return GUARD(args[0]);
}
static const fwp_fninfo token_fns[] = {{1, token_entry, "token callback", 0}};
static fwp_clo token_fn = {0, 0};
static int released(V v) {
    return !owner_ledger_slots[owner_ledger_find((uintptr_t)v)];
}
int main(void) {
#ifdef _WIN32
    _setmode(_fileno(stdout), _O_BINARY);
#endif
    fwp_heap_start();
    fwp_init_consts();
    fwp_fns = token_fns;
    size_t baseline = fwp_heap.live;
    for (int round = 0; round < 32; round++) {
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
    if (result != input_cell) return 4;
    if (!fwp_rc_release_last(result)) return 6;
    fwp_rc_free_obj(result);
    input_cell = fwp_rc_fresh(fwp_data(1, 1, (V[]){(V)(int64_t)-2}));
    double before = fwp_heap.freed;
    result = BUILD(PTR(&token_fn), input_cell); /* Empty: constructor never takes the cell */
    if (result || !released(input_cell) || fwp_cleanups) return 9;
    if (fwp_heap.freed <= before) return 10;
    if (fwp_heap.live != baseline || fwp_heap.rc_wide_len) return 90;
    owner_ledger_finish();
    }
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
        let cleanup = "if (value) fwp_rc_free_obj(value);";
        let cleanup_start = runtime
            .find("static void fwp_rc_cleanup_cell(void *arg)")
            .unwrap();
        let cleanup_end = cleanup_start + runtime[cleanup_start..].find("\n}").unwrap();
        assert_eq!(
            runtime[cleanup_start..cleanup_end].matches(cleanup).count(),
            1
        );
        let missing_cleanup = format!(
            "{}{}{}",
            &runtime[..cleanup_start],
            runtime[cleanup_start..cleanup_end].replace(cleanup, ""),
            &runtime[cleanup_end..]
        );
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("token{opt}.exe"));
            let mut cases = vec![
                ("normal", format!("{runtime}\n{probe}"), 0),
                ("missing-cleanup", format!("{missing_cleanup}\n{probe}"), 2),
            ];
            {
                let missing = probe.replace("fwp_rc_free_obj(result);", "");
                assert_ne!(missing, probe);
                cases.push(("missing-release", format!("{runtime}\n{missing}"), 90));
            }
            for (label, code, status) in cases {
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();

                {
                    let out = Command::new(&exe).output().unwrap();
                    record_probe::save(
                        "reuse_token_ownership",
                        &format!("counted{opt}-token-{label}"),
                        &code,
                        &exe,
                        &out,
                    );
                    assert_eq!(
                        out.status.code(),
                        Some(status),
                        "counted {opt} {label}: {out:?}"
                    );
                    assert!(out.stderr.is_empty(), "counted {opt} {label}: {out:?}");
                    let expected = if status == 0 {
                        &b"compiler token owners release and transfer exactly once\n"[..]
                    } else {
                        &b""[..]
                    };
                    assert_eq!(out.stdout, expected);
                }
            }
            checked(
                Command::new(fwp)
                    .args(["build", "--memory", "dynamic"])
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_STACK", "0")
                    .env("FWP_VRET", "0"),
            );
            let out = checked(&mut Command::new(&exe));
            assert_eq!(out.stdout, reference.stdout);
        }
    }
}

#[test]
fn compiler_token_cleanup_preserves_reuse_and_stack_controls() {
    let dir = Scratch::new("switches");
    let src = dir.0.join("token.fwp");
    let exe = dir.0.join("token.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    // The failing and unused branches also exercise lexical release when
    // physical freeing or reuse is disabled for comparison measurements.
    for input in ["2", "0", "(-2)"] {
        std::fs::write(
            &src,
            SOURCE.replace("main = Box 2", &format!("main = Box {input}")),
        )
        .unwrap();
        let reference = checked(
            Command::new(fwp)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&src),
        );
        for stack in ["0", "1"] {
            let cfile = dir.0.join("token.c");
            checked(
                Command::new(fwp)
                    .args(["build", "--memory", "dynamic", "--emit-c", "-O1"])
                    .arg(&src)
                    .arg("-o")
                    .arg(&cfile)
                    .env("FWP_STACK", stack),
            );
            let generated = std::fs::read_to_string(&cfile).unwrap();
            for reuse in [true, false] {
                let code = if reuse {
                    generated.clone()
                } else {
                    format!("#define FWP_NO_REUSE 1\n{generated}")
                };
                fwp::cgen::compile_c(&code, &exe, "-O1").unwrap();
                let out = checked(&mut Command::new(&exe));
                assert_eq!(
                    out.stdout, reference.stdout,
                    "input {input}, stack={stack}, reuse={reuse}"
                );
                assert_eq!(out.stderr, reference.stderr);
            }
        }
    }
}

#[test]
fn forced_copies_preserve_token_cleanup() {
    let dir = Scratch::new("copy");
    let src = dir.0.join("token.fwp");
    let cfile = dir.0.join("token.c");
    let exe = dir.0.join("token.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE.replace("main = Box 2", "main = Box (-2)")).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    checked(
        Command::new(fwp)
            .args(["build"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0")
            .env("FWP_VRET", "0"),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    fwp::cgen::compile_c(&format!("#define FWP_NO_REUSE 1\n{emitted}"), &exe, "-O1").unwrap();
    assert_eq!(checked(&mut Command::new(&exe)).stdout, reference.stdout);
}

#[test]
fn tail_token_cleanup_preserves_long_native_recursion() {
    let dir = Scratch::new("tail");
    let src = dir.0.join("tail.fwp");
    let cfile = dir.0.join("tail.c");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let source = r#"Box = | Empty | Box I64
down : Box -> Box ! {Error[String]}
rec down = match
    Empty -> Empty
    Box _ -> if (lt 0) (const "negative" | fail) (if (eq 0) Box (sub 1 | Box | down))
main = Box 1000000 | attempt down | echo
"#;
    // The same recurrence ends at Box 0 for any nonnegative input. Keep the
    // raw local oracle small; the large native case detects retained C frames.
    std::fs::write(&src, source.replace("Box 1000000 |", "Box 200 |")).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    assert_eq!(reference.stdout, b"Ok (Box 0)\n");
    std::fs::write(&src, source).unwrap();
    {
        checked(
            Command::new(fwp)
                .env("FWP_STACK", "0")
                .env("FWP_VRET", "0")
                .args(["build", "--memory", "dynamic"])
                .arg(&src)
                .args(["--emit-c", "-O2", "-o"])
                .arg(&cfile),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        assert!(emitted.contains("fwp_rc_cleanup_cell(&t"));
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("token{opt}.exe"));
            fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
            {
                let out = Command::new(&exe).output().unwrap();
                record_probe::save(
                    "reuse_token_ownership",
                    &format!("counted{opt}-tail"),
                    &emitted,
                    &exe,
                    &out,
                );
                assert!(
                    out.status.success() && out.stderr.is_empty(),
                    "counted {opt}: {out:?}"
                );
                assert_eq!(out.stdout, reference.stdout, "{opt}");
            }
        }
    }
}
