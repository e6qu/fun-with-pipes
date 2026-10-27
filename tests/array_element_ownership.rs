//! Array storage owns typed elements across copies, aliases and callbacks.
use std::io::Write;
use std::path::PathBuf;
use std::process::{Command, Output, Stdio};

#[path = "support/array_construction.rs"]
mod array_construction;

#[path = "support/array_probe.rs"]
mod array_probe;

#[path = "support/array_sort.rs"]
mod array_sort;

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

    for stack in ["0", "1"] {
        let cfile = dir.0.join(format!("boundaries-counted-{stack}.c"));
        checked(
            Command::new(compiler)
                .args(["build", "--emit-c", "-O2"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile)
                .env("FWP_STACK", stack)
                .env_remove("FWP_NO_OPT"),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        for opt in ["-O0", "-O2"] {
            let binary = dir.0.join(format!("boundaries-counted-{stack}{opt}.exe"));
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();

            let output = checked(&mut Command::new(binary));
            assert_eq!(output.stdout, reference.stdout, "counted/{stack}/{opt}");
            assert!(
                output.stderr.is_empty(),
                "counted/{stack}/{opt}: {output:?}"
            );
            if let Some(path) = std::env::var_os("FWP_CALLBACK_CAPTURE_ARTIFACTS") {
                let path = PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                let stem = format!("boundaries-counted-{stack}{opt}");
                std::fs::write(path.join(format!("{stem}.c")), &code).unwrap();
                std::fs::copy(
                    dir.0.join(format!("boundaries-counted-{stack}{opt}.exe")),
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
        for reuse in [false, true] {
            let cfile = dir.0.join(format!("{name}-{reuse}.c"));
            checked(
                Command::new(compiler)
                    .args(["build", "--emit-c", "-O2"])
                    .arg(&source)
                    .arg("-o")
                    .arg(&cfile)
                    .env("FWP_NO_OPT", "1")
                    ,
            );
            let code = std::fs::read_to_string(&cfile).unwrap();
            let code = if reuse { code } else { format!("#define FWP_NO_REUSE 1\n{code}") };
            let table = code
                .split_once("static const fwp_fninfo fwp_fn_table[] = {\n")
                .unwrap()
                .1
                .split_once("};")
                .unwrap()
                .0;
            let entries: Vec<_> = table.lines().filter(|line| line.contains("\"direct\"")).collect();
            assert_eq!(entries.len(), 1, "{name}/{reuse}: {table}");
            assert_eq!(
                entries[0].contains(", 0, \"direct\", 0}"),
                !dynamic,
                "{name}/{reuse}: {}",
                entries[0]
            );
            for opt in ["-O0", "-O2"] {
                let exe = dir.0.join(format!("{name}-{reuse}{opt}.exe"));
                fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                let result = checked(
                    Command::new(&exe)
                        .stdin(Stdio::null())



                        ,
                );
                assert_eq!(result.stdout, reference.stdout, "{name}/{reuse}/{opt}");
                assert!(result.stderr.is_empty(), "{result:?}");
            }
        }
    }
}

#[test]
fn array_elements_aliases_and_callbacks_preserve_owners() {
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
            let exe = dir.0.join(format!("counted{opt}-aliases-stack{stack}.exe"));
            let cfile = exe.with_extension("c");
            for emit in [true, false] {
                let mut command = Command::new(fwp);
                command
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", stack)
                    .args(["build", "--memory", "dynamic", opt])
                    .arg(&src);
                if emit {
                    command.arg("--emit-c");
                }
                command.arg("-o").arg(if emit { &cfile } else { &exe });
                checked(&mut command);
            }
            let code = std::fs::read_to_string(cfile).unwrap();

            let out = Command::new(&exe)
                .env("FWP_ALLOC_STATS", "0")
                .output()
                .unwrap();
            let label = format!("counted{opt}-aliases-stack{stack}");
            record_probe::save("array_element_ownership", &label, &code, &exe, &out);
            assert_eq!(
                out.status.code(),
                reference.status.code(),
                "{label}: {out:?}"
            );
            assert_eq!(out.stdout, reference.stdout, "{label}");
            assert_eq!(out.stderr, reference.stderr, "{label}");
        }
    }

    // These deliberate controls preserve values while forcing copies or retention.
    for control in ["no-reuse", "no-free"] {
        let exe = dir.0.join(format!("{control}.exe"));
        let cfile = exe.with_extension("c");
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", "0")
                .args(["build", "--memory", "dynamic", "-O2", "--emit-c"])
                .arg(&src)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let code = if control == "no-reuse" {
            format!("#define FWP_NO_REUSE 1\n{code}")
        } else {
            let boundary = "static void fwp_mem_free(void *p) {\n";
            assert_eq!(code.matches(boundary).count(), 1);
            code.replacen(boundary, &format!("{boundary}    return;\n"), 1)
        };
        fwp::cgen::compile_c(&code, &exe, "-O1").unwrap();
        let out = Command::new(&exe)
            .env("FWP_ALLOC_STATS", "0")
            .output()
            .unwrap();
        let label = format!("counted-O1-{control}");
        record_probe::save("array_element_ownership", &label, &code, &exe, &out);
        assert_eq!(
            out.status.code(),
            reference.status.code(),
            "{label}: {out:?}"
        );
        assert_eq!(out.stdout, reference.stdout, "{label}");
        assert_eq!(out.stderr, reference.stderr, "{label}");
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
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "0")
            .args(["build", "--memory", "dynamic", "-O2", "--emit-c"])
            .arg(&src)
            .arg("-o")
            .arg(&emitted),
    );
    let owned = std::fs::read_to_string(&emitted).unwrap();

    let finish = "\n    /* Ownership observation point: before runtime teardown. */\n";
    assert_eq!(owned.matches(finish).count(), 1);
    let balanced = owned.replace(
        finish,
        &format!("{finish}    if(fwp_heap.live!=0||fwp_heap.rc_wide_len)exit(90);\n"),
    );
    let mut changed = 0;
    let leaking = balanced
        .lines()
        .map(|line| {
            if line.contains("return fwp_p_array_sort_typed(") {
                changed += 1;
                line.replace(
                    "return fwp_p_array_sort_typed(",
                    "V result = fwp_p_array_sort_typed(",
                )
                .replace(';', "; fwp_rc_dup(result); return result;")
            } else {
                line.to_owned()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert_eq!(changed, 1);
    for opt in ["-O1", "-O2"] {
        for (name, code, status) in [
            ("reclamation", &balanced, 0),
            ("extra-sort-owner", &leaking, 90),
        ] {
            let exe = dir.0.join(format!("counted{opt}-{name}.exe"));
            fwp::cgen::compile_c(code, &exe, opt).unwrap();
            let out = Command::new(&exe)
                .env("FWP_ALLOC_STATS", "0")
                .output()
                .unwrap();
            let label = format!("counted{opt}-{name}");
            record_probe::save("array_element_ownership", &label, code, &exe, &out);
            assert_eq!(out.status.code(), Some(status), "{label}: {out:?}");
            assert_eq!(out.stdout, reference.stdout, "{label}");
            assert!(out.stderr.is_empty(), "{label}: {out:?}");
        }
    }
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

    // This probe needs the dynamic conversion primitives so it can inject
    // scalar bits shaped like managed addresses into their actual wrappers.
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .env("FWP_ARRAY_FUSION", "0")
            .env("FWP_STACK", "0")
            .args(["build", "--memory", "dynamic", "-O2"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let mut probe = r#"
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 23;
#endif
    fwp_heap_start();
    size_t baseline=fwp_heap.live;
    for(unsigned round=0;round<32;round++) {
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    V xs = fwp_rc_fresh(fwp_cons(bits, 0));
    fwp_rc_dup(xs); /* Keep the independent list alias across conversion. */
    V original = FROM_LIST_WRAPPER(xs);
    V selected = GET_WRAPPER(0, original);
    V listed = TO_LIST_WRAPPER(original);
    V sliced = SLICE_WRAPPER(0, 1, original);
    fwp_rc_dup(original); /* The sort call consumes its own array reference. */
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
    DROP_LIST(xs);DROP_LIST(listed);
    fwp_rc_free_obj(selected);fwp_rc_free_obj(changed);fwp_rc_free_obj(bits);
    if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
    }
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
    let boundary = emitted.find("return fwp_p_array_to_list_typed(").unwrap();
    let call = emitted[boundary..].split(';').next().unwrap();
    let drop_list = call.rsplit(", ").next().unwrap().trim_end_matches(')');
    assert!(
        drop_list.starts_with("fwp_drop"),
        "missing scalar list release: {call}"
    );
    probe = probe.replace("DROP_LIST", drop_list);
    let scalar = "return fwp_p_array_from_list_typed(l0, NULL,";
    assert_eq!(runtime.matches(scalar).count(), 1);
    let mut cases = vec![
        ("scalar", runtime.clone(), probe.clone(), 0),
        (
            "scalar-counted",
            runtime.replace(scalar, "return fwp_p_array_from_list_typed(l0, fwp_rc_dup,"),
            probe.clone(),
            1,
        ),
    ];

    for (label, release) in [
        ("missing-input-list", format!("{drop_list}(xs);")),
        ("missing-output-list", format!("{drop_list}(listed);")),
        ("missing-selected", "fwp_rc_free_obj(selected);".to_owned()),
        ("missing-changed", "fwp_rc_free_obj(changed);".to_owned()),
        ("missing-bits", "fwp_rc_free_obj(bits);".to_owned()),
    ] {
        assert_eq!(probe.matches(&release).count(), 1);
        cases.push((
            label,
            runtime.clone(),
            probe.replace(&release, "/* omitted owner */"),
            90,
        ));
    }

    for opt in ["-O1", "-O2"] {
        for (case, runtime, probe, status) in &cases {
            let code = format!("{runtime}\n{probe}");
            let exe = dir.0.join(format!("counted{opt}-{case}.exe"));
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();

            let out = Command::new(&exe)
                .env("FWP_ALLOC_STATS", "0")
                .output()
                .unwrap();
            let label = format!("counted{opt}-{case}");
            record_probe::save("array_element_ownership", &label, &code, &exe, &out);
            assert_eq!(out.status.code(), Some(*status), "{label}: {out:?}");
            assert!(out.stderr.is_empty(), "{label}: {out:?}");
            assert_eq!(
                out.stdout,
                if *status == 0 {
                    b"scalar array ownership preserved\n".as_slice()
                } else {
                    b""
                },
                "{label}"
            );
        }
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

        for stack in ["0", "1"] {
            let cfile = dir.0.join(format!("{name}-counted-{stack}.c"));
            checked(
                Command::new(compiler)
                    .args(["build", "--emit-c", "-O2"])
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
                "{name}/counted/{stack}: missing borrowed array callback"
            );
            if name == "reads" {
                assert_eq!(
                    emitted.contains("/* direct callback captures without a closure */"),
                    stack == "1",
                    "{name}/counted/{stack}: callback representation"
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
                    &format!("{retain}\n        if (array_probe_active) array_probe_retains++;"),
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
                code = code.replace(
                    start,
                    &format!("{start}    array_probe_start=(double)fwp_heap.live;\n"),
                );
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
                code = code.replace(finish, &format!("{finish}    {calls}\n    if ((double)fwp_heap.live!=array_probe_start) _Exit(222);\n"));
                code = format!("static unsigned array_probe_active,array_probe_retains,array_probe_calls,array_probe_partials;\nstatic double array_probe_start;\n{code}");
                for opt in ["-O0", "-O2"] {
                    let binary = dir
                        .0
                        .join(format!("{name}-counted-{stack}-{control}{opt}.exe"));
                    fwp::cgen::compile_c(&code, &binary, opt).unwrap();

                    let output = Command::new(&binary).output().unwrap();
                    assert_eq!(
                        output.status.code(),
                        Some(*expected_status),
                        "{name}/counted/{stack}/{control}/{opt}: {output:?}"
                    );
                    if *expected_status == 0 {
                        assert_eq!(output.stdout, reference.stdout);
                        assert_eq!(output.stderr, reference.stderr);
                    }
                    if let Some(destination) = std::env::var_os("FWP_ARRAY_CAPTURE_ARTIFACTS") {
                        let destination = PathBuf::from(destination);
                        std::fs::create_dir_all(&destination).unwrap();
                        let stem = format!("{name}-counted-{stack}-{control}{opt}");
                        std::fs::write(destination.join(format!("{stem}.c")), &code).unwrap();
                        std::fs::copy(&binary, destination.join(format!("{stem}.exe"))).unwrap();
                        std::fs::write(destination.join(format!("{stem}.stdout")), &output.stdout)
                            .unwrap();
                        std::fs::write(destination.join(format!("{stem}.stderr")), &output.stderr)
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

    for stack in ["0", "1"] {
        let cfile = dir.0.join(format!("order-counted-{stack}.c"));
        checked(
            Command::new(compiler)
                .args(["build", "--emit-c", "-O2"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile)
                .env("FWP_STACK", stack)
                .env_remove("FWP_NO_OPT"),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        assert!(
            code.contains("/* borrowed array callback"),
            "counted/{stack}: missing capture borrowing"
        );
        for opt in ["-O0", "-O2"] {
            let binary = dir.0.join(format!("order-counted-{stack}{opt}.exe"));
            fwp::cgen::compile_c(&code, &binary, opt).unwrap();

            input(&mut Command::new(&binary));
        }
    }
}

#[test]
fn static_array_callbacks_avoid_owner_checks_and_preserve_partial_cleanup() {
    let dir = Scratch::new("static-callbacks");
    let source = dir.0.join("callbacks.fwp");
    std::fs::write(&source, include_str!("fixtures/static_array_callbacks.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert!(reference.stderr.is_empty());
    let cfile = dir.0.join("callbacks.c");
    checked(
        Command::new(compiler)
            .env_remove("FWP_NO_OPT")
            .args(["build", "--emit-c", "-O2"])
            .arg(&source)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let function = |name: &str| {
        let start = code.find(&format!("/* {name} :")).unwrap();
        let id = code[start..]
            .split("static V f")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        format!("f{id}")
    };
    let generated = function("generated");
    let failed = function("failed");
    let measured = code
        .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic int callback_probe_active;\nstatic size_t callback_probe_retains, callback_probe_drops;")
        .replace("static inline void fwp_rc_dup(V v) {\n", "static inline void fwp_rc_dup(V v) {\n    if (callback_probe_active) callback_probe_retains++;\n")
        .replace("static void fwp_closure_drop(V f) {\n", "static void fwp_closure_drop(V f) {\n    if (callback_probe_active) callback_probe_drops++;\n")
        .replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
    let probe = format!(
        r#"
int main(void) {{
    fwp_heap_start(); fwp_fns=fwp_fn_table; fwp_init_consts();
    size_t initial=fwp_heap.live;
    const size_t lengths[]={{0,16,4096}};
    for(size_t test=0;test<3;test++) {{
        size_t n=lengths[test];
        callback_probe_active=1;
        V result={generated}((V)n);
        callback_probe_active=0;
        if(callback_probe_retains || callback_probe_drops) return 224;
        if(fwp_array_len(result)!=n) return 226;
        for(size_t i=0;i<n;i++) if((int64_t)fwp_array_load(result,i,NULL)!=(int64_t)i) return 227;
        fwp_rc_free_arr(result);
        if(fwp_heap.live!=initial) return 225;
    }}
    fwp_handler h; h.prev=fwp_handlers; h.state_depth=fwp_state_len; h.cleanup=fwp_cleanups;
    fwp_handlers=&h;
    if(!setjmp(h.jb)) {{ {failed}(4); return 228; }}
    fwp_handlers=h.prev;
    if(fwp_cleanups!=h.cleanup || fwp_heap.live!=initial) return 225;
    return 0;
}}
"#
    );
    let measured = measured + &probe;
    for optimization in ["-O1", "-O2"] {
        let binary = dir.0.join(format!("semantics{optimization}.exe"));
        fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
        let actual = checked(&mut Command::new(&binary));
        assert_eq!(actual.stdout, reference.stdout, "{optimization}");
        assert_eq!(actual.stderr, reference.stderr, "{optimization}");
        for (label, variant, expected) in [
            ("owned", measured.clone(), 0),
            (
                "extra-callback-check",
                measured.replace(
                    "callback_probe_active=1;",
                    "callback_probe_active=1; fwp_rc_dup(0);",
                ),
                224,
            ),
            (
                "missing-partial-cleanup",
                measured.replace(
                    "fwp_array_builder *owner = arg;",
                    "fwp_array_builder *owner = arg; (void)owner; return;",
                ),
                225,
            ),
        ] {
            let binary = dir.0.join(format!("{label}{optimization}.exe"));
            fwp::cgen::compile_c(&variant, &binary, optimization).unwrap();
            let actual = Command::new(&binary).output().unwrap();
            record_probe::save(
                "static-array-callbacks",
                &format!("{label}{optimization}"),
                &variant,
                &binary,
                &actual,
            );
            assert_eq!(
                actual.status.code(),
                Some(expected),
                "{label}/{optimization}: {actual:?}"
            );
            assert!(
                actual.stdout.is_empty() && actual.stderr.is_empty(),
                "{actual:?}"
            );
        }
    }
}
