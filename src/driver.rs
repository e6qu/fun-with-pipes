//! Compilation driver: loads modules (the embedded standard library, the
//! root file and its imports) and runs the front end.

use std::collections::{HashMap, HashSet};
use std::path::{Path, PathBuf};

use crate::ast::{Decl, Module, NodeId};
use crate::diag::{render_all, Diagnostic, SourceMap, Span};
use crate::env::Env;
use crate::infer::{check_program, Typed};
use crate::parser::parse_module_recover;

/// Embedded standard library sources, all forming the `std` module.
pub const STD_SOURCES: &[(&str, &str)] = &[
    ("<std>/prelude.fwp", include_str!("../lib/prelude.fwp")),
    ("<std>/list.fwp", include_str!("../lib/list.fwp")),
    ("<std>/option.fwp", include_str!("../lib/option.fwp")),
    ("<std>/string.fwp", include_str!("../lib/string.fwp")),
    (
        "<std>/collections.fwp",
        include_str!("../lib/collections.fwp"),
    ),
    ("<std>/iter.fwp", include_str!("../lib/iter.fwp")),
    ("<std>/io.fwp", include_str!("../lib/io.fwp")),
    ("<std>/fs.fwp", include_str!("../lib/fs.fwp")),
    ("<std>/process.fwp", include_str!("../lib/process.fwp")),
    ("<std>/cli.fwp", include_str!("../lib/cli.fwp")),
    ("<std>/numeric.fwp", include_str!("../lib/numeric.fwp")),
    ("<std>/autodiff.fwp", include_str!("../lib/autodiff.fwp")),
    ("<std>/ternary.fwp", include_str!("../lib/ternary.fwp")),
    ("<std>/simd.fwp", include_str!("../lib/simd.fwp")),
    ("<std>/tensor.fwp", include_str!("../lib/tensor.fwp")),
    ("<std>/task.fwp", include_str!("../lib/task.fwp")),
    ("<std>/net.fwp", include_str!("../lib/net.fwp")),
    ("<std>/json.fwp", include_str!("../lib/json.fwp")),
    ("<std>/url.fwp", include_str!("../lib/url.fwp")),
    ("<std>/log.fwp", include_str!("../lib/log.fwp")),
    ("<std>/http.fwp", include_str!("../lib/http.fwp")),
    ("<std>/ffi.fwp", include_str!("../lib/ffi.fwp")),
];

pub struct Compilation {
    pub sm: SourceMap,
    /// The file id of the root source in `sm`.
    pub root: u32,
    pub env: Env,
    pub typed: Typed,
    pub warnings: Vec<Diagnostic>,
}

impl Compilation {
    pub fn render_warnings(&self) -> String {
        render_all(&self.warnings, &self.sm)
    }
}

/// Front-end failure: the diagnostics (errors, and the warnings found
/// before them), rendered and as data.
#[derive(Debug)]
pub struct Failure {
    pub rendered: String,
    pub diagnostics: Vec<Diagnostic>,
    /// The files the diagnostics' spans refer to.
    pub sm: SourceMap,
    /// The file id of the root source in `sm` (`u32::MAX` if it was not
    /// loaded).
    pub root: u32,
}

impl Failure {
    fn new(diagnostics: Vec<Diagnostic>, sm: &SourceMap, root: u32) -> Failure {
        Failure {
            rendered: render_all(&diagnostics, sm),
            diagnostics,
            sm: sm.clone(),
            root,
        }
    }
}

struct Loader {
    sm: SourceMap,
    next_id: NodeId,
    modules: Vec<(String, HashSet<String>, Vec<Decl>)>,
    /// Imported modules and the file each was loaded from.
    loaded: HashMap<String, Option<PathBuf>>,
    errors: Vec<Diagnostic>,
}

impl Loader {
    /// Parse a file, recording every syntax error. Returns the
    /// declarations that parsed when there was no error.
    fn parse(&mut self, name: &str, text: &str) -> Option<Module> {
        let file = self.sm.add(name.to_string(), text.to_string());
        let (m, errors) = parse_module_recover(text, file, &mut self.next_id);
        let ok = errors.is_empty();
        self.errors.extend(errors);
        ok.then_some(m)
    }

    fn add_module(&mut self, module: &str, m: Module, dir: Option<&Path>) {
        let mut imports = HashSet::new();
        for d in &m.decls {
            if let Decl::Import { module: imp, span } = d {
                imports.insert(imp.clone());
                self.load_import(imp, *span, dir);
            }
        }
        self.modules.push((module.to_string(), imports, m.decls));
    }

    fn load_import(&mut self, name: &str, span: Span, dir: Option<&Path>) {
        if name == "std" || name == "main" {
            self.errors.push(Diagnostic::error(
                span,
                format!("`{}` is a reserved module name", name),
            ));
            return;
        }
        let file_name = format!("{}.fwp", name.replace('.', "/"));
        let path = dir.map(|d| d.join(&file_name));
        let canonical = path.as_deref().and_then(canonical_path);
        if let Some(prev) = self.loaded.get(name) {
            if prev.is_some() && canonical.is_some() && *prev != canonical {
                self.errors.push(Diagnostic::error(
                    span,
                    format!(
                        "module `{}` is imported from two different files; module names must be unique",
                        name
                    ),                ));
            }
            return;
        }
        self.loaded.insert(name.to_string(), canonical);
        if let Some(path) = path {
            if let Ok(text) = std::fs::read_to_string(&path) {
                if let Some(m) = self.parse(&path.to_string_lossy(), &text) {
                    let sub = path.parent().map(Path::to_path_buf);
                    self.add_module(name, m, sub.as_deref());
                }
                return;
            }
        }
        self.errors.push(Diagnostic::error(
            span,
            format!("cannot find module `{}` (looked for `{}`)", name, file_name),
        ));
    }
}

/// The canonical form of an existing file's path. WASI has no `realpath`
/// (nor symbolic links in the playground), so there `.` and `..` are
/// resolved by hand.
fn canonical_path(p: &Path) -> Option<PathBuf> {
    if let Ok(c) = std::fs::canonicalize(p) {
        return Some(c);
    }
    if !cfg!(target_family = "wasm") || !p.exists() {
        return None;
    }
    let abs = std::env::current_dir().ok()?.join(p);
    let mut out = PathBuf::new();
    for c in abs.components() {
        match c {
            std::path::Component::CurDir => {}
            std::path::Component::ParentDir => {
                out.pop();
            }
            c => out.push(c),
        }
    }
    Some(out)
}

/// Type-check a root source text.
pub fn check_source(name: &str, text: &str, dir: Option<&Path>) -> Result<Compilation, Failure> {
    let mut ld = Loader {
        sm: SourceMap::default(),
        next_id: 0,
        modules: Vec::new(),
        loaded: HashMap::new(),
        errors: Vec::new(),
    };
    let mut std_decls = Vec::new();
    for (n, src) in STD_SOURCES {
        if let Some(m) = ld.parse(n, src) {
            std_decls.extend(m.decls);
        }
    }
    let generated = crate::stdgen::numeric_impls();
    if let Some(m) = ld.parse("<std>/numeric-impls.fwp", &generated) {
        std_decls.extend(m.decls);
    }
    ld.modules.push(("std".into(), HashSet::new(), std_decls));
    let root = ld.sm.files.len() as u32;
    if let Some(m) = ld.parse(name, text) {
        ld.add_module("main", m, dir);
    }
    if !ld.errors.is_empty() {
        return Err(Failure::new(ld.errors, &ld.sm, root));
    }
    let modules = match crate::macros::expand(ld.modules, &mut ld.next_id, &ld.sm) {
        Ok(m) => m,
        Err(errs) => return Err(Failure::new(errs, &ld.sm, root)),
    };
    let mut env = Env {
        next_node_id: ld.next_id,
        ..Env::default()
    };
    env.collect(modules);
    let mut typed = Typed::default();
    if env.errors.is_empty() {
        check_program(&mut env, &mut typed);
    }
    let warnings = std::mem::take(&mut env.warnings);
    if !env.errors.is_empty() {
        let mut errs = std::mem::take(&mut env.errors);
        errs.sort_by_key(|d| (d.span.file, d.span.line, d.span.col));
        errs.dedup_by(|a, b| a.span == b.span && a.message == b.message);
        let mut all = warnings;
        all.extend(errs);
        return Err(Failure::new(all, &ld.sm, root));
    }
    Ok(Compilation {
        sm: ld.sm,
        root,
        env,
        typed,
        warnings,
    })
}

pub fn check_file(path: &Path) -> Result<Compilation, Failure> {
    let text = std::fs::read_to_string(path).map_err(|e| {
        let d = Diagnostic::error(
            Span::DUMMY,
            format!("cannot read {}: {}", path.display(), e),
        );
        Failure::new(vec![d], &SourceMap::default(), u32::MAX)
    })?;
    check_source(&path.to_string_lossy(), &text, path.parent())
}

/// Render `name : type` lines for the bindings of the main module.
pub fn signatures(c: &Compilation) -> String {
    let mut out = String::new();
    for i in crate::infer::module_bindings(&c.env, "main") {
        let b = &c.env.bindings[i];
        let g = &c.env.globals[&b.name];
        if let Some(s) = &g.scheme {
            out.push_str(&format!(
                "{} : {}\n",
                crate::types::display_name(&b.name),
                show_scheme(&c.env, s)
            ));
        }
    }
    out
}

/// Render a scheme as `type where C[a], ...`.
pub fn show_scheme(env: &Env, s: &crate::env::Scheme) -> String {
    let mut p = crate::types::Printer::new(&env.table);
    let mut all: Vec<&crate::types::Type> = vec![&s.ty];
    for pr in &s.preds {
        all.extend(pr.args.iter());
    }
    p.prepare(&all);
    let mut out = p.show(&s.ty);
    if !s.preds.is_empty() {
        let rank = |n: &str| match n {
            "std::IntLit" | "std::FloatLit" => 3,
            "std::Dup" => 4,
            n if crate::solve::STRUCTURAL.contains(&n) => 2,
            n if crate::env::BUILTIN_CLASSES.contains(&n.trim_start_matches("std::")) => 1,
            _ => 0,
        };
        let mut preds = s.preds.clone();
        preds.sort_by_key(|p| rank(&p.trait_name));
        let ps: Vec<String> = preds
            .iter()
            .map(|pr| {
                let args: Vec<String> = pr.args.iter().map(|a| p.show(a)).collect();
                format!(
                    "{}[{}]",
                    crate::types::display_name(&pr.trait_name),
                    args.join(", ")
                )
            })
            .collect();
        out.push_str(" where ");
        out.push_str(&ps.join(", "));
    }
    out
}

/// Lower a checked program to IR, with the doc comments of its files.
pub fn lower(
    c: Compilation,
    roots: crate::mono::Roots,
) -> Result<(Compilation, crate::ir::Program), Failure> {
    match crate::mono::lower(&c.env, &c.typed, roots) {
        Ok(mut p) => {
            p.docs = crate::cli::Docs::from_sources(&c.sm, c.root);
            Ok((c, p))
        }
        Err(d) => Err(Failure::new(vec![d], &c.sm, c.root)),
    }
}

/// Check and lower a file to IR.
pub fn compile_file(
    path: &Path,
    roots: crate::mono::Roots,
) -> Result<(Compilation, crate::ir::Program), Failure> {
    let c = check_file(path)?;
    lower(c, roots)
}

/// Check and lower source text to IR.
pub fn compile_source(
    name: &str,
    text: &str,
    roots: crate::mono::Roots,
) -> Result<(Compilation, crate::ir::Program), Failure> {
    compile_source_in(name, text, None, roots)
}

/// Check and lower source text whose imports are found in `dir`.
pub fn compile_source_in(
    name: &str,
    text: &str,
    dir: Option<&Path>,
    roots: crate::mono::Roots,
) -> Result<(Compilation, crate::ir::Program), Failure> {
    let c = check_source(name, text, dir)?;
    lower(c, roots)
}

/// The file name of a program read from standard input (`fwp run -`).
pub const STDIN_NAME: &str = "<stdin>";

/// Read a program from standard input.
pub fn read_stdin() -> std::io::Result<String> {
    use std::io::Read;
    let mut buf = Vec::new();
    std::io::stdin().lock().read_to_end(&mut buf)?;
    Ok(String::from_utf8_lossy(&buf).into_owned())
}

/// Type-check the program at `path`, or standard input when `path` is
/// `-` (its imports are then found in the current directory).
pub fn check_input(path: &str) -> Result<Compilation, Failure> {
    if path != "-" {
        return check_file(Path::new(path));
    }
    let text = read_stdin().map_err(|e| {
        let d = Diagnostic::error(Span::DUMMY, format!("cannot read standard input: {}", e));
        Failure::new(vec![d], &SourceMap::default(), u32::MAX)
    })?;
    check_source(STDIN_NAME, &text, Some(Path::new(".")))
}

/// Check and lower the program at `path` (`-`: standard input) to IR.
pub fn compile_input(
    path: &str,
    roots: crate::mono::Roots,
) -> Result<(Compilation, crate::ir::Program), Failure> {
    let c = check_input(path)?;
    lower(c, roots)
}

/// Why the interpreter of the WebAssembly build of fwp cannot run `prog`:
/// it has no threads (so no tasks), no sockets, no processes and no
/// `dlopen` (so no foreign C functions). These are the effects the
/// `wasm32-wasi` target rejects too, checked when the program is lowered,
/// before it starts.
pub fn wasm_host_unsupported(prog: &crate::ir::Program) -> Option<String> {
    const BUILD: &str = "the WebAssembly build of fwp";
    if crate::cgen::uses_services(prog) {
        return Some(format!(
            "services (gRPC calls) are not available in {}",
            BUILD
        ));
    }
    if let Some((effect, sym)) = crate::cgen::wasm_missing_effect(prog) {
        return Some(format!(
            "{} does not provide the `{}` effect (used by `{}`)",
            BUILD, effect, sym
        ));
    }
    prog.funcs.iter().find_map(|f| match &f.body {
        crate::ir::Body::ForeignC { symbol, .. } => Some(format!(
            "foreign C functions are not available in {} (`{}`)",
            BUILD, symbol
        )),
        _ => None,
    })
}

/// The stack of the WebAssembly build of fwp, in bytes. It must match the
/// `-zstack-size` linker argument in `.cargo/config.toml`.
pub const WASM_STACK_SIZE: usize = 512 << 20;

/// Run `f` on a thread with a large stack (deeply recursive tacit code).
/// WebAssembly has no threads: `f` runs on the main stack, whose size is
/// set at link time ([`WASM_STACK_SIZE`]).
#[cfg(target_family = "wasm")]
pub fn with_big_stack<T: Send + 'static>(f: impl FnOnce() -> T + Send + 'static) -> T {
    crate::interp::set_stack_limit(WASM_STACK_SIZE);
    f()
}

/// Run `f` on a thread with a large stack (deeply recursive tacit code).
#[cfg(not(target_family = "wasm"))]
pub fn with_big_stack<T: Send + 'static>(f: impl FnOnce() -> T + Send + 'static) -> T {
    let size: usize = if cfg!(target_pointer_width = "64") {
        4 << 30
    } else {
        256 << 20
    };
    std::thread::Builder::new()
        .stack_size(size)
        .spawn(move || {
            crate::interp::set_stack_limit(size);
            f()
        })
        .expect("spawn interpreter thread")
        .join()
        .expect("interpreter thread panicked")
}

/// Run the tests of a program; returns (passed, failed).
pub fn run_tests(prog: &crate::ir::Program, out: &mut dyn std::io::Write) -> (usize, usize) {
    use crate::interp::{Ctl, Interp};
    let (mut pass, mut fail) = (0, 0);
    for (name, id) in &prog.tests {
        let mut sink = Vec::new();
        let r = {
            let mut it = Interp::new(prog, Box::new(&mut sink));
            it.call_root(*id)
        };
        let status = match r {
            Ok(v) if v.as_bool() => {
                pass += 1;
                "ok".to_string()
            }
            Ok(_) => {
                fail += 1;
                "FAILED".to_string()
            }
            Err(Ctl::Fail(v, mt)) => {
                fail += 1;
                format!(
                    "FAILED (error: {})",
                    crate::value::display(&v, &mt, prog, true)
                )
            }
            Err(Ctl::Trap(m)) => {
                fail += 1;
                format!("FAILED (trap: {})", m)
            }
            Err(Ctl::Exit(c)) => {
                fail += 1;
                format!("FAILED (exit {})", c)
            }
            Err(Ctl::Cancelled) => {
                fail += 1;
                "FAILED (cancelled)".to_string()
            }
        };
        let _ = writeln!(out, "test {} ... {}", name, status);
    }
    (pass, fail)
}
