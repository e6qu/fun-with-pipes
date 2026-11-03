//! Preserve eager numeric stages while avoiding a private array-to-list copy.
//! Selection precedes list materialization, which would hide this boundary.

use std::collections::HashMap;

use crate::ir::*;

#[derive(Clone, Copy)]
enum Use {
    Other,
    Alias(Local, usize),
    Map {
        node: usize,
        block: usize,
        callback: FuncId,
    },
    Zip {
        node: usize,
        block: usize,
        callback: FuncId,
        slot: usize,
    },
}

struct Producer {
    node: usize,
    usage: Use,
    block: usize,
    element: MT,
}

fn list(element: &MT) -> MT {
    MT::Con("std::List".into(), vec![element.clone()])
}

fn array(element: &MT) -> MT {
    MT::Con("std::Array".into(), vec![element.clone()])
}

fn callback(program: &Program, id: FuncId, arity: usize) -> bool {
    let Some(function) = program.funcs.get(id) else {
        return false;
    };
    let (parameters, result) = function.ty.params(arity);
    function.arity as usize == arity
        && matches!(function.body, Body::Expr(_) | Body::Prim(_))
        && parameters.len() == arity
        && parameters.iter().all(|ty| super::unboxed_numeric(ty))
        && super::unboxed_numeric(result)
}

fn operation(program: &Program, id: FuncId, symbol: &str, step: FuncId, arity: usize) -> bool {
    let Some(function) = program.funcs.get(id) else {
        return false;
    };
    if !matches!(&function.body, Body::Prim(name) if name == symbol)
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

fn conversion(program: &Program, id: FuncId) -> Option<MT> {
    let function = program.funcs.get(id)?;
    if function.arity != 1 || !matches!(&function.body, Body::Prim(name) if name == "array.to-list")
    {
        return None;
    }
    let (parameters, result) = function.ty.params(1);
    let [MT::Con(name, elements)] = parameters.as_slice() else {
        return None;
    };
    if name != "std::Array" || elements.len() != 1 || !super::unboxed_numeric(&elements[0]) {
        return None;
    }
    (result == &list(&elements[0])).then(|| elements[0].clone())
}

struct Index<'a> {
    program: &'a Program,
    uses: Vec<Option<Use>>,
    producers: Vec<Producer>,
    outputs: HashMap<usize, Use>,
    blocks: usize,
    visits: usize,
}

impl Index<'_> {
    fn use_local(&mut self, local: Local, usage: Use) {
        let entry = &mut self.uses[local as usize];
        *entry = Some(if entry.is_none() { usage } else { Use::Other });
    }

    fn nested(&mut self, expression: &Expr) {
        self.blocks += 1;
        self.walk(expression, self.blocks, Use::Other);
    }

    fn walk(&mut self, expression: &Expr, block: usize, usage: Use) {
        self.visits += 1;
        let node = expression as *const Expr as usize;
        match expression {
            Expr::Local(local) => self.use_local(*local, usage),
            Expr::Let(local, value, body) => {
                self.walk(value, block, Use::Alias(*local, block));
                self.walk(body, block, usage);
            }
            Expr::Trace(_, body) => self.walk(body, block, usage),
            Expr::Call(id, arguments) => {
                if arguments.len() == 1 {
                    if let Some(element) = conversion(self.program, *id) {
                        self.producers.push(Producer {
                            node,
                            usage,
                            block,
                            element,
                        });
                    }
                }
                match arguments.as_slice() {
                    [Expr::Func(step), input] if operation(self.program, *id, "map", *step, 1) => {
                        self.outputs.insert(node, usage);
                        self.walk(
                            input,
                            block,
                            Use::Map {
                                node,
                                block,
                                callback: *step,
                            },
                        );
                    }
                    [Expr::Func(step), first, second]
                        if operation(self.program, *id, "zip-with", *step, 2) =>
                    {
                        for (slot, input) in [first, second].into_iter().enumerate() {
                            self.walk(
                                input,
                                block,
                                Use::Zip {
                                    node,
                                    block,
                                    callback: *step,
                                    slot,
                                },
                            );
                        }
                    }
                    _ => {
                        for argument in arguments {
                            self.nested(argument);
                        }
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

#[derive(Clone, Copy)]
enum Rewrite {
    Array,
    Map(FuncId),
    Zip(FuncId),
}

fn function(name: &str, parameters: Vec<MT>, result: MT, body: Body) -> Func {
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

// Node identities are read before changing any child. Never dereference these
// addresses, or clone/replace the indexed body before this traversal.
fn rewrite(expression: &mut Expr, calls: &HashMap<usize, Rewrite>, visits: &mut usize) {
    *visits += 1;
    let action = calls.get(&(expression as *const Expr as usize)).copied();
    match expression {
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                rewrite(arg, calls, visits);
            }
        }
        Expr::Apply(function, args) => {
            rewrite(function, calls, visits);
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
    if let Some(action) = action {
        let Expr::Call(id, args) = expression else {
            unreachable!()
        };
        match action {
            Rewrite::Array => {
                assert_eq!(args.len(), 1);
                *expression = args.pop().unwrap();
            }
            Rewrite::Map(target) => *id = target,
            Rewrite::Zip(target) => {
                assert!(matches!(args.first(), Some(Expr::Func(_))));
                args.remove(0);
                *id = target;
            }
        }
    }
}

/// Return deterministic visits for scaling tests; no repeated tail scans.
pub(super) fn lower(program: &mut Program) -> usize {
    let original_len = program.funcs.len();
    let mut made = Vec::new();
    let mut maps = HashMap::new();
    let mut zips = HashMap::new();
    let mut visits = 0;
    for id in 0..original_len {
        let body_function = &program.funcs[id];
        let Body::Expr(body) = &body_function.body else {
            continue;
        };
        let mut index = Index {
            program,
            uses: vec![None; body_function.locals.len()],
            producers: Vec::new(),
            outputs: HashMap::new(),
            blocks: 0,
            visits: 0,
        };
        index.walk(body, 0, Use::Other);
        visits += index.visits;
        let mut calls = HashMap::new();
        let mut changed = Vec::new();
        let mut marks = vec![usize::MAX; body_function.locals.len()];
        for (generation, producer) in index.producers.iter().enumerate() {
            let mut usage = producer.usage;
            let mut element = &producer.element;
            let mut mapper = None;
            let mut aliases = Vec::new();
            let target = loop {
                visits += 1;
                match usage {
                    Use::Alias(local, block) if block == producer.block => {
                        if marks[local as usize] == generation
                            || body_function.locals[local as usize] != list(element)
                        {
                            break None;
                        }
                        marks[local as usize] = generation;
                        aliases.push((local, array(element)));
                        usage = index.uses[local as usize].unwrap_or(Use::Other);
                    }
                    Use::Map {
                        node,
                        block,
                        callback,
                    } if block == producer.block && mapper.is_none() => {
                        let (inputs, output) = program.funcs[callback].ty.params(1);
                        if inputs[0] != element {
                            break None;
                        }
                        mapper = Some((node, callback));
                        element = output;
                        usage = index.outputs[&node];
                    }
                    Use::Zip {
                        node,
                        block,
                        callback,
                        slot,
                    } if block == producer.block => {
                        if program.funcs[callback].ty.params(2).0[slot] != element {
                            break None;
                        }
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
            if let Some((map_node, callback)) = mapper {
                let map = *maps.entry(callback).or_insert_with(|| {
                    let worker = &program.funcs[callback];
                    let (inputs, output) = worker.ty.params(1);
                    let target = original_len + made.len();
                    made.push(function(
                        "array.map",
                        vec![worker.ty.clone(), array(inputs[0])],
                        array(output),
                        Body::Prim("array.map".into()),
                    ));
                    target
                });
                calls.insert(map_node, Rewrite::Map(map));
            }
            let zip = *zips.entry((step, slot)).or_insert_with(|| {
                let (inputs, output) = program.funcs[step].ty.params(2);
                let parameters = inputs
                    .iter()
                    .enumerate()
                    .map(|(i, ty)| if i == slot { array(ty) } else { list(ty) })
                    .collect();
                let target = original_len + made.len();
                made.push(function(
                    "array-list-zip",
                    parameters,
                    list(output),
                    Body::ScalarBufferZip {
                        callback: step,
                        slot,
                    },
                ));
                target
            });
            calls.insert(producer.node, Rewrite::Array);
            calls.insert(node, Rewrite::Zip(zip));
            changed.extend(aliases);
        }
        if !calls.is_empty() {
            let function = &mut program.funcs[id];
            let Body::Expr(body) = &mut function.body else {
                unreachable!()
            };
            rewrite(body, &calls, &mut visits);
            for (local, ty) in changed {
                function.locals[local as usize] = ty;
            }
        }
    }
    program.funcs.extend(made);
    visits
}

#[cfg(test)]
mod tests {
    use super::*;

    fn example(aliases: usize, slot: usize, mapped: bool, inline: bool, name: &str) -> Program {
        let number = MT::con(name);
        let sequence = list(&number);
        let storage = array(&number);
        let map = function(
            "mapped",
            vec![number.clone()],
            number.clone(),
            Body::Expr(Expr::Local(0)),
        );
        let step = function(
            "step",
            vec![number.clone(), number.clone()],
            number.clone(),
            Body::Expr(Expr::Local(1)),
        );
        let map_primitive = function(
            "map",
            vec![map.ty.clone(), sequence.clone()],
            sequence.clone(),
            Body::Prim("map".into()),
        );
        let zip_primitive = function(
            "zip-with",
            vec![step.ty.clone(), sequence.clone(), sequence.clone()],
            sequence.clone(),
            Body::Prim("zip-with".into()),
        );
        let convert = function(
            "array.to-list",
            vec![storage.clone()],
            sequence.clone(),
            Body::Prim("array.to-list".into()),
        );
        let input = Expr::Call(5, vec![Expr::Local(0)]);
        let mut mapped_input = if inline {
            input.clone()
        } else {
            Expr::Local(2 + aliases as Local)
        };
        if mapped {
            mapped_input = Expr::Call(3, vec![Expr::Func(1), mapped_input]);
        }
        let mut args = vec![Expr::Func(2), Expr::Local(1), Expr::Local(1)];
        args[slot + 1] = mapped_input;
        let mut body = Expr::Call(4, args);
        if !inline {
            for local in (3..=2 + aliases as Local).rev() {
                body = Expr::Let(local, Box::new(Expr::Local(local - 1)), Box::new(body));
            }
            body = Expr::Let(2, Box::new(input), Box::new(body));
        }
        let mut entry = function(
            "entry",
            vec![storage, sequence.clone()],
            sequence.clone(),
            Body::Expr(body),
        );
        if !inline {
            entry.locals.extend(vec![sequence; aliases + 1]);
        }
        Program {
            funcs: vec![entry, map, step, map_primitive, zip_primitive, convert],
            main: Some(0),
            ..Program::default()
        }
    }

    #[test]
    fn direct_and_mapped_conversions_support_inline_and_aliased_inputs_in_both_slots() {
        for name in ["std::I8", "std::U32", "std::F32", "std::F64"] {
            for slot in 0..2 {
                for mapped in [false, true] {
                    for inline in [false, true] {
                        let mut program = example(4, slot, mapped, inline, name);
                        crate::ir::check_locals(&program).unwrap();
                        lower(&mut program);
                        crate::ir::check_locals(&program).unwrap();
                        assert_eq!(program.funcs.len(), 7 + usize::from(mapped));
                        assert!(
                            matches!(program.funcs.last().unwrap().body, Body::ScalarBufferZip { callback: 2, slot: selected } if selected == slot)
                        );
                        if !inline {
                            assert!(program.funcs[0].locals[2..]
                                .iter()
                                .all(|ty| *ty == array(&MT::con(name))));
                        }
                        let live = reachable_functions(&program, &[0]).unwrap();
                        assert!(live[2]);
                        assert!(!live[5], "private conversion must disappear");
                        if mapped {
                            assert!(live[1]);
                        }
                    }
                }
            }
        }
    }

    #[test]
    fn changes_alias_types_on_both_sides_of_a_type_changing_map() {
        let mut program = example(1, 1, true, false, "std::F32");
        let input = MT::con("std::F32");
        let output = MT::con("std::F64");
        program.funcs[1] = function(
            "convert",
            vec![input.clone()],
            output.clone(),
            Body::Prim("float.convert".into()),
        );
        program.funcs[2] = function(
            "step",
            vec![output.clone(), output.clone()],
            output.clone(),
            Body::Expr(Expr::Local(1)),
        );
        program.funcs[3] = function(
            "map",
            vec![program.funcs[1].ty.clone(), list(&input)],
            list(&output),
            Body::Prim("map".into()),
        );
        program.funcs[4] = function(
            "zip-with",
            vec![program.funcs[2].ty.clone(), list(&output), list(&output)],
            list(&output),
            Body::Prim("zip-with".into()),
        );
        let mut entry = function(
            "entry",
            vec![array(&input), list(&output)],
            list(&output),
            Body::Expr(Expr::Let(
                2,
                Box::new(Expr::Call(5, vec![Expr::Local(0)])),
                Box::new(Expr::Let(
                    3,
                    Box::new(Expr::Call(3, vec![Expr::Func(1), Expr::Local(2)])),
                    Box::new(Expr::Let(
                        4,
                        Box::new(Expr::Local(3)),
                        Box::new(Expr::Call(
                            4,
                            vec![Expr::Func(2), Expr::Local(1), Expr::Local(4)],
                        )),
                    )),
                )),
            )),
        );
        entry
            .locals
            .extend([list(&input), list(&output), list(&output)]);
        program.funcs[0] = entry;
        crate::ir::check_locals(&program).unwrap();
        lower(&mut program);
        crate::ir::check_locals(&program).unwrap();
        assert_eq!(
            &program.funcs[0].locals[2..],
            &[array(&input), array(&output), array(&output)]
        );
    }

    #[test]
    fn shared_and_conditional_consumers_keep_their_list() {
        for conditional in [false, true] {
            let mut program = example(0, 0, true, false, "std::F64");
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
            let before = format!("{:?}", program.funcs[0].body);
            lower(&mut program);
            assert_eq!(program.funcs.len(), 6);
            assert_eq!(format!("{:?}", program.funcs[0].body), before);
        }
    }

    #[test]
    fn boxed_and_reference_values_keep_their_representation() {
        for name in ["std::F128", "std::I128", "std::String"] {
            let mut program = example(0, 0, true, true, name);
            lower(&mut program);
            assert_eq!(program.funcs.len(), 6);
        }
    }

    #[test]
    fn unknown_or_captured_callbacks_and_two_maps_keep_their_list() {
        for mode in 0..3 {
            let mut program = example(0, 0, true, true, "std::F64");
            let Body::Expr(Expr::Call(_, arguments)) = &mut program.funcs[0].body else {
                unreachable!()
            };
            let Expr::Call(_, mapped) = &mut arguments[1] else {
                unreachable!()
            };
            match mode {
                0 => mapped[0] = Expr::Local(2),
                1 => mapped[0] = Expr::Call(1, vec![Expr::Local(2)]),
                2 => mapped[1] = Expr::Call(3, vec![Expr::Func(1), mapped[1].clone()]),
                _ => unreachable!(),
            }
            let callback_type = program.funcs[1].ty.clone();
            program.funcs[0].locals.push(callback_type);
            let before = format!("{:?}", program.funcs[0].body);
            lower(&mut program);
            assert_eq!(program.funcs.len(), 6);
            assert_eq!(format!("{:?}", program.funcs[0].body), before);
        }
    }

    #[test]
    fn two_private_array_inputs_select_one_slot_and_keep_the_other_list() {
        let mut program = example(0, 0, false, true, "std::F64");
        let Body::Expr(Expr::Call(_, arguments)) = &mut program.funcs[0].body else {
            unreachable!()
        };
        arguments[2] = Expr::Call(5, vec![Expr::Local(0)]);
        crate::ir::check_locals(&program).unwrap();
        lower(&mut program);
        crate::ir::check_locals(&program).unwrap();
        assert_eq!(program.funcs.len(), 7);
        assert!(matches!(
            program.funcs[6].body,
            Body::ScalarBufferZip { slot: 0, .. }
        ));
        let Body::Expr(Expr::Call(6, arguments)) = &program.funcs[0].body else {
            unreachable!()
        };
        assert!(matches!(arguments[0], Expr::Local(0)));
        assert!(matches!(arguments[1], Expr::Call(5, _)));
    }

    #[test]
    fn index_and_rewrite_work_scale_with_long_alias_chains() {
        let small = lower(&mut example(64, 0, true, false, "std::F64"));
        let large = lower(&mut example(128, 0, true, false, "std::F64"));
        assert!(large <= 2 * small, "{small} -> {large}");
        assert!(large < 12 * 128, "{large}");
    }

    #[test]
    fn disjoint_producers_share_helpers_and_scale_with_input_size() {
        fn many(count: usize) -> Program {
            let mut program = example(0, 0, true, true, "std::F64");
            let Body::Expr(body) = &program.funcs[0].body else {
                unreachable!()
            };
            let chain = body.clone();
            let mut body = chain.clone();
            for local in 2..count + 1 {
                body = Expr::Let(local as Local, Box::new(chain.clone()), Box::new(body));
                program.funcs[0].locals.push(list(&MT::con("std::F64")));
            }
            program.funcs[0].body = Body::Expr(body);
            program
        }
        let mut small = many(32);
        let mut large = many(64);
        let small_visits = lower(&mut small);
        let large_visits = lower(&mut large);
        crate::ir::check_locals(&small).unwrap();
        crate::ir::check_locals(&large).unwrap();
        assert_eq!(small.funcs.len(), 8);
        assert_eq!(large.funcs.len(), 8);
        assert!(
            large_visits <= 2 * small_visits + 2,
            "{small_visits} -> {large_visits}"
        );
        assert!(large_visits < 24 * 64, "{large_visits}");
    }
}
