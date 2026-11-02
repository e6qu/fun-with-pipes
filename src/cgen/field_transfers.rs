//! Move a complete group of already-separated field owners without copying.
//!
//! The ownership expression remains unchanged. Selection proves a call-free
//! group with the same owners at its exit, so later call-liveness identities
//! and ordinary boxed-entry cleanup remain valid.

use std::collections::HashMap;

use crate::ir::{record_fields, Body, Expr, Local};

struct Projection {
    parent: Local,
    temporary: Local,
    index: usize,
    release: Option<*const Expr>,
}

fn projection(value: &Expr) -> Option<Projection> {
    let Expr::Let(temporary, read, body) = value else {
        return None;
    };
    let Expr::Field(base, index) = &**read else {
        return None;
    };
    let Expr::Local(parent) = &**base else {
        return None;
    };
    let Expr::Dup(retained, body) = &**body else {
        return None;
    };
    if retained != temporary || parent == temporary {
        return None;
    }
    let (release, result) = match &**body {
        Expr::Drop(released, result) if released == parent => {
            (Some(&**body as *const Expr), &**result)
        }
        result => (None, result),
    };
    matches!(result, Expr::Local(local) if local == temporary).then_some(Projection {
        parent: *parent,
        temporary: *temporary,
        index: *index as usize,
        release,
    })
}

struct Transfer<'e> {
    bindings: Vec<(Local, Local, usize)>,
    rest: &'e Expr,
    release: *const Expr,
}

/// One traversal of the immutable function. A later mention in another branch
/// conservatively prevents selecting an earlier branch. Pointer identities are
/// compared only, never dereferenced or carried across ownership-tree changes.
fn last_mentions(expr: &Expr, last: &mut HashMap<Local, *const Expr>) {
    match expr {
        Expr::Local(local) => {
            last.insert(*local, expr);
        }
        Expr::Const(_) | Expr::Func(_) => {}
        Expr::Call(_, arguments) | Expr::Construct(_, arguments) | Expr::Record(arguments) => {
            for argument in arguments {
                last_mentions(argument, last);
            }
        }
        Expr::Apply(function, arguments) => {
            last_mentions(function, last);
            for argument in arguments {
                last_mentions(argument, last);
            }
        }
        Expr::Field(base, _) => last_mentions(base, last),
        Expr::SetFields(base, fields) => {
            last_mentions(base, last);
            for (_, value) in fields {
                last_mentions(value, last);
            }
        }
        Expr::Let(_, value, body) => {
            last_mentions(value, last);
            last_mentions(body, last);
        }
        Expr::Match(value, arms) => {
            last_mentions(value, last);
            for (_, body) in arms {
                last_mentions(body, last);
            }
        }
        Expr::Dup(local, body) | Expr::Drop(local, body) => {
            last.insert(*local, expr);
            last_mentions(body, last);
        }
        Expr::Trace(_, body) | Expr::BorrowGlobal(_, _, body) => last_mentions(body, last),
        Expr::ResourceRegion {
            parameters,
            bindings,
            body,
        } => {
            for local in parameters.iter().chain(bindings) {
                last.insert(*local, expr);
            }
            last_mentions(body, last);
        }
    }
}

fn complete<'e>(
    mut destination: Local,
    mut value: &'e Expr,
    mut body: &'e Expr,
    parent: Local,
    width: usize,
) -> Option<Transfer<'e>> {
    if !(2..=super::MAX_UNBOXED).contains(&width) {
        return None;
    }
    let mut bindings = Vec::with_capacity(width);
    let mut seen = 0u32;
    for position in 0..width {
        let field = projection(value)?;
        if field.parent != parent
            || field.index >= width
            || seen & (1 << field.index) != 0
            || destination == parent
            || bindings.iter().any(|(other, _, _)| *other == destination)
            || field.release.is_some() != (position + 1 == width)
        {
            return None;
        }
        seen |= 1 << field.index;
        bindings.push((destination, field.temporary, field.index));
        if position + 1 == width {
            return Some(Transfer {
                bindings,
                rest: body,
                release: field.release.expect("complete group releases its parent"),
            });
        }
        let Expr::Let(next, next_value, next_body) = body else {
            return None;
        };
        destination = *next;
        value = next_value;
        body = next_body;
    }
    None
}

impl super::FnGen<'_, '_> {
    pub(super) fn bind_field_transfers<'e>(
        &mut self,
        destination: Local,
        value: &'e Expr,
        body: &'e Expr,
    ) -> Option<&'e Expr> {
        if self.in_loop.is_some() {
            return None;
        }
        let parent = projection(value)?.parent;
        let values = self.fields.get(&parent)?;
        let ty = &self.locals[parent as usize];
        if self.resource_slots.contains_key(&parent)
            || self.g.resource_type(ty)
            || self
                .g
                .prog
                .borrowed_parameters
                .get(&self.me)
                .is_some_and(|parameters| parameters.contains(&parent))
        {
            return None;
        }
        let types = record_fields(&self.g.prog.shapes, ty)?;
        if types.len() != values.len()
            || !types
                .iter()
                .all(|(_, ty)| crate::rc::needs_rc(&self.g.prog.shapes, ty))
        {
            return None;
        }
        let transfer = complete(destination, value, body, parent, values.len())?;
        let Body::Expr(root) = &self.g.prog.funcs[self.me].body else {
            return None;
        };
        let last = self.g.field_last_uses.entry(self.me).or_insert_with(|| {
            let mut last = HashMap::new();
            last_mentions(root, &mut last);
            last
        });
        if last.get(&parent) != Some(&transfer.release) {
            return None;
        }
        for (local, temporary, index) in &transfer.bindings {
            if self.resource_slots.contains_key(local)
                || self.fields.contains_key(local)
                || self.vlocals.contains_key(local)
                || self.stack_children.contains_key(local)
                || self.locals[*local as usize] != types[*index].1
                || self.locals[*temporary as usize] != types[*index].1
            {
                return None;
            }
        }
        let values = values.clone();
        self.line("/* move complete separated field owners */");
        for (local, temporary, index) in transfer.bindings {
            self.line(&format!("l{temporary} = {};", values[index]));
            self.line(&format!("l{local} = l{temporary};"));
        }
        Some(transfer.rest)
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    fn field(parent: Local, index: u32, temporary: Local, release: bool) -> Expr {
        let result = Expr::Local(temporary);
        let result = if release {
            Expr::Drop(parent, Box::new(result))
        } else {
            result
        };
        Expr::Let(
            temporary,
            Box::new(Expr::Field(Box::new(Expr::Local(parent)), index)),
            Box::new(Expr::Dup(temporary, Box::new(result))),
        )
    }

    fn group(indices: &[u32], rest: Expr) -> Expr {
        indices
            .iter()
            .enumerate()
            .rev()
            .fold(rest, |body, (position, index)| {
                Expr::Let(
                    1 + position as Local,
                    Box::new(field(
                        0,
                        *index,
                        20 + position as Local,
                        position + 1 == indices.len(),
                    )),
                    Box::new(body),
                )
            })
    }

    fn select(expr: &Expr, width: usize) -> Option<Transfer<'_>> {
        let Expr::Let(local, value, body) = expr else {
            return None;
        };
        let transfer = complete(*local, value, body, 0, width)?;
        let mut last = HashMap::new();
        last_mentions(expr, &mut last);
        (last.get(&0) == Some(&transfer.release)).then_some(transfer)
    }

    #[test]
    fn complete_reordered_transfers_preserve_the_original_continuation() {
        for indices in [vec![0, 1], vec![1, 0], (0..8).rev().collect()] {
            let body = group(&indices, Expr::Call(3, vec![Expr::Local(1)]));
            let transfer = select(&body, indices.len()).unwrap();
            assert_eq!(transfer.bindings.len(), indices.len());
            for (position, (destination, temporary, index)) in transfer.bindings.iter().enumerate()
            {
                assert_eq!(
                    (*destination, *temporary, *index),
                    (
                        1 + position as Local,
                        20 + position as Local,
                        indices[position] as usize
                    )
                );
            }
            let mut original = &body;
            for _ in &indices {
                let Expr::Let(_, _, rest) = original else {
                    unreachable!()
                };
                original = rest;
            }
            assert!(std::ptr::eq(transfer.rest, original));
        }
    }

    #[test]
    fn repeated_partial_out_of_range_and_live_parent_transfers_are_rejected() {
        for (indices, width) in [
            (vec![0, 0], 2),
            (vec![0], 2),
            (vec![0, 2], 2),
            (vec![0, 1], 1),
            ((0..9).collect(), 9),
        ] {
            assert!(select(&group(&indices, Expr::Local(1)), width).is_none());
        }
        for rest in [
            Expr::Local(0),
            Expr::Dup(0, Box::new(Expr::Local(1))),
            Expr::Drop(0, Box::new(Expr::Local(1))),
        ] {
            assert!(select(&group(&[0, 1], rest), 2).is_none());
        }
    }

    #[test]
    fn interrupted_or_mismatched_ownership_is_rejected() {
        let mut body = group(&[0, 1], Expr::Local(1));
        let Expr::Let(_, _, tail) = &mut body else {
            unreachable!()
        };
        let saved = tail.clone();
        *tail = Box::new(Expr::Let(10, Box::new(Expr::Call(4, vec![])), saved));
        assert!(select(&body, 2).is_none());
        for value in [
            field(0, 0, 20, true),
            field(0, 0, 0, false),
            field(1, 0, 20, false),
        ] {
            let tail = group(&[1], Expr::Local(1));
            assert!(complete(1, &value, &tail, 0, 2).is_none());
        }
        let value = Expr::Let(
            20,
            Box::new(Expr::Field(Box::new(Expr::Local(0)), 0)),
            Box::new(Expr::Dup(21, Box::new(Expr::Local(20)))),
        );
        assert!(projection(&value).is_none());
    }

    #[test]
    fn last_use_index_includes_enclosing_continuations() {
        let root = Expr::Let(
            50,
            Box::new(group(&[0, 1], Expr::Local(1))),
            Box::new(Expr::Local(0)),
        );
        let Expr::Let(_, value, _) = &root else {
            unreachable!()
        };
        let inner = select(value, 2).unwrap();
        let mut last = HashMap::new();
        last_mentions(&root, &mut last);
        assert_ne!(last.get(&0), Some(&inner.release));
    }
}
