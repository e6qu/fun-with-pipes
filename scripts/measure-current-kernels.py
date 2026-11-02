#!/usr/bin/env python3
"""Compare current kernels, word-state reference and C/Rust with both copy controls."""
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

from process_wait import run_capture
from current_kernel_costs import LABELS, decisions, execution_order, storage_label, summarize

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('kernel_measurement', ROOT / 'scripts/measure-kernel-baselines.py')
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)
BASELINE = MEASURE.BASELINE
CASES = MEASURE.CASES


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['compiler', 'reference-compiler', 'cc', 'rustc', 'c-arch', 'rust-cpu', 'objdump', 'nm', 'time']:
        parser.add_argument('--' + name, required=True)
    for name in ['samples', 'warmups', 'processes', 'small-matrix-processes', 'timeout', 'session']:
        parser.add_argument('--' + name, type=int, required=True)
    parser.add_argument('--case', action='append', choices=list(CASES), required=True)
    parser.add_argument('--reference-manifest', type=Path, required=True)
    parser.add_argument('--qualification', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert (args.samples, args.warmups, args.processes) == (18, 2, 4)
    assert args.small_matrix_processes == 256
    assert args.session in [1, 2] and args.timeout > 0
    assert args.case == list(CASES), 'All four declared cases are required in order'
    qualification = json.loads(args.qualification.read_text())
    assert qualification['qualified'] and not qualification['failures']
    assert qualification['actual'] == qualification['expected']
    assert qualification['source'] == os.environ['GITHUB_SHA']
    assert qualification['actual']['machine'] == platform.machine()
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[platform.machine()]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[platform.machine()]
    assert subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0] == qualification['actual']['cVersion']
    assert subprocess.check_output([args.rustc, '--version'], text=True).strip() == qualification['actual']['rustVersion']
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=ROOT, check=True)
    compilers = {'fwp': Path(args.compiler).resolve(), 'reference': Path(args.reference_compiler).resolve()}
    reference_manifest = json.loads(args.reference_manifest.read_text())
    assert reference_manifest['source'] == os.environ['GITHUB_SHA']
    assert reference_manifest['disabledTransformation'] == 'native floating-point loop-state fields'
    assert reference_manifest['candidateCodegenSha256'] == hashlib.sha256((ROOT / 'src/cgen.rs').read_bytes()).hexdigest()
    assert reference_manifest['compilerSha256'] == hashlib.sha256(compilers['reference'].read_bytes()).hexdigest()
    for label, compiler in compilers.items():
        shutil.copyfile(compiler, out / (label + '-compiler'))
    shutil.copyfile(args.reference_manifest, out / 'reference-manifest.json')
    for name in ('reference.patch', 'codegen-reference.rs'):
        shutil.copyfile(args.reference_manifest.parent / name, out / name)
    for name in reference_manifest['testExpectations']:
        saved = out / name
        saved.parent.mkdir(parents=True, exist_ok=True)
        shutil.copyfile(args.reference_manifest.parent / name, saved)
    assert hashlib.sha256((out / 'reference.patch').read_bytes()).hexdigest() == reference_manifest['patchSha256']
    assert hashlib.sha256((out / 'codegen-reference.rs').read_bytes()).hexdigest() == reference_manifest['referenceCodegenSha256']
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    environment.pop('FWP_NO_OPT', None)
    environment.pop('FWP_NO_REUSE', None)
    configuration = {key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()}
    identity = dict(source=os.environ['GITHUB_SHA'], qualification=qualification,
        configuration=configuration, referenceManifest=reference_manifest,
        compilerSha256={label: hashlib.sha256(path.read_bytes()).hexdigest() for label, path in compilers.items()},
        sourceTrees={name: subprocess.check_output(['git', 'rev-parse', os.environ['GITHUB_SHA'] + ':' + name],
            cwd=ROOT, text=True).strip() for name in ['src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs']},
        sourceHashes={name: hashlib.sha256((ROOT / name).read_bytes()).hexdigest() for name in
            ['scripts/measure-current-kernels.py', 'scripts/current_kernel_costs.py',
             'scripts/measure-kernel-baselines.py', 'scripts/numerical-baselines.py',
             'scripts/prepare-loop-state-reference.py', 'tests/fixtures/numerical_bench.c',
             'tests/fixtures/numerical_bench.rs', 'tests/fixtures/numerical_bench_native.c', 'src/cgen.rs']},
        executionEnvironment={key: environment[key] for key in sorted(environment) if key.startswith('FWP_')},
        removedEnvironment=['FWP_NO_OPT', 'FWP_NO_REUSE'],
        allowedCpus=sorted(os.sched_getaffinity(0)))
    (out / 'configuration.json').write_text(json.dumps(identity, indent=2) + '\n')

    def run(command, destination, expected_status):
        started = time.perf_counter_ns()
        timeout = None
        try:
            result = run_capture(list(map(str, command)), timeout=args.timeout,
                         env=environment, cwd=None, input_data=None, input_stream=None,
                         text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            timeout = error
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - started
        destination.with_suffix(destination.suffix + '.stdout').write_bytes(result.stdout)
        destination.with_suffix(destination.suffix + '.stderr').write_bytes(result.stderr)
        observation = dict(artifact=str(destination.relative_to(out)), command=list(map(str, command)), status=result.returncode,
                           elapsedNs=elapsed, stdoutSha256=hashlib.sha256(result.stdout).hexdigest(),
                           stderrSha256=hashlib.sha256(result.stderr).hexdigest(), timedOut=timeout is not None)
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(observation) + '\n')
        if timeout is not None:
            raise timeout
        assert result.returncode == expected_status, (command, result.returncode, result.stderr.decode(errors='replace'))
        return result, elapsed

    results = {}
    for case, dimensions in CASES.items():
        directory = out / case
        directory.mkdir()
        elements, rows, inner, columns = dimensions
        matrix = case.startswith('matrix')
        expected = [BASELINE.matrix_result(rows, inner, columns, r) if matrix else
                    [BASELINE.array_result(elements, r)] for r in range(8)]
        expected_hash = BASELINE.result_hash(expected)
        expected_output = BASELINE.verification_output(expected)
        (directory / 'expected-values.txt').write_bytes(expected_output)
        program = directory / 'kernel.fwp'
        if matrix:
            program.write_text(f'export product-data : Matrix[F64, {inner}, {columns}] -> Matrix[F64, {rows}, {inner}] -> Array[F64]\nproduct-data = curry (uncurry matmul | .data)\n')
            entry_name = 'product-data'
        else:
            program.write_text('export reduce64 : Array[F64] -> F64\nreduce64 = array.map (mul 3.0) | array.map (add 1.0) | array.fold add -0.0\n')
            entry_name = 'reduce64'
        generated = {}
        entries = {}
        for label, compiler in compilers.items():
            emitted = directory / (label + '-generated.c')
            result, _ = run([compiler, 'build', '--memory', 'dynamic', '--fn', entry_name,
                            '--emit-c', program, '-o', emitted], directory / (label + '-emit'), 0)
            assert not result.stderr
            generated[label] = emitted.read_text()
            marker = generated[label].index('/* ' + entry_name + ' :')
            entries[label] = 'f' + generated[label][marker:].split('static V f', 1)[1].split('(', 1)[0]
        if not matrix:
            assert re.search(r'typedef struct \{ V v0; V v1; double v2; \} fwp_loop_state\d+;', generated['fwp'])
            assert re.search(r'typedef struct \{ V v0; V v1; V v2; \} fwp_loop_state\d+;', generated['reference'])
        binaries, profiles, images, stack = {}, {}, {}, {}
        for mode in ['timing', 'profile', 'verify']:
            profile, verification = mode == 'profile', mode == 'verify'
            for language in ['c', 'rust', 'fwp', 'reference']:
                extension = '.rs' if language == 'rust' else '.c'
                source_path = directory / (language + '-' + mode + extension)
                binary = directory / (f'role{LABELS.index(language):04d}' if mode == 'timing' else language + '-' + mode)
                binary = binary.with_suffix('.exe')
                if language in compilers:
                    source = MEASURE.native_source(generated[language], entries[language], dimensions, matrix, profile, verification)
                else:
                    source = MEASURE.configured_peer((ROOT / ('tests/fixtures/numerical_bench' + extension)).read_text(), language, dimensions, verification)
                source_path.write_text(source)
                if language == 'rust':
                    command = [args.rustc, '--edition=2021', '--crate-name', 'kernel_' + mode,
                               '-C', 'opt-level=2', '-C', 'target-cpu=' + args.rust_cpu,
                               *(['--cfg', 'memory_profile'] if profile else []), source_path, '-o', binary]
                else:
                    command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch, '-w',
                               '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=' + str(int(profile)),
                               '-DMATRIX_BENCH=' + str(int(matrix)), source_path, '-o', binary, '-lm', '-lpthread']
                built, _ = run(command, directory / (language + '-' + mode + '-build'), 0)
                assert not built.stderr
                invocation = [binary] + ([] if language in compilers else ['matrix' if matrix else 'array'])
                if verification:
                    execution, _ = run(invocation, directory / (language + '-verify-output'), 0)
                    values = b'\n'.join(re.findall(rb'^\d+:\d+:[0-9a-f]{16}$', execution.stdout, re.M)) + b'\n'
                    assert values == expected_output and not execution.stderr, (case, language)
                elif profile:
                    execution, _ = run(invocation, directory / (language + '-profile-output'), 0)
                    assert not execution.stderr
                    profiles[language] = MEASURE.check_samples(execution.stdout, expected_hash, storage_label(language), True)
                else:
                    binaries[language] = invocation
                raw = binary.read_bytes()
                sections, _ = run([args.objdump, '-h', binary], directory / (binary.name + '-sections'), 0)
                symbols, _ = run([args.nm, binary], directory / (binary.name + '-symbols'), 0)
                assert not any(name in symbols.stdout for name in [b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'])
                text_bytes = sum(int(size, 16) for size in re.findall(rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections.stdout, re.M))
                assert text_bytes > 0
                images[language + '-' + mode] = dict(path=binary.name, bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest(), instructionBytes=text_bytes,
                                          sourceSha256=hashlib.sha256(source_path.read_bytes()).hexdigest())
        for label in compilers:
            copy = directory / f'role{LABELS.index(label + "-identical"):04d}.exe'
            shutil.copyfile(binaries[label][0], copy)
            copy.chmod(0o755)
            assert copy.read_bytes() == binaries[label][0].read_bytes()
            binaries[label + '-identical'] = [copy]
            leak = directory / (label + '-missing-owner-release.c')
            leak_source = (directory / (label + '-profile.c')).read_text()
            leak_source = MEASURE.replace_once(leak_source, 'uint64_t elapsed=bench_clock()-start;',
                'fwp_rc_fresh(fwp_array_new_packed(1,&scalar));uint64_t elapsed=bench_clock()-start;')
            leak.write_text(leak_source)
            leak_binary = leak.with_suffix('.exe')
            run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch, '-w',
                 '-DPROFILE=1', '-DMATRIX_BENCH=' + str(int(matrix)), leak, '-o', leak_binary, '-lm', '-lpthread'],
                 directory / (label + '-leak-build'), 0)
            leaked, _ = run([leak_binary], directory / (label + '-leak-check'), 224)
            assert b'unexpected charged storage' in leaked.stderr
        observations = []
        processes = args.small_matrix_processes if case == 'matrix-65-67-63' else args.processes
        for phase, count in [('warmup', args.warmups), ('sample', args.samples)]:
            for index in range(count):
                order = execution_order(index, processes)
                records, complete = [], False
                try:
                    for position, label in enumerate(order):
                        execution, elapsed = run(binaries[label], directory / f'{phase}-{index}-{position}', 0)
                        assert not execution.stderr
                        samples = MEASURE.check_samples(execution.stdout, expected_hash, storage_label(label), False)
                        records.append(dict(label=label, processNs=elapsed, samples=samples))
                    complete = True
                finally:
                    record = dict(phase=phase, round=index, order=order, observations=records, complete=complete)
                    (directory / f'{phase}-{index}.json').write_text(json.dumps(record, indent=2) + '\n')
                observations.append(record)
        rss = {}
        for label, invocation in binaries.items():
            result, _ = run([args.time, '-v', *invocation], directory / (label + '-rss'), 0)
            MEASURE.check_samples(result.stdout, expected_hash, storage_label(label), False)
            rss[label] = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', result.stderr)[1]) * 1024
        for path in directory.glob('*.su'):
            stack[path.name] = dict(sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                                   entries=[dict(location=p, bytes=int(size), qualifier=q) for p, size, q in
                                            (line.split('\t') for line in path.read_text().splitlines())])
        summary = summarize(observations, processes)
        results[case] = dict(dimensions=dimensions, resultHash=expected_hash, observations=observations,
                             profiles=profiles, binaries=images, stack=stack, peakProcessRssBytes=rss,
                             rolePaths={label: str(command[0].relative_to(directory)) for label, command in binaries.items()},
                             **summary)
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    failures = decisions(results)
    report = dict(**identity, results=results, failures=failures)
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({case: dict(ratios=row['ratios'], controls=row['identicalRatios'])
                     for case, row in results.items()}, indent=2))
    assert not failures, failures


if __name__ == '__main__':
    main()
