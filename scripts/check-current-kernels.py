#!/usr/bin/env python3
"""Audit complete current-kernel evidence, retaining failed performance decisions."""
import argparse
import ast
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

from current_kernel_costs import LABELS, decisions, storage_label, summarize

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('kernel_measurement', ROOT / 'scripts/measure-kernel-baselines.py')
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)
SPEC = importlib.util.spec_from_file_location('recorded_patch', ROOT / 'scripts/check-array-list-evidence.py')
PATCH = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PATCH)
HOSTS = {
    'aarch64': ('Neoverse-N2', 'gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0', 'armv8-a', 'generic'),
    'x86_64': ('AMD EPYC 7763 64-Core Processor', 'gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0', 'x86-64', 'x86-64'),
}


def digest(data):
    return hashlib.sha256(data).hexdigest()


def recorded_test_expectations(preparation):
    """Read the measured preparation's literal test changes, without executing it."""
    declarations = [node.value for node in ast.parse(preparation).body
                    if isinstance(node, ast.Assign) and any(
                        isinstance(target, ast.Name) and target.id == 'TEST_EXPECTATIONS'
                        for target in node.targets)]
    assert len(declarations) <= 1
    if not declarations:
        return {}  # Initial evidence predates the reference assertion repair.
    changes = ast.literal_eval(declarations[0])
    assert set(changes) == {'tests/loop_preparation_ownership.rs', 'tests/nested_loop_boxing.rs'}
    for pair in changes.values():
        assert isinstance(pair, tuple) and len(pair) == 2
        assert all(isinstance(value, str) and value for value in pair)
        assert pair[0].replace('double v3', 'V v3') == pair[1] and pair[0] != pair[1]
    return changes


def check_report(report, source, machine, session):
    assert re.fullmatch('[0-9a-f]{40}', source) and report['source'] == source
    assert machine in HOSTS and session in (1, 2)
    cpu, cc, c_arch, rust_cpu = HOSTS[machine]
    qualification = report['qualification']
    assert qualification['source'] == source and qualification['qualified'] and not qualification['failures']
    expected = dict(system='Linux', processors=4, machine=machine, cpu=cpu, cVersion=cc,
                    rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)')
    assert qualification['actual'] == qualification['expected'] == expected
    config = report['configuration']
    required = dict(samples=18, warmups=2, processes=4, small_matrix_processes=256,
                    timeout=180, session=session, c_arch=c_arch, rust_cpu=rust_cpu,
                    case=list(MEASURE.CASES))
    assert {key: config[key] for key in required} == required
    assert len(report['allowedCpus']) == len(set(report['allowedCpus'])) == 4
    environment = report['executionEnvironment']
    assert all(environment[key] == value for key, value in dict(
        FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0').items())
    assert report['removedEnvironment'] == ['FWP_NO_OPT', 'FWP_NO_REUSE']
    assert all(key not in environment for key in report['removedEnvironment'])
    assert set(report['sourceTrees']) == {'src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs'}
    assert set(report['sourceHashes']) == {
        'scripts/measure-current-kernels.py', 'scripts/current_kernel_costs.py',
        'scripts/measure-kernel-baselines.py', 'scripts/numerical-baselines.py',
        'scripts/prepare-loop-state-reference.py', 'tests/fixtures/numerical_bench.c',
        'tests/fixtures/numerical_bench.rs', 'tests/fixtures/numerical_bench_native.c', 'src/cgen.rs'}
    assert set(report['compilerSha256']) == {'fwp', 'reference'}
    manifest = report['referenceManifest']
    assert manifest['source'] == source
    assert manifest['disabledTransformation'] == 'native floating-point loop-state fields'
    assert manifest['compilerSha256'] == report['compilerSha256']['reference']
    assert list(report['results']) == list(MEASURE.CASES)
    for case, dimensions in MEASURE.CASES.items():
        row = report['results'][case]
        assert row['dimensions'] == list(dimensions)
        elements, rows, inner, columns = dimensions
        values = [MEASURE.BASELINE.matrix_result(rows, inner, columns, r) if case.startswith('matrix')
                  else [MEASURE.BASELINE.array_result(elements, r)] for r in range(8)]
        expected_hash = MEASURE.BASELINE.result_hash(values)
        assert row['resultHash'] == expected_hash
        processes = 256 if case == 'matrix-65-67-63' else 4
        for record in row['observations']:
            for observation in record['observations']:
                assert type(observation['processNs']) is int and observation['processNs'] > 0
                MEASURE.check_samples(json.dumps(dict(samples=observation['samples'])).encode(),
                                      expected_hash, storage_label(observation['label']), False)
        summary = summarize(row['observations'], processes)
        assert all(row[key] == value for key, value in summary.items())
        assert set(row['profiles']) == {'c', 'rust', 'fwp', 'reference'}
        for label, samples in row['profiles'].items():
            MEASURE.check_samples(json.dumps(dict(samples=samples)).encode(),
                                  expected_hash, storage_label(label), True)
            for sample in samples:
                assert all(type(value) is int and value >= 0 for key, value in sample.items() if key != 'hash')
        assert set(row['peakProcessRssBytes']) == set(LABELS)
        assert all(type(n) is int and n > 0 for n in row['peakProcessRssBytes'].values())
        assert row['rolePaths'] == {label: f'role{index:04d}.exe' for index, label in enumerate(LABELS)}
        assert set(row['binaries']) == {f'{label}-{mode}' for label in ('c', 'rust', 'fwp', 'reference')
                                       for mode in ('timing', 'profile', 'verify')}
        assert row['stack'] and all(item['entries'] for item in row['stack'].values())
    assert report['failures'] == decisions(report['results'])
    return report['failures']


def check_directory(directory, source, machine, session):
    report = json.loads((directory / 'comparison.json').read_text())
    failures = check_report(report, source, machine, session)
    identity = json.loads((directory / 'configuration.json').read_text())
    assert identity == {k: v for k, v in report.items() if k not in ('results', 'failures')}
    assert json.loads((directory / 'results.json').read_text()) == report['results']
    assert json.loads((directory / 'reference-manifest.json').read_text()) == report['referenceManifest']
    manifest = report['referenceManifest']
    candidate = subprocess.check_output(['git', 'show', source + ':src/cgen.rs'], cwd=ROOT, text=True)
    preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-loop-state-reference.py'], cwd=ROOT, text=True)
    reference = PATCH.recorded_reference(candidate, preparation)
    changes = recorded_test_expectations(preparation)
    if changes:
        assert set(manifest['testExpectations']) == set(changes)
        for name, (before, after) in changes.items():
            original = subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT, text=True)
            assert original.count(before) == 1 and after not in original
            updated = original.replace(before, after)
            assert (directory / name).read_text() == updated
            assert manifest['testExpectations'][name] == dict(candidateSha256=digest(original.encode()),
                                                            referenceSha256=digest(updated.encode()))
    else:
        assert 'testExpectations' not in manifest
    assert (directory / 'codegen-reference.rs').read_text() == reference
    ownership = subprocess.check_output(['git', 'show', source + ':src/ownership.rs'], cwd=ROOT)
    assert digest(ownership) == manifest['ownershipSha256']
    assert digest(candidate.encode()) == manifest['candidateCodegenSha256']
    assert digest(reference.encode()) == manifest['referenceCodegenSha256']
    assert digest((directory / 'reference.patch').read_bytes()) == manifest['patchSha256']
    for name, sha in report['sourceHashes'].items():
        assert digest(subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT)) == sha
    for name, tree in report['sourceTrees'].items():
        assert subprocess.check_output(['git', 'rev-parse', source + ':' + name], cwd=ROOT, text=True).strip() == tree
    for label, sha in report['compilerSha256'].items():
        assert digest((directory / (label + '-compiler')).read_bytes()) == sha
    commands = {}
    for line in (directory / 'commands.jsonl').read_text().splitlines():
        command = json.loads(line)
        artifact = command['artifact']
        assert artifact not in commands and not command['timedOut']
        assert command['status'] == (224 if artifact.endswith('-leak-check') else 0)
        assert command['elapsedNs'] > 0
        for stream in ('stdout', 'stderr'):
            raw = (directory / (artifact + '.' + stream)).read_bytes()
            assert digest(raw) == command[stream + 'Sha256']
            if stream == 'stderr' and not artifact.endswith(('-rss', '-leak-check')):
                assert not raw
        commands[artifact] = command
    for case, row in report['results'].items():
        case_dir = directory / case
        elements, rows, inner, columns = row['dimensions']
        values = [MEASURE.BASELINE.matrix_result(rows, inner, columns, r) if case.startswith('matrix')
                  else [MEASURE.BASELINE.array_result(elements, r)] for r in range(8)]
        expected = MEASURE.BASELINE.verification_output(values)
        assert (case_dir / 'expected-values.txt').read_bytes() == expected
        for image, info in row['binaries'].items():
            raw = (case_dir / info['path']).read_bytes()
            assert len(raw) == info['bytes'] and digest(raw) == info['sha256']
            assert 0 < info['instructionBytes'] <= len(raw)
            assert PATCH.instruction_bytes(raw, machine) == info['instructionBytes']
            label, mode = image.split('-', 1)
            build = commands[f'{case}/{label}-{mode}-build']['command']
            if label == 'rust':
                expected_prefix = [report['configuration']['rustc'], '--edition=2021', '--crate-name', 'kernel_' + mode,
                    '-C', 'opt-level=2', '-C', 'target-cpu=' + report['configuration']['rust_cpu']]
                if mode == 'profile':
                    expected_prefix += ['--cfg', 'memory_profile']
                assert build[:-3] == expected_prefix and build[-2] == '-o'
                assert Path(build[-3]).name == image + '.rs' and Path(build[-1]).name == info['path']
            else:
                expected_prefix = [report['configuration']['cc'], '-O2', '-std=gnu11', '-ffp-contract=off',
                    '-march=' + report['configuration']['c_arch'], '-w', '-fstack-usage', '-UFWP_NO_REUSE',
                    '-DPROFILE=' + str(int(mode == 'profile')), '-DMATRIX_BENCH=' + str(int(case.startswith('matrix')))]
                assert build[:-5] == expected_prefix and build[-4] == '-o' and build[-2:] == ['-lm', '-lpthread']
                assert Path(build[-5]).name == image + '.c' and Path(build[-3]).name == info['path']
            extension = '.rs' if image.startswith('rust-') else '.c'
            assert digest((case_dir / (image + extension)).read_bytes()) == info['sourceSha256']
            sections = (case_dir / (info['path'] + '-sections.stdout')).read_bytes()
            measured_size = sum(int(size, 16) for size in re.findall(
                rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections, re.M))
            assert measured_size == info['instructionBytes']
            symbols = (case_dir / (info['path'] + '-symbols.stdout')).read_bytes()
            assert not any(name in symbols for name in (b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'))
        for label in ('fwp', 'reference'):
            assert (case_dir / row['rolePaths'][label]).read_bytes() == (case_dir / row['rolePaths'][label + '-identical']).read_bytes()
            assert b'unexpected charged storage' in (case_dir / (label + '-leak-check.stderr')).read_bytes()
        for label in ('c', 'rust', 'fwp', 'reference'):
            raw = (case_dir / (label + '-verify-output.stdout')).read_bytes()
            observed = b'\n'.join(re.findall(rb'^\d+:\d+:[0-9a-f]{16}$', raw, re.M)) + b'\n'
            assert observed == expected
            raw = (case_dir / (label + '-profile-output.stdout')).read_bytes()
            assert json.loads(raw)['samples'] == row['profiles'][label]
        for record in row['observations']:
            prefix = f"{case}/{record['phase']}-{record['round']}"
            assert json.loads((directory / (prefix + '.json')).read_text()) == record
            for index, observation in enumerate(record['observations']):
                key = f'{prefix}-{index}'
                command = commands[key]
                label = observation['label']
                assert Path(command['command'][0]).name == row['rolePaths'][label]
                assert command['command'][1:] == ([] if storage_label(label).startswith('fwp') else
                    ['matrix' if case.startswith('matrix') else 'array'])
                assert command['elapsedNs'] == observation['processNs']
                assert json.loads((directory / (key + '.stdout')).read_text())['samples'] == observation['samples']
        for label in LABELS:
            raw = (case_dir / (label + '-rss.stdout')).read_bytes()
            MEASURE.check_samples(raw, row['resultHash'], storage_label(label), False)
            diagnostic = (case_dir / (label + '-rss.stderr')).read_bytes()
            observed_rss = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', diagnostic)[1]) * 1024
            assert observed_rss == row['peakProcessRssBytes'][label]
        for name, info in row['stack'].items():
            raw = (case_dir / name).read_bytes()
            assert digest(raw) == info['sha256']
            entries = [dict(location=p, bytes=int(size), qualifier=q) for p, size, q in
                       (line.split('\t') for line in raw.decode().splitlines())]
            assert entries == info['entries'] and all(e['bytes'] >= 0 for e in entries)
    return failures


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--machine', choices=tuple(HOSTS), required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    args = parser.parse_args()
    failures = check_directory(args.directory, args.source, args.machine, args.session)
    print(f'All four cases and raw evidence agree; {len(failures)} retained performance failures')


if __name__ == '__main__':
    main()
