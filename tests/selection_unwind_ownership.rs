//! Selected aliases and scratch storage release on predicate unwind.
use std::path::PathBuf;
use std::process::{Command, Output};

#[path = "support/record_probe.rs"]
mod record_probe;

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
        let p = std::env::temp_dir().join(format!(
            "fwp-selection-unwind-{}-{name}",
            std::process::id()
        ));
        std::fs::create_dir_all(&p).unwrap();
        Self(p)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}

const SOURCE: &str = r#"transform : String -> Bool ! {Error[String]}
transform = if (eq "stop") (const "expected" | fail) (const True)
transform-cap : String -> String -> Bool ! {Error[String]}
transform-cap = curry (if (.1 | eq "stop") (const "expected" | fail) (.0 | string.length | gt 0))
scalar : I64 -> Bool ! {Error[String]}
scalar = if (eq 2) (const "expected" | fail) (const True)
scalars : List[I64] -> List[I64] ! {Error[String]}
scalars = filter scalar
direct : List[String] -> List[String] ! {Error[String]}
direct = filter transform
captured : List[String] -> List[String] ! {Error[String]}
captured = filter (transform-cap "suffix")
prefix : List[String] -> List[String] ! {Error[String]}
prefix = take-while transform
prefix-cap : List[String] -> List[String] ! {Error[String]}
prefix-cap = take-while (transform-cap "suffix")
prefix-dynamic : (String -> Bool ! {Error[String]}) -> List[String] -> List[String] ! {Error[String]}
prefix-dynamic = take-while
dynamic : (String -> Bool ! {Error[String]}) -> List[String] -> List[String] ! {Error[String]}
dynamic = filter
main = [
    task.yield (),
    [1, 2] | attempt scalars | echo,
    ["a", "stop", "b"] | attempt direct | echo,
    ["a", "stop", "b"] | attempt captured | echo,
    ["a", "stop", "b"] | attempt (dynamic transform) | echo,
    ["a", "stop", "b"] | attempt prefix | echo,
    ["a", "stop", "b"] | attempt prefix-cap | echo,
    ["a", "stop", "b"] | attempt (prefix-dynamic transform) | echo,
    ["a", "b"] | direct | echo,
] | ignore
"#;

fn function_id<'a>(emitted: &'a str, name: &str) -> &'a str {
    let start = emitted.find(&format!("/* {name} :")).unwrap();
    emitted[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap()
}

#[test]
fn predicates_and_partial_spines_release_selected_aliases_and_scratch() {
    let dir = Scratch::new("callbacks");
    let src = dir.0.join("callbacks.fwp");
    let cfile = dir.0.join("callbacks.c");
    let exe = dir.0.join("callbacks.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    let reference = checked(
        Command::new(fwp)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&src),
    );
    for mode in ["arc", "tracing"] {
        let stress = if mode == "arc" { "0" } else { "1" };
        checked(
            Command::new(fwp)
                .args(["build", "--gc", mode, "--memory", "dynamic"])
                .env("FWP_STACK", "1")
                .arg(&src)
                .args(["--emit-c", "-O2", "-o"])
                .arg(&cfile),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let direct = function_id(&emitted, "direct");
        let captured = function_id(&emitted, "captured");
        let dynamic = function_id(&emitted, "dynamic");
        let transform = function_id(&emitted, "transform");
        let prefix = function_id(&emitted, "prefix");
        let prefix_cap = function_id(&emitted, "prefix-cap");
        let prefix_dynamic = function_id(&emitted, "prefix-dynamic");
        let probe = r#"
static volatile V source_list, input_leaf, input_alias;
static int recover_map_trap(void) { return 1; }
static int dead_string(V v) {
#ifndef FWP_ARC_ONLY
    if (fwp_reuse_verify) return STR(v)->len == 0;
#endif
    return *fwp_rc_slot(v) == 0;
}
static int dead_data(V v) {
#ifndef FWP_ARC_ONLY
    if (fwp_reuse_verify) return OBJ(v)->tag == 0xdead;
#endif
    return *fwp_rc_slot(v) == 0;
}
static int dead_scratch(V v) {
    size_t ci;
    heap_chunk *chunk = fwp_heap_chunk_of((uintptr_t)v, &ci);
    if (!chunk) return 1;
    if (chunk->type == HEAP_FREE) return 1;
    if (chunk->type != HEAP_SMALL) return 0;
    for (char *p = fwp_heap.lists[chunk->leaf][chunk->cls].free; p;
         p = (char *)~*(uintptr_t *)p)
        if (PTR(p) == v) return 1;
    return 0;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    for (volatile int round=0; round<32; round++) {
    for (volatile int mode = 0; mode < 6; mode++) {
        input_leaf = fwp_rc_fresh(fwp_str_new("a", 1));
        input_alias = input_leaf; fwp_rc_dup(input_alias);
        V stop = fwp_rc_fresh(fwp_str_new("stop", 4));
        V tail = fwp_rc_fresh(fwp_data(1, 2, (V[]){stop, 0}));
        source_list = fwp_rc_fresh(fwp_data(1, 2, (V[]){input_leaf, tail}));
        observed_count = 0; observed_result = 0; observed_scratch = 0;
        fwp_handler h;
        h.prev = fwp_handlers; h.state_depth = fwp_state_len; h.cleanup = fwp_cleanups;
        fwp_handlers = &h;
        fwp_trap_recover = recover_map_trap; fwp_trap_jb = &h.jb; fwp_trap_cleanup = h.cleanup;
        if (!setjmp(h.jb)) {
            if (mode == 0) fDIRECT(source_list);
            else if (mode == 1) fCAPTURED(source_list);
            else if (mode == 2) fDYNAMIC(PTR(&fcTRANSFORM), source_list);
            else if (mode == 3) fPREFIX(source_list);
            else if (mode == 4) fPCAP(source_list);
            else fPDYN(PTR(&fcTRANSFORM), source_list);
            return 1;
        }
        fwp_handlers = h.prev; fwp_trap_recover = NULL; fwp_trap_jb = NULL;
        if (fwp_cleanups || observed_count != 1 || !observed_result || !observed_scratch) return 2;
        if (observed_result != input_alias || !dead_scratch(observed_scratch)) return 3;
        if (*fwp_rc_slot(input_alias) != 1 || STR(input_alias)->len != 1 || STR(input_alias)->d[0] != 'a') return 4;
        if (!dead_string(stop)) return 5;
        /* The retained input alias remains owned independently of the map. */
        fwp_rc_free_obj(input_alias);
    }
#ifdef FWP_ARC_ONLY
    if (fwp_heap.live != baseline || fwp_heap.rc_wide_len || fwp_heap.ncollect) return 90;
#endif
    }
    puts("selected aliases and scratch release across failed predicates");
    return 0;
}
"#.replace("DIRECT", direct).replace("CAPTURED", captured).replace("DYNAMIC", dynamic).replace("TRANSFORM", transform).replace("PREFIX", prefix).replace("PCAP", prefix_cap).replace("PDYN", prefix_dynamic);
        // Observe the actual cleanup state, retaining the generated implementation.
        let release = "static void fwp_map_release(void *arg) {";
        assert_eq!(emitted.matches(release).count(), 1);
        let runtime = emitted.replace(release, "static volatile V observed_result, observed_scratch, observed_built, observed_built_element;\nstatic size_t observed_count;\nstatic void fwp_map_release(void *arg) {").replace("    V built = owner->built;", "    V built = owner->built;\n    observed_count = count; observed_result = count ? items[0] : 0; observed_scratch = PTR(items); observed_built = built; observed_built_element = built ? OBJ(built)->f[0] : 0;").replace("int main(int argc, char **argv)", "int original_main(int argc, char **argv)");
        let allocate = "        V fields[] = {owner->items[owner->count - 1], owner->built};";
        let start = runtime.find("static V fwp_map_finish_protected(").unwrap();
        let end = start + runtime[start..].find("\n}\n").unwrap() + 3;
        let helper = &runtime[start..end];
        assert_eq!(helper.matches(allocate).count(), 1);
        let mut builder = runtime.clone();
        builder.replace_range(start..end, &helper.replace(allocate, &format!("        if (owner->count == 1 && owner->built) fwp_trap(\"injected map allocation failure\");\n{allocate}")));
        let builder_probe = probe.replace("fwp_str_new(\"stop\", 4)", "fwp_str_new(\"b\", 1)").replace("        if (!dead_string(stop)) return 5;", "        if (!dead_string(stop)) return 5;\n        if (!observed_built || !dead_string(observed_built_element)) return 6;\n        if (!dead_data(observed_built)) return 7;");
        let cancelled = "static void cancel_map_after_result(void);\n".to_string()
            + &runtime
                .replace(
                    "owner.count = k;",
                    "owner.count = k; if (owner.count == 1) cancel_map_after_result();",
                )
                .replace(
                    "owner.count = kept;",
                    "owner.count = kept; if (owner.count == 1) cancel_map_after_result();",
                );
        assert_ne!(cancelled, runtime);
        let cancelled_probe = probe.replace("static volatile V source_list, input_leaf, input_alias;", "static volatile V source_list, input_leaf, input_alias;\nstatic fwp_task map_cancel;\nstatic void cancel_map_after_result(void) { if (fwp_cur) { fwp_cur->cancelled = 1; fwp_budget = 0; } }").replace("        if (!setjmp(h.jb))", "        memset(&map_cancel, 0, sizeof map_cancel); fwp_cur = &map_cancel; fwp_budget = 1000000;\n#ifdef _WIN32\n        /* This synthetic task executes on main's stack. */\n        map_cancel.ctx.top = fwp_heap.main_top;\n#endif\n        jmp_buf map_cancel_base; map_cancel.base = &map_cancel_base;\n        if (!setjmp(map_cancel_base))").replace("        fwp_handlers = h.prev;", "        map_cancel.base = NULL; fwp_cur = NULL; if (!map_cancel.unwinding) return 8;\n        fwp_handlers = h.prev;");
        for opt in ["-O1", "-O2"] {
            for (case, code, probe) in [
                ("callback", &runtime, &probe),
                ("builder", &builder, &builder_probe),
                ("cancelled", &cancelled, &cancelled_probe),
            ] {
                if mode == "arc" {
                    let missing = probe.replace("fwp_rc_free_obj(input_alias);", "");
                    assert_ne!(&missing, probe);
                    fwp::cgen::compile_c(&format!("{code}\n{missing}"), &exe, opt).unwrap();
                    let out = Command::new(&exe)
                        .env("FWP_GC", "off")
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    record_probe::save(
                        "selection_unwind_ownership",
                        &format!("{mode}{opt}-{case}-missing-release"),
                        &format!("{code}\n{missing}"),
                        &exe,
                        &out,
                    );
                    assert_eq!(out.status.code(), Some(90), "{mode} {opt} {case}: {out:?}");
                }
                let missing_scratch =
                    code.replacen("    if (items) fwp_mem_free(items);", "    (void)items;", 1);
                assert_ne!(&missing_scratch, code);
                fwp::cgen::compile_c(&format!("{missing_scratch}\n{probe}"), &exe, opt).unwrap();
                let out = Command::new(&exe)
                    .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress)
                    .output()
                    .unwrap();
                record_probe::save(
                    "selection_unwind_ownership",
                    &format!("{mode}{opt}-{case}-missing-scratch"),
                    &format!("{missing_scratch}\n{probe}"),
                    &exe,
                    &out,
                );
                assert_eq!(out.status.code(), Some(3), "{mode} {opt} {case}: {out:?}");
                fwp::cgen::compile_c(&format!("{code}\n{probe}"), &exe, opt).unwrap();
                for poison in if mode == "arc" {
                    &["0"][..]
                } else {
                    &["0", "1"][..]
                } {
                    let out = Command::new(&exe)
                        .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    record_probe::save(
                        "selection_unwind_ownership",
                        &format!("{mode}{opt}-{case}-normal-poison{poison}"),
                        &format!("{code}\n{probe}"),
                        &exe,
                        &out,
                    );
                    assert!(
                        out.status.success(),
                        "{mode} {opt} poison={poison}: {out:?}"
                    );
                    assert_eq!(
                        out.stdout,
                        b"selected aliases and scratch release across failed predicates\n"
                    );
                    assert!(out.stderr.is_empty(), "{mode} {opt} {case}: {out:?}");
                }
            }
            checked(
                Command::new(fwp)
                    .args(["build", "--gc", mode, "--memory", "dynamic"])
                    .env("FWP_STACK", "1")
                    .arg(&src)
                    .args([opt, "-o"])
                    .arg(&exe),
            );
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                    .env("FWP_GC_STATS", "0")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress),
            );
            assert_eq!(out.stdout, reference.stdout);
        }
    }
}

#[test]
fn scalar_address_bits_survive_selection_cleanup() {
    let dir = Scratch::new("scalar-bits");
    let src = dir.0.join("scalar.fwp");
    let cfile = dir.0.join("scalar.c");
    let exe = dir.0.join("scalar.exe");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    std::fs::write(&src, SOURCE).unwrap();
    for mode in ["arc", "tracing"] {
        let stress = if mode == "arc" { "0" } else { "1" };
        checked(
            Command::new(fwp)
                .args(["build", "--gc", mode, "--memory", "dynamic"])
                .env("FWP_STACK", "1")
                .arg(&src)
                .args(["--emit-c", "-O2", "-o"])
                .arg(&cfile),
        );
        let emitted = std::fs::read_to_string(&cfile).unwrap();
        let scalar = function_id(&emitted, "scalar");
        let call = format!("fwp_k_filter_owned(fwp_owned_k{scalar},");
        let start = emitted.find(&call).unwrap();
        let arguments = emitted[start..].split(')').next().unwrap();
        assert!(arguments.contains(", NULL, "));
        let list_drop = arguments.rsplit(',').next().unwrap().trim();
        let probe = r#"
static volatile V scalar_word, source;
static fwp_obj scalar_tail = {1, 2, {2, 0}};
static fwp_obj scalar_head = {1, 2, {1, PTR(&scalar_tail)}};
static jmp_buf scalar_trap;
static int recover_scalar(void) { return 1; }
static V address_word(V input) {
    if (input == 2) fwp_trap("scalar result failure");
    return FWP_TRUE;
}
int main(void) {
#ifdef _WIN32
    if (_setmode(_fileno(stdout), _O_BINARY) < 0) return 253;
#endif
    fwp_heap_start(); fwp_fns = fwp_fn_table; fwp_init_consts();
    size_t baseline = fwp_heap.live;
    for (volatile int round=0; round<32; round++) {
    scalar_word = fwp_rc_fresh(fwp_str_new("scalar alias", 12)); scalar_head.f[0] = scalar_word; source = PTR(&scalar_head);
    fwp_trap_recover = recover_scalar; fwp_trap_jb = &scalar_trap; fwp_trap_cleanup = 0;
    if (!setjmp(scalar_trap)) { fwp_k_filter_owned(address_word, ARG_DUP, source, NULL, LIST_DROP); return 1; }
    fwp_trap_recover = NULL; fwp_trap_jb = NULL;
    if (fwp_cleanups || *fwp_rc_slot(scalar_word) != 1 || STR(scalar_word)->len != 12 ||
        memcmp(STR(scalar_word)->d, "scalar alias", 12)) return 2;
    /* A partial result list also contains scalar words, never child owners. */
    V result = fwp_rc_fresh(fwp_data(1, 2, (V[]){scalar_word, 0}));
    LIST_DROP(result);
    if (*fwp_rc_slot(scalar_word) != 1 || STR(scalar_word)->len != 12) return 3;
    fwp_rc_free_obj(scalar_word);
#ifdef FWP_ARC_ONLY
    if (fwp_heap.live != baseline || fwp_heap.rc_wide_len || fwp_heap.ncollect) return 90;
#endif
    }
    puts("scalar address bits remain uncounted on selection failure");
    return 0;
}
"#
    .replace("LIST_DROP", list_drop).replace("ARG_DUP", &format!("fwp_args{scalar}"));
        let runtime = emitted.replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
        for opt in ["-O1", "-O2"] {
            for (case, code, probe) in [("scalar", &runtime, &probe)] {
                if mode == "arc" {
                    let missing = probe.replace("fwp_rc_free_obj(scalar_word);", "");
                    assert_ne!(&missing, probe);
                    fwp::cgen::compile_c(&format!("{code}\n{missing}"), &exe, opt).unwrap();
                    let out = Command::new(&exe)
                        .env("FWP_GC", "off")
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_GC_STRESS", "0")
                        .env("FWP_GC_VERIFY", "0")
                        .env("FWP_REUSE_VERIFY", "0")
                        .output()
                        .unwrap();
                    record_probe::save(
                        "selection_unwind_ownership",
                        &format!("{mode}{opt}-{case}-missing-release"),
                        &format!("{code}\n{missing}"),
                        &exe,
                        &out,
                    );
                    assert_eq!(out.status.code(), Some(90), "{mode} {opt} {case}: {out:?}");
                }

                fwp::cgen::compile_c(&format!("{code}\n{probe}"), &exe, opt).unwrap();
                for poison in if mode == "arc" {
                    &["0"][..]
                } else {
                    &["0", "1"][..]
                } {
                    let out = Command::new(&exe)
                        .env("FWP_GC", if mode == "arc" { "off" } else { "on" })
                        .env("FWP_GC_STATS", "0")
                        .env("FWP_GC_STRESS", stress)
                        .env("FWP_GC_VERIFY", stress)
                        .env("FWP_REUSE_VERIFY", poison)
                        .output()
                        .unwrap();
                    record_probe::save(
                        "selection_unwind_ownership",
                        &format!("{mode}{opt}-{case}-normal-poison{poison}"),
                        &format!("{code}\n{probe}"),
                        &exe,
                        &out,
                    );
                    assert!(
                        out.status.success(),
                        "{mode} {opt} poison={poison}: {out:?}"
                    );
                    assert_eq!(
                        out.stdout,
                        b"scalar address bits remain uncounted on selection failure\n"
                    );
                    assert!(out.stderr.is_empty(), "{mode} {opt} {case}: {out:?}");
                }
            }
        }
    }
}
