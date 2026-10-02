//! Standalone function executables: running an exported function with
//! curried arguments from the command line and records from stdin, in text
//! or the binary typed protocol. The C runtime implements the same
//! behaviour for native builds (runtime/fwp_rt_exec.c).
//!
//! * Flags fill an options record (the first parameter), as `src/cli.rs`
//!   describes; `--help` and `--version` print the help and the version.
//! * `k` command-line arguments fill the first `k` parameters, parsed by
//!   type from the canonical text format (top-level strings are raw).
//! * With all `n` parameters given, the function runs once.
//! * With `n - 1` given, the last parameter comes from stdin: a `List[T]`
//!   parameter receives all input records; any other type is applied to
//!   each record in turn (streaming).
//! * A `Result` result is its `Ok` value, or an error (exit status 1); an
//!   `Option` result is its value or nothing; a `List[T]` result is
//!   emitted as one record per element.
//! * Input in the binary protocol is detected by its magic bytes; output is
//!   binary when `FWP_OUT=bin`. Text records are lines.

use std::io::{BufRead, Write};

use crate::cli;
use crate::interp::{report, Ctl, Interp};
use crate::ir::{FuncId, Program, MT};
use crate::proto;
use crate::value::{display, Value};

fn list_elem(mt: &MT) -> Option<MT> {
    match mt {
        MT::Con(n, args) if n == "std::List" => args.first().cloned(),
        _ => None,
    }
}

fn is_unit(mt: &MT) -> bool {
    matches!(mt, MT::Record(fs) if fs.is_empty())
}

pub struct Emitter<'w> {
    out: &'w mut dyn Write,
    binary: bool,
    elem: MT,
}

impl Emitter<'_> {
    fn emit(&mut self, v: &Value, prog: &Program) -> std::io::Result<()> {
        if self.binary {
            let mut buf = Vec::new();
            proto::encode(&mut buf, v, &self.elem, prog);
            self.out.write_all(&proto::frame(&buf))
        } else if is_unit(&self.elem) {
            Ok(())
        } else {
            writeln!(self.out, "{}", display(v, &self.elem, prog, true))
        }
    }

    /// Write a result: an `Err` is returned, `None` writes nothing and a
    /// list is one record per element. The exit status of an `Outcome`
    /// (else 0).
    fn emit_result(
        &mut self,
        v: &Value,
        out: &cli::Output,
        prog: &Program,
    ) -> Result<i32, (Value, MT)> {
        let mut v = v.clone();
        let mut status = 0;
        if let (Some((o, st)), Value::Record(fs)) = (out.outcome, &v) {
            status = fs[st].as_i128().unwrap_or(0).rem_euclid(256) as i32;
            v = fs[o].clone();
        }
        if let Some(e) = &out.error {
            match &v {
                Value::Data(0, fs) => v = fs[0].clone(),
                Value::Data(_, fs) => return Err((fs[0].clone(), e.clone())),
                _ => {}
            }
        }
        if out.option {
            match &v {
                Value::Data(1, fs) => v = fs[0].clone(),
                _ => return Ok(status),
            }
        }
        if out.list {
            for x in v.list_items() {
                let _ = self.emit(&x, prog);
            }
        } else {
            let _ = self.emit(&v, prog);
        }
        Ok(status)
    }
}

/// An error as a command reports it: an `IoError` by its message, other
/// values as `show` displays them (strings unquoted).
pub fn error_text(v: &Value, mt: &MT, prog: &Program) -> String {
    if matches!(mt, MT::Con(n, a) if n == "std::IoError" && a.is_empty()) {
        if let Value::Record(fs) = v {
            if let Some(Value::Str(m)) = fs.get(1) {
                return m.to_string();
            }
        }
    }
    display(v, mt, prog, true)
}

/// Input records from stdin, in text or binary form.
pub enum Input {
    Text(Box<dyn BufRead>),
    Binary(Box<dyn BufRead>),
}

/// Detect the input format by peeking at the magic bytes.
pub fn open_input(mut r: Box<dyn BufRead>, elem: &MT, prog: &Program) -> Result<Input, String> {
    let buf = r.fill_buf().map_err(|e| e.to_string())?;
    if buf.len() >= 4 && &buf[..4] == proto::MAGIC {
        r.consume(4);
        let h = proto::read_header(&mut r)?;
        if h.version != proto::VERSION {
            return Err(format!("unsupported protocol version {}", h.version));
        }
        let want = proto::fingerprint(&proto::canonical_type(elem, prog));
        if h.fingerprint != want {
            return Err(format!(
                "input type mismatch: expected `{}`, got `{}`",
                elem, h.type_name
            ));
        }
        return Ok(Input::Binary(r));
    }
    Ok(Input::Text(r))
}

impl Input {
    /// Next input record.
    pub fn next(&mut self, elem: &MT, prog: &Program) -> Result<Option<Value>, String> {
        match self {
            Input::Binary(r) => match proto::read_frame(r)? {
                None => Ok(None),
                Some(payload) => {
                    let mut rd = proto::Reader::new(&payload);
                    // one message for every decoding failure, as in the
                    // native runtime
                    proto::decode(&mut rd, elem, prog)
                        .map(Some)
                        .map_err(|_| "malformed value".to_string())
                }
            },
            Input::Text(r) => {
                let mut bytes = Vec::new();
                match r.read_until(b'\n', &mut bytes) {
                    Ok(0) => Ok(None),
                    Ok(_) => {
                        if bytes.ends_with(b"\n") {
                            bytes.pop();
                            if bytes.ends_with(b"\r") {
                                bytes.pop();
                            }
                        }
                        let line = crate::value::lossy(&bytes);
                        crate::textio::parse(&line, elem, prog)
                            .map(Some)
                            .map_err(|_| format!("cannot parse input `{}` as {}", line, elem))
                    }
                    Err(e) => Err(e.to_string()),
                }
            }
        }
    }
}

/// Run function `fid` as an executable named `name`. Returns the exit
/// code.
pub fn exec(prog: &Program, fid: FuncId, name: &str, argv: &[String]) -> i32 {
    let cmd = match cli::version(prog).and_then(|v| cli::command(prog, fid, name, None, v)) {
        Ok(c) => c,
        Err(e) => {
            eprintln!("fwp exec: {}", e);
            return 1;
        }
    };
    let own = |n: &str| cli::has_flag(&cmd, n);
    if let Some(code) = generated(argv, std::slice::from_ref(&cmd), None, prog, &own) {
        return code;
    }
    exec_command(prog, &cmd, argv)
}

/// `--completions SHELL` and `--man` as the first argument (unless the
/// command has flags of these names, `own`): print the script or the
/// page. The exit status, or `None` for other arguments.
fn generated(
    argv: &[String],
    cmds: &[cli::Command],
    multi: Option<&str>,
    prog: &Program,
    own: &dyn Fn(&str) -> bool,
) -> Option<i32> {
    let first = argv.first()?;
    let name = match multi {
        Some(n) => n.to_string(),
        None => cmds.first().map(|c| c.name.clone()).unwrap_or_default(),
    };
    if first == "--man" && !own("man") {
        print!(
            "{}",
            crate::cli_gen::man_page(cmds, multi, &prog.docs.module)
        );
        return Some(0);
    }
    let shell = match first.strip_prefix("--completions") {
        Some("") if !own("completions") => argv.get(1).cloned(),
        Some(s) if s.starts_with('=') && !own("completions") => Some(s[1..].to_string()),
        _ => return None,
    };
    let Some(shell) = shell else {
        eprintln!(
            "{}: option `--completions` needs a value (bash, zsh or fish)",
            name
        );
        return Some(2);
    };
    match crate::cli_gen::completions(&shell, cmds, multi) {
        Some(text) => {
            print!("{}", text);
            Some(0)
        }
        None => {
            eprintln!("{}: unknown shell `{}` (bash, zsh or fish)", name, shell);
            Some(2)
        }
    }
}

/// Run a multi-command program (`fwp build --cli`): the first argument
/// names the exported function. Returns the exit code.
pub fn exec_program(prog: &Program, name: &str, argv: &[String]) -> i32 {
    let cmds = match cli::commands(prog, Some(name)) {
        Ok(c) => c,
        Err(e) => {
            eprintln!("fwp exec: {}", e);
            return 1;
        }
    };
    let find = |n: &str| cmds.iter().find(|c| c.command == n);
    let Some(first) = argv.first() else {
        eprint!("{}", cli::program_help(name, &cmds, prog));
        return 2;
    };
    if let Some(c) = find(first) {
        return exec_command(prog, c, &argv[1..]);
    }
    if let Some(code) = generated(argv, &cmds, Some(name), prog, &|_| false) {
        return code;
    }
    let version = cmds.first().and_then(|c| c.version.clone());
    match first.as_str() {
        "--help" | "-h" => {
            print!("{}", cli::program_help(name, &cmds, prog));
            0
        }
        "--version" if version.is_some() => {
            println!("{} {}", name, version.unwrap_or_default());
            0
        }
        "help" => match argv.get(1) {
            None => {
                print!("{}", cli::program_help(name, &cmds, prog));
                0
            }
            Some(n) => match find(n) {
                Some(c) => {
                    print!("{}", c.help);
                    0
                }
                None => {
                    eprintln!(
                        "{}: unknown command `{}`\n{}",
                        name,
                        n,
                        cli::program_usage(name)
                    );
                    2
                }
            },
        },
        _ => {
            eprintln!(
                "{}: unknown command `{}`\n{}",
                name,
                first,
                cli::program_usage(name)
            );
            2
        }
    }
}

/// Run a command with its command line. Returns the exit code.
pub fn exec_command(prog: &Program, cmd: &cli::Command, argv: &[String]) -> i32 {
    let name = cmd.name.as_str();
    let fid = cmd.fid;
    let n = cmd.params.len();
    let params = &cmd.params;
    // flags, unless a record parameter is given as before (on stdin or as
    // a record argument)
    let flags_mode = cmd.options.is_some()
        && (!cmd.record_fallback || argv.first().is_some_and(|a| a.starts_with('-')));
    let flags = if flags_mode {
        cmd.options.as_ref().map(|o| o.flags.as_slice())
    } else {
        None
    };
    let usage_error = |msg: Option<String>| {
        if let Some(m) = msg {
            eprintln!("{}: {}", name, m);
        }
        eprintln!("{}", cmd.usage);
        2
    };
    let (vals, pos) = match cli::parse_args(flags, argv, true, cmd.version.is_some(), prog) {
        Err(m) => return usage_error(Some(m)),
        Ok(cli::Parsed::Help) => {
            print!("{}", cmd.help);
            let _ = std::io::stdout().flush();
            return 0;
        }
        Ok(cli::Parsed::Version) => {
            let program = name.split(' ').next().unwrap_or(name);
            println!("{} {}", program, cmd.version.clone().unwrap_or_default());
            return 0;
        }
        Ok(cli::Parsed::Args(v, p)) => (v, p),
    };
    let mut args = Vec::new();
    if let (true, Some(o)) = (flags_mode, &cmd.options) {
        let defaults = cli::default_values(cmd, prog);
        let env = |var: &str| std::env::var_os(var).map(|v| v.to_string_lossy().into_owned());
        match cli::build_record(o, vals, &defaults, &env, prog) {
            Ok(r) => args.push(r),
            Err(m) => return usage_error(Some(m)),
        }
    }
    let end = n - cmd.unit_last as usize;
    let from_stdin = if !flags_mode && cmd.record_fallback {
        // the record as an argument or from stdin, as before
        match pos.len() {
            0 => true,
            1 => match crate::textio::parse(&pos[0], &params[0], prog) {
                Ok(v) => {
                    args.push(v);
                    false
                }
                Err(_) => {
                    eprintln!(
                        "{}: argument 1: cannot parse `{}` as {}",
                        name, pos[0], params[0]
                    );
                    return 2;
                }
            },
            _ => return usage_error(None),
        }
    } else {
        match cli::bind_positional(cmd, &pos, prog) {
            Ok((vs, stdin)) => {
                args.extend(vs);
                stdin
            }
            Err(cli::ArgError::Usage) => return usage_error(None),
            Err(cli::ArgError::Value(m)) => {
                eprintln!("{}: {}", name, m);
                return 2;
            }
        }
    };
    let output = &cmd.output;
    let binary = std::env::var("FWP_OUT").is_ok_and(|v| v == "bin");
    crate::sys::OUTPUT_TO_STDERR.store(binary, std::sync::atomic::Ordering::Relaxed);
    let stdout = std::io::stdout();
    let mut lock = std::io::BufWriter::new(stdout.lock());
    if binary {
        let _ = lock.write_all(&proto::header(&output.elem, prog));
    }
    let code = {
        // In binary mode the program's own output goes to stderr so that it
        // cannot corrupt the frame stream.
        let program_out: Box<dyn Write> = if binary {
            Box::new(std::io::stderr())
        } else {
            Box::new(std::io::stdout())
        };
        let mut it = Interp::new(prog, program_out);
        let fv = Value::Closure(std::rc::Rc::new(crate::value::Closure {
            func: fid,
            args: vec![],
        }));
        let mut em = Emitter {
            out: &mut lock,
            binary,
            elem: output.elem.clone(),
        };
        let run = |it: &mut Interp, mut args: Vec<Value>, em: &mut Emitter| -> Result<i32, i32> {
            if cmd.unit_last {
                args.push(Value::unit());
            }
            let r = if n == 0 {
                it.call(fid, vec![])
            } else {
                it.apply(fv.clone(), args)
            };
            if r.is_err() {
                it.cancel_children();
            } else {
                it.join_children();
            }
            // program output written with `print` goes before the result
            let _ = it.out.flush();
            match r {
                Ok(v) => {
                    let res = em.emit_result(&v, output, prog);
                    let _ = em.out.flush();
                    match res {
                        Ok(status) => Ok(status),
                        Err((e, mt)) => {
                            eprintln!("{}: {}", name, error_text(&e, &mt, prog));
                            Err(1)
                        }
                    }
                }
                Err(Ctl::Fail(e, mt)) => {
                    let _ = em.out.flush();
                    eprintln!("{}: {}", name, error_text(&e, &mt, prog));
                    Err(1)
                }
                Err(e) => {
                    let _ = em.out.flush();
                    let trap = matches!(e, Ctl::Trap(_));
                    let code = report(&Err::<Value, Ctl>(e), prog);
                    if trap {
                        // a trap aborts the process, like the native runtime
                        std::process::exit(code);
                    }
                    Err(code)
                }
            }
        };
        let mut code = 0;
        if !from_stdin {
            code = run(&mut it, args, &mut em).unwrap_or_else(|c| c);
        } else {
            let last = params[end - 1].clone();
            let (collect, elem) = match list_elem(&last) {
                Some(e) => (true, e),
                None => (false, last.clone()),
            };
            let stdin: Box<dyn BufRead> = Box::new(std::io::BufReader::new(std::io::stdin()));
            match open_input(stdin, &elem, prog) {
                Err(e) => {
                    eprintln!("{}: {}", name, e);
                    code = 3;
                }
                Ok(mut input) => {
                    let mut items = Vec::new();
                    loop {
                        match input.next(&elem, prog) {
                            Ok(Some(v)) => {
                                if collect {
                                    items.push(v);
                                } else {
                                    let mut a = args.clone();
                                    a.push(v);
                                    match run(&mut it, a, &mut em) {
                                        Ok(st) => code = code.max(st),
                                        Err(c) => {
                                            code = c;
                                            break;
                                        }
                                    }
                                }
                            }
                            Ok(None) => break,
                            Err(e) => {
                                eprintln!("{}: {}", name, e);
                                code = 3;
                                break;
                            }
                        }
                    }
                    if collect && code == 0 {
                        let mut a = args.clone();
                        a.push(Value::list(items));
                        code = run(&mut it, a, &mut em).unwrap_or_else(|c| c);
                    }
                }
            }
        }
        let _ = it.out.flush();
        code
    };
    if binary {
        let _ = lock.write_all(&proto::end_frame());
    }
    let _ = lock.flush();
    code
}

/// One stage of `fwp pipe`: `file.fwp:function arg...`.
#[derive(Debug, PartialEq)]
pub struct Stage {
    pub file: String,
    pub function: String,
    pub args: Vec<String>,
}

/// Split a pipeline description into stages. Arguments may be quoted with
/// double quotes; `|` inside quotes does not separate stages.
pub fn parse_pipeline(spec: &str) -> Result<Vec<Stage>, String> {
    let mut stages = Vec::new();
    let mut words: Vec<String> = Vec::new();
    let mut cur = String::new();
    let mut in_word = false;
    let mut quoted = false;
    let mut flush_stage = |words: &mut Vec<String>| -> Result<(), String> {
        if words.is_empty() {
            return Err("empty pipeline stage".into());
        }
        let head = words.remove(0);
        let (file, function) = head
            .rsplit_once(':')
            .ok_or_else(|| format!("stage `{}` must be written file.fwp:function", head))?;
        stages.push(Stage {
            file: file.to_string(),
            function: function.to_string(),
            args: std::mem::take(words),
        });
        Ok(())
    };
    for c in spec.chars() {
        match c {
            '"' => {
                quoted = !quoted;
                in_word = true;
            }
            '|' if !quoted => {
                if in_word {
                    words.push(std::mem::take(&mut cur));
                    in_word = false;
                }
                flush_stage(&mut words)?;
            }
            c if c.is_whitespace() && !quoted => {
                if in_word {
                    words.push(std::mem::take(&mut cur));
                    in_word = false;
                }
            }
            c => {
                cur.push(c);
                in_word = true;
            }
        }
    }
    if quoted {
        return Err("unterminated quote".into());
    }
    if in_word {
        words.push(cur);
    }
    flush_stage(&mut words)?;
    Ok(stages)
}

/// Run a pipeline of exported functions as processes connected with the
/// binary typed protocol; the last stage prints text. Returns the exit code
/// of the first failing stage (or 0).
pub fn run_pipeline(fwp_exe: &std::path::Path, spec: &str) -> Result<i32, String> {
    use std::process::{Command, Stdio};
    let stages = parse_pipeline(spec)?;
    let mut children = Vec::new();
    let mut prev_out: Option<std::process::ChildStdout> = None;
    let n = stages.len();
    for (i, st) in stages.iter().enumerate() {
        let mut cmd = Command::new(fwp_exe);
        cmd.arg("exec")
            .arg(&st.file)
            .arg(&st.function)
            .args(&st.args);
        if i + 1 < n {
            cmd.env("FWP_OUT", "bin").stdout(Stdio::piped());
        } else {
            cmd.env_remove("FWP_OUT");
        }
        if let Some(out) = prev_out.take() {
            cmd.stdin(Stdio::from(out));
        }
        let mut child = cmd
            .spawn()
            .map_err(|e| format!("cannot start stage {}: {}", i + 1, e))?;
        prev_out = child.stdout.take();
        children.push(child);
    }
    let mut code = 0;
    for mut c in children {
        let status = c.wait().map_err(|e| e.to_string())?;
        if code == 0 {
            code = status.code().unwrap_or(1);
        }
    }
    Ok(code)
}
