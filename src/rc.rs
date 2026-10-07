//! Reference counting, as in Perceus: explicit `Dup` and `Drop` in the IR,
//! so that a value is freed as soon as its last reference goes, without a
//! collector. This pass runs after every other one; `check` verifies what
//! it produces.
//!
//! The ownership discipline:
//! - A function owns its parameters and returns an owned value; so does a
//!   constructor. A primitive, a C function and a remote call only borrow
//!   their arguments: the caller drops them after the call.
//! - Building a record or a variant, or applying a closure, consumes the
//!   parts.
//! - `match` and field access borrow the value they look into; a field
//!   that is kept gets a `Dup`, and a variable bound by a pattern gets one
//!   where its arm uses it.
//! - A local that the rest of its scope does not use is dropped right
//!   away: at its binding, or at the start of an arm that does not use it.
//! - Within a sequence of subexpressions (arguments, a `let`'s value and
//!   body), the last one that uses a local owns it and the earlier ones
//!   borrow it, so a local used several times is duplicated only where a
//!   use needs a reference of its own.
//!
//! Only locals whose type may hold a pointer take part: integers, floats,
//! `Bool`, `()` and other enumerations are never counted.

use std::collections::{BTreeMap, BTreeSet};

use crate::ir::*;

type Set = BTreeSet<Local>;

/// Whether values of type `t` are counted: records and variants, which
/// compiled code allocates and may come to own alone, and arrays, maps
/// and sets, which some primitives update in place when unique
/// (`prim_consumes`). Strings and bytes participate when a primitive returns
/// an owned leaf; unknown runtime/FFI boundaries still promote them to sharing.
/// Compiled dynamic applications own closures and typed captures. Unknown
/// callbacks and other runtime values remain shared. Never count
/// integers, floats, `Bool`, `()` and other enumerations. A type this pass
/// does not know (`unknown`) is counted.
pub fn needs_rc(shapes: &Shapes, t: &MT) -> bool {
    match t {
        MT::Record(fs) => !fs.is_empty(),
        MT::Con(n, _)
            if n == "?"
                || is_container(n)
                || matches!(n.as_str(), "std::String" | "std::Bytes") =>
        {
            true
        }
        MT::Con(..) => match shapes.get(t) {
            Some(TypeShape::Adt(vs)) => vs.iter().any(|(_, fs)| !fs.is_empty()),
            Some(TypeShape::Record(fs)) => !fs.is_empty(),
            _ => false,
        },
        MT::Fun(..) => true,
        MT::Nat(_) => false,
    }
}

/// The type of a local this pass adds whose type no expression gives: it
/// is counted.
fn unknown() -> MT {
    MT::Con("?".into(), vec![])
}

/// Whether a call of `id` takes ownership of its arguments.
fn consumes(funcs: &[Func], id: FuncId) -> bool {
    matches!(funcs[id].body, Body::Expr(_) | Body::Ctor(_))
}

/// Whether a call of `id` takes ownership of its argument `j`: every
/// argument of a function or constructor, and the array that
/// `array.set` and `array.push` write in place when it is unique.
fn consumes_arg(funcs: &[Func], id: FuncId, j: usize) -> bool {
    consumes(funcs, id) || matches!(&funcs[id].body, Body::Prim(s) if prim_consumes(s, j))
}

/// Arrays, maps and sets: what the runtime allocates and some primitives
/// update in place when compiled code holds the only reference.
pub fn is_container(name: &str) -> bool {
    matches!(name, "std::Array" | "std::Map" | "std::Set")
}

/// Whether the shared primitive contract transfers this reference.
pub fn prim_consumes(sym: &str, j: usize) -> bool {
    crate::ownership::primitive(sym)
        .is_some_and(|c| c.argument(j) == crate::ownership::Argument::Consume)
}

/// Historical name: consumed arguments also avoid runtime sharing.
pub fn prim_reads_only(sym: &str, j: usize) -> bool {
    crate::ownership::primitive(sym)
        .is_some_and(|c| c.argument(j) != crate::ownership::Argument::Share)
}

/// Whether the primitive returns independently owned leaf or outer storage.
pub fn prim_fresh(sym: &str) -> bool {
    crate::ownership::primitive(sym).is_some_and(|c| {
        matches!(
            c.result,
            crate::ownership::ResultOwnership::FreshContainer
                | crate::ownership::ResultOwnership::FreshLeaf
                | crate::ownership::ResultOwnership::FreshTree
        )
    })
}

struct Pass<'a> {
    funcs: &'a [Func],
    shapes: &'a Shapes,
    locals: Vec<MT>,
}

impl Pass<'_> {
    fn counted(&self, l: Local) -> bool {
        needs_rc(self.shapes, &self.locals[l as usize])
    }

    fn fresh(&mut self, t: MT) -> Local {
        self.locals.push(t);
        self.locals.len() as Local - 1
    }

    fn ty(&self, e: &Expr) -> MT {
        let func = |id: FuncId| &self.funcs[id].ty;
        type_of(&func, self.shapes, &self.locals, e).unwrap_or_else(unknown)
    }

    /// The counted locals `e` reads that it does not bind.
    fn free(&self, e: &Expr) -> Set {
        let mut out = Set::new();
        free(e, &mut out);
        out.retain(|l| self.counted(*l));
        out
    }

    /// `e`, consuming exactly the references in `owned` (which hold every
    /// counted local `e` reads that is not in `borrowed`), with the locals
    /// in `borrowed` alive throughout. Returns an owned value.
    fn conv(&mut self, e: &Expr, owned: &Set, borrowed: &Set) -> Expr {
        let fv = self.free(e);
        let dead: Vec<Local> = owned.difference(&fv).copied().collect();
        let owned: Set = owned.intersection(&fv).copied().collect();
        let out = self.exact(e, &owned, borrowed);
        dead.into_iter()
            .rev()
            .fold(out, |b, l| Expr::Drop(l, Box::new(b)))
    }

    /// A local as an owned value.
    fn take(&mut self, l: Local, owned: &Set) -> Expr {
        if !self.counted(l) || owned.contains(&l) {
            Expr::Local(l)
        } else {
            Expr::Dup(l, Box::new(Expr::Local(l)))
        }
    }

    fn exact(&mut self, e: &Expr, owned: &Set, borrowed: &Set) -> Expr {
        match e {
            Expr::Local(l) => self.take(*l, owned),
            Expr::Const(_) | Expr::Func(_) => e.clone(),
            Expr::Call(id, args) if consumes(self.funcs, *id) => {
                let modes = vec![Mode::Consume; args.len()];
                let id = *id;
                self.seq(args, &modes, owned, borrowed, move |xs| Expr::Call(id, xs))
            }
            Expr::Call(id, args) => {
                let modes: Vec<Mode> = (0..args.len())
                    .map(|j| {
                        if consumes_arg(self.funcs, *id, j) {
                            Mode::Consume
                        } else {
                            Mode::Borrow
                        }
                    })
                    .collect();
                let id = *id;
                self.seq(args, &modes, owned, borrowed, move |xs| Expr::Call(id, xs))
            }
            Expr::Construct(tag, args) => {
                let modes = vec![Mode::Consume; args.len()];
                let tag = *tag;
                self.seq(args, &modes, owned, borrowed, move |xs| {
                    Expr::Construct(tag, xs)
                })
            }
            Expr::Record(args) => {
                let modes = vec![Mode::Consume; args.len()];
                self.seq(args, &modes, owned, borrowed, Expr::Record)
            }
            Expr::Apply(f, args) => {
                let mut parts = vec![(**f).clone()];
                parts.extend(args.iter().cloned());
                let modes = vec![Mode::Consume; parts.len()];
                self.seq(&parts, &modes, owned, borrowed, |mut xs| {
                    let f = xs.remove(0);
                    Expr::Apply(Box::new(f), xs)
                })
            }
            // the copy borrows the record and consumes the new fields; the
            // fields it keeps get a reference each (in the runtime)
            Expr::SetFields(r, sets) => {
                let mut parts = vec![(**r).clone()];
                parts.extend(sets.iter().map(|(_, x)| x.clone()));
                let mut modes = vec![Mode::Consume; parts.len()];
                modes[0] = Mode::Borrow;
                let idx: Vec<u32> = sets.iter().map(|(i, _)| *i).collect();
                self.seq(&parts, &modes, owned, borrowed, move |mut xs| {
                    let r = xs.remove(0);
                    Expr::SetFields(Box::new(r), idx.iter().copied().zip(xs).collect())
                })
            }
            // a field is read from a borrowed record and kept with a Dup;
            // the record is dropped after when this was its last use
            Expr::Field(r, i) => {
                let (base, owned_base, bind) = match &**r {
                    Expr::Local(x) => (*x, owned.contains(x), None),
                    r => {
                        let t = self.ty(r);
                        let v = self.conv(r, owned, borrowed);
                        let tl = self.fresh(t);
                        (tl, self.counted(tl), Some(v))
                    }
                };
                let y = self.fresh(self.ty(e));
                let mut body = Expr::Local(y);
                if owned_base {
                    body = Expr::Drop(base, Box::new(body));
                }
                if self.counted(y) {
                    body = Expr::Dup(y, Box::new(body));
                }
                let read = Expr::Field(Box::new(Expr::Local(base)), *i);
                let out = Expr::Let(y, Box::new(read), Box::new(body));
                match bind {
                    Some(v) => Expr::Let(base, Box::new(v), Box::new(out)),
                    None => out,
                }
            }
            Expr::Let(x, v, b) => {
                let fb = self.free(b);
                // the body owns what it uses; the value borrows those
                let vo: Set = owned.difference(&fb).copied().collect();
                let mut vb = borrowed.clone();
                vb.extend(owned.intersection(&fb));
                let v = self.conv(v, &vo, &vb);
                let mut bo: Set = owned.intersection(&fb).copied().collect();
                if self.counted(*x) {
                    bo.insert(*x);
                }
                let b = self.conv(b, &bo, borrowed);
                Expr::Let(*x, Box::new(v), Box::new(b))
            }
            Expr::Match(s, arms) => {
                let mut fa = Set::new();
                for (_, b) in arms {
                    fa.extend(self.free(b));
                }
                // the scrutinee as a local the arms borrow
                let (scrut, bind) = match &**s {
                    Expr::Local(l) => (*l, None),
                    s => {
                        let so: Set = owned.difference(&fa).copied().collect();
                        let mut sb = borrowed.clone();
                        sb.extend(owned.intersection(&fa));
                        let t = self.ty(s);
                        let v = self.conv(s, &so, &sb);
                        (self.fresh(t), Some(v))
                    }
                };
                let mut ao: Set = owned.intersection(&fa).copied().collect();
                if bind.is_some() && self.counted(scrut) {
                    ao.insert(scrut);
                }
                if bind.is_none() && owned.contains(&scrut) {
                    ao.insert(scrut);
                }
                let arms: Vec<(Pat, Expr)> = arms
                    .iter()
                    .map(|(p, b)| {
                        // the variables a pattern binds are borrowed from the
                        // scrutinee: those the arm uses get a reference
                        let mut bound = Vec::new();
                        pat_binds(p, &mut bound);
                        let used: Vec<Local> = {
                            let fb = self.free(b);
                            bound.into_iter().filter(|v| fb.contains(v)).collect()
                        };
                        let mut o = ao.clone();
                        o.extend(used.iter().copied());
                        let body = self.conv(b, &o, borrowed);
                        let body = used
                            .iter()
                            .rev()
                            .fold(body, |e, v| Expr::Dup(*v, Box::new(e)));
                        (p.clone(), body)
                    })
                    .collect();
                let m = Expr::Match(Box::new(Expr::Local(scrut)), arms);
                match bind {
                    Some(v) => Expr::Let(scrut, Box::new(v), Box::new(m)),
                    None => m,
                }
            }
            Expr::Dup(..) | Expr::Drop(..) => unreachable!("reference counting runs once"),
        }
    }

    /// Parts evaluated in order, then combined by `build`: each part that
    /// is a local in a borrowing position is passed as it is (and dropped
    /// after `build` when this was its last use and it is owned); any
    /// other part becomes an owned value. A local several parts use is
    /// owned by the last of them and borrowed by the others.
    fn seq(
        &mut self,
        parts: &[Expr],
        modes: &[Mode],
        owned: &Set,
        borrowed: &Set,
        build: impl FnOnce(Vec<Expr>) -> Expr,
    ) -> Expr {
        let fvs: Vec<Set> = parts.iter().map(|p| self.free(p)).collect();
        // the last part that uses each owned local; a local passed to a
        // borrowing position is read by the operation itself, after every
        // part (position `parts.len()`)
        let end = parts.len();
        let mut last: BTreeMap<Local, usize> = BTreeMap::new();
        for (i, fv) in fvs.iter().enumerate() {
            for l in fv.intersection(owned) {
                last.insert(*l, i);
            }
        }
        for (p, mode) in parts.iter().zip(modes) {
            if let (Mode::Borrow, Expr::Local(l)) = (mode, p) {
                if owned.contains(l) {
                    last.insert(*l, end);
                }
            }
        }
        let mut binds: Vec<(Local, Expr)> = Vec::new();
        let mut xs = Vec::new();
        let mut drop_after: Vec<Local> = Vec::new();
        // a borrowed part that is computed (and counted) becomes a
        // temporary bound before the operation; every computed part before
        // the last such one is bound too, to keep the order of evaluation
        let inline = |p: &Expr| matches!(p, Expr::Local(_) | Expr::Const(_) | Expr::Func(_));
        // a borrowed part whose value is not counted needs no temporary:
        // nothing is dropped after the operation
        let uncounted: Vec<bool> = parts
            .iter()
            .map(|p| !needs_rc(self.shapes, &self.ty(p)))
            .collect();
        let last_bound = parts
            .iter()
            .zip(modes)
            .enumerate()
            .filter(|(i, (p, m))| matches!(m, Mode::Borrow) && !inline(p) && !uncounted[*i])
            .map(|(i, _)| i)
            .next_back();
        for (i, (p, mode)) in parts.iter().zip(modes).enumerate() {
            let mine: Set = last
                .iter()
                .filter(|(_, j)| **j == i)
                .map(|(l, _)| *l)
                .collect();
            let mut theirs = borrowed.clone();
            theirs.extend(last.iter().filter(|(_, j)| **j > i).map(|(l, _)| *l));
            match (mode, p) {
                (Mode::Borrow, Expr::Local(l)) => {
                    if last.get(l) == Some(&end) && !drop_after.contains(l) {
                        drop_after.push(*l);
                    }
                    xs.push(Expr::Local(*l));
                }
                (Mode::Borrow, Expr::Const(_) | Expr::Func(_)) => xs.push(p.clone()),
                // computed in place, unless a later part is bound before
                // the operation (then bound too, in order)
                (Mode::Borrow, p) if uncounted[i] => {
                    let v = self.conv(p, &mine, &theirs);
                    if last_bound.is_none_or(|j| i > j) {
                        xs.push(v);
                    } else {
                        let tl = self.fresh(self.ty(p));
                        binds.push((tl, v));
                        xs.push(Expr::Local(tl));
                    }
                }
                (Mode::Borrow, p) => {
                    // an owned temporary, dropped after the call
                    let t = self.ty(p);
                    let v = self.conv(p, &mine, &theirs);
                    let tl = self.fresh(t);
                    binds.push((tl, v));
                    if self.counted(tl) {
                        drop_after.push(tl);
                    }
                    xs.push(Expr::Local(tl));
                }
                (Mode::Consume, p) => {
                    let v = self.conv(p, &mine, &theirs);
                    if inline(&v) || last_bound.is_none_or(|j| i > j) {
                        xs.push(v);
                    } else {
                        let t = self.ty(p);
                        let tl = self.fresh(t);
                        binds.push((tl, v));
                        xs.push(Expr::Local(tl));
                    }
                }
            }
        }
        let mut out = build(xs);
        if !drop_after.is_empty() {
            let t = self.ty(&out);
            let r = self.fresh(t);
            let body = drop_after
                .iter()
                .rev()
                .fold(Expr::Local(r), |b, l| Expr::Drop(*l, Box::new(b)));
            out = Expr::Let(r, Box::new(out), Box::new(body));
        }
        binds
            .into_iter()
            .rev()
            .fold(out, |b, (l, v)| Expr::Let(l, Box::new(v), Box::new(b)))
    }
}

#[derive(Clone, Copy)]
enum Mode {
    /// The part's value is taken over.
    Consume,
    /// The part is only read during the operation.
    Borrow,
}

fn free(e: &Expr, out: &mut Set) {
    let mut bound = Set::new();
    free_in(e, &mut bound, out);
}

fn free_in(e: &Expr, bound: &mut Set, out: &mut Set) {
    match e {
        Expr::Local(l) => {
            if !bound.contains(l) {
                out.insert(*l);
            }
        }
        Expr::Const(_) | Expr::Func(_) => {}
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => {
            a.iter().for_each(|x| free_in(x, bound, out))
        }
        Expr::Apply(f, a) => {
            free_in(f, bound, out);
            a.iter().for_each(|x| free_in(x, bound, out));
        }
        Expr::Field(r, _) => free_in(r, bound, out),
        Expr::SetFields(r, s) => {
            free_in(r, bound, out);
            s.iter().for_each(|(_, x)| free_in(x, bound, out));
        }
        Expr::Let(l, v, b) => {
            free_in(v, bound, out);
            bound.insert(*l);
            free_in(b, bound, out);
        }
        Expr::Match(s, arms) => {
            free_in(s, bound, out);
            for (p, b) in arms {
                let mut vs = Vec::new();
                pat_binds(p, &mut vs);
                bound.extend(vs);
                free_in(b, bound, out);
            }
        }
        Expr::Dup(l, b) | Expr::Drop(l, b) => {
            if !bound.contains(l) {
                out.insert(*l);
            }
            free_in(b, bound, out);
        }
    }
}

fn pat_binds(p: &Pat, out: &mut Vec<Local>) {
    match p {
        Pat::Bind(l) => out.push(*l),
        Pat::Wild | Pat::Lit(_) => {}
        Pat::Construct(_, ps) | Pat::Record(ps) => ps.iter().for_each(|q| pat_binds(q, out)),
    }
}

/// The function bodies of `prog` with their references counted: the new
/// bodies and their locals, for each function with a body.
pub fn insert(prog: &Program) -> Vec<Option<(Expr, Vec<MT>)>> {
    prog.funcs
        .iter()
        .map(|f| {
            let Body::Expr(e) = &f.body else {
                return None;
            };
            let mut p = Pass {
                funcs: &prog.funcs,
                shapes: &prog.shapes,
                locals: f.locals.clone(),
            };
            let params: Set = (0..f.arity).filter(|l| p.counted(*l)).collect();
            let body = p.conv(e, &params, &Set::new());
            Some((body, p.locals))
        })
        .collect()
}

// ----- checking ------------------------------------------------------------

/// What the checker knows of a counted local: the references it owns, or
/// that it is borrowed from another local (a field or a pattern variable)
/// and valid while that one is alive.
#[derive(Clone, Debug, PartialEq, Eq)]
enum Held {
    Owned(u32),
    From(Local),
}

struct Checker<'a> {
    funcs: &'a [Func],
    shapes: &'a Shapes,
    locals: &'a [MT],
}

type State = BTreeMap<Local, Held>;

impl Checker<'_> {
    fn counted(&self, l: Local) -> bool {
        needs_rc(self.shapes, &self.locals[l as usize])
    }

    fn alive(st: &State, l: Local) -> bool {
        match st.get(&l) {
            Some(Held::Owned(n)) => *n > 0,
            Some(Held::From(p)) => Self::alive(st, *p),
            None => false,
        }
    }

    fn need_alive(&self, st: &State, l: Local, what: &str) -> Result<(), String> {
        if !self.counted(l) || Self::alive(st, l) {
            Ok(())
        } else {
            Err(format!("local {} {} after its last reference", l, what))
        }
    }

    /// One owned reference of `l` given up.
    fn release(&self, st: &mut State, l: Local, what: &str) -> Result<(), String> {
        if !self.counted(l) {
            return Ok(());
        }
        match st.get_mut(&l) {
            Some(Held::Owned(n)) if *n > 0 => {
                *n -= 1;
                Ok(())
            }
            Some(Held::From(_)) => Err(format!(
                "local {} {} without a reference of its own",
                l, what
            )),
            _ => Err(format!("local {} {} after its last reference", l, what)),
        }
    }

    /// Evaluate `e` for its effect on the references held. `consume`: the
    /// value is taken over (a local in that position gives up a
    /// reference). Returns the local the value is borrowed from, if it is
    /// a borrowed read.
    fn expr(&self, e: &Expr, st: &mut State, consume: bool) -> Result<(), String> {
        match e {
            Expr::Local(l) => {
                if consume {
                    self.release(st, *l, "is consumed")
                } else {
                    self.need_alive(st, *l, "is read")
                }
            }
            Expr::Const(_) | Expr::Func(_) => Ok(()),
            Expr::Call(id, args) => args.iter().enumerate().try_for_each(|(j, a)| {
                let c = consumes_arg(self.funcs, *id, j);
                self.expr(a, st, c || !matches!(a, Expr::Local(_)))
            }),
            Expr::Construct(_, a) | Expr::Record(a) => {
                a.iter().try_for_each(|x| self.expr(x, st, true))
            }
            Expr::Apply(f, a) => {
                self.expr(f, st, true)?;
                a.iter().try_for_each(|x| self.expr(x, st, true))
            }
            Expr::SetFields(r, s) => {
                self.expr(r, st, !matches!(**r, Expr::Local(_)))?;
                s.iter().try_for_each(|(_, x)| self.expr(x, st, true))
            }
            Expr::Field(r, _) => self.expr(r, st, !matches!(**r, Expr::Local(_))),
            Expr::Let(l, v, b) => {
                self.expr(v, st, true)?;
                if self.counted(*l) {
                    // a field read is borrowed from its record
                    let held = match &**v {
                        Expr::Field(r, _) => match &**r {
                            Expr::Local(p) => Held::From(*p),
                            _ => return Err(format!("local {} reads a field of a temporary", l)),
                        },
                        _ => Held::Owned(1),
                    };
                    st.insert(*l, held);
                }
                self.expr(b, st, consume)
            }
            Expr::Match(s, arms) => {
                let Expr::Local(x) = &**s else {
                    return Err("a match on an expression, not a local".into());
                };
                self.need_alive(st, *x, "is matched")?;
                let mut after: Option<State> = None;
                for (p, b) in arms {
                    let mut st2 = st.clone();
                    let mut bound = Vec::new();
                    pat_binds(p, &mut bound);
                    for v in bound {
                        if self.counted(v) {
                            st2.insert(v, Held::From(*x));
                        }
                    }
                    self.expr(b, &mut st2, consume)?;
                    // what the arm binds goes out of scope, released
                    let inner: Vec<Local> = st2
                        .keys()
                        .filter(|l| !st.contains_key(l))
                        .copied()
                        .collect();
                    for v in inner {
                        if let Some(Held::Owned(n)) = st2.get(&v) {
                            if *n > 0 {
                                return Err(format!("local {} is never released", v));
                            }
                        }
                        st2.remove(&v);
                    }
                    match &after {
                        None => after = Some(st2),
                        Some(a) if *a != st2 => {
                            return Err(format!(
                                "the arms of a match leave different references: {:?} and {:?}",
                                a, st2
                            ))
                        }
                        _ => {}
                    }
                }
                *st = after.unwrap_or_default();
                Ok(())
            }
            Expr::Dup(l, b) => {
                if self.counted(*l) {
                    self.need_alive(st, *l, "is duplicated")?;
                    match st.get_mut(l) {
                        Some(Held::Owned(n)) => *n += 1,
                        _ => {
                            st.insert(*l, Held::Owned(1));
                        }
                    }
                }
                self.expr(b, st, consume)
            }
            Expr::Drop(l, b) => {
                self.release(st, *l, "is dropped")?;
                self.expr(b, st, consume)
            }
        }
    }
}

/// Check the counted references of a function body: no local is released
/// more often than it is held, none is read after its last reference, and
/// every one is released on every path.
pub fn check(prog: &Program, f: &Func, body: &Expr, locals: &[MT]) -> Result<(), String> {
    let c = Checker {
        funcs: &prog.funcs,
        shapes: &prog.shapes,
        locals,
    };
    let mut st = State::new();
    for l in 0..f.arity {
        if c.counted(l) {
            st.insert(l, Held::Owned(1));
        }
    }
    c.expr(body, &mut st, true)?;
    for (l, h) in &st {
        if let Held::Owned(n) = h {
            if *n > 0 {
                return Err(format!("local {} keeps {} reference(s)", l, n));
            }
        }
    }
    Ok(())
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::value::Value;

    fn list() -> MT {
        MT::Con("std::List".into(), vec![MT::con("std::I64")])
    }

    /// A program of one function of `params`, with `extra` more locals.
    fn prog(params: Vec<MT>, extra: Vec<MT>, body: Expr) -> Program {
        let mut p = Program::default();
        p.shapes.insert(
            list(),
            TypeShape::Adt(vec![
                ("Nil".into(), vec![]),
                ("Cons".into(), vec![MT::con("std::I64"), list()]),
            ]),
        );
        let arity = params.len() as u32;
        let ty = params
            .iter()
            .rev()
            .fold(list(), |t, a| MT::Fun(Box::new(a.clone()), Box::new(t)));
        let mut locals = params;
        locals.extend(extra);
        p.funcs.push(Func {
            name: "f".into(),
            arity,
            locals,
            ty,
            body: Body::Expr(body),
        });
        p
    }

    fn counted(p: &Program) -> (Expr, Vec<MT>) {
        let (e, ls) = insert(p).remove(0).unwrap();
        check(p, &p.funcs[0], &e, &ls).unwrap_or_else(|m| panic!("{}: {:?}", m, e));
        (e, ls)
    }

    fn checked(p: &Program, e: Expr) -> Result<(), String> {
        check(p, &p.funcs[0], &e, &p.funcs[0].locals)
    }

    #[test]
    fn a_parameter_returned_is_moved() {
        let p = prog(vec![list()], vec![], Expr::Local(0));
        assert!(matches!(counted(&p).0, Expr::Local(0)));
    }

    #[test]
    fn a_parameter_used_twice_is_duplicated_once() {
        let p = prog(
            vec![list()],
            vec![],
            Expr::Record(vec![Expr::Local(0), Expr::Local(0)]),
        );
        let s = format!("{:?}", counted(&p).0);
        assert_eq!(s.matches("Dup(0").count(), 1, "{}", s);
        assert!(!s.contains("Drop"), "{}", s);
    }

    #[test]
    fn an_unused_parameter_is_dropped() {
        let p = prog(vec![list()], vec![], Expr::Construct(0, vec![]));
        assert!(matches!(counted(&p).0, Expr::Drop(0, _)));
    }

    #[test]
    fn scalars_are_not_counted() {
        let i = MT::con("std::I64");
        let p = prog(vec![i], vec![], Expr::Construct(0, vec![]));
        assert!(matches!(counted(&p).0, Expr::Construct(..)));
    }

    #[test]
    fn a_match_dups_the_fields_an_arm_keeps_and_drops_the_rest() {
        // match xs { Nil -> Nil; Cons _ t -> t }
        let body = Expr::Match(
            Box::new(Expr::Local(0)),
            vec![
                (Pat::Construct(0, vec![]), Expr::Construct(0, vec![])),
                (
                    Pat::Construct(1, vec![Pat::Wild, Pat::Bind(1)]),
                    Expr::Local(1),
                ),
            ],
        );
        let p = prog(vec![list()], vec![list()], body);
        let s = format!("{:?}", counted(&p).0);
        assert!(s.contains("Dup(1, Drop(0, Local(1)))"), "{}", s);
        assert!(s.contains("Drop(0, Construct(0, []))"), "{}", s);
    }

    #[test]
    fn a_borrowed_argument_lives_until_the_operation() {
        // a record copy borrows its base while computing the new field
        // from it: the base is dropped after the copy, not before
        let body = Expr::SetFields(
            Box::new(Expr::Local(0)),
            vec![(1, Expr::Field(Box::new(Expr::Local(0)), 1))],
        );
        let p = prog(vec![list()], vec![], body);
        counted(&p);
    }

    #[test]
    fn parts_keep_their_order() {
        // prim(uncounted read of x, counted part that releases x): the
        // first part must still run before the second
        let mut p = prog(vec![list()], vec![], Expr::Const(Value::unit()));
        p.funcs.push(Func {
            name: "prim".into(),
            arity: 2,
            locals: vec![MT::con("std::I64"), list()],
            ty: MT::Fun(
                Box::new(MT::con("std::I64")),
                Box::new(MT::Fun(Box::new(list()), Box::new(MT::unit()))),
            ),
            body: Body::Prim("prim".into()),
        });
        p.funcs.push(Func {
            name: "len".into(),
            arity: 1,
            locals: vec![list()],
            ty: MT::Fun(Box::new(list()), Box::new(MT::con("std::I64"))),
            body: Body::Prim("len".into()),
        });
        let body = Expr::Call(
            1,
            vec![
                Expr::Call(2, vec![Expr::Local(0)]),
                Expr::Construct(1, vec![Expr::Const(Value::I64(0)), Expr::Local(0)]),
            ],
        );
        p.funcs[0].body = Body::Expr(body);
        let (e, _) = counted(&p);
        // the length is computed first
        let s = format!("{:?}", e);
        let len = s.find("Call(2").unwrap();
        let cons = s.find("Construct(1").unwrap();
        assert!(len < cons, "{}", s);
    }

    #[test]
    fn the_checker_rejects_mistakes() {
        let p = prog(vec![list()], vec![], Expr::Local(0));
        // a reference kept
        assert!(checked(&p, Expr::Construct(0, vec![])).is_err());
        // released twice
        let twice = Expr::Drop(
            0,
            Box::new(Expr::Drop(0, Box::new(Expr::Construct(0, vec![])))),
        );
        assert!(checked(&p, twice).is_err());
        // consumed twice without a Dup
        assert!(checked(&p, Expr::Record(vec![Expr::Local(0), Expr::Local(0)])).is_err());
        // read after its last reference
        let late = Expr::Drop(0, Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)));
        assert!(checked(&p, late).is_err());
        // arms that disagree
        let arms = Expr::Match(
            Box::new(Expr::Local(0)),
            vec![
                (Pat::Construct(0, vec![]), Expr::Local(0)),
                (Pat::Wild, Expr::Construct(0, vec![])),
            ],
        );
        assert!(checked(&p, arms).is_err());
    }
}
