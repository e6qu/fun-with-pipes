#!/usr/bin/env python3
"""Compare original, observation-only and zero-preparation array drivers."""
import argparse
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import time
from zipfile import ZipFile

import array_observation_boundaries as BOUNDARIES
from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('preparation_audit', ROOT / 'scripts/check-array-consumption.py')
PREVIOUS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PREVIOUS)
SOURCE = '87d4f6b099b755a52cd091b6c07cb57bb456af77'
PROTOCOL = 'roadmap/array-observation-protocol-2026-11-02'
CASES = {'array-65537': 65537, 'array-262145': 262145}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('archive', 'artifact', 'qualification', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('cc', 'c-arch', 'objdump', 'nm', 'time'):
        parser.add_argument('--' + name, required=True)
    for name in ('session', 'samples', 'warmups', 'processes', 'timeout'):
        parser.add_argument('--' + name, type=int, required=True)
    parser.add_argument('--case', choices=tuple(CASES), action='append', required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert (args.samples, args.warmups, args.processes, args.timeout) == (24, 2, 4, 180)
    assert args.case == list(CASES) and args.session in (1, 2)
    qualification = json.loads(args.qualification.read_text())
    assert qualification['qualified'] and not qualification['failures']
    assert qualification['source'] == os.environ['GITHUB_SHA']
    machine = platform.machine()
    cpu, cc, arch, _ = PREVIOUS.DIAG.AUDIT.HOSTS[machine]
    expected = dict(system='Linux', machine=machine, cpu=cpu, processors=4, cVersion=cc)
    assert qualification['actual'] == qualification['expected'] == expected
    assert subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0] == cc
    assert args.c_arch == arch and len(os.sched_getaffinity(0)) == 4
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    trees = {}
    for name in ('src', 'runtime', 'lib', 'tests', 'Cargo.toml', 'Cargo.lock', 'build.rs'):
        old = subprocess.check_output(['git', 'rev-parse', SOURCE + ':' + name], cwd=ROOT, text=True).strip()
        current = subprocess.check_output(['git', 'rev-parse', 'HEAD:' + name], cwd=ROOT, text=True).strip()
        assert old == current, name + ' differs from the verified source'
        trees[name] = current
    artifact = json.loads(args.artifact.read_text())
    assert artifact['workflow_run']['head_sha'] == SOURCE
    assert artifact['digest'] == 'sha256:' + hashlib.sha256(args.archive.read_bytes()).hexdigest()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    shutil.copyfile(args.archive, out / 'preparation.zip')
    shutil.copyfile(args.artifact, out / 'preparation-artifact.json')
    protocol_source = subprocess.check_output(['git', 'rev-parse', PROTOCOL], cwd=ROOT, text=True).strip()
    protocol = subprocess.check_output(['git', 'show', PROTOCOL + ':docs/measurements/array-observation-boundaries.md'], cwd=ROOT)
    (out / 'protocol.md').write_bytes(protocol)
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    environment.pop('FWP_NO_OPT', None)
    environment.pop('FWP_NO_REUSE', None)
    sources = (
        'scripts/array_observation_boundaries.py', 'scripts/diagnose-array-observations.py',
        'scripts/array_consumption_setup.py', 'scripts/check-array-consumption.py',
        'scripts/diagnose-array-consumption.py', 'scripts/check-array-construction-time.py',
        'scripts/array_construction_phases.py', 'scripts/measure-kernel-baselines.py',
        'scripts/numerical-baselines.py', 'scripts/current_kernel_costs.py',
        'scripts/prepare-scalar-array-reference.py', 'scripts/process_wait.py')
    identity = dict(source=os.environ['GITHUB_SHA'], sourceTrees=trees,
        protocolSource=protocol_source, protocolSha256=hashlib.sha256(protocol).hexdigest(),
        previousSource=SOURCE, previousArtifact=artifact, qualification=qualification,
        configuration={key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()},
        executionEnvironment={key: environment[key] for key in sorted(environment) if key.startswith('FWP_')},
        allowedCpus=sorted(os.sched_getaffinity(0)),
        sourceHashes={name: hashlib.sha256((ROOT / name).read_bytes()).hexdigest() for name in sources})
    (out / 'configuration.json').write_text(json.dumps(identity, indent=2) + '\n')

    def run(command, destination, expected_status):
        started = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(list(map(str, command)), timeout=args.timeout, env=environment,
                cwd=None, input_data=None, input_stream=None, text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - started
        destination.with_suffix(destination.suffix + '.stdout').write_bytes(result.stdout)
        destination.with_suffix(destination.suffix + '.stderr').write_bytes(result.stderr)
        record = dict(artifact=str(destination.relative_to(out)), command=list(map(str, command)),
            status=result.returncode, timedOut=timed_out, elapsedNs=elapsed,
            stdoutSha256=hashlib.sha256(result.stdout).hexdigest(), stderrSha256=hashlib.sha256(result.stderr).hexdigest())
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(record) + '\n')
        assert not timed_out and result.returncode == expected_status, (command, result.returncode, result.stderr.decode(errors='replace'))
        return result

    def build(source, binary, profile, destination):
        result = run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch,
            '-w', '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=' + str(int(profile)), '-DMATRIX_BENCH=0',
            source, '-o', binary, '-lm', '-lpthread'], destination, 0)
        assert not result.stdout and not result.stderr

    def invocation(binary, version):
        assert version in BOUNDARIES.VERSIONS
        return [binary, '0'] if version == 'preparation-zero' else [binary]

    prepared = {}
    with ZipFile(args.archive) as prior:
        previous_report = PREVIOUS.check(prior.read, SOURCE, machine, args.session)
        with ZipFile(io.BytesIO(prior.read('original.zip'))) as original:
            for case, elements in CASES.items():
                directory = out / case
                directory.mkdir()
                images, checks, programs = {}, {}, {}
                for version in BOUNDARIES.VERSIONS:
                    part = directory / version
                    part.mkdir()
                    for program in ('fwp', 'reference'):
                        generated = original.read(case + ('/generated.c' if program == 'fwp' else '/reference-generated.c')).decode()
                        marker = generated.index('/* reduce64 :')
                        reducer = 'f' + generated[marker:].split('static V f', 1)[1].split('(', 1)[0]
                        for mode in ('timing', 'profile', 'verify'):
                            saved = original.read(case + '/' + program + '-' + mode + '.c').decode()
                            if version == 'original':
                                code = saved
                            elif version == 'observed':
                                code = BOUNDARIES.observed_source(saved, elements, reducer)
                            else:
                                code = prior.read(case + '/' + program + '-' + mode + '.c').decode()
                                assert code == BOUNDARIES.PREPARATION.source(saved, elements, reducer)
                            path = part / (program + '-' + mode + '.c')
                            path.write_text(code)
                            binary = path.with_suffix('.exe')
                            build(path, binary, mode == 'profile', part / (program + '-' + mode + '-build'))
                            raw = binary.read_bytes()
                            sections = run([args.objdump, '-h', binary], part / (program + '-' + mode + '-sections'), 0)
                            symbols = run([args.nm, binary], part / (program + '-' + mode + '-symbols'), 0)
                            assert not sections.stderr and not symbols.stderr
                            assert not any(name in symbols.stdout for name in (b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'))
                            text_bytes = sum(int(size, 16) for size in re.findall(rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections.stdout, re.M))
                            assert text_bytes > 0
                            key = version + '/' + program + '-' + mode
                            images[key] = dict(path=str(binary.relative_to(directory)), bytes=len(raw),
                                sha256=hashlib.sha256(raw).hexdigest(), instructionBytes=text_bytes,
                                sourceSha256=hashlib.sha256(path.read_bytes()).hexdigest())
                            if mode == 'timing':
                                programs[(program, version, 0)] = invocation(binary, version)
                                continue
                            result = run(invocation(binary, version), part / (program + '-' + mode + '-run'), 0)
                            assert not result.stderr
                            checks[key] = BOUNDARIES.check_output(result.stdout, elements, version, mode == 'profile', mode == 'verify')
                            if mode == 'profile':
                                controls = [('missing-array-release', BOUNDARIES.missing_array_release(code), 224,
                                    f'unexpected charged storage: {8 * (8 * elements + 8)}, expected 0\n'.encode())]
                                controls.append(('failed-wall-clock', BOUNDARIES.failed_clock(code, 'wall'), 1, b'clock_gettime failed\n'))
                                if version != 'original':
                                    controls.append(('failed-cpu-clock', BOUNDARIES.failed_clock(code, 'cpu'), 1, b'process CPU clock failed\n'))
                                for label, changed, status, stderr in controls:
                                    control = part / (program + '-' + label + '.c')
                                    control.write_text(changed)
                                    control_binary = control.with_suffix('.exe')
                                    build(control, control_binary, True, part / (program + '-' + label + '-build'))
                                    broken = run(invocation(control_binary, version), part / (program + '-' + label + '-run'), status)
                                    assert broken.stderr == stderr
                                    if version == 'preparation-zero' and status == 1:
                                        assert not broken.stdout
                                    elif version == 'preparation-zero':
                                        partial = json.loads(broken.stdout + b']}')
                                        assert partial['samples'] == [] and partial['preparation']['passes'] == 0
                                        assert partial['preparation']['liveChargedBytes'] == 0
                                    else:
                                        assert broken.stdout == b'{"samples":[\n'
                        binary = programs[(program, version, 0)][0]
                        copy = part / (program + '-identical.exe')
                        shutil.copyfile(binary, copy)
                        copy.chmod(0o755)
                        assert copy.read_bytes() == binary.read_bytes()
                        programs[(program, version, 1)] = invocation(copy, version)
                prepared[case] = dict(programs=programs, checks=checks, images=images,
                    originalFailures=previous_report['results'][case]['originalFailures'],
                    previousSummary=previous_report['results'][case]['summary'])
    # Every version/program/size and failure control completes before timing.
    results = {}
    for case, elements in CASES.items():
        directory = out / case
        ready = prepared[case]
        records = []
        for phase, count in (('warmup', 2), ('sample', 24)):
            for number in range(count):
                record = dict(phase=phase, round=number, complete=False, observations=[])
                try:
                    for position, label in enumerate(BOUNDARIES.execution_order(number)):
                        result = run(ready['programs'][label], directory / f'{phase}-{number}-{position}', 0)
                        assert not result.stderr
                        output = BOUNDARIES.check_output(result.stdout, elements, label[1], False, False)
                        record['observations'].append(dict(role=list(label), output=output))
                    record['complete'] = True
                finally:
                    (directory / f'{phase}-{number}.json').write_text(json.dumps(record, indent=2) + '\n')
                records.append(record)
        rss = []
        for label in BOUNDARIES.LABELS:
            result = run([args.time, '-v', *ready['programs'][label]], directory / ('rss-' + '-'.join(map(str, label))), 0)
            BOUNDARIES.check_output(result.stdout, elements, label[1], False, False)
            size = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', result.stderr)[1]) * 1024
            rss.append(dict(role=list(label), peakProcessRssBytes=size))
        stack = {str(path.relative_to(directory)): dict(sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            entries=[dict(location=p, bytes=int(size), qualifier=q) for p, size, q in
                (line.split('\t') for line in path.read_text().splitlines())]) for path in directory.glob('*/*.su')}
        results[case] = dict(elements=elements, records=records, checks=ready['checks'], images=ready['images'],
            originalFailures=ready['originalFailures'], previousSummary=ready['previousSummary'],
            peakProcessRss=rss, stack=stack, summary=BOUNDARIES.summarize(records))
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    report = dict(**identity, results=results,
        decision='Descriptive driver comparison; original timing and copy limits unchanged')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('All driver versions completed; original timing and copy limits remain unchanged')


if __name__ == '__main__':
    main()
