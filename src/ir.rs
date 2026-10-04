//! Monomorphic typed IR shared by the interpreter and the C backend.
//!
//! Every function value at runtime is a partial application of a known
//! function: fwp code has no local binders, so lambda lifting is trivial.

use std::fmt;

use crate::types::label_cmp;
use crate::value::Value;

/// Monomorphic type (effects erased).
#[derive(Clone, Debug, PartialEq, Eq, Hash, PartialOrd, Ord)]
pub enum MT {
    Con(String, Vec<MT>),
    Fun(Box<MT>, Box<MT>),
    /// Record with fields in canonical order (tuples have labels 0, 1, ...).
    Record(Vec<(String, MT)>),
    Nat(u64),
}

impl MT {
    pub fn unit() -> MT {
        MT::Record(vec![])
    }

    pub fn con(n: &str) -> MT {
        MT::Con(n.to_string(), vec![])
    }

    /// Argument and result types of a function type, if it is one.
    pub fn as_fun(&self) -> Option<(&MT, &MT)> {
        match self {
            MT::Fun(a, b) => Some((a, b)),
            _ => None,
        }
    }

    /// Parameter types along the arrow spine, up to `n` arrows.
    pub fn params(&self, n: usize) -> (Vec<&MT>, &MT) {
        let mut ps = Vec::new();
        let mut t = self;
        while ps.len() < n {
            match t {
                MT::Fun(a, b) => {
                    ps.push(&**a);
                    t = b;
                }
                _ => break,
            }
        }
        (ps, t)
    }

    pub fn record_index(&self, label: &str) -> Option<usize> {
        match self {
            MT::Record(fs) => fs.iter().position(|(l, _)| l == label),
            _ => None,
        }
    }

    pub fn sort_fields(fields: &mut [(String, MT)]) {
        fields.sort_by(|a, b| label_cmp(&a.0, &b.0));
    }

    /// Short type name without module prefix.
    pub fn short_name(n: &str) -> String {
        crate::types::display_name(n)
    }
}

impl fmt::Display for MT {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            MT::Con(n, args) => {
                write!(f, "{}", MT::short_name(n))?;
                if !args.is_empty() {
                    write!(f, "[")?;
                    for (i, a) in args.iter().enumerate() {
                        if i > 0 {
                            write!(f, ", ")?;
                        }
                        write!(f, "{}", a)?;
                    }
                    write!(f, "]")?;
                }
                Ok(())
            }
            MT::Fun(a, b) => match **a {
                MT::Fun(..) => write!(f, "({}) -> {}", a, b),
                _ => write!(f, "{} -> {}", a, b),
            },
            MT::Record(fs) => {
                let is_tuple =
                    fs.len() > 1 && fs.iter().enumerate().all(|(i, (l, _))| *l == i.to_string());
                if fs.is_empty() {
                    write!(f, "()")
                } else if is_tuple {
                    write!(f, "(")?;
                    for (i, (_, t)) in fs.iter().enumerate() {
                        if i > 0 {
                            write!(f, ", ")?;
                        }
                        write!(f, "{}", t)?;
                    }
                    write!(f, ")")
                } else {
                    write!(f, "{{")?;
                    for (i, (l, t)) in fs.iter().enumerate() {
                        if i > 0 {
                            write!(f, ", ")?;
                        }
                        write!(f, "{}: {}", l, t)?;
                    }
                    write!(f, "}}")
                }
            }
            MT::Nat(n) => write!(f, "{}", n),
        }
    }
}

pub type FuncId = usize;
pub type Local = u32;

#[derive(Clone, Debug)]
pub enum Expr {
    Local(Local),
    Const(Value),
    /// A function as a value: a partial application with no arguments, or
    /// the value of a constant (arity 0) binding.
    Func(FuncId),
    /// Saturated call of a known function.
    Call(FuncId, Vec<Expr>),
    /// Application of an arbitrary function value.
    Apply(Box<Expr>, Vec<Expr>),
    /// ADT value.
    Construct(u32, Vec<Expr>),
    /// Record or tuple value, fields in canonical order.
    Record(Vec<Expr>),
    Field(Box<Expr>, u32),
    /// Copy of a record with some fields replaced.
    SetFields(Box<Expr>, Vec<(u32, Expr)>),
    Let(Local, Box<Expr>, Box<Expr>),
    /// First matching arm wins; patterns bind locals.
    Match(Box<Expr>, Vec<(Pat, Expr)>),
    /// One more reference to the value of a local, then the expression
    /// (reference counting, `src/rc.rs`; only after every other pass).
    Dup(Local, Box<Expr>),
    /// One reference to the value of a local fewer, then the expression.
    Drop(Local, Box<Expr>),
}

#[derive(Clone, Debug)]
pub enum Pat {
    /// Matches anything and binds it.
    Bind(Local),
    Wild,
    /// Literal (an integer of any width, or a string).
    Lit(Value),
    Construct(u32, Vec<Pat>),
    Record(Vec<Pat>),
}

#[derive(Clone, Debug)]
pub enum Body {
    Expr(Expr),
    /// Runtime primitive identified by symbol, specialized at `ty` (the
    /// full function type of this instance).
    Prim(String),
    /// ADT constructor.
    Ctor(u32),
    /// A C function (`foreign "C"`), called through the C ABI.
    ForeignC {
        symbol: String,
        /// Number of fixed parameters of a variadic function.
        variadic: Option<u32>,
    },
    /// An exported function of a module built as a separate service: the
    /// call is a gRPC unary call (see `services.rs`).
    Remote(Box<RemoteFn>),
}

/// The client side of a function served by another process.
#[derive(Clone, Debug)]
pub struct RemoteFn {
    /// The module that serves the function.
    pub module: String,
    /// The function's name within the module.
    pub method: String,
    /// The gRPC path (`/fwp.Inventory/Item`, or a `# grpc:` annotation's).
    pub path: String,
    /// The `Error[E]` type of the function, if it has one.
    pub error: Option<MT>,
    /// Address used when `FWP_SERVICE_<MODULE>` is not set.
    pub default_addr: String,
    /// `std::grpc._iter` at the element type of a streamed result
    /// (`Iterator[T]`), which turns received messages into an iterator.
    pub iter_fn: Option<FuncId>,
}

/// A module served as a gRPC service.
#[derive(Clone, Debug, Default)]
pub struct ServiceDef {
    pub module: String,
    /// Exported functions.
    pub methods: Vec<ServedFn>,
    /// Address to listen on when neither `--listen` nor
    /// `FWP_SERVICE_<MODULE>` is given.
    pub default_addr: String,
    /// The root file's functions, served as module `module` (`--grpc`).
    pub root: bool,
}

impl ServiceDef {
    /// The fingerprint of a served function, as its callers compute it.
    pub fn fingerprint(&self, prog: &Program, f: &ServedFn) -> String {
        let main_as = self.root.then_some(self.module.as_str());
        crate::protobuf::fingerprint_as(prog, &prog.funcs[f.func].ty, f.error.as_ref(), main_as)
    }
}

/// An exported function of a served module.
#[derive(Clone, Debug)]
pub struct ServedFn {
    pub name: String,
    pub func: FuncId,
    /// The `Error[E]` type of the function, if it has one.
    pub error: Option<MT>,
    /// The gRPC path (`/fwp.Inventory/Item`, or a `# grpc:` annotation's).
    pub path: String,
    /// `std::grpc._iter` at the element type of a streamed parameter
    /// (`Iterator[T]`), which turns received messages into an iterator.
    pub iter_fn: Option<FuncId>,
}

#[derive(Clone, Debug)]
pub struct Func {
    pub name: String,
    pub arity: u32,
    /// The type of each local: the parameters first, then the locals the
    /// body binds.
    pub locals: Vec<MT>,
    pub ty: MT,
    pub body: Body,
}

impl Func {
    pub fn nlocals(&self) -> u32 {
        self.locals.len() as u32
    }
}

pub type Shapes = std::collections::BTreeMap<MT, TypeShape>;

/// The fields of a record type, nominal (by its shape) or not.
pub fn record_fields<'a>(shapes: &'a Shapes, t: &'a MT) -> Option<&'a [(String, MT)]> {
    match t {
        MT::Record(fs) => Some(fs),
        MT::Con(..) => match shapes.get(t)? {
            TypeShape::Record(fs) => Some(fs),
            _ => None,
        },
        _ => None,
    }
}

/// Whether two types have the same representation: equal, or a nominal
/// record and a record with the same fields.
pub fn same_type(shapes: &Shapes, a: &MT, b: &MT) -> bool {
    if a == b {
        return true;
    }
    let nominal =
        |t: &MT| matches!(t, MT::Con(..)) && matches!(shapes.get(t), Some(TypeShape::Record(_)));
    match (a, b) {
        (MT::Con(x, xs), MT::Con(y, ys)) if x == y && !nominal(a) => {
            xs.len() == ys.len() && xs.iter().zip(ys).all(|(x, y)| same_type(shapes, x, y))
        }
        (MT::Fun(a1, r1), MT::Fun(a2, r2)) => {
            same_type(shapes, a1, a2) && same_type(shapes, r1, r2)
        }
        _ => match (record_fields(shapes, a), record_fields(shapes, b)) {
            (Some(x), Some(y)) => {
                x.len() == y.len()
                    && x.iter()
                        .zip(y)
                        .all(|((l, s), (m, t))| l == m && same_type(shapes, s, t))
            }
            _ => false,
        },
    }
}

/// The type of `e`, where it follows from the types of its parts: a local
/// (`locals`), a function (`func`), or a call or field of one. `None` for
/// constants and constructed values, whose type the expression alone does
/// not give.
pub fn type_of<'a>(
    func: &dyn Fn(FuncId) -> &'a MT,
    shapes: &Shapes,
    locals: &'a [MT],
    e: &'a Expr,
) -> Option<MT> {
    let type_of = |e| type_of(func, shapes, locals, e);
    match e {
        Expr::Dup(_, b) | Expr::Drop(_, b) => type_of(b),
        Expr::Local(l) => locals.get(*l as usize).cloned(),
        Expr::Func(id) => Some(func(*id).clone()),
        Expr::Call(id, a) => Some(func(*id).params(a.len()).1.clone()),
        Expr::Apply(f, a) => Some(type_of(f)?.params(a.len()).1.clone()),
        Expr::Field(r, i) => Some(
            record_fields(shapes, &type_of(r)?)?
                .get(*i as usize)?
                .1
                .clone(),
        ),
        Expr::SetFields(r, _) => type_of(r),
        Expr::Let(_, _, b) => type_of(b),
        Expr::Match(_, arms) => arms.iter().find_map(|(_, b)| type_of(b)),
        Expr::Const(_) | Expr::Construct(..) | Expr::Record(_) => None,
    }
}

/// Information about named types needed at runtime (display, encoding).
#[derive(Clone, Debug)]
pub enum TypeShape {
    /// Variant names and field types (with the type's parameters
    /// substituted).
    Adt(Vec<(String, Vec<MT>)>),
    /// Nominal record: field names and types in canonical order.
    Record(Vec<(String, MT)>),
    Opaque,
}

#[derive(Default, Clone, Debug)]
pub struct Program {
    pub funcs: Vec<Func>,
    /// Shapes of all named types reachable from function types.
    pub shapes: Shapes,
    pub main: Option<FuncId>,
    /// `(test name, function)`.
    pub tests: Vec<(String, FuncId)>,
    /// Exported functions by name.
    pub exports: Vec<(String, FuncId)>,
    /// Instances of bindings requested by canonical name (`Roots::names`).
    pub named: Vec<(String, FuncId)>,
    /// `repr(C)` records: type name to field names in declaration order.
    pub repr_c: std::collections::BTreeMap<String, Vec<String>>,
    /// Every nominal record: type name to field names in declaration order
    /// (protobuf field numbers follow it).
    pub field_order: std::collections::BTreeMap<String, Vec<String>>,
    /// Doc comments of the exported functions and record fields (for the
    /// help of command-line programs).
    pub docs: crate::cli::Docs,
    /// The module this program serves (`fwp serve`, split builds).
    pub service: Option<ServiceDef>,
    /// Exported functions: the `Error[E]` type and the effects (by name)
    /// of their final arrow (for REST endpoints).
    pub export_effects: std::collections::BTreeMap<String, (Option<MT>, Vec<String>)>,
    /// The canonical names (`std::iter.map`) of instances of the standard
    /// library's iterator functions, which the optimizer recognizes.
    pub std_names: std::collections::BTreeMap<FuncId, String>,
}

impl crate::value::Shapes for Program {
    fn shape(&self, mt: &MT) -> TypeShape {
        self.shapes.get(mt).cloned().unwrap_or(TypeShape::Opaque)
    }
}

/// Check that every function's local types agree with its body: each
/// local it uses has a type, its parameters have its type's parameter
/// types, and a local bound to a value (or a pattern on one) whose type
/// the value gives has that type.
pub fn check_locals(prog: &Program) -> Result<(), String> {
    let func = |id: FuncId| &prog.funcs[id].ty;
    let shapes = &prog.shapes;
    for f in &prog.funcs {
        let err = |m: String| format!("{}: {}: {}", f.name, f.ty, m);
        let (ps, _) = f.ty.params(f.arity as usize);
        if ps.len() == f.arity as usize
            && ps
                .iter()
                .zip(&f.locals)
                .any(|(p, l)| !same_type(shapes, p, l))
        {
            return Err(err("parameter types differ from the function's".into()));
        }
        if f.locals.len() < f.arity as usize {
            return Err(err("fewer locals than parameters".into()));
        }
        if let Body::Expr(e) = &f.body {
            check_expr(&func, shapes, &f.locals, e).map_err(err)?;
        }
    }
    Ok(())
}

fn check_expr<'a>(
    func: &dyn Fn(FuncId) -> &'a MT,
    shapes: &Shapes,
    locals: &'a [MT],
    e: &'a Expr,
) -> Result<(), String> {
    let has = |l: Local| match locals.get(l as usize) {
        Some(_) => Ok(()),
        None => Err(format!("local {} has no type", l)),
    };
    let same = |l: Local, v: &'a Expr| match type_of(func, shapes, locals, v) {
        Some(t) if !same_type(shapes, &t, &locals[l as usize]) => Err(format!(
            "local {} is {} but is bound to a {}",
            l, locals[l as usize], t
        )),
        _ => Ok(()),
    };
    match e {
        Expr::Dup(l, b) | Expr::Drop(l, b) => {
            has(*l)?;
            check_expr(func, shapes, locals, b)
        }
        Expr::Local(l) => has(*l),
        Expr::Const(_) | Expr::Func(_) => Ok(()),
        Expr::Call(_, a) | Expr::Construct(_, a) | Expr::Record(a) => a
            .iter()
            .try_for_each(|x| check_expr(func, shapes, locals, x)),
        Expr::Apply(f, a) => {
            check_expr(func, shapes, locals, f)?;
            a.iter()
                .try_for_each(|x| check_expr(func, shapes, locals, x))
        }
        Expr::Field(r, _) => check_expr(func, shapes, locals, r),
        Expr::SetFields(r, s) => {
            check_expr(func, shapes, locals, r)?;
            s.iter()
                .try_for_each(|(_, x)| check_expr(func, shapes, locals, x))
        }
        Expr::Let(l, v, b) => {
            has(*l)?;
            same(*l, v)?;
            check_expr(func, shapes, locals, v)?;
            check_expr(func, shapes, locals, b)
        }
        Expr::Match(s, arms) => {
            check_expr(func, shapes, locals, s)?;
            let st = type_of(func, shapes, locals, s);
            for (p, b) in arms {
                check_pat(shapes, locals, p, st.as_ref())?;
                check_expr(func, shapes, locals, b)?;
            }
            Ok(())
        }
    }
}

fn check_pat(shapes: &Shapes, locals: &[MT], p: &Pat, ty: Option<&MT>) -> Result<(), String> {
    match p {
        Pat::Bind(l) => match (locals.get(*l as usize), ty) {
            (None, _) => Err(format!("local {} has no type", l)),
            (Some(t), Some(u)) if !same_type(shapes, t, u) => {
                Err(format!("local {} is {} but matches a {}", l, t, u))
            }
            _ => Ok(()),
        },
        Pat::Wild | Pat::Lit(_) => Ok(()),
        Pat::Construct(_, ps) => ps
            .iter()
            .try_for_each(|p| check_pat(shapes, locals, p, None)),
        Pat::Record(ps) => {
            let fs = ty
                .and_then(|t| record_fields(shapes, t))
                .filter(|fs| fs.len() == ps.len());
            ps.iter()
                .enumerate()
                .try_for_each(|(i, p)| check_pat(shapes, locals, p, fs.map(|fs| &fs[i].1)))
        }
    }
}
