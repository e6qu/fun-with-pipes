#!/usr/bin/env python3
"""Recompute retained State-range costs and analysis decisions without rerunning them."""
import argparse
import base64
import importlib.util
import json
from pathlib import Path
import re

SPEC = importlib.util.spec_from_file_location('state_range_size', Path(__file__).with_name('check-state-range-size.py'))
SIZE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SIZE)


def check_native(row, source, outcome):
    report = row['report']
    assert report['source'] == source
    assert report['host']['machine'] == {'arm': 'aarch64', 'amd': 'x86_64'}[row['host']]
    assert report['cases'] == list(SIZE.CASES)
    assert set(report['programs']) == {'reference', 'candidate'}
    commands = row['commands']
    assert len(commands) == 48
    for command in commands:
        assert type(command['status']) is int and command['status'] == 0
        assert command['timedOut'] is False
        assert base64.b64decode(command['stderr'], validate=True) == b''
        base64.b64decode(command['stdout'], validate=True)
    assert base64.b64decode(commands[0]['stdout']).decode().strip() == source
    for label, mode in [('reference', '0'), ('candidate', '1')]:
        program = report['programs'][label]
        selected = [command for command in commands if command['fusion'] == mode]
        assert len(selected) == 22
        assert selected[1]['command'] == program['command']
        flags = program['command']
        for flag in ['-O2', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-fstack-usage']:
            assert flags.count(flag) == 1
        assert '-march=' + {'arm': 'armv8-a', 'amd': 'x86-64'}[row['host']] in flags
        for index, n in enumerate(SIZE.CASES):
            expected = f'{max(n, 0) * (max(n, 0) - 1) // 2}\n'.encode()
            executions = selected[2 + 3 * index:5 + 3 * index]
            for command in executions:
                assert command['command'][-1] == str(n)
                assert base64.b64decode(command['stdout']) == expected
            assert all('--interp' in command['command'] for command in executions[:2])
            assert executions[2]['command'][0].endswith('/' + label + '/range')
        symbols = SIZE.worker_symbols(base64.b64decode(selected[-2]['stdout']).decode(), program['entry'])
        assert symbols == program['symbols']
        assert SIZE.worker_bytes(symbols) == program['workerBytes']
        assert SIZE.PROGRAMS.sections(base64.b64decode(selected[-1]['stdout']).decode()) == program['sections']
        assert program['frames']
        assert all(type(frame['bytes']) is int and frame['bytes'] >= 0 for frame in program['frames'])
        assert max(frame['bytes'] for frame in program['frames']) == program['largestFrameBytes']
        for key in ['binarySha256', 'generatedSha256']:
            assert re.fullmatch('[0-9a-f]{64}', program[key])
    decision = SIZE.limits(report['programs']['reference'], report['programs']['candidate'])
    assert decision == report['acceptance'] == dict(code=outcome == 'focused', stack=True)
    if outcome == 'focused':
        costs = row['functionalCosts']
        assert len(costs) == 4
        assert {Path(cost['file']).name for cost in costs} == {
            f'functional-{level}.{n}.stdout' for level in ['O0', 'O2'] for n in [32, 128]}
        for cost in costs:
            assert len(cost['rows']) == 16 and all(len(item) == 8 for item in cost['rows'])
            selected = [item for item in cost['rows'] if item[:2] == ['each-count', 'known']]
            assert len(selected) == 1
            assert selected[0][2] == Path(cost['file']).name.split('.')[1]
            assert selected[0][3:] == ['2', '152', '2', '1', '0']


def check_analysis(row, outcome):
    observations = row['observations']
    labels = ['Merged', 'Separate', 'SeparateCopy']
    assert [(item['n'], item['label']) for item in observations] == [
        (n, label) for n in [16, 32, 64] for label in labels]
    controls = []
    for n, limit in zip([16, 32, 64], [20, 35, 65] if row['host'] == 'amd' else [55, 90, 170]):
        times = {}
        for item in [item for item in observations if item['n'] == n]:
            samples, fields, label = item['samplesNs'], item['fields'], item['label']
            assert len(samples) == 12 and all(len(batch) == 64 for batch in samples)
            assert all(type(value) is int and value > 0 for batch in samples for value in batch)
            totals = sorted(sum(batch) for batch in samples)
            median = (totals[5] + totals[6]) // 2
            assert fields['proofs_per_batch'] == 64
            assert fields['median_batch_ns'] == median and fields['median_ns'] == median // 64
            budgets = dict(rounds=16, visits=15 * n + 300, summary_updates=6,
                           contexts=n + 33, functions=n + 33, ir_nodes=19 * n + 126,
                           closures=13 if label == 'Merged' else 5 * n + 8,
                           facts=57 if label == 'Merged' else 10 * n + 47)
            assert all(type(fields[key]) is int and 0 <= fields[key] <= bound for key, bound in budgets.items())
            times[label] = median
        control = dict(n=n, absolute=all(value <= limit * 1_000_000 * 64 for value in times.values()),
                       separateOverMerged=all(times[label] * 2 <= times['Merged'] * 3 for label in labels[1:]),
                       identicalCopy=max(times[label] for label in labels[1:]) * 100
                       <= min(times[label] for label in labels[1:]) * 105)
        assert control == dict(n=n, absolute=True, separateOverMerged=True,
                               identicalCopy=not (outcome == 'rejected' and row['host'] == 'intel' and n == 32))
        controls.append(control)
    assert controls == row['controls']
    startup = row['startupLog']
    for fixture in ['tests/rest/forms.fwp', 'tests/fixtures/server_entries.fwp']:
        seconds = re.findall(r'rest-startup fixture=' + re.escape(fixture)
                             + r' raw=true .*? analysis_seconds=([0-9.]+) analysis_limit_seconds=10 ', startup)
        assert len(seconds) == 1 and 0 <= float(seconds[0]) <= 10
        assert startup.count(f'rest-worklist fixture={fixture} full_scan_facts=equal validation_added_facts=false') == 1
    assert 'test result: ok. 1 passed; 0 failed;' in startup
    if outcome == 'focused':
        assert row['orders'] == [[0, 1, 2], [0, 2, 1], [1, 2, 0], [2, 1, 0], [1, 0, 2], [2, 0, 1]]


def check(record, source, outcome):
    assert outcome in ['focused', 'rejected'] and re.fullmatch('[0-9a-f]{40}', source)
    assert record['source'] == source
    assert [row['host'] for row in record['native']] == ['arm', 'amd']
    assert [row['host'] for row in record['analysis']] == ['amd', 'intel']
    for row in record['native'] + record['analysis']:
        assert type(row['artifact']) is int and row['artifact'] > 0
        assert type(row['job']) is int and row['job'] > 0
        assert re.fullmatch('[0-9a-f]{64}', row['archiveSha256'])
    for row in record['native']:
        check_native(row, source, outcome)
    for row in record['analysis']:
        check_analysis(row, outcome)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--record', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--outcome', choices=['focused', 'rejected'], required=True)
    args = parser.parse_args()
    check(json.loads(args.record.read_text()), args.source, args.outcome)
    print(f'Consistent {args.outcome} evidence; no new measurement or production acceptance')


if __name__ == '__main__':
    main()
