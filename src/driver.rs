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
pub const STD_SOURCES: &[(&str, &str)] =
    &[("<std>/prelude.fwp", include_str!("../lib/prelude.fwp"))];

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
    ld.modules.push(("std".into(), HashSet::new(), std_decls));
    if let Some(m) = ld.parse(name, text) {
        ld.add_module("main", m, dir);
    }
    if !ld.errors.is_empty() {
        return Err(Failure {
            rendered: render_all(&ld.errors, &ld.sm),
        });
    }
    let mut env = Env::default();
    env.collect(ld.modules);
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
            let mut p = crate::types::Printer::new(&c.env.table);
            out.push_str(&format!(
                "{} : {}\n",
                crate::types::display_name(&b.name),
                p.show(&s.ty)
            ));
        }
    }
    out
}
