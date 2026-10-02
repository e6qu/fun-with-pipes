//! Protocol Buffers for services: a protobuf schema derived from fwp
//! types, a transcoder between the canonical binary encoding of values
//! (`proto.rs`) and the protobuf wire format, and `.proto` generation.
//!
//! The mapping (documented in docs/services.md):
//!
//! | fwp | protobuf |
//! |---|---|
//! | `Bool` | `bool` |
//! | `I8`, `I16`, `I32`, `Trit` | `sint32` |
//! | `I64`, `ISize`, `TInt` | `sint64` |
//! | `U8`, `U16`, `U32` | `uint32` |
//! | `U64`, `USize` | `uint64` |
//! | `I128`, `U128` | `bytes` (16 bytes, little-endian) |
//! | `F32` (`F16`, `BF16`) | `float` |
//! | `F64` (`F128`) | `double` |
//! | `String`, `Bytes` | `string`, `bytes` |
//! | records, tuples, `()` | messages; fields numbered in declaration order |
//! | variants | a message with a `oneof` of one message per constructor |
//! | `List`, `Array`, `Set` | `repeated` |
//! | `Map[K, V]` | `map<K, V>` (or `repeated` entries with `key = 1`, `value = 2`) |
//! | `Option[T]` | `optional` |
//!
//! A `repeated` or `optional` value where protobuf needs a single one (a
//! list of lists, an option in a list) is wrapped in a message with one
//! field, `value = 1`. A function's arguments form its request message
//! (`arg1 = 1`, ...); its result is `value = 1` of the response, which is a
//! `oneof` of `value = 1` and `error = 2` when the function can fail.
//!
//! The same schema is flattened into an array of integers for the C
//! runtime (`runtime/fwp_rt_h2.c`), which implements the same transcoder.

use std::collections::{HashMap, HashSet};

use crate::ir::{Program, TypeShape, MT};
use crate::proto::{leb128, Reader};

pub type NodeId = usize;

#[derive(Clone, Debug, PartialEq)]
pub enum Node {
    Bool,
    /// Signed integer of a width in bytes (zigzag varint).
    SInt(u8),
    /// Unsigned integer of a width in bytes (varint).
    UInt(u8),
    F32,
    F64,
    Str,
    Bytes,
    /// A 128-bit integer as 16 little-endian bytes.
    Int128,
    /// A message; fields in canonical order with their numbers.
    Msg(Msg),
    /// A message holding a `oneof`; alternative `i` is field `i + 1` and
    /// its canonical form is the constructor index then the value.
    OneOf {
        name: String,
        /// The `oneof` group name.
        group: String,
        alts: Vec<(String, NodeId)>,
    },
    /// `repeated` (a count then the elements, canonically).
    List(NodeId),
    /// `optional` (tag 0 for none, 1 then the value, canonically).
    Opt(NodeId),
}

#[derive(Clone, Debug, PartialEq)]
pub struct Msg {
    pub name: String,
    /// `(number, name, node)` in canonical order.
    pub fields: Vec<(u32, String, NodeId)>,
    /// A map entry (`key = 1`, `value = 2`).
    pub map_entry: bool,
    /// Messages nested in another one (constructors of a variant).
    pub parent: Option<NodeId>,
}

/// Request and response nodes of a method.
#[derive(Clone, Copy, Debug)]
pub struct MethodSchema {
    pub request: NodeId,
    pub response: NodeId,
}

#[derive(Default)]
pub struct Schema {
    pub nodes: Vec<Node>,
    memo: HashMap<MT, NodeId>,
    wraps: HashMap<NodeId, NodeId>,
    names: HashSet<String>,
}

fn camel(s: &str) -> String {
    let mut out = String::new();
    let mut up = true;
    for c in s.chars() {
        if c.is_ascii_alphanumeric() {
            if up {
                out.push(c.to_ascii_uppercase());
            } else {
                out.push(c);
            }
            up = false;
        } else {
            up = true;
        }
    }
    if out.is_empty() || out.starts_with(|c: char| c.is_ascii_digit()) {
        out.insert(0, 'X');
    }
    out
}

fn snake(s: &str) -> String {
    let mut out = String::new();
    for (i, c) in s.chars().enumerate() {
        if c.is_ascii_uppercase() {
            if i > 0 && !out.ends_with('_') {
                out.push('_');
            }
            out.push(c.to_ascii_lowercase());
        } else if c.is_ascii_alphanumeric() {
            out.push(c);
        } else if !out.ends_with('_') {
            out.push('_');
        }
    }
    let out = out.trim_matches('_').to_string();
    if out.is_empty() || out.starts_with(|c: char| c.is_ascii_digit()) {
        format!("f{}", out)
    } else {
        out
    }
}

/// The gRPC service name of a module: `shop.inventory` is `ShopInventory`.
pub fn service_name(module: &str) -> String {
    camel(module)
}

/// The gRPC method name of a function: `price-of` is `PriceOf`.
pub fn method_name(function: &str) -> String {
    camel(function)
}

/// The protobuf package of every fwp service.
pub const PACKAGE: &str = "fwp";

/// The gRPC path of a function: `/fwp.Inventory/Lookup`.
pub fn path(module: &str, function: &str) -> String {
    format!(
        "/{}.{}/{}",
        PACKAGE,
        service_name(module),
        method_name(function)
    )
}

/// The environment variable that holds a service's address:
/// `FWP_SERVICE_INVENTORY` for `inventory`, `FWP_SERVICE_SHOP_INVENTORY`
/// for `shop.inventory`.
pub fn env_var(module: &str) -> String {
    let m: String = module
        .chars()
        .map(|c| {
            if c.is_ascii_alphanumeric() {
                c.to_ascii_uppercase()
            } else {
                '_'
            }
        })
        .collect();
    format!("FWP_SERVICE_{}", m)
}

/// A hex fingerprint of a function's interface (its type and error type),
/// sent by fwp clients in the `fwp-fingerprint` header.
pub fn fingerprint(prog: &Program, ty: &MT, error: Option<&MT>) -> String {
    let mut canon = crate::proto::canonical_type(ty, prog);
    if let Some(e) = error {
        canon.push('!');
        canon.push_str(&crate::proto::canonical_type(e, prog));
    }
    crate::proto::fingerprint(&canon)
        .iter()
        .map(|b| format!("{:02x}", b))
        .collect()
}

fn short(n: &str) -> &str {
    n.strip_prefix("std::").unwrap_or(n)
}

/// A readable name for a type: `ResultI64String`, `TupleStringF64`.
fn type_name(mt: &MT) -> String {
    match mt {
        MT::Con(n, args) => {
            let mut s = camel(&crate::types::display_name(n));
            for a in args {
                s.push_str(&type_name(a));
            }
            s
        }
        MT::Record(fs) if fs.is_empty() => "Unit".into(),
        MT::Record(fs) => {
            let tuple = fs.iter().enumerate().all(|(i, (l, _))| *l == i.to_string());
            let mut s = String::from(if tuple { "Tuple" } else { "Record" });
            for (l, t) in fs {
                if !tuple {
                    s.push_str(&camel(l));
                }
                s.push_str(&type_name(t));
            }
            s
        }
        MT::Fun(..) => "Fn".into(),
        MT::Nat(n) => format!("N{}", n),
    }
}

fn is_tuple(fs: &[(String, MT)]) -> bool {
    fs.iter().enumerate().all(|(i, (l, _))| *l == i.to_string())
}

/// Check that values of a type can be sent to and from a service.
pub fn check_encodable(prog: &Program, mt: &MT) -> Result<(), String> {
    Schema::default().field(prog, mt).map(|_| ())
}

impl Schema {
    fn push(&mut self, n: Node) -> NodeId {
        self.nodes.push(n);
        self.nodes.len() - 1
    }

    /// A unique top-level message name.
    fn unique(&mut self, base: String) -> String {
        let mut name = base.clone();
        let mut i = 2;
        while self.names.contains(&name) {
            name = format!("{}{}", base, i);
            i += 1;
        }
        self.names.insert(name.clone());
        name
    }

    pub fn is_singular(&self, id: NodeId) -> bool {
        !matches!(self.nodes[id], Node::List(_) | Node::Opt(_))
    }

    /// The node of a field holding values of `mt` (possibly `repeated` or
    /// `optional`).
    pub fn field(&mut self, prog: &Program, mt: &MT) -> Result<NodeId, String> {
        if let Some(id) = self.memo.get(mt) {
            return Ok(*id);
        }
        let bad = || format!("values of type `{}` cannot be sent to a service", mt);
        let scalar = match mt {
            MT::Con(n, args) if args.is_empty() || short(n) == "TInt" => match short(n) {
                "Bool" => Some(Node::Bool),
                "I8" | "Trit" => Some(Node::SInt(1)),
                "I16" => Some(Node::SInt(2)),
                "I32" => Some(Node::SInt(4)),
                "I64" | "ISize" | "TInt" => Some(Node::SInt(8)),
                "U8" => Some(Node::UInt(1)),
                "U16" => Some(Node::UInt(2)),
                "U32" => Some(Node::UInt(4)),
                "U64" | "USize" => Some(Node::UInt(8)),
                "I128" | "U128" => Some(Node::Int128),
                "F32" | "F16" | "BF16" => Some(Node::F32),
                "F64" | "F128" => Some(Node::F64),
                "String" => Some(Node::Str),
                "Bytes" => Some(Node::Bytes),
                _ => None,
            },
            _ => None,
        };
        if let Some(s) = scalar {
            let id = self.push(s);
            self.memo.insert(mt.clone(), id);
            return Ok(id);
        }
        match mt {
            MT::Fun(..) | MT::Nat(_) => Err(bad()),
            MT::Record(fs) => {
                let name = self.unique(type_name(mt));
                let id = self.push(Node::Bool);
                self.memo.insert(mt.clone(), id);
                let tuple = is_tuple(fs);
                let mut fields = Vec::new();
                for (i, (l, t)) in fs.iter().enumerate() {
                    let n = self.field(prog, t)?;
                    let fname = if tuple { format!("f{}", i) } else { snake(l) };
                    fields.push(((i + 1) as u32, fname, n));
                }
                self.nodes[id] = Node::Msg(Msg {
                    name,
                    fields,
                    map_entry: false,
                    parent: None,
                });
                Ok(id)
            }
            MT::Con(n, args) => {
                let elem = |i: usize| args.get(i).cloned().unwrap_or(MT::unit());
                match short(n) {
                    "Option" => {
                        let c = self.singular(prog, &elem(0))?;
                        let id = self.push(Node::Opt(c));
                        self.memo.insert(mt.clone(), id);
                        return Ok(id);
                    }
                    "List" | "Array" | "Set" => {
                        let c = self.singular(prog, &elem(0))?;
                        let id = self.push(Node::List(c));
                        self.memo.insert(mt.clone(), id);
                        return Ok(id);
                    }
                    "Map" => {
                        let name = self.unique(format!("{}Entry", type_name(mt)));
                        let entry = self.push(Node::Bool);
                        let id = self.push(Node::List(entry));
                        self.memo.insert(mt.clone(), id);
                        let k = self.field(prog, &elem(0))?;
                        let v = self.field(prog, &elem(1))?;
                        self.nodes[entry] = Node::Msg(Msg {
                            name,
                            fields: vec![(1, "key".into(), k), (2, "value".into(), v)],
                            map_entry: true,
                            parent: None,
                        });
                        return Ok(id);
                    }
                    _ => {}
                }
                match prog.shapes.get(mt) {
                    Some(TypeShape::Record(fs)) => {
                        let name = self.unique(type_name(mt));
                        let id = self.push(Node::Bool);
                        self.memo.insert(mt.clone(), id);
                        let order = prog.field_order.get(n);
                        let mut fields = Vec::new();
                        for (i, (l, t)) in fs.iter().enumerate() {
                            let num = order
                                .and_then(|o| o.iter().position(|x| x == l))
                                .unwrap_or(i)
                                + 1;
                            let node = self.field(prog, t)?;
                            fields.push((num as u32, snake(l), node));
                        }
                        self.nodes[id] = Node::Msg(Msg {
                            name,
                            fields,
                            map_entry: false,
                            parent: None,
                        });
                        Ok(id)
                    }
                    Some(TypeShape::Adt(vs)) => {
                        let name = self.unique(type_name(mt));
                        let id = self.push(Node::Bool);
                        self.memo.insert(mt.clone(), id);
                        let mut alts = Vec::new();
                        let mut seen = HashSet::new();
                        for (cname, fts) in vs {
                            let mut base = camel(cname);
                            if base == name {
                                base.push('_');
                            }
                            let mut cn = base.clone();
                            let mut i = 2;
                            while !seen.insert(cn.clone()) {
                                cn = format!("{}{}", base, i);
                                i += 1;
                            }
                            let mut fields = Vec::new();
                            for (i, t) in fts.iter().enumerate() {
                                let node = self.field(prog, t)?;
                                fields.push(((i + 1) as u32, format!("f{}", i), node));
                            }
                            let m = self.push(Node::Msg(Msg {
                                name: cn,
                                fields,
                                map_entry: false,
                                parent: Some(id),
                            }));
                            alts.push((snake(cname), m));
                        }
                        self.nodes[id] = Node::OneOf {
                            name,
                            group: "value".into(),
                            alts,
                        };
                        Ok(id)
                    }
                    _ => Err(bad()),
                }
            }
        }
    }

    /// A node that is not `repeated` or `optional`: such values are
    /// wrapped in a message with one field.
    pub fn singular(&mut self, prog: &Program, mt: &MT) -> Result<NodeId, String> {
        let n = self.field(prog, mt)?;
        if self.is_singular(n) {
            return Ok(n);
        }
        if let Some(w) = self.wraps.get(&n) {
            return Ok(*w);
        }
        let name = self.unique(format!("{}Wrapper", type_name(mt)));
        let w = self.push(Node::Msg(Msg {
            name,
            fields: vec![(1, "value".into(), n)],
            map_entry: false,
            parent: None,
        }));
        self.wraps.insert(n, w);
        Ok(w)
    }

    /// Request and response messages of a function.
    pub fn method(
        &mut self,
        prog: &Program,
        function: &str,
        params: &[MT],
        result: &MT,
        error: Option<&MT>,
    ) -> Result<MethodSchema, String> {
        let m = method_name(function);
        let req_name = self.unique(format!("{}Request", m));
        let resp_name = self.unique(format!("{}Response", m));
        let mut fields = Vec::new();
        for (i, p) in params.iter().enumerate() {
            let n = self.field(prog, p)?;
            fields.push(((i + 1) as u32, format!("arg{}", i + 1), n));
        }
        let request = self.push(Node::Msg(Msg {
            name: req_name,
            fields,
            map_entry: false,
            parent: None,
        }));
        let response = match error {
            None => {
                let n = self.field(prog, result)?;
                self.push(Node::Msg(Msg {
                    name: resp_name,
                    fields: vec![(1, "value".into(), n)],
                    map_entry: false,
                    parent: None,
                }))
            }
            Some(e) => {
                let v = self.singular(prog, result)?;
                let e = self.singular(prog, e)?;
                self.push(Node::OneOf {
                    name: resp_name,
                    group: "result".into(),
                    alts: vec![("value".into(), v), ("error".into(), e)],
                })
            }
        };
        Ok(MethodSchema { request, response })
    }

    // ------------------------------------------------------------ flat form

    /// The schema as integers for the C runtime, and the offset of each
    /// node. Layout per node: `BOOL`; `SINT w`; `UINT w`; `F32`; `F64`;
    /// `STR`; `BYTES`; `INT128`; `MSG n (number offset)*`; `ONEOF n
    /// offset*`; `LIST offset`; `OPT offset` (kinds 0 to 11).
    pub fn flatten(&self) -> (Vec<i32>, Vec<usize>) {
        let size = |n: &Node| match n {
            Node::SInt(_) | Node::UInt(_) | Node::List(_) | Node::Opt(_) => 2,
            Node::Msg(m) => 2 + 2 * m.fields.len(),
            Node::OneOf { alts, .. } => 2 + alts.len(),
            _ => 1,
        };
        let mut offs = Vec::new();
        let mut at = 0;
        for n in &self.nodes {
            offs.push(at);
            at += size(n);
        }
        let mut out = Vec::with_capacity(at);
        for n in &self.nodes {
            match n {
                Node::Bool => out.push(0),
                Node::SInt(w) => out.extend([1, *w as i32]),
                Node::UInt(w) => out.extend([2, *w as i32]),
                Node::F32 => out.push(3),
                Node::F64 => out.push(4),
                Node::Str => out.push(5),
                Node::Bytes => out.push(6),
                Node::Int128 => out.push(7),
                Node::Msg(m) => {
                    out.extend([8, m.fields.len() as i32]);
                    for (num, _, c) in &m.fields {
                        out.extend([*num as i32, offs[*c] as i32]);
                    }
                }
                Node::OneOf { alts, .. } => {
                    out.extend([9, alts.len() as i32]);
                    for (_, c) in alts {
                        out.push(offs[*c] as i32);
                    }
                }
                Node::List(c) => out.extend([10, offs[*c] as i32]),
                Node::Opt(c) => out.extend([11, offs[*c] as i32]),
            }
        }
        (out, offs)
    }

    // ------------------------------------------------------- canonical -> pb

    fn packable(&self, id: NodeId) -> bool {
        matches!(
            self.nodes[id],
            Node::Bool | Node::SInt(_) | Node::UInt(_) | Node::F32 | Node::F64
        )
    }

    /// Encode the body of message node `id` from canonical bytes.
    pub fn encode(&self, id: NodeId, canon: &[u8]) -> Result<Vec<u8>, String> {
        let mut r = Reader::new(canon);
        let mut out = Vec::new();
        self.enc_body(id, &mut r, &mut out)?;
        if r.pos != canon.len() {
            return Err("trailing bytes after value".into());
        }
        Ok(out)
    }

    fn enc_body(&self, id: NodeId, r: &mut Reader, out: &mut Vec<u8>) -> Result<(), String> {
        match &self.nodes[id] {
            Node::Msg(m) => {
                // canonical order in, field number order out
                let mut parts = Vec::new();
                for (num, _, c) in &m.fields {
                    let mut b = Vec::new();
                    self.enc_field(*num, *c, r, &mut b, false)?;
                    parts.push((*num, b));
                }
                parts.sort_by_key(|p| p.0);
                for (_, b) in parts {
                    out.extend_from_slice(&b);
                }
                Ok(())
            }
            Node::OneOf { alts, .. } => {
                let tag = r.leb128()? as usize;
                let Some((_, c)) = alts.get(tag) else {
                    return Err("bad constructor tag".into());
                };
                self.enc_field(tag as u32 + 1, *c, r, out, true)
            }
            _ => Err("internal: not a message".into()),
        }
    }

    fn enc_field(
        &self,
        num: u32,
        id: NodeId,
        r: &mut Reader,
        out: &mut Vec<u8>,
        presence: bool,
    ) -> Result<(), String> {
        match &self.nodes[id] {
            Node::Msg(_) | Node::OneOf { .. } => {
                let mut sub = Vec::new();
                self.enc_body(id, r, &mut sub)?;
                key(out, num, 2);
                varint(out, sub.len() as u64);
                out.extend_from_slice(&sub);
            }
            Node::List(c) => {
                let n = r.leb128()?;
                if self.packable(*c) {
                    let mut buf = Vec::new();
                    for _ in 0..n {
                        let (_, bytes, _) = self.enc_scalar(*c, r)?;
                        buf.extend_from_slice(&bytes);
                    }
                    if n > 0 {
                        key(out, num, 2);
                        varint(out, buf.len() as u64);
                        out.extend_from_slice(&buf);
                    }
                } else {
                    for _ in 0..n {
                        self.enc_field(num, *c, r, out, true)?;
                    }
                }
            }
            Node::Opt(c) => {
                if r.leb128()? == 1 {
                    self.enc_field(num, *c, r, out, true)?;
                }
            }
            _ => {
                let (wire, bytes, default) = self.enc_scalar(id, r)?;
                if presence || !default {
                    key(out, num, wire);
                    out.extend_from_slice(&bytes);
                }
            }
        }
        Ok(())
    }

    /// A scalar: wire type, encoded bytes, and whether it is the default.
    fn enc_scalar(&self, id: NodeId, r: &mut Reader) -> Result<(u8, Vec<u8>, bool), String> {
        let mut out = Vec::new();
        Ok(match &self.nodes[id] {
            Node::Bool => {
                let b = r.leb128()?;
                varint(&mut out, b);
                (0, out, b == 0)
            }
            Node::SInt(w) => {
                let x = le(r, *w as usize)?;
                let shift = 64 - 8 * *w as u32;
                let v = ((x << shift) as i64) >> shift;
                varint(&mut out, ((v << 1) ^ (v >> 63)) as u64);
                (0, out, v == 0)
            }
            Node::UInt(w) => {
                let x = le(r, *w as usize)?;
                varint(&mut out, x);
                (0, out, x == 0)
            }
            Node::F32 => {
                let b = take(r, 4)?;
                out.extend_from_slice(b);
                (5, out, b.iter().all(|x| *x == 0))
            }
            Node::F64 => {
                let b = take(r, 8)?;
                out.extend_from_slice(b);
                (1, out, b.iter().all(|x| *x == 0))
            }
            Node::Str | Node::Bytes => {
                let n = r.leb128()? as usize;
                let b = take(r, n)?;
                varint(&mut out, n as u64);
                out.extend_from_slice(b);
                (2, out, n == 0)
            }
            Node::Int128 => {
                let b = take(r, 16)?;
                varint(&mut out, 16);
                out.extend_from_slice(b);
                (2, out, b.iter().all(|x| *x == 0))
            }
            _ => return Err("internal: not a scalar".into()),
        })
    }

    // ------------------------------------------------------- pb -> canonical

    /// Decode the body of message node `id` into canonical bytes.
    pub fn decode(&self, id: NodeId, pb: &[u8]) -> Result<Vec<u8>, String> {
        let mut out = Vec::new();
        self.dec_body(id, pb, &mut out)?;
        Ok(out)
    }

    fn dec_body(&self, id: NodeId, pb: &[u8], out: &mut Vec<u8>) -> Result<(), String> {
        match &self.nodes[id] {
            Node::Msg(m) => {
                for (num, _, c) in &m.fields {
                    self.dec_field(*num, *c, pb, out)?;
                }
                Ok(())
            }
            Node::OneOf { name, alts, .. } => {
                let mut found = None;
                for f in fields(pb) {
                    let f = f?;
                    if f.0 >= 1 && f.0 as usize <= alts.len() {
                        found = Some(f);
                    }
                }
                let Some((num, val)) = found else {
                    return Err(format!("no alternative of `{}` is set", name));
                };
                leb128(out, num as u64 - 1);
                self.dec_value(alts[num as usize - 1].1, num, &val, out)
            }
            _ => Err("internal: not a message".into()),
        }
    }

    fn dec_field(&self, num: u32, id: NodeId, pb: &[u8], out: &mut Vec<u8>) -> Result<(), String> {
        match &self.nodes[id] {
            Node::List(c) => {
                let mut buf = Vec::new();
                let mut n = 0u64;
                for f in fields(pb) {
                    let (fnum, val) = f?;
                    if fnum != num {
                        continue;
                    }
                    match (&val, self.packable(*c)) {
                        (Val::Len(b), true) => {
                            let mut p = PReader { d: b, i: 0 };
                            while p.i < b.len() {
                                let v = match self.nodes[*c] {
                                    Node::F32 => Val::Fixed32(p.fixed(4)? as u32),
                                    Node::F64 => Val::Fixed64(p.fixed(8)?),
                                    _ => Val::Varint(p.varint()?),
                                };
                                self.dec_scalar(*c, num, &v, &mut buf)?;
                                n += 1;
                            }
                        }
                        _ => {
                            self.dec_value(*c, num, &val, &mut buf)?;
                            n += 1;
                        }
                    }
                }
                leb128(out, n);
                out.extend_from_slice(&buf);
                Ok(())
            }
            _ => {
                let mut last = None;
                for f in fields(pb) {
                    let (fnum, val) = f?;
                    if fnum == num {
                        last = Some(val);
                    }
                }
                match (&self.nodes[id], last) {
                    (Node::Opt(c), Some(v)) => {
                        out.push(1);
                        self.dec_value(*c, num, &v, out)
                    }
                    (Node::Opt(_), None) => {
                        out.push(0);
                        Ok(())
                    }
                    (_, Some(v)) => self.dec_value(id, num, &v, out),
                    (_, None) => self.default_value(id, num, out),
                }
            }
        }
    }

    fn dec_value(&self, id: NodeId, num: u32, v: &Val, out: &mut Vec<u8>) -> Result<(), String> {
        match &self.nodes[id] {
            Node::Msg(_) | Node::OneOf { .. } => match v {
                Val::Len(b) => self.dec_body(id, b, out),
                _ => Err(format!("field {}: wrong wire type", num)),
            },
            _ => self.dec_scalar(id, num, v, out),
        }
    }

    fn dec_scalar(&self, id: NodeId, num: u32, v: &Val, out: &mut Vec<u8>) -> Result<(), String> {
        let wrong = || format!("field {}: wrong wire type", num);
        let range = || format!("field {}: value out of range", num);
        match (&self.nodes[id], v) {
            (Node::Bool, Val::Varint(x)) => out.push((*x != 0) as u8),
            (Node::SInt(w), Val::Varint(x)) => {
                let v = ((x >> 1) as i64) ^ -((x & 1) as i64);
                let bits = 8 * *w as u32;
                if bits < 64 && (v < -(1i64 << (bits - 1)) || v >= (1i64 << (bits - 1))) {
                    return Err(range());
                }
                out.extend_from_slice(&v.to_le_bytes()[..*w as usize]);
            }
            (Node::UInt(w), Val::Varint(x)) => {
                let bits = 8 * *w as u32;
                if bits < 64 && *x >= (1u64 << bits) {
                    return Err(range());
                }
                out.extend_from_slice(&x.to_le_bytes()[..*w as usize]);
            }
            (Node::F32, Val::Fixed32(x)) => out.extend_from_slice(&x.to_le_bytes()),
            (Node::F64, Val::Fixed64(x)) => out.extend_from_slice(&x.to_le_bytes()),
            (Node::Str, Val::Len(b)) => {
                if std::str::from_utf8(b).is_err() {
                    return Err(format!("field {}: invalid UTF-8", num));
                }
                leb128(out, b.len() as u64);
                out.extend_from_slice(b);
            }
            (Node::Bytes, Val::Len(b)) => {
                leb128(out, b.len() as u64);
                out.extend_from_slice(b);
            }
            (Node::Int128, Val::Len(b)) => match b.len() {
                0 => out.extend_from_slice(&[0; 16]),
                16 => out.extend_from_slice(b),
                _ => return Err(range()),
            },
            _ => return Err(wrong()),
        }
        Ok(())
    }

    /// The canonical form of a field's default value.
    fn default_value(&self, id: NodeId, num: u32, out: &mut Vec<u8>) -> Result<(), String> {
        match &self.nodes[id] {
            Node::Bool | Node::Str | Node::Bytes | Node::List(_) | Node::Opt(_) => out.push(0),
            Node::SInt(w) | Node::UInt(w) => out.resize(out.len() + *w as usize, 0),
            Node::F32 => out.extend_from_slice(&[0; 4]),
            Node::F64 => out.extend_from_slice(&[0; 8]),
            Node::Int128 => out.extend_from_slice(&[0; 16]),
            Node::Msg(m) => {
                for (n, _, c) in &m.fields {
                    self.default_value(*c, *n, out)?;
                }
            }
            Node::OneOf { name, .. } => {
                return Err(format!("field {}: missing value of `{}`", num, name))
            }
        }
        Ok(())
    }

    // ---------------------------------------------------------- .proto text

    fn type_ref(&self, id: NodeId) -> String {
        match &self.nodes[id] {
            Node::Bool => "bool".into(),
            Node::SInt(8) => "sint64".into(),
            Node::SInt(_) => "sint32".into(),
            Node::UInt(8) => "uint64".into(),
            Node::UInt(_) => "uint32".into(),
            Node::F32 => "float".into(),
            Node::F64 => "double".into(),
            Node::Str => "string".into(),
            Node::Bytes | Node::Int128 => "bytes".into(),
            Node::Msg(m) => m.name.clone(),
            Node::OneOf { name, .. } => name.clone(),
            Node::List(c) | Node::Opt(c) => self.type_ref(*c),
        }
    }

    /// `map<K, V>` for a list of map entries whose key is a valid map key
    /// and whose value is singular.
    fn as_map(&self, id: NodeId) -> Option<(NodeId, NodeId)> {
        let Node::List(e) = self.nodes[id] else {
            return None;
        };
        let Node::Msg(m) = &self.nodes[e] else {
            return None;
        };
        if !m.map_entry {
            return None;
        }
        let (k, v) = (m.fields[0].2, m.fields[1].2);
        let key_ok = matches!(
            self.nodes[k],
            Node::Bool | Node::SInt(_) | Node::UInt(_) | Node::Str
        );
        (key_ok && self.is_singular(v)).then_some((k, v))
    }

    fn field_line(&self, num: u32, name: &str, id: NodeId, in_oneof: bool) -> String {
        if let Some((k, v)) = self.as_map(id) {
            return format!(
                "map<{}, {}> {} = {};",
                self.type_ref(k),
                self.type_ref(v),
                name,
                num
            );
        }
        let label = match self.nodes[id] {
            Node::List(_) => "repeated ",
            Node::Opt(_) if !in_oneof => "optional ",
            _ => "",
        };
        format!("{}{} {} = {};", label, self.type_ref(id), name, num)
    }

    /// Message nodes reachable from `roots`, in creation order.
    fn reachable(&self, roots: &[NodeId]) -> Vec<bool> {
        let mut seen = vec![false; self.nodes.len()];
        let mut stack: Vec<NodeId> = roots.to_vec();
        while let Some(id) = stack.pop() {
            if std::mem::replace(&mut seen[id], true) {
                continue;
            }
            match &self.nodes[id] {
                Node::Msg(m) => stack.extend(m.fields.iter().map(|f| f.2)),
                Node::OneOf { alts, .. } => stack.extend(alts.iter().map(|a| a.1)),
                Node::List(c) | Node::Opt(c) => stack.push(*c),
                _ => {}
            }
        }
        seen
    }

    fn message_text(&self, id: NodeId, indent: usize, out: &mut String) {
        let pad = "  ".repeat(indent);
        match &self.nodes[id] {
            Node::Msg(m) => {
                if m.fields.is_empty() {
                    out.push_str(&format!("{}message {} {{}}\n", pad, m.name));
                    return;
                }
                out.push_str(&format!("{}message {} {{\n", pad, m.name));
                let mut fs = m.fields.clone();
                fs.sort_by_key(|f| f.0);
                for (num, name, c) in fs {
                    out.push_str(&format!(
                        "{}  {}\n",
                        pad,
                        self.field_line(num, &name, c, false)
                    ));
                }
                out.push_str(&format!("{}}}\n", pad));
            }
            Node::OneOf { name, group, alts } => {
                out.push_str(&format!("{}message {} {{\n", pad, name));
                for (i, n) in self.nodes.iter().enumerate() {
                    if matches!(n, Node::Msg(m) if m.parent == Some(id)) {
                        self.message_text(i, indent + 1, out);
                    }
                }
                out.push_str(&format!("{}  oneof {} {{\n", pad, group));
                for (i, (aname, c)) in alts.iter().enumerate() {
                    out.push_str(&format!(
                        "{}    {}\n",
                        pad,
                        self.field_line(i as u32 + 1, aname, *c, true)
                    ));
                }
                out.push_str(&format!("{}  }}\n{}}}\n", pad, pad));
            }
            _ => {}
        }
    }
}

/// A service's methods for `.proto` generation: function name, request
/// and response.
pub struct ServiceText {
    pub module: String,
    pub methods: Vec<(String, MethodSchema)>,
}

/// The `.proto` file of a set of services sharing a schema.
pub fn proto_file(schema: &Schema, services: &[ServiceText], source: &str) -> String {
    let mut out = format!(
        "// Generated by `fwp proto` from {}.\n// fwp services: gRPC over HTTP/2; see docs/services.md for the mapping.\n\nsyntax = \"proto3\";\n\npackage {};\n",
        source, PACKAGE
    );
    let mut roots = Vec::new();
    for s in services {
        out.push_str(&format!("\nservice {} {{\n", service_name(&s.module)));
        for (f, m) in &s.methods {
            out.push_str(&format!(
                "  rpc {}({}) returns ({});\n",
                method_name(f),
                schema.type_ref(m.request),
                schema.type_ref(m.response)
            ));
            roots.push(m.request);
            roots.push(m.response);
        }
        out.push_str("}\n");
    }
    let seen = schema.reachable(&roots);
    for (id, n) in schema.nodes.iter().enumerate() {
        if !seen[id] {
            continue;
        }
        let top = match n {
            Node::Msg(m) => m.parent.is_none() && !(m.map_entry && is_map_entry_used(schema, id)),
            Node::OneOf { .. } => true,
            _ => false,
        };
        if top {
            out.push('\n');
            schema.message_text(id, 0, &mut out);
        }
    }
    out
}

/// Whether every list of this entry message is written as `map<K, V>`.
fn is_map_entry_used(schema: &Schema, entry: NodeId) -> bool {
    schema
        .nodes
        .iter()
        .enumerate()
        .filter(|(_, n)| matches!(n, Node::List(e) if *e == entry))
        .all(|(i, _)| schema.as_map(i).is_some())
}

// ------------------------------------------------------------- wire helpers

pub fn varint(out: &mut Vec<u8>, mut x: u64) {
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

fn key(out: &mut Vec<u8>, num: u32, wire: u8) {
    varint(out, ((num as u64) << 3) | wire as u64);
}

fn take<'a>(r: &mut Reader<'a>, n: usize) -> Result<&'a [u8], String> {
    if r.pos + n > r.data.len() {
        return Err("truncated value".into());
    }
    let b = &r.data[r.pos..r.pos + n];
    r.pos += n;
    Ok(b)
}

fn le(r: &mut Reader, n: usize) -> Result<u64, String> {
    let b = take(r, n)?;
    Ok(b.iter()
        .enumerate()
        .fold(0u64, |acc, (i, x)| acc | (*x as u64) << (8 * i)))
}

/// A field value on the wire.
#[derive(Clone, Debug)]
enum Val<'a> {
    Varint(u64),
    Fixed32(u32),
    Fixed64(u64),
    Len(&'a [u8]),
}

struct PReader<'a> {
    d: &'a [u8],
    i: usize,
}

impl<'a> PReader<'a> {
    fn varint(&mut self) -> Result<u64, String> {
        let mut x = 0u64;
        for shift in (0..64).step_by(7) {
            let Some(b) = self.d.get(self.i) else {
                return Err("truncated message".into());
            };
            self.i += 1;
            x |= ((b & 0x7f) as u64) << shift;
            if b & 0x80 == 0 {
                return Ok(x);
            }
        }
        Err("bad varint".into())
    }

    fn bytes(&mut self, n: usize) -> Result<&'a [u8], String> {
        if self.i + n > self.d.len() {
            return Err("truncated message".into());
        }
        let b = &self.d[self.i..self.i + n];
        self.i += n;
        Ok(b)
    }

    fn fixed(&mut self, n: usize) -> Result<u64, String> {
        Ok(self
            .bytes(n)?
            .iter()
            .enumerate()
            .fold(0u64, |acc, (i, x)| acc | (*x as u64) << (8 * i)))
    }
}

/// The fields of a message body, in order.
fn fields(pb: &[u8]) -> impl Iterator<Item = Result<(u32, Val<'_>), String>> {
    let mut p = PReader { d: pb, i: 0 };
    let mut failed = false;
    std::iter::from_fn(move || {
        if failed || p.i >= p.d.len() {
            return None;
        }
        let r = (|| {
            let k = p.varint()?;
            let num = (k >> 3) as u32;
            if num == 0 || k >> 3 > u32::MAX as u64 {
                return Err("bad field number".to_string());
            }
            let v = match k & 7 {
                0 => Val::Varint(p.varint()?),
                1 => Val::Fixed64(p.fixed(8)?),
                2 => {
                    let n = p.varint()? as usize;
                    Val::Len(p.bytes(n)?)
                }
                5 => Val::Fixed32(p.fixed(4)? as u32),
                _ => return Err("unsupported wire type".to_string()),
            };
            Ok((num, v))
        })();
        failed = r.is_err();
        Some(r)
    })
}
