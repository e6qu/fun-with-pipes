#!/usr/bin/env python3
"""Compare complete gradient methods, then observe storage and compiler costs."""
import argparse
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import platform
import resource
import shutil
import subprocess
import time

from process_wait import run_capture
from structured_ad_costs import ROOT, REFERENCE_SOURCE, callback_cases, cases, driver, entry_and_drops, expected, program, raw_program
from structured_ad_observations import check_reports, instrument, stack_report
from structured_ad_statistics import order, summarize

SPEC = importlib.util.spec_from_file_location('resource_reports', ROOT / 'scripts/observe-array-costs.py')
RESOURCES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RESOURCES)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--comparison', choices=('methods', 'callbacks'), required=True)
    parser.add_argument('--reference-root', type=Path)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--c-arch', choices=('armv8-a', 'x86-64'), required=True)
    parser.add_argument('--time', type=Path, required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert resource.getrlimit(resource.RLIMIT_STACK)[0] == 64 * 1024 * 1024
    machine = platform.machine()
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[machine]
    assert subprocess.check_output([args.cc, '-dumpfullversion'], text=True).strip() == {
        'aarch64': '13.3.0', 'x86_64': '15.2.0'}[machine]
    assert subprocess.check_output(['rustc', '--version'], text=True).startswith('rustc 1.99.1 ')
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    cpus = sorted(os.sched_getaffinity(0)); assert len(cpus) >= 4
    cpu = cpus[0]
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    compiler = args.compiler.resolve()
    reference_compiler = None
    if args.comparison == 'callbacks':
        assert args.reference_root is not None
        reference_root = args.reference_root.resolve()
        assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=reference_root, text=True).strip() == REFERENCE_SOURCE
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=reference_root, check=True)
        reference_compiler = reference_root / 'target/debug/fwp'
    else:
        assert args.reference_root is None
    workload = list(callback_cases() if args.comparison == 'callbacks' else cases())
    reference = 'baseline' if args.comparison == 'callbacks' else 'reverse'
    summary_key = 'vsBaseline' if args.comparison == 'callbacks' else 'vsReverse'
    output = args.output.resolve(); output.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, LC_ALL='C', FWP_LTO='0', FWP_STACK='1', FWP_ARRAY_FUSION='1',
        FWP_PACKED_ARRAYS='1', FWP_VRET='1', FWP_FRAME_FIELDS='1', FWP_AD_WORKSPACE='1')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto',
             '-march=' + args.c_arch, '-fstack-usage']
    host = json.loads(subprocess.check_output(['lscpu', '--json'], text=True))
    models = [row['data'] for row in host['lscpu'] if row['field'] == 'Model name:']
    assert len(models) == 1 and models[0]
    identity = dict(source=source, comparison=args.comparison, session=args.session, machine=machine, host=host,
        model=models[0], availableCpus=cpus, timingCpu=cpu, flags=flags,
        stackLimitBytes=resource.getrlimit(resource.RLIMIT_STACK)[0],
        compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
        compilerBuildSettings={key: os.environ[key] for key in ('CARGO_PROFILE_DEV_OPT_LEVEL',
            'CARGO_PROFILE_DEV_DEBUG_ASSERTIONS', 'CARGO_PROFILE_DEV_OVERFLOW_CHECKS')},
        ccVersion=subprocess.check_output([args.cc, '--version'], text=True),
        rustVersion=subprocess.check_output(['rustc', '-Vv'], text=True),
        settings={key: value for key, value in environment.items() if key.startswith('FWP_')})
    if reference_compiler is not None:
        identity['referenceSource'] = REFERENCE_SOURCE
        identity['referenceCompilerSha256'] = hashlib.sha256(reference_compiler.read_bytes()).hexdigest()
    (output / 'identity.json').write_text(json.dumps(identity, indent=2)+'\n')

    def run(command, destination, observe, pinned, env):
        command = list(map(str, command))
        if pinned:
            command = ['taskset', '--cpu-list', str(cpu), *command]
        if observe:
            command = [str(args.time), '-v', '-o', str(destination.with_suffix('.resources')), *command]
        start = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(command, timeout=180, cwd=ROOT, env=env, input_data=None,
                input_stream=None, text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - start
        destination.with_suffix('.stdout').write_bytes(result.stdout)
        destination.with_suffix('.stderr').write_bytes(result.stderr)
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode, timedOut=timed_out,
                elapsedNs=elapsed, output=str(destination.relative_to(output)),
                settings={key: value for key, value in env.items() if key.startswith('FWP_')}))+'\n')
        assert result.returncode == 0 and not timed_out, (command, result.returncode, result.stderr)
        cost = dict(elapsedNs=elapsed)
        if observe:
            cost.update(RESOURCES.resources(destination.with_suffix('.resources').read_text()))
        return result, cost

    summary = {}
    for case in workload:
        directory = output / case['name']; directory.mkdir()
        (directory / 'case.json').write_text(json.dumps(case, indent=2)+'\n')
        (directory / 'expected.json').write_text(json.dumps(expected(case['family'], case['count']))+'\n')
        binaries = {}
        result_checksums = {}
        for method in case['methods']:
            selected_compiler = reference_compiler if method == 'baseline' else compiler
            actual_method = case['method'] if args.comparison == 'callbacks' else method
            fwp = directory / (method + '.fwp'); fwp.write_text(program(case['family'], actual_method))
            if case['count'] <= 3:
                raw = directory / (method + '-raw.fwp'); raw.write_text(raw_program(case, actual_method))
                result, _ = run([selected_compiler, 'run', '--interp', raw], directory / (method + '-interpreter'),
                    False, False, dict(environment, FWP_NO_OPT='1'))
                assert not result.stderr, result.stderr
                values = json.loads(result.stdout)
                oracle = expected(case['family'], case['count'])
                assert len(values) == len(oracle)
                assert all(math.isfinite(a) and abs(a-b) <= 1e-10 + 1e-10*abs(b) for a,b in zip(values,oracle))
            emitted = directory / (method + '-generated.c')
            result, _ = run([selected_compiler, 'build', '--fn', 'measure', '--emit-c', '-O2', fwp, '-o', emitted],
                directory / (method + '-emit'), False, False, environment)
            assert not result.stderr, result.stderr
            cfile = directory / (method + '.c'); cfile.write_text(driver(emitted.read_text(), case))
            binary = directory / method
            result, _ = run([args.cc, *flags, cfile, '-o', binary, '-lm', '-lpthread', '-ldl'],
                directory / (method + '-build'), False, False, environment)
            assert not result.stderr, result.stderr
            result, _ = run([binary, case['count']], directory / (method + '-check'), False, True, environment)
            assert not result.stderr, result.stderr
            observation = json.loads(result.stdout)
            assert observation['initialLiveBytes'] == observation['finalLiveBytes']
            result_checksums[method] = observation['checksum']
            copied = directory / (method + '-copy'); shutil.copy2(binary, copied)
            binaries[method], binaries[method + '-copy'] = binary, copied
        if args.comparison == 'callbacks':
            assert result_checksums['baseline'] == result_checksums['candidate'], case['name']
        rows = []
        for round_number in range(-2, 24):
            for role in order(case['methods'], round_number):
                result, cost = run([binaries[role], case['count']], directory / f'round-{round_number}-{role}',
                    False, True, environment)
                assert not result.stderr, result.stderr
                row = json.loads(result.stdout) | dict(round=round_number, role=role, processNs=cost['elapsedNs'])
                rows.append(row)
                with (directory / 'samples.jsonl').open('a') as log:
                    log.write(json.dumps(row)+'\n')
        summary[case['name']] = summarize(rows, case['methods'], case['repeats'], reference) | dict(
            binaryHashes={role: hashlib.sha256(path.read_bytes()).hexdigest() for role,path in binaries.items()})
        (output / 'summary.json').write_text(json.dumps(summary, indent=2)+'\n')
        print(case['name'], summary[case['name']][summary_key], flush=True)

    # Finish all ordinary timings before instrumentation or resource rebuilding.
    if args.session == 1:
        observations = {}
        for case in workload:
            directory = output / case['name']; reports = {}
            for method in case['methods']:
                selected_compiler = reference_compiler if method == 'baseline' else compiler
                actual_method = case['method'] if args.comparison == 'callbacks' else method
                ordinary = directory / method
                result, rss = run([ordinary, case['count']], directory / (method + '-rss'), True, True, environment)
                assert not result.stderr, result.stderr
                timing = json.loads(result.stdout)
                emitted = directory / (method + '-observed-generated.c')
                result, emitter = run([selected_compiler, 'build', '--fn', 'measure', '--emit-c', '-O2',
                    directory / (method + '.fwp'), '-o', emitted], directory / (method + '-compiler-cost'),
                    True, False, environment)
                assert not result.stderr and emitted.read_bytes() == (directory / (method + '-generated.c')).read_bytes()
                rebuilt = directory / (method + '-rebuilt')
                result, c_compiler = run([args.cc, *flags, directory / (method + '.c'), '-o', rebuilt,
                    '-lm', '-lpthread', '-ldl'], directory / (method + '-c-cost'), True, False, environment)
                assert not result.stderr, result.stderr
                result, _ = run([rebuilt, case['count']], directory / (method + '-rebuilt-check'), False, True, environment)
                assert not result.stderr and json.loads(result.stdout)['checksum'] == timing['checksum']
                observed_c = directory / (method + '-memory.c')
                observed_c.write_text(instrument((directory / (method + '.c')).read_text()))
                observed_binary = directory / (method + '-memory')
                result, _ = run([args.cc, *flags, observed_c, '-o', observed_binary, '-lm', '-lpthread', '-ldl'],
                    directory / (method + '-memory-build'), False, False, environment)
                assert not result.stderr, result.stderr
                memory = {}
                for workspace in (True, False):
                    result, _ = run([observed_binary, case['count']], directory / (method + '-memory-' + str(int(workspace))),
                        False, True, dict(environment, FWP_AD_WORKSPACE=str(int(workspace))))
                    measured = json.loads(result.stdout)
                    assert measured['checksum'] == timing['checksum']
                    assert measured['retainedManagedBytesAfterCall'] == timing['retainedManagedBytesAfterCall']
                    managed, raw = [json.loads(line) for line in result.stderr.splitlines()]
                    check_reports(managed, raw['rawDerivativeStorage'], case['count'], case['repeats'], actual_method, workspace)
                    memory[str(int(workspace))] = dict(managed=managed, rawDerivativeStorage=raw['rawDerivativeStorage'])
                reports[method] = dict(memory=memory, process=rss, compiler=emitter,
                    cCompiler=c_compiler, imageBytes=ordinary.stat().st_size,
                    retainedManagedBytesAfterCall=timing['retainedManagedBytesAfterCall'],
                    stack=stack_report((directory / (method + '.su')).read_text(),
                                       entry_and_drops((directory / (method + '-generated.c')).read_text())[0]))
            observations[case['name']] = reports
            (output / 'observations.json').write_text(json.dumps(observations, indent=2)+'\n')


if __name__ == '__main__':
    main()
