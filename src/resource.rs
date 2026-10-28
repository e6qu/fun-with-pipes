//! Preserve original observable resource lifetimes before optimization.
use crate::ir::*;
use std::collections::HashSet;

fn contains_where(shapes: &Shapes, ty: &MT, names: fn(&str) -> bool, closures: bool) -> bool {
    fn visit(
        shapes: &Shapes,
        ty: &MT,
        seen: &mut HashSet<MT>,
        names: fn(&str) -> bool,
        closures: bool,
    ) -> bool {
        if !seen.insert(ty.clone()) {
            return false;
        }
        match ty {
            MT::Con(name, _) if names(name) => true,
            MT::Con(name, _) if name == "std::WeakChannel" => false,
            MT::Record(fields) => fields
                .iter()
                .any(|(_, ty)| visit(shapes, ty, seen, names, closures)),
            MT::Con(_, args) => {
                args.iter()
                    .any(|ty| visit(shapes, ty, seen, names, closures))
                    || match shapes.get(ty) {
                        Some(TypeShape::Record(fields)) => fields
                            .iter()
                            .any(|(_, ty)| visit(shapes, ty, seen, names, closures)),
                        Some(TypeShape::Adt(variants)) => variants.iter().any(|(_, fields)| {
                            fields
                                .iter()
                                .any(|ty| visit(shapes, ty, seen, names, closures))
                        }),
                        _ => false,
                    }
            }
            // An arrow does not own its input/output types, but its runtime
            // closure may own captures whose types are absent from the arrow.
            MT::Fun(..) => closures,
            MT::Nat(_) => false,
        }
    }
    visit(shapes, ty, &mut HashSet::new(), names, closures)
}

pub(crate) fn contains_resource(shapes: &Shapes, ty: &MT) -> bool {
    contains_where(
        shapes,
        ty,
        |name| {
            matches!(
                name,
                "std::File" | "std::UdpSocket" | "std::Conn" | "std::Listener" | "std::H2Stream"
            )
        },
        false,
    )
}

pub(crate) fn may_hold_resource(shapes: &Shapes, ty: &MT) -> bool {
    contains_where(
        shapes,
        ty,
        |name| {
            matches!(
                name,
                "std::File" | "std::UdpSocket" | "std::Conn" | "std::Listener" | "std::H2Stream"
            )
        },
        true,
    )
}

pub(crate) fn contains_channel(shapes: &Shapes, ty: &MT) -> bool {
    contains_where(shapes, ty, |name| name == "std::Channel", false)
}

/// Weak observations make final channel release observable. Programs without
/// weak channels keep their existing last-use ownership optimization.
pub(crate) fn uses_weak_channels(funcs: &[Func], shapes: &Shapes) -> bool {
    fn signature(shapes: &Shapes, ty: &MT) -> bool {
        match ty {
            MT::Fun(input, output) => signature(shapes, input) || signature(shapes, output),
            _ => contains_where(shapes, ty, |name| name == "std::WeakChannel", false),
        }
    }
    funcs.iter().any(|function| {
        signature(shapes, &function.ty) || function.locals.iter().any(|ty| signature(shapes, ty))
    })
}

pub(crate) fn observable_type(funcs: &[Func], shapes: &Shapes, ty: &MT) -> bool {
    contains_resource(shapes, ty)
        || (contains_channel(shapes, ty) && uses_weak_channels(funcs, shapes))
        || (may_hold_resource(shapes, ty) && has_observable_captures(funcs, shapes))
}

/// Socket values can be captured; File values cannot. Only programs that use
/// these handles need to preserve opaque closure holders as resource owners.
pub(crate) fn has_observable_captures(funcs: &[Func], shapes: &Shapes) -> bool {
    uses_weak_channels(funcs, shapes)
        || funcs.iter().any(|function| {
            function.locals.iter().any(|ty| {
                contains_where(
                    shapes,
                    ty,
                    |name| {
                        matches!(
                            name,
                            "std::UdpSocket" | "std::Conn" | "std::Listener" | "std::H2Stream"
                        )
                    },
                    false,
                )
            })
        })
}

pub(crate) fn preserve_frames(program: &mut Program) {
    let captures = has_observable_captures(&program.funcs, &program.shapes);
    let weak_channels = uses_weak_channels(&program.funcs, &program.shapes);
    for function in &mut program.funcs {
        let Body::Expr(body) = &mut function.body else {
            continue;
        };
        let mut parameters = Vec::new();
        let mut bindings = Vec::new();
        for (i, ty) in function.locals.iter().enumerate() {
            if contains_resource(&program.shapes, ty)
                || (weak_channels && contains_channel(&program.shapes, ty))
                || (captures && may_hold_resource(&program.shapes, ty))
            {
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
        Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::Field(body, _) => visit(body),
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

/// Whether this value can be released without closing a handle or changing a weak observation.
/// This is a value proof, not a purity proof: evaluating it may still trap or do
/// work. A known unsaturated function owns exactly its supplied arguments.
/// A saturated call or cached function value may return arbitrary captures.
pub(crate) fn unobservable_value(
    funcs: &[Func],
    shapes: &Shapes,
    locals: &[MT],
    expr: &Expr,
    expected: Option<&MT>,
) -> bool {
    let inferred = type_of(&|id: FuncId| &funcs[id].ty, shapes, locals, expr);
    if expected
        .or(inferred.as_ref())
        .is_some_and(|ty| crate::tailrec::plain_data(shapes, ty, &mut HashSet::new()))
    {
        return true;
    }
    match expr {
        Expr::Func(id) => funcs[*id].arity > 0,
        Expr::Apply(function, args) => {
            let Expr::Func(id) = &**function else {
                return false;
            };
            let function = &funcs[*id];
            args.len() < function.arity as usize
                && args
                    .iter()
                    .zip(function.ty.params(args.len()).0)
                    .all(|(arg, ty)| unobservable_value(funcs, shapes, locals, arg, Some(ty)))
        }
        _ => false,
    }
}

/// Collect only proved initializers, once per expression. Unknown parameters,
/// pattern captures and saturated closure factories retain their anchors.
pub(crate) fn unobservable_bindings(
    expr: &Expr,
    funcs: &[Func],
    shapes: &Shapes,
    locals: &[MT],
    out: &mut HashSet<Local>,
) {
    if let Expr::Let(local, value, _) = expr {
        if unobservable_value(funcs, shapes, locals, value, locals.get(*local as usize)) {
            out.insert(*local);
        }
    }
    match expr {
        Expr::ResourceRegion { body, .. }
        | Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::Field(body, _) => unobservable_bindings(body, funcs, shapes, locals, out),
        Expr::Let(_, a, b) => {
            unobservable_bindings(a, funcs, shapes, locals, out);
            unobservable_bindings(b, funcs, shapes, locals, out);
        }
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                unobservable_bindings(arg, funcs, shapes, locals, out);
            }
        }
        Expr::Apply(function, args) => {
            unobservable_bindings(function, funcs, shapes, locals, out);
            for arg in args {
                unobservable_bindings(arg, funcs, shapes, locals, out);
            }
        }
        Expr::SetFields(base, fields) => {
            unobservable_bindings(base, funcs, shapes, locals, out);
            for (_, value) in fields {
                unobservable_bindings(value, funcs, shapes, locals, out);
            }
        }
        Expr::Match(value, arms) => {
            unobservable_bindings(value, funcs, shapes, locals, out);
            for (_, body) in arms {
                unobservable_bindings(body, funcs, shapes, locals, out);
            }
        }
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
}

/// Remove only the proved locals from cleanup metadata, before substitution.
/// Expressions and their evaluation order are untouched; debug frames remain.
pub(crate) fn remove_anchors(expr: &mut Expr, safe: &HashSet<Local>) {
    match expr {
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => {
            parameters.retain(|local| !safe.contains(local));
            bindings.retain(|local| !safe.contains(local));
            remove_anchors(body, safe);
            if parameters.is_empty() && bindings.is_empty() {
                *expr =
                    *std::mem::replace(body, Box::new(Expr::Const(crate::value::Value::unit())));
            }
        }
        Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::Field(body, _) => remove_anchors(body, safe),
        Expr::Let(_, a, b) => {
            remove_anchors(a, safe);
            remove_anchors(b, safe);
        }
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                remove_anchors(arg, safe);
            }
        }
        Expr::Apply(function, args) => {
            remove_anchors(function, safe);
            for arg in args {
                remove_anchors(arg, safe);
            }
        }
        Expr::SetFields(base, fields) => {
            remove_anchors(base, safe);
            for (_, value) in fields {
                remove_anchors(value, safe);
            }
        }
        Expr::Match(value, arms) => {
            remove_anchors(value, safe);
            for (_, body) in arms {
                remove_anchors(body, safe);
            }
        }
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    #[test]
    fn only_known_capture_storage_can_release_its_frame_anchor() {
        let int = MT::con("std::I64");
        let arrow = |a: MT, b: MT| MT::Fun(Box::new(a), Box::new(b));
        let callback = arrow(int.clone(), int.clone());
        let weak = MT::Con("std::WeakChannel".into(), vec![callback.clone()]);
        let strong = MT::Con("std::Channel".into(), vec![callback.clone()]);
        let shapes = Shapes::new();
        let make = |name: &str, capture: MT| Func {
            name: name.into(),
            arity: 2,
            ty: arrow(capture.clone(), callback.clone()),
            locals: vec![capture, int.clone()],
            body: Body::Expr(Expr::Local(1)),
        };
        let funcs = vec![
            make("weak", weak.clone()),
            make("strong", strong.clone()),
            make("unknown", callback.clone()),
            Func {
                name: "factory".into(),
                arity: 1,
                ty: arrow(int.clone(), callback.clone()),
                locals: vec![int.clone()],
                body: Body::Prim("fixture-factory".into()),
            },
            Func {
                name: "cached".into(),
                arity: 0,
                ty: callback.clone(),
                locals: vec![],
                body: Body::Prim("fixture-cached".into()),
            },
        ];
        let locals = vec![weak, strong, callback.clone(), int];
        let partial = |id, local| Expr::Apply(Box::new(Expr::Func(id)), vec![Expr::Local(local)]);
        for (value, expected) in [
            (Expr::Func(0), true),
            (Expr::Func(1), true),
            (partial(0, 0), true),
            (partial(1, 1), false),
            (partial(2, 2), false),
            (partial(3, 3), false),
            (Expr::Func(4), false),
            (Expr::Local(2), false),
            (Expr::Call(3, vec![Expr::Local(3)]), false),
        ] {
            assert_eq!(
                unobservable_value(&funcs, &shapes, &locals, &value, None),
                expected,
                "{value:?}"
            );
        }
        // Removing one proved anchor keeps the other owner and debugger frame.
        let mut body = Expr::ResourceRegion {
            parameters: vec![0, 1],
            bindings: vec![2],
            body: Box::new(Expr::Trace(
                SourcePoint {
                    span: crate::diag::Span::DUMMY,
                    ty: callback,
                },
                Box::new(Expr::Local(2)),
            )),
        };
        remove_anchors(&mut body, &HashSet::from([0]));
        assert!(!anchored(&body, 0));
        assert!(anchored(&body, 1) && anchored(&body, 2));
        remove_anchors(&mut body, &HashSet::from([1, 2]));
        assert!(matches!(body, Expr::Trace(..)));
    }

    #[test]
    fn inlining_releases_only_known_function_anchors() {
        let int = MT::con("std::I64");
        let arrow = |a: MT, b: MT| MT::Fun(Box::new(a), Box::new(b));
        let callback = arrow(int.clone(), int.clone());
        let weak = MT::Con("std::WeakChannel".into(), vec![int.clone()]);
        let mut program = Program {
            funcs: vec![
                Func {
                    name: "identity".into(),
                    arity: 1,
                    ty: callback.clone(),
                    locals: vec![int.clone()],
                    body: Body::Expr(Expr::Local(0)),
                },
                Func {
                    name: "invoke".into(),
                    arity: 2,
                    ty: arrow(callback.clone(), callback.clone()),
                    locals: vec![callback.clone(), int.clone()],
                    body: Body::Expr(Expr::Apply(Box::new(Expr::Local(0)), vec![Expr::Local(1)])),
                },
                Func {
                    name: "known".into(),
                    arity: 1,
                    ty: callback.clone(),
                    locals: vec![int.clone(), weak],
                    body: Body::Expr(Expr::Call(1, vec![Expr::Func(0), Expr::Local(0)])),
                },
                Func {
                    name: "unknown".into(),
                    arity: 2,
                    ty: arrow(callback.clone(), callback.clone()),
                    locals: vec![callback, int],
                    body: Body::Expr(Expr::Call(1, vec![Expr::Local(0), Expr::Local(1)])),
                },
            ],
            ..Program::default()
        };
        preserve_frames(&mut program);
        crate::opt::optimize(&mut program);
        crate::ir::check_locals(&program).unwrap();
        assert!(matches!(program.funcs[2].body, Body::Expr(Expr::Local(0))));
        let Body::Expr(body) = &program.funcs[3].body else {
            unreachable!()
        };
        assert!(anchored(body, 0));
    }

    #[test]
    fn weak_observation_preserves_channels_without_anchoring_the_weak_target() {
        let channel = MT::Con("std::Channel".into(), vec![MT::con("std::I64")]);
        let weak = MT::Con("std::WeakChannel".into(), vec![MT::con("std::I64")]);
        let mut program = Program {
            funcs: vec![Func {
                name: "observe".into(),
                arity: 1,
                ty: MT::Fun(Box::new(channel.clone()), Box::new(MT::Record(vec![]))),
                locals: vec![channel],
                body: Body::Expr(Expr::Const(crate::value::Value::unit())),
            }],
            ..Program::default()
        };
        assert!(!uses_weak_channels(&program.funcs, &program.shapes));
        preserve_frames(&mut program);
        assert!(matches!(program.funcs[0].body, Body::Expr(Expr::Const(_))));
        program.funcs[0].locals.push(weak.clone());
        assert!(uses_weak_channels(&program.funcs, &program.shapes));
        assert!(!contains_channel(&program.shapes, &weak));
        preserve_frames(&mut program);
        let Body::Expr(Expr::ResourceRegion {
            parameters,
            bindings,
            ..
        }) = &program.funcs[0].body
        else {
            panic!("weak observation must preserve the original channel frame");
        };
        assert_eq!(parameters, &[0]);
        assert!(bindings.is_empty());
        crate::ir::check_locals(&program).unwrap();
    }

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
        assert!(contains_resource(&shapes, &node));
        assert!(contains_resource(
            &shapes,
            &MT::Con("std::Array".into(), vec![file.clone()])
        ));
        assert!(!contains_resource(
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
        assert!(!contains_resource(&shapes, &MT::con("ScalarNode")));
    }
    #[test]
    fn opaque_closure_holders_keep_socket_frames_only_when_needed() {
        let arrow = MT::Fun(
            Box::new(MT::Record(vec![])),
            Box::new(MT::con("std::String")),
        );
        let holder = MT::con("Holder");
        let mut shapes = Shapes::new();
        shapes.insert(
            holder.clone(),
            TypeShape::Record(vec![("read".into(), arrow.clone())]),
        );
        assert!(!contains_resource(&shapes, &holder));
        assert!(may_hold_resource(&shapes, &holder));
        assert!(!contains_resource(&shapes, &arrow));
        let function = Func {
            name: "holder".into(),
            arity: 1,
            locals: vec![holder.clone()],
            ty: MT::Fun(Box::new(holder), Box::new(MT::Record(vec![]))),
            body: Body::Expr(Expr::Const(crate::value::Value::unit())),
        };
        let mut program = Program {
            funcs: vec![function],
            shapes,
            ..Program::default()
        };
        preserve_frames(&mut program);
        assert!(matches!(program.funcs[0].body, Body::Expr(Expr::Const(_))));
        program.funcs[0].locals.push(MT::con("std::UdpSocket"));
        preserve_frames(&mut program);
        match &program.funcs[0].body {
            Body::Expr(Expr::ResourceRegion {
                parameters,
                bindings,
                ..
            }) => {
                assert_eq!(parameters, &[0]);
                assert_eq!(bindings, &[1]);
            }
            _ => panic!("socket capture holder must retain its original frame"),
        }
        crate::ir::check_locals(&program).unwrap();
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
