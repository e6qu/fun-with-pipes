//! Ordered maps and sets own typed keys and values across all boundaries.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/allocation_report.rs"]
mod allocation_report;

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
        let p = std::env::temp_dir().join(format!(
            "fwp-map-set-elements-{}-{name}",
            std::process::id()
        ));
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
fn map_set_elements_and_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
views : Map[String, String] -> (List[(String, String)], Map[String, String], Map[String, String], Map[String, String])
views = make { 0 = map.to-list, 1 = map.insert "a" "new", 2 = map.remove "b", 3 = id }
put : I64 -> Map[String, String] -> Map[String, String]
put = show | flip map.insert "grown"
grow : (I64, Map[String, String]) -> Step[(I64, Map[String, String]), Map[String, String]]
grow = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork put .0 .1 } | Again)
fetch : Map[String, String] -> String
fetch = map.get "a" | option.unwrap-or "fallback"
trace-value : String -> String ! {IO}
trace-value = fork const (concat "seen:") echo
base : Map[String, String]
base = [("a", "first"), ("b", "middle"), ("a", "last")] | map.from-list
sets : Set[String] -> (Set[String], Set[String], Set[String], Set[String])
sets = make { 0 = set.union (["b", "c"] | set.from-list),
    1 = set.intersect (["b", "c"] | set.from-list),
    2 = set.diff (["b", "c"] | set.from-list), 3 = id }
main = [
    base | views | echo,
    [("a", "owned" | concat "selected:")] | map.from-list | fetch | concat "used:" | echo,
    (129, map.empty) | loop grow | map.size | echo,
    (129, map.empty) | loop grow | map.remove "129" | map.size | echo,
    base | both map.keys map.values | echo,
    base | map.get "a" | option.map (concat "selected:") | echo,
    base | map.get "missing" | option.unwrap-or "fallback" | echo,
    base | map.remove "missing" | map.to-list | echo,
    base | map.map-values id | map.to-list | echo,
    base | map.map-values concat | map.values | map (apply "!") | echo,
    base | map.map-values trace-value | map.to-list | echo,
    base | map.update "a" id "unused" | map.to-list | echo,
    base | map.update "new" (concat "updated:") "default" | map.to-list | echo,
    base | map.update "a" (const "replacement") "unused" | map.to-list | echo,
    map.empty | map.insert "a" "only" | map.remove "a" | map.to-list | echo,
    [("a", "a b"), ("b", "c d")] | map (both .0 (.1 | words | array.from-list))
        | map.from-list | map.values | map array.to-list | echo,
    [("a", "a"), ("b", "b")] | map (both .0 (.1 | concat)) | map.from-list
        | map.get "a" | option.map (apply "!") | echo,
    "a b a" | words | set.from-list | sets | echo,
    "a b a" | words | set.from-list | both (set.insert "b") id | echo,
    "a b" | words | set.from-list | both (set.remove "b") id | echo,
    "a b" | words | set.from-list | set.remove "missing" | set.to-list | echo,
    [1, 2, 1] | set.from-list | set.to-list | echo,
    [] | map.from-list | map.to-list | echo,
    [] | set.from-list | set.union set.empty | set.to-list | echo,
    ["a"] | set.from-list | set.intersect set.empty | set.to-list | echo,
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
            let exe = dir
                .0
                .join(format!("aliases{opt}-{stack}"))
                .with_extension(std::env::consts::EXE_EXTENSION);
            checked(
                Command::new(fwp)
                    .args(["build"])
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
        let exe = dir
            .0
            .join(flag)
            .with_extension(std::env::consts::EXE_EXTENSION);
        checked(
            Command::new(fwp)
                .args(["build"])
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
fn map_set_elements_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
map-score : Map[String, String] -> I64
map-score = map.values | map string.length | sum
maps : I64 -> I64
maps = rem 3 | add 2 | flip repeat ("a b a" | words | both head last | both
    (.0 | option.unwrap-or "") (.1 | option.unwrap-or "")) | map.from-list
    | map.insert ("c" | concat "") ("value" | concat "")
    | map.update "a" (concat "updated:") "default" | map.map-values (concat "mapped:")
    | map.remove "c" | map-score
sets : I64 -> I64
sets = rem 3 | add 2 | flip take ("a b a c" | words) | set.from-list
    | set.union ("b d" | words | set.from-list) | set.insert "e"
    | set.intersect ("a b d e" | words | set.from-list) | set.remove "e"
    | set.diff ("d" | words | set.from-list) | set.to-list | length
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | fork add maps sets) } | Again)
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
    // Keep identical typed alias duplication and scratch cleanup; change only
    // whether the emitted wrappers share their structural result graphs.
    let mut changed = 0;
    let shared = owned
        .lines()
        .map(|line| {
            if [
                "map_from_list",
                "map_insert",
                "map_update",
                "map_map_values",
                "map_remove",
                "map_values",
                "set_from_list",
                "set_union",
                "set_insert",
                "set_intersect",
                "set_remove",
                "set_diff",
                "set_to_list",
            ]
            .iter()
            .any(|name| line.contains(&format!("return fwp_p_{name}_typed(l")))
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
    assert_eq!(changed, 13, "missing typed map/set wrappers: {changed}");
    assert_ne!(shared, owned);
    let mut freed = Vec::new();
    for (name, code) in [("shared", &shared), ("owned", &owned)] {
        let exe = dir
            .0
            .join(name)
            .with_extension(std::env::consts::EXE_EXTENSION);
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
        let out = checked(
            Command::new(&exe)
                .env("FWP_ALLOC_STATS", "1")
                .env("FWP_REUSE_VERIFY", "0"),
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
    eprintln!("typed map/set graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn actual_map_set_wrappers_preserve_scalar_bits_and_key_identity() {
    let dir = Scratch::new("native-probe");
    let src = dir.0.join("probe.fwp");
    let cfile = dir.0.join("probe.c");
    std::fs::write(
        &src,
        r#"
main = [
    [(1, 2)] | map.from-list | map.insert 3 4 | map.remove 1 | map.to-list | echo,
    [(1, 2)] | map.from-list | map.get 1 | echo,
    [1] | set.from-list | set.insert 2 | set.remove 1 | set.to-list | echo,
    [("a", "first"), ("a", "last")] | map.from-list | map.insert "a" "new" | map.to-list | echo,
    ["a", "a"] | set.from-list | set.to-list | echo,
] | ignore
"#,
    )
    .unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let mut probe = r#"
int main(void) {
#ifdef _WIN32
    /* Preserve exact test output bytes on native Windows too. */
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start();
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    V input = fwp_cons(fwp_tuple2(bits, bits), 0);
    V m = NUM_FROM(input);
    V selected = NUM_GET(bits, m);
    if (OBJ(selected)->f[0] != bits) return 2;
    m = NUM_INSERT(bits, bits, m);
    m = NUM_REMOVE(bits, m);
    DROP_NUM_MAP(m);
    V set = NUM_SET_FROM(fwp_cons(bits, 0));
    set = NUM_SET_INSERT(bits, set);
    set = NUM_SET_REMOVE(bits, set);
    DROP_NUM_SET(set);
    if (*fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;

    V first_key = fwp_rc_fresh(fwp_cstr("equal"));
    V later_key = fwp_rc_fresh(fwp_cstr("equal"));
    V first_value = fwp_rc_fresh(fwp_cstr("first"));
    V last_value = fwp_rc_fresh(fwp_cstr("last"));
    V replacement = fwp_rc_fresh(fwp_cstr("new"));
    V pairs = fwp_cons(fwp_tuple2(first_key, first_value),
        fwp_cons(fwp_tuple2(later_key, last_value), 0));
    V owned = REF_FROM(pairs);
    if (MAP(owned)->len != 1 || MAP(owned)->d[0] != first_key ||
        MAP(owned)->d[1] != last_value || *fwp_rc_slot(first_key) != 2 ||
        *fwp_rc_slot(later_key) != 1 || *fwp_rc_slot(first_value) != 1 ||
        *fwp_rc_slot(last_value) != 2) return 3;
    owned = REF_INSERT(later_key, replacement, owned);
    if (MAP(owned)->d[0] != first_key || MAP(owned)->d[1] != replacement ||
        *fwp_rc_slot(last_value) != 1 || *fwp_rc_slot(replacement) != 2) return 4;
    DROP_REF_MAP(owned);
    if (*fwp_rc_slot(first_key) != 1 || *fwp_rc_slot(later_key) != 1 ||
        *fwp_rc_slot(replacement) != 1) return 5;
    V keys = fwp_cons(first_key, fwp_cons(later_key, 0));
    V owned_set = REF_SET_FROM(keys);
    if (MAP(owned_set)->len != 1 || MAP(owned_set)->d[0] != first_key ||
        *fwp_rc_slot(first_key) != 2 ||
        *fwp_rc_slot(later_key) != 1) return 6;
    DROP_REF_SET(owned_set);
    if (*fwp_rc_slot(first_key) != 1 || *fwp_rc_slot(later_key) != 1) return 7;
    puts("typed map/set native ownership preserved");
    return 0;
}
"#
    .to_string();
    for (symbol, placeholder, references, drop_placeholder) in [
        ("map_from_list", "NUM_FROM", false, None),
        ("map_get", "NUM_GET", false, None),
        ("map_insert", "NUM_INSERT", false, Some("DROP_NUM_MAP")),
        ("map_remove", "NUM_REMOVE", false, None),
        ("set_from_list", "NUM_SET_FROM", false, None),
        ("set_insert", "NUM_SET_INSERT", false, Some("DROP_NUM_SET")),
        ("set_remove", "NUM_SET_REMOVE", false, None),
        ("map_from_list", "REF_FROM", true, None),
        ("map_insert", "REF_INSERT", true, Some("DROP_REF_MAP")),
        ("set_from_list", "REF_SET_FROM", true, Some("DROP_REF_SET")),
    ] {
        let marker = if references && symbol.starts_with("set_") {
            "fwp_map_ops){fwp_rc_dup, NULL,"
        } else if references {
            "fwp_map_ops){fwp_rc_dup, fwp_rc_dup,"
        } else {
            "fwp_map_ops){NULL, NULL,"
        };
        let (at, call) = emitted
            .match_indices(&format!("return fwp_p_{symbol}_typed(l"))
            .find_map(|(at, _)| {
                let call = emitted[at..].split(';').next().unwrap();
                call.contains(marker).then_some((at, call))
            })
            .unwrap_or_else(|| panic!("missing actual {symbol} wrapper, references {references}"));
        let wrapper = emitted[..at]
            .rsplit("static V ")
            .next()
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        probe = probe.replace(placeholder, wrapper);
        if let Some(drop_placeholder) = drop_placeholder {
            let ops = call
                .split("fwp_map_ops){")
                .nth(1)
                .unwrap()
                .split('}')
                .next()
                .unwrap();
            probe = probe.replace(drop_placeholder, ops.split(", ").nth(4).unwrap());
        }
    }
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let source = format!("{runtime}\n{probe}");
    for opt in ["-O1", "-O2"] {
        let exe = dir
            .0
            .join(opt)
            .with_extension(std::env::consts::EXE_EXTENSION);
        fwp::cgen::compile_c(&source, &exe, opt).unwrap();
        assert_eq!(
            checked(&mut Command::new(&exe)).stdout,
            b"typed map/set native ownership preserved\n"
        );
    }
}

fn save_map_evidence(name: &str, bytes: &[u8]) {
    if let Some(root) = std::env::var_os("FWP_MAP_FAILURE_ARTIFACTS") {
        let root = PathBuf::from(root);
        std::fs::create_dir_all(&root).unwrap();
        std::fs::write(root.join(name), bytes).unwrap();
    }
}

fn map_failure_source(dir: &Scratch, mode: &str) -> String {
    let src = dir.0.join("failures.fwp");
    let cfile = dir.0.join(format!("failures-{mode}.c"));
    std::fs::write(&src, include_str!("fixtures/map_failures.fwp")).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&src)
            .args(["--gc", mode, "--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    std::fs::read_to_string(cfile).unwrap()
}

fn map_failure_ops<'a>(emitted: &'a str, symbol: &str, prefix: &str) -> (&'a str, &'a str) {
    let call = emitted
        .lines()
        .find(|line| {
            line.contains(&format!("return fwp_p_{symbol}_typed(l"))
                && line.contains(&format!("fwp_map_ops){{{prefix}"))
        })
        .unwrap_or_else(|| panic!("missing typed {symbol}: {prefix}"));
    let ops = call.split("fwp_map_ops){").nth(1).unwrap();
    (ops.split('}').next().unwrap(), call)
}

fn map_failure_probe(emitted: &str) -> String {
    let (map, call) = map_failure_ops(emitted, "map_from_list", "fwp_rc_dup, fwp_rc_dup,");
    let key_type = call.split("}, ").nth(1).unwrap().trim_end_matches(");");
    let (set, _) = map_failure_ops(emitted, "set_from_list", "fwp_rc_dup, NULL,");
    let (column, _) = map_failure_ops(emitted, "map_values", "fwp_rc_dup, fwp_rc_dup,");
    let (pairs, _) = map_failure_ops(emitted, "map_to_list", "fwp_rc_dup, fwp_rc_dup,");
    let (get, _) = map_failure_ops(emitted, "map_get", "fwp_rc_dup, fwp_rc_dup,");
    let (scalar, _) = map_failure_ops(emitted, "map_map_values", "fwp_rc_dup, NULL,");
    let scalar_start = emitted.find("/* scalar :").unwrap();
    let scalar_id = emitted[scalar_start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let start = emitted.find("/* transform :").unwrap();
    let callback = emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let mut probe = include_str!("fixtures/map_failure_probe.c").to_string();
    for (name, value) in [
        ("SCALAR_OPS", format!("{{{scalar}}}")),
        ("SCALAR_CALLBACK", format!("PTR(&fc{scalar_id})")),
        ("MAP_OPS", format!("{{{map}}}")),
        ("SET_OPS", format!("{{{set}}}")),
        ("COLUMN_OPS", format!("{{{column}}}")),
        ("PAIR_OPS", format!("{{{pairs}}}")),
        ("KEY_TYPE", key_type.into()),
        ("DROP_STRING", map.split(", ").nth(2).unwrap().into()),
        ("DROP_MAP", map.split(", ").nth(4).unwrap().into()),
        ("DROP_SET", set.split(", ").nth(4).unwrap().into()),
        ("DROP_OPTION", get.split(", ").nth(5).unwrap().into()),
        ("CALLBACK", format!("PTR(&fc{callback})")),
    ] {
        probe = probe.replace(name, &value);
    }
    // Return real heap address bits as an I64. Typed output cleanup must leave
    // that independent string owner untouched, even after a later failure.
    let definition = format!("static V f{scalar_id}(V l0) {{");
    let start = emitted.find(&definition).unwrap();
    let end = start + emitted[start..].find('\n').unwrap() + 1;
    assert!(
        emitted[start..end].trim_end().ends_with('}'),
        "expected the scalar word wrapper on one line"
    );
    let mut emitted = emitted.to_string();
    emitted.replace_range(
        start..end,
        &format!("static V map_test_scalar(V);\n{definition} return map_test_scalar(l0); }}\n"),
    );
    let allocate = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
    assert_eq!(emitted.matches(allocate).count(), 1);
    let mut runtime = emitted.replace(
        allocate,
        "static inline void *map_test_allocate(size_t n, int kind) {",
    );
    let start = runtime
        .find("static inline void *map_test_allocate(")
        .unwrap();
    let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
    runtime.insert_str(end, "\nstatic inline void *fwp_heap_alloc(size_t n, int kind) { map_test_tick(); void *p = map_test_allocate(n, kind); map_test_record(p); return p; }\n");
    // The initialized-object allocator has its own fast path. Instrument it
    // once, including that path, without counting its slow path twice.
    let init = "static inline void *fwp_alloc_init(size_t n) {";
    assert_eq!(runtime.matches(init).count(), 1);
    runtime = runtime.replace(
        init,
        "static inline void *map_test_allocate_init(size_t n) {",
    );
    let start = runtime
        .find("static inline void *map_test_allocate_init(")
        .unwrap();
    let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
    let body = runtime[start..end].replace("fwp_heap_alloc(n, 0)", "map_test_allocate(n, 0)");
    runtime.replace_range(start..end, &body);
    runtime.insert_str(start + body.len(), "\nstatic inline void *fwp_alloc_init(size_t n) { map_test_tick(); void *p = map_test_allocate_init(n); map_test_record(p); return p; }\n");
    // Comparison can fail while sort scratch is live, and during compaction
    // after it is released. Exercise both cleanup boundaries independently.
    let compare = "static int fwp_cmp(V a, V b, const fwp_desc *d) {";
    assert_eq!(runtime.matches(compare).count(), 1);
    runtime = runtime.replace(compare, &format!("{compare} map_test_tick();"));
    runtime = runtime
        .replace(
            "static inline void fwp_rc_dup(V v) {",
            "static inline void fwp_rc_dup(V v) { map_test_tick();",
        )
        .replace(
            "static void fwp_mem_free(void *p) {",
            "static void fwp_mem_free(void *p) { map_test_release(p);",
        )
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    format!("static void map_test_no_release(void *p) {{ (void)p; }}\nstatic void map_test_tick(void);\nstatic void map_test_record(void *);\nstatic void map_test_release(void *);\n{runtime}\n{probe}")
}

#[test]
fn map_set_failures_release_partial_storage_and_preserve_aliases() {
    let dir = Scratch::new("partial-failure");
    for mode in ["arc", "tracing"] {
        let emitted = map_failure_source(&dir, mode);
        let source = map_failure_probe(&emitted);
        save_map_evidence(&format!("faults-{mode}.c"), source.as_bytes());
        for opt in ["-O1", "-O2"] {
            let exe = dir
                .0
                .join(format!("failures-{mode}{opt}"))
                .with_extension(std::env::consts::EXE_EXTENSION);
            fwp::cgen::compile_c(&source, &exe, opt).unwrap();
            save_map_evidence(
                &format!("faults-{mode}{opt}.bin"),
                &std::fs::read(&exe).unwrap(),
            );
            for poison in if mode == "arc" {
                &["0"][..]
            } else {
                &["0", "1"][..]
            } {
                let mut command = Command::new(&exe);
                command
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", poison);
                if mode != "arc" {
                    command.env("FWP_GC_STRESS", "1").env("FWP_GC_VERIFY", "1");
                }
                let out = checked(&mut command);
                save_map_evidence(
                    &format!("faults-{mode}{opt}-reuse-{poison}.txt"),
                    &out.stdout,
                );
                let stdout = String::from_utf8(out.stdout).unwrap();
                assert!(stdout.starts_with("22 map/set operations: "), "{stdout}");
                assert!(
                    stdout.ends_with(" injected failures cleaned; aliases preserved\n"),
                    "{stdout}"
                );
                print!("{mode} {opt} reuse={poison}: {stdout}");
            }
        }
        // A missing result owner must be detected independently of output checks.
        if mode == "arc" {
            let start = source.find("static V fwp_map_typed_copy(").unwrap();
            let end = start + source[start..].find("\n}\n").unwrap() + 3;
            let mut broken = source.clone();
            let body = source[start..end].replace(
                "fwp_value_owner owner = {result, ops->drop_map};",
                "fwp_value_owner owner = {result, NULL};",
            );
            assert_ne!(body, source[start..end]);
            broken.replace_range(start..end, &body);
            let exe = dir
                .0
                .join("missing-owner")
                .with_extension(std::env::consts::EXE_EXTENSION);
            fwp::cgen::compile_c(&broken, &exe, "-O1").unwrap();
            save_map_evidence("missing-result-owner.c", broken.as_bytes());
            save_map_evidence("missing-result-owner.bin", &std::fs::read(&exe).unwrap());
            let out = Command::new(exe)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(213),
                "{}",
                String::from_utf8_lossy(&out.stderr)
            );
            save_map_evidence("missing-result-owner.txt", &out.stderr);
            save_map_evidence(
                "missing-result-owner.status",
                out.status.code().unwrap().to_string().as_bytes(),
            );
            // Protecting the map alone is insufficient when an earlier scratch
            // allocation survives a comparison failure during sorting.
            let start = source.find("static V fwp_map_build_typed(").unwrap();
            let end = start + source[start..].find("\n}\n").unwrap() + 3;
            let body = source[start..end].replace(
                "fwp_scratch_protect(&tk, &tk_cleanup);",
                "fwp_cleanup_push(&tk_cleanup, map_test_no_release, &tk);",
            );
            assert_ne!(body, source[start..end]);
            let mut broken = source.clone();
            broken.replace_range(start..end, &body);
            let exe = dir
                .0
                .join("missing-scratch-owner")
                .with_extension(std::env::consts::EXE_EXTENSION);
            fwp::cgen::compile_c(&broken, &exe, "-O1").unwrap();
            save_map_evidence("missing-scratch-owner.c", broken.as_bytes());
            save_map_evidence("missing-scratch-owner.bin", &std::fs::read(&exe).unwrap());
            let out = Command::new(exe)
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0")
                .output()
                .unwrap();
            assert_eq!(
                out.status.code(),
                Some(213),
                "{}",
                String::from_utf8_lossy(&out.stderr)
            );
            save_map_evidence("missing-scratch-owner.txt", &out.stderr);
            save_map_evidence(
                "missing-scratch-owner.status",
                out.status.code().unwrap().to_string().as_bytes(),
            );
        }
    }
}

#[test]
fn map_callbacks_can_change_value_types_and_fail_without_leaking() {
    let dir = Scratch::new("callback-failure");
    let source = dir.0.join("failures.fwp");
    std::fs::write(&source, include_str!("fixtures/map_failures.fwp")).unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["run", "--interp"])
            .arg(&source)
            .env("FWP_NO_OPT", "1"),
    );
    for mode in ["arc", "tracing"] {
        save_map_evidence("interpreter.txt", &reference.stdout);
        let mut emitted = map_failure_source(&dir, mode);
        if mode == "arc" {
            let finish = "\n    /* Ownership observation point: before runtime teardown. */\n";
            assert_eq!(emitted.matches(finish).count(), 1);
            emitted = emitted.replace(finish, &format!("{finish}\n    if (0 != fwp_heap.live) {{ fprintf(stderr, \"map callback storage leaked: %lld bytes\\n\", (long long)(fwp_heap.live)); abort(); }}\n"));
        }
        save_map_evidence(&format!("callbacks-{mode}.c"), emitted.as_bytes());
        for opt in ["-O1", "-O2"] {
            let exe = dir
                .0
                .join(format!("callbacks-{mode}{opt}"))
                .with_extension(std::env::consts::EXE_EXTENSION);
            fwp::cgen::compile_c(&emitted, &exe, opt).unwrap();
            save_map_evidence(
                &format!("callbacks-{mode}{opt}.bin"),
                &std::fs::read(&exe).unwrap(),
            );
            let mut command = Command::new(&exe);
            command
                .env_remove("FWP_GC")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_GC_VERIFY", "0")
                .env("FWP_REUSE_VERIFY", "0");
            if mode != "arc" {
                command
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", "1");
            }
            let output = checked(&mut command);
            assert_eq!(output.stdout, reference.stdout);
            save_map_evidence(&format!("callbacks-{mode}{opt}.txt"), &output.stdout);
            save_map_evidence(&format!("callbacks-{mode}{opt}.stderr"), &output.stderr);
        }
    }
}

#[test]
fn compact_sets_preserve_values_and_request_only_key_storage() {
    let dir = Scratch::new("compact");
    let src = dir.0.join("sets.fwp");
    std::fs::write(&src, include_str!("fixtures/compact_sets.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = include_str!("fixtures/compact_sets.out").as_bytes();
    for optimize in ["0", "1"] {
        let output = checked(
            Command::new(compiler)
                .env("FWP_NO_OPT", optimize)
                .args(["run", "--interp"])
                .arg(&src),
        );
        assert_eq!(
            output.stdout, reference,
            "interpreter FWP_NO_OPT={optimize}"
        );
    }
    for mode in ["arc", "tracing"] {
        let cfile = dir.0.join("sets.c");
        checked(
            Command::new(compiler)
                .args(["build", "--emit-c", "--gc", mode])
                .arg(&src)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(&cfile).unwrap();
        let probe_cfile = dir.0.join("builder.c");
        checked(
            Command::new(compiler)
                .args(["build", "--emit-c", "--gc", mode, "--fn", "build-set"])
                .arg(&src)
                .arg("-o")
                .arg(&probe_cfile),
        );
        let builder = std::fs::read_to_string(&probe_cfile).unwrap();
        let start = builder
            .find("/* build-set :")
            .expect("selected set builder missing");
        let function = builder[start..]
            .split("static V ")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let allocation = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
        assert_eq!(builder.matches(allocation).count(), 1);
        let measured = builder
            .replace(
                "typedef uint64_t V;",
                "typedef uint64_t V;\nstatic size_t set_last_request;",
            )
            .replace(allocation, &format!("{allocation} set_last_request = n;"))
            .replace(
                "int main(int argc, char **argv)",
                "int original_main(int argc, char **argv)",
            );
        let measured = format!(
            "{measured}\n{}",
            include_str!("fixtures/compact_set_storage.c").replace("BUILD_SET", function)
        );
        for opt in ["-O0", "-O2"] {
            let exe = dir
                .0
                .join("sets")
                .with_extension(std::env::consts::EXE_EXTENSION);
            let verify = if mode == "arc" { "0" } else { "1" };
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            let output = checked(
                Command::new(&exe)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", verify)
                    .env("FWP_GC_VERIFY", verify)
                    .env("FWP_REUSE_VERIFY", verify),
            );
            assert_eq!(output.stdout, reference, "{mode}/{opt}");
            fwp::cgen::compile_c(&measured, &exe, opt).unwrap();
            let output = checked(
                Command::new(&exe)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0"),
            );
            save_map_evidence(&format!("compact-{mode}{opt}.txt"), &output.stdout);
            save_map_evidence(&format!("compact-{mode}{opt}.c"), measured.as_bytes());
            save_map_evidence(
                &format!("compact-{mode}{opt}.exe"),
                &std::fs::read(&exe).unwrap(),
            );
            if std::env::var_os("FWP_MAP_FAILURE_ARTIFACTS").is_some() {
                let disassembly = if cfg!(target_os = "macos") {
                    checked(Command::new("otool").arg("-tvV").arg(&exe))
                } else if cfg!(target_os = "windows") {
                    checked(Command::new("llvm-objdump").arg("-d").arg(&exe))
                } else {
                    checked(Command::new("objdump").arg("-d").arg(&exe))
                };
                save_map_evidence(&format!("compact-{mode}{opt}.asm"), &disassembly.stdout);
            }
            print!("{mode}/{opt}: {}", String::from_utf8_lossy(&output.stdout));
            if mode == "arc" && opt == "-O0" {
                // Restoring one wasted word per key must fail the request check.
                let old = "fwp_alloc(sizeof(fwp_map) + columns * len * sizeof(V))";
                assert_eq!(measured.matches(old).count(), 1);
                let wasteful = measured.replace(
                    old,
                    "fwp_alloc(sizeof(fwp_map) + (columns + 1) * len * sizeof(V))",
                );
                fwp::cgen::compile_c(&wasteful, &exe, opt).unwrap();
                save_map_evidence("compact-wasted-slot-control.c", wasteful.as_bytes());
                save_map_evidence(
                    "compact-wasted-slot-control.bin",
                    &std::fs::read(&exe).unwrap(),
                );
                let failed = Command::new(&exe)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(failed.status.code(), Some(211), "{failed:?}");
                save_map_evidence("compact-wasted-slot-control.txt", &failed.stderr);
                save_map_evidence(
                    "compact-wasted-slot-control.status",
                    failed.status.code().unwrap().to_string().as_bytes(),
                );
            }
        }
    }
}

#[test]
fn map_sort_scratch_does_not_overlap_result_storage() {
    let dir = Scratch::new("sort-storage");
    for mode in ["arc", "tracing"] {
        let source = map_failure_source(&dir, mode);
        let allocation = "static inline void *fwp_heap_alloc(size_t n, int kind) {";
        assert_eq!(source.matches(allocation).count(), 1);
        let mut measured = source.replace(
            "typedef uint64_t V;",
            "typedef uint64_t V;\nstatic int map_storage_active;\nstatic double map_storage_start, map_storage_peak;\nstatic void map_storage_sample(void);",
        ).replace(allocation, "static inline void *map_storage_allocate(size_t n, int kind) {");
        let start = measured
            .find("static inline void *map_storage_allocate(")
            .unwrap();
        let end = start + measured[start..].find("\n}\n").unwrap() + 3;
        measured.insert_str(end, "\nstatic inline void *fwp_heap_alloc(size_t n, int kind) { void *p = map_storage_allocate(n, kind); map_storage_sample(); return p; }\n");
        measured = measured.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        measured.push_str(include_str!("fixtures/map_sort_storage.c"));
        let start = measured.find("static V fwp_map_build_typed(").unwrap();
        let end = start + measured[start..].find("\n}\n").unwrap() + 3;
        let body = &measured[start..end];
        let release = "    fwp_scratch_finish(&tk, &tk_cleanup);\n";
        assert_eq!(body.matches(release).count(), 1);
        let late = body.replace(release, "").replace(
            "    fwp_value_finish(&owner, &cleanup);\n",
            &format!("    fwp_value_finish(&owner, &cleanup);\n{release}"),
        );
        let mut control = measured.clone();
        control.replace_range(start..end, &late);
        for (label, code, status) in [("ordinary", &measured, 0), ("late-release", &control, 241)] {
            save_map_evidence(&format!("sort-storage-{mode}-{label}.c"), code.as_bytes());
            for opt in ["-O1", "-O2"] {
                let exe = dir
                    .0
                    .join("sort-storage")
                    .with_extension(std::env::consts::EXE_EXTENSION);
                fwp::cgen::compile_c(code, &exe, opt).unwrap();
                save_map_evidence(
                    &format!("sort-storage-{mode}-{label}{opt}.bin"),
                    &std::fs::read(&exe).unwrap(),
                );
                for kind in ["map", "set"] {
                    let out = Command::new(&exe)
                        .arg(kind)
                        .env_remove("FWP_GC")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    assert_eq!(
                        out.status.code(),
                        Some(status),
                        "{mode}/{label}/{opt}/{kind}: {out:?}"
                    );
                    assert!(out.stderr.is_empty(), "{out:?}");
                    save_map_evidence(
                        &format!("sort-storage-{mode}-{label}{opt}-{kind}.txt"),
                        &out.stdout,
                    );
                    save_map_evidence(
                        &format!("sort-storage-{mode}-{label}{opt}-{kind}.status"),
                        out.status.code().unwrap().to_string().as_bytes(),
                    );
                    println!(
                        "{mode}/{label}/{opt}/{}",
                        String::from_utf8(out.stdout).unwrap().trim()
                    );
                }
            }
        }
    }
}
