//! Pretty printing of the AST as fully-parenthesized fwp source. Used by
//! `fwp check --parse`, for snapshot tests, and for displaying `Syntax`.

use crate::ast::*;

pub fn module(m: &Module) -> String {
    m.decls.iter().map(|d| decl(d) + "\n").collect()
}

pub fn decl(d: &Decl) -> String {
    match d {
        Decl::Import { module, .. } => format!("import {}", module),
        Decl::Sig { sig: s, export } => {
            format!("{}{}", if *export { "export " } else { "" }, sig(s))
        }
        Decl::Export { name, .. } => format!("export {}", name),
        Decl::Bind(b) => binding(b),
        Decl::Macro(b) => format!("macro {}", binding(b)),
        Decl::Type(t) => {
            let head = format!(
                "{}{}{}",
                if t.repr_c {
                    "repr(C) "
                } else if t.resource {
                    "resource "
                } else {
                    ""
                },
                t.name,
                params(&t.params)
            );
            match &t.body {
                TypeBody::Variants(vs) => {
                    let vs: Vec<String> = vs
                        .iter()
                        .map(|v| {
                            let mut s = format!("| {}", v.name);
                            for f in &v.fields {
                                s.push(' ');
                                s.push_str(&ty_atom(f));
                            }
                            s
                        })
                        .collect();
                    format!("{} = {}", head, vs.join(" "))
                }
                TypeBody::Record(fs) => format!("{} = {}", head, record_ty(fs, &None)),
                TypeBody::Alias(t) => format!("{} = {}", head, ty(t)),
                TypeBody::Opaque => format!("{} = builtin", head),
            }
        }
        Decl::Trait(t) => {
            let mut s = format!("trait {}{}", t.name, params(&t.params));
            if !t.supers.is_empty() {
                s.push_str(" : ");
                s.push_str(&constraints(&t.supers));
            }
            s.push_str(" = {");
            let mut items: Vec<String> = t.methods.iter().map(sig).collect();
            items.extend(t.defaults.iter().map(binding));
            s.push_str(&items.join(", "));
            s.push('}');
            s
        }
        Decl::Impl(i) => {
            let mut s = format!("impl {}[{}]", i.trait_name, tys(&i.args));
            if !i.constraints.is_empty() {
                s.push_str(" where ");
                s.push_str(&constraints(&i.constraints));
            }
            let bs: Vec<String> = i.bindings.iter().map(binding).collect();
            s.push_str(&format!(" = {{{}}}", bs.join(", ")));
            s
        }
        Decl::Foreign {
            abi,
            name,
            symbol,
            variadic,
            ty: t,
            constraints: cs,
            ..
        } => {
            let w = if cs.is_empty() {
                String::new()
            } else {
                format!(" where {}", constraints(cs))
            };
            let v = match variadic {
                Some(n) => format!(" variadic {}", n),
                None => String::new(),
            };
            format!(
                "foreign {:?} {} : {}{} = {:?}{}",
                abi,
                name,
                ty(t),
                w,
                symbol,
                v
            )
        }
        Decl::Test { name, body, .. } => format!("test {:?} = {}", name, expr(body)),
    }
}

fn params(ps: &[String]) -> String {
    if ps.is_empty() {
        String::new()
    } else {
        format!("[{}]", ps.join(", "))
    }
}

fn sig(s: &Sig) -> String {
    let mut out = format!("{} : {}", s.name, ty(&s.ty));
    if !s.constraints.is_empty() {
        out.push_str(" where ");
        out.push_str(&constraints(&s.constraints));
    }
    out
}

fn constraints(cs: &[Constraint]) -> String {
    cs.iter()
        .map(|c| format!("{}[{}]", c.trait_name, tys(&c.args)))
        .collect::<Vec<_>>()
        .join(", ")
}

fn binding(b: &Binding) -> String {
    format!(
        "{}{} = {}",
        if b.rec { "rec " } else { "" },
        b.name,
        expr(&b.body)
    )
}

fn tys(ts: &[TypeExpr]) -> String {
    ts.iter().map(ty).collect::<Vec<_>>().join(", ")
}

pub fn ty(t: &TypeExpr) -> String {
    match &t.kind {
        TypeKind::Fun(a, b, eff) => {
            let mut s = format!("{} -> {}", ty_nonarrow(a), ty(b));
            if let Some(e) = eff {
                s.push_str(" ! ");
                s.push_str(&effects(e));
            }
            s
        }
        _ => ty_atom(t),
    }
}

fn ty_nonarrow(t: &TypeExpr) -> String {
    match &t.kind {
        TypeKind::Fun(..) => format!("({})", ty(t)),
        _ => ty_atom(t),
    }
}

fn ty_atom(t: &TypeExpr) -> String {
    match &t.kind {
        TypeKind::Name(n, args) => {
            if args.is_empty() {
                n.clone()
            } else {
                format!("{}[{}]", n, tys(args))
            }
        }
        TypeKind::Fun(..) => format!("({})", ty(t)),
        TypeKind::Unit => "()".into(),
        TypeKind::Tuple(ts) => format!("({})", tys(ts)),
        TypeKind::Record(fs, tail) => record_ty(fs, tail),
        TypeKind::Nat(n) => n.to_string(),
    }
}

fn record_ty(fs: &[(String, TypeExpr)], tail: &Option<String>) -> String {
    let fs: Vec<String> = fs
        .iter()
        .map(|(n, t)| format!("{}: {}", n, ty(t)))
        .collect();
    match tail {
        Some(t) => format!("{{{} | {}}}", fs.join(", "), t),
        None => format!("{{{}}}", fs.join(", ")),
    }
}

fn effects(e: &EffExpr) -> String {
    let ls: Vec<String> = e
        .labels
        .iter()
        .map(|(n, args)| {
            if args.is_empty() {
                n.clone()
            } else {
                format!("{}[{}]", n, tys(args))
            }
        })
        .collect();
    match (&e.tail, ls.is_empty()) {
        (Some(t), true) => t.clone(),
        (Some(t), false) => format!("{{{} | {}}}", ls.join(", "), t),
        (None, _) => format!("{{{}}}", ls.join(", ")),
    }
}

fn int_lit(neg: bool, mag: u128) -> String {
    format!("{}{}", if neg { "-" } else { "" }, mag)
}

pub fn float_lit(v: f64) -> String {
    crate::value::fmt_f64(v)
}

pub fn trits(ts: &[i8]) -> String {
    let mut s = String::from("0t");
    for t in ts {
        s.push(match t {
            1 => '+',
            -1 => '-',
            _ => '0',
        });
    }
    s
}

pub fn duration(ns: i128) -> String {
    for (unit, size) in [
        ("h", 3_600_000_000_000i128),
        ("min", 60_000_000_000),
        ("s", 1_000_000_000),
        ("ms", 1_000_000),
        ("us", 1_000),
    ] {
        if ns != 0 && ns % size == 0 {
            return format!("{}{}", ns / size, unit);
        }
    }
    format!("{}ns", ns)
}

pub fn expr(e: &Expr) -> String {
    match &e.kind {
        ExprKind::Pipe(a, b) => format!("{} | {}", expr(a), app_level(b)),
        ExprKind::Comptime(x) => format!("comptime ({})", expr(x)),
        _ => app_level(e),
    }
}

fn app_level(e: &Expr) -> String {
    match &e.kind {
        ExprKind::App(f, args) => {
            let mut s = atom(f);
            for a in args {
                s.push(' ');
                s.push_str(&atom(a));
            }
            s
        }
        _ => atom(e),
    }
}

fn fields(fs: &[(String, Expr)]) -> String {
    fs.iter()
        .map(|(n, e)| format!("{} = {}", n, expr(e)))
        .collect::<Vec<_>>()
        .join(", ")
}

pub fn atom(e: &Expr) -> String {
    match &e.kind {
        ExprKind::Int { neg, mag, suffix } => {
            format!("{}{}", int_lit(*neg, *mag), suffix.as_deref().unwrap_or(""))
        }
        ExprKind::Float { value, suffix } => {
            format!("{}{}", float_lit(*value), suffix.as_deref().unwrap_or(""))
        }
        ExprKind::Str(s) => crate::value::escape_str(s),
        ExprKind::Trits(t) => trits(t),
        ExprKind::Duration(ns) => duration(*ns),
        ExprKind::Var(v) => v.clone(),
        ExprKind::Ctor(c) => c.clone(),
        ExprKind::Selector(p) => format!(".{}", p.join(".")),
        ExprKind::App(..) | ExprKind::Pipe(..) => format!("({})", expr(e)),
        ExprKind::Unit => "()".into(),
        ExprKind::Tuple(items) => format!(
            "({})",
            items.iter().map(expr).collect::<Vec<_>>().join(", ")
        ),
        ExprKind::List(items) => format!(
            "[{}]",
            items.iter().map(expr).collect::<Vec<_>>().join(", ")
        ),
        ExprKind::Record(fs) => format!("{{{}}}", fields(fs)),
        ExprKind::NominalRecord(n, fs) => format!("{} {{{}}}", n, fields(fs)),
        ExprKind::With(fs) => format!("with {{{}}}", fields(fs)),
        ExprKind::Make(None, fs) => format!("make {{{}}}", fields(fs)),
        ExprKind::Make(Some(n), fs) => format!("make {} {{{}}}", n, fields(fs)),
        ExprKind::Update(fs) => format!("update {{{}}}", fields(fs)),
        ExprKind::Match(arms) => {
            let arms: Vec<String> = arms
                .iter()
                .map(|a| format!("{} -> {}", pattern(&a.pat), expr(&a.body)))
                .collect();
            format!("(match {{{}}})", arms.join(", "))
        }
        ExprKind::Comptime(x) => format!("(comptime {})", expr(x)),
        ExprKind::Quote(x) => format!("quote {}", atom(x)),
        ExprKind::TypeOf(t) => format!("type[{}]", ty(t)),
        ExprKind::MacroCall(n, args) => format!(
            "{}!({})",
            n,
            args.iter().map(expr).collect::<Vec<_>>().join(", ")
        ),
    }
}

pub fn pattern(p: &Pattern) -> String {
    match &p.kind {
        PatKind::Hole => "_".into(),
        PatKind::Int { neg, mag } => int_lit(*neg, *mag),
        PatKind::Str(s) => crate::value::escape_str(s),
        PatKind::Ctor(n, None) => n.clone(),
        PatKind::Ctor(n, Some(args)) => {
            let mut s = n.clone();
            for a in args {
                s.push(' ');
                match &a.kind {
                    PatKind::Ctor(_, Some(_)) => s.push_str(&format!("({})", pattern(a))),
                    _ => s.push_str(&pattern(a)),
                }
            }
            s
        }
        PatKind::Tuple(ps) => format!(
            "({})",
            ps.iter().map(pattern).collect::<Vec<_>>().join(", ")
        ),
        PatKind::Unit => "()".into(),
    }
}
