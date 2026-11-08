#!/usr/bin/env python3
"""Measure captured-map work, then observe memory and compiler costs separately."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import shutil
import struct
import subprocess
import time

from borrowed_array_reference import captured_reference_source
from captured_map_costs import ROOT, cases, driver, expected, program, raw_program
from process_wait import run_capture

SPEC = importlib.util.spec_from_file_location('costs', ROOT / 'scripts/measure-borrowed-arrays.py')
COSTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COSTS)
OBS_SPEC = importlib.util.spec_from_file_location('observations', ROOT / 'scripts/observe-array-costs.py')
OBS = importlib.util.module_from_spec(OBS_SPEC)
OBS_SPEC.loader.exec_module(OBS)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('compiler', 'reference', 'reference-manifest', 'host', 'time', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--c-arch', required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[platform.machine()]
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], check=True)
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip()
    host = json.loads(args.host.read_text())
    assert host['qualified'] and host['source'] == source
    manifest = json.loads(args.reference_manifest.read_text())
    implementation = (ROOT / 'src/cgen/owned_numeric.rs').read_text()
    assert manifest['source'] == source and manifest['disabled'] == 'captured-maps'
    assert manifest['candidateSha256'] == hashlib.sha256(implementation.encode()).hexdigest()
    assert manifest['referenceSha256'] == hashlib.sha256(captured_reference_source(implementation).encode()).hexdigest()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, LC_ALL='C', FWP_LTO='0', FWP_STACK='1',
                       FWP_ARRAY_FUSION='1', FWP_PACKED_ARRAYS='1', FWP_VRET='1', FWP_FRAME_FIELDS='1')
    compilers = dict(candidate=args.compiler.resolve(), reference=args.reference.resolve())
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto',
             '-march=' + args.c_arch, '-fstack-usage']
    identity = dict(source=source, session=args.session, machine=platform.machine(), host=host,
        reference=manifest, flags=flags, ccVersion=subprocess.check_output([args.cc, '--version'], text=True),
        compilerHashes={role: hashlib.sha256(path.read_bytes()).hexdigest() for role, path in compilers.items()},
        settings={key: value for key, value in environment.items() if key.startswith('FWP_')},
        affinity=sorted(os.sched_getaffinity(0)))
    (output / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')

    def run(command, destination, env, observe):
        command = list(map(str, command))
        if observe:
            command = [str(args.time), '-v', '-o', str(destination.with_suffix('.resources')), *command]
        started = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(command, timeout=180, cwd=ROOT, env=env, input_data=None,
                                 input_stream=None, text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - started
        destination.with_suffix('.stdout').write_bytes(result.stdout)
        destination.with_suffix('.stderr').write_bytes(result.stderr)
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode, timedOut=timed_out,
                elapsedNs=elapsed, output=str(destination.relative_to(output)))) + '\n')
        assert result.returncode == 0 and not timed_out and not result.stderr, dict(
            command=command, status=result.returncode, timedOut=timed_out, stderr=result.stderr)
        cost = dict(elapsedNs=elapsed)
        if observe:
            cost.update(OBS.resources(destination.with_suffix('.resources').read_text()))
        return result.stdout, cost

    summary = {}
    for case in cases():
        directory = output / case['name']; directory.mkdir()
        source_file = directory / 'program.fwp'; source_file.write_text(program(case['kind']))
        (directory / 'case.json').write_text(json.dumps(case, indent=2) + '\n')
        if case['count'] <= 16 and case['sharing'] == 0:
            check = directory / 'raw.fwp'
            check.write_text(raw_program(case))
            raw, _ = run([compilers['candidate'], 'run', '--interp', check], directory / 'interpreter',
                         dict(environment, FWP_NO_OPT='1'), False)
            values = json.loads(raw)
            words = [struct.unpack('>Q', struct.pack('>d', v))[0] for v in values] if case['kind'] == 'sensor' else values
            assert words == expected(case['kind'], case['count'], case['updates'])
        binaries = {}
        for role, compiler in compilers.items():
            emitted = directory / (role + '-generated.c')
            run([compiler, 'build', '--fn', 'measure', '--emit-c', '-O2', source_file, '-o', emitted],
                directory / (role + '-emit'), environment, False)
            generated = emitted.read_text()
            assert ('/* consumed-scalar-array-map :' in generated) == (role == 'candidate')
            cfile = directory / (role + '.c'); cfile.write_text(driver(generated, case))
            binary = directory / role
            run([args.cc, *flags, cfile, '-o', binary, '-lm', '-lpthread', '-ldl'], directory / (role + '-build'), environment, False)
            raw, _ = run([binary], directory / (role + '-check'), environment, False)
            check = json.loads(raw); assert check['initialLiveBytes'] == check['finalLiveBytes']
            copied = directory / (role + '-copy'); shutil.copy2(binary, copied)
            binaries[role], binaries[role + '-copy'] = binary, copied
        rows = []
        for number in range(-2, 24):
            for role in COSTS.order(number):
                raw, cost = run([binaries[role]], directory / f'round-{number}-{role}', environment, False)
                row = json.loads(raw) | dict(round=number, role=role, processNs=cost['elapsedNs'])
                assert row['initialLiveBytes'] == row['finalLiveBytes']
                rows.append(row)
                with (directory / 'samples.jsonl').open('a') as log:
                    log.write(json.dumps(row) + '\n')
        assert len({row['checksum'] for row in rows}) == 1
        summary[case['name']] = COSTS.summarize(rows) | dict(
            binaryHashes={role: hashlib.sha256(path.read_bytes()).hexdigest() for role, path in binaries.items()})
        (output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
        print(case['name'], summary[case['name']]['ratios']['computationNs'],
              'qualified:', summary[case['name']]['computationQualified'], flush=True)

    # Finish every ordinary timing before any instrumentation or resource rebuild.
    if args.session == 1:
        observations = {}
        for case in cases():
            directory = output / case['name']; reports = {}
            for role, compiler in compilers.items():
                ordinary = directory / role
                raw, rss = run([ordinary], directory / (role + '-rss'), environment, True)
                timing = json.loads(raw)
                rebuilt_c = directory / (role + '-observed-generated.c')
                _, emitter = run([compiler, 'build', '--fn', 'measure', '--emit-c', '-O2', directory / 'program.fwp', '-o', rebuilt_c],
                                 directory / (role + '-compiler-cost'), environment, True)
                assert rebuilt_c.read_bytes() == (directory / (role + '-generated.c')).read_bytes()
                rebuilt = directory / (role + '-rebuilt')
                _, c_compiler = run([args.cc, *flags, directory / (role + '.c'), '-o', rebuilt, '-lm', '-lpthread', '-ldl'],
                                    directory / (role + '-c-cost'), environment, True)
                raw, _ = run([rebuilt], directory / (role + '-rebuilt-check'), environment, False)
                assert json.loads(raw)['checksum'] == timing['checksum']
                profile = directory / (role + '-memory.c'); profile.write_text(OBS.memory_source((directory / (role + '.c')).read_text()))
                instrumented = directory / (role + '-memory')
                run([args.cc, *flags, profile, '-o', instrumented, '-lm', '-lpthread', '-ldl'],
                    directory / (role + '-memory-build'), environment, False)
                raw, _ = run([instrumented], directory / (role + '-memory-run'), environment, False)
                measured, memory = [json.loads(line) for line in raw.splitlines()]
                assert measured['checksum'] == timing['checksum']
                assert memory['initialLiveBytes'] == memory['finalLiveBytes'] == timing['initialLiveBytes']
                reports[role] = dict(memory=memory, process=rss, compiler=emitter, cCompiler=c_compiler,
                                     imageBytes=ordinary.stat().st_size)
            assert reports['candidate']['memory']['requests'] <= reports['reference']['memory']['requests']
            if case['sharing'] == 0:
                assert reports['candidate']['memory']['requests'] < reports['reference']['memory']['requests']
            assert reports['candidate']['memory']['peakLiveBytes'] <= reports['reference']['memory']['peakLiveBytes']
            observations[case['name']] = reports
            (output / 'observations.json').write_text(json.dumps(observations, indent=2) + '\n')


if __name__ == '__main__':
    main()
