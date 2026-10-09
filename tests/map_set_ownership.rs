//! Ordered maps and sets own typed keys and values across all boundaries.
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
    fwp_gc_start(__builtin_frame_address(0));
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
    ] {
        let marker = if references {
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
            probe = probe.replace(drop_placeholder, ops.rsplit(", ").next().unwrap());
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
            b"typed map/set native ownership preserved\n"
        );
    }
}
