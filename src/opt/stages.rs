//! Flatten a constructor only after proving that it merely captures values.
//! Source lowering keeps every strict stage. This proof excludes calls, traps,
//! observable owners and resource frames; their construction must stay eager.
use super::*;

fn returned_partial<'a>(expression: &'a Expr, optimizer: &Opt<'_>) -> Option<&'a Expr> {
    match expression {
        Expr::Let(_, value, body) if optimizer.pure(value) => returned_partial(body, optimizer),
        Expr::Apply(function, captures)
            if matches!(&**function, Expr::Func(id) if captures.len() < optimizer.arity(*id))
                && optimizer.pure(expression) =>
        {
            Some(expression)
        }
        _ => None,
    }
}

pub(super) fn flatten(prog: &mut Program) {
    let mut changes = Vec::new();
    let observable_captures = crate::resource::has_observable_captures(&prog.funcs, &prog.shapes);
    for (id, function) in prog.funcs.iter().enumerate() {
        let Body::Expr(body) = &function.body else {
            continue;
        };
        if function
            .ty
            .after_args(function.arity as usize)
            .as_fun()
            .is_none()
            || size(body) > MAX_BODY
            || calls(body, id)
        {
            continue;
        }
        if function.locals.iter().any(|ty| {
            crate::resource::contains_resource(&prog.shapes, ty)
                || crate::resource::contains_channel(&prog.shapes, ty)
                || (observable_captures && crate::resource::may_hold_resource(&prog.shapes, ty))
        }) {
            continue;
        }
        let mut optimizer = Opt {
            funcs: &prog.funcs,
            shapes: &prog.shapes,
            current: id,
            locals: function.locals.clone(),
            budget: 600,
            resource_locals: Vec::new(),
        };
        // Prove constructors before their calls are inlined into consumers.
        // Use the ordinary bounded simplifier, preserving all resource frames.
        let body = optimizer.expr(body.clone(), 0);
        let Some(Expr::Apply(target, captures)) = returned_partial(&body, &optimizer) else {
            continue;
        };
        let Expr::Func(target) = &**target else {
            unreachable!()
        };
        let extra = prog.funcs[*target].arity as usize - captures.len();
        let arity = function.arity as usize;
        let (inputs, _) = function.ty.after_args(arity).params(extra);
        if inputs.len() != extra
            || inputs.iter().any(|ty| {
                crate::resource::contains_resource(&prog.shapes, ty)
                    || crate::resource::contains_channel(&prog.shapes, ty)
                    || (observable_captures && crate::resource::may_hold_resource(&prog.shapes, ty))
            })
        {
            continue;
        }
        // An unused owner must not be kept until a later argument arrives.
        if (0..arity).any(|local| uses(&body, local as Local) == 0) {
            continue;
        }
        let mapping: Vec<_> = (0..optimizer.locals.len())
            .map(|local| {
                Some(Expr::Local(
                    (if local < arity { local } else { local + extra }) as Local,
                ))
            })
            .collect();
        let body = substitute(&body, &mapping);
        let mut locals = optimizer.locals[..arity].to_vec();
        locals.extend(inputs.into_iter().cloned());
        locals.extend_from_slice(&optimizer.locals[arity..]);
        let arguments = (arity..arity + extra)
            .map(|local| Expr::Local(local as Local))
            .collect();
        changes.push((
            id,
            (arity + extra) as u32,
            locals,
            Expr::Apply(Box::new(body), arguments),
        ));
    }
    if changes.is_empty() {
        return;
    }
    let ids: HashSet<_> = changes.iter().map(|(id, ..)| *id).collect();
    for (id, arity, locals, body) in changes {
        let function = &mut prog.funcs[id];
        function.arity = arity;
        function.locals = locals;
        function.body = Body::Expr(body);
    }
    for function in &mut prog.funcs {
        if let Body::Expr(body) = &mut function.body {
            rewrite_calls(body, &ids);
        }
    }
}

fn rewrite_calls(expression: &mut Expr, changed: &HashSet<FuncId>) {
    match expression {
        Expr::Call(id, arguments) => {
            for argument in arguments.iter_mut() {
                rewrite_calls(argument, changed);
            }
            if changed.contains(id) {
                *expression = Expr::Apply(Box::new(Expr::Func(*id)), std::mem::take(arguments));
            }
        }
        Expr::Apply(function, arguments) => {
            rewrite_calls(function, changed);
            for argument in arguments {
                rewrite_calls(argument, changed);
            }
        }
        Expr::Construct(_, fields) | Expr::Record(fields) => {
            for field in fields {
                rewrite_calls(field, changed);
            }
        }
        Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::ResourceRegion { body, .. }
        | Expr::Field(body, _) => rewrite_calls(body, changed),
        Expr::Let(_, value, body) => {
            rewrite_calls(value, changed);
            rewrite_calls(body, changed);
        }
        Expr::SetFields(record, fields) => {
            rewrite_calls(record, changed);
            for (_, field) in fields {
                rewrite_calls(field, changed);
            }
        }
        Expr::Match(value, arms) => {
            rewrite_calls(value, changed);
            for (_, arm) in arms {
                rewrite_calls(arm, changed);
            }
        }
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::value::Value;

    fn program(input: MT, body: Expr) -> Program {
        let integer = MT::con("std::I64");
        let unary = MT::Fun(Box::new(integer.clone()), Box::new(integer.clone()));
        let binary = MT::Fun(Box::new(integer.clone()), Box::new(unary.clone()));
        Program {
            funcs: vec![
                Func {
                    name: "add".into(),
                    arity: 2,
                    ty: binary.clone(),
                    locals: vec![integer.clone(), integer.clone()],
                    body: Body::Prim("add".into()),
                },
                Func {
                    name: "factory".into(),
                    arity: 1,
                    ty: MT::Fun(Box::new(input.clone()), Box::new(unary.clone())),
                    locals: vec![input.clone(), integer.clone()],
                    body: Body::Expr(body),
                },
                Func {
                    name: "caller".into(),
                    arity: 1,
                    ty: MT::Fun(
                        Box::new(input.clone()),
                        Box::new(MT::Record(vec![("function".into(), unary)])),
                    ),
                    locals: vec![input],
                    body: Body::Expr(Expr::Record(vec![Expr::Call(1, vec![Expr::Local(0)])])),
                },
            ],
            ..Program::default()
        }
    }

    fn partial(capture: Expr) -> Expr {
        Expr::Apply(Box::new(Expr::Func(0)), vec![capture])
    }

    #[test]
    fn pure_constructor_flattens_without_losing_its_local_bindings_or_callers() {
        let mut program = program(
            MT::con("std::I64"),
            Expr::Let(
                1,
                Box::new(Expr::Const(Value::unit())),
                Box::new(partial(Expr::Local(0))),
            ),
        );
        program.funcs[1].locals[1] = MT::unit();
        crate::ir::check_locals(&program).unwrap();
        flatten(&mut program);
        crate::ir::check_locals(&program).unwrap();
        assert_eq!(program.funcs[1].arity, 2);
        assert_eq!(program.funcs[1].locals.len(), 3);
        let Body::Expr(Expr::Apply(body, arguments)) = &program.funcs[1].body else {
            panic!("missing promoted input")
        };
        assert!(matches!(&**body, Expr::Let(2, value, _) if matches!(&**value, Expr::Const(_))));
        assert!(matches!(arguments.as_slice(), [Expr::Local(1)]));
        let Body::Expr(Expr::Record(fields)) = &program.funcs[2].body else {
            panic!("missing caller record")
        };
        assert!(matches!(&fields[0], Expr::Apply(function, args)
            if matches!(&**function, Expr::Func(1)) && matches!(args.as_slice(), [Expr::Local(0)])));
    }

    #[test]
    fn constant_function_values_can_flatten_but_computed_captures_stay_eager() {
        for computed in [false, true] {
            let capture = if computed {
                Expr::Call(
                    0,
                    vec![Expr::Const(Value::I64(1)), Expr::Const(Value::I64(2))],
                )
            } else {
                Expr::Const(Value::I64(1))
            };
            let mut program = program(MT::con("std::I64"), partial(capture));
            program.funcs[1].ty = program.funcs[1].ty.after_args(1).clone();
            program.funcs[1].arity = 0;
            program.funcs[1].locals.clear();
            program.funcs[2].body = Body::Expr(Expr::Record(vec![Expr::Func(1)]));
            flatten(&mut program);
            crate::ir::check_locals(&program).unwrap();
            assert_eq!(program.funcs[1].arity, u32::from(!computed));
        }
    }

    #[test]
    fn computations_resource_frames_and_unused_owners_keep_their_stage() {
        for (input, body) in [
            (
                MT::con("std::I64"),
                Expr::Let(
                    1,
                    Box::new(Expr::Call(
                        0,
                        vec![Expr::Local(0), Expr::Const(Value::I64(1))],
                    )),
                    Box::new(partial(Expr::Local(1))),
                ),
            ),
            (
                MT::con("std::File"),
                Expr::ResourceRegion {
                    parameters: vec![0],
                    bindings: vec![],
                    body: Box::new(partial(Expr::Const(Value::I64(1)))),
                },
            ),
            (MT::con("std::I64"), partial(Expr::Const(Value::I64(1)))),
        ] {
            let mut program = program(input, body);
            crate::ir::check_locals(&program).unwrap();
            let before = format!("{program:?}");
            flatten(&mut program);
            assert_eq!(format!("{program:?}"), before);
        }
    }
}
