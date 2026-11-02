#!/usr/bin/env python3
"""Measure current source/driver array construction against materialized C/Rust."""
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
from current_kernel_costs import LABELS, execution_order, summarize
import array_construction_phases as PHASES

ROOT = Path(__file__).resolve().parent.parent
MEASURE = PHASES.MEASURE
BASELINE = MEASURE.BASELINE
CASES = {name: dims for name, dims in MEASURE.CASES.items() if name.startswith('array')}
SPEC = importlib.util.spec_from_file_location('scalar_reference', ROOT / 'scripts/prepare-scalar-array-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['compiler', 'cc', 'rustc', 'c-arch', 'rust-cpu', 'objdump', 'nm', 'time']:
        parser.add_argument('--' + name, required=True)
    for name in ['samples', 'warmups', 'processes', 'timeout', 'session']:
        parser.add_argument('--' + name, type=int, required=True)
    parser.add_argument('--comparison', choices=('source-paths', 'scalar-captures'), required=True)
    parser.add_argument('--reference-compiler', type=Path)
    parser.add_argument('--reference-manifest', type=Path)
    parser.add_argument('--safety', type=Path)
    parser.add_argument('--case', action='append', choices=list(CASES), required=True)
    parser.add_argument('--qualification', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert (args.samples, args.warmups, args.processes) == (18, 2, 4)
    assert args.session in [1, 2] and args.timeout > 0
    scalar = args.comparison == 'scalar-captures'
    reference_inputs = (args.reference_compiler, args.reference_manifest, args.safety)
    if scalar:
        assert all(value is not None for value in reference_inputs)
    else:
        assert all(value is None for value in reference_inputs)
    cases = CASES
    assert args.case == list(cases), 'Every declared case is required in order'
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
    prerequisite_path = ROOT / 'docs/measurements/array-construction-2026-11-02/index.json'
    prerequisite = json.loads(prerequisite_path.read_text())
    assert len(prerequisite['jobs']) == 2 and all(job['conclusion'] == 'success' for job in prerequisite['jobs'])
    for name in ('src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs',
                 'tests/fixtures/array_construction_costs.fwp'):
        if scalar and name == 'src':
            continue  # The paired reference below verifies the one declared codegen difference.
        verified = subprocess.check_output(['git', 'rev-parse', prerequisite['source'] + ':' + name], cwd=ROOT)
        current = subprocess.check_output(['git', 'rev-parse', 'HEAD:' + name], cwd=ROOT)
        assert verified == current, name + ' differs from verified construction diagnostics'
    compiler = Path(args.compiler).resolve()
    shutil.copyfile(compiler, out / 'fwp-compiler')
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    environment.pop('FWP_NO_OPT', None)
    environment.pop('FWP_NO_REUSE', None)
    configuration = {key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()}
    identity = dict(source=os.environ['GITHUB_SHA'], qualification=qualification,
        configuration=configuration, prerequisiteSha256=hashlib.sha256(prerequisite_path.read_bytes()).hexdigest(),
        constructionPaths={'fwp': 'compiled make-input', 'reference': 'C driver runtime calls'},
        compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
        sourceTrees={name: subprocess.check_output(['git', 'rev-parse', os.environ['GITHUB_SHA'] + ':' + name],
            cwd=ROOT, text=True).strip() for name in ['src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs']},
        sourceHashes={name: hashlib.sha256((ROOT / name).read_bytes()).hexdigest() for name in
            ['scripts/measure-array-construction.py', 'scripts/array_construction_phases.py', 'scripts/current_kernel_costs.py',
             'scripts/measure-kernel-baselines.py', 'scripts/numerical-baselines.py',
             'tests/fixtures/numerical_bench.c', 'tests/fixtures/numerical_bench.rs',
             'tests/fixtures/numerical_bench_native.c', 'tests/fixtures/array_construction_costs.fwp', 'src/cgen.rs']},
        executionEnvironment={key: environment[key] for key in sorted(environment) if key.startswith('FWP_')},
        removedEnvironment=['FWP_NO_OPT', 'FWP_NO_REUSE'],
        allowedCpus=sorted(os.sched_getaffinity(0)))
    if scalar:
        manifest = json.loads(args.reference_manifest.read_text())
        assert manifest['source'] == os.environ['GITHUB_SHA']
        assert manifest['disabledTransformation'] == 'direct scalar array captures'
        candidate_codegen = (ROOT / 'src/cgen.rs').read_text()
        reference_codegen = REFERENCE.reference_source(candidate_codegen)
        assert manifest['candidateCodegenSha256'] == REFERENCE.digest(candidate_codegen.encode())
        assert manifest['referenceCodegenSha256'] == REFERENCE.digest(reference_codegen.encode())
        assert manifest['ownershipSha256'] == REFERENCE.digest((ROOT / 'src/ownership.rs').read_bytes())
        assert manifest['compilerSha256'] == REFERENCE.digest(args.reference_compiler.read_bytes())
        source_dir = args.reference_manifest.parent
        assert (source_dir / 'codegen-reference.rs').read_text() == reference_codegen
        assert REFERENCE.digest((source_dir / 'reference.patch').read_bytes()) == manifest['patchSha256']
        for name in ('codegen-reference.rs', 'reference.patch'):
            shutil.copyfile(source_dir / name, out / name)
        shutil.copyfile(args.reference_compiler, out / 'reference-compiler')
        (out / 'reference-manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
        safety = json.loads(args.safety.read_text())
        assert len(safety['jobs']) == 3 and all(job['conclusion'] == 'success' for job in safety['jobs'])
        assert {job['name'] for job in safety['jobs']} == {
            'scalar_array_checks (ubuntu-latest, gcc)', 'scalar_array_checks (ubuntu-24.04-arm, gcc)',
            'scalar_array_checks (macos-15, clang)'}
        assert all(job['head_sha'] == safety['source'] for job in safety['jobs'])
        for name in ('src', 'runtime', 'lib', 'tests', 'Cargo.toml', 'Cargo.lock', 'build.rs'):
            verified = subprocess.check_output(['git', 'rev-parse', safety['source'] + ':' + name], cwd=ROOT)
            current = subprocess.check_output(['git', 'rev-parse', 'HEAD:' + name], cwd=ROOT)
            assert verified == current, name + ' differs from focused safety checks'
        identity.update(referenceManifest=manifest, safety=safety)
        identity['constructionPaths']['reference'] = 'compiled make-input with scalar specialization disabled'
        identity['sourceHashes']['scripts/prepare-scalar-array-reference.py'] = REFERENCE.digest(
            (ROOT / 'scripts/prepare-scalar-array-reference.py').read_bytes())
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

    prepared, results = {}, {}
    for case, dimensions in cases.items():
        directory = out / case
        directory.mkdir()
        elements, rows, inner, columns = dimensions
        expected = [[BASELINE.array_result(elements, r)] for r in range(8)]
        expected_hash = BASELINE.result_hash(expected)
        expected_output = BASELINE.verification_output(expected)
        (directory / 'expected-values.txt').write_bytes(expected_output)
        program = directory / 'kernel.fwp'
        program.write_text((ROOT / 'tests/fixtures/array_construction_costs.fwp').read_text())
        modules = {}
        emitters = [('fwp', compiler)] + ([('reference', args.reference_compiler.resolve())] if scalar else [])
        for label, emitter in emitters:
            emitted = directory / ('generated.c' if label == 'fwp' else 'reference-generated.c')
            result, _ = run([emitter, 'build', '--memory', 'dynamic', '--fn', 'reduce64',
                            '--emit-c', program, '-o', emitted], directory / ('emit' if label == 'fwp' else 'reference-emit'), 0)
            assert not result.stderr
            generated = emitted.read_text()
            entries = {}
            for name in ('reduce64', 'make-input'):
                marker = generated.index('/* ' + name + ' :')
                entries[name] = 'f' + generated[marker:].split('static V f', 1)[1].split('(', 1)[0]
            modules[label] = (generated, entries)
        binaries, profiles, phase_profiles, images, stack = {}, {}, {}, {}, {}
        for mode in (['timing', 'profile', 'verify'] if scalar else ['timing', 'profile', 'verify', 'phases']):
            profile, verification = mode in ('profile', 'phases'), mode == 'verify'
            for language in (['fwp', 'reference'] if mode == 'phases' else ['c', 'rust', 'fwp', 'reference']):
                extension = '.rs' if language == 'rust' else '.c'
                source_path = directory / (language + '-' + mode + extension)
                binary = directory / (f'role{LABELS.index(language):04d}' if mode == 'timing' else language + '-' + mode)
                binary = binary.with_suffix('.exe')
                if language in ('fwp', 'reference'):
                    generated, entries = modules[language if scalar else 'fwp']
                    source = PHASES.native_source(generated, entries['reduce64'], entries['make-input'],
                        dimensions, 'fwp' if scalar else language, profile, verification, mode == 'phases')
                else:
                    source = PHASES.peer_source((ROOT / ('tests/fixtures/numerical_bench' + extension)).read_text(), language, dimensions, verification)
                source_path.write_text(source)
                if language == 'rust':
                    command = [args.rustc, '--edition=2021', '--crate-name', 'kernel_' + mode,
                               '-C', 'opt-level=2', '-C', 'target-cpu=' + args.rust_cpu,
                               *(['--cfg', 'memory_profile'] if profile else []), source_path, '-o', binary]
                else:
                    command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch, '-w',
                               '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=' + str(int(profile)),
                               '-DMATRIX_BENCH=0', source_path, '-o', binary, '-lm', '-lpthread']
                built, _ = run(command, directory / (language + '-' + mode + '-build'), 0)
                assert not built.stderr
                invocation = [binary] + ([] if language in ('fwp', 'reference') else ['array'])
                if verification:
                    execution, _ = run(invocation, directory / (language + '-verify-output'), 0)
                    values = b'\n'.join(re.findall(rb'^\d+:\d+:[0-9a-f]{16}$', execution.stdout, re.M)) + b'\n'
                    assert values == expected_output and not execution.stderr, (case, language)
                elif profile:
                    execution, _ = run(invocation, directory / (language + '-' + mode + '-output'), 0)
                    assert not execution.stderr
                    samples = PHASES.check_samples(execution.stdout, expected_hash, language, True, mode == 'phases')
                    for sample in samples:
                        assert sample['requests'] == 8
                        assert sample['requestedBytes'] == 8 * (elements * 8 + (8 if language in ('fwp', 'reference') else 0))
                        if language in ('fwp', 'reference'):
                            assert sample['retains'] == sample['nonlastReleases'] == 0
                    (phase_profiles if mode == 'phases' else profiles)[language] = samples
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
        for label in ('fwp', 'reference'):
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
                 '-DPROFILE=1', '-DMATRIX_BENCH=0', leak, '-o', leak_binary, '-lm', '-lpthread'],
                 directory / (label + '-leak-build'), 0)
            leaked, _ = run([leak_binary], directory / (label + '-leak-check'), 224)
            assert b'unexpected charged storage' in leaked.stderr
        prepared[case] = dict(dimensions=dimensions, resultHash=expected_hash, binaries=binaries,
            profiles=profiles, phaseProfiles=phase_profiles, images=images, stack=stack)
    # Complete every build, exact-output/profile check and leak control before timing.
    for case, ready in prepared.items():
        directory = out / case
        dimensions, expected_hash = ready['dimensions'], ready['resultHash']
        binaries, profiles, phase_profiles = ready['binaries'], ready['profiles'], ready['phaseProfiles']
        images, stack = ready['images'], ready['stack']
        observations = []
        processes = args.processes
        for phase, count in [('warmup', args.warmups), ('sample', args.samples)]:
            for index in range(count):
                order = execution_order(index, processes)
                records, complete = [], False
                try:
                    for position, label in enumerate(order):
                        execution, elapsed = run(binaries[label], directory / f'{phase}-{index}-{position}', 0)
                        assert not execution.stderr
                        samples = PHASES.check_samples(execution.stdout, expected_hash, label, False, False)
                        records.append(dict(label=label, processNs=elapsed, samples=samples))
                    complete = True
                finally:
                    record = dict(phase=phase, round=index, order=order, observations=records, complete=complete)
                    (directory / f'{phase}-{index}.json').write_text(json.dumps(record, indent=2) + '\n')
                observations.append(record)
        rss = {}
        for label, invocation in binaries.items():
            result, _ = run([args.time, '-v', *invocation], directory / (label + '-rss'), 0)
            PHASES.check_samples(result.stdout, expected_hash, label, False, False)
            rss[label] = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', result.stderr)[1]) * 1024
        for path in directory.glob('*.su'):
            stack[path.name] = dict(sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                                   entries=[dict(location=p, bytes=int(size), qualifier=q) for p, size, q in
                                            (line.split('\t') for line in path.read_text().splitlines())])
        summary = summarize(observations, processes, PHASES.METRICS)
        results[case] = dict(dimensions=dimensions, resultHash=expected_hash, observations=observations,
                             profiles=profiles, phaseProfiles=phase_profiles, binaries=images, stack=stack, peakProcessRssBytes=rss,
                             rolePaths={label: str(command[0].relative_to(directory)) for label, command in binaries.items()},
                             **summary)
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    failures = [dict(kind='copy', case=case, label=label, metric=metric, ratio=ratio, limit=1.02)
        for case, row in results.items() for label, scopes in row['identicalRatios'].items()
        for metric, ratio in scopes.items() if ratio > 1.02]
    if scalar:
        for case, row in results.items():
            for metric, ratio in row['ratios']['reference'].items():
                limit = 1.02 if metric == 'kernelNs' else 0.95
                if ratio > limit:
                    failures.append(dict(kind='speed', case=case, metric=metric, ratio=ratio, limit=limit))
            for index, (candidate, reference) in enumerate(zip(row['profiles']['fwp'], row['profiles']['reference'])):
                for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes'):
                    if candidate[metric] > reference[metric]:
                        failures.append(dict(kind='memory', case=case, sample=index, metric=metric,
                            candidate=candidate[metric], reference=reference[metric]))
    report = dict(**identity, results=results, failures=failures)
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({case: dict(ratios=row['ratios'], controls=row['identicalRatios'])
                     for case, row in results.items()}, indent=2))
    assert not failures, failures


if __name__ == '__main__':
    main()
