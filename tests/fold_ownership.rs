//! Fold transfers its accumulator while borrowing list elements and callbacks.
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
        let p = std::env::temp_dir().join(format!("fwp-fold-{}-{name}", std::process::id()));
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
fn numeric_record_folds_preserve_aliases_empty_inputs_and_effects() {
    let dir = Scratch::new("numeric-records");
    let src = dir.0.join("records.fwp");
    std::fs::write(
        &src,
        r#"
step : (I64, F64) -> (I64, F64) -> (I64, F64)
step = fn (count, total) -> fn (n, value) -> (count + n, total + value)
scalar-step : (I64, F64) -> I64 -> (I64, F64)
scalar-step = fn (count, total) -> fn n -> (count + n, total + 0.5)
fail-step : (I64, F64) -> I64 -> (I64, F64) ! {Error[String]}
fail-step = fn (count, total) -> fn n ->
    n == 2 | match
        True -> fail "stop"
        False -> (count + n, total + 0.5)
aliases : (I64, F64) -> List[(I64, F64)] -> ((I64, F64), (I64, F64), List[(I64, F64)])
aliases = fn seed -> fn values -> (fold step seed values, seed, values)
main =
    let n = read-all () | string.length
    in [
        aliases (n, 0.5) [(1, 1.5), (2, 2.5)] | show,
        aliases (n, 0.5) [] | show,
        aliases (n, 0.5) [(3, 1.5)] | show,
        [1, 2, 3] | fold scalar-step (n, 0.5) | show,
        [1, 2, 3] | attempt (fold fail-step (n, 0.5)) | show,
    ] | each print
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1"),
    );
    let optimized = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    assert_eq!(optimized.stdout, reference.stdout);
    for stack in ["0", "1"] {
        let cfile = dir.0.join(format!("records-{stack}.c"));
        checked(
            Command::new(fwp)
                .args(["build", "--memory", "dynamic"])
                .arg(&src)
                .args(["--emit-c", "-o"])
                .arg(&cfile)
                .env("FWP_STACK", stack),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        assert!(code.contains("Numeric record fold: one result box"));
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("records-{stack}-{opt}.exe"));
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            let out = checked(Command::new(&exe).env("FWP_ALLOC_STATS", "1"));
            assert_eq!(out.stdout, reference.stdout, "{stack}/{opt}");
            let stats =
                allocation_report::parse(std::str::from_utf8(&out.stderr).unwrap()).unwrap();
            assert_eq!(stats.live, 0, "{stack}/{opt}: {stats:?}");
        }
    }
}

#[test]
fn numeric_record_folds_allocate_only_the_final_result() {
    let dir = Scratch::new("record-counts");
    let input = dir.0.join("point.fwp");
    let cfile = dir.0.join("point.c");
    std::fs::write(&input, r#"
Point = {index: I64, value: F64}
step : Point -> Point -> Point
step = fn a -> fn b -> Point {index = (a | .index) + (b | .index), value = (a | .value) + (b | .value)}
export transform : Point -> List[Point] -> Point
transform = fold step
"#).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args([
                "build",
                "--fn",
                "transform",
                "--memory",
                "dynamic",
                "--emit-c",
            ])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let code = std::fs::read_to_string(cfile).unwrap();
    let helper_start = code.find("static V fwp_record_fold").unwrap();
    let helper = code[helper_start..]
        .split('(')
        .next()
        .unwrap()
        .strip_prefix("static V ")
        .unwrap();
    let drop_name = |ty: &str| {
        let start = code
            .find(&format!("/* {ty} */\nstatic void fwp_drop"))
            .unwrap();
        code[start..]
            .split("static void ")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap()
    };
    let point_drop = drop_name("Point");
    let probe = include_str!("fixtures/record_fold_counts.c")
        .replace("RECORD_FOLD", helper)
        .replace("DROP_POINT", point_drop)
        .replace("DROP_LIST", drop_name("List[Point]"));
    let mut prefix = code[..code.find("int main(").unwrap()].replace("typedef uint64_t V;",
        "typedef uint64_t V;\nstatic uint64_t record_fold_allocations, record_fold_bytes, record_fold_retains;");
    for marker in [
        "static inline void *fwp_heap_alloc(size_t n, int kind) {",
        "static inline void *fwp_alloc_init(size_t n) {",
    ] {
        assert_eq!(prefix.matches(marker).count(), 1);
        let condition = if marker.contains("int kind") {
            "if (kind != 0) "
        } else {
            ""
        };
        prefix = prefix.replace(
            marker,
            &format!("{marker}\n{condition}{{record_fold_allocations++; record_fold_bytes += n;}}"),
        );
    }
    let retain = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
    assert_eq!(prefix.matches(retain).count(), 1);
    prefix = prefix.replace(retain, &format!("{retain}\nrecord_fold_retains++;"));
    let normal = format!("{prefix}\n{probe}");
    let missing_result = normal.replace(&format!("{point_drop}(result);"), ";");
    let missing_seed = normal.replace(
        &format!("    {point_drop}(z);\n    while (xs)"),
        "    while (xs)",
    );
    assert_ne!(normal, missing_result);
    assert_ne!(normal, missing_seed);
    for opt in ["-O1", "-O2"] {
        for (name, source, expected) in [
            ("ordinary", &normal, 0),
            ("missing-result", &missing_result, 90),
            ("missing-seed", &missing_seed, 90),
        ] {
            let exe = dir.0.join(format!("{name}-{opt}.exe"));
            fwp::cgen::compile_c(source, &exe, opt).unwrap();
            let output = Command::new(&exe).output().unwrap();
            record_probe::save(
                "record_fold",
                &format!("{name}-{opt}"),
                source,
                &exe,
                &output,
            );
            assert_eq!(
                output.status.code(),
                Some(expected),
                "{name}/{opt}: {output:?}"
            );
        }
    }
}
#[test]
fn record_fold_selection_excludes_owned_fields_and_other_calling_conventions() {
    let dir = Scratch::new("record-exclusions");
    let cases = [
        ("managed", "step : (I64, String) -> I64 -> (I64, String)\nstep = fn (n, text) -> fn value -> (n + value, text)\nexport transform : (I64, String) -> List[I64] -> (I64, String)\ntransform = fold step\n"),
        ("nested", "step : ((I64, I64), F64) -> I64 -> ((I64, I64), F64)\nstep = fn ((n, count), total) -> fn value -> ((n + value, count + 1), total)\nexport transform : ((I64, I64), F64) -> List[I64] -> ((I64, I64), F64)\ntransform = fold step\n"),
        ("wide", "step : (F128, I64) -> I64 -> (F128, I64)\nstep = fn (value, count) -> fn n -> (value, count + n)\nexport transform : (F128, I64) -> List[I64] -> (F128, I64)\ntransform = fold step\n"),
        ("whole-value", "step : (I64, F64) -> I64 -> (I64, F64)\nstep = const\nexport transform : (I64, F64) -> List[I64] -> (I64, F64)\ntransform = fold step\n"),
        ("right", "step : I64 -> (I64, F64) -> (I64, F64)\nstep = fn n -> fn (count, total) -> (count + n, total + 0.5)\nexport transform : (I64, F64) -> List[I64] -> (I64, F64)\ntransform = fold-right step\n"),
        ("captured", "step : I64 -> (I64, F64) -> I64 -> (I64, F64)\nstep = fn offset -> fn (count, total) -> fn n -> (count + n + offset, total + 0.5)\nexport transform : I64 -> (I64, F64) -> List[I64] -> (I64, F64)\ntransform = step | fold\n"),
        ("dynamic", "export transform : ((I64, F64) -> I64 -> (I64, F64)) -> (I64, F64) -> List[I64] -> (I64, F64)\ntransform = fold\n"),
    ];
    for (name, source) in cases {
        let input = dir.0.join(format!("{name}.fwp"));
        let cfile = dir.0.join(format!("{name}.c"));
        std::fs::write(&input, source).unwrap();
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .args(["build", "--fn", "transform", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        assert!(
            !code.contains("Numeric record fold: one result box"),
            "{name}"
        );
    }
}

#[test]
fn accumulator_input_and_capture_aliases_preserve_values() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String -> String)
choose = if (rem 2 | eq 0)
    (const concat)
    (const (flip concat))
three : String -> String -> String -> String
three = curry3 (fork concat .0 (fork concat .1 .2))
keep : String -> (String, String)
keep = both (flip (fold concat) ["a", "b"]) id
function-step : (String -> String) -> String -> (String -> String)
function-step = curry (fork const .0 .1)
use-functions : List[String] -> (String, String)
use-functions = fold function-step (concat "kept") | both (apply "!") (apply "?")
main = [
    ["a", "b", "c"] | both (fold concat "seed") id | echo,
    ["a", "b", "c"] | both (fold const "seed") id | echo,
    ["a", "b", "c"] | both (fold (flip const) "seed") id | echo,
    ["a", "b", "c"] | fold (3 | choose) "seed" | echo,
    ["a", "b", "c"] | fold (4 | choose) "seed" | echo,
    ["a", "b"] | fold (three "prefix") "seed" | echo,
    [] | fold concat "empty" | echo,
    [1, 2, 3] | fold add 7 | echo,
    ["a", "b"] | use-functions | echo,
    read-all () | concat "input" | keep | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1"),
    );
    for opt in ["-O1", "-O2"] {
        for stack in ["0", "1"] {
            let exe = dir.0.join(format!("aliases{opt}-{stack}"));
            checked(
                Command::new(fwp)
                    .args(["build"])
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_STACK", stack),
            );

            let out = checked(&mut Command::new(&exe));
            assert_eq!(out.stdout, reference.stdout, "{opt}, stack {stack}");
        }
    }
}
#[test]
fn folded_accumulators_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
choose : I64 -> (String -> String -> String)
choose = if (rem 2 | eq 0)
    (const concat)
    (const (flip concat))
size : I64 -> I64
size = choose | flip fold "seed" | apply ["a", "b", "c"] | string.length
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
            .args(["run", "--interp"])
            .arg(&src)
            .env("FWP_NO_OPT", "1"),
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
    let owned = std::fs::read_to_string(emitted).unwrap();
    let start = owned.find("static V fwp_p_fold_own(").unwrap();
    let end = start + owned[start..].find("\n}\n").unwrap();
    let callback = "z = fwp_apply_borrowed_prefix(f, 2, args, 1);";
    assert_eq!(owned[start..end].matches(callback).count(), 1);
    let mut retained = owned.clone();
    retained.replace_range(
        start..end,
        &owned[start..end].replace(callback, &format!("{callback} fwp_rc_dup(z);")),
    );
    // Captured HOFs also transfer accumulators through the owned entry.
    retained = retained
        .lines()
        .map(|line| {
            let trimmed = line.trim();
            if let Some(call) = trimmed
                .strip_prefix("z = ")
                .and_then(|s| s.strip_suffix(';'))
            {
                if call.starts_with("fwp_owned_entry") || call.starts_with("fwp_borrowed_fold") {
                    let indent = &line[..line.len() - line.trim_start().len()];
                    return format!("{indent}z = {call}; fwp_rc_dup(z);");
                }
            }
            line.to_string()
        })
        .collect::<Vec<_>>()
        .join("\n");
    let mut freed = Vec::new();
    for (name, code) in [("retained", &retained), ("owned", &owned)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
        let out = checked(Command::new(&exe).env("FWP_ALLOC_STATS", "1"));
        assert_eq!(out.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&out.stderr);

        let report = allocation_report::parse(&stats).expect("allocation report");
        if name == "owned" {
            assert_eq!(report.live, 0, "{name}: {report:?}");
        } else {
            assert!(
                report.live > 0,
                "ineffective retained-owner control: {name}: {report:?}"
            );
        }
        freed.push(report.released as f64 / 1_048_576.0);
    }
    eprintln!("fold MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn known_fold_callbacks_borrow_captures_and_elements_without_retain_traffic() {
    let dir = Scratch::new("borrowed-parameters");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (fold, ty, body) in [
        (
            "fold",
            "String -> I64 -> String -> I64",
            "if (fork eq .0 .2) (.1 | add 1) .1",
        ),
        (
            "fold-right",
            "String -> String -> I64 -> I64",
            "if (fork eq .0 .1) (.2 | add 1) .2",
        ),
    ] {
        let source = dir.0.join(format!("{fold}.fwp"));
        // Heap strings prevent literal constants from hiding reference traffic.
        // The callback only compares its capture/element and updates an integer.
        std::fs::write(&source, format!(r#"step : {ty}
step = curry3 ({body})
count : String -> List[String] -> I64
count = step | flip {fold} 0
main = (read-all () | concat "needle!", ["needle", "skip"] | map (concat "!")) | uncurry count | echo
"#)).unwrap();
        let reference = checked(
            Command::new(fwp)
                .args(["run", "--interp"])
                .arg(&source)
                .env("FWP_NO_OPT", "1"),
        );
        assert_eq!(reference.stdout, b"1\n");
        for stack in ["0", "1"] {
            let cfile = dir.0.join(format!("{fold}-{stack}.c"));
            checked(
                Command::new(fwp)
                    .args(["build"])
                    .arg(&source)
                    .args(["--emit-c", "-o"])
                    .arg(&cfile)
                    .env("FWP_STACK", stack),
            );
            let emitted = std::fs::read_to_string(cfile).unwrap();
            assert_eq!(
                emitted.contains("/* direct callback captures without a closure */"),
                stack == "1",
                "{fold}/{stack}: callback representation"
            );
            let helpers: Vec<_> = emitted
                .lines()
                .filter_map(|line| {
                    line.strip_prefix("static V fwp_borrowed_fold")
                        .filter(|line| line.ends_with('{'))
                        .map(|line| line.split('(').next().unwrap())
                })
                .collect();
            assert!(
                !helpers.is_empty(),
                "{fold}: no callback body with borrowed parameters"
            );
            let retain = "static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {";
            assert_eq!(emitted.matches(retain).count(), 1);
            let runtime = emitted
                .replace(
                    retain,
                    &format!("{retain}\n        if (probe_active) probe_retains++;"),
                )
                .replace(
                    "int main(int argc, char **argv)",
                    "int original_main(int argc, char **argv)",
                );
            for broken in [false, true] {
                let mut runtime = runtime.clone();
                for id in &helpers {
                    let call = format!("z = fwp_borrowed_fold{id}(args);");
                    assert_eq!(runtime.matches(&call).count(), 1);
                    let extra = if broken {
                        "fwp_rc_dup(args[0]); fwp_rc_drop(args[0]);"
                    } else {
                        ""
                    };
                    runtime = runtime.replace(&call, &format!("probe_retains=0; probe_active=1; {extra} {call} probe_active=0; if(probe_retains)_Exit(88); probe_calls++;"));
                }
                let code = format!("static unsigned probe_active,probe_retains,probe_calls;\n{runtime}\nint main(int argc,char **argv){{int status=original_main(argc,argv);if(!status && probe_calls!=2)return 89;return status;}}\n");
                for opt in ["-O1", "-O2"] {
                    let exe = dir
                        .0
                        .join(format!("borrowed-{fold}-{stack}-{broken}{opt}.exe"));
                    fwp::cgen::compile_c(&code, &exe, opt).unwrap();
                    let artifacts =
                        std::env::var_os("FWP_CALLBACK_CAPTURE_ARTIFACTS").map(PathBuf::from);
                    let stem = format!("{fold}-{stack}-{broken}{opt}");
                    if let Some(path) = &artifacts {
                        std::fs::create_dir_all(path).unwrap();
                        std::fs::write(path.join(format!("{stem}.c")), &code).unwrap();
                        std::fs::copy(&exe, path.join(format!("{stem}.exe"))).unwrap();
                    }

                    let output = Command::new(&exe).output().unwrap();
                    assert_eq!(
                        output.status.code(),
                        Some(if broken { 88 } else { 0 }),
                        "{fold}/{stack}/{opt}/broken={broken}: {output:?}"
                    );
                    if !broken {
                        assert_eq!(output.stdout, reference.stdout);
                    }
                    if let Some(path) = &artifacts {
                        std::fs::write(path.join(format!("{stem}.stdout")), &output.stdout)
                            .unwrap();
                        std::fs::write(path.join(format!("{stem}.stderr")), &output.stderr)
                            .unwrap();
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
}
