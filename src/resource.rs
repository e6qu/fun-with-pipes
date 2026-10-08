//! Preserve original observable resource lifetimes before optimization.
use crate::ir::*;
use std::collections::HashSet;

pub(crate) fn contains_file(shapes: &Shapes, ty: &MT) -> bool {
    fn visit(shapes: &Shapes, ty: &MT, seen: &mut HashSet<MT>) -> bool {
        if !seen.insert(ty.clone()) {
            return false;
        }
        match ty {
            MT::Con(n, _) if n == "std::File" => true,
            MT::Record(fields) => fields.iter().any(|(_, t)| visit(shapes, t, seen)),
            MT::Con(_, args) => {
                args.iter().any(|t| visit(shapes, t, seen))
                    || match shapes.get(ty) {
                        Some(TypeShape::Record(fields)) => {
                            fields.iter().any(|(_, t)| visit(shapes, t, seen))
                        }
                        Some(TypeShape::Adt(variants)) => variants
                            .iter()
                            .any(|(_, fields)| fields.iter().any(|t| visit(shapes, t, seen))),
                        _ => false,
                    }
            }
            // Resource captures are forbidden; an arrow mentioning File is
            // not itself a File owner.
            MT::Fun(..) | MT::Nat(_) => false,
        }
    }
    visit(shapes, ty, &mut HashSet::new())
}

pub(crate) fn preserve_frames(program: &mut Program) {
    for function in &mut program.funcs {
        let Body::Expr(body) = &mut function.body else {
            continue;
        };
        let mut parameters = Vec::new();
        let mut bindings = Vec::new();
        for (i, ty) in function.locals.iter().enumerate() {
            if contains_file(&program.shapes, ty) {
                if i < function.arity as usize {
                    parameters.push(i as Local);
                } else {
                    bindings.push(i as Local);
                }
            }
        }
        if parameters.is_empty() && bindings.is_empty() {
            continue;
        }
        let body = Box::new(std::mem::replace(
            body,
            Expr::Const(crate::value::Value::unit()),
        ));
        function.body = Body::Expr(Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        });
    }
}

/// A binding outside a region may initialize one of its parameter slots. Do
/// not propagate its caller alias into the region and destroy that caller slot.
pub(crate) fn anchored(expr: &Expr, local: Local) -> bool {
    let visit = |e| anchored(e, local);
    match expr {
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => parameters.contains(&local) || bindings.contains(&local) || visit(body),
        Expr::Dup(_, body) | Expr::Drop(_, body) | Expr::Field(body, _) => visit(body),
        Expr::Let(_, value, body) => visit(value) || visit(body),
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            args.iter().any(visit)
        }
        Expr::Apply(fun, args) => visit(fun) || args.iter().any(visit),
        Expr::SetFields(base, fields) => {
            visit(base) || fields.iter().any(|(_, value)| visit(value))
        }
        Expr::Match(value, arms) => visit(value) || arms.iter().any(|(_, body)| visit(body)),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => false,
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn nominal_recursive_resource_graphs_and_nonowning_arrows() {
        let node = MT::con("Node");
        let file = MT::con("std::File");
        let mut shapes = Shapes::new();
        shapes.insert(
            node.clone(),
            TypeShape::Adt(vec![
                ("Next".into(), vec![node.clone()]),
                ("File".into(), vec![file.clone()]),
            ]),
        );
        assert!(contains_file(&shapes, &node));
        assert!(contains_file(
            &shapes,
            &MT::Con("std::Array".into(), vec![file.clone()])
        ));
        assert!(!contains_file(
            &shapes,
            &MT::Fun(Box::new(file.clone()), Box::new(file))
        ));
        shapes.insert(
            MT::con("ScalarNode"),
            TypeShape::Adt(vec![
                ("Next".into(), vec![MT::con("ScalarNode")]),
                ("End".into(), vec![]),
            ]),
        );
        assert!(!contains_file(&shapes, &MT::con("ScalarNode")));
    }
    #[test]
    fn owner_metadata_rejects_missing_duplicate_and_scalar_slots() {
        let file = MT::con("std::File");
        let function = Func {
            name: "frame".into(),
            arity: 1,
            locals: vec![file.clone(), MT::con("std::I64")],
            ty: MT::Fun(Box::new(file), Box::new(MT::Record(vec![]))),
            body: Body::Expr(Expr::Const(crate::value::Value::unit())),
        };
        for (owners, expected) in [
            (vec![0], None),
            (vec![0, 0], Some("duplicate resource owner")),
            (vec![1], Some("nonresource type")),
            (vec![2], Some("has no type")),
        ] {
            let mut f = function.clone();
            f.body = Body::Expr(Expr::ResourceRegion {
                parameters: owners,
                bindings: vec![],
                body: Box::new(Expr::Const(crate::value::Value::unit())),
            });
            let p = Program {
                funcs: vec![f],
                ..Program::default()
            };
            match expected {
                None => crate::ir::check_locals(&p).unwrap(),
                Some(message) => {
                    assert!(crate::ir::check_locals(&p).unwrap_err().contains(message))
                }
            }
        }
    }
    #[test]
    fn fusion_preserves_resource_stage_frames_even_with_pure_bodies() {
        let file = MT::con("std::File");
        let int = MT::con("std::I64");
        let files = MT::Con("std::List".into(), vec![file.clone()]);
        let ints = MT::Con("std::List".into(), vec![int.clone()]);
        let arrow = |a: MT, b: MT| MT::Fun(Box::new(a), Box::new(b));
        let stage_type = arrow(file.clone(), int.clone());
        let mut p = Program {
            funcs: vec![
                Func {
                    name: "stage".into(),
                    arity: 1,
                    locals: vec![file.clone()],
                    ty: stage_type.clone(),
                    body: Body::Expr(Expr::ResourceRegion {
                        parameters: vec![0],
                        bindings: vec![],
                        body: Box::new(Expr::Const(crate::value::Value::I64(1))),
                    }),
                },
                Func {
                    name: "map".into(),
                    arity: 2,
                    locals: vec![stage_type.clone(), files.clone()],
                    ty: arrow(stage_type, arrow(files.clone(), ints.clone())),
                    body: Body::Prim("map".into()),
                },
                Func {
                    name: "length".into(),
                    arity: 1,
                    locals: vec![ints.clone()],
                    ty: arrow(ints.clone(), int.clone()),
                    body: Body::Prim("length".into()),
                },
                Func {
                    name: "main".into(),
                    arity: 1,
                    locals: vec![files.clone()],
                    ty: arrow(files.clone(), int.clone()),
                    body: Body::Expr(Expr::Call(
                        2,
                        vec![Expr::Call(1, vec![Expr::Func(0), Expr::Local(0)])],
                    )),
                },
            ],
            ..Program::default()
        };
        for (list, element) in [(files, file), (ints, int)] {
            p.shapes.insert(
                list.clone(),
                TypeShape::Adt(vec![
                    ("Nil".into(), vec![]),
                    ("Cons".into(), vec![element, list]),
                ]),
            );
        }
        crate::ir::check_locals(&p).unwrap();
        let mut unscoped = p.clone();
        unscoped.funcs[0].body = Body::Expr(Expr::Const(crate::value::Value::I64(1)));
        crate::fuse::fuse(&mut unscoped);
        assert!(
            unscoped.funcs.iter().any(|f| f.name == "fused"),
            "control pipeline must fuse"
        );
        crate::fuse::fuse(&mut p);
        assert!(
            !p.funcs.iter().any(|f| f.name == "fused"),
            "cleanup must keep its original stage boundary"
        );
        crate::ir::check_locals(&p).unwrap();
    }
}
