"""Reconstruct compiler costs and HTTP load records without rerunning measurements."""
import hashlib
import json
from pathlib import Path

from compiler_build_comparison import comparison
from compiler_scaling import resources
from http_load import audit
from nested_resource_counts import compare, decode
from nested_resource_timing import summarize
from resource_value_contract import VALUE_REFERENCE
from weak_callback_timing import CASES, decode_output, summarize as peer_summary


def records(folder, source):
    report = json.loads((folder / 'report.json').read_text())
    manifest = json.loads((folder / 'manifest.json').read_text())
    for name in ('report.json', 'commands.jsonl'):
        assert hashlib.sha256((folder / name).read_bytes()).hexdigest() == manifest[name]
    assert report['source'] == source and not report['failures']
    commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    assert all(row['index'] == index for index, row in enumerate(commands))
    return report, commands


def runtime(root, source):
    result = dict(service=[], peers=[])
    for directory, label in (('nested-time-comparison', 'service'), ('nested-time-peers', 'peers')):
        folder = root / directory
        report, commands = records(folder, source)
        if label == 'service':
            assert report['referenceSource'] == VALUE_REFERENCE
        assert set(report['sessions']) == {'1', '2'}
        for session, cases in report['sessions'].items():
            assert set(cases) == {f'{population}-{mode}' for population, mode in CASES}
            for key, case in cases.items():
                population, mode = map(int, key.split('-'))
                batches = case['batches'] if label == 'service' else report['pilots'][key]['batches']
                for sample in case['warmups'] + case['samples']:
                    raw = commands[sample['command']]
                    assert raw['status'] == 0 and not raw['stderr']
                    assert raw['command'][-3:] == list(map(str, (population, mode, batches)))
                    value = decode_output(raw['stdout'], population, mode, batches)
                    if 'ns' in sample:
                        assert sample['ns'] == dict(service=value['serviceNs'], process=raw['elapsedNs'])
                actual = (summarize(case['samples'], population, VALUE_REFERENCE)
                          if label == 'service' else peer_summary(case['samples']))
                assert case['summary'] == actual
                peaks = {}
                for role, readings in case['memory'].items():
                    assert len(readings) == 3
                    for row in readings:
                        assert row['peakRssKiB'] == int((folder / row['file']).read_text()) > 0
                    peaks[role] = max(row['peakRssKiB'] for row in readings)
                row = dict(session=session, case=key, summary=actual, peakRssKiB=peaks)
                if label == 'service':
                    ratio = peaks['candidate'] / peaks['reference']
                    assert case['peakRssRatio'] == ratio and case['rssTargetMet'] == (ratio <= 1.05)
                    row.update(peakRssRatio=ratio, rssTargetMet=case['rssTargetMet'])
                result[label].append(row)
    return result


def counts(root, source):
    report, commands = records(root / 'nested-owner-counts', source)
    assert report['referenceSource'] == VALUE_REFERENCE
    assert len(report['cases']) == 4 and len(report['controls']) == 8
    for cases in report['cases'].values():
        assert set(cases) == {f'{population}-{mode}' for population, mode in CASES}
        for key, row in cases.items():
            population, mode = map(int, key.split('-'))
            raw = commands[row['command']]
            assert raw['status'] == 0 and raw['command'][-3:] == [str(population), str(mode), '1']
            decode_output(raw['stdout'], population, mode, 1)
            assert decode(raw['stderr']) == row['counts']
    comparisons = {}
    for level in (1, 2):
        for population, mode in CASES:
            key = f'{population}-{mode}'
            comparisons[f'O{level}/{key}'] = compare(report['cases'][f'reference-O{level}'][key]['counts'],
                report['cases'][f'candidate-O{level}'][key]['counts'], VALUE_REFERENCE)
    assert report['comparisons'] == comparisons
    for control in report['controls']:
        raw = commands[control['command']]
        if control['variant'] == 'missing-release':
            assert raw['status'] == 79 and raw['stderr'] == 'service storage not released\n'
        else:
            assert control['variant'] == 'extra-cleanup' and raw['status'] == 0
            expected = dict(report['cases'][f'{control["role"]}-O{control["level"]}']['64-0']['counts'])
            expected['pushes'] += 1
            expected['pops'] += 1
            assert decode(raw['stderr']) == expected
    return comparisons


def compiler(root, source):
    result = []
    for session in (1, 2):
        folder = root / f'nested-compiler-session-{session}'
        report = json.loads((folder / 'summary.json').read_text())
        identity = report['identity']
        assert identity['source'] == source and identity['session'] == session
        assert identity['referenceSource'] == '5a9047178b88c801f37a279dfeca55b0e190bf07'
        assert identity['contract'] == 'nested-resources'
        assert not report['failures'] and len(report['cases']) == 16
        commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
        assert len(commands) == 16 * 36
        observed = []
        for name, case in report['cases'].items():
            assert case['correct']
            assert hashlib.sha256((folder / name / 'input.fwp').read_bytes()).hexdigest() == case['sourceSha256']
            hashes = {}
            for sample in case['samples']:
                prefix = folder / name / f'round-{sample["round"]}-{sample["role"]}'
                raw = commands[len(observed)]
                assert {key: sample[key] for key in raw} == raw
                assert raw['status'] == 0 and not raw['timedOut']
                measured = resources(prefix.with_suffix('.resources').read_text())
                assert all(sample[key] == value for key, value in measured.items())
                assert not prefix.with_suffix('.stdout').read_bytes()
                assert not prefix.with_suffix('.stderr').read_bytes()
                role = sample['role'].removesuffix('-copy')
                hashes.setdefault(role, (sample['cSha256'], sample['cBytes']))
                assert hashes[role] == (sample['cSha256'], sample['cBytes'])
                observed.append(raw)
            actual = comparison(case['samples'], name, 'nested-resources')
            assert all(case[key] == value for key, value in actual.items())
            result.append(dict(session=session, case=name, **actual))
        assert observed == commands
    return result


def http(root, source):
    folder = root / 'http-load'
    report = json.loads((folder / 'summary.json').read_text())
    assert report['identity']['source'] == source and not report['failures']
    assert report['trials']
    for trial in report['trials']:
        path = folder / trial['name']
        header = json.loads((path / 'generator.stdout').read_text())
        assert header == trial['header']
        actual = audit(path / 'attempts', header, True)
        assert all(trial[key] == value for key, value in actual.items())
        assert trial['generatorStatus'] == 0 and trial['allFailures'] == 0
        assert not (path / 'generator.stderr').read_bytes()
    return report
