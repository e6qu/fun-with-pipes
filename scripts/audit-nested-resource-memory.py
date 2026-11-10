#!/usr/bin/env python3
"""Reconstruct stopped service snapshots; reject edited reports with fresh hashes."""
import argparse
import hashlib
import json
from pathlib import Path

from nested_resource_memory import categories, fast_counters
from nested_resource_timing import order
from parser_process_memory import mappings, summary, validate_mapping_control
from weak_callback_timing import CASES, decode_output


def audit(folder, source, arch):
    manifest = json.loads((folder / 'manifest.json').read_text())
    assert set(manifest) == {str(p.relative_to(folder)) for p in folder.rglob('*')
                             if p.is_file() and p.name != 'manifest.json'}
    for name, value in manifest.items():
        path = folder / name
        assert path.resolve().is_relative_to(folder.resolve())
        assert hashlib.sha256(path.read_bytes()).hexdigest() == value
    report = json.loads((folder / 'report.json').read_text())
    assert report['observerSource'] == source and report['architecture'] == arch
    assert report['binarySource'] == 'd80357c8c81d206c9d9934b141b5a5fafe97c430' and not report['failures']
    settings = report['settings']
    assert (settings['rounds'], settings['interval_ms'], settings['deadline']) == (4, 50, 30)
    assert set(report['controls']) == {'ordinary', 'omit-touch', 'omit-unmap'}
    for variant, expected in (('ordinary', None), ('omit-touch', 'touch-control-missing'), ('omit-unmap', 'unmap-control-missing')):
        control = report['controls'][variant]
        observed = None
        try:
            validate_mapping_control(control['result'], folder / ('control-' + variant))
        except ValueError as error:
            observed = str(error)
        assert observed == expected == control['expectedError'] == control['observedError']
    assert set(report['binaries']) == {'reference', 'reference-copy', 'candidate', 'candidate-copy'}
    for binary in report['binaries'].values():
        assert hashlib.sha256(Path(binary['path']).read_bytes()).hexdigest() == binary['sha256']
    assert set(report['cases']) == {f'{n}-{m}' for n, m in CASES}
    result = {}
    for n, m in CASES:
        key = f'{n}-{m}'
        observations = report['cases'][key]
        assert len(observations) == 16
        result[key] = []
        for index, row in enumerate(observations):
            round_number, position = divmod(index, 4)
            assert (row['round'], row['label']) == (round_number, order(round_number)[position])
            assert row['folder'] == f'{key}/{round_number}-{row["label"]}'
            part = folder / row['folder']
            recorded = json.loads((part / 'observation.json').read_text())
            assert recorded['failure'] is None and recorded['status'] == row['status'] == 0
            for field in ('command', 'snapshots', 'wait4PeakRssKiB'):
                assert recorded[field] == row[field]
            assert row['command'][0] == report['binaries'][row['label']]['path']
            assert row['command'][1:3] == [str(n), str(m)]
            assert row['stdout'] == (part / 'stdout.txt').read_text()
            assert row['stderr'] == (part / 'stderr.txt').read_text() == ''
            decode_output(row['stdout'], n, m, int(row['command'][3]))
            assert 2 <= len(row['snapshots']) <= 600
            for index, snapshot in enumerate(row['snapshots']):
                assert snapshot['index'] == index and set(snapshot['files']) == {'smaps', 'status', 'statm'}
                raw = {}
                for name, file in snapshot['files'].items():
                    assert file['file'] == f'{index}-{name}.txt'
                    data = (part / file['file']).read_bytes()
                    assert hashlib.sha256(data).hexdigest() == file['sha256']
                    raw[name] = data.decode()
                mapped = mappings(raw['smaps'])
                assert summary(mapped) == snapshot['metrics']
                assert categories(mapped, Path(row['command'][0])) == snapshot['categories']
                assert fast_counters(raw['status'], raw['statm'], report['pageBytes']) == snapshot['fast']
            peak = max(s['metrics']['residentKiB'] for s in row['snapshots'])
            anon = max(s['metrics']['anonymousKiB'] for s in row['snapshots'])
            assert (peak, anon) == (row['observedResidentPeakKiB'], row['observedAnonymousPeakKiB'])
            result[key].append(dict(label=row['label'], round=round_number, wait4PeakRssKiB=row['wait4PeakRssKiB'],
                observedResidentPeakKiB=peak, observedAnonymousPeakKiB=anon,
                snapshots=len(row['snapshots']),
                categoryResidentPeaksKiB={category: max(s['categories'][category]['residentKiB'] for s in row['snapshots'])
                                          for category in ('heap', 'stack', 'executable', 'otherFiles', 'otherMappings')},
                minimumFastMinusWalkKiB=min(s['fast']['VmRSSKiB']-s['metrics']['residentKiB'] for s in row['snapshots']),
                maximumFastMinusWalkKiB=max(s['fast']['VmRSSKiB']-s['metrics']['residentKiB'] for s in row['snapshots'])))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--mode', choices=('audit', 'controls'), required=True)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', required=True)
    args = parser.parse_args()
    folder = args.input.resolve()
    result = audit(folder, args.source, args.arch)
    if args.mode == 'audit':
        args.output.write_text(json.dumps(result, indent=2) + '\n')
        print('128 original-binary executions, raw page walks and native omission controls reconstruct')
        return
    path, manifest_path = folder / 'report.json', folder / 'manifest.json'
    original, original_manifest = path.read_bytes(), manifest_path.read_bytes()
    observation_path = folder / '64-0/0-reference/observation.json'
    original_observation = observation_path.read_bytes()
    rejected = []
    for name in ('rss-summary', 'fast-counter', 'binary-hash'):
        try:
            report = json.loads(original)
            row = report['cases']['64-0'][0]
            if name == 'rss-summary':
                row['observedResidentPeakKiB'] += 1
            elif name == 'fast-counter':
                row['snapshots'][0]['fast']['VmRSSKiB'] += 1
                observation = json.loads(original_observation)
                observation['snapshots'][0]['fast']['VmRSSKiB'] += 1
                observation_path.write_text(json.dumps(observation, indent=2) + '\n')
            else:
                report['binaries']['candidate']['sha256'] = '0' * 64
            changed = (json.dumps(report, indent=2) + '\n').encode()
            path.write_bytes(changed)
            manifest = json.loads(original_manifest)
            manifest['report.json'] = hashlib.sha256(changed).hexdigest()
            manifest[str(observation_path.relative_to(folder))] = hashlib.sha256(observation_path.read_bytes()).hexdigest()
            manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
            try:
                audit(folder, args.source, args.arch)
            except AssertionError:
                rejected.append(name)
        finally:
            path.write_bytes(original)
            manifest_path.write_bytes(original_manifest)
            observation_path.write_bytes(original_observation)
    assert rejected == ['rss-summary', 'fast-counter', 'binary-hash']
    args.output.write_text(json.dumps(dict(rejected=rejected), indent=2) + '\n')
    print('All three altered reports rejected; original evidence restored')


if __name__ == '__main__':
    main()
