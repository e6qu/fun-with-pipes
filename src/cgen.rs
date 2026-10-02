//! C code generation from the monomorphic IR. The output is a single C
//! translation unit containing the runtime and the program; it is compiled
//! with the system C compiler into a self-contained native executable.

use std::collections::HashMap;
use std::fmt::Write;

use crate::ir::*;
use crate::value::Value;

const RUNTIME: &[&str] = &[
    include_str!("../runtime/fwp_rt.c"),
    include_str!("../runtime/fwp_rt_ops.c"),
    include_str!("../runtime/fwp_rt_num.c"),
    include_str!("../runtime/fwp_rt_prims.c"),
    include_str!("../runtime/fwp_rt_task.c"),
    include_str!("../runtime/fwp_rt_json.c"),
    include_str!("../runtime/fwp_rt_web.c"),
    include_str!("../runtime/fwp_rt_exec.c"),
];

struct Gen<'p> {
    prog: &'p Program,
    descs: HashMap<MT, usize>,
    desc_defs: Vec<String>,
    strings: HashMap<Vec<u8>, usize>,
    string_defs: Vec<String>,
    consts: Vec<String>,
    const_init: String,
    used_closures: Vec<bool>,
}

/// Numeric kind, display name and TInt width of a primitive type.
fn num_kind(mt: &MT) -> Option<(&'static str, String, u64)> {
    let MT::Con(n, args) = mt else { return None };
    let short = n.strip_prefix("std::")?;
    let k = match short {
        "I8" => "K_I8",
        "I16" => "K_I16",
        "I32" => "K_I32",
        "I64" | "ISize" => "K_I64",
        "I128" => "K_I128",
        "U8" => "K_U8",
        "U16" => "K_U16",
        "U32" => "K_U32",
        "U64" | "USize" => "K_U64",
        "U128" => "K_U128",
        "F32" | "F16" | "BF16" => "K_F32",
        "F64" | "F128" => "K_F64",
        "TInt" => "K_TINT",
        "Trit" => "K_TRIT",
        _ => return None,
    };
    let w = match args.first() {
        Some(MT::Nat(w)) => *w,
        _ => 0,
    };
    Some((k, short.to_string(), w))
}

/// Lane count and lane type of a `Vec[n, t]`.
fn vec_shape(mt: &MT) -> (u64, MT) {
    match mt {
        MT::Con(_, args) => (
            match args.first() {
                Some(MT::Nat(n)) => *n,
                _ => 0,
            },
            args.get(1).cloned().unwrap_or(MT::unit()),
        ),
        _ => (0, MT::unit()),
    }
}

fn c_string_literal(bytes: &[u8]) -> String {
    let mut s = String::from("\"");
    for &b in bytes {
        match b {
            b'"' => s.push_str("\\\""),
            b'\\' => s.push_str("\\\\"),
            b'\n' => s.push_str("\\n"),
            0x20..=0x7e if b != b'?' => s.push(b as char),
            _ => {
                let _ = write!(s, "\\{:03o}", b);
            }
        }
    }
    s.push('"');
    s
}

fn op_code(sym: &str) -> &'static str {
    match sym.rsplit('.').next().unwrap() {
        "add" => "OP_ADD",
        "sub" => "OP_SUB",
        "mul" => "OP_MUL",
        "div" => "OP_DIV",
        _ => "OP_REM",
    }
}

fn elem(mt: &MT, i: usize) -> MT {
    match mt {
        MT::Con(_, args) => args.get(i).cloned().unwrap_or(MT::unit()),
        _ => MT::unit(),
    }
}

impl<'p> Gen<'p> {
    // ----- descriptors -----------------------------------------------------------

    fn desc(&mut self, mt: &MT) -> String {
        format!("&d{}", self.desc_id(mt))
    }

    fn desc_id(&mut self, mt: &MT) -> usize {
        if let Some(i) = self.descs.get(mt) {
            return *i;
        }
        let id = self.desc_defs.len();
        self.descs.insert(mt.clone(), id);
        self.desc_defs.push(String::new());
        let def = self.desc_body(mt, id);
        self.desc_defs[id] = def;
        id
    }

    fn cstr(s: &str) -> String {
        c_string_literal(s.as_bytes())
    }

    fn desc_body(&mut self, mt: &MT, id: usize) -> String {
        let simple = |kind: &str, name: &str| {
            format!(
                "static fwp_desc d{} = {{{}, {}}};",
                id,
                kind,
                Self::cstr(name)
            )
        };
        match mt {
            MT::Fun(..) => simple("K_FUN", "function"),
            MT::Nat(_) => simple("K_OPAQUE", "nat"),
            MT::Record(fs) => {
                let tuple =
                    fs.len() > 1 && fs.iter().enumerate().all(|(i, (l, _))| *l == i.to_string());
                self.record_desc(id, None, fs, tuple)
            }
            MT::Con(n, args) => {
                if let Some((k, short, w)) = num_kind(mt) {
                    return format!(
                        "static fwp_desc d{} = {{{}, {}, .width = {}}};",
                        id,
                        k,
                        Self::cstr(&short),
                        w
                    );
                }
                match n.as_str() {
                    "std::String" => return simple("K_STR", "String"),
                    "std::Bytes" => return simple("K_BYTES", "Bytes"),
                    "std::File" => return simple("K_FILE", "File"),
                    "std::Task" => return simple("K_NATIVE", "task"),
                    "std::Channel" => return simple("K_NATIVE", "channel"),
                    "std::Listener" => return simple("K_NATIVE", "listener"),
                    "std::Conn" => return simple("K_NATIVE", "connection"),
                    "std::UdpSocket" => return simple("K_NATIVE", "udp socket"),
                    "std::List" | "std::Array" | "std::Set" => {
                        let e = self.desc_id(&elem(mt, 0));
                        let k = match n.as_str() {
                            "std::List" => "K_LIST",
                            "std::Array" => "K_ARRAY",
                            _ => "K_SET",
                        };
                        return format!("static fwp_desc d{} = {{{}, 0, .elem = &d{}}};", id, k, e);
                    }
                    "std::Map" => {
                        let k = self.desc_id(&elem(mt, 0));
                        let v = self.desc_id(&elem(mt, 1));
                        return format!(
                            "static fwp_desc d{} = {{K_MAP, 0, .elem = &d{}, .elem2 = &d{}}};",
                            id, k, v
                        );
                    }
                    _ => {}
                }
                let _ = args;
                let short = MT::short_name(n);
                match self.prog.shapes.get(mt).cloned() {
                    Some(TypeShape::Adt(vs)) => {
                        let names: Vec<String> = vs.iter().map(|(n, _)| Self::cstr(n)).collect();
                        let arity: Vec<String> =
                            vs.iter().map(|(_, f)| f.len().to_string()).collect();
                        let mut vf = Vec::new();
                        for (vi, (_, fields)) in vs.iter().enumerate() {
                            let ds: Vec<String> = fields
                                .iter()
                                .map(|f| format!("&d{}", self.desc_id(f)))
                                .collect();
                            vf.push(format!(
                                "static const fwp_desc *const d{}_v{}[] = {{{}}};",
                                id,
                                vi,
                                if ds.is_empty() {
                                    "0".to_string()
                                } else {
                                    ds.join(", ")
                                }
                            ));
                        }
                        let vrefs: Vec<String> =
                            (0..vs.len()).map(|vi| format!("d{}_v{}", id, vi)).collect();
                        format!(
                            "static fwp_desc d{id};\n{vf}\nstatic const char *const d{id}_n[] = {{{names}}};\nstatic const int d{id}_a[] = {{{arity}}};\nstatic const fwp_desc *const *const d{id}_vf[] = {{{vrefs}}};\nstatic fwp_desc d{id} = {{K_ADT, {name}, {n}, d{id}_n, 0, d{id}_a, d{id}_vf}};",
                            id = id,
                            vf = vf.join("\n"),
                            names = names.join(", "),
                            arity = arity.join(", "),
                            vrefs = vrefs.join(", "),
                            name = Self::cstr(&short),
                            n = vs.len()
                        )
                    }
                    Some(TypeShape::Record(fs)) => self.record_desc(id, Some(&short), &fs, false),
                    _ => simple("K_OPAQUE", &short),
                }
            }
        }
    }

    fn record_desc(
        &mut self,
        id: usize,
        name: Option<&str>,
        fs: &[(String, MT)],
        tuple: bool,
    ) -> String {
        let names: Vec<String> = fs.iter().map(|(l, _)| Self::cstr(l)).collect();
        let ds: Vec<String> = fs
            .iter()
            .map(|(_, t)| format!("&d{}", self.desc_id(t)))
            .collect();
        format!(
            "static fwp_desc d{id};\nstatic const char *const d{id}_n[] = {{{names}}};\nstatic const fwp_desc *const d{id}_f[] = {{{ds}}};\nstatic fwp_desc d{id} = {{K_RECORD, {name}, {n}, d{id}_n, d{id}_f, .width = {tuple}}};",
            id = id,
            names = if names.is_empty() { "0".into() } else { names.join(", ") },
            ds = if ds.is_empty() { "0".into() } else { ds.join(", ") },
            name = name.map(Self::cstr).unwrap_or_else(|| "0".into()),
            n = fs.len(),
            tuple = tuple as u8
        )
    }

    // ----- constants -------------------------------------------------------------

    fn string_const(&mut self, bytes: &[u8]) -> String {
        if let Some(i) = self.strings.get(bytes) {
            return format!("PTR(&s{})", i);
        }
        let id = self.string_defs.len();
        self.strings.insert(bytes.to_vec(), id);
        self.string_defs.push(format!(
            "static struct {{ uint64_t len; char d[{}]; }} s{} = {{{}, {}}};",
            bytes.len() + 1,
            id,
            bytes.len(),
            c_string_literal(bytes)
        ));
        format!("PTR(&s{})", id)
    }

    /// C expression for a constant value (complex values are built once at
    /// startup into a global).
    fn const_expr(&mut self, v: &Value) -> String {
        match v {
            Value::I8(x) => format!("(V)(int64_t){}", x),
            Value::I16(x) => format!("(V)(int64_t){}", x),
            Value::I32(x) => format!("(V)(int64_t){}", x),
            Value::I64(x) => {
                if *x == i64::MIN {
                    "(V)INT64_MIN".into()
                } else {
                    format!("(V)(int64_t){}LL", x)
                }
            }
            Value::U8(x) => format!("(V){}", x),
            Value::U16(x) => format!("(V){}", x),
            Value::U32(x) => format!("(V){}U", x),
            Value::U64(x) => format!("(V){}ULL", x),
            Value::F32(x) => format!("(V)0x{:x}U", x.to_bits()),
            Value::F64(x) => format!("(V)0x{:x}ULL", x.to_bits()),
            Value::TInt(x) => format!("(V)(int64_t){}LL", x),
            Value::Trit(x) => format!("(V)(int64_t){}", x),
            Value::Str(s) => self.string_const(s.as_bytes()),
            Value::Bytes(b) => self.string_const(b),
            Value::Data(tag, fs) if fs.is_empty() => format!("(V){}", tag),
            Value::Record(fs) if fs.is_empty() => "(V)0".into(),
            _ => {
                let id = self.consts.len();
                self.consts.push(format!("static V c{};", id));
                let init = self.const_build(v);
                let _ = writeln!(self.const_init, "    c{} = {};", id, init);
                format!("c{}", id)
            }
        }
    }

    fn const_build(&mut self, v: &Value) -> String {
        match v {
            Value::I128(x) => {
                let (hi, lo) = ((*x as u128 >> 64) as u64, *x as u128 as u64);
                format!("fwp_box_i128((i128)(((u128){}ULL << 64) | {}ULL))", hi, lo)
            }
            Value::U128(x) => {
                let (hi, lo) = ((x >> 64) as u64, *x as u64);
                format!("fwp_box_u128(((u128){}ULL << 64) | {}ULL)", hi, lo)
            }
            Value::Data(tag, fs) => {
                let parts: Vec<String> = fs.iter().map(|f| self.const_expr(f)).collect();
                format!(
                    "fwp_data({}, {}, (V[]){{{}}})",
                    tag,
                    fs.len(),
                    parts.join(", ")
                )
            }
            Value::Record(fs) => {
                let parts: Vec<String> = fs.iter().map(|f| self.const_expr(f)).collect();
                format!("fwp_record({}, (V[]){{{}}})", fs.len(), parts.join(", "))
            }
            Value::Array(items) => {
                let parts: Vec<String> = items.iter().map(|f| self.const_expr(f)).collect();
                format!(
                    "fwp_p_array_from_list(fwp_list_from((V[]){{{}}}, {}))",
                    if parts.is_empty() {
                        "0".into()
                    } else {
                        parts.join(", ")
                    },
                    items.len()
                )
            }
            Value::Map(m) => {
                let mut parts = Vec::new();
                for (k, v) in m.iter() {
                    parts.push(self.const_expr(k));
                    parts.push(self.const_expr(v));
                }
                format!(
                    "fwp_map_from_sorted({}, (V[]){{{}}})",
                    m.len(),
                    if parts.is_empty() {
                        "0".into()
                    } else {
                        parts.join(", ")
                    }
                )
            }
            Value::File(_) | Value::Native(_) => "0".into(),
            Value::Closure(c) => {
                self.used_closures[c.func] = true;
                let parts: Vec<String> = c.args.iter().map(|f| self.const_expr(f)).collect();
                if parts.is_empty() {
                    format!("PTR(&fc{})", c.func)
                } else {
                    format!(
                        "fwp_pap({}, {}, (V[]){{{}}})",
                        c.func,
                        parts.len(),
                        parts.join(", ")
                    )
                }
            }
            // scalars and strings are handled by `const_expr`
            _ => "0".into(),
        }
    }
}

/// Per-function code generation state.
struct FnGen<'g, 'p> {
    g: &'g mut Gen<'p>,
    out: String,
    tmp: usize,
    label: usize,
    indent: usize,
}

impl<'g, 'p> FnGen<'g, 'p> {
    fn line(&mut self, s: &str) {
        for _ in 0..self.indent {
            self.out.push_str("    ");
        }
        self.out.push_str(s);
        self.out.push('\n');
    }

    fn fresh(&mut self) -> String {
        self.tmp += 1;
        format!("t{}", self.tmp)
    }

    fn bind(&mut self, rhs: String) -> String {
        let t = self.fresh();
        self.line(&format!("V {} = {};", t, rhs));
        t
    }

    fn args(&mut self, args: &[Expr]) -> Vec<String> {
        args.iter().map(|a| self.expr(a)).collect()
    }

    fn array(xs: &[String]) -> String {
        format!("(V[]){{{}}}", xs.join(", "))
    }

    fn expr(&mut self, e: &Expr) -> String {
        match e {
            Expr::Local(i) => format!("l{}", i),
            Expr::Const(v) => self.g.const_expr(v),
            Expr::Func(id) => {
                if self.g.prog.funcs[*id].arity == 0 {
                    self.bind(format!("caf{}()", id))
                } else {
                    self.g.used_closures[*id] = true;
                    format!("PTR(&fc{})", id)
                }
            }
            Expr::Call(id, args) => {
                let xs = self.args(args);
                if self.g.prog.funcs[*id].arity == 0 {
                    self.bind(format!("caf{}()", id))
                } else {
                    self.bind(format!("f{}({})", id, xs.join(", ")))
                }
            }
            Expr::Apply(f, args) => {
                let fv = self.expr(f);
                let xs = self.args(args);
                self.bind(format!(
                    "fwp_apply({}, {}, {})",
                    fv,
                    xs.len(),
                    Self::array(&xs)
                ))
            }
            Expr::Construct(tag, args) => {
                if args.is_empty() {
                    return format!("(V){}", tag);
                }
                let xs = self.args(args);
                self.bind(format!(
                    "fwp_data({}, {}, {})",
                    tag,
                    xs.len(),
                    Self::array(&xs)
                ))
            }
            Expr::Record(args) => {
                if args.is_empty() {
                    return "(V)0".into();
                }
                let xs = self.args(args);
                self.bind(format!("fwp_record({}, {})", xs.len(), Self::array(&xs)))
            }
            Expr::Field(r, i) => {
                let rv = self.expr(r);
                self.bind(format!("OBJ({})->f[{}]", rv, i))
            }
            Expr::SetFields(r, sets) => {
                let rv = self.expr(r);
                let t = self.bind(format!("fwp_data(0, OBJ({rv})->n, OBJ({rv})->f)", rv = rv));
                for (i, x) in sets {
                    let xv = self.expr(x);
                    self.line(&format!("OBJ({})->f[{}] = {};", t, i, xv));
                }
                t
            }
            Expr::Let(l, v, body) => {
                let x = self.expr(v);
                self.line(&format!("l{} = {};", l, x));
                self.expr(body)
            }
            Expr::Match(scrut, arms) => {
                let sv = self.expr(scrut);
                let s = self.bind(sv);
                let r = self.fresh();
                self.line(&format!("V {};", r));
                self.label += 1;
                let done = format!("done{}", self.label);
                for (pat, body) in arms {
                    self.label += 1;
                    let next = format!("next{}", self.label);
                    self.line("{");
                    self.indent += 1;
                    self.pattern(pat, &s, &next);
                    let bv = self.expr(body);
                    self.line(&format!("{} = {};", r, bv));
                    self.line(&format!("goto {};", done));
                    self.indent -= 1;
                    self.line("}");
                    self.line(&format!("{}:;", next));
                }
                self.line("fwp_trap(\"internal: no match arm applies\");");
                self.line(&format!("{}:;", done));
                r
            }
        }
    }

    fn pattern(&mut self, p: &Pat, v: &str, fail: &str) {
        match p {
            Pat::Wild => {}
            Pat::Bind(l) => self.line(&format!("l{} = {};", l, v)),
            Pat::Lit(lit) => {
                let cond = match lit {
                    Value::Str(s) => {
                        let c = self.g.string_const(s.as_bytes());
                        format!("fwp_str_eq({}, {})", v, c)
                    }
                    Value::F32(x) => format!("fwp_f32({}) == fwp_f32((V)0x{:x}U)", v, x.to_bits()),
                    Value::F64(x) => {
                        format!("fwp_f64({}) == fwp_f64((V)0x{:x}ULL)", v, x.to_bits())
                    }
                    Value::I128(x) => format!("fwp_i128({}) == (i128){}", v, x),
                    Value::U128(x) => format!("fwp_u128({}) == (u128){}ULL", v, x),
                    other => {
                        let c = self.g.const_expr(other);
                        format!("{} == {}", v, c)
                    }
                };
                self.line(&format!("if (!({})) goto {};", cond, fail));
            }
            Pat::Construct(tag, ps) => {
                self.line(&format!("if (fwp_tag({}) != {}) goto {};", v, tag, fail));
                for (i, sp) in ps.iter().enumerate() {
                    if !matches!(sp, Pat::Wild) {
                        let fv = format!("OBJ({})->f[{}]", v, i);
                        self.pattern(sp, &fv, fail);
                    }
                }
            }
            Pat::Record(ps) => {
                for (i, sp) in ps.iter().enumerate() {
                    if !matches!(sp, Pat::Wild) {
                        let fv = format!("OBJ({})->f[{}]", v, i);
                        self.pattern(sp, &fv, fail);
                    }
                }
            }
        }
    }
}

impl<'p> Gen<'p> {
    /// Body statements for a primitive instance.
    fn prim(&mut self, func: &Func, sym: &str) -> Result<String, String> {
        let (params, result) = func.ty.params(func.arity as usize);
        let params: Vec<MT> = params.into_iter().cloned().collect();
        let result = result.clone();
        let p = |i: usize| params.get(i).cloned().unwrap_or(MT::unit());
        let nk = |mt: &MT| num_kind(mt).unwrap_or(("K_I64", "?".into(), 0));
        let (rk, rname, rw) = nk(&result);
        let s = match sym {
            "prim.add" | "prim.sub" | "prim.mul" | "prim.div" | "prim.rem" => format!(
                "return fwp_arith({}, {}, l1, l0, {}, {});",
                rk,
                op_code(sym),
                Self::cstr(&rname),
                rw
            ),
            "prim.neg" => format!(
                "return fwp_arith({rk}, OP_SUB, fwp_from_i128({rk}, 0, {n}, {w}), l0, {n}, {w});",
                rk = rk,
                n = Self::cstr(&rname),
                w = rw
            ),
            "prim.zero" | "prim.one" => format!(
                "return fwp_from_i128({}, {}, {}, {});",
                rk,
                if sym == "prim.zero" { 0 } else { 1 },
                Self::cstr(&rname),
                rw
            ),
            "prim.from-int" => format!(
                "return fwp_from_i128({}, (i128)(int64_t)l0, {}, {});",
                rk,
                Self::cstr(&rname),
                rw
            ),
            "prim.from-float" => format!("return fwp_float_of({}, fwp_f64(l0));", rk),
            "trit.from-sign" => {
                "return (V)(int64_t)(((int64_t)l0 > 0) - ((int64_t)l0 < 0));".into()
            }
            "trit.to-int" | "tint.to-int" => "return l0;".into(),
            "tint.of-int" => format!("return fwp_p_tint_of_int(l0, {});", nk(&elem(&result, 0)).2),
            "tint.trits" => format!("return fwp_p_tint_trits(l0, {});", nk(&p(0)).2),
            "tint.from-trits" => format!(
                "return fwp_p_tint_from_trits(l0, {});",
                nk(&elem(&result, 0)).2
            ),
            "trits.pack" => "return fwp_p_trits_pack(l0);".into(),
            "trits.unpack" => "return fwp_p_trits_unpack(l0, l1);".into(),
            "simd.splat" => format!("return fwp_p_simd_splat(l0, {});", vec_shape(&result).0),
            "simd.from-array" => format!(
                "return fwp_p_simd_from_array(l0, {});",
                vec_shape(&elem(&result, 0)).0
            ),
            "simd.add" | "simd.sub" | "simd.mul" | "simd.div" | "simd.min" | "simd.max" => {
                let (k, name, w) = nk(&vec_shape(&p(0)).1);
                let op = match sym {
                    "simd.add" => "OP_ADD",
                    "simd.sub" => "OP_SUB",
                    "simd.mul" => "OP_MUL",
                    "simd.div" => "OP_DIV",
                    "simd.min" => "5",
                    _ => "6",
                };
                format!(
                    "return fwp_p_simd_op({}, {}, l1, l0, {}, {});",
                    k,
                    op,
                    Self::cstr(&name),
                    w
                )
            }
            "simd.sum" => format!(
                "return fwp_p_simd_sum({}, l0, {}, {});",
                rk,
                Self::cstr(&rname),
                rw
            ),
            "wrapping.add" | "wrapping.sub" | "wrapping.mul" => {
                format!("return fwp_wrapping({}, {}, l1, l0);", rk, op_code(sym))
            }
            "saturating.add" | "saturating.sub" | "saturating.mul" => format!(
                "return fwp_saturating({}, {}, l1, l0, {});",
                rk,
                op_code(sym),
                Self::cstr(&rname)
            ),
            "overflowing.add" | "overflowing.sub" | "overflowing.mul" => {
                let (k, _, _) = nk(&p(0));
                format!("return fwp_overflowing({}, {}, l1, l0);", k, op_code(sym))
            }
            "checked.add" | "checked.sub" | "checked.mul" | "checked.div" => {
                let (k, _, _) = nk(&p(0));
                format!("return fwp_checked({}, {}, l1, l0);", k, op_code(sym))
            }
            "bit.and" | "bit.or" | "bit.xor" => {
                let which = match sym {
                    "bit.and" => 0,
                    "bit.or" => 1,
                    _ => 2,
                };
                format!("return fwp_bitop({}, {}, l1, l0);", rk, which)
            }
            "bit.not" => format!("return fwp_bitnot({}, l0);", rk),
            "bit.shl" | "bit.shr" => format!(
                "return fwp_shift({}, {}, (uint32_t)l0, l1);",
                rk,
                (sym == "bit.shl") as u8
            ),
            "int.convert" => {
                let (ks, _, _) = nk(&p(0));
                let (kt, _, _) = nk(&elem(&result, 0));
                format!("return fwp_int_convert({}, {}, l0);", ks, kt)
            }
            "int.to-float" => {
                let (ks, _, _) = nk(&p(0));
                format!("return fwp_int_to_float({}, {}, l0);", ks, rk)
            }
            "float.to-int" => {
                let (ks, _, _) = nk(&p(0));
                let (kt, _, _) = nk(&elem(&result, 0));
                format!("return fwp_float_to_int({}, {}, l0);", ks, kt)
            }
            "float.convert" => {
                let (ks, _, _) = nk(&p(0));
                format!("return fwp_float_of({}, fwp_as_f64({}, l0));", rk, ks)
            }
            "sqrt" | "exp" | "ln" | "sin" | "cos" | "tan" | "floor" | "ceil" | "round" => {
                format!("return fwp_fmath({}, FM_{}, l0);", rk, sym.to_uppercase())
            }
            "pow" => format!(
                "return fwp_float_of({rk}, pow(fwp_as_f64({rk}, l1), fwp_as_f64({rk}, l0)));",
                rk = rk
            ),
            "abs" => format!("return fwp_abs({}, l0, {});", rk, Self::cstr(&rname)),
            "eq" | "ne" => {
                let d = self.desc(&p(0));
                format!(
                    "return fwp_eq(l1, l0, {}) {} 0 ? FWP_TRUE : FWP_FALSE;",
                    d,
                    if sym == "eq" { "!=" } else { "==" }
                )
            }
            "lt" | "le" | "gt" | "ge" => {
                let d = self.desc(&p(0));
                let cond = match sym {
                    "lt" => "c == -1",
                    "le" => "c == -1 || c == 0",
                    "gt" => "c == 1",
                    _ => "c == 1 || c == 0",
                };
                format!(
                    "int c = fwp_partial_cmp(l1, l0, {}); return ({}) ? FWP_TRUE : FWP_FALSE;",
                    d, cond
                )
            }
            "compare" => {
                let d = self.desc(&p(0));
                format!(
                    "int c = fwp_cmp(l1, l0, {}); return c < 0 ? 0 : c == 0 ? 1 : 2;",
                    d
                )
            }
            "min" | "max" => {
                let d = self.desc(&p(0));
                format!(
                    "return fwp_cmp(l1, l0, {}) {} 0 ? l1 : l0;",
                    d,
                    if sym == "min" { "<=" } else { ">=" }
                )
            }
            "hash" => format!("return fwp_hash(l0, {});", self.desc(&p(0))),
            "not" => "return l0 == FWP_TRUE ? FWP_FALSE : FWP_TRUE;".into(),
            "and" => "return (l0 == FWP_TRUE && l1 == FWP_TRUE) ? FWP_TRUE : FWP_FALSE;".into(),
            "or" => "return (l0 == FWP_TRUE || l1 == FWP_TRUE) ? FWP_TRUE : FWP_FALSE;".into(),
            "show" => format!("return fwp_show(l0, {});", self.desc(&p(0))),
            "format" => format!("return fwp_p_format(l0, l1, {});", self.desc(&p(1))),
            "fail" => format!("fwp_fail(l0, {}); return 0;", self.desc(&p(0))),
            "sort" => format!("return fwp_p_sort(l0, {});", self.desc(&elem(&p(0), 0))),
            "sort-by" => {
                let key = match p(0) {
                    MT::Fun(_, k) => *k,
                    _ => MT::unit(),
                };
                format!("return fwp_p_sort_by(l0, l1, {});", self.desc(&key))
            }
            "index-of" => format!("return fwp_p_index_of(l0, l1, {});", self.desc(&p(0))),
            "unique" => format!("return fwp_p_unique(l0, {});", self.desc(&elem(&p(0), 0))),
            "array.sort" => format!(
                "return fwp_p_array_sort(l0, {});",
                self.desc(&elem(&p(0), 0))
            ),
            "range" => {
                let (k, _, _) = nk(&p(0));
                format!("return fwp_p_range({}, l0, l1);", k)
            }
            "parse-int" => {
                let (k, _, w) = nk(&elem(&result, 0));
                format!("return fwp_p_parse_int(l0, {}, {});", k, w)
            }
            "parse-float" => {
                let (k, _, _) = nk(&elem(&result, 0));
                format!("return fwp_p_parse_float(l0, {});", k)
            }
            "map.insert" => format!("return fwp_p_map_insert(l0, l1, l2, {});", self.desc(&p(0))),
            "map.get" => format!("return fwp_p_map_get(l0, l1, {});", self.desc(&p(0))),
            "map.remove" | "set.remove" => {
                format!("return fwp_p_map_remove(l0, l1, {});", self.desc(&p(0)))
            }
            "map.contains" | "set.contains" => {
                format!("return fwp_p_map_contains(l0, l1, {});", self.desc(&p(0)))
            }
            "map.from-list" => {
                let kt = match elem(&p(0), 0) {
                    MT::Record(fs) if !fs.is_empty() => fs[0].1.clone(),
                    _ => MT::unit(),
                };
                format!("return fwp_p_map_from_list(l0, {});", self.desc(&kt))
            }
            "map.update" => format!(
                "return fwp_p_map_update(l0, l1, l2, l3, {});",
                self.desc(&p(0))
            ),
            "set.insert" => format!("return fwp_p_set_insert(l0, l1, {});", self.desc(&p(0))),
            "set.from-list" => {
                format!(
                    "return fwp_p_set_from_list(l0, {});",
                    self.desc(&elem(&p(0), 0))
                )
            }
            "set.union" | "set.intersect" | "set.diff" => {
                let op = match sym {
                    "set.union" => 0,
                    "set.intersect" => 1,
                    _ => 2,
                };
                format!(
                    "return fwp_p_set_op(l0, l1, {}, {});",
                    op,
                    self.desc(&elem(&p(0), 0))
                )
            }
            "file.open" | "file.create" | "file.read-all" | "file.write" | "file.with"
            | "file.read" | "file.write-new" => {
                let err = self.desc(&MT::con("std::IoError"));
                match sym {
                    "file.open" => format!("return fwp_p_file_open(l0, 0, {});", err),
                    "file.create" => format!("return fwp_p_file_open(l0, 1, {});", err),
                    "file.read-all" => format!("return fwp_p_file_read_all(l0, {});", err),
                    "file.write" => format!("return fwp_p_file_write(l0, l1, {});", err),
                    "file.with" => format!("return fwp_p_file_with(l0, l1, {});", err),
                    "file.read" => format!("return fwp_p_file_read(l0, {});", err),
                    _ => format!("return fwp_p_file_write_new(l0, l1, {});", err),
                }
            }
            "tcp.listen" | "tcp.accept" | "tcp.accept-for" | "tcp.connect" | "tcp.read"
            | "tcp.read-for" | "tcp.write" | "udp.bind" | "udp.send-to" | "udp.recv-from"
            | "dns.resolve" => {
                let err = self.desc(&MT::con("std::IoError"));
                let (f, n) = match sym {
                    "tcp.listen" => ("fwp_p_tcp_listen", 1),
                    "tcp.accept" => ("fwp_p_tcp_accept", 1),
                    "tcp.accept-for" => ("fwp_p_tcp_accept_for", 2),
                    "tcp.connect" => ("fwp_p_tcp_connect", 1),
                    "tcp.read" => ("fwp_p_tcp_read", 2),
                    "tcp.read-for" => ("fwp_p_tcp_read_for", 3),
                    "tcp.write" => ("fwp_p_tcp_write", 2),
                    "udp.bind" => ("fwp_p_udp_bind", 1),
                    "udp.send-to" => ("fwp_p_udp_send_to", 3),
                    "udp.recv-from" => ("fwp_p_udp_recv_from", 2),
                    _ => ("fwp_p_dns_resolve", 1),
                };
                let args: Vec<String> = (0..n).map(|i| format!("l{}", i)).collect();
                format!("return {}({}, {});", f, args.join(", "), err)
            }
            _ => {
                let simple: &[(&str, &str)] = &[
                    ("map", "fwp_p_map(l0, l1)"),
                    ("filter", "fwp_p_filter(l0, l1)"),
                    ("fold", "fwp_p_fold(l0, l1, l2)"),
                    ("fold-right", "fwp_p_fold_right(l0, l1, l2)"),
                    ("length", "fwp_p_length(l0)"),
                    ("reverse", "fwp_p_reverse(l0)"),
                    ("append", "fwp_p_append(l0, l1)"),
                    ("flatten", "fwp_p_flatten(l0)"),
                    ("take", "fwp_p_take(l0, l1)"),
                    ("drop", "fwp_p_drop(l0, l1)"),
                    ("take-while", "fwp_p_take_while(l0, l1)"),
                    ("drop-while", "fwp_p_drop_while(l0, l1)"),
                    ("zip", "fwp_p_zip(l0, l1)"),
                    ("zip-with", "fwp_p_zip_with(l0, l1, l2)"),
                    ("unzip", "fwp_p_unzip(l0)"),
                    ("repeat", "fwp_p_repeat(l0, l1)"),
                    ("nth", "fwp_p_nth(l0, l1)"),
                    ("find", "fwp_p_find(l0, l1)"),
                    ("scan", "fwp_p_scan(l0, l1, l2)"),
                    ("chunks", "fwp_p_chunks(l0, l1)"),
                    ("iterate", "fwp_p_iterate(l0, l1, l2)"),
                    ("list.flat-map", "fwp_p_flat_map(l0, l1)"),
                    ("list.ap", "fwp_p_list_ap(l0, l1)"),
                    ("trim", "fwp_p_trim_impl(l0, 1, 1)"),
                    ("trim-start", "fwp_p_trim_impl(l0, 1, 0)"),
                    ("trim-end", "fwp_p_trim_impl(l0, 0, 1)"),
                    ("lower", "fwp_p_case(l0, 0)"),
                    ("upper", "fwp_p_case(l0, 1)"),
                    ("concat", "fwp_p_concat(l0, l1)"),
                    (
                        "string.length",
                        "(V)(int64_t)fwp_utf8_count(STR(l0)->d, STR(l0)->len)",
                    ),
                    ("string.byte-length", "(V)(int64_t)STR(l0)->len"),
                    ("string.chars", "fwp_p_chars(l0)"),
                    ("split", "fwp_p_split(l0, l1)"),
                    ("join", "fwp_p_join(l0, l1)"),
                    ("lines", "fwp_p_lines(l0)"),
                    ("words", "fwp_p_words(l0)"),
                    ("string.contains", "fwp_p_str_contains(l0, l1)"),
                    ("starts-with", "fwp_p_starts_with(l0, l1)"),
                    ("ends-with", "fwp_p_ends_with(l0, l1)"),
                    ("replace", "fwp_p_replace(l0, l1, l2)"),
                    ("string.repeat", "fwp_p_str_repeat(l0, l1)"),
                    ("string.reverse", "fwp_p_str_reverse(l0)"),
                    ("string.slice", "fwp_p_str_slice(l0, l1, l2)"),
                    ("string.find", "fwp_p_str_find(l0, l1)"),
                    ("pad-left", "fwp_p_pad(l0, l1, l2, 1)"),
                    ("pad-right", "fwp_p_pad(l0, l1, l2, 0)"),
                    ("string.codepoints", "fwp_p_codepoints(l0)"),
                    ("string.from-codepoints", "fwp_p_from_codepoints(l0)"),
                    ("string.to-bytes", "l0"),
                    ("string.from-bytes", "fwp_p_from_bytes(l0)"),
                    ("array.from-list", "fwp_p_array_from_list(l0)"),
                    ("array.to-list", "fwp_p_array_to_list(l0)"),
                    ("array.length", "(V)(int64_t)ARR(l0)->len"),
                    ("array.get", "fwp_p_array_get(l0, l1)"),
                    ("array.set", "fwp_p_array_set(l0, l1, l2)"),
                    ("array.push", "fwp_p_array_push(l0, l1)"),
                    ("array.make", "fwp_p_array_make(l0, l1)"),
                    ("array.generate", "fwp_p_array_generate(l0, l1)"),
                    ("array.map", "fwp_p_array_map(l0, l1)"),
                    ("array.fold", "fwp_p_array_fold(l0, l1, l2)"),
                    ("array.slice", "fwp_p_array_slice(l0, l1, l2)"),
                    ("array.append", "fwp_p_array_append(l0, l1)"),
                    ("map.empty", "FWP_EMPTY_MAP"),
                    ("set.empty", "FWP_EMPTY_MAP"),
                    ("map.size", "fwp_p_map_size(l0)"),
                    ("set.size", "fwp_p_map_size(l0)"),
                    ("map.keys", "fwp_p_map_column(l0, 0)"),
                    ("set.to-list", "fwp_p_map_column(l0, 0)"),
                    ("map.values", "fwp_p_map_column(l0, 1)"),
                    ("map.to-list", "fwp_p_map_to_list(l0)"),
                    ("map.map-values", "fwp_p_map_map_values(l0, l1)"),
                    ("bytes.from-list", "fwp_p_bytes_from_list(l0)"),
                    ("bytes.to-list", "fwp_p_bytes_to_list(l0)"),
                    ("bytes.length", "(V)(int64_t)STR(l0)->len"),
                    ("bytes.get", "fwp_p_bytes_get(l0, l1)"),
                    ("bytes.slice", "fwp_p_bytes_slice(l0, l1, l2)"),
                    ("bytes.append", "fwp_p_concat(l0, l1)"),
                    ("print", "fwp_p_print(l0)"),
                    ("linalg.lu-solve", "fwp_p_lu_solve(l0, l1, l2)"),
                    ("linalg.det", "fwp_p_det(l0, l1)"),
                    ("linalg.inverse", "fwp_p_inverse(l0, l1)"),
                    ("linalg.cholesky", "fwp_p_cholesky(l0, l1)"),
                    ("linalg.qr", "fwp_p_qr(l0, l1, l2)"),
                    ("linalg.cg", "fwp_p_cg(l0, l1, l2, l3, l4)"),
                    ("list.transpose", "fwp_p_list_transpose(l0)"),
                    ("syntax.show", "fwp_p_syntax_show(l0)"),
                    ("write", "fwp_p_write(l0)"),
                    ("eprint", "fwp_p_eprint(l0)"),
                    ("read-line", "fwp_p_read_line()"),
                    ("read-all", "fwp_read_stdin_all()"),
                    ("read-lines", "fwp_p_read_lines()"),
                    ("args", "fwp_p_args()"),
                    ("exit", "fwp_p_exit(l0)"),
                    ("env.get", "fwp_p_env_get(l0)"),
                    ("time.monotonic", "fwp_p_time_monotonic()"),
                    ("time.unix", "fwp_p_time_unix()"),
                    ("random.u64", "fwp_p_random_u64()"),
                    ("random.f64", "fwp_p_random_f64()"),
                    ("attempt", "fwp_p_attempt(l0, l1)"),
                    ("get", "fwp_p_get()"),
                    ("put", "fwp_p_put(l0)"),
                    ("modify", "fwp_p_modify(l0)"),
                    ("run-state", "fwp_p_run_state(l0, l1, l2)"),
                    ("file.close", "fwp_p_file_close(l0)"),
                    ("loop", "fwp_p_loop(l0, l1)"),
                    ("json.parse", "fwp_p_json_parse(l0)"),
                    ("json.encode", "fwp_p_json_encode(l0)"),
                    ("string.split-once", "fwp_p_split_once(l0, l1)"),
                    ("bytes.find", "fwp_p_bytes_find(l0, l1)"),
                    ("url.encode", "fwp_p_url_encode(l0)"),
                    ("url.decode", "fwp_p_url_decode(l0, 0)"),
                    ("form.decode", "fwp_p_url_decode(l0, 1)"),
                    ("url.split", "fwp_p_url_split(l0)"),
                    ("http.parse-request-head", "fwp_p_parse_request_head(l0)"),
                    ("http.parse-response-head", "fwp_p_parse_response_head(l0)"),
                    ("int.to-hex", "fwp_p_to_hex(l0)"),
                    ("int.parse-hex", "fwp_p_parse_hex(l0)"),
                    ("task.spawn", "fwp_p_task_spawn(l0)"),
                    ("task.await", "fwp_p_task_await(l0)"),
                    ("task.cancel", "fwp_p_task_cancel(l0)"),
                    ("task.within", "fwp_p_task_within(l0, l1)"),
                    ("task.sleep", "fwp_p_task_sleep(l0)"),
                    ("task.yield", "fwp_p_task_yield()"),
                    ("task.deadline", "fwp_p_task_deadline(l0, l1)"),
                    ("task.cancelled", "fwp_p_task_cancelled()"),
                    ("task.scope", "fwp_p_task_scope(l0)"),
                    ("channel.make", "fwp_p_channel_make(l0)"),
                    ("channel.send", "fwp_p_channel_send(l0, l1)"),
                    ("channel.recv", "fwp_p_channel_recv(l0)"),
                    ("channel.recv-for", "fwp_p_channel_recv_for(l0, l1)"),
                    ("channel.close", "fwp_p_channel_close(l0)"),
                    ("tcp.local-addr", "fwp_p_local_addr(l0)"),
                    ("tcp.peer-addr", "fwp_p_peer_addr(l0)"),
                    ("tcp.stop", "fwp_p_tcp_stop(l0)"),
                    ("tcp.close", "fwp_p_sock_close(l0)"),
                    ("udp.local-addr", "fwp_p_local_addr(l0)"),
                    ("udp.close", "fwp_p_sock_close(l0)"),
                    ("signal.shutdown-requested", "fwp_p_shutdown_requested()"),
                    ("signal.request-shutdown", "fwp_p_request_shutdown()"),
                    ("metrics.add", "fwp_p_metrics_update(0, l0, l1)"),
                    ("metrics.set", "fwp_p_metrics_update(1, l0, l1)"),
                    ("metrics.observe", "fwp_p_metrics_update(2, l0, l1)"),
                    ("metrics.snapshot", "fwp_p_metrics_snapshot()"),
                ];
                match simple.iter().find(|(n, _)| *n == sym) {
                    Some((_, c)) => format!("return {};", c),
                    None => {
                        return Err(format!(
                            "primitive `{}` is not supported by the native backend",
                            sym
                        ))
                    }
                }
            }
        };
        Ok(s)
    }

    fn func(&mut self, id: FuncId) -> Result<String, String> {
        let f = &self.prog.funcs[id];
        let params: Vec<String> = (0..f.arity).map(|i| format!("V l{}", i)).collect();
        let sig = format!(
            "static V f{}({})",
            id,
            if params.is_empty() {
                "void".into()
            } else {
                params.join(", ")
            }
        );
        let mut out = format!("/* {} : {} */\n{} {{\n", f.name, f.ty, sig);
        for i in f.arity..f.nlocals {
            let _ = writeln!(out, "    V l{} = 0;", i);
        }
        match &f.body {
            Body::Prim(sym) => {
                let sym = sym.clone();
                let func = f.clone();
                let s = self.prim(&func, &sym)?;
                let _ = writeln!(out, "    {}", s);
            }
            Body::Ctor(tag) => {
                let args: Vec<String> = (0..f.arity).map(|i| format!("l{}", i)).collect();
                if args.is_empty() {
                    let _ = writeln!(out, "    return (V){};", tag);
                } else {
                    let _ = writeln!(
                        out,
                        "    return fwp_data({}, {}, (V[]){{{}}});",
                        tag,
                        args.len(),
                        args.join(", ")
                    );
                }
            }
            Body::Expr(e) => {
                let e = e.clone();
                let mut fg = FnGen {
                    g: self,
                    out: String::new(),
                    tmp: 0,
                    label: 0,
                    indent: 1,
                };
                let r = fg.expr(&e);
                let body = fg.out;
                out.push_str(&body);
                let _ = writeln!(out, "    return {};", r);
            }
        }
        out.push_str("}\n");
        Ok(out)
    }
}

/// What the generated executable runs.
enum Mode<'a> {
    Main,
    Tests,
    /// An exported function as a standalone executable.
    Exec(FuncId, &'a str),
}

/// Generate the complete C program running `main`.
pub fn generate(prog: &Program) -> Result<String, String> {
    if prog.main.is_none() {
        return Err("no `main` binding to compile".into());
    }
    generate_mode(prog, Mode::Main)
}

/// Generate a C program that runs the program's tests.
pub fn generate_tests(prog: &Program) -> Result<String, String> {
    generate_mode(prog, Mode::Tests)
}

/// Generate a standalone executable for an exported function.
pub fn generate_exec(prog: &Program, fid: FuncId, name: &str) -> Result<String, String> {
    generate_mode(prog, Mode::Exec(fid, name))
}

fn bytes_literal(b: &[u8]) -> String {
    let parts: Vec<String> = b.iter().map(|x| x.to_string()).collect();
    format!(
        "{{{}}}",
        if parts.is_empty() {
            "0".into()
        } else {
            parts.join(", ")
        }
    )
}

fn generate_mode(prog: &Program, mode: Mode) -> Result<String, String> {
    let tests = matches!(mode, Mode::Tests);
    let main = prog.main.unwrap_or(0);
    let mut g = Gen {
        prog,
        descs: HashMap::new(),
        desc_defs: Vec::new(),
        strings: HashMap::new(),
        string_defs: Vec::new(),
        consts: Vec::new(),
        const_init: String::new(),
        used_closures: vec![false; prog.funcs.len()],
    };
    let mut bodies = String::new();
    for id in 0..prog.funcs.len() {
        bodies.push_str(&g.func(id)?);
        bodies.push('\n');
    }
    let main_ty = match mode {
        Mode::Main => prog.funcs[main].ty.clone(),
        _ => MT::unit(),
    };
    // exec mode: descriptors and protocol data for the function's interface
    let mut exec_defs = String::new();
    if let Mode::Exec(fid, name) = &mode {
        let f = &prog.funcs[*fid];
        let n = f.arity as usize;
        let (params, result) = f.ty.params(n);
        let params: Vec<MT> = params.into_iter().cloned().collect();
        let result = result.clone();
        let list_elem = |t: &MT| match t {
            MT::Con(n, a) if n == "std::List" => a.first().cloned(),
            _ => None,
        };
        let out_elem = list_elem(&result).unwrap_or_else(|| result.clone());
        let last = params.last().cloned().unwrap_or(MT::unit());
        let in_elem = list_elem(&last).unwrap_or_else(|| last.clone());
        let pd: Vec<String> = params.iter().map(|p| g.desc(p)).collect();
        let pn: Vec<String> = params
            .iter()
            .map(|p| c_string_literal(p.to_string().as_bytes()))
            .collect();
        let rd = g.desc(&result);
        let od = g.desc(&out_elem);
        let idd = g.desc(&in_elem);
        let header = crate::proto::header(&out_elem, prog);
        let fp = crate::proto::fingerprint(&crate::proto::canonical_type(&in_elem, prog));
        let usage = crate::exec::usage(name, &params);
        let _ = write!(
            exec_defs,
            r#"
static const fwp_desc *const exec_params[] = {{{pd}}};
static const char *const exec_param_names[] = {{{pn}}};
static const unsigned char exec_out_header[] = {header};
static const unsigned char exec_in_fp[16] = {fp};
static V caf_exec_entry(void) {{ return {entry}; }}
static const fwp_exec_spec exec_spec = {{
    {name}, {usage}, {fid}, {arity}, exec_params, exec_param_names, {rd}, {rlist},
    {od}, exec_out_header, sizeof exec_out_header, {llist}, {idd}, {itype}, exec_in_fp}};
"#,
            pd = if pd.is_empty() {
                "0".into()
            } else {
                pd.join(", ")
            },
            pn = if pn.is_empty() {
                "0".into()
            } else {
                pn.join(", ")
            },
            header = bytes_literal(&header),
            fp = bytes_literal(&fp),
            entry = if n == 0 {
                format!("caf{}()", fid)
            } else {
                "0".into()
            },
            name = c_string_literal(name.as_bytes()),
            usage = c_string_literal(usage.as_bytes()),
            fid = fid,
            arity = n,
            rd = rd,
            rlist = list_elem(&result).is_some() as u8,
            od = od,
            llist = list_elem(&last).is_some() as u8,
            idd = idd,
            itype = c_string_literal(in_elem.to_string().as_bytes()),
        );
    } else {
        exec_defs.push_str("static V caf_exec_entry(void) { return 0; }\n");
    }
    let main_desc = g.desc(&main_ty);
    // IoError is always available for uncaught IO failures.
    g.desc(&MT::con("std::IoError"));

    let mut out = String::new();
    out.push_str("/* Generated by fwp. */\n");
    for part in RUNTIME {
        out.push_str(part);
        out.push('\n');
    }
    out.push_str("\n/* ---- program ---- */\n\n");
    // tentative declarations, so descriptors can refer to each other
    for i in 0..g.desc_defs.len() {
        let _ = writeln!(out, "static fwp_desc d{};", i);
    }
    for d in &g.desc_defs {
        out.push_str(d);
        out.push('\n');
    }
    for s in &g.string_defs {
        out.push_str(s);
        out.push('\n');
    }
    for c in &g.consts {
        out.push_str(c);
        out.push('\n');
    }
    // prototypes
    for (id, f) in prog.funcs.iter().enumerate() {
        let params: Vec<String> = (0..f.arity).map(|i| format!("V l{}", i)).collect();
        let _ = writeln!(
            out,
            "static V f{}({});",
            id,
            if params.is_empty() {
                "void".into()
            } else {
                params.join(", ")
            }
        );
    }
    // constant applicative forms
    for (id, f) in prog.funcs.iter().enumerate() {
        if f.arity == 0 {
            let _ = writeln!(
                out,
                "static V caf{id}(void) {{ static int st = 0; static V v; if (st == 0) {{ v = f{id}(); st = 1; }} return v; }}",
                id = id
            );
        }
    }
    // entries and the function table
    for (id, f) in prog.funcs.iter().enumerate() {
        if f.arity > 0 {
            let args: Vec<String> = (0..f.arity).map(|i| format!("a[{}]", i)).collect();
            let _ = writeln!(
                out,
                "static V e{}(V *a) {{ return f{}({}); }}",
                id,
                id,
                args.join(", ")
            );
        }
    }
    out.push_str("static const fwp_fninfo fwp_fn_table[] = {\n");
    for (id, f) in prog.funcs.iter().enumerate() {
        let entry = if f.arity > 0 {
            format!("e{}", id)
        } else {
            "0".into()
        };
        let _ = writeln!(
            out,
            "    {{{}, {}, {}}},",
            f.arity,
            entry,
            c_string_literal(f.name.as_bytes())
        );
    }
    out.push_str("};\n");
    for (id, used) in g.used_closures.iter().enumerate() {
        if *used {
            let _ = writeln!(out, "static fwp_clo fc{} = {{{}, 0}};", id, id);
        }
    }
    out.push('\n');
    out.push_str(&bodies);
    let exit_code = matches!(&main_ty, MT::Con(n, _) if n == "std::I32");
    out.push_str(&exec_defs);
    let run = if let Mode::Exec(..) = mode {
        "    fwp_exit_code = fwp_exec(&exec_spec, fwp_argc, fwp_argv);".to_string()
    } else if tests {
        let mut r = String::from("    int pass = 0, fail = 0;\n");
        for (name, id) in &prog.tests {
            let _ = write!(
                r,
                r#"    {{
        fwp_handler h; h.prev = fwp_handlers; h.state_depth = fwp_state_len; fwp_handlers = &h;
        if (setjmp(h.jb) == 0) {{
            V v = caf{id}();
            fwp_handlers = h.prev;
            fwp_tasks_finish();
            if (v == FWP_TRUE) {{ pass++; printf("test %s ... ok\n", {name}); }}
            else {{ fail++; printf("test %s ... FAILED\n", {name}); }}
        }} else {{
            fwp_handlers = h.prev; fwp_state_len = h.state_depth; fail++;
            fwp_tasks_abort();
            fwp_buf b = {{0}}; fwp_write(&b, h.value, h.desc, 1);
            printf("test %s ... FAILED (error: %s)\n", {name}, b.d ? b.d : "");
        }}
    }}
"#,
                id = id,
                name = c_string_literal(name.as_bytes())
            );
        }
        r.push_str("    printf(\"\\n%d passed, %d failed\\n\", pass, fail);\n    fwp_exit_code = fail ? 1 : 0;");
        r
    } else {
        format!(
            "    V r = caf{}();\n    fwp_tasks_finish();\n    (void){};\n    fwp_exit_code = {};",
            main,
            main_desc,
            if exit_code {
                "(int)(int32_t)r"
            } else {
                "((void)r, 0)"
            }
        )
    };
    let _ = write!(
        out,
        r#"
static void fwp_init_consts(void) {{
{init}}}

static int fwp_exit_code = 0;

static void *fwp_main_thread(void *arg) {{
    (void)arg;
    fwp_init_consts();
{run}
    fflush(stdout);
    return 0;
}}

int main(int argc, char **argv) {{
    fwp_fns = fwp_fn_table;
    fwp_prog_out = stdout;
    fwp_argc = argc;
    fwp_argv = argv;
    clock_gettime(CLOCK_MONOTONIC, &fwp_start_time);
    fwp_seed_rng();
    setvbuf(stdout, 0, _IOFBF, 1 << 16);
    signal(SIGPIPE, SIG_IGN);
    pthread_attr_t attr;
    pthread_attr_init(&attr);
    pthread_attr_setstacksize(&attr, (size_t)1 << 30);
    pthread_t t;
    if (pthread_create(&t, &attr, fwp_main_thread, 0) != 0) fwp_main_thread(0);
    else pthread_join(t, 0);
    fflush(stdout);
    return fwp_exit_code;
}}
"#,
        init = g.const_init,
        run = run
    );
    Ok(out)
}

/// Compile C source to an executable with the system C compiler.
pub fn compile_c(c_source: &str, output: &std::path::Path, opt: &str) -> Result<(), String> {
    let dir = std::env::temp_dir().join(format!("fwp-build-{}", std::process::id()));
    std::fs::create_dir_all(&dir).map_err(|e| e.to_string())?;
    let c_path = dir.join(format!(
        "{}.c",
        output
            .file_name()
            .map(|s| s.to_string_lossy().to_string())
            .unwrap_or("out".into())
    ));
    std::fs::write(&c_path, c_source).map_err(|e| e.to_string())?;
    let cc = std::env::var("CC").unwrap_or_else(|_| "cc".into());
    let res = std::process::Command::new(&cc)
        .arg(opt)
        .arg("-std=gnu11")
        // no fused multiply-add: results must match the interpreter exactly
        .arg("-ffp-contract=off")
        .arg("-w")
        .arg("-o")
        .arg(output)
        .arg(&c_path)
        .arg("-lm")
        .arg("-lpthread")
        .output()
        .map_err(|e| format!("cannot run C compiler `{}`: {}", cc, e))?;
    let _ = std::fs::remove_file(&c_path);
    if !res.status.success() {
        return Err(format!(
            "C compiler failed:\n{}",
            String::from_utf8_lossy(&res.stderr)
        ));
    }
    Ok(())
}
