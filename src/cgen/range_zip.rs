//! Generate a sole-use I64 range directly at its zip consumer. Bounds remain
//! evaluated once at creation; only the private list storage disappears.
use std::collections::HashMap;

use crate::ir::*;
use crate::value::Value;

#[derive(Clone, Copy, PartialEq, Eq, Hash)]
struct Callback {
    id: FuncId,
    captures: usize,
}

#[derive(Clone, Copy)]
enum Use {
    Other,
    Alias(Local, usize),
    Zip {
        node: usize,
        block: usize,
        callback: Callback,
        slot: usize,
    },
}
struct Producer {
    node: usize,
    local: Local,
    block: usize,
}
#[derive(Clone, Copy)]
struct Consumer {
    helper: FuncId,
    slot: usize,
    lo: Local,
    hi: Local,
}

fn integer() -> MT {
    MT::con("std::I64")
}
fn list(element: &MT) -> MT {
    MT::Con("std::List".into(), vec![element.clone()])
}

fn range(program: &Program, id: FuncId) -> bool {
    let f = &program.funcs[id];
    let (parameters, result) = f.ty.params(2);
    f.arity == 2
        && matches!(&f.body, Body::Prim(s) if s == "range")
        && parameters == vec![&integer(), &integer()]
        && result == &list(&integer())
}

fn zip(program: &Program, id: FuncId, step: Callback) -> bool {
    let f = &program.funcs[id];
    let worker = &program.funcs[step.id];
    if f.arity != 3
        || !matches!(&f.body, Body::Prim(s) if s == "zip-with")
        || worker.arity as usize != step.captures + 2
        || !matches!(worker.body, Body::Expr(_) | Body::Prim(_))
    {
        return false;
    }
    let (inputs, result) = worker.ty.params(step.captures + 2);
    if inputs.len() != step.captures + 2 || !inputs.iter().all(|ty| super::scalar(ty).is_some()) {
        return false;
    }
    if super::scalar(result).is_none()
        && !record_fields(&program.shapes, result).is_some_and(|fields| {
            (1..=2).contains(&fields.len())
                && fields.iter().all(|(_, ty)| super::scalar(ty).is_some())
        })
    {
        return false;
    }
    let (parameters, output) = f.ty.params(3);
    parameters.len() == 3
        && parameters[0] == worker.ty.params(step.captures).1
        && parameters[1] == &list(inputs[step.captures])
        && parameters[2] == &list(inputs[step.captures + 1])
        && output == &list(result)
}

struct Index<'a> {
    program: &'a Program,
    uses: Vec<Option<Use>>,
    origins: Vec<Option<Callback>>,
    producers: Vec<Producer>,
    blocks: usize,
    visits: usize,
}
impl Index<'_> {
    fn use_local(&mut self, local: Local, usage: Use) {
        let entry = &mut self.uses[local as usize];
        *entry = Some(if entry.is_none() { usage } else { Use::Other });
    }
    fn origin(&self, expr: &Expr) -> Option<Callback> {
        match expr {
            Expr::Func(id) => Some(Callback {
                id: *id,
                captures: 0,
            }),
            Expr::Local(local) => self.origins[*local as usize],
            Expr::Apply(f, args) => match &**f {
                Expr::Func(id) => Some(Callback {
                    id: *id,
                    captures: args.len(),
                }),
                _ => None,
            },
            Expr::Trace(_, body) => self.origin(body),
            _ => None,
        }
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
                    if arguments.len() == 2 && range(self.program, *id) {
                        self.producers.push(Producer {
                            node: expr as *const Expr as usize,
                            local: *local,
                            block,
                        });
                    }
                }
                self.walk(value, block, Use::Alias(*local, block));
                self.origins[*local as usize] = self.origin(value);
                self.walk(body, block, usage);
            }
            Expr::Trace(_, body) => self.walk(body, block, usage),
            Expr::Call(id, arguments) => {
                let step = arguments
                    .first()
                    .and_then(|value| self.origin(value))
                    .filter(|step| arguments.len() == 3 && zip(self.program, *id, *step));
                for (slot, argument) in arguments.iter().enumerate() {
                    if let (Some(callback), Expr::Local(_), true) = (step, argument, slot > 0) {
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

fn rewrite(
    expr: &mut Expr,
    calls: &HashMap<usize, Consumer>,
    producers: &HashMap<usize, (Local, Local)>,
    visits: &mut usize,
) {
    *visits += 1;
    let replacement = calls.get(&(expr as *const Expr as usize)).copied();
    let bounds = producers.get(&(expr as *const Expr as usize)).copied();
    match expr {
        Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
            for arg in args {
                rewrite(arg, calls, producers, visits);
            }
        }
        Expr::Apply(f, args) => {
            rewrite(f, calls, producers, visits);
            for arg in args {
                rewrite(arg, calls, producers, visits);
            }
        }
        Expr::Let(_, value, body) => {
            rewrite(value, calls, producers, visits);
            rewrite(body, calls, producers, visits);
        }
        Expr::Match(value, arms) => {
            rewrite(value, calls, producers, visits);
            for (_, body) in arms {
                rewrite(body, calls, producers, visits);
            }
        }
        Expr::SetFields(value, fields) => {
            rewrite(value, calls, producers, visits);
            for (_, value) in fields {
                rewrite(value, calls, producers, visits);
            }
        }
        Expr::Field(body, _)
        | Expr::Trace(_, body)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::BorrowGlobal(_, _, body)
        | Expr::ResourceRegion { body, .. } => rewrite(body, calls, producers, visits),
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
    }
    if let Some(Consumer {
        helper,
        slot,
        lo,
        hi,
    }) = replacement
    {
        let Expr::Call(id, arguments) = expr else {
            unreachable!()
        };
        arguments[slot + 1] = Expr::Local(lo);
        arguments.insert(slot + 2, Expr::Local(hi));
        *id = helper;
    }
    if let Some((lo, hi)) = bounds {
        let Expr::Let(local, value, body) = std::mem::replace(expr, Expr::Const(Value::unit()))
        else {
            unreachable!()
        };
        let Expr::Call(_, arguments) = *value else {
            unreachable!()
        };
        let [low, high]: [Expr; 2] = arguments.try_into().expect("range bounds");
        *expr = Expr::Let(
            lo,
            Box::new(low),
            Box::new(Expr::Let(
                hi,
                Box::new(high),
                Box::new(Expr::Let(local, Box::new(Expr::Const(Value::unit())), body)),
            )),
        );
    }
}

/// Index uses once and follow disjoint single-use alias chains; count visits
/// deterministically so tests can check analysis scaling without wall-clock noise.
pub(super) fn lower(program: &mut Program) -> usize {
    let original_len = program.funcs.len();
    let mut made = Vec::new();
    let mut helpers = HashMap::new();
    let mut visits = 0;
    for id in 0..original_len {
        let function = &program.funcs[id];
        let Body::Expr(body) = &function.body else {
            continue;
        };
        let mut index = Index {
            program,
            uses: vec![None; function.locals.len()],
            origins: vec![None; function.locals.len()],
            producers: Vec::new(),
            blocks: 0,
            visits: 0,
        };
        index.walk(body, 0, Use::Other);
        visits += index.visits;
        let mut calls = HashMap::new();
        let mut producers = HashMap::new();
        let mut changed = Vec::new();
        let mut fresh = function.locals.len();
        let mut marks = vec![usize::MAX; fresh];
        for (generation, producer) in index.producers.iter().enumerate() {
            let mut local = producer.local;
            let mut aliases = Vec::new();
            let target = loop {
                visits += 1;
                if marks[local as usize] == generation
                    || function.locals[local as usize] != list(&integer())
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
                    }) if block == producer.block => break Some((node, callback, slot)),
                    _ => break None,
                }
            };
            let Some((node, step, slot)) = target else {
                continue;
            };
            if calls.contains_key(&node) {
                continue;
            }
            let worker = &program.funcs[step.id];
            let (parameters, result) = worker.ty.params(step.captures + 2);
            if parameters[step.captures + slot] != &integer() {
                continue;
            }
            let helper = *helpers.entry((step, slot)).or_insert_with(|| {
                let helper = original_len + made.len();
                let mut inputs = vec![worker.ty.params(step.captures).1.clone()];
                for position in 0..2 {
                    if position == slot {
                        inputs.extend([integer(), integer()]);
                    } else {
                        inputs.push(list(parameters[step.captures + position]));
                    }
                }
                made.push(function_body(
                    "range-zip",
                    inputs,
                    list(result),
                    Body::RangeZip {
                        callback: step.id,
                        captures: step.captures,
                        slot,
                    },
                ));
                helper
            });
            let lo = Local::try_from(fresh).expect("range lower local");
            let hi = Local::try_from(fresh + 1).expect("range upper local");
            fresh += 2;
            calls.insert(
                node,
                Consumer {
                    helper,
                    slot,
                    lo,
                    hi,
                },
            );
            producers.insert(producer.node, (lo, hi));
            changed.extend(aliases);
        }
        if !calls.is_empty() {
            let function = &mut program.funcs[id];
            let Body::Expr(body) = &mut function.body else {
                unreachable!()
            };
            rewrite(body, &calls, &producers, &mut visits);
            for local in changed {
                function.locals[local as usize] = MT::unit();
            }
            function.locals.resize(fresh, integer());
        }
    }
    program.funcs.extend(made);
    visits
}

#[cfg(test)]
mod tests {
    use super::*;

    fn example(aliases: usize, slot: usize, captured: bool, result: MT) -> Program {
        let number = integer();
        let sequence = list(&number);
        let captures = usize::from(captured);
        let callback = function_body(
            "step",
            vec![number.clone(); captures + 2],
            result.clone(),
            Body::Expr(if matches!(result, MT::Record(_)) {
                Expr::Record(vec![
                    Expr::Local(captures as Local),
                    Expr::Local(captures as Local + 1),
                ])
            } else {
                Expr::Local(captures as Local)
            }),
        );
        let range = function_body(
            "range",
            vec![number.clone(); 2],
            sequence.clone(),
            Body::Prim("range".into()),
        );
        let zip = function_body(
            "zip",
            vec![
                callback.ty.params(captures).1.clone(),
                sequence.clone(),
                sequence.clone(),
            ],
            list(&result),
            Body::Prim("zip-with".into()),
        );
        // Parameters 0/1 are bounds, 2 is the other list, 3 is a numeric capture.
        // Local 4 is the callback, 5 is the range, followed by range aliases.
        let last = 5 + aliases as Local;
        let mut args = vec![Expr::Local(4), Expr::Local(2), Expr::Local(2)];
        args[slot + 1] = Expr::Local(last);
        let mut body = Expr::Call(3, args);
        for local in (6..=last).rev() {
            body = Expr::Let(local, Box::new(Expr::Local(local - 1)), Box::new(body));
        }
        body = Expr::Let(
            5,
            Box::new(Expr::Call(2, vec![Expr::Local(0), Expr::Local(1)])),
            Box::new(body),
        );
        body = Expr::Let(
            4,
            Box::new(if captured {
                Expr::Apply(Box::new(Expr::Func(1)), vec![Expr::Local(3)])
            } else {
                Expr::Func(1)
            }),
            Box::new(body),
        );
        let mut entry = function_body(
            "entry",
            vec![number.clone(), number.clone(), sequence.clone(), number],
            list(&result),
            Body::Expr(body),
        );
        entry.locals.push(callback.ty.params(captures).1.clone());
        entry.locals.extend(vec![sequence; aliases + 1]);
        Program {
            funcs: vec![entry, callback, range, zip],
            main: Some(0),
            ..Program::default()
        }
    }

    #[test]
    fn both_slots_capture_origins_numeric_records_and_aliases() {
        let record = MT::Record(vec![("0".into(), integer()), ("1".into(), integer())]);
        for slot in 0..2 {
            for captured in [false, true] {
                for result in [integer(), record.clone()] {
                    let mut program = example(4, slot, captured, result);
                    check_locals(&program).unwrap();
                    lower(&mut program);
                    check_locals(&program).unwrap();
                    assert_eq!(program.funcs.len(), 5);
                    assert!(program.funcs[0].locals[5..10]
                        .iter()
                        .all(|ty| *ty == MT::unit()));
                    assert_eq!(program.funcs[0].locals[10..], [integer(), integer()]);
                    assert!(
                        matches!(program.funcs[4].body, Body::RangeZip { callback: 1, captures, slot: selected } if captures == usize::from(captured) && selected == slot)
                    );
                    assert_eq!(program.funcs[4].arity, 4);
                    let live = reachable_functions(&program, &[0]).unwrap();
                    assert!(live[1] && live[4]);
                    assert!(!live[2] && !live[3]);
                    assert_eq!(crate::escape::params(&program)[4], [true; 4]);
                }
            }
        }
    }

    #[test]
    fn shared_or_conditional_ranges_are_not_selected() {
        for conditional in [false, true] {
            let mut program = example(0, 0, false, integer());
            let Body::Expr(Expr::Let(_, _, outer)) = &mut program.funcs[0].body else {
                unreachable!()
            };
            let Expr::Let(_, _, body) = &mut **outer else {
                unreachable!()
            };
            let original = (**body).clone();
            **body = if conditional {
                Expr::Match(
                    Box::new(Expr::Const(Value::unit())),
                    vec![(Pat::Wild, original)],
                )
            } else {
                Expr::Let(6, Box::new(Expr::Local(5)), Box::new(original))
            };
            program.funcs[0].locals.push(list(&integer()));
            lower(&mut program);
            assert_eq!(program.funcs.len(), 4);
        }
    }

    #[test]
    fn unknown_and_reference_captures_or_wide_results_are_excluded() {
        let mut program = example(0, 0, false, integer());
        let Body::Expr(Expr::Let(_, value, _)) = &mut program.funcs[0].body else {
            unreachable!()
        };
        **value = Expr::Local(6);
        let callback_type = program.funcs[1].ty.clone();
        program.funcs[0].locals.push(callback_type);
        lower(&mut program);
        assert_eq!(program.funcs.len(), 4);
        for result in [
            MT::con("std::String"),
            MT::con("std::F128"),
            MT::Record(vec![("0".into(), MT::con("std::String"))]),
            MT::Record(vec![(
                "0".into(),
                MT::Record(vec![("0".into(), integer())]),
            )]),
            MT::Record(vec![
                ("0".into(), integer()),
                ("1".into(), integer()),
                ("2".into(), integer()),
            ]),
        ] {
            let mut program = example(0, 0, false, result);
            lower(&mut program);
            assert_eq!(program.funcs.len(), 4);
        }
        let mut program = example(0, 0, true, integer());
        program.funcs[1] = function_body(
            "reference-capture",
            vec![MT::con("std::String"), integer(), integer()],
            integer(),
            Body::Expr(Expr::Local(1)),
        );
        lower(&mut program);
        assert_eq!(program.funcs.len(), 4);
    }

    #[test]
    fn bound_expressions_stay_in_order_at_creation() {
        let mut program = example(0, 1, true, integer());
        lower(&mut program);
        let Body::Expr(Expr::Let(4, _, outer)) = &program.funcs[0].body else {
            panic!("callback construction moved")
        };
        let Expr::Let(6, lo, high) = &**outer else {
            panic!("lower bound moved")
        };
        assert!(matches!(**lo, Expr::Local(0)));
        let Expr::Let(7, hi, range) = &**high else {
            panic!("upper bound moved")
        };
        assert!(matches!(**hi, Expr::Local(1)));
        let Expr::Let(5, _, body) = &**range else {
            panic!("range binding moved")
        };
        let Expr::Call(4, args) = &**body else {
            panic!("zip call missing")
        };
        assert!(matches!(
            args.as_slice(),
            [
                Expr::Local(4),
                Expr::Local(2),
                Expr::Local(6),
                Expr::Local(7)
            ]
        ));
    }

    #[test]
    fn alias_walk_scales_linearly() {
        let small = lower(&mut example(64, 0, true, integer()));
        let large = lower(&mut example(128, 0, true, integer()));
        assert!(large <= 2 * small, "{small} -> {large}");
        assert!(large < 12 * 128, "{large}");
    }
}
