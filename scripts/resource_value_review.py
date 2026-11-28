"""Reconstruct compiler costs and HTTP load records without rerunning measurements."""
import hashlib
import json
from pathlib import Path

from compiler_build_comparison import comparison
from compiler_scaling import resources
from http_load import audit
from nested_resource_counts import compare, decode
from nested_resource_memory import MEMORY_ENVIRONMENTS, categories, fast_counters
from nested_resource_timing import order, summarize
from parser_process_memory import mappings, summary, validate_mapping_control
from resource_value_contract import VALUE_REFERENCE
from weak_callback_timing import CASES, decode_output, summarize as peer_summary


def memory(root, source):
    folder = root / 'nested-memory'
    report = json.loads((folder / 'report.json').read_text())
    assert report['observerSource'] == source and not report['failures']
    assert report['binarySource'] == '33149ad2fd888a66ff36b8eb7f2c5b61faccfccb'
    assert (report['image'], report['libcPackage']) == MEMORY_ENVIRONMENTS[report['binarySource']]
    settings = report['settings']
    assert (settings['rounds'], settings['interval_ms'], settings['deadline']) == (4, 50, 30)
    controls = json.loads((root / 'memory-audit-controls.json').read_text())
    assert controls == {'rejected': ['rss-summary', 'fast-counter', 'binary-hash']}
    assert set(report['controls']) == {'ordinary', 'omit-touch', 'omit-unmap'}
    for variant, control in report['controls'].items():
        error = None
        try:
            validate_mapping_control(control['result'], folder / ('control-' + variant))
        except ValueError as problem:
            error = str(problem)
        assert error == control['expectedError'] == control['observedError']
    audited = json.loads((root / 'memory-audit.json').read_text())
    assert set(report['cases']) == set(audited) == {f'{n}-{m}' for n, m in CASES}
    for key, rows in report['cases'].items():
        assert len(rows) == len(audited[key]) == 16
        population, mode = map(int, key.split('-'))
        for index, (row, expected) in enumerate(zip(rows, audited[key])):
            round_number, position = divmod(index, 4)
            assert (row['round'], row['label']) == (round_number, order(round_number)[position])
            assert row['folder'] == f'{key}/{round_number}-{row["label"]}'
            part = folder / row['folder']
            recorded = json.loads((part / 'observation.json').read_text())
            assert recorded['failure'] is None and recorded['status'] == row['status'] == 0
            assert recorded['snapshots'] == row['snapshots'] and not row['stderr']
            assert row['stdout'] == (part / 'stdout.txt').read_text()
            assert row['stderr'] == (part / 'stderr.txt').read_text() == ''
            assert recorded['command'] == row['command']
            assert recorded['wait4PeakRssKiB'] == row['wait4PeakRssKiB']
            decode_output(row['stdout'], population, mode, int(row['command'][3]))
            assert 2 <= len(row['snapshots']) <= 600
            for snapshot_index, snapshot in enumerate(row['snapshots']):
                assert snapshot['index'] == snapshot_index
                assert set(snapshot['files']) == {'smaps', 'status', 'statm'}
                raw = {}
                for name, file in snapshot['files'].items():
                    assert file['file'] == f'{snapshot_index}-{name}.txt'
                    data = (part / file['file']).read_bytes()
                    assert hashlib.sha256(data).hexdigest() == file['sha256']
                    raw[name] = data.decode()
                parsed = mappings(raw['smaps'])
                assert summary(parsed) == snapshot['metrics']
                assert categories(parsed, Path(row['command'][0])) == snapshot['categories']
                assert fast_counters(raw['status'], raw['statm'], report['pageBytes']) == snapshot['fast']
            peak = max(s['metrics']['residentKiB'] for s in row['snapshots'])
            anonymous = max(s['metrics']['anonymousKiB'] for s in row['snapshots'])
            assert peak == row['observedResidentPeakKiB'] == expected['observedResidentPeakKiB']
            assert anonymous == row['observedAnonymousPeakKiB'] == expected['observedAnonymousPeakKiB']
            actual = dict(label=row['label'], round=row['round'], wait4PeakRssKiB=row['wait4PeakRssKiB'],
                observedResidentPeakKiB=peak, observedAnonymousPeakKiB=anonymous,
                snapshots=len(row['snapshots']),
                categoryResidentPeaksKiB={category: max(s['categories'][category]['residentKiB'] for s in row['snapshots'])
                                         for category in ('heap', 'stack', 'executable', 'otherFiles', 'otherMappings')},
                minimumFastMinusWalkKiB=min(s['fast']['VmRSSKiB'] - s['metrics']['residentKiB'] for s in row['snapshots']),
                maximumFastMinusWalkKiB=max(s['fast']['VmRSSKiB'] - s['metrics']['residentKiB'] for s in row['snapshots']))
            assert actual == expected
    return audited


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
                assert {key: sample[key] for key in raw} == raw, 'compiler sample differs from raw command'
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
