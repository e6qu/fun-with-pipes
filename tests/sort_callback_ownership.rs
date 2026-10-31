//! Sort-by borrows synchronous callbacks and releases owned keys by type.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/allocation_report.rs"]
mod allocation_report;

#[path = "support/list_copy.rs"]
mod list_copy;

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
fn sort_keys_and_aliases_preserve_values() {
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
    [("b", 2), ("a", 2), ("c", 1)] | sort-by (both (.1 | neg) .0) | echo,
    [("b", 2), ("a", 2), ("c", 1)] | both (sort-by (both (.1 | neg) .0)) id | echo,
    ["one"] | sort-by trace | echo,
    [] | sort-by trace | echo,
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
    // Forced copies preserve the same callback results and typed ownership.
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
    // Deliberately retain one extra result owner in the emitted typed wrappers.
    // Scalar bits never become references in either version.
    let mut changed = 0;
    let retained = owned
        .lines()
        .map(|line| {
            if line.contains("V result = fwp_p_sort_by_copied(l") {
                changed += 1;
                line.replace("return result;", "fwp_rc_dup(result); return result;")
            } else {
                line.to_string()
            }
        })
        .collect::<Vec<_>>()
        .join("\n");
    assert!(changed == 1, "missing sort-by boundary: {changed}");
    assert_ne!(retained, owned);
    // Keep owned output but remove only typed key destruction. Raw drops
    // reduce outer counts without destroying the last owned key allocation.
    let kept_keys = owned.replace(
        "fwp_map_owner owner = {keys, 0, 0, drop_key, NULL};",
        "fwp_map_owner owner = {keys, 0, 0, drop_key ? fwp_rc_drop : NULL, NULL};",
    );
    assert_ne!(kept_keys, owned);
    let mut freed = Vec::new();
    for (name, code) in [
        ("retained", &retained),
        ("kept-keys", &kept_keys),
        ("owned", &owned),
    ] {
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
            .args(["build"])
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    let emitted = std::fs::read_to_string(&cfile).unwrap();
    let boundary = emitted.find("V result = fwp_p_sort_by_copied(l").unwrap();
    let body = emitted[boundary..].lines().next().unwrap();
    assert!(
        body.contains(", NULL, &d"),
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
static void drop_scalar_nodes(V xs) {
    while(xs && fwp_rc_release_last(xs)) {
        V next=OBJ(xs)->f[1];fwp_rc_free_obj(xs);xs=next;
    }
}
static V scalar_key_entry(V *args) { return args[0]; }
static void scalar_key_args(V *args, uint32_t start, uint32_t n) {
    (void)args; (void)start; (void)n;
}
static void scalar_key_caps(V f, int duplicate) { (void)f; (void)duplicate; }
static const fwp_owned_fninfo scalar_owned = {scalar_key_entry, scalar_key_caps, scalar_key_args, NULL};
static const fwp_fninfo scalar_fns[] = {{1, scalar_key_entry, "scalar key", &scalar_owned}};
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start();size_t baseline=fwp_heap.live;
    fwp_fns = scalar_fns;
    V bits = fwp_rc_fresh(fwp_cstr("numeric bits"));
    V xs = fwp_rc_fresh(fwp_cons(bits, fwp_rc_fresh(fwp_cons(bits, 0))));
    fwp_clo callback = {0, 0};
    V result = WRAPPER(PTR(&callback), xs);
    if (*fwp_rc_slot(bits) != 1 || STR(bits)->len != 12) return 1;
    if (fwp_list_len(result) != 2 || OBJ(result)->f[0] != bits ||
        OBJ(OBJ(result)->f[1])->f[0] != bits) return 2;
    drop_scalar_nodes(result);drop_scalar_nodes(xs);fwp_rc_free_obj(bits);
    if(fwp_heap.live!=baseline)return 3;
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

#[test]
fn specialized_sort_keys_preserve_capture_order_failure_and_cancellation() {
    let dir = Scratch::new("captures");
    let source = dir.0.join("captures.fwp");
    let cfile = dir.0.join("captures.c");
    std::fs::write(&source, include_str!("fixtures/sort_key_captures.fwp")).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    assert!(reference.stderr.is_empty());
    let expected = String::from_utf8_lossy(&reference.stdout);
    assert_eq!(
        expected.lines().filter(|line| *line == "prefix:").count(),
        2
    );
    for stack in ["0", "1"] {
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", stack)
                .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        assert!(
            emitted.contains("/* sort-by-fn :"),
            "known sort keys were not specialized"
        );
        for opt in ["-O1", "-O2"] {
            let executable = dir.0.join(format!("captures-{stack}{opt}.exe"));
            fwp::cgen::compile_c(&emitted, &executable, opt).unwrap();
            let actual = checked(Command::new(&executable).env("FWP_ALLOC_STATS", "1"));
            assert_eq!(actual.stdout, reference.stdout, "{stack}/{opt}");
            let stats = String::from_utf8_lossy(&actual.stderr);
            let report = allocation_report::parse(&stats).expect("allocation report");
            assert_eq!(report.live, 0, "{stack}/{opt}: {report:?}");
        }
    }
}

#[test]
fn inline_keys_preserve_fields_order_and_partial_cleanup() {
    let dir = Scratch::new("inline-keys");
    let source = dir.0.join("keys.fwp");
    let cfile = dir.0.join("keys.c");
    std::fs::write(&source, include_str!("fixtures/inline_sort_keys.fwp")).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    let mut failures = Vec::new();
    for typed in ["0", "1"] {
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_TYPED_ABI", typed)
                .args(["build", "--memory", "dynamic", "--emit-c", "-O2"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let ordinary = std::fs::read_to_string(&cfile).unwrap();
        assert!(
            ordinary.contains("static V fwp_sort_keys"),
            "typed key selection"
        );
        checked(
            Command::new(fwp)
                .env_remove("FWP_NO_OPT")
                .env("FWP_TYPED_ABI", typed)
                .args([
                    "build", "--fn", "probe", "--memory", "dynamic", "--emit-c", "-O2",
                ])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let mut emitted = std::fs::read_to_string(&cfile).unwrap();
        let marker = emitted.find("/* key :").expect("exported key");
        let worker = emitted[marker..]
            .split(" w")
            .nth(1)
            .unwrap()
            .split('(')
            .next()
            .unwrap();
        let kernel = format!("fwp_sort_keys{worker}");
        let start = emitted
            .find(&format!("static V {kernel}(V xs) {{"))
            .unwrap();
        let end = start + emitted[start..].find("\n}\n").unwrap() + 3;
        let body = &emitted[start..end];
        let list = body
            .split("fwp_copy_finish(vals, n, 0, ")
            .nth(1)
            .unwrap()
            .split(')')
            .next()
            .unwrap()
            .to_string();
        assert!(
            !body.contains("fwp_record("),
            "key records must remain unboxed"
        );
        let worker_start = emitted.find(&format!(" w{worker}(")).unwrap();
        // Locate the definition after its comment, not the earlier prototype.
        let entry = marker + emitted[marker..].find("FWP_TICK();").unwrap();
        assert!(entry > worker_start);
        emitted.replace_range(
            entry..entry + "FWP_TICK();".len(),
            "key_entry(); FWP_TICK();",
        );
        let declarations =
            "typedef uint64_t V;\nstatic void key_allocation(void);\nstatic void key_entry(void);";
        let measured = emitted
            .replace("typedef uint64_t V;", declarations)
            .replace(
                "static inline void *fwp_alloc(size_t n) {",
                "static inline void *fwp_alloc(size_t n) { key_allocation();",
            )
            .replace(
                "static inline void *fwp_alloc_init(size_t n) {",
                "static inline void *fwp_alloc_init(size_t n) { key_allocation();",
            )
            .replace(
                "int main(int argc, char **argv)",
                "int original_main(int argc, char **argv)",
            )
            + &include_str!("fixtures/inline_sort_keys_probe.c")
                .replace("@sort@", &kernel)
                .replace("@list@", &list);
        for opt in ["-O1", "-O2"] {
            let executable = dir.0.join(format!("main-{typed}{opt}.exe"));
            fwp::cgen::compile_c(&ordinary, &executable, opt).unwrap();
            let actual = checked(Command::new(&executable).env("FWP_ALLOC_STATS", "1"));
            assert_eq!(actual.stdout, reference.stdout, "{typed}/{opt}");
            assert_eq!(
                allocation_report::parse(&String::from_utf8_lossy(&actual.stderr))
                    .unwrap()
                    .live,
                0
            );
            for (name, code, status) in [
                ("owners", measured.clone(), 0),
                (
                    "missing-field-release",
                    measured.replace("owner->drop_text(keys[i].text);", "(void)keys[i].text;"),
                    227,
                ),
                (
                    "missing-buffer-free",
                    measured.replace("if (keys) fwp_mem_free(keys);", "/* omitted buffer free */"),
                    229,
                ),
            ] {
                let label = format!("{name}-{typed}{opt}");
                let executable = dir.0.join(format!("{label}.exe"));
                fwp::cgen::compile_c(&code, &executable, opt).unwrap();
                let actual = Command::new(&executable).output().unwrap();
                record_probe::save("inline-sort-keys", &label, &code, &executable, &actual);
                if actual.status.code() != Some(status)
                    || !actual.stdout.is_empty()
                    || !actual.stderr.is_empty()
                {
                    failures.push(format!("{label}: expected {status}, got {actual:?}"));
                }
            }
        }
    }
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}
