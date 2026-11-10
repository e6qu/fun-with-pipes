//! Inner resource frames can borrow lifetime protection from an enclosing frame.
//! This does not borrow ordinary argument owners or alter interpreter metadata.

use std::collections::{HashMap, HashSet};

use crate::ir::{Expr, Local, Pat};

#[derive(Clone, Copy, Default)]
struct LocalState {
    protected: bool,
    binding: bool,
}

struct Scan {
    locals: Vec<LocalState>,
    undo: Vec<(Local, LocalState)>,
    selected: HashMap<*const Expr, HashSet<Local>>,
}

impl Scan {
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

    // These expressions expose the same immutable value or one of its owned
    // fields. Calls, factories, updated records and mutable channel contents do
    // not establish this relation. Ordinary Dup/Drop never remove frame owners.
    fn covered(&self, value: &Expr) -> bool {
        match value {
            Expr::Local(local) => self.locals[*local as usize].protected,
            Expr::Field(base, _)
            | Expr::Trace(_, base)
            | Expr::Dup(_, base)
            | Expr::Drop(_, base) => self.covered(base),
            _ => false,
        }
    }

    fn bind(&mut self, local: Local, covered: bool) {
        let binding = self.locals[local as usize].binding;
        self.set(
            local,
            LocalState {
                protected: binding || covered,
                binding,
            },
        );
    }

    fn pattern(&mut self, pattern: &Pat, covered: bool) {
        match pattern {
            Pat::Bind(local) => self.bind(*local, covered),
            Pat::Record(fields) | Pat::Construct(_, fields) => {
                for field in fields {
                    self.pattern(field, covered);
                }
            }
            Pat::Wild | Pat::Lit(_) => {}
        }
    }

    fn visit(&mut self, expr: &Expr) {
        let mark = self.undo.len();
        match expr {
            Expr::ResourceRegion {
                parameters,
                bindings,
                body,
            } => {
                // Test against enclosing frames before registering this frame.
                let inherited: HashSet<_> = parameters
                    .iter()
                    .copied()
                    .filter(|local| self.locals[*local as usize].protected)
                    .collect();
                if !inherited.is_empty() {
                    self.selected.insert(expr, inherited);
                }
                for &local in parameters {
                    self.set(
                        local,
                        LocalState {
                            protected: true,
                            binding: false,
                        },
                    );
                }
                for &local in bindings {
                    // The slot exists, but is not an owner until initialized.
                    self.set(
                        local,
                        LocalState {
                            protected: false,
                            binding: true,
                        },
                    );
                }
                self.visit(body);
            }
            Expr::Let(local, value, body) => {
                self.visit(value);
                self.bind(*local, self.covered(value));
                self.visit(body);
            }
            Expr::Match(value, arms) => {
                self.visit(value);
                let covered = self.covered(value);
                for (pattern, body) in arms {
                    self.pattern(pattern, covered);
                    self.visit(body);
                    self.restore(mark);
                }
            }
            Expr::Trace(_, body)
            | Expr::Field(body, _)
            | Expr::Dup(_, body)
            | Expr::Drop(_, body)
            | Expr::BorrowGlobal(_, _, body) => self.visit(body),
            Expr::Call(_, args) | Expr::Record(args) | Expr::Construct(_, args) => {
                for arg in args {
                    self.visit(arg);
                }
            }
            Expr::Apply(function, args) => {
                self.visit(function);
                for arg in args {
                    self.visit(arg);
                }
            }
            Expr::SetFields(base, fields) => {
                self.visit(base);
                for (_, value) in fields {
                    self.visit(value);
                }
            }
            Expr::Local(_) | Expr::Const(_) | Expr::Func(_) => {}
        }
        self.restore(mark);
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
    locals: usize,
    arity: u32,
) -> HashMap<*const Expr, HashSet<Local>> {
    if !fresh_bindings(root, &mut (0..arity).collect()) {
        return HashMap::new();
    }
    let mut scan = Scan {
        locals: vec![LocalState::default(); locals],
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
        let mut result: Vec<_> = parameters(body, 16, 2).into_values().flatten().collect();
        result.sort_unstable();
        result
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
        let original = parameters(&body, 16, 2);
        let copied = parameters(&clone, 16, 2);
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
