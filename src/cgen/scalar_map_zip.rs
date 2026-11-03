//! Keep a sole-use eager scalar map in a private buffer until zip-with consumes it.
//! Uses and straight-line aliases are indexed once, before any mutation. Mapping
//! and zipping stay at their original calls; their callbacks never interleave.
use std::collections::HashMap;

use crate::ir::*;

#[derive(Clone, Copy)]
enum Use {
    Other,
    Alias(Local, usize),
    Zip {
        node: usize,
        block: usize,
        callback: FuncId,
        slot: usize,
    },
}

struct Producer {
    node: usize,
    local: Local,
    block: usize,
    callback: FuncId,
}

fn buffer() -> MT {
    MT::Con("std::Array".into(), vec![MT::con("std::I64")])
}

fn list(element: &MT) -> MT {
    MT::Con("std::List".into(), vec![element.clone()])
}

fn callback(program: &Program, id: FuncId, arity: usize) -> bool {
    let Some(function) = program.funcs.get(id) else {
        return false;
    };
    let (parameters, result) = function.ty.params(arity);
    function.arity as usize == arity
        && matches!(function.body, Body::Expr(_) | Body::Prim(_))
        && parameters.len() == arity
        && parameters.iter().all(|ty| super::scalar(ty).is_some())
        && super::scalar(result).is_some()
}

fn operation(program: &Program, id: FuncId, name: &str, step: FuncId, arity: usize) -> bool {
    let Some(function) = program.funcs.get(id) else {
        return false;
    };
    if !matches!(&function.body, Body::Prim(symbol) if symbol == name)
        || function.arity as usize != arity + 1
        || !callback(program, step, arity)
    {
        return false;
    }
    let worker = &program.funcs[step];
    let (inputs, output) = worker.ty.params(arity);
    let (parameters, result) = function.ty.params(arity + 1);
    parameters.len() == arity + 1
        && parameters[0] == &worker.ty
        && parameters[1..]
            .iter()
            .zip(inputs)
            .all(|(actual, input)| **actual == list(input))
        && result == &list(output)
}

struct Index<'a> {
    program: &'a Program,
    uses: Vec<Option<Use>>,
    producers: Vec<Producer>,
    blocks: usize,
    visits: usize,
}

impl Index<'_> {
    fn use_local(&mut self, local: Local, usage: Use) {
        let entry = &mut self.uses[local as usize];
        *entry = Some(if entry.is_none() { usage } else { Use::Other });
    }

    fn nested(&mut self, expr: &Expr) {
        self.blocks += 1;
        self.walk(expr, self.blocks, Use::Other);
    }

    fn walk(&mut self, expr: &Expr, block: usize, usage: Use) {
        self.visits += 1;
        match expr {
            Expr::Local(local) => self.use_local(*local, usage),
            Expr::Let(local, value, body) => {
                if let Expr::Call(id, arguments) = &**value {
                    if let [Expr::Func(step), _] = arguments.as_slice() {
                        if operation(self.program, *id, "map", *step, 1) {
                            self.producers.push(Producer {
                                node: &**value as *const Expr as usize,
                                local: *local,
                                block,
                                callback: *step,
                            });
                        }
                    }
                }
                self.walk(value, block, Use::Alias(*local, block));
                self.walk(body, block, usage);
            }
            Expr::Trace(_, body) => self.walk(body, block, usage),
            Expr::Call(id, arguments) => {
                let step = match arguments.as_slice() {
                    [Expr::Func(step), _, _]
                        if operation(self.program, *id, "zip-with", *step, 2) =>
                    {
                        Some(*step)
                    }
                    _ => None,
                };
                for (slot, argument) in arguments.iter().enumerate() {
                    if let (Some(callback), Expr::Local(_)) = (step, argument) {
                        self.walk(
                            argument,
                            block,
                            Use::Zip {
                                node: expr as *const Expr as usize,
                                block,
                                callback,
                                slot: slot - 1,
                            },
                        );
                    } else {
                        self.nested(argument);
                    }
                }
            }
            Expr::Apply(function, arguments) => {
                self.nested(function);
                for argument in arguments {
                    self.nested(argument);
                }
            }
            Expr::Construct(_, fields) | Expr::Record(fields) => {
                for field in fields {
                    self.nested(field);
                }
            }
            Expr::Field(value, _) => self.nested(value),
            Expr::SetFields(value, fields) => {
                self.nested(value);
                for (_, field) in fields {
                    self.nested(field);
                }
            }
            Expr::Match(value, arms) => {
                self.nested(value);
                for (_, body) in arms {
                    self.nested(body);
                }
            }
            Expr::Dup(local, body) | Expr::Drop(local, body) => {
                self.use_local(*local, Use::Other);
                self.nested(body);
            }
            Expr::BorrowGlobal(_, _, body) => self.nested(body),
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => {
                for local in parameters.iter().chain(bindings) {
                    self.use_local(*local, Use::Other);
                }
                self.nested(body);
            }
            Expr::Const(_) | Expr::Func(_) => {}
        }
    }
}

fn function_body(name: &str, parameters: Vec<MT>, result: MT, body: Body) -> Func {
    let ty = parameters.iter().rev().fold(result, |result, parameter| {
        MT::Fun(Box::new(parameter.clone()), Box::new(result))
    });
    Func {
        name: name.into(),
        arity: parameters.len() as u32,
        locals: parameters,
        ty,
        body,
    }
}

// The node addresses belong to this exact body. Do not clone or replace it
// between indexing and rewriting. Rewrites remove only the callback argument;
// remaining expressions stay at the same evaluation points.
fn rewrite(expr: &mut Expr, calls: &HashMap<usize, FuncId>, visits: &mut usize) {
    *visits += 1;
    let replacement = calls.get(&(expr as *const Expr as usize)).copied();
    match expr {
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                rewrite(arg, calls, visits);
            }
        }
        Expr::Apply(f, args) => {
            rewrite(f, calls, visits);
            for arg in args {
                rewrite(arg, calls, visits);
            }
        }
        Expr::Let(_, value, body) => {
            rewrite(value, calls, visits);
            rewrite(body, calls, visits);
        }
        Expr::Match(value, arms) => {
            rewrite(value, calls, visits);
            for (_, body) in arms {
                rewrite(body, calls, visits);
            }
        }
        Expr::SetFields(value, fields) => {
            rewrite(value, calls, visits);
            for (_, value) in fields {
                rewrite(value, calls, visits);
            }
        }
        Expr::Field(body, _)
        | Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::ResourceRegion { body, .. } => rewrite(body, calls, visits),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
    if let Some(new_id) = replacement {
        let Expr::Call(id, arguments) = expr else {
            unreachable!()
        };
        assert!(matches!(arguments.first(), Some(Expr::Func(_))));
        arguments.remove(0);
        *id = new_id;
    }
}

/// Deterministic visit count for analysis-scaling controls. No program clone.
pub(super) fn lower(program: &mut Program) -> usize {
    let original_len = program.funcs.len();
    let mut made = Vec::new();
    let mut maps = HashMap::new();
    let mut zips = HashMap::new();
    let mut visits = 0;
    for id in 0..original_len {
        let function = &program.funcs[id];
        let Body::Expr(body) = &function.body else {
            continue;
        };
        let mut index = Index {
            program,
            uses: vec![None; function.locals.len()],
            producers: Vec::new(),
            blocks: 0,
            visits: 0,
        };
        index.walk(body, 0, Use::Other);
        visits += index.visits;
        if index.producers.is_empty() {
            continue;
        }
        let mut calls = HashMap::new();
        let mut changed = Vec::new();
        let mut marks = vec![usize::MAX; function.locals.len()];
        for (generation, producer) in index.producers.iter().enumerate() {
            let element = program.funcs[producer.callback].ty.params(1).1;
            let mut local = producer.local;
            let mut aliases = Vec::new();
            let target = loop {
                visits += 1;
                if marks[local as usize] == generation
                    || function.locals[local as usize] != list(element)
                {
                    break None;
                }
                marks[local as usize] = generation;
                aliases.push(local);
                match index.uses[local as usize] {
                    Some(Use::Alias(next, block)) if block == producer.block => local = next,
                    Some(Use::Zip {
                        node,
                        block,
                        callback,
                        slot,
                    }) if block == producer.block => {
                        break Some((node, callback, slot));
                    }
                    _ => break None,
                }
            };
            let Some((node, step, slot)) = target else {
                continue;
            };
            if calls.contains_key(&node) {
                continue;
            }
            let (zip_parameters, zip_result) = program.funcs[step].ty.params(2);
            if zip_parameters[slot] != element {
                continue;
            }
            let map = *maps.entry(producer.callback).or_insert_with(|| {
                let new_id = original_len + made.len();
                let input = program.funcs[producer.callback].ty.params(1).0[0];
                made.push(function_body(
                    "scalar-buffer-map",
                    vec![list(input)],
                    buffer(),
                    Body::ScalarBufferMap {
                        callback: producer.callback,
                    },
                ));
                new_id
            });
            let zip = *zips.entry((step, slot)).or_insert_with(|| {
                let new_id = original_len + made.len();
                let parameters = zip_parameters
                    .iter()
                    .enumerate()
                    .map(|(i, ty)| if i == slot { buffer() } else { list(ty) })
                    .collect();
                made.push(function_body(
                    "scalar-buffer-zip",
                    parameters,
                    list(zip_result),
                    Body::ScalarBufferZip {
                        callback: step,
                        slot,
                    },
                ));
                new_id
            });
            calls.insert(producer.node, map);
            calls.insert(node, zip);
            changed.extend(aliases);
        }
        if !calls.is_empty() {
            let function = &mut program.funcs[id];
            let Body::Expr(body) = &mut function.body else {
                unreachable!()
            };
            rewrite(body, &calls, &mut visits);
            for local in changed {
                function.locals[local as usize] = buffer();
            }
        }
    }
    program.funcs.extend(made);
    visits
}

#[cfg(test)]
mod tests {
    use super::*;

    fn example(aliases: usize, slot: usize) -> Program {
        let number = MT::con("std::F64");
        let sequence = list(&number);
        let map = function_body(
            "mapped",
            vec![number.clone()],
            number.clone(),
            Body::Expr(Expr::Local(0)),
        );
        let step = function_body(
            "step",
            vec![number.clone(), number],
            MT::con("std::F64"),
            Body::Expr(Expr::Local(1)),
        );
        let map_primitive = function_body(
            "map",
            vec![map.ty.clone(), sequence.clone()],
            sequence.clone(),
            Body::Prim("map".into()),
        );
        let zip_primitive = function_body(
            "zip-with",
            vec![step.ty.clone(), sequence.clone(), sequence.clone()],
            sequence.clone(),
            Body::Prim("zip-with".into()),
        );
        let last = 2 + aliases as Local;
        let mut arguments = vec![Expr::Func(2), Expr::Local(1), Expr::Local(1)];
        arguments[slot + 1] = Expr::Local(last);
        let mut body = Expr::Call(4, arguments);
        for local in (3..=last).rev() {
            body = Expr::Let(local, Box::new(Expr::Local(local - 1)), Box::new(body));
        }
        body = Expr::Let(
            2,
            Box::new(Expr::Call(3, vec![Expr::Func(1), Expr::Local(0)])),
            Box::new(body),
        );
        let mut entry = function_body(
            "entry",
            vec![sequence.clone(), sequence.clone()],
            sequence.clone(),
            Body::Expr(body),
        );
        entry.locals.extend(vec![sequence; aliases + 1]);
        Program {
            funcs: vec![entry, map, step, map_primitive, zip_primitive],
            main: Some(0),
            ..Program::default()
        }
    }

    #[test]
    fn both_slots_follow_complete_single_use_alias_chains() {
        for slot in 0..2 {
            let mut program = example(4, slot);
            crate::ir::check_locals(&program).unwrap();
            lower(&mut program);
            crate::ir::check_locals(&program).unwrap();
            assert_eq!(program.funcs.len(), 7);
            assert!(program.funcs[0].locals[2..]
                .iter()
                .all(|ty| *ty == buffer()));
            assert!(matches!(
                program.funcs[5].body,
                Body::ScalarBufferMap { callback: 1 }
            ));
            assert!(
                matches!(program.funcs[6].body, Body::ScalarBufferZip { callback: 2, slot: selected } if selected == slot)
            );
            let live = live_functions(&program, &[]).unwrap();
            assert!(live[1] && live[2] && live[5] && live[6]);
        }
    }

    #[test]
    fn shared_map_and_conditional_consumer_are_not_selected() {
        for conditional in [false, true] {
            let mut program = example(0, 0);
            let Body::Expr(Expr::Let(_, _, body)) = &mut program.funcs[0].body else {
                unreachable!()
            };
            let original = (**body).clone();
            **body = if conditional {
                Expr::Match(
                    Box::new(Expr::Const(crate::value::Value::unit())),
                    vec![(Pat::Wild, original)],
                )
            } else {
                Expr::Let(3, Box::new(Expr::Local(2)), Box::new(original))
            };
            program.funcs[0].locals.push(list(&MT::con("std::F64")));
            lower(&mut program);
            assert_eq!(program.funcs.len(), 5);
        }
    }

    #[test]
    fn unknown_callbacks_and_boxed_values_are_not_selected() {
        let mut program = example(0, 0);
        let Body::Expr(Expr::Let(_, value, _)) = &mut program.funcs[0].body else {
            unreachable!()
        };
        let Expr::Call(_, arguments) = &mut **value else {
            unreachable!()
        };
        arguments[0] = Expr::Local(3);
        let callback_type = program.funcs[1].ty.clone();
        program.funcs[0].locals.push(callback_type);
        lower(&mut program);
        assert_eq!(program.funcs.len(), 5);
        for name in ["std::F128", "std::String", "std::I128"] {
            let mut program = example(0, 0);
            let number = MT::con(name);
            program.funcs[1] = function_body(
                "wide",
                vec![number.clone()],
                number,
                Body::Expr(Expr::Local(0)),
            );
            lower(&mut program);
            assert_eq!(program.funcs.len(), 5);
        }
    }

    #[test]
    fn only_one_of_two_private_inputs_changes_representation() {
        let mut program = example(0, 0);
        let Body::Expr(Expr::Let(_, _, body)) = &mut program.funcs[0].body else {
            unreachable!()
        };
        **body = Expr::Let(
            3,
            Box::new(Expr::Call(3, vec![Expr::Func(1), Expr::Local(1)])),
            Box::new(Expr::Call(
                4,
                vec![Expr::Func(2), Expr::Local(2), Expr::Local(3)],
            )),
        );
        program.funcs[0].locals.push(list(&MT::con("std::F64")));
        lower(&mut program);
        crate::ir::check_locals(&program).unwrap();
        assert_eq!(program.funcs.len(), 7);
        assert_eq!(program.funcs[0].locals[2], buffer());
        assert_eq!(program.funcs[0].locals[3], list(&MT::con("std::F64")));
    }

    #[test]
    fn alias_index_and_rewrite_work_scale_linearly() {
        let small = lower(&mut example(64, 0));
        let large = lower(&mut example(128, 0));
        assert!(large <= 2 * small, "{small} -> {large}");
        assert!(large < 12 * 128, "{large}");
    }
}
