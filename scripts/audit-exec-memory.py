#!/usr/bin/env python3
"""Audit every ordinary/traced service observation without native image downloads."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import shutil
import tempfile

from exec_memory_records import review, validate_transient
from nested_resource_memory import MEMORY_ENVIRONMENTS
from nested_resource_timing import order
from weak_callback_timing import CASES, decode_output


def audit(folder, source, arch):
    report = json.loads((folder / 'report.json').read_text())
    assert report['source'] == source and report['architecture'] == arch
    binary_source = '33149ad2fd888a66ff36b8eb7f2c5b61faccfccb'
    assert report['binarySource'] == binary_source and report['originalRun'] == 46067853489
    assert (report['image'], report['libcPackage']) == MEMORY_ENVIRONMENTS[binary_source]
    artifact = report['originalArtifact']
    assert artifact['workflow_run']['head_sha'] == binary_source
    assert artifact['workflow_run']['id'] == report['originalRun']
    comparison = json.loads((folder / 'original-comparison.json').read_text())
    peers = json.loads((folder / 'original-peers.json').read_text())
    assert comparison['source'] == peers['source'] == binary_source
    assert comparison['architecture'] == peers['architecture'] == arch
    assert set(report['binaries']) == set(order(0))
    for label, row in report['binaries'].items():
        role = label.removesuffix('-copy')
        assert row['sha256'] == comparison['binaries'][role]['sha256']
    assert set(report['controls']) == {'transient', 'untouched', 'exec'}
    for mode, control in report['controls'].items():
        actual = review(folder / ('control-' + mode), control['hashes'], report['pageBytes'])
        assert actual == control['result'], 'control summary mismatch'
        if mode == 'transient':
            validate_transient(actual)
        elif mode == 'untouched':
            try:
                validate_transient(actual)
            except AssertionError as error:
                assert str(error) == 'touch-control-missing'
            else:
                raise AssertionError('untouched control accepted')
        else:
            assert actual['gnuTimePeakKiB'] > 30 * 1024 and actual['terminalHwmKiB'] < 8 * 1024
    assert set(report['cases']) == {f'{population}-{mode}' for population, mode in CASES}
    analysis = {}
    for population, mode in CASES:
        key = f'{population}-{mode}'
        rows = report['cases'][key]
        expected = [(round_number, label, path) for round_number in range(4)
                    for label in order(round_number)
                    for path in (('ordinary', 'traced') if round_number % 2 == 0 else ('traced', 'ordinary'))]
        assert [(row['round'], row['label'], row['path']) for row in rows] == expected, 'observation schedule mismatch'
        for row in rows:
            label, path = row['label'], row['path']
            assert row['folder'] == f"{key}/{row['round']}-{label}-{path}"
            part = folder / row['folder']
            expected_command = ['/usr/bin/time', '-f', '%M', '-o', None,
                                report['binaries'][label]['path'], str(population), str(mode),
                                str(peers['pilots'][key]['batches'])]
            record = json.loads((part / ('observation.json' if path == 'traced' else 'execution.json')).read_text())
            assert record['status'] == 0
            command = list(record['command'])
            assert command[4].endswith('/' + row['folder'] + '/rss.txt')
            command[4] = None
            assert command == expected_command, 'execution command mismatch'
            assert not (part / 'stderr.txt').read_text()
            decode_output((part / 'stdout.txt').read_text(), population, mode, peers['pilots'][key]['batches'])
            if path == 'traced':
                actual = review(part, [report['binaries'][label]['sha256']], report['pageBytes'])
                root_exec, = [event for event in record['events'] if event['pid'] == record['root'] and event['kind'] == 'exec']
                assert root_exec['snapshot']['executableSha256'] == report['timeSha256']
            else:
                actual = dict(gnuTimePeakKiB=int((part / 'rss.txt').read_text()))
            assert actual == row['result'], 'service summary mismatch'
            assert actual['gnuTimePeakKiB'] > 0
        analysis[key] = {}
        for path in ('ordinary', 'traced'):
            selected = [row for row in rows if row['path'] == path]
            values = {label: [row['result']['gnuTimePeakKiB'] for row in selected if row['label'] == label]
                      for label in order(0)}
            ratios = [values['candidate'][i] / values['reference'][i] for i in range(4)]
            copies = {role: [values[role + '-copy'][i] / values[role][i] for i in range(4)]
                      for role in ('reference', 'candidate')}
            analysis[key][path] = dict(samplesKiB=values, candidateOverReference=ratios, copyRatios=copies)
        analysis[key]['traceOverOrdinary'] = {
            label: [analysis[key]['traced']['samplesKiB'][label][i] / analysis[key]['ordinary']['samplesKiB'][label][i]
                    for i in range(4)] for label in order(0)}
        analysis[key]['lifetimeMinusTerminalHwmKiB'] = [row['result']['lifetimeMinusTerminalHwmKiB']
                                                       for row in rows if row['path'] == 'traced']
        analysis[key]['terminalFastMinusWalkKiB'] = [row['result']['terminalFastMinusWalkKiB']
                                                   for row in rows if row['path'] == 'traced']
    return analysis


def controls(folder, source, arch):
    # Copy just one raw execution per mutation, never native compiler images.
    report = json.loads((folder / 'report.json').read_text())
    row = next(row for row in report['cases']['64-0'] if row['path'] == 'traced')
    expected = [report['binaries'][row['label']]['sha256']]
    mutations = ('raw-counter', 'pid', 'wait', 'gnu-time', 'binary')
    rejected = {}
    for mutation in mutations:
        with tempfile.TemporaryDirectory() as name:
            part = Path(name) / 'case'
            shutil.copytree(folder / row['folder'], part)
            path = part / 'observation.json'
            record = json.loads(path.read_text())
            target = record['target']
            terminal = next(event for event in record['events'] if event['pid'] == target and event['kind'] == 'exit-stop')
            if mutation == 'raw-counter':
                snap = terminal['snapshot']
                data_path = part / snap['files']['status']['file']
                data = data_path.read_text().replace('VmRSS:', 'VmRSS: 4 kB\nMissing:')
                data_path.write_text(data)
                snap['files']['status']['sha256'] = hashlib.sha256(data.encode()).hexdigest()
            elif mutation == 'pid':
                terminal['pid'] = record['root']
            elif mutation == 'wait':
                next(event for event in record['events'] if event['pid'] == target and event['kind'] == 'reaped')['wait4PeakRssKiB'] += 4
            elif mutation == 'gnu-time':
                (part / 'rss.txt').write_text(str(int((part / 'rss.txt').read_text()) + 4))
            else:
                next(event for event in record['events'] if event['pid'] == target and event['kind'] == 'exec')['snapshot']['executableSha256'] = '0' * 64
            path.write_text(json.dumps(record))
            try:
                review(part, expected, report['pageBytes'])
            except AssertionError as error:
                rejected[mutation] = str(error)
            else:
                raise AssertionError('altered observation accepted: ' + mutation)
    assert len(rejected) == len(mutations)
    return rejected


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', required=True)
    parser.add_argument('--mode', choices=('audit', 'controls'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    analysis = audit(args.input, args.source, args.arch)
    result = analysis if args.mode == 'audit' else controls(args.input, args.source, args.arch)
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print('Reconstructed 256 service executions, all lifecycle snapshots and three controls;', args.mode, 'passes')


if __name__ == '__main__':
    main()
