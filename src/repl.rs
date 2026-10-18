//! Persistent, interpreted interactive sessions. Each cell is checked normally;
//! linked functions keep stable IDs so cached values and captured closures live
//! across cells without evaluating earlier runtime effects again.
use std::cell::RefCell;
use std::collections::HashMap;
use std::hash::{Hash, Hasher};
use std::io::{self, BufRead, IsTerminal, Write};
use std::path::PathBuf;
use std::rc::Rc;
use std::sync::atomic::{AtomicBool, Ordering};
use std::time::{Duration, Instant};

use crate::ast::{Decl, Module};
use crate::driver::{self, Compilation};
use crate::interp::{Ctl, Interp};
use crate::ir::{Body, Expr, FuncId, Program, MT};
use crate::value::{Closure, Value};

static INTERRUPTED: AtomicBool = AtomicBool::new(false);
pub(crate) fn interrupted() -> bool {
    INTERRUPTED.load(Ordering::Relaxed)
}

const HELP: &str = "Enter expressions or ordinary fwp declarations. No JIT is used.
Definitions are lazy, as in a source file; cached values run once per type.
Results are available as out1, out2, ...; it names the latest successful result.
:type EXPR     Show its inferred type without running it (also EXPR?).
:names         List session bindings and their types.
:history       Show entered cells.
:load PATH     Load declarations; imports resolve from the session directory.
:save PATH     Save user declarations as source (not cached result values).
:time EXPR     Evaluate once; report checking/linking and evaluation separately.
:paste         Enter a block, finished by a line containing :end.
:reset         Release the session and start afresh (history remains).
:help          Show this help.
:quit          Exit (also Ctrl-D on an empty input).
Tab completes names; arrows and Ctrl-R browse/search history.
Ctrl-C clears input or interrupts interpreted calls; blocking I/O may finish first.
";

#[derive(Debug)]
pub struct Outcome {
    pub index: usize,
    pub value: Option<String>,
    pub signatures: String,
    pub preparation: Duration,
    pub evaluation: Duration,
}

pub struct Session {
    directory: PathBuf,
    declarations: Vec<Decl>,
    versions: HashMap<String, u64>,
    program: Program,
    globals: HashMap<(String, MT, u64), FuncId>,
    caches: Rc<RefCell<Vec<Option<Value>>>>,
    world: std::sync::Arc<crate::sched::World>,
    task: std::sync::Arc<crate::sched::TaskShared>,
    rng: Option<u64>,
    pub history: Vec<String>,
    pub names: Vec<String>,
    signatures: String,
}

impl Session {
    pub fn new(directory: PathBuf) -> Result<Self, String> {
        let c = driver::check_source("<repl>", "", Some(&directory)).map_err(|f| f.rendered)?;
        Ok(Self {
            directory,
            declarations: Vec::new(),
            versions: HashMap::new(),
            program: Program::default(),
            globals: HashMap::new(),
            caches: Rc::new(RefCell::new(Vec::new())),
            world: crate::sched::World::new(),
            task: crate::sched::TaskShared::new(),
            rng: None,
            history: Vec::new(),
            names: names(&c),
            signatures: String::new(),
        })
    }

    fn source(declarations: &[Decl]) -> String {
        crate::pretty::module(&Module {
            decls: declarations.to_vec(),
        })
    }

    pub fn source_text(&self) -> String {
        Self::source(&self.declarations)
    }

    fn check(&self, declarations: &[Decl]) -> Result<Compilation, String> {
        driver::check_source("<repl>", &Self::source(declarations), Some(&self.directory))
            .map_err(|f| f.rendered)
    }

    pub fn type_of(&self, expression: &str) -> Result<String, String> {
        let source = format!("{}\nrepl-query = {}\n", self.source_text(), expression);
        let c =
            driver::check_repl_source("<repl-type>", &source, &self.directory, "main::repl-query")
                .map_err(|f| f.rendered)?;
        let scheme = c
            .env
            .globals
            .get("main::repl-query")
            .and_then(|g| g.scheme.as_ref())
            .ok_or("expression has no inferred type")?;
        Ok(driver::show_scheme(&c.env, scheme))
    }

    pub fn submit(&mut self, text: &str, output: &mut dyn Write) -> Result<Outcome, String> {
        let started = Instant::now();
        INTERRUPTED.store(false, Ordering::Relaxed);
        self.history.push(text.to_string());
        let index = self.history.len();
        let mut declarations = self.declarations.clone();
        let mut versions = self.versions.clone();
        let parsed = crate::parser::parse_module(text, 0, &mut 0);
        if let Ok(module) = parsed.as_ref() {
            if !module.decls.is_empty() {
                for declaration in &module.decls {
                    if let Some(key) = declaration_key(declaration) {
                        if key.starts_with("type:")
                            && declarations
                                .iter()
                                .any(|d| declaration_key(d).as_ref() == Some(&key))
                        {
                            return Err("type redefinition needs :reset; live values retain their original type".into());
                        }
                        declarations.retain(|d| declaration_key(d).as_ref() != Some(&key));
                    }
                    let declared_name = match declaration {
                        Decl::Bind(binding) | Decl::Macro(binding) => Some(binding.name.as_str()),
                        Decl::Sig { sig, .. } => Some(sig.name.as_str()),
                        Decl::Foreign { name, .. } | Decl::Export { name, .. } => {
                            Some(name.as_str())
                        }
                        _ => None,
                    };
                    if declared_name.is_some_and(reserved) {
                        return Err(
                            "it, out followed by digits, and repl-query are REPL result names"
                                .into(),
                        );
                    }
                    if let Decl::Bind(binding) = declaration {
                        versions.insert(format!("main::{}", binding.name), index as u64);
                    }
                    declarations.push(declaration.clone());
                }
                let c = self.check(&declarations)?;
                self.names = names(&c);
                self.signatures = driver::signatures(&c);
                self.declarations = declarations;
                self.versions = versions;
                return Ok(Outcome {
                    index,
                    value: None,
                    signatures: self.signatures.clone(),
                    preparation: started.elapsed(),
                    evaluation: Duration::ZERO,
                });
            }
        }
        // A malformed declaration should keep its declaration diagnostic instead
        // of being disguised as an expression. The expression parser decides.
        if let Err(error) = crate::parser::parse_expr_text(text, 0, &mut 0) {
            let mut sm = crate::diag::SourceMap::default();
            sm.add("<repl>", text);
            return Err(parsed.err().unwrap_or(error).render(&sm));
        }
        let result_name = format!("out{index}");
        let addition = format!("{result_name} = {text}\n");
        let module = crate::parser::parse_module(&addition, 0, &mut 0).map_err(|e| e.message)?;
        declarations.extend(module.decls);
        let entry = format!("main::{result_name}");
        let c = driver::check_repl_source(
            "<repl>",
            &Self::source(&declarations),
            &self.directory,
            &entry,
        )
        .map_err(|f| f.rendered)?;
        let scheme = c.env.globals[&entry]
            .scheme
            .as_ref()
            .ok_or("expression has no type")?;
        if scheme
            .vars
            .iter()
            .any(|v| c.env.table.vars[*v as usize].kind != crate::types::Kind::Eff)
        {
            return Err("expression remains generic; use :type to inspect it, or give a binding a concrete signature before evaluating it".into());
        }
        let result_signature = driver::show_scheme(&c.env, scheme);
        let (c, fresh) = driver::lower(
            c,
            crate::mono::Roots {
                entry: Some(entry.clone()),
                ..Default::default()
            },
        )
        .map_err(|f| f.rendered)?;
        if fresh
            .funcs
            .iter()
            .any(|f| matches!(f.body, Body::ForeignC { .. }))
        {
            return Err(
                "foreign C calls require an ahead-of-time build; the REPL does not compile shims"
                    .into(),
            );
        }
        versions.insert(entry, index as u64);
        let id = self.link(fresh, &c, &versions)?;
        let preparation = started.elapsed();
        let evaluating = Instant::now();
        let value = {
            let mut interpreter = Interp::new(&self.program, Box::new(output));
            interpreter.cafs = self.caches.clone();
            interpreter.world = self.world.clone();
            interpreter.task = self.task.clone();
            if let Some(seed) = self.rng {
                interpreter.rng = seed;
            }
            let result = if self.program.funcs[id].arity == 0 {
                interpreter.call_root(id)
            } else {
                Ok(Value::Closure(Rc::new(Closure {
                    func: id,
                    args: Vec::new(),
                })))
            };
            self.rng = Some(interpreter.rng);
            result
        };
        let evaluation = evaluating.elapsed();
        INTERRUPTED.store(false, Ordering::Relaxed);
        let value = value.map_err(|error| match error {
            Ctl::Trap(message) => format!("trap: {message}"),
            Ctl::Fail(value, ty) => format!(
                "error: {}",
                crate::value::display(&value, &ty, &self.program, true)
            ),
            Ctl::Exit(code) => format!("program requested exit {code}; session remains open"),
            Ctl::Cancelled => "interrupted".into(),
        })?;
        let display =
            crate::value::display(&value, &self.program.funcs[id].ty, &self.program, false);
        // The checked interface of a stored result must no longer depend on
        // the expression that produced it: later redefinitions can change type,
        // and earlier runtime/compile-time effects must not run again.
        declarations.retain(|d| !matches!(d, Decl::Bind(b) if b.name == result_name));
        let stored = format!("{result_name} : {result_signature}\n{result_name} = prim.trap \"internal: missing REPL value\"\n");
        declarations.extend(
            crate::parser::parse_module(&stored, 0, &mut 0)
                .map_err(|e| e.message)?
                .decls,
        );
        declarations.retain(|d| !matches!(d, Decl::Bind(b) if b.name == "it"));
        declarations.extend(
            crate::parser::parse_module(&format!("it = {result_name}\n"), 0, &mut 0)
                .unwrap()
                .decls,
        );
        versions.insert("main::it".into(), index as u64);
        self.names = names(&c);
        self.names.push("it".into());
        self.signatures = driver::signatures(&c);
        self.declarations = declarations;
        self.versions = versions;
        Ok(Outcome {
            index,
            value: Some(display),
            signatures: String::new(),
            preparation,
            evaluation,
        })
    }

    fn link(
        &mut self,
        fresh: Program,
        c: &Compilation,
        versions: &HashMap<String, u64>,
    ) -> Result<FuncId, String> {
        let mut ids = Vec::with_capacity(fresh.funcs.len());
        let mut additions = Vec::new();
        for (index, function) in fresh.funcs.iter().enumerate() {
            let key = fresh
                .binding_names
                .get(&index)
                .filter(|name| {
                    function.arity == 0 || name.strip_prefix("main::").is_some_and(reserved)
                })
                .map(|name| {
                    let version = versions.get(name).copied().unwrap_or_else(|| {
                        let binding = c.env.bindings.iter().find(|b| &b.name == name);
                        let mut hasher = std::collections::hash_map::DefaultHasher::new();
                        if let Some(file) = binding.and_then(|b| c.sm.get(b.span.file)) {
                            file.text.hash(&mut hasher);
                        }
                        hasher.finish()
                    });
                    (name.clone(), function.ty.clone(), version)
                });
            if let Some(id) = key.as_ref().and_then(|k| self.globals.get(k)) {
                ids.push(*id);
            } else {
                let id = self.program.funcs.len() + additions.len();
                ids.push(id);
                additions.push(index);
                if let Some(key) = key {
                    self.globals.insert(key, id);
                }
            }
        }
        for index in additions {
            let mut function = fresh.funcs[index].clone();
            match &mut function.body {
                Body::Expr(body) => remap_expr(body, &ids),
                Body::Remote(remote) => {
                    remote.iter_fn = remote.iter_fn.map(|id| ids[id]);
                }
                _ => {}
            }
            self.program.funcs.push(function);
        }
        for (ty, shape) in fresh.shapes {
            self.program.shapes.insert(ty, shape);
        }
        self.program.field_order.extend(fresh.field_order);
        self.program.repr_c.extend(fresh.repr_c);
        self.caches
            .borrow_mut()
            .resize(self.program.funcs.len(), None);
        Ok(ids[fresh.main.ok_or("expression has no entry point")?])
    }
}

fn names(c: &Compilation) -> Vec<String> {
    let mut names: Vec<_> = c
        .env
        .globals
        .keys()
        .map(|name| crate::types::display_name(name))
        .collect();
    names.sort();
    names.dedup();
    names
}

fn reserved(name: &str) -> bool {
    name == "it"
        || name == "repl-query"
        || name
            .strip_prefix("out")
            .is_some_and(|s| !s.is_empty() && s.bytes().all(|b| b.is_ascii_digit()))
}

fn declaration_key(declaration: &Decl) -> Option<String> {
    match declaration {
        Decl::Bind(b) => Some(format!("bind:{}", b.name)),
        Decl::Macro(b) => Some(format!("macro:{}", b.name)),
        Decl::Sig { sig, .. } => Some(format!("sig:{}", sig.name)),
        Decl::Import { module, .. } => Some(format!("import:{module}")),
        Decl::Type(t) => Some(format!("type:{}", t.name)),
        _ => None,
    }
}

fn remap_value(value: &Value, ids: &[FuncId]) -> Value {
    match value {
        Value::Closure(c) => Value::Closure(Rc::new(Closure {
            func: ids[c.func],
            args: c.args.iter().map(|v| remap_value(v, ids)).collect(),
        })),
        Value::Record(fields) => Value::tuple(fields.iter().map(|v| remap_value(v, ids)).collect()),
        Value::Data(tag, fields) => {
            Value::data(*tag, fields.iter().map(|v| remap_value(v, ids)).collect())
        }
        Value::Array(values) => Value::Array(Rc::new(
            values.iter().map(|v| remap_value(v, ids)).collect(),
        )),
        Value::Map(values) => Value::Map(Rc::new(
            values
                .iter()
                .map(|(k, v)| (remap_value(k, ids), remap_value(v, ids)))
                .collect(),
        )),
        other => other.clone(),
    }
}

fn remap_expr(expr: &mut Expr, ids: &[FuncId]) {
    match expr {
        Expr::Func(id) => *id = ids[*id],
        Expr::Const(value) => *value = remap_value(value, ids),
        Expr::Call(id, args) => {
            *id = ids[*id];
            for arg in args {
                remap_expr(arg, ids);
            }
        }
        Expr::BorrowGlobal(_, id, body) => {
            *id = ids[*id];
            remap_expr(body, ids);
        }
        Expr::Apply(f, args) => {
            remap_expr(f, ids);
            for arg in args {
                remap_expr(arg, ids);
            }
        }
        Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                remap_expr(arg, ids);
            }
        }
        Expr::Let(_, value, body) => {
            remap_expr(value, ids);
            remap_expr(body, ids);
        }
        Expr::Field(value, _)
        | Expr::Dup(_, value)
        | Expr::Drop(_, value)
        | Expr::ResourceRegion { body: value, .. } => remap_expr(value, ids),
        Expr::SetFields(value, fields) => {
            remap_expr(value, ids);
            for (_, value) in fields {
                remap_expr(value, ids);
            }
        }
        Expr::Match(value, arms) => {
            remap_expr(value, ids);
            for (_, body) in arms {
                remap_expr(body, ids);
            }
        }
        Expr::Local(_) => {}
    }
}

/// Delimiters and a trailing operator require more input. Layout blocks finish
/// with a blank line; :paste is available for several declarations at once.
pub fn incomplete(text: &str) -> bool {
    use crate::lexer::{Sym, Tok};
    let tokens = match crate::lexer::lex(text, 0) {
        Ok(tokens) => tokens,
        Err(error) => return error.message.contains("unterminated"),
    };
    let mut open = Vec::new();
    for token in &tokens {
        match token.tok {
            Tok::Sym(Sym::LParen) => open.push(Sym::RParen),
            Tok::Sym(Sym::LBracket) => open.push(Sym::RBracket),
            Tok::Sym(Sym::LBrace) => open.push(Sym::RBrace),
            Tok::Sym(s @ (Sym::RParen | Sym::RBracket | Sym::RBrace)) => {
                if open.pop() != Some(s) {
                    return false;
                }
            }
            _ => {}
        }
    }
    if !open.is_empty() {
        return true;
    }
    let last = tokens.iter().rev().find(|t| !matches!(t.tok, Tok::Eof));
    if last.is_some_and(|t| {
        matches!(
            t.tok,
            Tok::Keyword(crate::lexer::Kw::Match)
                | Tok::Sym(
                    Sym::Eq
                        | Sym::Arrow
                        | Sym::Pipe
                        | Sym::Plus
                        | Sym::Minus
                        | Sym::Star
                        | Sym::Slash
                        | Sym::Percent
                        | Sym::EqEq
                        | Sym::Ne
                        | Sym::Lt
                        | Sym::Le
                        | Sym::Gt
                        | Sym::Ge
                )
        )
    }) {
        return true;
    }
    text.contains('\n')
        && !text.ends_with('\n')
        && text.lines().any(|line| {
            let line = line.trim_end();
            line.ends_with('=') || line.ends_with("match")
        })
}

fn command(session: &mut Session, line: &str, output: &mut dyn Write) -> Result<bool, String> {
    let trimmed = line.trim();
    let (name, argument) = trimmed
        .split_once(char::is_whitespace)
        .unwrap_or((trimmed, ""));
    let argument = argument.trim();
    match name {
        ":quit" => return Ok(false),
        ":help" => write!(output, "{HELP}").map_err(|e| e.to_string())?,
        ":type" => writeln!(output, "{}", session.type_of(argument)?).map_err(|e| e.to_string())?,
        ":names" => write!(output, "{}", session.signatures).map_err(|e| e.to_string())?,
        ":history" => {
            for (i, cell) in session.history.iter().enumerate() {
                writeln!(output, "In [{}]: {cell}", i + 1).map_err(|e| e.to_string())?;
            }
        }
        ":reset" => {
            let history = std::mem::take(&mut session.history);
            *session = Session::new(session.directory.clone())?;
            session.history = history;
            writeln!(output, "Session reset.").map_err(|e| e.to_string())?;
        }
        ":save" => {
            if argument.is_empty() {
                return Err("usage: :save PATH".into());
            }
            std::fs::write(
                argument,
                Session::source(
                    &session
                        .declarations
                        .iter()
                        .filter(|d| {
                            !matches!(d, Decl::Bind(b) if reserved(&b.name))
                                && !matches!(d, Decl::Sig { sig, .. } if reserved(&sig.name))
                        })
                        .cloned()
                        .collect::<Vec<_>>(),
                ),
            )
            .map_err(|e| e.to_string())?;
        }
        ":load" => {
            if argument.is_empty() {
                return Err("usage: :load PATH".into());
            }
            let source = std::fs::read_to_string(argument).map_err(|e| e.to_string())?;
            display_outcome(session.submit(&source, output)?, false, output)?;
        }
        ":time" => display_outcome(session.submit(argument, output)?, true, output)?,
        _ if trimmed.starts_with(':') => return Err(format!("unknown command {name}; use :help")),
        _ if trimmed.ends_with('?') => writeln!(
            output,
            "{}",
            session.type_of(trimmed.trim_end_matches('?'))?
        )
        .map_err(|e| e.to_string())?,
        _ => display_outcome(session.submit(line, output)?, false, output)?,
    }
    Ok(true)
}

fn display_outcome(outcome: Outcome, timed: bool, output: &mut dyn Write) -> Result<(), String> {
    if let Some(value) = outcome.value {
        writeln!(output, "Out[{}]: {value}", outcome.index).map_err(|e| e.to_string())?;
    } else {
        write!(output, "{}", outcome.signatures).map_err(|e| e.to_string())?;
    }
    if timed {
        writeln!(
            output,
            "Check/link: {:.3} ms; interpreted evaluation: {:.3} ms (one execution)",
            outcome.preparation.as_secs_f64() * 1000.0,
            outcome.evaluation.as_secs_f64() * 1000.0
        )
        .map_err(|e| e.to_string())?;
    }
    Ok(())
}

/// Scripted sessions use the same engine, without prompts or terminal escapes.
pub fn run_stream(
    mut input: impl BufRead,
    mut output: impl Write,
    directory: PathBuf,
) -> Result<(), String> {
    let mut session = Session::new(directory)?;
    let mut buffer = String::new();
    let mut paste = false;
    loop {
        let mut line = String::new();
        let read = input.read_line(&mut line).map_err(|e| e.to_string())?;
        if read == 0 {
            if !buffer.trim().is_empty() {
                return Err("incomplete input at end of session".into());
            }
            break;
        }
        if buffer.is_empty() && line.trim() == ":paste" {
            paste = true;
            continue;
        }
        if paste && line.trim() != ":end" {
            buffer.push_str(&line);
            continue;
        }
        if paste {
            paste = false;
        } else {
            if buffer.is_empty() && line.trim().is_empty() {
                continue;
            }
            buffer.push_str(line.trim_end_matches(['\r', '\n']));
            if incomplete(&buffer) {
                buffer.push('\n');
                continue;
            }
        }
        let result = command(&mut session, &buffer, &mut output);
        buffer.clear();
        match result {
            Ok(false) => break,
            Ok(true) => {}
            Err(error) => writeln!(output, "{error}").map_err(|e| e.to_string())?,
        }
        output.flush().map_err(|e| e.to_string())?;
    }
    Ok(())
}

pub fn run(args: &[String]) -> i32 {
    if args.iter().any(|a| a == "--help" || a == "-h") {
        println!("Usage: fwp repl [--no-history | --history PATH]\n\n{HELP}");
        return 0;
    }
    let mut history = None;
    let mut no_history = false;
    let mut args = args.iter();
    while let Some(arg) = args.next() {
        match arg.as_str() {
            "--no-history" => no_history = true,
            "--history" => match args.next() {
                Some(path) => history = Some(PathBuf::from(path)),
                None => {
                    eprintln!("--history needs a path");
                    return 2;
                }
            },
            _ => {
                eprintln!("unknown REPL option {arg}");
                return 2;
            }
        }
    }
    if no_history && history.is_some() {
        eprintln!("choose --no-history or --history, not both");
        return 2;
    }
    let directory = match std::env::current_dir() {
        Ok(p) => p,
        Err(e) => {
            eprintln!("{e}");
            return 1;
        }
    };
    let result = if !io::stdin().is_terminal() || !io::stdout().is_terminal() {
        run_stream(io::stdin().lock(), io::stdout(), directory)
    } else {
        #[cfg(not(target_family = "wasm"))]
        {
            terminal::run(directory, history, no_history)
        }
        #[cfg(target_family = "wasm")]
        {
            Err("terminal editing is available in the native compiler; pipe a scripted session on WASI".into())
        }
    };
    match result {
        Ok(()) => 0,
        Err(error) => {
            eprintln!("fwp repl: {error}");
            1
        }
    }
}

#[cfg(not(target_family = "wasm"))]
mod terminal;
