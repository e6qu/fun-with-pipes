//! Standalone function executables: running an exported function with
//! curried arguments from the command line and records from stdin, in text
//! or the binary typed protocol. The C runtime implements the same
//! behaviour for native builds (runtime/fwp_rt_exec.c).
//!
//! * `k` command-line arguments fill the first `k` parameters, parsed by
//!   type from the canonical text format (top-level strings are raw).
//! * With all `n` parameters given, the function runs once.
//! * With `n - 1` given, the last parameter comes from stdin: a `List[T]`
//!   parameter receives all input records; any other type is applied to
//!   each record in turn (streaming).
//! * A `List[T]` result is emitted as one record per element.
//! * Input in the binary protocol is detected by its magic bytes; output is
//!   binary when `FWP_OUT=bin`. Text records are lines.

use std::io::{BufRead, Write};

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

    fn emit_result(&mut self, v: &Value, result: &MT, prog: &Program) -> std::io::Result<()> {
        if list_elem(result).is_some() {
            for x in v.list_items() {
                self.emit(&x, prog)?;
            }
            Ok(())
        } else {
            self.emit(v, prog)
        }
    }
}

/// Usage line for a function.
pub fn usage(name: &str, params: &[MT]) -> String {
    let ps: Vec<String> = params.iter().map(|p| format!("<{}>", p)).collect();
    format!(
        "usage: {} {}\n  (the last argument may instead be given as records on stdin)",
        name,
        ps.join(" ")
    )
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

/// Run function `fid` as an executable. Returns the exit code.
pub fn exec(prog: &Program, fid: FuncId, name: &str, argv: &[String]) -> i32 {
    let f = &prog.funcs[fid];
    let n = f.arity as usize;
    let (params, result) = f.ty.params(n);
    let params: Vec<MT> = params.into_iter().cloned().collect();
    let result = result.clone();
    if argv.len() > n || argv.len() + 1 < n {
        eprintln!("{}", usage(name, &params));
        return 2;
    }
    let mut args = Vec::new();
    for (i, a) in argv.iter().enumerate() {
        match crate::textio::parse(a, &params[i], prog) {
            Ok(v) => args.push(v),
            Err(_) => {
                eprintln!(
                    "{}: argument {}: cannot parse `{}` as {}",
                    name,
                    i + 1,
                    a,
                    params[i]
                );
                return 2;
            }
        }
    }
    let binary = std::env::var("FWP_OUT").is_ok_and(|v| v == "bin");
    let out_elem = list_elem(&result).unwrap_or_else(|| result.clone());
    let stdout = std::io::stdout();
    let mut lock = std::io::BufWriter::new(stdout.lock());
    if binary {
        let _ = lock.write_all(&proto::header(&out_elem, prog));
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
            elem: out_elem.clone(),
        };
        let run = |it: &mut Interp, args: Vec<Value>, em: &mut Emitter| -> Result<(), i32> {
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
                    let _ = em.emit_result(&v, &result, prog);
                    let _ = em.out.flush();
                    Ok(())
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
        if argv.len() == n {
            if let Err(c) = run(&mut it, args, &mut em) {
                code = c;
            }
        } else {
            let last = params[n - 1].clone();
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
                                    if let Err(c) = run(&mut it, a, &mut em) {
                                        code = c;
                                        break;
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
                        if let Err(c) = run(&mut it, a, &mut em) {
                            code = c;
                        }
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
