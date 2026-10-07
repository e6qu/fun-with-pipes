//! Sort-by borrows synchronous callbacks and releases owned keys by type.
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
            std::env::temp_dir().join(format!("fwp-sort-callback-{}-{name}", std::process::id()));
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
fn sort_keys_and_aliases_under_collection() {
    let dir = Scratch::new("aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
trace : String -> String ! {IO}
trace = both echo id | .1
views : List[String] -> (List[String], List[String], List[String])
views = make { 0 = sort-by id, 1 = sort-by (concat "prefix:"), 2 = id }
main = [
    ["b", "a", "b", "héllo", "", "a"] | views | echo,
    "c b a b c" | words | sort-by trace | echo,
    "ccc a bb dd" | words | sort-by string.length | echo,
    "ccc a bb dd" | words | sort-by (const "equal") | echo,
    "c b a" | words | sort-by (concat "!") | map (concat "value:") | echo,
    ["b a", "a b", "b a", ""] | map words | sort-by id | flatten | echo,
    ["c", "a", "b"] | map concat | sort-by (apply "!") | map (apply "?") | echo,
    "ccc a bb" | words | sort-by (make { 0 = string.length, 1 = id }) | echo,
    [3, 1, 3, 2, 1] | sort-by id | echo,
    ["one"] | sort-by trace | echo,
    [] | sort-by trace | echo,
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
    // The conservative compilation switches must retain the same observable
    // callback behavior and use their matching runtime function signatures.
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
fn sort_keys_and_results_are_released_without_tracing() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("loop.fwp");
    std::fs::write(
        &src,
        r#"
score : List[String] -> I64
score = fork add length (head | option.map string.length | option.unwrap-or 0)
size : I64 -> I64
size = rem 4 | add 1 | flip take ("c b a d" | words) | sort-by (concat "key:") | score
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
    // Restore result sharing only in the emitted monomorphic wrappers.
    // Scalar bits never become references in either version.
    let mut changed = 0;
    let shared = owned
        .lines()
        .map(|line| {
            if line.contains("V result = fwp_p_sort_by_copied(l") {
                changed += 1;
                line.replace("return result;", "return fwp_rc_shared(result);")
            } else {
                line.to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert!(changed == 1, "missing sort-by boundary: {changed}");
    assert_ne!(shared, owned);
    // Keep owned output but remove only typed key destruction. Raw drops
    // reduce outer counts without destroying the last owned key allocation.
    let kept_keys = owned.replace("drop_key(owned_key);", "fwp_rc_drop(owned_key);");
    assert_ne!(kept_keys, owned);
    let mut freed = Vec::new();
    for (name, code) in [
        ("shared", &shared),
        ("kept-keys", &kept_keys),
        ("owned", &owned),
    ] {
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
    eprintln!("sort callback graph MiB freed by counts: {freed:?}");
    assert!(freed[2] > freed[0] + 0.3, "{freed:?}");
    assert!(freed[2] > freed[1] + 0.3, "{freed:?}");
}

#[test]
fn scalar_key_bits_do_not_release_pointed_to_values() {
    let dir = Scratch::new("scalar");
    let src = dir.0.join("scalar.fwp");
    let cfile = dir.0.join("scalar.c");
    std::fs::write(&src, "main = [2, 1, 3] | sort-by id | echo\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let boundary = emitted.find("V result = fwp_p_sort_by_copied(l").unwrap();
    let body = emitted[boundary..].lines().next().unwrap();
    assert!(
        body.contains(", NULL);"),
        "scalar key has a release function"
    );
    // Invoke the actual emitted monomorphic wrapper, with scalar words whose
    // bits are a real counted allocation address. Guessing pointer ownership
    // would incorrectly release or share that unrelated allocation.
    let wrapper = emitted[..boundary]
        .rsplit("static V ")
        .next()
        .unwrap()
        .split('(')
        .next()
        .unwrap();
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static V scalar_key_entry(V *args) { return args[0]; }
static void scalar_key_args(V *args, uint32_t start, uint32_t n) {
    (void)args; (void)start; (void)n;
}
static void scalar_key_caps(V f, int duplicate) { (void)f; (void)duplicate; }
static const fwp_owned_fninfo scalar_owned = {scalar_key_entry, scalar_key_caps, scalar_key_args};
static const fwp_fninfo scalar_fns[] = {{1, scalar_key_entry, "scalar key", &scalar_owned}};
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns = scalar_fns;
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    V xs = fwp_cons(bits, fwp_cons(bits, 0));
    fwp_clo callback = {0, 0};
    V result = WRAPPER(PTR(&callback), xs);
    if (*fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;
    if (fwp_list_len(result) != 2 || OBJ(result)->f[0] != bits ||
        OBJ(OBJ(result)->f[1])->f[0] != bits) return 2;
    puts("scalar key ownership preserved");
    return 0;
}
"#
    .replace("WRAPPER", wrapper);
    let source = format!("{runtime}\n{probe}");
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        fwp::cgen::compile_c(&source, &exe, opt).unwrap();
        assert_eq!(
            checked(&mut Command::new(&exe)).stdout,
            b"scalar key ownership preserved\n"
        );
    }
}
