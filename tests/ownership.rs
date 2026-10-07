//! Shared contracts must preserve aliases/callbacks and avoid promoting
//! comparison-only keys to permanent runtime sharing.
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
        let path =
            std::env::temp_dir().join(format!("fwp-ownership-{}-{name}", std::process::id()));
        std::fs::create_dir_all(&path).unwrap();
        Self(path)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[test]
fn container_keys_aliases_and_callbacks() {
    let scratch = Scratch::new("aliases");
    let src = scratch.0.join("boundaries.fwp");
    std::fs::write(&src, r#"
Key = { a: I64, b: I64, c: I64, d: I64, e: I64 }
key : Key
key = Key { a = 1, b = 2, c = 3, d = 4, e = 5 }
changed : Key -> Key
changed = update { a = add 10 }
capture : Key -> I64 -> Key
capture = const
m : Map[Key, Key]
m = map.empty | map.insert key key
main = [
    m | map.contains key | echo,
    m | map.get key | option.map changed | echo,
    m | map.values | echo,
    m | both (map.remove key) id | both (.0 | map.size) (.1 | map.size) | echo,
    m | map.remove (key | changed) | map.values | echo,
    m | map.map-values id | map.values | echo,
    m | map.update key changed key | map.values | echo,
    [key] | set.from-list | set.contains key | echo,
    [key] | set.from-list | set.remove (key | changed) | set.to-list | echo,
    [key] | array.from-list | array.map id | array.get 0 | option.map changed | echo,
    [key] | array.from-list | array.fold const key | echo,
    [key] | array.from-list | array.map capture | array.get 0 | option.map (apply 0 | changed) | echo,
    [key] | array.from-list | array.set -1 key | echo,
    [key] | array.from-list | array.slice 0 1 | array.to-list | echo,
    [key] | array.from-list | both id (array.push (key | changed)) | both (.0 | array.to-list) (.1 | array.to-list) | echo,
] | ignore
"#).unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    let emitted = scratch.0.join("boundaries.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted),
    );
    let c = std::fs::read_to_string(&emitted).unwrap();
    for primitive in ["map_contains", "map_remove", "map_get"] {
        let call = format!("return fwp_p_{primitive}");
        let calls: Vec<_> = c.match_indices(&call).collect();
        assert!(!calls.is_empty(), "missing {primitive}");
        for (at, _) in calls {
            let start = c[..at].rfind("static V f").unwrap();
            assert!(
                !c[start..at].contains("fwp_rc_share(l0)"),
                "{primitive} shares comparison key"
            );
        }
    }
    let insert = c.find("return fwp_p_map_insert_typed(l0").unwrap();
    let start = c[..insert].rfind("static V f").unwrap();
    assert!(
        !c[start..insert].contains("fwp_rc_share(l0)")
            && c[insert..]
                .split(';')
                .next()
                .unwrap()
                .contains("fwp_map_ops){fwp_rc_dup, fwp_rc_dup,"),
        "insert must retain stored keys and values by type"
    );
    let exe = scratch.0.join("boundaries");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["-O1", "-o"])
            .arg(&exe),
    );
    for verify in ["0", "1"] {
        let native = checked(
            Command::new(&exe)
                .env("FWP_GC_STRESS", "1")
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_REUSE_VERIFY", verify),
        );
        assert_eq!(
            native.stdout, reference.stdout,
            "reuse verification {verify}"
        );
    }
}

#[test]
fn comparison_only_keys_stay_reusable() {
    let scratch = Scratch::new("keys");
    let src = scratch.0.join("key-loop.fwp");
    std::fs::write(
        &src,
        r#"
Key = { a: I64, b: I64, c: I64, d: I64, e: I64, f: I64, g: I64, h: I64, i: I64 }
key : Key
key = Key { a = 0, b = 1, c = 2, d = 3, e = 4, f = 5, g = 6, h = 7, i = 8 }
m : Map[Key, I64]
m = map.empty
# Reading the key must not prevent the following immutable update reusing it.
bump : Key -> Key
bump = if (flip map.contains m) (update { a = add 2 }) (update { a = add 1 })
step : (I64, Key) -> Step[(I64, Key), I64]
step = if (.0 | eq 0) (.1 | .a | Stop) (both (.0 | sub 1) (.1 | bump) | Again)
main = (10000, key) | loop step | echo
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    assert_eq!(reference.stdout, b"10000\n");
    let emitted = scratch.0.join("key-loop.c");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&emitted)
            .env("FWP_STACK", "0")
            .env("FWP_REUSE", "1"),
    );
    let borrowed = std::fs::read_to_string(emitted).unwrap();
    // Reproduce the previous comparison-key boundary without disabling
    // any other ownership optimization, so this isolates the contract.
    let boundary = "return fwp_p_map_contains(l0, l1,";
    assert!(borrowed.contains(boundary));
    let shared = borrowed.replace(
        boundary,
        "fwp_rc_share(l0); return fwp_p_map_contains(l0, l1,",
    );
    let mut allocated = Vec::new();
    for (name, source) in [("shared", shared.as_str()), ("borrowed", borrowed.as_str())] {
        let exe = scratch.0.join(name);
        fwp::cgen::compile_c(source, &exe, "-O1").unwrap();
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_STATS", "1")
                .env("FWP_REUSE_VERIFY", "0"),
        );
        assert_eq!(out.stdout, reference.stdout);
        let stats = String::from_utf8_lossy(&out.stderr);
        let prefix = stats.split(" MiB allocated").next().unwrap();
        allocated.push(
            prefix
                .split_whitespace()
                .last()
                .unwrap()
                .parse::<f64>()
                .unwrap(),
        );
    }
    eprintln!(
        "comparison keys: shared {} MiB; borrowed {} MiB",
        allocated[0], allocated[1]
    );
    assert!(
        allocated[0] > 0.5 && allocated[1] < allocated[0] / 2.0,
        "copied: {} MiB; borrowed/reused: {} MiB",
        allocated[0],
        allocated[1]
    );
}

#[test]
fn saturated_counts_protect_reachable_values() {
    let scratch = Scratch::new("saturation");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let emitted = scratch.0.join("runtime.c");
    let hello = PathBuf::from(env!("CARGO_MANIFEST_DIR")).join("examples/hello.fwp");
    checked(
        Command::new(fwp)
            .arg("build")
            .arg(hello)
            .args(["--emit-c", "-o"])
            .arg(&emitted),
    );
    let runtime = std::fs::read_to_string(emitted).unwrap().replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let source = format!(
        "{runtime}\n{}",
        r#"
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    V child = fwp_rc_fresh(fwp_record(1, (V[]){7}));
    V parent = fwp_rc_fresh(fwp_record(1, &child));
    volatile V aliases[255];
    for (int i = 0; i < 255; i++) { aliases[i] = parent; fwp_rc_dup(parent); }
    if (*fwp_rc_slot(parent) != 255 && *fwp_rc_slot(parent) != 0) return 1;
    /* Counts stay exact at high fanout. A retained runtime callback still
     * requires explicit graph sharing before receiving borrowed children. */
    fwp_rc_share(parent);
    if (*fwp_rc_slot(parent) != 0) return 1;
    V reachable = OBJ(aliases[0])->f[0];
    /* A runtime callback receiving a shared value may try a unique
     * update: it must copy when another alias can observe the original. */
    V updated = reachable;
    if (fwp_rc_unique(reachable) != 1)
        updated = fwp_rc_fresh(fwp_data(0, OBJ(reachable)->n, OBJ(reachable)->f));
    OBJ(updated)->f[0] = 9;
    if (OBJ(OBJ(aliases[254])->f[0])->f[0] != 7) return 2;
    if (OBJ(updated)->f[0] != 9) return 3;
    V first = fwp_rc_fresh(fwp_record(1, (V[]){11}));
    V second = fwp_rc_fresh(fwp_record(1, (V[]){12}));
    V pair = fwp_rc_fresh(fwp_record(2, (V[]){first, second}));
    fwp_rc_share(PTR(&OBJ(pair)->f[1]));
    if (fwp_rc_unique(first) == 1 || fwp_rc_unique(second) == 1) return 4;
    V branches[70];
    for (int i = 0; i < 70; i++) {
        V leaf = fwp_rc_fresh(fwp_record(1, (V[]){(V)i}));
        branches[i] = fwp_rc_fresh(fwp_record(1, &leaf));
    }
    V wide = fwp_rc_fresh(fwp_record(70, branches));
    fwp_rc_share(wide);
    for (int i = 0; i < 70; i++)
        if (fwp_rc_unique(OBJ(branches[i])->f[0]) == 1) return 5;
    puts("shared descendants protected");
    return 0;
}
"#
    );
    let start = source
        .find("static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);")
        .unwrap();
    let end = start
        + source[start..]
            .find("\nstatic inline void fwp_rc_drop")
            .unwrap();
    let mut previous = source.clone();
    previous.replace_range(
        start..end,
        r#"static inline void fwp_rc_dup(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (c && *c) *c = *c == 255 ? 0 : *c + 1;
}
"#,
    );
    assert!(previous != source, "saturation baseline was not restored");
    let old = scratch.0.join("old-saturation");
    fwp::cgen::compile_c(&previous, &old, "-O2").unwrap();
    let old_result = Command::new(&old)
        .env("FWP_REUSE_VERIFY", "0")
        .env("FWP_GC_STRESS", "0")
        .output()
        .unwrap();
    assert_eq!(
        old_result.status.code(),
        Some(2),
        "old boundary must corrupt the observed child"
    );
    let exe = scratch.0.join("saturation");
    fwp::cgen::compile_c(&source, &exe, "-O2").unwrap();
    assert_eq!(
        checked(&mut Command::new(&exe)).stdout,
        b"shared descendants protected\n"
    );
}
