#!/usr/bin/env python3
"""Compare explicit preparation settings on verified retained array programs."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import time
from zipfile import ZipFile

import array_consumption_setup as SETUP
from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('array_audit', ROOT / 'scripts/check-array-construction-time.py')
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)
SOURCE = 'f8a558daa42fc07930f7a93870b6dcbcf2580bb3'
CASES = {'array-65537': 65537, 'array-262145': 262145}
PROTOCOL = 'roadmap/array-consumption-protocol-2026-11-02'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('archive', 'artifact', 'qualification', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('cc', 'c-arch', 'objdump', 'nm', 'time'):
        parser.add_argument('--' + name, required=True)
    for name in ('session', 'samples', 'warmups', 'processes', 'timeout', 'clock-pairs'):
        parser.add_argument('--' + name, type=int, required=True)
    parser.add_argument('--case', choices=tuple(CASES), action='append', required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert (args.samples, args.warmups, args.processes, args.timeout) == (16, 2, 4, 180)
    assert args.clock_pairs == 10000
    assert args.case == list(CASES) and args.session in (1, 2)
    qualification = json.loads(args.qualification.read_text())
    assert qualification['qualified'] and not qualification['failures']
    assert qualification['actual'] == qualification['expected']
    assert qualification['source'] == os.environ['GITHUB_SHA']
    machine = platform.machine()
    cpu, cc, arch, _ = AUDIT.HOSTS[machine]
    assert qualification['actual']['machine'] == machine
    assert qualification['actual']['cpu'] == cpu and qualification['actual']['processors'] == 4
    assert qualification['actual']['cVersion'] == cc
    assert subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0] == cc
    assert args.c_arch == arch
    assert len(os.sched_getaffinity(0)) == 4
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    for name in ('src', 'runtime', 'lib', 'tests', 'Cargo.toml', 'Cargo.lock', 'build.rs'):
        old = subprocess.check_output(['git', 'rev-parse', SOURCE + ':' + name], cwd=ROOT)
        current = subprocess.check_output(['git', 'rev-parse', 'HEAD:' + name], cwd=ROOT)
        assert old == current, name + ' differs from the verified source'
    artifact = json.loads(args.artifact.read_text())
    assert artifact['workflow_run']['head_sha'] == SOURCE
    assert artifact['digest'] == 'sha256:' + hashlib.sha256(args.archive.read_bytes()).hexdigest()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    shutil.copyfile(args.archive, out / 'original.zip')
    shutil.copyfile(args.artifact, out / 'original-artifact.json')
    protocol_source = subprocess.check_output(['git', 'rev-parse', PROTOCOL], cwd=ROOT, text=True).strip()
    protocol = subprocess.check_output(['git', 'show', PROTOCOL + ':docs/measurements/array-consumption-setup.md'], cwd=ROOT)
    (out / 'protocol.md').write_bytes(protocol)
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    environment.pop('FWP_NO_OPT', None)
    environment.pop('FWP_NO_REUSE', None)
    identity = dict(source=os.environ['GITHUB_SHA'], protocolSource=protocol_source,
        protocolSha256=hashlib.sha256(protocol).hexdigest(), originalSource=SOURCE,
        originalArtifact=artifact, qualification=qualification,
        configuration={key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()},
        executionEnvironment={key: environment[key] for key in sorted(environment) if key.startswith('FWP_')},
        allowedCpus=sorted(os.sched_getaffinity(0)),
        sourceHashes={name: hashlib.sha256((ROOT / name).read_bytes()).hexdigest() for name in (
            'scripts/array_consumption_setup.py', 'scripts/diagnose-array-consumption.py',
            'scripts/check-array-construction-time.py', 'scripts/array_construction_phases.py',
            'scripts/measure-kernel-baselines.py', 'scripts/numerical-baselines.py',
            'scripts/current_kernel_costs.py', 'scripts/prepare-scalar-array-reference.py',
            'scripts/process_wait.py')})
    (out / 'configuration.json').write_text(json.dumps(identity, indent=2) + '\n')

    def run(command, destination, expected):
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
        assert not timed_out and result.returncode == expected, (command, result.returncode, result.stderr.decode(errors='replace'))
        return result

    def build(source, binary, profile, destination):
        result = run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch,
            '-w', '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=' + str(int(profile)), '-DMATRIX_BENCH=0',
            source, '-o', binary, '-lm', '-lpthread'], destination, 0)
        assert not result.stderr

    with ZipFile(args.archive) as archive:
        original_report = AUDIT.check(archive, '', SOURCE, machine, args.session, 'scalar-captures')

    clock_code = SETUP.clock_source(args.clock_pairs)
    clock_path = out / 'empty-clocks.c'
    clock_path.write_text(clock_code)
    clock_binary = clock_path.with_suffix('.exe')
    build(clock_path, clock_binary, False, out / 'empty-clocks-build')
    clock_output = run([clock_binary], out / 'empty-clocks-run', 0)
    assert not clock_output.stderr
    clock_observation = json.loads(clock_output.stdout)
    assert set(clock_observation) == {'pairs', 'wallNs', 'cpuNs'}
    assert clock_observation['pairs'] == args.clock_pairs
    assert all(type(clock_observation[key]) is int and clock_observation[key] > 0 for key in ('wallNs', 'cpuNs'))
    for label, call, expected in (
            ('cpu', 'clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t)', b'process CPU clock failed\n'),
            ('wall', 'clock_gettime(CLOCK_MONOTONIC,&t)', b'wall clock failed\n')):
        changed = SETUP.PHASES.replace_once(clock_code, call, '(-1)')
        path = out / ('failed-' + label + '-clock.c')
        path.write_text(changed)
        binary = path.with_suffix('.exe')
        build(path, binary, False, out / ('failed-' + label + '-clock-build'))
        result = run([binary], out / ('failed-' + label + '-clock-run'), 1)
        assert not result.stdout and result.stderr == expected

    prepared = {}
    with ZipFile(args.archive) as archive:
        for case, elements in CASES.items():
            directory = out / case
            directory.mkdir()
            images, checks, programs = {}, {}, {}
            for program in ('fwp', 'reference'):
                generated = archive.read(case + ('/generated.c' if program == 'fwp' else '/reference-generated.c')).decode()
                marker = generated.index('/* reduce64 :')
                reducer = 'f' + generated[marker:].split('static V f', 1)[1].split('(', 1)[0]
                for mode in ('timing', 'profile', 'verify'):
                    original = archive.read(case + '/' + program + '-' + mode + '.c').decode()
                    code = SETUP.source(original, elements, reducer)
                    path = directory / (program + '-' + mode + '.c')
                    path.write_text(code)
                    binary = path.with_suffix('.exe')
                    build(path, binary, mode == 'profile', directory / (program + '-' + mode + '-build'))
                    raw = binary.read_bytes()
                    sections = run([args.objdump, '-h', binary], directory / (program + '-' + mode + '-sections'), 0)
                    symbols = run([args.nm, binary], directory / (program + '-' + mode + '-symbols'), 0)
                    assert not any(name in symbols.stdout for name in (b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'))
                    text_bytes = sum(int(size, 16) for size in re.findall(rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections.stdout, re.M))
                    assert text_bytes > 0
                    images[program + '-' + mode] = dict(path=binary.name, bytes=len(raw),
                        sha256=hashlib.sha256(raw).hexdigest(), instructionBytes=text_bytes,
                        sourceSha256=hashlib.sha256(path.read_bytes()).hexdigest())
                    if mode == 'timing':
                        programs[program] = binary
                        continue
                    for passes in (0, 1024):
                        label = program + '-' + mode + '-' + str(passes)
                        result = run([binary, passes], directory / label, 0)
                        assert not result.stderr
                        checks[label] = SETUP.check_output(result.stdout, elements, passes, mode == 'profile', mode == 'verify')
                    if mode == 'profile':
                        leak = SETUP.PHASES.replace_once(code,
                            'fwp_rc_free_arr(input); /* preparation-final-release control */',
                            '/* deliberately omit preparation release */')
                        failure = SETUP.PHASES.replace_once(code,
                            'clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &t)', '(-1)')
                        for label, changed, expected, stderr in (
                                ('missing-preparation-release', leak, 246, b'preparation retained storage or cleanup\n'),
                                ('failed-cpu-clock', failure, 1, b'process CPU clock failed\n')):
                            control = directory / (program + '-' + label + '.c')
                            control.write_text(changed)
                            control_binary = control.with_suffix('.exe')
                            build(control, control_binary, True, directory / (program + '-' + label + '-build'))
                            result = run([control_binary, 1024], directory / (program + '-' + label + '-run'), expected)
                            assert not result.stdout and result.stderr == stderr
            for program in ('fwp', 'reference'):
                copy = directory / (program + '-identical.exe')
                shutil.copyfile(programs[program], copy)
                copy.chmod(0o755)
                assert copy.read_bytes() == programs[program].read_bytes()
                programs[program + '-identical'] = copy
            prepared[case] = dict(programs=programs, checks=checks, images=images,
                originalFailures=original_report['failures'])
    # Every source/size/setting and negative control passes before collecting timings.
    results = {}
    for case, elements in CASES.items():
        directory = out / case
        ready = prepared[case]
        records = []
        for phase, count in (('warmup', 2), ('sample', 16)):
            for index in range(count):
                record = dict(phase=phase, round=index, complete=False, observations=[])
                try:
                    for position, (program, passes) in enumerate(SETUP.execution_order(index)):
                        result = run([ready['programs'][program], passes], directory / f'{phase}-{index}-{position}', 0)
                        assert not result.stderr
                        output = SETUP.check_output(result.stdout, elements, passes, False, False)
                        record['observations'].append(dict(role=[program, passes], output=output))
                    record['complete'] = True
                finally:
                    (directory / f'{phase}-{index}.json').write_text(json.dumps(record, indent=2) + '\n')
                records.append(record)
        rss = []
        for program, passes in SETUP.LABELS:
            result = run([args.time, '-v', ready['programs'][program], passes], directory / f'rss-{program}-{passes}', 0)
            SETUP.check_output(result.stdout, elements, passes, False, False)
            size = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', result.stderr)[1]) * 1024
            rss.append(dict(program=program, preparationPasses=passes, peakProcessRssBytes=size))
        stack = {path.name: dict(sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
            entries=[dict(location=p, bytes=int(size), qualifier=q) for p, size, q in
                (line.split('\t') for line in path.read_text().splitlines())]) for path in directory.glob('*.su')}
        results[case] = dict(elements=elements, records=records, checks=ready['checks'], images=ready['images'],
            originalFailures=ready['originalFailures'], peakProcessRss=rss, stack=stack, summary=SETUP.summarize(records))
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    report = dict(**identity, results=results, clockOverhead=clock_observation,
        decision='Descriptive preparation diagnostic; original timing limits unchanged')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('Both sizes and all explicit preparation settings completed; original timing limits remain unchanged')


if __name__ == '__main__':
    main()
