#!/usr/bin/env python3
"""Prepare and verify a same-source compiler with only scalar recording disabled."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
FACT = '    if symbol == "ad.push" && index == 0 {\n        return true;\n    }'
DISABLED = FACT.replace('return true;', 'return false;')


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
    current = (ROOT / 'src/ownership.rs').read_text()
    assert current.count(FACT) == 1
    expected = current.replace(FACT, DISABLED)
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        assert (checkout / 'src/ownership.rs').read_text() == current
        args.output.mkdir(parents=True, exist_ok=False)
        (checkout / 'src/ownership.rs').write_text(expected)
    assert (checkout / 'src/ownership.rs').read_text() == expected
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed == 'src/ownership.rs\n', changed
    patch = subprocess.check_output(['git', 'diff', 'HEAD', '--', 'src/ownership.rs'], cwd=checkout)
    manifest = dict(source=source, disabledFact='borrows_without_escape(ad.push, 0)',
                    candidateOwnershipSha256=digest(current.encode()),
                    referenceOwnershipSha256=digest(expected.encode()), patchSha256=digest(patch))
    (args.output / 'ownership-reference.rs').write_text(expected)
    (args.output / 'reference.patch').write_bytes(patch)
    if args.verify:
        previous = json.loads((args.output / 'manifest.json').read_text())
        assert previous == manifest
        manifest['compilerSha256'] = digest((args.output / 'fwp').read_bytes())
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
