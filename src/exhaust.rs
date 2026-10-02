//! Pattern exhaustiveness and redundancy (Maranget's usefulness algorithm),
//! producing a witness for missing cases.

use crate::env::{Env, TypeDefKind};

#[derive(Clone, Debug, PartialEq)]
pub enum Pat {
    Wild,
    /// Canonical constructor name and argument patterns.
    Ctor(String, Vec<Pat>),
    Lit(String),
    Tuple(Vec<Pat>),
}

fn ctor_arity(env: &Env, c: &str) -> usize {
    env.ctors[c].fields.len()
}

fn siblings(env: &Env, c: &str) -> Vec<String> {
    let t = &env.ctors[c].type_name;
    match &env.types[t].kind {
        TypeDefKind::Adt { ctors } => ctors.clone(),
        _ => vec![c.to_string()],
    }
}

fn wilds(n: usize) -> Vec<Pat> {
    vec![Pat::Wild; n]
}

fn specialize_ctor(rows: &[Vec<Pat>], c: &str, k: usize) -> Vec<Vec<Pat>> {
    let mut out = Vec::new();
    for r in rows {
        match &r[0] {
            Pat::Ctor(c2, args) if c2 == c => {
                let mut nr = args.clone();
                nr.extend_from_slice(&r[1..]);
                out.push(nr);
            }
            Pat::Wild => {
                let mut nr = wilds(k);
                nr.extend_from_slice(&r[1..]);
                out.push(nr);
            }
            _ => {}
        }
    }
    out
}

fn specialize_tuple(rows: &[Vec<Pat>], k: usize) -> Vec<Vec<Pat>> {
    let mut out = Vec::new();
    for r in rows {
        match &r[0] {
            Pat::Tuple(args) => {
                let mut nr = args.clone();
                nr.extend_from_slice(&r[1..]);
                out.push(nr);
            }
            Pat::Wild => {
                let mut nr = wilds(k);
                nr.extend_from_slice(&r[1..]);
                out.push(nr);
            }
            _ => {}
        }
    }
    out
}

fn specialize_lit(rows: &[Vec<Pat>], l: &str) -> Vec<Vec<Pat>> {
    rows.iter()
        .filter(|r| matches!(&r[0], Pat::Wild) || matches!(&r[0], Pat::Lit(x) if x == l))
        .map(|r| r[1..].to_vec())
        .collect()
}

fn default_rows(rows: &[Vec<Pat>]) -> Vec<Vec<Pat>> {
    rows.iter()
        .filter(|r| matches!(r[0], Pat::Wild))
        .map(|r| r[1..].to_vec())
        .collect()
}

/// If `q` is useful with respect to `rows` (matches some value none of the
/// rows match), return a witness vector.
pub fn useful(env: &Env, rows: &[Vec<Pat>], q: &[Pat]) -> Option<Vec<Pat>> {
    if q.is_empty() {
        return if rows.is_empty() { Some(vec![]) } else { None };
    }
    let rest = &q[1..];
    match &q[0] {
        Pat::Ctor(c, args) => {
            let k = args.len();
            let spec = specialize_ctor(rows, c, k);
            let mut nq = args.clone();
            nq.extend_from_slice(rest);
            useful(env, &spec, &nq).map(|w| rebuild_ctor(c, k, w))
        }
        Pat::Tuple(args) => {
            let k = args.len();
            let spec = specialize_tuple(rows, k);
            let mut nq = args.clone();
            nq.extend_from_slice(rest);
            useful(env, &spec, &nq).map(|w| rebuild_tuple(k, w))
        }
        Pat::Lit(l) => {
            let spec = specialize_lit(rows, l);
            useful(env, &spec, rest).map(|mut w| {
                w.insert(0, Pat::Lit(l.clone()));
                w
            })
        }
        Pat::Wild => {
            let heads: Vec<&Pat> = rows.iter().map(|r| &r[0]).collect();
            if let Some(Pat::Tuple(args)) = heads.iter().find(|p| matches!(p, Pat::Tuple(_))) {
                let k = args.len();
                let spec = specialize_tuple(rows, k);
                let mut nq = wilds(k);
                nq.extend_from_slice(rest);
                return useful(env, &spec, &nq).map(|w| rebuild_tuple(k, w));
            }
            if let Some(Pat::Ctor(c0, _)) = heads.iter().find(|p| matches!(p, Pat::Ctor(..))) {
                let all = siblings(env, c0);
                let present: Vec<&String> = heads
                    .iter()
                    .filter_map(|p| match p {
                        Pat::Ctor(c, _) => Some(c),
                        _ => None,
                    })
                    .collect();
                let missing: Vec<&String> = all.iter().filter(|c| !present.contains(c)).collect();
                if missing.is_empty() {
                    for c in &all {
                        let k = ctor_arity(env, c);
                        let spec = specialize_ctor(rows, c, k);
                        let mut nq = wilds(k);
                        nq.extend_from_slice(rest);
                        if let Some(w) = useful(env, &spec, &nq) {
                            return Some(rebuild_ctor(c, k, w));
                        }
                    }
                    return None;
                }
                let def = default_rows(rows);
                return useful(env, &def, rest).map(|mut w| {
                    let c = missing[0];
                    w.insert(0, Pat::Ctor(c.clone(), wilds(ctor_arity(env, c))));
                    w
                });
            }
            let def = default_rows(rows);
            useful(env, &def, rest).map(|mut w| {
                w.insert(0, Pat::Wild);
                w
            })
        }
    }
}

fn rebuild_ctor(c: &str, k: usize, mut w: Vec<Pat>) -> Vec<Pat> {
    let rest = w.split_off(k);
    let mut out = vec![Pat::Ctor(c.to_string(), w)];
    out.extend(rest);
    out
}

fn rebuild_tuple(k: usize, mut w: Vec<Pat>) -> Vec<Pat> {
    let rest = w.split_off(k);
    let mut out = vec![Pat::Tuple(w)];
    out.extend(rest);
    out
}

pub fn show(p: &Pat) -> String {
    match p {
        Pat::Wild => "_".into(),
        Pat::Lit(l) => l.clone(),
        Pat::Tuple(ps) => format!("({})", ps.iter().map(show).collect::<Vec<_>>().join(", ")),
        Pat::Ctor(c, args) => {
            let short = c.rsplit('.').next().unwrap_or(c).to_string();
            let short = short.rsplit("::").next().unwrap().to_string();
            let mut s = short;
            for a in args {
                s.push(' ');
                match a {
                    Pat::Ctor(_, xs) if !xs.is_empty() => s.push_str(&format!("({})", show(a))),
                    _ => s.push_str(&show(a)),
                }
            }
            s
        }
    }
}
