//! Fusion of list pipelines: `range a b | map f | filter p | fold g z`
//! (and the same over any list) becomes one `loop` whose state is the
//! position, the accumulator and the values the stages capture, so no
//! intermediate list is built. The C backend runs that loop with its state
//! in locals (`loop_shape` in src/cgen.rs).
//!
//! Fusing interleaves the stages: unfused, `map f` runs on every element
//! before `filter p` sees the first; fused, each element goes through every
//! stage in turn. That is unobservable when the stages are total apart from
//! their traps, and the traps cannot be told apart:
//!
//! - every stage function is pure (it calls only known functions and the
//!   primitives below) and terminates (no recursion, no `loop`);
//! - all the stages together can raise at most one trap message (say
//!   `arithmetic overflow in I64`): whichever stage raises it first, the
//!   program prints the same and exits the same way.
//!
//! The analysis is `Behaviors`: the trap messages a function can raise,
//! or `None` when it may do anything else (effects, divergence, calls of
//! unknown functions, primitives not listed here).

use std::collections::{BTreeSet, HashMap};

use crate::ir::*;
use crate::value::Value;

/// The trap messages an expression can raise when it is evaluated; `None`
/// when it may do anything else.
type Traps = Option<BTreeSet<String>>;

fn union(a: Traps, b: Traps) -> Traps {
    let (mut a, b) = (a?, b?);
    a.extend(b);
    Some(a)
}

fn none() -> Traps {
    Some(BTreeSet::new())
}

enum Num {
    Int(String),
    Float,
}

fn num(t: &MT) -> Option<Num> {
    let MT::Con(n, args) = t else { return None };
    if !args.is_empty() {
        return None;
    }
    let short = n.trim_start_matches("std::");
    if crate::solve::INT_TYPES.contains(&short) {
        Some(Num::Int(short.to_string()))
    } else if crate::solve::FLOAT_TYPES.contains(&short) {
        Some(Num::Float)
    } else {
        None
    }
}

struct Behaviors<'p> {
    funcs: &'p [Func],
    memo: HashMap<FuncId, Traps>,
    active: Vec<FuncId>,
}

impl<'p> Behaviors<'p> {
    fn new(funcs: &'p [Func]) -> Self {
        Behaviors {
            funcs,
            memo: HashMap::new(),
            active: Vec::new(),
        }
    }

    /// What calling function `id` with `args` (all of them) can do.
    fn call(&mut self, id: FuncId, args: &[Expr]) -> Traps {
        let f = &self.funcs[id];
        match &f.body {
            Body::Ctor(_) => none(),
            Body::Prim(sym) => prim(sym, &f.ty, args),
            Body::Expr(e) => {
                if let Some(t) = self.memo.get(&id) {
                    return t.clone();
                }
                // recursion may not terminate
                if self.active.contains(&id) {
                    return None;
                }
                self.active.push(id);
                let t = self.expr(e);
                self.active.pop();
                self.memo.insert(id, t.clone());
                t
            }
            _ => None,
        }
    }

    fn all(&mut self, es: &[Expr]) -> Traps {
        es.iter().fold(none(), |acc, e| union(acc, self.expr(e)))
    }

    fn expr(&mut self, e: &Expr) -> Traps {
        match e {
            Expr::Local(_) | Expr::Const(_) => none(),
            // a constant binding is evaluated; a function is a value
            Expr::Func(id) if self.funcs[*id].arity == 0 => self.call(*id, &[]),
            Expr::Func(_) => none(),
            Expr::Call(id, args) => union(self.all(args), self.call(*id, args)),
            Expr::Apply(f, args) => {
                let (id, mut all) = match &**f {
                    Expr::Func(id) => (*id, Vec::new()),
                    Expr::Apply(g, pre) => match &**g {
                        Expr::Func(id) => (*id, pre.clone()),
                        _ => return None,
                    },
                    _ => return None,
                };
                all.extend(args.iter().cloned());
                let arity = self.funcs[id].arity as usize;
                let t = self.all(&all);
                if all.len() < arity {
                    t
                } else if all.len() == arity {
                    union(t, self.call(id, &all))
                } else {
                    None
                }
            }
            Expr::Construct(_, a) | Expr::Record(a) => self.all(a),
            Expr::Field(r, _) => self.expr(r),
            Expr::SetFields(r, s) => {
                let t = self.expr(r);
                s.iter().fold(t, |acc, (_, x)| union(acc, self.expr(x)))
            }
            Expr::Let(_, v, b) => union(self.expr(v), self.expr(b)),
            Expr::Match(s, arms) => {
                let t = self.expr(s);
                arms.iter().fold(t, |acc, (_, b)| union(acc, self.expr(b)))
            }
        }
    }
}

/// What a primitive can do: only arithmetic and comparisons are known.
fn prim(sym: &str, ty: &MT, args: &[Expr]) -> Traps {
    let (params, result) = ty.params(2);
    match sym {
        "eq" | "ne" | "lt" | "le" | "gt" | "ge" | "compare" | "min" | "max" => {
            // primitive numbers only: anything else compares structurally
            params.first().and_then(|t| num(t)).map(|_| BTreeSet::new())
        }
        "prim.zero" | "prim.one" => num(result).map(|_| BTreeSet::new()),
        "prim.add" | "prim.sub" | "prim.mul" | "prim.neg" => match num(result)? {
            Num::Float => none(),
            Num::Int(n) => Some(BTreeSet::from([format!("arithmetic overflow in {}", n)])),
        },
        "prim.div" | "prim.rem" => match num(result)? {
            Num::Float => none(),
            Num::Int(n) => {
                // a literal divisor other than 0 and -1 cannot trap
                let safe = match args.first() {
                    Some(Expr::Const(v)) => v.as_i128().is_some_and(|d| d != 0 && d != -1),
                    _ => false,
                };
                if safe {
                    none()
                } else {
                    Some(BTreeSet::from([
                        "division by zero".to_string(),
                        format!("arithmetic overflow in {}", n),
                    ]))
                }
            }
        },
        _ => None,
    }
}

/// A stage of a fused pipeline, outermost first as written in the IR.
enum Stage {
    Map(Expr),
    Filter(Expr),
}

/// Where the elements come from.
enum Producer {
    /// `range a b` at integer type `t`.
    Range(Expr, Expr, MT),
    List(Expr),
}

/// A function value `f` applied to `n` more arguments: a known function,
/// or one partially applied to locals and constants. Returns the function
/// and its captured arguments.
fn fn_value(funcs: &[Func], e: &Expr, n: usize) -> Option<(FuncId, Vec<Expr>)> {
    let (id, caps) = match e {
        Expr::Func(id) => (*id, Vec::new()),
        Expr::Apply(f, caps) => match &**f {
            Expr::Func(id) => (*id, caps.clone()),
            _ => return None,
        },
        _ => return None,
    };
    if !caps
        .iter()
        .all(|c| matches!(c, Expr::Local(_) | Expr::Const(_)))
    {
        return None;
    }
    (funcs[id].arity as usize == caps.len() + n && funcs[id].arity > 0).then_some((id, caps))
}

fn prim_sym(funcs: &[Func], id: FuncId) -> Option<&str> {
    match &funcs.get(id)?.body {
        Body::Prim(s) => Some(s),
        _ => None,
    }
}

struct Fuser<'p> {
    funcs: &'p [Func],
    beh: Behaviors<'p>,
    /// Functions made by this pass (step functions and primitives).
    made: Vec<Func>,
    /// The caller's locals.
    nlocals: Local,
}

impl Fuser<'_> {
    fn new_func(&mut self, f: Func) -> FuncId {
        self.made.push(f);
        self.funcs.len() + self.made.len() - 1
    }

    fn prim(&mut self, sym: &str, ty: MT, arity: u32) -> FuncId {
        let base = self.funcs.len();
        if let Some(i) = self
            .made
            .iter()
            .position(|f| matches!(&f.body, Body::Prim(s) if s == sym) && f.ty == ty)
        {
            return base + i;
        }
        self.new_func(Func {
            name: sym.to_string(),
            arity,
            nlocals: arity,
            ty,
            body: Body::Prim(sym.to_string()),
        })
    }

    fn fresh(&mut self) -> Local {
        self.nlocals += 1;
        self.nlocals - 1
    }

    fn expr(&mut self, e: Expr) -> Expr {
        let e = match e {
            Expr::Call(id, args) => {
                Expr::Call(id, args.into_iter().map(|a| self.expr(a)).collect())
            }
            Expr::Apply(f, args) => Expr::Apply(
                Box::new(self.expr(*f)),
                args.into_iter().map(|a| self.expr(a)).collect(),
            ),
            Expr::Construct(t, a) => {
                Expr::Construct(t, a.into_iter().map(|x| self.expr(x)).collect())
            }
            Expr::Record(a) => Expr::Record(a.into_iter().map(|x| self.expr(x)).collect()),
            Expr::Field(r, i) => Expr::Field(Box::new(self.expr(*r)), i),
            Expr::SetFields(r, s) => Expr::SetFields(
                Box::new(self.expr(*r)),
                s.into_iter().map(|(i, x)| (i, self.expr(x))).collect(),
            ),
            Expr::Let(l, v, b) => Expr::Let(l, Box::new(self.expr(*v)), Box::new(self.expr(*b))),
            Expr::Match(s, arms) => Expr::Match(
                Box::new(self.expr(*s)),
                arms.into_iter().map(|(p, b)| (p, self.expr(b))).collect(),
            ),
            e => e,
        };
        match &e {
            Expr::Call(id, args) if self.consumer(*id, args).is_some() => {
                self.consume(*id, args).unwrap_or(e)
            }
            // `Let(l, xs, fold g z l)`: the list is consumed right away, and
            // evaluating the consumer's other arguments first changes
            // nothing when they can do nothing
            // The call may also be the first thing the body evaluates, as
            // in `Let(l, xs, Let(m, find p l, ...))`.
            Expr::Let(l, v, b) if crate::opt::uses(b, *l) == 1 => {
                let (l, v) = (*l, (**v).clone());
                let Expr::Let(_, _, b) = e else {
                    unreachable!()
                };
                let mut b = *b;
                let first = first_evaluated(&mut b);
                let fused = match first {
                    Expr::Call(id, args)
                        if self.consumer(*id, args).is_some()
                            && matches!(args.last(), Some(Expr::Local(x)) if *x == l)
                            && args[..args.len() - 1]
                                .iter()
                                .all(|a| self.beh.expr(a) == none()) =>
                    {
                        let mut args = args.clone();
                        *args.last_mut().unwrap() = v.clone();
                        self.consume(*id, &args)
                    }
                    _ => None,
                };
                match fused {
                    Some(f) => {
                        *first_evaluated(&mut b) = f;
                        b
                    }
                    None => Expr::Let(l, Box::new(v), Box::new(b)),
                }
            }
            _ => e,
        }
    }

    /// The primitive a fused pipeline can end in, if `id` is one.
    fn consumer(&self, id: FuncId, args: &[Expr]) -> Option<&'static str> {
        match (prim_sym(self.funcs, id)?, args.len()) {
            ("fold", 3) => Some("fold"),
            ("length", 1) => Some("length"),
            ("find", 2) => Some("find"),
            _ => None,
        }
    }

    /// `consumer (stages (producer))` as a loop, when that is safe: a
    /// `fold g z`, `length`, or `find p` (which stops at the first match,
    /// so the stages before it may not trap at all).
    fn consume(&mut self, cons_id: FuncId, args: &[Expr]) -> Option<Expr> {
        let funcs = self.funcs;
        let kind = self.consumer(cons_id, args)?;
        let list = args.last()?;
        let (cparams, result_ty) = funcs[cons_id].ty.params(args.len());
        let list_ty = (*cparams.last()?).clone();
        let result_ty = result_ty.clone();
        let mut stages = Vec::new();
        let mut cur = list;
        loop {
            match cur {
                Expr::Call(id, a) if a.len() == 2 => match prim_sym(funcs, *id) {
                    Some("map") => stages.push(Stage::Map(a[0].clone())),
                    Some("filter") => stages.push(Stage::Filter(a[0].clone())),
                    _ => break,
                },
                _ => break,
            }
            let Expr::Call(_, a) = cur else {
                unreachable!()
            };
            cur = &a[1];
        }
        let producer = match cur {
            Expr::Call(id, a) if a.len() == 2 && prim_sym(funcs, *id) == Some("range") => {
                let t = funcs[*id].ty.params(2).0[0].clone();
                match num(&t) {
                    Some(Num::Int(_)) if crate::interp::from_i128(&t, 1).is_ok() => {
                        Producer::Range(a[0].clone(), a[1].clone(), t)
                    }
                    _ => return None,
                }
            }
            // a list built by other means: worth it only with stages
            e if !stages.is_empty() => Producer::List(e.clone()),
            _ => return None,
        };
        // the consumer's and stages' functions, and what they can do together
        let cv = match kind {
            "fold" => Some(fn_value(funcs, &args[0], 2)?),
            "find" => Some(fn_value(funcs, &args[0], 1)?),
            _ => None,
        };
        let mut traps = match &cv {
            Some((id, _)) => self.beh.call(*id, &dummy_args(funcs, *id))?,
            None => BTreeSet::new(),
        };
        let mut fns = Vec::new();
        for s in &stages {
            let (Stage::Map(f) | Stage::Filter(f)) = s;
            let fv = fn_value(funcs, f, 1)?;
            traps.extend(self.beh.call(fv.0, &dummy_args(funcs, fv.0))?);
            fns.push(fv);
        }
        if traps.len() > usize::from(kind != "find") {
            return None;
        }
        let elem_ty = match list_ty {
            MT::Con(_, a) if a.len() == 1 => a[0].clone(),
            _ => return None,
        };
        // the accumulator: a fold's, a count, or nothing (`find`)
        let (z, acc_ty) = match kind {
            "fold" => (args[1].clone(), cparams[1].clone()),
            "length" => (Expr::Const(Value::I64(0)), MT::con("std::I64")),
            _ => (Expr::Const(Value::unit()), MT::unit()),
        };

        // Outer values, evaluated in the order the unfused program evaluates
        // them: g, z, the stages outermost first, then the producer.
        let mut binds: Vec<(Local, Expr)> = Vec::new();
        let mut bind = |me: &mut Self, e: &Expr| -> Expr {
            match e {
                Expr::Local(_) | Expr::Const(_) => e.clone(),
                _ => {
                    let l = me.fresh();
                    binds.push((l, e.clone()));
                    Expr::Local(l)
                }
            }
        };
        let z = bind(self, &z);
        let (start, end) = match &producer {
            Producer::Range(a, b, _) => (bind(self, a), Some(bind(self, b))),
            Producer::List(e) => (bind(self, e), None),
        };

        // the state: position, accumulator, then the outer locals the step
        // reads (the end of a range, the captured values)
        let mut outer: Vec<Local> = Vec::new();
        let mut field = |e: &Expr| -> Expr {
            match e {
                Expr::Local(l) => {
                    let i = match outer.iter().position(|o| o == l) {
                        Some(i) => i,
                        None => {
                            outer.push(*l);
                            outer.len() - 1
                        }
                    };
                    Expr::Field(Box::new(Expr::Local(0)), (i + 2) as u32)
                }
                _ => e.clone(),
            }
        };
        let st = |i: u32| Expr::Field(Box::new(Expr::Local(0)), i);
        let end = end.map(|e| field(&e));
        let apply = |field: &mut dyn FnMut(&Expr) -> Expr,
                     (id, caps): &(FuncId, Vec<Expr>),
                     xs: Vec<Expr>| {
            let mut a: Vec<Expr> = caps.iter().map(&mut *field).collect();
            a.extend(xs);
            Expr::Call(*id, a)
        };
        let fcalls: Vec<(bool, (FuncId, Vec<Expr>))> = stages
            .iter()
            .zip(fns)
            .map(|(s, f)| (matches!(s, Stage::Filter(_)), f))
            .collect();

        // step locals: 0 is the state; 1 and 2 the head and tail of a list
        let mut nl: Local = 1;
        let next = |nl: &mut Local| {
            *nl += 1;
            *nl - 1
        };
        let (elem0, next_pos, cell) = match &producer {
            Producer::Range(_, _, t) => {
                let one = Expr::Const(crate::interp::from_i128(t, 1).ok()?);
                let add = self.prim("prim.add", fun2(t, t, t), 2);
                (st(0), Expr::Call(add, vec![one, st(0)]), None)
            }
            Producer::List(_) => {
                let (h, t) = (next(&mut nl), next(&mut nl));
                (Expr::Local(h), Expr::Local(t), Some((h, t)))
            }
        };
        let again = |pos: &Expr, acc: Expr, n: usize| {
            let mut fs = vec![pos.clone(), acc];
            fs.extend((0..n).map(|i| st((i + 2) as u32)));
            Expr::Construct(0, vec![Expr::Record(fs)])
        };
        // the stages innermost first, so build from the end: the element
        // after every stage goes into the accumulator
        let mut x = elem0;
        let mut lets: Vec<(Local, Expr)> = Vec::new();
        let mut guards: Vec<(usize, Expr)> = Vec::new();
        for (is_filter, f) in fcalls.iter().rev() {
            if *is_filter {
                guards.push((lets.len(), apply(&mut field, f, vec![x.clone()])));
            } else {
                let l = next(&mut nl);
                lets.push((l, apply(&mut field, f, vec![x.clone()])));
                x = Expr::Local(l);
            }
        }
        // the element after every stage, into the consumer
        let some = |x: Expr| Expr::Construct(1, vec![Expr::Construct(1, vec![x])]);
        let last = match kind {
            "fold" => Ok(apply(&mut field, cv.as_ref()?, vec![st(1), x.clone()])),
            "length" => {
                let i64 = MT::con("std::I64");
                let add = self.prim("prim.add", fun2(&i64, &i64, &i64), 2);
                Ok(Expr::Call(add, vec![Expr::Const(Value::I64(1)), st(1)]))
            }
            _ => Err(apply(&mut field, cv.as_ref()?, vec![x.clone()])),
        };
        let n = outer.len();
        let skip = again(&next_pos, st(1), n);
        let mut body = match last {
            Ok(acc) => again(&next_pos, acc, n),
            // `find`: stop with the element it matches
            Err(cond) => Expr::Match(
                Box::new(cond),
                vec![
                    (Pat::Construct(1, vec![]), some(x)),
                    (Pat::Wild, skip.clone()),
                ],
            ),
        };
        // wrap from the last binding back to the first
        let mut li = lets.len();
        for (at, cond) in guards.into_iter().rev() {
            while li > at {
                li -= 1;
                let (l, v) = lets[li].clone();
                body = Expr::Let(l, Box::new(v), Box::new(body));
            }
            body = Expr::Match(
                Box::new(cond),
                vec![(Pat::Construct(1, vec![]), body), (Pat::Wild, skip.clone())],
            );
        }
        while li > 0 {
            li -= 1;
            let (l, v) = lets[li].clone();
            body = Expr::Let(l, Box::new(v), Box::new(body));
        }
        let stop = Expr::Construct(
            1,
            vec![if kind == "find" {
                Expr::Construct(0, vec![])
            } else {
                st(1)
            }],
        );
        let body = match &producer {
            Producer::Range(_, _, t) => {
                let lt = self.prim("lt", fun2(t, t, &MT::con("std::Bool")), 2);
                Expr::Match(
                    Box::new(Expr::Call(lt, vec![end.clone()?, st(0)])),
                    vec![(Pat::Construct(1, vec![]), body), (Pat::Wild, stop)],
                )
            }
            Producer::List(_) => {
                let (h, t) = cell?;
                Expr::Match(
                    Box::new(st(0)),
                    vec![
                        (Pat::Construct(1, vec![Pat::Bind(h), Pat::Bind(t)]), body),
                        (Pat::Wild, stop),
                    ],
                )
            }
        };
        let pos_ty = match &producer {
            Producer::Range(_, _, t) => t.clone(),
            Producer::List(_) => MT::Con("std::List".into(), vec![elem_ty]),
        };
        let mut fields = vec![("0".to_string(), pos_ty), ("1".to_string(), acc_ty.clone())];
        fields.extend((0..n).map(|i| ((i + 2).to_string(), MT::unit())));
        MT::sort_fields(&mut fields);
        let state_ty = MT::Record(fields);
        let step_ty = MT::Fun(
            Box::new(state_ty.clone()),
            Box::new(MT::Con(
                "std::Step".into(),
                vec![state_ty.clone(), result_ty.clone()],
            )),
        );
        let all: Vec<Func> = self.funcs.iter().chain(&self.made).cloned().collect();
        let (body, nlocals) = crate::opt::simplify(&all, body, nl);
        let step = self.new_func(Func {
            name: "fused".into(),
            arity: 1,
            nlocals,
            ty: step_ty.clone(),
            body: Body::Expr(body),
        });
        let loop_id = self.prim(
            "loop",
            MT::Fun(
                Box::new(step_ty),
                Box::new(MT::Fun(Box::new(state_ty), Box::new(result_ty))),
            ),
            2,
        );
        let mut init = vec![start, z];
        init.extend(outer.into_iter().map(Expr::Local));
        let mut out = Expr::Call(loop_id, vec![Expr::Func(step), Expr::Record(init)]);
        for (l, v) in binds.into_iter().rev() {
            out = Expr::Let(l, Box::new(v), Box::new(out));
        }
        Some(out)
    }
}

/// The subexpression an expression evaluates first, through `Let`s.
fn first_evaluated(e: &mut Expr) -> &mut Expr {
    match e {
        Expr::Let(_, v, _) => first_evaluated(v),
        e => e,
    }
}

fn fun2(a: &MT, b: &MT, r: &MT) -> MT {
    MT::Fun(
        Box::new(a.clone()),
        Box::new(MT::Fun(Box::new(b.clone()), Box::new(r.clone()))),
    )
}

/// Arguments standing for unknown values, to ask what a call can do.
fn dummy_args(funcs: &[Func], id: FuncId) -> Vec<Expr> {
    (0..funcs[id].arity).map(Expr::Local).collect()
}

/// Fuse the list pipelines of every function.
pub fn fuse(prog: &mut Program) {
    let snapshot = prog.funcs.clone();
    let mut made = Vec::new();
    for id in 0..snapshot.len() {
        let Body::Expr(body) = &snapshot[id].body else {
            continue;
        };
        let mut f = Fuser {
            funcs: &snapshot,
            beh: Behaviors::new(&snapshot),
            made: std::mem::take(&mut made),
            nlocals: snapshot[id].nlocals,
        };
        let body = f.expr(body.clone());
        made = f.made;
        prog.funcs[id].body = Body::Expr(body);
        prog.funcs[id].nlocals = f.nlocals;
    }
    prog.funcs.extend(made);
}
