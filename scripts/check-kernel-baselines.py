#!/usr/bin/env python3
"""Check retained kernel measurements without confusing partial and full coverage."""
import argparse
from collections import Counter
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import statistics

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('kernel_oracles', ROOT / 'scripts/numerical-baselines.py')
ORACLE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ORACLE)
CASES = {'array-65537': (65537, 65, 67, 63), 'array-262145': (262145, 65, 67, 63),
         'matrix-65-67-63': (65537, 65, 67, 63), 'matrix-257-259-255': (65537, 257, 259, 255)}
METRICS = ['kernelNs', 'allocationInclusiveNs']
HOSTS = {
    'arm64': dict(machine='aarch64', cpu='Neoverse-N2', cVersion='gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0'),
    'amd64': dict(machine='x86_64', cpu='AMD EPYC 7763 64-Core Processor', cVersion='gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0'),
}


def check_samples(samples, label, expected_hash):
    assert len(samples) == 5
    for sample in samples:
        assert sample['hash'] == expected_hash
        assert all(type(sample[k]) is int for k in METRICS)
        assert sample['allocationInclusiveNs'] >= sample['kernelNs'] > 0
        assert sample['liveChargedBytes' if label.startswith('fwp') else 'livePayloadBytes'] == 0
        assert all(type(sample[k]) is int and sample[k] >= 0 for k in ['requests', 'requestedBytes'])


def check_report(report, source, architecture, session, small_matrix_processes):
    assert report['source'] == source and not report['failures']
    config = report['configuration']
    assert {k: config[k] for k in ['samples', 'warmups', 'processes', 'order_seed', 'timeout', 'session']} == dict(
        samples=16, warmups=2, processes=4, order_seed=20261029, timeout=180, session=session)
    assert small_matrix_processes in [4, 256]
    if small_matrix_processes == 256:
        assert config['small_matrix_processes'] == 256
    else:
        assert 'small_matrix_processes' not in config
    assert config['case'] == list(CASES)
    assert config['c_arch'] == ('armv8-a' if architecture == 'arm64' else 'x86-64')
    assert config['rust_cpu'] == ('generic' if architecture == 'arm64' else 'x86-64')
    host = report['qualification']
    assert host['source'] == source and host['qualified'] and not host['failures']
    expected_host = dict(system='Linux', processors=4, rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)', **HOSTS[architecture])
    assert host['actual'] == host['expected'] == expected_host
    assert list(report['results']) == list(CASES)
    expected_files = {}
    for name, dimensions in CASES.items():
        n, m, k, columns = dimensions
        row = report['results'][name]
        assert row['dimensions'] == list(dimensions)
        values = [ORACLE.matrix_result(m, k, columns, r) if name.startswith('matrix') else
                  [ORACLE.array_result(n, r)] for r in range(8)]
        expected_hash = ORACLE.result_hash(values)
        raw = ORACLE.verification_output(values)
        expected_files[name] = dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest())
        assert row['resultHash'] == expected_hash
        assert len(row['observations']) == 18
        processes = small_matrix_processes if name == 'matrix-65-67-63' else 4
        totals = {label: {metric: [] for metric in METRICS} for label in ORACLE.LABELS}
        for position, record in enumerate(row['observations']):
            phase, index = ('warmup', position) if position < 2 else ('sample', position - 2)
            assert record['complete'] and record['phase'] == phase and record['round'] == index
            assert record['order'] == ORACLE.execution_order(index, 20261029, processes)
            assert Counter(record['order']) == Counter({label: processes for label in ORACLE.LABELS})
            assert [o['label'] for o in record['observations']] == record['order']
            for observation in record['observations']:
                assert type(observation['processNs']) is int and observation['processNs'] > 0
                check_samples(observation['samples'], observation['label'], expected_hash)
            if phase == 'sample':
                for label in ORACLE.LABELS:
                    for metric in METRICS:
                        totals[label][metric].append(sum(s[metric] for o in record['observations']
                                                        if o['label'] == label for s in o['samples']))
        assert totals == row['totals']
        medians = {label: {metric: statistics.median(samples) for metric, samples in scopes.items()}
                   for label, scopes in totals.items()}
        assert medians == row['medians']
        ratios = {metric: max(medians['fwp'][metric], medians['fwp-identical'][metric]) /
                  min(medians['fwp'][metric], medians['fwp-identical'][metric]) for metric in METRICS}
        assert ratios == row['identicalRatios'] and max(ratios.values()) <= 1.02
        assert set(row['profiles']) == {'c', 'rust', 'fwp'}
        for label, samples in row['profiles'].items():
            check_samples(samples, label, expected_hash)
            assert all(s['requests'] > 0 for s in samples)
        assert set(row['peakProcessRssBytes']) == set(ORACLE.LABELS)
        assert all(type(n) is int and n > 0 for n in row['peakProcessRssBytes'].values())
        assert set(row['binaries']) == {f'{language}-{mode}' for language in ['c', 'rust', 'fwp']
                                       for mode in ['timing', 'profile', 'verify']}
        assert set(row['stack']) == {f'{language}-{mode}.su' for language in ['c', 'fwp']
                                    for mode in ['timing', 'profile', 'verify']}
    return expected_files


def check_archive(path, coverage):
    archive = json.loads(path.read_text())
    required = {(architecture, session) for architecture in
                (['arm64'] if coverage == 'initial-arm' else ['arm64', 'amd64']) for session in [1, 2]}
    assert coverage in ['initial-arm', 'complete']
    small_matrix_processes = 4 if coverage == 'initial-arm' else 256
    sessions = archive['sessions']
    assert len(sessions) == len(required)
    assert {(s['architecture'], s['session']) for s in sessions} == required
    identities, source_hashes = set(), None
    for session in sessions:
        job = session['jobMetadata']
        assert job['id'] == session['job'] and job['run_id'] == session['run']
        assert job['head_sha'] == session['source'] and job['status'] == 'completed' and job['conclusion'] == 'success'
        identity = (job['runner_id'], job['started_at'], job['completed_at'])
        assert identity not in identities
        identities.add(identity)
        raw = gzip.decompress((path.parent / session['report']).read_bytes())
        files = session['files']
        assert len(raw) == files['comparison.json']['bytes']
        assert hashlib.sha256(raw).hexdigest() == files['comparison.json']['sha256']
        log = gzip.decompress((path.parent / session['log']).read_bytes())
        assert len(log) == session['logBytes'] and hashlib.sha256(log).hexdigest() == session['logSha256']
        report = json.loads(raw)
        expected_files = check_report(report, session['source'], session['architecture'], session['session'], small_matrix_processes)
        if source_hashes is None:
            source_hashes = report['sourceHashes']
        assert report['sourceHashes'] == source_hashes
        for case, row in report['results'].items():
            assert files[f'{case}/fwp-identical'] == files[f'{case}/fwp-timing']
            for image, info in row['binaries'].items():
                assert files[f'{case}/{image}'] == dict(bytes=info['bytes'], sha256=info['sha256'])
                extension = '.rs' if image.startswith('rust-') else '.c'
                assert files[f'{case}/{image}{extension}']['sha256'] == info['sourceSha256']
                assert files[f'{case}/{image}-assembly.stdout']['sha256'] == info['assemblySha256']
                assert 0 < info['instructionBytes'] <= info['bytes']
            for name, info in row['stack'].items():
                assert files[f'{case}/{name}']['sha256'] == info['sha256']
                assert info['entries'] and all(e['bytes'] >= 0 for e in info['entries'])
            assert files[f'{case}/expected-values.txt'] == expected_files[case]
            assert f'{case}/leak-check.stderr' in files
            for record in row['observations']:
                raw = (json.dumps(record, indent=2) + '\n').encode()
                name = f"{case}/{record['phase']}-{record['round']}.json"
                assert files[name] == dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest())
            processes = small_matrix_processes if case == 'matrix-65-67-63' else 4
            for phase, count in [('warmup', 2), ('sample', 16)]:
                for index in range(count):
                    assert f'{case}/{phase}-{index}.json' in files
                    assert all(f'{case}/{phase}-{index}-{p}.{stream}' in files
                               for p in range(4 * processes) for stream in ['stdout', 'stderr'])
    print(f'{coverage}: {len(sessions)} kernel sessions verified; incomplete coverage is not full N1 acceptance')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    parser.add_argument('--coverage', choices=['initial-arm', 'complete'], required=True)
    args = parser.parse_args()
    check_archive(args.archive, args.coverage)
