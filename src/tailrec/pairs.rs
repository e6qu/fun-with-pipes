//! A bounded prototype for two mutually recursive scalar functions.
//!
//! Each original entry selects a branch in one internal worker. Only direct
//! tail transfers change branch; non-tail calls keep ordinary call frames.
//! Scalar locals cannot hide resource cleanup. This deliberately does not
//! attempt a general strongly connected component or heterogeneous state ABI.
use crate::ir::*;
use crate::value::Value;
use std::collections::BTreeSet;

fn scalar(ty: &MT) -> bool {
    matches!(ty, MT::Con(n, xs) if xs.is_empty() && matches!(n.as_str(), "std::I64" | "std::Bool"))
        || matches!(ty, MT::Record(xs) if xs.is_empty())
}

fn eligible(e: &Expr) -> bool {
    match e {
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => true,
        Expr::Call(_, xs) | Expr::Record(xs) | Expr::Construct(_, xs) => xs.iter().all(eligible),
        Expr::Let(_, a, b) => eligible(a) && eligible(b),
        Expr::Match(s, arms) => eligible(s) && arms.iter().all(|(_, b)| eligible(b)),
        Expr::Field(a, _) => eligible(a),
        Expr::SetFields(a, fs) => eligible(a) && fs.iter().all(|(_, e)| eligible(e)),
        Expr::Apply(..)
        | Expr::Trace(..)
        | Expr::ResourceRegion { .. }
        | Expr::BorrowGlobal(..)
        | Expr::Dup(..)
        | Expr::Drop(..) => false,
    }
}

fn targets(e: &Expr, out: &mut BTreeSet<FuncId>) {
    match e {
        Expr::Call(id, _) => {
            out.insert(*id);
        }
        Expr::Let(_, _, b) => targets(b, out),
        Expr::Match(_, arms) => arms.iter().for_each(|(_, b)| targets(b, out)),
        _ => {}
    }
}

fn rename_pattern(p: &mut Pat, local: &impl Fn(Local) -> Local) {
    match p {
        Pat::Bind(l) => *l = local(*l),
        Pat::Construct(_, ps) | Pat::Record(ps) => {
            ps.iter_mut().for_each(|p| rename_pattern(p, local));
        }
        Pat::Wild | Pat::Lit(_) => {}
    }
}

fn transfer(
    e: &mut Expr,
    tail: bool,
    pair: [FuncId; 2],
    worker: FuncId,
    local: &impl Fn(Local) -> Local,
) {
    match e {
        Expr::Local(l) => *l = local(*l),
        Expr::Call(id, xs) => {
            for x in xs.iter_mut() {
                transfer(x, false, pair, worker, local);
            }
            if tail {
                if let Some(tag) = pair.iter().position(|member| member == id) {
                    xs.insert(0, Expr::Const(Value::I64(tag as i64)));
                    *id = worker;
                }
            }
        }
        Expr::Let(l, a, b) => {
            *l = local(*l);
            transfer(a, false, pair, worker, local);
            transfer(b, tail, pair, worker, local);
        }
        Expr::Match(s, arms) => {
            transfer(s, false, pair, worker, local);
            for (p, b) in arms {
                rename_pattern(p, local);
                transfer(b, tail, pair, worker, local);
            }
        }
        Expr::Record(xs) | Expr::Construct(_, xs) => {
            xs.iter_mut()
                .for_each(|x| transfer(x, false, pair, worker, local));
        }
        Expr::Field(a, _) => transfer(a, false, pair, worker, local),
        Expr::SetFields(a, fs) => {
            transfer(a, false, pair, worker, local);
            fs.iter_mut()
                .for_each(|(_, x)| transfer(x, false, pair, worker, local));
        }
        Expr::Const(_) | Expr::Func(_) => {}
        _ => unreachable!("eligibility excludes ownership/debugger and dynamic-call nodes"),
    }
}

/// One candidate scan plus one clone of each selected body. Original
/// entries stay available to callers and function values; no body is duplicated
/// per call site. Arguments gain one scalar tag; locals from both branches
/// remain distinct. Native measurements account for the combined frame size.
pub(super) fn lower(prog: &mut Program) {
    let partners: Vec<_> = prog
        .funcs
        .iter()
        .enumerate()
        .map(|(id, f)| {
            let Body::Expr(body) = &f.body else {
                return None;
            };
            if f.arity == 0
                || !f.locals.iter().all(scalar)
                || !scalar(f.ty.after_args(f.arity as usize))
                || !eligible(body)
            {
                return None;
            }
            let mut calls = BTreeSet::new();
            targets(body, &mut calls);
            calls.remove(&id);
            // Ignore primitive exits; a pair may return a checked arithmetic call.
            calls.retain(|id| matches!(prog.funcs[*id].body, Body::Expr(_)));
            if calls.len() == 1 {
                calls.first().copied()
            } else {
                None
            }
        })
        .collect();
    for a in 0..partners.len() {
        let Some(b) = partners[a] else { continue };
        if b <= a || partners.get(b) != Some(&Some(a)) {
            continue;
        }
        let left = &prog.funcs[a];
        let right = &prog.funcs[b];
        if left.arity != right.arity || left.ty != right.ty {
            continue;
        }
        let arity = left.arity as usize;
        let Some(worker_arity) = left.arity.checked_add(1) else {
            continue;
        };
        let Some(total_locals) = left
            .locals
            .len()
            .checked_add(right.locals.len())
            .and_then(|n| n.checked_add(1))
            .and_then(|n| n.checked_sub(arity))
        else {
            continue;
        };
        if Local::try_from(total_locals).is_err() {
            continue;
        }
        let worker = prog.funcs.len();
        let mut locals = vec![MT::con("std::I64")];
        locals.extend_from_slice(&left.locals[..arity]);
        let mut arms = vec![];
        for (tag, id) in [a, b].into_iter().enumerate() {
            let function = &prog.funcs[id];
            let offset = locals.len();
            locals.extend_from_slice(&function.locals[arity..]);
            let rename = |l: Local| -> Local {
                let l = l as usize;
                Local::try_from(if l < arity { l + 1 } else { offset + l - arity })
                    .expect("mutual worker local index fits IR")
            };
            let Body::Expr(mut body) = function.body.clone() else {
                unreachable!()
            };
            transfer(&mut body, true, [a, b], worker, &rename);
            arms.push((
                if tag == 0 {
                    Pat::Lit(Value::I64(0))
                } else {
                    Pat::Wild
                },
                body,
            ));
        }
        let ty = MT::Fun(Box::new(MT::con("std::I64")), Box::new(left.ty.clone()));
        let name = format!("{}+{}$tail-pair", left.name, right.name);
        prog.funcs.push(Func {
            name,
            arity: worker_arity,
            locals,
            ty,
            body: Body::Expr(Expr::Match(Box::new(Expr::Local(0)), arms)),
        });
        for (tag, id) in [a, b].into_iter().enumerate() {
            let function = &mut prog.funcs[id];
            function.locals.truncate(arity);
            let mut args = vec![Expr::Const(Value::I64(tag as i64))];
            args.extend((0..arity).map(|l| Expr::Local(l as Local)));
            function.body = Body::Expr(Expr::Call(worker, args));
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn pair() -> Program {
        let integer = MT::con("std::I64");
        let unary = MT::Fun(Box::new(integer.clone()), Box::new(integer.clone()));
        let mut p = Program::default();
        for tag in 0..2 {
            p.funcs.push(Func {
                name: format!("parity-{tag}"),
                arity: 1,
                locals: vec![integer.clone(), integer.clone()],
                ty: unary.clone(),
                body: Body::Expr(Expr::Match(
                    Box::new(Expr::Local(0)),
                    vec![
                        (Pat::Lit(Value::I64(0)), Expr::Const(Value::I64(tag as i64))),
                        (
                            Pat::Bind(1),
                            Expr::Call(
                                1 - tag,
                                vec![Expr::Call(
                                    2,
                                    vec![Expr::Const(Value::I64(1)), Expr::Local(1)],
                                )],
                            ),
                        ),
                    ],
                )),
            });
        }
        p.funcs.push(Func {
            name: "subtract".into(),
            arity: 2,
            locals: vec![integer.clone(), integer.clone()],
            ty: MT::Fun(Box::new(integer), Box::new(unary)),
            body: Body::Prim("sub".into()),
        });
        p
    }

    #[test]
    fn scalar_pair_preserves_both_entries_patterns_and_deep_parity() {
        let original = pair();
        let mut lowered = original.clone();
        lower(&mut lowered);
        assert_eq!(lowered.funcs.len(), original.funcs.len() + 1);
        crate::ir::check_locals(&lowered).unwrap();
        super::super::analyze(&mut lowered);
        assert_eq!(lowered.self_tail, BTreeSet::from([3]));
        let run = |p: &Program, entry, n| {
            let mut interp = crate::interp::Interp::new(p, Box::new(std::io::sink())).unwrap();
            interp.call_root(entry, vec![Value::I64(n)]).unwrap()
        };
        for entry in 0..2 {
            for n in [0, 1, 20, 21] {
                assert_eq!(run(&original, entry, n), run(&lowered, entry, n));
            }
            assert_eq!(run(&original, entry, 21), run(&lowered, entry, 200001));
        }
        // Running the pass again must not add wrappers or another worker.
        lower(&mut lowered);
        assert_eq!(lowered.funcs.len(), 4);
    }

    #[test]
    fn non_tail_calls_keep_their_frame_and_argument_order() {
        let mut call = Expr::Call(1, vec![Expr::Call(0, vec![Expr::Local(0)])]);
        transfer(&mut call, true, [0, 1], 9, &|l| l + 1);
        let Expr::Call(id, args) = call else {
            panic!("missing outer transfer")
        };
        assert_eq!(id, 9);
        assert!(matches!(&args[0], Expr::Const(Value::I64(1))));
        let Expr::Call(id, args) = &args[1] else {
            panic!("argument call disappeared")
        };
        assert_eq!(*id, 0);
        assert!(matches!(args.as_slice(), [Expr::Local(1)]));
    }

    #[test]
    fn resource_debugger_dynamic_and_mismatched_pairs_are_unchanged() {
        for variant in 0..5 {
            let mut p = pair();
            let Body::Expr(body) = p.funcs[0].body.clone() else {
                unreachable!()
            };
            match variant {
                0 => p.funcs[0].locals.push(MT::con("std::File")),
                1 => {
                    p.funcs[0].body = Body::Expr(Expr::ResourceRegion {
                        parameters: vec![],
                        bindings: vec![],
                        body: Box::new(body),
                    })
                }
                2 => {
                    p.funcs[0].body = Body::Expr(Expr::Trace(
                        SourcePoint {
                            span: crate::diag::Span::DUMMY,
                            ty: MT::con("std::I64"),
                        },
                        Box::new(body),
                    ))
                }
                3 => {
                    p.funcs[0].body =
                        Body::Expr(Expr::Apply(Box::new(Expr::Func(1)), vec![Expr::Local(0)]))
                }
                4 => {
                    p.funcs[1].ty = MT::Fun(
                        Box::new(MT::con("std::Bool")),
                        Box::new(MT::con("std::I64")),
                    )
                }
                _ => unreachable!(),
            }
            let before = format!("{p:?}");
            lower(&mut p);
            assert_eq!(format!("{p:?}"), before, "variant {variant}");
        }
    }

    #[test]
    #[ignore = "runner-only inputs for the O0/O2 mutual-recursion measurement"]
    fn emit_mutual_recursion_comparison() {
        let directory = std::path::PathBuf::from(std::env::var_os("FWP_MUTUAL_EVIDENCE").unwrap());
        std::fs::create_dir_all(&directory).unwrap();
        let mut ordinary = pair();
        ordinary.main = Some(ordinary.funcs.len());
        ordinary.funcs.push(Func {
            name: "main".into(),
            arity: 0,
            locals: vec![],
            ty: MT::con("std::I64"),
            body: Body::Expr(Expr::Call(0, vec![Expr::Const(Value::I64(0))])),
        });
        let mut grouped = ordinary.clone();
        lower(&mut grouped);
        super::super::analyze(&mut grouped);
        assert_eq!(grouped.funcs.len(), ordinary.funcs.len() + 1);
        assert_eq!(grouped.self_tail.len(), 1);
        let source = "step : (I64, I64) -> Step[(I64, I64), I64]\nstep = if (.0 | eq 0) (.1 | Stop) (make { 0 = .0 | sub 1, 1 = .1 | flip sub 1 } | Again)\nexport parity : I64 -> I64\nparity = both id (const 0) | loop step\nmain = parity 0 | ignore\n";
        let (_, explicit) = crate::driver::compile_source(
            "explicit.fwp",
            source,
            crate::mono::Roots {
                main: true,
                exports: true,
                ..Default::default()
            },
        )
        .map_err(|e| e.rendered)
        .unwrap();
        let entry = explicit
            .exports
            .iter()
            .find(|(name, _)| name == "parity")
            .unwrap()
            .1;
        std::fs::write(directory.join("explicit.fwp"), source).unwrap();
        for (name, program, entry) in [
            ("ordinary", ordinary, 0),
            ("grouped", grouped, 0),
            ("explicit", explicit, entry),
        ] {
            crate::ir::check_locals(&program).unwrap();
            let mut interpreter =
                crate::interp::Interp::new(&program, Box::new(std::io::sink())).unwrap();
            for n in [0, 1, 20, 21] {
                assert_eq!(
                    interpreter.call_root(entry, vec![Value::I64(n)]).unwrap(),
                    Value::I64(n % 2)
                );
            }
            let code = crate::cgen::generate(&program).unwrap();
            std::fs::write(directory.join(format!("{name}.c")), code).unwrap();
            std::fs::write(directory.join(format!("{name}.entry")), format!("f{entry}")).unwrap();
            std::fs::write(
                directory.join(format!("{name}.ir")),
                format!("{program:#?}"),
            )
            .unwrap();
        }
    }
}
