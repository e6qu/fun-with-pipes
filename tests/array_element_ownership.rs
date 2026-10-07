//! Array storage owns typed elements across copies, aliases and callbacks.
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
            let drop = call.rsplit(", ").next().unwrap().trim_end_matches(')');
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
