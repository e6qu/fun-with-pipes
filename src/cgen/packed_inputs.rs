//! Replace a private indexed record list and its one-element suffix with one
//! numeric buffer. Mapping still finishes before the existing packed fold.

use std::collections::{HashMap, HashSet};

use crate::ir::*;
use crate::value::Value;

fn buffer() -> MT {
    MT::Con("std::Array".into(), vec![MT::con("std::I64")])
}

fn width(program: &Program, ty: &MT) -> Option<usize> {
    let fields = record_fields(&program.shapes, ty)?;
    ((1..=2).contains(&fields.len()) && fields.iter().all(|(_, ty)| super::scalar(ty).is_some()))
        .then_some(fields.len())
}

#[derive(Clone, Copy)]
enum Use {
    Other,
    Alias {
        local: Local,
        block: usize,
        tail: bool,
    },
    Pair {
        node: usize,
        block: usize,
        slot: usize,
        tail: bool,
    },
}

struct Producer {
    local: Local,
    helper: FuncId,
    block: usize,
}

struct Index<'a> {
    program: &'a Program,
    locals: &'a [MT],
    uses: Vec<Vec<Use>>,
    producers: Vec<Producer>,
    pairs: HashMap<usize, FuncId>,
    blocks: usize,
}

impl Index<'_> {
    fn view(&self, expression: &Expr) -> Option<(Local, bool)> {
        match expression {
            Expr::Local(local) => Some((*local, false)),
            Expr::Trace(_, body) => self.view(body),
            Expr::Call(id, args) => {
                let function = self.program.funcs.get(*id)?;
                let [Expr::Const(Value::I64(1)), Expr::Local(local)] = args.as_slice() else {
                    return None;
                };
                let (parameters, result) = function.ty.params(2);
                let input = self.locals.get(*local as usize)?;
                (function.arity == 2
                    && matches!(&function.body, Body::Prim(symbol) if symbol == "drop")
                    && parameters == [&MT::con("std::I64"), input]
                    && result == input
                    && matches!(input, MT::Con(name, args) if name == "std::List" && args.len() == 1))
                .then_some((*local, true))
            }
            _ => None,
        }
    }

    fn pair(&self, id: FuncId) -> Option<()> {
        let function = self.program.funcs.get(id)?;
        let Body::PackedRecordMap { callback } = function.body else {
            return None;
        };
        let step = self.program.funcs.get(callback)?;
        let (inputs, result) = step.ty.params(2);
        if step.arity != 2 || inputs.len() != 2 || inputs[0] != inputs[1] {
            return None;
        }
        let fields = width(self.program, inputs[0])?;
        let output = width(self.program, result)?;
        let abi = super::abi_of(self.program, step)?;
        let list = MT::Con("std::List".into(), vec![inputs[0].clone()]);
        let (parameters, result) = function.ty.params(2);
        (function.arity == 2
            && parameters == [&list, &list]
            && result == &buffer()
            && abi.params == [Some(fields), Some(fields)]
            && abi.ret == Some(output))
        .then_some(())
    }

    fn nested(&mut self, expression: &Expr) {
        self.blocks += 1;
        self.walk(expression, self.blocks);
    }

    fn walk(&mut self, expression: &Expr, block: usize) {
        match expression {
            Expr::Local(local) => self.uses[*local as usize].push(Use::Other),
            Expr::Let(local, value, body) => {
                if let Expr::Call(id, args) = &**value {
                    if args.len() == 4
                        && matches!(self.program.funcs[*id].body, Body::RangeZip { .. })
                    {
                        self.producers.push(Producer {
                            local: *local,
                            helper: *id,
                            block,
                        });
                    }
                }
                if let Some((source, tail)) = self.view(value) {
                    if self.locals[*local as usize] == self.locals[source as usize] {
                        self.uses[source as usize].push(Use::Alias {
                            local: *local,
                            block,
                            tail,
                        });
                    } else {
                        self.walk(value, block);
                    }
                } else {
                    self.walk(value, block);
                }
                self.walk(body, block);
            }
            Expr::Trace(_, body) => self.walk(body, block),
            Expr::Call(id, args) if args.len() == 2 && self.pair(*id).is_some() => {
                let node = expression as *const Expr as usize;
                self.pairs.insert(node, *id);
                for (slot, argument) in args.iter().enumerate() {
                    if let Some((local, tail)) = self.view(argument) {
                        self.uses[local as usize].push(Use::Pair {
                            node,
                            block,
                            slot,
                            tail,
                        });
                    } else {
                        self.nested(argument);
                    }
                }
            }
            Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
                for arg in args {
                    self.nested(arg);
                }
            }
            Expr::Apply(function, args) => {
                self.nested(function);
                for arg in args {
                    self.nested(arg);
                }
            }
            Expr::Field(record, _) => self.nested(record),
            Expr::SetFields(record, fields) => {
                self.nested(record);
                for (_, value) in fields {
                    self.nested(value);
                }
            }
            Expr::Match(value, arms) => {
                self.nested(value);
                for (_, body) in arms {
                    self.nested(body);
                }
            }
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => {
                for local in parameters.iter().chain(bindings) {
                    self.uses[*local as usize].push(Use::Other);
                }
                self.nested(body);
            }
            Expr::Dup(local, body) | Expr::Drop(local, body) => {
                self.uses[*local as usize].push(Use::Other);
                self.walk(body, block);
            }
            Expr::BorrowGlobal(_, _, body) => self.nested(body),
            Expr::Const(_) | Expr::Func(_) => {}
        }
    }

    fn consumer(&self, producer: &Producer) -> Option<(usize, usize, HashSet<Local>)> {
        let mut work = vec![(producer.local, 0)];
        let mut seen = HashSet::new();
        let mut leaves = Vec::new();
        while let Some((local, offset)) = work.pop() {
            if !seen.insert(local) || self.uses[local as usize].is_empty() {
                return None;
            }
            for usage in &self.uses[local as usize] {
                match *usage {
                    Use::Alias { local, block, tail } if block == producer.block => {
                        let offset = offset + usize::from(tail);
                        if offset > 1 {
                            return None;
                        }
                        work.push((local, offset));
                    }
                    Use::Pair {
                        node,
                        block,
                        slot,
                        tail,
                    } if block == producer.block => {
                        leaves.push((node, slot, offset + usize::from(tail)));
                        if leaves.len() > 2 {
                            return None;
                        }
                    }
                    _ => return None,
                }
            }
        }
        leaves.sort_unstable_by_key(|(_, slot, _)| *slot);
        let [(first, 0, left), (second, 1, right)] = leaves.as_slice() else {
            return None;
        };
        if first != second || !matches!((*left, *right), (0, 1) | (1, 0)) {
            return None;
        }
        seen.remove(&producer.local);
        Some((*first, usize::from(*right == 1), seen))
    }
}

struct Changes {
    producers: HashMap<Local, FuncId>,
    pairs: HashMap<usize, (FuncId, Local)>,
    aliases: HashSet<Local>,
}

fn rewrite(expression: &mut Expr, changes: &Changes) {
    let node = expression as *const Expr as usize;
    if let Some((helper, source)) = changes.pairs.get(&node) {
        *expression = Expr::Call(*helper, vec![Expr::Local(*source)]);
        return;
    }
    match expression {
        Expr::Let(local, value, body) => {
            rewrite(value, changes);
            rewrite(body, changes);
            if let Some(helper) = changes.producers.get(local) {
                let Expr::Call(id, _) = &mut **value else {
                    unreachable!()
                };
                *id = *helper;
            }
            if changes.aliases.contains(local) {
                *expression = *std::mem::replace(body, Box::new(Expr::Const(Value::unit())));
            }
        }
        Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::ResourceRegion { body, .. } => rewrite(body, changes),
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                rewrite(arg, changes);
            }
        }
        Expr::Apply(function, args) => {
            rewrite(function, changes);
            for arg in args {
                rewrite(arg, changes);
            }
        }
        Expr::Field(record, _) => rewrite(record, changes),
        Expr::SetFields(record, fields) => {
            rewrite(record, changes);
            for (_, value) in fields {
                rewrite(value, changes);
            }
        }
        Expr::Match(value, arms) => {
            rewrite(value, changes);
            for (_, body) in arms {
                rewrite(body, changes);
            }
        }
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
}

fn producer(program: &Program, id: FuncId) -> Option<(FuncId, usize, usize)> {
    let function = program.funcs.get(id)?;
    let Body::RangeZip {
        callback,
        captures,
        slot,
    } = function.body
    else {
        return None;
    };
    let step = program.funcs.get(callback)?;
    let (parameters, result) = step.ty.params(captures + 2);
    let fields = width(program, result)?;
    let abi = super::abi_of(program, step)?;
    let (inputs, output) = function.ty.params(4);
    if slot >= 2 || parameters.len() != captures + 2 {
        return None;
    }
    let integer = MT::con("std::I64");
    let mut expected = vec![step.ty.params(captures).1.clone()];
    for position in 0..2 {
        if position == slot {
            expected.extend([integer.clone(), integer.clone()]);
        } else {
            expected.push(MT::Con(
                "std::List".into(),
                vec![parameters[captures + position].clone()],
            ));
        }
    }
    (function.arity == 4
        && step.arity as usize == captures + 2
        && parameters[captures + slot] == &integer
        && inputs == expected.iter().collect::<Vec<_>>()
        && function.locals == expected
        && parameters.iter().all(|ty| super::scalar(ty).is_some())
        && abi.ret == Some(fields)
        && abi.params.iter().all(Option::is_none)
        && output == &MT::Con("std::List".into(), vec![result.clone()]))
        .then_some((callback, captures, slot))
}

pub(super) fn lower(program: &mut Program) {
    let base = program.funcs.len();
    let mut made = Vec::new();
    let mut producers = HashMap::new();
    let mut pairs = HashMap::new();
    let mut rewritten = Vec::new();
    for (id, function) in program.funcs.iter().enumerate() {
        let Body::Expr(body) = &function.body else {
            continue;
        };
        let mut body = body.clone();
        let mut index = Index {
            program,
            locals: &function.locals,
            uses: vec![Vec::new(); function.locals.len()],
            producers: Vec::new(),
            pairs: HashMap::new(),
            blocks: 0,
        };
        index.walk(&body, 0);
        let mut changes = Changes {
            producers: HashMap::new(),
            pairs: HashMap::new(),
            aliases: HashSet::new(),
        };
        for source in &index.producers {
            let Some((callback, captures, slot)) = producer(program, source.helper) else {
                continue;
            };
            let Some((node, tail_slot, aliases)) = index.consumer(source) else {
                continue;
            };
            let pair = index.pairs[&node];
            // Both views must be of this exact element type, not merely records
            // with the same number of words.
            let (inputs, _) = program.funcs[pair].ty.params(2);
            if inputs[0] != &function.locals[source.local as usize] {
                continue;
            }
            let producer = *producers.entry(source.helper).or_insert_with(|| {
                let mut helper = program.funcs[source.helper].clone();
                helper.name = "packed-indexed-records".into();
                helper.ty = helper.locals.iter().rev().fold(buffer(), |result, input| {
                    MT::Fun(Box::new(input.clone()), Box::new(result))
                });
                helper.body = Body::PackedRecordRangeZip {
                    callback,
                    captures,
                    slot,
                };
                let id = base + made.len();
                made.push(helper);
                id
            });
            let pair = *pairs.entry((pair, tail_slot)).or_insert_with(|| {
                let Body::PackedRecordMap { callback } = program.funcs[pair].body else {
                    unreachable!()
                };
                let id = base + made.len();
                made.push(Func {
                    name: "packed-neighbor-pairs".into(),
                    arity: 1,
                    locals: vec![buffer()],
                    ty: MT::Fun(Box::new(buffer()), Box::new(buffer())),
                    body: Body::PackedRecordPairs {
                        callback,
                        tail_slot,
                    },
                });
                id
            });
            changes.producers.insert(source.local, producer);
            changes.pairs.insert(node, (pair, source.local));
            changes.aliases.extend(aliases);
        }
        if changes.producers.is_empty() {
            continue;
        }
        rewrite(&mut body, &changes);
        let mut locals = function.locals.clone();
        for local in changes.producers.keys() {
            locals[*local as usize] = buffer();
        }
        rewritten.push((id, body, locals));
    }
    for (id, body, locals) in rewritten {
        program.funcs[id].body = Body::Expr(body);
        program.funcs[id].locals = locals;
    }
    program.funcs.extend(made);
}

#[cfg(test)]
mod tests {
    use super::*;

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

    fn program(tail_slot: usize, aliased: bool) -> Program {
        let integer = MT::con("std::I64");
        let record = MT::Record(vec![
            ("0".into(), integer.clone()),
            ("1".into(), integer.clone()),
        ]);
        let list = MT::Con("std::List".into(), vec![integer.clone()]);
        let records = MT::Con("std::List".into(), vec![record.clone()]);
        let producer = function(
            "produce",
            vec![integer.clone(), integer.clone()],
            record.clone(),
            Body::Expr(Expr::Record(vec![Expr::Local(0), Expr::Local(1)])),
        );
        let range = function(
            "indexed",
            vec![
                producer.ty.clone(),
                list.clone(),
                integer.clone(),
                integer.clone(),
            ],
            records.clone(),
            Body::RangeZip {
                callback: 0,
                captures: 0,
                slot: 1,
            },
        );
        let pair = function(
            "pair",
            vec![record.clone(), record.clone()],
            record.clone(),
            Body::Expr(Expr::Record(vec![
                Expr::Field(Box::new(Expr::Local(0)), 0),
                Expr::Field(Box::new(Expr::Local(1)), 1),
            ])),
        );
        let map = function(
            "pairs",
            vec![records.clone(), records.clone()],
            buffer(),
            Body::PackedRecordMap { callback: 2 },
        );
        let drop = function(
            "suffix",
            vec![integer.clone(), records.clone()],
            records.clone(),
            Body::Prim("drop".into()),
        );
        let tail = Expr::Call(4, vec![Expr::Const(Value::I64(1)), Expr::Local(1)]);
        let mut arguments = vec![Expr::Local(1), Expr::Local(1)];
        arguments[tail_slot] = if aliased {
            Expr::Local(2)
        } else {
            tail.clone()
        };
        let pairs = Expr::Call(3, arguments);
        let consumer = if aliased {
            Expr::Let(2, Box::new(tail), Box::new(pairs))
        } else {
            pairs
        };
        let body = Expr::Let(
            1,
            Box::new(Expr::Call(
                1,
                vec![
                    Expr::Func(0),
                    Expr::Local(0),
                    Expr::Const(Value::I64(0)),
                    Expr::Const(Value::I64(4)),
                ],
            )),
            Box::new(consumer),
        );
        let mut caller = function("caller", vec![list], buffer(), Body::Expr(body));
        caller.locals.extend([records.clone(), records]);
        Program {
            funcs: vec![producer, range, pair, map, drop, caller],
            ..Program::default()
        }
    }

    #[test]
    fn both_window_orders_and_named_suffixes_use_one_owner() {
        for tail_slot in 0..2 {
            for aliased in [false, true] {
                let mut program = program(tail_slot, aliased);
                crate::ir::check_locals(&program).unwrap();
                lower(&mut program);
                assert_eq!(program.funcs.len(), 8);
                assert!(matches!(
                    program.funcs[6].body,
                    Body::PackedRecordRangeZip {
                        callback: 0,
                        captures: 0,
                        slot: 1
                    }
                ));
                assert!(matches!(program.funcs[7].body,
                    Body::PackedRecordPairs { callback: 2, tail_slot: actual } if actual == tail_slot));
                assert_eq!(program.funcs[5].locals[1], buffer());
                let Body::Expr(Expr::Let(1, source, consumer)) = &program.funcs[5].body else {
                    panic!("producer binding lost");
                };
                assert!(matches!(&**source, Expr::Call(6, args) if args.len() == 4));
                assert!(
                    matches!(&**consumer, Expr::Call(7, args) if matches!(args.as_slice(), [Expr::Local(1)]))
                );
                crate::ir::check_locals(&program).unwrap();
            }
        }
    }

    #[test]
    fn extra_reads_resource_frames_branches_and_double_suffixes_exclude_selection() {
        for case in 0..4 {
            let mut program = program(0, true);
            let Body::Expr(Expr::Let(_, _, body)) = &mut program.funcs[5].body else {
                unreachable!()
            };
            let previous = *body.clone();
            **body = match case {
                0 => Expr::Record(vec![previous, Expr::Local(1)]),
                1 => Expr::ResourceRegion {
                    parameters: vec![],
                    bindings: vec![1],
                    body: Box::new(previous),
                },
                2 => Expr::Match(
                    Box::new(Expr::Const(Value::unit())),
                    vec![(Pat::Wild, previous)],
                ),
                3 => {
                    let Expr::Let(local, value, mut pairs) = previous else {
                        unreachable!()
                    };
                    let Expr::Call(_, args) = &mut *pairs else {
                        unreachable!()
                    };
                    args[0] = Expr::Call(4, vec![Expr::Const(Value::I64(1)), Expr::Local(2)]);
                    Expr::Let(local, value, pairs)
                }
                _ => unreachable!(),
            };
            let before = format!("{:?}", program.funcs[5]);
            lower(&mut program);
            assert_eq!(program.funcs.len(), 6, "case {case}");
            assert_eq!(format!("{:?}", program.funcs[5]), before);
        }
    }

    #[test]
    fn forwarding_callbacks_require_numeric_callee_lowering_first() {
        let mut program = program(0, true);
        let record = program.funcs[2].locals[0].clone();
        let nested = MT::Record(vec![
            ("0".into(), record.clone()),
            ("1".into(), record.clone()),
        ]);
        program.funcs.push(function(
            "numeric-pair",
            vec![nested],
            record,
            Body::Expr(Expr::Record(vec![
                Expr::Field(Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)), 0),
                Expr::Field(Box::new(Expr::Field(Box::new(Expr::Local(0)), 1)), 1),
            ])),
        ));
        program.funcs[2].body = Body::Expr(Expr::Call(
            6,
            vec![Expr::Record(vec![Expr::Local(0), Expr::Local(1)])],
        ));
        crate::ir::check_locals(&program).unwrap();
        let mut before = program.clone();
        lower(&mut before);
        assert_eq!(before.funcs.len(), 7, "whole-record inputs must stay boxed");

        // Exercise the production pass order, not just the two isolated passes.
        let emitted = super::super::generate_exec(&program, 5, "caller").unwrap();
        assert!(emitted.contains("/* packed-indexed-records :"));
        assert!(emitted.contains("/* packed-neighbor-pairs :"));

        super::super::numeric_parameters::lower(&mut program, &[5]);
        lower(&mut program);
        assert_eq!(program.funcs.len(), 9);
        crate::ir::check_locals(&program).unwrap();
    }

    #[test]
    fn identical_consumers_share_generated_helpers() {
        let mut program = program(1, true);
        let caller = program.funcs[5].clone();
        program.funcs.extend(std::iter::repeat_n(caller, 64));
        lower(&mut program);
        assert_eq!(program.funcs.len(), 72);
        assert_eq!(
            program
                .funcs
                .iter()
                .filter(|f| matches!(f.body, Body::PackedRecordRangeZip { .. }))
                .count(),
            1
        );
        assert_eq!(
            program
                .funcs
                .iter()
                .filter(|f| matches!(f.body, Body::PackedRecordPairs { .. }))
                .count(),
            1
        );
        crate::ir::check_locals(&program).unwrap();
    }
}
