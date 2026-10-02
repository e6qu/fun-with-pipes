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
        Value::Closure(_) | Value::File(_) => {}
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
