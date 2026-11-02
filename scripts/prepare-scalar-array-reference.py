#!/usr/bin/env python3
"""Prepare a same-source compiler with only scalar-capture selection disabled."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
CANDIDATE = '''            && (captures == 0
                || function.locals[..captures]
                    .iter()
                    .any(|ty| crate::rc::needs_rc(&self.g.prog.shapes, ty))
                || function.locals[..captures]
                    .iter()
                    .all(|ty| scalar(ty).is_some()))'''
REFERENCE = '''            && (captures == 0
                || function.locals[..captures]
                    .iter()
                    .any(|ty| crate::rc::needs_rc(&self.g.prog.shapes, ty)))'''


def reference_source(candidate):
    assert candidate.count(CANDIDATE) == 1 and REFERENCE not in candidate
    return candidate.replace(CANDIDATE, REFERENCE)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--stage', choices=('prepare', 'verify'), required=True)
    parser.add_argument('--checkout', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    checkout, output = args.checkout.resolve(), args.output.resolve()
    assert checkout != ROOT
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    candidate = (ROOT / 'src/cgen.rs').read_text()
    reference = reference_source(candidate)
    if args.stage == 'prepare':
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        assert (checkout / 'src/cgen.rs').read_text() == candidate
        output.mkdir(parents=True, exist_ok=False)
        (checkout / 'src/cgen.rs').write_text(reference)
    assert (checkout / 'src/cgen.rs').read_text() == reference
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed.splitlines() == ['src/cgen.rs']
    patch = subprocess.check_output(['git', 'diff', 'HEAD', '--', 'src/cgen.rs'], cwd=checkout)
    ownership = (ROOT / 'src/ownership.rs').read_bytes()
    assert (checkout / 'src/ownership.rs').read_bytes() == ownership
    manifest = dict(source=source, disabledTransformation='direct scalar array captures',
        candidateCodegenSha256=digest(candidate.encode()), referenceCodegenSha256=digest(reference.encode()),
        ownershipSha256=digest(ownership), patchSha256=digest(patch))
    if args.stage == 'verify':
        assert json.loads((output / 'manifest.json').read_text()) == manifest
        assert (output / 'codegen-reference.rs').read_text() == reference
        assert (output / 'reference.patch').read_bytes() == patch
        manifest['compilerSha256'] = digest((output / 'fwp').read_bytes())
    else:
        (output / 'codegen-reference.rs').write_text(reference)
        (output / 'reference.patch').write_bytes(patch)
    (output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
