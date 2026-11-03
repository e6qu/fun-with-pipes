#!/usr/bin/env python3
"""Build a same-source reference that disables only direct closed scalar array map callbacks."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
CANDIDATE = '        if matches!(&self.g.prog.funcs[id].body, Body::Prim(s) if s == "array.map") {\n'
REFERENCE = '        if false && matches!(&self.g.prog.funcs[id].body, Body::Prim(s) if s == "array.map") {\n'


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
    current = (ROOT / 'src/cgen.rs').read_text()
    expected = reference_source(current)
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        assert (checkout / 'src/cgen.rs').read_text() == current
        args.output.mkdir(parents=True, exist_ok=False)
        (checkout / 'src/cgen.rs').write_text(expected)
    assert (checkout / 'src/cgen.rs').read_text() == expected
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed == 'src/cgen.rs\n', changed
    patch = subprocess.check_output(['git', 'diff', 'HEAD', '--', 'src/cgen.rs'], cwd=checkout)
    ownership = (ROOT / 'src/ownership.rs').read_bytes()
    assert (checkout / 'src/ownership.rs').read_bytes() == ownership
    manifest = dict(source=source, disabledTransformation='direct closed scalar array map callbacks',
                    candidateCodegenSha256=digest(current.encode()),
                    referenceCodegenSha256=digest(expected.encode()),
                    ownershipSha256=digest(ownership), patchSha256=digest(patch))
    (args.output / 'codegen-reference.rs').write_text(expected)
    (args.output / 'reference.patch').write_bytes(patch)
    if args.verify:
        previous = json.loads((args.output / 'manifest.json').read_text())
        assert previous == manifest
        manifest['compilerSha256'] = digest((args.output / 'fwp').read_bytes())
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
