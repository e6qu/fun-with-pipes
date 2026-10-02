//! Primitives for URLs and HTTP/1.1 message heads, plus small string and
//! byte helpers. The C runtime (fwp_rt_web.c) implements the same
//! algorithms with identical results.

use crate::value::Value;

fn some(v: Value) -> Value {
    Value::data(1, vec![v])
}

fn none() -> Value {
    Value::data(0, vec![])
}

fn ok(v: Value) -> Value {
    Value::data(0, vec![v])
}

fn err(msg: &str) -> Value {
    Value::data(1, vec![Value::str(msg)])
}

fn bytes_of(v: &Value) -> &[u8] {
    match v {
        Value::Bytes(b) => b,
        Value::Str(s) => s.as_bytes(),
        _ => &[],
    }
}

fn find(hay: &[u8], needle: &[u8]) -> Option<usize> {
    if needle.is_empty() {
        return Some(0);
    }
    hay.windows(needle.len()).position(|w| w == needle)
}

/// `string.split-once sep s`: the parts before and after the first `sep`.
pub fn split_once(sep: &Value, s: &Value) -> Value {
    let (sep, s) = (sep.as_str(), s.as_str());
    match s.find(sep) {
        Some(i) if !sep.is_empty() => some(Value::tuple(vec![
            Value::str(&s[..i]),
            Value::str(&s[i + sep.len()..]),
        ])),
        _ => none(),
    }
}

/// `bytes.find needle hay`: offset of the first occurrence.
pub fn bytes_find(needle: &Value, hay: &Value) -> Value {
    match find(bytes_of(hay), bytes_of(needle)) {
        Some(i) => some(Value::I64(i as i64)),
        None => none(),
    }
}

fn unreserved(c: u8) -> bool {
    c.is_ascii_alphanumeric() || matches!(c, b'-' | b'.' | b'_' | b'~')
}

/// Percent-encode everything but unreserved characters (RFC 3986).
pub fn url_encode(s: &Value) -> Value {
    let mut out = String::new();
    for &c in s.as_str().as_bytes() {
        if unreserved(c) {
            out.push(c as char);
        } else {
            out.push_str(&format!("%{:02X}", c));
        }
    }
    Value::str(&out)
}

/// Percent-decode (and with `plus`, `+` is a space); `None` for malformed
/// escapes or invalid UTF-8.
pub fn url_decode(s: &Value, plus: bool) -> Value {
    let b = s.as_str().as_bytes();
    let mut out = Vec::with_capacity(b.len());
    let mut i = 0;
    while i < b.len() {
        match b[i] {
            b'%' => {
                let hex = |c: u8| (c as char).to_digit(16);
                match (
                    b.get(i + 1).and_then(|c| hex(*c)),
                    b.get(i + 2).and_then(|c| hex(*c)),
                ) {
                    (Some(h), Some(l)) => out.push((h * 16 + l) as u8),
                    _ => return none(),
                }
                i += 3;
            }
            b'+' if plus => {
                out.push(b' ');
                i += 1;
            }
            c => {
                out.push(c);
                i += 1;
            }
        }
    }
    match String::from_utf8(out) {
        Ok(s) => some(Value::str(&s)),
        Err(_) => none(),
    }
}

/// `url.split`: (scheme, host, port, path, query) of an absolute URL. The
/// port defaults to 80 for http and 443 for https (0 otherwise); the path
/// defaults to "/".
pub fn url_split(s: &Value) -> Value {
    let s = s.as_str();
    let Some(i) = s.find("://") else {
        return none();
    };
    let scheme = s[..i].to_ascii_lowercase();
    if scheme.is_empty() {
        return none();
    }
    let rest = &s[i + 3..];
    let end = rest.find(['/', '?', '#']).unwrap_or(rest.len());
    let auth = &rest[..end];
    let mut tail = &rest[end..];
    if let Some(h) = tail.find('#') {
        tail = &tail[..h];
    }
    let (path, query) = match tail.find('?') {
        Some(q) => (&tail[..q], &tail[q + 1..]),
        None => (tail, ""),
    };
    let path = if path.is_empty() { "/" } else { path };
    let auth = match auth.rfind('@') {
        Some(a) => &auth[a + 1..],
        None => auth,
    };
    let (host, port) = if let Some(stripped) = auth.strip_prefix('[') {
        match stripped.find(']') {
            Some(e) => {
                let after = &stripped[e + 1..];
                (&stripped[..e], after.strip_prefix(':'))
            }
            None => return none(),
        }
    } else {
        match auth.rfind(':') {
            Some(c) => (&auth[..c], Some(&auth[c + 1..])),
            None => (auth, None),
        }
    };
    if host.is_empty() {
        return none();
    }
    let port = match port {
        Some(p) => match p.parse::<u16>() {
            Ok(n) if !p.is_empty() && p.len() <= 5 && p.bytes().all(|c| c.is_ascii_digit()) => {
                n as i64
            }
            _ => return none(),
        },
        None => match scheme.as_str() {
            "http" | "ws" => 80,
            "https" | "wss" => 443,
            _ => 0,
        },
    };
    some(Value::tuple(vec![
        Value::str(&scheme),
        Value::str(host),
        Value::I64(port),
        Value::str(path),
        Value::str(query),
    ]))
}

fn tchar(c: u8) -> bool {
    c.is_ascii_alphanumeric() || b"!#$%&'*+-.^_`|~".contains(&c)
}

/// Header lines after the first line: lower-cased names, trimmed values.
fn headers(lines: &[&[u8]]) -> Result<Value, &'static str> {
    let mut hs = Vec::new();
    for line in lines {
        let Some(colon) = line.iter().position(|c| *c == b':') else {
            return Err("invalid header");
        };
        let name = &line[..colon];
        if name.is_empty() || !name.iter().all(|c| tchar(*c)) {
            return Err("invalid header");
        }
        let mut v = &line[colon + 1..];
        while let [b' ' | b'\t', r @ ..] = v {
            v = r;
        }
        while let [r @ .., b' ' | b'\t'] = v {
            v = r;
        }
        if v.iter().any(|c| *c < 0x20 && *c != b'\t' || *c == 0x7f) {
            return Err("invalid header");
        }
        let (Ok(n), Ok(v)) = (std::str::from_utf8(name), std::str::from_utf8(v)) else {
            return Err("invalid header");
        };
        hs.push(Value::tuple(vec![
            Value::str(&n.to_ascii_lowercase()),
            Value::str(v),
        ]));
    }
    Ok(Value::list(hs))
}

fn split_lines(b: &[u8]) -> Vec<&[u8]> {
    let mut out = Vec::new();
    let mut start = 0;
    while let Some(i) = find(&b[start..], b"\r\n") {
        out.push(&b[start..start + i]);
        start += i + 2;
    }
    out.push(&b[start..]);
    out
}

/// `http.parse-request-head`: the head without its final blank line, to
/// (method, target, version, headers).
pub fn parse_request_head(head: &Value) -> Value {
    let lines = split_lines(bytes_of(head));
    let first = lines[0];
    let parts: Vec<&[u8]> = first.split(|c| *c == b' ').collect();
    if parts.len() != 3
        || parts[0].is_empty()
        || !parts[0].iter().all(|c| tchar(*c))
        || parts[1].is_empty()
        || !parts[1].iter().all(|c| *c > 0x20 && *c != 0x7f)
    {
        return err("invalid request line");
    }
    if parts[2] != b"HTTP/1.1" && parts[2] != b"HTTP/1.0" {
        return err("unsupported HTTP version");
    }
    let Ok(target) = std::str::from_utf8(parts[1]) else {
        return err("invalid request line");
    };
    match headers(&lines[1..]) {
        Ok(hs) => ok(Value::tuple(vec![
            Value::str(std::str::from_utf8(parts[0]).unwrap_or("")),
            Value::str(target),
            Value::str(std::str::from_utf8(parts[2]).unwrap_or("")),
            hs,
        ])),
        Err(e) => err(e),
    }
}

/// `http.parse-response-head`: to (version, status, reason, headers).
pub fn parse_response_head(head: &Value) -> Value {
    let lines = split_lines(bytes_of(head));
    let first = lines[0];
    let bad = || err("invalid status line");
    let Some(sp) = first.iter().position(|c| *c == b' ') else {
        return bad();
    };
    let version = &first[..sp];
    if !version.starts_with(b"HTTP/1.") || version.len() != 8 {
        return bad();
    }
    let rest = &first[sp + 1..];
    if rest.len() < 3 || !rest[..3].iter().all(|c| c.is_ascii_digit()) {
        return bad();
    }
    if rest.len() > 3 && rest[3] != b' ' {
        return bad();
    }
    let status = rest[..3]
        .iter()
        .fold(0i64, |a, c| a * 10 + (c - b'0') as i64);
    let reason = if rest.len() > 4 { &rest[4..] } else { &[][..] };
    let Ok(reason) = std::str::from_utf8(reason) else {
        return bad();
    };
    match headers(&lines[1..]) {
        Ok(hs) => ok(Value::tuple(vec![
            Value::str(std::str::from_utf8(version).unwrap_or("")),
            Value::I64(status),
            Value::str(reason),
            hs,
        ])),
        Err(e) => err(e),
    }
}

/// `int.to-hex`: lower-case hexadecimal (negative numbers with a sign).
pub fn to_hex(n: &Value) -> Value {
    let n = n.as_i128().unwrap_or(0) as i64;
    let s = if n < 0 {
        format!("-{:x}", (n as i128).unsigned_abs())
    } else {
        format!("{:x}", n)
    };
    Value::str(&s)
}

/// `int.parse-hex`: 1 to 15 hexadecimal digits.
pub fn parse_hex(s: &Value) -> Value {
    let s = s.as_str();
    if s.is_empty() || s.len() > 15 || !s.bytes().all(|c| c.is_ascii_hexdigit()) {
        return none();
    }
    some(Value::I64(i64::from_str_radix(s, 16).unwrap_or(0)))
}
