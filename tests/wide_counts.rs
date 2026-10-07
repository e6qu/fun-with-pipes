//! High-fanout ownership stays exact without promoting graphs to tracing.
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
fn emitted(dir: &Scratch, source: &str) -> String {
    let path = dir.0.join("probe.fwp");
    let cfile = dir.0.join("probe.c");
    std::fs::write(&path, source).unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&path)
            .args(["--emit-c", "-o"])
            .arg(&cfile)
            .env("FWP_STACK", "0"),
    );
    std::fs::read_to_string(cfile).unwrap()
}

#[test]
fn wide_counts_release_aliases_and_clear_gc_metadata() {
    let dir = Scratch::new("runtime");
    let runtime = emitted(&dir, "discard : String -> I64\ndiscard = const 1\nmain = read-all () | string.repeat 2 | discard | echo\n");
    let marker = "/* String */\nstatic void fwp_drop";
    let start = runtime
        .find(marker)
        .expect("missing actual generated String drop")
        + marker.len();
    let number = runtime[start..].split('(').next().unwrap();
    let runtime = runtime.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
static void wide_many(V v) { for (int i = 0; i < 600; i++) fwp_rc_dup(v); }
static size_t wide_count(V v) {
    uint8_t *slot = fwp_rc_slot(v);
    gc_rc_wide **entry = fwp_rc_wide_link(slot);
    return *entry ? (*entry)->count : *slot;
}
static V probe_entry(V *args) { return args[0]; }
static void probe_args(V *args, uint32_t start, uint32_t n) {
    if (!start && n) fwp_rc_dup(args[0]);
}
static void probe_caps(V f, int duplicate) {
    if (duplicate) fwp_rc_dup(CLO(f)->a[0]);
    else { DROP_LEAF(CLO(f)->a[0]); fwp_rc_free_obj(f); }
}
static const fwp_owned_fninfo probe_owned = {probe_entry, probe_caps, probe_args};
static const fwp_fninfo probe_fns[] = {{1, probe_entry, "probe", &probe_owned}};
int main(int argc, char **argv) {
    fwp_gc_start(__builtin_frame_address(0));
    V leaf = fwp_rc_fresh(fwp_cstr("alias"));
    wide_many(leaf);
    if (wide_count(leaf) != 601 || fwp_gc.rc_wide_len != 1) return 1;
    if (argc > 1 && !strcmp(argv[1], "overflow")) {
        (*fwp_rc_wide_link(fwp_rc_slot(leaf)))->count = SIZE_MAX;
        fwp_rc_dup(leaf);
        return 2;
    }
    for (int i = 0; i < 600; i++) DROP_LEAF(leaf);
    if (wide_count(leaf) != 1 || fwp_gc.rc_wide_len) return 3;
    if (STR(leaf)->len != 5 || memcmp(STR(leaf)->d, "alias", 5)) return 4;
    DROP_LEAF(leaf);
    if (*fwp_rc_slot(leaf) || fwp_gc.rc_wide_len) return 5;
    /* A count-slot key canonicalizes interior aliases, with no value root. */
    V record = fwp_rc_fresh(fwp_record(2, (V[]){7, 8}));
    V interior = PTR(&OBJ(record)->f[1]);
    wide_many(interior);
    if (wide_count(record) != 601 || !fwp_gc.rc_wide_len) return 6;
    for (int i = 0; i < 600; i++) fwp_rc_drop(interior);
    if (!fwp_rc_last(record) || fwp_gc.rc_wide_len) return 7;
    fwp_rc_free_obj(record);
    /* Closure work-list cleanup consumes wide counts before capture cleanup. */
    fwp_fns = probe_fns;
    leaf = fwp_rc_fresh(fwp_cstr("capture"));
    fwp_clo *closure = fwp_alloc_init(sizeof *closure + sizeof(V));
    closure->fn = 0; closure->n = 1; closure->a[0] = leaf;
    V f = fwp_rc_fresh(PTR(closure));
    wide_many(f);
    for (int i = 0; i < 600; i++) fwp_closure_drop(f);
    if (!fwp_rc_last(f) || fwp_gc.rc_wide_len || wide_count(leaf) != 1) return 8;
    fwp_closure_drop(f);
    if (*fwp_rc_slot(f) || *fwp_rc_slot(leaf)) return 9;
    /* Explicit graph sharing discards parent and child wide metadata. */
    leaf = fwp_rc_fresh(fwp_cstr("shared")); wide_many(leaf);
    record = fwp_rc_fresh(fwp_record(1, &leaf)); wide_many(record);
    fwp_rc_share(record);
    if (fwp_gc.rc_wide_len || *fwp_rc_slot(record) || *fwp_rc_slot(leaf)) return 10;
    /* Runtime scratch release must not leave metadata on a reused slot. */
    record = fwp_rc_fresh(fwp_record(1, (V[]){0})); wide_many(record);
    uint8_t *slot = fwp_rc_slot(record);
    fwp_mem_free(OBJ(record));
    if (fwp_gc.rc_wide_len || *slot) return 11;
    V reused = fwp_rc_fresh(fwp_record(1, (V[]){9}));
    if (fwp_rc_slot(reused) != slot || wide_count(reused) != 1) return 12;
    /* Deterministic sweep fixtures provide mark decisions, avoiding stale
     * conservative stack words obscuring dead-slot and empty-chunk coverage. */
    wide_many(reused);
    V keep = fwp_rc_fresh(fwp_record(1, (V[]){10}));
    for (size_t ci = 0; ci < fwp_gc.top; ci++) {
        memset(fwp_gc.meta[ci].bits, 0, sizeof fwp_gc.meta[ci].bits);
        fwp_gc.meta[ci].mark = 0;
    }
    size_t ci = ((uintptr_t)keep - (uintptr_t)fwp_gc.base) >> GC_SHIFT;
    size_t index = fwp_rc_slot(keep) - fwp_gc.meta[ci].rc;
    fwp_gc.meta[ci].bits[index >> 6] |= (uint64_t)1 << (index & 63);
    fwp_gc_sweep();
    if (fwp_gc.rc_wide_len || *slot || *fwp_rc_slot(keep) != 1) return 13;
    record = fwp_rc_fresh(fwp_record(1, (V[]){11})); wide_many(record);
    memset(fwp_gc.meta[ci].bits, 0, sizeof fwp_gc.meta[ci].bits);
    fwp_gc_sweep();
    if (fwp_gc.rc_wide_len || fwp_gc.meta[ci].type != GC_FREE) return 14;
    char data[20000] = {0};
    V big = fwp_rc_fresh(fwp_str_new(data, sizeof data)); wide_many(big);
    if (wide_count(big) != 601) return 15;
    ci = ((uintptr_t)big - (uintptr_t)fwp_gc.base) >> GC_SHIFT;
    if (fwp_gc.meta[ci].type != GC_BIG) return 16;
    fwp_gc.meta[ci].mark = 0;
    fwp_gc_sweep();
    if (fwp_gc.rc_wide_len || fwp_gc.meta[ci].type != GC_FREE) return 17;
    puts("wide aliases reclaimed and metadata cleared");
    return 0;
}
"#
    .replace("DROP_LEAF", &format!("fwp_drop{number}"));
    let source = format!("{runtime}\n{probe}");
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(format!("runtime{opt}"));
        fwp::cgen::compile_c(&source, &exe, opt).unwrap();
        let got = checked(
            Command::new(&exe)
                .env("FWP_GC", "off")
                .env("FWP_REUSE_VERIFY", "0"),
        );
        assert_eq!(got.stdout, b"wide aliases reclaimed and metadata cleared\n");
        let overflow = Command::new(&exe)
            .arg("overflow")
            .env("FWP_GC", "off")
            .output()
            .unwrap();
        assert!(!overflow.status.success());
        assert_eq!(overflow.stderr, b"fwp: trap: reference count overflow\n");
    }
    let fail = source.replace("(gc_rc_wide *)malloc(sizeof *entry)", "(gc_rc_wide *)NULL");
    assert!(fail != source, "wide allocation failure was not injected");
    let exe = dir.0.join("oom");
    fwp::cgen::compile_c(&fail, &exe, "-O1").unwrap();
    let got = Command::new(&exe).env("FWP_GC", "off").output().unwrap();
    assert_eq!(got.status.code(), Some(102));
    assert_eq!(got.stderr, b"fwp: out of memory\n");
}

#[test]
fn high_fanout_leaves_are_reclaimed_without_tracing() {
    let dir = Scratch::new("counts");
    let source = r#"
size : I64 -> I64
size = rem 7 | show | string.repeat 256 | const | flip map (range 0 400) | map string.length | sum
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make { 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) } | Again)
main = (3000, 0) | loop step | echo
"#;
    let owned = emitted(&dir, source);
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(dir.0.join("probe.fwp")),
    );
    let shared = owned.replace(
        "if (__builtin_expect(*c >= 254, 0)) fwp_rc_wide_dup(c);",
        "if (*c == 255) fwp_rc_share(v); else if (*c == 254) fwp_rc_wide_dup(c);",
    );
    assert!(
        shared != owned,
        "automatic sharing baseline was not restored"
    );
    let mut freed = Vec::new();
    for (name, code) in [("shared", shared), ("wide", owned)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(&code, &exe, "-O1").unwrap();
        let got = checked(
            Command::new(&exe)
                .env("FWP_GC", "off")
                .env("FWP_GC_STATS", "1")
                .env("FWP_REUSE_VERIFY", "0"),
        );
        assert_eq!(got.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&got.stderr);
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
    eprintln!("high-fanout MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 0.3, "{freed:?}");
}

#[test]
fn high_fanout_functions_and_leaves_survive_collection() {
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
            let exe = dir.0.join(format!("stress{opt}-{stack}"));
            checked(
                Command::new(fwp)
                    .arg("build")
                    .arg(&source)
                    .args([opt, "-o"])
                    .arg(&exe)
                    .env("FWP_STACK", stack),
            );
            for poison in ["0", "1"] {
                let got = checked(
                    Command::new(&exe)
                        .env("FWP_GC_STRESS", "17")
                        .env("FWP_GC_VERIFY", "1")
                        .env("FWP_REUSE_VERIFY", poison),
                );
                assert_eq!(
                    got.stdout, reference.stdout,
                    "{opt}, stack {stack}, poison {poison}"
                );
            }
        }
    }
}
