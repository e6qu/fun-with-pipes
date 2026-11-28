#!/usr/bin/env python3
"""Reconstruct resource attribution from raw native executions and HTTP replies."""
import argparse
import hashlib
import json
from pathlib import Path

from http_load import REQUEST, response_ok
from nested_resource_counts import COUNTERS, MEMORY, decode as decode_total
from resource_frame_counts import decode
from weak_callback_service import CASES, unique_fields
from weak_callback_timing import decode_output


def read(path):
    return json.loads(path.read_text(), object_pairs_hook=unique_fields)


def audit(root, source, arch):
    root = root.resolve()
    report = read(root / 'report.json')
    assert report['source'] == source and report['arch'] == arch
    assert not report['failures']
    manifest = read(root / 'manifest.json')
    assert set(manifest) == {str(path.relative_to(root)) for path in root.rglob('*')
                             if path.is_file() and path != root / 'manifest.json'}
    for name, digest in manifest.items():
        path = (root / name).resolve()
        assert path.is_relative_to(root)
        assert hashlib.sha256(path.read_bytes()).hexdigest() == digest
    commands = [json.loads(line, object_pairs_hook=unique_fields)
                for line in (root / 'commands.jsonl').read_text().splitlines()]
    assert all(row['index'] == index for index, row in enumerate(commands))
    builds = {row['group']: row for row in report['builds']}
    assert len(builds) == len(report['builds']) == 12
    for build in builds.values():
        image = (root / build['path']).read_bytes()
        assert hashlib.sha256(image).hexdigest() == build['sha256']
        assert image[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[arch]
        assert commands[build['command']]['status'] == 0
        assert commands[build['command']]['command'][-2:] == ['-o', str(root / build['path'])] or (
            commands[build['command']]['command'][-1].endswith('/' + build['path']))
    expected_keys = set()
    for application in ('service', 'http'):
        selected = report['selected'][application]
        for level in (1, 2):
            for label in ('baseline', 'attributed', 'extra-pair'):
                inputs = CASES if application == 'service' else ((64, 0), (256, 0))
                if label == 'extra-pair':
                    inputs = ((64, 0),)
                for population, mode in inputs:
                    group = f'{application}/O{level}/{label}'
                    key = f'{group}/{population}-{mode}'
                    expected_keys.add(key)
                    entry = report['cases'][key]
                    if application == 'service':
                        command = commands[entry['command']]
                        assert command['status'] == 0
                        assert command['command'][0].endswith('/' + builds[group]['path'])
                        assert command['command'][-3:] == [str(population), str(mode), '1']
                        decode_output(command['stdout'], population, mode, 1)
                        lines = command['stderr'].splitlines()
                        assert len(lines) == (1 if label == 'baseline' else 2)
                        total = decode_total(lines[0])
                        rebuilt = dict(command=command['index'], total=total)
                    else:
                        directory = key.replace('/', '-')
                        path = root / directory
                        command = read(path / 'command.json')
                        assert command['status'] == 0 and command['requests'] == command['responses'] == population
                        assert len(command['command']) == 1 and command['command'][0].endswith('/' + builds[group]['path'])
                        assert (path / 'request.bin').read_bytes() == REQUEST
                        assert len(list(path.glob('response-*.bin'))) == population
                        for index in range(population):
                            assert response_ok((path / f'response-{index}.bin').read_bytes())
                        assert not (path / 'stdout').read_bytes()
                        lines = (path / 'stderr').read_text().splitlines()
                        assert lines.count('stopped') == 1
                        raw_total, = [line.removeprefix('FWP_HTTP_TOTAL ') for line in lines if line.startswith('FWP_HTTP_TOTAL ')]
                        total = decode_total(raw_total)
                        rebuilt = dict(directory=directory, total=total)
                    if label != 'baseline':
                        line, = [line for line in lines if line.startswith('FWP_RESOURCE_WORK ')]
                        work = decode(line, selected)
                        assert sum(row[0] for row in work['frames']) <= total['pushes']
                        assert sum(row[1] for row in work['frames']) <= total['pops']
                        assert sum(row[1] for row in work['fields']) <= total['retains']
                        assert sum(row[1] for row in work['closures']) == sum(
                            row[0] for row, field in zip(work['fields'], selected['fields']) if field['callable'])
                        rebuilt['work'] = work
                    assert rebuilt == entry, ('raw output disagrees with summary', key)
            if application == 'service':
                for population, mode in CASES:
                    baseline = report['cases'][f'{application}/O{level}/baseline/{population}-{mode}']
                    counted = report['cases'][f'{application}/O{level}/attributed/{population}-{mode}']
                    assert baseline['total'] == counted['total'], 'observer changed service work'
            ordinary = report['cases'][f'{application}/O{level}/attributed/64-0']
            extra = report['cases'][f'{application}/O{level}/extra-pair/64-0']
            # Aggregate inclusive typed-release counts can include children,
            # but this control's owner is still shared: precisely one decrement.
            difference = [sum(row[i] for row in extra['work']['fields']) -
                          sum(row[i] for row in ordinary['work']['fields']) for i in range(4)]
            assert difference == [1, 1, 1, 1], ('extra owner did not reach selected counters', application, difference)
            assert ordinary['work']['closures'] == extra['work']['closures']
            assert ordinary['work']['frames'] == extra['work']['frames']
            if application == 'service':
                delta = {key: extra['total'][key] - ordinary['total'][key] for key in (*COUNTERS, *MEMORY)}
                assert all(delta[key] == 1 for key in ('dupCalls', 'retains', 'decrements'))
                assert delta['dropCalls'] + delta['releaseCalls'] == 1
                assert all(value == 0 for key, value in delta.items()
                           if key not in ('dupCalls', 'retains', 'decrements', 'dropCalls', 'releaseCalls'))
    assert set(report['cases']) == expected_keys
    print('Verified 44 executions, 12 native binaries, every HTTP reply and real extra-owner controls')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    args = parser.parse_args()
    audit(args.input, args.source, args.arch)


if __name__ == '__main__':
    main()
