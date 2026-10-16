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
            Body::Prim(sym) => match self.higher_order(sym, args) {
                Some(t) => t,
                None => prim(sym, &f.ty, args),
            },
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

    /// What a higher-order primitive can do: what its function argument
    /// can, when it is a known function. `None` when `sym` is not one.
    fn higher_order(&mut self, sym: &str, args: &[Expr]) -> Option<Traps> {
        let n = match sym {
            "map" | "filter" | "find" | "take-while" | "drop-while" => 1,
            "fold" => 2,
            _ => return None,
        };
        Some(
            match args.first().and_then(|f| fn_value(self.funcs, f, n)) {
                Some((id, _)) => self.call(id, &dummy_args(self.funcs, id)),
                None => None,
            },
        )
    }

    fn all(&mut self, es: &[Expr]) -> Traps {
        es.iter().fold(none(), |acc, e| union(acc, self.expr(e)))
    }

    fn expr(&mut self, e: &Expr) -> Traps {
        match e {
            // Resource release is observable even when the source arrow is
            // pure. Fusion must not interleave an original frame's cleanup.
            Expr::ResourceRegion { .. } => None,
            Expr::Dup(_, b) | Expr::Drop(_, b) => self.expr(b),
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

/// What a primitive can do: only the explicitly proved contracts below are known.
fn prim(sym: &str, ty: &MT, args: &[Expr]) -> Traps {
    let (params, result) = ty.params(2);
    match sym {
        "eq" | "ne" | "lt" | "le" | "gt" | "ge" | "compare" | "min" | "max" => {
            // primitive numbers only: anything else compares structurally
            params.first().and_then(|t| num(t)).map(|_| BTreeSet::new())
        }
        // Hash accepts finite immutable structural values, not functions or
        // resources. It reads canonical bytes without callbacks or language
        // traps. Its borrowed input stays owned by the ordinary fused loop.
        "hash" => none(),
        // These integer operations are total, including boxed wide integers.
        // Shifts are deliberately absent: their bit count can trap.
        "bit.and" | "bit.or" | "bit.xor" | "bit.not" => match num(result)? {
            Num::Int(_) => none(),
            Num::Float => None,
        },
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
        // total, and with no effect but allocation (running out of memory
        // is not a trap a program can tell from another)
        "show" | "concat" | "string.length" | "string.byte-length" | "string.chars" | "split"
        | "join" | "lower" | "upper" | "trim" | "trim-start" | "trim-end" | "length"
        | "reverse" | "not" | "and" | "or" | "range" => none(),
        // ordered maps and sets: structural comparisons of keys
        s if (s.starts_with("map.") || s.starts_with("set."))
            && !matches!(s, "map.update" | "map.map-values") =>
        {
            none()
        }
        _ => None,
    }
}

fn unboxed_numeric(ty: &MT) -> bool {
    let MT::Con(name, args) = ty else {
        return false;
    };
    args.is_empty()
        && matches!(
            name.strip_prefix("std::").unwrap_or(name),
            "I8" | "I16"
                | "I32"
                | "I64"
                | "ISize"
                | "U8"
                | "U16"
                | "U32"
                | "U64"
                | "USize"
                | "F32"
                | "F64"
        )
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
    Array(Expr),
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
    shapes: &'p mut Shapes,
    std_names: &'p std::collections::BTreeMap<FuncId, String>,
    beh: Behaviors<'p>,
    /// Functions made by this pass (step functions and primitives).
    made: Vec<Func>,
    /// The types of the caller's locals.
    locals: Vec<MT>,
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
            locals: ty.params(arity as usize).0.into_iter().cloned().collect(),
            ty,
            body: Body::Prim(sym.to_string()),
        })
    }

    fn fresh(&mut self, ty: MT) -> Local {
        self.locals.push(ty);
        self.locals.len() as Local - 1
    }

    /// The type of `e` in a function with locals `locals`, functions made
    /// by this pass included.
    fn ty_in(&self, locals: &[MT], e: &Expr) -> Option<MT> {
        let base = self.funcs.len();
        let func = |id: FuncId| match id.checked_sub(base) {
            Some(i) => &self.made[i].ty,
            None => &self.funcs[id].ty,
        };
        type_of(&func, self.shapes, locals, e)
    }

    fn expr(&mut self, e: Expr) -> Expr {
        let e = match e {
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => Expr::ResourceRegion {
                parameters,
                bindings,
                body: Box::new(self.expr(*body)),
            },
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

    fn std_name(&self, id: FuncId) -> Option<&str> {
        self.std_names.get(&id).map(String::as_str)
    }

    /// Direct iterator consumers over `iter.map`, `iter.filter` and `iter.take`
    /// stages of any iterator, as one loop that consumes the source one
    /// element at a time, without the stages' `Yield` cells and thunks.
    /// Iterators are lazy, so each element already goes through every
    /// stage in turn: the loop keeps that order exactly, effects and traps
    /// included, and forces the source's tail only when another element
    /// is wanted (so `iter.take n` forces nothing after the n-th).
    fn iter_consume(&mut self, consumer: FuncId, args: &[Expr]) -> Option<Expr> {
        let kind = match (self.std_name(consumer)?, args.len()) {
            ("std::iter.to-list", 1) => "list",
            ("std::iter.fold", 3) => "fold",
            ("std::iter.each", 2) => "each",
            ("std::iter.find", 2) => "find",
            _ => return None,
        };
        if kind != "list"
            && (std::env::var("FWP_ITER_CONSUMERS").is_ok_and(|v| v == "0")
                || !closure(self.funcs, &args[0]))
        {
            return None;
        }
        let it = args.last()?;
        // a stage's function: a closure built from known functions, which
        // the step applies to each element (and the optimizer then turns
        // into direct calls)
        enum St {
            Map(Expr),
            Filter(Expr),
            Take(usize),
        }
        let funcs = self.funcs;
        // outermost first, as written in the IR
        // with the element type after each stage
        let mut raw: Vec<(&str, &Expr, MT)> = Vec::new();
        let mut cur = it;
        while let Expr::Call(id, a) = cur {
            let kind = match (self.std_name(*id), a.len()) {
                (Some("std::iter.map"), 2) => "map",
                (Some("std::iter.filter"), 2) => "filter",
                (Some("std::iter.take"), 2) => "take",
                _ => break,
            };
            raw.push((kind, &a[0], elem(funcs[*id].ty.params(2).1)?));
            cur = &a[1];
        }
        if raw.is_empty() && kind == "list" {
            return None;
        }
        let iterator_ty = self.ty_in(&self.locals, cur)?;
        let src_elem = elem(&iterator_ty)?;
        let result_ty = funcs[consumer].ty.params(args.len()).1.clone();
        let i64 = MT::con("std::I64");
        // Both count-from and iterate compute the next element while building
        // the current Yield, even when the first take is already exhausted.
        enum Source {
            Successors { initial: Expr, advance: Expr },
            List(Expr),
            Array(Expr),
        }
        let producer = if std::env::var("FWP_ITER_PRODUCERS").is_ok_and(|v| v == "0") {
            None
        } else if let Expr::Call(id, arguments) = cur {
            match (self.std_name(*id), arguments.as_slice()) {
                (Some("std::iter.count-from"), [initial]) if src_elem == i64 => {
                    let add = self.prim("prim.add", fun2(&i64, &i64, &i64), 2);
                    Some(Source::Successors {
                        initial: initial.clone(),
                        advance: Expr::Apply(
                            Box::new(Expr::Func(add)),
                            vec![Expr::Const(Value::I64(1))],
                        ),
                    })
                }
                (Some("std::iter.iterate"), [advance, initial]) if closure(funcs, advance) => {
                    Some(Source::Successors {
                        initial: initial.clone(),
                        advance: advance.clone(),
                    })
                }
                (Some("std::iter.from-list"), [list]) => {
                    if let Expr::Call(convert, input) = list {
                        if prim_sym(funcs, *convert) == Some("array.to-list") && input.len() == 1 {
                            Some(Source::Array(input[0].clone()))
                        } else {
                            Some(Source::List(list.clone()))
                        }
                    } else {
                        Some(Source::List(list.clone()))
                    }
                }
                _ => None,
            }
        } else {
            None
        };
        let src_ty = match &producer {
            Some(Source::Successors { .. }) => MT::Record(vec![
                ("0".into(), src_elem.clone()),
                ("1".into(), src_elem.clone()),
            ]),
            Some(Source::List(source)) => self.ty_in(&self.locals, source)?,
            Some(Source::Array(source)) => MT::Record(vec![
                ("0".into(), self.ty_in(&self.locals, source)?),
                ("1".into(), i64.clone()),
            ]),
            _ => iterator_ty.clone(),
        };
        // An immutable array has no observable work when converted to a list
        // except allocating that list. Keep its owner and read in index order;
        // an option match preserves the existing checked access operation.
        let array_access = if let Some(Source::Array(source)) = &producer {
            let array = self.ty_in(&self.locals, source)?;
            let option = MT::Con("std::Option".into(), vec![src_elem.clone()]);
            self.shapes.entry(option.clone()).or_insert_with(|| {
                TypeShape::Adt(vec![
                    ("None".into(), vec![]),
                    ("Some".into(), vec![src_elem.clone()]),
                ])
            });
            Some((
                self.prim("array.get", fun2(&i64, &array, &option), 2),
                self.prim("prim.add", fun2(&i64, &i64, &i64), 2),
            ))
        } else {
            None
        };
        let lt = self.prim("lt", fun2(&i64, &i64, &MT::con("std::Bool")), 2);
        let subp = self.prim("prim.sub", fun2(&i64, &i64, &i64), 2);
        let rev = (kind == "list").then(|| {
            self.prim(
                "reverse",
                MT::Fun(Box::new(result_ty.clone()), Box::new(result_ty.clone())),
                1,
            )
        });
        // outer values in the unfused order: the stages' arguments
        // outermost first, then the source
        let mut binds: Vec<(Local, Expr)> = Vec::new();
        let initial = match kind {
            "fold" => {
                let local = self.fresh(result_ty.clone());
                binds.push((local, args[1].clone()));
                Expr::Local(local)
            }
            "each" => Expr::Const(Value::unit()),
            _ => Expr::Construct(0, vec![]),
        };
        let mut stages: Vec<St> = Vec::new();
        let mut takes: Vec<Expr> = Vec::new();
        for (kind, arg, _) in &raw {
            match *kind {
                "take" => {
                    let v = match arg {
                        Expr::Local(_) | Expr::Const(_) => (*arg).clone(),
                        _ => {
                            let l = self.fresh(i64.clone());
                            binds.push((l, (*arg).clone()));
                            Expr::Local(l)
                        }
                    };
                    takes.push(v);
                    stages.push(St::Take(takes.len() - 1));
                }
                k => {
                    if !closure(funcs, arg) {
                        return None;
                    }
                    stages.push(if k == "map" {
                        St::Map((*arg).clone())
                    } else {
                        St::Filter((*arg).clone())
                    });
                }
            }
        }
        stages.reverse(); // the source's side first
        let source = match &producer {
            Some(Source::Successors { initial, advance }) => {
                let current = self.fresh(src_elem.clone());
                binds.push((current, initial.clone()));
                Expr::Record(vec![
                    Expr::Local(current),
                    Expr::Apply(Box::new(advance.clone()), vec![Expr::Local(current)]),
                ])
            }
            Some(Source::List(list)) => list.clone(),
            Some(Source::Array(array)) => {
                Expr::Record(vec![array.clone(), Expr::Const(Value::I64(0))])
            }
            _ => cur.clone(),
        };
        let src = {
            let l = self.fresh(src_ty.clone());
            binds.push((l, source));
            Expr::Local(l)
        };
        // the state: the iterator, the list so far (reversed), the take
        // counters, then captured locals
        let nt = takes.len();
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
                    Expr::Field(Box::new(Expr::Local(0)), (2 + nt + i) as u32)
                }
                _ => e.clone(),
            }
        };
        let st = |i: usize| Expr::Field(Box::new(Expr::Local(0)), i as u32);
        let mut calls: Vec<Option<Expr>> = Vec::new();
        for s in &stages {
            calls.push(match s {
                St::Map(f) | St::Filter(f) => Some(map_locals(f, &mut field)),
                St::Take(_) => None,
            });
        }
        let callback = (kind != "list").then(|| map_locals(&args[0], &mut field));
        let advance = match &producer {
            Some(Source::Successors { advance, .. }) => Some(map_locals(advance, &mut field)),
            _ => None,
        };
        let nout = outer.len();
        let mut fields = vec![
            ("0".to_string(), src_ty.clone()),
            ("1".to_string(), result_ty.clone()),
        ];
        fields.extend((0..nt).map(|i| ((i + 2).to_string(), i64.clone())));
        fields.extend(
            outer
                .iter()
                .enumerate()
                .map(|(i, l)| ((i + 2 + nt).to_string(), self.locals[*l as usize].clone())),
        );
        MT::sort_fields(&mut fields);
        let state_ty = MT::Record(fields);
        // step locals: the state, the source's head and tail, then the
        // stages' results
        let (h, t) = (1 as Local, 2 as Local);
        let mut nl: Vec<MT> = vec![
            state_ty.clone(),
            src_elem.clone(),
            match &producer {
                Some(Source::Successors { .. }) => src_elem,
                Some(Source::List(_)) => src_ty.clone(),
                Some(Source::Array(_)) => i64.clone(),
                _ => MT::Fun(Box::new(MT::unit()), Box::new(iterator_ty.clone())),
            },
        ];
        let unit = Expr::Const(Value::unit());
        let less_than_one = |c: Expr| Expr::Call(lt, vec![Expr::Const(Value::I64(1)), c]);
        // go on to the next element, or stop when a take is exhausted
        let go_on = |acc: Expr, counters: &[Expr], reached: &[usize]| {
            let tail = match &producer {
                Some(Source::Successors { .. }) => Expr::Record(vec![
                    Expr::Local(t),
                    Expr::Apply(
                        Box::new(advance.clone().expect("successor function")),
                        vec![Expr::Local(t)],
                    ),
                ]),
                Some(Source::List(_)) => Expr::Local(t),
                Some(Source::Array(_)) => {
                    Expr::Record(vec![Expr::Field(Box::new(st(0)), 0), Expr::Local(t)])
                }
                _ => Expr::Apply(Box::new(Expr::Local(t)), vec![unit.clone()]),
            };
            let mut fs = vec![tail, acc.clone()];
            fs.extend(counters.iter().cloned());
            fs.extend((0..nout).map(|i| st(2 + nt + i)));
            let mut e = Expr::Construct(0, vec![Expr::Record(fs)]);
            for &k in reached.iter().rev() {
                e = Expr::Match(
                    Box::new(less_than_one(counters[k].clone())),
                    vec![
                        (
                            Pat::Construct(1, vec![]),
                            Expr::Construct(1, vec![acc.clone()]),
                        ),
                        (Pat::Wild, e),
                    ],
                );
            }
            e
        };
        // the element through the stages, innermost (source side) first;
        // built from the end, so collect the steps first
        enum Do {
            Let(Local, Expr),
            Guard(Expr, Vec<Expr>, Vec<usize>),
            Take(Expr),
        }
        let mut steps: Vec<Do> = Vec::new();
        let mut reached = Vec::new();
        let mut x = Expr::Local(h);
        let mut counters: Vec<Expr> = (0..nt).map(|k| st(2 + k)).collect();
        let elems = raw.iter().rev().map(|(_, _, t)| t.clone());
        for ((s, c), e) in stages.iter().zip(&calls).zip(elems) {
            match (s, c) {
                (St::Map(_), Some(f)) => {
                    let l = nl.len() as Local;
                    nl.push(e);
                    steps.push(Do::Let(
                        l,
                        Expr::Apply(Box::new(f.clone()), vec![x.clone()]),
                    ));
                    x = Expr::Local(l);
                }
                (St::Filter(_), Some(f)) => {
                    let cond = Expr::Apply(Box::new(f.clone()), vec![x.clone()]);
                    steps.push(Do::Guard(cond, counters.clone(), reached.clone()));
                }
                (St::Take(k), _) => {
                    steps.push(Do::Take(less_than_one(counters[*k].clone())));
                    reached.push(*k);
                    let l = nl.len() as Local;
                    nl.push(i64.clone());
                    steps.push(Do::Let(
                        l,
                        Expr::Call(subp, vec![Expr::Const(Value::I64(1)), counters[*k].clone()]),
                    ));
                    counters[*k] = Expr::Local(l);
                }
                _ => return None,
            }
        }
        let mut body = match kind {
            "list" => go_on(Expr::Construct(1, vec![x, st(1)]), &counters, &reached),
            "find" => Expr::Match(
                Box::new(Expr::Apply(Box::new(callback?), vec![x.clone()])),
                vec![
                    (
                        Pat::Construct(1, vec![]),
                        Expr::Construct(1, vec![Expr::Construct(1, vec![x])]),
                    ),
                    (Pat::Wild, go_on(st(1), &counters, &reached)),
                ],
            ),
            "fold" | "each" => {
                // Finish the callback before forcing the tail. In particular,
                // failure must not evaluate a poisonous next element.
                let local = nl.len() as Local;
                nl.push(result_ty.clone());
                let inputs = if kind == "fold" {
                    vec![st(1), x]
                } else {
                    vec![x]
                };
                Expr::Let(
                    local,
                    Box::new(Expr::Apply(Box::new(callback?), inputs)),
                    Box::new(go_on(Expr::Local(local), &counters, &reached)),
                )
            }
            _ => unreachable!(),
        };
        for d in steps.into_iter().rev() {
            body = match d {
                Do::Let(l, v) => Expr::Let(l, Box::new(v), Box::new(body)),
                Do::Take(exhausted) => Expr::Match(
                    Box::new(exhausted),
                    vec![
                        (Pat::Construct(1, vec![]), Expr::Construct(1, vec![st(1)])),
                        (Pat::Wild, body),
                    ],
                ),
                Do::Guard(cond, cs, reached) => Expr::Match(
                    Box::new(cond),
                    vec![
                        (Pat::Construct(1, vec![]), body),
                        (Pat::Wild, go_on(st(1), &cs, &reached)),
                    ],
                ),
            };
        }
        let stop = Expr::Construct(1, vec![st(1)]);
        let body = if matches!(producer, Some(Source::Successors { .. })) {
            // Read the pair as fields: matching a whole nested record would
            // reconstruct a box in the flattened loop worker on every step.
            Expr::Let(
                h,
                Box::new(Expr::Field(Box::new(st(0)), 0)),
                Box::new(Expr::Let(
                    t,
                    Box::new(Expr::Field(Box::new(st(0)), 1)),
                    Box::new(body),
                )),
            )
        } else if let Some((get, next)) = array_access {
            let index = Expr::Field(Box::new(st(0)), 1);
            Expr::Match(
                Box::new(Expr::Call(
                    get,
                    vec![index.clone(), Expr::Field(Box::new(st(0)), 0)],
                )),
                vec![
                    (
                        Pat::Construct(1, vec![Pat::Bind(h)]),
                        Expr::Let(
                            t,
                            Box::new(Expr::Call(next, vec![Expr::Const(Value::I64(1)), index])),
                            Box::new(body),
                        ),
                    ),
                    (Pat::Wild, stop.clone()),
                ],
            )
        } else {
            Expr::Match(
                Box::new(st(0)),
                vec![
                    (Pat::Construct(1, vec![Pat::Bind(h), Pat::Bind(t)]), body),
                    (Pat::Wild, stop.clone()),
                ],
            )
        };
        let step_result = MT::Con(
            "std::Step".into(),
            vec![state_ty.clone(), result_ty.clone()],
        );
        // Ownership lowering needs the fields of compiler-generated variants
        // just as it needs the fields registered during monomorphization.
        self.shapes.entry(step_result.clone()).or_insert_with(|| {
            TypeShape::Adt(vec![
                ("Again".into(), vec![state_ty.clone()]),
                ("Stop".into(), vec![result_ty.clone()]),
            ])
        });
        let step_ty = MT::Fun(Box::new(state_ty.clone()), Box::new(step_result));
        let all: Vec<Func> = self.funcs.iter().chain(&self.made).cloned().collect();
        let (body, locals) = crate::opt::simplify(&all, self.shapes, body, nl);
        let step = self.new_func(Func {
            name: "fused-iter".into(),
            arity: 1,
            locals,
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
        let mut init = vec![src, initial];
        init.extend(takes);
        init.extend(outer.into_iter().map(Expr::Local));
        let mut out = Expr::Call(loop_id, vec![Expr::Func(step), Expr::Record(init)]);
        if let Some(rev) = rev {
            out = Expr::Call(rev, vec![out]);
        }
        for (l, v) in binds.into_iter().rev() {
            out = Expr::Let(l, Box::new(v), Box::new(out));
        }
        Some(out)
    }

    /// The primitive a fused pipeline can end in, if `id` is one.
    fn consumer(&self, id: FuncId, args: &[Expr]) -> Option<&'static str> {
        match (prim_sym(self.funcs, id)?, args.len()) {
            ("array.from-list", 1)
                if std::env::var("FWP_ARRAY_FUSION").map_or(true, |v| v != "0") =>
            {
                Some("array-map-list")
            }
            ("fold", 3) => Some("fold"),
            ("array.fold", 3) if std::env::var("FWP_ARRAY_FUSION").map_or(true, |v| v != "0") => {
                Some("array-fold")
            }
            ("array.length", 1) if std::env::var("FWP_ARRAY_FUSION").map_or(true, |v| v != "0") => {
                Some("array-length")
            }
            ("length", 1) => Some("length"),
            ("find", 2) => Some("find"),
            _ => None,
        }
    }

    /// `consumer (stages (producer))` as a loop, when that is safe: a
    /// `fold g z`, `length`, or `find p` (which stops at the first match,
    /// so the stages before it may not trap at all).
    fn consume(&mut self, cons_id: FuncId, args: &[Expr]) -> Option<Expr> {
        let kind = self.consumer(cons_id, args)?;
        // Specializing a known callback can bind its eager captures before
        // building the producer. Keep those computations outside the loop and
        // in order. Only cross consumer arguments with no effects or traps.
        if let Some(Expr::Let(local, value, body)) = args.last() {
            if args[..args.len() - 1]
                .iter()
                .all(|arg| self.beh.expr(arg) == none())
            {
                let mut inner = args.to_vec();
                *inner.last_mut().unwrap() = (**body).clone();
                let consumed = self.consume(cons_id, &inner)?;
                return Some(Expr::Let(*local, value.clone(), Box::new(consumed)));
            }
            return None;
        }
        if kind == "array-map-list" {
            if std::env::var("FWP_MAP_ARRAY").as_deref() == Ok("0") {
                return None;
            }
            let Expr::Call(map, inputs) = &args[0] else {
                return None;
            };
            if prim_sym(self.funcs, *map) != Some("map") || inputs.len() != 2 {
                return None;
            }
            let result = self.funcs[cons_id].ty.params(1).1.clone();
            let MT::Con(name, elements) = &result else {
                return None;
            };
            if name != "std::Array" || elements.len() != 1 || !unboxed_numeric(&elements[0]) {
                return None;
            }
            // Callbacks still run in list order, all before array construction.
            // Restrict outputs to inline numbers: there are no result resources
            // whose destruction could move relative to later callbacks.
            let parameters = self.funcs[*map].ty.params(2).0;
            let ty = fun2(parameters[0], parameters[1], &result);
            let fused = self.prim("array._map-list", ty, 2);
            return Some(Expr::Call(fused, inputs.clone()));
        }
        let (cparams, result_ty) = self.funcs[cons_id].ty.params(args.len());
        let cparams: Vec<MT> = cparams.into_iter().cloned().collect();
        let result_ty = result_ty.clone();
        self.fuse_chain(kind, args, cparams, result_ty)
    }

    /// A chain of at least two `map` and `filter` stages whose list is
    /// used as such: one pass that conses the elements in reverse, then a
    /// `reverse`, instead of a list per stage.
    fn materialize(&mut self, chain: &Expr) -> Option<Expr> {
        let mut n = 0;
        let mut cur = chain;
        while let Expr::Call(id, a) = cur {
            match prim_sym(self.funcs, *id) {
                Some("map" | "filter") if a.len() == 2 => {
                    n += 1;
                    cur = &a[1];
                }
                _ => break,
            }
        }
        if n < 2 {
            return None;
        }
        let Expr::Call(top, _) = chain else {
            return None;
        };
        let list_ty = self.funcs[*top].ty.params(2).1.clone();
        self.fuse_chain(
            "list",
            std::slice::from_ref(chain),
            vec![list_ty.clone()],
            list_ty,
        )
    }

    /// Run after existing consumers have fused: replacing map too early would
    /// hide it from fold/array construction and reintroduce their list results.
    /// Numeric zip inputs have no resource owners whose destruction would move
    /// across a callback. Keep both eager inputs and the existing zip-with result
    /// cleanup, but specialize away the pair consumed by a known map function.
    fn map_zip(&mut self, map: FuncId, args: &[Expr]) -> Option<Expr> {
        if std::env::var("FWP_ZIP_MAP").as_deref() == Ok("0") {
            return None;
        }
        let (callback, captures) = fn_value(self.funcs, &args[0], 1)?;
        let mut producer = &args[1];
        let mut bindings = Vec::new();
        while let Expr::Let(local, value, body) = producer {
            let ty = self.locals.get(*local as usize)?;
            let numeric_list = matches!(ty, MT::Con(name, elements)
                if name == "std::List" && elements.len() == 1 && unboxed_numeric(&elements[0]));
            if !unboxed_numeric(ty) && !numeric_list {
                return None;
            }
            // Only numeric owners can remain live through the mapped callbacks;
            // extending a resource-bearing local's lifetime is observable.
            bindings.push((*local, (**value).clone()));
            producer = body;
        }
        let Expr::Call(zip, inputs) = producer else {
            return None;
        };
        if prim_sym(self.funcs, *zip) != Some("zip") || inputs.len() != 2 {
            return None;
        }
        let (zip_params, _) = self.funcs[*zip].ty.params(2);
        let left = elem(zip_params[0])?;
        let right = elem(zip_params[1])?;
        if !unboxed_numeric(&left) || !unboxed_numeric(&right) {
            return None;
        }
        let (callback_params, result) = self.funcs[callback].ty.params(captures.len() + 1);
        let result = result.clone();
        let mut parameters: Vec<MT> = callback_params[..captures.len()]
            .iter()
            .map(|ty| (*ty).clone())
            .collect();
        parameters.extend([left.clone(), right.clone()]);
        let n = captures.len() as Local;
        let mut call: Vec<Expr> = (0..n).map(Expr::Local).collect();
        // zip ys xs forms (x, y), while zip-with calls f y x.
        call.push(Expr::Record(vec![Expr::Local(n + 1), Expr::Local(n)]));
        let body = Expr::Call(callback, call);
        let all: Vec<Func> = self.funcs.iter().chain(&self.made).cloned().collect();
        let (body, locals) = crate::opt::simplify(&all, self.shapes, body, parameters.clone());
        let ty = parameters
            .into_iter()
            .rev()
            .fold(result.clone(), |result, parameter| {
                MT::Fun(Box::new(parameter), Box::new(result))
            });
        let specialized = self.new_func(Func {
            name: "fused-zip-map".into(),
            arity: n + 2,
            locals,
            ty,
            body: Body::Expr(body),
        });
        let function = if captures.is_empty() {
            Expr::Func(specialized)
        } else {
            Expr::Apply(Box::new(Expr::Func(specialized)), captures)
        };
        let output = self.funcs[map].ty.params(2).1.clone();
        let callback_ty = fun2(&left, &right, &result);
        let zip_ty = MT::Fun(
            Box::new(callback_ty),
            Box::new(fun2(zip_params[0], zip_params[1], &output)),
        );
        let zip_with = self.prim("zip-with", zip_ty, 3);
        let mut result = Expr::Call(
            zip_with,
            vec![function, inputs[0].clone(), inputs[1].clone()],
        );
        for (local, value) in bindings.into_iter().rev() {
            result = Expr::Let(local, Box::new(value), Box::new(result));
        }
        Some(result)
    }

    /// Lists built by `map` and `filter` chains no consumer took: fused
    /// one by one, outermost first.
    fn lists(&mut self, e: Expr) -> Expr {
        // Optimizer ANF binds stage results before the next stage/consumer.
        // Rejoin an immediately consumed single-use value only when preceding
        // arguments are total: this preserves eager initial-stage evaluation.
        if let Expr::Let(local, value, body) = &e {
            if crate::opt::uses(body, *local) == 1 {
                let mut body = (**body).clone();
                if let Expr::Call(id, args) = first_evaluated(&mut body) {
                    if prim_sym(self.funcs, *id) == Some("map")
                        && args.len() == 2
                        && matches!(&args[1], Expr::Local(l) if l == local)
                        && self.beh.expr(&args[0]) == none()
                    {
                        let inputs = vec![args[0].clone(), (**value).clone()];
                        if let Some(fused) = self.map_zip(*id, &inputs) {
                            *first_evaluated(&mut body) = fused;
                            return self.lists(body);
                        }
                    }
                    if matches!(
                        self.std_name(*id),
                        Some(
                            "std::iter.map"
                                | "std::iter.filter"
                                | "std::iter.take"
                                | "std::iter.fold"
                                | "std::iter.each"
                                | "std::iter.find"
                                | "std::iter.to-list"
                        )
                    ) && matches!(args.last(), Some(Expr::Local(l)) if l == local)
                        && args[..args.len() - 1]
                            .iter()
                            .all(|a| self.beh.expr(a) == none())
                    {
                        *args.last_mut().unwrap() = (**value).clone();
                        return self.lists(body);
                    }
                }
            }
        }
        if let Expr::Call(id, args) = &e {
            if let Some(r) = self.iter_consume(*id, args) {
                return r;
            }
        }
        if let Expr::Call(id, _) = &e {
            if matches!(prim_sym(self.funcs, *id), Some("map" | "filter")) {
                if let Some(r) = self.materialize(&e) {
                    return r;
                }
                if prim_sym(self.funcs, *id) == Some("map") {
                    let Expr::Call(_, args) = &e else {
                        unreachable!()
                    };
                    if args.len() == 2 {
                        if let Some(r) = self.map_zip(*id, args) {
                            return r;
                        }
                    }
                }
            }
        }
        match e {
            Expr::Call(id, args) => {
                Expr::Call(id, args.into_iter().map(|a| self.lists(a)).collect())
            }
            Expr::Apply(f, args) => Expr::Apply(
                Box::new(self.lists(*f)),
                args.into_iter().map(|a| self.lists(a)).collect(),
            ),
            Expr::Construct(t, a) => {
                Expr::Construct(t, a.into_iter().map(|x| self.lists(x)).collect())
            }
            Expr::Record(a) => Expr::Record(a.into_iter().map(|x| self.lists(x)).collect()),
            Expr::Field(r, i) => Expr::Field(Box::new(self.lists(*r)), i),
            Expr::SetFields(r, s) => Expr::SetFields(
                Box::new(self.lists(*r)),
                s.into_iter().map(|(i, x)| (i, self.lists(x))).collect(),
            ),
            Expr::Let(l, v, b) => Expr::Let(l, Box::new(self.lists(*v)), Box::new(self.lists(*b))),
            Expr::Match(sc, arms) => Expr::Match(
                Box::new(self.lists(*sc)),
                arms.into_iter().map(|(p, b)| (p, self.lists(b))).collect(),
            ),
            e => e,
        }
    }

    /// The loop for `kind` (`fold`, `length`, `find` or `list`) over the
    /// stages and producer of its last argument.
    fn fuse_chain(
        &mut self,
        kind: &'static str,
        args: &[Expr],
        cparams: Vec<MT>,
        result_ty: MT,
    ) -> Option<Expr> {
        let array = kind.starts_with("array-");
        let kind = match kind {
            "array-fold" => "fold",
            "array-length" => "length",
            other => other,
        };
        let accumulator = if array { 2 } else { 1 };
        let capture_start = if array { 3 } else { 2 };
        let funcs = self.funcs;
        let list = args.last()?;
        let mut stages = Vec::new();
        let mut cur = list;
        loop {
            match cur {
                Expr::Call(id, a) if a.len() == 2 => match prim_sym(funcs, *id) {
                    Some("map") if !array => stages.push(Stage::Map(a[0].clone())),
                    Some("filter") if !array => stages.push(Stage::Filter(a[0].clone())),
                    Some("array.map") if array => stages.push(Stage::Map(a[0].clone())),
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
            e if array && !stages.is_empty() => Producer::Array(e.clone()),
            _ if array => return None,
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
        // the producer's list: its own type, or the list of what the
        // innermost stage takes
        let prod_ty = match &producer {
            Producer::Range(_, _, t) => t.clone(),
            Producer::List(e) | Producer::Array(e) => match self.ty_in(&self.locals, e) {
                Some(t) => t,
                None => {
                    let (id, caps) = fns.last()?;
                    let (ps, _) = funcs[*id].ty.params(caps.len() + 1);
                    MT::Con("std::List".into(), vec![(*ps.last()?).clone()])
                }
            },
        };
        if array {
            if !elem(&prod_ty).is_some_and(|t| unboxed_numeric(&t)) {
                return None;
            }
            for (id, captures) in &fns {
                let (params, result) = funcs[*id].ty.params(captures.len() + 1);
                if !unboxed_numeric(params.last()?) || !unboxed_numeric(result) {
                    return None;
                }
            }
            if kind == "fold" && (!unboxed_numeric(&cparams[1]) || !unboxed_numeric(&result_ty)) {
                return None;
            }
        }
        // the accumulator: a fold's, a count, the list so far in reverse,
        // or nothing (`find`)
        let (z, acc_ty) = match kind {
            "fold" => (args[1].clone(), cparams[1].clone()),
            "length" => (Expr::Const(Value::I64(0)), MT::con("std::I64")),
            "list" => (Expr::Construct(0, vec![]), result_ty.clone()),
            _ => (Expr::Const(Value::unit()), MT::unit()),
        };

        // Outer values, evaluated in the order the unfused program evaluates
        // them: g, z, the stages outermost first, then the producer.
        let mut binds: Vec<(Local, Expr)> = Vec::new();
        let mut bind = |me: &mut Self, e: &Expr, ty: &MT| -> Expr {
            match e {
                Expr::Local(_) | Expr::Const(_) => e.clone(),
                _ => {
                    let l = me.fresh(ty.clone());
                    binds.push((l, e.clone()));
                    Expr::Local(l)
                }
            }
        };
        let z = bind(self, &z, &acc_ty);
        let (start, end) = match &producer {
            Producer::Range(a, b, t) => (bind(self, a, t), Some(bind(self, b, t))),
            Producer::List(e) => (bind(self, e, &prod_ty), None),
            Producer::Array(e) => (
                Expr::Record(vec![Expr::Const(Value::I64(0)), bind(self, e, &prod_ty)]),
                None,
            ),
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
                    Expr::Field(Box::new(Expr::Local(0)), (i + capture_start) as u32)
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

        // step locals: 0 is the state; 1 and 2 the head and tail of a
        // list; then the stages' results (typed once the state's type is
        // known, below)
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
            Producer::List(_) | Producer::Array(_) => {
                let (h, t) = (next(&mut nl), next(&mut nl));
                (Expr::Local(h), Expr::Local(t), Some((h, t)))
            }
        };
        let again = |pos: &Expr, acc: Expr, n: usize| {
            let mut fs = if array {
                vec![pos.clone(), st(1), acc]
            } else {
                vec![pos.clone(), acc]
            };
            fs.extend((0..n).map(|i| st((i + capture_start) as u32)));
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
            "fold" => Ok(apply(
                &mut field,
                cv.as_ref()?,
                vec![st(accumulator), x.clone()],
            )),
            "list" => Ok(Expr::Construct(1, vec![x.clone(), st(accumulator)])),
            "length" => {
                let i64 = MT::con("std::I64");
                let add = self.prim("prim.add", fun2(&i64, &i64, &i64), 2);
                Ok(Expr::Call(
                    add,
                    vec![Expr::Const(Value::I64(1)), st(accumulator)],
                ))
            }
            _ => Err(apply(&mut field, cv.as_ref()?, vec![x.clone()])),
        };
        let n = outer.len();
        let skip = again(&next_pos, st(accumulator), n);
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
                st(accumulator)
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
            Producer::Array(_) => {
                let (h, t) = cell?;
                let index_ty = MT::con("std::I64");
                let element = elem(&prod_ty)?;
                let option = MT::Con("std::Option".into(), vec![element]);
                let get = self.prim("array.get", fun2(&index_ty, &prod_ty, &option), 2);
                // The index starts at zero and advances only after a successful
                // array.get. Array lengths reserve the header's high bit for
                // views, so position < length <= I64::MAX here. Adding one
                // cannot overflow; user callback arithmetic remains checked.
                let add = self.prim("wrapping.add", fun2(&index_ty, &index_ty, &index_ty), 2);
                let position = st(0);
                let input = st(1);
                let next = Expr::Call(add, vec![Expr::Const(Value::I64(1)), position.clone()]);
                Expr::Match(
                    Box::new(Expr::Call(get, vec![position, input])),
                    vec![
                        (
                            Pat::Construct(1, vec![Pat::Bind(h)]),
                            Expr::Let(t, Box::new(next), Box::new(body)),
                        ),
                        (Pat::Wild, stop),
                    ],
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
            Producer::List(_) => prod_ty.clone(),
            Producer::Array(_) => MT::con("std::I64"),
        };
        let mut fields = if array {
            vec![
                ("0".into(), pos_ty.clone()),
                ("1".into(), prod_ty.clone()),
                ("2".into(), acc_ty.clone()),
            ]
        } else {
            vec![("0".into(), pos_ty.clone()), ("1".into(), acc_ty.clone())]
        };
        fields.extend(outer.iter().enumerate().map(|(i, l)| {
            (
                (i + capture_start).to_string(),
                self.locals[*l as usize].clone(),
            )
        }));
        MT::sort_fields(&mut fields);
        let state_ty = MT::Record(fields);
        // the step's locals: the state, a list's head and tail, the stages'
        // results (calls of known functions)
        let mut step_locals = vec![state_ty.clone()];
        if cell.is_some() {
            step_locals.extend([elem(&prod_ty)?, pos_ty]);
        }
        for (l, v) in &lets {
            debug_assert_eq!(*l as usize, step_locals.len());
            step_locals.push(self.ty_in(&[], v)?);
        }
        debug_assert_eq!(step_locals.len(), nl as usize);
        let step_result = MT::Con(
            "std::Step".into(),
            vec![state_ty.clone(), result_ty.clone()],
        );
        // Ownership lowering needs the fields of compiler-generated variants
        // just as it needs the fields registered during monomorphization.
        self.shapes.entry(step_result.clone()).or_insert_with(|| {
            TypeShape::Adt(vec![
                ("Again".into(), vec![state_ty.clone()]),
                ("Stop".into(), vec![result_ty.clone()]),
            ])
        });
        let step_ty = MT::Fun(Box::new(state_ty.clone()), Box::new(step_result));
        let all: Vec<Func> = self.funcs.iter().chain(&self.made).cloned().collect();
        let (body, locals) = crate::opt::simplify(&all, self.shapes, body, step_locals);
        // the step may have inlined pipelines (from the functions as they
        // were before this pass): fuse those too
        let saved = std::mem::replace(&mut self.locals, locals);
        let body = self.expr(body);
        let locals = std::mem::replace(&mut self.locals, saved);
        let step = self.new_func(Func {
            name: "fused".into(),
            arity: 1,
            locals,
            ty: step_ty.clone(),
            body: Body::Expr(body),
        });
        let loop_id = self.prim(
            "loop",
            MT::Fun(
                Box::new(step_ty),
                Box::new(MT::Fun(Box::new(state_ty), Box::new(result_ty.clone()))),
            ),
            2,
        );
        let mut init = if array {
            let Expr::Record(mut positions) = start else {
                return None;
            };
            positions.push(z);
            positions
        } else {
            vec![start, z]
        };
        init.extend(outer.into_iter().map(Expr::Local));
        let mut out = Expr::Call(loop_id, vec![Expr::Func(step), Expr::Record(init)]);
        if kind == "list" {
            let ty = MT::Fun(Box::new(result_ty.clone()), Box::new(result_ty.clone()));
            let rev = self.prim("reverse", ty, 1);
            out = Expr::Call(rev, vec![out]);
        }
        for (l, v) in binds.into_iter().rev() {
            out = Expr::Let(l, Box::new(v), Box::new(out));
        }
        Some(out)
    }
}

/// A function value whose construction can do nothing: a known function,
/// a local or constant, or a known function partially applied to such.
fn closure(funcs: &[Func], e: &Expr) -> bool {
    fn arg(funcs: &[Func], e: &Expr) -> bool {
        matches!(e, Expr::Local(_) | Expr::Const(_)) || closure(funcs, e)
    }
    match e {
        Expr::Local(_) => true,
        Expr::Func(id) => funcs[*id].arity > 0,
        Expr::Apply(f, a) => match &**f {
            Expr::Func(id) => {
                a.len() < funcs[*id].arity as usize && a.iter().all(|x| arg(funcs, x))
            }
            _ => false,
        },
        _ => false,
    }
}

/// `e` with each local replaced by `f(local)` (for expressions without
/// binders: closures and their arguments).
fn map_locals(e: &Expr, f: &mut dyn FnMut(&Expr) -> Expr) -> Expr {
    match e {
        Expr::Local(_) => f(e),
        Expr::Apply(g, a) => Expr::Apply(
            Box::new(map_locals(g, f)),
            a.iter().map(|x| map_locals(x, f)).collect(),
        ),
        Expr::Call(g, a) => Expr::Call(*g, a.iter().map(|x| map_locals(x, f)).collect()),
        Expr::Record(a) => Expr::Record(a.iter().map(|x| map_locals(x, f)).collect()),
        Expr::Construct(t, a) => Expr::Construct(*t, a.iter().map(|x| map_locals(x, f)).collect()),
        _ => e.clone(),
    }
}

/// The first evaluated operation, through lets and trivial record prefixes.
/// Reading a local/constant cannot move an effect or a resource frame. Stop at
/// every other preceding expression, even a function value of unknown arity.
fn first_evaluated(e: &mut Expr) -> &mut Expr {
    let first_field = match &*e {
        Expr::Record(fields) => fields
            .iter()
            .position(|field| !matches!(field, Expr::Local(_) | Expr::Const(_))),
        _ => None,
    };
    match (e, first_field) {
        (Expr::Let(_, v, _), _) => first_evaluated(v),
        (Expr::Record(fields), Some(first)) => first_evaluated(&mut fields[first]),
        (e, _) => e,
    }
}

/// The element type of a list or iterator type.
fn elem(t: &MT) -> Option<MT> {
    match t {
        MT::Con(_, a) if a.len() == 1 => Some(a[0].clone()),
        _ => None,
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
    let elements: Vec<_> = prog
        .funcs
        .iter()
        .flat_map(|f| &f.locals)
        .filter_map(|ty| match ty {
            MT::Con(name, args)
                if name == "std::Array" && args.len() == 1 && unboxed_numeric(&args[0]) =>
            {
                Some(args[0].clone())
            }
            _ => None,
        })
        .collect();
    for element in elements {
        prog.shapes
            .entry(MT::Con("std::Option".into(), vec![element.clone()]))
            .or_insert_with(|| {
                TypeShape::Adt(vec![
                    ("None".into(), vec![]),
                    ("Some".into(), vec![element]),
                ])
            });
    }
    let snapshot = prog.funcs.clone();
    let std_names = prog.std_names.clone();
    let mut made = Vec::new();
    for id in 0..snapshot.len() {
        let Body::Expr(body) = &snapshot[id].body else {
            continue;
        };
        let mut f = Fuser {
            funcs: &snapshot,
            shapes: &mut prog.shapes,
            std_names: &std_names,
            beh: Behaviors::new(&snapshot),
            made: std::mem::take(&mut made),
            locals: snapshot[id].locals.clone(),
        };
        let body = f.expr(body.clone());
        let body = f.lists(body);
        made = f.made;
        prog.funcs[id].body = Body::Expr(body);
        prog.funcs[id].locals = f.locals;
    }
    prog.funcs.extend(made);
}

/// Specialize canonical standard F64 products. Overlapping primitive numeric
/// impls are rejected by inference. Runtime matrix.cast retains its existing
/// behavior, so incompatible runtime shapes still evaluate the original body.
pub fn specialize_matrices(prog: &mut Program) {
    if std::env::var("FWP_MATRIX_BLOCKING").as_deref() == Ok("0") {
        return;
    }
    let candidates: Vec<_> = prog
        .std_names
        .iter()
        .filter(|(_, name)| name.as_str() == "std::matmul")
        .map(|(id, _)| *id)
        .collect();
    let array = MT::Con("std::Array".into(), vec![MT::con("std::F64")]);
    let integer = MT::con("std::I64");
    for id in candidates {
        let f = &prog.funcs[id];
        if f.arity != 2 {
            continue;
        }
        let (params, result) = f.ty.params(2);
        let matrix = |ty: &MT| {
            matches!(ty, MT::Con(name, args) if name == "std::Matrix" && args.first() == Some(&MT::con("std::F64")))
                && record_fields(&prog.shapes, ty).is_some_and(|fields| {
                    fields
                        == [
                            ("cols".into(), integer.clone()),
                            ("data".into(), array.clone()),
                            ("rows".into(), integer.clone()),
                        ]
                })
        };
        if !params.iter().all(|p| matrix(p)) || !matrix(result) {
            continue;
        }
        let Body::Expr(original) = &f.body else {
            continue;
        };
        let original = original.clone();
        let valid = prog.funcs.len();
        let compute = valid + 1;
        let primitive = |name: &str, locals: Vec<MT>, result: MT| {
            let ty = locals
                .iter()
                .rev()
                .fold(result, |r, p| MT::Fun(Box::new(p.clone()), Box::new(r)));
            Func {
                name: name.into(),
                arity: locals.len() as u32,
                locals,
                ty,
                body: Body::Prim(name.into()),
            }
        };
        prog.funcs.push(primitive(
            "matrix._valid-f64",
            vec![integer.clone(); 4]
                .into_iter()
                .chain([array.clone(), array.clone()])
                .collect(),
            MT::con("std::Bool"),
        ));
        prog.funcs.push(primitive(
            "matrix._mul-f64",
            vec![integer.clone(); 3]
                .into_iter()
                .chain([array.clone(), array.clone()])
                .collect(),
            array.clone(),
        ));
        let field = |local, index| Expr::Field(Box::new(Expr::Local(local)), index);
        // Scalar dimensions and borrowed arrays cross the primitive boundary
        // directly: no temporary Matrix records are needed for either call.
        let valid_args = vec![
            field(1, 2),
            field(1, 0),
            field(0, 2),
            field(0, 0),
            field(1, 1),
            field(0, 1),
        ];
        let compute_args = vec![
            field(1, 2),
            field(1, 0),
            field(0, 0),
            field(1, 1),
            field(0, 1),
        ];
        prog.funcs[id].body = Body::Expr(Expr::Match(
            Box::new(Expr::Call(valid, valid_args)),
            vec![
                (
                    Pat::Construct(1, vec![]),
                    Expr::Record(vec![
                        field(0, 0),
                        Expr::Call(compute, compute_args),
                        field(1, 2),
                    ]),
                ),
                (Pat::Wild, original),
            ],
        ));
    }
}
