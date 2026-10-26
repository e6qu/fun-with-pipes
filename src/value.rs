//! Runtime values of the interpreter, structural comparison, and the
//! canonical text format.

use std::cell::RefCell;
use std::cmp::Ordering;
use std::collections::{BTreeMap, BTreeSet};
use std::rc::Rc;

use crate::ir::{FuncId, TypeShape, MT};
use crate::softfloat::{BFloat16, Binary128, Binary16, FloatFormat};

#[derive(Clone, Debug)]
pub enum Value {
    I8(i8),
    I16(i16),
    I32(i32),
    I64(i64),
    I128(i128),
    U8(u8),
    U16(u16),
    U32(u32),
    U64(u64),
    U128(u128),
    F32(f32),
    F64(f64),
    F16(Binary16),
    BF16(BFloat16),
    F128(Binary128),
    Str(Rc<str>),
    /// ADT value: constructor tag and fields.
    Data(u32, Rc<[Value]>),
    /// Record or tuple, fields in canonical order.
    Record(Rc<[Value]>),
    /// Partial application of a function.
    Closure(Rc<Closure>),
    Array(Rc<Vec<Value>>),
    Map(Rc<BTreeMap<Value, Value>>),
    Set(Rc<BTreeSet<Value>>),
    Bytes(Rc<[u8]>),
    /// Balanced ternary integer (value; the width is in the type).
    TInt(i64),
    Trit(i8),
    File(Rc<RefCell<FileState>>),
    /// Task, channel or socket.
    Native(Rc<crate::sched::Native>),
}

/// Dropping a value frees what only it refers to. A long list is a chain
/// of `Cons` cells, so the default recursive drop would use stack in
/// proportion to its length; this drop moves the children of uniquely
/// owned cells to a work list instead. (Native fwp has a deep stack, but
/// the WebAssembly build is limited by the engine's.)
impl Drop for Value {
    fn drop(&mut self) {
        let mut work = Vec::new();
        take_children(self, &mut work);
        while let Some(mut v) = work.pop() {
            take_children(&mut v, &mut work);
        }
    }
}

/// Move the children of `v` that own other values to `work`, if `v` is
/// the only reference to them.
fn take_children(v: &mut Value, work: &mut Vec<Value>) {
    fn owns(v: &Value) -> bool {
        matches!(
            v,
            Value::Data(..) | Value::Record(_) | Value::Closure(_) | Value::Array(_)
        )
    }
    let fields: &mut [Value] = match v {
        Value::Data(_, fs) | Value::Record(fs) => match Rc::get_mut(fs) {
            Some(fs) => fs,
            None => return,
        },
        Value::Closure(c) => match Rc::get_mut(c) {
            Some(c) => &mut c.args,
            None => return,
        },
        Value::Array(a) => match Rc::get_mut(a) {
            Some(a) => a,
            None => return,
        },
        _ => return,
    };
    for f in fields {
        if owns(f) {
            work.push(std::mem::replace(f, Value::I8(0)));
        }
    }
}

#[derive(Debug)]
pub struct Closure {
    pub func: FuncId,
    pub args: Vec<Value>,
}

#[derive(Debug)]
pub struct FileState {
    pub path: String,
    pub file: Option<std::fs::File>,
}

impl Value {
    /// Constants must be portable data, never handles into the compiler process.
    pub(crate) fn check_constant(&self) -> Result<(), String> {
        let mut pending = vec![self];
        while let Some(value) = pending.pop() {
            match value {
                Value::File(_) => return Err("constant contains a runtime File handle".into()),
                Value::Native(n) => {
                    return Err(format!(
                        "constant contains a native runtime handle {}",
                        n.describe()
                    ));
                }
                Value::Data(_, fields) | Value::Record(fields) => pending.extend(fields.iter()),
                Value::Closure(c) => pending.extend(&c.args),
                Value::Array(a) => pending.extend(a.iter()),
                Value::Set(s) => pending.extend(s.iter()),
                Value::Map(m) => {
                    for (key, value) in m.iter() {
                        pending.push(key);
                        pending.push(value);
                    }
                }
                Value::I8(_)
                | Value::I16(_)
                | Value::I32(_)
                | Value::I64(_)
                | Value::I128(_)
                | Value::U8(_)
                | Value::U16(_)
                | Value::U32(_)
                | Value::U64(_)
                | Value::U128(_)
                | Value::F16(_)
                | Value::BF16(_)
                | Value::F32(_)
                | Value::F64(_)
                | Value::F128(_)
                | Value::Str(_)
                | Value::Bytes(_)
                | Value::TInt(_)
                | Value::Trit(_) => {}
            }
        }
        Ok(())
    }

    pub fn unit() -> Value {
        Value::Record(Rc::from(Vec::new()))
    }

    pub fn bool(b: bool) -> Value {
        Value::Data(b as u32, Rc::from(Vec::new()))
    }

    pub fn nullary(tag: u32) -> Value {
        Value::Data(tag, Rc::from(Vec::new()))
    }

    pub fn data(tag: u32, fields: Vec<Value>) -> Value {
        Value::Data(tag, Rc::from(fields))
    }

    pub fn tuple(items: Vec<Value>) -> Value {
        Value::Record(Rc::from(items))
    }

    pub fn str(s: &str) -> Value {
        Value::Str(Rc::from(s))
    }

    pub fn as_bool(&self) -> bool {
        matches!(self, Value::Data(1, _))
    }

    pub fn as_str(&self) -> &str {
        match self {
            Value::Str(s) => s,
            other => panic!("expected string, got {:?}", other),
        }
    }

    /// Integer value widened to i128 (u128 values above i128::MAX are not
    /// representable; callers handle U128 separately).
    pub fn as_i128(&self) -> Option<i128> {
        Some(match self {
            Value::I8(x) => *x as i128,
            Value::I16(x) => *x as i128,
            Value::I32(x) => *x as i128,
            Value::I64(x) => *x as i128,
            Value::I128(x) => *x,
            Value::U8(x) => *x as i128,
            Value::U16(x) => *x as i128,
            Value::U32(x) => *x as i128,
            Value::U64(x) => *x as i128,
            Value::U128(x) => i128::try_from(*x).ok()?,
            Value::TInt(x) => *x as i128,
            Value::Trit(x) => *x as i128,
            _ => return None,
        })
    }

    pub fn as_f64(&self) -> Option<f64> {
        match self {
            Value::F16(x) => Some(x.to_quad().to_f64()),
            Value::BF16(x) => Some(x.to_quad().to_f64()),
            Value::F32(x) => Some(*x as f64),
            Value::F64(x) => Some(*x),
            _ => None,
        }
    }

    /// Exact widening for comparisons and explicit float conversion.
    /// Quad values never implicitly narrow through `as_f64`.
    pub fn as_quad(&self) -> Option<Binary128> {
        match self {
            Value::F16(x) => Some(x.to_quad()),
            Value::BF16(x) => Some(x.to_quad()),
            Value::F32(x) => Some(Binary128::from_f32(*x)),
            Value::F64(x) => Some(Binary128::from_f64(*x)),
            Value::F128(x) => Some(*x),
            _ => None,
        }
    }

    pub fn is_float(&self) -> bool {
        matches!(
            self,
            Value::F16(_) | Value::BF16(_) | Value::F32(_) | Value::F64(_) | Value::F128(_)
        )
    }

    /// Build a list value (prelude `List`: Nil = 0, Cons = 1).
    pub fn list(items: Vec<Value>) -> Value {
        let mut v = Value::nullary(0);
        for x in items.into_iter().rev() {
            v = Value::data(1, vec![x, v]);
        }
        v
    }

    /// Collect a list value into a vector.
    pub fn list_items(&self) -> Vec<Value> {
        let mut out = Vec::new();
        let mut cur = self;
        while let Value::Data(1, fs) = cur {
            out.push(fs[0].clone());
            cur = &fs[1];
        }
        out
    }

    fn rank(&self) -> u8 {
        match self {
            Value::I8(_) => 0,
            Value::I16(_) => 1,
            Value::I32(_) => 2,
            Value::I64(_) => 3,
            Value::I128(_) => 4,
            Value::U8(_) => 5,
            Value::U16(_) => 6,
            Value::U32(_) => 7,
            Value::U64(_) => 8,
            Value::U128(_) => 9,
            Value::F32(_) => 10,
            Value::F64(_) => 11,
            Value::Str(_) => 12,
            Value::Data(..) => 13,
            Value::Record(_) => 14,
            Value::Closure(_) => 15,
            Value::Array(_) => 16,
            Value::Map(_) => 17,
            Value::TInt(_) => 18,
            Value::Trit(_) => 19,
            Value::File(_) => 20,
            Value::Native(_) => 21,
            Value::Bytes(_) => 22,
            Value::F16(_) => 23,
            Value::BF16(_) => 24,
            Value::F128(_) => 25,
            Value::Set(_) => 26,
        }
    }
}

/// Structural total order. Floats use IEEE total order so that maps and
/// sorting are deterministic; `eq` on floats uses IEEE equality instead.
impl Ord for Value {
    fn cmp(&self, other: &Self) -> Ordering {
        use Value::*;
        match (self, other) {
            (I8(a), I8(b)) => a.cmp(b),
            (I16(a), I16(b)) => a.cmp(b),
            (I32(a), I32(b)) => a.cmp(b),
            (I64(a), I64(b)) => a.cmp(b),
            (I128(a), I128(b)) => a.cmp(b),
            (U8(a), U8(b)) => a.cmp(b),
            (U16(a), U16(b)) => a.cmp(b),
            (U32(a), U32(b)) => a.cmp(b),
            (U64(a), U64(b)) => a.cmp(b),
            (U128(a), U128(b)) => a.cmp(b),
            (F32(a), F32(b)) => a.total_cmp(b),
            (F64(a), F64(b)) => a.total_cmp(b),
            (F16(a), F16(b)) => a.total_cmp(*b),
            (BF16(a), BF16(b)) => a.total_cmp(*b),
            (F128(a), F128(b)) => a.total_cmp(*b),

            (Str(a), Str(b)) => a.as_bytes().cmp(b.as_bytes()),
            (Data(t1, f1), Data(t2, f2)) => t1.cmp(t2).then_with(|| f1.iter().cmp(f2.iter())),
            (Record(a), Record(b)) => a.iter().cmp(b.iter()),
            (Array(a), Array(b)) => a.iter().cmp(b.iter()),
            (Map(a), Map(b)) => a.iter().cmp(b.iter()),
            (Set(a), Set(b)) => a.iter().cmp(b.iter()),
            (Bytes(a), Bytes(b)) => a.cmp(b),
            (TInt(a), TInt(b)) => a.cmp(b),
            (Trit(a), Trit(b)) => a.cmp(b),
            (Closure(a), Closure(b)) => Rc::as_ptr(a).cmp(&Rc::as_ptr(b)),
            (File(a), File(b)) => Rc::as_ptr(a).cmp(&Rc::as_ptr(b)),
            (Native(a), Native(b)) => match (a.as_ref(), b.as_ref()) {
                // Downgrading twice creates two interpreter wrappers, but both
                // weak values name the same identity, even after expiration.
                (crate::sched::Native::WeakChan(a), crate::sched::Native::WeakChan(b)) => {
                    a.as_ptr().cmp(&b.as_ptr())
                }
                (crate::sched::Native::WeakChan(_), _) => Ordering::Less,
                (_, crate::sched::Native::WeakChan(_)) => Ordering::Greater,
                _ => Rc::as_ptr(a).cmp(&Rc::as_ptr(b)),
            },
            _ => self.rank().cmp(&other.rank()),
        }
    }
}

impl PartialOrd for Value {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialEq for Value {
    fn eq(&self, other: &Self) -> bool {
        self.cmp(other) == Ordering::Equal
    }
}

impl Eq for Value {}

/// Structural equality as seen by fwp programs (IEEE semantics for floats).
pub fn fwp_eq(a: &Value, b: &Value) -> bool {
    use Value::*;
    match (a, b) {
        (F32(x), F32(y)) => x == y,
        (F64(x), F64(y)) => x == y,
        (F16(x), F16(y)) => x.to_quad().numeric_cmp(y.to_quad()) == Some(Ordering::Equal),
        (BF16(x), BF16(y)) => x.to_quad().numeric_cmp(y.to_quad()) == Some(Ordering::Equal),
        (F128(x), F128(y)) => x.numeric_cmp(*y) == Some(Ordering::Equal),
        (Data(t1, f1), Data(t2, f2)) => {
            t1 == t2 && f1.len() == f2.len() && f1.iter().zip(f2.iter()).all(|(x, y)| fwp_eq(x, y))
        }
        (Record(f1), Record(f2)) => {
            f1.len() == f2.len() && f1.iter().zip(f2.iter()).all(|(x, y)| fwp_eq(x, y))
        }
        (Array(f1), Array(f2)) => {
            f1.len() == f2.len() && f1.iter().zip(f2.iter()).all(|(x, y)| fwp_eq(x, y))
        }
        _ => a == b,
    }
}

// ----------------------------------------------------------------- text format

/// Format with `p` significant digits: fixed notation for decimal
/// exponents in [-5, 16], scientific (C style, `1e+21`) otherwise. The C
/// runtime mirrors this with `%.*f` / `%.*e`.
fn format_g(x: f64, p: usize) -> String {
    let sci = format!("{:.*e}", p - 1, x);
    let (mant, exp) = sci.split_once('e').unwrap();
    let exp: i32 = exp.parse().unwrap();
    if !(-5..=16).contains(&exp) {
        let mut m = mant.to_string();
        if m.contains('.') {
            while m.ends_with('0') {
                m.pop();
            }
            if m.ends_with('.') {
                m.pop();
            }
        }
        let sign = if exp < 0 { '-' } else { '+' };
        format!("{}e{}{:02}", m, sign, exp.abs())
    } else {
        let decimals = (p as i32 - 1 - exp).max(0) as usize;
        let mut s = format!("{:.*}", decimals, x);
        if s.contains('.') {
            while s.ends_with('0') {
                s.pop();
            }
            if s.ends_with('.') {
                s.pop();
            }
        }
        s
    }
}

fn finish_float(s: String) -> String {
    if s.contains('.') || s.contains('e') || s.contains("inf") || s.contains("NaN") {
        s
    } else {
        format!("{}.0", s)
    }
}

pub fn fmt_exact(bits: u128, format: FloatFormat) -> String {
    finish_float(crate::softfloat::format_bits(bits, format).expect("float text allocation"))
}

/// Shortest round-trip decimal form of an `F64`.
pub fn fmt_f64(x: f64) -> String {
    if x.is_nan() {
        return "NaN".into();
    }
    if x.is_infinite() {
        return if x > 0.0 { "inf".into() } else { "-inf".into() };
    }
    for p in 1..=17 {
        let s = format_g(x, p);
        if s.parse::<f64>().ok() == Some(x) {
            return finish_float(s);
        }
    }
    finish_float(format_g(x, 17))
}

/// Shortest round-trip decimal form of an `F32`.
pub fn fmt_f32(x: f32) -> String {
    if x.is_nan() {
        return "NaN".into();
    }
    if x.is_infinite() {
        return if x > 0.0 { "inf".into() } else { "-inf".into() };
    }
    for p in 1..=9 {
        let s = format_g(x as f64, p);
        if s.parse::<f32>().ok() == Some(x) {
            return finish_float(s);
        }
    }
    finish_float(format_g(x as f64, 9))
}

pub fn escape_str(s: &str) -> String {
    let mut out = String::from("\"");
    for c in s.chars() {
        match c {
            '"' => out.push_str("\\\""),
            '\\' => out.push_str("\\\\"),
            '\n' => out.push_str("\\n"),
            '\t' => out.push_str("\\t"),
            '\r' => out.push_str("\\r"),
            c if (c as u32) < 0x20 || c as u32 == 0x7f => {
                out.push_str(&format!("\\u{{{:x}}}", c as u32))
            }
            c => out.push(c),
        }
    }
    out.push('"');
    out
}

/// Text from outside the program (stdin, arguments, the environment): each
/// maximal invalid UTF-8 subsequence becomes U+FFFD (as `fwp_str_lossy` in
/// the C runtime).
pub fn lossy(bytes: &[u8]) -> String {
    String::from_utf8_lossy(bytes).into_owned()
}

/// The widest `TInt[N]`: values of up to 40 trits fit in an `i64`, which is
/// how both backends store them.
pub const TINT_MAX_WIDTH: u64 = 40;

/// The error for a `TInt[n]` wider than [`TINT_MAX_WIDTH`].
pub fn tint_width_error(n: u64) -> String {
    format!(
        "`TInt[{}]` is too wide: balanced ternary integers have at most {} trits",
        n, TINT_MAX_WIDTH
    )
}

/// The width of the first `TInt[n]` in `mt` wider than [`TINT_MAX_WIDTH`].
pub fn too_wide_tint(mt: &MT) -> Option<u64> {
    match mt {
        MT::Con(n, args) => {
            if n == "std::TInt" {
                if let Some(MT::Nat(w)) = args.first() {
                    if *w > TINT_MAX_WIDTH {
                        return Some(*w);
                    }
                }
            }
            args.iter().find_map(too_wide_tint)
        }
        MT::Fun(a, b) => too_wide_tint(a).or_else(|| too_wide_tint(b)),
        MT::Record(fs) => fs.iter().find_map(|(_, t)| too_wide_tint(t)),
        MT::Nat(_) => None,
    }
}

pub fn trits_of(mut v: i64, width: u64) -> String {
    let mut digits = Vec::new();
    for _ in 0..width {
        let r = v.rem_euclid(3);
        let (d, carry) = match r {
            0 => ('0', 0),
            1 => ('+', 0),
            _ => ('-', 1),
        };
        digits.push(d);
        v = v.div_euclid(3) + carry;
    }
    digits.reverse();
    format!("0t{}", digits.into_iter().collect::<String>())
}

/// Type information needed to display values.
pub trait Shapes {
    fn shape(&self, mt: &MT) -> TypeShape;
}

/// Render a value in the canonical text format. `top` controls whether
/// strings are shown raw (top level) or quoted (nested).
pub fn display(v: &Value, mt: &MT, shapes: &dyn Shapes, top: bool) -> String {
    let mut out = String::new();
    write_value(&mut out, v, mt, shapes, top);
    out
}

fn needs_parens(v: &Value, mt: &MT, shapes: &dyn Shapes) -> bool {
    match (v, mt) {
        (Value::Data(_, fs), MT::Con(n, _)) if n != "std::List" && !fs.is_empty() => {
            !matches!(shapes.shape(mt), TypeShape::Opaque)
        }
        (Value::Record(_), MT::Con(n, _)) => n != "std::Duration",
        _ => {
            if let Some(i) = v.as_i128() {
                i < 0 && !matches!(v, Value::TInt(_) | Value::Trit(_))
            } else if let Value::F128(f) = v {
                f.is_sign_negative()
            } else if let Some(f) = v.as_f64() {
                f.is_sign_negative()
            } else {
                false
            }
        }
    }
}

pub(crate) fn write_value(out: &mut String, v: &Value, mt: &MT, shapes: &dyn Shapes, top: bool) {
    match v {
        Value::I8(x) => out.push_str(&x.to_string()),
        Value::I16(x) => out.push_str(&x.to_string()),
        Value::I32(x) => out.push_str(&x.to_string()),
        Value::I64(x) => out.push_str(&x.to_string()),
        Value::I128(x) => out.push_str(&x.to_string()),
        Value::U8(x) => out.push_str(&x.to_string()),
        Value::U16(x) => out.push_str(&x.to_string()),
        Value::U32(x) => out.push_str(&x.to_string()),
        Value::U64(x) => out.push_str(&x.to_string()),
        Value::U128(x) => out.push_str(&x.to_string()),
        Value::F32(x) => out.push_str(&fmt_f32(*x)),
        Value::F64(x) => out.push_str(&fmt_f64(*x)),
        Value::F16(x) => out.push_str(&fmt_exact(x.to_bits() as u128, FloatFormat::F16)),
        Value::BF16(x) => out.push_str(&fmt_exact(x.to_bits() as u128, FloatFormat::BF16)),
        Value::F128(x) => out.push_str(&fmt_exact(x.to_bits(), FloatFormat::F128)),

        Value::Str(s) => {
            if top {
                out.push_str(s)
            } else {
                out.push_str(&escape_str(s))
            }
        }
        Value::TInt(x) => {
            let w = match mt {
                MT::Con(_, args) => match args.first() {
                    Some(MT::Nat(n)) => *n,
                    _ => 1,
                },
                _ => 1,
            };
            out.push_str(&trits_of(*x, w))
        }
        Value::Trit(t) => out.push_str(match t {
            1 => "+1",
            -1 => "-1",
            _ => "0",
        }),
        Value::Closure(_) => out.push_str("<function>"),
        Value::Bytes(b) => {
            out.push_str("bytes[");
            for (i, x) in b.iter().enumerate() {
                if i > 0 {
                    out.push_str(", ");
                }
                out.push_str(&x.to_string());
            }
            out.push(']');
        }
        Value::File(f) => out.push_str(&format!("<file {}>", f.borrow().path)),
        Value::Native(n) => out.push_str(n.describe()),
        Value::Array(items) => {
            let elem = match mt {
                MT::Con(_, args) if !args.is_empty() => args[0].clone(),
                _ => MT::unit(),
            };
            out.push_str("array[");
            for (i, x) in items.iter().enumerate() {
                if i > 0 {
                    out.push_str(", ");
                }
                write_value(out, x, &elem, shapes, false);
            }
            out.push(']');
        }
        Value::Set(items) => {
            let key = match mt {
                MT::Con(_, args) => args[0].clone(),
                _ => MT::unit(),
            };
            out.push_str("set{");
            for (i, value) in items.iter().enumerate() {
                if i > 0 {
                    out.push_str(", ");
                }
                write_value(out, value, &key, shapes, false);
            }
            out.push('}');
        }
        Value::Map(m) => {
            let (k, vt) = match mt {
                MT::Con(_, args) if args.len() == 2 => (args[0].clone(), args[1].clone()),
                _ => (MT::unit(), MT::unit()),
            };
            out.push_str("map{");
            for (i, (key, val)) in m.iter().enumerate() {
                if i > 0 {
                    out.push_str(", ");
                }
                write_value(out, key, &k, shapes, false);
                out.push_str(": ");
                write_value(out, val, &vt, shapes, false);
            }
            out.push('}');
        }
        Value::Record(fields) => {
            let (name, ftypes): (Option<String>, Vec<(String, MT)>) = match mt {
                MT::Record(fs) => (None, fs.clone()),
                MT::Con(n, _) => match shapes.shape(mt) {
                    TypeShape::Record(fs) => (Some(MT::short_name(n)), fs),
                    _ => (Some(MT::short_name(n)), vec![]),
                },
                _ => (None, vec![]),
            };
            if name.as_deref() == Some("Duration") {
                if let Some(Value::I64(ns)) = fields.first() {
                    out.push_str(&crate::pretty::duration(*ns as i128));
                    return;
                }
            }
            let is_tuple = name.is_none()
                && ftypes.len() > 1
                && ftypes
                    .iter()
                    .enumerate()
                    .all(|(i, (l, _))| *l == i.to_string());
            if fields.is_empty() && name.is_none() {
                out.push_str("()");
                return;
            }
            if let Some(n) = &name {
                out.push_str(n);
                out.push(' ');
            }
            out.push(if is_tuple { '(' } else { '{' });
            for (i, x) in fields.iter().enumerate() {
                if i > 0 {
                    out.push_str(", ");
                }
                let (l, t) = ftypes
                    .get(i)
                    .cloned()
                    .unwrap_or_else(|| (i.to_string(), MT::unit()));
                if !is_tuple {
                    out.push_str(&l);
                    out.push_str(" = ");
                }
                write_value(out, x, &t, shapes, false);
            }
            out.push(if is_tuple { ')' } else { '}' });
        }
        Value::Data(tag, fields) => {
            if let MT::Con(n, args) = mt {
                if n == "std::List" {
                    let elem = args.first().cloned().unwrap_or(MT::unit());
                    out.push('[');
                    for (i, x) in v.list_items().iter().enumerate() {
                        if i > 0 {
                            out.push_str(", ");
                        }
                        write_value(out, x, &elem, shapes, false);
                    }
                    out.push(']');
                    return;
                }
            }
            match shapes.shape(mt) {
                TypeShape::Adt(variants) => {
                    let (name, ftypes) = &variants[*tag as usize];
                    out.push_str(name);
                    for (x, t) in fields.iter().zip(ftypes) {
                        out.push(' ');
                        if needs_parens(x, t, shapes) {
                            out.push('(');
                            write_value(out, x, t, shapes, false);
                            out.push(')');
                        } else {
                            write_value(out, x, t, shapes, false);
                        }
                    }
                }
                _ => out.push_str(&format!("<data {}>", tag)),
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn constants_reject_handles_in_every_container_and_capture() {
        let file = Value::File(Rc::new(RefCell::new(FileState {
            path: "closed-test-file".into(),
            file: None,
        })));
        for value in [
            file.clone(),
            Value::data(1, vec![file.clone()]),
            Value::tuple(vec![Value::I64(1), file.clone()]),
            Value::Array(Rc::new(vec![file.clone()])),
            Value::Set(Rc::new(BTreeSet::from([file.clone()]))),
            Value::Map(Rc::new(BTreeMap::from([(file.clone(), Value::I64(1))]))),
            Value::Map(Rc::new(BTreeMap::from([(Value::I64(1), file.clone())]))),
            Value::Closure(Rc::new(Closure {
                func: 0,
                args: vec![Value::tuple(vec![file])],
            })),
        ] {
            assert_eq!(
                value.check_constant().unwrap_err(),
                "constant contains a runtime File handle"
            );
        }
        let socket = Value::Native(Rc::new(crate::sched::Native::Udp(RefCell::new(None))));
        assert!(socket
            .check_constant()
            .unwrap_err()
            .contains("<udp socket>"));
        Value::list((0..10000).map(Value::I64).collect())
            .check_constant()
            .unwrap();
        Value::Closure(Rc::new(Closure {
            func: 0,
            args: vec![Value::str("portable capture")],
        }))
        .check_constant()
        .unwrap();
    }

    #[test]
    fn floats_round_trip_shortest() {
        assert_eq!(fmt_f64(0.1), "0.1");
        assert_eq!(fmt_f64(1.0), "1.0");
        assert_eq!(fmt_f64(-2.5), "-2.5");
        assert_eq!(fmt_f64(1e21), "1e+21");
        assert_eq!(fmt_f64(1.5e-7), "1.5e-07");
        assert_eq!(fmt_f64(123456.0), "123456.0");
        assert_eq!(fmt_f64(0.1 + 0.2), "0.30000000000000004");
        assert_eq!(fmt_f64(f64::NAN), "NaN");
        assert_eq!(fmt_f32(0.1), "0.1");
        assert_eq!(fmt_f64(100.0), "100.0");
        assert_eq!(fmt_f64(1e16), "10000000000000000.0");
        assert_eq!(fmt_f64(1e17), "1e+17");
        assert_eq!(fmt_f64(0.00001), "0.00001");
        assert_eq!(fmt_f64(0.000001), "1e-06");
        assert_eq!(fmt_f64(123.456), "123.456");
    }

    #[test]
    fn trits() {
        assert_eq!(trits_of(0, 3), "0t000");
        assert_eq!(trits_of(1, 2), "0t0+");
        assert_eq!(trits_of(-1, 2), "0t0-");
        assert_eq!(trits_of(2, 2), "0t+-");
        assert_eq!(trits_of(-4, 3), "0t0--");
    }
}
