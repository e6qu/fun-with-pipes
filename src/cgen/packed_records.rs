//! Keep an eager mapped numeric-record collection in one private word buffer.
//!
//! This is representation lowering, not stage fusion: the producer stays at its
//! original let binding and the seed stays at its original evaluation point.
//! Only the sole consuming fold changes. The ordinary ownership pass then sees
//! an Array[I64] owner, whose words hold numeric bits and never child pointers.

use std::collections::HashMap;

use crate::ir::*;

fn buffer_type() -> MT {
    MT::Con("std::Array".into(), vec![MT::con("std::I64")])
}

fn numeric_record(prog: &Program, ty: &MT) -> Option<usize> {
    let fields = record_fields(&prog.shapes, ty)?;
    (!fields.is_empty() && fields.iter().all(|(_, ty)| super::scalar(ty).is_some()))
        .then_some(fields.len())
}

fn mapper(prog: &Program, id: FuncId, arity: usize) -> Option<usize> {
    let function = prog.funcs.get(id)?;
    if function.arity as usize != arity {
        return None;
    }
    let abi = super::abi_of(prog, function)?;
    // Reuse the existing boxed-input ownership convention. Unpacked record
    // parameters need a distinct preparation proof and are not selected here.
    if abi.params.iter().any(Option::is_some) {
        return None;
    }
    let (parameters, result) = function.ty.params(arity);
    if parameters
        .iter()
        .any(|ty| super::scalar(ty).is_none() && numeric_record(prog, ty).is_none())
    {
        return None;
    }
    let width = numeric_record(prog, result)?;
    (abi.ret == Some(width)).then_some(width)
}

fn fold(prog: &Program, id: FuncId, element: &MT) -> Option<()> {
    let function = prog.funcs.get(id)?;
    if function.arity != 2 {
        return None;
    }
    let (parameters, result) = function.ty.params(2);
    if parameters[0] != result || parameters[1] != element {
        return None;
    }
    let width = numeric_record(prog, result)?;
    let element_width = numeric_record(prog, element)?;
    let abi = super::abi_of(prog, function)?;
    (abi.ret == Some(width) && abi.params == [Some(width), Some(element_width)]).then_some(())
}

/// Find the sole use along a straight sequence. Prefix bindings may have
/// effects: leave them where they are, rather than hoisting a fold's seed.
fn consumer(expr: &mut Expr, local: Local) -> Option<&mut Expr> {
    match expr {
        Expr::Trace(_, body) => consumer(body, local),
        Expr::Let(_, value, body) => {
            if crate::opt::uses(value, local) == 0 {
                consumer(body, local)
            } else {
                consumer(value, local)
            }
        }
        Expr::Call(_, _) => Some(expr),
        _ => None,
    }
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

struct Lower<'a> {
    program: &'a Program,
    made: Vec<Func>,
    maps: HashMap<FuncId, FuncId>,
    folds: HashMap<FuncId, FuncId>,
}

impl Lower<'_> {
    fn select(&mut self, expr: &mut Expr, locals: &mut [MT]) -> Option<()> {
        let Expr::Let(local, value, body) = expr else {
            return None;
        };
        if crate::opt::uses(body, *local) != 1 {
            return None;
        }
        let Expr::Call(producer, inputs) = &**value else {
            return None;
        };
        let Body::Prim(symbol) = &self.program.funcs.get(*producer)?.body else {
            return None;
        };
        let arity = match symbol.as_str() {
            "map" => 1,
            "zip-with" => 2,
            _ => return None,
        };
        if inputs.len() != arity + 1 {
            return None;
        }
        let Expr::Func(callback) = inputs[0] else {
            return None;
        };
        mapper(self.program, callback, arity)?;
        let (parameters, element) = self.program.funcs[callback].ty.params(arity);
        let (_, mapped) = self.program.funcs[*producer].ty.params(arity + 1);
        if mapped != &MT::Con("std::List".into(), vec![element.clone()]) {
            return None;
        }
        let target = consumer(body, *local)?;
        let Expr::Call(consumer, arguments) = target else {
            return None;
        };
        if !matches!(&self.program.funcs.get(*consumer)?.body, Body::Prim(s) if s == "fold") {
            return None;
        }
        let [Expr::Func(step), seed, Expr::Local(input)] = arguments.as_slice() else {
            return None;
        };
        if input != local {
            return None;
        }
        fold(self.program, *step, element)?;
        let map = *self.maps.entry(callback).or_insert_with(|| {
            let id = self.program.funcs.len() + self.made.len();
            self.made.push(function(
                "packed-record-map",
                parameters
                    .iter()
                    .map(|ty| MT::Con("std::List".into(), vec![(*ty).clone()]))
                    .collect(),
                buffer_type(),
                Body::PackedRecordMap { callback },
            ));
            id
        });
        let step = *step;
        let fold = *self.folds.entry(step).or_insert_with(|| {
            let id = self.program.funcs.len() + self.made.len();
            let result = self.program.funcs[step].ty.params(2).1.clone();
            self.made.push(function(
                "packed-record-fold",
                vec![result.clone(), buffer_type()],
                result,
                Body::PackedRecordFold { callback: step },
            ));
            id
        });
        let mapped_inputs = inputs[1..].to_vec();
        *target = Expr::Call(fold, vec![seed.clone(), Expr::Local(*local)]);
        **value = Expr::Call(map, mapped_inputs);
        locals[*local as usize] = buffer_type();
        Some(())
    }

    fn visit(&mut self, expr: &mut Expr, locals: &mut [MT]) {
        match expr {
            Expr::Trace(_, body)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body)
            | Expr::ResourceRegion { body, .. } => self.visit(body, locals),
            Expr::Call(_, args) | Expr::Construct(_, args) | Expr::Record(args) => {
                for arg in args {
                    self.visit(arg, locals);
                }
            }
            Expr::Apply(function, args) => {
                self.visit(function, locals);
                for arg in args {
                    self.visit(arg, locals);
                }
            }
            Expr::Field(record, _) => self.visit(record, locals),
            Expr::SetFields(record, fields) => {
                self.visit(record, locals);
                for (_, value) in fields {
                    self.visit(value, locals);
                }
            }
            Expr::Let(_, value, body) => {
                self.visit(value, locals);
                self.visit(body, locals);
            }
            Expr::Match(value, arms) => {
                self.visit(value, locals);
                for (_, body) in arms {
                    self.visit(body, locals);
                }
            }
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
        }
        self.select(expr, locals);
    }
}

pub(super) fn lower(program: &Program) -> Program {
    let mut result = program.clone();
    let mut lower = Lower {
        program,
        made: Vec::new(),
        maps: HashMap::new(),
        folds: HashMap::new(),
    };
    for function in &mut result.funcs {
        if let Body::Expr(body) = &mut function.body {
            lower.visit(body, &mut function.locals);
        }
    }
    result.funcs.extend(lower.made);
    result
}
