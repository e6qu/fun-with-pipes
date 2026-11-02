#!/usr/bin/env python3
"""Recompute preparation diagnostics from all raw commands and original sources."""
import argparse
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import re
import subprocess
from zipfile import ZipFile

import array_consumption_setup as SETUP

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('diagnostic', ROOT / 'scripts/diagnose-array-consumption.py')
DIAG = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DIAG)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def check(read, source, machine, session):
    report = json.loads(read('report.json'))
    identity = json.loads(read('configuration.json'))
    assert all(report[key] == value for key, value in identity.items())
    assert report['source'] == source and report['originalSource'] == DIAG.SOURCE
    assert report['protocolSource'] == subprocess.check_output(
        ['git', 'rev-parse', DIAG.PROTOCOL], cwd=ROOT, text=True).strip()
    protocol = subprocess.check_output(['git', 'show', DIAG.PROTOCOL + ':docs/measurements/array-consumption-setup.md'], cwd=ROOT)
    assert read('protocol.md') == protocol and digest(protocol) == report['protocolSha256']
    for name, sha in report['sourceHashes'].items():
        assert digest(subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT)) == sha, name
        assert digest((ROOT / name).read_bytes()) == sha, 'Audit with matching scripts: ' + name
    assert len(report['allowedCpus']) == len(set(report['allowedCpus'])) == 4
    cpu, cc, arch, _ = DIAG.AUDIT.HOSTS[machine]
    qualification = report['qualification']
    expected = dict(system='Linux', machine=machine, cpu=cpu, processors=4, cVersion=cc)
    assert qualification['source'] == source and qualification['qualified'] and not qualification['failures']
    assert qualification['actual'] == qualification['expected'] == expected
    config = report['configuration']
    assert (config['session'], config['samples'], config['warmups'], config['processes'], config['timeout'], config['clock_pairs']) == (session, 16, 2, 4, 180, 10000)
    assert config['case'] == list(DIAG.CASES) and config['c_arch'] == arch
    assert report['executionEnvironment'] == dict(FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    original = read('original.zip')
    artifact = json.loads(read('original-artifact.json'))
    assert artifact == report['originalArtifact']
    assert artifact['workflow_run']['head_sha'] == DIAG.SOURCE
    assert artifact['digest'] == 'sha256:' + digest(original)
    commands = {}
    for line in read('commands.jsonl').splitlines():
        command = json.loads(line)
        name = command['artifact']
        assert name not in commands and not command['timedOut'] and command['elapsedNs'] > 0
        for stream in ('stdout', 'stderr'):
            assert digest(read(name + '.' + stream)) == command[stream + 'Sha256']
        commands[name] = command
    used = set()

    def command(name, arguments, status, stderr):
        used.add(name)
        row = commands[name]
        assert row['command'] == list(map(str, arguments)), (name, row['command'], arguments)
        assert row['status'] == status, name
        if stderr is not None:
            assert read(name + '.stderr') == stderr, name
        return read(name + '.stdout')

    # Recover the absolute output path used on the runner.
    out = Path(commands['empty-clocks-build']['command'][-3]).parent
    assert out.is_absolute()

    def build(name, code, profile):
        assert read(name + '.c').decode() == code, name
        arguments = [config['cc'], '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + arch,
            '-w', '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=' + str(int(profile)), '-DMATRIX_BENCH=0',
            out / (name + '.c'), '-o', out / (name + '.exe'), '-lm', '-lpthread']
        assert command(name + '-build', arguments, 0, b'') == b''

    clock = SETUP.clock_source(10000)
    build('empty-clocks', clock, False)
    clocks = json.loads(command('empty-clocks-run', [out / 'empty-clocks.exe'], 0, b''))
    assert clocks == report['clockOverhead'] and clocks['pairs'] == 10000
    assert all(type(clocks[k]) is int and clocks[k] > 0 for k in ('wallNs', 'cpuNs'))
    for label, call, stderr in (
            ('cpu', 'clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t)', b'process CPU clock failed\n'),
            ('wall', 'clock_gettime(CLOCK_MONOTONIC,&t)', b'wall clock failed\n')):
        name = 'failed-' + label + '-clock'
        build(name, SETUP.PHASES.replace_once(clock, call, '(-1)'), False)
        assert command(name + '-run', [out / (name + '.exe')], 1, stderr) == b''
    with ZipFile(io.BytesIO(original)) as archive:
        prior = DIAG.AUDIT.check(archive, '', DIAG.SOURCE, machine, session, 'scalar-captures')
        assert set(report['results']) == set(DIAG.CASES)
        for case, elements in DIAG.CASES.items():
            row = report['results'][case]
            assert row['elements'] == elements and row['originalFailures'] == prior['failures']
            expected_checks = {}
            for program in ('fwp', 'reference'):
                generated = archive.read(case + ('/generated.c' if program == 'fwp' else '/reference-generated.c')).decode()
                marker = generated.index('/* reduce64 :')
                reducer = 'f' + generated[marker:].split('static V f', 1)[1].split('(', 1)[0]
                for mode in ('timing', 'profile', 'verify'):
                    name = case + '/' + program + '-' + mode
                    code = SETUP.source(archive.read(name + '.c').decode(), elements, reducer)
                    build(name, code, mode == 'profile')
                    binary = read(name + '.exe')
                    image = row['images'][program + '-' + mode]
                    assert image['sha256'] == digest(binary) and image['bytes'] == len(binary)
                    assert image['sourceSha256'] == digest(code.encode()) and image['path'] == program + '-' + mode + '.exe'
                    sections = command(name + '-sections', [config['objdump'], '-h', out / (name + '.exe')], 0, b'')
                    symbols = command(name + '-symbols', [config['nm'], out / (name + '.exe')], 0, b'')
                    assert not any(symbol in symbols for symbol in (b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'))
                    sizes = re.findall(rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections, re.M)
                    assert image['instructionBytes'] == sum(int(size, 16) for size in sizes) > 0
                    if mode == 'timing':
                        assert binary == read(case + '/' + program + '-identical.exe')
                        continue
                    for passes in (0, 1024):
                        label = program + '-' + mode + '-' + str(passes)
                        raw = command(case + '/' + label, [out / (name + '.exe'), passes], 0, b'')
                        expected_checks[label] = SETUP.check_output(raw, elements, passes, mode == 'profile', mode == 'verify')
                    if mode == 'profile':
                        for label, before, after, status, stderr in (
                                ('missing-preparation-release', 'fwp_rc_free_arr(input); /* preparation-final-release control */', '/* deliberately omit preparation release */', 246, b'preparation retained storage or cleanup\n'),
                                ('failed-cpu-clock', 'clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t)', '(-1)', 1, b'process CPU clock failed\n')):
                            control = case + '/' + program + '-' + label
                            build(control, SETUP.PHASES.replace_once(code, before, after), True)
                            assert command(control + '-run', [out / (control + '.exe'), 1024], status, stderr) == b''
            assert row['checks'] == expected_checks
            records = []
            for phase, count in (('warmup', 2), ('sample', 16)):
                for index in range(count):
                    record = json.loads(read(f'{case}/{phase}-{index}.json'))
                    observations = []
                    for position, (program, passes) in enumerate(SETUP.execution_order(index)):
                        raw = command(f'{case}/{phase}-{index}-{position}',
                            [out / case / (program + ('' if program.endswith('-identical') else '-timing') + '.exe'), passes], 0, b'')
                        observations.append(dict(role=[program, passes], output=SETUP.check_output(raw, elements, passes, False, False)))
                    assert record == dict(phase=phase, round=index, complete=True, observations=observations)
                    records.append(record)
            assert row['records'] == records and row['summary'] == SETUP.summarize(records)
            rss = []
            for program, passes in SETUP.LABELS:
                name = f'{case}/rss-{program}-{passes}'
                raw = command(name, [config['time'], '-v', out / case / (program + ('' if program.endswith('-identical') else '-timing') + '.exe'), passes], 0, None)
                SETUP.check_output(raw, elements, passes, False, False)
                size = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', read(name + '.stderr'))[1]) * 1024
                rss.append(dict(program=program, preparationPasses=passes, peakProcessRssBytes=size))
            assert row['peakProcessRss'] == rss and row['stack']
            for name, stack in row['stack'].items():
                raw = read(case + '/' + name)
                assert stack['sha256'] == digest(raw)
                assert stack['entries'] == [dict(location=p, bytes=int(size), qualifier=q)
                    for p, size, q in (line.split('\t') for line in raw.decode().splitlines())]
    assert used == set(commands), set(commands) - used
    positions = {name: index for index, name in enumerate(commands)}
    first = min(index for name, index in positions.items() if '/warmup-' in name)
    assert all(index < first for name, index in positions.items()
               if name.endswith(('-build', '-run', '-profile-0', '-profile-1024', '-verify-0', '-verify-1024')))
    assert json.loads(read('results.json')) == report['results']
    assert report['decision'] == 'Descriptive preparation diagnostic; original timing limits unchanged'
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=tuple(DIAG.AUDIT.HOSTS), required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    args = parser.parse_args()
    check(lambda name: (args.directory / name).read_bytes(), args.source, args.machine, args.session)
    print('Complete raw preparation diagnostic audited; original timing limits unchanged')


if __name__ == '__main__':
    main()
