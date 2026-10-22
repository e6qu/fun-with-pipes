//! Array storage owns typed elements across copies, aliases and callbacks.
use std::io::Write;
use std::path::PathBuf;
use std::process::{Command, Output, Stdio};

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
            std::env::temp_dir().join(format!("fwp-array-elements-{}-{name}", std::process::id()));
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
fn callback_captures_survive_reuse_storage_and_ordinary_application() {
    let dir = Scratch::new("callback-boundaries");
    let source = dir.0.join("boundaries.fwp");
    std::fs::write(
        &source,
        include_str!("fixtures/callback_capture_boundaries.fwp"),
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .args(["run", "--interp"])
            .arg(&source)
            .env("FWP_NO_OPT", "1"),
    );
    assert_eq!(
        reference.stdout,
        include_bytes!("fixtures/callback_capture_boundaries.out")
    );
    assert!(reference.stderr.is_empty());
    for gc in ["arc", "tracing"] {
        for stack in ["0", "1"] {
            let cfile = dir.0.join(format!("boundaries-{gc}-{stack}.c"));
            checked(
                Command::new(compiler)
                    .args(["build", "--gc", gc, "--emit-c", "-O2"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile)
                    .env("FWP_STACK", stack)
                    .env_remove("FWP_NO_OPT"),
            );
            let code = std::fs::read_to_string(cfile).unwrap();
            for opt in ["-O0", "-O2"] {
                let binary = dir.0.join(format!("boundaries-{gc}-{stack}{opt}.exe"));
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                let stress = if gc == "tracing" { "1" } else { "0" };
                let output = checked(
                    Command::new(binary)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress),
                );
                assert_eq!(output.stdout, reference.stdout, "{gc}/{stack}/{opt}");
                assert!(output.stderr.is_empty(), "{gc}/{stack}/{opt}: {output:?}");
                if let Some(path) = std::env::var_os("FWP_CALLBACK_CAPTURE_ARTIFACTS") {
                    let path = PathBuf::from(path);
                    std::fs::create_dir_all(&path).unwrap();
                    let stem = format!("boundaries-{gc}-{stack}{opt}");
                    std::fs::write(path.join(format!("{stem}.c")), &code).unwrap();
                    std::fs::copy(
                        dir.0.join(format!("boundaries-{gc}-{stack}{opt}.exe")),
                        path.join(format!("{stem}.exe")),
                    )
                    .unwrap();
                    std::fs::write(path.join(format!("{stem}.stdout")), &output.stdout).unwrap();
                    std::fs::write(path.join(format!("{stem}.stderr")), &output.stderr).unwrap();
                    std::fs::write(
                        path.join(format!("{stem}.status")),
                        format!("{:?}\n", output.status.code()),
                    )
                    .unwrap();
                }
            }
        }
    }
}

#[test]
fn generic_entries_follow_function_values_not_direct_calls() {
    let dir = Scratch::new("entries");
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (name, body, dynamic, expected) in [
        (
            "direct",
            "main = read-all () | string.length | direct | echo",
            false,
            "7\n",
        ),
        (
            "dynamic",
            "choose : Bool -> I64 -> I64\nchoose = if id (const direct) (const (mul 3))\nvalues : (I64 -> I64) -> (I64, I64)\nvalues = both (apply 2) (apply 4)\nmain = values (choose (read-all () | string.length | eq 0)) | echo",
            true,
            "(9, 11)\n",
        ),
    ] {
        let source = dir.0.join(format!("{name}.fwp"));
        std::fs::write(
            &source,
            format!("direct : I64 -> I64\ndirect = add 7\n{body}\n"),
        )
        .unwrap();
        let reference = checked(
            Command::new(compiler)
                .args(["run", "--interp"])
                .arg(&source)
                .env("FWP_NO_OPT", "1")
                .stdin(Stdio::null()),
        );
        assert_eq!(reference.stdout, expected.as_bytes());
        for (gc, reuse) in [("arc", "1"), ("tracing", "1"), ("tracing", "0")] {
            let cfile = dir.0.join(format!("{name}-{gc}-{reuse}.c"));
            checked(
                Command::new(compiler)
                    .args(["build", "--gc", gc, "--emit-c", "-O2"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile)
                    .env("FWP_NO_OPT", "1")
                    .env("FWP_REUSE", reuse),
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            let table = code
                .split_once("static const fwp_fninfo fwp_fn_table[] = {\n")
                .unwrap()
                .1
                .split_once("};")
                .unwrap()
                .0;
            let entries: Vec<_> = table.lines().filter(|line| line.contains("\"direct\"")).collect();
            assert_eq!(entries.len(), 1, "{name}/{gc}/{reuse}: {table}");
            assert_eq!(
                entries[0].contains(", 0, \"direct\", 0}"),
                !dynamic,
                "{name}/{gc}/{reuse}: {}",
                entries[0]
            );
            for opt in ["-O0", "-O2"] {
                let exe = dir.0.join(format!("{name}-{gc}-{reuse}{opt}"));
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let stress = if gc == "tracing" { "1" } else { "0" };
                let result = checked(
                    Command::new(&exe)
                        .stdin(Stdio::null())
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", stress),
                );
                assert_eq!(result.stdout, reference.stdout, "{name}/{gc}/{reuse}/{opt}");
                assert!(result.stderr.is_empty(), "{result:?}");
            }
        }
    }
}

#[test]
fn array_elements_aliases_and_callbacks_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
views : Array[String] -> (Array[String], Array[String], Array[String], Option[Array[String]], Array[String], Array[String])
views = make { 0 = id, 1 = array.slice 1 9223372036854775807,
    2 = array.append (["extra"] | array.from-list), 3 = array.set 1 "replacement",
    4 = array.push "end", 5 = array.sort }
function-step : (String -> String) -> String -> (String -> String)
function-step = curry (fork const .0 .1)
use-functions : Array[String] -> (String, String)
use-functions = array.fold function-step (concat "kept") | both (apply "!") (apply "?")
three : String -> String -> String -> String
three = curry3 (fork concat .0 (fork concat .1 .2))
trace-index : I64 -> String ! {IO}
trace-index = fork const (show | concat "index:") (echo)
trace-text : String -> String ! {IO}
trace-text = fork const (concat "seen:") (echo)
grow : (I64, Array[String]) -> Step[(I64, Array[String]), Array[String]]
grow = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = .1 | array.push "grown" } | Again)
main = [
    "c a b" | words | array.from-list | views | echo,
    "a b" | words | both (array.from-list | array.to-list) id | echo,
    "a b" | words | array.from-list | array.get 1 | option.map (concat "selected:") | echo,
    "a b" | words | array.from-list | array.set -1 "unused" | echo,
    "a b" | words | array.from-list | array.set 99 "unused" | echo,
    "a b" | words | array.from-list | array.get -1 | echo,
    [] | array.from-list | array.get 0 | echo,
    ["a", "b"] | map concat | array.from-list | both
        (array.map (apply "!") | array.to-list)
        (array.get 0 | option.map (apply "?")) | echo,
    "a b" | words | array.from-list | array.map concat | array.to-list | map (apply "!") | echo,
    "a b" | words | array.from-list | use-functions | echo,
    "a b" | words | array.from-list | both (array.fold const "seed") id | echo,
    "a b" | words | array.from-list | both (array.fold (flip const) "seed") id | echo,
    "a b" | words | array.from-list | array.fold (three "prefix") "seed" | echo,
    "a b" | words | array.from-list | array.map id | array.to-list | echo,
    "a b" | words | array.from-list | array.map trace-text | array.fold (flip concat) "start:" | echo,
    4 | flip array.generate trace-index | array.to-list | echo,
    "x" | concat "!" | array.make 601 | array.length | echo,
    "unused" | concat "!" | array.make -1 | array.to-list | echo,
    "unused" | concat "!" | array.make 0 | array.to-list | echo,
    "a b" | words | array.from-list | array.slice -1 1 | array.to-list | echo,
    "a b" | words | array.from-list | array.slice 99 1 | array.to-list | echo,
    "a b" | words | array.from-list | array.slice 1 -1 | array.to-list | echo,
    [] | array.from-list | array.fold (flip concat) "unchanged" | echo,
    ["a b", "c d"] | map (words | array.from-list) | array.from-list | array.to-list | map array.to-list | echo,
    "héllo" | string.to-bytes | array.make 3 | array.map bytes.length | array.to-list | echo,
    (601, [] | array.from-list) | loop grow | array.length | echo,
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
fn array_elements_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
score : Array[String] -> I64
score = array.to-list | map string.length | sum
size : I64 -> I64
size = rem 4 | add 2 | flip array.make ("a" | concat "value:") | array.push ("b" | concat "value:")
    | array.set 1 ("c" | concat "value:") | option.unwrap-or ([] | array.from-list)
    | array.slice 1 3 | array.map (concat "mapped:") | array.append ("d e" | words | array.from-list)
    | array.sort | score
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
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0"),
    );
    let owned = std::fs::read_to_string(&emitted).unwrap();
    // Keep identical typed alias duplication and scratch cleanup; change only
    // whether the emitted wrappers share their structural result graphs.
    let mut changed = 0;
    let shared = owned
        .lines()
        .map(|line| {
            if [
                "array_make",
                "array_from_list",
                "array_push",
                "array_set",
                "array_slice",
                "array_map",
                "array_append",
                "array_sort",
                "array_to_list",
            ]
            .iter()
            .any(|name| line.contains(&format!("return fwp_p_{name}_typed(")))
            {
                changed += 1;
                line.replace("return fwp_p_", "return fwp_rc_shared(fwp_p_")
                    .replace(");", "));")
            } else {
                line.to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert_eq!(changed, 9, "missing typed array wrappers: {changed}");
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
    eprintln!("typed array graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn scalar_array_elements_do_not_count_address_shaped_bits() {
    let dir = Scratch::new("scalar");
    let src = dir.0.join("scalar.fwp");
    let cfile = dir.0.join("scalar.c");
    std::fs::write(
        &src,
        r#"
main = [
    [1, 2] | array.from-list | array.to-list | echo,
    [1, 2] | array.from-list | array.get 0 | echo,
    [1, 2] | array.from-list | array.set 0 3 | echo,
    [1, 2] | array.from-list | array.push 3 | echo,
    [1, 2] | array.from-list | array.slice 0 1 | echo,
    [1, 2] | array.from-list | array.append ([3] | array.from-list) | echo,
    [1, 2] | array.from-list | array.sort | echo,
    42 | array.make 3 | echo,
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
    let mut probe = r#"
int main(void) {
#ifdef _WIN32
    _setmode(_fileno(stdout), _O_BINARY);
#endif
    fwp_gc_start(__builtin_frame_address(0));
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    V xs = fwp_rc_fresh(fwp_cons(bits, 0));
    V original = FROM_LIST_WRAPPER(xs);
    V selected = GET_WRAPPER(0, original);
    V listed = TO_LIST_WRAPPER(original);
    V sliced = SLICE_WRAPPER(0, 1, original);
    V sorted = SORT_WRAPPER(original);
    V joined = APPEND_WRAPPER(original, original);
    V repeated = MAKE_WRAPPER(601, bits);
    V changed = SET_WRAPPER(0, bits, sliced);
    V grown = PUSH_WRAPPER(bits, sorted);
    if (OBJ(selected)->f[0] != bits || OBJ(listed)->f[0] != bits ||
        ARR(OBJ(changed)->f[0])->d[0] != bits || ARR(grown)->len != 2 ||
        ARR(repeated)->len != 601 || ARR(joined)->len != 2) return 2;
    DROP_ARRAY(original);
    DROP_ARRAY(OBJ(changed)->f[0]);
    DROP_ARRAY(grown);
    DROP_ARRAY(joined);
    DROP_ARRAY(repeated);
    if (*fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;
    puts("scalar array ownership preserved");
    return 0;
}
"#
    .to_string();
    for (symbol, placeholder) in [
        ("array_from_list", "FROM_LIST_WRAPPER"),
        ("array_get", "GET_WRAPPER"),
        ("array_to_list", "TO_LIST_WRAPPER"),
        ("array_slice", "SLICE_WRAPPER"),
        ("array_sort", "SORT_WRAPPER"),
        ("array_append", "APPEND_WRAPPER"),
        ("array_make", "MAKE_WRAPPER"),
        ("array_set", "SET_WRAPPER"),
        ("array_push", "PUSH_WRAPPER"),
    ] {
        let boundary = emitted
            .find(&format!("return fwp_p_{symbol}_typed("))
            .unwrap_or_else(|| panic!("missing actual scalar {symbol} wrapper"));
        let wrapper = emitted[..boundary]
            .rsplit("static V ")
            .next()
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        probe = probe.replace(placeholder, wrapper);
        if symbol == "array_set" {
            let call = emitted[boundary..].split(';').next().unwrap();
            assert!(
                call.contains("NULL, NULL,"),
                "scalar set counts elements: {call}"
            );
            let mut arguments = call.rsplit(", ");
            let descriptor = arguments.next().unwrap().trim_end_matches(')');
            assert!(
                descriptor.starts_with("&d"),
                "missing element descriptor: {call}"
            );
            let drop = arguments.next().unwrap();
            assert!(
                drop.starts_with("fwp_drop") || drop == "fwp_rc_drop",
                "missing array release: {call}"
            );
            probe = probe.replace("DROP_ARRAY", drop);
        }
    }
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let source = format!("{runtime}\n{probe}");
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        fwp::cgen::compile_c(&source, &exe, opt).unwrap();
        assert_eq!(
            checked(&mut Command::new(&exe)).stdout,
            b"scalar array ownership preserved\n"
        );
    }
}

#[test]
fn generated_numeric_arrays_borrow_captures_and_preserve_effect_cleanup() {
    let dir = Scratch::new("capture-borrows");
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (name, text, expected) in [
        (
            "reads",
            include_str!("fixtures/array_capture_reads.fwp"),
            include_bytes!("fixtures/array_capture_reads.out").as_slice(),
        ),
        (
            "effects",
            include_str!("fixtures/array_capture_effects.fwp"),
            include_bytes!("fixtures/array_capture_effects.out").as_slice(),
        ),
    ] {
        let source = dir.0.join(format!("{name}.fwp"));
        std::fs::write(&source, text).unwrap();
        let reference = checked(
            Command::new(compiler)
                .args(["run", "--interp"])
                .arg(&source)
                .env("FWP_NO_OPT", "1"),
        );
        assert_eq!(reference.stdout, expected);
        assert!(reference.stderr.is_empty());
        for gc in ["arc", "tracing"] {
            for stack in ["0", "1"] {
                let cfile = dir.0.join(format!("{name}-{gc}-{stack}.c"));
                checked(
                    Command::new(compiler)
                        .args(["build", "--gc", gc, "--emit-c", "-O2"])
                        .arg(&source)
                        .arg("-o")
                        .arg(&cfile)
                        .env("FWP_STACK", stack)
                        .env_remove("FWP_NO_OPT"),
                );
                let emitted = std::fs::read_to_string(&cfile).unwrap();
                let helpers: Vec<_> = emitted
                    .lines()
                    .filter_map(|line| {
                        line.strip_prefix("static V fwp_borrowed_array")
                            .filter(|line| line.ends_with('{'))
                            .map(|line| line.split('(').next().unwrap())
                    })
                    .collect();
                assert!(
                    !helpers.is_empty(),
                    "{name}/{gc}/{stack}: missing borrowed array callback"
                );
                if name == "reads" {
                    assert_eq!(
                        emitted.contains("/* direct callback captures without a closure */"),
                        stack == "1",
                        "{name}/{gc}/{stack}: callback representation"
                    );
                }
                let retain = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
                assert_eq!(emitted.matches(retain).count(), 1);
                let start = "    fwp_init_consts();\n";
                let finish = "    /* Ownership observation point: before runtime teardown. */\n";
                assert_eq!(emitted.matches(start).count(), 1);
                assert_eq!(emitted.matches(finish).count(), 1);
                for (control, expected_status) in if name == "reads" {
                    &[
                        ("protected", 0),
                        ("extra-retain", 221),
                        ("leaked-owner", 222),
                    ][..]
                } else {
                    &[("protected", 0), ("skipped-partial-release", 222)][..]
                } {
                    let mut code = emitted.replace(
                        retain,
                        &format!(
                            "{retain}\n        if (array_probe_active) array_probe_retains++;"
                        ),
                    );
                    for helper in &helpers {
                        let call = format!("V value = fwp_borrowed_array{helper}(args);");
                        assert_eq!(code.matches(&call).count(), 1);
                        let extra = if *control == "extra-retain" {
                            "fwp_rc_dup(args[0]); fwp_rc_drop(args[0]);"
                        } else {
                            ""
                        };
                        let leaked = if *control == "leaked-owner" {
                            "fwp_rc_dup(args[0]);"
                        } else {
                            ""
                        };
                        let count_check = if name == "reads" {
                            "if (array_probe_retains) _Exit(221);"
                        } else {
                            ""
                        };
                        code = code.replace(&call, &format!("array_probe_retains=0; array_probe_active=1; {extra} {call} array_probe_active=0; {count_check} array_probe_calls++; {leaked}"));
                    }
                    code = code.replace(start, &format!("{start}    array_probe_start=fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget);\n"));
                    let release = "static void fwp_array_builder_release(void *arg) {\n    fwp_array_builder *owner = arg;";
                    assert_eq!(code.matches(release).count(), 1);
                    let skip = if *control == "skipped-partial-release" {
                        "return;"
                    } else {
                        ""
                    };
                    code = code.replace(release, &format!("{release}\n    if (owner->value && owner->filled == 2 && owner->element->kind == K_F64) {{ array_probe_partials++; {skip} }}"));
                    let calls = if name == "reads" {
                        "if (array_probe_calls != 3) _Exit(223);"
                    } else {
                        "if (array_probe_partials != 2) _Exit(224);"
                    };
                    code = code.replace(finish, &format!("{finish}    {calls}\n    const char *array_probe_stress=getenv(\"FWP_GC_STRESS\");\n    if ((!array_probe_stress || strcmp(array_probe_stress,\"1\")) && fwp_gc.total_alloc+(double)(fwp_gc.budget_given-fwp_gc.budget)!=array_probe_start) _Exit(222);\n"));
                    code = format!("static unsigned array_probe_active,array_probe_retains,array_probe_calls,array_probe_partials;\nstatic double array_probe_start;\n{code}");
                    for opt in ["-O0", "-O2"] {
                        let binary = dir
                            .0
                            .join(format!("{name}-{gc}-{stack}-{control}{opt}.exe"));
                        fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                        for stress in if gc == "tracing" && *control == "protected" {
                            &["0", "1"][..]
                        } else {
                            &["0"][..]
                        } {
                            let output = Command::new(&binary)
                                .env_remove("FWP_GC")
                                .env("FWP_GC_STRESS", stress)
                                .env("FWP_GC_VERIFY", stress)
                                .env("FWP_REUSE_VERIFY", stress)
                                .output()
                                .unwrap();
                            assert_eq!(
                                output.status.code(),
                                Some(*expected_status),
                                "{name}/{gc}/{stack}/{control}/{opt}/{stress}: {output:?}"
                            );
                            if *expected_status == 0 {
                                assert_eq!(output.stdout, reference.stdout);
                                assert_eq!(output.stderr, reference.stderr);
                            }
                            if let Some(destination) =
                                std::env::var_os("FWP_ARRAY_CAPTURE_ARTIFACTS")
                            {
                                let destination = PathBuf::from(destination);
                                std::fs::create_dir_all(&destination).unwrap();
                                let stem = format!("{name}-{gc}-{stack}-{control}{opt}-{stress}");
                                std::fs::write(destination.join(format!("{stem}.c")), &code)
                                    .unwrap();
                                std::fs::copy(&binary, destination.join(format!("{stem}.exe")))
                                    .unwrap();
                                std::fs::write(
                                    destination.join(format!("{stem}.stdout")),
                                    &output.stdout,
                                )
                                .unwrap();
                                std::fs::write(
                                    destination.join(format!("{stem}.stderr")),
                                    &output.stderr,
                                )
                                .unwrap();
                                std::fs::write(
                                    destination.join(format!("{stem}.status")),
                                    format!("{:?}\n", output.status.code()),
                                )
                                .unwrap();
                            }
                        }
                    }
                }
            }
        }
    }
}

#[test]
fn generated_array_captures_preserve_argument_and_callback_order() {
    let dir = Scratch::new("capture-order");
    let root = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let source = root.join("tests/fixtures/array_capture_order.fwp");
    let expected = std::fs::read(root.join("tests/fixtures/array_capture_order.out")).unwrap();
    let input = |command: &mut Command| {
        let mut child = command
            .stdin(Stdio::piped())
            .stdout(Stdio::piped())
            .stderr(Stdio::piped())
            .spawn()
            .unwrap();
        child.stdin.take().unwrap().write_all(b"seed").unwrap();
        let result = child.wait_with_output().unwrap();
        assert!(result.status.success(), "{result:?}");
        assert_eq!(result.stdout, expected);
        assert!(result.stderr.is_empty(), "{result:?}");
    };
    let compiler = env!("CARGO_BIN_EXE_fwp");
    input(
        Command::new(compiler)
            .args(["run", "--interp"])
            .arg(&source)
            .env("FWP_NO_OPT", "1"),
    );
    for gc in ["arc", "tracing"] {
        for stack in ["0", "1"] {
            let cfile = dir.0.join(format!("order-{gc}-{stack}.c"));
            checked(
                Command::new(compiler)
                    .args(["build", "--gc", gc, "--emit-c", "-O2"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile)
                    .env("FWP_STACK", stack)
                    .env_remove("FWP_NO_OPT"),
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            assert!(
                code.contains("/* borrowed array callback"),
                "{gc}/{stack}: missing capture borrowing"
            );
            for opt in ["-O0", "-O2"] {
                let binary = dir.0.join(format!("order-{gc}-{stack}{opt}.exe"));
                fwp::cgen::compile_c(&code, &binary, opt).unwrap();
                for stress in if gc == "tracing" {
                    &["0", "1"][..]
                } else {
                    &["0"][..]
                } {
                    input(
                        Command::new(&binary)
                            .env_remove("FWP_GC")
                            .env("FWP_GC_STRESS", stress)
                            .env("FWP_GC_VERIFY", stress)
                            .env("FWP_REUSE_VERIFY", stress),
                    );
                }
            }
        }
    }
}
