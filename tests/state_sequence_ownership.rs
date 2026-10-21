//! State sequences preserve owners; each visits in order without result nodes.
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
            std::env::temp_dir().join(format!("fwp-state-sequence-{}-{name}", std::process::id()));
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
fn state_sequences_preserve_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
trace-step : String -> String ! {IO}
trace-step = both echo id | .1 | concat "!"
trace-scan : String -> String -> String ! {IO}
trace-scan = const trace-step
main = [
    "a b c" | words | both (scan concat "start:") id | echo,
    "a b c" | words | scan const "unchanged" | map (concat "state:") | echo,
    "a b c" | words | scan (flip const) "first" | echo,
    "a b c" | words | scan trace-scan "trace:" | echo,
    [] | scan concat "empty" | echo,
    scan concat ("a b" | words | join "") [] | echo,
    iterate 1 id ("a b" | words | join "") | echo,
    "seed" | both (iterate 5 (concat "!")) id | echo,
    "seed" | iterate 5 id | map (concat "alias:") | echo,
    "seed" | iterate 3 trace-step | echo,
    "seed" | iterate 1 trace-step | echo,
    "seed" | iterate 0 trace-step | echo,
    "seed" | iterate -1 trace-step | echo,
    iterate 4 id (concat "capture:") | map (apply "!") | echo,
    scan (flip const) (concat "initial:") (["a", "b", "c"] | map concat) | map (apply "!") | echo,
    [1, 2, 3] | scan add 0 | echo,
    1 | iterate 4 (add 1) | echo,
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
fn state_sequences_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
score : List[String] -> I64
score = head | option.map string.length | option.unwrap-or 0
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
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0"),
    );
    let owned = std::fs::read_to_string(&emitted).unwrap();
    // Restore result sharing only in the emitted monomorphic wrappers.
    // Scalar bits never become references in either version.
    let mut changed = 0;
    let shared = owned
        .lines()
        .map(|line| {
            if ["scan", "iterate"]
                .iter()
                .any(|name| line.contains(&format!("return fwp_p_{name}_owned(l")))
            {
                changed += 1;
                line.replacen("return ", "return fwp_rc_shared(", 1)
                    .replace(");", "));")
            } else {
                line.to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert!(changed == 2, "missing scan/iterate boundaries: {changed}");
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
    eprintln!("state sequence graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn each_preserves_aliases_effect_order_and_early_failures() {
    let dir = Scratch::new("each-order");
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let cases = [
        (
            "values",
            r#"main = [
    "a b c" | words | both (each echo) id | .1 | echo,
    [] | each (concat "empty:" | echo),
    range 0 3 | run-state 0 (each (const (add 1) | modify)) | .1 | echo,
    "a stop later" | words | attempt (each (if (eq "stop") (const "stopped" | fail) echo)) | echo,
] | ignore
"#,
            "a\nb\nc\n[\"a\", \"b\", \"c\"]\n3\na\nErr \"stopped\"\n",
            0,
        ),
        (
            "trap",
            "main = [2, 0, 4] | each (both echo (flip div 12 | ignore) | ignore)\n",
            "2\n0\n",
            101,
        ),
        (
            "capture-trap",
            "bad : I64\nbad = 1 | div 0\nmain = each (add bad | ignore) ([9223372036854775807] | map (mul 2))\n",
            "",
            101,
        ),
        (
            "empty-capture-trap",
            "bad : I64\nbad = 1 | div 0\nmain = each (add bad | ignore) []\n",
            "",
            101,
        ),
    ];
    for (name, source, expected, status) in cases {
        let input = dir.0.join(format!("{name}.fwp"));
        std::fs::write(&input, source).unwrap();
        let raw = Command::new(compiler)
            .args(["run", "--interp"])
            .env("FWP_NO_OPT", "1")
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(raw.status.code(), Some(status), "{raw:?}");
        assert_eq!(raw.stdout, expected.as_bytes());
        if name.ends_with("capture-trap") {
            // Creating the callback evaluates its capture before evaluating
            // the input, even when no element would use that captured value.
            assert!(String::from_utf8_lossy(&raw.stderr).contains("division by zero"));
        }
        let optimized = Command::new(compiler)
            .args(["run", "--interp"])
            .env_remove("FWP_NO_OPT")
            .arg(&input)
            .output()
            .unwrap();
        assert_eq!(
            (
                &optimized.stdout,
                &optimized.stderr,
                optimized.status.code()
            ),
            (&raw.stdout, &raw.stderr, raw.status.code())
        );
        for mode in ["tracing", "arc"] {
            for opt in ["-O1", "-O2"] {
                let binary = dir.0.join(format!("{name}-{mode}{opt}.exe"));
                checked(
                    Command::new(compiler)
                        .args(["build", "--gc", mode, opt])
                        .arg(&input)
                        .arg("-o")
                        .arg(&binary),
                );
                // Reuse verification retains freed storage for comparison;
                // checked ARC deliberately prohibits that diagnostic mode.
                let reuse_modes: &[&str] = if mode == "tracing" {
                    &["0", "1"]
                } else {
                    &["0"]
                };
                for reuse in reuse_modes {
                    let stress = if mode == "tracing" { "1" } else { "0" };
                    let output = Command::new(&binary)
                        .env("FWP_GC", if mode == "tracing" { "on" } else { "off" })
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_REUSE_VERIFY", reuse)
                        .output()
                        .unwrap();
                    // Retain trap programs for instruction and startup inspection,
                    // plus any unexpected result from the other cases.
                    if (name == "trap" && *reuse == "0")
                        || output.stdout != raw.stdout
                        || output.stderr != raw.stderr
                        || output.status.code() != raw.status.code()
                    {
                        if let Some(path) = std::env::var_os("FWP_CONTEXT_ARTIFACTS") {
                            let path = PathBuf::from(path);
                            std::fs::create_dir_all(&path).unwrap();
                            let stem = format!("each-{name}-{mode}{opt}");
                            std::fs::copy(&binary, path.join(format!("{stem}.exe"))).unwrap();
                            std::fs::copy(&input, path.join(format!("{stem}.fwp"))).unwrap();
                            checked(
                                Command::new(compiler)
                                    .args(["build", "--gc", mode, opt, "--emit-c"])
                                    .arg(&input)
                                    .arg("-o")
                                    .arg(path.join(format!("{stem}.c"))),
                            );
                            std::fs::write(
                                path.join(format!("{stem}.txt")),
                                format!("reuse={reuse}\n{output:?}\n"),
                            )
                            .unwrap();
                        }
                    }
                    assert_eq!(
                        (&output.stdout, &output.stderr, output.status.code()),
                        (&raw.stdout, &raw.stderr, raw.status.code()),
                        "{name}/{mode}/{opt}/{reuse}: {:?}",
                        output.status
                    );
                }
            }
        }
    }
}

#[test]
fn each_avoids_allocating_a_discarded_result_list() {
    let dir = Scratch::new("each-cost");
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let mut counts = std::collections::BTreeMap::new();
    for (name, function) in [("map", "each-before"), ("fold", "each")] {
        for count in [32, 128] {
            let source = format!("each-before : (a -> () ! e) -> List[a] -> () ! e\neach-before = map | flip compose ignore\nmain = range 0 {count} | run-state 0 ({function} (const (add 1) | modify)) | .1 | echo\n");
            let input = dir.0.join(format!("{name}-{count}.fwp"));
            let cfile = dir.0.join(format!("{name}-{count}.c"));
            let binary = dir.0.join(format!("{name}-{count}.exe"));
            std::fs::write(&input, &source).unwrap();
            let raw = checked(
                Command::new(compiler)
                    .args(["run", "--interp"])
                    .env("FWP_NO_OPT", "1")
                    .arg(&input),
            );
            assert_eq!(raw.stdout, format!("{count}\n").as_bytes());
            checked(
                Command::new(compiler)
                    .args(["build", "--emit-c", "-O2"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let mut code = std::fs::read_to_string(&cfile).unwrap();
            let declaration = "typedef uint64_t V;";
            assert_eq!(code.matches(declaration).count(), 1);
            code = code.replace(
                declaration,
                "typedef uint64_t V;\nstatic unsigned long long each_requests,each_bytes,each_calls;",
            );
            for (marker, condition) in [
                ("static inline void *fwp_alloc_init(size_t n) {", "1"),
                (
                    "static inline void *fwp_gc_alloc(size_t n, int leaf) {",
                    "leaf != 0",
                ),
            ] {
                assert_eq!(code.matches(marker).count(), 1);
                code = code.replace(
                    marker,
                    &format!("{marker} if({condition}){{each_requests++;each_bytes+=n;}}"),
                );
            }
            for marker in [
                "static V fwp_apply(V f, uint32_t n, V *args) {",
                "static V fwp_apply_owned(V f, uint32_t n, V *args) {",
                "static V fwp_apply_borrowed_span(V f, uint32_t n, V *args, uint32_t owned_start, uint32_t owned_len) {",
            ] {
                assert_eq!(code.matches(marker).count(), 1);
                code = code.replace(marker, &format!("{marker} each_calls++;"));
            }
            let finish = "    /* Ownership observation point: before runtime teardown. */\n";
            let main = code
                .find("static void *fwp_main_thread(void *arg) {")
                .unwrap();
            let (prefix, body) = code.split_at(main);
            assert_eq!(body.matches(finish).count(), 1);
            code = prefix.to_string() + &body.replace(finish, &format!("{finish}fprintf(stderr,\"each-cost %llu %llu %llu\\n\",each_requests,each_bytes,each_calls);\n"));
            fwp::cgen::compile_c(&code, &binary, "-O2").unwrap();
            let output = checked(
                Command::new(&binary)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            assert_eq!(output.stdout, raw.stdout);
            let stderr = String::from_utf8(output.stderr).unwrap();
            let values: Vec<i64> = stderr
                .trim()
                .strip_prefix("each-cost ")
                .unwrap()
                .split_whitespace()
                .map(|value| value.parse().unwrap())
                .collect();
            assert_eq!(values.len(), 3);
            counts.insert((name, count), values);
            if let Some(path) = std::env::var_os("FWP_CONTEXT_ARTIFACTS") {
                let path = PathBuf::from(path);
                std::fs::create_dir_all(&path).unwrap();
                std::fs::write(path.join(format!("each-{name}-{count}.fwp")), source).unwrap();
                std::fs::write(path.join(format!("each-{name}-{count}.c")), code).unwrap();
                std::fs::copy(&binary, path.join(format!("each-{name}-{count}.exe"))).unwrap();
            }
        }
    }
    let growth = |name, metric| counts[&(name, 128)][metric] - counts[&(name, 32)][metric];
    // The old implementation is an executable control: both versions print the
    // same count, but map must allocate at least one discarded node per element.
    assert!(growth("map", 0) - growth("fold", 0) >= 96, "{counts:?}");
    assert!(
        growth("map", 1) - growth("fold", 1) >= 24 * 96,
        "{counts:?}"
    );
    assert!(growth("fold", 0) <= 96, "{counts:?}");
    // Known callbacks must stay direct as the input grows. A heap saving alone
    // must not hide runtime callback dispatch on every element.
    assert_eq!(growth("fold", 2), 0, "{counts:?}");
    let mut report = String::from(
        "implementation\titerations\tmanaged_requests\trequested_bytes\tdynamic_calls\n",
    );
    for ((name, count), values) in counts {
        report.push_str(&format!(
            "{name}\t{count}\t{}\t{}\t{}\n",
            values[0], values[1], values[2]
        ));
    }
    eprint!("{report}");
    if let Some(path) = std::env::var_os("FWP_CONTEXT_ARTIFACTS") {
        std::fs::write(PathBuf::from(path).join("each-storage.tsv"), report).unwrap();
    }
}
