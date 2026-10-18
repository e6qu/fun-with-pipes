//! Interpreter instrumentation and its line-delimited JSON control protocol.
//! The terminal and Python client use the same event/control state machine.
use crate::diag::SourceMap;
use crate::interp::Ctl;
use crate::ir::{Expr, FuncId, Program, MT};
use crate::json::Json;
use crate::value::Value;
use std::collections::{HashMap, HashSet};
use std::io::{BufRead, Write};

pub type Shared = std::rc::Rc<std::cell::RefCell<Debugger>>;

#[derive(Clone)]
struct Frame {
    function: FuncId,
    locals: Json,
    location: Option<crate::diag::Span>,
}

enum Motion {
    Step,
    Continue,
    Next { task: usize, depth: usize },
    Return { task: usize, depth: usize },
}

pub struct Debugger {
    input: Box<dyn BufRead>,
    program_input: Option<Box<dyn BufRead>>,
    output: Box<dyn Write>,
    json: bool,
    frames: HashMap<usize, Vec<Frame>>,
    breakpoints: HashSet<String>,
    trace: HashSet<String>,
    motion: Motion,
    selected: usize,
    sequence: u64,
    sources: SourceMap,
    spans: HashMap<FuncId, crate::diag::Span>,
    sites: HashMap<usize, usize>,
}

fn number(n: impl ToString) -> Json {
    Json::Num(n.to_string())
}
fn field<'a>(json: &'a Json, name: &str) -> &'a str {
    json.get(name).and_then(Json::as_str).unwrap_or("")
}

impl Debugger {
    pub fn new(
        input: Box<dyn BufRead>,
        output: Box<dyn Write>,
        json: bool,
        sources: SourceMap,
        spans: HashMap<FuncId, crate::diag::Span>,
        program: &Program,
    ) -> Self {
        fn index(e: &Expr, sites: &mut HashMap<usize, usize>) {
            sites.insert(e as *const Expr as usize, sites.len());
            match e {
                Expr::Call(_, xs) | Expr::Record(xs) | Expr::Construct(_, xs) => {
                    for x in xs {
                        index(x, sites);
                    }
                }
                Expr::Apply(f, xs) => {
                    index(f, sites);
                    for x in xs {
                        index(x, sites);
                    }
                }
                Expr::Let(_, a, b) => {
                    index(a, sites);
                    index(b, sites);
                }
                Expr::Field(a, _)
                | Expr::Trace(_, a)
                | Expr::Dup(_, a)
                | Expr::Drop(_, a)
                | Expr::BorrowGlobal(_, _, a)
                | Expr::ResourceRegion { body: a, .. } => index(a, sites),
                Expr::SetFields(a, xs) => {
                    index(a, sites);
                    for (_, x) in xs {
                        index(x, sites);
                    }
                }
                Expr::Match(a, arms) => {
                    index(a, sites);
                    for (_, x) in arms {
                        index(x, sites);
                    }
                }
                Expr::Func(_) | Expr::Local(_) | Expr::Const(_) => {}
            }
        }
        let mut sites = HashMap::new();
        for f in &program.funcs {
            if let crate::ir::Body::Expr(e) = &f.body {
                index(e, &mut sites);
            }
        }
        Self {
            input,
            program_input: None,
            output,
            json,
            frames: HashMap::new(),
            breakpoints: HashSet::new(),
            trace: HashSet::new(),
            motion: Motion::Step,
            selected: 0,
            sequence: 0,
            sources,
            spans,
            sites,
        }
    }

    pub fn read_input(&mut self, line: bool) -> Result<Vec<u8>, Ctl> {
        let input = self.program_input.as_mut().ok_or_else(|| Ctl::Trap("debugged standard input requires --input FILE; debugger commands use a separate stream".into()))?;
        let mut bytes = Vec::new();
        if line {
            input.read_until(b'\n', &mut bytes)
        } else {
            input.read_to_end(&mut bytes)
        }
        .map_err(|e| Ctl::Trap(e.to_string()))?;
        Ok(bytes)
    }

    fn send(&mut self, message: &Json) -> Result<(), Ctl> {
        if self.json {
            writeln!(self.output, "{message}")
                .and_then(|()| self.output.flush())
                .map_err(|e| Ctl::Trap(e.to_string()))?;
        }
        Ok(())
    }

    fn location(&self, id: FuncId) -> Json {
        self.source_location(self.spans.get(&id).copied())
    }

    fn source_location(&self, span: Option<crate::diag::Span>) -> Json {
        let Some(span) = span else {
            return Json::Null;
        };
        let Some(file) = self.sources.get(span.file) else {
            return Json::Null;
        };
        Json::obj(vec![
            ("file", Json::str(&file.name)),
            ("line", number(span.line)),
            ("column", number(span.col)),
            ("scope", Json::str("source")),
            (
                "source",
                Json::str(
                    file.text
                        .lines()
                        .nth(span.line.saturating_sub(1) as usize)
                        .unwrap_or(""),
                ),
            ),
        ])
    }

    fn values(program: &Program, id: FuncId, values: &[Value]) -> Json {
        Json::Arr(
            values
                .iter()
                .zip(&program.funcs[id].locals)
                .enumerate()
                .map(|(slot, (value, ty))| {
                    Json::obj(vec![
                        ("slot", number(slot)),
                        ("type", Json::str(ty.to_string())),
                        ("value", snapshot(value, ty, program)),
                    ])
                })
                .collect(),
        )
    }

    fn stack(&self, program: &Program, task: usize) -> Json {
        Json::Arr(
            self.frames
                .get(&task)
                .into_iter()
                .flatten()
                .enumerate()
                .map(|(index, frame)| {
                    Json::obj(vec![
                        ("index", number(index)),
                        ("function_id", number(frame.function)),
                        ("function", Json::str(&program.funcs[frame.function].name)),
                        ("location", self.source_location(frame.location)),
                        ("locals", frame.locals.clone()),
                    ])
                })
                .collect(),
        )
    }

    pub fn enter(
        &mut self,
        program: &Program,
        task: usize,
        id: FuncId,
        args: &[Value],
    ) -> Result<(), Ctl> {
        self.frames.entry(task).or_default().push(Frame {
            function: id,
            locals: Self::values(program, id, args),
            location: self.spans.get(&id).copied(),
        });
        self.event(program, task, id, "call", Json::Null)
    }

    pub fn expression(&mut self, program: &Program, task: usize, expr: &Expr) -> Result<(), Ctl> {
        let Some(id) = self
            .frames
            .get(&task)
            .and_then(|s| s.last())
            .map(|f| f.function)
        else {
            return Ok(());
        };
        if let Expr::Trace(span, _) = expr {
            if let Some(frame) = self.frames.get_mut(&task).and_then(|s| s.last_mut()) {
                frame.location = Some(span.span);
            }
        }
        let operation = match expr {
            Expr::Trace(_, _) => "source",
            Expr::Local(_) => "local",
            Expr::Const(_) => "constant",
            Expr::Func(_) => "function",
            Expr::Call(..) => "call",
            Expr::Apply(..) => "apply",
            Expr::Construct(..) => "construct",
            Expr::Record(_) => "record",
            Expr::Field(..) => "field",
            Expr::SetFields(..) => "update",
            Expr::Let(..) => "bind",
            Expr::BorrowGlobal(..) => "borrow_global",
            Expr::ResourceRegion { .. } => "resource_scope",
            Expr::Match(..) => "match",
            Expr::Dup(..) => "retain",
            Expr::Drop(..) => "release",
        };
        self.event(
            program,
            task,
            id,
            "expression",
            Json::obj(vec![
                (
                    "site",
                    self.sites
                        .get(&(expr as *const Expr as usize))
                        .map_or(Json::Null, number),
                ),
                ("operation", Json::str(operation)),
            ]),
        )
    }

    pub fn value(
        &mut self,
        program: &Program,
        task: usize,
        point: &crate::ir::SourcePoint,
        value: &Value,
    ) -> Result<(), Ctl> {
        let Some(frame) = self.frames.get_mut(&task).and_then(|s| s.last_mut()) else {
            return Ok(());
        };
        let id = frame.function;
        frame.location = Some(point.span);
        self.event(
            program,
            task,
            id,
            "value",
            Json::obj(vec![
                ("type", Json::str(point.ty.to_string())),
                ("value", snapshot(value, &point.ty, program)),
            ]),
        )
    }

    pub fn bind(
        &mut self,
        program: &Program,
        task: usize,
        slot: u32,
        value: &Value,
    ) -> Result<(), Ctl> {
        let Some(frame) = self.frames.get_mut(&task).and_then(|s| s.last_mut()) else {
            return Ok(());
        };
        let id = frame.function;
        let item = Json::obj(vec![
            ("slot", number(slot)),
            (
                "type",
                Json::str(program.funcs[id].locals[slot as usize].to_string()),
            ),
            (
                "value",
                snapshot(value, &program.funcs[id].locals[slot as usize], program),
            ),
        ]);
        if let Json::Arr(values) = &mut frame.locals {
            values.retain(|v| v.get("slot") != Some(&number(slot)));
            values.push(item.clone());
        }
        self.event(program, task, id, "bind", item)
    }

    pub fn leave(
        &mut self,
        program: &Program,
        task: usize,
        id: FuncId,
        result: &Result<Value, Ctl>,
    ) -> Result<(), Ctl> {
        let (kind, data) = match result {
            Ok(value) => (
                "return",
                snapshot(
                    value,
                    program.funcs[id]
                        .ty
                        .params(program.funcs[id].arity as usize)
                        .1,
                    program,
                ),
            ),
            Err(error) => ("error", Json::str(format!("{error:?}"))),
        };
        let response = self.event(program, task, id, kind, data);
        self.frames.entry(task).or_default().pop();
        response
    }

    fn event(
        &mut self,
        program: &Program,
        task: usize,
        id: FuncId,
        kind: &str,
        data: Json,
    ) -> Result<(), Ctl> {
        self.sequence += 1;
        let depth = self.frames.get(&task).map_or(0, Vec::len);
        let event = Json::obj(vec![
            ("event", Json::str(kind)),
            ("sequence", number(self.sequence)),
            ("task", number(task)),
            ("depth", number(depth)),
            ("function_id", number(id)),
            ("function", Json::str(&program.funcs[id].name)),
            (
                "location",
                self.source_location(
                    self.frames
                        .get(&task)
                        .and_then(|s| s.last())
                        .and_then(|f| f.location),
                ),
            ),
            ("data", data),
        ]);
        if self.trace.contains(kind) {
            self.send(&event)?;
        }
        let source_event = kind == "expression"
            && event.at(&["data", "operation"]).and_then(Json::as_str) == Some("source");
        let enter = kind == "call" || source_event;
        let line_break = source_event
            && self
                .frames
                .get(&task)
                .and_then(|s| s.last())
                .and_then(|f| f.location)
                .is_some_and(|span| {
                    self.sources.get(span.file).is_some_and(|file| {
                        self.breakpoints.iter().any(|b| {
                            b.rsplit_once(':').is_some_and(|(name, line)| {
                                line.parse::<u32>() == Ok(span.line)
                                    && (name == file.name
                                        || std::path::Path::new(&file.name)
                                            .file_name()
                                            .and_then(|s| s.to_str())
                                            == Some(name))
                            })
                        })
                    })
                });
        let stop = line_break
            || kind == "error"
            || (kind == "call" && self.breakpoints.contains(&program.funcs[id].name))
            || match self.motion {
                Motion::Step => enter,
                Motion::Continue => false,
                Motion::Next {
                    task: target,
                    depth: target_depth,
                } => enter && task == target && depth <= target_depth,
                Motion::Return {
                    task: target,
                    depth: target_depth,
                } => kind == "return" && task == target && depth <= target_depth,
            };
        if stop {
            self.selected = depth.saturating_sub(1);
            self.send(&Json::obj(vec![
                ("event", Json::str("stopped")),
                ("reason", event),
            ]))?;
            if !self.json {
                writeln!(
                    self.output,
                    "{}: {} [{}]",
                    kind,
                    program.funcs[id].name,
                    self.location(id)
                )
                .map_err(|e| Ctl::Trap(e.to_string()))?;
            }
            self.commands(program, task, depth)?;
        }
        Ok(())
    }

    fn commands(&mut self, program: &Program, task: usize, depth: usize) -> Result<(), Ctl> {
        loop {
            if !self.json {
                write!(self.output, "(fwpdb) ")
                    .and_then(|()| self.output.flush())
                    .map_err(|e| Ctl::Trap(e.to_string()))?;
            }
            let mut line = String::new();
            if self
                .input
                .read_line(&mut line)
                .map_err(|e| Ctl::Trap(e.to_string()))?
                == 0
            {
                return Err(Ctl::Cancelled);
            }
            let request = if self.json {
                match Json::parse(&line) {
                    Ok(r) => r,
                    Err(e) => {
                        self.send(&Json::obj(vec![("error", Json::str(e))]))?;
                        continue;
                    }
                }
            } else {
                let (command, argument) = line.trim().split_once(' ').unwrap_or((line.trim(), ""));
                Json::obj(vec![
                    ("command", Json::str(command)),
                    ("argument", Json::str(argument)),
                ])
            };
            let command = field(&request, "command");
            let argument = field(&request, "argument");
            let mut resume = false;
            let result: Result<Json, String> = match command {
                "c" | "continue" => { self.motion = Motion::Continue; resume = true; Ok(Json::Null) }
                "s" | "step" => { self.motion = Motion::Step; resume = true; Ok(Json::Null) }
                "n" | "next" => { self.motion = Motion::Next { task, depth }; resume = true; Ok(Json::Null) }
                "r" | "return" => { self.motion = Motion::Return { task, depth }; resume = true; Ok(Json::Null) }
                "q" | "quit" => return Err(Ctl::Cancelled),
                "b" | "break" => {
                    let source_line = argument.rsplit_once(':').is_some_and(|(name, line)| {
                        line.parse::<usize>().is_ok_and(|line| line > 0 && self.sources.files.iter().any(|file|
                            (file.name == name || std::path::Path::new(&file.name).file_name().and_then(|s| s.to_str()) == Some(name))
                                && line <= file.text.lines().count()))
                    });
                    if !source_line && !program.funcs.iter().any(|f| f.name == argument) { Err(format!("no reachable function or loaded source line named {argument}")) }
                    else { self.breakpoints.insert(argument.into()); Ok(Json::str(argument)) }
                }
                "clear" => { self.breakpoints.remove(argument); Ok(Json::Null) }
                "breakpoints" => { let mut names: Vec<_> = self.breakpoints.iter().cloned().collect(); names.sort(); Ok(Json::Arr(names.into_iter().map(Json::str).collect())) }
                "w" | "where" | "stack" => Ok(self.stack(program, task)),
                "locals" => Ok(self.frames.get(&task).and_then(|s| s.get(self.selected)).map_or(Json::Null, |f| f.locals.clone())),
                "frame" => match argument.parse::<usize>() { Ok(n) if n < depth => { self.selected = n; Ok(number(n)) }, _ => Err("frame index is outside the current stack".into()) },
                "p" | "print" => {
                    let slot = argument.parse::<usize>();
                    slot.map_err(|_| "print expects a local slot number; use locals to list slots".to_string()).and_then(|slot| {
                        self.frames.get(&task).and_then(|s| s.get(self.selected)).and_then(|f| f.locals.as_array()).and_then(|vs| vs.iter().find(|v| v.get("slot") == Some(&number(slot)))).cloned().ok_or("local slot is not initialized in this frame".into())
                    })
                }
                "l" | "list" => Ok(self.frames.get(&task).and_then(|s| s.get(self.selected)).map_or(Json::Null, |f| self.source_location(f.location))),
                "trace" => {
                    let kinds: HashSet<_> = argument.split_whitespace().map(str::to_string).collect();
                    if kinds.iter().all(|k| ["call", "expression", "value", "bind", "return", "error"].contains(&k.as_str())) { self.trace = kinds; Ok(Json::Null) }
                    else { Err("trace events: call expression value bind return error; empty clears tracing".into()) }
                }
                "h" | "help" => Ok(Json::str("break NAME or FILE:LINE; clear NAME; breakpoints; step; next; return; continue; stack; frame INDEX; locals; print SLOT; list; trace EVENTS; quit")),
                _ => Err(format!("unknown debugger command {command}; use help")),
            };
            let reply = match result {
                Ok(result) => Json::obj(vec![
                    ("id", request.get("id").cloned().unwrap_or(Json::Null)),
                    ("result", result),
                ]),
                Err(error) => Json::obj(vec![
                    ("id", request.get("id").cloned().unwrap_or(Json::Null)),
                    ("error", Json::str(error)),
                ]),
            };
            self.send(&reply)?;
            if !self.json && !resume {
                writeln!(self.output, "{}", reply.pretty())
                    .map_err(|e| Ctl::Trap(e.to_string()))?;
            }
            if resume {
                return Ok(());
            }
        }
    }
}

pub fn snapshot(value: &Value, ty: &MT, program: &Program) -> Json {
    let bits = match value {
        Value::F16(v) => Some(format!("{:04x}", v.to_bits())),
        Value::BF16(v) => Some(format!("{:04x}", v.to_bits())),
        Value::F32(v) => Some(format!("{:08x}", v.to_bits())),
        Value::F64(v) => Some(format!("{:016x}", v.to_bits())),
        Value::F128(v) => Some(format!("{:032x}", v.to_bits())),
        _ => None,
    };
    Json::obj(vec![
        (
            "display",
            Json::str(crate::value::display(value, ty, program, false)),
        ),
        ("float_bits", bits.map_or(Json::Null, Json::str)),
    ])
}

pub fn run(args: &[String]) -> i32 {
    let json = args.iter().any(|s| s == "--json");
    if args.iter().any(|s| s == "--help" || s == "-h") {
        println!("Usage: fwp debug [--json] [--input FILE] SOURCE\nUnoptimized interpreter: function/line breakpoints, source stepping, typed local slots.\nUse --input FILE for program standard input; control commands have their own stream.");
        return 0;
    }
    let mut paths = Vec::new();
    let mut program_input = None;
    let mut options = args.iter();
    while let Some(option) = options.next() {
        match option.as_str() {
            "--json" => {}
            "--input" => {
                let Some(path) = options.next() else {
                    eprintln!("--input needs a file");
                    return 2;
                };
                match std::fs::File::open(path) {
                    Ok(file) => {
                        program_input =
                            Some(Box::new(std::io::BufReader::new(file)) as Box<dyn BufRead>)
                    }
                    Err(e) => {
                        eprintln!("{path}: {e}");
                        return 1;
                    }
                }
            }
            _ => paths.push(option),
        }
    }
    if paths.len() != 1 {
        eprintln!("fwp debug: expected one source file");
        return 2;
    }
    let checked = match crate::driver::check_file(std::path::Path::new(paths[0])) {
        Ok(c) => c,
        Err(e) => {
            eprintln!("{}", e.rendered);
            return 1;
        }
    };
    let mut program = match crate::mono::Mono::new(&checked.env, &checked.typed)
        .with_source_steps()
        .run(crate::mono::Roots {
            main: true,
            ..Default::default()
        }) {
        Ok(p) => p,
        Err(e) => {
            eprintln!("{}", e.render(&checked.sm));
            return 1;
        }
    };
    crate::resource::preserve_frames(&mut program);
    let spans = program
        .binding_names
        .iter()
        .filter_map(|(id, name)| {
            checked
                .env
                .bindings
                .iter()
                .find(|b| &b.name == name)
                .map(|b| (*id, b.span))
        })
        .collect();
    let Some(main) = program.main else {
        eprintln!("program has no main");
        return 1;
    };
    let debugger = std::rc::Rc::new(std::cell::RefCell::new(Debugger::new(
        Box::new(std::io::BufReader::new(std::io::stdin())),
        Box::new(std::io::stdout()),
        json,
        checked.sm,
        spans,
        &program,
    )));
    debugger.borrow_mut().program_input = program_input;
    let mut interpreter = crate::interp::Interp::new(
        &program,
        Box::new(ProgramOutput(debugger.clone(), "output")),
    );
    interpreter.set_error_writer(Box::new(ProgramOutput(debugger.clone(), "stderr")));
    interpreter.debugger = Some(debugger.clone());
    let result = interpreter.call_root(main);
    let status = match &result {
        Ok(_) => 0,
        Err(Ctl::Exit(n)) => *n,
        Err(_) => 1,
    };
    let _ = debugger.borrow_mut().send(&Json::obj(vec![
        ("event", Json::str("finished")),
        ("status", number(status)),
        (
            "error",
            result
                .err()
                .map_or(Json::Null, |e| Json::str(format!("{e:?}"))),
        ),
    ]));
    status
}

struct ProgramOutput(Shared, &'static str);
impl Write for ProgramOutput {
    fn write(&mut self, bytes: &[u8]) -> std::io::Result<usize> {
        let mut debugger = self.0.borrow_mut();
        if debugger.json {
            debugger
                .send(&Json::obj(vec![
                    ("event", Json::str(self.1)),
                    ("text", Json::str(String::from_utf8_lossy(bytes))),
                ]))
                .map_err(|e| std::io::Error::other(format!("{e:?}")))?;
        } else {
            debugger.output.write_all(bytes)?;
        }
        Ok(bytes.len())
    }
    fn flush(&mut self) -> std::io::Result<()> {
        self.0.borrow_mut().output.flush()
    }
}
