#!/usr/bin/env python3
"""Undo the whole gradient-array change in a same-source measurement checkout."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent
PATCH = ROOT / 'scripts/gradient-array-candidate.patch'
FILES = ('lib/autodiff.fwp', 'runtime/fwp_rt_kernel.c', 'src/cgen.rs',
         'src/fuse.rs', 'src/interp.rs', 'src/ir.rs', 'src/numerics.rs')


def digest(data):
    return hashlib.sha256(data).hexdigest()


def reference_sources(current):
    assert set(current) == set(FILES)
    with tempfile.TemporaryDirectory(prefix='fwp-gradient-reference-') as directory:
        root = Path(directory)
        for name, data in current.items():
            target = root / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
        result = subprocess.run(['git', 'apply', '--reverse', '--check', str(PATCH)],
                                cwd=root, capture_output=True)
        assert result.returncode == 0, result.stderr.decode()
        subprocess.run(['git', 'apply', '--reverse', str(PATCH)], cwd=root, check=True)
        restored = {name: (root / name).read_bytes() for name in FILES}
        assert all(restored[name] != current[name] for name in FILES)
        subprocess.run(['git', 'apply', str(PATCH)], cwd=root, check=True)
        assert all((root / name).read_bytes() == current[name] for name in FILES)
        return restored


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
    current = {name: (ROOT / name).read_bytes() for name in FILES}
    expected = reference_sources(current)
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        args.output.mkdir(parents=True, exist_ok=False)
        for name, data in expected.items():
            assert (checkout / name).read_bytes() == current[name]
            (checkout / name).write_bytes(data)
    assert all((checkout / name).read_bytes() == data for name, data in expected.items())
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed.splitlines() == sorted(FILES), changed
    patch = subprocess.check_output(['git', 'diff', 'HEAD'], cwd=checkout)
    ownership = (ROOT / 'src/ownership.rs').read_bytes()
    assert (checkout / 'src/ownership.rs').read_bytes() == ownership
    manifest = dict(source=source, disabledTransformation='owned gradient arrays and direct array/list zip',
                    candidate={name: digest(data) for name, data in current.items()},
                    reference={name: digest(data) for name, data in expected.items()},
                    ownershipSha256=digest(ownership), patchSha256=digest(patch),
                    frozenPatchSha256=digest(PATCH.read_bytes()))
    if args.verify:
        previous = json.loads((args.output / 'manifest.json').read_text())
        assert previous == manifest
        manifest['compilerSha256'] = digest((args.output / 'fwp').read_bytes())
    else:
        for name, data in expected.items():
            target = args.output / 'source' / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_bytes(data)
        (args.output / 'reference.patch').write_bytes(patch)
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
