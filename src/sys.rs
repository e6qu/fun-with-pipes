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

/// Whether the program's own output goes to stderr (an executable writing
/// the binary protocol on stdout): programs it calls write there too.
pub static OUTPUT_TO_STDERR: std::sync::atomic::AtomicBool =
    std::sync::atomic::AtomicBool::new(false);

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
            | "term.width"
            | "term.read-secret"
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
        "term.width" => Ok(Value::I64(term_width())),
        "term.read-secret" => {
            let _ = out.flush();
            let _ = std::io::stderr().flush();
            let echo = tty::echo_off();
            let mut line = Vec::new();
            use std::io::BufRead;
            let r = std::io::stdin().lock().read_until(b'\n', &mut line);
            if let Some(saved) = echo {
                tty::restore(saved);
                eprintln!();
            }
            Ok(match r {
                Ok(0) | Err(_) => Value::data(0, vec![]),
                Ok(_) => {
                    if line.ends_with(b"\n") {
                        line.pop();
                        if line.ends_with(b"\r") {
                            line.pop();
                        }
                    }
                    Value::data(1, vec![Value::str(&lossy(&line))])
                }
            })
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

/// The width of the terminal: `COLUMNS` (digits only), else the terminal
/// of stdout, stderr or stdin, else 80.
fn term_width() -> i64 {
    if let Ok(c) = std::env::var("COLUMNS") {
        if !c.is_empty() && c.len() <= 5 && c.bytes().all(|b| b.is_ascii_digit()) {
            let w: i64 = c.parse().unwrap_or(0);
            if w > 0 {
                return w;
            }
        }
    }
    tty::columns().unwrap_or(80)
}

/// The terminal through the C library: its size and its echo.
#[cfg(any(target_os = "linux", target_os = "macos"))]
mod tty {
    use std::ffi::{c_int, c_ulong};

    #[repr(C)]
    #[derive(Default)]
    struct WinSize {
        row: u16,
        col: u16,
        xpixel: u16,
        ypixel: u16,
    }

    /// `struct termios`, as bytes: large enough on both systems.
    #[repr(C, align(8))]
    #[derive(Clone, Copy)]
    pub struct Termios([u8; 256]);

    extern "C" {
        fn ioctl(fd: c_int, request: c_ulong, ...) -> c_int;
        fn isatty(fd: c_int) -> c_int;
        fn tcgetattr(fd: c_int, t: *mut Termios) -> c_int;
        fn tcsetattr(fd: c_int, action: c_int, t: *const Termios) -> c_int;
    }

    #[cfg(target_os = "linux")]
    const TIOCGWINSZ: c_ulong = 0x5413;
    #[cfg(target_os = "macos")]
    const TIOCGWINSZ: c_ulong = 0x40087468;
    const ECHO: u64 = 0o10;
    const TCSAFLUSH: c_int = 2;

    pub fn columns() -> Option<i64> {
        for fd in [1, 2, 0] {
            let mut ws = WinSize::default();
            // SAFETY: TIOCGWINSZ writes a `struct winsize`.
            if unsafe { ioctl(fd, TIOCGWINSZ, &mut ws as *mut WinSize) } == 0 && ws.col > 0 {
                return Some(ws.col as i64);
            }
        }
        None
    }

    /// `c_lflag` of `struct termios`: a 32-bit field at byte 12 on Linux,
    /// a 64-bit one at byte 24 on macOS.
    fn lflag(t: &mut Termios) -> &mut [u8] {
        if cfg!(target_os = "linux") {
            &mut t.0[12..16]
        } else {
            &mut t.0[24..32]
        }
    }

    /// Turn the echo of standard input off when it is a terminal; the
    /// settings to restore.
    pub fn echo_off() -> Option<Termios> {
        let mut t = Termios([0; 256]);
        // SAFETY: the buffer is larger than `struct termios`.
        if unsafe { isatty(0) } == 0 || unsafe { tcgetattr(0, &mut t) } != 0 {
            return None;
        }
        let saved = t;
        let f = lflag(&mut t);
        let mut v = [0u8; 8];
        v[..f.len()].copy_from_slice(f);
        let x = u64::from_ne_bytes(v) & !ECHO;
        let n = f.len();
        f.copy_from_slice(&x.to_ne_bytes()[..n]);
        // SAFETY: as above.
        unsafe { tcsetattr(0, TCSAFLUSH, &t) };
        Some(saved)
    }

    pub fn restore(t: Termios) {
        // SAFETY: the settings `echo_off` read.
        unsafe { tcsetattr(0, TCSAFLUSH, &t) };
    }
}

#[cfg(not(any(target_os = "linux", target_os = "macos")))]
mod tty {
    pub struct Termios;

    pub fn columns() -> Option<i64> {
        None
    }

    pub fn echo_off() -> Option<Termios> {
        None
    }

    pub fn restore(_: Termios) {}
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
        if OUTPUT_TO_STDERR.load(std::sync::atomic::Ordering::Relaxed) {
            cmd.stdout(Stdio::from(std::io::stderr()));
        }
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
