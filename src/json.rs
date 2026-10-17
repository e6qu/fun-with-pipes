//! JSON text <-> the `Json` type of the standard library. The C runtime
//! implements the same algorithm (same results and error positions).
//!
//! `Json` constructors, in declaration order: Null, Bool, Num, Str, Arr, Obj.

use crate::value::Value;

const MAX_DEPTH: usize = 512;

/// A JSON value whose numbers retain their exact text. Numeric conversions
/// happen only when a caller requests a concrete numeric type.
#[derive(Clone, Debug, PartialEq)]
pub enum Json {
    Null,
    Bool(bool),
    Num(String),
    Str(String),
    Arr(Vec<Json>),
    Obj(Vec<(String, Json)>),
}

impl Json {
    /// Parse a JSON text (the errors of `json.parse`).
    pub fn parse(text: &str) -> Result<Json, String> {
        let mut p = Parser {
            s: text.as_bytes(),
            p: 0,
            depth: 0,
        };
        let v = p.raw()?;
        p.ws();
        if p.p != p.s.len() {
            return err("trailing characters", p.p);
        }
        Ok(v)
    }

    /// A value of the standard library's `Json` type.
    pub fn to_value(&self) -> Value {
        match self {
            Json::Null => Value::data(0, vec![]),
            Json::Bool(b) => Value::data(1, vec![Value::bool(*b)]),
            Json::Num(t) => Value::data(2, vec![Value::str(t)]),
            Json::Str(s) => Value::data(3, vec![Value::str(s)]),
            Json::Arr(xs) => Value::data(
                4,
                vec![Value::list(xs.iter().map(Json::to_value).collect())],
            ),
            Json::Obj(fs) => Value::data(
                5,
                vec![Value::list(
                    fs.iter()
                        .map(|(k, v)| Value::tuple(vec![Value::str(k), v.to_value()]))
                        .collect(),
                )],
            ),
        }
    }
}

struct Parser<'a> {
    s: &'a [u8],
    p: usize,
    depth: usize,
}

type PResult<T> = Result<T, String>;

fn err<T>(what: &str, at: usize) -> PResult<T> {
    Err(format!("{} at byte {}", what, at))
}

impl Parser<'_> {
    fn ws(&mut self) {
        while self.p < self.s.len() && matches!(self.s[self.p], b' ' | b'\t' | b'\n' | b'\r') {
            self.p += 1;
        }
    }

    /// A value with its numbers as written (see [`Json`]).
    fn raw(&mut self) -> PResult<Json> {
        self.ws();
        let Some(&c) = self.s.get(self.p) else {
            return err("unexpected end of input", self.p);
        };
        match c {
            b'{' | b'[' => {
                if self.depth >= MAX_DEPTH {
                    return err("nesting too deep", self.p);
                }
                self.depth += 1;
                let r = if c == b'{' {
                    self.object()
                } else {
                    self.array()
                };
                self.depth -= 1;
                r
            }
            b'"' => Ok(Json::Str(self.string()?)),
            b't' => self.word("true", Json::Bool(true)),
            b'f' => self.word("false", Json::Bool(false)),
            b'n' => self.word("null", Json::Null),
            b'-' | b'0'..=b'9' => self.number(),
            _ => err("unexpected character", self.p),
        }
    }

    fn word(&mut self, w: &str, v: Json) -> PResult<Json> {
        if self.s[self.p..].starts_with(w.as_bytes()) {
            self.p += w.len();
            Ok(v)
        } else {
            err("unexpected character", self.p)
        }
    }

    fn digits(&mut self) -> usize {
        let start = self.p;
        while self.p < self.s.len() && self.s[self.p].is_ascii_digit() {
            self.p += 1;
        }
        self.p - start
    }

    fn number(&mut self) -> PResult<Json> {
        let start = self.p;
        if self.s[self.p] == b'-' {
            self.p += 1;
        }
        match self.s.get(self.p) {
            Some(b'0') => self.p += 1,
            Some(b'1'..=b'9') => {
                self.digits();
            }
            _ => return err("invalid number", self.p),
        }
        if self.s.get(self.p) == Some(&b'.') {
            self.p += 1;
            if self.digits() == 0 {
                return err("invalid number", self.p);
            }
        }
        if matches!(self.s.get(self.p), Some(b'e' | b'E')) {
            self.p += 1;
            if matches!(self.s.get(self.p), Some(b'+' | b'-')) {
                self.p += 1;
            }
            if self.digits() == 0 {
                return err("invalid number", self.p);
            }
        }
        let text =
            std::str::from_utf8(&self.s[start..self.p]).expect("JSON number grammar is ASCII");
        Ok(Json::Num(text.to_string()))
    }

    fn hex4(&mut self) -> PResult<u32> {
        let mut v = 0u32;
        for _ in 0..4 {
            let Some(d) = self.s.get(self.p).and_then(|c| (*c as char).to_digit(16)) else {
                return err("invalid escape", self.p);
            };
            v = v * 16 + d;
            self.p += 1;
        }
        Ok(v)
    }

    /// At the opening quote.
    fn string(&mut self) -> PResult<String> {
        self.p += 1;
        let mut out: Vec<u8> = Vec::new();
        loop {
            let Some(&c) = self.s.get(self.p) else {
                return err("unexpected end of input", self.p);
            };
            match c {
                b'"' => {
                    self.p += 1;
                    return Ok(String::from_utf8_lossy(&out).into_owned());
                }
                b'\\' => {
                    self.p += 1;
                    let Some(&e) = self.s.get(self.p) else {
                        return err("unexpected end of input", self.p);
                    };
                    let simple = match e {
                        b'"' => Some(b'"'),
                        b'\\' => Some(b'\\'),
                        b'/' => Some(b'/'),
                        b'b' => Some(8),
                        b'f' => Some(12),
                        b'n' => Some(b'\n'),
                        b'r' => Some(b'\r'),
                        b't' => Some(b'\t'),
                        b'u' => None,
                        _ => return err("invalid escape", self.p),
                    };
                    self.p += 1;
                    if let Some(b) = simple {
                        out.push(b);
                        continue;
                    }
                    let mut code = self.hex4()?;
                    if (0xD800..0xDC00).contains(&code) && self.s[self.p..].starts_with(b"\\u") {
                        let save = self.p;
                        self.p += 2;
                        let low = self.hex4()?;
                        if (0xDC00..0xE000).contains(&low) {
                            code = 0x10000 + ((code - 0xD800) << 10) + (low - 0xDC00);
                        } else {
                            self.p = save;
                        }
                    }
                    let ch = char::from_u32(code).unwrap_or('\u{FFFD}');
                    let mut buf = [0u8; 4];
                    out.extend_from_slice(ch.encode_utf8(&mut buf).as_bytes());
                }
                0..=0x1f => return err("unexpected character", self.p),
                _ => {
                    out.push(c);
                    self.p += 1;
                }
            }
        }
    }

    /// After a value inside a container: `,` continues, `close` ends.
    fn next(&mut self, close: u8) -> PResult<bool> {
        self.ws();
        match self.s.get(self.p) {
            Some(b',') => {
                self.p += 1;
                Ok(true)
            }
            Some(c) if *c == close => {
                self.p += 1;
                Ok(false)
            }
            Some(_) => err("unexpected character", self.p),
            None => err("unexpected end of input", self.p),
        }
    }

    fn array(&mut self) -> PResult<Json> {
        self.p += 1;
        let mut items = Vec::new();
        self.ws();
        if self.s.get(self.p) == Some(&b']') {
            self.p += 1;
        } else {
            loop {
                items.push(self.raw()?);
                if !self.next(b']')? {
                    break;
                }
            }
        }
        Ok(Json::Arr(items))
    }

    fn expect(&mut self, c: u8) -> PResult<()> {
        self.ws();
        match self.s.get(self.p) {
            Some(x) if *x == c => Ok(()),
            Some(_) => err("unexpected character", self.p),
            None => err("unexpected end of input", self.p),
        }
    }

    fn object(&mut self) -> PResult<Json> {
        self.p += 1;
        let mut fields = Vec::new();
        self.ws();
        if self.s.get(self.p) == Some(&b'}') {
            self.p += 1;
        } else {
            loop {
                self.expect(b'"')?;
                let k = self.string()?;
                self.expect(b':')?;
                self.p += 1;
                let v = self.raw()?;
                fields.push((k, v));
                if !self.next(b'}')? {
                    break;
                }
            }
        }
        Ok(Json::Obj(fields))
    }
}

/// `Result[Json, String]`
pub fn parse(text: &str) -> Value {
    let r = Json::parse(text).map(|value| value.to_value());
    match r {
        Ok(v) => Value::data(0, vec![v]),
        Err(e) => Value::data(1, vec![Value::str(&e)]),
    }
}

pub fn escape(s: &str, out: &mut String) {
    out.push('"');
    for c in s.chars() {
        match c {
            '"' => out.push_str("\\\""),
            '\\' => out.push_str("\\\\"),
            '\n' => out.push_str("\\n"),
            '\r' => out.push_str("\\r"),
            '\t' => out.push_str("\\t"),
            '\u{8}' => out.push_str("\\b"),
            '\u{c}' => out.push_str("\\f"),
            c if (c as u32) < 0x20 => out.push_str(&format!("\\u{:04x}", c as u32)),
            c => out.push(c),
        }
    }
    out.push('"');
}

/// Validate the complete JSON number spelling, without a floating conversion.
pub fn valid_number(text: &str) -> bool {
    if text.is_empty() {
        return false;
    }
    let mut parser = Parser {
        s: text.as_bytes(),
        p: 0,
        depth: 0,
    };
    parser.number().is_ok() && parser.p == parser.s.len()
}

pub fn encode(v: &Value, out: &mut String) -> Result<(), String> {
    let Value::Data(tag, fs) = v else {
        out.push_str("null");
        return Ok(());
    };
    match tag {
        1 => out.push_str(if fs[0].as_bool() { "true" } else { "false" }),
        2 => {
            let text = fs[0].as_str();
            if !valid_number(text) {
                return Err("invalid JSON number".into());
            }
            out.push_str(text);
        }
        3 => escape(fs[0].as_str(), out),
        4 => {
            out.push('[');
            for (i, x) in fs[0].list_items().iter().enumerate() {
                if i > 0 {
                    out.push(',');
                }
                encode(x, out)?;
            }
            out.push(']');
        }
        5 => {
            out.push('{');
            for (i, kv) in fs[0].list_items().iter().enumerate() {
                if i > 0 {
                    out.push(',');
                }
                if let Value::Record(p) = kv {
                    escape(p[0].as_str(), out);
                    out.push(':');
                    encode(&p[1], out)?;
                }
            }
            out.push('}');
        }
        _ => out.push_str("null"),
    }
    Ok(())
}

impl Json {
    /// A member of an object.
    pub fn get(&self, key: &str) -> Option<&Json> {
        match self {
            Json::Obj(fs) => fs.iter().find(|(k, _)| k == key).map(|(_, v)| v),
            _ => None,
        }
    }

    /// The value at a path of object keys.
    pub fn at(&self, path: &[&str]) -> Option<&Json> {
        path.iter().try_fold(self, |v, k| v.get(k))
    }

    pub fn as_str(&self) -> Option<&str> {
        match self {
            Json::Str(s) => Some(s),
            _ => None,
        }
    }

    pub fn as_f64(&self) -> Option<f64> {
        match self {
            Json::Num(n) => n.parse().ok(),
            _ => None,
        }
    }

    pub fn as_array(&self) -> Option<&[Json]> {
        match self {
            Json::Arr(xs) => Some(xs),
            _ => None,
        }
    }

    /// The members of an object (none for other values).
    pub fn members(&self) -> &[(String, Json)] {
        match self {
            Json::Obj(fs) => fs,
            _ => &[],
        }
    }

    /// An object from key-value pairs.
    pub fn obj(fields: Vec<(&str, Json)>) -> Json {
        Json::Obj(
            fields
                .into_iter()
                .map(|(k, v)| (k.to_string(), v))
                .collect(),
        )
    }

    pub fn str(s: impl Into<String>) -> Json {
        Json::Str(s.into())
    }
}

impl std::fmt::Display for Json {
    fn fmt(&self, f: &mut std::fmt::Formatter<'_>) -> std::fmt::Result {
        let mut out = String::new();
        self.write(&mut out);
        f.write_str(&out)
    }
}

impl Json {
    /// The text with two-space indentation, one member per line.
    pub fn pretty(&self) -> String {
        let mut out = String::new();
        self.write_pretty(&mut out, 0);
        out.push('\n');
        out
    }

    fn write_pretty(&self, out: &mut String, depth: usize) {
        let pad = |out: &mut String, d: usize| {
            out.push('\n');
            for _ in 0..d {
                out.push_str("  ");
            }
        };
        match self {
            Json::Arr(xs) if !xs.is_empty() => {
                out.push('[');
                for (i, x) in xs.iter().enumerate() {
                    if i > 0 {
                        out.push(',');
                    }
                    pad(out, depth + 1);
                    x.write_pretty(out, depth + 1);
                }
                pad(out, depth);
                out.push(']');
            }
            Json::Obj(fs) if !fs.is_empty() => {
                out.push('{');
                for (i, (k, v)) in fs.iter().enumerate() {
                    if i > 0 {
                        out.push(',');
                    }
                    pad(out, depth + 1);
                    escape(k, out);
                    out.push_str(": ");
                    v.write_pretty(out, depth + 1);
                }
                pad(out, depth);
                out.push('}');
            }
            _ => self.write(out),
        }
    }

    fn write(&self, out: &mut String) {
        match self {
            Json::Null => out.push_str("null"),
            Json::Bool(b) => out.push_str(if *b { "true" } else { "false" }),
            Json::Num(n) => out.push_str(n),
            Json::Str(s) => escape(s, out),
            Json::Arr(xs) => {
                out.push('[');
                for (i, x) in xs.iter().enumerate() {
                    if i > 0 {
                        out.push(',');
                    }
                    x.write(out);
                }
                out.push(']');
            }
            Json::Obj(fs) => {
                out.push('{');
                for (i, (k, v)) in fs.iter().enumerate() {
                    if i > 0 {
                        out.push(',');
                    }
                    escape(k, out);
                    out.push(':');
                    v.write(out);
                }
                out.push('}');
            }
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn numbers_round_trip_without_floating_conversion() {
        for text in [
            "9007199254740993",
            "-9223372036854775808",
            "18446744073709551615",
            "340282366920938463463374607431768211455",
            "1.0000000000000000000000000000000001",
            "1.2300e+9999",
            "-0.00",
        ] {
            let parsed = Json::parse(text).unwrap();
            assert_eq!(parsed, Json::Num(text.into()));
            assert_eq!(parsed.to_string(), text);
            let mut output = String::new();
            encode(&parsed.to_value(), &mut output).unwrap();
            assert_eq!(output, text);
        }
    }

    #[test]
    fn constructed_numbers_cannot_inject_invalid_json() {
        for text in [
            "", "x", "01", "+1", "1.", "1e", " 1", "1 ", "1,2", "NaN", "Infinity",
        ] {
            let value = Value::data(2, vec![Value::str(text)]);
            assert_eq!(
                encode(&value, &mut String::new()),
                Err("invalid JSON number".into())
            );
        }
    }
}
