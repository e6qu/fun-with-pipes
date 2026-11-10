#!/usr/bin/env python3
"""Reconstruct ownership-count comparisons and fault controls from retained native observations."""
import argparse
import hashlib
import json
from pathlib import Path

from nested_resource_counts import compare, decode, instrument
from weak_callback_service import CASES, replace_once
from weak_callback_source import boundary
from weak_callback_timing import decode_output


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    args = parser.parse_args()
    folder = args.input.resolve()
    manifest = json.loads((folder / 'manifest.json').read_text())
    assert set(manifest) == {str(path.relative_to(folder)) for path in folder.rglob('*')
                             if path.is_file() and path.name != 'manifest.json'}
    for name, digest in manifest.items():
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert hashlib.sha256((folder / name).read_bytes()).hexdigest() == digest, name
    report = json.loads((folder / 'report.json').read_text())
    assert (report['source'], report['architecture']) == (args.source, args.arch)
    assert report['referenceSource'] == '65719f7fc2277a5b97c5a790df941fea6c5eb4d7'
    assert not report['failures']
    assert set(report['compilers']) == {'reference', 'candidate'}
    commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    observed = set()
    root = Path(report['root'])
    assert len(report['builds']) == 4 and len(report['controls']) == 8
    assert set(report['cases']) == {f'{role}-O{level}' for role in ('reference', 'candidate') for level in (1, 2)}
    assert set(report['selection']) == {f'{role}-{app}' for role in ('reference', 'candidate') for app in ('service', 'http')}

    def reading(index, part, population, mode, status, stderr):
        assert index not in observed
        observed.add(index)
        row = commands[index]
        assert row['command'] == [str(root / part / 'program'), str(population), str(mode), '1']
        assert row['status'] == status
        if status == 0:
            decode_output(row['stdout'], population, mode, 1)
            return decode(row['stderr'])
        assert row['stdout'] == '' and row['stderr'] == stderr
        return None

    comparisons = {}
    for role in ('reference', 'candidate'):
        for app in ('service', 'http'):
            name = f'{role}-{app}.c'
            original = (folder / name).read_text()
            selection = report['selection'][f'{role}-{app}']
            assert selection['sha256'] == manifest[name]
            assert selection['anchors'] == original.count('protected by enclosing frame')
            assert (selection['anchors'] > 0) if role == 'candidate' else (selection['anchors'] == 0)
        expected_source = instrument(boundary((folder / f'{role}-service.c').read_text()))
        for level in (1, 2):
            part = f'fwp-{role}-{level}-diagnostic'
            assert (folder / part / 'factory.c').read_text() == expected_source
            builds = [row for row in report['builds'] if (row['role'], row['level']) == (role, level)]
            assert len(builds) == 1
            image = (folder / part / 'program').read_bytes()
            assert builds[0]['sha256'] == hashlib.sha256(image).hexdigest()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
            cases = report['cases'][f'{role}-O{level}']
            assert set(cases) == {f'{population}-{mode}' for population, mode in CASES}
            for population, mode in CASES:
                row = cases[f'{population}-{mode}']
                assert reading(row['command'], part, population, mode, 0, None) == row['counts']
            for variant in ('extra-cleanup', 'missing-release'):
                controls = [row for row in report['controls'] if
                            (row['role'], row['level'], row['variant']) == (role, level, variant)]
                assert len(controls) == 1
                control = controls[0]
                control_part = f'fwp-{role}-{variant}-{level}-diagnostic'
                control_source = (replace_once(expected_source, '    ServiceStats result =',
                    '    fwp_cleanup extra; fwp_cleanup_push(&extra, NULL, NULL); fwp_cleanup_pop(&extra);\n    ServiceStats result =')
                    if variant == 'extra-cleanup' else replace_once(expected_source, '    fwp_rc_free_obj(output);', ''))
                assert (folder / control_part / 'factory.c').read_text() == control_source
                actual = reading(control['command'], control_part, 64, 0,
                    0 if variant == 'extra-cleanup' else 79, 'service storage not released\n')
                if variant == 'extra-cleanup':
                    expected = dict(cases['64-0']['counts'])
                    expected['pushes'] += 1
                    expected['pops'] += 1
                    assert actual == expected
    for level in (1, 2):
        for population, mode in CASES:
            key = f'{population}-{mode}'
            comparisons[f'O{level}/{key}'] = compare(report['cases'][f'reference-O{level}'][key]['counts'],
                                                    report['cases'][f'candidate-O{level}'][key]['counts'])
    assert report['comparisons'] == comparisons
    for index, row in enumerate(commands):
        assert row['index'] == index
        if index not in observed:
            assert row['status'] == 0 and row['stderr'] == '', row
    print('All 32 native cases, eight fault controls, selections and 16 count comparisons reconstruct')


if __name__ == '__main__':
    main()
