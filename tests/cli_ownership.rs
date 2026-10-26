//! CLI reconstruction owns repeated/overwritten values and partial records.
use std::process::{Command, Output};

fn checked(command: &mut Command) -> Output {
    let output = command.output().unwrap();
    assert!(output.status.success(), "{command:?}: {output:?}");
    output
}

#[test]
fn cli_parsing_and_help_reclaim_owned_temporaries() {
    let dir = fwp::cgen::TempDir::new("fwp-cli-ownership").unwrap();
    let source = dir.join("cli.fwp");
    std::fs::write(
        &source,
        r#"
Level = | Low | VeryHigh
Options = {
    title: String,
    tag: List[String],
    # a user [requires: password]
    user: Option[String],
    password: Option[String],
    # anonymous mode [conflicts: user, password]
    anonymous: Bool,
    level: Level,
    next: Option[Level],
    wide: I128,
    quad: F128,
}
defaults : Options
defaults = Options {
    title = "default", tag = ["first", "second"],
    user = None, password = None, anonymous = False,
    level = Low, next = Some VeryHigh, wide = 17i128, quad = 0.1f128,
}
parse : List[String] -> Result[(Options, List[String]), String]
parse = cli.parse defaults
cases = [
    [],
    ["--title=a", "--title=second", "--tag=a", "--tag=b", "word", "more"],
    ["--title=first", "--title=second", "--tag=a", "--tag=b", "--bogus"],
    ["--user=first", "--user=second"],
    ["--user=ann", "--password=x"],
    ["--anonymous", "--password=x"],
    ["--next=low", "--next=very-high", "--level=not-a-level"],
    ["--wide=340282366920938463463374607431768211455"],
    ["--wide=42", "--wide=17", "--quad=0.2", "--quad=0.1"],
    ["--", "--title=x", "1", "2", "3", "4", "5", "6", "7", "8", "9"],
]
main = [
    cases | map parse | echo,
    defaults | cli.help | write,
    defaults | with { user = Some "name", password = Some "secret" } | cli.help | write,
    ["x"] | cli.parse 3 | echo,
] | ignore
"#,
    )
    .unwrap();
    let compiler = env!("CARGO_BIN_EXE_fwp");
    let reference = checked(
        Command::new(compiler)
            .env("FWP_NO_OPT", "1")
            .args(["run", "--interp"])
            .arg(&source),
    );
    for mode in ["tracing", "arc"] {
        let cfile = dir.join(format!("{mode}.c"));
        checked(
            Command::new(compiler)
                .args(["build", "--gc", mode, "--emit-c"])
                .arg(&source)
                .arg("-o")
                .arg(&cfile),
        );
        let code = std::fs::read_to_string(cfile).unwrap();
        let start = code
            .find("static void *fwp_main_thread(void *arg) {")
            .unwrap();
        let (runtime, main) = code.split_at(start);
        let measured = if mode == "arc" {
            format!("{runtime}{}", main
                .replace("    fwp_init_consts();\n", "    fwp_init_consts();\n    size_t cli_live_bytes=fwp_heap.live;\n")
                .replace("    /* Ownership observation point: before runtime teardown. */\n", "    /* Ownership observation point: before runtime teardown. */\n    if(fwp_heap.ncollect || fwp_heap.enabled || fwp_heap.live > cli_live_bytes) { fprintf(stderr,\"CLI bytes left: %ld\\n\",(long)(fwp_heap.live - cli_live_bytes)); exit(193); }\n"))
        } else {
            code
        };
        for opt in ["-O1", "-O2"] {
            let binary = dir.join(if cfg!(windows) { "cli.exe" } else { "cli" });
            fwp::cgen::compile_c(&measured, &binary, opt).unwrap();
            let stress = if mode == "arc" { "0" } else { "1" };
            let output = checked(
                Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", stress)
                    .env("FWP_GC_VERIFY", stress)
                    .env("FWP_REUSE_VERIFY", stress),
            );
            assert_eq!(output.stdout, reference.stdout, "{mode} {opt}");
            assert_eq!(output.stderr, reference.stderr, "{mode} {opt}");
            if mode == "arc" {
                let release = "if (state[k] && f->value->drop) f->value->drop(vals[k]);";
                assert_eq!(measured.matches(release).count(), 1);
                fwp::cgen::compile_c(
                    &measured.replace(release, "/* omit displaced flag release */"),
                    &binary,
                    opt,
                )
                .unwrap();
                let output = Command::new(&binary)
                    .env_remove("FWP_GC")
                    .env("FWP_GC_STRESS", "0")
                    .env("FWP_GC_VERIFY", "0")
                    .env("FWP_REUSE_VERIFY", "0")
                    .output()
                    .unwrap();
                assert_eq!(
                    output.status.code(),
                    Some(193),
                    "omitted flag release: {output:?}"
                );
            }
        }
    }
}
