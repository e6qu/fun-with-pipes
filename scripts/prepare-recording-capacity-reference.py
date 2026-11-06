#!/usr/bin/env python3
"""Recombine the checked reserve gate and unchanged tape growth body."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
EDITS = {'runtime/fwp_rt_kernel.c': (
    ('static void fwp_tape_grow(fwp_tape *t, int64_t n, int64_t limit) {\n',
     '''static void fwp_tape_reserve(fwp_tape *t, int64_t n) {
    int64_t limit = fwp_tape_limit();
    if (n < 0 || n > limit) fwp_trap("autodiff: the tape is full");
    if (n <= t->cap) return;
'''),
    ('''/* Keep the usual no-growth path at the caller, without duplicating buffer
 * allocation and recovery. Validate before taking the capacity shortcut. */
static inline __attribute__((always_inline)) void fwp_tape_reserve(fwp_tape *t, int64_t n) {
    int64_t limit = fwp_tape_limit();
    if (n < 0 || n > limit) fwp_trap("autodiff: the tape is full");
    if (n <= t->cap) return;
    fwp_tape_grow(t, n, limit);
}

''', ''),
)}
RESERVE = 'static void fwp_tape_reserve(fwp_tape *t, int64_t n) {\n'
PRESERVED = (
    'src/cgen.rs', 'src/ownership.rs', 'src/ir.rs', 'src/rc.rs', 'src/rc/borrows.rs', 'src/escape.rs',
    'src/cgen/recording.rs', 'src/cgen/constant_values.rs', 'src/cgen/owned_numeric.rs', 'src/cgen/scoped_calls.rs', 'src/cgen/fold_fields.rs',
    'src/opt/scoped.rs', 'src/cgen/packed_inputs.rs',
    'src/cgen/numeric_parameters.rs', 'src/cgen/packed_records.rs',
    'src/cgen/range_zip.rs', 'src/fuse.rs', 'src/opt.rs',
    'runtime/fwp_rt.c', 'runtime/fwp_rt_heap.c', 'runtime/fwp_rt_prims.c',
    'runtime/fwp_rt_task.c', 'src/numerics.rs', 'src/interp.rs',
    'lib/list.fwp', 'lib/autodiff.fwp',
)


def reference_sources(current):
    assert set(current) == set(EDITS), 'reference requires exactly the reserve gate/growth split'
    result = {}
    for name, edits in EDITS.items():
        source = current[name]
        assert RESERVE not in source and source.count('fwp_tape_grow(') == 2, name
        for candidate, reference in edits:
            assert source.count(candidate) == 1, (name, candidate)
            source = source.replace(candidate, reference)
        assert 'fwp_tape_grow(' not in source and source.count(RESERVE) == 1, name
        result[name] = source
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
        disabledTransformation='inlined checked reserve gate with shared tape growth',
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
