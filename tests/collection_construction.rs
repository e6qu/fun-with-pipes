//! Numeric collection construction preserves values and callback order.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn mapped_numeric_collections_agree_with_raw_interpreter() {
    let directory = fwp::cgen::TempDir::new("collection-construction").unwrap();
    let input = directory.join("collections.fwp");
    // Arithmetic NaN signs are implementation dependent. Parsed NaNs and neg
    // supply identical key bits, testing both signs and duplicate NaN keys.
    std::fs::write(
        &input,
        r#"
nan : F64
nan = "NaN" | parse-float | match
    Some -> id
    None -> "test NaN parsing failed" | prim.trap
nan32 : F32
nan32 = "NaN" | parse-float | match
    Some -> id
    None -> "test NaN parsing failed" | prim.trap
key : I64 -> I64
key = rem 3
pair : I64 -> (I64, I64)
pair = fork (curry id) key id
captured-pair : String -> I64 -> (I64, I64)
captured-pair = curry (fork (curry id) (.0 | string.length) .1)
string-pair : String -> (I64, I64)
string-pair = fork (curry id) string.length (string.length | add 1)
choose : Bool -> (I64 -> (I64, I64))
choose = if id (const pair) (const (fork (curry id) id id))
choose-key : Bool -> (I64 -> I64)
choose-key = if id (const key) (const id)
captured-key : String -> I64 -> I64
captured-key = curry (fork add (.0 | string.length) .1)
main = [
    [0, 1, 2, 3, 4] | map key | set.from-list | set.to-list | echo,
    [0, 1, 2, 3, 4] | map pair | map.from-list | map.to-list | echo,
    [] | map key | set.from-list | set.to-list | echo,
    [] | map pair | map.from-list | map.to-list | echo,
    range -3 4 | map key | set.from-list | set.to-list | echo,
    range -3 4 | map pair | map.from-list | map.to-list | echo,
    range 3 -3 | map (tap echo | key) | set.from-list | set.to-list | echo,
    range 3 3 | map (tap echo | pair) | map.from-list | map.to-list | echo,
    range -9223372036854775808 -9223372036854775806 | map id | set.from-list | set.to-list | echo,
    range 9223372036854775805 9223372036854775807 | map (fork (curry id) id id) | map.from-list | map.to-list | echo,
    [1i8, -2i8, 127i8, 1i8] | map id | set.from-list | set.to-list | echo,
    [0u64, 18446744073709551615u64, 0u64] | map id | set.from-list | set.to-list | echo,
    [0.0, -0.0, 1.5, nan, nan | neg, nan] | map id | set.from-list | set.to-list | echo,
    [0.0f32, -0.0f32, 1.5f32, nan32, nan32 | neg, nan32] | map (fork (curry id) id (mul 2.0f32)) | map.from-list | map.to-list | echo,
    ["a", "héllo", ""] | both (map string.length | set.from-list | set.to-list) id | echo,
    ["a", "héllo", ""] | both (map string-pair | map.from-list | map.to-list) id | echo,
    range 0 4 | map (captured-pair ("prefix" | concat "!")) | map.from-list | map.to-list | echo,
    range 0 4 | map (choose (read-all () | string.length | eq 0)) | map.from-list | map.to-list | echo,
    range 0 4 | map (choose-key (read-all () | string.length | eq 0)) | set.from-list | set.to-list | echo,
    range 0 4 | map (captured-key (read-all () | concat "prefix")) | set.from-list | set.to-list | echo,
    [0, 1, 2, 3] | map (captured-key (read-all () | concat "prefix")) | set.from-list | set.to-list | echo,
    range (0 | tap echo) (4 | tap echo) | map (captured-pair ("capture" | tap echo)) | map.from-list | map.to-list | echo,
    range (3 | tap echo) (3 | tap echo) | map (captured-pair ("empty capture" | tap echo)) | map.from-list | map.to-list | echo,
    range (0 | tap echo) (4 | tap echo) | map (add (1 | tap echo)) | set.from-list | set.to-list | echo,
    range 0 4 | map (tap echo | key) | set.from-list | set.to-list | echo,
    range 0 4 | map (tap echo | pair) | map.from-list | map.to-list | echo
] | ignore
"#,
    )
    .unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for fused in ["0", "1"] {
        let interpreted = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_MAP_BUILD", fused)
                .args(["run", "--interp"])
                .arg(&input),
        );
        assert_eq!(
            interpreted.stdout, reference.stdout,
            "interpreter fused={fused}"
        );
        assert_eq!(
            interpreted.stderr, reference.stderr,
            "interpreter fused={fused}"
        );
    }

    for optimization in ["-O1", "-O2"] {
        for fused in ["0", "1"] {
            let executable = directory
                .join(format!("counted{optimization}-{fused}"))
                .with_extension(std::env::consts::EXE_EXTENSION);
            checked(
                Command::new(env!("CARGO_BIN_EXE_fwp"))
                    .env_remove("FWP_NO_OPT")
                    .env("FWP_MAP_BUILD", fused)
                    .args(["build", optimization, "-o"])
                    .arg(&executable)
                    .arg(&input),
            );
            let output = checked(&mut Command::new(&executable));
            assert_eq!(
                output.stdout, reference.stdout,
                "counted {optimization} fused={fused}"
            );
            assert_eq!(
                output.stderr, reference.stderr,
                "counted {optimization} fused={fused}"
            );
        }
    }
}

#[test]
fn failed_numeric_collection_callbacks_release_storage() {
    let directory = fwp::cgen::TempDir::new("collection-failures").unwrap();
    let input = directory.join("failures.fwp");
    let mut source = String::new();
    let mut cases = Vec::new();
    // Fail before the first result, in the middle, after earlier duplicates,
    // or never. Catching the error must release buffers and allow later work.
    for stop in [0, 2, 3, 9] {
        source.push_str(&format!("step{stop} : I64 -> I64 ! {{Error[String]}}\nstep{stop} = if (eq {stop}) (const \"expected\" | fail) (rem 2)\npair{stop} : I64 -> (I64, I64) ! {{Error[String]}}\npair{stop} = fork (curry id) step{stop} id\n"));
        for producer in ["range 0", "const [0, 1, 2, 3]"] {
            for (callback, consumer) in [
                ("step", "set.from-list | set.to-list"),
                ("pair", "map.from-list | map.to-list"),
            ] {
                cases.push(format!(
                    "4 | attempt ({producer} | map {callback}{stop} | {consumer}) | echo"
                ));
            }
        }
    }
    source.push_str("captured : String -> I64 -> (I64, I64) ! {Error[String]}\ncaptured = curry (if (.1 | eq 2) (.0 | fail) (fork (curry id) (.0 | string.length) .1))\n");
    source.push_str("captured-key : String -> I64 -> I64 ! {Error[String]}\ncaptured-key = curry (if (.1 | eq 2) (.0 | fail) (fork add (.0 | string.length) .1))\n");
    cases.push("4 | range 0 | attempt (map pair2 | map.from-list) | echo".into());
    cases.push("4 | range 0 | attempt (map step2 | array.from-list) | echo".into());
    for _ in 0..4 {
        cases.push("4 | attempt (range 0 | map (captured (read-all () | concat \"callback failure\")) | map.from-list) | echo".into());
        for producer in ["range 0", "const [0, 1, 2, 3]"] {
            cases.push(format!("4 | attempt ({producer} | map (captured-key (read-all () | concat \"callback failure\")) | set.from-list) | echo"));
        }
    }
    source.push_str(&format!("main = [{}] | ignore\n", cases.join(",\n")));
    std::fs::write(&input, source).unwrap();
    let reference = checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&input),
    );
    for fused in ["0", "1"] {
        let interpreted = checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_MAP_BUILD", fused)
                .args(["run", "--interp"])
                .arg(&input),
        );
        assert_eq!(
            interpreted.stdout, reference.stdout,
            "interpreter fused={fused}"
        );

        let cfile = directory.join("failures.c");
        checked(
            Command::new(env!("CARGO_BIN_EXE_fwp"))
                .env_remove("FWP_NO_OPT")
                .env("FWP_MAP_BUILD", fused)
                .args(["build", "--emit-c", "-o"])
                .arg(&cfile)
                .arg(&input),
        );
        let mut code = std::fs::read_to_string(&cfile).unwrap();

        let finish = "\n    /* Ownership observation point: before runtime teardown. */\n";
        assert_eq!(code.matches(finish).count(), 1);
        code = code.replace(finish, &format!("{finish}\n    if (0 != fwp_heap.live) {{ fprintf(stderr, \"collection storage leaked: %lld bytes\\n\", (long long)(fwp_heap.live)); exit(231); }}\n"));

        for optimization in ["-O1", "-O2"] {
            let executable = directory
                .join("failures")
                .with_extension(std::env::consts::EXE_EXTENSION);
            fwp::cgen::compile_c(&code, &executable, optimization).unwrap();
            let output = checked(&mut Command::new(&executable));
            assert_eq!(
                output.stdout, reference.stdout,
                "counted {optimization} fused={fused}"
            );
            assert_eq!(
                output.stderr, reference.stderr,
                "counted {optimization} fused={fused}"
            );
        }
    }
}

fn save_evidence(name: &str, bytes: &[u8]) {
    if let Some(path) = std::env::var_os("FWP_COLLECTION_ARTIFACTS") {
        let path = std::path::PathBuf::from(path);
        std::fs::create_dir_all(&path).unwrap();
        std::fs::write(path.join(name), bytes).unwrap();
    }
}

fn function_id<'a>(code: &'a str, name: &str) -> &'a str {
    let start = code.find(&format!("/* {name} :")).unwrap();
    code[start..]
        .split("static V f")
        .nth(1)
        .unwrap()
        .split('(')
        .next()
        .unwrap()
}

fn allocation_probe(mut code: String) -> String {
    let mut probe = include_str!("fixtures/collection_build_probe.c").to_string();
    for (placeholder, name, prefix) in [
        ("MAP_RANGE", "map._map-range", "f"),
        ("SET_RANGE", "set._map-range", "f"),
        ("MAP_LIST", "map._map-list", "f"),
        ("SET_LIST", "set._map-list", "f"),
        ("PAIR_CALLBACK", "pair", "fc"),
        ("KEY_CALLBACK", "key", "fc"),
    ] {
        probe = probe.replace(
            placeholder,
            &format!("{prefix}{}", function_id(&code, name)),
        );
    }
    // Retain the actual emitted direct-worker bodies, isolating them from
    // main's unrelated literal list construction and output.
    let mut direct = String::new();
    for (kind, marker) in [
        ("map", "{ /* numeric map: direct callback fields */"),
        ("set", "{ /* numeric set: direct callback */"),
    ] {
        let bodies = code
            .match_indices(marker)
            .map(|(start, _)| {
                let declaration = code[..start].trim_end().lines().last().unwrap();
                let result = declaration
                    .trim()
                    .strip_prefix("V ")
                    .unwrap()
                    .trim_end_matches(';');
                let end = start
                    + code[start..]
                        .find(&format!("{result} = result;\n}}"))
                        .unwrap()
                    + format!("{result} = result;\n}}").len();
                (
                    result.to_string(),
                    format!("{declaration}\n{}\nreturn {result};", &code[start..end]),
                )
            })
            .collect::<Vec<_>>();
        assert_eq!(bodies.len(), 2);
        for ((_, body), name) in bodies.into_iter().zip(["range", "list"]) {
            let mut body = body;
            if name == "list" {
                let input = body
                    .split("fwp_list_len(")
                    .nth(1)
                    .unwrap()
                    .split(')')
                    .next()
                    .unwrap()
                    .to_string();
                body = body
                    .replace(
                        &format!("fwp_list_len({input})"),
                        "fwp_list_len(build_input)",
                    )
                    .replace(&format!("V xs = {input};"), "V xs = build_input;");
            }
            direct.push_str(&format!(
                "static V build_direct_{kind}_{name}(void) {{\n{body}\n}}\n"
            ));
        }
    }
    code = code
        .replace("#define FWP_UNWIND 0", "#define FWP_UNWIND 1")
        .replace(
            "int main(int argc, char **argv)",
            "int original_main(int argc, char **argv)",
        );
    code.push_str(&direct);
    // Every mapped element passes this point in both dynamic and direct code.
    assert_eq!(code.matches("V input = ").count(), 12);
    code = code.replace("V input = ", "build_callback(); V input = ");
    for (name, replacement) in [
        ("fwp_heap_alloc", "build_allocate"),
        ("fwp_alloc_init", "build_allocate_init"),
    ] {
        let header = if name == "fwp_heap_alloc" {
            "size_t n, int kind"
        } else {
            "size_t n"
        };
        let definition = format!("static inline void *{name}({header}) {{");
        assert_eq!(code.matches(&definition).count(), 1);
        code = code.replace(
            &definition,
            &format!("static inline void *{replacement}({header}) {{"),
        );
        let start = code
            .find(&format!("static inline void *{replacement}("))
            .unwrap();
        let end = start + code[start..].find("\n}\n").unwrap() + 3;
        let body = code[start..end].replace("fwp_heap_alloc(n, 0)", "build_allocate(n, 0)");
        code.replace_range(start..end, &body);
        let arguments = if name == "fwp_heap_alloc" {
            "n, kind"
        } else {
            "n"
        };
        code.insert_str(start + body.len(), &format!("\nstatic inline void *{name}({header}) {{ build_tick(); void *p = {replacement}({arguments}); build_record(p); return p; }}\n"));
    }
    for (from, to, count) in [
        (
            "static inline void fwp_rc_dup(V v) {\n",
            "static inline void fwp_rc_dup(V v) { build_tick();\n",
            1,
        ),
        (
            "static void fwp_mem_free(void *p) {\n",
            "static void fwp_mem_free(void *p) { build_release(p);\n",
            1,
        ),
    ] {
        assert_eq!(code.matches(from).count(), count, "{from}");
        code = code.replace(from, to);
    }
    format!("static void build_tick(void); static void build_record(void *); static void build_release(void *); static void build_callback(void);\n{code}\n{probe}")
        .replace("typedef uint64_t V;", "typedef uint64_t V;\nstatic V build_input;")
}

#[test]
fn collection_allocation_failures_and_cancellation_release_every_owner() {
    let directory = fwp::cgen::TempDir::new("collection-allocation-failures").unwrap();
    let input = directory.join("builders.fwp");
    std::fs::write(&input, include_str!("fixtures/collection_build.fwp")).unwrap();

    let cfile = directory.join("builders.c");
    checked(
        Command::new(env!("CARGO_BIN_EXE_fwp"))
            .env_remove("FWP_NO_OPT")
            .env("FWP_MAP_BUILD", "1")
            .args(["build", "--emit-c", "-o"])
            .arg(&cfile)
            .arg(&input),
    );
    let code = allocation_probe(std::fs::read_to_string(cfile).unwrap());
    save_evidence("failures-counted.c", code.as_bytes());
    for optimization in ["-O1", "-O2"] {
        let binary = directory
            .join("probe")
            .with_extension(std::env::consts::EXE_EXTENSION);
        fwp::cgen::compile_c(&code, &binary, optimization).unwrap();
        save_evidence(
            &format!("failures-counted{optimization}.bin"),
            &std::fs::read(&binary).unwrap(),
        );

        let output = checked(&mut Command::new(&binary));
        let text = String::from_utf8(output.stdout).unwrap();
        save_evidence(
            &format!("failures-counted{optimization}.txt"),
            text.as_bytes(),
        );
        assert!(text.starts_with("8 builders: "), "{text}");
        assert!(
            text.ends_with(
                " allocation failures and 64 callback exits cleaned; aliases preserved\n"
            ),
            "{text}"
        );
        eprint!("counted {optimization}: {text}");

        // Disabling scratch release must make the allocation ledger fail.
        let broken = code.replace(
            "static void fwp_scratch_release(void *arg) {",
            "static void fwp_scratch_release(void *arg) { (void)arg; return;",
        );
        assert_ne!(broken, code);
        save_evidence("missing-cleanup-counted.c", broken.as_bytes());
        fwp::cgen::compile_c(&broken, &binary, optimization).unwrap();
        save_evidence(
            &format!("missing-cleanup-counted{optimization}.bin"),
            &std::fs::read(&binary).unwrap(),
        );
        let output = Command::new(&binary).output().unwrap();
        assert_eq!(output.status.code(), Some(213), "{output:?}");
        assert!(String::from_utf8_lossy(&output.stderr).contains("collection live allocations:"));
        save_evidence(
            &format!("missing-cleanup-counted{optimization}.txt"),
            &output.stderr,
        );
    }
}
