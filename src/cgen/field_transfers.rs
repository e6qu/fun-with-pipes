//! Move a complete group of already-separated field owners without copying.
//!
//! The ownership expression remains unchanged. Selection proves a call-free
//! group with the same owners at its exit, so later call-liveness identities
//! and ordinary boxed-entry cleanup remain valid.

use crate::ir::{record_fields, Expr, Local};

struct Projection {
    parent: Local,
    temporary: Local,
    index: usize,
    releases_parent: bool,
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
    let (releases_parent, result) = match &**body {
        Expr::Drop(released, result) if released == parent => (true, &**result),
        result => (false, result),
    };
    matches!(result, Expr::Local(local) if local == temporary).then_some(Projection {
        parent: *parent,
        temporary: *temporary,
        index: *index as usize,
        releases_parent,
    })
}

struct Transfer<'e> {
    bindings: Vec<(Local, Local, usize)>,
    rest: &'e Expr,
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
            || field.releases_parent != (position + 1 == width)
        {
            return None;
        }
        seen |= 1 << field.index;
        bindings.push((destination, field.temporary, field.index));
        if position + 1 == width {
            // Only a fully matched candidate scans its continuation. Ordinary
            // bindings never scan a function suffix looking for a later drop.
            return (crate::opt::uses(body, parent) == 0).then_some(Transfer {
                bindings,
                rest: body,
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
        complete(*local, value, body, 0, width)
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
}
