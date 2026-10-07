//! Final owned references reclaim storage after surviving collections.
use std::path::PathBuf;
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let out = command.output().unwrap();
    assert!(
        out.status.success(),
        "{command:?}: status {:?}: {}",
        out.status.code(),
        String::from_utf8_lossy(&out.stderr)
    );
    out
}
struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let p =
            std::env::temp_dir().join(format!("fwp-old-reclamation-{}-{name}", std::process::id()));
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
fn marked_owned_storage_reclaims_and_reuses_as_young() {
    let dir = Scratch::new("native");
    let src = dir.0.join("probe.fwp");
    let cfile = dir.0.join("probe.c");
    std::fs::write(
        &src,
        r#"
Box = { text: String }
main = [
    ["a"] | array.from-list | array.set 0 "b" | echo,
    map.empty | map.insert "key" "value" | map.to-list | echo,
    map.empty | map.insert "key" (Box { text = "value" }) | map.values | map (.text) | echo,
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
    let call = emitted
        .lines()
        .find(|line| line.contains("return fwp_p_array_set_typed(l"))
        .expect("missing typed array wrapper");
    let drop_array = call
        .split(';')
        .next()
        .unwrap()
        .rsplit(", ")
        .next()
        .unwrap()
        .trim_end_matches(')');
    let mut drop_leaf = None;
    let mut drop_box = None;
    let mut drop_map = None;
    for call in emitted
        .lines()
        .filter(|line| line.contains("return fwp_p_map_insert_typed(l"))
    {
        let ops = call
            .split("fwp_map_ops){")
            .nth(1)
            .unwrap()
            .split('}')
            .next()
            .unwrap();
        let fields: Vec<_> = ops.split(", ").collect();
        if fields[2] == fields[3] {
            drop_leaf = Some(fields[2]);
            drop_map = Some(fields[4]);
        } else {
            drop_box = Some(fields[3]);
        }
    }
    let drop_leaf = drop_leaf.expect("missing actual String destructor");
    let probe = r#"
static volatile V old_roots[7];
static V old_entry(V *args) { return args[0]; }
static void old_args(V *args, uint32_t start, uint32_t n) {
    if (!start && n) fwp_rc_dup(args[0]);
}
static void old_caps(V f, int duplicate) {
    if (duplicate) fwp_rc_dup(CLO(f)->a[0]);
    else { DROP_LEAF(CLO(f)->a[0]); fwp_rc_free_obj(f); }
}
static const fwp_owned_fninfo old_owned = {old_entry, old_caps, old_args};
static const fwp_fninfo old_fns[] = {{1, old_entry, "owned capture", &old_owned}};
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    fwp_fns = old_fns;
    old_roots[0] = fwp_rc_fresh(fwp_cstr("standalone"));
    char bytes[20000] = {0};
    old_roots[1] = fwp_rc_fresh(fwp_str_new(bytes, sizeof bytes));
    V child = fwp_rc_fresh(fwp_cstr("box child"));
    old_roots[2] = fwp_rc_fresh(fwp_record(1, &child));
    fwp_clo *capture = fwp_alloc_init(sizeof *capture + sizeof(V));
    capture->fn = 0; capture->n = 1;
    capture->a[0] = fwp_rc_fresh(fwp_cstr("capture"));
    old_roots[3] = fwp_rc_fresh(PTR(capture));
    old_roots[4] = fwp_array_typed_new(2);
    ARR(old_roots[4])->d[0] = fwp_rc_fresh(fwp_cstr("array zero"));
    ARR(old_roots[4])->d[1] = fwp_rc_fresh(fwp_cstr("array one"));
    old_roots[5] = fwp_map_typed_new(1);
    MAP(old_roots[5])->d[0] = fwp_rc_fresh(fwp_cstr("key"));
    MAP(old_roots[5])->d[1] = fwp_rc_fresh(fwp_cstr("value"));
    child = fwp_rc_fresh(fwp_cstr("runtime child"));
    old_roots[6] = fwp_rc_fresh(fwp_record(1, &child));
    fwp_rc_share(old_roots[6]);
    /* Force actual major survival, then minor survival with live roots. */
    fwp_gc.major_next = 1;
    fwp_gc_collect();
    fwp_gc.major_next = 0;
    fwp_gc_collect();
    if (fwp_gc.ncollect < 2 || !fwp_gc.nminor) return 1;
    for (int i = 0; i < 7; i++) if (!fwp_gc_marked((void *)(uintptr_t)old_roots[i])) return 2;
    if (fwp_rc_unique(old_roots[2])) return 3; /* immutable old updates stay forbidden */
    V small = old_roots[0], big = old_roots[1];
    uint8_t *small_slot = fwp_rc_slot(small);
    size_t big_ci = ((uintptr_t)big - (uintptr_t)fwp_gc.base) >> GC_SHIFT;
    fwp_rc_dup(small);
    double before = fwp_gc.freed;
    DROP_LEAF(small);
    if (*small_slot != 1 || STR(small)->len != 10 || fwp_gc.freed != before) return 4;
    DROP_LEAF(small);
    if (!fwp_reuse_verify) {
        if (*small_slot || fwp_gc_marked((void *)(uintptr_t)small)) return 7;
        /* Check immediate LIFO reuse before other same-sized leaves free. */
        V reused = fwp_rc_fresh(fwp_cstr("standalone"));
        if (fwp_rc_slot(reused) != small_slot || !fwp_rc_young(reused) || *small_slot != 1) return 8;
        DROP_LEAF(reused);
    }
    DROP_LEAF(big); DROP_BOX(old_roots[2]);
    fwp_closure_drop(old_roots[3]); DROP_ARRAY(old_roots[4]); DROP_MAP(old_roots[5]);
    DROP_BOX(old_roots[6]);
    if (*fwp_rc_slot(old_roots[6]) || *fwp_rc_slot(child) || STR(child)->len != 13) return 5;
    if (!fwp_reuse_verify) {
        if (*small_slot || fwp_gc.meta[big_ci].type != GC_FREE || fwp_gc.freed <= before) return 6;
    } else {
        if (STR(small)->len || OBJ(old_roots[2])->tag != 0xdead ||
            ARR(old_roots[4])->len || MAP(old_roots[5])->len || fwp_gc.freed != before) return 9;
    }
    /* Stale roots naming a freed slot must not cause verification to follow
     * its old fields into newly reused young allocations. */
    for (int i = 0; i < 6; i++) old_roots[i] = 0;
    fwp_gc.major_next = 0;
    fwp_gc_collect();
    puts("old owned storage reclaimed; shared fallback and young reuse preserved");
    return 0;
}
"#.replace("DROP_LEAF", drop_leaf)
        .replace("DROP_BOX", drop_box.expect("missing actual Box destructor"))
        .replace("DROP_ARRAY", drop_array)
        .replace("DROP_MAP", drop_map.expect("missing actual Map destructor"));
    let runtime = emitted.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let source = format!("{runtime}\n{probe}");
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        fwp::cgen::compile_c(&source, &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(
                out.stdout,
                b"old owned storage reclaimed; shared fallback and young reuse preserved\n"
            );
        }
    }
}

#[test]
fn surviving_leaf_storage_is_released_by_counts() {
    let dir = Scratch::new("counts");
    let src = dir.0.join("count.fwp");
    let cfile = dir.0.join("count.c");
    std::fs::write(&src, "discard : String -> I64\ndiscard = const 1\nmain = read-all () | string.repeat 2 | discard | echo\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&src)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let emitted = std::fs::read_to_string(cfile).unwrap();
    let marker = "/* String */\nstatic void fwp_drop";
    let start = emitted
        .find(marker)
        .expect("missing actual String destructor")
        + marker.len();
    let drop_leaf = format!("fwp_drop{}", emitted[start..].split('(').next().unwrap());
    let probe = r#"
static volatile V count_root;
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    char bytes[20000] = {0};
    for (int i = 0; i < 250; i++) {
        count_root = fwp_rc_fresh(fwp_str_new(bytes, sizeof bytes));
        fwp_gc.major_next = 1;
        fwp_gc_collect();
        if (!fwp_gc_marked((void *)(uintptr_t)count_root)) return 1;
        DROP_LEAF(count_root);
        count_root = 0;
    }
    printf("survivor collections: %zu\n", fwp_gc.ncollect);
    fwp_gc_report();
    return 0;
}
"#
    .replace("DROP_LEAF", &drop_leaf);
    let owned = format!(
        "{}\n{probe}",
        emitted.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)"
        )
    );
    // Restore only the prior age gate in the actual storage release routines.
    let guard = "if (!fwp_rc_last(v)) return;";
    let old_age = r#"if (!fwp_rc_last(v)) return;
    size_t age_ci; gc_chunk *age = fwp_gc_chunk_of((uintptr_t)v, &age_ci);
    size_t age_slot = age && age->type == GC_SMALL ? ((uintptr_t)v & (GC_CHUNK - 1)) / age->slot : 0;
    if (age && (age->type == GC_BIG ? age->mark :
        ((age->bits[age_slot >> 6] >> (age_slot & 63)) & 1))) return;"#;
    assert_eq!(owned.matches(guard).count(), 2);
    let aged = owned.replace(guard, old_age);
    let mut freed = Vec::new();
    let mut reference = None;
    for (name, code) in [("aged", &aged), ("owned", &owned)] {
        let exe = dir.0.join(name);
        fwp::cgen::compile_c(code, &exe, "-O1").unwrap();
        let out = checked(
            Command::new(&exe)
                .env("FWP_GC_VERIFY", "1")
                .env("FWP_GC_STRESS", "0")
                .env("FWP_REUSE_VERIFY", "0"),
        );
        if let Some(expected) = &reference {
            assert_eq!(&out.stdout, expected);
        } else {
            reference = Some(out.stdout.clone());
        }
        assert_eq!(out.stdout, b"survivor collections: 250\n");
        let stats = String::from_utf8_lossy(&out.stderr);
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
    eprintln!("surviving leaf MiB freed by counts: {freed:?}");
    assert!(freed[1] > freed[0] + 4.0, "{freed:?}");
}

#[test]
fn retained_task_boundaries_preserve_golden_behavior() {
    let dir = Scratch::new("tasks");
    let root = PathBuf::from(env!("CARGO_MANIFEST_DIR"));
    let source = root.join("tests/run/tasks.fwp");
    let expected = std::fs::read(source.with_extension("out")).unwrap();
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join("tasks");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .arg("build")
                .arg(&source)
                .args([opt, "-o"])
                .arg(&exe),
        );
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_SEED", "42")
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, expected, "{opt}, poison={poison}");
            assert!(
                out.stderr.is_empty(),
                "{}",
                String::from_utf8_lossy(&out.stderr)
            );
        }
    }
}
