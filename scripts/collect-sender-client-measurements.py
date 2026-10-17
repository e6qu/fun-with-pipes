#!/usr/bin/env python3
"""Retain six-platform input-iterator measurements without executing artifacts."""
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
MODES = {'synchronous': 2080, 'bidirectional': 439,
         'retained-input': 878, 'early-completion': 60}


def fingerprint(path):
    data = path.read_bytes()
    return {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}


def table(path):
    with path.open() as stream:
        return [{key: value if key == 'mode' else int(value) for key, value in row.items()}
                for row in csv.DictReader(stream, delimiter='\t')]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True)
    parser.add_argument('--head', required=True)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--baseline-report', type=Path)
    args = parser.parse_args()
    baseline = json.loads(args.baseline_report.read_text()) if args.baseline_report else None
    if baseline:
        assert baseline['source_revision'] != args.head
        assert {h['host'] for h in baseline['hosts']} == HOSTS
        assert baseline['modes'] == MODES
    run = json.loads(subprocess.check_output([
        'gh', 'run', 'view', args.run, '--repo', REPO,
        '--json', 'headSha,status,conclusion,jobs,url']))
    assert run['headSha'] == args.head and run['status'] == 'completed' and run['conclusion'] == 'success'
    jobs = [job for job in run['jobs'] if job['conclusion'] != 'skipped']
    assert len(jobs) == 6 and {j['name'] for j in jobs} == {f'paths ({h})' for h in HOSTS}
    checks = ['sender_input_memory_measurement', 'every_kind_of_call',
              'stream_aliases_are_consistent_across_tasks', 'calls_are_concurrent',
              'task_handles_and_cached_results_have_independent_owners',
              'fatal_runtime_allocations_report_errors_from_task_stacks',
              'library_unload_closes_idle_connections_before_draining_tasks',
              'owned_client_streams_release_after_readers_and_senders_finish',
              'request_encoding_buffer_releases_on_encode_trap_and_cancelled_send',
              'unique_closure_captures_move_through_partial_calls_and_failures']
    output_tables = args.output.parent / args.output.stem
    output_tables.mkdir(parents=True, exist_ok=True)
    hosts = []
    for job in jobs:
        assert job['status'] == 'completed' and job['conclusion'] == 'success'
        host = job['name'][len('paths ('):-1]
        folder = args.artifacts / ('sender-clients-' + host)
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
        keys = {(mode, batches, rep) for mode in MODES for batches in [1, 16, 256] for rep in range(3)}
        key = lambda row: (row['mode'], row['batches'], row['repetition'])
        assert len(rows) == len(keys) and {key(r) for r in rows} == keys
        inputs = table(folder / 'senders.tsv')
        assert len(inputs) == len(keys) and {key(r) for r in inputs} == keys
        storage = table(folder / 'connection-storage.tsv')
        assert len(storage) == len(keys) and {key(r) for r in storage} == keys
        checkpoints = table(folder / 'checkpoints.tsv')
        drains = table(folder / 'drains.tsv')
        assert len(checkpoints) == len(drains) == 4 * 3 * (1 + 16 + 256)
        summaries = []
        for row in rows:
            mode, batches, rep = key(row)
            assert row['collections'] == 0
            assert row['connections_created'] == row['connections_finalized'] == batches
            assert row['streams_created'] == row['streams_finalized'] == batches
            responses = 1 if mode == 'synchronous' else 3 if mode == 'early-completion' else 64
            assert row['messages_created'] == row['messages_freed'] == responses * batches
            assert row['message_requested_bytes'] == row['message_freed_bytes']
            source = next(item for item in inputs if key(item) == key(row))
            senders = 0 if mode == 'synchronous' else batches
            assert source['senders_created'] == source['senders_finished'] == senders
            assert source['inputs_pulled'] == source['inputs_encoded']
            assert 3 * batches <= source['inputs_pulled'] <= 64 * batches
            if mode != 'early-completion':
                assert source['inputs_pulled'] == 64 * batches
            assert source['sender_requested_bytes'] == senders * source['sender_bytes']
            assert source['sender_task_requested_bytes'] == senders * source['task_bytes']
            for table_rows, ordinal in [(checkpoints, 'prior_streams'), (drains, 'connections_created')]:
                selected = [item for item in table_rows if key(item) == key(row)]
                assert len(selected) == batches
                first = 0 if ordinal == 'prior_streams' else 1
                assert [item[ordinal] for item in selected] == list(range(first, batches + first))
            for drain in (item for item in drains if key(item) == key(row)):
                assert drain['connections_created'] == drain['connections_closed']
                assert all(drain[field] == 0 for field in
                    ['live_tasks', 'unfinalized_connections', 'unfinalized_streams', 'message_bytes'])
            summaries.append({'mode': mode, 'batches': batches, 'repetition': rep,
                'remaining_managed_bytes': row['final_charged_bytes'],
                'inputs_pulled': source['inputs_pulled'], 'inputs_encoded': source['inputs_encoded']})
        comparison = None
        if baseline:
            earlier = next(h for h in baseline['hosts'] if h['host'] == host)
            prior = {key(r): r for r in earlier['rows']}
            for mode in MODES:
                # Early completion need not perform equal work, but cleanup must
                # leave the same bounded final storage at every offered input size.
                assert len({r['final_charged_bytes'] for r in rows if r['mode'] == mode}) == 1
                assert max(r['final_charged_bytes'] for r in rows if r['mode'] == mode) < max(
                    r['final_charged_bytes'] for r in earlier['rows'] if r['mode'] == mode)
                assert fingerprint(folder / (mode + '.fwp')) == earlier['files'][mode + '.fwp']
            comparison = [{'mode': r['mode'], 'batches': r['batches'], 'repetition': r['repetition'],
                'change_from_baseline': {field: r[field] - prior[key(r)][field] for field in
                    ['requests', 'requested_bytes', 'retains', 'peak_charged_bytes', 'final_charged_bytes']}}
                for r in rows]
        control = (folder / 'missing-sender-drain.log').read_text()
        # Rust's probe requires exit 213. Keep its complete output and job check.
        assert control.rstrip().endswith('--- exit 213'), (host, control)
        names = ['source.txt', 'rust.txt', 'c.txt', 'cpu.txt', 'scope.txt', 'greeter.fwp',
                 'primitive-inventory.json', 'job.log', 'missing-sender-drain.log', 'missing-sender-drain.c']
        suffix = '.exe' if host.startswith('windows-') else ''
        names.append('missing-sender-drain' + suffix)
        raw = {}
        for name in ['memory.tsv', 'checkpoints.tsv', 'drains.tsv', 'senders.tsv', 'connection-storage.tsv']:
            names.append(name)
            destination = output_tables / (host + '-' + name)
            shutil.copyfile(folder / name, destination)
            raw[name] = {'file': str(destination.relative_to(args.output.parent)), **fingerprint(destination)}
        for mode in MODES:
            names += [mode + ext for ext in ['.fwp', '.c', '-measured.c', suffix, '-measured' + suffix]]
            names += [f'{mode}-{n}-{rep}.log' for n in [1, 16, 256] for rep in range(3)]
        observations = folder / 'binary-observations.json'
        if observations.exists():
            names.append(observations.name)
        hosts.append({'host': host, 'job_url': job['url'], 'rows': rows, 'inputs': inputs,
            'connection_storage_allocations': storage, 'summaries': summaries, 'comparison': comparison,
            'raw_tables': raw, 'scope': (folder / 'scope.txt').read_text(),
            'environment': {name: (folder / (name + '.txt')).read_text() for name in ['rust', 'c', 'cpu']},
            'binary_observations': json.loads(observations.read_text()) if observations.exists() else None,
            'files': {name: fingerprint(folder / name) for name in names}})
    report = {'source_revision': args.head, 'run_url': run['url'], 'checks': checks, 'modes': MODES,
        'sampling': '1, 16 and 256 calls, up to 64 input values, three independent measured processes per case. Instrumented native clients close each connection and drain reader/writer/sender tasks before the next call and final sample. Counters start after constant initialization and end before whole-runtime shutdown, after root execution and cached-value cleanup.',
        'limits': 'No collection, physical freeing enabled. Interpreter and ordinary native output are functional references using normal pooling, so transport work differs. Ownership comparisons must use the same closing hooks. Early server completion can change how many inputs are pulled/encoded; actual counts are retained and allocation deltas are not equal-work speed measurements. Allocation categories are cumulative, not live-object attribution. Stack pools, other raw buffers, TLS/OS/allocator metadata, server/process memory and timing are excluded. This does not establish checked ARC, zero-cost abstractions or C/Rust parity.',
        'hosts': hosts}
    if baseline:
        report['baseline'] = {'file': args.baseline_report.name, 'source_revision': baseline['source_revision'],
                              'run_url': baseline['run_url'], **fingerprint(args.baseline_report)}
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print(f'Retained six native sender measurements at {args.head}')


if __name__ == '__main__':
    main()
