//! Typed JSON: values of any encodable type written as JSON text and read
//! back, driven by their types (`json.write` and `json.read` in
//! `lib/json.fwp`, and the arguments and results of REST endpoints). The C
//! runtime implements the same mapping with type descriptors
//! (`runtime/fwp_rt_json.c`); both must agree byte for byte, including
//! the error messages.
//!
//! | fwp | JSON |
//! |---|---|
//! | integers up to 64 bits, `TInt`, `Trit` | numbers, written exactly |
//! | `I128`, `U128` | decimal strings |
//! | floats | numbers (shortest round-trip form); `"NaN"`, `"Infinity"`, `"-Infinity"` |
//! | `Bool`, `String` | `true`/`false`, strings |
//! | `Bytes` | base64 strings (standard alphabet, padded) |
//! | `Duration` | strings such as `"1500ms"` (as `show` writes them) |
//! | `()` | `{}` |
//! | records (nominal or not) | objects; `Option` fields that are `None` are left out |
//! | tuples | arrays |
//! | `List`, `Array`, `Set` | arrays |
//! | `Map[String, V]` | objects; other maps are arrays of `[key, value]` pairs |
//! | `Option[T]` | `null` or the value (`Option[Option[T]]`: `null` or `[value]`) |
//! | variants without fields (enums) | strings: `"Red"` |
//! | other variants | `{"type": "Circle", "value": x}` (`value` is absent without fields and an array with several) |
//! | `Json` | itself |
//!
//! Reading is lenient where it loses nothing: integers, floats and `Bool`
//! may also be given as strings (`"42"`, `"1.5"`, `"true"`, which is how
//! path and query parameters arrive), an integer may be written with a
//! fraction or an exponent if its value is integral (`1e3`), a `Duration`
//! may be a number of nanoseconds, a constructor without fields may be a
//! bare string, and unknown object members are ignored. Errors name the
//! place with a JSON path: `$.items[2].price: expected a number, got "x"`.

use std::collections::BTreeMap;
use std::rc::Rc;

use crate::ir::{Program, TypeShape, MT};
use crate::json::{self, Raw};
use crate::value::Value;

/// How values of a type are written as JSON.
#[derive(Clone, Debug)]
pub enum Shape {
    /// An integer of at most 64 bits (its type name).
    Int(String),
    /// `I128` or `U128`, as a string.
    Wide(String),
    F32,
    F64,
    /// `TInt[n]`.
    TInt(u64),
    Trit,
    Str,
    Bytes,
    Duration,
    Bool,
    Json,
    Unit,
    Option(MT),
    List(MT),
    Array(MT),
    Set(MT),
    Map(MT, MT),
    Tuple(Vec<MT>),
    /// A record: its name (nominal records), its fields in canonical
    /// order, the order in which they are written (declaration order for
    /// nominal records), and the JSON name of each field (its own name,
    /// unless a field comment `json: name` gives another).
    Record(Option<String>, Vec<(String, MT)>, Vec<usize>, Vec<String>),
    /// A variant type whose constructors have no fields.
    Enum(String, Vec<String>),
    Adt(String, Vec<(String, Vec<MT>)>),
    /// A variant type marked `# json: untagged`: a constructor's value
    /// alone, read by trying the constructors in order.
    Untagged(String, Vec<(String, Vec<MT>)>),
    /// Functions, resources and runtime handles.
    Other,
}

fn arg(mt: &MT, i: usize) -> MT {
    match mt {
        MT::Con(_, args) => args.get(i).cloned().unwrap_or(MT::unit()),
        _ => MT::unit(),
    }
}

/// Whether a record type is a tuple: fields `0`, `1`, ...
pub fn is_tuple(fs: &[(String, MT)]) -> bool {
    !fs.is_empty() && fs.iter().enumerate().all(|(i, (l, _))| *l == i.to_string())
}

/// The JSON shape of a type.
pub fn shape(mt: &MT, prog: &Program) -> Shape {
    match mt {
        MT::Record(fs) if fs.is_empty() => Shape::Unit,
        MT::Record(fs) if is_tuple(fs) => Shape::Tuple(fs.iter().map(|(_, t)| t.clone()).collect()),
        MT::Record(fs) => Shape::Record(
            None,
            fs.clone(),
            (0..fs.len()).collect(),
            fs.iter().map(|(l, _)| l.clone()).collect(),
        ),
        MT::Fun(..) | MT::Nat(_) => Shape::Other,
        MT::Con(n, args) => {
            let short = n.strip_prefix("std::").unwrap_or(n);
            if n.starts_with("std::") {
                match short {
                    "I8" | "I16" | "I32" | "I64" | "ISize" | "U8" | "U16" | "U32" | "U64"
                    | "USize" => return Shape::Int(short.to_string()),
                    "I128" | "U128" => return Shape::Wide(short.to_string()),
                    "F32" | "F16" | "BF16" => return Shape::F32,
                    "F64" | "F128" => return Shape::F64,
                    "TInt" => {
                        return Shape::TInt(match args.first() {
                            Some(MT::Nat(w)) => *w,
                            _ => 1,
                        })
                    }
                    "Trit" => return Shape::Trit,
                    "String" => return Shape::Str,
                    "Bytes" => return Shape::Bytes,
                    "Duration" => return Shape::Duration,
                    "Bool" => return Shape::Bool,
                    "Json" => return Shape::Json,
                    "Option" => return Shape::Option(arg(mt, 0)),
                    "List" => return Shape::List(arg(mt, 0)),
                    "Array" => return Shape::Array(arg(mt, 0)),
                    "Set" => return Shape::Set(arg(mt, 0)),
                    "Map" => return Shape::Map(arg(mt, 0), arg(mt, 1)),
                    _ => {}
                }
            }
            let name = MT::short_name(n);
            match prog.shapes.get(mt) {
                Some(TypeShape::Record(fs)) if fs.is_empty() => Shape::Unit,
                Some(TypeShape::Record(fs)) => {
                    let order = match prog.field_order.get(n) {
                        Some(names) if names.len() == fs.len() => names
                            .iter()
                            .filter_map(|l| fs.iter().position(|(f, _)| f == l))
                            .collect(),
                        _ => (0..fs.len()).collect(),
                    };
                    let docs = field_docs(prog, mt);
                    let json = fs
                        .iter()
                        .map(|(l, _)| {
                            docs.and_then(|d| d.get(l))
                                .and_then(|d| d.json.clone())
                                .unwrap_or_else(|| l.clone())
                        })
                        .collect();
                    Shape::Record(Some(name), fs.clone(), order, json)
                }
                Some(TypeShape::Adt(vs)) if prog.docs.untagged.contains(&name) => {
                    Shape::Untagged(name, vs.clone())
                }
                Some(TypeShape::Adt(vs)) if vs.iter().all(|(_, f)| f.is_empty()) => {
                    Shape::Enum(name, vs.iter().map(|(c, _)| c.clone()).collect())
                }
                Some(TypeShape::Adt(vs)) => Shape::Adt(name, vs.clone()),
                _ => Shape::Other,
            }
        }
    }
}

/// The comments of the fields of a record type, declared in any file of
/// the program.
pub fn field_docs<'p>(
    prog: &'p Program,
    mt: &MT,
) -> Option<&'p BTreeMap<String, crate::cli::FieldDoc>> {
    match mt {
        MT::Con(n, _) => prog.docs.fields.get(n.rsplit("::").next().unwrap_or(n)),
        _ => None,
    }
}

/// The JSON name a field comment gives a field: `# json: name`.
pub fn json_name(doc: &str) -> Option<&str> {
    tagged(doc, "json")
}

/// A field comment without its `json: name` part.
pub fn without_json_name(doc: &str) -> String {
    without_tag(doc, "json")
}

/// The word after `key: ` in a field comment (`json: name`,
/// `header: X-Name`).
pub fn tagged<'a>(doc: &'a str, key: &str) -> Option<&'a str> {
    let pat = format!("{}: ", key);
    let mut rest = doc;
    loop {
        let i = rest.find(&pat)?;
        if i == 0 || rest[..i].ends_with(' ') {
            return rest[i + pat.len()..].split_whitespace().next();
        }
        rest = &rest[i + pat.len()..];
    }
}

/// A field comment without its `key: word` part.
pub fn without_tag(doc: &str, key: &str) -> String {
    match tagged(doc, key) {
        Some(n) => doc
            .replacen(&format!("{}: {}", key, n), "", 1)
            .split_whitespace()
            .collect::<Vec<_>>()
            .join(" "),
        None => doc.to_string(),
    }
}

pub fn is_option(mt: &MT) -> bool {
    matches!(mt, MT::Con(n, _) if n == "std::Option")
}

fn is_string(mt: &MT) -> bool {
    matches!(mt, MT::Con(n, _) if n == "std::String")
}

// ------------------------------------------------------------------ writing

/// The JSON text of a value of type `mt`.
pub fn write(v: &Value, mt: &MT, prog: &Program) -> String {
    let mut out = String::new();
    write_to(&mut out, v, mt, prog);
    out
}

fn int_text(v: &Value) -> String {
    match v {
        Value::U128(x) => x.to_string(),
        _ => v.as_i128().unwrap_or(0).to_string(),
    }
}

fn float_text(out: &mut String, x: f64, text: String) {
    if x.is_nan() {
        out.push_str("\"NaN\"");
    } else if x.is_infinite() {
        out.push_str(if x > 0.0 {
            "\"Infinity\""
        } else {
            "\"-Infinity\""
        });
    } else {
        out.push_str(&text);
    }
}

fn write_to(out: &mut String, v: &Value, mt: &MT, prog: &Program) {
    match shape(mt, prog) {
        Shape::Int(_) | Shape::TInt(_) | Shape::Trit => out.push_str(&int_text(v)),
        Shape::Wide(_) => {
            out.push('"');
            out.push_str(&int_text(v));
            out.push('"');
        }
        Shape::F32 => {
            let x = match v {
                Value::F32(x) => *x,
                _ => 0.0,
            };
            float_text(out, x as f64, crate::value::fmt_f32(x));
        }
        Shape::F64 => {
            let x = v.as_f64().unwrap_or(0.0);
            float_text(out, x, crate::value::fmt_f64(x));
        }
        Shape::Str => json::escape(v.as_str(), out),
        Shape::Bytes => {
            out.push('"');
            if let Value::Bytes(b) = v {
                out.push_str(&base64(b));
            }
            out.push('"');
        }
        Shape::Duration => {
            let ns = match v {
                Value::Record(fs) => fs.first().and_then(Value::as_i128).unwrap_or(0),
                _ => 0,
            };
            out.push('"');
            out.push_str(&crate::pretty::duration(ns));
            out.push('"');
        }
        Shape::Bool => out.push_str(if v.as_bool() { "true" } else { "false" }),
        Shape::Json => json::encode(v, out),
        Shape::Unit => out.push_str("{}"),
        Shape::Option(t) => match v {
            Value::Data(1, fs) => {
                if is_option(&t) {
                    out.push('[');
                    write_to(out, &fs[0], &t, prog);
                    out.push(']');
                } else {
                    write_to(out, &fs[0], &t, prog);
                }
            }
            _ => out.push_str("null"),
        },
        Shape::List(t) => write_items(out, &v.list_items(), &t, prog),
        Shape::Array(t) => match v {
            Value::Array(items) => write_items(out, items, &t, prog),
            _ => out.push_str("[]"),
        },
        Shape::Set(t) => match v {
            Value::Map(m) => {
                let keys: Vec<Value> = m.keys().cloned().collect();
                write_items(out, &keys, &t, prog)
            }
            _ => out.push_str("[]"),
        },
        Shape::Map(kt, vt) => {
            let Value::Map(m) = v else {
                out.push_str("{}");
                return;
            };
            let obj = is_string(&kt);
            out.push(if obj { '{' } else { '[' });
            for (i, (k, x)) in m.iter().enumerate() {
                if i > 0 {
                    out.push(',');
                }
                if obj {
                    json::escape(k.as_str(), out);
                    out.push(':');
                    write_to(out, x, &vt, prog);
                } else {
                    out.push('[');
                    write_to(out, k, &kt, prog);
                    out.push(',');
                    write_to(out, x, &vt, prog);
                    out.push(']');
                }
            }
            out.push(if obj { '}' } else { ']' });
        }
        Shape::Tuple(ts) => {
            let Value::Record(fs) = v else {
                out.push_str("[]");
                return;
            };
            out.push('[');
            for (i, (x, t)) in fs.iter().zip(&ts).enumerate() {
                if i > 0 {
                    out.push(',');
                }
                write_to(out, x, t, prog);
            }
            out.push(']');
        }
        Shape::Record(_, fts, order, names) => {
            let Value::Record(fs) = v else {
                out.push_str("{}");
                return;
            };
            out.push('{');
            let mut first = true;
            for i in order {
                let t = &fts[i].1;
                if is_option(t) && matches!(fs[i], Value::Data(0, _)) {
                    continue;
                }
                if !first {
                    out.push(',');
                }
                first = false;
                json::escape(&names[i], out);
                out.push(':');
                write_to(out, &fs[i], t, prog);
            }
            out.push('}');
        }
        Shape::Enum(_, names) => {
            let tag = match v {
                Value::Data(t, _) => *t as usize,
                _ => 0,
            };
            json::escape(&names[tag], out);
        }
        Shape::Untagged(_, vs) => {
            let (tag, fs): (usize, &[Value]) = match v {
                Value::Data(t, fs) => (*t as usize, fs),
                _ => (0, &[]),
            };
            let fts = &vs[tag.min(vs.len() - 1)].1;
            match fts.len() {
                0 => out.push_str("null"),
                1 => write_to(out, &fs[0], &fts[0], prog),
                _ => write_items_of(out, fs, fts, prog),
            }
        }
        Shape::Adt(_, vs) => {
            let Value::Data(tag, fs) = v else {
                out.push_str("null");
                return;
            };
            let (name, fts) = &vs[*tag as usize];
            out.push_str("{\"type\":");
            json::escape(name, out);
            match fts.len() {
                0 => {}
                1 => {
                    out.push_str(",\"value\":");
                    write_to(out, &fs[0], &fts[0], prog);
                }
                _ => {
                    out.push_str(",\"value\":[");
                    for (i, (x, t)) in fs.iter().zip(fts).enumerate() {
                        if i > 0 {
                            out.push(',');
                        }
                        write_to(out, x, t, prog);
                    }
                    out.push(']');
                }
            }
            out.push('}');
        }
        Shape::Other => out.push_str("null"),
    }
}

fn write_items_of(out: &mut String, items: &[Value], ts: &[MT], prog: &Program) {
    out.push('[');
    for (i, (x, t)) in items.iter().zip(ts).enumerate() {
        if i > 0 {
            out.push(',');
        }
        write_to(out, x, t, prog);
    }
    out.push(']');
}

fn write_items(out: &mut String, items: &[Value], t: &MT, prog: &Program) {
    out.push('[');
    for (i, x) in items.iter().enumerate() {
        if i > 0 {
            out.push(',');
        }
        write_to(out, x, t, prog);
    }
    out.push(']');
}

const B64: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

/// Standard base64 with padding.
pub fn base64(b: &[u8]) -> String {
    let mut out = String::new();
    for c in b.chunks(3) {
        let n = (c[0] as u32) << 16
            | (*c.get(1).unwrap_or(&0) as u32) << 8
            | *c.get(2).unwrap_or(&0) as u32;
        for i in 0..4 {
            if i <= c.len() {
                out.push(B64[(n >> (18 - 6 * i) & 63) as usize] as char);
            } else {
                out.push('=');
            }
        }
    }
    out
}

/// Base64 (standard or URL-safe alphabet, padding optional).
pub fn unbase64(s: &str) -> Option<Vec<u8>> {
    let s = s.as_bytes();
    let body = s
        .strip_suffix(b"==")
        .or_else(|| s.strip_suffix(b"="))
        .unwrap_or(s);
    if body.len() % 4 == 1 || (body.len() != s.len() && !s.len().is_multiple_of(4)) {
        return None;
    }
    let mut out = Vec::new();
    let (mut acc, mut bits) = (0u32, 0);
    for &c in body {
        let d = match c {
            b'A'..=b'Z' => c - b'A',
            b'a'..=b'z' => c - b'a' + 26,
            b'0'..=b'9' => c - b'0' + 52,
            b'+' | b'-' => 62,
            b'/' | b'_' => 63,
            _ => return None,
        };
        acc = acc << 6 | d as u32;
        bits += 6;
        if bits >= 8 {
            bits -= 8;
            out.push((acc >> bits) as u8);
            acc &= (1 << bits) - 1;
        }
    }
    Some(out)
}

// ------------------------------------------------------------------ reading

/// Read a value of type `mt` from JSON text. Syntax errors are those of
/// `json.parse` (`unexpected character at byte 3`); type errors start with
/// the JSON path of the offending value.
pub fn read(text: &str, mt: &MT, prog: &Program) -> Result<Value, String> {
    let raw = Raw::parse(text)?;
    let mut path = String::from("$");
    decode(&raw, mt, prog, &mut path)
}

/// Whether `s` is a JSON number.
pub fn is_number(s: &str) -> bool {
    let b = s.as_bytes();
    let mut i = 0;
    if b.first() == Some(&b'-') {
        i += 1;
    }
    let digits = |i: &mut usize| {
        let st = *i;
        while *i < b.len() && b[*i].is_ascii_digit() {
            *i += 1;
        }
        *i - st
    };
    match b.get(i) {
        Some(b'0') => i += 1,
        Some(b'1'..=b'9') => {
            digits(&mut i);
        }
        _ => return false,
    }
    if b.get(i) == Some(&b'.') {
        i += 1;
        if digits(&mut i) == 0 {
            return false;
        }
    }
    if matches!(b.get(i), Some(b'e' | b'E')) {
        i += 1;
        if matches!(b.get(i), Some(b'+' | b'-')) {
            i += 1;
        }
        if digits(&mut i) == 0 {
            return false;
        }
    }
    i == b.len()
}

enum Exact {
    Int(bool, u128),
    NotInt,
    TooBig,
}

/// The exact integer value of a JSON number, if it is integral.
fn exact_int(t: &str) -> Exact {
    let (neg, t) = match t.strip_prefix('-') {
        Some(r) => (true, r),
        None => (false, t),
    };
    let (mant, exp) = match t.find(['e', 'E']) {
        Some(i) => (&t[..i], t[i + 1..].parse::<i64>().unwrap_or(i64::MAX)),
        None => (t, 0),
    };
    let (ip, fp) = mant.split_once('.').unwrap_or((mant, ""));
    let mut digits: Vec<u8> = ip.bytes().chain(fp.bytes()).collect();
    let mut exp = exp.saturating_sub(fp.len() as i64);
    while digits.len() > 1 && digits[0] == b'0' {
        digits.remove(0);
    }
    if digits == b"0" {
        return Exact::Int(false, 0);
    }
    while exp < 0 {
        match digits.pop() {
            Some(b'0') => exp += 1,
            Some(_) => return Exact::NotInt,
            None => return Exact::Int(false, 0),
        }
    }
    if exp > 40 || digits.len() as i64 + exp > 40 {
        return Exact::TooBig;
    }
    let mut x: u128 = 0;
    for d in digits
        .iter()
        .copied()
        .chain(std::iter::repeat_n(b'0', exp as usize))
    {
        match x
            .checked_mul(10)
            .and_then(|x| x.checked_add((d - b'0') as u128))
        {
            Some(y) => x = y,
            None => return Exact::TooBig,
        }
    }
    Exact::Int(neg && x != 0, x)
}

/// How a JSON value is named in an error.
fn got(r: &Raw) -> String {
    fn cut(s: &str) -> String {
        if s.chars().count() > 32 {
            format!("{}...", s.chars().take(32).collect::<String>())
        } else {
            s.to_string()
        }
    }
    match r {
        Raw::Null => "null".into(),
        Raw::Bool(b) => b.to_string(),
        Raw::Num(t) => cut(t),
        Raw::Str(s) => {
            let mut out = String::new();
            json::escape(&cut(s), &mut out);
            out
        }
        Raw::Arr(_) => "an array".into(),
        Raw::Obj(_) => "an object".into(),
    }
}

fn expected(path: &str, what: &str, r: &Raw) -> String {
    format!("{}: expected {}, got {}", path, what, got(r))
}

/// The path of a member of an object.
fn push_key(path: &mut String, k: &str) {
    let simple = k
        .chars()
        .next()
        .is_some_and(|c| c.is_ascii_alphabetic() || c == '_')
        && k.chars()
            .all(|c| c.is_ascii_alphanumeric() || c == '_' || c == '-');
    if simple {
        path.push('.');
        path.push_str(k);
    } else {
        path.push('[');
        json::escape(k, path);
        path.push(']');
    }
}

fn with_key<T>(path: &mut String, k: &str, f: impl FnOnce(&mut String) -> T) -> T {
    let len = path.len();
    push_key(path, k);
    let r = f(path);
    path.truncate(len);
    r
}

fn with_index<T>(path: &mut String, i: usize, f: impl FnOnce(&mut String) -> T) -> T {
    let len = path.len();
    path.push_str(&format!("[{}]", i));
    let r = f(path);
    path.truncate(len);
    r
}

/// The last member named `k` of an object.
fn member<'r>(fs: &'r [(String, Raw)], k: &str) -> Option<&'r Raw> {
    fs.iter().rev().find(|(n, _)| n == k).map(|(_, v)| v)
}

/// A number, or a string holding one.
fn number_text(r: &Raw) -> Option<&str> {
    match r {
        Raw::Num(t) => Some(t),
        Raw::Str(s) if is_number(s) => Some(s),
        _ => None,
    }
}

fn int_value(name: &str, neg: bool, mag: u128) -> Option<Value> {
    let signed = |max: u128| -> Option<i128> {
        if neg {
            (mag <= max + 1).then(|| (mag as i128).wrapping_neg())
        } else {
            (mag <= max).then_some(mag as i128)
        }
    };
    let unsigned = |max: u128| -> Option<u128> { (!neg && mag <= max).then_some(mag) };
    Some(match name {
        "I8" => Value::I8(signed(i8::MAX as u128)? as i8),
        "I16" => Value::I16(signed(i16::MAX as u128)? as i16),
        "I32" => Value::I32(signed(i32::MAX as u128)? as i32),
        "I64" | "ISize" => Value::I64(signed(i64::MAX as u128)? as i64),
        "I128" => {
            if neg && mag == 1u128 << 127 {
                Value::I128(i128::MIN)
            } else {
                Value::I128(signed(i128::MAX as u128)?)
            }
        }
        "U8" => Value::U8(unsigned(u8::MAX as u128)? as u8),
        "U16" => Value::U16(unsigned(u16::MAX as u128)? as u16),
        "U32" => Value::U32(unsigned(u32::MAX as u128)? as u32),
        "U64" | "USize" => Value::U64(unsigned(u64::MAX as u128)? as u64),
        "U128" => Value::U128(unsigned(u128::MAX)?),
        _ => return None,
    })
}

fn decode_int(r: &Raw, name: &str, path: &str) -> Result<Value, String> {
    let Some(t) = number_text(r) else {
        return Err(expected(path, "an integer", r));
    };
    let range = || format!("{}: {} is out of range for {}", path, got(r), name);
    match exact_int(t) {
        Exact::NotInt => Err(expected(path, "an integer", r)),
        Exact::TooBig => Err(range()),
        Exact::Int(neg, mag) => int_value(name, neg, mag).ok_or_else(range),
    }
}

fn decode_float(r: &Raw, path: &str) -> Result<String, String> {
    match r {
        Raw::Str(s) if s == "NaN" || s == "Infinity" || s == "-Infinity" => Ok(match s.as_str() {
            "NaN" => "NaN".into(),
            "Infinity" => "inf".into(),
            _ => "-inf".into(),
        }),
        _ => number_text(r)
            .map(str::to_string)
            .ok_or_else(|| expected(path, "a number", r)),
    }
}

/// A duration as `show` writes it (`1500ms`), possibly with a fraction
/// (`1.5s`), in nanoseconds.
pub fn parse_duration(s: &str) -> Option<i64> {
    let (neg, s) = match s.strip_prefix('-') {
        Some(r) => (true, r),
        None => (false, s),
    };
    let end = s.find(|c: char| !c.is_ascii_digit() && c != '.')?;
    let (num, unit) = s.split_at(end);
    let scale: i128 = match unit {
        "ns" => 1,
        "us" => 1_000,
        "ms" => 1_000_000,
        "s" => 1_000_000_000,
        "min" => 60_000_000_000,
        "h" => 3_600_000_000_000,
        _ => return None,
    };
    let (ip, fp) = num.split_once('.').unwrap_or((num, ""));
    if ip.is_empty()
        || ip.len() > 20
        || fp.len() > 20
        || num.ends_with('.')
        || !ip.bytes().all(|c| c.is_ascii_digit())
        || !fp.bytes().all(|c| c.is_ascii_digit())
    {
        return None;
    }
    let mut total: i128 = ip.parse::<i128>().ok()?.checked_mul(scale)?;
    let mut frac = fp.parse::<i128>().unwrap_or(0) * scale;
    for _ in 0..fp.len() {
        if frac % 10 != 0 {
            return None;
        }
        frac /= 10;
    }
    total = total.checked_add(frac)?;
    if neg {
        total = -total;
    }
    i64::try_from(total).ok()
}

fn decode(r: &Raw, mt: &MT, prog: &Program, path: &mut String) -> Result<Value, String> {
    Ok(match shape(mt, prog) {
        Shape::Int(name) | Shape::Wide(name) => decode_int(r, &name, path)?,
        Shape::TInt(w) => {
            let max = (3i128.pow(w.min(40) as u32) - 1) / 2;
            let v = decode_int(r, "I128", path)
                .map_err(|_| expected(path, "an integer", r))?
                .as_i128()
                .unwrap_or(0);
            if v.abs() > max {
                return Err(format!(
                    "{}: {} is out of range for TInt[{}]",
                    path,
                    got(r),
                    w
                ));
            }
            Value::TInt(v as i64)
        }
        Shape::Trit => {
            let v = decode_int(r, "I128", path)
                .map_err(|_| expected(path, "an integer", r))?
                .as_i128()
                .unwrap_or(0);
            if v.abs() > 1 {
                return Err(format!("{}: {} is out of range for Trit", path, got(r)));
            }
            Value::Trit(v as i8)
        }
        Shape::F32 => Value::F32(decode_float(r, path)?.parse().unwrap_or(0.0)),
        Shape::F64 => Value::F64(decode_float(r, path)?.parse().unwrap_or(0.0)),
        Shape::Str => match r {
            Raw::Str(s) => Value::str(s),
            _ => return Err(expected(path, "a string", r)),
        },
        Shape::Bytes => match r {
            Raw::Str(s) => match unbase64(s) {
                Some(b) => Value::Bytes(Rc::from(b)),
                None => return Err(expected(path, "a base64 string", r)),
            },
            _ => return Err(expected(path, "a base64 string", r)),
        },
        Shape::Duration => {
            let ns = match r {
                Raw::Str(s) => parse_duration(s),
                Raw::Num(t) => match exact_int(t) {
                    Exact::Int(neg, mag) => match int_value("I64", neg, mag) {
                        Some(Value::I64(x)) => Some(x),
                        _ => None,
                    },
                    _ => None,
                },
                _ => None,
            };
            match ns {
                Some(ns) => Value::tuple(vec![Value::I64(ns)]),
                None => return Err(expected(path, "a duration", r)),
            }
        }
        Shape::Bool => match r {
            Raw::Bool(b) => Value::bool(*b),
            Raw::Str(s) if s == "true" || s == "false" => Value::bool(s == "true"),
            _ => return Err(expected(path, "true or false", r)),
        },
        Shape::Json => r.to_value(),
        Shape::Unit => match r {
            Raw::Obj(_) | Raw::Null => Value::unit(),
            Raw::Arr(xs) if xs.is_empty() => Value::unit(),
            _ => return Err(expected(path, "{}", r)),
        },
        Shape::Option(t) => match r {
            Raw::Null => Value::nullary(0),
            _ if is_option(&t) => match r {
                Raw::Arr(xs) if xs.len() == 1 => {
                    let x = with_index(path, 0, |p| decode(&xs[0], &t, prog, p))?;
                    Value::data(1, vec![x])
                }
                _ => return Err(expected(path, "null or a one-element array", r)),
            },
            _ => Value::data(1, vec![decode(r, &t, prog, path)?]),
        },
        Shape::List(t) | Shape::Array(t) | Shape::Set(t) => {
            let Raw::Arr(xs) = r else {
                return Err(expected(path, "an array", r));
            };
            let mut items = Vec::new();
            for (i, x) in xs.iter().enumerate() {
                items.push(with_index(path, i, |p| decode(x, &t, prog, p))?);
            }
            match shape(mt, prog) {
                Shape::List(_) => Value::list(items),
                Shape::Array(_) => Value::Array(Rc::new(items)),
                _ => Value::Map(Rc::new(
                    items.into_iter().map(|k| (k, Value::unit())).collect(),
                )),
            }
        }
        Shape::Map(kt, vt) => {
            let mut m = BTreeMap::new();
            if is_string(&kt) {
                let Raw::Obj(fs) = r else {
                    return Err(expected(path, "an object", r));
                };
                for (k, x) in fs {
                    let v = with_key(path, k, |p| decode(x, &vt, prog, p))?;
                    m.insert(Value::str(k), v);
                }
            } else {
                let what = "an array of [key, value] pairs";
                let Raw::Arr(xs) = r else {
                    return Err(expected(path, what, r));
                };
                for (i, x) in xs.iter().enumerate() {
                    let (k, v) = with_index(path, i, |p| match x {
                        Raw::Arr(kv) if kv.len() == 2 => {
                            let k = with_index(p, 0, |p| decode(&kv[0], &kt, prog, p))?;
                            let v = with_index(p, 1, |p| decode(&kv[1], &vt, prog, p))?;
                            Ok((k, v))
                        }
                        _ => Err(expected(p, "a [key, value] pair", x)),
                    })?;
                    m.insert(k, v);
                }
            }
            Value::Map(Rc::new(m))
        }
        Shape::Tuple(ts) => Value::tuple(decode_tuple(r, &ts, prog, path)?),
        Shape::Record(_, fts, order, names) => {
            let Raw::Obj(fs) = r else {
                return Err(expected(path, "an object", r));
            };
            // in declaration order, so that errors come in that order
            let mut out = vec![Value::unit(); fts.len()];
            for i in order {
                let (t, l) = (&fts[i].1, &names[i]);
                out[i] = with_key(path, l, |p| match member(fs, l) {
                    Some(x) => decode(x, t, prog, p),
                    None if is_option(t) => Ok(Value::nullary(0)),
                    None => Err(format!("{}: required field is missing", p)),
                })?;
            }
            Value::tuple(out)
        }
        Shape::Enum(_, names) => {
            let tag = match r {
                Raw::Str(s) => names.iter().position(|n| n == s),
                _ => None,
            };
            match tag {
                Some(t) => Value::nullary(t as u32),
                None => return Err(expected(path, &one_of(&names), r)),
            }
        }
        Shape::Untagged(name, vs) => {
            if matches!(r, Raw::Null) {
                if let Some(t) = vs.iter().position(|(_, f)| f.is_empty()) {
                    return Ok(Value::nullary(t as u32));
                }
            }
            for (tag, (_, fts)) in vs.iter().enumerate() {
                let mut p = path.clone();
                let got = match fts.len() {
                    0 => continue,
                    1 => decode(r, &fts[0], prog, &mut p).map(|x| vec![x]),
                    _ => decode_tuple(r, fts, prog, &mut p),
                };
                if let Ok(fields) = got {
                    return Ok(Value::data(tag as u32, fields));
                }
            }
            return Err(expected(
                path,
                &format!("a value of one of the variants of {}", name),
                r,
            ));
        }
        Shape::Adt(_, vs) => {
            let names: Vec<String> = vs.iter().map(|(n, _)| n.clone()).collect();
            let tag_of = |s: &str| names.iter().position(|n| n == s);
            match r {
                Raw::Str(s) if tag_of(s).is_some_and(|t| vs[t].1.is_empty()) => {
                    Value::nullary(tag_of(s).unwrap() as u32)
                }
                Raw::Obj(fs) => {
                    let tag = with_key(path, "type", |p| match member(fs, "type") {
                        None => Err(format!("{}: required field is missing", p)),
                        Some(t @ Raw::Str(s)) => {
                            tag_of(s).ok_or_else(|| expected(p, &one_of(&names), t))
                        }
                        Some(t) => Err(expected(p, &one_of(&names), t)),
                    })?;
                    let fts = &vs[tag].1;
                    let fields = if fts.is_empty() {
                        vec![]
                    } else {
                        with_key(path, "value", |p| match member(fs, "value") {
                            None => Err(format!("{}: required field is missing", p)),
                            Some(x) if fts.len() == 1 => Ok(vec![decode(x, &fts[0], prog, p)?]),
                            Some(x) => decode_tuple(x, fts, prog, p),
                        })?
                    };
                    Value::data(tag as u32, fields)
                }
                _ => return Err(expected(path, "an object with a \"type\"", r)),
            }
        }
        Shape::Other => return Err(format!("{}: values of type {} cannot be decoded", path, mt)),
    })
}

fn one_of(names: &[String]) -> String {
    let quoted: Vec<String> = names.iter().map(|n| format!("\"{}\"", n)).collect();
    format!("one of {}", quoted.join(", "))
}

fn decode_tuple(
    r: &Raw,
    ts: &[MT],
    prog: &Program,
    path: &mut String,
) -> Result<Vec<Value>, String> {
    let what = format!("an array of {} elements", ts.len());
    match r {
        Raw::Arr(xs) if xs.len() == ts.len() => {
            let mut out = Vec::new();
            for (i, (x, t)) in xs.iter().zip(ts).enumerate() {
                out.push(with_index(path, i, |p| decode(x, t, prog, p))?);
            }
            Ok(out)
        }
        Raw::Arr(xs) => Err(format!("{}: expected {}, got {}", path, what, xs.len())),
        _ => Err(expected(path, &what, r)),
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn exact_integers() {
        let int = |t: &str| match exact_int(t) {
            Exact::Int(n, m) => Some((n, m)),
            _ => None,
        };
        assert_eq!(int("42"), Some((false, 42)));
        assert_eq!(int("-0"), Some((false, 0)));
        assert_eq!(int("1e3"), Some((false, 1000)));
        assert_eq!(int("1.50e1"), Some((false, 15)));
        assert_eq!(int("1.5"), None);
        assert_eq!(int("-12.000"), Some((true, 12)));
        assert_eq!(int("0.0e5"), Some((false, 0)));
        assert!(matches!(exact_int("1e50"), Exact::TooBig));
    }

    #[test]
    fn base64_round_trip() {
        for s in ["", "f", "fo", "foo", "foob", "fooba", "foobar"] {
            let e = base64(s.as_bytes());
            assert_eq!(unbase64(&e).unwrap(), s.as_bytes());
        }
        assert_eq!(base64(b"foobar"), "Zm9vYmFy");
        assert_eq!(base64(b"fo"), "Zm8=");
        assert_eq!(unbase64("Zm8").unwrap(), b"fo");
        assert!(unbase64("Z").is_none());
        assert!(unbase64("Zm 8").is_none());
    }

    #[test]
    fn durations() {
        assert_eq!(parse_duration("1500ms"), Some(1_500_000_000));
        assert_eq!(parse_duration("1.5s"), Some(1_500_000_000));
        assert_eq!(parse_duration("-2min"), Some(-120_000_000_000));
        assert_eq!(parse_duration("1.5ns"), None);
        assert_eq!(parse_duration("s"), None);
        assert_eq!(parse_duration("1."), None);
    }
}
