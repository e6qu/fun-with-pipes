#!/usr/bin/env python3
"""Disable numeric-parameter rewriting and numeric packed-map inputs only."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
CHANGES = {
    'src/cgen.rs': (
        '    numeric_parameters::lower(&mut numeric_program, &roots);\n',
        '    if false { numeric_parameters::lower(&mut numeric_program, &roots); }\n',
    ),
    'src/cgen/packed_records.rs': (
        '    let abi = super::abi_of(prog, function)?;\n    // Proved numeric fields',
        '    let abi = super::abi_of(prog, function)?;\n'
        '    if abi.params.iter().any(Option::is_some) { return None; }\n'
        '    // Proved numeric fields',
    ),
}


def reference_sources(current):
    assert set(current) == set(CHANGES)
    result = {}
    for path, (candidate, reference) in CHANGES.items():
        assert current[path].count(candidate) == 1 and reference not in current[path], path
        result[path] = current[path].replace(candidate, reference)
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
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    current = {path: (ROOT / path).read_text() for path in CHANGES}
    expected = reference_sources(current)
    if args.checkout:
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        args.output.mkdir(parents=True, exist_ok=False)
        for path, text in expected.items():
            assert (checkout / path).read_text() == current[path]
            (checkout / path).write_text(text)
    for path, text in expected.items():
        assert (checkout / path).read_text() == text, path
    changed = subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True)
    assert changed.splitlines() == sorted(CHANGES), changed
    patch = subprocess.check_output(['git', 'diff', 'HEAD', '--', *sorted(CHANGES)], cwd=checkout)
    untouched = {}
    for path in ['src/ownership.rs', 'src/cgen/field_transfers.rs', 'src/cgen/numeric_parameters.rs']:
        data = (ROOT / path).read_bytes()
        assert (checkout / path).read_bytes() == data
        untouched[path] = digest(data)
    manifest = dict(source=source,
                    disabledTransformation='numeric internal parameters and numeric packed-map input preparation',
                    files={path: dict(candidateSha256=digest(current[path].encode()),
                                      referenceSha256=digest(expected[path].encode())) for path in CHANGES},
                    unchanged=untouched, patchSha256=digest(patch))
    for path, text in expected.items():
        (args.output / ('reference-' + Path(path).name)).write_text(text)
    (args.output / 'reference.patch').write_bytes(patch)
    if args.verify:
        assert json.loads((args.output / 'manifest.json').read_text()) == manifest
        manifest['compilerSha256'] = digest((args.output / 'fwp').read_bytes())
    (args.output / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


if __name__ == '__main__':
    main()
