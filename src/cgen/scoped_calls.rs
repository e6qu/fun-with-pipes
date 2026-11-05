//! Expose a closed derivative-scope callback as a direct word-valued worker.
//!
//! Scope arguments still borrow. The worker's independently inferred contract
//! decides which slots need owners; the scope prepares those owners explicitly.

use std::collections::{HashMap, HashSet};

use crate::ir::*;

struct Lower<'a> {
    program: &'a Program,
    made: Vec<Func>,
    scopes: HashMap<FuncId, FuncId>,
}

impl Lower<'_> {
    fn visit(&mut self, expr: &mut Expr) {
        match expr {
            Expr::ResourceRegion { .. } => return,
            Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
                for arg in args {
                    self.visit(arg);
                }
            }
            Expr::Apply(target, args) => {
                self.visit(target);
                for arg in args {
                    self.visit(arg);
                }
            }
            Expr::Let(_, value, body) => {
                self.visit(value);
                self.visit(body);
            }
            Expr::Match(value, arms) => {
                self.visit(value);
                for (_, body) in arms {
                    self.visit(body);
                }
            }
            Expr::SetFields(value, fields) => {
                self.visit(value);
                for (_, value) in fields {
                    self.visit(value);
                }
            }
            Expr::Field(body, _)
            | Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body) => self.visit(body),
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
        }
        let _ = self.select(expr);
    }

    fn select(&mut self, expr: &mut Expr) -> Option<()> {
        let Expr::Call(scope, args) = expr else {
            return None;
        };
        let Body::Prim(symbol) = &self.program.funcs[*scope].body else {
            return None;
        };
        let arity = match symbol.as_str() {
            "ad.scope" => 1,
            "ad.scope2" => 2,
            _ => return None,
        };
        if args.len() != arity + 1 {
            return None;
        }
        let Expr::Func(callback) = args[0] else {
            return None;
        };
        let worker = &self.program.funcs[callback];
        // This proof covers the missing word-valued convention. Existing
        // numeric/record workers need their own argument/result representation
        // proof before this operation can call them directly.
        if worker.arity as usize != arity
            || !matches!(worker.body, Body::Expr(_))
            || super::abi_of(self.program, worker).is_some()
            || !matches!(worker.ty.params(arity).1, MT::Con(name, elements)
                if name == "std::Array" && elements.len() == 1)
        {
            return None;
        }
        let id = *self.scopes.entry(callback).or_insert_with(|| {
            let id = self.program.funcs.len() + self.made.len();
            self.made.push(Func {
                name: "direct-ad-scope".into(),
                ty: worker.ty.clone(),
                arity: worker.arity,
                locals: worker.locals[..arity].to_vec(),
                body: Body::DirectAdScope { callback },
            });
            id
        });
        *expr = Expr::Call(id, args[1..].to_vec());
        Some(())
    }
}

pub(super) fn lower(program: &mut Program) {
    let source = program.clone();
    let mut lower = Lower {
        program: &source,
        made: Vec::new(),
        scopes: HashMap::new(),
    };
    for function in &mut program.funcs {
        if let Body::Expr(body) = &mut function.body {
            lower.visit(body);
        }
    }
    program.funcs.extend(lower.made);
}

pub(super) fn word_workers(program: &Program) -> HashSet<FuncId> {
    program
        .funcs
        .iter()
        .filter_map(|f| match f.body {
            Body::DirectAdScope { callback } => Some(callback),
            _ => None,
        })
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::value::Value;
    use std::collections::BTreeMap;

    fn function(name: &str, inputs: Vec<MT>, result: MT, body: Body) -> Func {
        let ty = inputs.iter().rev().fold(result, |result, input| {
            MT::Fun(Box::new(input.clone()), Box::new(result))
        });
        Func {
            name: name.into(),
            arity: inputs.len() as u32,
            locals: inputs,
            ty,
            body,
        }
    }

    fn program(keep_input: bool) -> Program {
        let scalar = MT::con("std::F64");
        let list = MT::Con("std::List".into(), vec![scalar.clone()]);
        let array = MT::Con("std::Array".into(), vec![scalar.clone()]);
        let int = MT::con("std::I64");
        let worker = function(
            "worker",
            vec![list.clone()],
            array.clone(),
            Body::Expr(Expr::Let(
                1,
                Box::new(Expr::Call(3, vec![Expr::Local(0)])),
                Box::new(Expr::Const(Value::Array(vec![].into()))),
            )),
        );
        let call = Expr::Call(2, vec![Expr::Func(1), Expr::Local(0)]);
        let body = if keep_input {
            Expr::Let(
                1,
                Box::new(call),
                Box::new(Expr::Let(
                    2,
                    Box::new(Expr::Call(3, vec![Expr::Local(0)])),
                    Box::new(Expr::Local(1)),
                )),
            )
        } else {
            call
        };
        let mut program = Program::default();
        program.shapes.insert(
            list.clone(),
            TypeShape::Adt(vec![
                ("Nil".into(), vec![]),
                ("Cons".into(), vec![scalar, list.clone()]),
            ]),
        );
        program.funcs = vec![
            function("main", vec![list.clone()], array.clone(), Body::Expr(body)),
            worker.clone(),
            function(
                "scope",
                vec![worker.ty, list.clone()],
                array,
                Body::Prim("ad.scope".into()),
            ),
            function(
                "length",
                vec![list],
                int.clone(),
                Body::Prim("length".into()),
            ),
        ];
        let result = program.funcs[1].ty.params(1).1.clone();
        program.funcs[0].locals.extend([result, int.clone()]);
        program.funcs[1].locals.push(int);
        program.main = Some(0);
        program
    }

    fn borrowed(program: &Program) -> BTreeMap<FuncId, Vec<Local>> {
        let workers = word_workers(program);
        let owned: Vec<_> = (0..program.funcs.len())
            .map(|id| !workers.contains(&id))
            .collect();
        let live = crate::ir::reachable_functions(program, &[0]).unwrap();
        crate::rc::borrows::infer(program, &owned, &live)
    }

    #[test]
    fn scope_worker_borrows_only_with_a_continuing_caller_owner() {
        let mut p = program(true);
        lower(&mut p);
        assert_eq!(p.funcs.len(), 5);
        assert!(matches!(
            p.funcs[4].body,
            Body::DirectAdScope { callback: 1 }
        ));
        assert_eq!(borrowed(&p), BTreeMap::from([(1, vec![0])]));
        p.borrowed_parameters = borrowed(&p);
        let (body, locals) = crate::rc::insert(&p)[1].clone().unwrap();
        crate::rc::ownership_liveness(&p, &p.funcs[1], &body, &locals, &[0]).unwrap();
        let broken = Expr::Drop(0, Box::new(body));
        assert!(crate::rc::ownership_liveness(&p, &p.funcs[1], &broken, &locals, &[0]).is_err());
        let mut last_use = program(false);
        lower(&mut last_use);
        assert!(borrowed(&last_use).is_empty());
    }

    #[test]
    fn owner_after_an_enclosing_call_survives_nested_scope_evaluation() {
        for keep_input in [false, true] {
            let mut p = program(keep_input);
            let array = p.funcs[1].ty.params(1).1.clone();
            p.funcs.push(function(
                "identity-array",
                vec![array.clone()],
                array,
                Body::Expr(Expr::Local(0)),
            ));
            let Body::Expr(body) = &mut p.funcs[0].body else {
                unreachable!()
            };
            let call = if let Expr::Let(_, value, _) = body {
                value.as_mut()
            } else {
                body
            };
            *call = Expr::Call(4, vec![call.clone()]);
            lower(&mut p);
            assert_eq!(borrowed(&p).contains_key(&1), keep_input);
        }
    }

    #[test]
    fn escaping_exported_dynamic_and_recursive_workers_keep_owned_parameters() {
        for case in 0..4 {
            let mut p = program(true);
            lower(&mut p);
            match case {
                0 => p.funcs[1].body = Body::Expr(Expr::Local(0)),
                1 => p.exports.push(("worker".into(), 1)),
                2 => {
                    let Body::Expr(body) = p.funcs[0].body.clone() else {
                        unreachable!()
                    };
                    let worker_type = p.funcs[1].ty.clone();
                    p.funcs[0].locals.push(worker_type);
                    p.funcs[0].body =
                        Body::Expr(Expr::Let(3, Box::new(Expr::Func(1)), Box::new(body)));
                }
                3 => p.funcs[1].body = Body::Expr(Expr::Call(1, vec![Expr::Local(0)])),
                _ => unreachable!(),
            }
            assert!(borrowed(&p).is_empty(), "case {case}");
        }
    }

    #[test]
    fn repeated_calls_share_one_entry_and_captured_targets_remain_dynamic() {
        let mut p = program(true);
        let call = Expr::Call(2, vec![Expr::Func(1), Expr::Local(0)]);
        p.funcs[0].body = Body::Expr(Expr::Record(vec![call; 1024]));
        lower(&mut p);
        assert_eq!(p.funcs.len(), 5);
        let mut p = program(true);
        p.funcs[0].body = Body::Expr(Expr::Call(
            2,
            vec![
                Expr::Apply(Box::new(Expr::Func(1)), vec![Expr::Local(0)]),
                Expr::Local(0),
            ],
        ));
        lower(&mut p);
        assert_eq!(p.funcs.len(), 4);
    }
}
