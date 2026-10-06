//! Tree-walking interpreter over the monomorphic IR. It runs programs
//! (`fwp run`), tests, and compile-time evaluation.

use std::cell::RefCell;
use std::cmp::Ordering;
use std::io::{Read, Write};
use std::rc::Rc;

use crate::ir::*;
use crate::value::*;

/// Non-local control flow.
#[derive(Debug)]
pub enum Ctl {
    /// The `Error[E]` effect: a value of the given type.
    Fail(Value, MT),
    /// Unrecoverable runtime failure (overflow, division by zero, ...).
    Trap(String),
    /// Process exit requested by the program.
    Exit(i32),
    /// The current task was cancelled (or its deadline passed).
    Cancelled,
}

pub type R<T> = Result<T, Ctl>;

fn trap<T>(msg: impl Into<String>) -> R<T> {
    Err(Ctl::Trap(msg.into()))
}

thread_local! {
    /// The lowest stack address calls may reach on this thread (0: no
    /// limit); see [`set_stack_limit`].
    static STACK_LIMIT: std::cell::Cell<usize> = const { std::cell::Cell::new(0) };
}

/// The current stack position, approximately.
#[inline(always)]
fn stack_position() -> usize {
    let here = 0u8;
    std::hint::black_box(&here) as *const u8 as usize
}

/// Called at the start of a thread with a stack of `size` bytes: calls
/// that get close to its end trap with "stack overflow", as native
/// programs do, instead of aborting the process.
pub fn set_stack_limit(size: usize) {
    let reserve = (size / 16).max(1 << 20);
    let limit = stack_position().saturating_sub(size.saturating_sub(reserve));
    STACK_LIMIT.with(|l| l.set(limit));
}

/// The stack limit of this thread (or WebAssembly fiber), for switching
/// fibers (`fiber.rs`).
#[cfg(target_family = "wasm")]
pub(crate) fn stack_limit() -> usize {
    STACK_LIMIT.with(|l| l.get())
}

#[cfg(target_family = "wasm")]
pub(crate) fn set_raw_stack_limit(limit: usize) {
    STACK_LIMIT.with(|l| l.set(limit));
}

pub struct Interp<'p> {
    pub prog: &'p Program,
    /// Values of argument-less functions, shared by all tasks.
    pub(crate) cafs: Rc<RefCell<Vec<Option<Value>>>>,
    pub(crate) state: Vec<Value>,
    pub(crate) rng: u64,
    pub out: Box<dyn Write + 'p>,
    pub args: Vec<String>,
    pub(crate) world: std::sync::Arc<crate::sched::World>,
    pub(crate) task: std::sync::Arc<crate::sched::TaskShared>,
    /// The root task's writer, shared by every task.
    pub(crate) root_out: *mut (dyn Write + 'p),
    /// Tasks spawned inside each enclosing `task.scope`.
    pub(crate) scopes: Vec<Vec<std::sync::Arc<crate::sched::TaskShared>>>,
    /// The foreign function shim, loaded on the first foreign C call.
    pub(crate) ffi: Rc<RefCell<Option<Rc<crate::ffi_interp::FfiLib>>>>,
    /// The gRPC context of the task: outgoing metadata, call deadline and
    /// the call being served.
    pub(crate) grpc: crate::grpc::TaskCtx,
}

impl<'p> Interp<'p> {
    pub fn new(prog: &'p Program, mut out: Box<dyn Write + 'p>) -> Self {
        let seed = std::env::var("FWP_SEED")
            .ok()
            .and_then(|s| s.parse().ok())
            .unwrap_or_else(|| {
                std::time::SystemTime::now()
                    .duration_since(std::time::UNIX_EPOCH)
                    .map(|d| d.as_nanos() as u64)
                    .unwrap_or(1)
            });
        let root_out: *mut (dyn Write + 'p) = &mut *out;
        Interp {
            prog,
            cafs: Rc::new(RefCell::new(vec![None; prog.funcs.len()])),
            state: Vec::new(),
            rng: seed | 1,
            out,
            args: Vec::new(),
            world: crate::sched::World::new(),
            task: crate::sched::TaskShared::new(),
            root_out,
            scopes: Vec::new(),
            ffi: Rc::new(RefCell::new(None)),
            grpc: Default::default(),
        }
    }

    // ----- evaluation ----------------------------------------------------------

    /// Call a root function (main or a test) and wait for the tasks it
    /// started; when it failed, they are cancelled first.
    pub fn call_root(&mut self, id: FuncId) -> R<Value> {
        crate::sched::start_slice();
        let r = self.call(id, vec![]);
        if r.is_err() {
            self.cancel_children();
        } else {
            self.join_children();
        }
        r
    }

    pub fn call(&mut self, id: FuncId, args: Vec<Value>) -> R<Value> {
        if stack_position() < STACK_LIMIT.with(|l| l.get()) {
            return trap("stack overflow");
        }
        let f = &self.prog.funcs[id];
        if f.arity == 0 {
            if let Some(v) = &self.cafs.borrow()[id] {
                return Ok(v.clone());
            }
        }
        let v = match &f.body {
            Body::Expr(e) => {
                // a safe point: preempted after a slice of function entries
                if crate::sched::tick() {
                    self.preempt()?;
                }
                let mut locals = args;
                locals.resize(f.nlocals() as usize, Value::unit());
                self.eval(e, &mut locals)?
            }
            Body::Prim(sym) => self.prim(id, sym, args)?,
            Body::Ctor(tag) => Value::data(*tag, args),
            Body::ForeignC { .. } => self.call_foreign(id, args)?,
            Body::Remote(r) => crate::grpc::call_remote(self, id, r, args)?,
        };
        if f.arity == 0 {
            self.cafs.borrow_mut()[id] = Some(v.clone());
        }
        Ok(v)
    }

    /// Apply a function value to arguments.
    pub fn apply(&mut self, f: Value, mut args: Vec<Value>) -> R<Value> {
        let mut f = f;
        loop {
            let Value::Closure(c) = &f else {
                return trap(format!("internal: applying a non-function {:?}", f));
            };
            let arity = self.prog.funcs[c.func].arity as usize;
            let have = c.args.len();
            if have + args.len() < arity {
                let mut all = c.args.clone();
                all.extend(args);
                return Ok(Value::Closure(Rc::new(Closure {
                    func: c.func,
                    args: all,
                })));
            }
            let need = arity - have;
            let rest = args.split_off(need);
            let mut all = c.args.clone();
            all.extend(args);
            let r = self.call(c.func, all)?;
            if rest.is_empty() {
                return Ok(r);
            }
            f = r;
            args = rest;
        }
    }

    fn func_value(&mut self, id: FuncId) -> R<Value> {
        if self.prog.funcs[id].arity == 0 {
            self.call(id, vec![])
        } else {
            Ok(Value::Closure(Rc::new(Closure {
                func: id,
                args: vec![],
            })))
        }
    }

    pub fn eval(&mut self, e: &Expr, locals: &mut Vec<Value>) -> R<Value> {
        match e {
            // Rust's reference counts free the interpreter's values
            Expr::Dup(_, b) | Expr::Drop(_, b) => self.eval(b, locals),
            Expr::Local(i) => Ok(locals[*i as usize].clone()),
            Expr::Const(v) => Ok(v.clone()),
            Expr::Func(id) => self.func_value(*id),
            Expr::Call(id, args) => {
                let mut vs = Vec::with_capacity(args.len());
                for a in args {
                    vs.push(self.eval(a, locals)?);
                }
                self.call(*id, vs)
            }
            Expr::Apply(f, args) => {
                let fv = self.eval(f, locals)?;
                let mut vs = Vec::with_capacity(args.len());
                for a in args {
                    vs.push(self.eval(a, locals)?);
                }
                self.apply(fv, vs)
            }
            Expr::Construct(tag, args) => {
                let mut vs = Vec::with_capacity(args.len());
                for a in args {
                    vs.push(self.eval(a, locals)?);
                }
                Ok(Value::data(*tag, vs))
            }
            Expr::Record(args) => {
                let mut vs = Vec::with_capacity(args.len());
                for a in args {
                    vs.push(self.eval(a, locals)?);
                }
                Ok(Value::tuple(vs))
            }
            Expr::Field(r, i) => match &self.eval(r, locals)? {
                Value::Record(fs) => Ok(fs[*i as usize].clone()),
                other => trap(format!("internal: field of non-record {:?}", other)),
            },
            Expr::SetFields(r, sets) => {
                let rv = self.eval(r, locals)?;
                let Value::Record(fs) = &rv else {
                    return trap("internal: update of non-record");
                };
                let mut fs: Vec<Value> = fs.to_vec();
                for (i, x) in sets {
                    fs[*i as usize] = self.eval(x, locals)?;
                }
                Ok(Value::tuple(fs))
            }
            Expr::Let(l, v, body) => {
                let x = self.eval(v, locals)?;
                locals[*l as usize] = x;
                self.eval(body, locals)
            }
            Expr::Match(scrut, arms) => {
                let v = self.eval(scrut, locals)?;
                for (p, body) in arms {
                    if bind(p, &v, locals) {
                        return self.eval(body, locals);
                    }
                }
                trap("internal: no match arm applies")
            }
        }
    }

    // ----- primitives ------------------------------------------------------------

    fn ty(&self, id: FuncId) -> &MT {
        &self.prog.funcs[id].ty
    }

    /// Parameter types and result type of a primitive instance.
    fn sig(&self, id: FuncId) -> (Vec<MT>, MT) {
        let f = &self.prog.funcs[id];
        let (ps, r) = f.ty.params(f.arity as usize);
        (ps.into_iter().cloned().collect(), r.clone())
    }

    fn show(&self, v: &Value, mt: &MT) -> String {
        display(v, mt, self.prog, true)
    }

    fn write_out(&mut self, s: &str) -> R<()> {
        self.out
            .write_all(s.as_bytes())
            .map_err(|e| Ctl::Trap(format!("cannot write output: {}", e)))
    }

    fn next_random(&mut self) -> u64 {
        // xorshift64*
        let mut x = self.rng;
        x ^= x >> 12;
        x ^= x << 25;
        x ^= x >> 27;
        self.rng = x;
        x.wrapping_mul(0x2545F4914F6CDD1D)
    }

    fn io_error(&self, id: FuncId, kind: &str, msg: String) -> Ctl {
        // The Error payload type is the IoError record {kind, message}.
        let mt = MT::Con("std::IoError".into(), vec![]);
        let _ = id;
        Ctl::Fail(Value::tuple(vec![Value::str(kind), Value::str(&msg)]), mt)
    }

    fn prim(&mut self, id: FuncId, sym: &str, mut a: Vec<Value>) -> R<Value> {
        let (params, result) = self.sig(id);
        match sym {
            // arithmetic (data-last: `sub a b` is b - a)
            "prim.add" => arith(Op::Add, &a[1], &a[0], &result),
            "prim.sub" => arith(Op::Sub, &a[1], &a[0], &result),
            "prim.mul" => arith(Op::Mul, &a[1], &a[0], &result),
            "prim.div" => arith(Op::Div, &a[1], &a[0], &result),
            "prim.rem" => arith(Op::Rem, &a[1], &a[0], &result),
            // floats flip the sign (so `neg 0.0` is -0.0); integers are
            // checked `0 - x`
            "prim.neg" => match &a[0] {
                Value::F32(x) => Ok(Value::F32(-x)),
                Value::F64(x) => Ok(Value::F64(-x)),
                x => arith(Op::Sub, &zero_of(&result)?, x, &result),
            },
            "prim.zero" => zero_of(&result),
            "prim.one" => from_i128(&result, 1),
            "prim.from-int" => from_i128(&result, a[0].as_i128().unwrap()),
            "prim.from-float" => float_of(&result, a[0].as_f64().unwrap()),
            "wrapping.add" => wrapping(Op::Add, &a[1], &a[0]),
            "wrapping.sub" => wrapping(Op::Sub, &a[1], &a[0]),
            "wrapping.mul" => wrapping(Op::Mul, &a[1], &a[0]),
            "saturating.add" => saturating(Op::Add, &a[1], &a[0], &result),
            "saturating.sub" => saturating(Op::Sub, &a[1], &a[0], &result),
            "saturating.mul" => saturating(Op::Mul, &a[1], &a[0], &result),
            "overflowing.add" | "overflowing.sub" | "overflowing.mul" => {
                let op = op_of(sym);
                let w = wrapping(op, &a[1], &a[0])?;
                let ok = arith(op, &a[1], &a[0], &params[0]).is_ok();
                Ok(Value::tuple(vec![w, Value::bool(!ok)]))
            }
            "checked.add" | "checked.sub" | "checked.mul" | "checked.div" => {
                match arith(op_of(sym), &a[1], &a[0], &params[0]) {
                    Ok(v) => Ok(Value::data(1, vec![v])),
                    Err(_) => Ok(Value::nullary(0)),
                }
            }
            "bit.and" | "bit.or" | "bit.xor" => bitop(sym, &a[1], &a[0], &result),
            "bit.not" => Ok(match &a[0] {
                Value::I8(x) => Value::I8(!x),
                Value::I16(x) => Value::I16(!x),
                Value::I32(x) => Value::I32(!x),
                Value::I64(x) => Value::I64(!x),
                Value::I128(x) => Value::I128(!x),
                Value::U8(x) => Value::U8(!x),
                Value::U16(x) => Value::U16(!x),
                Value::U32(x) => Value::U32(!x),
                Value::U64(x) => Value::U64(!x),
                Value::U128(x) => Value::U128(!x),
                other => other.clone(),
            }),
            "bit.shl" | "bit.shr" => {
                let n = a[0].as_i128().unwrap() as u32;
                shift(sym == "bit.shl", n, &a[1], &result)
            }
            "int.convert" => {
                let r = option_inner(&result);
                match &a[0] {
                    Value::U128(x) => Ok(match u128_to(&r, *x) {
                        Some(v) => Value::data(1, vec![v]),
                        None => Value::nullary(0),
                    }),
                    v => Ok(match checked_int(&r, v.as_i128().unwrap()) {
                        Some(v) => Value::data(1, vec![v]),
                        None => Value::nullary(0),
                    }),
                }
            }
            "int.to-float" => {
                let x = match &a[0] {
                    Value::U128(x) => *x as f64,
                    v => v.as_i128().unwrap() as f64,
                };
                float_of(&result, x)
            }
            "float.to-int" => {
                let x = a[0].as_f64().unwrap();
                let r = option_inner(&result);
                if !x.is_finite() {
                    return Ok(Value::nullary(0));
                }
                // exact bounds: [-2^127, 2^127) converts through i128,
                // [2^127, 2^128) only to U128
                let t = x.trunc();
                let p127 = 2f64.powi(127);
                let v = if t < -p127 || t >= 2.0 * p127 {
                    None
                } else if t >= p127 {
                    u128_to(&r, t as u128)
                } else {
                    checked_int(&r, t as i128)
                };
                Ok(match v {
                    Some(v) => Value::data(1, vec![v]),
                    None => Value::nullary(0),
                })
            }
            "float.convert" => float_of(&result, a[0].as_f64().unwrap()),
            "sqrt" | "exp" | "ln" | "sin" | "cos" | "tan" | "floor" | "ceil" | "round" => {
                let x = a[0].as_f64().unwrap();
                let y = match sym {
                    "sqrt" => x.sqrt(),
                    "exp" => x.exp(),
                    "ln" => x.ln(),
                    "sin" => x.sin(),
                    "cos" => x.cos(),
                    "tan" => x.tan(),
                    "floor" => x.floor(),
                    "ceil" => x.ceil(),
                    _ => x.round(),
                };
                match &a[0] {
                    Value::F32(x32) => Ok(Value::F32(match sym {
                        "sqrt" => x32.sqrt(),
                        "floor" => x32.floor(),
                        "ceil" => x32.ceil(),
                        "round" => x32.round(),
                        _ => y as f32,
                    })),
                    _ => Ok(Value::F64(y)),
                }
            }
            "pow" => {
                let (e, b) = (a[0].as_f64().unwrap(), a[1].as_f64().unwrap());
                float_of(&result, b.powf(e))
            }
            "abs" => match &a[0] {
                Value::F32(x) => Ok(Value::F32(x.abs())),
                Value::F64(x) => Ok(Value::F64(x.abs())),
                v => {
                    let x = v.as_i128().unwrap();
                    if x < 0 {
                        arith(Op::Sub, &zero_of(&result)?, v, &result)
                    } else {
                        Ok(v.clone())
                    }
                }
            },
            // comparison (data-last: `lt a b` is b < a)
            "eq" => Ok(Value::bool(fwp_eq(&a[1], &a[0]))),
            "ne" => Ok(Value::bool(!fwp_eq(&a[1], &a[0]))),
            "lt" | "le" | "gt" | "ge" => {
                let o = fwp_partial_cmp(&a[1], &a[0]);
                Ok(Value::bool(match (sym, o) {
                    (_, None) => false,
                    ("lt", Some(o)) => o == Ordering::Less,
                    ("le", Some(o)) => o != Ordering::Greater,
                    ("gt", Some(o)) => o == Ordering::Greater,
                    (_, Some(o)) => o != Ordering::Less,
                }))
            }
            "compare" => Ok(Value::nullary(match a[1].cmp(&a[0]) {
                Ordering::Less => 0,
                Ordering::Equal => 1,
                Ordering::Greater => 2,
            })),
            "min" => Ok(if a[1] <= a[0] {
                a.swap_remove(1)
            } else {
                a.swap_remove(0)
            }),
            "max" => Ok(if a[1] >= a[0] {
                a.swap_remove(1)
            } else {
                a.swap_remove(0)
            }),
            "hash" => Ok(Value::U64(crate::proto::hash(&a[0], &params[0], self.prog))),
            "not" => Ok(Value::bool(!a[0].as_bool())),
            "and" => Ok(Value::bool(a[0].as_bool() && a[1].as_bool())),
            "or" => Ok(Value::bool(a[0].as_bool() || a[1].as_bool())),
            // lists
            "map" => {
                let f = a[0].clone();
                let mut out = Vec::new();
                for x in a[1].list_items() {
                    out.push(self.apply(f.clone(), vec![x])?);
                }
                Ok(Value::list(out))
            }
            "filter" => {
                let f = a[0].clone();
                let mut out = Vec::new();
                for x in a[1].list_items() {
                    if self.apply(f.clone(), vec![x.clone()])?.as_bool() {
                        out.push(x);
                    }
                }
                Ok(Value::list(out))
            }
            "fold" => {
                let f = a[0].clone();
                let mut acc = a[1].clone();
                for x in a[2].list_items() {
                    acc = self.apply(f.clone(), vec![acc, x])?;
                }
                Ok(acc)
            }
            "sort" => {
                let mut items = a[0].list_items();
                items.sort();
                Ok(Value::list(items))
            }
            "length" => Ok(Value::I64(a[0].list_items().len() as i64)),
            "list.flat-map" => {
                let f = a[0].clone();
                let mut out = Vec::new();
                for x in a[1].list_items() {
                    out.extend(self.apply(f.clone(), vec![x])?.list_items());
                }
                Ok(Value::list(out))
            }
            "list.ap" => {
                let mut out = Vec::new();
                for f in a[0].list_items() {
                    for x in a[1].list_items() {
                        out.push(self.apply(f.clone(), vec![x])?);
                    }
                }
                Ok(Value::list(out))
            }
            // strings
            "trim" => Ok(Value::str(a[0].as_str().trim_matches(|c: char| {
                c == ' ' || c == '\t' || c == '\n' || c == '\r'
            }))),
            "lower" => Ok(Value::str(&a[0].as_str().to_ascii_lowercase())),
            "upper" => Ok(Value::str(&a[0].as_str().to_ascii_uppercase())),
            "concat" => Ok(Value::str(&format!("{}{}", a[1].as_str(), a[0].as_str()))),
            "show" => Ok(Value::str(&self.show(&a[0], &params[0]))),
            "syntax.show" => Ok(Value::str(&crate::syntax::show(&a[0]))),
            "print" => {
                let line = format!("{}\n", a[0].as_str());
                self.write_out(&line)?;
                Ok(Value::unit())
            }
            // effects
            "fail" => Err(Ctl::Fail(a.swap_remove(0), params[0].clone())),
            "attempt" => {
                let f = a[0].clone();
                let depth = self.state.len();
                match self.apply(f, vec![a[1].clone()]) {
                    Ok(v) => Ok(Value::data(0, vec![v])),
                    Err(Ctl::Fail(e, _)) => {
                        self.state.truncate(depth);
                        Ok(Value::data(1, vec![e]))
                    }
                    Err(other) => Err(other),
                }
            }
            _ if sym.starts_with("ptr.") || sym.starts_with("mem.") => {
                crate::ffi_interp::pointer_prim(sym, &a, &params, &result)
            }
            "json.parse" => Ok(crate::json::parse(a[0].as_str())),
            "json.encode" => {
                let mut out = String::new();
                crate::json::encode(&a[0], &mut out);
                Ok(Value::str(&out))
            }
            "json.write" => Ok(Value::str(&crate::jsontype::write(
                &a[0], &params[0], self.prog,
            ))),
            "json.read" => {
                let t = match &result {
                    MT::Con(_, args) => args.first().cloned().unwrap_or(MT::unit()),
                    _ => MT::unit(),
                };
                Ok(match crate::jsontype::read(a[0].as_str(), &t, self.prog) {
                    Ok(v) => Value::data(0, vec![v]),
                    Err(e) => Value::data(1, vec![Value::str(&e)]),
                })
            }
            "string.split-once" => Ok(crate::web::split_once(&a[0], &a[1])),
            "bytes.find" => Ok(crate::web::bytes_find(&a[0], &a[1])),
            "url.encode" => Ok(crate::web::url_encode(&a[0])),
            "url.decode" => Ok(crate::web::url_decode(&a[0], false)),
            "form.decode" => Ok(crate::web::url_decode(&a[0], true)),
            "url.split" => Ok(crate::web::url_split(&a[0])),
            "http.parse-request-head" => Ok(crate::web::parse_request_head(&a[0])),
            "http.parse-response-head" => Ok(crate::web::parse_response_head(&a[0])),
            "http.field-ok" => Ok(crate::web::field_ok(&a[0], &a[1])),
            "http.content-length" => Ok(crate::web::content_length(&a[0])),
            "prim.trap" => trap(a[0].as_str()),
            "int.to-hex" => Ok(crate::web::to_hex(&a[0])),
            "int.parse-hex" => Ok(crate::web::parse_hex(&a[0])),
            "loop" => {
                let f = a[0].clone();
                let mut s = a[1].clone();
                loop {
                    // a safe point, as each function entry is
                    if crate::sched::tick() {
                        self.preempt()?;
                    }
                    match &self.apply(f.clone(), vec![s])? {
                        Value::Data(0, fs) => s = fs[0].clone(),
                        Value::Data(_, fs) => return Ok(fs[0].clone()),
                        _ => return trap("internal: loop step is not a Step"),
                    }
                }
            }
            "get" => Ok(self.state.last().cloned().unwrap_or_else(Value::unit)),
            "put" => {
                if let Some(s) = self.state.last_mut() {
                    *s = a.swap_remove(0);
                }
                Ok(Value::unit())
            }
            "modify" => {
                let cur = self.state.last().cloned().unwrap_or_else(Value::unit);
                let new = self.apply(a[0].clone(), vec![cur])?;
                if let Some(s) = self.state.last_mut() {
                    *s = new;
                }
                Ok(Value::unit())
            }
            "run-state" => {
                self.state.push(a[0].clone());
                let r = self.apply(a[1].clone(), vec![a[2].clone()]);
                let s = self.state.pop().unwrap_or_else(Value::unit);
                Ok(Value::tuple(vec![r?, s]))
            }
            "args" => Ok(Value::list(
                self.args.iter().map(|a| Value::str(a)).collect(),
            )),
            "exit" => {
                let _ = self.out.flush();
                Err(Ctl::Exit(a[0].as_i128().unwrap_or(1) as i32))
            }
            "random.u64" => Ok(Value::U64(self.next_random())),
            "random.f64" => Ok(Value::F64(
                (self.next_random() >> 11) as f64 / (1u64 << 53) as f64,
            )),
            // files
            "file.open" | "file.create" => {
                let path = a[0].as_str().to_string();
                let f = if sym == "file.open" {
                    std::fs::File::open(&path)
                } else {
                    std::fs::File::create(&path)
                };
                match f {
                    Ok(f) => Ok(Value::File(Rc::new(RefCell::new(FileState {
                        path,
                        file: Some(f),
                    })))),
                    Err(e) => Err(self.io_error(
                        id,
                        "open",
                        format!("{}: {}", path, crate::h2::io_msg(&e)),
                    )),
                }
            }
            "file.close" => {
                if let Value::File(f) = &a[0] {
                    f.borrow_mut().file = None;
                }
                Ok(Value::unit())
            }
            "file.read-all" => {
                let Value::File(f) = &a[0] else {
                    return trap("internal: not a file");
                };
                let mut s = String::new();
                let res = match f.borrow_mut().file.as_mut() {
                    Some(file) => file.read_to_string(&mut s).map(|_| ()),
                    None => Ok(()),
                };
                match res {
                    Ok(()) => Ok(Value::tuple(vec![Value::str(&s), a[0].clone()])),
                    Err(e) => Err(self.io_error(id, "read", crate::h2::io_msg(&e))),
                }
            }
            "file.write" => {
                let Value::File(f) = &a[1] else {
                    return trap("internal: not a file");
                };
                let res = match f.borrow_mut().file.as_mut() {
                    Some(file) => file.write_all(a[0].as_str().as_bytes()),
                    None => Ok(()),
                };
                match res {
                    Ok(()) => Ok(a[1].clone()),
                    Err(e) => Err(self.io_error(id, "write", crate::h2::io_msg(&e))),
                }
            }
            "file.with" => {
                let path = a[0].as_str().to_string();
                let file = match std::fs::OpenOptions::new()
                    .read(true)
                    .write(true)
                    .create(true)
                    .truncate(false)
                    .open(&path)
                {
                    Ok(f) => Value::File(Rc::new(RefCell::new(FileState {
                        path: path.clone(),
                        file: Some(f),
                    }))),
                    Err(e) => {
                        return Err(self.io_error(
                            id,
                            "open",
                            format!("{}: {}", path, crate::h2::io_msg(&e)),
                        ))
                    }
                };
                let handle = file.clone();
                let r = self.apply(a[1].clone(), vec![file]);
                // Always close, also when the body failed.
                if let Value::File(f) = &handle {
                    f.borrow_mut().file = None;
                }
                let v = r?;
                if let Value::Record(fs) = &v {
                    return Ok(fs[0].clone());
                }
                Ok(v)
            }
            "file.read" => {
                let path = a[0].as_str().to_string();
                match std::fs::read_to_string(&path) {
                    Ok(s) => Ok(Value::str(&s)),
                    Err(e) => Err(self.io_error(
                        id,
                        "read",
                        format!("{}: {}", path, crate::h2::io_msg(&e)),
                    )),
                }
            }
            "file.write-new" => {
                let path = a[0].as_str().to_string();
                match std::fs::write(&path, a[1].as_str()) {
                    Ok(()) => Ok(Value::unit()),
                    Err(e) => Err(self.io_error(
                        id,
                        "write",
                        format!("{}: {}", path, crate::h2::io_msg(&e)),
                    )),
                }
            }
            _ if sym.starts_with("task.")
                || sym.starts_with("channel.")
                || sym.starts_with("tcp.")
                || sym.starts_with("udp.")
                || sym.starts_with("dns.")
                || sym.starts_with("tls.")
                || sym.starts_with("signal.")
                || sym.starts_with("metrics.") =>
            {
                match self.prim_conc(sym, &mut a) {
                    Some(r) => r,
                    None => trap(format!("primitive `{}` is not implemented", sym)),
                }
            }
            _ if sym.starts_with("http2.")
                || sym.starts_with("zlib.")
                || sym.starts_with("ws.") =>
            {
                crate::grpc::web::prim(self, sym, &mut a)
            }
            _ if sym.starts_with("grpc.") => crate::grpc::prim(self, id, sym, &mut a),
            _ if crate::sys::handles(sym) => crate::sys::prim(sym, &a, &mut *self.out),
            "cli.parse" => {
                let argv: Vec<String> = a[1]
                    .list_items()
                    .iter()
                    .map(|v| v.as_str().to_string())
                    .collect();
                Ok(
                    match crate::cli::parse_with(&params[0], &a[0], &argv, self.prog) {
                        Ok((rec, pos)) => Value::data(
                            0,
                            vec![Value::tuple(vec![
                                rec,
                                Value::list(pos.iter().map(|p| Value::str(p)).collect()),
                            ])],
                        ),
                        Err(m) => Value::data(1, vec![Value::str(&m)]),
                    },
                )
            }
            "csv.parse-with" => {
                let sep = a[0].as_str().as_bytes().first().copied().unwrap_or(b',');
                Ok(Value::list(
                    crate::csv::parse(a[1].as_str(), sep)
                        .iter()
                        .map(|r| Value::list(r.iter().map(|c| Value::str(c)).collect()))
                        .collect(),
                ))
            }
            "csv.decode" => {
                // Result[List[t], String]
                let t = match &result {
                    MT::Con(_, args) => match args.first() {
                        Some(MT::Con(_, e)) => e.first().cloned().unwrap_or_else(MT::unit),
                        _ => MT::unit(),
                    },
                    _ => MT::unit(),
                };
                Ok(
                    match crate::csv::decode(&a[0].list_items(), &t, self.prog) {
                        Ok(vs) => Value::data(0, vec![Value::list(vs)]),
                        Err(m) => Value::data(1, vec![Value::str(&m)]),
                    },
                )
            }
            "cli.help" => Ok(Value::str(&crate::cli::options_help(
                &params[0], &a[0], self.prog,
            ))),
            _ => match self
                .prim_std(sym, &mut a, &params, &result)
                .or_else(|| crate::numerics::prim(sym, &a))
            {
                Some(r) => r,
                None => trap(format!(
                    "primitive `{}` is not implemented (at type {})",
                    sym,
                    self.ty(id)
                )),
            },
        }
    }
}

/// Bind a pattern against a value, writing holes into `locals`.
fn bind(p: &Pat, v: &Value, locals: &mut [Value]) -> bool {
    match p {
        Pat::Wild => true,
        Pat::Bind(l) => {
            locals[*l as usize] = v.clone();
            true
        }
        Pat::Lit(x) => fwp_eq(x, v),
        Pat::Construct(tag, ps) => match v {
            Value::Data(t, fs) if t == tag => {
                ps.iter().zip(fs.iter()).all(|(p, f)| bind(p, f, locals))
            }
            _ => false,
        },
        Pat::Record(ps) => match v {
            Value::Record(fs) => ps.iter().zip(fs.iter()).all(|(p, f)| bind(p, f, locals)),
            _ => false,
        },
    }
}

/// IEEE-style partial order used by `lt`, `le`, `gt`, `ge`.
fn fwp_partial_cmp(a: &Value, b: &Value) -> Option<Ordering> {
    match (a, b) {
        (Value::F32(x), Value::F32(y)) => x.partial_cmp(y),
        (Value::F64(x), Value::F64(y)) => x.partial_cmp(y),
        _ => Some(a.cmp(b)),
    }
}

// ----------------------------------------------------------------- numerics

#[derive(Clone, Copy, PartialEq, Eq, Debug)]
pub enum Op {
    Add,
    Sub,
    Mul,
    Div,
    Rem,
}

fn op_of(sym: &str) -> Op {
    match sym.rsplit('.').next().unwrap() {
        "add" => Op::Add,
        "sub" => Op::Sub,
        "mul" => Op::Mul,
        "div" => Op::Div,
        _ => Op::Rem,
    }
}

fn prim_name(mt: &MT) -> &str {
    match mt {
        MT::Con(n, _) => n.strip_prefix("std::").unwrap_or(n),
        _ => "",
    }
}

fn option_inner(mt: &MT) -> MT {
    match mt {
        MT::Con(_, args) if !args.is_empty() => args[0].clone(),
        _ => MT::unit(),
    }
}

fn tint_width(mt: &MT) -> u64 {
    match mt {
        MT::Con(_, args) => match args.first() {
            Some(MT::Nat(n)) => *n,
            _ => 1,
        },
        _ => 1,
    }
}

fn tint_max(width: u64) -> i128 {
    (3i128.pow(width.min(80) as u32) - 1) / 2
}

pub fn zero_of(mt: &MT) -> R<Value> {
    from_i128(mt, 0)
}

/// Integer value of a numeric type, trapping when out of range.
pub fn from_i128(mt: &MT, x: i128) -> R<Value> {
    if let Some(v) = checked_int(mt, x) {
        return Ok(v);
    }
    match prim_name(mt) {
        "F32" | "F16" | "BF16" => Ok(Value::F32(x as f32)),
        "F64" | "F128" => Ok(Value::F64(x as f64)),
        n => trap(format!(
            "integer {} does not fit in {}",
            x,
            if n.is_empty() { "this type" } else { n }
        )),
    }
}

pub(crate) fn checked_int(mt: &MT, x: i128) -> Option<Value> {
    Some(match prim_name(mt) {
        "I8" => Value::I8(i8::try_from(x).ok()?),
        "I16" => Value::I16(i16::try_from(x).ok()?),
        "I32" => Value::I32(i32::try_from(x).ok()?),
        "I64" | "ISize" => Value::I64(i64::try_from(x).ok()?),
        "I128" => Value::I128(x),
        "U8" => Value::U8(u8::try_from(x).ok()?),
        "U16" => Value::U16(u16::try_from(x).ok()?),
        "U32" => Value::U32(u32::try_from(x).ok()?),
        "U64" | "USize" => Value::U64(u64::try_from(x).ok()?),
        "U128" => Value::U128(u128::try_from(x).ok()?),
        "TInt" => {
            let w = tint_width(mt);
            if x.abs() > tint_max(w) {
                return None;
            }
            Value::TInt(x as i64)
        }
        _ => return None,
    })
}

fn u128_to(mt: &MT, x: u128) -> Option<Value> {
    if prim_name(mt) == "U128" {
        return Some(Value::U128(x));
    }
    checked_int(mt, i128::try_from(x).ok()?)
}

fn float_of(mt: &MT, x: f64) -> R<Value> {
    match prim_name(mt) {
        "F32" | "F16" | "BF16" => Ok(Value::F32(x as f32)),
        _ => Ok(Value::F64(x)),
    }
}

macro_rules! int_cases {
    ($a:expr, $b:expr, $f:ident, $($v:ident),*) => {
        match ($a, $b) {
            $( (Value::$v(x), Value::$v(y)) => x.$f(*y).map(Value::$v), )*
            _ => None,
        }
    };
}

/// Checked arithmetic `a op b`; traps on overflow and division by zero.
pub fn arith(op: Op, a: &Value, b: &Value, mt: &MT) -> R<Value> {
    use Value::*;
    match (a, b) {
        (F32(x), F32(y)) => {
            return Ok(F32(match op {
                Op::Add => x + y,
                Op::Sub => x - y,
                Op::Mul => x * y,
                Op::Div => x / y,
                Op::Rem => x % y,
            }))
        }
        (F64(x), F64(y)) => {
            return Ok(F64(match op {
                Op::Add => x + y,
                Op::Sub => x - y,
                Op::Mul => x * y,
                Op::Div => x / y,
                Op::Rem => x % y,
            }))
        }
        (TInt(x), TInt(y)) => {
            let (x, y) = (*x as i128, *y as i128);
            let r = match op {
                Op::Add => x + y,
                Op::Sub => x - y,
                Op::Mul => x.checked_mul(y).unwrap_or(i128::MAX),
                Op::Div | Op::Rem => {
                    if y == 0 {
                        return trap("division by zero");
                    }
                    if op == Op::Div {
                        x / y
                    } else {
                        x % y
                    }
                }
            };
            let w = tint_width(mt);
            if r.abs() > tint_max(w) {
                return trap(format!("arithmetic overflow in TInt[{}]", w));
            }
            return Ok(TInt(r as i64));
        }
        _ => {}
    }
    if matches!(op, Op::Div | Op::Rem) && b.as_i128() == Some(0) {
        return trap("division by zero");
    }
    let r = match op {
        Op::Add => int_cases!(
            a,
            b,
            checked_add,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
        Op::Sub => int_cases!(
            a,
            b,
            checked_sub,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
        Op::Mul => int_cases!(
            a,
            b,
            checked_mul,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
        Op::Div => int_cases!(
            a,
            b,
            checked_div,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
        Op::Rem => int_cases!(
            a,
            b,
            checked_rem,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
    };
    match r {
        Some(v) => Ok(v),
        None => trap(format!(
            "arithmetic overflow in {}",
            match prim_name(mt) {
                "" => "integer operation".to_string(),
                n => n.to_string(),
            }
        )),
    }
}

macro_rules! wrap_cases {
    ($a:expr, $b:expr, $f:ident, $($v:ident),*) => {
        match ($a, $b) {
            $( (Value::$v(x), Value::$v(y)) => Some(Value::$v(x.$f(*y))), )*
            _ => None,
        }
    };
}

pub(crate) fn wrapping(op: Op, a: &Value, b: &Value) -> R<Value> {
    let r = match op {
        Op::Add => wrap_cases!(
            a,
            b,
            wrapping_add,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
        Op::Sub => wrap_cases!(
            a,
            b,
            wrapping_sub,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
        _ => wrap_cases!(
            a,
            b,
            wrapping_mul,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
    };
    r.map_or_else(|| trap("internal: wrapping arithmetic on non-integers"), Ok)
}

fn saturating(op: Op, a: &Value, b: &Value, _mt: &MT) -> R<Value> {
    let r = match op {
        Op::Add => wrap_cases!(
            a,
            b,
            saturating_add,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
        Op::Sub => wrap_cases!(
            a,
            b,
            saturating_sub,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
        _ => wrap_cases!(
            a,
            b,
            saturating_mul,
            I8,
            I16,
            I32,
            I64,
            I128,
            U8,
            U16,
            U32,
            U64,
            U128
        ),
    };
    r.map_or_else(
        || trap("internal: saturating arithmetic on non-integers"),
        Ok,
    )
}

/// Reinterpret an i128 bit pattern at the width of `like`.
fn wrap_to(mt: &MT, x: i128, like: Value) -> Value {
    match like {
        Value::I8(_) => Value::I8(x as i8),
        Value::I16(_) => Value::I16(x as i16),
        Value::I32(_) => Value::I32(x as i32),
        Value::I64(_) => Value::I64(x as i64),
        Value::I128(_) => Value::I128(x),
        Value::U8(_) => Value::U8(x as u8),
        Value::U16(_) => Value::U16(x as u16),
        Value::U32(_) => Value::U32(x as u32),
        Value::U64(_) => Value::U64(x as u64),
        Value::U128(_) => Value::U128(x as u128),
        other => {
            let _ = mt;
            other
        }
    }
}

fn bitop(sym: &str, a: &Value, b: &Value, mt: &MT) -> R<Value> {
    if let (Value::U128(x), Value::U128(y)) = (a, b) {
        return Ok(Value::U128(match sym {
            "bit.and" => x & y,
            "bit.or" => x | y,
            _ => x ^ y,
        }));
    }
    let (x, y) = (a.as_i128().unwrap(), b.as_i128().unwrap());
    let r = match sym {
        "bit.and" => x & y,
        "bit.or" => x | y,
        _ => x ^ y,
    };
    Ok(wrap_to(mt, r, a.clone()))
}

fn shift(left: bool, n: u32, v: &Value, mt: &MT) -> R<Value> {
    let bits = match v {
        Value::I8(_) | Value::U8(_) => 8,
        Value::I16(_) | Value::U16(_) => 16,
        Value::I32(_) | Value::U32(_) => 32,
        Value::I64(_) | Value::U64(_) => 64,
        _ => 128,
    };
    if n >= bits {
        return trap(format!(
            "shift by {} bits overflows a {}-bit integer",
            n, bits
        ));
    }
    Ok(match v {
        Value::I8(x) => Value::I8(if left { x << n } else { x >> n }),
        Value::I16(x) => Value::I16(if left { x << n } else { x >> n }),
        Value::I32(x) => Value::I32(if left { x << n } else { x >> n }),
        Value::I64(x) => Value::I64(if left { x << n } else { x >> n }),
        Value::I128(x) => Value::I128(if left { x << n } else { x >> n }),
        Value::U8(x) => Value::U8(if left { x << n } else { x >> n }),
        Value::U16(x) => Value::U16(if left { x << n } else { x >> n }),
        Value::U32(x) => Value::U32(if left { x << n } else { x >> n }),
        Value::U64(x) => Value::U64(if left { x << n } else { x >> n }),
        Value::U128(x) => Value::U128(if left { x << n } else { x >> n }),
        other => {
            let _ = mt;
            other.clone()
        }
    })
}

/// Outcome of running a program.
pub struct RunResult {
    pub exit_code: i32,
}

/// Run `main` and report uncaught failures on stderr.
pub fn run_main(prog: &Program, args: Vec<String>) -> RunResult {
    let stdout = std::io::stdout();
    // In WebAssembly a deep recursion can exhaust the engine's own stack,
    // which ends the module at once: write each line as it is complete so
    // that the output before such a failure is kept.
    #[cfg(target_family = "wasm")]
    let out = std::io::LineWriter::new(stdout.lock());
    #[cfg(not(target_family = "wasm"))]
    let out = std::io::BufWriter::new(stdout.lock());
    let mut it = Interp::new(prog, Box::new(out));
    it.args = args;
    let Some(main) = prog.main else {
        eprintln!("fwp: no `main` binding");
        return RunResult { exit_code: 2 };
    };
    let r = it.call_root(main);
    let _ = it.out.flush();
    let code = report(&r, prog);
    match r {
        Ok(v) => {
            // `main` may evaluate to an exit code.
            if let Value::I32(c) = v {
                return RunResult { exit_code: c };
            }
            RunResult { exit_code: 0 }
        }
        Err(_) => RunResult { exit_code: code },
    }
}

/// Print an uncaught failure; returns the exit code to use.
pub fn report(r: &R<Value>, prog: &Program) -> i32 {
    match r {
        Ok(_) => 0,
        Err(Ctl::Fail(v, mt)) => {
            eprintln!("error: {}", display(v, mt, prog, true));
            1
        }
        Err(Ctl::Trap(msg)) => {
            eprintln!("fwp: trap: {}", msg);
            101
        }
        Err(Ctl::Exit(c)) => *c,
        Err(Ctl::Cancelled) => {
            eprintln!("fwp: the main task was cancelled");
            1
        }
    }
}
