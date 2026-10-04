//! IR optimizations: inlining of small functions (combinators, compose,
//! selectors, trait-method wrappers), flattening of nested applications,
//! saturation of known partial applications into direct calls, and folding
//! of record projections. Internal pipes compile to direct calls this way.
//!
//! All transformations preserve evaluation order: arguments that may have
//! effects are bound with `Let` before the inlined body; only pure
//! expressions are substituted.

use crate::ir::*;

const INLINE_SIZE: usize = 40;
const MAX_BODY: usize = 4000;
const ROUNDS: usize = 4;

fn size(e: &Expr) -> usize {
    match e {
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

fn calls(e: &Expr, id: FuncId) -> bool {
    match e {
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
        Expr::Local(x) => (*x == l) as usize,
        Expr::Const(_) | Expr::Func(_) => 0,
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => {
            a.iter().map(|x| uses(x, l)).sum()
        }
        Expr::Apply(f, a) => uses(f, l) + a.iter().map(|x| uses(x, l)).sum::<usize>(),
        Expr::Field(r, _) => uses(r, l),
        Expr::SetFields(r, s) => uses(r, l) + s.iter().map(|(_, x)| uses(x, l)).sum::<usize>(),
        Expr::Let(_, v, b) => uses(v, l) + uses(b, l),
        // a use inside a match arm may run at most once, but counts as a
        // use for duplication purposes
        Expr::Match(s, arms) => uses(s, l) + arms.iter().map(|(_, b)| uses(b, l)).sum::<usize>(),
    }
}

struct Opt<'p> {
    funcs: &'p [Func],
    current: FuncId,
    nlocals: u32,
    /// Remaining number of IR nodes this function may grow by inlining.
    budget: isize,
}

impl<'p> Opt<'p> {
    fn arity(&self, id: FuncId) -> usize {
        self.funcs[id].arity as usize
    }

    /// Cheap expressions that can be duplicated freely.
    fn trivial(&self, e: &Expr) -> bool {
        match e {
            Expr::Local(_) | Expr::Func(_) => true,
            Expr::Const(v) => {
                !matches!(
                    v,
                    crate::value::Value::Data(..)
                        | crate::value::Value::Record(_)
                        | crate::value::Value::Array(_)
                ) || matches!(v, crate::value::Value::Data(_, f) if f.is_empty())
            }
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

    fn fresh(&mut self) -> Local {
        self.nlocals += 1;
        self.nlocals - 1
    }

    fn expr(&mut self, e: Expr, depth: usize) -> Expr {
        match e {
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
                let r = self.expr(*r, depth);
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
                let b = self.expr(*b, depth);
                Expr::Let(l, Box::new(v), Box::new(b))
            }
            Expr::Match(s, arms) => Expr::Match(
                Box::new(self.expr(*s, depth)),
                arms.into_iter()
                    .map(|(p, b)| (p, self.expr(b, depth)))
                    .collect(),
            ),
        }
    }

    fn apply(&mut self, f: Expr, args: Vec<Expr>, depth: usize) -> Expr {
        if args.is_empty() {
            return f;
        }
        match f {
            // ((g a) b) = (g a b)
            Expr::Apply(g, mut a1) => {
                a1.extend(args);
                self.apply(*g, a1, depth)
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
        {
            return Expr::Call(id, args);
        }
        self.budget -= body_size as isize;
        let body = body.clone();
        let arity = callee.arity;
        let nlocals = callee.nlocals;
        // map callee locals to caller expressions/locals
        let mut lets = Vec::new();
        let mut subst: Vec<Option<Expr>> = vec![None; nlocals as usize];
        for (i, a) in args.into_iter().enumerate() {
            let n = uses(&body, i as u32);
            if self.trivial(&a) || (n <= 1 && self.pure(&a)) {
                subst[i] = Some(a);
            } else {
                let l = self.fresh();
                lets.push((l, a));
                subst[i] = Some(Expr::Local(l));
            }
        }
        let mut renamed = Vec::new();
        for slot in subst.iter_mut().skip(arity as usize) {
            let l = self.fresh();
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

/// Replace callee locals: in expressions with the mapped expressions, in
/// binding positions (let, patterns) with the mapped locals.
fn substitute(e: &Expr, s: &[Option<Expr>]) -> Expr {
    let local = |l: &Local| match &s[*l as usize] {
        Some(Expr::Local(x)) => *x,
        _ => *l,
    };
    match e {
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
                current: id,
                nlocals: prog.funcs[id].nlocals,
                budget: 600,
            };
            let new = o.expr(body.clone(), 0);
            let f = &mut prog.funcs[id];
            f.body = Body::Expr(new);
            f.nlocals = o.nlocals;
        }
    }
}

/// Optimize an expression of a new function with `nlocals` locals (as
/// every function is): returns it and the function's new local count.
pub(crate) fn simplify(funcs: &[Func], body: Expr, nlocals: Local) -> (Expr, Local) {
    let mut o = Opt {
        funcs,
        current: usize::MAX,
        nlocals,
        budget: 600,
    };
    let mut body = body;
    for _ in 0..ROUNDS {
        body = o.expr(body, 0);
    }
    (body, o.nlocals)
}

/// The number of arguments a higher-order primitive applies its function
/// argument to, for those that `specialize_hofs` handles.
pub fn hof_arity(sym: &str) -> Option<usize> {
    match sym {
        "map" | "filter" | "find" | "take-while" | "drop-while" | "loop" => Some(1),
        "fold" | "fold-right" | "zip-with" => Some(2),
        _ => None,
    }
}

/// The locals an expression reads, in order of first use.
fn free_locals(e: &Expr, out: &mut Vec<Local>) {
    match e {
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
        Expr::SetFields(..) | Expr::Let(..) | Expr::Match(..) => {}
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
        rewrite_hofs(&mut body, &snapshot, base, &mut made, &mut seen);
        prog.funcs[id].body = Body::Expr(body);
    }
    prog.funcs.extend(made);
}

fn rewrite_hofs(
    e: &mut Expr,
    funcs: &[Func],
    base: usize,
    made: &mut Vec<Func>,
    seen: &mut Vec<(String, FuncId)>,
) {
    // children first
    match e {
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => a
            .iter_mut()
            .for_each(|x| rewrite_hofs(x, funcs, base, made, seen)),
        Expr::Apply(f, a) => {
            rewrite_hofs(f, funcs, base, made, seen);
            a.iter_mut()
                .for_each(|x| rewrite_hofs(x, funcs, base, made, seen));
        }
        Expr::Field(r, _) => rewrite_hofs(r, funcs, base, made, seen),
        Expr::SetFields(r, s) => {
            rewrite_hofs(r, funcs, base, made, seen);
            s.iter_mut()
                .for_each(|(_, x)| rewrite_hofs(x, funcs, base, made, seen));
        }
        Expr::Let(_, v, b) => {
            rewrite_hofs(v, funcs, base, made, seen);
            rewrite_hofs(b, funcs, base, made, seen);
        }
        Expr::Match(s, arms) => {
            rewrite_hofs(s, funcs, base, made, seen);
            arms.iter_mut()
                .for_each(|(_, b)| rewrite_hofs(b, funcs, base, made, seen));
        }
    }
    let Expr::Call(prim, args) = e else { return };
    let Some(prim_f) = funcs.get(*prim) else {
        return;
    };
    let Body::Prim(sym) = &prim_f.body else {
        return;
    };
    let Some(n) = hof_arity(sym) else { return };
    let Some(fexpr) = args.first() else { return };
    let o = Opt {
        funcs,
        current: usize::MAX,
        nlocals: 0,
        budget: 0,
    };
    if !matches!(fexpr, Expr::Apply(..)) || !o.pure(fexpr) {
        return;
    }
    let mut caps = Vec::new();
    free_locals(fexpr, &mut caps);
    let k = caps.len();
    // the closure over its captures, numbered from 0
    let renamed = rename_locals(fexpr, &caps);
    let key = format!("{:?}|{}", renamed, n);
    let h = match seen.iter().find(|(s, _)| *s == key) {
        Some((_, h)) => *h,
        None => {
            let params: Vec<Expr> = (k..k + n).map(|i| Expr::Local(i as Local)).collect();
            let mut o = Opt {
                funcs,
                current: usize::MAX,
                nlocals: (k + n) as Local,
                budget: 600,
            };
            let mut body = Expr::Apply(Box::new(renamed), params);
            for _ in 0..ROUNDS {
                body = o.expr(body, 0);
            }
            let h = base + made.len();
            let ty = prim_f.ty.params(prim_f.arity as usize).0[0].clone();
            made.push(Func {
                name: format!("{}-fn", sym),
                arity: (k + n) as u32,
                nlocals: o.nlocals,
                ty,
                body: Body::Expr(body),
            });
            seen.push((key, h));
            h
        }
    };
    args[0] = if k == 0 {
        Expr::Func(h)
    } else {
        Expr::Apply(
            Box::new(Expr::Func(h)),
            caps.iter().map(|l| Expr::Local(*l)).collect(),
        )
    };
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
