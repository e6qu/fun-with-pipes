//! Interpreter implementations of the primitives for command-line
//! programs: the file system (`file.*`, `dir.*`), the environment, the
//! terminal and processes. The C runtime has the same ones
//! (`runtime/fwp_rt_sys.c`); errors are `IoError`s worded as C's
//! `strerror` words them.

use std::io::Write;

use crate::h2::io_msg;
use crate::interp::Ctl;
use crate::ir::MT;
use crate::value::{lossy, Value};

fn io_error(kind: &str, msg: String) -> Ctl {
    Ctl::Fail(
        Value::tuple(vec![Value::str(kind), Value::str(&msg)]),
        MT::con("std::IoError"),
    )
}

fn path_error(kind: &str, path: &str, e: &std::io::Error) -> Ctl {
    io_error(kind, format!("{}: {}", path, io_msg(e)))
}

fn lossy_os(s: &std::ffi::OsStr) -> String {
    s.to_string_lossy().into_owned()
}

/// Whether `sym` is one of these primitives.
pub fn handles(sym: &str) -> bool {
    matches!(
        sym,
        "file.exists"
            | "file.is-dir"
            | "file.info"
            | "file.remove"
            | "file.rename"
            | "file.append"
            | "file.read-bytes"
            | "file.write-bytes"
            | "dir.list"
            | "dir.create"
            | "dir.create-all"
            | "dir.remove"
            | "env.vars"
            | "env.cwd"
            | "term.is-tty"
            | "process.run-input"
            | "process.call"
    )
}

/// Run one of these primitives. `out` is the program's standard output,
/// flushed before a process starts.
pub fn prim(sym: &str, a: &[Value], out: &mut dyn Write) -> Result<Value, Ctl> {
    let s = |i: usize| a[i].as_str().to_string();
    match sym {
        "file.exists" => Ok(Value::bool(std::fs::metadata(s(0)).is_ok())),
        "file.is-dir" => Ok(Value::bool(
            std::fs::metadata(s(0)).is_ok_and(|m| m.is_dir()),
        )),
        "file.info" => {
            let p = s(0);
            let m = std::fs::metadata(&p).map_err(|e| path_error("stat", &p, &e))?;
            let modified = m
                .modified()
                .ok()
                .and_then(|t| t.duration_since(std::time::UNIX_EPOCH).ok())
                .map(|d| d.as_nanos() as i64)
                .unwrap_or(0);
            // fields in canonical order: is-dir, modified, size
            Ok(Value::tuple(vec![
                Value::bool(m.is_dir()),
                Value::tuple(vec![Value::I64(modified)]),
                Value::I64(m.len() as i64),
            ]))
        }
        "file.remove" => {
            let p = s(0);
            std::fs::remove_file(&p).map_err(|e| path_error("remove", &p, &e))?;
            Ok(Value::unit())
        }
        "dir.remove" => {
            let p = s(0);
            std::fs::remove_dir(&p).map_err(|e| path_error("remove", &p, &e))?;
            Ok(Value::unit())
        }
        "file.rename" => {
            let (to, from) = (s(0), s(1));
            std::fs::rename(&from, &to).map_err(|e| path_error("rename", &from, &e))?;
            Ok(Value::unit())
        }
        "file.append" => {
            let p = s(0);
            let mut f = std::fs::OpenOptions::new()
                .append(true)
                .create(true)
                .open(&p)
                .map_err(|e| path_error("write", &p, &e))?;
            f.write_all(a[1].as_str().as_bytes())
                .map_err(|e| path_error("write", &p, &e))?;
            Ok(Value::unit())
        }
        "file.read-bytes" => {
            let p = s(0);
            let b = std::fs::read(&p).map_err(|e| path_error("read", &p, &e))?;
            Ok(Value::Bytes(b.into()))
        }
        "file.write-bytes" => {
            let p = s(0);
            let Value::Bytes(b) = &a[1] else {
                return Err(Ctl::Trap("internal: not bytes".into()));
            };
            std::fs::write(&p, b).map_err(|e| path_error("write", &p, &e))?;
            Ok(Value::unit())
        }
        "dir.list" => {
            let p = s(0);
            let rd = std::fs::read_dir(&p).map_err(|e| path_error("list", &p, &e))?;
            let mut names = Vec::new();
            for e in rd {
                let e = e.map_err(|e| path_error("list", &p, &e))?;
                names.push(lossy_os(&e.file_name()));
            }
            names.sort();
            Ok(Value::list(names.iter().map(|n| Value::str(n)).collect()))
        }
        "dir.create" => {
            let p = s(0);
            std::fs::create_dir(&p).map_err(|e| path_error("create", &p, &e))?;
            Ok(Value::unit())
        }
        "dir.create-all" => {
            let p = s(0);
            std::fs::create_dir_all(&p).map_err(|e| path_error("create", &p, &e))?;
            Ok(Value::unit())
        }
        "env.vars" => {
            let mut vs: Vec<(String, String)> = std::env::vars_os()
                .map(|(k, v)| (lossy_os(&k), lossy_os(&v)))
                .collect();
            vs.sort();
            Ok(Value::list(
                vs.iter()
                    .map(|(k, v)| Value::tuple(vec![Value::str(k), Value::str(v)]))
                    .collect(),
            ))
        }
        "env.cwd" => Ok(Value::str(
            &std::env::current_dir()
                .map(|p| lossy_os(p.as_os_str()))
                .unwrap_or_else(|_| ".".into()),
        )),
        "term.is-tty" => {
            use std::io::IsTerminal;
            let fd = a[0].as_i128().unwrap_or(-1);
            let _ = out.flush();
            Ok(Value::bool(match fd {
                0 => std::io::stdin().is_terminal(),
                1 => std::io::stdout().is_terminal(),
                2 => std::io::stderr().is_terminal(),
                _ => false,
            }))
        }
        "process.run-input" => {
            let _ = out.flush();
            run(a[1].list_items(), Some(a[0].as_str().as_bytes().to_vec()))
        }
        "process.call" => {
            let _ = out.flush();
            run(a[0].list_items(), None)
        }
        _ => Err(Ctl::Trap(format!("primitive `{}` is not implemented", sym))),
    }
}

/// The exit status of a process as a shell reports it: the exit code, or
/// 128 plus the signal that ended it.
fn status_code(st: std::process::ExitStatus) -> i32 {
    if let Some(c) = st.code() {
        return c;
    }
    #[cfg(unix)]
    {
        use std::os::unix::process::ExitStatusExt;
        if let Some(sig) = st.signal() {
            return 128 + sig;
        }
    }
    1
}

/// Run a command. With `input`, its standard input is that text and its
/// output is captured (`ProcessOutput`); without, it shares the program's
/// standard streams and the result is its status.
fn run(argv: Vec<Value>, input: Option<Vec<u8>>) -> Result<Value, Ctl> {
    use std::process::{Command, Stdio};
    let argv: Vec<String> = argv.iter().map(|v| v.as_str().to_string()).collect();
    let Some(prog) = argv.first() else {
        return Err(io_error("spawn", "empty command".into()));
    };
    let mut cmd = Command::new(prog);
    cmd.args(&argv[1..]);
    let Some(input) = input else {
        let st = cmd.status().map_err(|e| path_error("spawn", prog, &e))?;
        return Ok(Value::I32(status_code(st)));
    };
    cmd.stdin(Stdio::piped())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped());
    let mut child = cmd.spawn().map_err(|e| path_error("spawn", prog, &e))?;
    let mut stdin = child.stdin.take();
    let writer = std::thread::spawn(move || {
        if let Some(w) = stdin.as_mut() {
            let _ = w.write_all(&input);
        }
    });
    let output = child
        .wait_with_output()
        .map_err(|e| path_error("spawn", prog, &e))?;
    let _ = writer.join();
    // fields in canonical order: status, stderr, stdout
    Ok(Value::tuple(vec![
        Value::I32(status_code(output.status)),
        Value::str(&lossy(&output.stderr)),
        Value::str(&lossy(&output.stdout)),
    ]))
}
