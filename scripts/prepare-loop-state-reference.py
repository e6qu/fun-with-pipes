#!/usr/bin/env python3
"""Build a same-source reference that disables only native floating-point loop-state fields."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
CANDIDATE = """            scalars: slot_types
                .iter()
                .map(|(_, ty)| scalar(ty).filter(|kind| matches!(kind, Scalar::F32 | Scalar::F64)))
                .collect(),"""
REFERENCE = """            // Paired reference: loop state uses ordinary value words.
            scalars: slot_types.iter().map(|_| None).collect(),"""


TEST_EXPECTATIONS = {
    'tests/loop_preparation_ownership.rs': (
        'typedef struct {{ V v0; V v1; V v2; double v3; }} fwp_loop_state{id};',
        'typedef struct {{ V v0; V v1; V v2; V v3; }} fwp_loop_state{id};'),
    'tests/nested_loop_boxing.rs': (
        'typedef struct {{ V v0; V v1; V v2; double v3; V v4; }} fwp_loop_state{id};',
        'typedef struct {{ V v0; V v1; V v2; V v3; V v4; }} fwp_loop_state{id};'),
}


def reference_test(current, name):
    before, after = TEST_EXPECTATIONS[name]
    assert current.count(before) == 1 and after not in current
    return current.replace(before, after)


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
    current = (ROOT / 'src/cgen.rs').read_text()
    expected = reference_source(current)
    tests = {}
    for name in TEST_EXPECTATIONS:
        original = (ROOT / name).read_text()
        tests[name] = (original, reference_test(original, name))
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        assert (checkout / 'src/cgen.rs').read_text() == current
        args.output.mkdir(parents=True, exist_ok=False)
        (checkout / 'src/cgen.rs').write_text(expected)
        for name, (original, updated) in tests.items():
            assert (checkout / name).read_text() == original
            (checkout / name).write_text(updated)
    assert (checkout / 'src/cgen.rs').read_text() == expected
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed.splitlines() == sorted(['src/cgen.rs', *tests]), changed
    for name, (_, updated) in tests.items():
        assert (checkout / name).read_text() == updated
    patch = subprocess.check_output(['git', 'diff', 'HEAD', '--', 'src/cgen.rs', *tests], cwd=checkout)
    ownership = (ROOT / 'src/ownership.rs').read_bytes()
    assert (checkout / 'src/ownership.rs').read_bytes() == ownership
    manifest = dict(source=source, disabledTransformation='native floating-point loop-state fields',
                    candidateCodegenSha256=digest(current.encode()),
                    referenceCodegenSha256=digest(expected.encode()),
                    ownershipSha256=digest(ownership), patchSha256=digest(patch),
                    testExpectations={name: dict(candidateSha256=digest(original.encode()),
                        referenceSha256=digest(updated.encode())) for name, (original, updated) in tests.items()})
    (args.output / 'codegen-reference.rs').write_text(expected)
    (args.output / 'reference.patch').write_bytes(patch)
    for name, (_, updated) in tests.items():
        saved = args.output / name
        saved.parent.mkdir(parents=True, exist_ok=True)
        saved.write_text(updated)
    if args.verify:
        previous = json.loads((args.output / 'manifest.json').read_text())
        assert previous == manifest
        manifest['compilerSha256'] = digest((args.output / 'fwp').read_bytes())
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
