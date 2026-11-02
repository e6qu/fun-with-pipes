#!/usr/bin/env python3
"""Replay compact driver records and export every version, copy and sample position."""
import argparse
import csv
import gzip
import hashlib
import io
import json
from pathlib import Path
import re
import subprocess
from zipfile import ZipFile

import array_observation_boundaries as BOUNDARIES

ROOT = Path(__file__).resolve().parent.parent


def check(directory, mode):
    index = json.loads((directory / 'index.json').read_text())
    records = index['records']
    assert len(records) == 4 and {(r['machine'], r['session']) for r in records} == {
        (machine, session) for machine in ('aarch64', 'x86_64') for session in (1, 2)}
    previous_dir = ROOT / 'docs/measurements/array-consumption-2026-11-02'
    previous_index = json.loads((previous_dir / 'index.json').read_text())['records']
    table = []
    for entry in records:
        report = json.loads(gzip.decompress((directory / entry['report']).read_bytes()))
        files = json.loads(gzip.decompress((directory / entry['files']).read_bytes()))
        source = entry['source']
        assert entry['conclusion'] == 'success'
        assert report['source'] == entry['artifact']['workflow_run']['head_sha'] == source
        config = report['configuration']
        assert (config['session'], config['samples'], config['warmups'], config['processes'], config['timeout']) == (entry['session'], 24, 2, 4, 180)
        qualification = report['qualification']
        assert qualification['source'] == source and qualification['qualified'] and not qualification['failures']
        assert qualification['actual'] == qualification['expected'] and qualification['actual']['machine'] == entry['machine']
        for name, sha in report['sourceHashes'].items():
            assert hashlib.sha256(subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT)).hexdigest() == sha
        old, = [r for r in previous_index if (r['machine'], r['session']) == (entry['machine'], entry['session'])]
        prior = json.loads(gzip.decompress((previous_dir / old['report']).read_bytes()))
        assert report['previousArtifact'] == old['artifact']
        with ZipFile(directory / entry['raw']) as archive:
            assert set(archive.namelist()) == {name for name in files if not name.endswith(('.c', '.exe', '.zip')) and name != 'report.json'}
            for name in archive.namelist():
                assert hashlib.sha256(archive.read(name)).hexdigest() == files[name], name
            assert hashlib.sha256(json.dumps(report, indent=2).encode() + b'\n').hexdigest() == files['report.json']
            configuration = json.loads(archive.read('configuration.json'))
            assert all(report[key] == value for key, value in configuration.items())
            commands = {}
            for line in archive.read('commands.jsonl').splitlines():
                row = json.loads(line)
                name = row['artifact']
                assert name not in commands and not row['timedOut'] and row['elapsedNs'] > 0
                for stream in ('stdout', 'stderr'):
                    assert row[stream + 'Sha256'] == files[name + '.' + stream]
                status, stderr = 0, b''
                if name.endswith('missing-array-release-run'):
                    elements = int(name.split('/')[0].split('-')[1])
                    status, stderr = 224, f'unexpected charged storage: {8 * (8 * elements + 8)}, expected 0\n'.encode()
                elif name.endswith('failed-wall-clock-run'):
                    status, stderr = 1, b'clock_gettime failed\n'
                elif name.endswith('failed-cpu-clock-run'):
                    status, stderr = 1, b'process CPU clock failed\n'
                assert row['status'] == status, name
                if '/rss-' not in name:
                    assert archive.read(name + '.stderr') == stderr, name
                if name.endswith('-build'):
                    profile = name.endswith(('-profile-build', '-missing-array-release-build', '-failed-wall-clock-build', '-failed-cpu-clock-build'))
                    assert row['command'][1:10] == ['-O2', '-std=gnu11', '-ffp-contract=off',
                        '-march=' + config['c_arch'], '-w', '-fstack-usage', '-UFWP_NO_REUSE',
                        '-DPROFILE=' + str(int(profile)), '-DMATRIX_BENCH=0']
                    assert not archive.read(name + '.stdout')
                if status:
                    raw = archive.read(name + '.stdout')
                    if '/preparation-zero/' not in name:
                        assert raw == b'{"samples":[\n'
                    elif status == 1:
                        assert not raw
                    else:
                        partial = json.loads(raw + b']}')
                        assert partial['samples'] == [] and partial['preparation']['passes'] == 0
                        assert partial['preparation']['liveChargedBytes'] == 0
                commands[name] = row
            positions = {name: i for i, name in enumerate(commands)}
            first = min(i for name, i in positions.items() if '/warmup-' in name)
            assert all(i < first for name, i in positions.items() if name.endswith(('-build', '-run')))
            assert set(report['results']) == {'array-65537', 'array-262145'}
            for case, result in report['results'].items():
                elements = int(case.split('-')[1])
                assert result['elements'] == elements
                assert result['originalFailures'] == prior['results'][case]['originalFailures']
                assert result['previousSummary'] == prior['results'][case]['summary']
                checks = {}
                for version in BOUNDARIES.VERSIONS:
                    for program in ('fwp', 'reference'):
                        for observation_mode in ('profile', 'verify'):
                            key = version + '/' + program + '-' + observation_mode
                            checks[key] = BOUNDARIES.check_output(archive.read(case + '/' + key + '-run.stdout'),
                                elements, version, observation_mode == 'profile', observation_mode == 'verify')
                assert result['checks'] == checks
                for row in result['records']:
                    phase, number = row['phase'], row['round']
                    assert row == json.loads(archive.read(f'{case}/{phase}-{number}.json'))
                    for position, role in enumerate(BOUNDARIES.execution_order(number)):
                        raw = archive.read(f'{case}/{phase}-{number}-{position}.stdout')
                        output = BOUNDARIES.check_output(raw, elements, role[1], False, False)
                        assert row['observations'][position] == dict(role=list(role), output=output)
                assert result['summary'] == BOUNDARIES.summarize(result['records'])
                assert len(result['peakProcessRss']) == 12
                assert {tuple(r['role']) for r in result['peakProcessRss']} == set(BOUNDARIES.LABELS)
                for row in result['peakProcessRss']:
                    name = case + '/rss-' + '-'.join(map(str, row['role']))
                    BOUNDARIES.check_output(archive.read(name + '.stdout'), elements, row['role'][1], False, False)
                    size = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', archive.read(name + '.stderr'))[1]) * 1024
                    assert row['peakProcessRssBytes'] == size
                assert set(result['images']) == {version + '/' + program + '-' + kind
                    for version in BOUNDARIES.VERSIONS for program in ('fwp', 'reference') for kind in ('timing', 'profile', 'verify')}
                for name, image in result['images'].items():
                    assert files[case + '/' + name + '.exe'] == image['sha256']
                    assert files[case + '/' + name + '.c'] == image['sourceSha256']
                for name, stack in result['stack'].items():
                    raw = archive.read(case + '/' + name)
                    assert stack['sha256'] == hashlib.sha256(raw).hexdigest()
                    assert stack['entries'] == [dict(location=p, bytes=int(size), qualifier=q)
                        for p, size, q in (line.split('\t') for line in raw.decode().splitlines())]
                for role in result['summary']['roles']:
                    program, version, copy = role['role']
                    profile = checks[version + '/' + program + '-profile']['samples'][0]
                    metrics = role['metrics']
                    rss, = [r['peakProcessRssBytes'] for r in result['peakProcessRss'] if r['role'] == role['role']]
                    stack, = [r for name, data in result['stack'].items() if name.startswith(version + '/')
                        for r in data['entries'] if r['location'].endswith(':main') and
                        Path(r['location'].rsplit(':', 3)[0]).name == program + '-timing.c']
                    row = dict(machine=entry['machine'], session=entry['session'], elements=elements,
                        program=program, version=version, copy=copy)
                    for metric in (*BOUNDARIES.WALL_METRICS, 'kernelCpuNs'):
                        row[metric + 'PerArray'] = metrics[metric]['medianRoundTotal'] / 160 if metric in metrics else ''
                    for i, value in enumerate(metrics['kernelNs']['samplePositionMedians']):
                        row[f'kernelSample{i + 1}NsPerArray'] = value / 8
                    row['firstMinusLastKernelNsPerArray'] = metrics['kernelNs']['firstMinusLastMedian'] / 8
                    for metric in BOUNDARIES.OBSERVATIONS[1:]:
                        row[metric + 'PerRound'] = metrics[metric]['medianRoundTotal'] if metric in metrics else ''
                    for key in ('requests', 'requestedBytes', 'peakChargedBytes', 'liveChargedBytes', 'retains',
                                'nonlastReleases', 'releaseChecks', 'chunkHighWaterBytes', 'reservedVirtualBytes'):
                        row['measuredSample_' + key] = profile[key]
                    row.update(peakProcessRssBytes=rss,
                        instructionBytes=result['images'][version + '/' + program + '-timing']['instructionBytes'],
                        mainStackBytes=stack['bytes'], mainStackQualifier=stack['qualifier'])
                    table.append(row)
            assert json.loads(archive.read('results.json')) == report['results']
        print(entry['machine'], entry['session'], 'all driver samples, profiles and summaries agree')
    for entry in index['rejectedHosts']:
        raw = (directory / entry['qualification']).read_bytes()
        assert entry['artifact']['digest'] == 'sha256:' + hashlib.sha256(raw).hexdigest()
        with ZipFile(io.BytesIO(raw)) as archive:
            name, = archive.namelist()
            record = json.loads(archive.read(name))
        assert record['source'] == entry['artifact']['workflow_run']['head_sha']
        assert not record['qualified'] and record['failures']
        assert record['failures'] == [f'{key}: expected {value!r}, observed {record["actual"][key]!r}'
            for key, value in record['expected'].items() if record['actual'][key] != value]
    output = io.StringIO(newline='')
    writer = csv.DictWriter(output, fieldnames=list(table[0]), lineterminator='\n')
    writer.writeheader()
    writer.writerows(table)
    path = directory / 'all-roles.csv'
    if mode == 'write':
        path.write_text(output.getvalue())
    else:
        assert path.read_text() == output.getvalue(), 'table differs from raw records'
    print('All 96 roles retained; absent original observations are blank, not zero')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--mode', choices=('write', 'check'), required=True)
    args = parser.parse_args()
    check(args.directory, args.mode)


if __name__ == '__main__':
    main()
