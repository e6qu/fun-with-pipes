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
    /// `repr(C)` record.
    pub repr_c: bool,
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
    Foreign {
        abi: String,
        symbol: String,
        variadic: Option<u32>,
    },
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

/// Classes solved by the compiler from the structure of types, or by
/// membership in a fixed set of primitive types.
pub const BUILTIN_CLASSES: &[&str] = &[
    "Eq", "Ord", "Hash", "Display", "Dup", "Encode", "Decode", "IntLit", "FloatLit", "Integer",
    "Signed", "Float", "Numeric",
];

#[derive(Clone, Debug)]
pub struct TraitDef {
    pub name: String,
    pub span: Span,
    pub params: Vec<TV>,
    pub param_kinds: Vec<usize>,
    /// Superclass predicates over `params`.
    pub supers: Vec<Pred>,
    /// Canonical method names.
    pub methods: Vec<String>,
    /// Default method bodies.
    pub defaults: HashMap<String, Expr>,
    pub module: String,
}

#[derive(Clone, Debug)]
pub struct ImplDef {
    pub trait_name: String,
    pub span: Span,
    /// Variables of the impl head (rigid templates).
    pub vars: Vec<TV>,
    pub head: Vec<Type>,
    pub context: Vec<Pred>,
    /// Method canonical name -> binding index.
    pub methods: HashMap<String, usize>,
    pub module: String,
}

#[derive(Default)]
pub struct Env {
    pub traits: HashMap<String, TraitDef>,
    pub impls: Vec<ImplDef>,
    /// Next fresh AST node id (for copies of default method bodies).
    pub next_node_id: NodeId,
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
        // `::module::name` is an absolute (hygienic) reference
        if let Some(abs) = name.strip_prefix("::") {
            return self.globals.contains_key(abs).then(|| abs.to_string());
        }
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
        if let Some(abs) = name.strip_prefix("::") {
            if self.ctors.contains_key(abs) {
                return Ok(abs.to_string());
            }
            return Err(format!("unknown constructor `{}`", abs));
        }
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
                if canon == "std::TInt" {
                    if let Some(Type::Nat(w)) = cargs.first() {
                        if *w > crate::value::TINT_MAX_WIDTH {
                            return Err(Diagnostic::error(
                                te.span,
                                crate::value::tint_width_error(*w),
                            ));
                        }
                    }
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
                            repr_c: td.repr_c,
                            params: vec![],
                            param_kinds: decl_param_kinds(td),
                        },
                    );
                }
            }
        }
        // Phase 2: type bodies. Aliases first, each after the aliases it
        // mentions, so other bodies can use them; alias cycles are errors.
        let mut aliases: Vec<(String, &TypeDecl)> = Vec::new();
        for (m, _, decls) in &modules {
            for d in decls {
                if let Decl::Type(td) = d {
                    if matches!(td.body, TypeBody::Alias(_)) {
                        aliases.push((m.clone(), td));
                    }
                }
            }
        }
        let index: HashMap<String, usize> = aliases
            .iter()
            .enumerate()
            .map(|(i, (m, td))| (format!("{}::{}", m, td.name), i))
            .collect();
        let deps: Vec<Vec<usize>> = aliases
            .iter()
            .map(|(m, td)| {
                let scope = Scope { module: m.clone() };
                let mut names = Vec::new();
                if let TypeBody::Alias(t) = &td.body {
                    type_names(t, &mut names);
                }
                names
                    .iter()
                    .filter_map(|n| self.resolve_type(&scope, n))
                    .filter_map(|c| index.get(&c).copied())
                    .collect()
            })
            .collect();
        // 0 = unvisited, 1 = in progress, 2 = done
        let mut state = vec![0u8; aliases.len()];
        let mut order = Vec::new();
        fn visit(
            i: usize,
            deps: &[Vec<usize>],
            state: &mut [u8],
            order: &mut Vec<usize>,
            cyclic: &mut Vec<usize>,
        ) {
            match state[i] {
                2 => return,
                1 => {
                    cyclic.push(i);
                    return;
                }
                _ => {}
            }
            state[i] = 1;
            for &d in &deps[i] {
                visit(d, deps, state, order, cyclic);
            }
            state[i] = 2;
            order.push(i);
        }
        let mut cyclic = Vec::new();
        for i in 0..aliases.len() {
            visit(i, &deps, &mut state, &mut order, &mut cyclic);
        }
        cyclic.sort();
        cyclic.dedup();
        for &i in &cyclic {
            let td = aliases[i].1;
            self.errors.push(Diagnostic::error(
                td.span,
                format!(
                    "type alias `{}` refers to itself; use a `type` with constructors for recursive types",
                    td.name
                ),
            ));
        }
        for i in order {
            if cyclic.contains(&i) {
                continue;
            }
            let (m, td) = &aliases[i];
            let scope = Scope { module: m.clone() };
            if let Err(e) = self.type_body(td, &scope) {
                self.errors.push(e);
            }
        }
        for (m, _, decls) in &modules {
            let scope = Scope { module: m.clone() };
            for d in decls {
                if let Decl::Type(td) = d {
                    if !matches!(td.body, TypeBody::Alias(_)) {
                        if let Err(e) = self.type_body(td, &scope) {
                            self.errors.push(e);
                        }
                    }
                }
            }
        }
        // Phase 2b: traits.
        for (m, _, decls) in &modules {
            let scope = Scope { module: m.clone() };
            for d in decls {
                if let Decl::Trait(td) = d {
                    if let Err(e) = self.trait_decl(td, &scope) {
                        self.errors.push(e);
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
                        variadic,
                        ty,
                        constraints,
                    } => {
                        let canon = format!("{}::{}", m, name);
                        match self.scheme_of(ty, constraints, &scope, &[]) {
                            Ok(scheme) => {
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
                                            variadic: *variadic,
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
            for d in decls {
                if let Decl::Impl(id) = d {
                    if let Err(e) = self.impl_decl(id, &scope) {
                        self.errors.push(e);
                    }
                }
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
        self.scheme_of(&sig.ty, &sig.constraints, scope, &[])
    }

    /// Convert a signature to a scheme. `preset` gives already-bound type
    /// variables (trait parameters), which come first in the scheme.
    pub fn scheme_of(
        &mut self,
        ty: &TypeExpr,
        constraints: &[Constraint],
        scope: &Scope,
        preset: &[(String, TV, usize)],
    ) -> Result<Scheme, Diagnostic> {
        let mut kinds: HashMap<String, usize> =
            preset.iter().map(|(n, _, k)| (n.clone(), *k)).collect();
        self.kind_check(ty, scope, 0, &mut kinds)?;
        let mut vars: Vec<(String, TV)> = preset.iter().map(|(n, v, _)| (n.clone(), *v)).collect();
        let t = self.conv_type(ty, scope, &mut vars, true)?;
        let mut preds = Vec::new();
        for c in constraints {
            preds.push(self.conv_constraint(c, scope, &mut vars, &mut kinds)?);
        }
        Ok(Scheme {
            vars: vars.iter().map(|(_, v)| *v).collect(),
            preds,
            ty: t,
        })
    }

    pub fn resolve_trait(&self, scope: &Scope, name: &str) -> Option<String> {
        if let Some(c) = self
            .candidates(scope, name)
            .into_iter()
            .find(|c| self.traits.contains_key(c))
        {
            return Some(c);
        }
        if BUILTIN_CLASSES.contains(&name) {
            return Some(format!("std::{}", name));
        }
        None
    }

    /// Parameter kinds of a trait (builtin classes take ordinary types).
    pub fn trait_param_kinds(&self, canon: &str) -> Vec<usize> {
        match self.traits.get(canon) {
            Some(t) => t.param_kinds.clone(),
            None => vec![0],
        }
    }

    fn conv_constraint(
        &mut self,
        c: &Constraint,
        scope: &Scope,
        vars: &mut Vec<(String, TV)>,
        kinds: &mut HashMap<String, usize>,
    ) -> Result<Pred, Diagnostic> {
        let Some(tc) = self.resolve_trait(scope, &c.trait_name) else {
            return Err(Diagnostic::error(
                c.span,
                format!("unknown trait `{}`", c.trait_name),
            ));
        };
        let pk = self.trait_param_kinds(&tc);
        if pk.len() != c.args.len() {
            return Err(Diagnostic::error(
                c.span,
                format!(
                    "trait `{}` takes {} type argument(s), got {}",
                    c.trait_name,
                    pk.len(),
                    c.args.len()
                ),
            ));
        }
        let mut args = Vec::new();
        for (a, k) in c.args.iter().zip(pk) {
            self.kind_check(a, scope, k, kinds)?;
            args.push(self.conv_type(a, scope, vars, true)?);
        }
        Ok(Pred {
            trait_name: tc,
            args,
        })
    }

    /// Register a trait: its parameters, superclasses and methods.
    fn trait_decl(&mut self, td: &TraitDecl, scope: &Scope) -> Result<(), Diagnostic> {
        let canon = format!("{}::{}", scope.module, td.name);
        // Parameter kinds from method signatures.
        let mut kinds: HashMap<String, usize> = HashMap::new();
        for m in &td.methods {
            collect_var_kinds(&m.ty, &mut kinds);
        }
        let mut preset = Vec::new();
        for p in &td.params {
            let v = self.table.fresh_rigid(Kind::Star, 0, p);
            preset.push((p.clone(), v, kinds.get(p).copied().unwrap_or(0)));
        }
        let params: Vec<TV> = preset.iter().map(|(_, v, _)| *v).collect();
        let param_kinds: Vec<usize> = preset.iter().map(|(_, _, k)| *k).collect();
        // Insert early so methods/supers may refer to the trait itself.
        self.traits.insert(
            canon.clone(),
            TraitDef {
                name: canon.clone(),
                span: td.span,
                params: params.clone(),
                param_kinds: param_kinds.clone(),
                supers: vec![],
                methods: vec![],
                defaults: HashMap::new(),
                module: scope.module.clone(),
            },
        );
        let mut supers = Vec::new();
        let mut vars: Vec<(String, TV)> = preset.iter().map(|(n, v, _)| (n.clone(), *v)).collect();
        let mut vk: HashMap<String, usize> =
            preset.iter().map(|(n, _, k)| (n.clone(), *k)).collect();
        for c in &td.supers {
            supers.push(self.conv_constraint(c, scope, &mut vars, &mut vk)?);
        }
        let self_pred = Pred {
            trait_name: canon.clone(),
            args: params.iter().map(|v| Type::Var(*v)).collect(),
        };
        let mut methods = Vec::new();
        for m in &td.methods {
            let mut scheme = self.scheme_of(&m.ty, &m.constraints, scope, &preset)?;
            scheme.preds.insert(0, self_pred.clone());
            let mcanon = format!("{}::{}", scope.module, m.name);
            if self.globals.contains_key(&mcanon) {
                return Err(Diagnostic::error(
                    m.span,
                    format!("`{}` is defined twice", m.name),
                ));
            }
            self.globals.insert(
                mcanon.clone(),
                Global {
                    name: mcanon.clone(),
                    kind: GlobalKind::Method {
                        trait_name: canon.clone(),
                    },
                    span: m.span,
                    scheme: Some(scheme),
                    exported: false,
                },
            );
            methods.push(mcanon);
        }
        let mut defaults = HashMap::new();
        for d in &td.defaults {
            let mcanon = format!("{}::{}", scope.module, d.name);
            if !methods.contains(&mcanon) {
                return Err(Diagnostic::error(
                    d.span,
                    format!("`{}` is not a method of trait `{}`", d.name, td.name),
                ));
            }
            defaults.insert(mcanon, d.body.clone());
        }
        let t = self.traits.get_mut(&canon).unwrap();
        t.supers = supers;
        t.methods = methods;
        t.defaults = defaults;
        Ok(())
    }

    /// Register an impl and create bindings for its methods.
    fn impl_decl(&mut self, id: &ImplDecl, scope: &Scope) -> Result<(), Diagnostic> {
        let Some(tc) = self.resolve_trait(scope, &id.trait_name) else {
            return Err(Diagnostic::error(
                id.span,
                format!("unknown trait `{}`", id.trait_name),
            ));
        };
        let Some(tdef) = self.traits.get(&tc).cloned() else {
            return Err(Diagnostic::error(
                id.span,
                format!(
                    "`{}` is derived automatically from the structure of types and cannot be implemented",
                    id.trait_name
                ),
            ));
        };
        if tdef.params.len() != id.args.len() {
            return Err(Diagnostic::error(
                id.span,
                format!(
                    "trait `{}` takes {} type argument(s), got {}",
                    id.trait_name,
                    tdef.params.len(),
                    id.args.len()
                ),
            ));
        }
        let mut vars: Vec<(String, TV)> = Vec::new();
        let mut kinds: HashMap<String, usize> = HashMap::new();
        let mut head = Vec::new();
        for (a, k) in id.args.iter().zip(&tdef.param_kinds) {
            self.kind_check(a, scope, *k, &mut kinds)?;
            head.push(self.conv_type(a, scope, &mut vars, true)?);
        }
        let mut context = Vec::new();
        for c in &id.constraints {
            context.push(self.conv_constraint(c, scope, &mut vars, &mut kinds)?);
        }
        let impl_vars: Vec<TV> = vars.iter().map(|(_, v)| *v).collect();
        let mut methods = HashMap::new();
        let mut given_names = HashSet::new();
        for b in &id.bindings {
            let mcanon = format!("{}::{}", tdef.module, b.name);
            if !tdef.methods.contains(&mcanon) {
                return Err(Diagnostic::error(
                    b.span,
                    format!("`{}` is not a method of trait `{}`", b.name, id.trait_name),
                ));
            }
            if !given_names.insert(mcanon.clone()) {
                return Err(Diagnostic::error(
                    b.span,
                    format!("method `{}` is defined twice", b.name),
                ));
            }
        }
        let head_pred = Pred {
            trait_name: tc.clone(),
            args: head.clone(),
        };
        for mcanon in &tdef.methods {
            let (body, rec, span, module) = match id
                .bindings
                .iter()
                .find(|b| format!("{}::{}", tdef.module, b.name) == *mcanon)
            {
                Some(b) => (b.body.clone(), b.rec, b.span, scope.module.clone()),
                None => match tdef.defaults.get(mcanon) {
                    Some(e) => (
                        renumber(e, &mut self.next_node_id),
                        true,
                        id.span,
                        tdef.module.clone(),
                    ),
                    None => {
                        return Err(Diagnostic::error(
                            id.span,
                            format!(
                                "impl of `{}` is missing method `{}`",
                                id.trait_name,
                                display_name(mcanon)
                            ),
                        ))
                    }
                },
            };
            // Method scheme instantiated at the impl head; the method's own
            // variables get fresh rigid copies.
            let ms = self.globals[mcanon].scheme.clone().unwrap();
            let mut map: HashMap<TV, Type> = HashMap::new();
            for (p, h) in tdef.params.iter().zip(&head) {
                map.insert(*p, h.clone());
            }
            let mut own = Vec::new();
            for v in ms.vars.iter().skip(tdef.params.len()) {
                let info = self.table.vars[*v as usize].clone();
                let nv = self
                    .table
                    .fresh_rigid(info.kind, 0, info.rigid.as_deref().unwrap_or("t"));
                map.insert(*v, Type::Var(nv));
                own.push(nv);
            }
            let ty = TypeTable::subst(&ms.ty, &map);
            let mut preds: Vec<Pred> = ms
                .preds
                .iter()
                .skip(1)
                .map(|p| Pred {
                    trait_name: p.trait_name.clone(),
                    args: p.args.iter().map(|a| TypeTable::subst(a, &map)).collect(),
                })
                .collect();
            preds.extend(context.iter().cloned());
            preds.push(head_pred.clone());
            let mut all_vars = impl_vars.clone();
            all_vars.extend(own);
            let short = mcanon.rsplit("::").next().unwrap();
            let head_src: Vec<String> = id.args.iter().map(crate::pretty::ty).collect();
            let bname = format!(
                "{}::{}[{}].{}",
                scope.module,
                id.trait_name,
                head_src.join(", "),
                short
            );
            let idx = self.bindings.len();
            self.bindings.push(BindingInfo {
                name: bname.clone(),
                module,
                span,
                rec,
                body,
                annotated: true,
                mono_vars: all_vars.clone(),
                test_name: None,
            });
            self.globals.insert(
                bname.clone(),
                Global {
                    name: bname,
                    kind: GlobalKind::Binding(idx),
                    span,
                    scheme: Some(Scheme {
                        vars: all_vars,
                        preds,
                        ty,
                    }),
                    exported: false,
                },
            );
            methods.insert(mcanon.clone(), idx);
        }
        // Overlap check against earlier impls of the same trait.
        for other in &self.impls {
            if other.trait_name == tc && heads_overlap(&self.table, &other.head, &head) {
                return Err(Diagnostic::error(
                    id.span,
                    format!("overlapping impls of `{}`", id.trait_name),
                )
                .with_note("an earlier impl already covers some of the same types"));
            }
        }
        self.impls.push(ImplDef {
            trait_name: tc,
            span: id.span,
            vars: impl_vars,
            head,
            context,
            methods,
            module: scope.module.clone(),
        });
        Ok(())
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

/// Copy an expression with fresh node ids.
pub fn renumber(e: &Expr, next: &mut NodeId) -> Expr {
    let mut e = e.clone();
    fn go(e: &mut Expr, next: &mut NodeId) {
        e.id = *next;
        *next += 1;
        match &mut e.kind {
            ExprKind::App(f, args) => {
                go(f, next);
                args.iter_mut().for_each(|a| go(a, next));
            }
            ExprKind::Pipe(a, b) => {
                go(a, next);
                go(b, next);
            }
            ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
                xs.iter_mut().for_each(|a| go(a, next))
            }
            ExprKind::Record(fs)
            | ExprKind::NominalRecord(_, fs)
            | ExprKind::With(fs)
            | ExprKind::Make(_, fs)
            | ExprKind::Update(fs) => fs.iter_mut().for_each(|(_, a)| go(a, next)),
            ExprKind::Match(arms) => arms.iter_mut().for_each(|a| {
                pat(&mut a.pat, next);
                go(&mut a.body, next)
            }),
            ExprKind::Comptime(x) | ExprKind::Quote(x) => go(x, next),
            _ => {}
        }
    }
    fn pat(p: &mut Pattern, next: &mut NodeId) {
        p.id = *next;
        *next += 1;
        match &mut p.kind {
            PatKind::Ctor(_, Some(args)) | PatKind::Tuple(args) => {
                args.iter_mut().for_each(|a| pat(a, next))
            }
            _ => {}
        }
    }
    go(&mut e, next);
    e
}

/// One-way matching of an impl head (whose variables are `pattern vars`)
/// against a target type. Returns false if the target is not yet specific
/// enough or does not match.
pub fn match_type(
    table: &TypeTable,
    pat: &Type,
    target: &Type,
    pvars: &[TV],
    subst: &mut HashMap<TV, Type>,
) -> bool {
    let target = table.resolve(target);
    match pat {
        Type::Var(v) if pvars.contains(v) => match subst.get(v) {
            Some(prev) => types_equal(table, prev, &target),
            None => {
                subst.insert(*v, target);
                true
            }
        },
        Type::Var(v) => matches!(target, Type::Var(w) if *v == w),
        Type::Con(n, args) => match &target {
            Type::Con(m, targs) if n == m && args.len() == targs.len() => args
                .iter()
                .zip(targs)
                .all(|(a, b)| match_type(table, a, b, pvars, subst)),
            _ => false,
        },
        Type::App(h, args) => match &target {
            Type::Con(m, targs) if targs.len() >= args.len() => {
                let k = targs.len() - args.len();
                match_type(
                    table,
                    h,
                    &Type::Con(m.clone(), targs[..k].to_vec()),
                    pvars,
                    subst,
                ) && args
                    .iter()
                    .zip(&targs[k..])
                    .all(|(a, b)| match_type(table, a, b, pvars, subst))
            }
            Type::App(th, targs) if targs.len() == args.len() => {
                match_type(table, h, th, pvars, subst)
                    && args
                        .iter()
                        .zip(targs)
                        .all(|(a, b)| match_type(table, a, b, pvars, subst))
            }
            _ => false,
        },
        Type::Fun(a, b, _) => match &target {
            Type::Fun(ta, tb, _) => {
                match_type(table, a, ta, pvars, subst) && match_type(table, b, tb, pvars, subst)
            }
            _ => false,
        },
        Type::Record(r) => match &target {
            Type::Record(tr) => {
                let tr = table.flatten_row(tr);
                r.tail.is_none()
                    && tr.tail.is_none()
                    && r.fields.len() == tr.fields.len()
                    && r.fields
                        .iter()
                        .zip(&tr.fields)
                        .all(|((l1, a), (l2, b))| l1 == l2 && match_type(table, a, b, pvars, subst))
            }
            _ => false,
        },
        Type::Nat(n) => matches!(target, Type::Nat(m) if *n == m),
    }
}

pub fn types_equal(table: &TypeTable, a: &Type, b: &Type) -> bool {
    table.zonk(a) == table.zonk(b)
}

/// Whether two impl heads could both apply to some type.
fn heads_overlap(table: &TypeTable, a: &[Type], b: &[Type]) -> bool {
    fn ov(table: &TypeTable, x: &Type, y: &Type) -> bool {
        let x = table.resolve(x);
        let y = table.resolve(y);
        match (&x, &y) {
            (Type::Var(_), _) | (_, Type::Var(_)) => true,
            (Type::Con(n, xs), Type::Con(m, ys)) => {
                n == m && xs.len() == ys.len() && xs.iter().zip(ys).all(|(p, q)| ov(table, p, q))
            }
            (Type::Fun(a1, b1, _), Type::Fun(a2, b2, _)) => ov(table, a1, a2) && ov(table, b1, b2),
            (Type::Record(r1), Type::Record(r2)) => {
                r1.fields.len() == r2.fields.len()
                    && r1
                        .fields
                        .iter()
                        .zip(&r2.fields)
                        .all(|((l1, p), (l2, q))| l1 == l2 && ov(table, p, q))
            }
            (Type::Nat(n), Type::Nat(m)) => n == m,
            (Type::App(..), _) | (_, Type::App(..)) => true,
            _ => false,
        }
    }
    a.iter().zip(b).all(|(x, y)| ov(table, x, y))
}

/// The type names mentioned in a type expression.
fn type_names(t: &TypeExpr, out: &mut Vec<String>) {
    match &t.kind {
        TypeKind::Name(n, args) => {
            out.push(n.clone());
            for a in args {
                type_names(a, out);
            }
        }
        TypeKind::Fun(a, b, eff) => {
            type_names(a, out);
            type_names(b, out);
            if let Some(e) = eff {
                for (_, ts) in &e.labels {
                    for t in ts {
                        type_names(t, out);
                    }
                }
            }
        }
        TypeKind::Tuple(ts) => ts.iter().for_each(|t| type_names(t, out)),
        TypeKind::Record(fs, _) => fs.iter().for_each(|(_, t)| type_names(t, out)),
        TypeKind::Unit | TypeKind::Nat(_) => {}
    }
}
