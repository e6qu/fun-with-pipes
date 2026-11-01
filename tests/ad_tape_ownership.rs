//! Detached numeric tape buffers follow the runtime unwind chain.
use std::path::PathBuf;
#[path = "support/c_instrument.rs"]
mod c_instrument;
use std::process::{Command, Output};

#[path = "support/record_probe.rs"]
mod record_probe;

struct Scratch(PathBuf);
impl Scratch {
    fn new(name: &str) -> Self {
        let path =
            std::env::temp_dir().join(format!("fwp-ad-unwind-{}-{name}", std::process::id()));
        std::fs::create_dir(&path).unwrap();
        Self(path)
    }
}
impl Drop for Scratch {
    fn drop(&mut self) {
        let _ = std::fs::remove_dir_all(&self.0);
    }
}
fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(
        output.status.success(),
        "{command:?}: {}: {}",
        output.status,
        String::from_utf8_lossy(&output.stderr)
    );
    output
}
const PROBE: &str = include_str!("fixtures/ad_unwind_probe.c");

#[test]
fn detached_tape_buffers_release_on_return_trap_and_cancellation() {
    let scratch = Scratch::new("cleanup");
    let input = scratch.0.join("runtime.fwp");
    let cfile = scratch.0.join("runtime.c");
    std::fs::write(&input, "main = echo \"runtime\"\n").unwrap();

    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "0")
            .args(["build", "--memory", "dynamic", "-O2"])
            .arg(&input)
            .args(["--emit-c", "-o"])
            .arg(&cfile),
    );
    let original = std::fs::read_to_string(&cfile).unwrap();
    let start = original
        .find("/* ------------------------------------------------------------------ tapes */")
        .unwrap();
    let end = original[start..]
        .find("/* ---------------------------------------------------------------- kernels */")
        .unwrap()
        + start;
    let tape_code = c_instrument::calls(&original[start..end], &[("free", "probe_free")])
        .replace("(double *)calloc(", "(double *)probe_calloc(")
        .replace(
            "V r = fwp_arr_new((size_t)tp.leaves);",
            "V r = probe_result_array((size_t)tp.leaves);",
        );
    assert_eq!(tape_code.matches("probe_free(b->").count(), 3);
    let declarations = "static void probe_free(void *);\nstatic void *probe_calloc(size_t,size_t);\nstatic V probe_result_array(size_t);\n";
    let runtime = format!(
        "{}{}{}{}",
        &original[..start],
        declarations,
        tape_code,
        &original[end..]
    )
    .replace(
        "int main(int argc, char **argv)",
        "int original_main(int argc, char **argv)",
    );
    let push = "fwp_cleanup_push(&cleanup, fwp_tape_buffers_release, &buffers);";
    assert_eq!(runtime.matches(push).count(), 1);
    // This control removes the detached-buffer unwind registration only.
    let unprotected = runtime
        .replace(push, "(void)cleanup;")
        .replace(
            "fwp_cleanup_pop(&cleanup);\n        fwp_tape_buffers_release(&buffers);",
            "fwp_tape_buffers_release(&buffers);",
        )
        .replace(
            "fwp_cleanup_pop(&cleanup);\n    fwp_tape_buffers_release(&buffers);",
            "fwp_tape_buffers_release(&buffers);",
        );
    let unchecked = runtime.replace(
        "    if ((ra & 0xffffffff) >= idx || (rb >= 0 && (rb & 0xffffffff) >= idx))\n        fwp_trap(FWP_AD_INVALID_NODE);\n", "");
    assert_ne!(unchecked, runtime);
    let missing_release = runtime.replace("probe_free(b->pa);", "(void)b->pa;");
    // Bypass the cursor too: exhausted generations are excluded by both the
    // release cursor and the scan predicate. This control must actually wrap.
    assert_eq!(
        runtime
            .matches("int64_t slot = fwp_tape_next_slot;")
            .count(),
        1
    );
    let wrapping = runtime
        .replace("int64_t slot = fwp_tape_next_slot;", "int64_t slot = 0;")
        .replace("while (slot < fwp_ntapes && (fwp_tapes[slot].live || fwp_tapes[slot].gen >= 32767)) slot++;", "while (slot < fwp_ntapes && fwp_tapes[slot].live) slot++;")
        .replace("t->gen++;", "t->gen = t->gen % 32767 + 1;");
    assert_ne!(wrapping, runtime);
    let mut cases = vec![
        ("registered", runtime.clone(), PROBE.to_owned(), 0),
        ("unregistered", unprotected, PROBE.to_owned(), 41),
        ("missing-release", missing_release, PROBE.to_owned(), 41),
        ("wrapping", wrapping, PROBE.to_owned(), 46),
        ("unchecked", unchecked, PROBE.to_owned(), 31),
    ];

    for (label, release) in [
        ("input-release-omitted", "fwp_rc_free_arr(seeds);"),
        ("result-release-omitted", "fwp_rc_free_arr(result);"),
    ] {
        let probe = PROBE.replace(release, "/* omitted release */");
        assert_ne!(probe, PROBE);
        cases.push((label, runtime.clone(), probe, 90));
    }

    for opt in ["-O1", "-O2"] {
        for (label, code, probe, expected) in &cases {
            let executable = scratch.0.join(format!("counted{opt}-{label}.exe"));
            let source = format!("{code}\n{probe}");
            fwp::cgen::compile_c(&source, &executable, opt).unwrap();

            let output = Command::new(&executable)
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap();
            let label = format!("counted{opt}-{label}");
            if let Some(directory) = std::env::var_os("FWP_AD_ARTIFACTS") {
                let directory = PathBuf::from(directory);
                std::fs::create_dir_all(&directory).unwrap();
                let prefix = directory.join(&label);
                std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                std::fs::write(prefix.with_extension("c"), &source).unwrap();
                std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                std::fs::write(
                    prefix.with_extension("status"),
                    format!("{}\n", output.status),
                )
                .unwrap();
            }
            record_probe::save("ad_tape_ownership", &label, &source, &executable, &output);
            assert_eq!(output.status.code(), Some(*expected), "{label}: {output:?}");
            assert!(output.stderr.is_empty(), "{label}: {output:?}");
            if *expected == 0 {
                assert_eq!(String::from_utf8_lossy(&output.stdout).replace("\r\n","\n"),"autodiff releases allocated detached buffers on return, trap and task cancellation\n");
            } else {
                assert!(output.stdout.is_empty(), "{label}: {output:?}");
            }
        }
    }
}

#[test]
fn public_tape_tokens_agree_with_raw_interpreter() {
    let scratch = Scratch::new("tokens");
    let input = scratch.0.join("tokens.fwp");
    let common = "one-output : I64 -> Array[I64]\none-output = both id (const []) | uncurry Cons | array.from-list\nfinish : I64 -> Array[F64]\nfinish = make { 0 = id, 1 = add 1 | one-output, 2 = const [1.0] | array.from-list } | uncurry3 ad.backward\n";
    let cases = [
        ("left", "main = 1 | ad.tape | (fn node -> ad.push (node + 1) 1.0 -1 0.0) | echo\n", true),
        ("right", "main = 1 | ad.tape | (fn node -> ad.push node 1.0 (node + 1) 1.0) | echo\n", true),
        ("backward", "main = 1 | ad.tape | finish | echo\n", true),
        ("empty", "empty : I64 -> Array[F64]\nempty = make { 0 = id, 1 = const [] | array.from-list, 2 = const [] | array.from-list } | uncurry3 ad.backward\nmain = 0 | ad.tape | empty | echo\n", false),
        ("paired", "paired : I64 -> Array[F64]\npaired = make { 0 = id, 1 = both id (const []) | uncurry Cons | array.from-list, 2 = const [2.0] | array.from-list } | uncurry3 ad.backward\nmain = 1 | ad.tape | paired | echo\n", false),
    ];
    for (label, source, invalid) in cases {
        // Raw tape handles require a lexical lifetime in checked ARC.
        let (declarations, body) = source.split_once("main = ").unwrap();
        let (value, body) = body.trim().split_once(" | ").unwrap();
        let body = body.strip_suffix(" | echo").unwrap();
        let scoped = format!("{common}{declarations}main = {value} | ad.scope ({body}) | echo\n");
        std::fs::write(&input, &scoped).unwrap();
        let reference = Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input)
            .output()
            .unwrap();
        if invalid {
            assert!(!reference.status.success());
            assert!(
                String::from_utf8_lossy(&reference.stderr).contains("autodiff: invalid node index"),
                "{label}: {}",
                String::from_utf8_lossy(&reference.stderr)
            );
        } else {
            assert!(
                reference.status.success(),
                "{label}: {}",
                String::from_utf8_lossy(&reference.stderr)
            );
        }
        if let Some(directory) = std::env::var_os("FWP_ARC_ARTIFACTS") {
            let directory = PathBuf::from(directory).join("record-ownership/ad_tape_ownership");
            std::fs::create_dir_all(&directory).unwrap();
            let prefix = directory.join(format!("reference-{label}"));
            std::fs::write(prefix.with_extension("fwp"), std::fs::read(&input).unwrap()).unwrap();
            std::fs::write(prefix.with_extension("stdout"), &reference.stdout).unwrap();
            std::fs::write(prefix.with_extension("stderr"), &reference.stderr).unwrap();
            std::fs::write(
                prefix.with_extension("status"),
                format!("{:?}\n", reference.status.code()),
            )
            .unwrap();
        }

        for opt in ["-O1", "-O2"] {
            let executable = scratch.0.join(format!("counted{opt}-{label}.exe"));
            let cfile = executable.with_extension("c");
            for emit in [true, false] {
                let mut command = Command::new(env!("CARGO_BIN_EXE_fwp"));
                command
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", "0")
                    .args(["build", "--memory", "dynamic", opt])
                    .arg(&input);
                if emit {
                    command.arg("--emit-c");
                }
                command
                    .arg("-o")
                    .arg(if emit { &cfile } else { &executable });
                checked(&mut command);
            }
            let code = std::fs::read_to_string(cfile).unwrap();

            let output = Command::new(&executable)
                .env("FWP_AD_WORKSPACE", "0")
                .output()
                .unwrap();
            let label = format!("counted{opt}-semantics-{label}");
            if let Some(directory) = std::env::var_os("FWP_AD_ARTIFACTS") {
                let directory = PathBuf::from(directory);
                std::fs::create_dir_all(&directory).unwrap();
                let prefix = directory.join(&label);
                std::fs::copy(&executable, prefix.with_extension("bin")).unwrap();
                std::fs::write(prefix.with_extension("c"), &code).unwrap();
                std::fs::write(prefix.with_extension("stdout"), &output.stdout).unwrap();
                std::fs::write(prefix.with_extension("stderr"), &output.stderr).unwrap();
                std::fs::write(
                    prefix.with_extension("status"),
                    format!("{}\n", output.status),
                )
                .unwrap();
            }
            record_probe::save("ad_tape_ownership", &label, &code, &executable, &output);
            assert_eq!(
                output.status.code(),
                reference.status.code(),
                "{label}: {output:?}"
            );
            assert_eq!(output.stdout, reference.stdout, "{label}");
            assert_eq!(output.stderr, reference.stderr, "{label}");
        }
    }
}

#[test]
fn scalar_recording_passes_direct_arguments_without_heap_records() {
    let scratch = Scratch::new("scalar-recording");
    let input = scratch.0.join("recording.fwp");
    std::fs::write(&input, include_str!("fixtures/ad_scalar_recording.fwp")).unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    assert_eq!(reference.stdout, b"1\n");
    assert!(reference.stderr.is_empty());

    for (stack, expected_records) in [("0", 0), ("1", 0)] {
        let cfile = scratch.0.join(format!("recording-stack{stack}.c"));
        checked(
            Command::new(compiler)
                .env_remove("FWP_NO_OPT")
                .env("FWP_STACK", stack)
                .args(["build", "--memory", "dynamic", "-O2", "--emit-c"])
                .arg(&input)
                .arg("-o")
                .arg(&cfile),
        );
        let mut code = std::fs::read_to_string(&cfile).unwrap();
        for (needle, replacement) in [
            (
                "static V fwp_record(uint32_t n, const V *f) {".to_owned(),
                "static uint64_t recording_records, recording_calls;\nstatic V fwp_record(uint32_t n, const V *f) {\nif (n == 4) recording_records++;".to_owned(),
            ),
            (
                "static V fwp_p_ad_push(V a, V wa, V b, V wb) {".to_owned(),
                "static V fwp_p_ad_push(V a, V wa, V b, V wb) {\nrecording_calls++;".to_owned(),
            ),
            (
                "    /* Ownership observation point: before runtime teardown. */".to_owned(),
                format!(r#"    /* Ownership observation point: before runtime teardown. */
    if (recording_calls != 256) exit(211);
    if (recording_records != {expected_records}) exit(212);
    if (fwp_heap.live || fwp_heap.rc_wide_len) exit(213);
    for (int64_t i = 0; i < fwp_ntapes; i++) if (fwp_tapes[i].live) exit(214);
    fprintf(stderr, "recording: %llu calls, %llu heap records\n",
        (unsigned long long)recording_calls, (unsigned long long)recording_records);"#),
            ),
        ] {
            assert_eq!(code.matches(&needle).count(), 1, "{needle}");
            code = code.replace(&needle, &replacement);
        }
        for opt in ["-O1", "-O2"] {
            let executable = scratch.0.join(format!("recording-stack{stack}{opt}.exe"));
            fwp::cgen::compile_c(&code, &executable, opt).unwrap();
            for workspace in ["0", "1"] {
                let output = Command::new(&executable)
                    .env("FWP_AD_WORKSPACE", workspace)
                    .output()
                    .unwrap();
                let label = format!("recording-stack{stack}{opt}-workspace{workspace}");
                record_probe::save("ad_tape_ownership", &label, &code, &executable, &output);
                assert!(output.status.success(), "{label}: {output:?}");
                assert_eq!(output.stdout, reference.stdout, "{label}");
                assert_eq!(
                    String::from_utf8(output.stderr)
                        .unwrap()
                        .replace("\r\n", "\n"),
                    format!("recording: 256 calls, {expected_records} heap records\n"),
                    "{label}"
                );
            }
        }
    }
}

#[test]
fn typed_recording_moves_direct_weights_without_argument_records() {
    let scratch = Scratch::new("typed-recording");
    let compiler = env!("CARGO_BIN_EXE_fwp");
    for (name, ty, one, zero) in [
        ("quad", "F128", "1.0f128", "0.0f128"),
        ("nested", "Rev[F64]", "(rev.const 1.0)", "(rev.const 0.0)"),
    ] {
        let input = scratch.0.join(format!("{name}.fwp"));
        let source = include_str!("fixtures/ad_typed_recording.fwp")
            .replace("WEIGHT_TYPE", ty)
            .replace("WEIGHT_ONE", one)
            .replace("WEIGHT_ZERO", zero);
        std::fs::write(&input, source).unwrap();
        let reference = checked(
            Command::new(compiler)
                .env("FWP_NO_OPT", "1")
                .args(["run", "--interp"])
                .arg(&input),
        );
        assert_eq!(reference.stdout, b"True\n");
        assert!(reference.stderr.is_empty());
        for (stack, expected_records) in [("0", 0), ("1", 0)] {
            // Whole-fixture charges from the verified #237 baseline. Counting
            // recording records alone misses allocations in arithmetic callbacks.
            let (max_total, max_peak) = match (name, stack) {
                ("quad", "0") => (30_608, 11_056),
                ("quad", "1") => (18_320, 11_056),
                ("nested", "0") => (96_384, 31_680),
                ("nested", "1") => (43_056, 31_664),
                _ => unreachable!(),
            };
            let cfile = scratch.0.join(format!("{name}-{stack}.c"));
            checked(
                Command::new(compiler)
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_STACK", stack)
                    .args(["build", "--memory", "dynamic", "--emit-c"])
                    .arg(&input)
                    .arg("-o")
                    .arg(&cfile),
            );
            let mut code = std::fs::read_to_string(cfile).unwrap();
            let entry =
                "static V fwp_p_ad_push_owned(V a, V da, V b, V db, const fwp_desc *elem) {";
            assert_eq!(code.matches(entry).count(), 1);
            code = code.replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic unsigned typed_calls, typed_heap_records, typed_recording_started;");
            code = code.replace(entry, &format!("{entry}\n    typed_calls++;"));
            let record = "static V fwp_record(uint32_t n, const V *f) {";
            assert_eq!(code.matches(record).count(), 1);
            code = code.replace(
                record,
                &format!(
                    "{record}\n    if (typed_recording_started && n == 4) typed_heap_records++;"
                ),
            );
            let setup =
                "    V base = fwp_ad_tape_new((V)n, owner);\n    fwp_cleanup_pop(&cleanup);";
            assert_eq!(code.matches(setup).count(), 1);
            code = code.replace(setup, &format!("{setup}\n    typed_recording_started = 1;"));
            let observation = "    /* Ownership observation point: before runtime teardown. */";
            assert_eq!(code.matches(observation).count(), 1);
            code = code.replace(
                observation,
                &format!(
                    r#"{observation}
    fprintf(stderr,"typed recording: %u calls, %u heap records\n",typed_calls,typed_heap_records);
    fprintf(stderr,"typed memory: process peak charged %zu, cumulative charged %.0f, final charged %zu\n",fwp_heap.peak,fwp_heap.total_alloc,fwp_heap.live);
    if (typed_calls != 256 || typed_heap_records != {expected_records}) exit(211);
    if (fwp_heap.total_alloc > {max_total} || fwp_heap.peak > {max_peak}) exit(214);
    if (fwp_owned_tapes || fwp_heap.live || fwp_heap.rc_wide_len) exit(212);
    for (int64_t i=0;i<fwp_ntapes;i++) if (fwp_tapes[i].live) exit(213);
"#
                ),
            );
            for opt in ["-O1", "-O2"] {
                let executable = scratch.0.join(format!("{name}-{stack}{opt}.exe"));
                fwp::cgen::compile_c(&code, &executable, opt).unwrap();
                for workspace in ["0", "1"] {
                    let output = Command::new(&executable)
                        .env("FWP_AD_WORKSPACE", workspace)
                        .output()
                        .unwrap();
                    let label = format!("typed-{name}-stack{stack}{opt}-workspace{workspace}");
                    record_probe::save("ad_tape_ownership", &label, &code, &executable, &output);
                    assert!(output.status.success(), "{label}: {output:?}");
                    assert_eq!(output.stdout, reference.stdout, "{label}");
                    let stderr = String::from_utf8(output.stderr)
                        .unwrap()
                        .replace("\r\n", "\n");
                    let lines = stderr.lines().collect::<Vec<_>>();
                    assert_eq!(lines.len(), 2);
                    assert_eq!(
                        lines[0],
                        format!("typed recording: 256 calls, {expected_records} heap records")
                    );
                    assert!(lines[1].starts_with("typed memory: process peak charged "));
                    assert!(lines[1].ends_with(", final charged 0"));
                }
            }
        }
    }
}

#[test]
fn typed_adjoints_borrow_zero_and_transfer_results_without_extra_owners() {
    let scratch = Scratch::new("typed-adjoints");
    let input = scratch.0.join("runtime.fwp");
    let cfile = scratch.0.join("runtime.c");
    std::fs::write(&input, "main = echo \"runtime\"\n").unwrap();
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .env("FWP_STACK", "1")
            .args(["build", "--memory", "dynamic", "--emit-c"])
            .arg(&input)
            .arg("-o")
            .arg(&cfile),
    );
    let mut code = std::fs::read_to_string(cfile).unwrap();
    for (marker, replacement) in [
        ("static V fwp_p_ad_backward_owned(V base, V outs, V seeds, const fwp_desc *list_type) {",
            "static void typed_begin(int);\nstatic V fwp_p_ad_backward_owned(V base, V outs, V seeds, const fwp_desc *list_type) {"),
        ("    /* The tape owns zero until all slots and result transfers are finished. */",
            "    typed_begin(1);\n    /* The tape owns zero until all slots and result transfers are finished. */"),
        ("    V output_cursor = outs, seed_cursor = seeds;", "    typed_begin(0);\n    V output_cursor = outs, seed_cursor = seeds;"),
        ("    for (int64_t i = tp.leaves; i; i--) {", "    typed_begin(2);\n    for (int64_t i = tp.leaves; i; i--) {"),
        ("    fwp_cleanup_pop(&result_cleanup);\n    fwp_cleanup_pop(&value_cleanup);", "    typed_begin(0);\n    fwp_cleanup_pop(&result_cleanup);\n    fwp_cleanup_pop(&value_cleanup);"),
        ("int main(int argc, char **argv)", "int original_main(int argc, char **argv)"),
    ] {
        assert_eq!(code.matches(marker).count(), 1, "{marker}");
        code = code.replace(marker, replacement);
    }
    code.push_str(include_str!("fixtures/ad_typed_owners_probe.c"));
    let extra_result = "        result.value = fwp_rc_fresh(fwp_cons(value, result.value));\n        fwp_cleanup_pop(&input_cleanup);";
    let zero_drop = "if (owner->adj[i] != owner->zero) owner->elem->drop(owner->adj[i]);";
    assert_eq!(code.matches(extra_result).count(), 1);
    assert_eq!(code.matches(zero_drop).count(), 1);
    let cases = [
        ("owners", code.clone(), 0),
        ("extra-owner", code.replace(extra_result, &format!("{extra_result}\n        typed_begin(0); owner->elem->dup(value); typed_begin(2);")), 188),
        ("drop-borrowed-zero", code.replace(zero_drop, "owner->elem->drop(owner->adj[i]);"), 187),
    ];
    for opt in ["-O1", "-O2"] {
        for (name, source, expected) in &cases {
            let executable = scratch.0.join(format!("{name}{opt}.exe"));
            fwp::cgen::compile_c(source, &executable, opt).unwrap();
            for workspace in ["0", "1"] {
                let output = Command::new(&executable)
                    .env("FWP_AD_WORKSPACE", workspace)
                    .output()
                    .unwrap();
                let label = format!("typed-{name}{opt}-workspace{workspace}");
                record_probe::save("ad_tape_ownership", &label, source, &executable, &output);
                assert_eq!(output.status.code(), Some(*expected), "{label}: {output:?}");
                if *expected == 0 {
                    assert_eq!(String::from_utf8_lossy(&output.stdout).lines().count(), 6);
                    assert!(output.stderr.is_empty());
                }
            }
        }
    }
}
