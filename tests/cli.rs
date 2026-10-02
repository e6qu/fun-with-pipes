//! Command-line programs: `tests/cli/app.fwp` built as a multi-command
//! executable (`fwp build --cli`) and as single functions (`--fn`), and
//! the CLIs of `examples/cli`. Every scenario runs with the interpreter
//! (`fwp exec`) and natively, with identical output and exit codes.

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
fn run(mut cmd: Command, args: &[&str], stdin: &str, dir: &Path) -> String {
    use std::io::Write;
    let mut child = cmd
        .args(args)
        .current_dir(dir)
        .env_remove("FWP_OUT")
        .env_remove("NO_COLOR")
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
  -h, --help     show this help
      --version  show the version

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
            "dirstat.fwp",
            Some("dirstat"),
            vec!["tree"],
            "",
            "extension  files  bytes\nrs         2      24\nmd         1      8\ncode=0",
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
                let name = func.unwrap_or("todo");
                let exe = dir.join(format!("{}-exe", name));
                if !exe.exists() {
                    match func {
                        Some(f) => build(&ex(file), &["--fn", f], &exe),
                        None => build(&ex(file), &["--cli"], &dir.join("todo")),
                    }
                    if func.is_none() {
                        std::fs::rename(dir.join("todo"), &exe).unwrap();
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
    }
    let _ = std::fs::remove_dir_all(&dir);
}
