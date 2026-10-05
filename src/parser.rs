//! Recursive-descent parser with an offside (layout) rule.
//!
//! Layout: a construct that opens a layout block (the top level, `match`
//! arms, `trait`/`impl` bodies) records a column. A token that is first on
//! its line and at or left of the current block column terminates whatever
//! expression is being parsed. Brackets suspend layout.

use crate::ast::*;
use crate::diag::{DResult, Diagnostic, Span};
use crate::lexer::{lex, Kw, Sym, Tok, Token};

pub struct Parser<'a> {
    toks: Vec<Token>,
    pos: usize,
    layout: Vec<u32>,
    next_id: &'a mut NodeId,
    /// Names whose signature was written with `rec`.
    rec_sigs: Vec<String>,
}

/// Parse a whole source file. `next_id` supplies unique node ids across
/// files. Fails with the first syntax error.
pub fn parse_module(text: &str, file: u32, next_id: &mut NodeId) -> DResult<Module> {
    let (m, mut errors) = parse_module_recover(text, file, next_id);
    if errors.is_empty() {
        Ok(m)
    } else {
        Err(errors.swap_remove(0))
    }
}

/// Parse a whole source file, recovering from syntax errors at
/// declaration boundaries: after an error, parsing resumes at the next
/// line that starts a declaration in column 1. Returns the declarations
/// that parsed and every error, in source order.
pub fn parse_module_recover(
    text: &str,
    file: u32,
    next_id: &mut NodeId,
) -> (Module, Vec<Diagnostic>) {
    let toks = match lex(text, file) {
        Ok(t) => t,
        Err(d) => return (Module::default(), vec![d]),
    };
    let mut p = Parser {
        toks,
        pos: 0,
        layout: vec![1],
        next_id,
        rec_sigs: Vec::new(),
    };
    p.module()
}

/// Parse a standalone expression (used by `fwp eval`).
pub fn parse_expr_text(text: &str, file: u32, next_id: &mut NodeId) -> DResult<Expr> {
    let toks = lex(text, file)?;
    let mut p = Parser {
        toks,
        pos: 0,
        layout: vec![0],
        next_id,
        rec_sigs: Vec::new(),
    };
    let e = p.expr()?;
    if !p.at(&Tok::Eof) {
        return p.unexpected("end of expression");
    }
    Ok(e)
}

fn can_start_atom(t: &Tok) -> bool {
    matches!(
        t,
        Tok::Ident(_)
            | Tok::Upper(_)
            | Tok::Selector(_)
            | Tok::MacroCall(_)
            | Tok::Int { .. }
            | Tok::Float { .. }
            | Tok::Trits(_)
            | Tok::Duration(_)
            | Tok::Str(_)
            | Tok::Sym(Sym::LParen)
            | Tok::Sym(Sym::LBracket)
            | Tok::Sym(Sym::LBrace)
            | Tok::Keyword(Kw::Match)
            | Tok::Keyword(Kw::Quote)
            | Tok::Keyword(Kw::With)
            | Tok::Keyword(Kw::Make)
            | Tok::Keyword(Kw::Update)
            | Tok::Keyword(Kw::Type)
            | Tok::Keyword(Kw::Comptime)
    )
}

fn join(a: Span, b: Span) -> Span {
    if a.file != b.file || a.line != b.line {
        return a;
    }
    Span {
        len: (b.col + b.len).saturating_sub(a.col).max(1),
        ..a
    }
}

impl<'a> Parser<'a> {
    // ----- token helpers -------------------------------------------------

    fn peek(&self) -> &Token {
        &self.toks[self.pos]
    }

    fn peek_tok(&self) -> &Tok {
        &self.toks[self.pos].tok
    }

    fn peek_at(&self, n: usize) -> &Tok {
        &self.toks[(self.pos + n).min(self.toks.len() - 1)].tok
    }

    fn at(&self, t: &Tok) -> bool {
        self.peek_tok() == t
    }

    fn at_sym(&self, s: Sym) -> bool {
        matches!(self.peek_tok(), Tok::Sym(x) if *x == s)
    }

    fn at_kw(&self, k: Kw) -> bool {
        matches!(self.peek_tok(), Tok::Keyword(x) if *x == k)
    }

    fn span(&self) -> Span {
        self.peek().span
    }

    fn bump(&mut self) -> Token {
        let t = self.toks[self.pos].clone();
        if self.pos + 1 < self.toks.len() {
            self.pos += 1;
        }
        t
    }

    fn unexpected<T>(&self, expected: &str) -> DResult<T> {
        Err(Diagnostic::error(
            self.span(),
            format!(
                "expected {}, found {}",
                expected,
                self.peek_tok().describe()
            ),
        ))
    }

    fn expect_sym(&mut self, s: Sym) -> DResult<Span> {
        if self.at_sym(s) && !self.at_boundary_strict() {
            Ok(self.bump().span)
        } else if self.at_sym(s) {
            // closing brackets are allowed at any column
            match s {
                Sym::RParen | Sym::RBracket | Sym::RBrace => Ok(self.bump().span),
                _ => self.unexpected(&format!("`{}`", s.text())),
            }
        } else {
            self.unexpected(&format!("`{}`", s.text()))
        }
    }

    fn eat_sym(&mut self, s: Sym) -> bool {
        if self.at_sym(s) && !self.at_boundary_strict() {
            self.bump();
            true
        } else {
            false
        }
    }

    fn new_id(&mut self) -> NodeId {
        let id = *self.next_id;
        *self.next_id += 1;
        id
    }

    fn mk(&mut self, span: Span, kind: ExprKind) -> Expr {
        Expr {
            id: self.new_id(),
            span,
            kind,
        }
    }

    // ----- layout --------------------------------------------------------

    fn layout_col(&self) -> u32 {
        *self.layout.last().unwrap()
    }

    /// Whether the next token is at a layout boundary of the current block.
    fn at_boundary_strict(&self) -> bool {
        let t = self.peek();
        t.bol && t.span.col <= self.layout_col()
    }

    /// Whether the current expression must stop before the next token.
    fn at_expr_end(&self) -> bool {
        if self.at(&Tok::Eof) || self.at_boundary_strict() {
            return true;
        }
        !can_start_atom(self.peek_tok())
    }

    fn with_layout<T>(&mut self, col: u32, f: impl FnOnce(&mut Self) -> DResult<T>) -> DResult<T> {
        self.layout.push(col);
        let r = f(self);
        self.layout.pop();
        r
    }

    // ----- module / declarations ----------------------------------------

    fn module(&mut self) -> (Module, Vec<Diagnostic>) {
        let mut decls = Vec::new();
        let mut errors = Vec::new();
        while !self.at(&Tok::Eof) {
            let start = self.pos;
            match self.top_decl() {
                Ok(d) => decls.push(d),
                Err(e) => {
                    errors.push(e);
                    self.recover(start);
                }
            }
        }
        (Module { decls }, errors)
    }

    fn top_decl(&mut self) -> DResult<Decl> {
        let t = self.peek();
        if t.span.col != 1 {
            return Err(Diagnostic::error(
                t.span,
                "top-level declarations must start in column 1",
            ));
        }
        let d = self.decl()?;
        if !self.at(&Tok::Eof) && !self.at_boundary_strict() {
            let mut d = self.unexpected::<()>("end of declaration").unwrap_err();
            if matches!(self.peek_tok(), Tok::Sym(Sym::Eq) | Tok::Sym(Sym::Colon)) {
                d = d.with_note(
                    "indented lines continue the previous declaration; \
                     start a new declaration in column 1",
                );
            }
            return Err(d);
        }
        Ok(d)
    }

    /// Skip to the first token after `start` that begins a line in column 1
    /// and can begin a declaration.
    fn recover(&mut self, start: usize) {
        self.layout.truncate(1);
        self.pos = start + 1;
        while self.pos < self.toks.len() - 1 {
            let t = &self.toks[self.pos];
            let starts_decl = matches!(
                t.tok,
                Tok::Ident(_)
                    | Tok::Upper(_)
                    | Tok::Keyword(
                        Kw::Import
                            | Kw::Export
                            | Kw::Test
                            | Kw::Macro
                            | Kw::Foreign
                            | Kw::Resource
                            | Kw::Trait
                            | Kw::Impl
                            | Kw::Rec
                    )
            );
            if t.bol && t.span.col == 1 && starts_decl {
                return;
            }
            self.pos += 1;
        }
        self.pos = self.toks.len() - 1;
    }

    fn ident(&mut self, what: &str) -> DResult<(String, Span)> {
        match self.peek_tok().clone() {
            Tok::Ident(s) => {
                let sp = self.bump().span;
                Ok((s, sp))
            }
            _ => self.unexpected(what),
        }
    }

    fn upper(&mut self, what: &str) -> DResult<(String, Span)> {
        match self.peek_tok().clone() {
            Tok::Upper(s) => {
                let sp = self.bump().span;
                Ok((s, sp))
            }
            _ => self.unexpected(what),
        }
    }

    fn string_lit(&mut self, what: &str) -> DResult<String> {
        match self.peek_tok().clone() {
            Tok::Str(s) => {
                self.bump();
                Ok(s)
            }
            _ => self.unexpected(what),
        }
    }

    fn decl(&mut self) -> DResult<Decl> {
        let start = self.span();
        match self.peek_tok().clone() {
            Tok::Keyword(Kw::Import) => {
                self.bump();
                let (m, _) = self.ident("module name")?;
                Ok(Decl::Import {
                    span: start,
                    module: m,
                })
            }
            Tok::Keyword(Kw::Export) => {
                self.bump();
                let (name, sp) = self.ident("name to export")?;
                if self.at_sym(Sym::Colon) && !self.at_boundary_strict() {
                    let sig = self.sig_rest(name, sp)?;
                    Ok(Decl::Sig { sig, export: true })
                } else {
                    Ok(Decl::Export { span: sp, name })
                }
            }
            Tok::Keyword(Kw::Test) => {
                self.bump();
                let name = self.string_lit("test name string")?;
                self.expect_sym(Sym::Eq)?;
                let body = self.expr()?;
                Ok(Decl::Test {
                    span: start,
                    name,
                    body,
                })
            }
            Tok::Keyword(Kw::Macro) => {
                self.bump();
                let (name, sp) = self.ident("macro name")?;
                self.expect_sym(Sym::Eq)?;
                let body = self.expr()?;
                Ok(Decl::Macro(Binding {
                    name,
                    span: sp,
                    rec: false,
                    body,
                }))
            }
            Tok::Keyword(Kw::Foreign) => {
                self.bump();
                let abi = self.string_lit("ABI string such as \"C\"")?;
                let (name, sp) = self.ident("foreign function name")?;
                self.expect_sym(Sym::Colon)?;
                let ty = self.ty()?;
                let constraints = self.where_clause()?;
                let symbol = if self.eat_sym(Sym::Eq) {
                    self.string_lit("symbol name")?
                } else {
                    name.clone()
                };
                let variadic = if matches!(self.peek_tok(), Tok::Ident(s) if s == "variadic")
                    && !self.at_boundary_strict()
                {
                    self.bump();
                    match self.peek_tok().clone() {
                        Tok::Int { mag, .. } => {
                            self.bump();
                            Some(mag as u32)
                        }
                        _ => {
                            return Err(Diagnostic::error(
                                self.span(),
                                "expected the number of fixed parameters after `variadic`",
                            ))
                        }
                    }
                } else {
                    None
                };
                Ok(Decl::Foreign {
                    span: sp,
                    abi,
                    name,
                    symbol,
                    variadic,
                    ty,
                    constraints,
                })
            }
            Tok::Ident(s) if s == "repr" => {
                self.bump();
                self.expect_sym(Sym::LParen)?;
                let (r, rsp) = self.upper("representation (`C`)")?;
                if r != "C" {
                    return Err(Diagnostic::error(rsp, "only `repr(C)` is supported"));
                }
                self.expect_sym(Sym::RParen)?;
                let mut td = self.type_decl()?;
                if !matches!(td.body, TypeBody::Record(_)) {
                    return Err(Diagnostic::error(
                        td.span,
                        "`repr(C)` applies to record types",
                    ));
                }
                td.repr_c = true;
                Ok(Decl::Type(td))
            }
            Tok::Keyword(Kw::Resource) => {
                self.bump();
                let mut td = self.type_decl()?;
                td.resource = true;
                Ok(Decl::Type(td))
            }
            Tok::Upper(_) => Ok(Decl::Type(self.type_decl()?)),
            Tok::Keyword(Kw::Trait) => self.trait_decl(),
            Tok::Keyword(Kw::Impl) => self.impl_decl(),
            Tok::Keyword(Kw::Rec) if matches!(self.peek_at(2), Tok::Sym(Sym::Colon)) => {
                // `rec name : T` marks the following binding as recursive.
                self.bump();
                let (name, sp) = self.ident("name")?;
                self.rec_sigs.push(name.clone());
                let sig = self.sig_rest(name, sp)?;
                Ok(Decl::Sig { sig, export: false })
            }
            Tok::Keyword(Kw::Rec) => Ok(Decl::Bind(self.binding()?)),
            Tok::Ident(_) => {
                if matches!(self.peek_at(1), Tok::Sym(Sym::Colon)) {
                    let (name, sp) = self.ident("name")?;
                    let sig = self.sig_rest(name, sp)?;
                    Ok(Decl::Sig { sig, export: false })
                } else {
                    Ok(Decl::Bind(self.binding()?))
                }
            }
            _ => self.unexpected("a declaration"),
        }
    }

    fn sig_rest(&mut self, name: String, span: Span) -> DResult<Sig> {
        self.expect_sym(Sym::Colon)?;
        let ty = self.ty()?;
        let constraints = self.where_clause()?;
        Ok(Sig {
            name,
            span,
            ty,
            constraints,
        })
    }

    fn where_clause(&mut self) -> DResult<Vec<Constraint>> {
        let mut cs = Vec::new();
        if self.at_kw(Kw::Where) && !self.at_boundary_strict() {
            self.bump();
            loop {
                cs.push(self.constraint()?);
                if !self.eat_sym(Sym::Comma) {
                    break;
                }
            }
        }
        Ok(cs)
    }

    fn constraint(&mut self) -> DResult<Constraint> {
        let (name, sp) = self.upper("trait name")?;
        let args = self.type_args()?;
        Ok(Constraint {
            span: sp,
            trait_name: name,
            args,
        })
    }

    fn binding(&mut self) -> DResult<Binding> {
        let rec = if self.at_kw(Kw::Rec) {
            self.bump();
            true
        } else {
            false
        };
        let (name, sp) = self.ident("binding name")?;
        self.expect_sym(Sym::Eq)?;
        let body = self.expr()?;
        let rec = rec || self.rec_sigs.contains(&name);
        Ok(Binding {
            name,
            span: sp,
            rec,
            body,
        })
    }

    fn type_params(&mut self) -> DResult<Vec<String>> {
        let mut ps = Vec::new();
        if self.at_sym(Sym::LBracket) && !self.at_boundary_strict() {
            self.bump();
            loop {
                match self.peek_tok().clone() {
                    Tok::Upper(s) | Tok::Ident(s) => {
                        self.bump();
                        ps.push(s);
                    }
                    _ => return self.unexpected("type parameter"),
                }
                if !self.eat_sym(Sym::Comma) {
                    break;
                }
            }
            self.expect_sym(Sym::RBracket)?;
        }
        Ok(ps)
    }

    fn type_decl(&mut self) -> DResult<TypeDecl> {
        let (name, span) = self.upper("type name")?;
        let params = self.type_params()?;
        self.expect_sym(Sym::Eq)?;
        let body = if self.at_sym(Sym::Pipe) {
            let mut vs = Vec::new();
            while self.at_sym(Sym::Pipe) && !self.at_boundary_strict() {
                self.bump();
                let (vname, vspan) = self.upper("variant name")?;
                let mut fields = Vec::new();
                while !self.at_boundary_strict()
                    && !self.at_sym(Sym::Pipe)
                    && !self.at(&Tok::Eof)
                    && self.can_start_type_atom()
                {
                    fields.push(self.btype()?);
                }
                vs.push(Variant {
                    name: vname,
                    span: vspan,
                    fields,
                });
            }
            TypeBody::Variants(vs)
        } else if self.at_sym(Sym::LBrace) {
            let t = self.ty()?;
            let tspan = t.span;
            match t.kind {
                TypeKind::Record(fields, None) => TypeBody::Record(fields),
                TypeKind::Unit => TypeBody::Record(vec![]),
                TypeKind::Record(_, Some(_)) => {
                    return Err(Diagnostic::error(
                        span,
                        "a nominal record declaration cannot have a row tail",
                    ))
                }
                // `{ x: I64 } -> I64`: an alias of some other type
                kind => TypeBody::Alias(TypeExpr { span: tspan, kind }),
            }
        } else if matches!(self.peek_tok(), Tok::Ident(s) if s == "builtin") {
            self.bump();
            TypeBody::Opaque
        } else {
            TypeBody::Alias(self.ty()?)
        };
        Ok(TypeDecl {
            name,
            span,
            params,
            body,
            resource: false,
            repr_c: false,
        })
    }

    /// Parse a layout block of items, starting at the next token's column.
    fn block<T>(&mut self, mut item: impl FnMut(&mut Self) -> DResult<T>) -> DResult<Vec<T>> {
        let mut items = Vec::new();
        if self.at_sym(Sym::LBrace) {
            self.bump();
            self.with_layout(0, |p| {
                while !p.at_sym(Sym::RBrace) {
                    items.push(item(p)?);
                    if !p.eat_sym(Sym::Comma) && !p.eat_sym(Sym::Semi) {
                        break;
                    }
                }
                p.expect_sym(Sym::RBrace)?;
                Ok(())
            })?;
            return Ok(items);
        }
        let first = self.peek().clone();
        if first.tok == Tok::Eof || (first.bol && first.span.col <= self.layout_col()) {
            return Ok(items);
        }
        let col = first.span.col;
        self.with_layout(col, |p| {
            loop {
                items.push(item(p)?);
                let t = p.peek();
                if t.bol && t.span.col == col && t.tok != Tok::Eof {
                    continue;
                }
                break;
            }
            Ok(())
        })?;
        Ok(items)
    }

    fn trait_decl(&mut self) -> DResult<Decl> {
        self.bump();
        let (name, span) = self.upper("trait name")?;
        let params = self.type_params()?;
        let mut supers = Vec::new();
        if self.eat_sym(Sym::Colon) {
            loop {
                supers.push(self.constraint()?);
                if !self.eat_sym(Sym::Comma) {
                    break;
                }
            }
        }
        self.expect_sym(Sym::Eq)?;
        enum Item {
            S(Sig),
            D(Binding),
        }
        let items = self.block(|p| {
            if matches!(p.peek_at(1), Tok::Sym(Sym::Colon)) {
                let (n, sp) = p.ident("method name")?;
                Ok(Item::S(p.sig_rest(n, sp)?))
            } else {
                Ok(Item::D(p.binding()?))
            }
        })?;
        let mut methods = Vec::new();
        let mut defaults = Vec::new();
        for it in items {
            match it {
                Item::S(s) => methods.push(s),
                Item::D(d) => defaults.push(d),
            }
        }
        Ok(Decl::Trait(TraitDecl {
            name,
            span,
            params,
            supers,
            methods,
            defaults,
        }))
    }

    fn impl_decl(&mut self) -> DResult<Decl> {
        let span = self.bump().span;
        let (trait_name, _) = self.upper("trait name")?;
        let args = self.type_args()?;
        let constraints = self.where_clause()?;
        self.expect_sym(Sym::Eq)?;
        let bindings = self.block(|p| p.binding())?;
        Ok(Decl::Impl(ImplDecl {
            span,
            trait_name,
            args,
            constraints,
            bindings,
        }))
    }

    // ----- types ---------------------------------------------------------

    fn can_start_type_atom(&self) -> bool {
        matches!(
            self.peek_tok(),
            Tok::Upper(_)
                | Tok::Ident(_)
                | Tok::Int { .. }
                | Tok::Sym(Sym::LParen)
                | Tok::Sym(Sym::LBrace)
        )
    }

    fn type_args(&mut self) -> DResult<Vec<TypeExpr>> {
        let mut args = Vec::new();
        if self.at_sym(Sym::LBracket) && !self.at_boundary_strict() {
            self.bump();
            self.with_layout(0, |p| {
                if !p.at_sym(Sym::RBracket) {
                    loop {
                        args.push(p.size_sum()?);
                        if !p.eat_sym(Sym::Comma) {
                            break;
                        }
                    }
                }
                p.expect_sym(Sym::RBracket)?;
                Ok(())
            })?;
        }
        Ok(args)
    }

    /// A type argument: a type, or a sum of products of sizes
    /// (`n + m`, `2 * n + 1`), `*` binding tighter.
    fn size_sum(&mut self) -> DResult<TypeExpr> {
        let mut lhs = self.size_product()?;
        while self.eat_sym(Sym::Plus) {
            let rhs = self.size_product()?;
            let span = lhs.span;
            lhs = TypeExpr {
                span,
                kind: TypeKind::NatOp(NatOp::Add, Box::new(lhs), Box::new(rhs)),
            };
        }
        Ok(lhs)
    }

    fn size_product(&mut self) -> DResult<TypeExpr> {
        let mut lhs = self.ty()?;
        while self.eat_sym(Sym::Star) {
            let rhs = self.ty()?;
            let span = lhs.span;
            lhs = TypeExpr {
                span,
                kind: TypeKind::NatOp(NatOp::Mul, Box::new(lhs), Box::new(rhs)),
            };
        }
        Ok(lhs)
    }

    /// Full type, including arrows and effect annotations.
    pub fn ty(&mut self) -> DResult<TypeExpr> {
        let lhs = self.btype()?;
        if self.at_sym(Sym::Arrow) && !self.at_boundary_strict() {
            self.bump();
            let rhs = self.ty()?;
            let rhs_is_fun = matches!(rhs.kind, TypeKind::Fun(..));
            let eff = if !rhs_is_fun && self.at_sym(Sym::Bang) && !self.at_boundary_strict() {
                self.bump();
                Some(self.effects()?)
            } else {
                None
            };
            let span = lhs.span;
            return Ok(TypeExpr {
                span,
                kind: TypeKind::Fun(Box::new(lhs), Box::new(rhs), eff),
            });
        }
        Ok(lhs)
    }

    fn effects(&mut self) -> DResult<EffExpr> {
        let span = self.span();
        if let Tok::Ident(v) = self.peek_tok().clone() {
            self.bump();
            return Ok(EffExpr {
                span,
                labels: vec![],
                tail: Some(v),
            });
        }
        self.expect_sym(Sym::LBrace)?;
        self.with_layout(0, |p| {
            let mut labels = Vec::new();
            let mut tail = None;
            while !p.at_sym(Sym::RBrace) && !p.at_sym(Sym::Pipe) {
                let (name, _) = p.upper("effect name")?;
                let args = p.type_args()?;
                labels.push((name, args));
                if !p.eat_sym(Sym::Comma) {
                    break;
                }
            }
            if p.eat_sym(Sym::Pipe) {
                let (v, _) = p.ident("effect row variable")?;
                tail = Some(v);
            }
            p.expect_sym(Sym::RBrace)?;
            Ok(EffExpr { span, labels, tail })
        })
    }

    /// Type without top-level arrows.
    fn btype(&mut self) -> DResult<TypeExpr> {
        let span = self.span();
        match self.peek_tok().clone() {
            Tok::Upper(name) | Tok::Ident(name) => {
                self.bump();
                let args = self.type_args()?;
                Ok(TypeExpr {
                    span,
                    kind: TypeKind::Name(name, args),
                })
            }
            Tok::Underscore => {
                // an abstract size
                self.bump();
                Ok(TypeExpr {
                    span,
                    kind: TypeKind::Name("_".into(), vec![]),
                })
            }
            Tok::Int {
                neg: false, mag, ..
            } => {
                self.bump();
                Ok(TypeExpr {
                    span,
                    kind: TypeKind::Nat(mag as u64),
                })
            }
            Tok::Sym(Sym::LParen) => {
                self.bump();
                self.with_layout(0, |p| {
                    if p.eat_sym(Sym::RParen) {
                        return Ok(TypeExpr {
                            span,
                            kind: TypeKind::Unit,
                        });
                    }
                    let first = p.size_sum()?;
                    if p.at_sym(Sym::Comma) {
                        let mut items = vec![first];
                        while p.eat_sym(Sym::Comma) {
                            if p.at_sym(Sym::RParen) {
                                break;
                            }
                            items.push(p.ty()?);
                        }
                        p.expect_sym(Sym::RParen)?;
                        Ok(TypeExpr {
                            span,
                            kind: TypeKind::Tuple(items),
                        })
                    } else {
                        p.expect_sym(Sym::RParen)?;
                        Ok(first)
                    }
                })
            }
            Tok::Sym(Sym::LBrace) => {
                self.bump();
                self.with_layout(0, |p| {
                    let mut fields = Vec::new();
                    let mut tail = None;
                    while !p.at_sym(Sym::RBrace) && !p.at_sym(Sym::Pipe) {
                        let fname = match p.peek_tok().clone() {
                            Tok::Ident(s) => s,
                            Tok::Int { mag, .. } => mag.to_string(),
                            _ => return p.unexpected("field name"),
                        };
                        p.bump();
                        p.expect_sym(Sym::Colon)?;
                        let t = p.ty()?;
                        fields.push((fname, t));
                        if !p.eat_sym(Sym::Comma) {
                            break;
                        }
                    }
                    if p.eat_sym(Sym::Pipe) {
                        let (v, _) = p.ident("row variable")?;
                        tail = Some(v);
                    }
                    p.expect_sym(Sym::RBrace)?;
                    if fields.is_empty() && tail.is_none() {
                        return Ok(TypeExpr {
                            span,
                            kind: TypeKind::Unit,
                        });
                    }
                    Ok(TypeExpr {
                        span,
                        kind: TypeKind::Record(fields, tail),
                    })
                })
            }
            _ => self.unexpected("a type"),
        }
    }

    // ----- expressions ---------------------------------------------------

    pub fn expr(&mut self) -> DResult<Expr> {
        if self.at_kw(Kw::Comptime) && !self.at_boundary_strict() {
            let sp = self.bump().span;
            let e = self.expr()?;
            return Ok(self.mk(sp, ExprKind::Comptime(Box::new(e))));
        }
        let mut lhs = self.app()?;
        while self.at_sym(Sym::Pipe) && !self.at_boundary_strict() {
            let psp = self.bump().span;
            let rhs = if self.at_kw(Kw::Comptime) {
                let sp = self.bump().span;
                let e = self.app()?;
                self.mk(sp, ExprKind::Comptime(Box::new(e)))
            } else {
                self.app()?
            };
            let span = Span { len: 1, ..psp };
            lhs = self.mk(span, ExprKind::Pipe(Box::new(lhs), Box::new(rhs)));
        }
        Ok(lhs)
    }

    fn app(&mut self) -> DResult<Expr> {
        if self.at_expr_end() {
            return self.unexpected("an expression");
        }
        let f = self.atom()?;
        let mut args = Vec::new();
        while !self.at_expr_end() {
            args.push(self.atom()?);
        }
        if args.is_empty() {
            Ok(f)
        } else {
            let span = f.span;
            Ok(self.mk(span, ExprKind::App(Box::new(f), args)))
        }
    }

    fn fields(&mut self, close: Sym) -> DResult<Vec<(String, Expr)>> {
        let mut fs = Vec::new();
        while !self.at_sym(close) {
            let name = match self.peek_tok().clone() {
                Tok::Ident(s) => s,
                Tok::Int {
                    mag, neg: false, ..
                } => mag.to_string(),
                _ => return self.unexpected("field name"),
            };
            let sp = self.bump().span;
            self.expect_sym(Sym::Eq)?;
            let e = self.expr()?;
            if fs.iter().any(|(n, _): &(String, Expr)| *n == name) {
                return Err(Diagnostic::error(sp, format!("duplicate field `{}`", name)));
            }
            fs.push((name, e));
            if !self.eat_sym(Sym::Comma) {
                break;
            }
        }
        self.expect_sym(close)?;
        Ok(fs)
    }

    fn atom(&mut self) -> DResult<Expr> {
        let t = self.bump();
        let span = t.span;
        let kind = match t.tok {
            Tok::Int { neg, mag, suffix } => ExprKind::Int { neg, mag, suffix },
            Tok::Float {
                value,
                value32,
                suffix,
            } => ExprKind::Float {
                value,
                value32,
                suffix,
            },
            Tok::Str(s) => ExprKind::Str(s),
            Tok::Trits(t) => ExprKind::Trits(t),
            Tok::Duration(d) => ExprKind::Duration(d),
            Tok::Ident(s) => ExprKind::Var(s),
            Tok::Selector(p) => ExprKind::Selector(p),
            Tok::Upper(s) => {
                if self.at_sym(Sym::LBrace) && !self.at_boundary_strict() {
                    self.bump();
                    let fs = self.with_layout(0, |p| p.fields(Sym::RBrace))?;
                    ExprKind::NominalRecord(s, fs)
                } else {
                    ExprKind::Ctor(s)
                }
            }
            Tok::MacroCall(name) => {
                let args = self.with_layout(0, |p| {
                    let mut args = Vec::new();
                    while !p.at_sym(Sym::RParen) {
                        args.push(p.expr()?);
                        if !p.eat_sym(Sym::Comma) {
                            break;
                        }
                    }
                    p.expect_sym(Sym::RParen)?;
                    Ok(args)
                })?;
                ExprKind::MacroCall(name, args)
            }
            Tok::Sym(Sym::LParen) => {
                return self.with_layout(0, |p| {
                    if p.at_sym(Sym::RParen) {
                        let end = p.bump().span;
                        return Ok(p.mk(join(span, end), ExprKind::Unit));
                    }
                    let first = p.expr()?;
                    if p.at_sym(Sym::Comma) {
                        let mut items = vec![first];
                        while p.eat_sym(Sym::Comma) {
                            if p.at_sym(Sym::RParen) {
                                break;
                            }
                            items.push(p.expr()?);
                        }
                        let end = p.expect_sym(Sym::RParen)?;
                        Ok(p.mk(join(span, end), ExprKind::Tuple(items)))
                    } else {
                        p.expect_sym(Sym::RParen)?;
                        Ok(first)
                    }
                });
            }
            Tok::Sym(Sym::LBracket) => {
                let items = self.with_layout(0, |p| {
                    let mut items = Vec::new();
                    while !p.at_sym(Sym::RBracket) {
                        items.push(p.expr()?);
                        if !p.eat_sym(Sym::Comma) {
                            break;
                        }
                    }
                    p.expect_sym(Sym::RBracket)?;
                    Ok(items)
                })?;
                ExprKind::List(items)
            }
            Tok::Sym(Sym::LBrace) => {
                let fs = self.with_layout(0, |p| p.fields(Sym::RBrace))?;
                if fs.is_empty() {
                    ExprKind::Unit
                } else {
                    ExprKind::Record(fs)
                }
            }
            Tok::Keyword(Kw::With) => {
                self.expect_sym(Sym::LBrace)?;
                let fs = self.with_layout(0, |p| p.fields(Sym::RBrace))?;
                if fs.is_empty() {
                    return Err(Diagnostic::error(span, "`with` needs at least one field"));
                }
                ExprKind::With(fs)
            }
            Tok::Keyword(Kw::Make) => {
                let nominal = match self.peek_tok().clone() {
                    Tok::Upper(n) => {
                        self.bump();
                        Some(n)
                    }
                    _ => None,
                };
                self.expect_sym(Sym::LBrace)?;
                let fs = self.with_layout(0, |p| p.fields(Sym::RBrace))?;
                if fs.is_empty() && nominal.is_none() {
                    return Err(Diagnostic::error(span, "`make` needs at least one field"));
                }
                ExprKind::Make(nominal, fs)
            }
            Tok::Keyword(Kw::Update) => {
                self.expect_sym(Sym::LBrace)?;
                let fs = self.with_layout(0, |p| p.fields(Sym::RBrace))?;
                if fs.is_empty() {
                    return Err(Diagnostic::error(span, "`update` needs at least one field"));
                }
                ExprKind::Update(fs)
            }
            Tok::Keyword(Kw::Quote) => {
                let e = self.atom()?;
                ExprKind::Quote(Box::new(e))
            }
            Tok::Keyword(Kw::Comptime) => {
                let e = self.atom()?;
                ExprKind::Comptime(Box::new(e))
            }
            Tok::Keyword(Kw::Type) => {
                if !self.at_sym(Sym::LBracket) {
                    return self.unexpected("`[` after `type`");
                }
                self.bump();
                let ty = self.with_layout(0, |p| {
                    let t = p.ty()?;
                    p.expect_sym(Sym::RBracket)?;
                    Ok(t)
                })?;
                ExprKind::TypeOf(ty)
            }
            Tok::Keyword(Kw::Match) => ExprKind::Match(self.match_arms(span)?),
            other => {
                return Err(Diagnostic::error(
                    span,
                    format!("expected an expression, found {}", other.describe()),
                ))
            }
        };
        Ok(self.mk(span, kind))
    }

    fn match_arms(&mut self, span: Span) -> DResult<Vec<Arm>> {
        let arms = self.block(|p| {
            let pat = p.pattern()?;
            p.expect_sym(Sym::Arrow)?;
            let body = p.expr()?;
            Ok(Arm { pat, body })
        })?;
        if arms.is_empty() {
            return Err(Diagnostic::error(span, "`match` needs at least one arm"));
        }
        Ok(arms)
    }

    // ----- patterns ------------------------------------------------------

    fn pattern(&mut self) -> DResult<Pattern> {
        let span = self.span();
        if let Tok::Upper(name) = self.peek_tok().clone() {
            self.bump();
            let mut args = Vec::new();
            while !self.at_sym(Sym::Arrow)
                && !self.at_sym(Sym::Comma)
                && !self.at_sym(Sym::RParen)
                && !self.at_boundary_strict()
                && !self.at(&Tok::Eof)
            {
                args.push(self.pat_atom()?);
            }
            let args = if args.is_empty() { None } else { Some(args) };
            let id = self.new_id();
            return Ok(Pattern {
                id,
                span,
                kind: PatKind::Ctor(name, args),
            });
        }
        self.pat_atom()
    }

    fn pat_atom(&mut self) -> DResult<Pattern> {
        let span = self.span();
        let t = self.bump();
        let kind = match t.tok {
            Tok::Underscore => PatKind::Hole,
            Tok::Int {
                neg,
                mag,
                suffix: None,
            } => PatKind::Int { neg, mag },
            Tok::Int {
                suffix: Some(sfx), ..
            } => {
                return Err(Diagnostic::error(
                    span,
                    format!(
                        "integer patterns take no suffix (`{}`); their type comes from the value matched",
                        sfx
                    ),
                ))
            }
            Tok::Str(s) => PatKind::Str(s),
            Tok::Upper(name) => PatKind::Ctor(name, None),
            Tok::Sym(Sym::LParen) => {
                return self.with_layout(0, |p| {
                    if p.eat_sym(Sym::RParen) {
                        let id = p.new_id();
                        return Ok(Pattern {
                            id,
                            span,
                            kind: PatKind::Unit,
                        });
                    }
                    let first = p.pattern()?;
                    if p.at_sym(Sym::Comma) {
                        let mut items = vec![first];
                        while p.eat_sym(Sym::Comma) {
                            if p.at_sym(Sym::RParen) {
                                break;
                            }
                            items.push(p.pattern()?);
                        }
                        p.expect_sym(Sym::RParen)?;
                        let id = p.new_id();
                        Ok(Pattern {
                            id,
                            span,
                            kind: PatKind::Tuple(items),
                        })
                    } else {
                        p.expect_sym(Sym::RParen)?;
                        Ok(first)
                    }
                })
            }
            other => {
                return Err(Diagnostic::error(
                    span,
                    format!("expected a pattern, found {}", other.describe()),
                ))
            }
        };
        let id = self.new_id();
        Ok(Pattern { id, span, kind })
    }
}
