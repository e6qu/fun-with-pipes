//! Borrowed callback application keeps source owners and uses parameter types.
use std::path::PathBuf;
use std::process::{Command, Output};

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
checked : I64 -> I64 ! {Error[String]}
checked = if (lt 0) (const "negative input" | fail) id
main = apply 7 (choose (read-all () | string.length | add 3 | attempt checked | result.unwrap-or 3)) | echo
"#,
    )
    .unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&fixture),
    );

    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "0")
            .args(["build", "--memory", "dynamic", "-O2"])
            .arg(&fixture)
            .args(["--emit-c", "-o"])
            .arg(&emitted),
    );
    let program = std::fs::read_to_string(&emitted).unwrap();
    assert!(program.contains("#define FWP_UNWIND 1"));
    let copy = "memcpy(r->a, args, n * sizeof(V));";
    assert_eq!(program.matches(copy).count(), 1);
    let program = program.replace(copy, "probe_pap_copy(r->a, args, n * sizeof(V));");
    let program = program.replace(
        "typedef uint64_t V;",
        r#"typedef uint64_t V;
/* Check the copy contract even when a libc header lacks nonnull annotations. */
static void probe_pap_copy(void *to, const void *from, size_t size) {
    if (!to || !from) { fputs("null partial-application copy\n", stderr); _Exit(209); }
    memcpy(to, from, size);
}
"#,
    );

    let program = ownership_ledger::instrument_native(&program, 1 << 16);
    let runtime = program.replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let probe = r#"
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
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 22;
#endif
    fwp_heap_start();
    size_t baseline=fwp_heap.live;
    for(unsigned round=0;round<32;round++) {
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
    V empty_pap = fwp_rc_fresh(fwp_pap(0, 0, NULL));
    if (CLO(empty_pap)->n || *fwp_rc_slot(empty_pap) != 1) return 22;
    fwp_closure_drop(empty_pap);
    V leaf = fwp_rc_fresh(fwp_cstr("retained"));
    V scalar = fwp_rc_fresh(fwp_cstr("scalar bits"));
    V mixed = probe_closure(0, 0, NULL);
    V empty_partial = fwp_apply_borrowed(mixed, 0, NULL);
    if (CLO(empty_partial)->n || *fwp_rc_slot(empty_partial) != 1 ||
        *fwp_rc_slot(mixed) != 1) return 20;
    fwp_closure_drop(empty_partial);
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
    V transferred = fwp_rc_fresh(fwp_cstr("transferred"));
    V transfer_args[] = {transferred, scalar};
    r = fwp_apply_borrowed_prefix(mixed, 2, transfer_args, 1);
    if (r != transferred || *fwp_rc_slot(r) != 1 ||
        *fwp_rc_slot(scalar) != 1 || *fwp_rc_slot(mixed) != 1) return 16;
    probe_drop_leaf(r);
    transferred = fwp_rc_fresh(fwp_cstr("partial transfer"));
    V transferred_partial = fwp_apply_borrowed_prefix(mixed, 1, &transferred, 1);
    if (*fwp_rc_slot(transferred) != 1) return 17;
    r = fwp_apply_borrowed(transferred_partial, 1, &scalar);
    if (r != transferred || *fwp_rc_slot(r) != 2 || *fwp_rc_slot(scalar) != 1) return 18;
    probe_drop_leaf(r);
    fwp_closure_drop(transferred_partial);
    V factory = probe_closure(2, 0, NULL);
    V over[] = {scalar, leaf};
    r = fwp_apply_borrowed(factory, 2, over);
    if (r != leaf || *fwp_rc_slot(leaf) != 2 || *fwp_rc_slot(scalar) != 1 || *fwp_rc_slot(factory) != 1) return 5;
    probe_drop_leaf(r);
    r = fwp_apply_borrowed_prefix(factory, 2, over, 1);
    if (r != leaf || *fwp_rc_slot(leaf) != 2 || *fwp_rc_slot(scalar) != 1 ||
        *fwp_rc_slot(factory) != 1) return 19;
    probe_drop_leaf(r);
    transferred = fwp_rc_fresh(fwp_cstr("span transfer"));
    V span_args[] = {scalar, transferred};
    r = fwp_apply_borrowed_span(factory, 2, span_args, 1, 1);
    if (r != transferred || *fwp_rc_slot(r) != 1 || *fwp_rc_slot(scalar) != 1 ||
        *fwp_rc_slot(factory) != 1) return 21;
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
    if(fwp_heap.live!=baseline||fwp_heap.rc_wide_len)return 90;
    owner_ledger_finish();
    }
    puts("borrowed owners and typed slices preserved");
    return 0;
}
"#;
    let mut cases = vec![("normal", probe.to_owned(), 0)];
    for (label, old, new, status) in [
        (
            "missing-capture",
            "else probe_drop_leaf(CLO(f)->a[0]);",
            "else (void)f;",
            4,
        ),
        (
            "scalar-counted",
            "(void)a; (void)start; (void)n;",
            "if (!start && n) fwp_rc_dup(a[0]);",
            5,
        ),
    ] {
        assert_eq!(probe.matches(old).count(), 1);
        cases.push((label, probe.replace(old, new), status));
    }

    let release = "    fwp_closure_drop(empty_partial);";
    assert_eq!(probe.matches(release).count(), 1);
    cases.push((
        "duplicate-closure-drop",
        probe.replace(release, &format!("{release}\n{release}")),
        203,
    ));
    for (label, release) in [
        ("missing-scalar", "probe_drop_leaf(scalar);"),
        ("missing-factory", "fwp_closure_drop(factory);"),
    ] {
        assert_eq!(probe.matches(release).count(), 1);
        cases.push((label, probe.replace(release, "/* omitted owner */"), 90));
    }

    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(format!("counted{opt}-program.exe"));
        fwp::cgen::compile_c(&program, &exe, opt).unwrap();

        let output = Command::new(&exe).output().unwrap();
        let label = format!("counted{opt}-program");
        record_probe::save("borrowed_callbacks", &label, &program, &exe, &output);
        assert_eq!(
            output.status.code(),
            reference.status.code(),
            "{label}: {output:?}"
        );
        assert_eq!(output.stdout, reference.stdout, "{label}");
        assert_eq!(output.stderr, reference.stderr, "{label}");

        let copy = "if (n) probe_pap_copy(r->a, args, n * sizeof(V));";
        assert_eq!(runtime.matches(copy).count(), 1);
        let code = format!(
            "{}\n{}",
            runtime.replace(copy, "probe_pap_copy(r->a, args, n * sizeof(V));"),
            cases[0].1
        );
        let exe = dir.0.join(format!("counted{opt}-null-copy.exe"));
        fwp::cgen::compile_c(&code, &exe, opt).unwrap();
        let out = Command::new(&exe).output().unwrap();
        record_probe::save(
            "borrowed_callbacks",
            &format!("counted{opt}-null-copy"),
            &code,
            &exe,
            &out,
        );
        assert_eq!(out.status.code(), Some(209), "counted{opt}: {out:?}");
        assert!(
            String::from_utf8_lossy(&out.stderr).contains("null partial-application copy"),
            "counted{opt}: {out:?}"
        );
        #[cfg(unix)]
        {
            let probe = &cases[0].1;
            for (label, code, broken) in [
                ("valid", format!("{runtime}\n{probe}"), false),
                (
                    "null-offset",
                    format!(
                        "{}\n{probe}",
                        runtime.replace(
                            "owned_len ? args + owned_start : NULL",
                            "args + owned_start"
                        )
                    ),
                    true,
                ),
                (
                    "null-tail-offset",
                    format!(
                        "{}\n{probe}",
                        runtime.replace(
                            "after ? args + before + transferred : NULL",
                            "args + before + transferred"
                        )
                    ),
                    true,
                ),
            ] {
                let cfile = dir.0.join(format!("counted{opt}-{label}-ubsan.c"));
                let exe = cfile.with_extension("exe");
                std::fs::write(&cfile, &code).unwrap();
                checked(
                    Command::new("clang")
                        .args([
                            opt,
                            "-std=gnu11",
                            "-ffp-contract=off",
                            "-w",
                            "-fsanitize=pointer-overflow",
                            "-fno-sanitize-recover=all",
                        ])
                        .arg(&cfile)
                        .arg("-o")
                        .arg(&exe)
                        .args(["-lm", "-lpthread"]),
                );
                let out = Command::new(&exe)
                    .env(
                        "UBSAN_OPTIONS",
                        "halt_on_error=1:abort_on_error=0:exitcode=1",
                    )
                    .output()
                    .unwrap();
                record_probe::save(
                    "borrowed_callbacks",
                    &format!("counted{opt}-{label}-ubsan"),
                    &code,
                    &exe,
                    &out,
                );
                if broken {
                    assert_eq!(out.status.code(), Some(1), "{label}: {out:?}");
                    let message = "applying zero offset to null pointer";
                    assert!(
                        String::from_utf8_lossy(&out.stderr).contains(message),
                        "{label}: {out:?}"
                    );
                } else {
                    assert!(out.status.success(), "{label}: {out:?}");
                    assert!(out.stderr.is_empty(), "{label}: {out:?}");
                    assert_eq!(out.stdout, b"borrowed owners and typed slices preserved\n");
                }
            }
        }
        for (case, probe, status) in &cases {
            let code = format!("{runtime}\n{probe}");
            let exe = dir.0.join(format!("counted{opt}-{case}.exe"));
            fwp::cgen::compile_c(&code, &exe, opt).unwrap();

            let output = Command::new(&exe).output().unwrap();
            let label = format!("counted{opt}-{case}");
            record_probe::save("borrowed_callbacks", &label, &code, &exe, &output);
            assert_eq!(output.status.code(), Some(*status), "{label}: {output:?}");
            if *status == 203 {
                assert!(
                    String::from_utf8_lossy(&output.stderr)
                        .contains("count operation on a dead or interior allocation"),
                    "{label}: {output:?}"
                );
            } else {
                assert!(output.stderr.is_empty(), "{label}: {output:?}");
            }
            assert_eq!(
                output.stdout,
                if *status == 0 {
                    b"borrowed owners and typed slices preserved\n".as_slice()
                } else {
                    b""
                },
                "{label}"
            );
        }
    }
}
