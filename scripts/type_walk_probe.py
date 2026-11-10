#!/usr/bin/env python3
"""Count Type clones in a separate diagnostic checkout, never in shipped fwp."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess


ROOT = Path(__file__).resolve().parent.parent
FILES = ('src/types.rs', 'src/compile_profile.rs')
PROBE = '''
pub(crate) mod clone_probe {
    std::thread_local! {
        static COUNTS: std::cell::Cell<[u64; 7]> = const { std::cell::Cell::new([0; 7]) };
    }

    pub(super) struct Scope(usize);

    impl Scope {
        pub(super) fn enter(kind: usize) -> Self {
            COUNTS.with(|state| {
                let mut counts = state.get();
                counts[3 + kind] = counts[3 + kind].checked_add(1).unwrap();
                counts[5 + kind] = counts[5 + kind].checked_add(1).unwrap();
                state.set(counts);
            });
            Self(kind)
        }
    }

    impl Drop for Scope {
        fn drop(&mut self) {
            COUNTS.with(|state| {
                let mut counts = state.get();
                counts[5 + self.0] = counts[5 + self.0].checked_sub(1).unwrap();
                state.set(counts);
            });
        }
    }

    pub(super) fn cloned() {
        COUNTS.with(|state| {
            let mut counts = state.get();
            counts[0] = counts[0].checked_add(1).unwrap();
            for kind in 0..2 {
                if counts[5 + kind] != 0 {
                    counts[1 + kind] = counts[1 + kind].checked_add(1).unwrap();
                }
            }
            state.set(counts);
        });
    }

    pub(crate) fn reset() {
        COUNTS.with(|state| state.set([0; 7]));
    }

    pub(crate) fn report() -> crate::json::Json {
        let counts = COUNTS.with(|state| state.get());
        assert_eq!(&counts[5..], &[0, 0]);
        crate::json::Json::Obj([
            "type_clones", "free_vars_clones", "zonk_clones", "free_vars_visits", "zonk_visits",
        ].into_iter().zip(counts).map(|(name, value)| {
            (name.into(), crate::json::Json::Num(value.to_string()))
        }).collect())
    }
}

impl Clone for Type {
    fn clone(&self) -> Self {
        clone_probe::cloned();
        match self {
            Self::Var(v) => Self::Var(*v),
            Self::Con(name, args) => Self::Con(name.clone(), args.clone()),
            Self::App(head, args) => Self::App(head.clone(), args.clone()),
            Self::Fun(input, output, effects) => Self::Fun(input.clone(), output.clone(), effects.clone()),
            Self::Record(row) => Self::Record(row.clone()),
            Self::Nat(n) => Self::Nat(*n),
            Self::NatOp(op, left, right) => Self::NatOp(*op, left.clone(), right.clone()),
        }
    }
}
'''


def instrument(sources):
    assert set(sources) == set(FILES)
    result = dict(sources)
    edits = {
        'src/types.rs': (
            ('#[derive(Clone, Debug, PartialEq)]\npub enum Type {', '#[derive(Debug, PartialEq)]\npub enum Type {'),
            ('\n#[derive(Clone, Debug, PartialEq, Default)]\npub struct Row', PROBE+'\n#[derive(Clone, Debug, PartialEq, Default)]\npub struct Row'),
            ('    pub fn free_vars(&self, t: &Type, out: &mut Vec<TV>) {\n',
             '    pub fn free_vars(&self, t: &Type, out: &mut Vec<TV>) {\n        let _clone_scope = clone_probe::Scope::enter(0);\n'),
            ('    pub fn zonk(&self, t: &Type) -> Type {\n',
             '    pub fn zonk(&self, t: &Type) -> Type {\n        let _clone_scope = clone_probe::Scope::enter(1);\n'),
        ),
        'src/compile_profile.rs': (
            ('    let activation = Activation;\n', '    crate::types::clone_probe::reset();\n    let activation = Activation;\n'),
            ('    let result = Json::Obj(vec![\n', '    let result = Json::Obj(vec![\n        ("type_walk_counts".into(), crate::types::clone_probe::report()),\n'),
        ),
    }
    for name, replacements in edits.items():
        for original, observed in replacements:
            assert result[name].count(original) == 1, (name, original)
            result[name] = result[name].replace(original, observed)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    stage = parser.add_mutually_exclusive_group(required=True)
    stage.add_argument('--checkout', type=Path)
    stage.add_argument('--verify', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    checkout = (args.checkout or args.verify).resolve()
    assert checkout != ROOT, 'instrument a separate checkout'
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    original = {name: (ROOT/name).read_text() for name in FILES}
    observed = instrument(original)
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        args.output.mkdir(parents=True, exist_ok=False)
        for name, text in observed.items():
            (checkout/name).write_text(text)
    assert all((checkout/name).read_text() == text for name, text in observed.items())
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed.splitlines() == sorted(FILES), changed
    patch = subprocess.check_output(['git', 'diff', 'HEAD'], cwd=checkout)
    manifest = dict(source=source, scope='Type clone nodes on the compilation worker; not allocation bytes or timings',
        original={name: hashlib.sha256(text.encode()).hexdigest() for name, text in original.items()},
        observed={name: hashlib.sha256(text.encode()).hexdigest() for name, text in observed.items()},
        patchSha256=hashlib.sha256(patch).hexdigest())
    if args.verify:
        assert json.loads((args.output/'manifest.json').read_text()) == manifest
        assert (args.output/'observer.patch').read_bytes() == patch
    else:
        (args.output/'manifest.json').write_text(json.dumps(manifest, indent=2)+'\n')
        (args.output/'observer.patch').write_bytes(patch)


if __name__ == '__main__':
    main()
