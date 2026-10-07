//! Escaping closures transfer captures by type and keep retained aliases valid.
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
        let p = std::env::temp_dir().join(format!("fwp-closure-{}-{name}", std::process::id()));
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
fn temporary_stack_arguments_release_owned_children() {
    let dir = Scratch::new("stack-children");
    let fwp = env!("CARGO_BIN_EXE_fwp");
    for (name, functions) in [
        (
            "variant",
            r#"
consume : Option[String] -> I64
consume = match
    None -> 0
    Some _ -> string.length | add 1 | mul 2 | sub 1 | rem 1000003
        | add 7 | mul 5 | rem 999983 | add 11 | mul 13 | rem 999983
        | add 1 | mul 2 | sub 1 | rem 1000003 | add 7 | mul 5
        | rem 999983 | add 11 | mul 13 | rem 999983
score : Option[String] -> I64
score = fork add consume (consume | mul 2 | rem 1009)
size : I64 -> I64
size = rem 64 | add 1 | flip string.repeat "x" | Some | score
"#,
        ),
        (
            "closure",
            r#"
rec twice : (String -> String) -> String -> String
twice = curry (fork apply (fork apply .1 .0) .0)
size : I64 -> I64
size = fork twice (rem 64 | add 1 | flip string.repeat "x" | concat) (const "!") | string.length
"#,
        ),
    ] {
        let src = dir.0.join(format!("{name}.fwp"));
        std::fs::write(
            &src,
            format!(
                r#"{functions}
step : (I64, I64) -> Step[(I64, I64), I64]
step = if (.0 | eq 0) (.1 | Stop)
    (make {{ 0 = .0 | sub 1, 1 = fork add .1 (.0 | size) }} | Again)
main = (10000, 0) | loop step | echo
"#
            ),
        )
        .unwrap();
        let expected = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
        let cfile = dir.0.join(format!("{name}.c"));
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args(["--emit-c", "-o"])
                .arg(&cfile),
        );
        let current = std::fs::read_to_string(&cfile).unwrap();
        // Restore only the previous lifetime of stack-owned children.
        let mut retained = String::new();
        let mut skip = false;
        let mut releases = 0;
        for line in current.lines() {
            if skip {
                assert!(line.trim_start().starts_with("fwp_drop"), "{line}");
                retained.push_str("/* retained stack child */\n");
                skip = false;
                releases += 1;
                continue;
            }
            retained.push_str(line);
            retained.push('\n');
            skip = line.contains("/* stack argument child */");
        }
        assert!(
            releases > 0 && !skip,
            "{name}: stack child release was not generated"
        );
        let mut freed = Vec::new();
        for (label, source) in [("retained", retained), ("released", current)] {
            let exe = dir.0.join(format!("{name}-{label}"));
            fwp::cgen::compile_c(&source, &exe, "-O1").unwrap();
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC", "off")
                    .env("FWP_GC_STATS", "1"),
            );
            assert_eq!(out.stdout, expected.stdout);
            let stats = String::from_utf8_lossy(&out.stderr);
            assert!(stats.contains("fwp gc: 0 collections"), "{stats}");
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
        assert!(
            freed[1] > freed[0] + 0.2,
            "{name}: retained/released frees {freed:?}"
        );
        eprintln!(
            "{name} stack child MiB freed by counts: {} -> {}",
            freed[0], freed[1]
        );
    }
}

#[test]
fn stack_children_and_returned_aliases_under_collection() {
    let dir = Scratch::new("stack-aliases");
    let src = dir.0.join("aliases.fwp");
    std::fs::write(
        &src,
        r#"
rec extract : Option[String] -> String
extract = match
    None -> "empty"
    Some _ -> if (string.length | eq 0) (const None | extract) id
rec pair : (String -> String) -> String -> (String, String)
pair = curry (make { 0 = fork apply .1 .0, 1 = .0 | apply "!" })
rec optional : (String -> String) -> String -> Option[String]
optional = curry (fork apply .1 .0 | Some)
use-twice : String -> (String, String)
use-twice = concat | both (apply "A") (apply "B")
main = [
    read-all () | concat "héllo" | both (Some | extract) id | echo,
    pair (read-all () | concat "P" | concat) "X" | both (.0 | string.length) .1 | echo,
    optional (read-all () | concat "Q" | concat) "Y" | option.unwrap-or "missing" | echo,
    read-all () | concat "local" | use-twice | echo,
] | ignore
"#,
    )
    .unwrap();
    let fwp = env!("CARGO_BIN_EXE_fwp");
    let expected = checked(Command::new(fwp).args(["run", "--interp"]).arg(&src));
    for opt in ["-O1", "-O2"] {
        let exe = dir.0.join(opt);
        checked(
            Command::new(fwp)
                .arg("build")
                .arg(&src)
                .args([opt, "-o"])
                .arg(&exe),
        );
        for poison in ["0", "1"] {
            let out = checked(
                Command::new(&exe)
                    .env("FWP_GC_STRESS", "1")
                    .env("FWP_GC_VERIFY", "1")
                    .env("FWP_REUSE_VERIFY", poison),
            );
            assert_eq!(out.stdout, expected.stdout, "{opt}, poison {poison}");
        }
    }
}
