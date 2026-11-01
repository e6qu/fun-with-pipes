#!/usr/bin/env python3
"""Build a same-source reference that disables only flat-record zip/map fusion."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
CANDIDATE = '''fn zip_map_element(shapes: &Shapes, ty: &MT) -> bool {
    unboxed_numeric(ty)
        || record_fields(shapes, ty).is_some_and(|fields| {
            !fields.is_empty() && fields.iter().all(|(_, field)| unboxed_numeric(field))
        })
}
'''
REFERENCE = '''fn zip_map_element(_shapes: &Shapes, ty: &MT) -> bool {
    unboxed_numeric(ty)
}
'''


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
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    current = (ROOT / 'src/fuse.rs').read_text()
    expected = reference_source(current)
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        assert (checkout / 'src/fuse.rs').read_text() == current
        args.output.mkdir(parents=True, exist_ok=False)
        (checkout / 'src/fuse.rs').write_text(expected)
    assert (checkout / 'src/fuse.rs').read_text() == expected
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed == 'src/fuse.rs\n', changed
    patch = subprocess.check_output(['git', 'diff', 'HEAD', '--', 'src/fuse.rs'], cwd=checkout)
    ownership = (ROOT / 'src/ownership.rs').read_bytes()
    assert (checkout / 'src/ownership.rs').read_bytes() == ownership
    manifest = dict(source=source, disabledTransformation='flat numeric record zip/map fusion',
                    candidateFusionSha256=digest(current.encode()),
                    referenceFusionSha256=digest(expected.encode()),
                    ownershipSha256=digest(ownership), patchSha256=digest(patch))
    (args.output / 'fusion-reference.rs').write_text(expected)
    (args.output / 'reference.patch').write_bytes(patch)
    if args.verify:
        previous = json.loads((args.output / 'manifest.json').read_text())
        assert previous == manifest
        manifest['compilerSha256'] = digest((args.output / 'fwp').read_bytes())
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
