#!/usr/bin/env python3
"""Independently validate parser samples, frozen budgets, storage and binaries."""

import argparse
import hashlib
import json
from pathlib import Path
import re
import statistics


def expected_blocks(depth, left):
    # Independently reconstruct parser construction order: two children precede
    # their parent. Leaves need 16 bytes; operators need 24, all aligned to 8.
    def sizes(level):
        if level == 1:
            yield 16
        else:
            yield from sizes(level - 1)
            yield from sizes(1 if left else level - 1)
            yield 24
    blocks = payload = capacity = remaining = 0
    for size in sizes(depth):
        if size > remaining:
            capacity = min(4096, capacity * 2) if capacity else 256
            blocks += 1
            payload += capacity
            remaining = capacity
        remaining -= size
    return blocks, payload


def check_case(name, row, settings):
    shapes = {'small': (31, 5), 'medium': (511, 9), 'large': (8191, 13), 'left': (127, 64)}
    assert (row['nodes'], row['depth']) == shapes[name]
    expected = sum(i % 17 - 8 for i in range((row['nodes'] + 1) // 2))
    assert row['result'] == expected
    assert row['rounds'] == settings['rounds'] // (16 if name == 'large' else 1)

    def sample(label, value, count):
        assert value['rounds'] == count and value['nodes'] == row['nodes'] and value['result'] == expected
        assert all(type(value[key]) is int and value[key] >= 0 for key in
                   ['totalNs', 'tokenizeNs', 'constructNs', 'walkAndReleaseNs'])
        assert value['tokenizeNs'] + value['constructNs'] + value['walkAndReleaseNs'] == value['totalNs']
        assert value['totalNs'] > 0
        if count == row['rounds']:
            assert value['totalNs'] >= 1_000_000
        if label.startswith(('baseline', 'candidate')):
            assert value['finalLiveBytes'] == 0
            assert value['peakHeapSlotBytes'] > 0 and value['allocatedHeapSlotBytes'] > 0
        if label.startswith('baseline'):
            assert value['releaseNs'] is None
            assert all(value[key] == 0 for key in
                       ['regionBlocks', 'regionPayloadBytes', 'regionRequestedBytes', 'regionRoundedBytes', 'regionUnusedBytes'])
        else:
            assert type(value['releaseNs']) is int and 0 <= value['releaseNs'] <= value['walkAndReleaseNs']
        if label == 'candidate-profile':
            blocks = value['regionBlocks']
            used = ((row['nodes'] + 1) // 2 * 16 + (row['nodes'] - 1) // 2 * 24) * count
            assert blocks > 0 and blocks % count == 0
            expected_count, payload = expected_blocks(row['depth'], name == 'left')
            assert blocks == expected_count * count
            assert value['regionPayloadBytes'] == payload * count
            assert value['regionRequestedBytes'] == value['regionPayloadBytes'] + blocks * 24
            assert value['regionRoundedBytes'] >= value['regionRequestedBytes']
            assert value['regionUnusedBytes'] == value['regionPayloadBytes'] - used
            assert value['heapAllocations'] >= blocks
        if label in ['c', 'rust']:
            assert value['nodeSize'] == 24
            assert value['nodeCapacityBytes'] >= row['nodes'] * 24
            assert value['tokenCapacityBytes'] >= row['nodes'] * 16
            assert value['allocations'] > 0

    assert set(row['profiles']) == {'baseline-profile', 'candidate-profile', 'c', 'rust'}
    for label, values in row['profiles'].items():
        assert len(values) == 3
        for count, value in zip([1, 16, 256], values, strict=True):
            sample(label, value, count)
        if label.endswith('-profile'):
            assert len({v['peakHeapSlotBytes'] for v in values}) == 1
            assert len({v['heapAllocations'] // v['rounds'] for v in values}) == 1
    assert len(row['control']) == settings['samples']
    for i, pair in enumerate(row['control']):
        assert list(pair) == (['baseline', 'baseline-copy'] if i % 2 == 0 else ['baseline-copy', 'baseline'])
        for label, value in pair.items():
            sample(label, value, row['rounds'])
    noise = max(abs(p['baseline-copy']['totalNs'] / p['baseline']['totalNs'] - 1) for p in row['control'])
    assert row['controlEnvelope'] == noise and row['allowedCandidateRatio'] == 1 + 2 * noise
    if 1 + noise > settings['max_control_ratio']:
        assert row['samples'] == [] and 'ratios' not in row
        return [f'{name}: unstable identical-code timing control']
    assert len(row['samples']) == settings['samples']
    for i, pair in enumerate(row['samples']):
        order = ['baseline', 'candidate', 'c', 'rust']
        assert list(pair) == (order if i % 2 == 0 else order[::-1])
        for label, value in pair.items():
            sample(label, value, row['rounds'])
    ratios = {label: statistics.median(p['candidate']['totalNs'] / p[label]['totalNs']
              for p in row['samples']) for label in ['baseline', 'c', 'rust']}
    assert row['ratios'] == ratios
    return ([f'{name}: candidate exceeds the frozen timing budget']
            if ratios['baseline'] > row['allowedCandidateRatio'] else [])


def check_compilation(count, label, row, code):
    assert set(map(int, re.findall(rb'/\* job(\d+) :', code))) == set(range(int(count)))
    assert len(code) == row['emittedBytes'] and hashlib.sha256(code).hexdigest() == row['sha256']
    assert len(row['samples']) == 3
    assert all(v['seconds'] > 0 and v['maxRssKiB'] > 0 for v in row['samples'])
    assert row['selectedEntries'] == code.count(b'fwp_region region = {0};')
    if label == 'baseline':
        assert row['selectedEntries'] == 0
    else:
        assert label == 'candidate' and 0 < row['selectedEntries'] <= int(count)


def audit(directory, source):
    report = json.loads((directory / 'report.json').read_text())
    assert report['source'] == source
    assert report['baselineSource'] == '56d5aac63a9963ae6b16574f10d6dc3087a08d8a'
    settings = report['settings']
    assert settings['samples'] == 6 and settings['warmups'] == 2 and settings['cpu'] == 1
    assert settings['rounds'] == 32768 and settings['max_control_ratio'] == 1.10
    required = {'baseline.exe', 'candidate.exe', 'baseline-copy.exe', 'baseline-profile.exe',
                'candidate-profile.exe', 'c.exe', 'rust.exe', 'baseline-original.c', 'candidate-original.c',
                'baseline.c', 'candidate.c', 'baseline-profile.c', 'candidate-profile.c',
                'parser_arena_peer.c', 'parser_arena_peer.rs', 'parser.fwp'}
    assert required <= set(report['files'])
    machine = {'x86_64': 62, 'aarch64': 183}[report['machine']]
    for name, entry in report['files'].items():
        assert Path(name).name == name
        data = (directory / name).read_bytes()
        assert hashlib.sha256(data).hexdigest() == entry['sha256'] and len(data) == entry['bytes']
        if name.endswith('.exe'):
            assert data[:6] == b'\x7fELF\x02\x01' and int.from_bytes(data[18:20], 'little') == machine
    assert (directory / 'baseline.exe').read_bytes() == (directory / 'baseline-copy.exe').read_bytes()
    assert set(report['cases']) == {'small', 'medium', 'large', 'left'}
    failures = []
    for name, row in report['cases'].items():
        assert hashlib.sha256((directory / f'{name}.txt').read_bytes()).hexdigest() == row['inputSha256']
        assert (directory / f'{name}.txt').read_text().split().count('+') == (row['nodes'] - 1) // 2
        failures.extend(check_case(name, row, settings))
        frozen = dict(row, samples=[])
        frozen.pop('ratios', None)
        assert json.loads((directory / f'budget-{name}.json').read_text()) == frozen
    controls = {'multiply': (7, 45), 'negative': (1, -7), 'minimum': (1, -9223372036854775808),
                'missing': None, 'trailing': None, 'invalid': None, 'add-overflow': None, 'mul-overflow': None}
    assert set(report['peerControls']) == set(controls)
    for name, expected in controls.items():
        assert set(report['peerControls'][name]) == {'c', 'rust'}
        for result in report['peerControls'][name].values():
            if expected is None:
                assert result['status'] != 0
            else:
                assert result['status'] == 0 and result['stderr'] == ''
                value = json.loads(result['stdout'])
                assert (value['nodes'], value['result']) == expected
    assert report['analysis'] == json.loads((directory / 'analysis.json').read_text())
    assert [row['roots'] for row in report['analysis']] == [16, 32, 64]
    for row in report['analysis']:
        assert 0 < row['selected'] <= row['roots'] and 0 < row['addedWeight'] <= row['originalWeight'] * 2
        assert row['iterations'] == 128 and len(row['nanoseconds']) == 6
        assert all(type(n) is int and n > 0 for n in row['nanoseconds'])
    assert set(report['compilation']) == {'16', '32', '64'}
    for count, variants in report['compilation'].items():
        assert set(variants) == {'baseline', 'candidate'}
        for label, row in variants.items():
            code = (directory / f'{label}-scale-{count}.c').read_bytes()
            check_compilation(count, label, row, code)
    assert report['failures'] == failures
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    args = parser.parse_args()
    report = audit(args.input, args.source)
    assert not report['failures'], '\n'.join(report['failures'])
    print('All parser samples, storage ledgers, binaries, compiler observations and budgets verified')


if __name__ == '__main__':
    main()
