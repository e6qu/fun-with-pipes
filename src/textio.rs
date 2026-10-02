//! Parsing of the canonical text format (the inverse of `show`), used for
//! command-line arguments and text records of standalone executables.
//! Top-level strings are taken raw; nested strings are quoted.

use std::collections::BTreeMap;
use std::rc::Rc;

use crate::interp::checked_int;
use crate::ir::{Program, TypeShape, MT};
use crate::prims_std::{valid_float, valid_int};
use crate::value::Value;

struct P<'a> {
    s: &'a [u8],
    i: usize,
    prog: &'a Program,
}

type R<T> = Result<T, String>;

fn prim(mt: &MT) -> &str {
    match mt {
        MT::Con(n, _) => n.strip_prefix("std::").unwrap_or(n),
        _ => "",
    }
}

fn arg(mt: &MT, i: usize) -> MT {
    match mt {
        MT::Con(_, a) => a.get(i).cloned().unwrap_or(MT::unit()),
        _ => MT::unit(),
    }
}

fn is_tuple(fs: &[(String, MT)]) -> bool {
    fs.len() > 1 && fs.iter().enumerate().all(|(i, (l, _))| *l == i.to_string())
}

impl<'a> P<'a> {
    fn ws(&mut self) {
        while self.i < self.s.len() && matches!(self.s[self.i], b' ' | b'\t' | b'\n' | b'\r') {
            self.i += 1;
        }
    }

    fn peek(&self) -> u8 {
        *self.s.get(self.i).unwrap_or(&0)
    }

    fn eat(&mut self, lit: &str) -> bool {
        self.ws();
        if self.s[self.i..].starts_with(lit.as_bytes()) {
            self.i += lit.len();
            true
        } else {
            false
        }
    }

    fn expect(&mut self, lit: &str) -> R<()> {
        if self.eat(lit) {
            Ok(())
        } else {
            Err(format!("expected `{}`", lit))
        }
    }

    /// A bare token: characters up to a delimiter.
    fn token(&mut self) -> &'a str {
        self.ws();
        let start = self.i;
        while self.i < self.s.len()
            && !matches!(
                self.s[self.i],
                b' ' | b'\t' | b'\n' | b'\r' | b',' | b')' | b']' | b'}' | b'(' | b':'
            )
        {
            self.i += 1;
        }
        std::str::from_utf8(&self.s[start..self.i]).unwrap_or("")
    }

    fn ident(&mut self) -> &'a str {
        self.ws();
        let start = self.i;
        while self.i < self.s.len()
            && (self.s[self.i].is_ascii_alphanumeric()
                || matches!(self.s[self.i], b'_' | b'-' | b'.'))
        {
            self.i += 1;
        }
        std::str::from_utf8(&self.s[start..self.i]).unwrap_or("")
    }

    fn quoted(&mut self) -> R<String> {
        self.ws();
        if self.peek() != b'"' {
            return Err("expected a quoted string".into());
        }
        self.i += 1;
        let mut out = Vec::new();
        loop {
            let c = self.peek();
            if self.i >= self.s.len() {
                return Err("unterminated string".into());
            }
            self.i += 1;
            match c {
                b'"' => break,
                b'\\' => {
                    let e = self.peek();
                    self.i += 1;
                    match e {
                        b'n' => out.push(b'\n'),
                        b't' => out.push(b'\t'),
                        b'r' => out.push(b'\r'),
                        b'0' => out.push(0),
                        b'"' => out.push(b'"'),
                        b'\\' => out.push(b'\\'),
                        b'u' => {
                            if self.peek() != b'{' {
                                return Err("bad unicode escape".into());
                            }
                            self.i += 1;
                            let start = self.i;
                            while self.peek().is_ascii_hexdigit() {
                                self.i += 1;
                            }
                            let hex = std::str::from_utf8(&self.s[start..self.i]).unwrap_or("");
                            if self.peek() != b'}' {
                                return Err("bad unicode escape".into());
                            }
                            self.i += 1;
                            let ch = u32::from_str_radix(hex, 16)
                                .ok()
                                .and_then(char::from_u32)
                                .ok_or("bad unicode escape")?;
                            let mut buf = [0u8; 4];
                            out.extend_from_slice(ch.encode_utf8(&mut buf).as_bytes());
                        }
                        _ => return Err("unknown escape".into()),
                    }
                }
                c => out.push(c),
            }
        }
        String::from_utf8(out).map_err(|_| "invalid UTF-8".to_string())
    }

    fn list_of(
        &mut self,
        open: &str,
        close: &str,
        mut item: impl FnMut(&mut Self) -> R<()>,
    ) -> R<()> {
        self.expect(open)?;
        if self.eat(close) {
            return Ok(());
        }
        loop {
            item(self)?;
            if self.eat(close) {
                return Ok(());
            }
            self.expect(",")?;
        }
    }

    fn int(&mut self, mt: &MT) -> R<Value> {
        let t = self.token();
        if !valid_int(t) {
            return Err(format!("`{}` is not an integer", t));
        }
        if prim(mt) == "U128" {
            return t
                .trim_start_matches('+')
                .parse::<u128>()
                .map(Value::U128)
                .map_err(|_| format!("`{}` does not fit in U128", t));
        }
        let x: i128 = t.parse().map_err(|_| format!("`{}` is out of range", t))?;
        checked_int(mt, x).ok_or_else(|| format!("`{}` does not fit in {}", t, prim(mt)))
    }

    fn float(&mut self, mt: &MT) -> R<Value> {
        let t = self.token();
        let x: f64 = match t {
            "inf" => f64::INFINITY,
            "-inf" => f64::NEG_INFINITY,
            "NaN" => f64::NAN,
            _ if valid_float(t) => t.parse().unwrap_or(f64::NAN),
            _ => return Err(format!("`{}` is not a number", t)),
        };
        Ok(match prim(mt) {
            "F32" | "F16" | "BF16" => Value::F32(if valid_float(t) {
                t.parse().unwrap_or(f32::NAN)
            } else {
                x as f32
            }),
            _ => Value::F64(x),
        })
    }

    /// A value in argument position (constructor fields): parenthesized
    /// unless it is atomic.
    fn atom(&mut self, mt: &MT) -> R<Value> {
        self.ws();
        let tuple_like = matches!(mt, MT::Record(fs) if fs.is_empty() || is_tuple(fs));
        if self.peek() == b'(' && !tuple_like {
            self.i += 1;
            let v = self.value(mt, false)?;
            self.expect(")")?;
            return Ok(v);
        }
        self.value(mt, false)
    }

    fn value(&mut self, mt: &MT, top: bool) -> R<Value> {
        self.ws();
        match mt {
            MT::Record(fs) if fs.is_empty() => {
                self.expect("(")?;
                self.expect(")")?;
                Ok(Value::unit())
            }
            MT::Record(fs) if is_tuple(fs) => {
                let mut out = Vec::new();
                self.expect("(")?;
                for (i, (_, t)) in fs.iter().enumerate() {
                    if i > 0 {
                        self.expect(",")?;
                    }
                    out.push(self.value(t, false)?);
                }
                self.expect(")")?;
                Ok(Value::tuple(out))
            }
            MT::Record(fs) => self.record_body(fs),
            MT::Fun(..) | MT::Nat(_) => Err("functions cannot be parsed".into()),
            MT::Con(n, _) => match prim(mt) {
                "I8" | "I16" | "I32" | "I64" | "I128" | "U8" | "U16" | "U32" | "U64" | "U128"
                | "ISize" | "USize" => self.int(mt),
                "F32" | "F64" | "F16" | "BF16" | "F128" => self.float(mt),
                "String" => {
                    if top {
                        let s =
                            std::str::from_utf8(&self.s[self.i..]).map_err(|_| "invalid UTF-8")?;
                        self.i = self.s.len();
                        Ok(Value::str(s))
                    } else {
                        Ok(Value::str(&self.quoted()?))
                    }
                }
                "Bytes" => {
                    let mut out = Vec::new();
                    self.expect("bytes")?;
                    let u8t = MT::con("std::U8");
                    self.list_of("[", "]", |p| {
                        if let Value::U8(b) = p.int(&u8t)? {
                            out.push(b);
                        }
                        Ok(())
                    })?;
                    Ok(Value::Bytes(Rc::from(out)))
                }
                "TInt" => {
                    let t = self.token();
                    let digits = t.strip_prefix("0t").ok_or("expected a ternary literal")?;
                    let mut v: i64 = 0;
                    for c in digits.chars() {
                        v = v * 3
                            + match c {
                                '+' => 1,
                                '-' => -1,
                                '0' => 0,
                                _ => return Err("bad trit".into()),
                            };
                    }
                    let w = match arg(mt, 0) {
                        MT::Nat(w) => w,
                        _ => 1,
                    };
                    if digits.len() as u64 > w {
                        return Err(format!("too many trits for TInt[{}]", w));
                    }
                    Ok(Value::TInt(v))
                }
                "Trit" => match self.token() {
                    "+1" | "1" => Ok(Value::Trit(1)),
                    "0" => Ok(Value::Trit(0)),
                    "-1" => Ok(Value::Trit(-1)),
                    t => Err(format!("`{}` is not a trit", t)),
                },
                "List" | "Array" => {
                    let is_array = prim(mt) == "Array";
                    if is_array {
                        self.expect("array")?;
                    }
                    let t = arg(mt, 0);
                    let mut items = Vec::new();
                    self.list_of("[", "]", |p| {
                        items.push(p.value(&t, false)?);
                        Ok(())
                    })?;
                    Ok(if is_array {
                        Value::Array(Rc::new(items))
                    } else {
                        Value::list(items)
                    })
                }
                "Map" | "Set" => {
                    let is_set = prim(mt) == "Set";
                    self.expect(if is_set { "set" } else { "map" })?;
                    let (kt, vt) = (arg(mt, 0), arg(mt, 1));
                    let mut m = BTreeMap::new();
                    self.list_of("{", "}", |p| {
                        let k = p.value(&kt, false)?;
                        let v = if is_set {
                            Value::unit()
                        } else {
                            p.expect(":")?;
                            p.value(&vt, false)?
                        };
                        m.insert(k, v);
                        Ok(())
                    })?;
                    Ok(Value::Map(Rc::new(m)))
                }
                "Duration" => {
                    let t = self.token();
                    let units = [
                        ("ns", 1i64),
                        ("us", 1_000),
                        ("ms", 1_000_000),
                        ("min", 60_000_000_000),
                        ("s", 1_000_000_000),
                        ("h", 3_600_000_000_000),
                    ];
                    for (u, k) in units {
                        if let Some(num) = t.strip_suffix(u) {
                            if valid_int(num) {
                                let x: i64 = num.parse().map_err(|_| "bad duration")?;
                                return Ok(Value::tuple(vec![Value::I64(x * k)]));
                            }
                        }
                    }
                    Err(format!("`{}` is not a duration", t))
                }
                _ => match self.prog.shapes.get(mt).cloned() {
                    Some(TypeShape::Adt(vs)) => {
                        let name = self.ident().to_string();
                        let lower = name.to_ascii_lowercase();
                        let pos = vs.iter().position(|(c, _)| *c == name).or_else(|| {
                            // `true`/`false` for convenience
                            if n == "std::Bool" && top {
                                vs.iter().position(|(c, _)| c.to_ascii_lowercase() == lower)
                            } else {
                                None
                            }
                        });
                        let Some(tag) = pos else {
                            return Err(format!("`{}` is not a constructor of {}", name, mt));
                        };
                        let mut fs = Vec::new();
                        for t in &vs[tag].1 {
                            fs.push(self.atom(t)?);
                        }
                        Ok(Value::data(tag as u32, fs))
                    }
                    Some(TypeShape::Record(fs)) => {
                        let short = MT::short_name(n);
                        self.ws();
                        if self.s[self.i..].starts_with(short.as_bytes()) {
                            self.i += short.len();
                        }
                        self.record_body(&fs)
                    }
                    _ => Err(format!("values of type {} cannot be parsed", mt)),
                },
            },
        }
    }

    fn record_body(&mut self, fs: &[(String, MT)]) -> R<Value> {
        let mut vals: Vec<Option<Value>> = vec![None; fs.len()];
        self.list_of("{", "}", |p| {
            let name = p.ident().to_string();
            let Some(i) = fs.iter().position(|(l, _)| *l == name) else {
                return Err(format!("unknown field `{}`", name));
            };
            p.expect("=")?;
            vals[i] = Some(p.value(&fs[i].1, false)?);
            Ok(())
        })?;
        let mut out = Vec::new();
        for (v, (l, _)) in vals.into_iter().zip(fs) {
            out.push(v.ok_or_else(|| format!("missing field `{}`", l))?);
        }
        Ok(Value::tuple(out))
    }
}

/// Parse `text` as a value of type `mt`. At the top level a `String` is the
/// whole text.
pub fn parse(text: &str, mt: &MT, prog: &Program) -> Result<Value, String> {
    let mut p = P {
        s: text.as_bytes(),
        i: 0,
        prog,
    };
    let v = p.value(mt, true)?;
    p.ws();
    if p.i != p.s.len() {
        return Err(format!(
            "unexpected `{}`",
            String::from_utf8_lossy(&p.s[p.i..])
        ));
    }
    Ok(v)
}
