//! Expose a closed function argument inside a known derivative-scope worker.
//! Keep the scope call, its arguments and the worker's call stage unchanged.
//! Only original call sites are visited; generated workers cannot recursively
//! expand this pass. Each worker/function pair shares one bounded specialization.

use std::collections::HashMap;

use super::{size, substitute, Opt, MAX_BODY, ROUNDS};
use crate::ir::*;

struct Specialize<'a> {
    program: &'a Program,
    made: Vec<Func>,
    known: HashMap<(FuncId, FuncId), FuncId>,
}

impl Specialize<'_> {
    fn select(&mut self, expression: &mut Expr, locals: &[MT]) -> Option<()> {
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
        let key = (worker_id, argument_id);
        let specialized = if let Some(id) = self.known.get(&key) {
            *id
        } else {
            let mut substitutions = vec![None; worker.locals.len()];
            substitutions[0] = Some(Expr::Func(argument_id));
            let mut body = substitute(body, &substitutions);
            let mut optimizer = Opt {
                funcs: &self.program.funcs,
                shapes: &self.program.shapes,
                current: worker_id,
                locals: worker.locals.clone(),
                budget: 600,
                resource_locals: Vec::new(),
            };
            for _ in 0..ROUNDS {
                body = optimizer.expr(body, 0);
            }
            let id = self.program.funcs.len() + self.made.len();
            self.made.push(Func {
                name: format!("{}-known-objective", worker.name),
                arity: worker.arity,
                locals: optimizer.locals,
                ty: worker.ty.clone(),
                body: Body::Expr(body),
            });
            self.known.insert(key, id);
            id
        };
        // Retain even the now-known argument: its original evaluation and the
        // primitive's borrowed-call protocol stay exactly where they were.
        arguments[0] = Expr::Func(specialized);
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
}
