//! Compilation driver: loads modules (the embedded standard library, the
//! root file and its imports) and runs the front end.

use std::collections::{HashMap, HashSet};
use std::path::{Path, PathBuf};

use crate::ast::{Decl, Module, NodeId};
use crate::diag::{render_all, Diagnostic, SourceMap, Span};
use crate::env::Env;
use crate::infer::{check_program, Typed};
use crate::parser::parse_module;

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
    pub env: Env,
    pub typed: Typed,
    pub warnings: Vec<Diagnostic>,
}

impl Compilation {
    pub fn render_warnings(&self) -> String {
        render_all(&self.warnings, &self.sm)
    }
}

/// Front-end failure with rendered diagnostics.
#[derive(Debug)]
pub struct Failure {
    pub rendered: String,
}

struct Loader {
    sm: SourceMap,
    next_id: NodeId,
    modules: Vec<(String, HashSet<String>, Vec<Decl>)>,
    loaded: HashMap<String, ()>,
    errors: Vec<Diagnostic>,
}

impl Loader {
    fn parse(&mut self, name: &str, text: &str) -> Option<Module> {
        let file = self.sm.add(name.to_string(), text.to_string());
        match parse_module(text, file, &mut self.next_id) {
            Ok(m) => Some(m),
            Err(d) => {
                self.errors.push(d);
                None
            }
        }
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
        if self.loaded.contains_key(name) {
            return;
        }
        self.loaded.insert(name.to_string(), ());
        let file_name = format!("{}.fwp", name.replace('.', "/"));
        let candidates: Vec<PathBuf> = dir.map(|d| d.join(&file_name)).into_iter().collect();
        for path in candidates {
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
    if let Some(m) = ld.parse(name, text) {
        ld.add_module("main", m, dir);
    }
    if !ld.errors.is_empty() {
        return Err(Failure {
            rendered: render_all(&ld.errors, &ld.sm),
        });
    }
    let modules = match crate::macros::expand(ld.modules, &mut ld.next_id, &ld.sm) {
        Ok(m) => m,
        Err(errs) => {
            return Err(Failure {
                rendered: render_all(&errs, &ld.sm),
            })
        }
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
        let mut rendered = render_all(&warnings, &ld.sm);
        rendered.push_str(&render_all(&errs, &ld.sm));
        return Err(Failure { rendered });
    }
    Ok(Compilation {
        sm: ld.sm,
        env,
        typed,
        warnings,
    })
}

pub fn check_file(path: &Path) -> Result<Compilation, Failure> {
    let text = std::fs::read_to_string(path).map_err(|e| Failure {
        rendered: format!("error: cannot read {}: {}\n", path.display(), e),
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

/// Check and lower a file to IR.
pub fn compile_file(
    path: &Path,
    roots: crate::mono::Roots,
) -> Result<(Compilation, crate::ir::Program), Failure> {
    let c = check_file(path)?;
    match crate::mono::lower(&c.env, &c.typed, roots) {
        Ok(p) => Ok((c, p)),
        Err(d) => Err(Failure {
            rendered: d.render(&c.sm),
        }),
    }
}

/// Check and lower source text to IR.
pub fn compile_source(
    name: &str,
    text: &str,
    roots: crate::mono::Roots,
) -> Result<(Compilation, crate::ir::Program), Failure> {
    let c = check_source(name, text, None)?;
    match crate::mono::lower(&c.env, &c.typed, roots) {
        Ok(p) => Ok((c, p)),
        Err(d) => Err(Failure {
            rendered: d.render(&c.sm),
        }),
    }
}

/// Run `f` on a thread with a large stack (deeply recursive tacit code).
pub fn with_big_stack<T: Send + 'static>(f: impl FnOnce() -> T + Send + 'static) -> T {
    std::thread::Builder::new()
        .stack_size(if cfg!(target_pointer_width = "64") {
            4 << 30
        } else {
            256 << 20
        })
        .spawn(f)
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
