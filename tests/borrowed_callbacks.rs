//! Borrowed callback application keeps source owners and uses parameter types.
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
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

#[test]
fn borrowed_application_preserves_aliases_and_typed_argument_slices() {
    let dir = Scratch(std::env::temp_dir().join(format!("fwp-borrowed-{}", std::process::id())));
    std::fs::create_dir_all(&dir.0).unwrap();
    let emitted = dir.0.join("runtime.c");
    let fixture = dir.0.join("mixed.fwp");
    std::fs::write(
        &fixture,
        r#"
choose : I64 -> (I64 -> String)
choose = if (rem 2 | eq 0)
    (show | flip string.repeat)
    (add 1 | show | flip string.repeat)
main = 3 | choose | apply 7 | echo
"#,
    )
    .unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .arg("build")
            .arg(&fixture)
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
static void probe_drop_leaf(V v) {
    uint8_t *c = fwp_rc_slot(v);
    if (!c || !*c) return;
    if (*c > 1) { (*c)--; return; }
    fwp_rc_free_obj(v);
}
static V probe_closure(uint32_t fn, uint32_t n, V *a) {
    fwp_clo *c = (fwp_clo *)fwp_alloc_init(sizeof(fwp_clo) + n * sizeof(V));
    c->fn = fn; c->n = n;
    for (uint32_t i = 0; i < n; i++) c->a[i] = a[i];
    return fwp_rc_fresh(PTR(c));
}
/* fn 0: String -> I64 -> String. Scalar bits deliberately point at a leaf. */
static V probe_mixed(V *a) { return a[0]; }
static void probe_mixed_args(V *a, uint32_t start, uint32_t n) {
    if (start == 0 && n) fwp_rc_dup(a[0]);
}
static void probe_mixed_caps(V f, int duplicate) {
    if (CLO(f)->n) {
        if (duplicate) fwp_rc_dup(CLO(f)->a[0]);
        else probe_drop_leaf(CLO(f)->a[0]);
    }
    if (!duplicate) fwp_rc_free_obj(f);
}
/* fn 1: String -> String, returning its consumed input. */
static V probe_identity(V *a) { return a[0]; }
static void probe_identity_args(V *a, uint32_t start, uint32_t n) {
    if (!start && n) fwp_rc_dup(a[0]);
}
static void probe_empty_caps(V f, int duplicate) {
    if (!duplicate) fwp_rc_free_obj(f);
}
/* fn 2: I64 -> (String -> String), changing the type at overapplication. */
static V probe_factory(V *a) { (void)a; return probe_closure(1, 0, NULL); }
static void probe_scalar_args(V *a, uint32_t start, uint32_t n) {
    (void)a; (void)start; (void)n;
}
/* fn 3: String -> String -> String; returned value aliases the capture. */
static V probe_capture(V *a) { probe_drop_leaf(a[1]); return a[0]; }
static void probe_capture_args(V *a, uint32_t start, uint32_t n) {
    (void)start;
    for (uint32_t i = 0; i < n; i++) fwp_rc_dup(a[i]);
}
static const fwp_owned_fninfo probe_owned[] = {
    {probe_mixed, probe_mixed_caps, probe_mixed_args},
    {probe_identity, probe_empty_caps, probe_identity_args},
    {probe_factory, probe_empty_caps, probe_scalar_args},
    {probe_capture, probe_mixed_caps, probe_capture_args},
};
static const fwp_fninfo probe_fns[] = {
    {2, probe_mixed, "mixed", &probe_owned[0]},
    {1, probe_identity, "identity", &probe_owned[1]},
    {1, probe_factory, "factory", &probe_owned[2]},
    {2, probe_capture, "capture", &probe_owned[3]},
};
int main(void) {
    fwp_gc_start(__builtin_frame_address(0));
    /* Exercise the compiler's actual parameter metadata, including a
     * scalar whose bits look exactly like the following pointer argument. */
    fwp_fns = fwp_fn_table;
    size_t repeat = 0;
    while (repeat < sizeof fwp_fn_table / sizeof *fwp_fn_table &&
           strcmp(fwp_fn_table[repeat].name, "string.repeat")) repeat++;
    if (repeat == sizeof fwp_fn_table / sizeof *fwp_fn_table ||
        !fwp_fn_table[repeat].owned) return 10;
    V generated_leaf = fwp_rc_fresh(fwp_cstr("kept"));
    V misleading[] = {generated_leaf, generated_leaf};
    fwp_fn_table[repeat].owned->arguments(misleading, 0, 2);
    if (*fwp_rc_slot(generated_leaf) != 2) return 11;
    probe_drop_leaf(generated_leaf);
    fwp_fn_table[repeat].owned->arguments(misleading, 0, 1);
    if (*fwp_rc_slot(generated_leaf) != 1) return 12;
    fwp_fn_table[repeat].owned->arguments(&generated_leaf, 1, 1);
    if (*fwp_rc_slot(generated_leaf) != 2) return 13;
    probe_drop_leaf(generated_leaf);
    V generated_fn = probe_closure((uint32_t)repeat, 0, NULL);
    V generated_args[] = {3, generated_leaf};
    V generated_result = fwp_apply_borrowed(generated_fn, 2, generated_args);
    if (STR(generated_result)->len != 12 ||
        *fwp_rc_slot(generated_result) != 1 ||
        *fwp_rc_slot(generated_leaf) != 1 ||
        *fwp_rc_slot(generated_fn) != 1) return 14;
    probe_drop_leaf(generated_result);
    V generated_partial = fwp_apply_borrowed(generated_fn, 1, generated_args);
    generated_result = fwp_apply_borrowed(generated_partial, 1, &generated_leaf);
    if (STR(generated_result)->len != 12 || *fwp_rc_slot(generated_leaf) != 1 ||
        *fwp_rc_slot(generated_partial) != 1) return 15;
    probe_drop_leaf(generated_result);
    fwp_closure_drop(generated_partial);
    fwp_closure_drop(generated_fn);
    probe_drop_leaf(generated_leaf);
    fwp_fns = probe_fns;
    V leaf = fwp_rc_fresh(fwp_cstr("retained"));
    V scalar = fwp_rc_fresh(fwp_cstr("scalar bits"));
    V mixed = probe_closure(0, 0, NULL);
    V pair[] = {leaf, scalar};
    V r = fwp_apply_borrowed(mixed, 2, pair);
    if (r != leaf || *fwp_rc_slot(leaf) != 2 || *fwp_rc_slot(scalar) != 1 || *fwp_rc_slot(mixed) != 1) return 1;
    probe_drop_leaf(r);
    V partial = fwp_apply_borrowed(mixed, 1, pair);
    if (*fwp_rc_slot(leaf) != 2 || *fwp_rc_slot(partial) != 1) return 2;
    r = fwp_apply_borrowed(partial, 1, &scalar);
    if (r != leaf || *fwp_rc_slot(leaf) != 3 || *fwp_rc_slot(scalar) != 1 || *fwp_rc_slot(partial) != 1) return 3;
    probe_drop_leaf(r);
    fwp_closure_drop(partial);
    if (*fwp_rc_slot(leaf) != 1) return 4;
    V factory = probe_closure(2, 0, NULL);
    V over[] = {scalar, leaf};
    r = fwp_apply_borrowed(factory, 2, over);
    if (r != leaf || *fwp_rc_slot(leaf) != 2 || *fwp_rc_slot(scalar) != 1 || *fwp_rc_slot(factory) != 1) return 5;
    probe_drop_leaf(r);
    fwp_rc_dup(leaf);
    V capture = probe_closure(3, 1, &leaf);
    r = fwp_apply_borrowed(capture, 1, &scalar);
    if (r != leaf || *fwp_rc_slot(leaf) != 3 || *fwp_rc_slot(scalar) != 1 || *fwp_rc_slot(capture) != 1) return 6;
    probe_drop_leaf(r);
    fwp_closure_drop(capture);
    if (*fwp_rc_slot(leaf) != 1) return 7;
    /* A synchronous callback may live on the caller's stack. */
    fwp_clo stack_callback = {1, 0};
    r = fwp_apply_borrowed(PTR(&stack_callback), 1, &leaf);
    if (r != leaf || *fwp_rc_slot(leaf) != 2) return 8;
    probe_drop_leaf(r);
    fwp_closure_drop(factory);
    fwp_closure_drop(mixed);
    if (*fwp_rc_slot(leaf) != 1 || *fwp_rc_slot(scalar) != 1) return 9;
    probe_drop_leaf(leaf);
    probe_drop_leaf(scalar);
    puts("borrowed owners and typed slices preserved");
    return 0;
}
"#
    );
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(format!("probe{opt}"));
        fwp::cgen::compile_c(&source, &exe, opt).unwrap();
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, b"borrowed owners and typed slices preserved\n");
        }
    }
}
