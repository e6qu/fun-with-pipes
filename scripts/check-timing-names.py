#!/usr/bin/env python3
"""Audit every executable-name observation; report diagnostic ratios, never acceptance."""
import argparse
import gzip
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import statistics

SPEC = importlib.util.spec_from_file_location('numerical_schedule', Path(__file__).with_name('numerical-baselines.py'))
SCHEDULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SCHEDULE)
SOURCES = {'kernel': '37da74419046eb568d30cc8a96ab11208db7ca91',
           'derivative': '694e31b7aa9bcd5b7f94485416dda423ee398317'}
ROLES = {'kernel': ['c', 'rust', 'fwp', 'fwp-identical'],
         'derivative': ['candidate', 'reference', 'candidate-copy', 'reference-copy']}
ORIGINALS = {'kernel': ['c-timing', 'rust-timing', 'fwp-timing', 'fwp-timing'],
             'derivative': ['fwp-ad-history', 'fwp-ad-history-reference', 'fwp-ad-history', 'fwp-ad-history-reference']}
FIELDS = {'userSeconds', 'systemSeconds', 'minorFaults', 'majorFaults', 'voluntarySwitches', 'involuntarySwitches'}


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def audit(directory, source):
    expected_files = set()

    def read(name):
        expected_files.add(name)
        return (directory / name).read_bytes()

    def document(name):
        raw = read(name)
        return json.loads(gzip.decompress(raw) if name.endswith('.gz') else raw)

    config = document('configuration.json')
    assert config['source'] == source and config['decision'] == 'diagnostic-only'
    args = config['arguments']
    assert [args[key] for key in ['rounds', 'processes', 'seed', 'timeout', 'naming']] == [16, 4, 20261029, 180, 'paired']
    assert all(args[group + '_source'] == value for group, value in SOURCES.items())
    assert len(config['allowedCpus']) == len(set(config['allowedCpus'])) == 4
    assert config['settings'] == dict(FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    assert all(key in config['environmentKeys'] for key in config['settings']) and 'FWP_NO_OPT' not in config['environmentKeys']
    assert len(config['environmentSha256']) == 64 and int(config['environmentSha256'], 16) >= 0
    host = config['qualification']
    assert host['qualified'] and not host['failures'] and host['actual'] == host['expected']
    assert host['actual']['cpu'] == 'AMD EPYC 7763 64-Core Processor'
    assert host['actual']['cVersion'] == 'gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0'
    assert host['actual']['rustVersion'] == 'rustc 1.99.1 (58cf8f9c3 2026-10-13)'
    assert Path(config['workingDirectory']).is_absolute()
    output = Path(config['workingDirectory']) / args['output']
    programs = document('programs.json')
    assert set(programs) == {group + '-' + role for group in ROLES for role in ROLES[group]}
    reports, rows, identities = {}, {}, set()
    for group in ROLES:
        report = document(group + '-report.json.gz')
        assert report['source'] == SOURCES[group] and report['qualification']['actual'] == host['actual']
        reports[group] = report
        row = report['results']['array-65537' if group == 'kernel' else '3-0']
        rows[group] = row
        for index, (role, original) in enumerate(zip(ROLES[group], ORIGINALS[group])):
            entry = programs[group + '-' + role]
            assert entry['original'] == original
            named, equal = group + '/' + group + '-' + role + '.exe', group + f'/slot{index}exe'
            assert entry['named'] == str(output / named) and entry['equal'] == str(output / equal)
            identity = (entry['device'], entry['inode'])
            assert all(type(value) is int and value >= 0 for value in identity) and identity not in identities
            identities.add(identity)
            raw = read(named)
            assert raw == read(equal) and digest(raw) == entry['sha256'] == row['binaries'][original]['sha256']
            assert raw[:6] == b'\x7fELF\x02\x01' and int.from_bytes(raw[18:20], 'little') == 62
            extension = '.rs' if group == 'kernel' and role == 'rust' else '.c'
            code = gzip.decompress(read(group + '/' + original + extension + '.gz'))
            assert digest(code) == entry['sourceSha256'] == row['binaries'][original]['sourceSha256']
    processes = [json.loads(line) for line in read('processes.jsonl').splitlines()]
    observations = [json.loads(line) for line in read('observations.jsonl').splitlines()]
    assert len(processes) == len(observations) == 1024
    totals = {group: {policy: {role: {metric: [0] * 16 for metric in
        (['elapsedNs', 'cpuSeconds', 'kernelNs', 'allocationInclusiveNs'] if group == 'kernel' else ['elapsedNs', 'cpuSeconds'])}
        for role in ROLES[group]} for policy in ['named', 'equal']} for group in ROLES}
    cursor = 0
    for group in ROLES:
        for index in range(16):
            for policy in (['named', 'equal'] if index % 2 == 0 else ['equal', 'named']):
                for position, label in enumerate(SCHEDULE.execution_order(index, 20261029, 4)):
                    record, observed = processes[cursor], observations[cursor]
                    cursor += 1
                    role = ROLES[group][SCHEDULE.LABELS.index(label)]
                    for key, value in dict(group=group, round=index, policy=policy, position=position, label=label, role=role).items():
                        assert record[key] == value
                    assert set(record) == {'group', 'round', 'policy', 'position', 'label', 'role', 'command',
                        'status', 'timedOut', 'elapsedNs', 'resources', 'stdoutSha256', 'stderrSha256'}
                    assert record['status'] == 0 and record['timedOut'] is False
                    assert type(record['elapsedNs']) is int and record['elapsedNs'] > 0
                    entry = programs[group + '-' + role]
                    suffix = ['array'] if group == 'kernel' and label in ['c', 'rust'] else []
                    assert record['command'] == [entry[policy]] + suffix
                    resources = record['resources']
                    assert set(resources) == FIELDS
                    for key, value in resources.items():
                        assert type(value) in [int, float] and math.isfinite(value) and value >= 0
                        if not key.endswith('Seconds'):
                            assert type(value) is int
                    name = f'{group}-{index}-{policy}-{position}'
                    stdout = gzip.decompress(read(name + '.stdout.gz'))
                    stderr = gzip.decompress(read(name + '.stderr.gz'))
                    assert not stderr and digest(stderr) == record['stderrSha256'] and digest(stdout) == record['stdoutSha256']
                    cell = totals[group][policy][role]
                    cell['elapsedNs'][index] += record['elapsedNs']
                    cell['cpuSeconds'][index] += resources['userSeconds'] + resources['systemSeconds']
                    if group == 'kernel':
                        result = json.loads(stdout)
                        assert set(result) == {'samples'} and len(result['samples']) == 5
                        live = 'liveChargedBytes' if label.startswith('fwp') else 'livePayloadBytes'
                        for sample in result['samples']:
                            assert sample['hash'] == rows[group]['resultHash'] and sample[live] == 0
                            assert type(sample['kernelNs']) is int and sample['kernelNs'] > 0
                            assert type(sample['allocationInclusiveNs']) is int and sample['allocationInclusiveNs'] >= sample['kernelNs']
                            for metric in ['kernelNs', 'allocationInclusiveNs']:
                                cell[metric][index] += sample[metric]
                        assert observed == dict(record, samples=result['samples'])
                    else:
                        assert digest(stdout) == rows[group]['outputSha256']['fwp-ad-history']
                        assert observed == record
    assert document('complete.json') == dict(observations=1024, decision='diagnostic-only')
    assert {str(path.relative_to(directory)) for path in directory.rglob('*') if path.is_file()} == expected_files
    medians = {group: {policy: {role: {metric: statistics.median(values) for metric, values in metrics.items()}
        for role, metrics in roles.items()} for policy, roles in policies.items()} for group, policies in totals.items()}
    ratios = {}
    pairs = {'kernel': [('fwp', 'fwp-identical')], 'derivative':
             [('candidate', 'reference'), ('candidate', 'candidate-copy'), ('reference', 'reference-copy')]}
    for group in ROLES:
        ratios[group] = {policy: {a + '/' + b: {metric: medians[group][policy][a][metric] / medians[group][policy][b][metric]
            for metric in medians[group][policy][a]} for a, b in pairs[group]} for policy in ['named', 'equal']}
    return dict(source=source, decision='diagnostic-only', observations=cursor, ratios=ratios, medians=medians, roundTotals=totals)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    result = audit(args.directory, args.source)
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({key: result[key] for key in ['decision', 'observations', 'ratios']}, indent=2))


if __name__ == '__main__':
    main()
