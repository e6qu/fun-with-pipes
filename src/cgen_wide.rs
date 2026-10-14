//! Native scalar workers for closed wide numeric expressions. Generic entries
//! keep word values; proven worker-to-worker paths keep full-width native bits.
use crate::ir::{type_of, Body, Expr, FuncId, Pat, Program, MT};
use crate::value::Value;
use std::fmt::Write;

#[derive(Clone, Copy, PartialEq, Eq)]
pub(super) enum Kind {
    I128,
    U128,
    F128,
    I64,
    U64,
    Bool,
    Unit,
}
impl Kind {
    pub(super) fn of(ty: &MT) -> Option<Self> {
        if *ty == MT::unit() {
            return Some(Self::Unit);
        }
        let MT::Con(name, _) = ty else { return None };
        Some(match name.as_str() {
            "std::I128" => Self::I128,
            "std::U128" => Self::U128,
            "std::F128" => Self::F128,
            "std::I64" => Self::I64,
            "std::U64" => Self::U64,
            "std::Bool" => Self::Bool,
            _ => return None,
        })
    }
    pub(super) fn wide(self) -> bool {
        matches!(self, Self::I128 | Self::U128 | Self::F128)
    }
    pub(super) fn c(self) -> &'static str {
        match self {
            Self::I128 => "i128",
            Self::U128 => "u128",
            Self::F128 => "float128_t",
            Self::I64 => "int64_t",
            Self::U64 | Self::Bool | Self::Unit => "uint64_t",
        }
    }
    pub(super) fn unbox(self, word: &str) -> String {
        if self == Self::F128 {
            format!("fwp_f128({word})")
        } else if self.wide() {
            format!("fwp_{}({word})", self.c())
        } else {
            format!("({})({word})", self.c())
        }
    }
    pub(super) fn boxed(self, value: &str) -> String {
        if self == Self::F128 {
            format!("fwp_box_f128({value})")
        } else if self.wide() {
            format!("fwp_box_{}({value})", self.c())
        } else {
            format!("(V)({value})")
        }
    }
}

pub(super) fn signature(program: &Program, id: FuncId) -> String {
    let f = &program.funcs[id];
    let (args, result) = f.ty.params(f.arity as usize);
    let args = args
        .iter()
        .enumerate()
        .map(|(i, t)| format!("{} l{i}", Kind::of(t).unwrap().c()))
        .collect::<Vec<_>>()
        .join(", ");
    format!(
        "static {} fwp_wide{id}({args})",
        Kind::of(result).unwrap().c()
    )
}

struct Emitter<'a> {
    program: &'a Program,
    enabled: &'a [bool],
    locals: &'a [MT],
    output: String,
    next: usize,
}
impl Emitter<'_> {
    fn temporary(&mut self, kind: Kind, value: &str) -> String {
        let name = format!("w{}", self.next);
        self.next += 1;
        let value = if kind == Kind::F128 && value == "0" {
            "{{0, 0}}"
        } else {
            value
        };
        writeln!(self.output, "    {} {name} = {value};", kind.c()).unwrap();
        name
    }
    fn kind(&self, e: &Expr) -> Option<Kind> {
        type_of(
            &|id| &self.program.funcs[id].ty,
            &self.program.shapes,
            self.locals,
            e,
        )
        .as_ref()
        .and_then(Kind::of)
    }
    fn constant(value: &Value, kind: Kind) -> Option<String> {
        Some(match value {
            Value::I128(n) => format!(
                "(i128)(((u128){}ULL << 64) | {}ULL)",
                (*n as u128 >> 64) as u64,
                *n as u64
            ),
            Value::U128(n) => format!("((u128){}ULL << 64) | {}ULL", (n >> 64) as u64, *n as u64),
            Value::F128(n) => format!(
                "(float128_t){{{{{}ULL, {}ULL}}}}",
                n.to_bits() as u64,
                (n.to_bits() >> 64) as u64
            ),
            Value::I64(n) => format!("(int64_t){}ULL", *n as u64),
            Value::U64(n) => format!("{}ULL", n),
            Value::Data(tag, fields) if fields.is_empty() && kind == Kind::Bool => tag.to_string(),
            Value::Record(fields) if fields.is_empty() && kind == Kind::Unit => "0".into(),
            _ => return None,
        })
    }
    fn expression(&mut self, e: &Expr, kind: Kind) -> Option<String> {
        match e {
            Expr::Local(l) if Kind::of(&self.locals[*l as usize]) == Some(kind) => {
                Some(format!("l{l}"))
            }
            Expr::Const(v) => Self::constant(v, kind),
            Expr::Construct(tag, fields) if fields.is_empty() && kind == Kind::Bool => {
                Some(tag.to_string())
            }
            Expr::Record(fields) if fields.is_empty() && kind == Kind::Unit => Some("0".into()),
            Expr::Let(l, value, body) => {
                let ty = Kind::of(&self.locals[*l as usize])?;
                let value = self.expression(value, ty)?;
                writeln!(self.output, "    l{l} = {value};").unwrap();
                self.expression(body, kind)
            }
            Expr::Call(id, args) => {
                let f = &self.program.funcs[*id];
                let (params, result) = f.ty.params(args.len());
                if Kind::of(result)? != kind || args.len() != f.arity as usize {
                    return None;
                }
                let mut values = Vec::new();
                let mut kinds = Vec::new();
                // Separate temporaries preserve argument and checked-trap order.
                for (arg, ty) in args.iter().zip(params) {
                    let k = Kind::of(ty)?;
                    let value = self.expression(arg, k)?;
                    values.push(self.temporary(k, &value));
                    kinds.push(k);
                }
                let call = if let Body::Prim(symbol) = &f.body {
                    self.primitive(*id, symbol, &values, &kinds, kind)?
                } else if self.enabled[*id] {
                    format!("fwp_wide{id}({})", values.join(", "))
                } else {
                    return None;
                };
                Some(self.temporary(kind, &call))
            }
            Expr::Match(scrutinee, arms) => {
                let sk = self.kind(scrutinee).or_else(|| {
                    arms.iter()
                        .all(|(p, _)| matches!(p, Pat::Wild | Pat::Construct(0..=1, _)))
                        .then_some(Kind::Bool)
                })?;
                let value = self.expression(scrutinee, sk)?;
                let value = self.temporary(sk, &value);
                let result = self.temporary(kind, "0");
                for (i, (pattern, body)) in arms.iter().enumerate() {
                    let condition = match pattern {
                        Pat::Wild | Pat::Bind(_) => "1".into(),
                        Pat::Construct(tag, fields) if fields.is_empty() && sk == Kind::Bool => {
                            format!("{value} == {tag}")
                        }
                        Pat::Lit(v) if sk == Kind::F128 => {
                            format!("fwp_f128_compare({value}, {}) == 0", Self::constant(v, sk)?)
                        }
                        Pat::Lit(v) => format!("{value} == ({})", Self::constant(v, sk)?),
                        _ => return None,
                    };
                    writeln!(
                        self.output,
                        "    {}if ({condition}) {{",
                        if i == 0 { "" } else { "else " }
                    )
                    .unwrap();
                    if let Pat::Bind(l) = pattern {
                        if Kind::of(&self.locals[*l as usize]) != Some(sk) {
                            return None;
                        }
                        writeln!(self.output, "    l{l} = {value};").unwrap();
                    }
                    let v = self.expression(body, kind)?;
                    writeln!(self.output, "    {result} = {v};\n    }}").unwrap();
                }
                self.output
                    .push_str("    else fwp_trap(\"internal: no match arm applies\");\n");
                Some(result)
            }
            Expr::Dup(_, body) | Expr::Drop(_, body) => self.expression(body, kind),
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } if parameters.is_empty() && bindings.is_empty() => self.expression(body, kind),
            _ => None,
        }
    }
    fn primitive(
        &mut self,
        id: FuncId,
        sym: &str,
        v: &[String],
        ks: &[Kind],
        result: Kind,
    ) -> Option<String> {
        if result == Kind::F128 || ks.contains(&Kind::F128) {
            return self.quad_primitive(sym, v, ks, result);
        }
        if !ks.iter().any(|k| k.wide()) && !result.wide() {
            if !matches!(
                sym,
                "prim.add"
                    | "prim.sub"
                    | "prim.mul"
                    | "prim.div"
                    | "prim.rem"
                    | "prim.neg"
                    | "prim.zero"
                    | "prim.one"
                    | "eq"
                    | "ne"
                    | "lt"
                    | "le"
                    | "gt"
                    | "ge"
                    | "min"
                    | "max"
                    | "abs"
            ) {
                return None;
            }
            return Some(format!(
                "({})f{id}({})",
                result.c(),
                v.iter()
                    .map(|v| format!("(V)({v})"))
                    .collect::<Vec<_>>()
                    .join(", ")
            ));
        }
        if matches!(sym, "prim.zero" | "prim.one") && v.is_empty() {
            return Some(if sym == "prim.one" { "1" } else { "0" }.into());
        }
        if v.len() == 2 && ks[0] == ks[1] && ks[0].wide() {
            let (x, y) = (&v[1], &v[0]);
            let k = ks[0];
            let operator = match sym {
                "eq" => Some("=="),
                "ne" => Some("!="),
                "lt" => Some("<"),
                "le" => Some("<="),
                "gt" => Some(">"),
                "ge" => Some(">="),
                _ => None,
            };
            if let Some(op) = operator {
                return Some(format!("({x} {op} {y})"));
            }
            if result != k {
                return None;
            }
            if matches!(sym, "min" | "max") {
                return Some(format!(
                    "({x} {} {y} ? {x} : {y})",
                    if sym == "min" { "<" } else { ">" }
                ));
            }
            let op = match sym {
                "prim.add" => "OP_ADD",
                "prim.sub" => "OP_SUB",
                "prim.mul" => "OP_MUL",
                "prim.div" => "OP_DIV",
                "prim.rem" => "OP_REM",
                _ => return None,
            };
            let out = self.temporary(k, "0");
            let error = format!("error{}", self.next);
            self.next += 1;
            writeln!(self.output, "    int {error};\n    if (!fwp_arith_{}({op}, {x}, {y}, &{out}, &{error})) {{\n        if ({error} == 2) fwp_trap(\"division by zero\");\n        fwp_trap_overflow(\"{}\");\n    }}", k.c(), if k == Kind::I128 { "I128" } else { "U128" }).unwrap();
            return Some(out);
        }
        if v.len() == 1 && ks[0] == result && result.wide() && matches!(sym, "prim.neg" | "abs") {
            let x = &v[0];
            if sym == "abs" && result == Kind::U128 {
                return Some(x.clone());
            }
            let check = if result == Kind::I128 {
                format!("{x} == (i128)((u128)1 << 127)")
            } else {
                format!("{x} != 0")
            };
            writeln!(
                self.output,
                "    if ({check}) fwp_trap_overflow(\"{}\");",
                if result == Kind::I128 { "I128" } else { "U128" }
            )
            .unwrap();
            return Some(if sym == "abs" {
                format!("({x} < 0 ? -{x} : {x})")
            } else {
                format!("-({x})")
            });
        }
        None
    }

    fn quad_primitive(
        &mut self,
        sym: &str,
        v: &[String],
        ks: &[Kind],
        result: Kind,
    ) -> Option<String> {
        if v.is_empty() && result == Kind::F128 {
            return match sym {
                "prim.zero" => Some("(float128_t){{0, 0}}".into()),
                "prim.one" => Some("(float128_t){{0, UINT64_C(0x3fff000000000000)}}".into()),
                _ => None,
            };
        }
        if ks == [Kind::F128, Kind::F128] {
            let (x, y) = (&v[1], &v[0]);
            if result == Kind::Bool {
                let comparison = format!("fwp_f128_compare({x}, {y})");
                return Some(match sym {
                    "eq" => format!("({comparison} == 0)"),
                    "ne" => format!("({comparison} != 0)"),
                    "lt" => format!("({comparison} == -1)"),
                    "le" => format!("({comparison} <= 0)"),
                    "gt" => format!("({comparison} == 1)"),
                    "ge" => format!("((unsigned){comparison} <= 1)"),
                    _ => return None,
                });
            }
            if result != Kind::F128 {
                return None;
            }
            let call = match sym {
                "prim.add" => "f128_add",
                "prim.sub" => "f128_sub",
                "prim.mul" => "f128_mul",
                "prim.div" => "f128_div",
                "prim.rem" => "fwp_f128_rem",
                "pow" => "fwp_f128_pow",
                _ => return None,
            };
            return Some(format!("{call}({x}, {y})"));
        }
        if ks == [Kind::F128] && result == Kind::F128 {
            let x = &v[0];
            return Some(match sym {
                "float.convert" => x.clone(),
                "prim.neg" => {
                    format!("(float128_t){{{{{x}.v[0], {x}.v[1] ^ UINT64_C(0x8000000000000000)}}}}")
                }
                "abs" => {
                    format!("(float128_t){{{{{x}.v[0], {x}.v[1] & UINT64_C(0x7fffffffffffffff)}}}}")
                }
                "sqrt" => format!("f128_sqrt({x})"),
                "exp" | "ln" | "sin" | "cos" | "tan" => format!("fwp_f128_{sym}({x})"),
                "floor" => format!("f128_roundToInt({x}, softfloat_round_min, false)"),
                "ceil" => format!("f128_roundToInt({x}, softfloat_round_max, false)"),
                "round" => format!("f128_roundToInt({x}, softfloat_round_near_maxMag, false)"),
                _ => return None,
            });
        }
        None
    }
}

fn body(program: &Program, enabled: &[bool], id: FuncId) -> Option<String> {
    let f = &program.funcs[id];
    let Body::Expr(expr) = &f.body else {
        return None;
    };
    let kind = Kind::of(f.ty.params(f.arity as usize).1)?;
    let mut emitter = Emitter {
        program,
        enabled,
        locals: &f.locals,
        output: String::new(),
        next: 0,
    };
    for (i, ty) in f.locals.iter().enumerate().skip(f.arity as usize) {
        if let Some(k) = Kind::of(ty) {
            writeln!(
                emitter.output,
                "    {} l{i} = {};",
                k.c(),
                if k == Kind::F128 { "{{0, 0}}" } else { "0" }
            )
            .unwrap();
        }
    }
    let value = emitter.expression(expr, kind)?;
    writeln!(emitter.output, "    return {value};").unwrap();
    Some(emitter.output)
}

pub(super) fn select(program: &Program) -> Vec<bool> {
    let mut enabled: Vec<_> = program
        .funcs
        .iter()
        .map(|f| {
            let (args, result) = f.ty.params(f.arity as usize);
            f.arity > 0
                && matches!(f.body, Body::Expr(_))
                && Kind::of(result).is_some()
                && args.iter().all(|t| Kind::of(t).is_some())
                && args
                    .iter()
                    .chain(std::iter::once(&result))
                    .any(|t| Kind::of(t).is_some_and(Kind::wide))
                && std::env::var("FWP_WIDE_WORKERS").as_deref() != Ok("0")
        })
        .collect();
    loop {
        let previous = enabled.clone();
        for (id, active) in enabled.iter_mut().enumerate() {
            if *active && body(program, &previous, id).is_none() {
                *active = false;
            }
        }
        if previous == enabled {
            return enabled;
        }
    }
}

pub(super) fn worker(program: &Program, enabled: &[bool], id: FuncId, ticks: bool) -> String {
    format!(
        "/* native wide worker: {} */\n{} {{\n{}{}\n}}\n",
        program.funcs[id].name,
        signature(program, id),
        if ticks { "    FWP_TICK();\n" } else { "" },
        body(program, enabled, id).expect("selected wide worker")
    )
}
