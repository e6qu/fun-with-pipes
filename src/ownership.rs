//! Ownership at native primitive boundaries. Unknown primitives, foreign
//! calls and remote calls keep the conservative runtime-sharing fallback.
//! Contracts cover containers, text/byte results and synchronous list callbacks.
//! Stored container elements and retained callbacks still use runtime sharing.

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
    /// One new record/variant allocation with typed borrowed field aliases.
    FreshOuter,
    /// A callback-produced owned value, or the unchanged empty-fold input.
    OwnedAccumulator {
        argument: usize,
        runtime: &'static str,
    },
    /// New owned list nodes containing already-owned callback results.
    FreshSpine,
    /// New list nodes alias borrowed elements; an optional suffix aliases
    /// the specified argument and requires one additional tail reference.
    CopiedSpine {
        runtime: &'static str,
        tail: Option<usize>,
    },
    /// One owned reference to a borrowed list suffix.
    AliasTail {
        argument: usize,
    },
    FreshLeaf,
    /// A tree of new counted allocations: no input aliases or internal sharing.
    FreshTree,
    /// An owned reference to the indicated argument's leaf allocation.
    AliasLeaf {
        argument: usize,
    },
    /// A copy, or the unchanged leaf argument on a no-op path.
    FreshOrAliasLeaf {
        argument: usize,
    },
    /// The wrapper consumes the indicated argument on every path. It may
    /// reuse that container or return a copy; array.set wraps it in Option.
    OwnedContainer {
        argument: usize,
        runtime: &'static str,
        wrapped: bool,
    },
}

#[derive(Clone, Copy, Debug, PartialEq, Eq)]
pub enum Callback {
    Shared(usize),
    /// Invoke synchronously without retaining the callback function itself.
    /// Supplied values borrow by type; returned values carry ownership.
    Borrowed(usize),
}

#[derive(Clone, Copy, Debug)]
pub struct Contract {
    pub arguments: &'static [Argument],
    pub result: ResultOwnership,
    pub callback: Option<Callback>,
    /// Arguments whose values/elements may be reachable from the result.
    /// Callback entries include values captured by the callback.
    pub aliases: &'static [usize],
}

impl Contract {
    /// Only proven synchronous callbacks may borrow without runtime sharing.
    /// Borrowing alone does not establish that an argument cannot escape.
    pub fn borrows_callback(self) -> bool {
        matches!(self.callback, Some(Callback::Borrowed(_)))
    }

    pub fn callback_argument(self) -> Option<usize> {
        self.callback.map(|c| match c {
            Callback::Shared(i) | Callback::Borrowed(i) => i,
        })
    }

    pub fn argument(self, index: usize) -> Argument {
        self.arguments
            .get(index)
            .copied()
            .unwrap_or(Argument::Share)
    }
}

/// Complete array/map/set contracts and selected String/Bytes contracts. Comparison-only keys
/// borrow; inserted keys and values share. Synchronous list callbacks borrow;
/// retained callbacks share. Slices and set operations copy storage.
pub fn primitive(symbol: &str) -> Option<Contract> {
    use Argument::{Borrow as B, Consume as C, Share as S};
    use ResultOwnership::{FreshContainer as F, OwnedContainer as O, Shared as R};
    let (arguments, result, callback, aliases): (
        &'static [Argument],
        ResultOwnership,
        Option<Callback>,
        &'static [usize],
    ) = match symbol {
        "trim" | "trim-start" | "trim-end" | "lower" | "upper" | "string.reverse" => {
            (&[B], ResultOwnership::FreshLeaf, None, &[])
        }
        "concat" | "bytes.append" | "string.repeat" | "bytes.from-list" => {
            let args: &'static [Argument] = if symbol == "bytes.from-list" {
                &[B]
            } else {
                &[B, B]
            };
            (args, ResultOwnership::FreshLeaf, None, &[])
        }
        "string.slice" | "bytes.slice" => (&[B, B, B], ResultOwnership::FreshLeaf, None, &[]),
        "join" | "format" => (&[B, B], ResultOwnership::FreshLeaf, None, &[]),
        "show" => (&[B], ResultOwnership::FreshLeaf, None, &[]),
        "string.chars"
        | "lines"
        | "words"
        | "string.codepoints"
        | "string.from-codepoints"
        | "string.from-bytes"
        | "bytes.to-list" => (&[B], ResultOwnership::FreshTree, None, &[]),
        "split" | "string.split-once" | "string.find" | "bytes.find" | "bytes.get" => {
            (&[B, B], ResultOwnership::FreshTree, None, &[])
        }
        "map" => (
            &[B, B],
            ResultOwnership::FreshSpine,
            Some(Callback::Borrowed(0)),
            &[0, 1],
        ),
        "zip-with" => (
            &[B, B, B],
            ResultOwnership::FreshSpine,
            Some(Callback::Borrowed(0)),
            &[0, 1, 2],
        ),
        "fold-right" => (
            &[B, C, B],
            ResultOwnership::OwnedAccumulator {
                argument: 1,
                runtime: "fold_right",
            },
            Some(Callback::Borrowed(0)),
            &[0, 1, 2],
        ),
        "fold" => (
            &[B, C, B],
            ResultOwnership::OwnedAccumulator {
                argument: 1,
                runtime: "fold",
            },
            Some(Callback::Borrowed(0)),
            &[0, 1, 2],
        ),
        "filter" => (
            &[B, B],
            ResultOwnership::FreshSpine,
            Some(Callback::Borrowed(0)),
            &[1],
        ),
        "take-while" => (
            &[B, B],
            ResultOwnership::FreshSpine,
            Some(Callback::Borrowed(0)),
            &[1],
        ),
        "drop-while" => (
            &[B, B],
            ResultOwnership::AliasTail { argument: 1 },
            Some(Callback::Borrowed(0)),
            &[1],
        ),
        "sort-by" => (
            &[B, B],
            ResultOwnership::CopiedSpine {
                runtime: "sort_by",
                tail: None,
            },
            Some(Callback::Borrowed(0)),
            &[1],
        ),
        "sort" | "unique" => (
            &[B],
            ResultOwnership::CopiedSpine {
                runtime: if symbol == "sort" { "sort" } else { "unique" },
                tail: None,
            },
            None,
            &[0],
        ),
        "reverse" | "flatten" => (
            &[B],
            ResultOwnership::CopiedSpine {
                runtime: if symbol == "reverse" {
                    "reverse"
                } else {
                    "flatten"
                },
                tail: None,
            },
            None,
            &[0],
        ),
        "take" => (
            &[B, B],
            ResultOwnership::CopiedSpine {
                runtime: "take",
                tail: None,
            },
            None,
            &[1],
        ),
        "append" => (
            &[B, B],
            ResultOwnership::CopiedSpine {
                runtime: "append",
                tail: Some(0),
            },
            None,
            &[0, 1],
        ),
        "drop" => (
            &[B, B],
            ResultOwnership::AliasTail { argument: 1 },
            None,
            &[1],
        ),
        "nth" => (&[B, B], ResultOwnership::FreshOuter, None, &[1]),
        "index-of" => (&[B, B], ResultOwnership::FreshOuter, None, &[]),
        "find" => (
            &[B, B],
            ResultOwnership::FreshOuter,
            Some(Callback::Borrowed(0)),
            &[1],
        ),
        "parse-int" | "parse-float" | "length" => (&[B], R, None, &[]),
        "string.to-bytes" => (&[B], ResultOwnership::AliasLeaf { argument: 0 }, None, &[0]),
        "pad-left" | "pad-right" | "replace" => (
            &[B, B, B],
            ResultOwnership::FreshOrAliasLeaf { argument: 2 },
            None,
            &[2],
        ),
        "string.length" | "string.byte-length" | "bytes.length" | "print" | "write" | "eprint"
        | "ewrite" => (&[B], R, None, &[]),
        "string.contains" | "starts-with" | "ends-with" | "eq" | "ne" | "lt" | "le" | "gt"
        | "ge" | "compare" => (&[B, B], R, None, &[]),
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
        "array.generate" => (&[B, S], F, Some(Callback::Shared(1)), &[1]),
        "array.map" | "map.map-values" => (&[S, B], F, Some(Callback::Shared(0)), &[0, 1]),
        "array.fold" => (&[S, S, B], R, Some(Callback::Shared(0)), &[0, 1, 2]),
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
            Some(Callback::Shared(1)),
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
    fn declared_collection_and_text_boundaries_have_consistent_contracts() {
        for (library, collections) in [
            (include_str!("../lib/collections.fwp"), true),
            (include_str!("../lib/string.fwp"), false),
        ] {
            for line in library.lines() {
                let Some(declaration) = line.strip_prefix("foreign \"fwp\" ") else {
                    continue;
                };
                let symbol = declaration.split_whitespace().next().unwrap();
                if collections
                    && !["array.", "map.", "set.", "bytes."]
                        .iter()
                        .any(|p| symbol.starts_with(p))
                {
                    continue;
                }
                let c = primitive(symbol).unwrap_or_else(|| panic!("missing contract: {symbol}"));
                assert!(c.aliases.iter().all(|i| *i < c.arguments.len()), "{symbol}");
                if let Some(i) = c.callback_argument() {
                    assert_eq!(
                        c.argument(i),
                        if c.borrows_callback() {
                            Argument::Borrow
                        } else {
                            Argument::Share
                        },
                        "{symbol}"
                    );
                }
                let consumed: Vec<_> = c
                    .arguments
                    .iter()
                    .enumerate()
                    .filter_map(|(i, a)| (*a == Argument::Consume).then_some(i))
                    .collect();
                match c.result {
                    ResultOwnership::OwnedContainer { argument, .. }
                    | ResultOwnership::OwnedAccumulator { argument, .. } => {
                        assert_eq!(consumed, vec![argument], "{symbol}")
                    }
                    ResultOwnership::AliasTail { argument }
                    | ResultOwnership::AliasLeaf { argument }
                    | ResultOwnership::FreshOrAliasLeaf { argument } => {
                        assert!(consumed.is_empty(), "{symbol}");
                        assert_eq!(c.argument(argument), Argument::Borrow, "{symbol}");
                        assert!(c.aliases.contains(&argument), "{symbol}");
                    }
                    ResultOwnership::FreshTree => {
                        assert!(
                            consumed.is_empty() && c.aliases.is_empty() && c.callback.is_none(),
                            "{symbol}"
                        );
                    }
                    _ => assert!(consumed.is_empty(), "{symbol}"),
                }
            }
        }
        let lists = include_str!("../lib/list.fwp");
        for symbol in [
            "map",
            "filter",
            "take-while",
            "drop-while",
            "find",
            "sort-by",
        ] {
            assert!(lists
                .lines()
                .any(|line| line.starts_with(&format!("foreign \"fwp\" {symbol} :"))));
            let contract = primitive(symbol).unwrap();
            assert!(contract.borrows_callback());
            assert_eq!(contract.callback, Some(Callback::Borrowed(0)));
            assert_eq!(contract.arguments, &[Argument::Borrow, Argument::Borrow]);
        }
        for symbol in [
            "reverse", "take", "append", "flatten", "drop", "nth", "index-of", "sort", "unique",
        ] {
            assert!(lists
                .lines()
                .any(|line| line.starts_with(&format!("foreign \"fwp\" {symbol} :"))));
            let c = primitive(symbol).unwrap();
            assert!(c.arguments.iter().all(|a| *a == Argument::Borrow));
            assert!(c.callback.is_none());
            assert!(c.aliases.iter().all(|i| *i < c.arguments.len()));
            if let ResultOwnership::CopiedSpine {
                tail: Some(argument),
                ..
            }
            | ResultOwnership::AliasTail { argument } = c.result
            {
                assert!(c.aliases.contains(&argument), "{symbol}");
                assert_eq!(c.argument(argument), Argument::Borrow);
            }
        }
        assert!(!primitive("array.map").unwrap().borrows_callback());
        assert!(primitive("unknown").is_none());
    }
}
