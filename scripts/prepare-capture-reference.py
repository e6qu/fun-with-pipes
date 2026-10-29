#!/usr/bin/env python3
"""Build a same-source measurement reference with the eager-capture change removed."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent

ORIGINAL_METHOD = """    /// The arguments of a partial application that are constants
    /// (`Func` of arity 0, whose evaluation may trap) become locals bound
    /// in `out`, in evaluation order.
    fn hoist_constants(&mut self, e: Expr, out: &mut Vec<(Local, Expr)>) -> Expr {
        match e {
            Expr::Apply(f, args) => {
                let args = args
                    .into_iter()
                    .map(|a| match a {
                        Expr::Func(id) if self.arity(id) == 0 => {
                            let l = self.fresh(&self.funcs[id].ty);
                            out.push((l, Expr::Func(id)));
                            Expr::Local(l)
                        }
                        a @ Expr::Apply(..) => self.hoist_constants(a, out),
                        a => a,
                    })
                    .collect();
                Expr::Apply(f, args)
            }
            e => e,
        }
    }

"""

ORIGINAL_BINDING = """                // a partial application used once: substituted, so that
                // applying it becomes a direct call
                if matches!(v, Expr::Apply(..)) && uses(&b, l) == 1 {
                    // constants it captures are evaluated here, first
                    let mut consts = Vec::new();
                    let v = if self.pure(&v) || applied_first(&b, l) {
                        v
                    } else {
                        self.hoist_constants(v, &mut consts)
                    };
                    if self.pure(&v) || applied_first(&b, l) {
                        let mut s: Vec<Option<Expr>> = vec![None; self.nlocals()];
                        s[l as usize] = Some(v);
                        let mut out = self.expr(substitute(&b, &s), depth);
                        for (c, e) in consts.into_iter().rev() {
                            out = Expr::Let(c, Box::new(e), Box::new(out));
                        }
                        return out;
                    }
                    let mut out = Expr::Let(l, Box::new(v), Box::new(self.expr(*b, depth)));
                    for (c, e) in consts.into_iter().rev() {
                        out = Expr::Let(c, Box::new(e), Box::new(out));
                    }
                    return out;
                }
"""

CANDIDATE_BINDING = """                // A once-used known closure can expose a direct call. Keep
                // eager capture computations at this binding, in their original
                // order, rather than moving them to the closure's later use.
                if matches!(v, Expr::Apply(..)) && uses(&b, l) == 1 {
                    let mut captures = Vec::new();
                    let v = if self.pure(&v) || applied_first(&b, l) {
                        v
                    } else {
                        let count = self.nlocals();
                        let known_partial = matches!(&v, Expr::Apply(f, args)
                            if matches!(&**f, Expr::Func(id) if args.len() < self.arity(*id)));
                        let normalized = if known_partial {
                            bind_captures(
                                &v,
                                None,
                                self.funcs,
                                self.shapes,
                                &mut self.locals,
                                &mut captures,
                            )
                        } else {
                            None
                        };
                        let Some(normalized) = normalized.filter(|e| self.pure(e)) else {
                            // No partial hoist on rejection: an earlier capture
                            // may fail before a later constant is evaluated.
                            self.locals.truncate(count);
                            return Expr::Let(l, Box::new(v), Box::new(self.expr(*b, depth)));
                        };
                        normalized
                    };
                    let mut s: Vec<Option<Expr>> = vec![None; self.nlocals()];
                    s[l as usize] = Some(v);
                    let mut out = self.expr(substitute(&b, &s), depth);
                    for (capture, value) in captures.into_iter().rev() {
                        out = Expr::Let(capture, Box::new(value), Box::new(out));
                    }
                    return out;
                }
"""


def reference_source(current):
    assert current.count(CANDIDATE_BINDING) == 1
    assert 'fn hoist_constants(' not in current
    assert current.count('    fn fresh(') == 1
    return current.replace(CANDIDATE_BINDING, ORIGINAL_BINDING).replace(
        '    fn fresh(', ORIGINAL_METHOD + '    fn fresh(')


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    stage = parser.add_mutually_exclusive_group(required=True)
    stage.add_argument('--checkout', type=Path)
    stage.add_argument('--verify', type=Path)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    checkout = (args.checkout or args.verify).resolve()
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    current = (ROOT / 'src/opt.rs').read_text()
    expected = reference_source(current)
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        assert (checkout / 'src/opt.rs').read_text() == current
        args.output.mkdir(parents=True, exist_ok=False)
        (checkout / 'src/opt.rs').write_text(expected)
    assert (checkout / 'src/opt.rs').read_text() == expected
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed == 'src/opt.rs\n', changed
    patch = subprocess.check_output(['git', 'diff', 'HEAD', '--', 'src/opt.rs'], cwd=checkout)
    ownership = (ROOT / 'src/ownership.rs').read_bytes()
    assert (checkout / 'src/ownership.rs').read_bytes() == ownership
    manifest = dict(source=source, disabledTransformation='once-used eager capture bindings',
                    candidateOptimizerSha256=digest(current.encode()),
                    referenceOptimizerSha256=digest(expected.encode()),
                    ownershipSha256=digest(ownership), patchSha256=digest(patch))
    (args.output / 'optimizer-reference.rs').write_text(expected)
    (args.output / 'reference.patch').write_bytes(patch)
    if args.verify:
        previous = json.loads((args.output / 'manifest.json').read_text())
        assert previous == manifest
        manifest['compilerSha256'] = digest((args.output / 'fwp').read_bytes())
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
