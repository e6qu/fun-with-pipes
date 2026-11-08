//! Expose a closed function argument inside a known scope or array worker.
//! Keep the scope call, its arguments and the worker's call stage unchanged.
//! Only original call sites are visited; generated workers cannot recursively
//! expand this pass. Each worker/function pair shares one bounded specialization.

use std::collections::{HashMap, HashSet};

use super::{size, substitute, Opt, MAX_BODY, ROUNDS};
use crate::ir::*;

/// Reassociate strict bindings only when extending their lexical scope cannot
/// extend an observable lifetime. All initializer calls keep their order.
/// Existing record scalar replacement can then see the constructor directly.
fn lift_bindings(expression: Expr, optimizer: &mut Opt<'_>) -> Expr {
    match expression {
        Expr::Let(local, value, body) => {
            let mut value = lift_bindings(*value, optimizer);
            let body = lift_bindings(*body, optimizer);
            let mut prefix = Vec::new();
            if !crate::resource::observable_type(
                optimizer.funcs,
                optimizer.shapes,
                &optimizer.locals[local as usize],
            ) && !crate::resource::anchored(&body, local)
            {
                while let Expr::Let(inner, initial, rest) = value {
                    if optimizer.budget <= 0
                        || inner == local
                        || super::uses(&body, inner) != 0
                        || crate::resource::observable_type(
                            optimizer.funcs,
                            optimizer.shapes,
                            &optimizer.locals[inner as usize],
                        )
                        || crate::resource::anchored(&rest, inner)
                    {
                        value = Expr::Let(inner, initial, rest);
                        break;
                    }
                    optimizer.budget -= 1;
                    prefix.push((inner, initial));
                    value = *rest;
                }
            }
            let mut result = Expr::Let(local, Box::new(value), Box::new(body));
            for (local, initial) in prefix.into_iter().rev() {
                result = Expr::Let(local, initial, Box::new(result));
            }
            result
        }
        Expr::Trace(span, body) => Expr::Trace(span, Box::new(lift_bindings(*body, optimizer))),
        Expr::Call(id, args) => Expr::Call(
            id,
            args.into_iter()
                .map(|e| lift_bindings(e, optimizer))
                .collect(),
        ),
        Expr::Apply(function, args) => Expr::Apply(
            Box::new(lift_bindings(*function, optimizer)),
            args.into_iter()
                .map(|e| lift_bindings(e, optimizer))
                .collect(),
        ),
        Expr::Construct(tag, args) => Expr::Construct(
            tag,
            args.into_iter()
                .map(|e| lift_bindings(e, optimizer))
                .collect(),
        ),
        Expr::Record(fields) => Expr::Record(
            fields
                .into_iter()
                .map(|e| lift_bindings(e, optimizer))
                .collect(),
        ),
        Expr::Field(record, field) => {
            Expr::Field(Box::new(lift_bindings(*record, optimizer)), field)
        }
        Expr::SetFields(record, fields) => Expr::SetFields(
            Box::new(lift_bindings(*record, optimizer)),
            fields
                .into_iter()
                .map(|(field, value)| (field, lift_bindings(value, optimizer)))
                .collect(),
        ),
        Expr::Match(value, arms) => Expr::Match(
            Box::new(lift_bindings(*value, optimizer)),
            arms.into_iter()
                .map(|(pattern, body)| (pattern, lift_bindings(body, optimizer)))
                .collect(),
        ),
        // Never move a binding into or out of a resource region. Counted IR is
        // not an input of this pass, and must not be normalized accidentally.
        other @ (Expr::ResourceRegion { .. }
        | Expr::Dup(..)
        | Expr::Drop(..)
        | Expr::BorrowGlobal(..)
        | Expr::Local(_)
        | Expr::Const(_)
        | Expr::Func(_)) => other,
    }
}

struct Specialize<'a> {
    program: &'a Program,
    made: Vec<Func>,
    known: HashMap<(FuncId, FuncId, bool), FuncId>,
}

impl Specialize<'_> {
    fn select(&mut self, expression: &mut Expr, locals: &[MT]) -> Option<()> {
        if self.array_callback(expression).is_some() {
            return Some(());
        }
        let Expr::Call(scope, arguments) = expression else {
            return None;
        };
        let primitive = self.program.funcs.get(*scope)?;
        if primitive.arity != 3
            || !matches!(&primitive.body, Body::Prim(symbol) if symbol == "ad.scope2")
        {
            return None;
        }
        let [Expr::Func(worker), Expr::Func(argument), input] = arguments.as_slice() else {
            return None;
        };
        let worker_id = *worker;
        let argument_id = *argument;
        let worker = self.program.funcs.get(worker_id)?;
        let argument = self.program.funcs.get(argument_id)?;
        let Body::Expr(body) = &worker.body else {
            return None;
        };
        if worker.arity != 2
            || worker.locals.len() < 2
            || argument.arity == 0
            || size(body) > MAX_BODY
        {
            return None;
        }
        let (parameters, result) = primitive.ty.params(3);
        let (worker_parameters, worker_result) = worker.ty.params(2);
        if parameters.len() != 3
            || worker_parameters.len() != 2
            || parameters[0] != &worker.ty
            || parameters[1] != &argument.ty
            || worker_parameters != parameters[1..]
            || result != worker_result
            || type_of(
                &|id| &self.program.funcs[id].ty,
                &self.program.shapes,
                locals,
                input,
            )
            .as_ref()
                != Some(parameters[2])
        {
            return None;
        }
        let specialized = self.known_worker(worker_id, argument_id, true)?;
        // Retain even the now-known argument: its original evaluation and the
        // primitive's borrowed-call protocol stay exactly where they were.
        arguments[0] = Expr::Func(specialized);
        Some(())
    }

    // Copy the worker once with its first, closed function argument known.
    // Scope primitives keep their protocol's argument. Array callbacks can
    // omit the closed function value: it has no captures, construction effects
    // or observable owner. Other arguments and frames stay in their order.
    fn known_worker(
        &mut self,
        worker_id: FuncId,
        argument_id: FuncId,
        keep_argument: bool,
    ) -> Option<FuncId> {
        let worker = self.program.funcs.get(worker_id)?;
        let argument = self.program.funcs.get(argument_id)?;
        let Body::Expr(body) = &worker.body else {
            return None;
        };
        if worker.arity == 0
            || worker.locals.first()? != &argument.ty
            || argument.arity == 0
            || size(body) > MAX_BODY
        {
            return None;
        }
        let key = (worker_id, argument_id, keep_argument);
        let specialized = if let Some(id) = self.known.get(&key) {
            *id
        } else {
            let mut substitutions = vec![None; worker.locals.len()];
            substitutions[0] = Some(Expr::Func(argument_id));
            let mut body = body.clone();
            let mut parameter_types = worker.locals.clone();
            if !keep_argument {
                // Removing a closed function argument must not shift another
                // parameter's resource identity onto its old anchor.
                crate::resource::remove_anchors(&mut body, &HashSet::from([0]));
                for (index, slot) in substitutions.iter_mut().enumerate().skip(1) {
                    *slot = Some(Expr::Local((index - 1) as Local));
                }
                parameter_types.remove(0);
            }
            let mut body = substitute(&body, &substitutions);
            let mut optimizer = Opt {
                funcs: &self.program.funcs,
                shapes: &self.program.shapes,
                current: worker_id,
                locals: parameter_types,
                budget: 600,
                resource_locals: Vec::new(),
            };
            for _ in 0..ROUNDS {
                body = lift_bindings(body, &mut optimizer);
                body = optimizer.expr(body, 0);
            }
            let id = self.program.funcs.len() + self.made.len();
            self.made.push(Func {
                name: format!("{}-known-objective", worker.name),
                arity: worker.arity - u32::from(!keep_argument),
                locals: optimizer.locals,
                ty: worker.ty.after_args(usize::from(!keep_argument)).clone(),
                body: Body::Expr(body),
            });
            self.known.insert(key, id);
            id
        };
        Some(specialized)
    }

    fn array_callback(&mut self, expression: &mut Expr) -> Option<()> {
        let Expr::Call(primitive, arguments) = expression else {
            return None;
        };
        let primitive = self.program.funcs.get(*primitive)?;
        let Body::Prim(symbol) = &primitive.body else {
            return None;
        };
        let position = match symbol.as_str() {
            "array.map" => 0,
            "array.generate" => 1,
            _ => return None,
        };
        if primitive.arity != 2 || arguments.len() != 2 {
            return None;
        }
        let callback = arguments.get_mut(position)?;
        let Expr::Apply(function, captures) = callback else {
            return None;
        };
        let Expr::Func(worker_id) = &**function else {
            return None;
        };
        let Some(Expr::Func(argument_id)) = captures.first() else {
            return None;
        };
        let worker = self.program.funcs.get(*worker_id)?;
        if worker.arity as usize != captures.len() + 1
            || Some(&worker.ty.after_args(captures.len())) != primitive.ty.params(2).0.get(position)
        {
            return None;
        }
        let specialized = self.known_worker(*worker_id, *argument_id, false)?;
        captures.remove(0);
        if captures.is_empty() {
            *callback = Expr::Func(specialized);
        } else {
            **function = Expr::Func(specialized);
        }
        Some(())
    }

    fn visit(&mut self, expression: &mut Expr, locals: &[MT]) -> bool {
        let mut changed = false;
        match expression {
            Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body)
            | Expr::ResourceRegion { body, .. } => changed |= self.visit(body, locals),
            Expr::Call(_, arguments) | Expr::Construct(_, arguments) | Expr::Record(arguments) => {
                for argument in arguments {
                    changed |= self.visit(argument, locals);
                }
            }
            Expr::Apply(function, arguments) => {
                changed |= self.visit(function, locals);
                for argument in arguments {
                    changed |= self.visit(argument, locals);
                }
            }
            Expr::Field(record, _) => changed |= self.visit(record, locals),
            Expr::SetFields(record, fields) => {
                changed |= self.visit(record, locals);
                for (_, value) in fields {
                    changed |= self.visit(value, locals);
                }
            }
            Expr::Let(_, value, body) => {
                changed |= self.visit(value, locals);
                changed |= self.visit(body, locals);
            }
            Expr::Match(value, arms) => {
                changed |= self.visit(value, locals);
                for (_, body) in arms {
                    changed |= self.visit(body, locals);
                }
            }
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
        }
        self.select(expression, locals).is_some() || changed
    }
}

pub(crate) fn specialize(program: &mut Program) {
    let mut specializer = Specialize {
        program,
        made: Vec::new(),
        known: HashMap::new(),
    };
    let mut changes = Vec::new();
    for (id, function) in program.funcs.iter().enumerate() {
        let Body::Expr(body) = &function.body else {
            continue;
        };
        if size(body) > MAX_BODY {
            continue;
        }
        let mut body = body.clone();
        if specializer.visit(&mut body, &function.locals) {
            changes.push((id, body));
        }
    }
    let made = specializer.made;
    for (id, body) in changes {
        program.funcs[id].body = Body::Expr(body);
    }
    program.funcs.extend(made);
}

#[cfg(test)]
mod tests {
    use super::*;

    fn function(name: &str, parameters: Vec<MT>, result: MT, body: Body) -> Func {
        let ty = parameters.iter().rev().fold(result, |result, input| {
            MT::Fun(Box::new(input.clone()), Box::new(result))
        });
        Func {
            name: name.into(),
            arity: parameters.len() as u32,
            locals: parameters,
            ty,
            body,
        }
    }

    fn program() -> Program {
        let integer = MT::con("std::I64");
        let objective = function(
            "objective",
            vec![integer.clone()],
            integer.clone(),
            Body::Prim("test.objective".into()),
        );
        let worker = function(
            "worker",
            vec![objective.ty.clone(), integer.clone()],
            integer.clone(),
            Body::Expr(Expr::Apply(Box::new(Expr::Local(0)), vec![Expr::Local(1)])),
        );
        let scope = function(
            "unrelated-name",
            vec![worker.ty.clone(), objective.ty.clone(), integer.clone()],
            integer.clone(),
            Body::Prim("ad.scope2".into()),
        );
        Program {
            funcs: vec![
                objective,
                worker,
                scope,
                function(
                    "caller",
                    vec![],
                    integer.clone(),
                    Body::Expr(Expr::Call(
                        2,
                        vec![Expr::Func(1), Expr::Func(0), Expr::Call(4, vec![])],
                    )),
                ),
                function("input", vec![], integer, Body::Prim("test.input".into())),
            ],
            ..Program::default()
        }
    }

    fn array_program(symbol: &str) -> Program {
        let mut program = program();
        let integer = MT::con("std::I64");
        let array = MT::Con("std::Array".into(), vec![integer.clone()]);
        let callback = program.funcs[0].ty.clone();
        let captured = Expr::Apply(Box::new(Expr::Func(1)), vec![Expr::Func(0)]);
        let (parameters, arguments, input) = if symbol == "array.map" {
            (
                vec![callback, array.clone()],
                vec![captured, Expr::Call(4, vec![])],
                array.clone(),
            )
        } else {
            (
                vec![integer.clone(), callback],
                vec![Expr::Call(4, vec![]), captured],
                integer,
            )
        };
        program.funcs[2] = function(
            "array",
            parameters,
            array.clone(),
            Body::Prim(symbol.into()),
        );
        program.funcs[3] = function(
            "caller",
            vec![],
            array,
            Body::Expr(Expr::Call(2, arguments)),
        );
        program.funcs[4] = function("input", vec![], input, Body::Prim("test.input".into()));
        program
    }

    #[test]
    fn array_workers_keep_eager_arguments_and_share_closed_specialization() {
        for symbol in ["array.map", "array.generate"] {
            let mut program = array_program(symbol);
            program.funcs.push(program.funcs[3].clone());
            let position = usize::from(symbol == "array.generate");
            specialize(&mut program);
            assert_eq!(program.funcs.len(), 7);
            for caller in [3, 5] {
                let Body::Expr(Expr::Call(2, arguments)) = &program.funcs[caller].body else {
                    panic!("array call or eager argument moved");
                };
                assert!(matches!(&arguments[1-position], Expr::Call(4, args) if args.is_empty()));
                assert!(matches!(&arguments[position], Expr::Func(6)));
            }
            assert_eq!(program.funcs[6].arity, program.funcs[1].arity - 1);
            assert_eq!(&program.funcs[6].ty, program.funcs[1].ty.after_args(1));
            assert!(
                matches!(&program.funcs[6].body, Body::Expr(Expr::Call(0, args))
                if matches!(args.as_slice(), [Expr::Local(0)]))
            );
            crate::ir::check_locals(&program).unwrap();
        }
    }

    #[test]
    fn array_specialization_preserves_remaining_resource_parameter_identity() {
        let mut program = array_program("array.generate");
        program.funcs[1].body = Body::Expr(Expr::ResourceRegion {
            parameters: vec![0, 1],
            bindings: vec![],
            body: Box::new(Expr::Apply(Box::new(Expr::Local(0)), vec![Expr::Local(1)])),
        });
        specialize(&mut program);
        assert_eq!(program.funcs.len(), 6);
        let Body::Expr(Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        }) = &program.funcs[5].body
        else {
            panic!("remaining resource region was removed");
        };
        assert_eq!(parameters, &[0]);
        assert!(bindings.is_empty());
        assert!(
            matches!(&**body, Expr::Call(0, args) if matches!(args.as_slice(), [Expr::Local(0)]))
        );
        crate::ir::check_locals(&program).unwrap();
    }

    #[test]
    fn array_specialization_rejects_unknown_captured_cached_and_large_functions() {
        for symbol in ["array.map", "array.generate"] {
            for case in 0..6 {
                let mut program = array_program(symbol);
                match case {
                    0 | 1 => {
                        let Body::Expr(Expr::Call(_, args)) = &mut program.funcs[3].body else {
                            unreachable!()
                        };
                        let Expr::Apply(_, captures) =
                            &mut args[usize::from(symbol == "array.generate")]
                        else {
                            unreachable!()
                        };
                        captures[0] = if case == 0 {
                            Expr::Local(0)
                        } else {
                            Expr::Apply(Box::new(Expr::Func(0)), vec![Expr::Call(4, vec![])])
                        };
                    }
                    2 => program.funcs[0].arity = 0,
                    3 => {
                        program.funcs[1].body =
                            Body::Expr(Expr::Record(vec![Expr::Local(1); MAX_BODY]))
                    }
                    4 => program.funcs[1].arity = 3,
                    5 => program.funcs[2].body = Body::Prim("other.array".into()),
                    _ => unreachable!(),
                }
                let before = format!("{:?}", program.funcs[3].body);
                specialize(&mut program);
                assert_eq!(program.funcs.len(), 5, "{symbol}/{case}");
                assert_eq!(format!("{:?}", program.funcs[3].body), before);
            }
        }
    }

    #[test]
    fn scope_and_eager_input_stay_in_place_with_one_shared_worker() {
        let mut program = program();
        program.funcs.push(program.funcs[3].clone());
        specialize(&mut program);
        assert_eq!(program.funcs.len(), 7);
        for caller in [3, 5] {
            let Body::Expr(Expr::Call(2, arguments)) = &program.funcs[caller].body else {
                panic!("scope call moved or changed");
            };
            assert!(matches!(arguments.as_slice(),
                [Expr::Func(6), Expr::Func(0), Expr::Call(4, args)] if args.is_empty()));
        }
        assert_eq!(program.funcs[6].arity, 2);
        assert_eq!(program.funcs[6].ty, program.funcs[1].ty);
        assert!(matches!(&program.funcs[6].body,
            Body::Expr(Expr::Call(0, args)) if matches!(args.as_slice(), [Expr::Local(1)])));
        assert!(matches!(
            &program.funcs[1].body,
            Body::Expr(Expr::Apply(..))
        ));
        crate::ir::check_locals(&program).unwrap();
    }

    #[test]
    fn unknown_captured_and_malformed_scopes_are_not_selected() {
        for case in 0..6 {
            let mut program = program();
            match case {
                0 => program.funcs[2].body = Body::Prim("other.scope2".into()),
                1 => program.funcs[2].arity = 2,
                2 => program.funcs[1].arity = 1,
                3 => program.funcs[0].ty = MT::con("std::I64"),
                4 | 5 => {
                    let Body::Expr(Expr::Call(_, args)) = &mut program.funcs[3].body else {
                        unreachable!()
                    };
                    args[1] = if case == 4 {
                        Expr::Local(0)
                    } else {
                        Expr::Apply(Box::new(Expr::Func(0)), vec![Expr::Call(4, vec![])])
                    };
                }
                _ => unreachable!(),
            }
            let before = format!("{:?}", program.funcs[3].body);
            specialize(&mut program);
            assert_eq!(program.funcs.len(), 5, "case {case}");
            assert_eq!(format!("{:?}", program.funcs[3].body), before);
        }
    }

    #[test]
    fn recursive_workers_do_not_expand_or_move_the_recursive_call() {
        let mut program = program();
        program.funcs[1].body = Body::Expr(Expr::Call(1, vec![Expr::Local(0), Expr::Local(1)]));
        specialize(&mut program);
        assert_eq!(program.funcs.len(), 6);
        assert!(
            matches!(&program.funcs[5].body, Body::Expr(Expr::Call(1, args))
            if matches!(args.as_slice(), [Expr::Func(0), Expr::Local(1)]))
        );
        crate::ir::check_locals(&program).unwrap();
    }

    #[test]
    fn large_workers_keep_the_existing_body_limit() {
        let mut program = program();
        program.funcs[1].body = Body::Expr(Expr::Record(vec![Expr::Local(1); MAX_BODY]));
        specialize(&mut program);
        assert_eq!(program.funcs.len(), 5);
    }

    #[test]
    fn lifting_keeps_calls_once_in_order_and_obeys_budget_and_resource_boundaries() {
        let program = program();
        let expression = Expr::Let(
            0,
            Box::new(Expr::Let(
                1,
                Box::new(Expr::Call(4, vec![])),
                Box::new(Expr::Local(1)),
            )),
            Box::new(Expr::Call(0, vec![Expr::Local(0)])),
        );
        for (budget, resource) in [(1, false), (0, false), (1, true)] {
            let mut optimizer = Opt {
                funcs: &program.funcs,
                shapes: &program.shapes,
                current: usize::MAX,
                locals: vec![
                    MT::con("std::I64"),
                    MT::con(if resource { "std::File" } else { "std::I64" }),
                ],
                budget,
                resource_locals: Vec::new(),
            };
            let result = lift_bindings(expression.clone(), &mut optimizer);
            if budget == 0 || resource {
                assert_eq!(format!("{result:?}"), format!("{expression:?}"));
                assert_eq!(optimizer.budget, budget);
            } else {
                let Expr::Let(1, first, rest) = result else {
                    panic!("inner initializer not exposed")
                };
                assert!(matches!(*first, Expr::Call(4, ref args) if args.is_empty()));
                let Expr::Let(0, value, last) = *rest else {
                    panic!("outer binding lost")
                };
                assert!(matches!(*value, Expr::Local(1)));
                assert!(
                    matches!(*last, Expr::Call(0, ref args) if matches!(args.as_slice(), [Expr::Local(0)]))
                );
                assert_eq!(optimizer.budget, 0);
            }
        }
        let region = Expr::ResourceRegion {
            parameters: vec![],
            bindings: vec![1],
            body: Box::new(expression),
        };
        let mut optimizer = Opt {
            funcs: &program.funcs,
            shapes: &program.shapes,
            current: usize::MAX,
            locals: vec![MT::con("std::I64"); 2],
            budget: 600,
            resource_locals: Vec::new(),
        };
        let result = lift_bindings(region.clone(), &mut optimizer);
        assert_eq!(format!("{result:?}"), format!("{region:?}"));
        assert_eq!(optimizer.budget, 600);
    }
}
