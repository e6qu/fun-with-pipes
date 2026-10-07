//! Ownership at native primitive boundaries. Unknown primitives, foreign
//! calls and remote calls keep the conservative runtime-sharing fallback.
//! These contracts describe outer container ownership; stored elements and
//! callback results still use runtime sharing, not typed element destruction.

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Argument {
    /// Borrow for this call, without sharing the outer value.
    Borrow,
    /// Transfer one owned reference to the runtime wrapper.
    Consume,
    /// Borrow, but promote to runtime sharing because the value may escape.
    Share,
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum ResultOwnership {
    Shared,
    FreshContainer,
    /// The wrapper consumes the indicated argument on every path. It may
    /// reuse that container or return a copy; array.set wraps it in Option.
    OwnedContainer {
        argument: usize,
        runtime: &'static str,
        wrapped: bool,
    },
}

#[derive(Clone, Copy, Debug)]
pub struct Contract {
    pub arguments: &'static [Argument],
    pub result: ResultOwnership,
    pub callback: Option<usize>,
    /// Arguments whose values/elements may be reachable from the result.
    /// Callback entries include values captured by the callback.
    pub aliases: &'static [usize],
}

impl Contract {
    pub fn argument(self, index: usize) -> Argument {
        self.arguments
            .get(index)
            .copied()
            .unwrap_or(Argument::Share)
    }
}

/// The complete array/map/set boundary inventory. Comparison-only keys
/// borrow; inserted keys and values share. Callbacks retain the existing
/// shared-input/result convention. Slices and set operations copy storage.
pub fn primitive(symbol: &str) -> Option<Contract> {
    use Argument::{Borrow as B, Consume as C, Share as S};
    use ResultOwnership::{FreshContainer as F, OwnedContainer as O, Shared as R};
    let (arguments, result, callback, aliases): (
        &'static [Argument],
        ResultOwnership,
        Option<usize>,
        &'static [usize],
    ) = match symbol {
        "array.from-list" | "map.from-list" | "set.from-list" => (&[S], F, None, &[0]),
        "array.to-list" | "map.keys" | "map.values" | "map.to-list" | "set.to-list" => {
            (&[B], R, None, &[0])
        }
        "array.length" | "map.size" | "set.size" => (&[B], R, None, &[]),
        "array.get" => (&[B, B], R, None, &[1]),
        "array.set" => (
            &[B, S, C],
            O {
                argument: 2,
                runtime: "array_set",
                wrapped: true,
            },
            None,
            &[1, 2],
        ),
        "array.push" => (
            &[S, C],
            O {
                argument: 1,
                runtime: "array_push",
                wrapped: false,
            },
            None,
            &[0, 1],
        ),
        "array.make" => (&[B, S], F, None, &[1]),
        "array.generate" => (&[B, S], F, Some(1), &[1]),
        "array.map" | "map.map-values" => (&[S, B], F, Some(0), &[0, 1]),
        "array.fold" => (&[S, S, B], R, Some(0), &[0, 1, 2]),
        "array.slice" => (&[B, B, B], F, None, &[2]),
        "array.append" | "set.union" | "set.intersect" | "set.diff" => (&[B, B], F, None, &[0, 1]),
        "array.sort" => (&[B], F, None, &[0]),
        "map.empty" | "set.empty" => (&[], R, None, &[]),
        "map.insert" => (
            &[S, S, C],
            O {
                argument: 2,
                runtime: "map_insert",
                wrapped: false,
            },
            None,
            &[0, 1, 2],
        ),
        "map.get" => (&[B, B], R, None, &[1]),
        "map.contains" | "set.contains" => (&[B, B], R, None, &[]),
        "map.remove" | "set.remove" => (
            &[B, C],
            O {
                argument: 1,
                runtime: "map_remove",
                wrapped: false,
            },
            None,
            &[1],
        ),
        "map.update" => (
            &[S, S, S, C],
            O {
                argument: 3,
                runtime: "map_update",
                wrapped: false,
            },
            Some(1),
            &[0, 1, 2, 3],
        ),
        "set.insert" => (
            &[S, C],
            O {
                argument: 1,
                runtime: "set_insert",
                wrapped: false,
            },
            None,
            &[0, 1],
        ),
        _ => return None,
    };
    Some(Contract {
        arguments,
        result,
        callback,
        aliases,
    })
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn every_container_boundary_has_a_consistent_contract() {
        let library = include_str!("../lib/collections.fwp");
        for line in library.lines() {
            let Some(declaration) = line.strip_prefix("foreign \"fwp\" ") else {
                continue;
            };
            let symbol = declaration.split_whitespace().next().unwrap();
            if !["array.", "map.", "set."]
                .iter()
                .any(|p| symbol.starts_with(p))
            {
                continue;
            }
            let c = primitive(symbol).unwrap_or_else(|| panic!("missing contract: {symbol}"));
            assert!(c.aliases.iter().all(|i| *i < c.arguments.len()), "{symbol}");
            if let Some(i) = c.callback {
                assert_eq!(c.argument(i), Argument::Share, "{symbol}");
            }
            let consumed: Vec<_> = c
                .arguments
                .iter()
                .enumerate()
                .filter_map(|(i, a)| (*a == Argument::Consume).then_some(i))
                .collect();
            match c.result {
                ResultOwnership::OwnedContainer { argument, .. } => {
                    assert_eq!(consumed, vec![argument], "{symbol}")
                }
                _ => assert!(consumed.is_empty(), "{symbol}"),
            }
        }
        assert!(primitive("unknown").is_none());
    }
}
