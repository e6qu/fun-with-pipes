#!/usr/bin/env python3
"""Retain six-platform server memory evidence without executing artifacts."""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import shutil
import subprocess

REPO = 'e6qu/fun-with-pipes'
HOSTS = {'ubuntu-latest', 'ubuntu-24.04-arm', 'macos-15', 'macos-15-intel',
         'windows-2025', 'windows-11-arm'}
MODES = {'unary-strings': 71, 'response-stream': 2080,
         'request-stream': 2080, 'channel-output': 439}


def fingerprint(path):
    data = path.read_bytes()
    return {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}


def table(path):
    with path.open() as stream:
        return [{key: value if key == 'mode' else int(value)
                 for key, value in row.items()}
                for row in csv.DictReader(stream, delimiter='\t')]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True)
    parser.add_argument('--head', required=True)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    run = json.loads(subprocess.check_output([
        'gh', 'run', 'view', args.run, '--repo', REPO,
        '--json', 'headSha,status,conclusion,jobs,url']))
    assert run['headSha'] == args.head
    assert run['status'] == 'completed' and run['conclusion'] == 'success'
    jobs = [job for job in run['jobs'] if job['conclusion'] != 'skipped']
    assert len(jobs) == 6
    assert {job['name'] for job in jobs} == {f'paths ({host})' for host in HOSTS}
    checks = ['every_kind_of_call', 'server_measurement::repeated_server_call_memory']
    output_tables = args.output.parent / args.output.stem
    output_tables.mkdir(parents=True, exist_ok=True)
    expected_keys = {(mode, calls, rep) for mode in MODES
                     for calls in [1, 16, 256] for rep in range(3)}
    key = lambda row: (row['mode'], row['calls'], row['repetition'])
    hosts = []
    for job in jobs:
        assert job['status'] == 'completed' and job['conclusion'] == 'success'
        host = job['name'][len('paths ('):-1]
        folder = args.artifacts / ('server-calls-' + host)
        if not folder.exists():
            subprocess.run(['gh', 'run', 'download', args.run, '--repo', REPO,
                            '--name', folder.name, '--dir', str(folder)], check=True)
        assert (folder / 'source.txt').read_text().strip() == args.head
        log = folder / 'job.log'
        if not log.exists():
            job_id = job['url'].rsplit('/', 1)[-1]
            log.write_bytes(subprocess.check_output(['gh', 'api', '--allow-escape-sequences',
                f'repos/{REPO}/actions/jobs/{job_id}/logs']))
        content = log.read_text()
        for check in checks:
            assert f'test {check} ... ok' in content, (host, check)
        inventory = json.loads((folder / 'primitive-inventory.json').read_text())
        assert inventory['head'] == args.head
        rows = table(folder / 'memory.tsv')
        checkpoints = table(folder / 'checkpoints.tsv')
        storage = table(folder / 'storage.tsv')
        for data in [rows, storage]:
            assert len(data) == len(expected_keys) and {key(row) for row in data} == expected_keys
        assert len(checkpoints) == 4 * 3 * (1 + 16 + 256)
        for row in rows:
            mode, calls, rep = key(row)
            assert row['collections'] == 0
            assert row['calls_started'] == row['calls_finished'] == calls
            assert row['connections_created'] == row['connections_closed'] == 1
            assert all(row[field] == 0 for field in
                       ['live_call_tasks', 'live_io_tasks', 'live_other_tasks'])
            assert row['peak_charged_bytes'] >= row['final_charged_bytes'] >= 0
            category = next(item for item in storage if key(item) == key(row))
            assert category['job_requested_bytes'] == calls * category['job_header_bytes']
            assert category['task_requested_bytes'] == calls * category['task_header_bytes']
            for category_name in ['job', 'task', 'args']:
                assert category[category_name + '_charged_bytes'] >= category[category_name + '_requested_bytes']
            selected = [item for item in checkpoints if key(item) == key(row)]
            assert len(selected) == calls
            assert [item['completed_calls'] for item in selected] == list(range(1, calls + 1))
            assert all(item['live_call_tasks'] == item['live_other_tasks'] == 0 for item in selected)
            raw_log = (folder / f'{mode}-{calls}-{rep}.log').read_text()
            assert raw_log.count('server-final\t') == raw_log.count('server-storage\t') == 1
            assert raw_log.count('server-call\t') == calls
        names = ['source.txt', 'rust.txt', 'c.txt', 'cpu.txt', 'scope.txt',
                 'greeter.fwp', 'primitive-inventory.json', 'job.log']
        raw = {}
        for name in ['memory.tsv', 'checkpoints.tsv', 'storage.tsv']:
            names.append(name)
            destination = output_tables / (host + '-' + name)
            shutil.copyfile(folder / name, destination)
            raw[name] = {'file': str(destination.relative_to(args.output.parent)), **fingerprint(destination)}
        suffix = '.exe' if host.startswith('windows-') else ''
        for mode in MODES:
            names.append(mode + '.fwp')
            for variant in ['client', 'server', 'server-measured']:
                names += [f'{mode}-{variant}.c', f'{mode}-{variant}{suffix}']
            names += [f'{mode}-{calls}-{rep}.log' for calls in [1, 16, 256] for rep in range(3)]
        observations = folder / 'binary-observations.json'
        inspected = json.loads(observations.read_text()) if observations.exists() else None
        if host in {'ubuntu-latest', 'ubuntu-24.04-arm'}:
            assert inspected is not None, (host, 'missing actual-binary inspection')
            review = inspected.get('manual_review', {})
            assert review.get('source_revision') == args.head
            assert review.get('architecture') == ('AMD64' if host == 'ubuntu-latest' else 'ARM64')
            assert all(review.get(mode, {}).get('observations')
                       for mode in ['unary-strings', 'request-stream'])
            assert {'unary-strings', 'request-stream'} <= {
                item['workload'] for item in inspected['observations']}
        if inspected:
            assert inspected['source_revision'] == args.head
            names.append(observations.name)
            for item in inspected['observations']:
                mode = item['workload']
                assert mode in MODES
                assert fingerprint(folder / (mode + '-server.c')) == item['source']
                assert fingerprint(folder / (mode + '-server' + suffix)) == item['binary']
                assembly = item['assembly']
                assert assembly['file'] == mode + '-server.asm'
                assert fingerprint(folder / assembly['file']) == {
                    key: assembly[key] for key in ['bytes', 'sha256']}
                names.append(assembly['file'])
        hosts.append({'host': host, 'job_url': job['url'], 'rows': rows,
            'storage_allocations': storage, 'raw_tables': raw,
            'binary_observations': inspected,
            'scope': (folder / 'scope.txt').read_text(),
            'environment': {name: (folder / (name + '.txt')).read_text() for name in ['rust', 'c', 'cpu']},
            'files': {name: fingerprint(folder / name) for name in names}})
    report = {'source_revision': args.head, 'run_url': run['url'], 'checks': checks,
        'per_call_results': MODES,
        'sampling': 'Native -O2 servers receive 1, 16 or 256 calls over one reused connection, three fresh server processes per case. Counters begin after listener/routing/root setup. Per-call samples follow serving-task removal; final samples require client disconnect and no serving/I/O/other tasks while the listener remains open. A measurement-only wake of the existing listener allows retirement of the final finished task without adding a task or connection.',
        'limits': 'Tracing is disabled and physical freeing enabled. Native clients check matching outputs against interpreted and ordinary native servers. Managed storage and cumulative allocation categories do not identify individual live objects. Raw request/wire buffers, stack pools, TLS/OS/allocator metadata, whole-process memory and timing are excluded. This baseline establishes neither server ownership nor checked ARC, zero-cost abstractions or C/Rust parity.',
        'hosts': hosts}
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print(f'Retained six native server measurements at {args.head}')


if __name__ == '__main__':
    main()
