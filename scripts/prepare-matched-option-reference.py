#!/usr/bin/env python3
"""Disable only direct fields for matched list reads and final iteration results."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
EDITS = (
    (
        '            if matches!(symbol.as_str(), "last" | "nth") {\n',
        '            if false && matches!(symbol.as_str(), "last" | "nth") {\n',
    ),
    (
        '        if symbol == "list._iterate-last" {\n',
        '        if false && symbol == "list._iterate-last" {\n',
    ),
)
CHANGED = 'src/cgen.rs'
PRESERVED = (
    'src/fuse.rs', 'src/prims_std.rs', 'src/ownership.rs', 'src/opt.rs',
    'runtime/fwp_rt.c', 'runtime/fwp_rt_prims.c', 'runtime/fwp_rt_task.c',
    'runtime/fwp_rt_heap.c', 'lib/list.fwp', 'lib/autodiff.fwp',
)


def reference_source(current):
    result = current
    for candidate, reference in EDITS:
        assert current.count(candidate) == 1 and reference not in current, candidate
        result = result.replace(candidate, reference)
    return result


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
    assert checkout != ROOT, 'reference must use a separate checkout'
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    current = {CHANGED: (ROOT / CHANGED).read_text()}
    expected = {CHANGED: reference_source(current[CHANGED])}
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        assert all((checkout / name).read_text() == data for name, data in current.items())
        args.output.mkdir(parents=True, exist_ok=False)
        for name, data in expected.items():
            (checkout / name).write_text(data)
    assert all((checkout / name).read_text() == data for name, data in expected.items())
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed.splitlines() == [CHANGED], changed
    unchanged = {}
    for name in PRESERVED:
        data = (ROOT / name).read_bytes()
        assert (checkout / name).read_bytes() == data, name
        unchanged[name] = digest(data)
    patch = subprocess.check_output(['git', 'diff', 'HEAD'], cwd=checkout)
    manifest = dict(
        source=source,
        disabledTransformation='direct fields for matched list last, nth and final iteration results',
        candidate={name: digest(data.encode()) for name, data in current.items()},
        reference={name: digest(data.encode()) for name, data in expected.items()},
        unchanged=unchanged,
        ownershipSha256=unchanged['src/ownership.rs'],
        patchSha256=digest(patch),
    )
    if args.verify:
        assert json.loads((args.output / 'manifest.json').read_text()) == manifest
        assert (args.output / 'reference.patch').read_bytes() == patch
        for name, data in expected.items():
            assert (args.output / 'source' / name).read_text() == data, name
        manifest['compilerSha256'] = digest((args.output / 'fwp').read_bytes())
    else:
        for name, data in expected.items():
            target = args.output / 'source' / name
            target.parent.mkdir(parents=True, exist_ok=True)
            target.write_text(data)
        (args.output / 'reference.patch').write_bytes(patch)
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
