#!/usr/bin/env python3
"""Prepare the frozen column tape with the current compiler and other runtime code."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
# Only measurement tools read this frozen section; production builds never do.
BASELINE = 'ef0a54a1da660fcc4c4e094e96c30c1adbe0fb5d'
REFERENCE_PATH = 'scripts/fixtures/tape_column_reference.c'
REFERENCE_SHA256 = '1334cf6ef6d30030db56a6cebc478ff6abd31c50e404a6ec89b0260ffeb6561c'
START = '/* ------------------------------------------------------------------ tapes */'
END = '/* ---------------------------------------------------------------- kernels */'
EDITS = {'runtime/fwp_rt_kernel.c'}
PRESERVED = (
    'src/ownership.rs', 'src/ir.rs', 'src/rc.rs', 'src/rc/borrows.rs', 'src/escape.rs',
    'src/cgen/recording.rs', 'src/cgen/constant_values.rs', 'src/cgen/owned_numeric.rs', 'src/cgen/scoped_calls.rs', 'src/cgen/fold_fields.rs',
    'src/opt/scoped.rs', 'src/cgen/packed_inputs.rs',
    'src/cgen/numeric_parameters.rs', 'src/cgen/packed_records.rs',
    'src/cgen/range_zip.rs', 'src/fuse.rs', 'src/opt.rs',
    'runtime/fwp_rt.c', 'runtime/fwp_rt_heap.c', 'runtime/fwp_rt_prims.c',
    'runtime/fwp_rt_task.c', 'src/cgen.rs', 'src/numerics.rs', 'src/interp.rs',
    'lib/list.fwp', 'lib/autodiff.fwp',
)



def replace_tape(candidate, reference):
    """Replace exactly the tape section; keep every surrounding source byte."""
    assert hashlib.sha256(reference.encode()).hexdigest() == REFERENCE_SHA256
    assert reference.startswith(START) and reference.count(START) == 1 and END not in reference
    assert candidate.count(START) == candidate.count(END) == 1
    begin, finish = candidate.index(START), candidate.index(END)
    assert begin < finish
    tape = candidate[begin:finish]
    assert 'typedef struct { int32_t pa, pb; double da, db; } fwp_tape_op;' in tape
    assert 'realloc(t->ops, (size_t)cap * sizeof(fwp_tape_op))' in tape
    assert 'realloc(t->parents, (size_t)cap * sizeof(fwp_tape_parents))' in tape
    return candidate[:begin] + reference + candidate[finish:]


def reference_sources(current):
    assert set(current) == EDITS, 'reference requires exactly the tape runtime'
    reference = (ROOT / REFERENCE_PATH).read_text()
    return {name: replace_tape(data, reference) for name, data in current.items()}


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
    current = {name: (ROOT / name).read_text() for name in EDITS}
    expected = reference_sources(current)
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        assert all((checkout / name).read_text() == data for name, data in current.items())
        args.output.mkdir(parents=True, exist_ok=False)
        for name, data in expected.items():
            (checkout / name).write_text(data)
    assert all((checkout / name).read_text() == data for name, data in expected.items())
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed.splitlines() == sorted(EDITS), changed
    unchanged = {}
    for name in PRESERVED:
        data = (ROOT / name).read_bytes()
        assert (checkout / name).read_bytes() == data, name
        unchanged[name] = digest(data)
    patch = subprocess.check_output(['git', 'diff', 'HEAD'], cwd=checkout)
    manifest = dict(
        source=source,
        layoutReference=dict(source=BASELINE, path=REFERENCE_PATH, sha256=REFERENCE_SHA256),
        disabledTransformation='contiguous numeric operation records and typed parent pairs',
        candidate={name: digest(data.encode()) for name, data in current.items()},
        reference={name: digest(data.encode()) for name, data in expected.items()},
        unchanged=unchanged,
        ownershipSha256=unchanged['src/ownership.rs'],
        patchSha256=digest(patch),
    )
    if args.verify:
        saved = json.loads((args.output / 'manifest.json').read_text())
        if 'compilerSha256' in saved:
            assert saved.pop('compilerSha256') == digest((args.output / 'fwp').read_bytes())
        assert saved == manifest
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
