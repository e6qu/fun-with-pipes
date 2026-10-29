//! Generic and specialized loops transfer owned states and typed Step payloads.
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
fn loop_states_and_step_payload_aliases_preserve_owners() {
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
tapped-step : (I64, String) -> Step[(I64, String), String] ! {IO}
tapped-step = if (.0 | eq 0) (.1 | Stop)
    (tap (.1 | echo) | make { 0 = .0 | sub 1, 1 = .1 | concat "!" } | Again)
branch-step : (I64, String) -> Step[(I64, String), String] ! {IO}
branch-step = if (.0 | eq 0) (.1 | Stop)
    (tap (.1 | echo)
        | if (.0 | eq 2)
            (make { 0 = .0 | sub 1, 1 = .1 | concat "!" })
            (make { 0 = .0 | sub 1, 1 = .1 | concat "?" })
        | Again)
fallible-step : (I64, String) -> Step[(I64, String), String] ! {IO, Error[String]}
fallible-step = tap (.1 | echo) | if (.0 | eq 1) (const "stopped" | fail)
    (make { 0 = .0 | sub 1, 1 = .1 | concat "!" } | Again)
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
    (3, "tapped") | both (loop tapped-step) id | echo,
    (3, "branches") | both (loop branch-step) id | echo,
    (3, "fallible") | both (attempt (loop fallible-step)) id | echo,
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
    for stack in ["0", "1"] {
        let emitted = dir.0.join(format!("aliases-{stack}.c"));
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["--emit-c", "-o"])
                .arg(&emitted)
                .env("FWP_STACK", stack),
        );
        let code = std::fs::read_to_string(emitted).unwrap();
        for opt in ["-O1", "-O2"] {
            for (name, source) in [
                ("reuse", code.clone()),
                ("copy", format!("#define FWP_NO_REUSE 1\n{code}")),
            ] {
                let exe = dir.0.join(format!("aliases{opt}-{stack}-{name}"));
                fwp::cgen::compile_c(&source, &exe, opt).unwrap();
                let out = checked(&mut Command::new(&exe));
                assert_eq!(out.stdout, reference.stdout, "{opt}, stack {stack}, {name}");
                assert_eq!(out.stderr, reference.stderr, "{opt}, stack {stack}, {name}");
            }
        }
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
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    let emitted = dir.0.join("loop.c");
    checked(
        Command::new(fwp)
            .args(["build"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0"),
    );
    let owned = std::fs::read_to_string(&emitted).unwrap();
    // Omit typed releases only in generated loop-step bodies. This retains
    // their allocations without changing scalar words or fabricating owners.
    // The resulting leak must be visible in both release and live-byte totals.
    let mut missing = owned.clone();
    let mut position = 0;
    let mut steps = 0;
    let mut releases = 0;
    while let Some(offset) =
        missing[position..].find("static inline __attribute__((always_inline)) int fs")
    {
        let start = position + offset;
        let end = start + missing[start..].find("\n}\n").expect("loop-step end");
        let body = &missing[start..end];
        let mut patched = String::new();
        let mut rest = body;
        while let Some(at) = rest.find("fwp_drop") {
            patched.push_str(&rest[..at]);
            let after_name = &rest[at + "fwp_drop".len()..];
            let digits = after_name.bytes().take_while(u8::is_ascii_digit).count();
            assert!(digits > 0 && after_name[digits..].starts_with('('));
            patched.push_str("fwp_test_omit_drop");
            rest = &after_name[digits..];
            releases += 1;
        }
        patched.push_str(rest);
        position = start + patched.len();
        missing.replace_range(start..end, &patched);
        steps += 1;
    }
    assert!(steps >= 3, "missing outer/fused loop steps: {steps}");
    assert!(releases > 0, "no typed loop releases were omitted");
    let first_step = missing
        .find("static inline __attribute__((always_inline)) int fs")
        .unwrap();
    missing.insert_str(
        first_step,
        "static void fwp_test_omit_drop(V value) { (void)value; }\n",
    );
    for opt in ["-O1", "-O2"] {
        let mut reports = Vec::new();
        for (name, code) in [("missing-release", &missing), ("owned", &owned)] {
            let exe = dir.0.join(format!("{name}{opt}"));
            fwp::cgen::compile_c(code, &exe, opt).unwrap();
            let out = checked(Command::new(&exe).env("FWP_ALLOC_STATS", "1"));
            assert_eq!(out.stdout, reference.stdout, "{name}{opt}");
            reports.push(
                allocation_report::parse(&String::from_utf8_lossy(&out.stderr))
                    .expect("allocation report"),
            );
        }
        let [missing, owned] = reports.as_slice() else {
            unreachable!()
        };
        assert!(
            owned.released > missing.released + 314_572,
            "{opt}: {reports:?}"
        );
        assert!(missing.live > owned.live + 314_572, "{opt}: {reports:?}");
    }
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
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    let emitted = dir.0.join("loop.c");
    checked(
        Command::new(fwp)
            .args(["build"])
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
        let out = checked(Command::new(&exe).env("FWP_ALLOC_STATS", "1"));
        assert_eq!(out.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&out.stderr);

        freed.push(
            allocation_report::parse(&stats)
                .expect("allocation report")
                .released as f64
                / 1_048_576.0,
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
            .args(["build"])
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
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 2;
#endif
    fwp_heap_start();
    fwp_fns = scalar_fns;
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    fwp_clo callback = {0, 0};
    V result = WRAPPER(PTR(&callback), bits);
    if (result != bits || *fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;
    fwp_rc_free_obj(bits);
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
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src)
            .output()
            .unwrap();
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("{name}{opt}"));
            checked(
                Command::new(fwp)
                    .args(["build"])
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            let native = Command::new(&exe).output().unwrap();
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

#[test]
fn floating_loop_states_preserve_bits_and_mixed_owners() {
    let dir = Scratch::new("floating-state");
    let src = dir.0.join("floating.fwp");
    std::fs::write(
        &src,
        r#"
step64 : (I64, F64) -> Step[(I64, F64), F64]
step64 = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 } | Again)
step32 : (I64, F32) -> Step[(I64, F32), F32]
step32 = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 } | Again)
nested-floats : (I64, (F64, F32), String) -> Step[(I64, (F64, F32), String), (F64, F32)]
nested-floats = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = both (.1 | .0) (.1 | .1), 2 = .2 | concat "x" } | Again)
scalar-float : F64 -> Step[F64, F64]
scalar-float = if (gt 0.0) (const -0.0 | Again) Stop
arithmetic : (I64, F64) -> Step[(I64, F64), F64]
arithmetic = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | mul 3.0 | add 1.0 } | Again)
main = [
    (3, 1.25) | loop step64 | echo,
    (3, 1.25f32) | loop step32 | echo,
    (3, (1.25, 2.5f32), "seed") | loop nested-floats | echo,
    1.0 | loop scalar-float | echo,
    (5, 0.25) | loop arithmetic | echo,
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
    let optimized = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    assert_eq!(optimized.stdout, reference.stdout);
    assert_eq!(optimized.stderr, reference.stderr);
    for stack in ["0", "1"] {
        let cfile = dir.0.join(format!("floating-{stack}.c"));
        checked(
            Command::new(fwp)
                .env("FWP_STACK", stack)
                .args(["build", "--emit-c"])
                .arg(&src)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        let step_id = |name: &str| {
            code.split(&format!("/* loop of {name} :"))
                .nth(1)
                .unwrap_or_else(|| panic!("missing loop {name}"))
                .split(" int fs")
                .nth(1)
                .unwrap()
                .split('(')
                .next()
                .unwrap()
        };
        let f64_id = step_id("step64");
        let f32_id = step_id("step32");
        let nested_id = step_id("nested-floats");
        let scalar_id = step_id("scalar-float");
        assert!(code.contains(&format!(
            "typedef struct {{ V v0; double v1; }} fwp_loop_state{f64_id};"
        )));
        assert!(code.contains(&format!(
            "typedef struct {{ V v0; float v1; }} fwp_loop_state{f32_id};"
        )));
        assert!(code.contains(&format!(
            "typedef struct {{ V v0; double v1; float v2; V v3; }} fwp_loop_state{nested_id};"
        )));
        assert!(code.contains(&format!(
            "typedef struct {{ double v0; }} fwp_loop_state{scalar_id};"
        )));
        let probe = r#"
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 100;
#endif
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    size_t baseline=fwp_heap.live;
    const V wide[] = {0, UINT64_C(0x8000000000000000), 1, UINT64_C(0x000fffffffffffff),
        UINT64_C(0x0010000000000000), UINT64_C(0x3ff0000000000001), UINT64_C(0x7fefffffffffffff),
        UINT64_C(0x7ff0000000000000), UINT64_C(0xfff0000000000000),
        UINT64_C(0x7ff0000000000001), UINT64_C(0x7ff8123456789abc), UINT64_C(0xfff8123456789abc)};
    const V narrow[] = {0, 0x80000000, 1, 0x007fffff, 0x00800000, 0x3f800001,
        0x7f7fffff, 0x7f800000, 0xff800000, 0x7f800001, 0x7fc12345, 0xffc12345};
    for (int repeat=0;repeat<16;repeat++) for (size_t i=0;i<sizeof(wide)/sizeof(*wide);i++) {
        for (V iterations=0;iterations<8;iterations++) {
            V box=fwp_rc_fresh(fwp_record(2,(V[]){iterations,wide[i]}));
            if (LOOP64(box)!=wide[i]) return 1;
            if (FIELDS64(iterations,wide[i])!=wide[i]) return 2;
            box=fwp_rc_fresh(fwp_record(2,(V[]){iterations,narrow[i]}));
            if (LOOP32(box)!=narrow[i]) return 3;
            if (FIELDS32(iterations,narrow[i])!=narrow[i]) return 4;
            V inner=fwp_rc_fresh(fwp_record(2,(V[]){wide[i],narrow[i]}));
            V text=fwp_rc_fresh(fwp_cstr("owned"));
            fwp_rc_dup(text);
            box=fwp_rc_fresh(fwp_record(3,(V[]){iterations,inner,text}));
            V result=NESTED(box);
            if (OBJ(result)->f[0]!=wide[i] || OBJ(result)->f[1]!=narrow[i]) return 5;
            if (*fwp_rc_slot(text)!=1 || STR(text)->len!=5) return 6;
            if (!fwp_rc_release_last(result)) return 9;
            fwp_rc_free_obj(result);
            if (!fwp_rc_release_last(text)) return 10;
            fwp_rc_free_obj(text);
            if (fwp_heap.live!=baseline || fwp_cleanups) return 7;
        }
    }
    if (SCALAR(UINT64_C(0x3ff0000000000000))!=UINT64_C(0x8000000000000000)) return 8;
    puts("floating state bits and shared owners preserved");
    return 0;
}
"#
        .replace("FIELDS64", &format!("fwp_loop_fields{f64_id}"))
        .replace("FIELDS32", &format!("fwp_loop_fields{f32_id}"))
        .replace("LOOP64", &format!("fwp_loop{f64_id}"))
        .replace("LOOP32", &format!("fwp_loop{f32_id}"))
        .replace("NESTED", &format!("fwp_loop{nested_id}"))
        .replace("SCALAR", &format!("fwp_loop{scalar_id}"));
        let instrumented = code.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        ) + &probe;
        // Deliberately narrow F64 state: the bit checks must detect the loss.
        let broken = instrumented.replace(
            &format!("typedef struct {{ V v0; double v1; }} fwp_loop_state{f64_id};"),
            &format!("typedef struct {{ V v0; float v1; }} fwp_loop_state{f64_id};"),
        );
        assert_ne!(broken, instrumented);
        for opt in ["-O1", "-O2"] {
            for (label, source) in [
                ("program", &code),
                ("bits", &instrumented),
                ("narrowed", &broken),
            ] {
                let exe = dir.0.join(format!("{label}-{stack}{opt}.exe"));
                fwp::cgen::compile_c(source, &exe, opt).unwrap();
                let result = Command::new(&exe).output().unwrap();
                record_probe::save(
                    "loop_ownership",
                    &format!("floating-{label}-{stack}{opt}"),
                    source,
                    &exe,
                    &result,
                );
                if label == "narrowed" {
                    assert_eq!(
                        result.status.code(),
                        Some(1),
                        "missing precision failure: {result:?}"
                    );
                } else {
                    assert!(result.status.success(), "{label}: {result:?}");
                    let expected: &[u8] = if label == "program" {
                        &reference.stdout
                    } else {
                        b"floating state bits and shared owners preserved\n"
                    };
                    assert_eq!(result.stdout, expected, "{label}, {stack}, {opt}");
                    assert_eq!(result.stderr, reference.stderr, "{label}, {stack}, {opt}");
                }
            }
        }
    }
}
