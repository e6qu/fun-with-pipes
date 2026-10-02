//! Interpreter implementations of the standard library primitives (lists,
//! strings, collections, bytes and console IO).

use std::collections::{BTreeMap, BTreeSet};
use std::io::{BufRead, Read, Write};
use std::rc::Rc;
use std::sync::OnceLock;

use crate::interp::{arith, checked_int, wrapping, Ctl, Interp, Op, R};
use crate::ir::MT;
use crate::value::*;

fn some(v: Value) -> Value {
    Value::data(1, vec![v])
}

fn none() -> Value {
    Value::nullary(0)
}

fn opt(v: Option<Value>) -> Value {
    v.map(some).unwrap_or_else(none)
}

fn int(v: &Value) -> i64 {
    v.as_i128().unwrap_or(0) as i64
}

fn chars(s: &str) -> Vec<char> {
    s.chars().collect()
}

fn inner(mt: &MT) -> MT {
    match mt {
        MT::Con(_, args) if !args.is_empty() => args[0].clone(),
        _ => MT::unit(),
    }
}

fn trap<T>(msg: impl Into<String>) -> R<T> {
    Err(Ctl::Trap(msg.into()))
}

/// `[+-]?[0-9]+`
pub fn valid_int(s: &str) -> bool {
    let d = s.strip_prefix(['+', '-']).unwrap_or(s);
    !d.is_empty() && d.bytes().all(|b| b.is_ascii_digit())
}

/// `parse-float`'s non-finite values, in any case: `nan`, and `inf` or
/// `infinity` with an optional sign (`show` writes `NaN`, `inf`, `-inf`).
fn special_float(s: &str) -> Option<f64> {
    let (neg, rest) = match s.as_bytes().first() {
        Some(b'-') => (true, &s[1..]),
        Some(b'+') => (false, &s[1..]),
        _ => (false, s),
    };
    if rest.eq_ignore_ascii_case("inf") || rest.eq_ignore_ascii_case("infinity") {
        Some(if neg {
            f64::NEG_INFINITY
        } else {
            f64::INFINITY
        })
    } else if s.eq_ignore_ascii_case("nan") {
        Some(f64::NAN)
    } else {
        None
    }
}

/// `[+-]?(digits(.digits?)?|.digits)([eE][+-]?digits)?`
pub fn valid_float(s: &str) -> bool {
    let b = s.as_bytes();
    let mut i = 0;
    if i < b.len() && (b[i] == b'+' || b[i] == b'-') {
        i += 1;
    }
    let start = i;
    while i < b.len() && b[i].is_ascii_digit() {
        i += 1;
    }
    let int_digits = i - start;
    let mut frac_digits = 0;
    if i < b.len() && b[i] == b'.' {
        i += 1;
        let fs = i;
        while i < b.len() && b[i].is_ascii_digit() {
            i += 1;
        }
        frac_digits = i - fs;
    }
    if int_digits == 0 && frac_digits == 0 {
        return false;
    }
    if i < b.len() && (b[i] == b'e' || b[i] == b'E') {
        i += 1;
        if i < b.len() && (b[i] == b'+' || b[i] == b'-') {
            i += 1;
        }
        let es = i;
        while i < b.len() && b[i].is_ascii_digit() {
            i += 1;
        }
        if i == es {
            return false;
        }
    }
    i == b.len()
}

/// Split into lines like Rust's `str::lines` (no trailing empty line, `\r`
/// before `\n` removed).
pub fn split_lines(s: &str) -> Vec<String> {
    s.lines().map(|l| l.to_string()).collect()
}

fn start_instant() -> &'static std::time::Instant {
    static START: OnceLock<std::time::Instant> = OnceLock::new();
    START.get_or_init(std::time::Instant::now)
}

fn duration(ns: i64) -> Value {
    Value::tuple(vec![Value::I64(ns)])
}

impl<'p> Interp<'p> {
    /// Standard library primitives; `None` if `sym` is not one of them.
    pub(crate) fn prim_std(
        &mut self,
        sym: &str,
        a: &mut [Value],
        params: &[MT],
        result: &MT,
    ) -> Option<R<Value>> {
        // `Ok(None)`: not one of these primitives
        let r = (|| -> R<Option<Value>> {
            Ok(Some(match sym {
                // ----- lists
                "fold-right" => {
                    let f = a[0].clone();
                    let mut acc = a[1].clone();
                    for x in a[2].list_items().into_iter().rev() {
                        acc = self.apply(f.clone(), vec![x, acc])?;
                    }
                    acc
                }
                "sort-by" => {
                    let f = a[0].clone();
                    let mut keyed = Vec::new();
                    for x in a[1].list_items() {
                        keyed.push((self.apply(f.clone(), vec![x.clone()])?, x));
                    }
                    keyed.sort_by(|p, q| p.0.cmp(&q.0));
                    Value::list(keyed.into_iter().map(|p| p.1).collect())
                }
                "reverse" => {
                    let mut v = a[0].list_items();
                    v.reverse();
                    Value::list(v)
                }
                "append" => {
                    let mut v = a[1].list_items();
                    v.extend(a[0].list_items());
                    Value::list(v)
                }
                "flatten" => Value::list(
                    a[0].list_items()
                        .iter()
                        .flat_map(|l| l.list_items())
                        .collect(),
                ),
                "take" => {
                    let n = int(&a[0]).max(0) as usize;
                    Value::list(a[1].list_items().into_iter().take(n).collect())
                }
                "drop" => {
                    let n = int(&a[0]).max(0) as usize;
                    Value::list(a[1].list_items().into_iter().skip(n).collect())
                }
                "take-while" | "drop-while" => {
                    let f = a[0].clone();
                    let items = a[1].list_items();
                    let mut n = 0;
                    for x in &items {
                        if !self.apply(f.clone(), vec![x.clone()])?.as_bool() {
                            break;
                        }
                        n += 1;
                    }
                    if sym == "take-while" {
                        Value::list(items[..n].to_vec())
                    } else {
                        Value::list(items[n..].to_vec())
                    }
                }
                "zip" => {
                    let ys = a[0].list_items();
                    let xs = a[1].list_items();
                    Value::list(
                        xs.into_iter()
                            .zip(ys)
                            .map(|(x, y)| Value::tuple(vec![x, y]))
                            .collect(),
                    )
                }
                "zip-with" => {
                    let f = a[0].clone();
                    let ys = a[1].list_items();
                    let xs = a[2].list_items();
                    let mut out = Vec::new();
                    // data-last: the subject's element is the last argument,
                    // so `xs | zip-with sub ys` is x - y
                    for (x, y) in xs.into_iter().zip(ys) {
                        out.push(self.apply(f.clone(), vec![y, x])?);
                    }
                    Value::list(out)
                }
                "unzip" => {
                    let (mut l, mut r) = (Vec::new(), Vec::new());
                    for p in a[0].list_items() {
                        if let Value::Record(fs) = &p {
                            l.push(fs[0].clone());
                            r.push(fs[1].clone());
                        }
                    }
                    Value::tuple(vec![Value::list(l), Value::list(r)])
                }
                "range" => {
                    // `i < hi` before each step, so `i + 1` cannot overflow
                    let mut out = Vec::new();
                    if let (Value::U128(lo), Value::U128(hi)) = (&a[0], &a[1]) {
                        let mut i = *lo;
                        while i < *hi {
                            out.push(Value::U128(i));
                            i += 1;
                        }
                    } else {
                        let t = &params[0];
                        let (lo, hi) = (a[0].as_i128().unwrap(), a[1].as_i128().unwrap());
                        let mut i = lo;
                        while i < hi {
                            out.push(checked_int(t, i).unwrap());
                            i += 1;
                        }
                    }
                    Value::list(out)
                }
                "repeat" => Value::list(vec![a[1].clone(); int(&a[0]).max(0) as usize]),
                "nth" => {
                    let n = int(&a[0]);
                    opt(if n < 0 {
                        None
                    } else {
                        a[1].list_items().into_iter().nth(n as usize)
                    })
                }
                "find" => {
                    let f = a[0].clone();
                    let mut found = None;
                    for x in a[1].list_items() {
                        if self.apply(f.clone(), vec![x.clone()])?.as_bool() {
                            found = Some(x);
                            break;
                        }
                    }
                    opt(found)
                }
                "index-of" => opt(a[1]
                    .list_items()
                    .iter()
                    .position(|x| fwp_eq(x, &a[0]))
                    .map(|i| Value::I64(i as i64))),
                "unique" => {
                    let mut seen = BTreeSet::new();
                    let mut out = Vec::new();
                    for x in a[0].list_items() {
                        if seen.insert(x.clone()) {
                            out.push(x);
                        }
                    }
                    Value::list(out)
                }
                "scan" => {
                    let f = a[0].clone();
                    let mut acc = a[1].clone();
                    let mut out = vec![acc.clone()];
                    for x in a[2].list_items() {
                        acc = self.apply(f.clone(), vec![acc, x])?;
                        out.push(acc.clone());
                    }
                    Value::list(out)
                }
                "chunks" => {
                    let n = int(&a[0]);
                    if n <= 0 {
                        return trap("chunks: size must be positive");
                    }
                    Value::list(
                        a[1].list_items()
                            .chunks(n as usize)
                            .map(|c| Value::list(c.to_vec()))
                            .collect(),
                    )
                }
                "iterate" => {
                    let n = int(&a[0]).max(0);
                    let f = a[1].clone();
                    let mut x = a[2].clone();
                    let mut out = Vec::new();
                    for i in 0..n {
                        out.push(x.clone());
                        if i + 1 < n {
                            x = self.apply(f.clone(), vec![x])?;
                        }
                    }
                    Value::list(out)
                }
                // ----- strings
                "trim-start" => {
                    Value::str(a[0].as_str().trim_start_matches([' ', '\t', '\n', '\r']))
                }
                "trim-end" => Value::str(a[0].as_str().trim_end_matches([' ', '\t', '\n', '\r'])),
                "string.length" => Value::I64(a[0].as_str().chars().count() as i64),
                "string.byte-length" => Value::I64(a[0].as_str().len() as i64),
                "string.chars" => Value::list(
                    a[0].as_str()
                        .chars()
                        .map(|c| Value::str(&c.to_string()))
                        .collect(),
                ),
                "split" => {
                    let (sep, s) = (a[0].as_str(), a[1].as_str());
                    if sep.is_empty() {
                        Value::list(s.chars().map(|c| Value::str(&c.to_string())).collect())
                    } else {
                        Value::list(s.split(sep).map(Value::str).collect())
                    }
                }
                "join" => {
                    let parts: Vec<String> = a[1]
                        .list_items()
                        .iter()
                        .map(|p| p.as_str().to_string())
                        .collect();
                    Value::str(&parts.join(a[0].as_str()))
                }
                "lines" => Value::list(
                    split_lines(a[0].as_str())
                        .iter()
                        .map(|l| Value::str(l))
                        .collect(),
                ),
                "words" => Value::list(
                    a[0].as_str()
                        .split([' ', '\t', '\n', '\r'])
                        .filter(|w| !w.is_empty())
                        .map(Value::str)
                        .collect(),
                ),
                "string.contains" => Value::bool(a[1].as_str().contains(a[0].as_str())),
                "starts-with" => Value::bool(a[1].as_str().starts_with(a[0].as_str())),
                "ends-with" => Value::bool(a[1].as_str().ends_with(a[0].as_str())),
                "replace" => {
                    let (from, to, s) = (a[0].as_str(), a[1].as_str(), a[2].as_str());
                    if from.is_empty() {
                        Value::str(s)
                    } else {
                        Value::str(&s.replace(from, to))
                    }
                }
                "string.repeat" => Value::str(&a[1].as_str().repeat(int(&a[0]).max(0) as usize)),
                "string.reverse" => Value::str(&a[0].as_str().chars().rev().collect::<String>()),
                "string.slice" => {
                    let cs = chars(a[2].as_str());
                    let start = (int(&a[0]).max(0) as usize).min(cs.len());
                    let len = int(&a[1]).max(0) as usize;
                    let end = (start + len).min(cs.len());
                    Value::str(&cs[start..end].iter().collect::<String>())
                }
                "string.find" => {
                    let (needle, s) = (a[0].as_str(), a[1].as_str());
                    opt(s
                        .find(needle)
                        .map(|byte| Value::I64(s[..byte].chars().count() as i64)))
                }
                "pad-left" | "pad-right" => {
                    let n = int(&a[0]).max(0) as usize;
                    let fill = a[1].as_str().chars().next();
                    let s = a[2].as_str();
                    let len = s.chars().count();
                    match fill {
                        Some(c) if len < n => {
                            let pad: String = std::iter::repeat_n(c, n - len).collect();
                            if sym == "pad-left" {
                                Value::str(&format!("{}{}", pad, s))
                            } else {
                                Value::str(&format!("{}{}", s, pad))
                            }
                        }
                        _ => Value::str(s),
                    }
                }
                "string.codepoints" => Value::list(
                    a[0].as_str()
                        .chars()
                        .map(|c| Value::U32(c as u32))
                        .collect(),
                ),
                "string.from-codepoints" => {
                    let mut s = String::new();
                    let mut ok = true;
                    for c in a[0].list_items() {
                        match char::from_u32(c.as_i128().unwrap_or(-1) as u32) {
                            Some(ch) => s.push(ch),
                            None => {
                                ok = false;
                                break;
                            }
                        }
                    }
                    opt(ok.then(|| Value::str(&s)))
                }
                "string.to-bytes" => Value::Bytes(Rc::from(a[0].as_str().as_bytes())),
                "string.from-bytes" => match &a[0] {
                    Value::Bytes(b) => opt(std::str::from_utf8(b).ok().map(Value::str)),
                    _ => none(),
                },
                "parse-int" => {
                    let s = a[0].as_str();
                    let t = inner(result);
                    if !valid_int(s) {
                        none()
                    } else if let Ok(x) = s.parse::<i128>() {
                        opt(checked_int(&t, x))
                    } else if let Ok(x) = s.trim_start_matches('+').parse::<u128>() {
                        opt((t == MT::con("std::U128")).then_some(Value::U128(x)))
                    } else {
                        none()
                    }
                }
                "parse-float" => {
                    let s = a[0].as_str();
                    let t = inner(result);
                    if let Some(x) = special_float(s) {
                        some(match t {
                            MT::Con(n, _) if n == "std::F32" => Value::F32(x as f32),
                            _ => Value::F64(x),
                        })
                    } else if !valid_float(s) {
                        none()
                    } else {
                        let x: f64 = s.parse().unwrap_or(f64::NAN);
                        some(match t {
                            MT::Con(n, _)
                                if matches!(n.as_str(), "std::F32" | "std::F16" | "std::BF16") =>
                            {
                                Value::F32(s.parse().unwrap_or(f32::NAN))
                            }
                            _ => Value::F64(x),
                        })
                    }
                }
                "format" => {
                    let tmpl = a[0].as_str().to_string();
                    let mt = &params[1];
                    let parts: Vec<String> = match (&a[1], mt) {
                        (Value::Record(fs), MT::Record(ts)) if !ts.is_empty() => fs
                            .iter()
                            .zip(ts)
                            .map(|(v, (_, t))| display(v, t, self.prog, true))
                            .collect(),
                        (v, t) => vec![display(v, t, self.prog, true)],
                    };
                    let holes = format_placeholders(&tmpl);
                    if holes != parts.len() {
                        return trap(format!(
                            "format: placeholder count ({}) does not match value count ({}) in \"{}\"",
                            holes,
                            parts.len(),
                            tmpl
                        ));
                    }
                    let mut out = String::new();
                    let mut it = parts.into_iter();
                    let mut cs = tmpl.chars().peekable();
                    while let Some(c) = cs.next() {
                        match (c, cs.peek()) {
                            ('{', Some('{')) => {
                                cs.next();
                                out.push('{');
                            }
                            ('}', Some('}')) => {
                                cs.next();
                                out.push('}');
                            }
                            ('{', Some('}')) => {
                                cs.next();
                                match it.next() {
                                    Some(p) => out.push_str(&p),
                                    None => out.push_str("{}"),
                                }
                            }
                            _ => out.push(c),
                        }
                    }
                    Value::str(&out)
                }
                // ----- balanced ternary
                "trit.from-sign" => Value::Trit(int(&a[0]).signum() as i8),
                "trit.to-int" => Value::I64(a[0].as_i128().unwrap_or(0) as i64),
                "tint.to-int" => Value::I64(a[0].as_i128().unwrap_or(0) as i64),
                "tint.of-int" => opt(checked_int(&inner(result), int(&a[0]) as i128)),
                "tint.trits" => {
                    let w = nat_arg(&params[0]);
                    Value::list(
                        tint_digits(int(&a[0]), w)
                            .into_iter()
                            .map(Value::Trit)
                            .collect(),
                    )
                }
                "tint.from-trits" => {
                    let t = inner(result);
                    let items = a[0].list_items();
                    if items.len() as u64 > nat_arg(&t) {
                        none()
                    } else {
                        let v = items
                            .iter()
                            .fold(0i128, |acc, x| acc * 3 + x.as_i128().unwrap_or(0));
                        opt(checked_int(&t, v))
                    }
                }
                "trits.pack" => {
                    let ts: Vec<i64> = a[0]
                        .list_items()
                        .iter()
                        .map(|x| x.as_i128().unwrap_or(0) as i64)
                        .collect();
                    let mut out = Vec::new();
                    for chunk in ts.chunks(5) {
                        let mut b: u32 = 0;
                        for (k, t) in chunk.iter().enumerate() {
                            b += ((t + 1) as u32) * 3u32.pow(k as u32);
                        }
                        out.push(b as u8);
                    }
                    Value::Bytes(Rc::from(out))
                }
                "trits.unpack" => {
                    let bs = bytes(&a[1]);
                    // only trits the bytes hold: none past the end
                    let n = (int(&a[0]).max(0) as usize).min(bs.len() * 5);
                    let mut out = Vec::new();
                    for i in 0..n {
                        let byte = bs[i / 5] as u32;
                        let d = (byte / 3u32.pow((i % 5) as u32)) % 3;
                        out.push(Value::Trit(d as i8 - 1));
                    }
                    Value::list(out)
                }
                // ----- portable SIMD (lanes in a one-field record)
                "simd.splat" => {
                    let n = nat_arg(result) as usize;
                    Value::tuple(vec![Value::Array(Rc::new(vec![a[0].clone(); n]))])
                }
                "simd.from-array" => {
                    let n = nat_arg(&inner(result)) as usize;
                    let v = arr(&a[0]);
                    opt((v.len() == n).then(|| Value::tuple(vec![Value::Array(v)])))
                }
                "simd.add" | "simd.sub" | "simd.mul" | "simd.div" | "simd.min" | "simd.max" => {
                    let (ys, xs) = (lanes(&a[0]), lanes(&a[1]));
                    let mut out = Vec::new();
                    for (x, y) in xs.iter().zip(ys.iter()) {
                        out.push(simd_lane(sym, x, y, &params[0])?);
                    }
                    Value::tuple(vec![Value::Array(Rc::new(out))])
                }
                "simd.sum" => {
                    let xs = lanes(&a[0]);
                    let mut acc = match xs.first() {
                        Some(x) => x.clone(),
                        None => crate::interp::zero_of(result)?,
                    };
                    for x in xs.iter().skip(1) {
                        acc = if x.as_f64().is_some() {
                            arith(Op::Add, &acc, x, result)?
                        } else {
                            wrapping(Op::Add, &acc, x)?
                        };
                    }
                    acc
                }
                // ----- linear algebra
                "linalg.lu-solve" => {
                    let n = int(&a[0]);
                    let (am, bv) = (f64s(&a[1]), f64s(&a[2]));
                    la_check(sym, am.len(), n, n)?;
                    la_check(sym, bv.len(), n, 1)?;
                    let n = n as usize;
                    opt(crate::linalg::lu_solve(n, &am, &bv).map(|x| f64_array(&x)))
                }
                "linalg.det" => {
                    let (n, am) = (int(&a[0]), f64s(&a[1]));
                    la_check(sym, am.len(), n, n)?;
                    Value::F64(crate::linalg::det(n as usize, &am))
                }
                "linalg.inverse" => {
                    let (n, am) = (int(&a[0]), f64s(&a[1]));
                    la_check(sym, am.len(), n, n)?;
                    opt(crate::linalg::inverse(n as usize, &am).map(|x| f64_array(&x)))
                }
                "linalg.cholesky" => {
                    let (n, am) = (int(&a[0]), f64s(&a[1]));
                    la_check(sym, am.len(), n, n)?;
                    opt(crate::linalg::cholesky(n as usize, &am).map(|x| f64_array(&x)))
                }
                "linalg.qr" => {
                    let (m, n, am) = (int(&a[0]), int(&a[1]), f64s(&a[2]));
                    la_check(sym, am.len(), m, n)?;
                    let (q, r) = crate::linalg::qr(m as usize, n as usize, &am);
                    Value::tuple(vec![f64_array(&q), f64_array(&r)])
                }
                "linalg.cg" => {
                    let n = int(&a[2]);
                    let tol = a[1].as_f64().unwrap_or(0.0);
                    let (am, bv) = (f64s(&a[3]), f64s(&a[4]));
                    la_check(sym, am.len(), n, n)?;
                    la_check(sym, bv.len(), n, 1)?;
                    f64_array(&crate::linalg::cg(int(&a[0]), tol, n as usize, &am, &bv))
                }
                "list.transpose" => {
                    let rows: Vec<Vec<Value>> =
                        a[0].list_items().iter().map(|r| r.list_items()).collect();
                    let nc = rows.iter().map(|r| r.len()).min().unwrap_or(0);
                    Value::list(
                        (0..nc)
                            .map(|j| Value::list(rows.iter().map(|r| r[j].clone()).collect()))
                            .collect(),
                    )
                }
                // ----- arrays
                "array.from-list" => Value::Array(Rc::new(a[0].list_items())),
                "array.to-list" => match &a[0] {
                    Value::Array(v) => Value::list(v.to_vec()),
                    _ => Value::list(vec![]),
                },
                "array.length" => Value::I64(arr(&a[0]).len() as i64),
                "array.get" => {
                    let i = int(&a[0]);
                    let v = arr(&a[1]);
                    opt(if i < 0 {
                        None
                    } else {
                        v.get(i as usize).cloned()
                    })
                }
                "array.set" => {
                    let i = int(&a[0]);
                    let v = arr(&a[2]);
                    if i < 0 || i as usize >= v.len() {
                        none()
                    } else {
                        let mut v = v.to_vec();
                        v[i as usize] = a[1].clone();
                        some(Value::Array(Rc::new(v)))
                    }
                }
                "array.push" => {
                    let mut v = arr(&a[1]).to_vec();
                    v.push(a[0].clone());
                    Value::Array(Rc::new(v))
                }
                "array.make" => {
                    Value::Array(Rc::new(vec![a[1].clone(); int(&a[0]).max(0) as usize]))
                }
                "array.generate" => {
                    let f = a[1].clone();
                    let mut out = Vec::new();
                    for i in 0..int(&a[0]).max(0) {
                        out.push(self.apply(f.clone(), vec![Value::I64(i)])?);
                    }
                    Value::Array(Rc::new(out))
                }
                "array.map" => {
                    let f = a[0].clone();
                    let mut out = Vec::new();
                    for x in arr(&a[1]).iter() {
                        out.push(self.apply(f.clone(), vec![x.clone()])?);
                    }
                    Value::Array(Rc::new(out))
                }
                "array.fold" => {
                    let f = a[0].clone();
                    let mut acc = a[1].clone();
                    for x in arr(&a[2]).iter() {
                        acc = self.apply(f.clone(), vec![acc, x.clone()])?;
                    }
                    acc
                }
                "array.slice" => {
                    let v = arr(&a[2]);
                    let start = (int(&a[0]).max(0) as usize).min(v.len());
                    let end = (start + int(&a[1]).max(0) as usize).min(v.len());
                    Value::Array(Rc::new(v[start..end].to_vec()))
                }
                "array.append" => {
                    let mut v = arr(&a[1]).to_vec();
                    v.extend(arr(&a[0]).iter().cloned());
                    Value::Array(Rc::new(v))
                }
                "array.sort" => {
                    let mut v = arr(&a[0]).to_vec();
                    v.sort();
                    Value::Array(Rc::new(v))
                }
                // ----- maps and sets
                "map.empty" | "set.empty" => Value::Map(Rc::new(BTreeMap::new())),
                "map.insert" => {
                    let mut m = map(&a[2]);
                    m.insert(a[0].clone(), a[1].clone());
                    Value::Map(Rc::new(m))
                }
                "map.get" => opt(map_ref(&a[1]).get(&a[0]).cloned()),
                "map.remove" | "set.remove" => {
                    let mut m = map(&a[1]);
                    m.remove(&a[0]);
                    Value::Map(Rc::new(m))
                }
                "map.contains" | "set.contains" => Value::bool(map_ref(&a[1]).contains_key(&a[0])),
                "map.size" | "set.size" => Value::I64(map_ref(&a[0]).len() as i64),
                "map.keys" | "set.to-list" => Value::list(map_ref(&a[0]).keys().cloned().collect()),
                "map.values" => Value::list(map_ref(&a[0]).values().cloned().collect()),
                "map.to-list" => Value::list(
                    map_ref(&a[0])
                        .iter()
                        .map(|(k, v)| Value::tuple(vec![k.clone(), v.clone()]))
                        .collect(),
                ),
                "map.from-list" => {
                    let mut m = BTreeMap::new();
                    for p in a[0].list_items() {
                        if let Value::Record(fs) = &p {
                            m.insert(fs[0].clone(), fs[1].clone());
                        }
                    }
                    Value::Map(Rc::new(m))
                }
                "map.update" => {
                    let mut m = map(&a[3]);
                    let cur = m.get(&a[0]).cloned().unwrap_or_else(|| a[2].clone());
                    let new = self.apply(a[1].clone(), vec![cur])?;
                    m.insert(a[0].clone(), new);
                    Value::Map(Rc::new(m))
                }
                "map.map-values" => {
                    let f = a[0].clone();
                    let mut out = BTreeMap::new();
                    for (k, v) in map_ref(&a[1]).iter() {
                        out.insert(k.clone(), self.apply(f.clone(), vec![v.clone()])?);
                    }
                    Value::Map(Rc::new(out))
                }
                "set.insert" => {
                    let mut m = map(&a[1]);
                    m.insert(a[0].clone(), Value::unit());
                    Value::Map(Rc::new(m))
                }
                "set.from-list" => Value::Map(Rc::new(
                    a[0].list_items()
                        .into_iter()
                        .map(|k| (k, Value::unit()))
                        .collect(),
                )),
                "set.union" | "set.intersect" | "set.diff" => {
                    let (other, this) = (map_ref(&a[0]), map_ref(&a[1]));
                    let out: BTreeMap<Value, Value> = match sym {
                        "set.union" => this
                            .iter()
                            .chain(other.iter())
                            .map(|(k, v)| (k.clone(), v.clone()))
                            .collect(),
                        "set.intersect" => this
                            .iter()
                            .filter(|(k, _)| other.contains_key(k))
                            .map(|(k, v)| (k.clone(), v.clone()))
                            .collect(),
                        _ => this
                            .iter()
                            .filter(|(k, _)| !other.contains_key(k))
                            .map(|(k, v)| (k.clone(), v.clone()))
                            .collect(),
                    };
                    Value::Map(Rc::new(out))
                }
                // ----- bytes
                "bytes.from-list" => Value::Bytes(Rc::from(
                    a[0].list_items()
                        .iter()
                        .map(|b| b.as_i128().unwrap_or(0) as u8)
                        .collect::<Vec<u8>>(),
                )),
                "bytes.to-list" => {
                    Value::list(bytes(&a[0]).iter().map(|b| Value::U8(*b)).collect())
                }
                "bytes.length" => Value::I64(bytes(&a[0]).len() as i64),
                "bytes.get" => {
                    let i = int(&a[0]);
                    let b = bytes(&a[1]);
                    opt(if i < 0 {
                        None
                    } else {
                        b.get(i as usize).map(|x| Value::U8(*x))
                    })
                }
                "bytes.slice" => {
                    let b = bytes(&a[2]);
                    let start = (int(&a[0]).max(0) as usize).min(b.len());
                    let end = (start + int(&a[1]).max(0) as usize).min(b.len());
                    Value::Bytes(Rc::from(&b[start..end]))
                }
                "bytes.append" => {
                    let mut v = bytes(&a[1]).to_vec();
                    v.extend_from_slice(&bytes(&a[0]));
                    Value::Bytes(Rc::from(v))
                }
                // ----- console, environment, time
                "write" => {
                    let s = a[0].as_str().to_string();
                    self.out
                        .write_all(s.as_bytes())
                        .map_err(|e| Ctl::Trap(e.to_string()))?;
                    Value::unit()
                }
                "eprint" => {
                    let _ = self.out.flush();
                    eprintln!("{}", a[0].as_str());
                    Value::unit()
                }
                "read-line" => {
                    let _ = self.out.flush();
                    let mut line = Vec::new();
                    match std::io::stdin().lock().read_until(b'\n', &mut line) {
                        Ok(0) | Err(_) => none(),
                        Ok(_) => {
                            if line.ends_with(b"\n") {
                                line.pop();
                                if line.ends_with(b"\r") {
                                    line.pop();
                                }
                            }
                            some(Value::str(&lossy(&line)))
                        }
                    }
                }
                "read-all" | "read-lines" => {
                    let _ = self.out.flush();
                    let mut bytes = Vec::new();
                    let _ = std::io::stdin().lock().read_to_end(&mut bytes);
                    let s = lossy(&bytes);
                    if sym == "read-all" {
                        Value::str(&s)
                    } else {
                        Value::list(split_lines(&s).iter().map(|l| Value::str(l)).collect())
                    }
                }
                "env.get" => {
                    opt(std::env::var_os(a[0].as_str()).map(|v| Value::str(&v.to_string_lossy())))
                }
                "time.monotonic" => duration(start_instant().elapsed().as_nanos() as i64),
                "time.unix" => duration(
                    std::time::SystemTime::now()
                        .duration_since(std::time::UNIX_EPOCH)
                        .map(|d| d.as_nanos() as i64)
                        .unwrap_or(0),
                ),
                _ => return Ok(None),
            }))
        })();
        r.transpose()
    }
}

fn nat_arg(mt: &MT) -> u64 {
    match mt {
        MT::Con(_, args) => args
            .iter()
            .find_map(|a| match a {
                MT::Nat(n) => Some(*n),
                _ => None,
            })
            .unwrap_or(0),
        _ => 0,
    }
}

/// Balanced ternary digits, most significant first.
fn tint_digits(mut v: i64, width: u64) -> Vec<i8> {
    let mut ds = Vec::new();
    for _ in 0..width {
        let r = v.rem_euclid(3);
        let (d, carry) = if r == 2 { (-1, 1) } else { (r as i8, 0) };
        ds.push(d);
        v = v.div_euclid(3) + carry;
    }
    ds.reverse();
    ds
}

fn lanes(v: &Value) -> Rc<Vec<Value>> {
    match v {
        Value::Record(fs) => arr(&fs[0]),
        _ => Rc::new(vec![]),
    }
}

/// One SIMD lane: `x` is the subject, `y` the argument (data-last).
fn simd_lane(sym: &str, x: &Value, y: &Value, vt: &MT) -> R<Value> {
    let elem = match vt {
        MT::Con(_, args) => args.get(1).cloned().unwrap_or(MT::unit()),
        _ => MT::unit(),
    };
    let float = x.as_f64().is_some();
    Ok(match sym {
        "simd.add" if !float => wrapping(Op::Add, x, y)?,
        "simd.sub" if !float => wrapping(Op::Sub, x, y)?,
        "simd.mul" if !float => wrapping(Op::Mul, x, y)?,
        "simd.add" => arith(Op::Add, x, y, &elem)?,
        "simd.sub" => arith(Op::Sub, x, y, &elem)?,
        "simd.mul" => arith(Op::Mul, x, y, &elem)?,
        "simd.div" => arith(Op::Div, x, y, &elem)?,
        "simd.min" => {
            if y < x && !float || float && y.as_f64() < x.as_f64() {
                y.clone()
            } else {
                x.clone()
            }
        }
        _ => {
            if y > x && !float || float && y.as_f64() > x.as_f64() {
                y.clone()
            } else {
                x.clone()
            }
        }
    })
}

/// Traps unless an array of `len` elements holds a `rows`×`cols` matrix
/// (as `la_check` in runtime/fwp_rt_prims.c).
fn la_check(name: &str, len: usize, rows: i64, cols: i64) -> R<()> {
    if rows < 0 || cols < 0 {
        return trap(format!("{}: negative dimension", name));
    }
    let want = rows as i128 * cols as i128;
    if len as i128 != want {
        return trap(format!(
            "{}: {} elements given for a {}x{} matrix",
            name, len, rows, cols
        ));
    }
    Ok(())
}

fn f64s(v: &Value) -> Vec<f64> {
    arr(v).iter().map(|x| x.as_f64().unwrap_or(0.0)).collect()
}

fn f64_array(xs: &[f64]) -> Value {
    Value::Array(Rc::new(xs.iter().map(|x| Value::F64(*x)).collect()))
}

fn arr(v: &Value) -> Rc<Vec<Value>> {
    match v {
        Value::Array(a) => a.clone(),
        _ => Rc::new(vec![]),
    }
}

fn map(v: &Value) -> BTreeMap<Value, Value> {
    match v {
        Value::Map(m) => (**m).clone(),
        _ => BTreeMap::new(),
    }
}

fn map_ref(v: &Value) -> Rc<BTreeMap<Value, Value>> {
    match v {
        Value::Map(m) => m.clone(),
        _ => Rc::new(BTreeMap::new()),
    }
}

fn bytes(v: &Value) -> Rc<[u8]> {
    match v {
        Value::Bytes(b) => b.clone(),
        _ => Rc::from(Vec::new()),
    }
}

/// The number of `{}` placeholders in a `format` template (`{{` and `}}`
/// are literal braces).
fn format_placeholders(tmpl: &str) -> usize {
    let b = tmpl.as_bytes();
    let (mut i, mut n) = (0, 0);
    while i < b.len() {
        if i + 1 < b.len() && matches!((b[i], b[i + 1]), (b'{', b'{') | (b'}', b'}')) {
            i += 2;
        } else if i + 1 < b.len() && b[i] == b'{' && b[i + 1] == b'}' {
            n += 1;
            i += 2;
        } else {
            i += 1;
        }
    }
    n
}
