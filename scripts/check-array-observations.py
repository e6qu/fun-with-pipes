#!/usr/bin/env python3
"""Independently reconstruct all three array drivers and replay their raw evidence."""
import argparse
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import re
import subprocess
from zipfile import ZipFile

import array_observation_boundaries as BOUNDARIES

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('observation_runner', ROOT / 'scripts/diagnose-array-observations.py')
DIAG = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DIAG)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def check(read, source, machine, session):
    report = json.loads(read('report.json'))
    identity = json.loads(read('configuration.json'))
    assert all(report[key] == value for key, value in identity.items())
    assert report['source'] == source and report['previousSource'] == DIAG.SOURCE
    protocol_source = subprocess.check_output(['git', 'rev-parse', DIAG.PROTOCOL], cwd=ROOT, text=True).strip()
    assert report['protocolSource'] == protocol_source
    protocol = subprocess.check_output(['git', 'show', DIAG.PROTOCOL + ':docs/measurements/array-observation-boundaries.md'], cwd=ROOT)
    assert read('protocol.md') == protocol and report['protocolSha256'] == digest(protocol)
    for name, sha in report['sourceHashes'].items():
        assert digest(subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT)) == sha, name
        assert digest((ROOT / name).read_bytes()) == sha, 'Use matching audit dependencies: ' + name
    for name, tree in report['sourceTrees'].items():
        assert subprocess.check_output(['git', 'rev-parse', source + ':' + name], cwd=ROOT, text=True).strip() == tree
        assert subprocess.check_output(['git', 'rev-parse', DIAG.SOURCE + ':' + name], cwd=ROOT, text=True).strip() == tree
    assert set(report['sourceTrees']) == {'src', 'runtime', 'lib', 'tests', 'Cargo.toml', 'Cargo.lock', 'build.rs'}
    cpu, cc, arch, _ = DIAG.PREVIOUS.DIAG.AUDIT.HOSTS[machine]
    expected = dict(system='Linux', machine=machine, cpu=cpu, processors=4, cVersion=cc)
    qualification = report['qualification']
    assert qualification['actual'] == qualification['expected'] == expected
    assert qualification['source'] == source and qualification['qualified'] and not qualification['failures']
    assert len(report['allowedCpus']) == len(set(report['allowedCpus'])) == 4
    config = report['configuration']
    assert (config['session'], config['samples'], config['warmups'], config['processes'], config['timeout']) == (session, 24, 2, 4, 180)
    assert config['case'] == list(DIAG.CASES) and config['c_arch'] == arch
    assert report['executionEnvironment'] == dict(FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    previous = read('preparation.zip')
    artifact = json.loads(read('preparation-artifact.json'))
    assert report['previousArtifact'] == artifact
    assert artifact['workflow_run']['head_sha'] == DIAG.SOURCE
    assert artifact['digest'] == 'sha256:' + digest(previous)
    commands = {}
    for line in read('commands.jsonl').splitlines():
        row = json.loads(line)
        name = row['artifact']
        assert name not in commands and not row['timedOut'] and row['elapsedNs'] > 0
        for stream in ('stdout', 'stderr'):
            assert digest(read(name + '.' + stream)) == row[stream + 'Sha256']
        commands[name] = row
    assert next(iter(commands)) == 'array-65537/original/fwp-timing-build'
    out = Path(commands[next(iter(commands))]['command'][-3]).parents[2]
    assert out.is_absolute()
    used = set()

    def command(name, arguments, status, stderr):
        used.add(name)
        row = commands[name]
        assert row['command'] == list(map(str, arguments)), (name, row['command'], arguments)
        assert row['status'] == status, name
        if stderr is not None:
            assert read(name + '.stderr') == stderr, name
        return read(name + '.stdout')

    def build(name, code, profile):
        assert read(name + '.c').decode() == code, name
        arguments = [config['cc'], '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + arch,
            '-w', '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=' + str(int(profile)), '-DMATRIX_BENCH=0',
            out / (name + '.c'), '-o', out / (name + '.exe'), '-lm', '-lpthread']
        assert command(name + '-build', arguments, 0, b'') == b''

    def invocation(name, version):
        assert version in BOUNDARIES.VERSIONS
        return [out / (name + '.exe'), '0'] if version == 'preparation-zero' else [out / (name + '.exe')]

    with ZipFile(io.BytesIO(previous)) as prior:
        previous_report = DIAG.PREVIOUS.check(prior.read, DIAG.SOURCE, machine, session)
        with ZipFile(io.BytesIO(prior.read('original.zip'))) as original:
            assert set(report['results']) == set(DIAG.CASES)
            for case, elements in DIAG.CASES.items():
                row = report['results'][case]
                assert row['elements'] == elements
                assert row['originalFailures'] == previous_report['results'][case]['originalFailures']
                assert row['previousSummary'] == previous_report['results'][case]['summary']
                expected_checks, expected_images = {}, set()
                for version in BOUNDARIES.VERSIONS:
                    for program in ('fwp', 'reference'):
                        generated = original.read(case + ('/generated.c' if program == 'fwp' else '/reference-generated.c')).decode()
                        marker = generated.index('/* reduce64 :')
                        reducer = 'f' + generated[marker:].split('static V f', 1)[1].split('(', 1)[0]
                        for mode in ('timing', 'profile', 'verify'):
                            key = version + '/' + program + '-' + mode
                            name = case + '/' + key
                            saved = original.read(case + '/' + program + '-' + mode + '.c').decode()
                            if version == 'original':
                                code = saved
                            elif version == 'observed':
                                code = BOUNDARIES.observed_source(saved, elements, reducer)
                            else:
                                code = prior.read(case + '/' + program + '-' + mode + '.c').decode()
                                assert code == BOUNDARIES.PREPARATION.source(saved, elements, reducer)
                            build(name, code, mode == 'profile')
                            binary = read(name + '.exe')
                            image = row['images'][key]
                            expected_images.add(key)
                            assert image['sha256'] == digest(binary) and image['bytes'] == len(binary)
                            assert image['sourceSha256'] == digest(code.encode()) and image['path'] == key + '.exe'
                            sections = command(name + '-sections', [config['objdump'], '-h', out / (name + '.exe')], 0, b'')
                            symbols = command(name + '-symbols', [config['nm'], out / (name + '.exe')], 0, b'')
                            assert not any(symbol in symbols for symbol in (b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'))
                            sizes = re.findall(rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections, re.M)
                            assert image['instructionBytes'] == sum(int(size, 16) for size in sizes) > 0
                            if mode == 'timing':
                                assert binary == read(case + '/' + version + '/' + program + '-identical.exe')
                                continue
                            raw = command(name + '-run', invocation(name, version), 0, b'')
                            expected_checks[key] = BOUNDARIES.check_output(raw, elements, version, mode == 'profile', mode == 'verify')
                            if mode == 'profile':
                                controls = [('missing-array-release', BOUNDARIES.missing_array_release(code), 224,
                                    f'unexpected charged storage: {8 * (8 * elements + 8)}, expected 0\n'.encode()),
                                    ('failed-wall-clock', BOUNDARIES.failed_clock(code, 'wall'), 1, b'clock_gettime failed\n')]
                                if version != 'original':
                                    controls.append(('failed-cpu-clock', BOUNDARIES.failed_clock(code, 'cpu'), 1, b'process CPU clock failed\n'))
                                for label, changed, status, stderr in controls:
                                    control = case + '/' + version + '/' + program + '-' + label
                                    build(control, changed, True)
                                    raw = command(control + '-run', invocation(control, version), status, stderr)
                                    if version == 'preparation-zero' and status == 1:
                                        assert not raw
                                    elif version == 'preparation-zero':
                                        partial = json.loads(raw + b']}')
                                        assert partial['samples'] == [] and partial['preparation']['passes'] == 0
                                        assert partial['preparation']['liveChargedBytes'] == 0
                                    else:
                                        assert raw == b'{"samples":[\n'
                assert row['checks'] == expected_checks and set(row['images']) == expected_images
                records = []
                for phase, count in (('warmup', 2), ('sample', 24)):
                    for number in range(count):
                        record = json.loads(read(f'{case}/{phase}-{number}.json'))
                        observations = []
                        for position, (program, version, copy) in enumerate(BOUNDARIES.execution_order(number)):
                            binary = case + '/' + version + '/' + program + ('-identical' if copy else '-timing')
                            raw = command(f'{case}/{phase}-{number}-{position}', invocation(binary, version), 0, b'')
                            observations.append(dict(role=[program, version, copy], output=BOUNDARIES.check_output(raw, elements, version, False, False)))
                        assert record == dict(phase=phase, round=number, complete=True, observations=observations)
                        records.append(record)
                assert row['records'] == records and row['summary'] == BOUNDARIES.summarize(records)
                rss = []
                for label in BOUNDARIES.LABELS:
                    program, version, copy = label
                    name = case + '/rss-' + '-'.join(map(str, label))
                    binary = case + '/' + version + '/' + program + ('-identical' if copy else '-timing')
                    raw = command(name, [config['time'], '-v', *invocation(binary, version)], 0, None)
                    BOUNDARIES.check_output(raw, elements, version, False, False)
                    size = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', read(name + '.stderr'))[1]) * 1024
                    rss.append(dict(role=list(label), peakProcessRssBytes=size))
                assert row['peakProcessRss'] == rss and row['stack']
                for name, stack in row['stack'].items():
                    raw = read(case + '/' + name)
                    assert stack['sha256'] == digest(raw)
                    assert stack['entries'] == [dict(location=p, bytes=int(size), qualifier=q)
                        for p, size, q in (line.split('\t') for line in raw.decode().splitlines())]
    assert used == set(commands), set(commands) - used
    positions = {name: index for index, name in enumerate(commands)}
    first_timing = min(index for name, index in positions.items() if '/warmup-' in name)
    assert all(index < first_timing for name, index in positions.items()
               if name.endswith(('-build', '-run')))
    assert json.loads(read('results.json')) == report['results']
    assert report['decision'] == 'Descriptive driver comparison; original timing and copy limits unchanged'
    print(machine, session, 'complete three-driver archive audited; copy failures retained')
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=tuple(DIAG.PREVIOUS.DIAG.AUDIT.HOSTS), required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    args = parser.parse_args()
    check(lambda name: (args.directory / name).read_bytes(), args.source, args.machine, args.session)


if __name__ == '__main__':
    main()
