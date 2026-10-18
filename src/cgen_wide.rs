//! Native scalar and record workers for closed wide numeric expressions. Generic entries
//! keep word values; proven worker-to-worker paths keep full-width native bits.
use crate::ir::{type_of, Body, Expr, FuncId, Pat, Program, MT};
use crate::value::Value;
use std::collections::BTreeSet;
use std::fmt::Write;

#[derive(Clone, Copy, PartialEq, Eq, PartialOrd, Ord)]
pub(super) enum Kind {
    I128,
    U128,
    F128,
    I64,
    U64,
    Bool,
    Unit,
}

/// Closed numeric records use a C struct through worker calls. Their generic
/// boundary still owns a record and any boxed numeric leaves.
#[derive(Clone, PartialEq, Eq, PartialOrd, Ord)]
pub(super) enum Shape {
    Scalar(Kind),
    Record(Vec<Kind>),
}
impl Shape {
    pub(super) fn of(program: &Program, ty: &MT) -> Option<Self> {
        if let Some(kind) = Kind::of(ty) {
            return Some(Self::Scalar(kind));
        }
        let fields = super::record_fields(&program.shapes, ty)?;
        Some(Self::Record(
            fields
                .iter()
                .map(|(_, field)| Kind::of(field))
                .collect::<Option<_>>()?,
        ))
    }
    pub(super) fn c(&self) -> String {
        match self {
            Self::Scalar(kind) => kind.c().into(),
            Self::Record(fields) => format!(
                "fwp_wide_record_{}",
                fields
                    .iter()
                    .map(|kind| match kind {
                        Kind::I128 => "i128",
                        Kind::U128 => "u128",
                        Kind::F128 => "f128",
                        Kind::I64 => "i64",
                        Kind::U64 => "u64",
                        Kind::Bool => "bool",
                        Kind::Unit => "unit",
                    })
                    .collect::<Vec<_>>()
                    .join("_")
            ),
        }
    }
    fn wide(&self) -> bool {
        match self {
            Self::Scalar(k) => k.wide(),
            Self::Record(fields) => fields.iter().any(|k| k.wide()),
        }
    }
    pub(super) fn unbox(&self, word: &str) -> String {
        match self {
            Self::Scalar(k) => k.unbox(word),
            Self::Record(fields) => format!(
                "({}){{{}}}",
                self.c(),
                fields
                    .iter()
                    .enumerate()
                    .map(|(i, k)| k.unbox(&format!("OBJ({word})->f[{i}]")))
                    .collect::<Vec<_>>()
                    .join(", ")
            ),
        }
    }
}

pub(super) fn declarations(program: &Program, enabled: &[bool]) -> String {
    let mut shapes = BTreeSet::new();
    for (_, function) in program
        .funcs
        .iter()
        .enumerate()
        .filter(|(id, _)| enabled[*id])
    {
        for ty in function.locals.iter().chain(std::iter::once(
            function.ty.params(function.arity as usize).1,
        )) {
            if let Some(shape @ Shape::Record(_)) = Shape::of(program, ty) {
                shapes.insert(shape);
            }
        }
    }
    let mut out = String::new();
    for shape in shapes {
        let Shape::Record(fields) = &shape else {
            unreachable!()
        };
        let fields = fields
            .iter()
            .enumerate()
            .map(|(i, k)| format!("{} f{i};", k.c()))
            .collect::<Vec<_>>()
            .join(" ");
        writeln!(out, "typedef struct {{ {fields} }} {};", shape.c()).unwrap();
    }
    out
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
        .map(|(i, t)| format!("{} l{i}", Shape::of(program, t).unwrap().c()))
        .collect::<Vec<_>>()
        .join(", ");
    format!(
        "static {} fwp_wide{id}({args})",
        Shape::of(program, result).unwrap().c()
    )
}

struct Emitter<'a> {
    program: &'a Program,
    enabled: &'a [bool],
    locals: &'a [MT],
    output: String,
    next: usize,
    tail_loop: bool,
}
impl Emitter<'_> {
    fn returned_local(expression: &Expr) -> Option<u32> {
        match expression {
            Expr::Local(local) => Some(*local),
            Expr::Dup(_, body) | Expr::Drop(_, body) => Self::returned_local(body),
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } if parameters.is_empty() && bindings.is_empty() => Self::returned_local(body),
            _ => None,
        }
    }
    /// Self calls in tail position reuse the worker frame. Finish every
    /// argument before overwriting parameters, preserving aliases and traps.
    fn tail(&mut self, expression: &Expr, shape: &Shape, function: FuncId) -> Option<()> {
        match expression {
            Expr::Call(callee, arguments) if *callee == function => {
                let f = &self.program.funcs[function];
                if arguments.len() != f.arity as usize {
                    return None;
                }
                let (parameters, result) = f.ty.params(arguments.len());
                if Shape::of(self.program, result).as_ref() != Some(shape) {
                    return None;
                }
                let mut values = Vec::new();
                for (argument, ty) in arguments.iter().zip(parameters) {
                    let argument_shape = Shape::of(self.program, ty)?;
                    let value = self.expression(argument, &argument_shape)?;
                    values.push(self.shape_temporary(&argument_shape, &value));
                }
                for (index, value) in values.iter().enumerate() {
                    writeln!(self.output, "    l{index} = {value};").unwrap();
                }
                self.output.push_str("    goto fwp_wide_again;\n");
                self.tail_loop = true;
            }
            Expr::Let(local, value, body) if Self::returned_local(body) == Some(*local) => {
                self.tail(value, shape, function)?;
            }
            Expr::Let(local, value, body) => {
                let local_shape = Shape::of(self.program, &self.locals[*local as usize])?;
                let value = self.expression(value, &local_shape)?;
                writeln!(self.output, "    l{local} = {value};").unwrap();
                self.tail(body, shape, function)?;
            }
            Expr::Match(scrutinee, arms) => {
                let scrutinee_shape = self.shape(scrutinee).or_else(|| {
                    arms.iter()
                        .all(|(p, _)| matches!(p, Pat::Wild | Pat::Construct(0..=1, _)))
                        .then_some(Shape::Scalar(Kind::Bool))
                })?;
                let value = self.expression(scrutinee, &scrutinee_shape)?;
                let value = self.shape_temporary(&scrutinee_shape, &value);
                for (index, (pattern, body)) in arms.iter().enumerate() {
                    let mut bindings = String::new();
                    let condition =
                        self.condition(pattern, &scrutinee_shape, &value, &mut bindings)?;
                    writeln!(
                        self.output,
                        "    {}if ({condition}) {{",
                        if index == 0 { "" } else { "else " }
                    )
                    .unwrap();
                    self.output.push_str(&bindings);
                    self.tail(body, shape, function)?;
                    self.output.push_str("    }\n");
                }
                self.output
                    .push_str("    else fwp_trap(\"internal: no match arm applies\");\n");
            }
            Expr::Dup(_, body) | Expr::Drop(_, body) => self.tail(body, shape, function)?,
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } if parameters.is_empty() && bindings.is_empty() => {
                self.tail(body, shape, function)?
            }
            _ => {
                let value = self.expression(expression, shape)?;
                writeln!(self.output, "    return {value};").unwrap();
            }
        }
        Some(())
    }

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
    fn shape(&self, e: &Expr) -> Option<Shape> {
        type_of(
            &|id| &self.program.funcs[id].ty,
            &self.program.shapes,
            self.locals,
            e,
        )
        .as_ref()
        .and_then(|ty| Shape::of(self.program, ty))
    }
    fn shape_temporary(&mut self, shape: &Shape, value: &str) -> String {
        let name = format!("w{}", self.next);
        self.next += 1;
        writeln!(
            self.output,
            "    {} {name} = {};",
            shape.c(),
            if value == "0" { "{0}" } else { value }
        )
        .unwrap();
        name
    }
    fn condition(
        &self,
        pattern: &Pat,
        shape: &Shape,
        value: &str,
        bindings: &mut String,
    ) -> Option<String> {
        Some(match pattern {
            Pat::Wild => "1".into(),
            Pat::Bind(local) => {
                if Shape::of(self.program, &self.locals[*local as usize]).as_ref() != Some(shape) {
                    return None;
                }
                writeln!(bindings, "    l{local} = {value};").unwrap();
                "1".into()
            }
            Pat::Construct(tag, fields)
                if fields.is_empty() && *shape == Shape::Scalar(Kind::Bool) =>
            {
                format!("{value} == {tag}")
            }
            Pat::Lit(v) => {
                let Shape::Scalar(kind) = shape else {
                    return None;
                };
                let constant = Self::constant(v, *kind)?;
                if *kind == Kind::F128 {
                    format!("fwp_f128_compare({value}, {constant}) == 0")
                } else {
                    format!("{value} == ({constant})")
                }
            }
            Pat::Record(patterns) => {
                let Shape::Record(fields) = shape else {
                    return None;
                };
                if fields.len() != patterns.len() {
                    return None;
                }
                patterns
                    .iter()
                    .zip(fields)
                    .enumerate()
                    .map(|(i, (pattern, kind))| {
                        self.condition(
                            pattern,
                            &Shape::Scalar(*kind),
                            &format!("{value}.f{i}"),
                            bindings,
                        )
                    })
                    .collect::<Option<Vec<_>>>()?
                    .join(" && ")
            }
            _ => return None,
        })
    }
    fn expression(&mut self, e: &Expr, shape: &Shape) -> Option<String> {
        match e {
            Expr::Local(local)
                if Shape::of(self.program, &self.locals[*local as usize]).as_ref()
                    == Some(shape) =>
            {
                Some(format!("l{local}"))
            }
            Expr::Const(value) => match (value, shape) {
                (_, Shape::Scalar(kind)) => Self::constant(value, *kind),
                (Value::Record(values), Shape::Record(kinds)) if values.len() == kinds.len() => {
                    Some(format!(
                        "({}){{{}}}",
                        shape.c(),
                        values
                            .iter()
                            .zip(kinds)
                            .map(|(v, k)| Self::constant(v, *k))
                            .collect::<Option<Vec<_>>>()?
                            .join(", ")
                    ))
                }
                _ => None,
            },
            Expr::Construct(tag, fields)
                if fields.is_empty() && *shape == Shape::Scalar(Kind::Bool) =>
            {
                Some(tag.to_string())
            }
            Expr::Record(fields) if fields.is_empty() && *shape == Shape::Scalar(Kind::Unit) => {
                Some("0".into())
            }
            Expr::Record(fields) => {
                let Shape::Record(kinds) = shape else {
                    return None;
                };
                if fields.len() != kinds.len() {
                    return None;
                }
                let mut values = Vec::new();
                for (field, kind) in fields.iter().zip(kinds) {
                    let field_shape = Shape::Scalar(*kind);
                    let value = self.expression(field, &field_shape)?;
                    values.push(self.shape_temporary(&field_shape, &value));
                }
                Some(format!("({}){{{}}}", shape.c(), values.join(", ")))
            }
            Expr::Field(record, index) => {
                let record_shape = self.shape(record)?;
                let Shape::Record(fields) = &record_shape else {
                    return None;
                };
                if *shape != Shape::Scalar(*fields.get(*index as usize)?) {
                    return None;
                }
                let value = self.expression(record, &record_shape)?;
                let record = self.shape_temporary(&record_shape, &value);
                Some(format!("{record}.f{index}"))
            }
            Expr::SetFields(record, updates) => {
                let Shape::Record(fields) = shape else {
                    return None;
                };
                let value = self.expression(record, shape)?;
                let record = self.shape_temporary(shape, &value);
                for (index, expr) in updates {
                    let value =
                        self.expression(expr, &Shape::Scalar(*fields.get(*index as usize)?))?;
                    writeln!(self.output, "    {record}.f{index} = {value};").unwrap();
                }
                Some(record)
            }
            Expr::Let(local, value, body) => {
                let local_shape = Shape::of(self.program, &self.locals[*local as usize])?;
                let value = self.expression(value, &local_shape)?;
                writeln!(self.output, "    l{local} = {value};").unwrap();
                self.expression(body, shape)
            }
            Expr::Call(id, args) => {
                let f = &self.program.funcs[*id];
                let (params, result) = f.ty.params(args.len());
                if Shape::of(self.program, result).as_ref() != Some(shape)
                    || args.len() != f.arity as usize
                {
                    return None;
                }
                let mut values = Vec::new();
                let mut shapes = Vec::new();
                // Each argument finishes before the next one can trap.
                for (arg, ty) in args.iter().zip(params) {
                    let arg_shape = Shape::of(self.program, ty)?;
                    let value = self.expression(arg, &arg_shape)?;
                    values.push(self.shape_temporary(&arg_shape, &value));
                    shapes.push(arg_shape);
                }
                let call = if let Body::Prim(symbol) = &f.body {
                    let Shape::Scalar(kind) = shape else {
                        return None;
                    };
                    let kinds = shapes
                        .iter()
                        .map(|s| match s {
                            Shape::Scalar(k) => Some(*k),
                            _ => None,
                        })
                        .collect::<Option<Vec<_>>>()?;
                    self.primitive(*id, symbol, &values, &kinds, *kind)?
                } else if self.enabled[*id] {
                    format!("fwp_wide{id}({})", values.join(", "))
                } else {
                    return None;
                };
                Some(self.shape_temporary(shape, &call))
            }
            Expr::Match(scrutinee, arms) => {
                let scrutinee_shape = self.shape(scrutinee).or_else(|| {
                    arms.iter()
                        .all(|(p, _)| matches!(p, Pat::Wild | Pat::Construct(0..=1, _)))
                        .then_some(Shape::Scalar(Kind::Bool))
                })?;
                let value = self.expression(scrutinee, &scrutinee_shape)?;
                let value = self.shape_temporary(&scrutinee_shape, &value);
                let result = self.shape_temporary(shape, "0");
                for (i, (pattern, body)) in arms.iter().enumerate() {
                    let mut bindings = String::new();
                    let condition =
                        self.condition(pattern, &scrutinee_shape, &value, &mut bindings)?;
                    writeln!(
                        self.output,
                        "    {}if ({condition}) {{",
                        if i == 0 { "" } else { "else " }
                    )
                    .unwrap();
                    self.output.push_str(&bindings);
                    let value = self.expression(body, shape)?;
                    writeln!(self.output, "    {result} = {value};\n    }}").unwrap();
                }
                self.output
                    .push_str("    else fwp_trap(\"internal: no match arm applies\");\n");
                Some(result)
            }
            Expr::Dup(_, body) | Expr::Drop(_, body) => self.expression(body, shape),
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } if parameters.is_empty() && bindings.is_empty() => self.expression(body, shape),
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
                "atan2" => "fwp_f128_atan2",
                "hypot" => "fwp_f128_hypot",

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
                "exp" | "ln" | "sin" | "cos" | "tan" | "asin" | "acos" | "atan" | "sinh"
                | "cosh" | "tanh" | "asinh" | "acosh" | "atanh" | "log2" | "log10" | "log1p"
                | "exp2" | "expm1" => format!("fwp_f128_{sym}({x})"),
                "floor" => format!("f128_roundToInt({x}, softfloat_round_min, false)"),
                "ceil" => format!("f128_roundToInt({x}, softfloat_round_max, false)"),
                "round" => format!("f128_roundToInt({x}, softfloat_round_near_maxMag, false)"),
                _ => return None,
            });
        }
        None
    }
}

fn body(program: &Program, enabled: &[bool], id: FuncId, ticks: bool) -> Option<String> {
    let f = &program.funcs[id];
    let Body::Expr(expr) = &f.body else {
        return None;
    };
    let shape = Shape::of(program, f.ty.params(f.arity as usize).1)?;
    let mut emitter = Emitter {
        program,
        enabled,
        locals: &f.locals,
        output: String::new(),
        next: 0,
        tail_loop: false,
    };
    let mut declarations = String::new();
    for (i, ty) in f.locals.iter().enumerate().skip(f.arity as usize) {
        if let Some(shape) = Shape::of(program, ty) {
            writeln!(declarations, "    {} l{i} = {{0}};", shape.c()).unwrap();
        }
    }
    emitter.tail(expr, &shape, id)?;
    if emitter.tail_loop {
        declarations.push_str("fwp_wide_again:;\n");
    }
    if ticks {
        declarations.push_str("    FWP_TICK();\n");
    }
    declarations.push_str(&emitter.output);
    Some(declarations)
}

pub(super) fn select(program: &Program) -> Vec<bool> {
    let mut enabled: Vec<_> = program
        .funcs
        .iter()
        .map(|f| {
            let (args, result) = f.ty.params(f.arity as usize);
            f.arity > 0
                && matches!(f.body, Body::Expr(_))
                && Shape::of(program, result).is_some()
                && args.iter().all(|t| Shape::of(program, t).is_some())
                && args
                    .iter()
                    .chain(std::iter::once(&result))
                    .any(|t| Shape::of(program, t).is_some_and(|shape| shape.wide()))
                && std::env::var("FWP_WIDE_WORKERS").as_deref() != Ok("0")
        })
        .collect();
    loop {
        let previous = enabled.clone();
        for (id, active) in enabled.iter_mut().enumerate() {
            if *active && body(program, &previous, id, false).is_none() {
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
        "/* native wide worker: {} */\n{} {{\n{}\n}}\n",
        program.funcs[id].name,
        signature(program, id),
        body(program, enabled, id, ticks).expect("selected wide worker")
    )
}
