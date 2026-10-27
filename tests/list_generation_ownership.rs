//! Generated list nodes own repeated aliases or fresh numeric payloads.
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
            std::env::temp_dir().join(format!("fwp-list-generation-{}-{name}", std::process::id()));
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
fn generated_lists_and_repeated_aliases_preserve_values() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
views : String -> (List[String], String, List[List[String]])
views = make { 0 = repeat 5, 1 = id, 2 = repeat 3 | chunks 2 }
functions : (String -> String) -> (List[String], String)
functions = make { 0 = repeat 601 | map (apply "!"), 1 = apply "?" }
main = [
    "allocated value" | concat "!" | views | echo,
    [concat "function:"] | map functions | echo,
    "a b" | words | repeat 3 | flatten | echo,
    "héllo" | string.to-bytes | repeat 4 | map bytes.length | echo,
    "unused" | concat "!" | repeat 0 | echo,
    "unused" | concat "!" | repeat -1 | echo,
    2 | repeat 4 | echo,
    range 3 3 | echo,
    range 5 -3 | echo,
    range -3 4 | echo,
    range 124i8 127i8 | echo,
    range 253u8 255u8 | echo,
    range 9223372036854775804 9223372036854775807 | echo,
    range 18446744073709551613u64 18446744073709551615u64 | echo,
    range 170141183460469231731687303715884105724i128 170141183460469231731687303715884105727i128 | echo,
    range 340282366920938463463374607431768211452u128 340282366920938463463374607431768211455u128 | echo,
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
fn generated_lists_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
score : List[String] -> I64
score = fork add length (head | option.map string.length | option.unwrap-or 0)
size : I64 -> I64
size = make { 0 = rem 4 | add 2, 1 = rem 3 | show | concat "value:" } | uncurry repeat | score
numbers : I64 -> I64
numbers = rem 5 | add 3 | range 0 | reverse | sum
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | fork add size numbers) } | Again)
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
            if ["repeat", "range"]
                .iter()
                .any(|name| line.contains(&format!("return fwp_p_{name}_owned(")))
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
    assert_eq!(changed, 2, "missing generated list wrappers: {changed}");
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
    eprintln!("generated list graph MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn scalar_list_generation_does_not_count_address_shaped_bits() {
    let dir = Scratch::new("scalar");
    let src = dir.0.join("scalar.fwp");
    let cfile = dir.0.join("scalar.c");
    std::fs::write(
        &src,
        "main = [1 | repeat 2 | echo, range 2 4 | echo] | ignore\n",
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
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start();size_t baseline=fwp_heap.live;
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    V repeated = REPEAT_WRAPPER(601, bits);
    V numbers = RANGE_WRAPPER(bits, bits + 1);
    if (*fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;
    if (fwp_list_len(repeated) != 601 || OBJ(repeated)->f[0] != bits ||
        fwp_list_len(numbers) != 1 || OBJ(numbers)->f[0] != bits) return 2;
    drop_scalar_nodes(repeated);drop_scalar_nodes(numbers);fwp_rc_free_obj(bits);
    if(fwp_heap.live!=baseline)return 3;
    puts("scalar list generation preserved");
    return 0;
}
"#
    .to_string();
    for (needle, placeholder) in [
        ("return fwp_p_repeat_owned(l0, l1, NULL,", "REPEAT_WRAPPER"),
        ("return fwp_p_range_owned(", "RANGE_WRAPPER"),
    ] {
        // Numeric kinds are emitted as an integer literal; find the range
        // boundary independently of its kind's enum value.
        let boundary = emitted.find(needle).expect("missing actual scalar wrapper");
        let wrapper = emitted[..boundary]
            .rsplit("static V ")
            .next()
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        probe = probe.replace(placeholder, wrapper);
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
            b"scalar list generation preserved\n"
        );
    }
}
