#!/usr/bin/env python3
"""Prepare a same-source reference that disables only F64 identity array-map elimination."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
CANDIDATE = '        if callee.arity == 2 && matches!(&callee.body, Body::Prim(symbol) if symbol == "array.map")\n'
REFERENCE = '        if false && callee.arity == 2 && matches!(&callee.body, Body::Prim(symbol) if symbol == "array.map")\n'


def reference_source(current):
    assert current.count(CANDIDATE) == 1 and REFERENCE not in current
    return current.replace(CANDIDATE, REFERENCE)


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
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
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
    unchanged = {}
    for path in ('src/interp.rs', 'runtime/fwp_rt_num.c', 'src/cgen.rs'):
        data = (ROOT / path).read_bytes()
        assert (checkout / path).read_bytes() == data, path
        unchanged[path] = digest(data)
    manifest = dict(unchanged=unchanged, source=source, disabledTransformation='F64 identity array-map elimination',
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
