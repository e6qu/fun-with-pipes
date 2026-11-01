//! Abstract syntax tree.

use crate::diag::{Diagnostic, Span};
use std::collections::HashSet;

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
        /// Decimal source, including its sign, before destination rounding.
        decimal: String,
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
    /// Operator application, retaining notation for formatting. Binary
    /// operators use `flip op` with arguments in source evaluation order;
    /// unary negation uses `neg` with one argument.
    Operator(Operator, Box<Expr>, Vec<Expr>),
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
    /// A single-argument function with lexical pattern bindings.
    Lambda(Pattern, Box<Expr>),
    /// Strict, nonrecursive local binding.
    Let(Pattern, Box<Expr>, Box<Expr>),
    /// Tacit or named case function.
    Match(Vec<Arm>),
    Comptime(Box<Expr>),
    Quote(Box<Expr>),
    /// Reflection: `type[T]`.
    TypeOf(TypeExpr),
    /// Macro invocation `name!(a, b)`.
    MacroCall(String, Vec<Expr>),
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Operator {
    Neg,
    Add,
    Sub,
    Mul,
    Div,
    Rem,
    Eq,
    Ne,
    Lt,
    Le,
    Gt,
    Ge,
}

impl Operator {
    pub fn text(self) -> &'static str {
        match self {
            Self::Neg => "-",
            Self::Add => "+",
            Self::Sub => "-",
            Self::Mul => "*",
            Self::Div => "/",
            Self::Rem => "%",
            Self::Eq => "==",
            Self::Ne => "!=",
            Self::Lt => "<",
            Self::Le => "<=",
            Self::Gt => ">",
            Self::Ge => ">=",
        }
    }

    pub fn function(self) -> &'static str {
        match self {
            Self::Neg => "neg",
            Self::Add => "add",
            Self::Sub => "sub",
            Self::Mul => "mul",
            Self::Div => "div",
            Self::Rem => "rem",
            Self::Eq => "eq",
            Self::Ne => "ne",
            Self::Lt => "lt",
            Self::Le => "le",
            Self::Gt => "gt",
            Self::Ge => "ge",
        }
    }

    pub fn comparison(self) -> bool {
        matches!(
            self,
            Self::Eq | Self::Ne | Self::Lt | Self::Le | Self::Gt | Self::Ge
        )
    }

    pub fn precedence(self) -> u8 {
        match self {
            Self::Neg => 4,
            Self::Add | Self::Sub => 2,
            Self::Mul | Self::Div | Self::Rem => 3,
            Self::Eq | Self::Ne | Self::Lt | Self::Le | Self::Gt | Self::Ge => 1,
        }
    }
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
    /// A lexical, monomorphic value binding.
    Bind(String),
    /// Discard an irrefutable fn/let input without forwarding it.
    Ignore,
    /// Irrefutable field selection; unlisted fields are ignored.
    Record(Vec<(String, Pattern)>),
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
    /// Arithmetic on sizes: `n + m`, `2 * n`.
    NatOp(NatOp, Box<TypeExpr>, Box<TypeExpr>),
}

/// An operation on type-level naturals.
#[derive(Clone, Copy, Debug, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub enum NatOp {
    Add,
    Mul,
}

impl NatOp {
    pub fn text(self) -> &'static str {
        match self {
            NatOp::Add => "+",
            NatOp::Mul => "*",
        }
    }
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

impl Expr {
    /// Visit evaluated expressions with the lexical patterns visible at each node.
    /// Quoted syntax is data; only its unquoted expressions are evaluated here.
    pub fn walk_scoped<'a>(
        &'a self,
        scope: &mut Vec<&'a Pattern>,
        f: &mut dyn FnMut(&'a Expr, &[&'a Pattern]),
    ) {
        f(self, scope);
        match &self.kind {
            ExprKind::Let(p, value, body) => {
                value.walk_scoped(scope, f);
                scope.push(p);
                body.walk_scoped(scope, f);
                scope.pop();
            }
            ExprKind::Lambda(p, body) => {
                scope.push(p);
                body.walk_scoped(scope, f);
                scope.pop();
            }
            ExprKind::Match(arms) => {
                for arm in arms {
                    scope.push(&arm.pat);
                    arm.body.walk_scoped(scope, f);
                    scope.pop();
                }
            }
            ExprKind::Quote(body) => {
                fn unquotes<'a>(
                    e: &'a Expr,
                    scope: &mut Vec<&'a Pattern>,
                    f: &mut dyn FnMut(&'a Expr, &[&'a Pattern]),
                ) {
                    if matches!(e.kind, ExprKind::Quote(_)) {
                        return;
                    }
                    if let ExprKind::MacroCall(name, args) = &e.kind {
                        if name == "unquote" {
                            for arg in args {
                                arg.walk_scoped(scope, f);
                            }
                            return;
                        }
                    }
                    e.children(&mut |child| unquotes(child, scope, f));
                }
                unquotes(body, scope, f);
            }
            _ => self.children(&mut |child| child.walk_scoped(scope, f)),
        }
    }

    /// Immediate expression children in source evaluation order.
    fn children<'a>(&'a self, f: &mut dyn FnMut(&'a Expr)) {
        match &self.kind {
            ExprKind::App(g, args) | ExprKind::Operator(_, g, args) => {
                f(g);
                args.iter().for_each(f);
            }
            ExprKind::Pipe(a, b) | ExprKind::Let(_, a, b) => {
                f(a);
                f(b);
            }
            ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
                xs.iter().for_each(f)
            }
            ExprKind::Record(fs)
            | ExprKind::NominalRecord(_, fs)
            | ExprKind::With(fs)
            | ExprKind::Make(_, fs)
            | ExprKind::Update(fs) => fs.iter().for_each(|(_, x)| f(x)),
            ExprKind::Match(arms) => arms.iter().for_each(|a| f(&a.body)),
            ExprKind::Lambda(_, x) | ExprKind::Comptime(x) | ExprKind::Quote(x) => f(x),
            _ => {}
        }
    }

    /// Visit this expression and every expression inside it, outer first.
    pub fn walk(&self, f: &mut dyn FnMut(&Expr)) {
        f(self);
        match &self.kind {
            ExprKind::App(g, args) | ExprKind::Operator(_, g, args) => {
                g.walk(f);
                args.iter().for_each(|a| a.walk(f));
            }
            ExprKind::Pipe(a, b) | ExprKind::Let(_, a, b) => {
                a.walk(f);
                b.walk(f);
            }
            ExprKind::Tuple(xs) | ExprKind::List(xs) | ExprKind::MacroCall(_, xs) => {
                xs.iter().for_each(|x| x.walk(f))
            }
            ExprKind::Record(fs)
            | ExprKind::NominalRecord(_, fs)
            | ExprKind::With(fs)
            | ExprKind::Make(_, fs)
            | ExprKind::Update(fs) => fs.iter().for_each(|(_, x)| x.walk(f)),
            ExprKind::Match(arms) => arms.iter().for_each(|a| a.body.walk(f)),
            ExprKind::Lambda(_, x) | ExprKind::Comptime(x) | ExprKind::Quote(x) => x.walk(f),
            _ => {}
        }
    }
}

impl Decl {
    /// The expressions of a declaration: binding, method and test bodies.
    pub fn bodies(&self) -> Vec<&Expr> {
        match self {
            Decl::Bind(b) | Decl::Macro(b) => vec![&b.body],
            Decl::Test { body, .. } => vec![body],
            Decl::Trait(t) => t.defaults.iter().map(|b| &b.body).collect(),
            Decl::Impl(i) => i.bindings.iter().map(|b| &b.body).collect(),
            _ => vec![],
        }
    }
}

impl Pattern {
    /// Macro syntax enters after parsing, so admission cannot rely on parser checks.
    pub fn validate(&self, refutable: bool) -> Result<(), Diagnostic> {
        fn visit(
            p: &Pattern,
            refutable: bool,
            names: &mut HashSet<String>,
        ) -> Result<(), Diagnostic> {
            match &p.kind {
            PatKind::Bind(name) => {
                if !names.insert(name.clone()) {
                    return Err(Diagnostic::error(p.span, format!("duplicate pattern binding `{name}`")));
                }
            }
            PatKind::Ignore | PatKind::Unit => {}
            PatKind::Tuple(items) => {
                for item in items { visit(item, refutable, names)?; }
            }
            PatKind::Record(fields) => {
                let mut labels = HashSet::new();
                for (label, value) in fields {
                    if !labels.insert(label) {
                        return Err(Diagnostic::error(value.span, format!("duplicate pattern field `{label}`")));
                    }
                    visit(value, false, names)?;
                }
            }
            _ if !refutable => return Err(Diagnostic::error(p.span,
                "fn, let and record field patterns must always match; use match for alternatives (PIgnore discards a macro binder)")),
            PatKind::Ctor(_, Some(items)) => {
                for item in items { visit(item, true, names)?; }
            }
            _ => {}
        }
            Ok(())
        }
        visit(self, refutable, &mut HashSet::new())
    }

    /// Visit named leaves, retaining their source positions and identities.
    pub fn walk_bindings(&self, f: &mut dyn FnMut(&Pattern, &str)) {
        match &self.kind {
            PatKind::Bind(name) => f(self, name),
            PatKind::Tuple(ps) | PatKind::Ctor(_, Some(ps)) => {
                for p in ps {
                    p.walk_bindings(f);
                }
            }
            PatKind::Record(fs) => {
                for (_, p) in fs {
                    p.walk_bindings(f);
                }
            }
            _ => {}
        }
    }

    /// Lexical bindings, in source order. Holes never introduce a name.
    pub fn bindings(&self, out: &mut Vec<(NodeId, String)>) {
        match &self.kind {
            PatKind::Bind(n) => out.push((self.id, n.clone())),
            PatKind::Tuple(ps) | PatKind::Ctor(_, Some(ps)) => {
                for p in ps {
                    p.bindings(out);
                }
            }
            PatKind::Record(fs) => {
                for (_, p) in fs {
                    p.bindings(out);
                }
            }
            _ => {}
        }
    }
}
