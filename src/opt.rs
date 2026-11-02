//! IR optimizations: inlining of small functions (combinators, compose,
//! selectors, trait-method wrappers), flattening of nested applications,
//! saturation of known partial applications into direct calls, folding
//! of record projections, and matches on values whose constructor is
//! known (a match on a match whose arms build values is moved into those
//! arms, where the constructor is known). Internal pipes compile to direct
//! calls this way.
//!
//! All transformations preserve evaluation order: arguments that may have
//! effects are bound with `Let` before the inlined body; only pure
//! expressions are substituted.

use crate::ir::*;
use std::collections::HashSet;

mod stages;

const INLINE_SIZE: usize = 40;
const MAX_BODY: usize = 4000;
const ROUNDS: usize = 4;

fn size(e: &Expr) -> usize {
    match e {
        Expr::Trace(_, b)
        | Expr::Dup(_, b)
        | Expr::Drop(_, b)
        | Expr::BorrowGlobal(_, _, b)
        | Expr::ResourceRegion { body: b, .. } => 1 + size(b),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => 1,
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => {
            1 + a.iter().map(size).sum::<usize>()
        }
        Expr::Apply(f, a) => 1 + size(f) + a.iter().map(size).sum::<usize>(),
        Expr::Field(r, _) => 1 + size(r),
        Expr::SetFields(r, s) => 1 + size(r) + s.iter().map(|(_, x)| size(x)).sum::<usize>(),
        Expr::Let(_, v, b) => 1 + size(v) + size(b),
        Expr::Match(s, arms) => 1 + size(s) + arms.iter().map(|(_, b)| 1 + size(b)).sum::<usize>(),
    }
}

pub(crate) fn calls(e: &Expr, id: FuncId) -> bool {
    match e {
        Expr::Trace(_, b)
        | Expr::Dup(_, b)
        | Expr::Drop(_, b)
        | Expr::ResourceRegion { body: b, .. } => calls(b, id),
        Expr::BorrowGlobal(_, global, b) => *global == id || calls(b, id),
        Expr::Local(_) | Expr::Const(_) => false,
        Expr::Func(f) => *f == id,
        Expr::Call(f, a) => *f == id || a.iter().any(|x| calls(x, id)),
        Expr::Construct(_, a) | Expr::Record(a) => a.iter().any(|x| calls(x, id)),
        Expr::Apply(f, a) => calls(f, id) || a.iter().any(|x| calls(x, id)),
        Expr::Field(r, _) => calls(r, id),
        Expr::SetFields(r, s) => calls(r, id) || s.iter().any(|(_, x)| calls(x, id)),
        Expr::Let(_, v, b) => calls(v, id) || calls(b, id),
        Expr::Match(s, arms) => calls(s, id) || arms.iter().any(|(_, b)| calls(b, id)),
    }
}

pub(crate) fn uses(e: &Expr, l: Local) -> usize {
    match e {
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => (parameters.contains(&l) || bindings.contains(&l)) as usize + uses(body, l),
        Expr::Trace(_, b) => uses(b, l),
        Expr::Dup(x, b) | Expr::Drop(x, b) => (*x == l) as usize + uses(b, l),
        Expr::Local(x) => (*x == l) as usize,
        Expr::Const(_) | Expr::Func(_) => 0,
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => {
            a.iter().map(|x| uses(x, l)).sum()
        }
        Expr::Apply(f, a) => uses(f, l) + a.iter().map(|x| uses(x, l)).sum::<usize>(),
        Expr::Field(r, _) => uses(r, l),
        Expr::SetFields(r, s) => uses(r, l) + s.iter().map(|(_, x)| uses(x, l)).sum::<usize>(),
        Expr::Let(_, v, b) => uses(v, l) + uses(b, l),
        Expr::BorrowGlobal(_, _, b) => uses(b, l),
        // a use inside a match arm may run at most once, but counts as a
        // use for duplication purposes
        Expr::Match(s, arms) => uses(s, l) + arms.iter().map(|(_, b)| uses(b, l)).sum::<usize>(),
    }
}

struct Opt<'p> {
    funcs: &'p [Func],
    shapes: &'p Shapes,
    current: FuncId,
    /// The type of each local of the function being optimized.
    locals: Vec<MT>,
    /// Remaining number of IR nodes this function may grow by inlining.
    budget: isize,
    resource_locals: Vec<Local>,
}

impl<'p> Opt<'p> {
    fn arity(&self, id: FuncId) -> usize {
        self.funcs[id].arity as usize
    }

    /// Cheap expressions that can be duplicated without erasing aggregate types.
    fn trivial(&self, e: &Expr) -> bool {
        match e {
            Expr::Local(_) => true,
            // CAF evaluation may allocate or trap and must occur before the
            // callee, even when its argument is unused after inlining.
            Expr::Func(id) => self.arity(*id) > 0,
            Expr::Const(v) => !matches!(
                v,
                crate::value::Value::Data(..)
                    | crate::value::Value::Record(_)
                    | crate::value::Value::Array(_)
                    | crate::value::Value::Map(_)
                    | crate::value::Value::Set(_)
                    | crate::value::Value::Closure(_)
            ),
            _ => false,
        }
    }

    /// Expressions without effects (and that cannot trap): partial
    /// applications of known functions, data built from pure parts.
    fn pure(&self, e: &Expr) -> bool {
        match e {
            Expr::Local(_) | Expr::Const(_) => true,
            Expr::Func(id) => self.arity(*id) > 0,
            Expr::Apply(f, a) => match &**f {
                Expr::Func(id) => a.len() < self.arity(*id) && a.iter().all(|x| self.pure(x)),
                _ => false,
            },
            Expr::Construct(_, a) | Expr::Record(a) => a.iter().all(|x| self.pure(x)),
            _ => false,
        }
    }

    fn fresh(&mut self, ty: &MT) -> Local {
        self.locals.push(ty.clone());
        self.locals.len() as Local - 1
    }

    fn nlocals(&self) -> usize {
        self.locals.len()
    }

    fn expr(&mut self, e: Expr, depth: usize) -> Expr {
        match e {
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => {
                let previous = self.resource_locals.len();
                self.resource_locals
                    .extend(parameters.iter().chain(&bindings));
                let body = Box::new(self.expr(*body, depth));
                self.resource_locals.truncate(previous);
                Expr::ResourceRegion {
                    parameters,
                    bindings,
                    body,
                }
            }
            Expr::Trace(span, body) => Expr::Trace(span, Box::new(self.expr(*body, depth))),
            Expr::Dup(..) | Expr::Drop(..) | Expr::BorrowGlobal(..) => e,
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => e,
            Expr::Call(id, args) => {
                let args: Vec<Expr> = args.into_iter().map(|a| self.expr(a, depth)).collect();
                self.call(id, args, depth)
            }
            Expr::Apply(f, args) => {
                let f = self.expr(*f, depth);
                let args: Vec<Expr> = args.into_iter().map(|a| self.expr(a, depth)).collect();
                self.apply(f, args, depth)
            }
            Expr::Construct(t, a) => {
                Expr::Construct(t, a.into_iter().map(|x| self.expr(x, depth)).collect())
            }
            Expr::Record(a) => Expr::Record(a.into_iter().map(|x| self.expr(x, depth)).collect()),
            Expr::Field(r, i) => {
                // Inlining a record-producing call can leave a bare Record,
                // whose nominal field types the expression does not carry.
                // Keep the checked base type for scalar replacement and RC.
                let base_ty = type_of(
                    &|id: FuncId| &self.funcs[id].ty,
                    self.shapes,
                    &self.locals,
                    &r,
                );
                let r = self.expr(*r, depth);
                if let Some(ty) = base_ty {
                    if type_of(
                        &|id: FuncId| &self.funcs[id].ty,
                        self.shapes,
                        &self.locals,
                        &r,
                    )
                    .is_none()
                    {
                        let l = self.fresh(&ty);
                        return self.expr(
                            Expr::Let(
                                l,
                                Box::new(r),
                                Box::new(Expr::Field(Box::new(Expr::Local(l)), i)),
                            ),
                            depth,
                        );
                    }
                }
                match r {
                    Expr::Record(mut fs) if fs.iter().all(|x| self.pure(x)) => {
                        fs.swap_remove(i as usize)
                    }
                    other => Expr::Field(Box::new(other), i),
                }
            }
            Expr::SetFields(r, s) => Expr::SetFields(
                Box::new(self.expr(*r, depth)),
                s.into_iter()
                    .map(|(i, x)| (i, self.expr(x, depth)))
                    .collect(),
            ),
            Expr::Let(l, v, b) => {
                let v = self.expr(*v, depth);
                if self.resource_locals.contains(&l) || crate::resource::anchored(&b, l) {
                    return Expr::Let(l, Box::new(v), Box::new(self.expr(*b, depth)));
                }
                // An effect followed by an unchanged local (for example tap)
                // needs no alias for its result. Keep the single wildcard
                // match and its scrutinee in place, then use the original local
                // in the continuation. No action is dropped, moved or copied.
                if let Expr::Match(scrutinee, arms) = &v {
                    if let [(Pat::Wild, value @ Expr::Local(_))] = arms.as_slice() {
                        let mut substitutions = vec![None; self.nlocals()];
                        substitutions[l as usize] = Some(value.clone());
                        let continuation = substitute(&b, &substitutions);
                        return self.expr(
                            Expr::Match(scrutinee.clone(), vec![(Pat::Wild, continuation)]),
                            depth,
                        );
                    }
                }
                // `Let(l, v, Match(l, arms))` with `l` used nowhere else
                // and `v` a record or variant built here: matched directly
                // (backends may then avoid building `v`); any other `v`
                // keeps its local, whose type the expression would not tell
                if let Expr::Match(s, arms) = &*b {
                    if matches!(**s, Expr::Local(x) if x == l)
                        && arms.iter().all(|(_, a)| uses(a, l) == 0)
                        && (builds_object(&v) || self.case_of_case(&v, arms))
                    {
                        let ty = self.locals[l as usize].clone();
                        if let Some(out) = self.known_ctor(&v, arms, Some(&ty)) {
                            return self.expr(out, depth);
                        }
                        if let Some(lowered) = self.known_record(&v, arms, Some(&ty)) {
                            return self.expr(lowered, depth);
                        }
                        // A bare constructor/record does not carry its nominal
                        // type. Keep its typed binding when elimination fails.
                        let func = |id: FuncId| &self.funcs[id].ty;
                        if type_of(&func, self.shapes, &self.locals, &v).is_some() {
                            let Expr::Match(_, arms) = *b else {
                                unreachable!()
                            };
                            return self.expr(Expr::Match(Box::new(v), arms), depth);
                        }
                    }
                }
                // A once-used known closure can expose a direct call. Keep
                // eager capture computations at this binding, in their original
                // order, rather than moving them to the closure's later use.
                if matches!(v, Expr::Apply(..)) && uses(&b, l) == 1 {
                    let mut captures = Vec::new();
                    let v = if self.pure(&v) || applied_first(&b, l) {
                        v
                    } else {
                        let count = self.nlocals();
                        let known_partial = matches!(&v, Expr::Apply(f, args)
                            if matches!(&**f, Expr::Func(id) if args.len() < self.arity(*id)));
                        let normalized = if known_partial {
                            bind_captures(
                                &v,
                                None,
                                self.funcs,
                                self.shapes,
                                &mut self.locals,
                                &mut captures,
                            )
                        } else {
                            None
                        };
                        let Some(normalized) = normalized.filter(|e| self.pure(e)) else {
                            // No partial hoist on rejection: an earlier capture
                            // may fail before a later constant is evaluated.
                            self.locals.truncate(count);
                            return Expr::Let(l, Box::new(v), Box::new(self.expr(*b, depth)));
                        };
                        normalized
                    };
                    let mut s: Vec<Option<Expr>> = vec![None; self.nlocals()];
                    s[l as usize] = Some(v);
                    let mut out = self.expr(substitute(&b, &s), depth);
                    for (capture, value) in captures.into_iter().rev() {
                        out = Expr::Let(capture, Box::new(value), Box::new(out));
                    }
                    return out;
                }
                // Propagate cheap aliases, including a capture-free function.
                // Arity-zero Func values evaluate constants and may trap;
                // trivial excludes them so their evaluation stays here.
                if matches!(v, Expr::Local(_) | Expr::Const(_) | Expr::Func(_)) && self.trivial(&v)
                {
                    let mut s: Vec<Option<Expr>> = vec![None; self.nlocals()];
                    s[l as usize] = Some(v);
                    return self.expr(substitute(&b, &s), depth);
                }
                // a record read only field by field: one local per field
                // (scalar replacement), so it is never built
                if let (Expr::Record(es), Some(fts)) =
                    (&v, record_fields(self.shapes, &self.locals[l as usize]))
                {
                    if only_fields(&b, l) && fts.len() == es.len() {
                        let fts: Vec<MT> = fts.iter().map(|(_, t)| t.clone()).collect();
                        let ls: Vec<Local> = fts.iter().map(|t| self.fresh(t)).collect();
                        let b = replace_fields(&b, l, &ls);
                        let mut out = self.expr(b, depth);
                        let Expr::Record(es) = v else { unreachable!() };
                        for (li, e) in ls.into_iter().zip(es).rev() {
                            out = Expr::Let(li, Box::new(e), Box::new(out));
                        }
                        return out;
                    }
                }
                let b = self.expr(*b, depth);
                Expr::Let(l, Box::new(v), Box::new(b))
            }
            Expr::Match(s, arms) => {
                let s = self.expr(*s, depth);
                // a match on a match whose arms build values: the outer
                // match moves into each inner arm (after the locals the
                // scrutinee binds first, which the arms do not see)
                if let Expr::Let(..) = s {
                    if self.case_of_case(&s, &arms) {
                        return self.expr(push_match(s, &arms), depth);
                    }
                }
                if self.case_of_case(&s, &arms) {
                    self.budget -= (size_of_arms(&arms) * arms_of(&s)) as isize;
                    let Expr::Match(is, iarms) = s else {
                        unreachable!()
                    };
                    let iarms = iarms
                        .into_iter()
                        .map(|(p, b)| (p, push_match(b, &arms)))
                        .collect();
                    return self.expr(Expr::Match(is, iarms), depth);
                }
                if let Some(e) = self.known_ctor(&s, &arms, None) {
                    return self.expr(e, depth);
                }
                let arms: Vec<(Pat, Expr)> = arms
                    .into_iter()
                    .map(|(p, b)| (p, self.expr(b, depth)))
                    .collect();
                // An irrefutable local record pattern reads fields; it does
                // not inspect a tag or choose an alternative. Expose those
                // reads to scalar replacement and loop-state unpacking before
                // ownership insertion. Observable resources keep their frame.
                if let (Expr::Local(local), [(Pat::Record(parts), body)]) = (&s, arms.as_slice()) {
                    if parts.iter().all(|p| matches!(p, Pat::Bind(_) | Pat::Wild))
                        && !crate::resource::observable_type(
                            self.funcs,
                            self.shapes,
                            &self.locals[*local as usize],
                        )
                        && record_fields(self.shapes, &self.locals[*local as usize])
                            .is_some_and(|fields| fields.len() == parts.len())
                    {
                        let mut body = body.clone();
                        for (index, pattern) in parts.iter().enumerate().rev() {
                            if let Pat::Bind(bound) = pattern {
                                body = Expr::Let(
                                    *bound,
                                    Box::new(Expr::Field(Box::new(s.clone()), index as u32)),
                                    Box::new(body),
                                );
                            }
                        }
                        return self.expr(body, depth);
                    }
                }
                if let Some(lowered) = self.known_record(&s, &arms, None) {
                    self.expr(lowered, depth)
                } else {
                    Expr::Match(Box::new(s), arms)
                }
            }
        }
    }

    /// Whether a match with `arms` on `s` should move into the arms of `s`:
    /// `s` is a match whose every arm ends in a constructor, and the copies
    /// of `arms` are small.
    fn case_of_case(&self, s: &Expr, arms: &[(Pat, Expr)]) -> bool {
        let mut s = s;
        while let Expr::Let(_, _, b) = s {
            s = b;
        }
        let Expr::Match(_, iarms) = s else {
            return false;
        };
        let extra = size_of_arms(arms) * iarms.len().saturating_sub(1);
        !iarms.is_empty()
            && iarms.iter().all(|(_, b)| ends_in_ctor(b))
            && extra <= INLINE_SIZE
            && (extra as isize) <= self.budget
    }

    /// A match on a constructor applied to arguments: the arm it selects,
    /// with the arguments bound to the arm's names in their order. `None`
    /// when an arm before it could match or not depending on the fields.
    fn known_ctor(&mut self, s: &Expr, arms: &[(Pat, Expr)], ty: Option<&MT>) -> Option<Expr> {
        let Expr::Construct(tag, args) = s else {
            return None;
        };
        let fields = ty.and_then(|t| match self.shapes.get(t) {
            Some(TypeShape::Adt(variants)) => variants.get(*tag as usize).map(|(_, fs)| fs.clone()),
            _ => None,
        });
        let irrefutable = |p: &Pat| matches!(p, Pat::Bind(_) | Pat::Wild);
        for (p, body) in arms {
            match p {
                Pat::Construct(t, _) if t != tag => continue,
                Pat::Construct(_, ps)
                    if ps.len() == 1
                        && args.len() == 1
                        && matches!(&ps[0], Pat::Record(parts) if parts.iter().all(irrefutable)) =>
                {
                    // One immediately destructured payload; every field matches.
                    // Reuse record elimination to preserve field evaluation and
                    // typed owners. Refutable fields must keep later arms.
                    let payload_ty = fields.as_ref().and_then(|fs| fs.first());
                    return self.known_record(
                        &args[0],
                        &[(ps[0].clone(), body.clone())],
                        payload_ty,
                    );
                }
                Pat::Construct(_, ps) if ps.iter().all(irrefutable) && ps.len() == args.len() => {
                    let mut binds = Vec::new();
                    for (i, (sp, a)) in ps.iter().zip(args).enumerate() {
                        match sp {
                            Pat::Bind(x) => binds.push((*x, a.clone())),
                            _ if self.pure(a) => {}
                            _ => {
                                let funcs = self.funcs;
                                let func = |id: FuncId| &funcs[id].ty;
                                let t = type_of(&func, self.shapes, &self.locals, a)
                                    .or_else(|| fields.as_ref()?.get(i).cloned())?;
                                let l = self.fresh(&t);
                                binds.push((l, a.clone()));
                            }
                        }
                    }
                    let mut out = body.clone();
                    for (x, a) in binds.into_iter().rev() {
                        out = Expr::Let(x, Box::new(a), Box::new(out));
                    }
                    return Some(out);
                }
                Pat::Bind(x) => {
                    return Some(Expr::Let(*x, Box::new(s.clone()), Box::new(body.clone())))
                }
                Pat::Wild if self.pure(s) => return Some(body.clone()),
                _ => return None,
            }
        }
        None
    }

    /// Match one field directly instead of constructing a temporary record.
    /// Evaluate every nontrivial field once, in order, before selecting an arm.
    /// The typed binding supplies nominal types that bare aggregates lack.
    fn known_record(&mut self, s: &Expr, arms: &[(Pat, Expr)], ty: Option<&MT>) -> Option<Expr> {
        let Expr::Record(es) = s else {
            return None;
        };
        let n = es.len();
        if arms.is_empty()
            || !arms
                .iter()
                .all(|(p, _)| matches!(p, Pat::Record(ps) if ps.len() == n))
        {
            return None;
        }
        let irrefutable = |p: &Pat| matches!(p, Pat::Bind(_) | Pat::Wild);
        let tested: Vec<usize> = (0..n)
            .filter(|&i| {
                arms.iter()
                    .any(|(p, _)| matches!(p, Pat::Record(ps) if !irrefutable(&ps[i])))
            })
            .collect();
        if tested.len() > 1 {
            return None;
        }
        let fields = ty.and_then(|ty| record_fields(self.shapes, ty));
        let types: Vec<Option<MT>> = es
            .iter()
            .enumerate()
            .map(|(i, e)| {
                fields
                    .and_then(|fs| fs.get(i).map(|(_, t)| t.clone()))
                    .or_else(|| {
                        type_of(
                            &|id: FuncId| &self.funcs[id].ty,
                            self.shapes,
                            &self.locals,
                            e,
                        )
                    })
            })
            .collect();
        if es
            .iter()
            .zip(&types)
            .any(|(e, ty)| !self.trivial(e) && ty.is_none())
        {
            return None;
        }
        let mut bindings = Vec::new();
        let values: Vec<Expr> = es
            .iter()
            .zip(types)
            .map(|(e, ty)| {
                if self.trivial(e) {
                    e.clone()
                } else {
                    let l = self.fresh(&ty.unwrap());
                    bindings.push((l, e.clone()));
                    Expr::Local(l)
                }
            })
            .collect();
        let mut out = Vec::new();
        for (p, body) in arms {
            let Pat::Record(ps) = p else { unreachable!() };
            let mut body = body.clone();
            let mut test = Pat::Wild;
            for (i, pi) in ps.iter().enumerate().rev() {
                match pi {
                    Pat::Bind(l) if !tested.contains(&i) => {
                        body = Expr::Let(*l, Box::new(values[i].clone()), Box::new(body));
                    }
                    pi if tested.contains(&i) => test = pi.clone(),
                    _ => {}
                }
            }
            out.push((test, body));
        }
        let mut result = match tested.first() {
            Some(&k) => Expr::Match(Box::new(values[k].clone()), out),
            None => out.swap_remove(0).1,
        };
        for (l, value) in bindings.into_iter().rev() {
            result = Expr::Let(l, Box::new(value), Box::new(result));
        }
        Some(result)
    }

    fn apply(&mut self, f: Expr, args: Vec<Expr>, depth: usize) -> Expr {
        if args.is_empty() {
            return f;
        }
        match f {
            // Only an unsaturated known entry can combine argument groups.
            // An unknown first application may run or trap before the next
            // argument is evaluated, even when its result is another function.
            Expr::Apply(g, mut a1) if matches!(&*g, Expr::Func(id) if a1.len() < self.arity(*id)) =>
            {
                a1.extend(args);
                self.apply(*g, a1, depth)
            }
            // Applying a function returned through a pure binding keeps that
            // binding first, then exposes the call in its body. Do not extend
            // resource lifetimes or move an application into a resource frame.
            Expr::Let(l, v, b)
                if self.pure(&v)
                    && !self.resource_locals.contains(&l)
                    && !crate::resource::anchored(&b, l)
                    && !crate::resource::may_hold_resource(
                        self.shapes,
                        &self.locals[l as usize],
                    ) =>
            {
                let body = self.apply(*b, args, depth);
                self.expr(Expr::Let(l, v, Box::new(body)), depth)
            }
            Expr::Func(id) if self.arity(id) > 0 => {
                let ar = self.arity(id);
                if args.len() < ar {
                    return Expr::Apply(Box::new(Expr::Func(id)), args);
                }
                let mut args = args;
                let rest = args.split_off(ar);
                let call = self.call(id, args, depth);
                if rest.is_empty() {
                    call
                } else {
                    self.apply(call, rest, depth)
                }
            }
            other => Expr::Apply(Box::new(other), args),
        }
    }

    fn call(&mut self, id: FuncId, args: Vec<Expr>, depth: usize) -> Expr {
        let callee = &self.funcs[id];
        // A small literal F64 splat is a constant value, including the exact
        // NaN/signed-zero bits. Charge its lanes to the ordinary inlining budget
        // so a large vector remains a runtime construction.
        if matches!(&callee.body, Body::Prim(symbol) if symbol == "simd.splat") {
            if let ([Expr::Const(value @ crate::value::Value::F64(_))], MT::Con(name, types)) =
                (args.as_slice(), callee.ty.after_args(1))
            {
                if let [MT::Nat(lanes), element] = types.as_slice() {
                    if name == "std::Vec"
                        && element == &MT::con("std::F64")
                        && *lanes <= INLINE_SIZE as u64
                        && *lanes <= self.budget.max(0) as u64
                    {
                        self.budget -= *lanes as isize;
                        return Expr::Const(crate::value::Value::Record(
                            vec![crate::value::Value::Array(std::rc::Rc::new(vec![
                                value.clone();
                                *lanes as usize
                            ]))]
                            .into(),
                        ));
                    }
                }
            }
        }
        // Top-level display of a string preserves its bytes. Eliminate the
        // copy before ownership lowering so aliases receive ordinary owners.
        // Strings nested inside other displayed values still need escaping.
        if matches!(&callee.body, Body::Prim(symbol) if symbol == "show")
            && args.len() == 1
            && callee.ty.params(1).0[0] == &MT::con("std::String")
        {
            return args.into_iter().next().unwrap();
        }
        if let Body::Ctor(tag) = callee.body {
            return Expr::Construct(tag, args);
        }
        let Body::Expr(body) = &callee.body else {
            return Expr::Call(id, args);
        };
        let body_size = size(body);
        if id == self.current
            || depth > 8
            || body_size > INLINE_SIZE
            || self.budget < body_size as isize
            || calls(body, id)
            || args.len() != callee.arity as usize
            // iterator stages stay calls, so that `iter.to-list` over them
            // can be fused (src/fuse.rs); inlining one level gains nothing
            || callee.name.starts_with("iter.")
        {
            return Expr::Call(id, args);
        }
        self.budget -= body_size as isize;
        let mut body = body.clone();
        let safe = args
            .iter()
            .enumerate()
            .filter_map(|(i, arg)| {
                crate::resource::unobservable_value(
                    self.funcs,
                    self.shapes,
                    &self.locals,
                    arg,
                    Some(&callee.locals[i]),
                )
                .then_some(i as Local)
            })
            .collect::<HashSet<_>>();
        crate::resource::remove_anchors(&mut body, &safe);
        let arity = callee.arity;
        let types = &callee.locals;
        // map callee locals to caller expressions/locals
        let mut lets = Vec::new();
        let mut subst: Vec<Option<Expr>> = vec![None; types.len()];
        for (i, a) in args.into_iter().enumerate() {
            let n = uses(&body, i as u32);
            let anchored = crate::resource::anchored(&body, i as Local);
            // An aggregate carries its field/variant types through the callee
            // parameter. Preserve that existing typed local when substituting
            // the value would erase the context needed for child ownership.
            // Compile-time aggregates need that context too; their stored value
            // does not encode its nominal record/variant or closure type.
            if !anchored
                && !builds_object(&a)
                && (self.trivial(&a) || (!matches!(&a, Expr::Const(_)) && n <= 1 && self.pure(&a)))
            {
                subst[i] = Some(a);
            } else {
                let l = self.fresh(&types[i]);
                lets.push((l, a));
                subst[i] = Some(Expr::Local(l));
            }
        }
        let mut renamed = Vec::new();
        for (slot, ty) in subst.iter_mut().zip(types).skip(arity as usize) {
            let l = self.fresh(ty);
            renamed.push(l);
            *slot = Some(Expr::Local(l));
        }
        let mut out = substitute(&body, &subst);
        for (l, v) in lets.into_iter().rev() {
            out = Expr::Let(l, Box::new(v), Box::new(out));
        }
        self.expr(out, depth + 1)
    }
}

/// Whether `e` gives a constructor applied to arguments (after the locals
/// it binds).
fn ends_in_ctor(e: &Expr) -> bool {
    match e {
        Expr::Let(_, _, b) => ends_in_ctor(b),
        Expr::Construct(..) => true,
        _ => false,
    }
}

/// `match e { arms }`, with the match after the locals `e` binds.
fn push_match(e: Expr, arms: &[(Pat, Expr)]) -> Expr {
    match e {
        Expr::Let(x, v, b) => Expr::Let(x, v, Box::new(push_match(*b, arms))),
        e => Expr::Match(Box::new(e), arms.to_vec()),
    }
}

fn size_of_arms(arms: &[(Pat, Expr)]) -> usize {
    arms.iter().map(|(_, b)| 1 + size(b)).sum()
}

fn arms_of(e: &Expr) -> usize {
    match e {
        Expr::Match(_, arms) => arms.len().saturating_sub(1),
        _ => 0,
    }
}

/// Whether `e` gives a record or variant it builds itself (after the
/// locals it binds).
fn builds_object(e: &Expr) -> bool {
    match e {
        Expr::Let(_, _, b) => builds_object(b),
        Expr::Record(_) | Expr::Construct(..) => true,
        _ => false,
    }
}

pub(crate) fn only_fields(e: &Expr, l: Local) -> bool {
    match e {
        // (a reference count change of a record kept as its fields applies
        // to the fields)
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => !parameters.contains(&l) && !bindings.contains(&l) && only_fields(body, l),
        Expr::Trace(_, b) | Expr::Dup(_, b) | Expr::Drop(_, b) | Expr::BorrowGlobal(_, _, b) => {
            only_fields(b, l)
        }
        Expr::Local(x) => *x != l,
        Expr::Field(r, _) if matches!(**r, Expr::Local(x) if x == l) => true,
        Expr::Const(_) | Expr::Func(_) => true,
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => {
            a.iter().all(|x| only_fields(x, l))
        }
        Expr::Apply(f, a) => only_fields(f, l) && a.iter().all(|x| only_fields(x, l)),
        Expr::Field(r, _) => only_fields(r, l),
        Expr::SetFields(r, s) => only_fields(r, l) && s.iter().all(|(_, x)| only_fields(x, l)),
        Expr::Let(_, v, b) => only_fields(v, l) && only_fields(b, l),
        Expr::Match(sc, arms) => only_fields(sc, l) && arms.iter().all(|(_, b)| only_fields(b, l)),
    }
}

/// `e` with each `Field(Local(l), i)` replaced by `Local(ls[i])`.
fn replace_fields(e: &Expr, l: Local, ls: &[Local]) -> Expr {
    let r = |x: &Expr| replace_fields(x, l, ls);
    match e {
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => Expr::ResourceRegion {
            parameters: parameters.clone(),
            bindings: bindings.clone(),
            body: Box::new(r(body)),
        },
        Expr::Trace(span, b) => Expr::Trace(span.clone(), Box::new(r(b))),
        Expr::Dup(x, b) => Expr::Dup(*x, Box::new(r(b))),
        Expr::Drop(x, b) => Expr::Drop(*x, Box::new(r(b))),
        Expr::BorrowGlobal(x, global, b) => Expr::BorrowGlobal(*x, *global, Box::new(r(b))),
        Expr::Field(b, i) if matches!(**b, Expr::Local(x) if x == l) => {
            Expr::Local(ls[*i as usize])
        }
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => e.clone(),
        Expr::Call(f, a) => Expr::Call(*f, a.iter().map(r).collect()),
        Expr::Construct(t, a) => Expr::Construct(*t, a.iter().map(r).collect()),
        Expr::Record(a) => Expr::Record(a.iter().map(r).collect()),
        Expr::Apply(f, a) => Expr::Apply(Box::new(r(f)), a.iter().map(r).collect()),
        Expr::Field(b, i) => Expr::Field(Box::new(r(b)), *i),
        Expr::SetFields(b, s) => {
            Expr::SetFields(Box::new(r(b)), s.iter().map(|(i, x)| (*i, r(x))).collect())
        }
        Expr::Let(x, v, b) => Expr::Let(*x, Box::new(r(v)), Box::new(r(b))),
        Expr::Match(sc, arms) => Expr::Match(
            Box::new(r(sc)),
            arms.iter().map(|(p, b)| (p.clone(), r(b))).collect(),
        ),
    }
}

/// Whether the first thing `e` evaluates is local `l` applied to locals
/// and constants, so a value bound to `l` can be computed there instead.
fn applied_first(e: &Expr, l: Local) -> bool {
    match e {
        Expr::Let(_, v, _) => applied_first(v, l),
        Expr::Apply(f, a) => {
            matches!(**f, Expr::Local(x) if x == l)
                && a.iter()
                    .all(|x| matches!(x, Expr::Local(y) if *y != l) || matches!(x, Expr::Const(_)))
        }
        _ => false,
    }
}

/// Replace callee locals: in expressions with the mapped expressions, in
/// binding positions (let, patterns) with the mapped locals.
pub(crate) fn substitute(e: &Expr, s: &[Option<Expr>]) -> Expr {
    let local = |l: &Local| match &s[*l as usize] {
        Some(Expr::Local(x)) => *x,
        _ => *l,
    };
    match e {
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => Expr::ResourceRegion {
            parameters: parameters.iter().map(local).collect(),
            bindings: bindings.iter().map(local).collect(),
            body: Box::new(substitute(body, s)),
        },
        Expr::Trace(span, b) => Expr::Trace(span.clone(), Box::new(substitute(b, s))),
        Expr::Dup(x, b) => Expr::Dup(local(x), Box::new(substitute(b, s))),
        Expr::Drop(x, b) => Expr::Drop(local(x), Box::new(substitute(b, s))),
        Expr::BorrowGlobal(x, global, b) => {
            Expr::BorrowGlobal(local(x), *global, Box::new(substitute(b, s)))
        }
        Expr::Local(l) => s[*l as usize].clone().unwrap_or(Expr::Local(*l)),
        Expr::Const(_) | Expr::Func(_) => e.clone(),
        Expr::Call(f, a) => Expr::Call(*f, a.iter().map(|x| substitute(x, s)).collect()),
        Expr::Apply(f, a) => Expr::Apply(
            Box::new(substitute(f, s)),
            a.iter().map(|x| substitute(x, s)).collect(),
        ),
        Expr::Construct(t, a) => Expr::Construct(*t, a.iter().map(|x| substitute(x, s)).collect()),
        Expr::Record(a) => Expr::Record(a.iter().map(|x| substitute(x, s)).collect()),
        Expr::Field(r, i) => Expr::Field(Box::new(substitute(r, s)), *i),
        Expr::SetFields(r, f) => Expr::SetFields(
            Box::new(substitute(r, s)),
            f.iter().map(|(i, x)| (*i, substitute(x, s))).collect(),
        ),
        Expr::Let(l, v, b) => Expr::Let(
            local(l),
            Box::new(substitute(v, s)),
            Box::new(substitute(b, s)),
        ),
        Expr::Match(sc, arms) => Expr::Match(
            Box::new(substitute(sc, s)),
            arms.iter()
                .map(|(p, b)| (subst_pat(p, &local), substitute(b, s)))
                .collect(),
        ),
    }
}

fn subst_pat(p: &Pat, local: &dyn Fn(&Local) -> Local) -> Pat {
    match p {
        Pat::Bind(l) => Pat::Bind(local(l)),
        Pat::Construct(t, ps) => {
            Pat::Construct(*t, ps.iter().map(|q| subst_pat(q, local)).collect())
        }
        Pat::Record(ps) => Pat::Record(ps.iter().map(|q| subst_pat(q, local)).collect()),
        other => other.clone(),
    }
}

/// Optimize all function bodies in place.
pub fn optimize(prog: &mut Program) {
    stages::flatten(prog);
    for _ in 0..ROUNDS {
        let snapshot = prog.funcs.clone();
        for id in 0..prog.funcs.len() {
            let Body::Expr(body) = &prog.funcs[id].body else {
                continue;
            };
            if size(body) > MAX_BODY {
                continue;
            }
            let mut o = Opt {
                funcs: &snapshot,
                shapes: &prog.shapes,
                current: id,
                locals: prog.funcs[id].locals.clone(),
                budget: 600,
                resource_locals: Vec::new(),
            };
            let mut body = body.clone();
            let mut safe = HashSet::new();
            crate::resource::unobservable_bindings(
                &body,
                &snapshot,
                &prog.shapes,
                &o.locals,
                &mut safe,
            );
            crate::resource::remove_anchors(&mut body, &safe);
            let new = o.expr(body, 0);
            let f = &mut prog.funcs[id];
            f.body = Body::Expr(new);
            f.locals = o.locals;
        }
    }
}

/// Optimize an expression of a new function whose locals have the types
/// `locals` (as every function's): returns it and the function's locals.
pub(crate) fn simplify(
    funcs: &[Func],
    shapes: &Shapes,
    body: Expr,
    locals: Vec<MT>,
) -> (Expr, Vec<MT>) {
    let mut o = Opt {
        funcs,
        shapes,
        current: usize::MAX,
        locals,
        budget: 600,
        resource_locals: Vec::new(),
    };
    let mut body = body;
    for _ in 0..ROUNDS {
        let mut safe = HashSet::new();
        crate::resource::unobservable_bindings(&body, funcs, shapes, &o.locals, &mut safe);
        crate::resource::remove_anchors(&mut body, &safe);
        body = o.expr(body, 0);
    }
    (body, o.locals)
}

/// The number of arguments a higher-order primitive applies its function
/// argument to, for those that `specialize_hofs` handles.
pub fn hof_arity(sym: &str) -> Option<usize> {
    match sym {
        "map" | "filter" | "find" | "take-while" | "drop-while" | "loop" | "modify" | "sort-by" => {
            Some(1)
        }
        "fold" | "fold-right" | "zip-with" => Some(2),
        _ => None,
    }
}

/// The locals an expression reads, in order of first use.
fn free_locals(e: &Expr, out: &mut Vec<Local>) {
    match e {
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => {
            for l in parameters.iter().chain(bindings) {
                if !out.contains(l) {
                    out.push(*l);
                }
            }
            free_locals(body, out);
        }
        Expr::Trace(_, b) => free_locals(b, out),
        Expr::Dup(l, b) | Expr::Drop(l, b) => {
            if !out.contains(l) {
                out.push(*l)
            }
            free_locals(b, out)
        }
        Expr::Local(l) => {
            if !out.contains(l) {
                out.push(*l)
            }
        }
        Expr::Const(_) | Expr::Func(_) => {}
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => {
            a.iter().for_each(|x| free_locals(x, out))
        }
        Expr::Apply(f, a) => {
            free_locals(f, out);
            a.iter().for_each(|x| free_locals(x, out));
        }
        Expr::Field(r, _) => free_locals(r, out),
        // closures built from pure parts have none of these
        Expr::SetFields(..) | Expr::Let(..) | Expr::BorrowGlobal(..) | Expr::Match(..) => {}
    }
}

/// Specialize the function arguments of higher-order primitives (`map`,
/// `filter`, `fold`, ...) that are closures built from known functions,
/// such as `map (mul 3)` or `filter (rem 2 | eq 0)`: each becomes a new
/// function `h(c1, ..., ck, x)` of the locals it captures and the
/// element(s), whose body is the closure applied and optimized (so `compose`
/// and the partial applications become direct calls), and the primitive is
/// given `h` partially applied to the captured locals (or `h` itself when it
/// captures none). Native code then calls `h` directly for every element
/// (`known_hof` in src/cgen.rs). Both backends run the result, so they stay
/// in step, safe points included.
pub fn specialize_hofs(prog: &mut Program) {
    let snapshot = prog.funcs.clone();
    let shapes = prog.shapes.clone();
    let mut made: Vec<Func> = Vec::new();
    let mut seen: Vec<(String, FuncId)> = Vec::new();
    let base = prog.funcs.len();
    for id in 0..base {
        let Body::Expr(body) = &prog.funcs[id].body else {
            continue;
        };
        if size(body) > MAX_BODY {
            continue;
        }
        let mut body = body.clone();
        let mut locals = snapshot[id].locals.clone();
        rewrite_hofs(
            &mut body,
            &snapshot,
            &shapes,
            &mut locals,
            base,
            &mut made,
            &mut seen,
        );
        prog.funcs[id].body = Body::Expr(body);
        prog.funcs[id].locals = locals;
    }
    prog.funcs.extend(made);
}

/// Bind eager captured computations in their original left-to-right order.
/// Only descend through known partial applications: entering an arbitrary call
/// would move its arguments across that call's own effects. Resource-bearing
/// results keep their original frame rather than gaining a new binding here.
fn bind_captures(
    e: &Expr,
    expected: Option<&MT>,
    funcs: &[Func],
    shapes: &Shapes,
    locals: &mut Vec<MT>,
    bindings: &mut Vec<(Local, Expr)>,
) -> Option<Expr> {
    match e {
        Expr::Local(_) => Some(e.clone()),
        Expr::Const(v)
            if !matches!(
                v,
                crate::value::Value::Data(..)
                    | crate::value::Value::Record(_)
                    | crate::value::Value::Array(_)
                    | crate::value::Value::Map(_)
                    | crate::value::Value::Set(_)
                    | crate::value::Value::Closure(_)
            ) =>
        {
            Some(e.clone())
        }
        Expr::Func(id) if funcs.get(*id)?.arity > 0 => Some(e.clone()),
        Expr::Apply(f, args) => {
            if let Expr::Func(id) = &**f {
                if args.len() < funcs.get(*id)?.arity as usize {
                    let parameters = funcs[*id].ty.params(args.len()).0;
                    let captures = args
                        .iter()
                        .zip(parameters)
                        .map(|(a, ty)| bind_captures(a, Some(ty), funcs, shapes, locals, bindings))
                        .collect::<Option<Vec<_>>>()?;
                    return Some(Expr::Apply(f.clone(), captures));
                }
            }
            bind_capture_value(e, expected, funcs, shapes, locals, bindings)
        }
        _ => bind_capture_value(e, expected, funcs, shapes, locals, bindings),
    }
}

fn bind_capture_value(
    e: &Expr,
    expected: Option<&MT>,
    funcs: &[Func],
    shapes: &Shapes,
    locals: &mut Vec<MT>,
    bindings: &mut Vec<(Local, Expr)>,
) -> Option<Expr> {
    // The partial application's checked parameter type also covers literal
    // and constructor results whose IR expression carries no nominal type.
    let ty = expected
        .cloned()
        .or_else(|| type_of(&|id: FuncId| &funcs[id].ty, shapes, locals, e))?;
    if crate::resource::observable_type(funcs, shapes, &ty) {
        return None;
    }
    let local = locals.len() as Local;
    locals.push(ty);
    bindings.push((local, e.clone()));
    Some(Expr::Local(local))
}

fn rewrite_hofs(
    e: &mut Expr,
    funcs: &[Func],
    shapes: &Shapes,
    locals: &mut Vec<MT>,
    base: usize,
    made: &mut Vec<Func>,
    seen: &mut Vec<(String, FuncId)>,
) {
    // children first
    match e {
        Expr::Trace(_, b)
        | Expr::Dup(_, b)
        | Expr::Drop(_, b)
        | Expr::BorrowGlobal(_, _, b)
        | Expr::ResourceRegion { body: b, .. } => {
            rewrite_hofs(b, funcs, shapes, locals, base, made, seen)
        }
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => a
            .iter_mut()
            .for_each(|x| rewrite_hofs(x, funcs, shapes, locals, base, made, seen)),
        Expr::Apply(f, a) => {
            rewrite_hofs(f, funcs, shapes, locals, base, made, seen);
            a.iter_mut()
                .for_each(|x| rewrite_hofs(x, funcs, shapes, locals, base, made, seen));
        }
        Expr::Field(r, _) => rewrite_hofs(r, funcs, shapes, locals, base, made, seen),
        Expr::SetFields(r, s) => {
            rewrite_hofs(r, funcs, shapes, locals, base, made, seen);
            s.iter_mut()
                .for_each(|(_, x)| rewrite_hofs(x, funcs, shapes, locals, base, made, seen));
        }
        Expr::Let(_, v, b) => {
            rewrite_hofs(v, funcs, shapes, locals, base, made, seen);
            rewrite_hofs(b, funcs, shapes, locals, base, made, seen);
        }
        Expr::Match(s, arms) => {
            rewrite_hofs(s, funcs, shapes, locals, base, made, seen);
            arms.iter_mut()
                .for_each(|(_, b)| rewrite_hofs(b, funcs, shapes, locals, base, made, seen));
        }
    }
    let Expr::Call(prim, args) = e else { return };
    let Some(prim_f) = funcs.get(*prim) else {
        return;
    };
    let Body::Prim(sym) = &prim_f.body else {
        return;
    };
    // Synchronous handlers call their callback once. Specializing its known
    // body avoids rebuilding nested partial applications on every invocation.
    let (callback, n) = match sym.as_str() {
        "run-state" | "grpc.with-tls" | "grpc.with-metadata" | "grpc.with-deadline" => (1, 1),
        "attempt" | "grpc.with-gzip" | "grpc.with-response-metadata" => (0, 1),
        _ => {
            let Some(n) = hof_arity(sym) else { return };
            (0, n)
        }
    };
    let Some(fexpr) = args.get(callback) else {
        return;
    };
    let o = Opt {
        funcs,
        shapes,
        current: usize::MAX,
        locals: vec![],
        budget: 0,
        resource_locals: Vec::new(),
    };
    match fexpr {
        Expr::Apply(function, captures) => {
            let Expr::Func(id) = &**function else { return };
            if captures.len() >= funcs.get(*id).map_or(0, |f| f.arity as usize) {
                return;
            }
        }
        Expr::Func(id) => {
            let function = &funcs[*id];
            // A curried named callback can return a known partial function.
            // Expose both argument stages to the existing specializer, which
            // preserves resource frames and eager capture evaluation. Already
            // saturated entries and unknown returned functions need no wrapper.
            if function.arity == 0 || function.arity as usize >= n {
                return;
            }
            let Body::Expr(Expr::Apply(returned, captures)) = &function.body else {
                return;
            };
            let Expr::Func(returned) = &**returned else {
                return;
            };
            if funcs[*returned].arity as usize != captures.len() + n - function.arity as usize {
                return;
            }
        }
        _ => return,
    }
    let mut bindings = Vec::new();
    // Bind aggregate captures once, including pure constructions. Otherwise
    // specialization would reconstruct a captured list on every loop element.
    // Captures cannot cross an earlier computation or resource lifetime.
    let count = locals.len();
    let Some(normalized) = bind_captures(fexpr, None, funcs, shapes, locals, &mut bindings) else {
        locals.truncate(count);
        return;
    };
    if !o.pure(&normalized)
        || (!bindings.is_empty() && args[..callback].iter().any(|arg| !o.trivial(arg)))
    {
        locals.truncate(count);
        return;
    }
    let fexpr = &normalized;
    let mut caps = Vec::new();
    free_locals(fexpr, &mut caps);
    let k = caps.len();
    // the closure over its captures, numbered from 0
    let renamed = rename_locals(fexpr, &caps);
    // the closure's function type, after its captures' types
    let fn_ty = prim_f.ty.params(prim_f.arity as usize).0[callback].clone();
    let cap_tys: Vec<MT> = caps.iter().map(|l| locals[*l as usize].clone()).collect();
    let key = format!("{:?}|{}|{:?}", renamed, n, cap_tys);
    let h = match seen.iter().find(|(s, _)| *s == key) {
        Some((_, h)) => *h,
        None => {
            let params: Vec<Expr> = (k..k + n).map(|i| Expr::Local(i as Local)).collect();
            let ty = cap_tys.iter().rev().fold(fn_ty.clone(), |t, c| {
                MT::Fun(Box::new(c.clone()), Box::new(t))
            });
            let mut o = Opt {
                funcs,
                shapes,
                current: usize::MAX,
                locals: ty.params(k + n).0.into_iter().cloned().collect(),
                budget: 600,
                resource_locals: Vec::new(),
            };
            let mut body = Expr::Apply(Box::new(renamed), params);
            for _ in 0..ROUNDS {
                body = o.expr(body, 0);
            }
            let h = base + made.len();
            // Reserve the identity before descending, so a repeated callback
            // shares this specialization instead of expanding recursively.
            made.push(Func {
                name: format!("{}-fn", sym),
                arity: (k + n) as u32,
                locals: Vec::new(),
                ty,
                body: Body::Expr(Expr::Const(crate::value::Value::unit())),
            });
            seen.push((key, h));
            // Inlining a state callback can expose another known callback,
            // such as fold inside each. Specialize it before native lowering
            // chooses direct calls or runtime function dispatch for the loop.
            rewrite_hofs(&mut body, funcs, shapes, &mut o.locals, base, made, seen);
            made[h - base].locals = o.locals;
            made[h - base].body = Body::Expr(body);
            h
        }
    };
    args[callback] = if k == 0 {
        Expr::Func(h)
    } else {
        Expr::Apply(
            Box::new(Expr::Func(h)),
            caps.iter().map(|l| Expr::Local(*l)).collect(),
        )
    };
    for (local, value) in bindings.into_iter().rev() {
        let body = std::mem::replace(e, Expr::Const(crate::value::Value::unit()));
        *e = Expr::Let(local, Box::new(value), Box::new(body));
    }
}

/// An expression whose locals `caps[i]` become local `i`.
fn rename_locals(e: &Expr, caps: &[Local]) -> Expr {
    let mut s: Vec<Option<Expr>> = Vec::new();
    for (i, l) in caps.iter().enumerate() {
        let l = *l as usize;
        if s.len() <= l {
            s.resize(l + 1, None);
        }
        s[l] = Some(Expr::Local(i as Local));
    }
    let max = {
        let mut all = Vec::new();
        free_locals(e, &mut all);
        all.into_iter().max().map_or(0, |m| m as usize + 1)
    };
    if s.len() < max {
        s.resize(max, None);
    }
    substitute(e, &s)
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn literal_splats_preserve_bits_and_respect_the_size_budget() {
        for lanes in [0, 4, INLINE_SIZE as u64, INLINE_SIZE as u64 + 1] {
            for bits in [0, 1_u64 << 63, 0x7ff8_0000_0000_0042, 0x3fe0_0000_0000_0000] {
                let number = MT::con("std::F64");
                let funcs = vec![Func {
                    name: "splat".into(),
                    arity: 1,
                    ty: MT::Fun(
                        Box::new(number.clone()),
                        Box::new(MT::Con(
                            "std::Vec".into(),
                            vec![MT::Nat(lanes), number.clone()],
                        )),
                    ),
                    locals: vec![number],
                    body: Body::Prim("simd.splat".into()),
                }];
                let call = Expr::Call(
                    0,
                    vec![Expr::Const(crate::value::Value::F64(f64::from_bits(bits)))],
                );
                let (result, _) = simplify(&funcs, &Shapes::default(), call, vec![]);
                if lanes > INLINE_SIZE as u64 {
                    assert!(matches!(result, Expr::Call(0, _)));
                    continue;
                }
                let Expr::Const(crate::value::Value::Record(fields)) = &result else {
                    panic!("splat not folded")
                };
                let [crate::value::Value::Array(values)] = fields.as_ref() else {
                    panic!("invalid vector")
                };
                assert_eq!(values.len(), lanes as usize);
                assert!(values.iter().all(|value| matches!(value, crate::value::Value::F64(value) if value.to_bits() == bits)));
            }
        }
    }

    #[test]
    fn computed_capture_stays_before_the_continuation_and_exposes_a_direct_call() {
        let integer = MT::con("std::I64");
        let unary = MT::Fun(Box::new(integer.clone()), Box::new(integer.clone()));
        let funcs = vec![
            Func {
                name: "add".into(),
                arity: 2,
                ty: MT::Fun(Box::new(integer.clone()), Box::new(unary.clone())),
                locals: vec![integer.clone(), integer.clone()],
                body: Body::Prim("prim.add".into()),
            },
            Func {
                name: "abs".into(),
                arity: 1,
                ty: unary.clone(),
                locals: vec![integer.clone()],
                body: Body::Prim("prim.abs".into()),
            },
        ];
        let shapes = Shapes::default();
        let mut opt = Opt {
            funcs: &funcs,
            shapes: &shapes,
            current: usize::MAX,
            locals: vec![integer.clone(), unary, integer],
            budget: 600,
            resource_locals: vec![],
        };
        let expression = Expr::Let(
            1,
            Box::new(Expr::Apply(
                Box::new(Expr::Func(0)),
                vec![Expr::Call(1, vec![Expr::Local(0)])],
            )),
            Box::new(Expr::Let(
                2,
                Box::new(Expr::Call(1, vec![Expr::Local(0)])),
                Box::new(Expr::Apply(Box::new(Expr::Local(1)), vec![Expr::Local(0)])),
            )),
        );
        let result = opt.expr(expression, 0);
        let Expr::Let(capture, first, continuation) = result else {
            panic!("the capture must still be evaluated before the continuation");
        };
        assert_eq!(capture, 3);
        assert!(
            matches!(*first, Expr::Call(1, ref args) if matches!(args.as_slice(), [Expr::Local(0)]))
        );
        let Expr::Let(2, second, call) = *continuation else {
            panic!("the intervening computation must keep its original position");
        };
        assert!(matches!(*second, Expr::Call(1, _)));
        assert!(matches!(*call, Expr::Call(0, ref args)
            if matches!(args.as_slice(), [Expr::Local(3), Expr::Local(0)])));
    }

    #[test]
    fn unknown_and_saturated_function_producers_keep_their_binding() {
        let integer = MT::con("std::I64");
        let unary = MT::Fun(Box::new(integer.clone()), Box::new(integer.clone()));
        let factory = MT::Fun(Box::new(integer.clone()), Box::new(unary.clone()));
        let funcs = vec![
            Func {
                name: "factory".into(),
                arity: 1,
                ty: factory.clone(),
                locals: vec![integer.clone()],
                body: Body::Prim("test.factory".into()),
            },
            Func {
                name: "compute".into(),
                arity: 1,
                ty: unary.clone(),
                locals: vec![integer.clone()],
                body: Body::Prim("prim.abs".into()),
            },
        ];
        let shapes = Shapes::default();
        for known in [false, true] {
            let mut opt = Opt {
                funcs: &funcs,
                shapes: &shapes,
                current: usize::MAX,
                locals: vec![
                    factory.clone(),
                    integer.clone(),
                    unary.clone(),
                    integer.clone(),
                ],
                budget: 600,
                resource_locals: vec![],
            };
            let expression = Expr::Let(
                2,
                Box::new(Expr::Apply(
                    Box::new(if known { Expr::Func(0) } else { Expr::Local(0) }),
                    vec![Expr::Call(1, vec![Expr::Local(1)])],
                )),
                Box::new(Expr::Let(
                    3,
                    Box::new(Expr::Call(1, vec![Expr::Local(1)])),
                    Box::new(Expr::Apply(Box::new(Expr::Local(2)), vec![Expr::Local(1)])),
                )),
            );
            let locals = opt.locals.clone();
            let result = opt.expr(expression, 0);
            let Expr::Let(2, producer, continuation) = result else {
                panic!("function-producing calls need their original binding");
            };
            if known {
                assert!(matches!(*producer, Expr::Call(0, _)));
            } else {
                assert!(
                    matches!(*producer, Expr::Apply(ref f, _) if matches!(**f, Expr::Local(0)))
                );
            }
            assert!(matches!(*continuation, Expr::Let(3, _, _)));
            assert_eq!(opt.locals, locals);
        }
    }

    #[test]
    fn rejected_observable_capture_discards_every_prepared_binding() {
        let integer = MT::con("std::I64");
        let channel = MT::Con("std::Channel".into(), vec![integer.clone()]);
        let weak = MT::Con("std::WeakChannel".into(), vec![integer.clone()]);
        let unary = MT::Fun(Box::new(integer.clone()), Box::new(integer.clone()));
        let funcs = vec![
            Func {
                name: "capture".into(),
                arity: 3,
                ty: MT::Fun(
                    Box::new(integer.clone()),
                    Box::new(MT::Fun(Box::new(channel.clone()), Box::new(unary.clone()))),
                ),
                locals: vec![integer.clone(), channel.clone(), integer.clone()],
                body: Body::Prim("test.capture".into()),
            },
            Func {
                name: "compute".into(),
                arity: 1,
                ty: unary.clone(),
                locals: vec![integer.clone()],
                body: Body::Prim("prim.abs".into()),
            },
            Func {
                name: "channel".into(),
                arity: 1,
                ty: MT::Fun(Box::new(integer.clone()), Box::new(channel)),
                locals: vec![integer.clone(), weak],
                body: Body::Prim("test.channel".into()),
            },
        ];
        let shapes = Shapes::default();
        let mut opt = Opt {
            funcs: &funcs,
            shapes: &shapes,
            current: usize::MAX,
            locals: vec![integer.clone(), unary, integer],
            budget: 600,
            resource_locals: vec![],
        };
        let expression = Expr::Let(
            1,
            Box::new(Expr::Apply(
                Box::new(Expr::Func(0)),
                vec![
                    Expr::Call(1, vec![Expr::Local(0)]),
                    Expr::Call(2, vec![Expr::Local(0)]),
                ],
            )),
            Box::new(Expr::Let(
                2,
                Box::new(Expr::Call(1, vec![Expr::Local(0)])),
                Box::new(Expr::Apply(Box::new(Expr::Local(1)), vec![Expr::Local(0)])),
            )),
        );
        let original = format!("{expression:?}");
        let locals = opt.locals.clone();
        let result = opt.expr(expression, 0);
        assert_eq!(format!("{result:?}"), original);
        assert_eq!(
            opt.locals, locals,
            "rejection must not leave typed temporaries"
        );
    }
}
