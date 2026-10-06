//! The tutorials (docs/tutorials/*/): each `main.fwp` runs with the
//! interpreter and natively and must print its `main.out`; each
//! ```console block of a README is a shell session, run in a copy of the
//! tutorial's directory with `fwp` on the `PATH`, whose commands must
//! print what the block shows; and each README must show its programs
//! and only code taken from them. The other examples must type-check.
//! `FWP_BLESS=1` regenerates the outputs (and the sessions' outputs in
//! the READMEs).

use std::path::{Path, PathBuf};
use std::process::Command;

fn fwp() -> PathBuf {
    PathBuf::from(env!("CARGO_BIN_EXE_fwp"))
}

fn examples() -> PathBuf {
    Path::new(env!("CARGO_MANIFEST_DIR")).join("examples")
}

/// The tutorials with a `main.fwp`.
fn tutorials() -> Vec<PathBuf> {
    let mut v: Vec<PathBuf> = tutorial_dirs()
        .into_iter()
        .map(|d| d.join("main.fwp"))
        .filter(|p| p.exists())
        .collect();
    v.sort();
    v
}

fn tutorial_dirs() -> Vec<PathBuf> {
    let dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("docs/tutorials");
    let mut v: Vec<PathBuf> = std::fs::read_dir(dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.join("README.md").exists())
        .collect();
    v.sort();
    v
}

/// The fwp files of a directory.
fn fwp_files(dir: &Path) -> Vec<PathBuf> {
    let mut v: Vec<PathBuf> = std::fs::read_dir(dir)
        .unwrap()
        .map(|e| e.unwrap().path())
        .filter(|p| p.extension().is_some_and(|e| e == "fwp"))
        .collect();
    v.sort();
    v
}

/// The bodies of the fenced code blocks of a language in a Markdown file.
fn code_blocks(md: &str, lang: &str) -> Vec<String> {
    let mut out = Vec::new();
    let mut cur: Option<String> = None;
    for line in md.lines() {
        match &mut cur {
            None if line.trim_start() == format!("```{}", lang) => cur = Some(String::new()),
            Some(_) if line.trim_start() == "```" => out.push(cur.take().unwrap()),
            Some(b) => {
                b.push_str(line);
                b.push('\n');
            }
            None => {}
        }
    }
    out
}

#[test]
fn tutorial_readmes_match_their_programs() {
    for dir in tutorial_dirs() {
        let readme = std::fs::read_to_string(dir.join("README.md")).unwrap();
        let mut lines: Vec<String> = Vec::new();
        for path in fwp_files(&dir) {
            let program = std::fs::read_to_string(&path).unwrap();
            assert!(
                readme.contains(program.trim_end()),
                "{}: README must show {}",
                dir.display(),
                path.file_name().unwrap().to_string_lossy()
            );
            lines.extend(program.lines().map(|l| l.trim_end().to_string()));
        }
        if let Ok(output) = std::fs::read_to_string(dir.join("main.out")) {
            assert!(
                readme.contains(output.trim_end()),
                "{}: README must show main.out",
                dir.display()
            );
        }
        for block in code_blocks(&readme, "fwp") {
            assert!(
                block
                    .lines()
                    .filter(|l| !l.trim().is_empty())
                    .all(|l| lines.iter().any(|p| p == l.trim_end())),
                "{}: README code not in its programs:\n{}",
                dir.display(),
                block
            );
        }
    }
}

// ---------------------------------------------------------------- sessions

/// A command of a console session and what it prints (stdout and stderr).
/// A command ending in `&` runs in the background, and prints its first
/// lines (such as `listening on ...`) before the session goes on.
#[derive(Debug)]
struct Step {
    command: String,
    background: bool,
    output: String,
}

/// The steps of a ```console block: `$ command` lines (continued by lines
/// ending in `\` or by `> ` lines, as in a shell), each followed by its
/// output.
fn session(block: &str) -> Vec<Step> {
    let mut steps: Vec<Step> = Vec::new();
    let mut lines = block.lines().peekable();
    while let Some(line) = lines.next() {
        if let Some(cmd) = line.strip_prefix("$ ") {
            let mut command = cmd.to_string();
            while command.ends_with('\\') {
                match lines.next() {
                    Some(l) => {
                        command.push('\n');
                        command.push_str(l);
                    }
                    None => break,
                }
            }
            while let Some(l) = lines.peek().and_then(|l| l.strip_prefix("> ")) {
                command.push('\n');
                command.push_str(l);
                lines.next();
            }
            let background = command.ends_with(" &");
            if background {
                command.truncate(command.len() - 2);
            }
            steps.push(Step {
                command,
                background,
                output: String::new(),
            });
        } else if let Some(s) = steps.last_mut() {
            s.output.push_str(line);
            s.output.push('\n');
        }
    }
    steps
}

fn copy_dir(from: &Path, to: &Path) {
    std::fs::create_dir_all(to).unwrap();
    for e in std::fs::read_dir(from).unwrap() {
        let p = e.unwrap().path();
        let dest = to.join(p.file_name().unwrap());
        if p.is_dir() {
            copy_dir(&p, &dest);
        } else {
            std::fs::copy(&p, &dest).unwrap();
        }
    }
}

/// Background commands of a session, killed with their process group.
struct Background(Vec<std::process::Child>);

impl Drop for Background {
    fn drop(&mut self) {
        for child in &mut self.0 {
            let _ = Command::new("kill")
                .args(["-TERM", "--", &format!("-{}", child.id())])
                .output();
            let _ = child.wait();
        }
    }
}

fn shell(dir: &Path, path: &str, command: &str) -> Command {
    let mut c = Command::new("sh");
    c.arg("-c")
        .arg(format!("exec 2>&1\n{}", command))
        .current_dir(dir)
        .env("PATH", path)
        .env("NO_COLOR", "1")
        .env_remove("FWP_REST_ADDR")
        .env_remove("FWP_TLS_CERT")
        .env_remove("FWP_TLS_KEY");
    c
}

/// Run the sessions of a README in a copy of its directory: the outputs
/// they print, by block and step.
fn run_sessions(dir: &Path, blocks: &[Vec<Step>]) -> Vec<Vec<String>> {
    use std::os::unix::process::CommandExt;
    let work = std::env::temp_dir().join(format!(
        "fwp-session-{}-{}",
        std::process::id(),
        dir.file_name().unwrap().to_string_lossy()
    ));
    let _ = std::fs::remove_dir_all(&work);
    copy_dir(dir, &work);
    let bin = fwp().parent().unwrap().to_path_buf();
    let path = format!(
        "{}:{}",
        bin.display(),
        std::env::var("PATH").unwrap_or_default()
    );
    let bless = std::env::var("FWP_BLESS").is_ok();
    let mut background = Background(Vec::new());
    let mut out = Vec::new();
    // the exit status of the last command, for `echo $?`
    let mut status = 0;
    for (b, steps) in blocks.iter().enumerate() {
        let mut outputs = Vec::new();
        for (i, step) in steps.iter().enumerate() {
            if step.background {
                let log = work.join(format!(".session-{}-{}.log", b, i));
                let file = std::fs::File::create(&log).unwrap();
                let child = shell(&work, &path, &step.command)
                    .stdout(file)
                    .process_group(0)
                    .spawn()
                    .unwrap();
                background.0.push(child);
                // wait for the lines it should print (when blessing, its
                // first line)
                let start = std::time::Instant::now();
                let text = loop {
                    let text = std::fs::read_to_string(&log).unwrap_or_default();
                    let ready = if bless {
                        text.contains('\n')
                    } else {
                        text.starts_with(&step.output)
                            || text.lines().count() > step.output.lines().count()
                    };
                    let exited = background
                        .0
                        .last_mut()
                        .unwrap()
                        .try_wait()
                        .ok()
                        .flatten()
                        .is_some();
                    if ready || exited || start.elapsed() > std::time::Duration::from_secs(600) {
                        break text;
                    }
                    std::thread::sleep(std::time::Duration::from_millis(50));
                };
                let n = if bless {
                    1
                } else {
                    step.output.lines().count()
                };
                let first: String = text.lines().take(n).map(|l| format!("{}\n", l)).collect();
                outputs.push(first);
            } else {
                let command = format!("(exit {})\n{}", status, step.command);
                let o = shell(&work, &path, &command).output().unwrap();
                status = o.status.code().unwrap_or(1);
                let mut text = String::from_utf8_lossy(&o.stdout).into_owned();
                // (a shell's prompt would start on the next line)
                if !text.is_empty() && !text.ends_with('\n') {
                    text.push('\n');
                }
                outputs.push(text);
            }
        }
        out.push(outputs);
    }
    drop(background);
    let _ = std::fs::remove_dir_all(&work);
    out
}

/// The README with the outputs of its sessions replaced.
fn blessed(readme: &str, outputs: &[Vec<String>]) -> String {
    let mut out = String::new();
    let mut block = 0;
    let mut lines = readme.lines().peekable();
    while let Some(line) = lines.next() {
        out.push_str(line);
        out.push('\n');
        if line.trim_start() != "```console" {
            continue;
        }
        let mut body = String::new();
        for l in lines.by_ref() {
            if l.trim_start() == "```" {
                break;
            }
            body.push_str(l);
            body.push('\n');
        }
        let steps = session(&body);
        for (step, output) in steps.iter().zip(&outputs[block]) {
            for (k, l) in step.command.lines().enumerate() {
                let continued = k > 0 && !step.command.lines().nth(k - 1).unwrap().ends_with('\\');
                out.push_str(if k == 0 {
                    "$ "
                } else if continued {
                    "> "
                } else {
                    ""
                });
                out.push_str(l);
                if k + 1 == step.command.lines().count() && step.background {
                    out.push_str(" &");
                }
                out.push('\n');
            }
            out.push_str(output);
        }
        out.push_str("```\n");
        block += 1;
    }
    out
}

#[test]
fn tutorial_sessions() {
    if Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_err()
    {
        return;
    }
    let dirs: Vec<PathBuf> = tutorial_dirs()
        .into_iter()
        .filter(|d| {
            // `FWP_TUTORIAL=16` runs the sessions of one tutorial
            if let Ok(only) = std::env::var("FWP_TUTORIAL") {
                if !d.file_name().unwrap().to_string_lossy().contains(&only) {
                    return false;
                }
            }
            let readme = std::fs::read_to_string(d.join("README.md")).unwrap();
            !code_blocks(&readme, "console").is_empty()
        })
        .collect();
    let failures: Vec<String> = std::thread::scope(|s| {
        let handles: Vec<_> = dirs
            .iter()
            .map(|dir| {
                s.spawn(move || {
                    let readme_path = dir.join("README.md");
                    let readme = std::fs::read_to_string(&readme_path).unwrap();
                    let blocks: Vec<Vec<Step>> = code_blocks(&readme, "console")
                        .iter()
                        .map(|b| session(b))
                        .collect();
                    let outputs = run_sessions(dir, &blocks);
                    if std::env::var("FWP_BLESS").is_ok() {
                        std::fs::write(&readme_path, blessed(&readme, &outputs)).unwrap();
                        return Vec::new();
                    }
                    let mut failures = Vec::new();
                    for (steps, outs) in blocks.iter().zip(&outputs) {
                        for (step, got) in steps.iter().zip(outs) {
                            if *got != step.output {
                                failures.push(format!(
                                    "{}: `$ {}`\n--- expected\n{}--- got\n{}",
                                    dir.display(),
                                    step.command,
                                    step.output,
                                    got
                                ));
                            }
                        }
                    }
                    failures
                })
            })
            .collect();
        handles
            .into_iter()
            .flat_map(|h| h.join().unwrap())
            .collect()
    });
    assert!(failures.is_empty(), "{}", failures.join("\n"));
}

#[test]
fn tutorial_programs() {
    let have_cc = Command::new(std::env::var("CC").unwrap_or_else(|_| "cc".into()))
        .arg("--version")
        .output()
        .is_ok();
    for path in tutorials() {
        let out = Command::new(fwp())
            .args(["run", "--interp"])
            .arg(&path)
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "{}: {}",
            path.display(),
            String::from_utf8_lossy(&out.stderr)
        );
        let got = String::from_utf8_lossy(&out.stdout).into_owned();
        let expected_path = path.with_extension("out");
        if std::env::var("FWP_BLESS").is_ok() {
            std::fs::write(&expected_path, &got).unwrap();
            continue;
        }
        let expected = std::fs::read_to_string(&expected_path).unwrap_or_default();
        assert_eq!(got, expected, "{}", path.display());
        if have_cc {
            let exe = std::env::temp_dir().join(format!(
                "fwp-example-{}-{}",
                std::process::id(),
                path.parent()
                    .unwrap()
                    .file_name()
                    .unwrap()
                    .to_string_lossy()
            ));
            let b = Command::new(fwp())
                .arg("build")
                .arg(&path)
                .args(["-O1", "-o"])
                .arg(&exe)
                .output()
                .unwrap();
            assert!(b.status.success(), "{}", String::from_utf8_lossy(&b.stderr));
            let n = Command::new(&exe).output().unwrap();
            let _ = std::fs::remove_file(&exe);
            assert_eq!(
                String::from_utf8_lossy(&n.stdout),
                expected,
                "native {}",
                path.display()
            );
        }
    }
}

#[test]
fn other_examples_check() {
    for path in [
        "hello.fwp",
        "wordfreq.fwp",
        "server/api.fwp",
        "server/chat.fwp",
        "shell/tools.fwp",
        "services/main.fwp",
        "cli/wc.fwp",
        "cli/grep.fwp",
        "cli/todo.fwp",
        "cli/dirstat.fwp",
        "rest/books.fwp",
        "rest/shop.fwp",
        "rest/client.fwp",
        "rest/uploads.fwp",
    ] {
        let out = Command::new(fwp())
            .arg("check")
            .arg(examples().join(path))
            .output()
            .unwrap();
        assert!(
            out.status.success(),
            "{}: {}",
            path,
            String::from_utf8_lossy(&out.stderr)
        );
    }
}
