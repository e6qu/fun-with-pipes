//! Deterministic, type-directed binary encoding of values. It is the
//! payload format of the typed process protocol and the basis of `hash`.
//!
//! Integers are little-endian at their declared width (`ISize`/`USize` as
//! 64 bits), floats are IEEE bits, lengths and constructor tags are
//! unsigned LEB128, records are encoded field by field in canonical order,
//! and lists, arrays, maps and sets are a count followed by their elements.

use crate::ir::{Program, TypeShape, MT};
use crate::value::Value;

pub fn leb128(out: &mut Vec<u8>, mut x: u64) {
    loop {
        let b = (x & 0x7f) as u8;
        x >>= 7;
        if x == 0 {
            out.push(b);
            return;
        }
        out.push(b | 0x80);
    }
}

fn elem(mt: &MT, i: usize) -> MT {
    match mt {
        MT::Con(_, args) => args.get(i).cloned().unwrap_or(MT::unit()),
        _ => MT::unit(),
    }
}

/// Encode a value of type `mt`. Functions and resources cannot be encoded
/// (the type checker rules them out).
pub fn encode(out: &mut Vec<u8>, v: &Value, mt: &MT, prog: &Program) {
    match v {
        Value::I8(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::I16(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::I32(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::I64(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::I128(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::U8(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::U16(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::U32(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::U64(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::U128(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::F32(x) => out.extend_from_slice(&x.to_bits().to_le_bytes()),
        Value::F64(x) => out.extend_from_slice(&x.to_bits().to_le_bytes()),
        Value::TInt(x) => out.extend_from_slice(&x.to_le_bytes()),
        Value::Trit(x) => out.push(*x as u8),
        Value::Str(s) => {
            leb128(out, s.len() as u64);
            out.extend_from_slice(s.as_bytes());
        }
        Value::Bytes(b) => {
            leb128(out, b.len() as u64);
            out.extend_from_slice(b);
        }
        Value::Record(fs) => {
            let types: Vec<MT> = match mt {
                MT::Record(ts) => ts.iter().map(|(_, t)| t.clone()).collect(),
                MT::Con(..) => match prog.shapes.get(mt) {
                    Some(TypeShape::Record(ts)) => ts.iter().map(|(_, t)| t.clone()).collect(),
                    _ => vec![],
                },
                _ => vec![],
            };
            for (i, f) in fs.iter().enumerate() {
                encode(out, f, types.get(i).unwrap_or(&MT::unit()), prog);
            }
        }
        Value::Data(tag, fs) => {
            if matches!(mt, MT::Con(n, _) if n == "std::List") {
                let items = v.list_items();
                leb128(out, items.len() as u64);
                let t = elem(mt, 0);
                for x in &items {
                    encode(out, x, &t, prog);
                }
                return;
            }
            leb128(out, *tag as u64);
            let types = match prog.shapes.get(mt) {
                Some(TypeShape::Adt(vs)) => vs[*tag as usize].1.clone(),
                _ => vec![],
            };
            for (i, f) in fs.iter().enumerate() {
                encode(out, f, types.get(i).unwrap_or(&MT::unit()), prog);
            }
        }
        Value::Array(items) => {
            leb128(out, items.len() as u64);
            let t = elem(mt, 0);
            for x in items.iter() {
                encode(out, x, &t, prog);
            }
        }
        Value::Map(m) => {
            leb128(out, m.len() as u64);
            let is_set = matches!(mt, MT::Con(n, _) if n == "std::Set");
            let (kt, vt) = (elem(mt, 0), elem(mt, 1));
            for (k, x) in m.iter() {
                encode(out, k, &kt, prog);
                if !is_set {
                    encode(out, x, &vt, prog);
                }
            }
        }
        Value::Closure(_) | Value::File(_) | Value::Native(_) => {}
    }
}

pub fn fnv1a64(bytes: &[u8]) -> u64 {
    let mut h: u64 = 0xcbf29ce484222325;
    for b in bytes {
        h ^= *b as u64;
        h = h.wrapping_mul(0x100000001b3);
    }
    h
}

/// Structural hash: FNV-1a over the canonical encoding.
pub fn hash(v: &Value, mt: &MT, prog: &Program) -> u64 {
    let mut buf = Vec::new();
    encode(&mut buf, v, mt, prog);
    fnv1a64(&buf)
}

// ------------------------------------------------------------------ decoding

/// Cursor over encoded bytes.
pub struct Reader<'a> {
    pub data: &'a [u8],
    pub pos: usize,
}

impl<'a> Reader<'a> {
    pub fn new(data: &'a [u8]) -> Self {
        Reader { data, pos: 0 }
    }

    fn take(&mut self, n: usize) -> Result<&'a [u8], String> {
        if n > self.data.len() - self.pos {
            return Err("truncated value".into());
        }
        let s = &self.data[self.pos..self.pos + n];
        self.pos += n;
        Ok(s)
    }

    pub fn leb128(&mut self) -> Result<u64, String> {
        let mut x: u64 = 0;
        let mut shift = 0;
        loop {
            let b = self.take(1)?[0];
            // the tenth byte holds only bit 63
            if shift >= 64 || (shift == 63 && b & 0x7f > 1) {
                return Err("bad LEB128".into());
            }
            x |= ((b & 0x7f) as u64) << shift;
            if b & 0x80 == 0 {
                return Ok(x);
            }
            shift += 7;
        }
    }

    /// An element count: no more than the bytes of the whole value, so a
    /// corrupt count fails fast instead of looping or allocating.
    fn count(&mut self) -> Result<usize, String> {
        let n = self.leb128()?;
        if n > self.data.len() as u64 {
            return Err("truncated value".into());
        }
        Ok(n as usize)
    }

    fn arr<const N: usize>(&mut self) -> Result<[u8; N], String> {
        Ok(self.take(N)?.try_into().unwrap())
    }
}

fn prim(mt: &MT) -> &str {
    match mt {
        MT::Con(n, _) => n.strip_prefix("std::").unwrap_or(n),
        _ => "",
    }
}

/// Decode a value of type `mt` (inverse of `encode`).
pub fn decode(r: &mut Reader, mt: &MT, prog: &Program) -> Result<Value, String> {
    Ok(match mt {
        MT::Record(fs) => {
            let mut out = Vec::new();
            for (_, t) in fs {
                out.push(decode(r, t, prog)?);
            }
            Value::tuple(out)
        }
        MT::Fun(..) | MT::Nat(_) => return Err("functions cannot be decoded".into()),
        MT::Con(n, args) => match prim(mt) {
            "I8" => Value::I8(i8::from_le_bytes(r.arr()?)),
            "I16" => Value::I16(i16::from_le_bytes(r.arr()?)),
            "I32" => Value::I32(i32::from_le_bytes(r.arr()?)),
            "I64" | "ISize" => Value::I64(i64::from_le_bytes(r.arr()?)),
            "I128" => Value::I128(i128::from_le_bytes(r.arr()?)),
            "U8" => Value::U8(u8::from_le_bytes(r.arr()?)),
            "U16" => Value::U16(u16::from_le_bytes(r.arr()?)),
            "U32" => Value::U32(u32::from_le_bytes(r.arr()?)),
            "U64" | "USize" => Value::U64(u64::from_le_bytes(r.arr()?)),
            "U128" => Value::U128(u128::from_le_bytes(r.arr()?)),
            "F32" | "F16" | "BF16" => Value::F32(f32::from_bits(u32::from_le_bytes(r.arr()?))),
            "F64" | "F128" => Value::F64(f64::from_bits(u64::from_le_bytes(r.arr()?))),
            "TInt" => Value::TInt(i64::from_le_bytes(r.arr()?)),
            "Trit" => Value::Trit(r.take(1)?[0] as i8),
            "String" => {
                let n = r.leb128()? as usize;
                let b = r.take(n)?;
                Value::str(std::str::from_utf8(b).map_err(|_| "invalid UTF-8 in string")?)
            }
            "Bytes" => {
                let n = r.leb128()? as usize;
                Value::Bytes(std::rc::Rc::from(r.take(n)?))
            }
            "List" | "Array" => {
                let n = r.count()?;
                let t = args.first().cloned().unwrap_or(MT::unit());
                let mut items = Vec::new();
                for _ in 0..n {
                    items.push(decode(r, &t, prog)?);
                }
                if prim(mt) == "List" {
                    Value::list(items)
                } else {
                    Value::Array(std::rc::Rc::new(items))
                }
            }
            "Map" | "Set" => {
                let n = r.count()?;
                let kt = args.first().cloned().unwrap_or(MT::unit());
                let vt = args.get(1).cloned().unwrap_or(MT::unit());
                let mut m = std::collections::BTreeMap::new();
                for _ in 0..n {
                    let k = decode(r, &kt, prog)?;
                    let v = if prim(mt) == "Map" {
                        decode(r, &vt, prog)?
                    } else {
                        Value::unit()
                    };
                    m.insert(k, v);
                }
                Value::Map(std::rc::Rc::new(m))
            }
            _ => match prog.shapes.get(mt) {
                Some(TypeShape::Adt(vs)) => {
                    let tag = r.leb128()? as usize;
                    let Some((_, fts)) = vs.get(tag) else {
                        return Err(format!("bad constructor tag {} for {}", tag, n));
                    };
                    let mut fs = Vec::new();
                    for t in fts {
                        fs.push(decode(r, t, prog)?);
                    }
                    Value::data(tag as u32, fs)
                }
                Some(TypeShape::Record(fts)) => {
                    let mut fs = Vec::new();
                    for (_, t) in fts {
                        fs.push(decode(r, t, prog)?);
                    }
                    Value::tuple(fs)
                }
                _ => return Err(format!("values of type {} cannot be decoded", mt)),
            },
        },
    })
}

// ---------------------------------------------------------- type fingerprint

/// Canonical structural description of a type: nominal types include their
/// module, fields and variants, so two programs agree on a fingerprint only
/// if their types have the same structure.
pub fn canonical_type(mt: &MT, prog: &Program) -> String {
    fn go(mt: &MT, prog: &Program, stack: &mut Vec<MT>, out: &mut String) {
        match mt {
            MT::Nat(n) => out.push_str(&n.to_string()),
            MT::Fun(a, b) => {
                out.push_str("fn(");
                go(a, prog, stack, out);
                out.push_str(")->");
                go(b, prog, stack, out);
            }
            MT::Record(fs) => {
                out.push('{');
                for (i, (l, t)) in fs.iter().enumerate() {
                    if i > 0 {
                        out.push(',');
                    }
                    out.push_str(l);
                    out.push(':');
                    go(t, prog, stack, out);
                }
                out.push('}');
            }
            MT::Con(n, args) => {
                out.push_str(n);
                if !args.is_empty() {
                    out.push('[');
                    for (i, a) in args.iter().enumerate() {
                        if i > 0 {
                            out.push(',');
                        }
                        go(a, prog, stack, out);
                    }
                    out.push(']');
                }
                if stack.contains(mt) {
                    return;
                }
                stack.push(mt.clone());
                match prog.shapes.get(mt) {
                    Some(TypeShape::Adt(vs)) if n != "std::List" => {
                        out.push('<');
                        for (i, (c, fs)) in vs.iter().enumerate() {
                            if i > 0 {
                                out.push('|');
                            }
                            out.push_str(c);
                            for f in fs {
                                out.push(' ');
                                go(f, prog, stack, out);
                            }
                        }
                        out.push('>');
                    }
                    Some(TypeShape::Record(fs)) => {
                        out.push('<');
                        for (i, (l, t)) in fs.iter().enumerate() {
                            if i > 0 {
                                out.push(',');
                            }
                            out.push_str(l);
                            out.push(':');
                            go(t, prog, stack, out);
                        }
                        out.push('>');
                    }
                    _ => {}
                }
                stack.pop();
            }
        }
    }
    let mut out = String::new();
    go(mt, prog, &mut Vec::new(), &mut out);
    out
}

/// 128-bit fingerprint of a canonical type string (little-endian halves).
pub fn fingerprint(canonical: &str) -> [u8; 16] {
    let a = fnv1a64(canonical.as_bytes());
    let b = fnv1a64(format!("fwp:{}", canonical).as_bytes());
    let mut out = [0u8; 16];
    out[..8].copy_from_slice(&a.to_le_bytes());
    out[8..].copy_from_slice(&b.to_le_bytes());
    out
}

// ------------------------------------------------------------------- framing

pub const MAGIC: &[u8; 4] = b"FWP1";
pub const VERSION: u8 = 1;
/// Capabilities this implementation offers; reserved names for future
/// transports are listed in docs/protocol.md.
pub const CAPABILITIES: &[&str] = &["PIPE_V1"];

/// Stream header for values of type `mt`.
pub fn header(mt: &MT, prog: &Program) -> Vec<u8> {
    let canon = canonical_type(mt, prog);
    let mut out = MAGIC.to_vec();
    out.push(VERSION);
    leb128(&mut out, CAPABILITIES.len() as u64);
    for c in CAPABILITIES {
        leb128(&mut out, c.len() as u64);
        out.extend_from_slice(c.as_bytes());
    }
    out.extend_from_slice(&fingerprint(&canon));
    let shown = mt.to_string();
    leb128(&mut out, shown.len() as u64);
    out.extend_from_slice(shown.as_bytes());
    out
}

/// A value frame.
pub fn frame(payload: &[u8]) -> Vec<u8> {
    let mut out = vec![1u8];
    out.extend_from_slice(&(payload.len() as u32).to_le_bytes());
    out.extend_from_slice(payload);
    out
}

/// The end-of-stream frame.
pub fn end_frame() -> Vec<u8> {
    vec![0u8, 0, 0, 0, 0]
}

/// The longest capability or type name a header may carry.
pub const MAX_HEADER_NAME: u64 = 1 << 20;

/// Parsed stream header.
pub struct Header {
    pub version: u8,
    pub capabilities: Vec<String>,
    pub fingerprint: [u8; 16],
    pub type_name: String,
}

/// Read a header (after the magic has been consumed).
pub fn read_header(r: &mut impl std::io::Read) -> Result<Header, String> {
    let mut b1 = [0u8; 1];
    let byte = |r: &mut dyn std::io::Read, b: &mut [u8; 1]| -> Result<u8, String> {
        r.read_exact(b)
            .map_err(|_| "truncated header".to_string())?;
        Ok(b[0])
    };
    let leb = |r: &mut dyn std::io::Read| -> Result<u64, String> {
        let mut x = 0u64;
        let mut shift = 0;
        let mut b = [0u8; 1];
        loop {
            r.read_exact(&mut b)
                .map_err(|_| "truncated header".to_string())?;
            if shift == 63 && b[0] & 0x7f > 1 {
                return Err("bad header".into());
            }
            x |= ((b[0] & 0x7f) as u64) << shift;
            if b[0] & 0x80 == 0 {
                return Ok(x);
            }
            shift += 7;
            if shift > 63 {
                return Err("bad header".into());
            }
        }
    };
    let name_len = |r: &mut dyn std::io::Read| -> Result<usize, String> {
        let n = leb(r)?;
        if n > MAX_HEADER_NAME {
            return Err("bad header".into());
        }
        Ok(n as usize)
    };
    let version = byte(r, &mut b1)?;
    let ncaps = leb(r)?;
    let mut capabilities = Vec::new();
    for _ in 0..ncaps.min(64) {
        let n = name_len(r)?;
        let mut s = vec![0u8; n];
        r.read_exact(&mut s).map_err(|_| "truncated header")?;
        capabilities.push(String::from_utf8_lossy(&s).to_string());
    }
    let mut fingerprint = [0u8; 16];
    r.read_exact(&mut fingerprint)
        .map_err(|_| "truncated header")?;
    let n = name_len(r)?;
    let mut s = vec![0u8; n];
    r.read_exact(&mut s).map_err(|_| "truncated header")?;
    Ok(Header {
        version,
        capabilities,
        fingerprint,
        type_name: String::from_utf8_lossy(&s).to_string(),
    })
}

/// Read the next frame payload; `None` at the end frame or end of input.
pub fn read_frame(r: &mut impl std::io::Read) -> Result<Option<Vec<u8>>, String> {
    let mut kind = [0u8; 1];
    if r.read_exact(&mut kind).is_err() {
        return Ok(None);
    }
    let mut len = [0u8; 4];
    r.read_exact(&mut len).map_err(|_| "truncated frame")?;
    let n = u32::from_le_bytes(len) as usize;
    let mut payload = vec![0u8; n];
    r.read_exact(&mut payload).map_err(|_| "truncated frame")?;
    if kind[0] == 0 {
        return Ok(None);
    }
    Ok(Some(payload))
}
