//! Type inference: Hindley–Milner with levels, rows for records and
//! effects, explicit `rec`, pipe-mode resolution and tacit `match`.

use std::collections::{HashMap, HashSet};

use crate::ast::*;
use crate::diag::{Diagnostic, Span};
use crate::env::*;
use crate::exhaust;
use crate::types::*;

/// How a `|` node is evaluated.
#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum PipeMode {
    /// `x | f` = `f x`
    Apply,
    /// `f | g` = `g . f`
    Compose,
}

/// What a `Var`/`Ctor` node refers to, with the instantiation of the
/// target's scheme.
#[derive(Clone, Debug)]
pub struct Inst {
    pub target: String,
    pub types: Vec<Type>,
}

/// Results of type checking, consumed by later phases.
#[derive(Default)]
pub struct Typed {
    pub node_types: HashMap<NodeId, Type>,
    pub insts: HashMap<NodeId, Inst>,
    pub pipe_modes: HashMap<NodeId, PipeMode>,
    /// Canonical constructor of each constructor pattern.
    pub pattern_ctors: HashMap<NodeId, String>,
    /// The type described by each `type[T]` node.
    pub reflected: HashMap<NodeId, Type>,
}

/// A record operation (`with`, `update`) whose input type is not known yet:
/// a nominal record input keeps its type; anything else becomes a row.
struct FieldReq {
    span: Span,
    input: Type,
    output: Type,
    /// field name, input type, output type
    fields: Vec<(String, Type, Type)>,
}

struct Deferred {
    node: NodeId,
    span: Span,
    lhs: Type,
    rhs: Type,
    result: Type,
    ctx: Row,
}

pub struct Infer<'a> {
    pub env: &'a mut Env,
    pub out: &'a mut Typed,
    pub(crate) level: u32,
    pub(crate) scope: Scope,
    /// Monomorphic types of the unannotated bindings in the current group.
    pub(crate) group: HashMap<String, Type>,
    pub(crate) current: String,
    deferred: Vec<Deferred>,
    field_reqs: Vec<FieldReq>,
    /// Predicates required by the binding being checked.
    pub(crate) wanted: Vec<(Pred, Span)>,
    /// Unsuffixed integer literals, checked against their final type.
    pub(crate) int_lits: Vec<(Span, Type, bool, u128)>,
    /// Effects performed while evaluating each binding's body.
    ctxs: Vec<(String, Row, Span)>,
    /// Effects performed by `comptime` expressions.
    comptimes: Vec<(Row, Span)>,
    /// Applications whose argument is captured if the result is a function.
    captures: Vec<(Span, Type, Type)>,
    /// uses of `vector`/`matrix`, and the ones sized by a literal argument
    size_uses: Vec<(NodeId, Span, &'static str)>,
    sized: HashSet<NodeId>,
    /// Equations between sizes not decided when they were met (`n + 1 =
    /// m` with m unknown), with where and why, checked when the group is
    /// done (`check_sizes`).
    size_eqs: Vec<(Type, Type, Span, String)>,
}

/// Effects permitted at compile time.
pub const COMPTIME_EFFECTS: &[&str] = &["IO", "FileIO", "Alloc", "Error"];

type IResult<T> = Result<T, Diagnostic>;

pub fn check_program(env: &mut Env, out: &mut Typed) {
    check_superclasses(env, out);
    let order = binding_order(env);
    for group in order {
        let mut inf = Infer {
            env,
            out,
            level: 0,
            scope: Scope {
                module: String::new(),
            },
            group: HashMap::new(),
            current: String::new(),
            deferred: Vec::new(),
            field_reqs: Vec::new(),
            wanted: Vec::new(),
            int_lits: Vec::new(),
            ctxs: Vec::new(),
            comptimes: Vec::new(),
            captures: Vec::new(),
            size_uses: Vec::new(),
            sized: HashSet::new(),
            size_eqs: Vec::new(),
        };
        inf.check_group(&group);
    }
}

/// Every impl must be accompanied by impls of its trait's superclasses
/// (under the impl's own context).
fn check_superclasses(env: &mut Env, out: &mut Typed) {
    let mut errors = Vec::new();
    for i in 0..env.impls.len() {
        let imp = env.impls[i].clone();
        let Some(tr) = env.traits.get(&imp.trait_name).cloned() else {
            continue;
        };
        if tr.supers.is_empty() {
            continue;
        }
        let map: HashMap<TV, Type> = tr
            .params
            .iter()
            .copied()
            .zip(imp.head.iter().cloned())
            .collect();
        let wanted: Vec<(Pred, Span)> = tr
            .supers
            .iter()
            .map(|p| {
                (
                    Pred {
                        trait_name: p.trait_name.clone(),
                        args: p.args.iter().map(|a| TypeTable::subst(a, &map)).collect(),
                    },
                    imp.span,
                )
            })
            .collect();
        let mut inf = Infer {
            env,
            out,
            level: 0,
            scope: Scope {
                module: imp.module.clone(),
            },
            group: HashMap::new(),
            current: String::new(),
            deferred: Vec::new(),
            field_reqs: Vec::new(),
            wanted: Vec::new(),
            int_lits: Vec::new(),
            ctxs: Vec::new(),
            comptimes: Vec::new(),
            captures: Vec::new(),
            size_uses: Vec::new(),
            sized: HashSet::new(),
            size_eqs: Vec::new(),
        };
        let given = inf.given_closure(&imp.context);
        match inf.solve(wanted, &given) {
            Ok(residual) => {
                for (p, sp) in residual {
                    let msg = format!(
                        "this impl of `{}` also needs an implementation of `{}` (a superclass)",
                        display_name(&imp.trait_name),
                        inf.show_pred(&p)
                    );
                    errors.push(Diagnostic::error(sp, msg));
                }
            }
            Err(d) => errors.push(Diagnostic::error(
                imp.span,
                format!(
                    "this impl of `{}` needs its superclasses: {}",
                    display_name(&imp.trait_name),
                    d.message
                ),
            )),
        }
    }
    env.errors.extend(errors);
}

/// Free value names of an expression (unresolved source names), together
/// with the scope of the binding.
fn free_names(e: &Expr, out: &mut Vec<(String, Span)>) {
    match &e.kind {
        ExprKind::Var(n) => out.push((n.clone(), e.span)),
        ExprKind::App(f, args) => {
            free_names(f, out);
            args.iter().for_each(|a| free_names(a, out));
        }
        ExprKind::Pipe(a, b) => {
            free_names(a, out);
            free_names(b, out);
        }
        ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
            xs.iter().for_each(|a| free_names(a, out))
        }
        ExprKind::Record(fs)
        | ExprKind::NominalRecord(_, fs)
        | ExprKind::With(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::Update(fs) => fs.iter().for_each(|(_, a)| free_names(a, out)),
        ExprKind::Match(arms) => arms.iter().for_each(|a| free_names(&a.body, out)),
        ExprKind::Comptime(x) => free_names(x, out),
        ExprKind::Quote(x) => {
            let mut us = Vec::new();
            collect_unquotes(x, &mut us);
            us.into_iter().for_each(|u| free_names(u, out));
        }
        _ => {}
    }
}

/// Strongly connected components of bindings in dependency order (Tarjan).
fn binding_order(env: &mut Env) -> Vec<Vec<usize>> {
    let n = env.bindings.len();
    let mut deps: Vec<Vec<usize>> = vec![vec![]; n];
    for (i, b) in env.bindings.iter().enumerate() {
        let scope = Scope {
            module: b.module.clone(),
        };
        let mut names = Vec::new();
        free_names(&b.body, &mut names);
        for (name, _) in names {
            if let Some(canon) = env.resolve_value(&scope, &name) {
                if let Some(GlobalKind::Binding(j)) = env.globals.get(&canon).map(|g| &g.kind) {
                    if !deps[i].contains(j) {
                        deps[i].push(*j);
                    }
                }
            }
        }
    }
    struct T<'a> {
        deps: &'a [Vec<usize>],
        index: Vec<Option<usize>>,
        low: Vec<usize>,
        on: Vec<bool>,
        stack: Vec<usize>,
        next: usize,
        out: Vec<Vec<usize>>,
    }
    fn strong(t: &mut T, v: usize) {
        t.index[v] = Some(t.next);
        t.low[v] = t.next;
        t.next += 1;
        t.stack.push(v);
        t.on[v] = true;
        for &w in &t.deps[v].clone() {
            if t.index[w].is_none() {
                strong(t, w);
                t.low[v] = t.low[v].min(t.low[w]);
            } else if t.on[w] {
                t.low[v] = t.low[v].min(t.index[w].unwrap());
            }
        }
        if Some(t.low[v]) == t.index[v] {
            let mut comp = Vec::new();
            loop {
                let w = t.stack.pop().unwrap();
                t.on[w] = false;
                comp.push(w);
                if w == v {
                    break;
                }
            }
            comp.sort();
            t.out.push(comp);
        }
    }
    let mut t = T {
        deps: &deps,
        index: vec![None; n],
        low: vec![0; n],
        on: vec![false; n],
        stack: vec![],
        next: 0,
        out: vec![],
    };
    for v in 0..n {
        if t.index[v].is_none() {
            strong(&mut t, v);
        }
    }
    let comps = t.out;
    // `rec` checks.
    for comp in &comps {
        let recursive = comp.len() > 1 || deps[comp[0]].contains(&comp[0]);
        if recursive {
            for &i in comp {
                let b = &env.bindings[i];
                if !b.rec {
                    let others: Vec<String> = comp
                        .iter()
                        .filter(|&&j| j != i)
                        .map(|&j| format!("`{}`", display_name(&env.bindings[j].name)))
                        .collect();
                    let msg = if others.is_empty() {
                        format!(
                            "`{}` refers to itself; recursive bindings must be declared with `rec`",
                            display_name(&b.name)
                        )
                    } else {
                        format!(
                            "`{}` is mutually recursive with {}; recursive bindings must be declared with `rec`",
                            display_name(&b.name),
                            others.join(", ")
                        )
                    };
                    env.errors.push(Diagnostic::error(b.span, msg));
                }
            }
        }
    }
    comps
}

impl<'a> Infer<'a> {
    fn fresh(&mut self) -> Type {
        self.env.table.fresh_ty(self.level)
    }

    fn fresh_eff(&mut self) -> Row {
        self.env.table.fresh_eff(self.level)
    }

    fn record(&mut self, e: &Expr, t: &Type) {
        self.out.node_types.insert(e.id, t.clone());
    }

    pub(crate) fn show(&self, t: &Type) -> String {
        Printer::new(&self.env.table).show(t)
    }

    fn show2(&self, a: &Type, b: &Type) -> (String, String) {
        let mut p = Printer::new(&self.env.table);
        p.prepare(&[a, b]);
        (p.show(a), p.show(b))
    }

    /// The equations between sizes left undecided, now that the group's
    /// definitions are checked: each must hold, and each must be decided.
    fn check_sizes(&mut self) -> IResult<()> {
        loop {
            let eqs = std::mem::take(&mut self.size_eqs);
            if eqs.is_empty() {
                return Ok(());
            }
            let n = eqs.len();
            let mut left = Vec::new();
            for (a, b, span, what) in eqs {
                if self.env.table.unify(&a, &b).is_err() {
                    let (x, y) = self.show2(&a, &b);
                    return Err(Diagnostic::error(
                        span,
                        format!("size mismatch in {}: `{}` is not `{}`", what, x, y),
                    ));
                }
                if !std::mem::take(&mut self.env.table.deferred).is_empty() {
                    left.push((a, b, span, what));
                }
            }
            if left.len() == n {
                let (a, b, span, what) = &left[0];
                let (x, y) = self.show2(a, b);
                return Err(Diagnostic::error(
                    *span,
                    format!("cannot tell whether `{}` is `{}` in {}", x, y, what),
                )
                .with_note("give the sizes in a signature, or an abstract size (`_`) for a size chosen when the program runs"));
            }
            self.size_eqs = left;
        }
    }

    /// Unify with a located, explained error.
    pub(crate) fn unify(
        &mut self,
        span: Span,
        expected: &Type,
        found: &Type,
        what: &str,
    ) -> IResult<()> {
        match self.env.table.unify(expected, found) {
            Ok(()) => {
                for (a, b) in std::mem::take(&mut self.env.table.deferred) {
                    self.size_eqs.push((a, b, span, what.to_string()));
                }
                Ok(())
            }
            Err(err) => {
                let (e, f) = self.show2(expected, found);
                let mut d = Diagnostic::error(
                    span,
                    format!("type mismatch in {}: expected `{}`, found `{}`", what, e, f),
                );
                match err {
                    UnifyError::Mismatch(a, b) => {
                        let (x, y) = self.show2(&a, &b);
                        if x != e || y != f {
                            d = d.with_note(format!("`{}` is not compatible with `{}`", x, y));
                        }
                    }
                    UnifyError::Occurs(v, t) => {
                        let (x, y) = self.show2(&Type::Var(v), &t);
                        d = d.with_note(format!(
                            "`{}` would have to contain itself (`{}`); the type would be infinite",
                            x, y
                        ));
                    }
                    UnifyError::MissingLabel(l, kind) => {
                        let msg = match kind {
                            Kind::Eff => format!("effect `{}` is not allowed here", l),
                            _ => format!("field `{}` is missing on one side", l),
                        };
                        d = d.with_note(msg);
                    }
                    UnifyError::LabelOnRigid(l) => {
                        d = d.with_note(format!(
                            "`{}` cannot be added to a row that the signature keeps abstract",
                            l
                        ));
                    }
                    UnifyError::RigidRow => {}
                    UnifyError::Abstract(m, _) => {
                        let x = self.show(&Type::Var(m));
                        d = d
                            .with_note(format!(
                            "the size `{}` is abstract: each call of the function chooses its own, \
                             so it cannot be shared beyond one call's result",
                            x
                        ))
                            .with_note(
                                "call the function directly (`xs | vector.from-list`), \
                             compare sizes at run time with `vector.same-size`, \
                             or keep values of different sizes packed (`vector.pack`)",
                            );
                    }
                }
                Err(d)
            }
        }
    }

    // ----- schemes -----------------------------------------------------------

    /// Instantiate a scheme, opening closed effect rows along the result
    /// spine (subeffecting).
    fn instantiate(&mut self, s: &Scheme) -> (Type, Vec<Type>, Vec<Pred>) {
        let mut map = HashMap::new();
        let mut inst = Vec::new();
        for v in &s.vars {
            if self.is_abstract(*v) {
                // chosen by the definition (see `Env::abstract_sizes`)
                inst.push(Type::Var(*v));
                continue;
            }
            let kind = self.env.table.vars[*v as usize].kind;
            let nv = self.env.table.fresh(kind, self.level);
            map.insert(*v, Type::Var(nv));
            inst.push(Type::Var(nv));
        }
        let ty = TypeTable::subst(&s.ty, &map);
        let ty = self.open_spine(ty);
        let preds = s
            .preds
            .iter()
            .map(|p| Pred {
                trait_name: p.trait_name.clone(),
                args: p.args.iter().map(|a| TypeTable::subst(a, &map)).collect(),
            })
            .collect();
        (ty, inst, preds)
    }

    /// An abstract size of a signature (`_`, `_n`).
    fn is_abstract(&self, v: TV) -> bool {
        let info = &self.env.table.vars[v as usize];
        info.rigid.as_deref().is_some_and(|n| n.starts_with('_'))
    }

    fn open_spine(&mut self, t: Type) -> Type {
        match t {
            Type::Fun(a, b, mut e) => {
                if e.tail.is_none() {
                    e.tail = Some(self.env.table.fresh(Kind::Eff, self.level));
                }
                let b = self.open_spine(*b);
                Type::Fun(a, Box::new(b), e)
            }
            other => other,
        }
    }

    // ----- binding groups ------------------------------------------------------

    fn check_group(&mut self, group: &[usize]) {
        self.level = 1;
        self.group.clear();
        self.deferred.clear();
        self.field_reqs.clear();
        self.int_lits.clear();
        self.ctxs.clear();
        self.comptimes.clear();
        self.captures.clear();
        for &i in group {
            let b = &self.env.bindings[i];
            if !b.annotated {
                let name = b.name.clone();
                let t = self.fresh();
                self.group.insert(name, t);
            }
        }
        let mut failed = false;
        let mut wanted_per: Vec<(usize, Vec<(Pred, Span)>)> = Vec::new();
        for &i in group {
            let b = self.env.bindings[i].clone();
            self.scope = Scope {
                module: b.module.clone(),
            };
            self.current = b.name.clone();
            self.wanted.clear();
            match self.check_binding(&b) {
                Ok(_) => {}
                Err(d) => {
                    self.env.errors.push(d);
                    failed = true;
                }
            }
            wanted_per.push((i, std::mem::take(&mut self.wanted)));
        }
        if !failed {
            if let Err(d) = self.resolve_deferred() {
                self.env.errors.push(d);
                failed = true;
            }
        }
        // Constraints of annotated bindings are checked one by one against
        // their signature; unannotated ones are solved for the group.
        let mut group_wanted = Vec::new();
        if !failed {
            for (i, w) in wanted_per {
                let b = &self.env.bindings[i];
                if b.annotated {
                    let given = self.env.globals[&b.name]
                        .scheme
                        .as_ref()
                        .unwrap()
                        .preds
                        .clone();
                    match self.solve_annotated(w, &given) {
                        Ok(implicit) => {
                            let name = self.env.bindings[i].name.clone();
                            if let Some(sc) = self
                                .env
                                .globals
                                .get_mut(&name)
                                .and_then(|g| g.scheme.as_mut())
                            {
                                for p in implicit {
                                    if !sc.preds.contains(&p) {
                                        sc.preds.push(p);
                                    }
                                }
                            }
                        }
                        Err(d) => {
                            self.env.errors.push(d);
                            failed = true;
                        }
                    }
                } else {
                    group_wanted.extend(w);
                }
            }
        }
        let mut residual = Vec::new();
        if !failed {
            match self.solve_group(group, group_wanted) {
                Ok(r) => residual = r,
                Err(d) => {
                    self.env.errors.push(d);
                    failed = true;
                }
            }
        }
        if !failed {
            let sized = std::mem::take(&mut self.sized);
            for (id, sp, what) in std::mem::take(&mut self.size_uses) {
                if !sized.contains(&id) {
                    self.env.errors.push(Diagnostic::error(
                        sp,
                        format!(
                            "`{}` takes its size from a list literal (`{} [...]`); for a computed list use `{}`",
                            what,
                            what,
                            if what == "vector" { "vector.from-list" } else { "matrix.from-rows" }
                        ),
                    ));
                    failed = true;
                }
            }
        }
        if !failed {
            if let Err(d) = self.check_sizes() {
                self.env.errors.push(d);
                failed = true;
            }
        }
        if !failed {
            if let Err(d) = self.check_int_literals() {
                self.env.errors.push(d);
                failed = true;
            }
        }
        if !failed {
            if let Err(d) = self.check_effects(group) {
                self.env.errors.push(d);
                failed = true;
            }
        }
        self.level = 0;
        for &i in group {
            let b = self.env.bindings[i].clone();
            if b.annotated {
                continue;
            }
            let t = self.group[&b.name].clone();
            let scheme = if failed {
                // Give failed bindings a fully polymorphic type to avoid
                // cascading errors.
                let v = self.env.table.fresh(Kind::Star, 1);
                Scheme {
                    vars: vec![v],
                    preds: vec![],
                    ty: Type::Var(v),
                }
            } else {
                let sc = self.generalize(&t, &residual);
                self.explicit_generics(&b, sc)
            };
            self.env.bindings[i].mono_vars = scheme.vars.clone();
            if let Some(g) = self.env.globals.get_mut(&b.name) {
                g.scheme = Some(scheme);
            }
        }
        // the program runs `main`'s value: a function would never be called
        for &i in group {
            let b = &self.env.bindings[i];
            if b.name != "main::main" || failed {
                continue;
            }
            let ty = self.env.globals[&b.name]
                .scheme
                .as_ref()
                .map(|s| s.ty.clone());
            if let Some(t @ Type::Fun(..)) = ty.map(|t| self.env.table.resolve(&t)) {
                let shown = self.show(&t);
                let span = b.span;
                self.env.errors.push(
                    Diagnostic::error(span, format!("`main` is a function (`{}`), so it would never run", shown))
                        .with_note("`main` is the program's value: apply the function, for example `main = () | f`"),
                );
            }
        }
    }

    /// Effect rules: definitions are pure (except `main` and tests), only
    /// the final arrow of a binding may be effectful, `comptime` code is
    /// capability-restricted, and resources are not captured in closures.
    fn check_effects(&mut self, group: &[usize]) -> IResult<()> {
        for (name, ctx, span) in std::mem::take(&mut self.ctxs) {
            let labels = self.effect_labels(&ctx);
            let is_test = name.contains("::test#");
            if name == "main::main" || name == crate::rest::ENTRY || name == crate::mcp::ENTRY {
                if labels.iter().any(|l| l == "State") {
                    return Err(Diagnostic::error(
                        span,
                        "`main` performs the `State` effect without a handler",
                    )
                    .with_note("wrap the stateful part with `run-state`"));
                }
            } else if !is_test && !labels.is_empty() {
                return Err(Diagnostic::error(
                    span,
                    format!(
                        "`{}` performs effects ({}) while being defined",
                        display_name(&name),
                        labels.join(", ")
                    ),
                )
                .with_note(
                    "effects may only happen when a function is called, or in `main`; \
                     make this a function (for example by composing with `|`)",
                ));
            }
        }
        for (row, span) in std::mem::take(&mut self.comptimes) {
            for l in self.effect_labels(&row) {
                if !COMPTIME_EFFECTS.contains(&l.as_str()) {
                    return Err(Diagnostic::error(
                        span,
                        format!("`comptime` code may not perform the `{}` effect", l),
                    )
                    .with_note(format!(
                        "compile-time effects are limited to {}",
                        COMPTIME_EFFECTS.join(", ")
                    )));
                }
            }
        }
        for &i in group {
            let b = &self.env.bindings[i];
            let t = match &self.env.globals[&b.name].scheme {
                Some(s) if b.annotated => s.ty.clone(),
                _ => self.group.get(&b.name).cloned().unwrap_or(Type::unit()),
            };
            let mut t = self.env.table.resolve(&t);
            while let Type::Fun(_, r, e) = t.clone() {
                let r = self.env.table.resolve(&r);
                if matches!(r, Type::Fun(..)) {
                    let labels = self.effect_labels(&e);
                    if !labels.is_empty() {
                        return Err(Diagnostic::error(
                            b.span,
                            format!(
                                "`{}` performs effects ({}) before receiving all of its arguments",
                                display_name(&b.name),
                                labels.join(", ")
                            ),
                        )
                        .with_note("effects may only occur on the final arrow of a function"));
                    }
                }
                t = r;
            }
        }
        for (span, arg, result) in std::mem::take(&mut self.captures) {
            if matches!(self.env.table.resolve(&result), Type::Fun(..)) {
                let p = Pred {
                    trait_name: "std::Dup".into(),
                    args: vec![arg.clone()],
                };
                if self.solve(vec![(p, span)], &[]).is_err() {
                    return Err(Diagnostic::error(
                        span,
                        format!(
                            "a resource of type `{}` would be captured by a partial application",
                            self.show(&arg)
                        ),
                    )
                    .with_note(
                        "resources may be used at most once; pass them as the last argument",
                    ));
                }
            }
        }
        Ok(())
    }

    fn effect_labels(&self, r: &Row) -> Vec<String> {
        self.env
            .table
            .flatten_row(r)
            .fields
            .iter()
            .map(|(l, _)| l.clone())
            .collect()
    }

    /// Polymorphism is explicit: a definition without a signature is not
    /// generic. Its effect row variables are generalized (effects are
    /// erased, so they cost nothing), but a type or record row variable
    /// left in its inferred type is an error that suggests the signature
    /// which would make it generic. `main` and tests are values whose
    /// unconstrained type variables are `()`.
    fn explicit_generics(&mut self, b: &BindingInfo, sc: Scheme) -> Scheme {
        let generic: Vec<TV> = sc
            .vars
            .iter()
            .copied()
            .filter(|v| self.env.table.vars[*v as usize].kind != Kind::Eff)
            .collect();
        // a macro's type is checked where it is expanded
        if generic.is_empty() || self.env.macros.contains(&b.name) {
            return sc;
        }
        if b.name == "main::main"
            || b.name == crate::rest::ENTRY
            || b.name == crate::mcp::ENTRY
            || b.test_name.is_some()
        {
            for v in &generic {
                if self.env.table.vars[*v as usize].kind == Kind::Star {
                    let _ = self.unify(b.span, &Type::Var(*v), &Type::unit(), "`main`");
                }
            }
            return self.generalize(&sc.ty, &[]);
        }
        // `Dup` is inferred for signatures too
        let mut wanted = sc.clone();
        wanted.preds.retain(|p| p.trait_name != "std::Dup");
        let shown = crate::driver::show_scheme(self.env, &wanted);
        self.env.errors.push(
            Diagnostic::error(
                b.span,
                format!(
                    "`{}` would be generic, but it has no signature",
                    display_name(&b.name)
                ),
            )
            .with_note(format!(
                "generics are explicit: write `{} : {}` to make it generic, \
                 or a signature with concrete types",
                b.name.rsplit("::").next().unwrap_or(&b.name),
                shown
            )),
        );
        sc
    }

    fn generalize(&mut self, t: &Type, residual: &[(Pred, Span)]) -> Scheme {
        let mut fv = Vec::new();
        self.env.table.free_vars(t, &mut fv);
        let vars: Vec<TV> = fv
            .into_iter()
            .filter(|v| {
                let info = &self.env.table.vars[*v as usize];
                info.level > self.level && info.rigid.is_none()
            })
            .collect();
        let mut preds: Vec<Pred> = Vec::new();
        for (p, _) in residual {
            let p = Pred {
                trait_name: p.trait_name.clone(),
                args: p.args.iter().map(|a| self.env.table.zonk(a)).collect(),
            };
            let mut pv = Vec::new();
            for a in &p.args {
                self.env.table.free_vars(a, &mut pv);
            }
            if pv.iter().all(|v| vars.contains(v)) && !preds.contains(&p) {
                preds.push(p);
            }
        }
        Scheme {
            vars,
            preds,
            ty: self.env.table.zonk(t),
        }
    }

    fn check_binding(&mut self, b: &BindingInfo) -> IResult<Type> {
        let ctx = self.fresh_eff();
        self.ctxs.push((b.name.clone(), ctx.clone(), b.body.span));
        let t = self.infer(&b.body, &ctx)?;
        let expected = if b.annotated {
            let sc = self.env.globals[&b.name].scheme.clone().unwrap();
            // the definition chooses its abstract sizes
            let mut map = HashMap::new();
            let abs: Vec<TV> = sc
                .vars
                .iter()
                .copied()
                .filter(|v| self.is_abstract(*v))
                .collect();
            for v in abs {
                map.insert(v, self.fresh());
            }
            TypeTable::subst(&sc.ty, &map)
        } else {
            self.group[&b.name].clone()
        };
        let what = if b.test_name.is_some() {
            "test (tests must produce a `Bool`)".to_string()
        } else {
            format!("the definition of `{}`", display_name(&b.name))
        };
        // under a signature, the definition's own results choose its
        // abstract sizes
        let found = if b.annotated {
            self.env.table.open_final(&t, self.level)
        } else {
            t.clone()
        };
        self.unify(b.body.span, &expected, &found, &what)?;
        Ok(t)
    }

    /// Settle a record operation: a nominal input record keeps its type
    /// (field types must then be preserved); otherwise input and output
    /// are rows sharing their other fields.
    fn finish_field_req(&mut self, req: FieldReq) -> IResult<()> {
        let input = self.env.table.resolve(&req.input);
        let nominal = matches!(&input, Type::Con(n, _) if self.env.table.records.contains_key(n));
        let what = "the record";
        if nominal {
            let mut fs: Vec<(String, Type)> = req
                .fields
                .iter()
                .map(|(n, a, _)| (n.clone(), a.clone()))
                .collect();
            fs.sort_by(|a, b| a.0.cmp(&b.0));
            let r = self.env.table.fresh(Kind::Row, self.level);
            let row = Type::Record(Row {
                fields: fs,
                tail: Some(r),
            });
            self.unify(req.span, &row, &input, what)?;
            for (_, a, b) in &req.fields {
                self.unify(req.span, a, b, what)?;
            }
            self.unify(req.span, &input, &req.output, what)?;
        } else {
            let r = self.env.table.fresh(Kind::Row, self.level);
            let mut rin = Row {
                fields: req
                    .fields
                    .iter()
                    .map(|(n, a, _)| (n.clone(), a.clone()))
                    .collect(),
                tail: Some(r),
            };
            rin.sort();
            let mut rout = Row {
                fields: req
                    .fields
                    .iter()
                    .map(|(n, _, b)| (n.clone(), b.clone()))
                    .collect(),
                tail: Some(r),
            };
            rout.sort();
            self.unify(req.span, &Type::Record(rin), &input, what)?;
            self.unify(req.span, &Type::Record(rout), &req.output, what)?;
        }
        Ok(())
    }

    fn resolve_field_reqs(&mut self, force: bool) -> IResult<bool> {
        let mut progress = false;
        for req in std::mem::take(&mut self.field_reqs) {
            let known = !matches!(self.env.table.resolve(&req.input), Type::Var(_))
                || !matches!(self.env.table.resolve(&req.output), Type::Var(_));
            if known || force {
                // a known output (and unknown input) means the same type
                if matches!(self.env.table.resolve(&req.input), Type::Var(_))
                    && matches!(self.env.table.resolve(&req.output), Type::Con(..))
                    && req.fields.iter().all(|(_, a, b)| {
                        let (a, b) = (self.env.table.resolve(a), self.env.table.resolve(b));
                        crate::env::types_equal(&self.env.table, &a, &b)
                    })
                {
                    let (i, o) = (req.input.clone(), req.output.clone());
                    self.unify(req.span, &i, &o, "the record")?;
                }
                progress = true;
                self.finish_field_req(req)?;
            } else {
                self.field_reqs.push(req);
            }
        }
        Ok(progress)
    }

    fn resolve_deferred(&mut self) -> IResult<()> {
        loop {
            let mut progress = self.resolve_field_reqs(false)?;
            let pending = std::mem::take(&mut self.deferred);
            for d in pending {
                let l = self.env.table.resolve(&d.lhs);
                match l {
                    Type::Var(_) => self.deferred.push(d),
                    Type::Fun(..) => {
                        progress = true;
                        self.finish_compose(d.node, d.span, &d.lhs, &d.rhs, &d.result)?;
                    }
                    _ => {
                        progress = true;
                        self.finish_apply(d.node, d.span, &d.lhs, &d.rhs, &d.result, &d.ctx)?;
                    }
                }
            }
            if self.deferred.is_empty() && self.field_reqs.is_empty() {
                return Ok(());
            }
            if !progress && !self.field_reqs.is_empty() {
                self.resolve_field_reqs(true)?;
                continue;
            }
            if !progress {
                // Default the remaining ones to application.
                let pending = std::mem::take(&mut self.deferred);
                for d in pending {
                    self.finish_apply(d.node, d.span, &d.lhs, &d.rhs, &d.result, &d.ctx)?;
                }
                return Ok(());
            }
        }
    }

    fn finish_apply(
        &mut self,
        node: NodeId,
        span: Span,
        lhs: &Type,
        rhs: &Type,
        result: &Type,
        ctx: &Row,
    ) -> IResult<()> {
        self.out.pipe_modes.insert(node, PipeMode::Apply);
        self.captures.push((span, lhs.clone(), result.clone()));
        let rr = self.env.table.resolve(rhs);
        if let Type::Fun(param, _, _) = &rr {
            let param = (**param).clone();
            self.unify(span, &param, lhs, "pipe input")?;
        }
        let eff = ctx.clone();
        let f = Type::fun(lhs.clone(), result.clone(), eff);
        match self.env.table.resolve(rhs) {
            Type::Fun(..) | Type::Var(_) | Type::App(..) => {
                let rhs = self.env.table.open_call(rhs, self.level);
                self.unify(span, &f, &rhs, "the stage after `|`")
            }
            other => Err(Diagnostic::error(
                span,
                format!(
                    "the stage after `|` must be a function, but it has type `{}`",
                    self.show(&other)
                ),
            )),
        }
    }

    fn finish_compose(
        &mut self,
        node: NodeId,
        span: Span,
        lhs: &Type,
        rhs: &Type,
        result: &Type,
    ) -> IResult<()> {
        self.out.pipe_modes.insert(node, PipeMode::Compose);
        // each call of the composition calls both stages once, choosing
        // their abstract sizes again
        let start = self.env.table.vars.len();
        let lhs = &self.env.table.open_call(lhs, self.level);
        let Type::Fun(a, b, e) = self.env.table.resolve(lhs) else {
            unreachable!()
        };
        let c = self.fresh();
        self.captures.push((span, (*b).clone(), c.clone()));
        let g = Type::fun((*b).clone(), c.clone(), e.clone());
        match self.env.table.resolve(rhs) {
            Type::Fun(..) | Type::Var(_) | Type::App(..) => {}
            other => {
                return Err(Diagnostic::error(
                    span,
                    format!(
                        "the stage after `|` must be a function, but it has type `{}`",
                        self.show(&other)
                    ),
                ))
            }
        }
        if let Type::Fun(param, _, _) = self.env.table.resolve(rhs) {
            self.unify(span, &param, &b, "pipe input (composition)")?;
        }
        let rhs = self.env.table.open_call(rhs, self.level);
        self.unify(span, &g, &rhs, "the stage after `|`")?;
        let composed = self.reabstract(start, Type::Fun(a, Box::new(c), e));
        self.unify(span, result, &composed, "composition")
    }

    // ----- expressions ---------------------------------------------------------

    fn lookup_var(&mut self, e: &Expr, name: &str) -> IResult<Type> {
        let Some(canon) = self.env.resolve_value(&self.scope, name) else {
            return Err(Diagnostic::error(
                e.span,
                format!("unknown name `{}`", name),
            ));
        };
        if let Some(t) = self.group.get(&canon) {
            let t = t.clone();
            self.out.insts.insert(
                e.id,
                Inst {
                    target: canon,
                    types: vec![],
                },
            );
            return Ok(t);
        }
        let g = &self.env.globals[&canon];
        let Some(scheme) = g.scheme.clone() else {
            return Err(Diagnostic::error(
                e.span,
                format!("`{}` is used before its type is known", name),
            ));
        };
        let (t, inst, preds) = self.instantiate(&scheme);
        for p in preds {
            self.wanted.push((p, e.span));
        }
        self.out.insts.insert(
            e.id,
            Inst {
                target: canon,
                types: inst,
            },
        );
        Ok(t)
    }

    fn lookup_ctor(&mut self, span: Span, name: &str) -> IResult<(String, Type, Vec<Type>)> {
        let canon = self
            .env
            .resolve_ctor(&self.scope, name)
            .map_err(|m| Diagnostic::error(span, m))?;
        let scheme = self.env.ctors[&canon].scheme.clone();
        let (t, inst, _) = self.instantiate(&scheme);
        Ok((canon, t, inst))
    }

    fn int_type(
        &mut self,
        span: Span,
        neg: bool,
        mag: u128,
        suffix: &Option<String>,
    ) -> IResult<Type> {
        let name = match suffix.as_deref() {
            None => "I64".to_string(),
            Some(s) => s.to_uppercase().replace("SIZE", "Size"),
        };
        if let Err(msg) = check_int_range(&name, neg, mag) {
            return Err(Diagnostic::error(span, msg));
        }
        Ok(Type::con(&format!("std::{}", name)))
    }

    fn int_literal(&mut self, span: Span, neg: bool, mag: u128) -> Type {
        let t = self.fresh();
        self.wanted.push((
            Pred {
                trait_name: "std::IntLit".into(),
                args: vec![t.clone()],
            },
            span,
        ));
        self.int_lits.push((span, t.clone(), neg, mag));
        t
    }

    pub fn infer(&mut self, e: &Expr, ctx: &Row) -> IResult<Type> {
        let t = self.infer_inner(e, ctx)?;
        self.record(e, &t);
        Ok(t)
    }

    fn infer_inner(&mut self, e: &Expr, ctx: &Row) -> IResult<Type> {
        match &e.kind {
            ExprKind::Int {
                neg,
                mag,
                suffix: None,
            } => Ok(self.int_literal(e.span, *neg, *mag)),
            ExprKind::Int { neg, mag, suffix } => self.int_type(e.span, *neg, *mag, suffix),
            ExprKind::Float { suffix: None, .. } => {
                let t = self.fresh();
                self.wanted.push((
                    Pred {
                        trait_name: "std::FloatLit".into(),
                        args: vec![t.clone()],
                    },
                    e.span,
                ));
                Ok(t)
            }
            ExprKind::Float { suffix, .. } => {
                let name = match suffix.as_deref() {
                    None => "F64".to_string(),
                    Some("bf16") => "BF16".to_string(),
                    Some(s) => s.to_uppercase(),
                };
                Ok(Type::con(&format!("std::{}", name)))
            }
            ExprKind::Str(_) => Ok(Type::con("std::String")),
            ExprKind::Trits(ts) if ts.len() as u64 > crate::value::TINT_MAX_WIDTH => Err(
                Diagnostic::error(e.span, crate::value::tint_width_error(ts.len() as u64)),
            ),
            ExprKind::Trits(ts) => Ok(Type::Con(
                "std::TInt".into(),
                vec![Type::Nat(ts.len() as u64)],
            )),
            ExprKind::Duration(_) => Ok(Type::con("std::Duration")),
            ExprKind::Var(name) => {
                let t = self.lookup_var(e, name)?;
                let user = self.scope.module != "std";
                match self.env.resolve_value(&self.scope, name).as_deref() {
                    _ if !user => {}
                    Some("std::vector") => self.size_uses.push((e.id, e.span, "vector")),
                    Some("std::matrix") => self.size_uses.push((e.id, e.span, "matrix")),
                    _ => {}
                }
                Ok(t)
            }
            ExprKind::Ctor(name) => {
                let (canon, t, inst) = self.lookup_ctor(e.span, name)?;
                self.out.insts.insert(
                    e.id,
                    Inst {
                        target: canon,
                        types: inst,
                    },
                );
                Ok(t)
            }
            ExprKind::Selector(path) => {
                // .a.b = .a | .b
                let mut result: Option<Type> = None;
                let eff = self.fresh_eff();
                for seg in path {
                    let a = self.fresh();
                    let r = self.env.table.fresh(Kind::Row, self.level);
                    let rec = Type::Record(Row {
                        fields: vec![(seg.clone(), a.clone())],
                        tail: Some(r),
                    });
                    result = Some(match result {
                        None => Type::fun(rec, a, eff.clone()),
                        Some(Type::Fun(x, y, _)) => {
                            self.unify(e.span, &rec, &y, "selector path")?;
                            Type::fun(*x, a, eff.clone())
                        }
                        Some(_) => unreachable!(),
                    });
                }
                Ok(result.unwrap())
            }
            ExprKind::App(f, args) => {
                let t = self.infer_app(e, f, args, ctx)?;
                self.size_literal(e, f, args, &t)?;
                Ok(t)
            }
            ExprKind::Pipe(l, r) => {
                let tl = self.infer(l, ctx)?;
                let tr = self.infer(r, ctx)?;
                let result = self.fresh();
                // `[..] | vector` sizes the vector like `vector [..]`
                if matches!(l.kind, ExprKind::List(_)) {
                    self.size_literal(e, r, std::slice::from_ref(l), &result)?;
                }
                match self.env.table.resolve(&tl) {
                    Type::Fun(..) => self.finish_compose(e.id, e.span, &tl, &tr, &result)?,
                    Type::Var(_) => self.deferred.push(Deferred {
                        node: e.id,
                        span: e.span,
                        lhs: tl,
                        rhs: tr,
                        result: result.clone(),
                        ctx: ctx.clone(),
                    }),
                    _ => self.finish_apply(e.id, e.span, &tl, &tr, &result, ctx)?,
                }
                Ok(result)
            }
            ExprKind::Unit => Ok(Type::unit()),
            ExprKind::Tuple(items) => {
                let mut ts = Vec::new();
                for i in items {
                    ts.push(self.infer(i, ctx)?);
                }
                Ok(Type::tuple(ts))
            }
            ExprKind::List(items) => {
                let elem = self.fresh();
                for i in items {
                    let t = self.infer(i, ctx)?;
                    self.unify(i.span, &elem, &t, "list element")?;
                }
                Ok(Type::Con("std::List".into(), vec![elem]))
            }
            ExprKind::Record(fields) => {
                let mut fs = Vec::new();
                for (n, x) in fields {
                    fs.push((n.clone(), self.infer(x, ctx)?));
                }
                Ok(Type::Record(Row::closed(fs)))
            }
            ExprKind::NominalRecord(name, fields) => {
                let mut fs = Vec::new();
                for (n, x) in fields {
                    fs.push((n.clone(), self.infer(x, ctx)?));
                }
                self.nominal_record_type(e, name, &fs)
            }
            ExprKind::With(fields) => {
                let mut fs = Vec::new();
                for (n, x) in fields {
                    let t = self.infer(x, ctx)?;
                    fs.push((n.clone(), t.clone(), t));
                }
                let t = self.fresh();
                self.field_reqs.push(FieldReq {
                    span: e.span,
                    input: t.clone(),
                    output: t.clone(),
                    fields: fs,
                });
                let eff = self.fresh_eff();
                Ok(Type::fun(t.clone(), t, eff))
            }
            ExprKind::Make(nominal, fields) => {
                let input = self.fresh();
                let eff = self.fresh_eff();
                let mut fs = Vec::new();
                for (n, x) in fields {
                    let tf = self.infer(x, ctx)?;
                    let out = self.fresh();
                    let want = Type::fun(input.clone(), out.clone(), eff.clone());
                    self.unify(x.span, &want, &tf, &format!("field `{}` of `make`", n))?;
                    self.captures.push((x.span, input.clone(), out.clone()));
                    fs.push((n.clone(), out));
                }
                if fields.len() > 1 {
                    self.wanted.push((
                        Pred {
                            trait_name: "std::Dup".into(),
                            args: vec![input.clone()],
                        },
                        e.span,
                    ));
                }
                let result = match nominal {
                    None => Type::Record(Row::closed(fs)),
                    Some(name) => self.nominal_record_type(e, name, &fs)?,
                };
                Ok(Type::fun(input, result, eff))
            }
            ExprKind::Update(fields) => {
                let eff = self.fresh_eff();
                let r = self.env.table.fresh(Kind::Row, self.level);
                let mut ins = Vec::new();
                let mut outs = Vec::new();
                for (n, x) in fields {
                    let tf = self.infer(x, ctx)?;
                    let (a, b) = (self.fresh(), self.fresh());
                    let want = Type::fun(a.clone(), b.clone(), eff.clone());
                    self.unify(x.span, &want, &tf, &format!("field `{}` of `update`", n))?;
                    ins.push((n.clone(), a));
                    outs.push((n.clone(), b));
                }
                let _ = r;
                let (tin, tout) = (self.fresh(), self.fresh());
                self.field_reqs.push(FieldReq {
                    span: e.span,
                    input: tin.clone(),
                    output: tout.clone(),
                    fields: ins
                        .into_iter()
                        .zip(outs)
                        .map(|((n, a), (_, b))| (n, a, b))
                        .collect(),
                });
                Ok(Type::fun(tin, tout, eff))
            }
            ExprKind::Match(arms) => self.infer_match(e, arms),
            ExprKind::Comptime(x) => {
                let cctx = self.fresh_eff();
                self.comptimes.push((cctx.clone(), e.span));
                self.infer(x, &cctx)
            }
            ExprKind::Quote(body) => {
                // spliced parts must be syntax values; positional holes
                // `unquote!(N)` make the quote a function of N+1 syntaxes
                let syn = Type::con("std::Syntax");
                let mut splices = Vec::new();
                collect_unquotes(body, &mut splices);
                for x in splices {
                    if matches!(
                        &x.kind,
                        ExprKind::Int {
                            neg: false,
                            suffix: None,
                            ..
                        }
                    ) {
                        continue;
                    }
                    let t = self.infer(x, ctx)?;
                    self.unify(x.span, &syn, &t, "`unquote!`")?;
                }
                let mut t = syn.clone();
                for _ in 0..crate::syntax::hole_count(body) {
                    let eff = self.fresh_eff();
                    t = Type::fun(syn.clone(), t, eff);
                }
                Ok(t)
            }
            ExprKind::TypeOf(te) => {
                let mut vars = Vec::new();
                let scope = self.scope.clone();
                let t = self.env.conv_type(te, &scope, &mut vars, true)?;
                // type variables in `type[...]` are fresh unknowns here
                let map: HashMap<TV, Type> = vars.iter().map(|(_, v)| (*v, self.fresh())).collect();
                let t = TypeTable::subst(&t, &map);
                self.out.reflected.insert(e.id, t);
                Ok(Type::con("std::TypeInfo"))
            }
            ExprKind::MacroCall(name, _) => Err(Diagnostic::error(
                e.span,
                format!("unknown macro `{}`", name),
            )),
        }
    }

    /// Check field names/types for a nominal record construction and return
    /// the record type.
    fn nominal_record_type(
        &mut self,
        e: &Expr,
        name: &str,
        fields: &[(String, Type)],
    ) -> IResult<Type> {
        let Some(canon) = self.env.resolve_type(&self.scope, name) else {
            return Err(Diagnostic::error(
                e.span,
                format!("unknown type `{}`", name),
            ));
        };
        let def = self.env.types[&canon].clone();
        let TypeDefKind::Record { fields: declared } = &def.kind else {
            return Err(Diagnostic::error(
                e.span,
                format!("`{}` is not a record type", name),
            ));
        };
        for (n, _) in fields {
            if !declared.contains(n) {
                return Err(Diagnostic::error(
                    e.span,
                    format!("record `{}` has no field `{}`", name, n),
                ));
            }
        }
        for d in declared {
            if !fields.iter().any(|(n, _)| n == d) {
                return Err(Diagnostic::error(
                    e.span,
                    format!("missing field `{}` for record `{}`", d, name),
                ));
            }
        }
        let args: Vec<Type> = (0..def.arity).map(|_| self.fresh()).collect();
        let row = self.env.table.expand_record(&canon, &args).unwrap();
        for (n, t) in fields {
            let want = row.fields.iter().find(|(l, _)| l == n).unwrap().1.clone();
            self.unify(e.span, &want, t, &format!("field `{}`", n))?;
        }
        self.out.insts.insert(
            e.id,
            Inst {
                target: canon.clone(),
                types: args.clone(),
            },
        );
        Ok(Type::Con(canon, args))
    }

    fn infer_app(&mut self, e: &Expr, f: &Expr, args: &[Expr], ctx: &Row) -> IResult<Type> {
        let mut tf = self.infer(f, ctx)?;
        for (i, arg) in args.iter().enumerate() {
            let ta = self.infer(arg, ctx)?;
            let r = self.fresh();
            match self.env.table.resolve(&tf) {
                Type::Fun(p, _, _) => {
                    self.unify(arg.span, &p, &ta, &format!("argument {}", i + 1))?;
                }
                Type::Var(_) | Type::App(..) => {}
                other => {
                    let what = if i == 0 {
                        format!(
                            "`{}` is not a function (it has type `{}`) and cannot be applied",
                            crate::pretty::atom(f),
                            self.show(&other)
                        )
                    } else {
                        format!(
                            "too many arguments: after {} argument(s) the result has type `{}`, which is not a function",
                            i,
                            self.show(&other)
                        )
                    };
                    return Err(Diagnostic::error(arg.span, what));
                }
            }
            self.captures.push((arg.span, ta.clone(), r.clone()));
            let want = Type::fun(ta, r.clone(), ctx.clone());
            let opened = self.env.table.open_call(&tf, self.level);
            self.unify(e.span, &want, &opened, "application")?;
            tf = r;
        }
        Ok(tf)
    }

    /// `vector [...]` and `matrix [[...]]` take their sizes from the literal.
    fn size_literal(&mut self, e: &Expr, f: &Expr, args: &[Expr], t: &Type) -> IResult<()> {
        let ExprKind::Var(name) = &f.kind else {
            return Ok(());
        };
        let which = self.env.resolve_value(&self.scope, name);
        let [arg] = args else { return Ok(()) };
        let ExprKind::List(items) = &arg.kind else {
            return Ok(());
        };
        if matches!(which.as_deref(), Some("std::vector") | Some("std::matrix")) {
            self.sized.insert(f.id);
        }
        match which.as_deref() {
            Some("std::vector") => {
                let want = Type::Con(
                    "std::Vector".into(),
                    vec![self.fresh(), Type::Nat(items.len() as u64)],
                );
                self.unify(e.span, &want, t, "vector literal")
            }
            Some("std::matrix") => {
                let mut cols = None;
                for row in items {
                    let ExprKind::List(r) = &row.kind else {
                        return Err(Diagnostic::error(
                            row.span,
                            "matrix rows must be list literals (use matrix.from-rows for computed rows)",
                        ));
                    };
                    match cols {
                        None => cols = Some(r.len()),
                        Some(c) if c != r.len() => {
                            return Err(Diagnostic::error(
                                row.span,
                                format!("matrix rows must all have {} elements", c),
                            ))
                        }
                        _ => {}
                    }
                }
                let want = Type::Con(
                    "std::Matrix".into(),
                    vec![
                        self.fresh(),
                        Type::Nat(items.len() as u64),
                        Type::Nat(cols.unwrap_or(0) as u64),
                    ],
                );
                self.unify(e.span, &want, t, "matrix literal")
            }
            _ => Ok(()),
        }
    }

    fn infer_match(&mut self, e: &Expr, arms: &[Arm]) -> IResult<Type> {
        let start = self.env.table.vars.len();
        let scrut = self.fresh();
        let result = self.fresh();
        let eff = self.fresh_eff();
        let mut rows = Vec::new();
        for arm in arms {
            let mut holes = Vec::new();
            let p = self.check_pattern(&arm.pat, &scrut, &mut holes)?;
            rows.push((p, arm.pat.span));
            let tb = self.infer(&arm.body, &eff)?;
            let mut want = result.clone();
            for h in holes.iter().rev() {
                want = Type::fun(h.clone(), want, eff.clone());
            }
            let what = if holes.is_empty() {
                "match arm".to_string()
            } else {
                format!(
                    "match arm (the body receives {} hole value(s) as arguments)",
                    holes.len()
                )
            };
            self.unify(arm.body.span, &want, &tb, &what)?;
        }
        // Exhaustiveness and redundancy.
        let mut seen: Vec<Vec<exhaust::Pat>> = Vec::new();
        for (p, span) in &rows {
            if exhaust::useful(self.env, &seen, std::slice::from_ref(p)).is_none() {
                self.env
                    .warnings
                    .push(Diagnostic::warning(*span, "unreachable match arm"));
            }
            seen.push(vec![p.clone()]);
        }
        if let Some(w) = exhaust::useful(self.env, &seen, &[exhaust::Pat::Wild]) {
            let shown = exhaust::show(&w[0]);
            return Err(Diagnostic::error(
                e.span,
                format!("match is not exhaustive: `{}` is not covered", shown),
            ));
        }
        Ok(self.reabstract(start, Type::fun(scrut, result, eff)))
    }

    /// A function runs its body once per call, so the sizes its body's
    /// calls chose (rigid sizes made since `start`) are chosen again by
    /// each call of the function: they become markers.
    fn reabstract(&mut self, start: usize, t: Type) -> Type {
        let t = self.env.table.zonk(&t);
        let mut fv = Vec::new();
        self.env.table.free_vars(&t, &mut fv);
        let mut map = HashMap::new();
        for v in fv {
            if (v as usize) >= start && self.is_abstract(v) && !self.env.table.markers.contains(&v)
            {
                let name = self.env.table.vars[v as usize].rigid.clone().unwrap();
                let base = name
                    .trim_end_matches(|c: char| c.is_ascii_digit())
                    .to_string();
                map.insert(v, Type::Var(self.env.table.fresh_marker(&base)));
            }
        }
        if map.is_empty() {
            t
        } else {
            TypeTable::subst(&t, &map)
        }
    }

    fn check_pattern(
        &mut self,
        p: &Pattern,
        expected: &Type,
        holes: &mut Vec<Type>,
    ) -> IResult<exhaust::Pat> {
        match &p.kind {
            PatKind::Hole => {
                holes.push(expected.clone());
                Ok(exhaust::Pat::Wild)
            }
            PatKind::Int { neg, mag } => {
                let t = self.int_literal(p.span, *neg, *mag);
                self.wanted.push((
                    Pred {
                        trait_name: "std::Eq".into(),
                        args: vec![t.clone()],
                    },
                    p.span,
                ));
                self.unify(p.span, expected, &t, "pattern")?;
                Ok(exhaust::Pat::Lit(format!(
                    "{}{}",
                    if *neg { "-" } else { "" },
                    mag
                )))
            }
            PatKind::Str(s) => {
                self.unify(p.span, expected, &Type::con("std::String"), "pattern")?;
                Ok(exhaust::Pat::Lit(format!("{:?}", s)))
            }
            PatKind::Unit => {
                self.unify(p.span, expected, &Type::unit(), "pattern")?;
                Ok(exhaust::Pat::Tuple(vec![]))
            }
            PatKind::Tuple(items) => {
                let ts: Vec<Type> = items.iter().map(|_| self.fresh()).collect();
                self.unify(p.span, expected, &Type::tuple(ts.clone()), "pattern")?;
                let mut ps = Vec::new();
                for (item, t) in items.iter().zip(&ts) {
                    ps.push(self.check_pattern(item, t, holes)?);
                }
                Ok(exhaust::Pat::Tuple(ps))
            }
            PatKind::Ctor(name, args) => {
                let (canon, _t, inst) = self.lookup_ctor(p.span, name)?;
                self.out.pattern_ctors.insert(p.id, canon.clone());
                let def = self.env.ctors[&canon].clone();
                let map: HashMap<TV, Type> = def
                    .scheme
                    .vars
                    .iter()
                    .cloned()
                    .zip(inst.iter().cloned())
                    .collect();
                let fields: Vec<Type> = def
                    .fields
                    .iter()
                    .map(|f| TypeTable::subst(f, &map))
                    .collect();
                let tdef = &self.env.types[&def.type_name];
                let result = Type::Con(
                    def.type_name.clone(),
                    tdef.params
                        .iter()
                        .map(|v| map.get(v).cloned().unwrap())
                        .collect(),
                );
                self.unify(p.span, expected, &result, "pattern")?;
                let mut ps = Vec::new();
                match args {
                    None => {
                        for f in &fields {
                            holes.push(f.clone());
                            ps.push(exhaust::Pat::Wild);
                        }
                    }
                    Some(args) => {
                        if args.len() != fields.len() {
                            return Err(Diagnostic::error(
                                p.span,
                                format!(
                                    "constructor `{}` has {} field(s), but the pattern gives {}",
                                    name,
                                    fields.len(),
                                    args.len()
                                ),
                            ));
                        }
                        for (a, f) in args.iter().zip(&fields) {
                            ps.push(self.check_pattern(a, f, holes)?);
                        }
                    }
                }
                Ok(exhaust::Pat::Ctor(canon, ps))
            }
        }
    }
}

/// The arguments of `unquote!` inside a quoted expression.
pub fn collect_unquotes<'e>(e: &'e Expr, out: &mut Vec<&'e Expr>) {
    match &e.kind {
        ExprKind::MacroCall(n, args) if n == "unquote" => out.extend(args.iter()),
        ExprKind::App(f, args) => {
            collect_unquotes(f, out);
            args.iter().for_each(|a| collect_unquotes(a, out));
        }
        ExprKind::Pipe(a, b) => {
            collect_unquotes(a, out);
            collect_unquotes(b, out);
        }
        ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
            xs.iter().for_each(|a| collect_unquotes(a, out))
        }
        ExprKind::Record(fs)
        | ExprKind::NominalRecord(_, fs)
        | ExprKind::With(fs)
        | ExprKind::Make(_, fs)
        | ExprKind::Update(fs) => fs.iter().for_each(|(_, a)| collect_unquotes(a, out)),
        ExprKind::Match(arms) => arms.iter().for_each(|a| collect_unquotes(&a.body, out)),
        ExprKind::Comptime(x) | ExprKind::Quote(x) => collect_unquotes(x, out),
        _ => {}
    }
}

/// Check that an integer literal fits its type.
pub fn check_int_range(ty: &str, neg: bool, mag: u128) -> Result<(), String> {
    let (min_mag, max): (u128, u128) = match ty {
        "I8" => (1 << 7, (1 << 7) - 1),
        "I16" => (1 << 15, (1 << 15) - 1),
        "I32" => (1 << 31, (1 << 31) - 1),
        "I64" | "ISize" => (1 << 63, (1 << 63) - 1),
        "I128" => (1 << 127, (1 << 127) - 1),
        "U8" => (0, u8::MAX as u128),
        "U16" => (0, u16::MAX as u128),
        "U32" => (0, u32::MAX as u128),
        "U64" | "USize" => (0, u64::MAX as u128),
        "U128" => (0, u128::MAX),
        _ => return Ok(()),
    };
    let ok = if neg { mag <= min_mag } else { mag <= max };
    if ok {
        Ok(())
    } else {
        Err(format!(
            "literal `{}{}` does not fit in `{}`",
            if neg { "-" } else { "" },
            mag,
            ty
        ))
    }
}

/// Collect names of bindings in a module (for reporting).
pub fn module_bindings(env: &Env, module: &str) -> Vec<usize> {
    let mut v: Vec<usize> = (0..env.bindings.len())
        .filter(|&i| {
            let b = &env.bindings[i];
            b.module == module && b.test_name.is_none() && !b.name.contains('[')
        })
        .collect();
    v.sort_by_key(|&i| (env.bindings[i].span.line, env.bindings[i].span.col));
    v
}
