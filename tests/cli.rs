//! Command-line programs: `tests/cli/app.fwp` built as a multi-command
//! executable (`fwp build --cli`) and as single functions (`--fn`),
//! `tests/cli/features.fwp` (enumerations, environment variables,
//! optional arguments, exit statuses, completion scripts and man pages),
//! `tests/cli/docs.fwp` (doc comments) and the CLIs of `examples/cli`.
//! Every scenario runs with the interpreter (`fwp exec`) and natively,
//! with identical output and exit codes.

use std::path::{Path, PathBuf};
use std::process::{Command, Stdio};

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn root() -> PathBuf {
    PathBuf::from(env!("CARGO_MANIFEST_DIR"))
}

fn app() -> PathBuf {
    root().join("tests/cli/app.fwp")
}

fn have_cc() -> bool {
    Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok()
}

fn scratch(name: &str) -> PathBuf {
    let dir = std::env::temp_dir().join(format!("fwp-cli-{}-{}", name, std::process::id()));
    let _ = std::fs::remove_dir_all(&dir);
    std::fs::create_dir_all(&dir).unwrap();
    dir
}

/// Run a command line with stdin in `dir`; stdout, stderr and the exit
/// code as one string.
fn run(cmd: Command, args: &[&str], stdin: &str, dir: &Path) -> String {
    run_env(cmd, args, stdin, &[], dir)
}

/// `run` with environment variables.
fn run_env(
    mut cmd: Command,
    args: &[&str],
    stdin: &str,
    env: &[(&str, &str)],
    dir: &Path,
) -> String {
    use std::io::Write;
    for v in [
        "FWP_OUT",
        "NO_COLOR",
        "FEATURES_FORMAT",
        "FEATURES_COUNT",
        "FEATURES_QUIET",
    ] {
        cmd.env_remove(v);
    }
    let mut child = cmd
        .args(args)
        .envs(env.iter().copied())
        .current_dir(dir)
        .stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .spawn()
        .unwrap();
    child
        .stdin
        .take()
        .unwrap()
        .write_all(stdin.as_bytes())
        .unwrap();
    let out = child.wait_with_output().unwrap();
    format!(
        "{}{}code={}",
        String::from_utf8_lossy(&out.stdout),
        String::from_utf8_lossy(&out.stderr),
        out.status.code().unwrap_or(-1)
    )
}

/// How to run a program: `fwp exec` (with its arguments before the
/// program's), or a native executable.
enum Runner {
    Interp(Vec<String>),
    Native(PathBuf),
}

impl Runner {
    fn command(&self) -> Command {
        match self {
            Runner::Interp(pre) => {
                let mut c = Command::new(fwp());
                c.arg("exec").args(pre);
                c
            }
            Runner::Native(exe) => Command::new(exe),
        }
    }
}

fn build(src: &Path, opts: &[&str], out: &Path) {
    let o = Command::new(fwp())
        .arg("build")
        .arg(src)
        .args(opts)
        .arg("-O1")
        .arg("-o")
        .arg(out)
        .output()
        .unwrap();
    assert!(
        o.status.success(),
        "build {} {:?}: {}",
        src.display(),
        opts,
        String::from_utf8_lossy(&o.stderr)
    );
}

const PROGRAM_HELP: &str = "\
usage: app <command> [arguments...]

A program to test command-line executables (tests/cli.rs).

commands:
  repeat     Repeat a word.
  add-all    Add numbers given as arguments.
  divide     Divide the second number by the first.
  even       Keep the even numbers.
  shout
  norm       The length of a vector, given as flags or as a record.
  greet
  status     Exit with a status.
  hello      Say hello (a final `()` parameter is not an argument).
  noop
  read-text
  help       show the help of a command

options:
  -h, --help                 show this help
      --version              show the version
      --completions <SHELL>  print a completion script for bash, zsh or fish
      --man                  print a man page

Run `app help <command>` for the arguments of a command.
";

const REPEAT_HELP: &str = "\
usage: app repeat [options] WORD

Repeat a word. Then stop.

The word is repeated `--times` times, followed by the extra words.

arguments:
  WORD  String, or one per line of standard input

options:
  -v, --verbose         say what is repeated
  -n, --times <I64>     how many times (default: 2)
      --label <String>  a label for the output
  -e, --extra <String>  extra words (repeatable)
      --sep <String>    the separator (default: \",\")
  -h, --help            show this help
      --version         show the version
";

const REPEAT_USAGE: &str = "\
usage: app repeat [options] WORD
  (the last argument may instead be given as records on stdin)
";

/// (arguments, stdin, expected output) of the multi-command program.
fn app_cases() -> Vec<(Vec<&'static str>, &'static str, String)> {
    let c = |args: &[&'static str], stdin: &'static str, want: &str| {
        (args.to_vec(), stdin, want.to_string())
    };
    vec![
        c(&[], "", &format!("{}code=2", PROGRAM_HELP)),
        c(&["--help"], "", &format!("{}code=0", PROGRAM_HELP)),
        c(&["help"], "", &format!("{}code=0", PROGRAM_HELP)),
        c(&["-h"], "", &format!("{}code=0", PROGRAM_HELP)),
        c(&["--version"], "", "app 2.1.0\ncode=0"),
        c(&["help", "repeat"], "", &format!("{}code=0", REPEAT_HELP)),
        c(&["repeat", "--help"], "", &format!("{}code=0", REPEAT_HELP)),
        c(&["repeat", "-n", "1", "-h"], "", &format!("{}code=0", REPEAT_HELP)),
        c(&["repeat", "--version"], "", "app 2.1.0\ncode=0"),
        // flags: defaults, short and long forms, `=`, bundles, `--`
        c(&["repeat", "hi"], "", "hi,hi\ncode=0"),
        c(
            &["repeat", "-v", "hi", "-n3", "--sep=-", "-e", "x", "--extra", "y"],
            "",
            "repeating: hi-hi-hi-x-y\ncode=0",
        ),
        c(&["repeat", "--label", "L", "-vn", "1", "hi"], "", "L: hi\ncode=0"),
        c(&["repeat", "--no-verbose", "-v", "--no-verbose", "a"], "", "a,a\ncode=0"),
        c(&["repeat", "--verbose=true", "a"], "", "repeating: a,a\ncode=0"),
        c(&["repeat", "--", "-v"], "", "-v,-v\ncode=0"),
        c(&["repeat", "-n", "1", "-5"], "", "-5\ncode=0"),
        c(&["repeat", "--sep", "", "a"], "", "aa\ncode=0"),
        // streaming: the last argument from stdin, the flags still apply
        c(&["repeat", "-n", "1", "--label", "x", "-v"], "a\nb\n", "x: a\nx: b\ncode=0"),
        // usage errors
        c(
            &["repeat", "-x", "a"],
            "",
            &format!("app repeat: unknown option `-x`\n{}code=2", REPEAT_USAGE),
        ),
        c(
            &["repeat", "--times"],
            "",
            &format!("app repeat: option `--times` needs a value\n{}code=2", REPEAT_USAGE),
        ),
        c(
            &["repeat", "--times=x", "a"],
            "",
            &format!(
                "app repeat: option `--times`: cannot parse `x` as I64\n{}code=2",
                REPEAT_USAGE
            ),
        ),
        c(
            &["repeat", "--no-times", "a"],
            "",
            &format!("app repeat: unknown option `--no-times`\n{}code=2", REPEAT_USAGE),
        ),
        c(
            &["repeat", "--verbose=yes", "a"],
            "",
            &format!(
                "app repeat: option `--verbose`: cannot parse `yes` as Bool\n{}code=2",
                REPEAT_USAGE
            ),
        ),
        c(&["repeat", "a", "b"], "", &format!("{}code=2", REPEAT_USAGE)),
        c(
            &["nope"],
            "",
            "app: unknown command `nope`\nusage: app <command> [arguments...]\n  (`app help` lists the commands)\ncode=2",
        ),
        c(
            &["help", "nope"],
            "",
            "app: unknown command `nope`\nusage: app <command> [arguments...]\n  (`app help` lists the commands)\ncode=2",
        ),
        // the remaining arguments as a list
        c(&["add-all", "1", "2", "-3", "10"], "", "10\ncode=0"),
        c(&["add-all"], "5\n", "0\ncode=0"),
        c(
            &["add-all", "1", "x"],
            "",
            "app add-all: argument 2: cannot parse `x` as I64\ncode=2",
        ),
        // Result: Err is an error (exit 1); Option: None prints nothing
        c(&["divide", "2", "9"], "", "4\ncode=0"),
        c(&["divide", "0", "9"], "", "app divide: division by zero\ncode=1"),
        c(&["divide", "3"], "9\n0\n", "3\n0\ncode=0"),
        c(&["divide", "0"], "9\n", "app divide: division by zero\ncode=1"),
        c(&["even"], "1\n2\n3\n4\n", "2\n4\ncode=0"),
        // Error effect: reported with the command's name, exit 1
        c(&["shout"], "a\n\nb\n", "A\napp shout: nothing to shout\ncode=1"),
        c(
            &["read-text", "missing.txt"],
            "",
            "app read-text: missing.txt: No such file or directory\ncode=1",
        ),
        // a record parameter: flags, a record argument, or records on stdin
        c(&["norm", "--x", "3", "--y=4"], "", "5.0\ncode=0"),
        c(&["norm", "{x = 3.0, y = 4.0}"], "", "5.0\ncode=0"),
        c(&["norm"], "{x = 6.0, y = 8.0}\n", "10.0\ncode=0"),
        c(
            &["norm", "--x", "1"],
            "",
            "app norm: missing option `--y`\nusage: app norm [options]\ncode=2",
        ),
        c(&["greet", "--name", "Bob", "-s"], "", "HELLO, BOB\ncode=0"),
        c(&["greet", "--name=Ann"], "", "hello, Ann\ncode=0"),
        // exit statuses and unit results
        c(&["status", "4"], "", "code=4"),
        c(&["noop", "3"], "", "code=0"),
        c(&["hello"], "", "hello\ncode=0"),
        c(&["hello", "x"], "", "usage: app hello\ncode=2"),
    ]
}

fn check_app(r: &Runner) {
    for (args, stdin, want) in app_cases() {
        let got = run(r.command(), &args, stdin, &root());
        assert_eq!(got, want, "app {:?} <<< {:?}", args, stdin);
    }
}

#[test]
fn multi_command_program() {
    let interp = Runner::Interp(vec!["--cli".into(), app().to_string_lossy().into()]);
    check_app(&interp);
    if !have_cc() {
        return;
    }
    let dir = scratch("app");
    let exe = dir.join("app");
    build(&app(), &["--cli"], &exe);
    check_app(&Runner::Native(exe.clone()));
    // the binary protocol between commands: `even` writes I64 records
    let sh = format!(
        "printf '4\\n5\\n8\\n' | FWP_OUT=bin {exe} even | {exe} divide 2",
        exe = exe.display()
    );
    let out = Command::new("sh").arg("-c").arg(&sh).output().unwrap();
    assert_eq!(String::from_utf8_lossy(&out.stdout), "2\n4\n");
    let _ = std::fs::remove_dir_all(&dir);
}

const RENDER_HELP: &str = "\
usage: features render [options] WORD [DIR]

Show the options and the arguments.

arguments:
  WORD  String
  DIR   String, default: \".\"

options:
  -f, --format <FORMAT>  how to write the result (one of: plain, json, csv-lines; default: plain; env: FEATURES_FORMAT)
  -n, --count <COUNT>    how many copies (default: 1; env: FEATURES_COUNT)
  -q, --quiet            say less (env: FEATURES_QUIET)
  -o, --output <FILE>    where to write (not with --quiet)
  -a, --append           add to the end of the file (requires --output)
  -h, --help             show this help
";

const RENDER_USAGE: &str = "usage: features render [options] WORD [DIR]\n";

const PICK_HELP: &str = "\
usage: features pick NAME [FORMAT]

A format, or none.

arguments:
  NAME    String
  FORMAT  Format, one of: plain, json, csv-lines, optional

options:
  -h, --help  show this help
";

type FeatureCase = (
    Vec<&'static str>,
    &'static str,
    Vec<(&'static str, &'static str)>,
    String,
);

/// (arguments, stdin, environment, expected) of `tests/cli/features.fwp`.
fn feature_cases() -> Vec<FeatureCase> {
    let c = |args: &[&'static str], env: &[(&'static str, &'static str)], want: &str| {
        (args.to_vec(), "", env.to_vec(), want.to_string())
    };
    vec![
        c(&["help", "render"], &[], &format!("{}code=0", RENDER_HELP)),
        c(&["pick", "-h"], &[], &format!("{}code=0", PICK_HELP)),
        // enumerations: any case, kebab-case or not; defaults
        c(&["render", "w"], &[], "Plain 1 False None w .\ncode=0"),
        c(&["render", "w", "-f", "json", "/tmp"], &[], "Json 1 False None w /tmp\ncode=0"),
        c(
            &["render", "w", "-f", "CSV_LINES", "-n", "2", "-o", "out.txt", "d"],
            &[],
            "CsvLines 2 False Some \"out.txt\" w d\ncode=0",
        ),
        c(
            &["render", "w", "--format=csvlines"],
            &[],
            "CsvLines 1 False None w .\ncode=0",
        ),
        c(
            &["render", "w", "-f", "xml"],
            &[],
            &format!(
                "features render: option `--format`: `xml` is not one of plain, json, csv-lines\n{}code=2",
                RENDER_USAGE
            ),
        ),
        // environment variables: flag > environment > default
        c(
            &["render", "w"],
            &[("FEATURES_FORMAT", "json"), ("FEATURES_COUNT", "7"), ("FEATURES_QUIET", "1")],
            "Json 7 True None w .\ncode=0",
        ),
        c(
            &["render", "w", "-f", "plain", "--no-quiet"],
            &[("FEATURES_FORMAT", "json"), ("FEATURES_QUIET", "true")],
            "Plain 1 False None w .\ncode=0",
        ),
        c(&["render", "w"], &[("FEATURES_COUNT", "")], "Plain 1 False None w .\ncode=0"),
        c(
            &["render", "w"],
            &[("FEATURES_COUNT", "many")],
            &format!(
                "features render: environment variable `FEATURES_COUNT`: cannot parse `many` as I64\n{}code=2",
                RENDER_USAGE
            ),
        ),
        c(
            &["render", "w"],
            &[("FEATURES_FORMAT", "xml")],
            &format!(
                "features render: environment variable `FEATURES_FORMAT`: `xml` is not one of plain, json, csv-lines\n{}code=2",
                RENDER_USAGE
            ),
        ),
        // options that conflict or go together
        c(
            &["render", "w", "-q", "-o", "f"],
            &[],
            &format!(
                "features render: option `--output` cannot be used with `--quiet`\n{}code=2",
                RENDER_USAGE
            ),
        ),
        c(
            &["render", "w", "-o", "f"],
            &[("FEATURES_QUIET", "true")],
            &format!(
                "features render: option `--output` cannot be used with `--quiet`\n{}code=2",
                RENDER_USAGE
            ),
        ),
        c(
            &["render", "w", "-a"],
            &[],
            &format!(
                "features render: option `--append` needs `--output`\n{}code=2",
                RENDER_USAGE
            ),
        ),
        c(
            &["render", "w", "-ao", "f"],
            &[],
            "Plain 1 False Some \"f\" w .\ncode=0",
        ),
        // optional arguments: none of them comes from stdin
        c(&["render"], &[], &format!("{}code=2", RENDER_USAGE)),
        c(&["render", "a", "b", "c"], &[], &format!("{}code=2", RENDER_USAGE)),
        c(&["pick", "x"], &[], "x: None\ncode=0"),
        c(&["pick", "x", "JSON"], &[], "x: Some Json\ncode=0"),
        c(
            &["pick", "x", "json-lines"],
            &[],
            "features pick: argument 2: `json-lines` is not one of plain, json, csv-lines\ncode=2",
        ),
        // exit statuses
        c(&["search", "a"], &[], "code=1"),
        c(&["search", "a", "ab", "b", "ca"], &[], "ab\nca\ncode=0"),
        c(&["leave", "300"], &[], "bye\ncode=44"),
        c(&["leave", "-1"], &[], "bye\ncode=255"),
        (vec!["check"], "1\n-2\n3\n", vec![], "1\n-2\n3\ncode=3".into()),
        (vec!["check"], "4\n", vec![], "4\ncode=0".into()),
        // completion scripts and the man page
        c(
            &["--completions"],
            &[],
            "features: option `--completions` needs a value (bash, zsh or fish)\ncode=2",
        ),
        c(
            &["--completions", "tcsh"],
            &[],
            "features: unknown shell `tcsh` (bash, zsh or fish)\ncode=2",
        ),
        c(&["render", "--man"], &[], &format!("features render: unknown option `--man`\n{}code=2", RENDER_USAGE)),
    ]
}

fn features() -> PathBuf {
    root().join("tests/cli/features.fwp")
}

/// The output of a program (its stdout), which must succeed.
fn output(mut cmd: Command, args: &[&str]) -> String {
    let o = cmd.args(args).env_remove("FWP_OUT").output().unwrap();
    assert!(
        o.status.success(),
        "{:?}: {}",
        args,
        String::from_utf8_lossy(&o.stderr)
    );
    String::from_utf8(o.stdout).unwrap()
}

#[test]
fn enumerations_environment_and_statuses() {
    let interp = Runner::Interp(vec!["--cli".into(), features().to_string_lossy().into()]);
    let mut runners = vec![interp];
    let dir = scratch("features");
    if have_cc() {
        let exe = dir.join("features");
        build(&features(), &["--cli"], &exe);
        runners.push(Runner::Native(exe));
    }
    let mut texts = Vec::new();
    for r in &runners {
        for (args, stdin, env, want) in feature_cases() {
            let got = run_env(r.command(), &args, stdin, &env, &root());
            assert_eq!(
                got, want,
                "features {:?} <<< {:?} with {:?}",
                args, stdin, env
            );
        }
        // the generated texts are the same in both backends
        let mut t = Vec::new();
        for args in [
            &["--completions", "bash"][..],
            &["--completions=zsh"],
            &["--completions", "fish"],
            &["--man"],
        ] {
            t.push(output(r.command(), args));
        }
        texts.push(t);
    }
    if texts.len() == 2 {
        assert_eq!(
            texts[0], texts[1],
            "completion scripts and man pages differ"
        );
    }
    let man = &texts[0][3];
    assert!(man.starts_with(".TH FEATURES 1 "), "{}", man);
    for part in [
        ".SH COMMANDS",
        ".SS features render [options] WORD [DIR]",
        ".SH ENVIRONMENT",
        "FEATURES_COUNT",
    ] {
        assert!(man.contains(part), "man page without {:?}", part);
    }
    check_bash(&texts[0][0], &dir);
    check_other_shells(&texts[0][1], &texts[0][2], &dir);
    let _ = std::fs::remove_dir_all(&dir);
}

/// The bash script parses, and completes like bash would with the words
/// of a command line (`COMP_WORDS`; bash splits `--opt=value` in three).
fn check_bash(script: &str, dir: &Path) {
    let Ok(v) = Command::new("bash").arg("--version").output() else {
        return;
    };
    if !v.status.success() {
        return;
    }
    let file = dir.join("features.bash");
    std::fs::write(&file, script).unwrap();
    let o = Command::new("bash").arg("-n").arg(&file).output().unwrap();
    assert!(
        o.status.success(),
        "bash -n: {}",
        String::from_utf8_lossy(&o.stderr)
    );
    std::fs::create_dir_all(dir.join("cdir/sub")).unwrap();
    std::fs::write(dir.join("cdir/file.txt"), "").unwrap();
    let cases: &[(&[&str], &str)] = &[
        (&["features", ""], "render pick search leave check help"),
        (&["features", "re"], "render"),
        (&["features", "--c"], "--completions"),
        (&["features", "--completions", ""], "bash zsh fish"),
        (&["features", "help", "p"], "pick"),
        (&["features", "render", "--f"], "--format"),
        (
            &["features", "render", "--format", ""],
            "plain json csv-lines",
        ),
        (&["features", "render", "-f", "c"], "csv-lines"),
        (&["features", "render", "--format", "=", "j"], "json"),
        (&["features", "render", "-o", "cdir/f"], "cdir/file.txt"),
        (&["features", "render", "w", "cdir/s"], "cdir/sub"),
        (&["features", "render", "-n", "3", "w", "cdir/"], "cdir/sub"),
        (
            &["features", "render", "--count", "=", "3", "w", "cdir/s"],
            "cdir/sub",
        ),
        (&["features", "render", ""], ""),
        (&["features", "pick", "a", "c"], "csv-lines"),
        (&["features", "search", "-"], "--help -h"),
    ];
    let mut sim = format!("source {}\n", file.display());
    sim.push_str("c() { COMP_WORDS=(\"$@\"); COMP_CWORD=$((${#COMP_WORDS[@]} - 1)); COMPREPLY=(); _fwp_features; echo \"${COMPREPLY[*]}\"; }\n");
    for (words, _) in cases {
        let quoted: Vec<String> = words.iter().map(|w| format!("'{}'", w)).collect();
        sim.push_str(&format!("c {}\n", quoted.join(" ")));
    }
    let o = Command::new("bash")
        .arg("-c")
        .arg(&sim)
        .current_dir(dir)
        .output()
        .unwrap();
    let got = String::from_utf8_lossy(&o.stdout);
    let lines: Vec<&str> = got.lines().collect();
    assert_eq!(
        lines.len(),
        cases.len(),
        "{}{}",
        got,
        String::from_utf8_lossy(&o.stderr)
    );
    for ((words, want), line) in cases.iter().zip(lines) {
        let mut g: Vec<&str> = line.split_whitespace().collect();
        let mut w: Vec<&str> = want.split_whitespace().collect();
        g.sort();
        w.sort();
        assert_eq!(g, w, "completing {:?}", words);
    }
}

/// The zsh and fish scripts parse, when those shells are installed.
fn check_other_shells(zsh: &str, fish: &str, dir: &Path) {
    for (shell, script, check) in [("zsh", zsh, "-n"), ("fish", fish, "--no-execute")] {
        if Command::new(shell).arg("--version").output().is_err() {
            continue;
        }
        let file = dir.join(format!("features.{}", shell));
        std::fs::write(&file, script).unwrap();
        let o = Command::new(shell).arg(check).arg(&file).output().unwrap();
        assert!(
            o.status.success(),
            "{} {}: {}",
            shell,
            check,
            String::from_utf8_lossy(&o.stderr)
        );
    }
}

/// `process.call` writes on stderr when the program's output is the
/// binary protocol (`FWP_OUT=bin`).
#[test]
fn called_programs_keep_the_protocol_clean() {
    let src = root().join("tests/cli/relay.fwp");
    let mut runners = vec![Runner::Interp(vec![
        src.to_string_lossy().into(),
        "relay".into(),
    ])];
    let dir = scratch("relay");
    if have_cc() {
        let exe = dir.join("relay");
        build(&src, &["--fn", "relay"], &exe);
        runners.push(Runner::Native(exe));
    }
    for r in &runners {
        let o = r
            .command()
            .args(["echo", "called"])
            .env("FWP_OUT", "bin")
            .output()
            .unwrap();
        assert!(o.status.success());
        assert!(o.stdout.starts_with(b"FWP1"));
        assert!(!String::from_utf8_lossy(&o.stdout).contains("called"));
        assert_eq!(String::from_utf8_lossy(&o.stderr), "called\n");
        let o = r
            .command()
            .args(["echo", "called"])
            .env_remove("FWP_OUT")
            .output()
            .unwrap();
        assert_eq!(String::from_utf8_lossy(&o.stdout), "called\n0\n");
    }
    let _ = std::fs::remove_dir_all(&dir);
}

const COUNT_HELP: &str = "\
usage: docs count-words [options] [WORDS...]

Count words.

The signature spans several lines.

arguments:
  WORDS...  String, any number

options:
  -m, --limit <LIMIT>  stop at this many words (env: DOCS_LIMIT)
  -u, --unique         count each word once
  -h, --help           show this help
";

/// Doc comments come from the syntax tree: signatures on several lines,
/// `rec` signatures exported later, records declared after their use or
/// in other modules.
#[test]
fn doc_comments() {
    let src = root().join("tests/cli/docs.fwp");
    let mut runners = vec![Runner::Interp(vec![
        "--cli".into(),
        src.to_string_lossy().into(),
    ])];
    let dir = scratch("docs");
    if have_cc() {
        let exe = dir.join("docs");
        build(&src, &["--cli"], &exe);
        runners.push(Runner::Native(exe));
    }
    let cases: Vec<(Vec<&str>, String)> = vec![
        (vec!["help", "count-words"], format!("{}code=0", COUNT_HELP)),
        (vec!["count-words", "-u", "a", "b", "a"], "2\ncode=0".into()),
        (
            vec!["help", "countdown"],
            "usage: docs countdown N\n\nCount down from N.\n\narguments:\n  N  I64, or one per line of standard input\n\noptions:\n  -h, --help  show this help\ncode=0".into(),
        ),
        (
            vec!["help", "say"],
            "usage: docs say [options] [WORD]\n\nSay something in a style.\n\narguments:\n  WORD  String, default: \"hello\"\n\noptions:\n  -l, --loud  in capitals\n  -h, --help  show this help\ncode=0".into(),
        ),
        (vec!["say", "-l"], "HELLO\ncode=0".into()),
        (vec!["say", "bye"], "bye\ncode=0".into()),
    ];
    for r in &runners {
        for (args, want) in &cases {
            assert_eq!(
                &run(r.command(), args, "", &root()),
                want,
                "docs {:?}",
                args
            );
        }
    }
    let _ = std::fs::remove_dir_all(&dir);
}

#[test]
fn single_function_executables() {
    let cases: Vec<(&str, Vec<&str>, &str, String)> = vec![
        (
            "repeat-word",
            vec!["-n", "3", "x"],
            "",
            "x,x,x\ncode=0".into(),
        ),
        (
            "repeat-word",
            vec!["--help"],
            "",
            format!("{}code=0", REPEAT_HELP.replace("app repeat", "repeat")),
        ),
        (
            "repeat-word",
            vec!["--version"],
            "",
            "repeat 2.1.0\ncode=0".into(),
        ),
        (
            "repeat-word",
            vec!["--bad"],
            "",
            format!(
                "repeat: unknown option `--bad`\n{}code=2",
                REPEAT_USAGE.replace("app repeat", "repeat")
            ),
        ),
        (
            "divide",
            vec!["0", "1"],
            "",
            "divide: division by zero\ncode=1".into(),
        ),
        ("even", vec![], "7\n10\n", "10\ncode=0".into()),
    ];
    let dir = scratch("single");
    let native = have_cc();
    for (f, args, stdin, want) in &cases {
        let interp = Runner::Interp(vec![app().to_string_lossy().into(), f.to_string()]);
        assert_eq!(
            &run(interp.command(), args, stdin, &dir),
            want,
            "exec {} {:?}",
            f,
            args
        );
        if native {
            let exe = dir.join(f);
            if !exe.exists() {
                build(&app(), &["--fn", f], &exe);
            }
            let got = run(Runner::Native(exe).command(), args, stdin, &dir);
            assert_eq!(&got, want, "native {} {:?}", f, args);
        }
    }
    // a single command has completion scripts and a man page too
    let interp = Runner::Interp(vec![app().to_string_lossy().into(), "repeat-word".into()]);
    let bash = output(interp.command(), &["--completions", "bash"]);
    assert!(
        bash.contains("complete -o filenames -F _fwp_repeat 'repeat'"),
        "{}",
        bash
    );
    assert!(
        bash.contains("'--verbose -v --times -n --label --extra -e --sep --help -h --version'"),
        "{}",
        bash
    );
    let man = output(interp.command(), &["--man"]);
    assert!(
        man.starts_with(".TH REPEAT 1 \"\" \"repeat 2.1.0\""),
        "{}",
        man
    );
    if native {
        let exe = dir.join("repeat-word");
        assert_eq!(output(Command::new(&exe), &["--completions", "bash"]), bash);
        assert_eq!(output(Command::new(&exe), &["--man"]), man);
    }
    let _ = std::fs::remove_dir_all(&dir);
}

/// The CLIs of `examples/cli`, natively and with `fwp exec`, in a scratch
/// directory with a few files.
#[test]
fn example_clis() {
    let dir = scratch("examples");
    std::fs::create_dir_all(dir.join("tree/sub")).unwrap();
    std::fs::create_dir_all(dir.join("tree/.hidden")).unwrap();
    std::fs::write(dir.join("a.txt"), "one two\nthree\n").unwrap();
    std::fs::write(dir.join("b.txt"), "Apple pie\nbanana\napple\n").unwrap();
    std::fs::write(dir.join("tree/x.rs"), "fn main() {}\n").unwrap();
    std::fs::write(dir.join("tree/sub/y.rs"), "1234567890\n").unwrap();
    std::fs::write(dir.join("tree/sub/notes.md"), "# notes\n").unwrap();
    std::fs::write(dir.join("tree/.hidden/z.rs"), "hidden\n").unwrap();
    std::fs::write(
        dir.join("people.csv"),
        "name,city,age\nAnn,Paris,31\n\"Bob, Jr\",Oslo,45\nCid,\"New\nYork\",28\n",
    )
    .unwrap();
    let ex = |f: &str| root().join("examples/cli").join(f);
    // (file, --fn or None for --cli, arguments, stdin, expected)
    type Case = (
        &'static str,
        Option<&'static str>,
        Vec<&'static str>,
        &'static str,
        &'static str,
    );
    let cases: Vec<Case> = vec![
        (
            "wc.fwp",
            Some("wc"),
            vec!["a.txt"],
            "",
            "      2      3     14 a.txt\ncode=0",
        ),
        (
            "wc.fwp",
            Some("wc"),
            vec!["-lw", "a.txt", "b.txt"],
            "",
            "      2      3 a.txt\n      3      4 b.txt\n      5      7 total\ncode=0",
        ),
        (
            "wc.fwp",
            Some("wc"),
            vec!["-c"],
            "hello\n",
            "      6\ncode=0",
        ),
        (
            "wc.fwp",
            Some("wc"),
            vec!["nope.txt"],
            "",
            "wc: nope.txt: No such file or directory\ncode=1",
        ),
        (
            "grep.fwp",
            Some("grep"),
            vec!["-i", "apple", "b.txt"],
            "",
            "Apple pie\napple\ncode=0",
        ),
        (
            "grep.fwp",
            Some("grep"),
            vec!["-n", "an", "a.txt", "b.txt"],
            "",
            "b.txt:2:banana\ncode=0",
        ),
        (
            "grep.fwp",
            Some("grep"),
            vec!["-vc", "e"],
            "a\nbe\nc\n",
            "2\ncode=0",
        ),
        (
            "grep.fwp",
            Some("grep"),
            vec!["zzz", "a.txt"],
            "",
            "code=1",
        ),
        (
            "grep.fwp",
            Some("grep"),
            vec!["-c", "zzz", "a.txt"],
            "",
            "0\ncode=1",
        ),
        (
            "dirstat.fwp",
            Some("dirstat"),
            vec!["tree"],
            "",
            "extension  files  bytes\nrs         2      24\nmd         1      8\ncode=0",
        ),
        (
            "dirstat.fwp",
            Some("dirstat"),
            vec!["--sort", "name", "tree"],
            "",
            "extension  files  bytes\nmd         1      8\nrs         2      24\ncode=0",
        ),
        (
            "dirstat.fwp",
            Some("dirstat"),
            vec!["-s", "Files", "-n", "2"],
            "",
            "extension  files  bytes\nrs         2      24\ntxt        2      37\ncode=0",
        ),
        (
            "csvtool.fwp",
            None,
            vec!["columns", "people.csv"],
            "",
            "  1  name\n  2  city\n  3  age\ncode=0",
        ),
        (
            "csvtool.fwp",
            None,
            vec!["show", "-n", "2", "people.csv"],
            "",
            "name     city   age\nAnn      Paris  31\nBob, Jr  Oslo   45\ncode=0",
        ),
        (
            "csvtool.fwp",
            None,
            vec!["cut", "-c", "city", "-c", "name", "--format", "csv"],
            "name,city\nAnn,Paris\n\"Bob, Jr\",Oslo\n",
            "city,name\nParis,Ann\nOslo,\"Bob, Jr\"\ncode=0",
        ),
        (
            "csvtool.fwp",
            None,
            vec!["cut", "-c", "zip", "people.csv"],
            "",
            "csvtool cut: there is no column `zip`\ncode=1",
        ),
        (
            "csvtool.fwp",
            None,
            vec!["show", "-f", "xml"],
            "",
            "csvtool show: option `--format`: `xml` is not one of table, csv, tsv\nusage: csvtool show [options] [FILE]\ncode=2",
        ),
        ("todo.fwp", None, vec!["list"], "", "code=0"),
        (
            "todo.fwp",
            None,
            vec!["add", "buy", "milk"],
            "",
            "added\ncode=0",
        ),
        (
            "todo.fwp",
            None,
            vec!["add", "write", "docs"],
            "",
            "added\ncode=0",
        ),
        (
            "todo.fwp",
            None,
            vec!["done", "1"],
            "",
            "item 1 is done\ncode=0",
        ),
        (
            "todo.fwp",
            None,
            vec!["list"],
            "",
            "  1. [x] buy milk\n  2. [ ] write docs\ncode=0",
        ),
        (
            "todo.fwp",
            None,
            vec!["done", "3"],
            "",
            "todo done: there is no item 3\ncode=1",
        ),
        ("todo.fwp", None, vec!["clear"], "", "cleared\ncode=0"),
        (
            "todo.fwp",
            None,
            vec!["list", "-f", "other.txt"],
            "",
            "code=0",
        ),
        (
            "todo.fwp",
            None,
            vec!["list"],
            "",
            "  1. [ ] write docs\ncode=0",
        ),
        (
            "todo.fwp",
            None,
            vec!["--version"],
            "",
            "todo 1.0.0\ncode=0",
        ),
    ];
    let native = have_cc();
    for (round, runner_native) in [(0, false), (1, true)] {
        if runner_native && !native {
            break;
        }
        let _ = std::fs::remove_file(dir.join("todo.txt"));
        for (file, func, args, stdin, want) in &cases {
            let r = if runner_native {
                // a multi-command program is named after its file
                let stem = file.trim_end_matches(".fwp");
                let name = func.unwrap_or(stem);
                // in a hidden directory, which `dirstat` skips
                let bin = dir.join(".bin");
                let exe = bin.join(format!("{}-exe", name));
                if !exe.exists() {
                    std::fs::create_dir_all(&bin).unwrap();
                    match func {
                        Some(f) => build(&ex(file), &["--fn", f], &exe),
                        None => build(&ex(file), &["--cli"], &bin.join(stem)),
                    }
                    if func.is_none() {
                        std::fs::rename(bin.join(stem), &exe).unwrap();
                    }
                }
                Runner::Native(exe)
            } else {
                match func {
                    Some(f) => {
                        Runner::Interp(vec![ex(file).to_string_lossy().into(), f.to_string()])
                    }
                    None => Runner::Interp(vec!["--cli".into(), ex(file).to_string_lossy().into()]),
                }
            };
            let got = run(r.command(), args, stdin, &dir);
            assert_eq!(&got, want, "round {}: {} {:?}", round, file, args);
        }
        // the file of `todo` from the environment
        let todo = if runner_native {
            Runner::Native(dir.join(".bin/todo-exe"))
        } else {
            Runner::Interp(vec![
                "--cli".into(),
                ex("todo.fwp").to_string_lossy().into(),
            ])
        };
        let env = [("TODO_FILE", "env.txt")];
        let got = run_env(todo.command(), &["add", "from", "env"], "", &env, &dir);
        assert_eq!(got, "added\ncode=0");
        let got = run_env(todo.command(), &["list"], "", &env, &dir);
        assert_eq!(got, "  1. [ ] from env\ncode=0");
        let got = run_env(todo.command(), &["list", "-f", "todo.txt"], "", &env, &dir);
        assert_eq!(got, "  1. [ ] write docs\ncode=0");
        let _ = std::fs::remove_file(dir.join("env.txt"));
    }
    let _ = std::fs::remove_dir_all(&dir);
}
