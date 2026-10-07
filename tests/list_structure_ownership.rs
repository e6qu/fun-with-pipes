//! Nested list structures own typed borrowed element references.
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
fn structural_list_aliases_under_collection() {
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
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
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
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
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
            if ["zip", "unzip", "chunks"]
                .iter()
                .any(|name| line.contains(&format!("return fwp_p_{name}_owned(l")))
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
    assert_eq!(changed, 3, "missing structural wrappers: {changed}");
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
            .args(["run", "--interp"])
            .arg(&src)
            .output()
            .unwrap();
        assert!(!reference.status.success());
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("invalid-{size}-{opt}"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            let out = Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .output()
                .unwrap();
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
    V pairs = ZIP_WRAPPER(xs, xs);
    V split = UNZIP_WRAPPER(pairs);
    V chunks = CHUNKS_WRAPPER(1, xs);
    if (*fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;
    if (OBJ(OBJ(pairs)->f[0])->f[0] != bits ||
        OBJ(OBJ(split)->f[0])->f[0] != bits ||
        OBJ(OBJ(chunks)->f[0])->f[0] != bits) return 2;
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
            .find(&format!("return fwp_p_{symbol}_owned({args});"))
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
