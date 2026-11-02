#!/usr/bin/env python3
"""Rebuild array phase results from retained raw files without running binaries."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
from zipfile import ZipFile

import array_construction_phases as PHASES
from current_kernel_costs import LABELS, summarize

ROOT = Path(__file__).resolve().parent.parent
CASES = {name: dimensions for name, dimensions in PHASES.MEASURE.CASES.items() if name.startswith('array')}
SPEC = importlib.util.spec_from_file_location('scalar_reference', ROOT / 'scripts/prepare-scalar-array-reference.py')
REFERENCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REFERENCE)
HOSTS = {
    'aarch64': ('Neoverse-N2', 'gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0', 'armv8-a', 'generic'),
    'x86_64': ('AMD EPYC 7763 64-Core Processor', 'gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0', 'x86-64', 'x86-64'),
}


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def check(archive, prefix, source, machine, session, comparison):
    def read(name):
        return archive.read(prefix + name)

    assert comparison in ('source-paths', 'scalar-captures')
    scalar = comparison == 'scalar-captures'
    report = json.loads(read('comparison.json'))
    assert re.fullmatch('[0-9a-f]{40}', source) and report['source'] == source
    assert machine in HOSTS and session in (1, 2)
    cpu, cc, c_arch, rust_cpu = HOSTS[machine]
    qualification = report['qualification']
    expected = dict(system='Linux', processors=4, machine=machine, cpu=cpu, cVersion=cc,
                    rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)')
    assert qualification['qualified'] and not qualification['failures']
    assert qualification['source'] == source
    assert qualification['actual'] == qualification['expected'] == expected
    config = report['configuration']
    required = dict(samples=18, warmups=2, processes=4, timeout=180, session=session,
                    c_arch=c_arch, rust_cpu=rust_cpu, case=list(CASES))
    assert {key: config[key] for key in required} == required
    if scalar or 'comparison' in config:
        assert config['comparison'] == comparison
    assert report['constructionPaths'] == {'fwp': 'compiled make-input', 'reference':
        'compiled make-input with scalar specialization disabled' if scalar else 'C driver runtime calls'}
    assert len(report['allowedCpus']) == len(set(report['allowedCpus'])) == 4
    environment = report['executionEnvironment']
    assert all(environment[key] == value for key, value in dict(
        FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0').items())
    assert report['removedEnvironment'] == ['FWP_NO_OPT', 'FWP_NO_REUSE']
    assert not set(report['removedEnvironment']) & environment.keys()
    assert digest(read('fwp-compiler')) == report['compilerSha256']
    assert json.loads(read('configuration.json')) == {key: value for key, value in report.items() if key not in ('results', 'failures')}
    assert json.loads(read('results.json')) == report['results']
    assert list(report['results']) == list(CASES)
    assert set(report['sourceTrees']) == {'src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs'}
    assert set(report['sourceHashes']) == {
        'scripts/measure-array-construction.py', 'scripts/array_construction_phases.py',
        'scripts/current_kernel_costs.py', 'scripts/measure-kernel-baselines.py',
        'scripts/numerical-baselines.py', 'tests/fixtures/numerical_bench.c',
        'tests/fixtures/numerical_bench.rs', 'tests/fixtures/numerical_bench_native.c',
        'tests/fixtures/array_construction_costs.fwp', 'src/cgen.rs'} | (
        {'scripts/prepare-scalar-array-reference.py'} if scalar else set())
    sources = {}
    for name, sha in report['sourceHashes'].items():
        raw = subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT)
        assert digest(raw) == sha
        sources[name] = raw.decode()
    for name, tree in report['sourceTrees'].items():
        assert subprocess.check_output(['git', 'rev-parse', source + ':' + name], cwd=ROOT, text=True).strip() == tree
    prerequisite = subprocess.check_output(['git', 'show', source + ':docs/measurements/array-construction-2026-11-02/index.json'], cwd=ROOT)
    assert digest(prerequisite) == report['prerequisiteSha256']
    previous = json.loads(prerequisite)
    assert len(previous['jobs']) == 2 and all(job['conclusion'] == 'success' for job in previous['jobs'])
    for name in (*report['sourceTrees'], 'tests/fixtures/array_construction_costs.fwp'):
        if scalar and name == 'src':
            continue
        old = subprocess.check_output(['git', 'rev-parse', previous['source'] + ':' + name], cwd=ROOT)
        current = subprocess.check_output(['git', 'rev-parse', source + ':' + name], cwd=ROOT)
        assert old == current
    if scalar:
        manifest = report['referenceManifest']
        assert json.loads(read('reference-manifest.json')) == manifest
        assert manifest['source'] == source and manifest['disabledTransformation'] == 'direct scalar array captures'
        assert digest(read('reference-compiler')) == manifest['compilerSha256']
        reference_codegen = REFERENCE.reference_source(sources['src/cgen.rs'])
        assert read('codegen-reference.rs').decode() == reference_codegen
        assert digest(reference_codegen.encode()) == manifest['referenceCodegenSha256']
        assert digest(sources['src/cgen.rs'].encode()) == manifest['candidateCodegenSha256']
        assert digest(read('reference.patch')) == manifest['patchSha256']
        assert digest(subprocess.check_output(['git', 'show', source + ':src/ownership.rs'], cwd=ROOT)) == manifest['ownershipSha256']
        safety = report['safety']
        assert len(safety['jobs']) == 3 and all(job['conclusion'] == 'success' and job['head_sha'] == safety['source'] for job in safety['jobs'])
        assert {job['name'] for job in safety['jobs']} == {
            'scalar_array_checks (ubuntu-latest, gcc)', 'scalar_array_checks (ubuntu-24.04-arm, gcc)',
            'scalar_array_checks (macos-15, clang)'}
        for name in ('src', 'runtime', 'lib', 'tests', 'Cargo.toml', 'Cargo.lock', 'build.rs'):
            verified = subprocess.check_output(['git', 'rev-parse', safety['source'] + ':' + name], cwd=ROOT)
            measured = subprocess.check_output(['git', 'rev-parse', source + ':' + name], cwd=ROOT)
            assert verified == measured
    commands = {}
    for line in read('commands.jsonl').splitlines():
        command = json.loads(line)
        name = command['artifact']
        assert name not in commands and not command['timedOut'] and command['elapsedNs'] > 0
        assert command['status'] == (224 if name.endswith('-leak-check') else 0)
        for stream in ('stdout', 'stderr'):
            raw = read(name + '.' + stream)
            assert digest(raw) == command[stream + 'Sha256']
            if stream == 'stderr' and not name.endswith(('-rss', '-leak-check')):
                assert not raw, name
        commands[name] = command
    positions = {name: index for index, name in enumerate(commands)}
    first_timing = min(index for name, index in positions.items() if '/warmup-' in name)
    assert all(index < first_timing for name, index in positions.items()
               if name.endswith(('-build', '-verify-output', '-profile-output', '-phases-output', '-leak-check')))
    for case, dimensions in CASES.items():
        row = report['results'][case]
        assert row['dimensions'] == list(dimensions)
        elements = dimensions[0]
        values = [[PHASES.MEASURE.BASELINE.array_result(elements, round_number)] for round_number in range(8)]
        expected_output = PHASES.MEASURE.BASELINE.verification_output(values)
        expected_hash = PHASES.MEASURE.BASELINE.result_hash(values)
        assert row['resultHash'] == expected_hash
        assert read(case + '/expected-values.txt') == expected_output
        assert read(case + '/kernel.fwp').decode() == sources['tests/fixtures/array_construction_costs.fwp']
        modules = {}
        for label in (('fwp', 'reference') if scalar else ('fwp',)):
            generated = read(case + ('/generated.c' if label == 'fwp' else '/reference-generated.c')).decode()
            entries = {}
            for name in ('make-input', 'reduce64'):
                marker = generated.index('/* ' + name + ' :')
                entries[name] = 'f' + generated[marker:].split('static V f', 1)[1].split('(', 1)[0]
            modules[label] = (generated, entries)
        expected_images = {label + '-' + mode for label in ('c', 'rust', 'fwp', 'reference')
                           for mode in ('timing', 'profile', 'verify')}
        if not scalar:
            expected_images |= {'fwp-phases', 'reference-phases'}
        assert set(row['binaries']) == expected_images
        for image, info in row['binaries'].items():
            label, mode = image.split('-', 1)
            profile, verification = mode in ('profile', 'phases'), mode == 'verify'
            extension = '.rs' if label == 'rust' else '.c'
            if label in ('fwp', 'reference'):
                generated, entries = modules[label if scalar else 'fwp']
                expected_source = PHASES.native_source(generated, entries['reduce64'], entries['make-input'],
                    dimensions, 'fwp' if scalar else label, profile, verification, mode == 'phases')
            else:
                expected_source = PHASES.peer_source(sources['tests/fixtures/numerical_bench' + extension], label, dimensions, verification)
            raw_source = read(case + '/' + image + extension)
            assert raw_source.decode() == expected_source
            assert digest(raw_source) == info['sourceSha256']
            raw = read(case + '/' + info['path'])
            assert len(raw) == info['bytes'] and digest(raw) == info['sha256']
            sections = read(case + '/' + info['path'] + '-sections.stdout')
            size = sum(int(value, 16) for value in re.findall(rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections, re.M))
            assert size == info['instructionBytes'] and 0 < size <= len(raw)
            symbols = read(case + '/' + info['path'] + '-symbols.stdout')
            assert not any(symbol in symbols for symbol in (b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'))
            command = commands[case + '/' + image + '-build']['command']
            if label == 'rust':
                expected_flags = [config['rustc'], '--edition=2021', '--crate-name', 'kernel_' + mode,
                                  '-C', 'opt-level=2', '-C', 'target-cpu=' + rust_cpu]
                if profile:
                    expected_flags += ['--cfg', 'memory_profile']
                assert command[:-3] == expected_flags and command[-2] == '-o'
                source_path, binary_path = command[-3], command[-1]
            else:
                expected_flags = [config['cc'], '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + c_arch,
                    '-w', '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=' + str(int(profile)), '-DMATRIX_BENCH=0']
                assert command[:-5] == expected_flags and command[-4] == '-o' and command[-2:] == ['-lm', '-lpthread']
                source_path, binary_path = command[-5], command[-3]
            assert Path(source_path).name == image + extension and Path(binary_path).name == info['path']
            if verification:
                output = read(case + '/' + label + '-verify-output.stdout')
                assert b'\n'.join(re.findall(rb'^\d+:\d+:[0-9a-f]{16}$', output, re.M)) + b'\n' == expected_output
            if profile:
                output = read(case + '/' + label + '-' + mode + '-output.stdout')
                samples = PHASES.check_samples(output, expected_hash, label, True, mode == 'phases')
                assert samples == row['phaseProfiles' if mode == 'phases' else 'profiles'][label]
                for sample in samples:
                    assert sample['requests'] == 8
                    assert sample['requestedBytes'] == 8 * (elements * 8 + (8 if label in ('fwp', 'reference') else 0))
                    if label in ('fwp', 'reference'):
                        assert sample['retains'] == sample['nonlastReleases'] == 0
        assert set(row['profiles']) == {'c', 'rust', 'fwp', 'reference'}
        assert set(row['phaseProfiles']) == (set() if scalar else {'fwp', 'reference'})
        assert row['rolePaths'] == {label: f'role{index:04d}.exe' for index, label in enumerate(LABELS)}
        for label in ('fwp', 'reference'):
            assert read(case + '/' + row['rolePaths'][label]) == read(case + '/' + row['rolePaths'][label + '-identical'])
            ordinary = read(case + '/' + label + '-profile.c').decode()
            leaked = PHASES.replace_once(ordinary, 'uint64_t elapsed=bench_clock()-start;',
                'fwp_rc_fresh(fwp_array_new_packed(1,&scalar));uint64_t elapsed=bench_clock()-start;')
            assert read(case + '/' + label + '-missing-owner-release.c').decode() == leaked
            assert b'unexpected charged storage' in read(case + '/' + label + '-leak-check.stderr')
        for record in row['observations']:
            phase, index = record['phase'], record['round']
            assert json.loads(read(f'{case}/{phase}-{index}.json')) == record
            for position, observation in enumerate(record['observations']):
                name = f'{case}/{phase}-{index}-{position}'
                command = commands[name]
                label = observation['label']
                assert Path(command['command'][0]).name == row['rolePaths'][label]
                assert command['command'][1:] == (['array'] if label in ('c', 'rust') else [])
                assert observation['processNs'] == command['elapsedNs']
                assert PHASES.check_samples(read(name + '.stdout'), expected_hash, label, False, False) == observation['samples']
        summary = summarize(row['observations'], 4, PHASES.METRICS)
        assert all(row[name] == value for name, value in summary.items())
        assert set(row['peakProcessRssBytes']) == set(LABELS)
        for label, size in row['peakProcessRssBytes'].items():
            raw = read(case + '/' + label + '-rss.stderr')
            assert size == int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', raw)[1]) * 1024 and size > 0
            PHASES.check_samples(read(case + '/' + label + '-rss.stdout'), expected_hash, label, False, False)
        assert row['stack']
        for name, stack in row['stack'].items():
            raw = read(case + '/' + name)
            assert digest(raw) == stack['sha256']
            entries = [dict(location=p, bytes=int(size), qualifier=q) for p, size, q in
                       (line.split('\t') for line in raw.decode().splitlines())]
            assert entries == stack['entries'] and entries
    failures = [dict(kind='copy', case=case, label=label, metric=metric, ratio=ratio, limit=1.02)
        for case, row in report['results'].items() for label, scopes in row['identicalRatios'].items()
        for metric, ratio in scopes.items() if ratio > 1.02]
    if scalar:
        for case, row in report['results'].items():
            for metric, ratio in row['ratios']['reference'].items():
                limit = 1.02 if metric == 'kernelNs' else 0.95
                if ratio > limit:
                    failures.append(dict(kind='speed', case=case, metric=metric, ratio=ratio, limit=limit))
            for index, (candidate, reference) in enumerate(zip(row['profiles']['fwp'], row['profiles']['reference'])):
                for metric in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes'):
                    if candidate[metric] > reference[metric]:
                        failures.append(dict(kind='memory', case=case, sample=index, metric=metric,
                            candidate=candidate[metric], reference=reference[metric]))
    assert report['failures'] == failures
    print(f'{machine} session {session}: raw results, identities, sources and cleanup agree; {len(failures)} unmet limits')
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--comparison', choices=('source-paths', 'scalar-captures'), required=True)
    parser.add_argument('--archive', type=Path, required=True)
    parser.add_argument('--prefix', required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=tuple(HOSTS), required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    args = parser.parse_args()
    with ZipFile(args.archive) as archive:
        check(archive, args.prefix, args.source, args.machine, args.session, args.comparison)


if __name__ == '__main__':
    main()
