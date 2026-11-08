//! Consume dead numeric inputs through explicit private entries, before ARC.
//! One reverse walk records later uses; one rewrite changes selected calls.
//! Branches share a conservative union of uses. Ordinary call arguments and
//! resource-bearing bodies are excluded rather than guessing owner lifetimes.
use std::collections::{HashMap, HashSet};

use crate::ir::*;

#[derive(Clone, Copy, Debug, Eq, Hash, PartialEq)]
enum Operation {
    Map(FuncId, FuncId),
    Zip(FuncId, bool),
}

fn callback(program: &Program, id: FuncId, arity: usize) -> bool {
    let function = &program.funcs[id];
    let (parameters, result) = function.ty.params(arity);
    function.arity as usize == arity
        && parameters.len() == arity
        && parameters.iter().all(|ty| super::scalar(ty).is_some())
        && super::scalar(result).is_some()
        && matches!(function.body, Body::Expr(_) | Body::Prim(_))
}

fn selection(
    program: &Program,
    locals: &[MT],
    id: FuncId,
    args: &[Expr],
) -> Option<(Option<Local>, Operation)> {
    let function = &program.funcs[id];
    match (&function.body, args) {
        (Body::Prim(symbol), [mapped, input]) if symbol == "array.map" => {
            // A partial call evaluates its captures here but cannot enter the
            // callback body. Only plain scalar captures may cross the loop.
            let (step, captures) = match mapped {
                Expr::Func(step) => (*step, 0),
                Expr::Call(step, args) => (*step, args.len()),
                _ => return None,
            };
            if !callback(program, step, captures + 1) {
                return None;
            }
            let worker = &program.funcs[step];
            let (parameters, result) = worker.ty.params(captures + 1);
            let array = MT::Con("std::Array".into(), vec![result.clone()]);
            let (actual, output) = function.ty.params(2);
            // A saturated call returns an owner at this exact evaluation
            // point. It need not allocate: aliases still prevent reuse.
            let local = match input {
                Expr::Local(local) if locals.get(*local as usize) == Some(&array) => Some(*local),
                Expr::Call(producer, arguments)
                    if program.funcs[*producer].arity as usize == arguments.len()
                        && program.funcs[*producer].ty.after_args(arguments.len()) == &array =>
                {
                    None
                }
                _ => return None,
            };
            (parameters[captures] == result
                && function.arity == 2
                && actual == vec![worker.ty.after_args(captures), &array]
                && output == &array)
                .then_some((local, Operation::Map(id, step)))
        }
        (
            Body::ScalarBufferZip {
                callback: step,
                slot,
            },
            [Expr::Local(a), Expr::Local(b)],
        ) if *slot < 2 && a != b && callback(program, *step, 2) => {
            let input = if *slot == 0 { *b } else { *a };
            let (parameters, result) = program.funcs[*step].ty.params(2);
            let list = MT::Con("std::List".into(), vec![result.clone()]);
            let (actual, output) = function.ty.params(2);
            (parameters[1 - slot] == result
                && function.arity == 2
                && actual.len() == 2
                && locals.get(*a as usize) == Some(actual[0])
                && locals.get(*b as usize) == Some(actual[1])
                && actual[1 - slot] == &list
                && output == &list)
                .then_some((Some(input), Operation::Zip(id, false)))
        }
        _ => None,
    }
}

struct Analysis<'a> {
    program: &'a Program,
    locals: &'a [MT],
    later: HashSet<Local>,
    selected: Vec<(usize, Operation)>,
    anchored: bool,
    visits: usize,
}

impl Analysis<'_> {
    fn walk(&mut self, expr: &Expr, eligible: bool) {
        self.visits += 1;
        match expr {
            Expr::Local(local) => {
                self.later.insert(*local);
            }
            Expr::Call(id, args) => {
                if eligible {
                    if let Some((input, operation)) =
                        selection(self.program, self.locals, *id, args)
                    {
                        if input.is_none_or(|local| !self.later.contains(&local)) {
                            let operation = match operation {
                                Operation::Zip(id, false) if super::GRADIENT_CALL_STORAGE => {
                                    let Body::ScalarBufferZip { slot, .. } =
                                        self.program.funcs[id].body
                                    else {
                                        unreachable!()
                                    };
                                    let Expr::Local(array) = args[slot] else {
                                        unreachable!()
                                    };
                                    let word_array = matches!(&self.locals[array as usize], MT::Con(name, elements)
                                        if name == "std::Array" && elements.len() == 1
                                            && matches!(&elements[0], MT::Con(name, args) if args.is_empty()
                                                && matches!(name.as_str(), "std::I64" | "std::U64" | "std::F64")));
                                    Operation::Zip(id, word_array && !self.later.contains(&array))
                                }
                                other => other,
                            };
                            self.selected
                                .push((expr as *const Expr as usize, operation));
                        }
                    }
                }
                for arg in args.iter().rev() {
                    self.walk(arg, false);
                }
            }
            Expr::Let(_, value, body) => {
                self.walk(body, eligible);
                self.walk(value, eligible);
            }
            Expr::Match(value, arms) => {
                // Union, without copying a live-local set for each arm. This
                // may exclude an earlier arm but never misses a later use.
                for (_, body) in arms.iter().rev() {
                    self.walk(body, eligible);
                }
                self.walk(value, false);
            }
            Expr::Apply(function, args) => {
                for arg in args.iter().rev() {
                    self.walk(arg, false);
                }
                self.walk(function, false);
            }
            Expr::Record(fields) | Expr::Construct(_, fields) => {
                // Constructors own their fields. ARC prepares earlier field
                // owners before a later consuming call. A record passed to an
                // ordinary call remains excluded by that call's eligibility.
                for field in fields.iter().rev() {
                    self.walk(field, eligible);
                }
            }
            Expr::SetFields(base, fields) => {
                for (_, field) in fields.iter().rev() {
                    self.walk(field, false);
                }
                self.walk(base, false);
            }
            Expr::ResourceRegion { body, .. } => {
                self.anchored = true;
                self.walk(body, false);
            }
            Expr::Dup(_, body) | Expr::Drop(_, body) | Expr::BorrowGlobal(_, _, body) => {
                // These appear only after ownership preparation. This pass
                // must not reinterpret an already prepared lifetime.
                self.anchored = true;
                self.walk(body, false);
            }
            Expr::Trace(_, body) => self.walk(body, eligible),
            Expr::Field(body, _) => self.walk(body, false),
            Expr::Const(_) | Expr::Func(_) => {}
        }
    }
}

fn entry(program: &Program, operation: Operation) -> Func {
    match operation {
        Operation::Map(id, callback) => {
            let original = &program.funcs[id];
            let (parameters, result) = original.ty.params(2);
            let worker = &program.funcs[callback];
            let captures = worker.arity as usize - 1;
            let mut inputs: Vec<_> = worker.ty.params(captures).0.into_iter().cloned().collect();
            inputs.push(parameters[1].clone());
            Func {
                name: "consumed-scalar-array-map".into(),
                arity: inputs.len() as u32,
                ty: inputs.iter().rev().fold(result.clone(), |result, input| {
                    MT::Fun(Box::new(input.clone()), Box::new(result))
                }),
                locals: inputs,
                body: Body::OwnedScalarArrayMap { callback },
            }
        }
        Operation::Zip(id, consume_array) => {
            let original = &program.funcs[id];
            let Body::ScalarBufferZip { callback, slot } = original.body else {
                unreachable!()
            };
            Func {
                name: "consumed-scalar-array-list-zip".into(),
                arity: original.arity,
                locals: original.locals.clone(),
                ty: original.ty.clone(),
                body: Body::OwnedScalarBufferZip {
                    callback,
                    slot,
                    consume_array,
                },
            }
        }
    }
}

fn rewrite(expr: &mut Expr, replacements: &HashMap<usize, (FuncId, bool)>, visits: &mut usize) {
    *visits += 1;
    let selected = replacements.get(&(expr as *const Expr as usize)).copied();
    match expr {
        Expr::Call(_, args) | Expr::Record(args) | Expr::Construct(_, args) => {
            for arg in args {
                rewrite(arg, replacements, visits);
            }
        }
        Expr::Apply(function, args) => {
            rewrite(function, replacements, visits);
            for arg in args {
                rewrite(arg, replacements, visits);
            }
        }
        Expr::Let(_, value, body) => {
            rewrite(value, replacements, visits);
            rewrite(body, replacements, visits);
        }
        Expr::Match(value, arms) => {
            rewrite(value, replacements, visits);
            for (_, body) in arms {
                rewrite(body, replacements, visits);
            }
        }
        Expr::SetFields(base, fields) => {
            rewrite(base, replacements, visits);
            for (_, field) in fields {
                rewrite(field, replacements, visits);
            }
        }
        Expr::Field(body, _)
        | Expr::Trace(_, body)
        | Expr::ResourceRegion { body, .. }
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body) => rewrite(body, replacements, visits),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
    if let Some((replacement, remove_callback)) = selected {
        let Expr::Call(id, args) = expr else {
            unreachable!()
        };
        *id = replacement;
        if remove_callback {
            match args.remove(0) {
                Expr::Func(_) => {}
                Expr::Call(_, mut captures) => {
                    captures.append(args);
                    *args = captures;
                }
                _ => unreachable!("selected scalar callback changed"),
            }
        }
    }
}

pub(super) fn lower(program: &mut Program) -> usize {
    let original = program.funcs.len();
    let mut entries = HashMap::new();
    let mut made = Vec::new();
    let mut visits = 0;
    for id in 0..original {
        let function = &program.funcs[id];
        let Body::Expr(body) = &function.body else {
            continue;
        };
        let mut analysis = Analysis {
            program,
            locals: &function.locals,
            later: HashSet::new(),
            selected: Vec::new(),
            anchored: false,
            visits: 0,
        };
        analysis.walk(body, true);
        visits += analysis.visits;
        if analysis.anchored || analysis.selected.is_empty() {
            continue;
        }
        let mut replacements = HashMap::new();
        for (node, operation) in analysis.selected {
            let next = *entries.entry(operation).or_insert_with(|| {
                let next = original + made.len();
                made.push(entry(program, operation));
                next
            });
            replacements.insert(node, (next, matches!(operation, Operation::Map(..))));
        }
        let Body::Expr(body) = &mut program.funcs[id].body else {
            unreachable!()
        };
        rewrite(body, &replacements, &mut visits);
    }
    program.funcs.extend(made);
    visits
}

#[cfg(test)]
mod tests {
    use super::*;

    fn function(name: &str, parameters: Vec<MT>, result: MT, body: Body) -> Func {
        Func {
            name: name.into(),
            arity: parameters.len() as u32,
            ty: parameters.iter().rev().fold(result, |result, input| {
                MT::Fun(Box::new(input.clone()), Box::new(result))
            }),
            locals: parameters,
            body,
        }
    }

    fn example(slot: Option<usize>) -> Program {
        let number = MT::con("std::F64");
        let array = MT::Con("std::Array".into(), vec![number.clone()]);
        let list = MT::Con("std::List".into(), vec![number.clone()]);
        let callback = function(
            "callback",
            vec![number.clone(); if slot.is_some() { 2 } else { 1 }],
            number.clone(),
            Body::Expr(Expr::Local(0)),
        );
        let (operation, parameters, args, result) = if let Some(slot) = slot {
            let mut parameters = vec![list.clone(), list.clone()];
            parameters[slot] = array;
            (
                function(
                    "zip",
                    parameters.clone(),
                    list.clone(),
                    Body::ScalarBufferZip { callback: 1, slot },
                ),
                parameters,
                vec![Expr::Local(0), Expr::Local(1)],
                list.clone(),
            )
        } else {
            (
                function(
                    "map",
                    vec![callback.ty.clone(), array.clone()],
                    array.clone(),
                    Body::Prim("array.map".into()),
                ),
                vec![array.clone()],
                vec![Expr::Func(1), Expr::Local(0)],
                array,
            )
        };
        let mut entry = function(
            "entry",
            parameters,
            result.clone(),
            Body::Expr(Expr::Call(2, args)),
        );
        entry.locals.push(result);
        let mut program = Program {
            funcs: vec![entry, callback, operation],
            main: Some(0),
            ..Program::default()
        };
        program.shapes.insert(
            list.clone(),
            TypeShape::Adt(vec![
                ("Nil".into(), vec![]),
                ("Cons".into(), vec![number, list]),
            ]),
        );
        program
    }

    fn verify_ownership(program: &Program) {
        crate::ir::check_locals(program).unwrap();
        for (function, prepared) in program.funcs.iter().zip(crate::rc::insert(program)) {
            if let Some((body, locals)) = prepared {
                crate::rc::check(program, function, &body, &locals).unwrap();
            }
        }
    }

    #[test]
    fn scalar_captures_keep_argument_order_and_consume_only_the_array() {
        for captures in [1, 2, 8] {
            let mut program = example(None);
            let number = MT::con("std::F64");
            let array = program.funcs[0].locals[0].clone();
            program.funcs[1] = function(
                "captured-step",
                vec![number.clone(); captures + 1],
                number.clone(),
                Body::Expr(Expr::Local(captures as Local)),
            );
            let mut parameters = vec![number; captures];
            parameters.push(array.clone());
            let saved = (0..captures)
                .map(|index| Expr::Local(index as Local))
                .collect::<Vec<_>>();
            program.funcs[0] = function(
                "entry",
                parameters.clone(),
                array,
                Body::Expr(Expr::Call(
                    2,
                    vec![Expr::Call(1, saved.clone()), Expr::Local(captures as Local)],
                )),
            );
            lower(&mut program);
            assert_eq!(program.funcs.len(), 4);
            assert_eq!(program.funcs[3].locals, parameters);
            let Body::Expr(Expr::Call(id, args)) = &program.funcs[0].body else {
                panic!("lost call")
            };
            assert_eq!(*id, 3);
            assert_eq!(args.len(), captures + 1);
            assert!(args
                .iter()
                .enumerate()
                .all(|(index, arg)| matches!(arg, Expr::Local(local) if *local == index as Local)));
            for index in 0..=captures {
                assert_eq!(
                    crate::rc::consumes_arg(&program, 3, index),
                    index == captures
                );
            }
            verify_ownership(&program);
        }
    }

    #[test]
    fn captured_maps_reject_reference_captures_and_executing_call_stages() {
        for (capture, supplied) in [
            (MT::con("std::String"), 1),
            (MT::con("std::I128"), 1),
            (MT::con("std::F64"), 0),
            (MT::con("std::F64"), 2),
        ] {
            let mut program = example(None);
            let number = MT::con("std::F64");
            let array = program.funcs[0].locals[0].clone();
            program.funcs[1] = function(
                "step",
                vec![capture.clone(), number.clone()],
                number,
                Body::Expr(Expr::Local(1)),
            );
            program.funcs[0] = function(
                "entry",
                vec![capture, array.clone()],
                array,
                Body::Expr(Expr::Call(
                    2,
                    vec![
                        Expr::Call(1, vec![Expr::Local(0); supplied]),
                        Expr::Local(1),
                    ],
                )),
            );
            lower(&mut program);
            assert_eq!(program.funcs.len(), 3);
        }
    }

    #[test]
    fn private_entries_consume_only_the_declared_owner() {
        for slot in [None, Some(0), Some(1)] {
            let mut program = example(slot);
            lower(&mut program);
            assert_eq!(program.funcs.len(), 4);
            verify_ownership(&program);
            assert!(reachable_functions(&program, &[0]).unwrap()[1]);
            for parameter in 0..program.funcs[3].arity as usize {
                assert_eq!(
                    crate::rc::consumes_arg(&program, 3, parameter),
                    slot != Some(parameter) || super::super::GRADIENT_CALL_STORAGE
                );
            }
        }
    }

    #[test]
    fn scratch_requires_a_dead_word_array_without_changing_list_consumption() {
        for slot in [0, 1] {
            for kept in [false, true] {
                let mut p = example(Some(slot));
                if kept {
                    let Body::Expr(call) = p.funcs[0].body.clone() else {
                        unreachable!()
                    };
                    p.funcs[0].body =
                        Body::Expr(Expr::Record(vec![call, Expr::Local(slot as Local)]));
                }
                lower(&mut p);
                assert!(
                    matches!(p.funcs[3].body, Body::OwnedScalarBufferZip { consume_array, .. }
                    if consume_array == !kept)
                );
                assert!(crate::rc::consumes_arg(&p, 3, 1 - slot));
                assert_eq!(crate::rc::consumes_arg(&p, 3, slot), !kept);
            }
            let mut narrow = example(Some(slot));
            fn replace(ty: &mut MT) {
                match ty {
                    MT::Con(name, args) => {
                        if name == "std::F64" {
                            *name = "std::F32".into();
                        }
                        for arg in args {
                            replace(arg);
                        }
                    }
                    MT::Fun(a, b) => {
                        replace(a);
                        replace(b);
                    }
                    _ => {}
                }
            }
            for f in &mut narrow.funcs {
                replace(&mut f.ty);
                for local in &mut f.locals {
                    replace(local);
                }
            }
            lower(&mut narrow);
            assert!(matches!(
                narrow.funcs[3].body,
                Body::OwnedScalarBufferZip {
                    consume_array: false,
                    ..
                }
            ));
        }
    }

    #[test]
    fn later_uses_and_nested_arguments_keep_borrowed_operations() {
        for slot in [None, Some(0), Some(1)] {
            for nested in [false, true] {
                let mut program = example(slot);
                let input = slot.map_or(0, |slot| 1 - slot) as Local;
                let result = program.funcs[0].arity;
                let Body::Expr(body) = &mut program.funcs[0].body else {
                    unreachable!()
                };
                let call = body.clone();
                *body = if nested {
                    Expr::Record(vec![call, Expr::Local(input)])
                } else {
                    Expr::Let(result, Box::new(call), Box::new(Expr::Local(input)))
                };
                lower(&mut program);
                assert_eq!(program.funcs.len(), 3);
            }
        }
    }

    #[test]
    fn saturated_array_results_transfer_without_reordering_the_producer() {
        for saturated in [false, true] {
            let mut program = example(None);
            let array = program.funcs[0].locals[0].clone();
            program.funcs.push(function(
                "producer",
                vec![array.clone(); if saturated { 1 } else { 2 }],
                array,
                Body::Expr(Expr::Local(0)),
            ));
            let producer = Expr::Call(3, vec![Expr::Local(0)]);
            program.funcs[0].body = Body::Expr(Expr::Call(2, vec![Expr::Func(1), producer]));
            lower(&mut program);
            assert_eq!(program.funcs.len(), if saturated { 5 } else { 4 });
            if saturated {
                let Body::Expr(Expr::Call(id, args)) = &program.funcs[0].body else {
                    panic!("producer evaluation must stay inside the owning call")
                };
                assert_eq!(*id, 4);
                assert!(matches!(args.as_slice(), [Expr::Call(3, arguments)]
                    if matches!(arguments.as_slice(), [Expr::Local(0)])));
                verify_ownership(&program);
            }
        }
    }

    #[test]
    fn owned_fields_preserve_both_alias_orders_and_constructor_ownership() {
        for earlier_alias in [false, true] {
            for variant in [false, true] {
                let mut program = example(None);
                let array = program.funcs[0].locals[0].clone();
                let record = MT::Record(vec![
                    ("0".into(), array.clone()),
                    ("1".into(), array.clone()),
                ]);
                let Body::Expr(call) = &program.funcs[0].body else {
                    unreachable!()
                };
                let mut fields = vec![call.clone(), Expr::Local(0)];
                if earlier_alias {
                    fields.reverse();
                }
                let mut body = Expr::Record(fields);
                let result = if variant {
                    let result = MT::con("OwnedFields");
                    program.shapes.insert(
                        result.clone(),
                        TypeShape::Adt(vec![("Yield".into(), vec![record])]),
                    );
                    body = Expr::Construct(0, vec![body]);
                    result
                } else {
                    record
                };
                program.funcs[0].ty = MT::Fun(Box::new(array), Box::new(result));
                program.funcs[0].body = Body::Expr(body);
                lower(&mut program);
                assert_eq!(program.funcs.len(), if earlier_alias { 4 } else { 3 });
                verify_ownership(&program);
            }
        }
    }

    #[test]
    fn ordinary_call_arguments_still_exclude_nested_selection() {
        let mut program = example(None);
        let array = program.funcs[0].locals[0].clone();
        program.funcs.push(function(
            "sink",
            vec![array.clone(), array.clone()],
            array,
            Body::Expr(Expr::Local(1)),
        ));
        let Body::Expr(call) = &program.funcs[0].body else {
            unreachable!()
        };
        program.funcs[0].body = Body::Expr(Expr::Call(3, vec![Expr::Local(0), call.clone()]));
        lower(&mut program);
        assert_eq!(program.funcs.len(), 4);
        verify_ownership(&program);
    }

    #[test]
    fn earlier_reads_allow_consumption_but_resource_anchors_do_not() {
        for anchored in [false, true] {
            let mut program = example(None);
            let Body::Expr(body) = &mut program.funcs[0].body else {
                unreachable!()
            };
            *body = if anchored {
                Expr::ResourceRegion {
                    parameters: vec![0],
                    bindings: vec![],
                    body: Box::new(body.clone()),
                }
            } else {
                Expr::Let(1, Box::new(Expr::Local(0)), Box::new(body.clone()))
            };
            lower(&mut program);
            assert_eq!(program.funcs.len(), if anchored { 3 } else { 4 });
            if !anchored {
                verify_ownership(&program);
            }
        }
    }

    #[test]
    fn branch_continuations_and_type_changes_prevent_selection() {
        let mut program = example(None);
        let Body::Expr(body) = &mut program.funcs[0].body else {
            unreachable!()
        };
        *body = Expr::Let(
            1,
            Box::new(body.clone()),
            Box::new(Expr::Match(
                Box::new(Expr::Local(1)),
                vec![(Pat::Wild, Expr::Local(0))],
            )),
        );
        lower(&mut program);
        assert_eq!(program.funcs.len(), 3);

        for slot in [None, Some(0), Some(1)] {
            let mut program = example(slot);
            // A callback changing F64 to I64 must not overwrite F64 storage.
            let arity = program.funcs[1].arity as usize;
            let parameters = vec![MT::con("std::F64"); arity];
            program.funcs[1] = function(
                "changed",
                parameters,
                MT::con("std::I64"),
                Body::Prim("fake".into()),
            );
            lower(&mut program);
            assert_eq!(program.funcs.len(), 3);
        }
    }

    #[test]
    fn many_calls_share_one_entry_with_linear_visits() {
        for count in [1, 8, 128] {
            let mut program = example(None);
            let array = program.funcs[0].locals[0].clone();
            program.funcs[0].locals = vec![array; count + 1];
            let mut body = Expr::Local(count as Local);
            for input in (0..count).rev() {
                body = Expr::Let(
                    input as Local + 1,
                    Box::new(Expr::Call(
                        2,
                        vec![Expr::Func(1), Expr::Local(input as Local)],
                    )),
                    Box::new(body),
                );
            }
            program.funcs[0].body = Body::Expr(body);
            let visits = lower(&mut program);
            assert_eq!(program.funcs.len(), 4);
            assert!(visits <= 8 * count + 3, "{visits} visits for {count} maps");
            verify_ownership(&program);
        }
    }
}
