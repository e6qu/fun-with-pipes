//! Program environment: modules, name resolution, type declarations,
//! constructors and global value signatures.

use std::collections::{HashMap, HashSet};

use crate::ast::*;
use crate::diag::{Diagnostic, Span};
use crate::types::*;

/// Effect labels known to the compiler.
pub const EFFECTS: &[&str] = &[
    "IO", "FileIO", "Network", "Async", "Random", "State", "Alloc", "Error", "Unsafe",
];

#[derive(Clone, Debug)]
pub struct Scheme {
    /// Quantified variables, in a stable order (instantiation order).
    pub vars: Vec<TV>,
    pub preds: Vec<Pred>,
    pub ty: Type,
}

impl Scheme {
    pub fn mono(ty: Type) -> Scheme {
        Scheme {
            vars: vec![],
            preds: vec![],
            ty,
        }
    }
}

#[derive(Clone, Debug, PartialEq)]
pub struct Pred {
    pub trait_name: String,
    pub args: Vec<Type>,
}

#[derive(Clone, Debug)]
pub enum TypeDefKind {
    Adt { ctors: Vec<String> },
    Record { fields: Vec<String> },
    Alias { params: Vec<TV>, ty: Type },
    Opaque,
}

#[derive(Clone, Debug)]
pub struct TypeDef {
    pub name: String,
    pub span: Span,
    pub arity: usize,
    pub kind: TypeDefKind,
    pub resource: bool,
    /// Parameter template variables (rigid).
    pub params: Vec<TV>,
    /// Number of type arguments each parameter takes (0 for ordinary
    /// types, 1 for `F` in `F[A]`, ...).
    pub param_kinds: Vec<usize>,
}

#[derive(Clone, Debug)]
pub struct CtorDef {
    pub name: String,
    pub type_name: String,
    pub tag: usize,
    pub fields: Vec<Type>,
    pub scheme: Scheme,
}

#[derive(Clone, Debug, PartialEq)]
pub enum GlobalKind {
    /// User or stdlib binding; index into `Env::bindings`.
    Binding(usize),
    /// Runtime-provided function.
    Foreign { abi: String, symbol: String },
    /// Trait method (filled in by the trait machinery).
    Method { trait_name: String },
}

#[derive(Clone, Debug)]
pub struct Global {
    pub name: String,
    pub kind: GlobalKind,
    pub span: Span,
    /// Known scheme. Unannotated bindings get theirs after inference.
    pub scheme: Option<Scheme>,
    pub exported: bool,
}

#[derive(Clone, Debug)]
pub struct BindingInfo {
    pub name: String,
    pub module: String,
    pub span: Span,
    pub rec: bool,
    pub body: Expr,
    pub annotated: bool,
    /// Variables of the body's types corresponding to the scheme's
    /// quantified variables, in order.
    pub mono_vars: Vec<TV>,
    pub test_name: Option<String>,
}

#[derive(Clone, Debug)]
pub struct ModuleInfo {
    pub name: String,
    pub imports: HashSet<String>,
}

#[derive(Default)]
pub struct Env {
    pub table: TypeTable,
    pub types: HashMap<String, TypeDef>,
    pub ctors: HashMap<String, CtorDef>,
    /// Unqualified constructor aliases (`M::C` -> `M::T.C`); `None` when
    /// ambiguous.
    pub ctor_alias: HashMap<String, Option<String>>,
    pub globals: HashMap<String, Global>,
    pub bindings: Vec<BindingInfo>,
    pub modules: HashMap<String, ModuleInfo>,
    pub errors: Vec<Diagnostic>,
    pub warnings: Vec<Diagnostic>,
}

/// Name-resolution scope: the module a declaration belongs to.
#[derive(Clone, Debug)]
pub struct Scope {
    pub module: String,
}

impl Env {
    fn imports(&self, scope: &Scope) -> Option<&HashSet<String>> {
        self.modules.get(&scope.module).map(|m| &m.imports)
    }

    /// Candidate canonical names for a source name, in priority order.
    fn candidates(&self, scope: &Scope, name: &str) -> Vec<String> {
        let mut c = vec![format!("{}::{}", scope.module, name)];
        // `geo.area` or `mods.geo.area`: the longest imported prefix wins.
        let dots: Vec<usize> = name.match_indices('.').map(|(i, _)| i).collect();
        for &i in dots.iter().rev() {
            let (prefix, rest) = (&name[..i], &name[i + 1..]);
            if self.imports(scope).is_some_and(|m| m.contains(prefix)) {
                c.push(format!("{}::{}", prefix, rest));
            }
        }
        c.push(format!("std::{}", name));
        c
    }

    pub fn resolve_value(&self, scope: &Scope, name: &str) -> Option<String> {
        self.candidates(scope, name)
            .into_iter()
            .find(|c| self.globals.contains_key(c))
    }

    pub fn resolve_type(&self, scope: &Scope, name: &str) -> Option<String> {
        self.candidates(scope, name)
            .into_iter()
            .find(|c| self.types.contains_key(c))
    }

    pub fn resolve_ctor(&self, scope: &Scope, name: &str) -> Result<String, String> {
        for c in self.candidates(scope, name) {
            if self.ctors.contains_key(&c) {
                return Ok(c);
            }
            match self.ctor_alias.get(&c) {
                Some(Some(full)) => return Ok(full.clone()),
                Some(None) => {
                    return Err(format!(
                        "constructor `{}` is ambiguous; qualify it with its type name",
                        name
                    ))
                }
                None => {}
            }
        }
        Err(format!("unknown constructor `{}`", name))
    }

    // ----- type expression conversion ------------------------------------

    /// Whether a name in a type is an (implicitly quantified) type variable.
    fn is_type_var_name(&self, scope: &Scope, n: &str) -> bool {
        let first = n.chars().next().unwrap();
        if first.is_ascii_lowercase() {
            return !n.contains('.');
        }
        let rest_digits = n[1..].chars().all(|c| c.is_ascii_digit());
        rest_digits && self.resolve_type(scope, n).is_none()
    }

    /// Convert a type expression. `vars` maps type variable names to
    /// (rigid) variables; new names are added if `allow_new` is set.
    pub fn conv_type(
        &mut self,
        te: &TypeExpr,
        scope: &Scope,
        vars: &mut Vec<(String, TV)>,
        allow_new: bool,
    ) -> Result<Type, Diagnostic> {
        match &te.kind {
            TypeKind::Name(n, args) => {
                let mut cargs = Vec::new();
                for a in args {
                    cargs.push(self.conv_type(a, scope, vars, allow_new)?);
                }
                if self.is_type_var_name(scope, n) {
                    let v = self.type_var(n, Kind::Star, te.span, vars, allow_new)?;
                    if cargs.is_empty() {
                        return Ok(Type::Var(v));
                    }
                    return Ok(Type::App(Box::new(Type::Var(v)), cargs));
                }
                let Some(canon) = self.resolve_type(scope, n) else {
                    return Err(Diagnostic::error(te.span, format!("unknown type `{}`", n)));
                };
                let def = self.types[&canon].clone();
                if cargs.len() > def.arity || (!cargs.is_empty() && cargs.len() < def.arity) {
                    return Err(Diagnostic::error(
                        te.span,
                        format!(
                            "type `{}` expects {} argument(s), got {}",
                            n,
                            def.arity,
                            cargs.len()
                        ),
                    ));
                }
                if let TypeDefKind::Alias { params, ty } = &def.kind {
                    if cargs.len() != def.arity {
                        return Err(Diagnostic::error(
                            te.span,
                            format!("type alias `{}` must be fully applied", n),
                        ));
                    }
                    let map: HashMap<TV, Type> = params.iter().cloned().zip(cargs).collect();
                    return Ok(TypeTable::subst(ty, &map));
                }
                Ok(Type::Con(canon, cargs))
            }
            TypeKind::Fun(a, b, eff) => {
                let a = self.conv_type(a, scope, vars, allow_new)?;
                let b = self.conv_type(b, scope, vars, allow_new)?;
                let row = match eff {
                    None => Row::empty(),
                    Some(e) => self.conv_effects(e, scope, vars, allow_new)?,
                };
                Ok(Type::fun(a, b, row))
            }
            TypeKind::Unit => Ok(Type::unit()),
            TypeKind::Tuple(items) => {
                let mut ts = Vec::new();
                for i in items {
                    ts.push(self.conv_type(i, scope, vars, allow_new)?);
                }
                Ok(Type::tuple(ts))
            }
            TypeKind::Record(fields, tail) => {
                let mut fs = Vec::new();
                for (n, t) in fields {
                    fs.push((n.clone(), self.conv_type(t, scope, vars, allow_new)?));
                }
                let tail = match tail {
                    Some(t) => Some(self.type_var(t, Kind::Row, te.span, vars, allow_new)?),
                    None => None,
                };
                let mut row = Row { fields: fs, tail };
                row.sort();
                Ok(Type::Record(row))
            }
            TypeKind::Nat(n) => Ok(Type::Nat(*n)),
        }
    }

    pub fn conv_effects(
        &mut self,
        e: &EffExpr,
        scope: &Scope,
        vars: &mut Vec<(String, TV)>,
        allow_new: bool,
    ) -> Result<Row, Diagnostic> {
        let mut fields = Vec::new();
        for (label, args) in &e.labels {
            if !EFFECTS.contains(&label.as_str()) {
                return Err(
                    Diagnostic::error(e.span, format!("unknown effect `{}`", label))
                        .with_note(format!("known effects: {}", EFFECTS.join(", "))),
                );
            }
            let t = match args.len() {
                0 => Type::unit(),
                1 => self.conv_type(&args[0], scope, vars, allow_new)?,
                _ => {
                    let mut ts = Vec::new();
                    for a in args {
                        ts.push(self.conv_type(a, scope, vars, allow_new)?);
                    }
                    Type::tuple(ts)
                }
            };
            if fields.iter().any(|(l, _): &(String, Type)| l == label) {
                return Err(Diagnostic::error(
                    e.span,
                    format!("effect `{}` listed twice", label),
                ));
            }
            fields.push((label.clone(), t));
        }
        let tail = match &e.tail {
            Some(t) => Some(self.type_var(t, Kind::Eff, e.span, vars, allow_new)?),
            None => None,
        };
        let mut row = Row { fields, tail };
        row.sort();
        Ok(row)
    }

    fn type_var(
        &mut self,
        name: &str,
        kind: Kind,
        span: Span,
        vars: &mut Vec<(String, TV)>,
        allow_new: bool,
    ) -> Result<TV, Diagnostic> {
        if let Some((_, v)) = vars.iter().find(|(n, _)| n == name) {
            let k = self.table.vars[*v as usize].kind;
            if k != kind {
                return Err(Diagnostic::error(
                    span,
                    format!("type variable `{}` is used with different kinds", name),
                ));
            }
            return Ok(*v);
        }
        if !allow_new {
            return Err(Diagnostic::error(
                span,
                format!("unknown type variable `{}`", name),
            ));
        }
        let v = self.table.fresh_rigid(kind, 0, name);
        vars.push((name.to_string(), v));
        Ok(v)
    }

    // ----- declaration collection ----------------------------------------

    /// Register all declarations of all modules. `modules` holds
    /// `(module name, imports, decls)`.
    pub fn collect(&mut self, modules: Vec<(String, HashSet<String>, Vec<Decl>)>) {
        for (name, imports, _) in &modules {
            self.modules.insert(
                name.clone(),
                ModuleInfo {
                    name: name.clone(),
                    imports: imports.clone(),
                },
            );
        }
        // Phase 1: type names.
        for (m, _, decls) in &modules {
            for d in decls {
                if let Decl::Type(td) = d {
                    let canon = format!("{}::{}", m, td.name);
                    if self.types.contains_key(&canon) {
                        self.errors.push(Diagnostic::error(
                            td.span,
                            format!("type `{}` is defined twice", td.name),
                        ));
                        continue;
                    }
                    self.types.insert(
                        canon.clone(),
                        TypeDef {
                            name: canon,
                            span: td.span,
                            arity: td.params.len(),
                            kind: TypeDefKind::Opaque,
                            resource: td.resource,
                            params: vec![],
                            param_kinds: decl_param_kinds(td),
                        },
                    );
                }
            }
        }
        // Phase 2: type bodies. Aliases first so other bodies can use them.
        for pass in 0..2 {
            for (m, _, decls) in &modules {
                let scope = Scope { module: m.clone() };
                for d in decls {
                    if let Decl::Type(td) = d {
                        let is_alias = matches!(td.body, TypeBody::Alias(_));
                        if (pass == 0) == is_alias {
                            if let Err(e) = self.type_body(td, &scope) {
                                self.errors.push(e);
                            }
                        }
                    }
                }
            }
        }
        // Phase 3: signatures, bindings, foreign functions, tests.
        for (m, _, decls) in &modules {
            let scope = Scope { module: m.clone() };
            let mut sigs: HashMap<String, (Sig, bool)> = HashMap::new();
            let mut exports: Vec<(String, Span)> = Vec::new();
            for d in decls {
                match d {
                    Decl::Sig { sig, export } => {
                        if sigs.contains_key(&sig.name) {
                            self.errors.push(Diagnostic::error(
                                sig.span,
                                format!("duplicate signature for `{}`", sig.name),
                            ));
                        }
                        sigs.insert(sig.name.clone(), (sig.clone(), *export));
                    }
                    Decl::Export { name, span } => exports.push((name.clone(), *span)),
                    _ => {}
                }
            }
            let mut test_count = 0;
            for d in decls {
                match d {
                    Decl::Bind(b) => {
                        let canon = format!("{}::{}", m, b.name);
                        if self.globals.contains_key(&canon) {
                            self.errors.push(Diagnostic::error(
                                b.span,
                                format!("`{}` is defined twice", b.name),
                            ));
                            continue;
                        }
                        let (scheme, exported) = match sigs.remove(&b.name) {
                            Some((sig, exp)) => match self.sig_scheme(&sig, &scope) {
                                Ok(s) => (Some(s), exp),
                                Err(e) => {
                                    self.errors.push(e);
                                    (None, exp)
                                }
                            },
                            None => (None, false),
                        };
                        let annotated = scheme.is_some();
                        let idx = self.bindings.len();
                        self.bindings.push(BindingInfo {
                            name: canon.clone(),
                            module: m.clone(),
                            span: b.span,
                            rec: b.rec,
                            body: b.body.clone(),
                            annotated,
                            mono_vars: scheme.as_ref().map(|s| s.vars.clone()).unwrap_or_default(),
                            test_name: None,
                        });
                        self.globals.insert(
                            canon.clone(),
                            Global {
                                name: canon,
                                kind: GlobalKind::Binding(idx),
                                span: b.span,
                                scheme,
                                exported,
                            },
                        );
                    }
                    Decl::Foreign {
                        span,
                        abi,
                        name,
                        symbol,
                        ty,
                    } => {
                        let canon = format!("{}::{}", m, name);
                        let mut vars = Vec::new();
                        if let Err(e) = self.kind_check(ty, &scope, 0, &mut HashMap::new()) {
                            self.errors.push(e);
                            continue;
                        }
                        match self.conv_type(ty, &scope, &mut vars, true) {
                            Ok(t) => {
                                let scheme = Scheme {
                                    vars: vars.iter().map(|(_, v)| *v).collect(),
                                    preds: vec![],
                                    ty: t,
                                };
                                if self.globals.contains_key(&canon) {
                                    self.errors.push(Diagnostic::error(
                                        *span,
                                        format!("`{}` is defined twice", name),
                                    ));
                                }
                                self.globals.insert(
                                    canon.clone(),
                                    Global {
                                        name: canon,
                                        kind: GlobalKind::Foreign {
                                            abi: abi.clone(),
                                            symbol: symbol.clone(),
                                        },
                                        span: *span,
                                        scheme: Some(scheme),
                                        exported: false,
                                    },
                                );
                            }
                            Err(e) => self.errors.push(e),
                        }
                    }
                    Decl::Test { span, name, body } => {
                        test_count += 1;
                        let canon = format!("{}::test#{}", m, test_count);
                        let idx = self.bindings.len();
                        let bool_ty = Type::con("std::Bool");
                        self.bindings.push(BindingInfo {
                            name: canon.clone(),
                            module: m.clone(),
                            span: *span,
                            rec: false,
                            body: body.clone(),
                            annotated: true,
                            mono_vars: vec![],
                            test_name: Some(name.clone()),
                        });
                        self.globals.insert(
                            canon.clone(),
                            Global {
                                name: canon,
                                kind: GlobalKind::Binding(idx),
                                span: *span,
                                scheme: Some(Scheme::mono(bool_ty)),
                                exported: false,
                            },
                        );
                    }
                    _ => {}
                }
            }
            for (name, (sig, _)) in sigs {
                // Trait methods are declared inside traits, not as top-level
                // signatures, so a leftover signature is an error.
                self.errors.push(Diagnostic::error(
                    sig.span,
                    format!("signature for `{}` has no binding", name),
                ));
            }
            for (name, span) in exports {
                let canon = format!("{}::{}", m, name);
                match self.globals.get_mut(&canon) {
                    Some(g) => g.exported = true,
                    None => self.errors.push(Diagnostic::error(
                        span,
                        format!("cannot export unknown binding `{}`", name),
                    )),
                }
            }
        }
    }

    /// Check that a type expression is well-kinded: `expected` is the
    /// number of further type arguments the position allows (0 for an
    /// ordinary type). Type variable kinds are inferred from use.
    pub fn kind_check(
        &self,
        te: &TypeExpr,
        scope: &Scope,
        expected: usize,
        var_kinds: &mut HashMap<String, usize>,
    ) -> Result<(), Diagnostic> {
        match &te.kind {
            TypeKind::Name(n, args) => {
                if self.is_type_var_name(scope, n) {
                    let k = args.len() + expected;
                    match var_kinds.get(n) {
                        Some(&k0) if k0 != k => {
                            return Err(Diagnostic::error(
                                te.span,
                                format!(
                                    "type variable `{}` is used with inconsistent numbers of type arguments",
                                    n
                                ),
                            ))
                        }
                        _ => {
                            var_kinds.insert(n.clone(), k);
                        }
                    }
                    for a in args {
                        self.kind_check(a, scope, 0, var_kinds)?;
                    }
                    return Ok(());
                }
                let Some(canon) = self.resolve_type(scope, n) else {
                    return Ok(()); // reported during conversion
                };
                let def = &self.types[&canon];
                if args.len() + expected != def.arity {
                    let msg = if expected == 0 {
                        format!(
                            "type `{}` expects {} argument(s), got {}",
                            n,
                            def.arity,
                            args.len()
                        )
                    } else {
                        format!(
                            "type `{}` cannot be used here: a type constructor taking {} argument(s) is expected",
                            n, expected
                        )
                    };
                    return Err(Diagnostic::error(te.span, msg));
                }
                for (i, a) in args.iter().enumerate() {
                    let k = def.param_kinds.get(i).copied().unwrap_or(0);
                    self.kind_check(a, scope, k, var_kinds)?;
                }
                Ok(())
            }
            _ => {
                if expected != 0 {
                    return Err(Diagnostic::error(
                        te.span,
                        format!(
                            "a type constructor taking {} argument(s) is expected here",
                            expected
                        ),
                    ));
                }
                match &te.kind {
                    TypeKind::Fun(a, b, eff) => {
                        self.kind_check(a, scope, 0, var_kinds)?;
                        self.kind_check(b, scope, 0, var_kinds)?;
                        if let Some(e) = eff {
                            for (_, args) in &e.labels {
                                for a in args {
                                    self.kind_check(a, scope, 0, var_kinds)?;
                                }
                            }
                        }
                        Ok(())
                    }
                    TypeKind::Tuple(ts) => ts
                        .iter()
                        .try_for_each(|t| self.kind_check(t, scope, 0, var_kinds)),
                    TypeKind::Record(fs, _) => fs
                        .iter()
                        .try_for_each(|(_, t)| self.kind_check(t, scope, 0, var_kinds)),
                    _ => Ok(()),
                }
            }
        }
    }

    pub fn sig_scheme(&mut self, sig: &Sig, scope: &Scope) -> Result<Scheme, Diagnostic> {
        self.kind_check(&sig.ty, scope, 0, &mut HashMap::new())?;
        let mut vars = Vec::new();
        let ty = self.conv_type(&sig.ty, scope, &mut vars, true)?;
        let mut preds = Vec::new();
        for c in &sig.constraints {
            let mut args = Vec::new();
            for a in &c.args {
                args.push(self.conv_type(a, scope, &mut vars, false)?);
            }
            preds.push(Pred {
                trait_name: c.trait_name.clone(),
                args,
            });
        }
        Ok(Scheme {
            vars: vars.iter().map(|(_, v)| *v).collect(),
            preds,
            ty,
        })
    }

    fn type_body(&mut self, td: &TypeDecl, scope: &Scope) -> Result<(), Diagnostic> {
        let canon = format!("{}::{}", scope.module, td.name);
        let mut vars: Vec<(String, TV)> = Vec::new();
        for p in &td.params {
            if vars.iter().any(|(n, _)| n == p) {
                return Err(Diagnostic::error(
                    td.span,
                    format!("duplicate type parameter `{}`", p),
                ));
            }
            let v = self.table.fresh_rigid(Kind::Star, 0, p);
            vars.push((p.clone(), v));
        }
        let params: Vec<TV> = vars.iter().map(|(_, v)| *v).collect();
        let result = Type::Con(
            canon.clone(),
            params.iter().map(|v| Type::Var(*v)).collect(),
        );
        {
            let mut vk: HashMap<String, usize> = HashMap::new();
            for (p, k) in td.params.iter().zip(&self.types[&canon].param_kinds) {
                vk.insert(p.clone(), *k);
            }
            let check =
                |t: &TypeExpr, vk: &mut HashMap<String, usize>| self.kind_check(t, scope, 0, vk);
            match &td.body {
                TypeBody::Alias(t) => check(t, &mut vk)?,
                TypeBody::Record(fs) => {
                    for (_, t) in fs {
                        check(t, &mut vk)?;
                    }
                }
                TypeBody::Variants(vs) => {
                    for v in vs {
                        for t in &v.fields {
                            check(t, &mut vk)?;
                        }
                    }
                }
                TypeBody::Opaque => {}
            }
        }
        let kind = match &td.body {
            TypeBody::Opaque => TypeDefKind::Opaque,
            TypeBody::Alias(t) => {
                let ty = self.conv_type(t, scope, &mut vars, false)?;
                TypeDefKind::Alias {
                    params: params.clone(),
                    ty,
                }
            }
            TypeBody::Record(fields) => {
                let mut fs = Vec::new();
                for (n, t) in fields {
                    if fs.iter().any(|(m, _): &(String, Type)| m == n) {
                        return Err(Diagnostic::error(
                            t.span,
                            format!("duplicate field `{}`", n),
                        ));
                    }
                    fs.push((n.clone(), self.conv_type(t, scope, &mut vars, false)?));
                }
                let names = fs.iter().map(|(n, _)| n.clone()).collect();
                self.table.records.insert(
                    canon.clone(),
                    RecordTemplate {
                        params: params.clone(),
                        fields: fs,
                    },
                );
                TypeDefKind::Record { fields: names }
            }
            TypeBody::Variants(vs) => {
                let mut names = Vec::new();
                for (tag, v) in vs.iter().enumerate() {
                    let mut fields = Vec::new();
                    for f in &v.fields {
                        fields.push(self.conv_type(f, scope, &mut vars, false)?);
                    }
                    let mut ty = result.clone();
                    for f in fields.iter().rev() {
                        ty = Type::fun(f.clone(), ty, Row::empty());
                    }
                    let full = format!("{}::{}.{}", scope.module, td.name, v.name);
                    if names.contains(&full) {
                        return Err(Diagnostic::error(
                            v.span,
                            format!("duplicate constructor `{}`", v.name),
                        ));
                    }
                    let short = format!("{}::{}", scope.module, v.name);
                    match self.ctor_alias.get(&short) {
                        Some(_) => {
                            self.ctor_alias.insert(short, None);
                        }
                        None => {
                            self.ctor_alias.insert(short, Some(full.clone()));
                        }
                    }
                    self.ctors.insert(
                        full.clone(),
                        CtorDef {
                            name: full.clone(),
                            type_name: canon.clone(),
                            tag,
                            fields,
                            scheme: Scheme {
                                vars: params.clone(),
                                preds: vec![],
                                ty,
                            },
                        },
                    );
                    names.push(full);
                }
                TypeDefKind::Adt { ctors: names }
            }
        };
        let def = self.types.get_mut(&canon).unwrap();
        def.kind = kind;
        def.params = params;
        Ok(())
    }

    /// Short display name for a canonical value name.
    pub fn show_name(&self, canon: &str) -> String {
        display_name(canon)
    }
}

fn decl_param_kinds(td: &TypeDecl) -> Vec<usize> {
    let mut kinds: HashMap<String, usize> = HashMap::new();
    match &td.body {
        TypeBody::Alias(t) => collect_var_kinds(t, &mut kinds),
        TypeBody::Record(fs) => fs
            .iter()
            .for_each(|(_, t)| collect_var_kinds(t, &mut kinds)),
        TypeBody::Variants(vs) => vs.iter().for_each(|v| {
            v.fields
                .iter()
                .for_each(|t| collect_var_kinds(t, &mut kinds))
        }),
        TypeBody::Opaque => {}
    }
    td.params
        .iter()
        .map(|p| kinds.get(p).copied().unwrap_or(0))
        .collect()
}

/// Record how many arguments each type variable name is applied to.
fn collect_var_kinds(t: &TypeExpr, out: &mut HashMap<String, usize>) {
    match &t.kind {
        TypeKind::Name(n, args) => {
            if !args.is_empty() {
                let e = out.entry(n.clone()).or_insert(0);
                *e = (*e).max(args.len());
            }
            args.iter().for_each(|a| collect_var_kinds(a, out));
        }
        TypeKind::Fun(a, b, _) => {
            collect_var_kinds(a, out);
            collect_var_kinds(b, out);
        }
        TypeKind::Tuple(ts) => ts.iter().for_each(|x| collect_var_kinds(x, out)),
        TypeKind::Record(fs, _) => fs.iter().for_each(|(_, x)| collect_var_kinds(x, out)),
        _ => {}
    }
}
