#!/usr/bin/env python3
"""Replay retained raw samples and counters; full native archives are audited separately."""
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

import array_consumption_setup as SETUP

ROOT = Path(__file__).resolve().parent.parent


def check(directory, mode):
    index = json.loads((directory / 'index.json').read_text())
    records = index['records']
    assert {(r['machine'], r['session']) for r in records} == {
        (machine, session) for machine in ('aarch64', 'x86_64') for session in (1, 2)}
    assert len(records) == 4
    prior_dir = ROOT / 'docs/measurements/scalar-array-captures-2026-11-02'
    prior_index = json.loads((prior_dir / 'index.json').read_text())['records']
    table = []
    for entry in records:
        report = json.loads(gzip.decompress((directory / entry['report']).read_bytes()))
        manifest = json.loads(gzip.decompress((directory / entry['files']).read_bytes()))
        source = entry['source']
        assert report['source'] == entry['artifact']['workflow_run']['head_sha'] == source
        assert entry['conclusion'] == 'success'
        assert report['configuration']['session'] == entry['session']
        config = report['configuration']
        assert (config['samples'], config['warmups'], config['processes'], config['timeout'], config['clock_pairs']) == (16, 2, 4, 180, 10000)
        assert report['qualification']['actual']['machine'] == entry['machine']
        assert report['qualification']['qualified'] and not report['qualification']['failures']
        assert report['qualification']['actual'] == report['qualification']['expected']
        for name, sha in report['sourceHashes'].items():
            assert hashlib.sha256(subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT)).hexdigest() == sha
        old, = [r for r in prior_index if (r['machine'], r['session']) == (entry['machine'], entry['session'])]
        prior = json.loads(gzip.decompress((prior_dir / old['report']).read_bytes()))
        assert report['originalArtifact'] == old['artifact']
        with ZipFile(directory / entry['raw']) as archive:
            names = set(archive.namelist())
            assert names == {name for name in manifest if not name.endswith(('.c', '.exe', '.zip')) and name != 'report.json'}
            for name in names:
                assert hashlib.sha256(archive.read(name)).hexdigest() == manifest[name], name
            assert hashlib.sha256(json.dumps(report, indent=2).encode() + b'\n').hexdigest() == manifest['report.json']
            configuration = json.loads(archive.read('configuration.json'))
            assert all(report[key] == value for key, value in configuration.items())
            commands = {}
            for line in archive.read('commands.jsonl').splitlines():
                row = json.loads(line)
                name = row['artifact']
                assert name not in commands and not row['timedOut'] and row['elapsedNs'] > 0
                for stream in ('stdout', 'stderr'):
                    assert row[stream + 'Sha256'] == manifest[name + '.' + stream]
                if name.endswith('missing-preparation-release-run'):
                    status, stderr = 246, b'preparation retained storage or cleanup\n'
                elif name.endswith('failed-cpu-clock-run'):
                    status, stderr = 1, b'process CPU clock failed\n'
                elif name == 'failed-wall-clock-run':
                    status, stderr = 1, b'wall clock failed\n'
                else:
                    status, stderr = 0, b''
                assert row['status'] == status
                if name.endswith('-build'):
                    profile = name.endswith('-profile-build') or ('/' in name and
                        name.endswith(('-missing-preparation-release-build', '-failed-cpu-clock-build')))
                    assert row['command'][1:10] == ['-O2', '-std=gnu11', '-ffp-contract=off',
                        '-march=' + config['c_arch'], '-w', '-fstack-usage', '-UFWP_NO_REUSE',
                        '-DPROFILE=' + str(int(profile)), '-DMATRIX_BENCH=0']
                if '/rss-' not in name:
                    assert archive.read(name + '.stderr') == stderr, name
                if status:
                    assert not archive.read(name + '.stdout')
                commands[name] = row
            clock = json.loads(archive.read('empty-clocks-run.stdout'))
            assert clock == report['clockOverhead'] and clock['pairs'] == 10000
            assert clock['wallNs'] > 0 and clock['cpuNs'] > 0
            assert set(report['results']) == {'array-65537', 'array-262145'}
            for case, result in report['results'].items():
                elements = int(case.split('-')[1])
                assert result['elements'] == elements and result['originalFailures'] == prior['failures']
                for label, expected in result['checks'].items():
                    program, observation_mode, passes = label.split('-')
                    assert program in ('fwp', 'reference') and observation_mode in ('profile', 'verify')
                    raw = archive.read(case + '/' + label + '.stdout')
                    assert SETUP.check_output(raw, elements, int(passes), observation_mode == 'profile', observation_mode == 'verify') == expected
                assert len(result['checks']) == 8
                assert set(result['images']) == {program + '-' + mode for program in ('fwp', 'reference') for mode in ('timing', 'profile', 'verify')}
                assert {(r['program'], r['preparationPasses']) for r in result['peakProcessRss']} == set(SETUP.LABELS)
                assert len(result['peakProcessRss']) == 8
                for row in result['records']:
                    phase, number = row['phase'], row['round']
                    assert row == json.loads(archive.read(f'{case}/{phase}-{number}.json'))
                    for position, (program, passes) in enumerate(SETUP.execution_order(number)):
                        raw = archive.read(f'{case}/{phase}-{number}-{position}.stdout')
                        output = SETUP.check_output(raw, elements, passes, False, False)
                        assert row['observations'][position] == dict(role=[program, passes], output=output)
                assert result['summary'] == SETUP.summarize(result['records'])
                for row in result['peakProcessRss']:
                    name = f"{case}/rss-{row['program']}-{row['preparationPasses']}"
                    SETUP.check_output(archive.read(name + '.stdout'), elements, row['preparationPasses'], False, False)
                    size = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', archive.read(name + '.stderr'))[1]) * 1024
                    assert row['peakProcessRssBytes'] == size
                for image, data in result['images'].items():
                    assert manifest[case + '/' + image + '.exe'] == data['sha256']
                    assert manifest[case + '/' + image + '.c'] == data['sourceSha256']
                for name, data in result['stack'].items():
                    raw = archive.read(case + '/' + name)
                    assert data['sha256'] == hashlib.sha256(raw).hexdigest()
                    assert data['entries'] == [dict(location=p, bytes=int(size), qualifier=q)
                        for p, size, q in (line.split('\t') for line in raw.decode().splitlines())]
                for role in result['summary']['roles']:
                    program, passes = role['program'], role['preparationPasses']
                    base = program.removesuffix('-identical')
                    profile = result['checks'][f'{base}-profile-{passes}']
                    metrics = role['metrics']
                    rss, = [r['peakProcessRssBytes'] for r in result['peakProcessRss']
                            if (r['program'], r['preparationPasses']) == (program, passes)]
                    stack, = [r for data in result['stack'].values() for r in data['entries']
                              if r['location'].endswith(':main') and
                              Path(r['location'].rsplit(':', 3)[0]).name == base + '-timing.c']
                    row = dict(machine=entry['machine'], session=entry['session'], elements=elements,
                        program=program, preparationPasses=passes)
                    for metric in ('constructionNs', 'kernelNs', 'kernelCpuNs', 'allocationInclusiveNs'):
                        row[metric + 'PerArray'] = metrics[metric]['medianRoundTotal'] / 160
                    row['firstKernelNsPerArray'] = metrics['kernelNs']['samplePositionMedians'][0] / 8
                    row['lastKernelNsPerArray'] = metrics['kernelNs']['samplePositionMedians'][4] / 8
                    row['firstMinusLastKernelNsPerArray'] = metrics['kernelNs']['firstMinusLastMedian'] / 8
                    for metric in ('minorFaults', 'majorFaults', 'voluntarySwitches', 'involuntarySwitches'):
                        row[metric + 'PerRound'] = metrics[metric]['medianRoundTotal']
                    for key in ('requests', 'requestedBytes', 'peakChargedBytes', 'liveChargedBytes', 'retains', 'nonlastReleases', 'releaseChecks'):
                        row['preparation_' + key] = profile['preparation'][key]
                        row['measuredSample_' + key] = profile['samples'][0][key]
                    for key in ('chunkHighWaterBytes', 'reservedVirtualBytes'):
                        row[key] = max(s[key] for s in profile['samples'])
                    row.update(peakProcessRssBytes=rss, instructionBytes=result['images'][base + '-timing']['instructionBytes'],
                        mainStackBytes=stack['bytes'], mainStackQualifier=stack['qualifier'],
                        emptyWallClockPairNs=clock['wallNs'] / clock['pairs'],
                        emptyCpuClockPairNs=clock['cpuNs'] / clock['pairs'])
                    table.append(row)
            assert json.loads(archive.read('results.json')) == report['results']
        print(entry['machine'], entry['session'], 'raw samples/counters/summaries agree; original failures retained')
    for entry in index['rejectedHosts']:
        raw = (directory / entry['qualification']).read_bytes()
        assert entry['artifact']['digest'] == 'sha256:' + hashlib.sha256(raw).hexdigest()
        with ZipFile(directory / entry['qualification']) as archive:
            name, = archive.namelist()
            record = json.loads(archive.read(name))
        assert record['source'] == entry['artifact']['workflow_run']['head_sha']
        assert not record['qualified'] and record['failures']
        assert record['failures'] == [f'{key}: expected {value!r}, observed {record["actual"][key]!r}'
            for key, value in record['expected'].items() if record['actual'][key] != value]
    print('Four compact records pass; full source/binary audit is recorded separately')
    output = io.StringIO(newline='')
    writer = csv.DictWriter(output, fieldnames=list(table[0]), lineterminator='\n')
    writer.writeheader()
    writer.writerows(table)
    path = directory / 'all-roles.csv'
    if mode == 'write':
        path.write_text(output.getvalue())
    else:
        assert path.read_text() == output.getvalue(), 'summary table differs from raw data'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--mode', choices=('write', 'check'), required=True)
    args = parser.parse_args()
    check(args.directory, args.mode)


if __name__ == '__main__':
    main()
