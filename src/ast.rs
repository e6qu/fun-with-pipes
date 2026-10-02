//! Abstract syntax tree.

use crate::diag::Span;

pub type NodeId = u32;

#[derive(Clone, Debug, PartialEq)]
pub struct Expr {
    pub id: NodeId,
    pub span: Span,
    pub kind: ExprKind,
}

#[derive(Clone, Debug, PartialEq)]
pub enum ExprKind {
    Int {
        neg: bool,
        mag: u128,
        suffix: Option<String>,
    },
    Float {
        value: f64,
        /// The literal rounded once, directly to `F32` precision.
        value32: f32,
        suffix: Option<String>,
    },
    Str(String),
    Trits(Vec<i8>),
    Duration(i128),
    /// Lowercase name, possibly qualified.
    Var(String),
    /// Constructor name, possibly qualified.
    Ctor(String),
    /// Field selector path, a function.
    Selector(Vec<String>),
    /// Juxtaposition: `f a b`.
    App(Box<Expr>, Vec<Expr>),
    /// `a | b`.
    Pipe(Box<Expr>, Box<Expr>),
    Unit,
    Tuple(Vec<Expr>),
    List(Vec<Expr>),
    /// Anonymous structural record `{ a = 1, b = 2 }`.
    Record(Vec<(String, Expr)>),
    /// Nominal record construction `User { name = "x" }`.
    NominalRecord(String, Vec<(String, Expr)>),
    /// Record update function `with { a = 1 }`.
    With(Vec<(String, Expr)>),
    /// Record builder `make { a = f, b = g }`: applies every field function
    /// to the same input. With a type name, builds a nominal record.
    Make(Option<String>, Vec<(String, Expr)>),
    /// Field-wise update `update { a = f }`: applies `f` to field `a`.
    Update(Vec<(String, Expr)>),
    /// Tacit case function.
    Match(Vec<Arm>),
    Comptime(Box<Expr>),
    Quote(Box<Expr>),
    /// Reflection: `type[T]`.
    TypeOf(TypeExpr),
    /// Macro invocation `name!(a, b)`.
    MacroCall(String, Vec<Expr>),
}

#[derive(Clone, Debug, PartialEq)]
pub struct Arm {
    pub pat: Pattern,
    pub body: Expr,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Pattern {
    pub id: NodeId,
    pub span: Span,
    pub kind: PatKind,
}

#[derive(Clone, Debug, PartialEq)]
pub enum PatKind {
    /// A hole: matches anything and passes the value to the arm body.
    Hole,
    Int {
        neg: bool,
        mag: u128,
    },
    Str(String),
    /// Constructor pattern. `None` args means "bare": all fields are holes.
    Ctor(String, Option<Vec<Pattern>>),
    Tuple(Vec<Pattern>),
    Unit,
}

#[derive(Clone, Debug, PartialEq)]
pub struct TypeExpr {
    pub span: Span,
    pub kind: TypeKind,
}

#[derive(Clone, Debug, PartialEq)]
pub enum TypeKind {
    /// Named type or type variable, with optional arguments: `List[T]`, `a`.
    Name(String, Vec<TypeExpr>),
    Fun(Box<TypeExpr>, Box<TypeExpr>, Option<EffExpr>),
    Unit,
    Tuple(Vec<TypeExpr>),
    Record(Vec<(String, TypeExpr)>, Option<String>),
    Nat(u64),
}

#[derive(Clone, Debug, PartialEq)]
pub struct EffExpr {
    pub span: Span,
    pub labels: Vec<(String, Vec<TypeExpr>)>,
    pub tail: Option<String>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Constraint {
    pub span: Span,
    pub trait_name: String,
    pub args: Vec<TypeExpr>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Sig {
    pub name: String,
    pub span: Span,
    pub ty: TypeExpr,
    pub constraints: Vec<Constraint>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Binding {
    pub name: String,
    pub span: Span,
    pub rec: bool,
    pub body: Expr,
}

#[derive(Clone, Debug, PartialEq)]
pub enum TypeBody {
    Variants(Vec<Variant>),
    Record(Vec<(String, TypeExpr)>),
    Alias(TypeExpr),
    /// Opaque type, implemented by the runtime (only in the prelude).
    Opaque,
}

#[derive(Clone, Debug, PartialEq)]
pub struct Variant {
    pub name: String,
    pub span: Span,
    pub fields: Vec<TypeExpr>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct TypeDecl {
    pub name: String,
    pub span: Span,
    pub params: Vec<String>,
    pub body: TypeBody,
    pub resource: bool,
    /// `repr(C)`: a record with C layout (fields in declaration order).
    pub repr_c: bool,
}

#[derive(Clone, Debug, PartialEq)]
pub struct TraitDecl {
    pub name: String,
    pub span: Span,
    pub params: Vec<String>,
    pub supers: Vec<Constraint>,
    pub methods: Vec<Sig>,
    pub defaults: Vec<Binding>,
}

#[derive(Clone, Debug, PartialEq)]
pub struct ImplDecl {
    pub span: Span,
    pub trait_name: String,
    pub args: Vec<TypeExpr>,
    pub constraints: Vec<Constraint>,
    pub bindings: Vec<Binding>,
}

#[derive(Clone, Debug, PartialEq)]
pub enum Decl {
    Import {
        span: Span,
        module: String,
    },
    Sig {
        sig: Sig,
        export: bool,
    },
    Export {
        span: Span,
        name: String,
    },
    Bind(Binding),
    Macro(Binding),
    Type(TypeDecl),
    Trait(TraitDecl),
    Impl(ImplDecl),
    Foreign {
        span: Span,
        abi: String,
        name: String,
        symbol: String,
        /// For C functions with `...`: the number of fixed parameters.
        variadic: Option<u32>,
        ty: TypeExpr,
        constraints: Vec<Constraint>,
    },
    Test {
        span: Span,
        name: String,
        body: Expr,
    },
}

impl Decl {
    pub fn span(&self) -> Span {
        match self {
            Decl::Import { span, .. }
            | Decl::Export { span, .. }
            | Decl::Foreign { span, .. }
            | Decl::Test { span, .. } => *span,
            Decl::Sig { sig, .. } => sig.span,
            Decl::Bind(b) | Decl::Macro(b) => b.span,
            Decl::Type(t) => t.span,
            Decl::Trait(t) => t.span,
            Decl::Impl(i) => i.span,
        }
    }
}

#[derive(Clone, Debug, PartialEq, Default)]
pub struct Module {
    pub decls: Vec<Decl>,
}
