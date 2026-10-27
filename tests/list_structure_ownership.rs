//! Nested list structures own typed borrowed element references.
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
        let p =
            std::env::temp_dir().join(format!("fwp-list-structure-{}-{name}", std::process::id()));
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
fn structural_list_aliases_preserve_values() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
functions : List[String -> String] -> (List[String], List[List[String]], List[String])
functions = make {
    0 = zip [concat "left", concat "right"] | map (make {0 = .0 | apply "!", 1 = .1 | apply "?"}) | unzip | .0,
    1 = chunks 2 | map (map (apply ".")),
    2 = map (apply ":"),
}
main = [
    "a b c" | words | both (zip ("x y" | words) | unzip) id | echo,
    "a b c" | words | both (chunks 2) id | echo,
    "a b c" | words | chunks 1 | flatten | map (concat "chunk:") | echo,
    "a b c" | words | chunks 9223372036854775807 | echo,
    ["a", "b", "c"] | map concat | functions | echo,
    ["a b", "c d"] | map words | zip [["x"], ["y"]] | unzip | echo,
    [1, 2, 3] | zip [True, False] | unzip | echo,
    [1, 2] | zip [] | unzip | echo,
    [] | zip ["a"] | unzip | echo,
    [] | chunks 3 | echo,
    [1, 2, 3] | chunks 2 | echo,
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
    let cfile = dir.0.join("forced-copy.c");
    checked(
        Command::new(fwp)
            .args(["build", "--emit-c"])
            .arg(&src)
            .arg("-o")
            .arg(&cfile),
    );
    let code = format!(
        "#define FWP_NO_REUSE 1\n{}",
        std::fs::read_to_string(cfile).unwrap()
    );
    let exe = dir.0.join("forced-copy.exe");
    fwp::cgen::compile_c(&code, &exe, "-O1").unwrap();
    assert_eq!(checked(&mut Command::new(&exe)).stdout, reference.stdout);
}

#[test]
fn structural_lists_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
score : List[String] -> I64
score = fork add length (head | option.map string.length | option.unwrap-or 0)
size : I64 -> I64
size = rem 3 | add 1 | flip take ("a b c d e f" | words) | zip ("g h i j" | words) | unzip | .0 | chunks 2 | flatten | score
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
    // Keep identical typed alias duplication and scratch cleanup; change only
    // whether each result graph has one extra owner that is never released.
    let mut changed = 0;
    let retained = owned
        .lines()
        .map(|line| {
            if ["zip", "unzip", "chunks"]
                .iter()
                .any(|name| line.contains(&format!("return fwp_p_{name}_owned(l")))
            {
                changed += 1;
                line.replace("return fwp_p_", "V retained = fwp_p_")
                    .replace(");", "); fwp_rc_dup(retained); return retained;")
            } else {
                line.to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert_eq!(changed, 3, "missing structural wrappers: {changed}");
    assert_ne!(retained, owned);
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
    eprintln!("structural list graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn invalid_chunk_sizes_preserve_failure_order() {
    let dir = Scratch::new("invalid");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for size in [0, -1] {
        let src = dir.0.join(format!("invalid-{size}.fwp"));
        std::fs::write(&src, format!("main = [1, 2] | chunks {size} | echo\n")).unwrap();
        let reference = Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src)
            .output()
            .unwrap();
        assert!(!reference.status.success());
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("invalid-{size}-{opt}"));
            checked(
                Command::new(fwp)
                    .args(["build"])
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            let out = Command::new(&exe).output().unwrap();
            assert_eq!(out.status.code(), reference.status.code());
            assert_eq!(out.stdout, reference.stdout);
            assert_eq!(out.stderr, reference.stderr);
        }
    }
}

#[test]
fn scalar_structural_fields_do_not_count_address_shaped_bits() {
    let dir = Scratch::new("scalar");
    let src = dir.0.join("scalar.fwp");
    let cfile = dir.0.join("scalar.c");
    std::fs::write(
        &src,
        "main = [1] | zip [2] | unzip | .0 | chunks 1 | echo\n",
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
static void drop_scalar_nodes(V xs) {
    while(xs && fwp_rc_release_last(xs)) {
        V next=OBJ(xs)->f[1];fwp_rc_free_obj(xs);xs=next;
    }
}
static void drop_pair_nodes(V xs) {
    while(xs && fwp_rc_release_last(xs)) {
        V next=OBJ(xs)->f[1];fwp_rc_free_obj(OBJ(xs)->f[0]);fwp_rc_free_obj(xs);xs=next;
    }
}
static void drop_nested_nodes(V xs) {
    while(xs && fwp_rc_release_last(xs)) {
        V next=OBJ(xs)->f[1];drop_scalar_nodes(OBJ(xs)->f[0]);fwp_rc_free_obj(xs);xs=next;
    }
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start();size_t baseline=fwp_heap.live;
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    V xs = fwp_rc_fresh(fwp_cons(bits, 0));
    V pairs = ZIP_WRAPPER(xs, xs);
    V split = UNZIP_WRAPPER(pairs);
    V chunks = CHUNKS_WRAPPER(1, xs);
    if (*fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;
    if (OBJ(OBJ(pairs)->f[0])->f[0] != bits ||
        OBJ(OBJ(split)->f[0])->f[0] != bits ||
        OBJ(OBJ(chunks)->f[0])->f[0] != bits) return 2;
    drop_pair_nodes(pairs);drop_nested_nodes(chunks);
    drop_scalar_nodes(OBJ(split)->f[0]);drop_scalar_nodes(OBJ(split)->f[1]);fwp_rc_free_obj(split);
    drop_scalar_nodes(xs);fwp_rc_free_obj(bits);
    if(fwp_heap.live!=baseline)return 3;
    puts("scalar structural ownership preserved");
    return 0;
}
"#
    .to_string();
    for (symbol, placeholder, args) in [
        ("unzip", "UNZIP_WRAPPER(", "l0, NULL, NULL"),
        ("zip", "ZIP_WRAPPER(", "l0, l1, NULL, NULL"),
        ("chunks", "CHUNKS_WRAPPER(", "l0, l1, NULL"),
    ] {
        let boundary = emitted
            .find(&format!("return fwp_p_{symbol}_owned({args}"))
            .unwrap_or_else(|| panic!("missing actual scalar {symbol} wrapper"));
        let wrapper = emitted[..boundary]
            .rsplit("static V ")
            .next()
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        probe = probe.replace(placeholder, &format!("{wrapper}("));
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
            b"scalar structural ownership preserved\n"
        );
    }
}
