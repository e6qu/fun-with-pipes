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
    /// The `Error[E]` type of the function, if it has one.
    pub error: Option<MT>,
    /// Address used when `FWP_SERVICE_<MODULE>` is not set.
    pub default_addr: String,
}

/// A module served as a gRPC service.
#[derive(Clone, Debug, Default)]
pub struct ServiceDef {
    pub module: String,
    /// Exported functions: name, function and `Error[E]` type.
    pub methods: Vec<(String, FuncId, Option<MT>)>,
    /// Address to listen on when neither `--listen` nor
    /// `FWP_SERVICE_<MODULE>` is given.
    pub default_addr: String,
}

#[derive(Clone, Debug)]
pub struct Func {
    pub name: String,
    pub arity: u32,
    pub nlocals: u32,
    pub ty: MT,
    pub body: Body,
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
    pub shapes: std::collections::BTreeMap<MT, TypeShape>,
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
}

impl crate::value::Shapes for Program {
    fn shape(&self, mt: &MT) -> TypeShape {
        self.shapes.get(mt).cloned().unwrap_or(TypeShape::Opaque)
    }
}
