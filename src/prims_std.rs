//! Interpreter implementations of the standard library primitives (lists,
//! strings, collections, bytes and console IO).

use std::collections::{BTreeMap, BTreeSet};
use std::io::{BufRead, Read, Write};
use std::rc::Rc;
use std::sync::OnceLock;

use crate::interp::{checked_int, Ctl, Interp, R};
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
        let r: R<Value> = (|| -> R<Value> {
            Ok(match sym {
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
                    for (x, y) in xs.into_iter().zip(ys) {
                        out.push(self.apply(f.clone(), vec![x, y])?);
                    }
                    Value::list(out)
                }
                "unzip" => {
                    let (mut l, mut r) = (Vec::new(), Vec::new());
                    for p in a[0].list_items() {
                        if let Value::Record(fs) = p {
                            l.push(fs[0].clone());
                            r.push(fs[1].clone());
                        }
                    }
                    Value::tuple(vec![Value::list(l), Value::list(r)])
                }
                "range" => {
                    let t = &params[0];
                    let (lo, hi) = (a[0].as_i128().unwrap(), a[1].as_i128().unwrap());
                    let mut out = Vec::new();
                    let mut i = lo;
                    while i < hi {
                        out.push(checked_int(t, i).unwrap());
                        i += 1;
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
                    if !valid_float(s) {
                        none()
                    } else {
                        let x: f64 = s.parse().unwrap_or(f64::NAN);
                        some(match t {
                            MT::Con(n, _) if n == "std::F32" => {
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
                        if let Value::Record(fs) = p {
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
                    let mut line = String::new();
                    match std::io::stdin().lock().read_line(&mut line) {
                        Ok(0) | Err(_) => none(),
                        Ok(_) => {
                            if line.ends_with('\n') {
                                line.pop();
                                if line.ends_with('\r') {
                                    line.pop();
                                }
                            }
                            some(Value::str(&line))
                        }
                    }
                }
                "read-all" | "read-lines" => {
                    let _ = self.out.flush();
                    let mut s = String::new();
                    let _ = std::io::stdin().lock().read_to_string(&mut s);
                    if sym == "read-all" {
                        Value::str(&s)
                    } else {
                        Value::list(split_lines(&s).iter().map(|l| Value::str(l)).collect())
                    }
                }
                "env.get" => opt(std::env::var(a[0].as_str()).ok().map(|v| Value::str(&v))),
                "time.monotonic" => duration(start_instant().elapsed().as_nanos() as i64),
                "time.unix" => duration(
                    std::time::SystemTime::now()
                        .duration_since(std::time::UNIX_EPOCH)
                        .map(|d| d.as_nanos() as i64)
                        .unwrap_or(0),
                ),
                _ => return Err(Ctl::Exit(i32::MIN)),
            })
        })();
        match r {
            Err(Ctl::Exit(i32::MIN)) => None,
            other => Some(other),
        }
    }
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
