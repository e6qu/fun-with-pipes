#!/usr/bin/env python3
"""Reconstruct selected-hold counts from every saved native command and binary."""
import argparse
import hashlib
import json
from pathlib import Path

from nested_resource_counts import COUNTERS, MEMORY, decode
from resource_field_census import HOLD_COUNTERS
from weak_callback_service import CASES, unique_fields
from weak_callback_timing import decode_output


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    args = parser.parse_args()
    root = args.input.resolve()
    report = json.loads((root / 'report.json').read_text(), object_pairs_hook=unique_fields)
    assert report['compilerSource'] == args.source and report['architecture'] == args.arch
    assert not report['failures'] and report['selected']
    manifest = json.loads((root / 'manifest.json').read_text(), object_pairs_hook=unique_fields)
    for name, expected in manifest.items():
        path = (root / name).resolve()
        assert path.is_relative_to(root) and hashlib.sha256(path.read_bytes()).hexdigest() == expected
    commands = [json.loads(line, object_pairs_hook=unique_fields)
                for line in (root / 'commands.jsonl').read_text().splitlines()]
    assert all(row['index'] == index for index, row in enumerate(commands))
    assert len(report['builds']) == 6 and len(report['cases']) == 34
    builds = {(row['level'], row['label']): row for row in report['builds']}
    assert len(builds) == 6
    for row in builds.values():
        path = (root / row['path']).resolve()
        assert path.is_relative_to(root)
        image = path.read_bytes()
        assert hashlib.sha256(image).hexdigest() == row['sha256']
        assert image[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
        assert commands[row['command']]['status'] == 0
    rebuilt = {}
    for level in (1, 2):
        for label in ('baseline', 'attributed', 'extra-pair'):
            inputs = CASES if label != 'extra-pair' else ((64, 0),)
            for population, mode in inputs:
                key = f'O{level}/{label}/{population}-{mode}'
                summary = report['cases'][key]
                row = commands[summary['command']]
                assert row['status'] == 0
                assert row['command'][-3:] == [str(population), str(mode), '1']
                assert row['command'][0].endswith('/' + builds[(level, label)]['path'])
                decode_output(row['stdout'], population, mode, 1)
                lines = row['stderr'].splitlines()
                assert len(lines) == (1 if label == 'baseline' else 2)
                entry = dict(command=row['index'], total=decode(lines[0]))
                if label != 'baseline':
                    assert lines[1].startswith('FWP_PLAIN_HOLDS ')
                    counts = json.loads(lines[1].removeprefix('FWP_PLAIN_HOLDS '), object_pairs_hook=unique_fields)
                    assert set(counts) == set(HOLD_COUNTERS)
                    assert all(type(value) is int and value >= 0 for value in counts.values())
                    assert counts['plainRetains'] <= counts['plainHolds']
                    assert counts['plainRetains'] <= entry['total']['retains']
                    assert counts['plainDecrements'] <= entry['total']['decrements']
                    entry['selected'] = counts
                assert entry == summary, ('raw output disagrees with summary', key)
                rebuilt[key] = entry
    for level in (1, 2):
        for population, mode in CASES:
            assert rebuilt[f'O{level}/baseline/{population}-{mode}']['total'] == rebuilt[f'O{level}/attributed/{population}-{mode}']['total']
        ordinary = rebuilt[f'O{level}/attributed/64-0']
        extra = rebuilt[f'O{level}/extra-pair/64-0']
        delta = {key: extra['total'][key] - ordinary['total'][key] for key in (*COUNTERS, *MEMORY)}
        assert all(delta[key] == 1 for key in ('dupCalls', 'retains', 'decrements'))
        assert delta['dropCalls'] in (0, 1) and delta['releaseCalls'] in (0, 1)
        assert delta['dropCalls'] + delta['releaseCalls'] == 1
        assert all(value == 0 for key, value in delta.items()
                   if key not in ('dupCalls', 'retains', 'decrements', 'dropCalls', 'releaseCalls'))
        assert all(extra['selected'][key] - ordinary['selected'][key] == 1 for key in HOLD_COUNTERS)
        controls = [row for row in report['controls'] if row['level'] == level]
        assert controls == [dict(level=level, command=extra['command'], delta=delta)]
    print('Verified 34 raw executions, six native binaries, unchanged totals and two real extra-pair controls')


if __name__ == '__main__':
    main()
