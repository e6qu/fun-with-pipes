//! Constraint solving: trait predicates, builtin structural classes,
//! literal classes, superclass entailment and defaulting.

use std::collections::{HashMap, HashSet};

use crate::diag::{Diagnostic, Span};
use crate::env::*;
use crate::infer::{check_int_range, Infer};
use crate::types::*;

pub const INT_TYPES: &[&str] = &[
    "I8", "I16", "I32", "I64", "I128", "U8", "U16", "U32", "U64", "U128", "ISize", "USize",
];
pub const SIGNED_INT_TYPES: &[&str] = &["I8", "I16", "I32", "I64", "I128", "ISize"];
pub const FLOAT_TYPES: &[&str] = &["F16", "BF16", "F32", "F64", "F128"];

pub const STRUCTURAL: &[&str] = &[
    "std::Eq",
    "std::Ord",
    "std::Hash",
    "std::Display",
    "std::Dup",
    "std::Encode",
    "std::Decode",
];

fn prim_name(t: &Type) -> Option<&str> {
    match t {
        Type::Con(n, args) if args.is_empty() => n.strip_prefix("std::"),
        _ => None,
    }
}

pub fn is_int(t: &Type) -> bool {
    prim_name(t).is_some_and(|n| INT_TYPES.contains(&n))
}

pub fn is_float(t: &Type) -> bool {
    prim_name(t).is_some_and(|n| FLOAT_TYPES.contains(&n))
}

enum Outcome {
    Solved(Vec<Pred>),
    Stuck,
    Fail(String),
}

type IResult<T> = Result<T, Diagnostic>;

impl<'a> Infer<'a> {
    fn zonk_pred(&self, p: &Pred) -> Pred {
        Pred {
            trait_name: p.trait_name.clone(),
            args: p.args.iter().map(|a| self.env.table.zonk(a)).collect(),
        }
    }

    pub(crate) fn show_pred(&self, p: &Pred) -> String {
        let mut pr = Printer::new(&self.env.table);
        let refs: Vec<&Type> = p.args.iter().collect();
        pr.prepare(&refs);
        let args: Vec<String> = p.args.iter().map(|a| pr.show(a)).collect();
        format!("{}[{}]", display_name(&p.trait_name), args.join(", "))
    }

    /// Given predicates closed under superclasses.
    pub(crate) fn given_closure(&self, given: &[Pred]) -> Vec<Pred> {
        let mut out: Vec<Pred> = Vec::new();
        let mut work: Vec<Pred> = given.to_vec();
        while let Some(p) = work.pop() {
            let p = self.zonk_pred(&p);
            if out.contains(&p) {
                continue;
            }
            // conversions from literals entail the literal classes
            let implied: &[&str] = match p.trait_name.as_str() {
                "std::FromFloat" => &["std::FloatLit"],
                "std::FromInt" => &["std::IntLit"],
                "std::Float" => &[
                    "std::FloatLit",
                    "std::IntLit",
                    "std::Numeric",
                    "std::Signed",
                ],
                "std::Integer" => &["std::IntLit", "std::Numeric"],
                "std::Signed" | "std::Numeric" => &["std::IntLit"],
                _ => &[],
            };
            for c in implied {
                work.push(Pred {
                    trait_name: c.to_string(),
                    args: p.args.clone(),
                });
            }
            if let Some(t) = self.env.traits.get(&p.trait_name) {
                let map: HashMap<TV, Type> = t
                    .params
                    .iter()
                    .cloned()
                    .zip(p.args.iter().cloned())
                    .collect();
                for s in &t.supers {
                    work.push(Pred {
                        trait_name: s.trait_name.clone(),
                        args: s.args.iter().map(|a| TypeTable::subst(a, &map)).collect(),
                    });
                }
            }
            out.push(p);
        }
        out
    }

    fn entailed(&self, p: &Pred, given: &[Pred]) -> bool {
        let p = self.zonk_pred(p);
        given.contains(&p)
    }

    fn has_flexible_vars(&self, p: &Pred) -> bool {
        let mut fv = Vec::new();
        for a in &p.args {
            self.env.table.free_vars(a, &mut fv);
        }
        fv.iter().any(|v| !self.env.table.is_rigid(*v))
    }

    fn has_rigid_vars(&self, p: &Pred) -> bool {
        let mut fv = Vec::new();
        for a in &p.args {
            self.env.table.free_vars(a, &mut fv);
        }
        fv.iter().any(|v| self.env.table.is_rigid(*v))
    }

    /// Solve predicates as far as possible; returns the residual ones.
    pub(crate) fn solve(
        &mut self,
        wanted: Vec<(Pred, Span)>,
        given: &[Pred],
    ) -> IResult<Vec<(Pred, Span)>> {
        let mut work = wanted;
        let mut residual: Vec<(Pred, Span)> = Vec::new();
        let mut steps = 0;
        while let Some((p, span)) = work.pop() {
            steps += 1;
            if steps > 100_000 {
                return Err(Diagnostic::error(
                    span,
                    "constraint solving did not terminate (recursive impl contexts?)",
                ));
            }
            let p = self.zonk_pred(&p);
            if self.entailed(&p, given) {
                continue;
            }
            match self.solve_one(&p) {
                Outcome::Solved(subs) => {
                    for s in subs {
                        work.push((s, span));
                    }
                }
                Outcome::Stuck => {
                    if !residual.iter().any(|(q, _)| *q == p) {
                        residual.push((p, span));
                    }
                }
                Outcome::Fail(msg) => return Err(Diagnostic::error(span, msg)),
            }
        }
        Ok(residual)
    }

    fn solve_one(&mut self, p: &Pred) -> Outcome {
        let name = p.trait_name.as_str();
        if STRUCTURAL.contains(&name) {
            return self.structural(name, &p.args[0]);
        }
        let t = self.env.table.resolve(&p.args[0]);
        match name {
            "std::IntLit" => match &t {
                Type::Var(_) => Outcome::Stuck,
                _ if is_int(&t) || is_float(&t) => Outcome::Solved(vec![]),
                Type::Con(..) => Outcome::Solved(vec![Pred {
                    trait_name: "std::FromInt".into(),
                    args: vec![t.clone()],
                }]),
                _ => Outcome::Fail(format!(
                    "an integer literal cannot have type `{}`",
                    self.show(&t)
                )),
            },
            "std::FloatLit" => match &t {
                Type::Var(_) => Outcome::Stuck,
                _ if is_float(&t) => Outcome::Solved(vec![]),
                _ if is_int(&t) => Outcome::Fail(format!(
                    "a float literal cannot have integer type `{}`",
                    self.show(&t)
                )),
                Type::Con(..) => Outcome::Solved(vec![Pred {
                    trait_name: "std::FromFloat".into(),
                    args: vec![t.clone()],
                }]),
                _ => Outcome::Fail(format!(
                    "a float literal cannot have type `{}`",
                    self.show(&t)
                )),
            },
            "std::Integer" | "std::Signed" | "std::Float" | "std::Numeric" => {
                if let Type::Var(_) | Type::App(..) = t {
                    return Outcome::Stuck;
                }
                let ok = match name {
                    "std::Integer" => is_int(&t),
                    "std::Signed" => {
                        prim_name(&t).is_some_and(|n| SIGNED_INT_TYPES.contains(&n)) || is_float(&t)
                    }
                    "std::Float" => is_float(&t),
                    _ => is_int(&t) || is_float(&t),
                };
                if ok {
                    Outcome::Solved(vec![])
                } else {
                    let what = match name {
                        "std::Integer" => "a primitive integer type",
                        "std::Signed" => "a signed primitive numeric type",
                        "std::Float" => "a primitive floating-point type",
                        _ => "a primitive numeric type",
                    };
                    Outcome::Fail(format!("`{}` is not {}", self.show(&t), what))
                }
            }
            _ => self.solve_trait(p),
        }
    }

    fn solve_trait(&mut self, p: &Pred) -> Outcome {
        let mut found = None;
        for (i, imp) in self.env.impls.iter().enumerate() {
            if imp.trait_name != p.trait_name {
                continue;
            }
            let mut subst = HashMap::new();
            let ok = imp
                .head
                .iter()
                .zip(&p.args)
                .all(|(h, a)| match_type(&self.env.table, h, a, &imp.vars, &mut subst));
            if ok {
                found = Some((i, subst));
                break;
            }
        }
        match found {
            Some((i, subst)) => {
                let imp = &self.env.impls[i];
                let subs = imp
                    .context
                    .iter()
                    .map(|c| Pred {
                        trait_name: c.trait_name.clone(),
                        args: c.args.iter().map(|a| TypeTable::subst(a, &subst)).collect(),
                    })
                    .collect();
                Outcome::Solved(subs)
            }
            None => {
                if self.has_flexible_vars(p) {
                    Outcome::Stuck
                } else if self.has_rigid_vars(p) {
                    // Resolved against the signature by the caller.
                    Outcome::Stuck
                } else {
                    Outcome::Fail(format!("no implementation of `{}`", self.show_pred(p)))
                }
            }
        }
    }

    fn structural(&mut self, class: &str, t: &Type) -> Outcome {
        let t = self.env.table.resolve(t);
        let short = display_name(class);
        let fail = |this: &Self, what: &str| {
            Outcome::Fail(format!(
                "values of type `{}` {} (`{}` is required)",
                this.show(&t),
                what,
                short
            ))
        };
        let what = match class {
            "std::Eq" => "cannot be compared for equality",
            "std::Ord" => "cannot be ordered",
            "std::Hash" => "cannot be hashed",
            "std::Display" => "cannot be displayed",
            "std::Encode" => "cannot be encoded",
            "std::Decode" => "cannot be decoded",
            _ => "cannot be duplicated because they are resources",
        };
        match &t {
            Type::Var(_) | Type::App(..) => Outcome::Stuck,
            Type::Fun(..) => {
                if class == "std::Dup" {
                    Outcome::Solved(vec![])
                } else {
                    fail(self, what)
                }
            }
            Type::Nat(_) => Outcome::Solved(vec![]),
            Type::Record(r) => {
                let r = self.env.table.flatten_row(r);
                if r.tail.is_some() {
                    return Outcome::Stuck;
                }
                Outcome::Solved(
                    r.fields
                        .iter()
                        .map(|(_, ft)| Pred {
                            trait_name: class.to_string(),
                            args: vec![ft.clone()],
                        })
                        .collect(),
                )
            }
            Type::Con(n, args) => {
                if !self.eligible(class, n, &mut HashSet::new()) {
                    return fail(self, what);
                }
                let def = &self.env.types[n];
                let used = self.used_params(n);
                let subs = args
                    .iter()
                    .enumerate()
                    .filter(|(i, _)| def.param_kinds.get(*i).copied().unwrap_or(0) == 0)
                    .filter(|(i, _)| used.get(*i).copied().unwrap_or(true))
                    .map(|(_, a)| Pred {
                        trait_name: class.to_string(),
                        args: vec![a.clone()],
                    })
                    .collect();
                Outcome::Solved(subs)
            }
        }
    }

    /// Which parameters of a named type occur in its fields (phantom
    /// parameters, like the size of a vector, do not need structural
    /// classes).
    fn used_params(&self, name: &str) -> Vec<bool> {
        let def = &self.env.types[name];
        let fields: Vec<Type> = match &def.kind {
            TypeDefKind::Opaque | TypeDefKind::Alias { .. } => return vec![true; def.arity],
            TypeDefKind::Record { .. } => self.env.table.records[name]
                .fields
                .iter()
                .map(|(_, t)| t.clone())
                .collect(),
            TypeDefKind::Adt { ctors } => ctors
                .iter()
                .flat_map(|c| self.env.ctors[c].fields.clone())
                .collect(),
        };
        let mut fv = Vec::new();
        for f in &fields {
            self.env.table.free_vars(f, &mut fv);
        }
        def.params.iter().map(|p| fv.contains(p)).collect()
    }

    /// Whether a named type supports a structural class, assuming its type
    /// arguments do.
    fn eligible(&self, class: &str, name: &str, visiting: &mut HashSet<String>) -> bool {
        let Some(def) = self.env.types.get(name) else {
            return false;
        };
        if def.resource {
            return false;
        }
        if !visiting.insert(name.to_string()) {
            return true;
        }
        let fields: Vec<Type> = match &def.kind {
            TypeDefKind::Opaque | TypeDefKind::Alias { .. } => vec![],
            TypeDefKind::Record { .. } => self.env.table.records[name]
                .fields
                .iter()
                .map(|(_, t)| t.clone())
                .collect(),
            TypeDefKind::Adt { ctors } => ctors
                .iter()
                .flat_map(|c| self.env.ctors[c].fields.clone())
                .collect(),
        };
        let ok = fields.iter().all(|f| self.field_ok(class, f, visiting));
        visiting.remove(name);
        ok
    }

    fn field_ok(&self, class: &str, t: &Type, visiting: &mut HashSet<String>) -> bool {
        match t {
            Type::Var(_) | Type::Nat(_) => true,
            Type::App(_, args) => args.iter().all(|a| self.field_ok(class, a, visiting)),
            Type::Fun(..) => class == "std::Dup",
            Type::Record(r) => r
                .fields
                .iter()
                .all(|(_, a)| self.field_ok(class, a, visiting)),
            Type::Con(n, args) => {
                self.eligible(class, n, visiting)
                    && args.iter().all(|a| self.field_ok(class, a, visiting))
            }
        }
    }

    /// Pick default types for ambiguous variables: integer literals become
    /// `I64`, float literals `F64`, and variables constrained only by
    /// structural classes become `()`.
    fn apply_defaults(&mut self, preds: &[(Pred, Span)]) -> IResult<bool> {
        let mut classes: HashMap<TV, Vec<String>> = HashMap::new();
        let mut spans: HashMap<TV, Span> = HashMap::new();
        for (p, span) in preds {
            for a in &p.args {
                if let Type::Var(v) = self.env.table.resolve(a) {
                    if !self.env.table.is_rigid(v) {
                        classes.entry(v).or_default().push(p.trait_name.clone());
                        spans.entry(v).or_insert(*span);
                    }
                }
            }
        }
        let mut vars: Vec<TV> = classes.keys().cloned().collect();
        vars.sort();
        let mut changed = false;
        for v in vars {
            let cs = &classes[&v];
            let has = |n: &str| cs.iter().any(|c| c == n);
            let choice = if has("std::FloatLit") || has("std::Float") {
                Some("std::F64")
            } else if has("std::IntLit")
                || has("std::Integer")
                || has("std::Signed")
                || has("std::Numeric")
            {
                Some("std::I64")
            } else if cs.iter().all(|c| STRUCTURAL.contains(&c.as_str())) {
                None
            } else {
                continue;
            };
            let t = match choice {
                Some(n) => Type::con(n),
                None => Type::unit(),
            };
            self.unify(spans[&v], &Type::Var(v), &t, "defaulted type")?;
            changed = true;
        }
        Ok(changed)
    }

    fn ambiguous(&self, p: &Pred, span: Span) -> Diagnostic {
        Diagnostic::error(
            span,
            format!(
                "ambiguous type: cannot determine which `{}` to use",
                self.show_pred(p)
            ),
        )
        .with_note("add a type signature or a literal suffix to pin the type down")
    }

    /// Solve the constraints of a binding with a signature.
    /// Returns the `Dup` constraints on signature variables that the body
    /// needs: `Dup` is inferred and added to the signature implicitly, so
    /// it is checked wherever the function is used at concrete types.
    pub(crate) fn solve_annotated(
        &mut self,
        wanted: Vec<(Pred, Span)>,
        given: &[Pred],
    ) -> IResult<Vec<Pred>> {
        let given = self.given_closure(given);
        let mut residual = self.solve(wanted, &given)?;
        let mut implicit: Vec<Pred> = Vec::new();
        loop {
            residual.retain(|(p, _)| {
                let rigid_dup = p.trait_name == "std::Dup"
                    && matches!(self.env.table.resolve(&p.args[0]), Type::Var(v) if self.env.table.is_rigid(v));
                if rigid_dup {
                    let z = self.zonk_pred(p);
                    if !implicit.contains(&z) {
                        implicit.push(z);
                    }
                }
                !rigid_dup
            });
            for (p, span) in &residual {
                if self.has_rigid_vars(p) && !self.has_flexible_vars(p) {
                    return Err(Diagnostic::error(
                        *span,
                        format!("missing constraint `{}`", self.show_pred(p)),
                    )
                    .with_note(format!(
                        "add `where {}` to the signature of `{}`",
                        self.show_pred(p),
                        display_name(&self.current)
                    )));
                }
            }
            if residual.is_empty() {
                return Ok(implicit);
            }
            if !self.apply_defaults(&residual)? {
                let (p, span) = &residual[0];
                return Err(self.ambiguous(p, *span));
            }
            residual = self.solve(residual, &given)?;
        }
    }

    /// Solve the constraints of an unannotated binding group, returning the
    /// predicates to quantify over.
    pub(crate) fn solve_group(
        &mut self,
        group: &[usize],
        wanted: Vec<(Pred, Span)>,
    ) -> IResult<Vec<(Pred, Span)>> {
        let mut residual = self.solve(wanted, &[])?;
        loop {
            let mut member_vars: Vec<Vec<TV>> = Vec::new();
            for &i in group {
                let b = &self.env.bindings[i];
                if b.annotated {
                    continue;
                }
                let t = self.env.table.resolve(&self.group[&b.name]);
                if !matches!(t, Type::Fun(..)) {
                    continue; // value bindings are not generalized over constraints
                }
                let mut fv = Vec::new();
                self.env.table.free_vars(&t, &mut fv);
                member_vars.push(fv);
            }
            let mut keep = Vec::new();
            let mut rest = Vec::new();
            for (p, span) in residual {
                let mut pv = Vec::new();
                for a in &p.args {
                    self.env.table.free_vars(a, &mut pv);
                }
                let generalizable = !pv.is_empty()
                    && member_vars
                        .iter()
                        .any(|mv| pv.iter().all(|v| mv.contains(v)));
                if generalizable {
                    keep.push((p, span));
                } else {
                    rest.push((p, span));
                }
            }
            if rest.is_empty() {
                return Ok(keep);
            }
            if !self.apply_defaults(&rest)? {
                let (p, span) = &rest[0];
                if !self.has_flexible_vars(p) {
                    return Err(Diagnostic::error(
                        *span,
                        format!("no implementation of `{}`", self.show_pred(p)),
                    ));
                }
                return Err(self.ambiguous(p, *span));
            }
            let mut again = keep;
            again.extend(rest);
            residual = self.solve(again, &[])?;
        }
    }

    /// Check unsuffixed integer literals against their final types.
    pub(crate) fn check_int_literals(&mut self) -> IResult<()> {
        for (span, t, neg, mag) in std::mem::take(&mut self.int_lits) {
            let t = self.env.table.resolve(&t);
            let name = match prim_name(&t) {
                Some(n) if INT_TYPES.contains(&n) => n.to_string(),
                Some(n) if FLOAT_TYPES.contains(&n) => continue,
                _ => "I64".to_string(),
            };
            if let Err(msg) = check_int_range(&name, neg, mag) {
                return Err(Diagnostic::error(span, msg));
            }
        }
        Ok(())
    }
}
