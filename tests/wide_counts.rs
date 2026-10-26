//! High-fanout ownership keeps exact counts and releases values and metadata.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/allocation_report.rs"]
mod allocation_report;

#[path = "support/ownership_ledger.rs"]
mod ownership_ledger;
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
        let p = std::env::temp_dir().join(format!("fwp-wide-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}
fn emitted(dir: &Scratch, source: &str, memory: &str) -> String {
    let path = dir.0.join("probe.fwp");
    let cfile = dir.0.join("probe.c");
    std::fs::write(&path, source).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .args(["build", "--memory", memory])
            .arg(&path)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    std::fs::read_to_string(cfile).unwrap()
}

#[test]
fn high_fanout_leaves_release_storage() {
    let dir = Scratch::new("counts");
    let source = r#"
size : I64 -> I64
size = rem 7 | show | string.repeat 256 | const | flip map (range 0 400) | map string.length | sum
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
main = (3000, 0) | loop step | echo
"#;
    let owned = emitted(&dir, source, "dynamic");
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(dir.0.join("probe.fwp")),
    );
    // Keep count updates and typed destruction in both versions; only the
    // negative control omits returning the final owner's physical storage.
    let missing_free = owned.replace(
        "static void fwp_mem_free(void *p) {",
        "static void fwp_mem_free(void *p) { (void)p; return;",
    );
    assert_ne!(missing_free, owned, "physical-free fault was not injected");
    let mut freed = Vec::new();
    for (name, code) in [("missing-free", missing_free), ("wide", owned)] {
        let exe = dir.0.join(format!("{name}.exe"));
        fwp::cgen::compile_c(&code, &exe, "-O1").unwrap();
        let got = checked(Command::new(&exe).env("FWP_ALLOC_STATS", "1"));
        assert_eq!(got.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&got.stderr);

        freed.push(
            allocation_report::parse(&stats)
                .expect("allocation report")
                .released as f64
                / 1_048_576.0,
        );
    }
    eprintln!("high-fanout MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn high_fanout_functions_and_leaves_preserve_aliases() {
    let dir = Scratch::new("stress");
    let source = dir.0.join("stress.fwp");
    std::fs::write(
        &source,
        r#"
leaves : String -> I64
leaves = const | flip map (range 0 400) | map string.length | sum
functions : (String -> String) -> I64
functions = const | flip map (range 0 400) | map (apply "!") | map string.length | sum
main = [
    "a b c" | words | join "" | string.repeat 64 | leaves | echo,
    functions ("a b c" | words | join "" | concat) | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    for opt in ["-O1", "-O2"] {
        for stack in ["0", "1"] {
            let exe = dir.0.join(format!("aliases{opt}-{stack}.exe"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&source)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_STACK", stack),
            );
            let got = checked(&mut Command::new(&exe));
            assert_eq!(got.stdout, reference.stdout, "{opt}, stack {stack}");
        }
    }
}

#[test]
fn wide_counts_release_values_and_metadata_each_round() {
    let dir = Scratch::new("arc");
    let program = "discard : String -> I64\ndiscard = const 1\nmain = read-all () | string.repeat 2 | discard | echo\n";
    for memory in ["dynamic", "static"] {
        let code = emitted(&dir, program, memory);
        let marker = "/* String */\nstatic void fwp_drop";
        let start = code.find(marker).unwrap() + marker.len();
        let drop = format!("fwp_drop{}", code[start..].split('(').next().unwrap());
        let code = ownership_ledger::instrument_native(&code, 65536).replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        let probe = include_str!("fixtures/owned_wide_counts.c").replace("DROP_LEAF", &drop);
        let code = code
            .replace(
                "(heap_rc_wide *)malloc(sizeof *entry)",
                "(heap_rc_wide *)wide_allocate(sizeof *entry)",
            )
            .replace(
                "    free(entry);\n    fwp_heap.rc_wide_len--;",
                "    wide_free(entry);\n    fwp_heap.rc_wide_len--;",
            );
        let code = code.replace(
            "typedef struct heap_rc_wide {",
            &format!(
                "{}\ntypedef struct heap_rc_wide {{",
                include_str!("fixtures/wide_count_allocator.c")
            ),
        );
        let code = format!("{code}\n{probe}");
        let missing_free = code.replace(
            "    wide_free(entry);\n    fwp_heap.rc_wide_len--;",
            "    /* omit physical wide-count metadata release */\n    fwp_heap.rc_wide_len--;",
        );
        assert_ne!(missing_free, code);
        for opt in ["-O1", "-O2"] {
            let exe = dir.0.join(format!("{memory}{opt}.exe"));
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();
            for (mode, status) in [("8", 0), ("1024", 0), ("overflow", 101), ("oom", 102)] {
                let output = Command::new(&exe).arg(mode).output().unwrap();
                record_probe::save(
                    "wide_counts",
                    &format!("{memory}{opt}-{mode}"),
                    &code,
                    &exe,
                    &output,
                );
                assert_eq!(
                    output.status.code(),
                    Some(status),
                    "{memory}/{opt}/{mode}: {output:?}"
                );
                if mode == "overflow" {
                    assert_eq!(output.stderr, b"fwp: trap: reference count overflow\n");
                } else if mode == "oom" {
                    assert_eq!(output.stderr, b"fwp: out of memory\n");
                } else {
                    assert!(output.stderr.is_empty(), "{output:?}");
                }
            }
        }
        let exe = dir.0.join(format!("{memory}-missing-wide-free.exe"));
        fwp::cgen::compile_c(&missing_free, &exe, "-O2").unwrap();
        let output = Command::new(&exe).arg("8").output().unwrap();
        record_probe::save(
            "wide_counts",
            &format!("{memory}-missing-wide-free"),
            &missing_free,
            &exe,
            &output,
        );
        assert_eq!(output.status.code(), Some(239), "{memory}: {output:?}");
    }
}
