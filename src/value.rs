//! Runtime values of the interpreter, structural comparison, and the
//! canonical text format.

use std::cell::RefCell;
use std::cmp::Ordering;
use std::collections::BTreeMap;
use std::rc::Rc;

use crate::ir::{FuncId, TypeShape, MT};

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
    Str(Rc<str>),
    /// ADT value: constructor tag and fields.
    Data(u32, Rc<[Value]>),
    /// Record or tuple, fields in canonical order.
    Record(Rc<[Value]>),
    /// Partial application of a function.
    Closure(Rc<Closure>),
    Array(Rc<Vec<Value>>),
    Map(Rc<BTreeMap<Value, Value>>),
    Bytes(Rc<[u8]>),
    /// Balanced ternary integer (value; the width is in the type).
    TInt(i64),
    Trit(i8),
    File(Rc<RefCell<FileState>>),
    /// Task, channel or socket.
    Native(Rc<crate::sched::Native>),
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
            Value::F32(x) => Some(*x as f64),
            Value::F64(x) => Some(*x),
            _ => None,
        }
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
            Value::Bytes(_) => 21,
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
            (Str(a), Str(b)) => a.as_bytes().cmp(b.as_bytes()),
            (Data(t1, f1), Data(t2, f2)) => t1.cmp(t2).then_with(|| f1.iter().cmp(f2.iter())),
            (Record(a), Record(b)) => a.iter().cmp(b.iter()),
            (Array(a), Array(b)) => a.iter().cmp(b.iter()),
            (Map(a), Map(b)) => a.iter().cmp(b.iter()),
            (Bytes(a), Bytes(b)) => a.cmp(b),
            (TInt(a), TInt(b)) => a.cmp(b),
            (Trit(a), Trit(b)) => a.cmp(b),
            (Closure(a), Closure(b)) => Rc::as_ptr(a).cmp(&Rc::as_ptr(b)),
            (File(a), File(b)) => Rc::as_ptr(a).cmp(&Rc::as_ptr(b)),
            (Native(a), Native(b)) => Rc::as_ptr(a).cmp(&Rc::as_ptr(b)),
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
    write_value(&mut out, v, mt, shapes, top, false);
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
            } else if let Some(f) = v.as_f64() {
                f.is_sign_negative()
            } else {
                false
            }
        }
    }
}

fn write_value(out: &mut String, v: &Value, mt: &MT, shapes: &dyn Shapes, top: bool, _arg: bool) {
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
                write_value(out, x, &elem, shapes, false, false);
            }
            out.push(']');
        }
        Value::Map(m) => {
            let (k, vt) = match mt {
                MT::Con(_, args) if args.len() == 2 => (args[0].clone(), args[1].clone()),
                MT::Con(_, args) if args.len() == 1 => (args[0].clone(), MT::unit()),
                _ => (MT::unit(), MT::unit()),
            };
            let is_set = matches!(mt, MT::Con(n, _) if n == "std::Set");
            out.push_str(if is_set { "set{" } else { "map{" });
            for (i, (key, val)) in m.iter().enumerate() {
                if i > 0 {
                    out.push_str(", ");
                }
                write_value(out, key, &k, shapes, false, false);
                if !is_set {
                    out.push_str(": ");
                    write_value(out, val, &vt, shapes, false, false);
                }
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
                write_value(out, x, &t, shapes, false, false);
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
                        write_value(out, x, &elem, shapes, false, false);
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
                            write_value(out, x, t, shapes, false, true);
                            out.push(')');
                        } else {
                            write_value(out, x, t, shapes, false, true);
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
