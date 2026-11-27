//! Inner resource frames can borrow lifetime protection from an enclosing frame.
//! This does not borrow ordinary argument owners or alter interpreter metadata.

use std::collections::{HashMap, HashSet};

use crate::ir::{Expr, Func, Local, Pat, Shapes, MT};

// The oldest active original frame that protects every observable resource in
// this value. Depth zero means no observable resource; None means unknown.
// A result can leave a region only when its protecting frame survives that exit.
type Protection = Option<usize>;

#[derive(Clone, Copy, Default)]
struct LocalState {
    protection: Protection,
    binding: Protection,
}

struct Scan<'a> {
    locals: Vec<LocalState>,
    plain: Vec<bool>,
    funcs: &'a [Func],
    depth: usize,
    undo: Vec<(Local, LocalState)>,
    selected: HashMap<*const Expr, HashSet<Local>>,
}

impl Scan<'_> {
    fn set(&mut self, local: Local, state: LocalState) {
        self.undo.push((local, self.locals[local as usize]));
        self.locals[local as usize] = state;
    }

    fn restore(&mut self, mark: usize) {
        while self.undo.len() > mark {
            let (local, state) = self.undo.pop().unwrap();
            self.locals[local as usize] = state;
        }
    }

    fn protected(&self, local: Local) -> Protection {
        if self.plain[local as usize] {
            Some(0)
        } else {
            self.locals[local as usize].protection
        }
    }

    fn bind(&mut self, local: Local, protection: Protection) {
        let binding = self.locals[local as usize].binding;
        // Prefer an older protecting owner when both exist. The new original
        // binding is still retained normally, but need not hide that ancestor.
        let protection = protection.into_iter().chain(binding).min();
        self.set(
            local,
            LocalState {
                protection,
                binding,
            },
        );
    }

    fn pattern(&mut self, pattern: &Pat, protection: Protection) {
        match pattern {
            Pat::Bind(local) => self.bind(*local, protection),
            Pat::Record(fields) | Pat::Construct(_, fields) => {
                for field in fields {
                    self.pattern(field, protection);
                }
            }
            Pat::Wild | Pat::Lit(_) => {}
        }
    }

    fn visit(&mut self, expr: &Expr) -> Protection {
        let mark = self.undo.len();
        let result = match expr {
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => {
                let parent = self.depth;
                self.depth += 1;
                let inherited: HashSet<_> = parameters
                    .iter()
                    .copied()
                    .filter(|local| self.protected(*local).is_some())
                    .collect();
                if !inherited.is_empty() {
                    self.selected.insert(expr, inherited);
                }
                for &local in parameters {
                    let protection = self.protected(local).or(Some(self.depth));
                    self.set(
                        local,
                        LocalState {
                            protection,
                            binding: None,
                        },
                    );
                }
                for &local in bindings {
                    // A future slot protects nothing until initialization.
                    self.set(
                        local,
                        LocalState {
                            protection: None,
                            binding: Some(self.depth),
                        },
                    );
                }
                let result = self.visit(body).filter(|depth| *depth <= parent);
                self.depth = parent;
                result
            }
            Expr::Let(local, value, body) => {
                let protection = self.visit(value);
                self.bind(*local, protection);
                self.visit(body)
            }
            Expr::Match(value, arms) => {
                let protection = self.visit(value);
                let mut joined = Some(0);
                for (pattern, body) in arms {
                    self.pattern(pattern, protection);
                    joined = joined.zip(self.visit(body)).map(|(a, b)| a.max(b));
                    self.restore(mark);
                }
                if arms.is_empty() {
                    None
                } else {
                    joined
                }
            }
            Expr::Trace(_, body)
            | Expr::Field(body, _)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body) => self.visit(body),
            Expr::Record(args) => {
                // The new record's identity is not observable. Every resource
                // it owns must already have a surviving enclosing owner.
                let mut joined = Some(0);
                for arg in args {
                    joined = joined.zip(self.visit(arg)).map(|(a, b)| a.max(b));
                }
                joined
            }
            Expr::Apply(function, args) => {
                self.visit(function);
                let mut joined = Some(0);
                for arg in args {
                    joined = joined.zip(self.visit(arg)).map(|(a, b)| a.max(b));
                }
                // Only an actual unsaturated constructor owns precisely these
                // captures. A saturated or nullary factory may return anything.
                if matches!(&**function, Expr::Func(id) if args.len() < self.funcs[*id].arity as usize)
                {
                    joined
                } else {
                    None
                }
            }
            Expr::Call(_, args) | Expr::Construct(_, args) => {
                for arg in args {
                    self.visit(arg);
                }
                None
            }
            Expr::SetFields(base, fields) => {
                self.visit(base);
                for (_, value) in fields {
                    self.visit(value);
                }
                None
            }
            Expr::Local(local) => self.protected(*local),
            Expr::Const(_) => Some(0), // Validated portable constants own no handles.
            Expr::Func(id) => (self.funcs[*id].arity > 0).then_some(0),
        };
        self.restore(mark);
        result
    }
}

// A proof about one binding must never survive reassignment of its local ID.
// Ordinary inlining uses fresh binders. Reject unusual/rebound emission trees
// rather than guessing which dynamic value the original frame owns.
fn fresh_bindings(expr: &Expr, seen: &mut HashSet<Local>) -> bool {
    fn pattern(pat: &Pat, seen: &mut HashSet<Local>) -> bool {
        match pat {
            Pat::Bind(local) => seen.insert(*local),
            Pat::Construct(_, fields) | Pat::Record(fields) => {
                fields.iter().all(|p| pattern(p, seen))
            }
            Pat::Wild | Pat::Lit(_) => true,
        }
    }
    match expr {
        Expr::Let(local, value, body) => {
            fresh_bindings(value, seen) && seen.insert(*local) && fresh_bindings(body, seen)
        }
        Expr::BorrowGlobal(local, _, body) => seen.insert(*local) && fresh_bindings(body, seen),
        Expr::Match(value, arms) => {
            fresh_bindings(value, seen)
                && arms
                    .iter()
                    .all(|(p, body)| pattern(p, seen) && fresh_bindings(body, seen))
        }
        Expr::Trace(_, body)
        | Expr::Field(body, _)
        | Expr::Dup(_, body)
        | Expr::Drop(_, body)
        | Expr::ResourceRegion { body, .. } => fresh_bindings(body, seen),
        Expr::Call(_, args) | Expr::Record(args) | Expr::Construct(_, args) => {
            args.iter().all(|e| fresh_bindings(e, seen))
        }
        Expr::Apply(function, args) => {
            fresh_bindings(function, seen) && args.iter().all(|e| fresh_bindings(e, seen))
        }
        Expr::SetFields(base, fields) => {
            fresh_bindings(base, seen) && fields.iter().all(|(_, e)| fresh_bindings(e, seen))
        }
        Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => true,
    }
}

/// Two bounded traversals of this exact emission tree; no interprocedural proof.
/// The caller excludes loop/tail-rebinding bodies. Keys cannot cross tree clones.
pub(super) fn parameters(
    root: &Expr,
    locals: &[MT],
    arity: u32,
    funcs: &[Func],
    shapes: &Shapes,
) -> HashMap<*const Expr, HashSet<Local>> {
    if !fresh_bindings(root, &mut (0..arity).collect()) {
        return HashMap::new();
    }
    let mut types = HashMap::new();
    let plain = locals
        .iter()
        .map(|ty| {
            *types
                .entry(ty)
                .or_insert_with(|| crate::tailrec::plain_data(shapes, ty, &mut HashSet::new()))
        })
        .collect();
    let mut scan = Scan {
        locals: vec![LocalState::default(); locals.len()],
        plain,
        funcs,
        depth: 0,
        undo: Vec::new(),
        selected: HashMap::new(),
    };
    scan.visit(root);
    scan.selected
}

#[cfg(test)]
mod tests {
    use super::*;
    use crate::value::Value;

    fn region(parameters: &[Local], bindings: &[Local], body: Expr) -> Expr {
        Expr::ResourceRegion {
            parameters: parameters.to_vec(),
            bindings: bindings.to_vec(),
            body: Box::new(body),
        }
    }

    fn bind(local: Local, value: Expr, body: Expr) -> Expr {
        Expr::Let(local, Box::new(value), Box::new(body))
    }

    fn unit() -> Expr {
        Expr::Const(Value::unit())
    }

    fn selected(body: &Expr) -> Vec<Local> {
        let mut result: Vec<_> =
            parameters(body, &vec![MT::con("unknown"); 16], 2, &[], &Shapes::new())
                .into_values()
                .flatten()
                .collect();
        result.sort_unstable();
        result
    }

    #[test]
    fn constructed_records_keep_the_oldest_protecting_owner() {
        let body = region(
            &[0],
            &[],
            bind(
                2,
                Expr::Record(vec![Expr::Local(0), unit()]),
                bind(
                    3,
                    region(&[2], &[], Expr::Field(Box::new(Expr::Local(2)), 0)),
                    region(&[3], &[], unit()),
                ),
            ),
        );
        assert_eq!(selected(&body), vec![2, 3]);
        // A new record does not make an unknown sibling field safe.
        let unknown = region(
            &[0],
            &[],
            bind(
                2,
                Expr::Record(vec![Expr::Local(0), Expr::Local(1)]),
                region(&[2], &[], unit()),
            ),
        );
        assert!(selected(&unknown).is_empty());
    }

    #[test]
    fn returned_values_require_an_owner_that_survives_the_exit() {
        let returned = region(
            &[0],
            &[],
            bind(2, Expr::Record(vec![Expr::Local(0)]), Expr::Local(2)),
        );
        let ended = bind(3, returned.clone(), region(&[3], &[], unit()));
        assert!(selected(&ended).is_empty());
        // The same returned record is covered when an older owner survives.
        let alive = region(&[0], &[], ended);
        assert_eq!(selected(&alive), vec![0, 3]);
    }

    #[test]
    fn every_branch_must_return_surviving_protection() {
        for unknown in [false, true] {
            let value = Expr::Match(
                Box::new(unit()),
                vec![
                    (Pat::Wild, Expr::Record(vec![Expr::Local(0)])),
                    (Pat::Wild, Expr::Local(if unknown { 1 } else { 0 })),
                ],
            );
            let body = region(&[0], &[], bind(2, value, region(&[2], &[], unit())));
            assert_eq!(selected(&body), if unknown { vec![] } else { vec![2] });
        }
    }

    #[test]
    fn only_unsaturated_known_constructors_preserve_capture_protection() {
        use crate::ir::Body;

        let funcs: Vec<_> = (0..=2)
            .map(|arity| Func {
                name: format!("arity{arity}"),
                arity,
                locals: vec![MT::con("unknown"); arity as usize],
                ty: (0..arity).fold(MT::unit(), |result, _| {
                    MT::Fun(Box::new(MT::con("unknown")), Box::new(result))
                }),
                body: Body::Expr(unit()),
            })
            .collect();
        let locals = vec![MT::con("unknown"); 16];
        for (function, args, expected) in [
            (Expr::Func(2), vec![Expr::Local(0)], true),
            (Expr::Func(2), vec![Expr::Local(1)], false),
            (Expr::Func(1), vec![Expr::Local(0)], false),
            (Expr::Func(0), vec![], false),
            (Expr::Local(0), vec![], false),
        ] {
            let body = region(
                &[0],
                &[],
                bind(
                    2,
                    Expr::Apply(Box::new(function), args),
                    region(&[2], &[], unit()),
                ),
            );
            let proof = parameters(&body, &locals, 2, &funcs, &Shapes::new());
            assert_eq!(proof.values().any(|locals| locals.contains(&2)), expected);
        }
    }

    #[test]
    fn enclosing_owner_covers_aliases_and_immutable_projections() {
        let body = region(
            &[0],
            &[],
            bind(
                2,
                Expr::Local(0),
                bind(
                    3,
                    Expr::Field(Box::new(Expr::Local(2)), 0),
                    region(&[2, 3], &[], unit()),
                ),
            ),
        );
        assert_eq!(selected(&body), vec![2, 3]);
        let clone = body.clone();
        let locals = vec![MT::con("unknown"); 16];
        let original = parameters(&body, &locals, 2, &[], &Shapes::new());
        let copied = parameters(&clone, &locals, 2, &[], &Shapes::new());
        assert!(original.keys().all(|key| !copied.contains_key(key)));
    }

    #[test]
    fn a_future_binding_does_not_own_its_unfinished_initializer() {
        let body = region(
            &[],
            &[2],
            bind(
                2,
                region(&[0], &[], Expr::Local(0)),
                bind(3, Expr::Local(2), region(&[3], &[], unit())),
            ),
        );
        assert_eq!(selected(&body), vec![3]);
    }

    #[test]
    fn scope_exit_and_factory_results_do_not_prove_outer_ownership() {
        let ended = bind(
            2,
            region(&[0], &[], Expr::Local(0)),
            region(&[2], &[], unit()),
        );
        assert!(selected(&ended).is_empty());
        for value in [
            Expr::Call(0, vec![Expr::Local(0)]),
            Expr::Apply(Box::new(Expr::Local(0)), vec![]),
            Expr::SetFields(Box::new(Expr::Local(0)), vec![(0, unit())]),
        ] {
            let body = region(&[0], &[], bind(2, value, region(&[2], &[], unit())));
            assert!(selected(&body).is_empty());
        }
    }

    #[test]
    fn pattern_coverage_is_scoped_to_its_branch() {
        let body = region(
            &[0],
            &[],
            Expr::Match(
                Box::new(Expr::Local(0)),
                vec![
                    (Pat::Record(vec![Pat::Bind(2)]), region(&[2], &[], unit())),
                    (Pat::Wild, region(&[1], &[], unit())),
                ],
            ),
        );
        assert_eq!(selected(&body), vec![2]);
        let unknown = region(
            &[],
            &[3],
            Expr::Match(
                Box::new(Expr::Local(1)),
                vec![
                    (
                        Pat::Construct(0, vec![Pat::Bind(3)]),
                        region(&[3], &[], unit()),
                    ),
                    (Pat::Wild, region(&[1], &[], unit())),
                ],
            ),
        );
        assert_eq!(selected(&unknown), vec![3]);
    }

    #[test]
    fn sibling_regions_do_not_share_a_finished_anchor() {
        let body = Expr::Record(vec![region(&[0], &[], unit()), region(&[0], &[], unit())]);
        assert!(selected(&body).is_empty());
    }

    #[test]
    fn rebinding_parameters_or_local_ids_rejects_the_proof() {
        let parameter = region(
            &[0],
            &[],
            bind(0, Expr::Call(0, vec![]), region(&[0], &[], unit())),
        );
        assert!(selected(&parameter).is_empty());
        let local = region(
            &[0],
            &[],
            bind(
                2,
                Expr::Local(0),
                bind(2, Expr::Call(0, vec![]), region(&[2], &[], unit())),
            ),
        );
        assert!(selected(&local).is_empty());
    }

    #[test]
    fn ordinary_count_changes_leave_the_independent_frame_owner_live() {
        let body = region(
            &[0],
            &[],
            bind(
                2,
                Expr::Dup(0, Box::new(Expr::Local(0))),
                Expr::Drop(0, Box::new(region(&[2], &[], unit()))),
            ),
        );
        assert_eq!(selected(&body), vec![2]);
    }
}
