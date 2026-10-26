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
    parser.add_argument('--baseline-report', type=Path)
    parser.add_argument('--comparison', choices=['storage', 'method-values', 'server-values', 'server-owners', 'server-borrows', 'server-arc', 'server-arc-moves'])
    parser.add_argument('--split-checks', action='store_true',
                        help='Require separate server/client checks for every measured host.')
    parser.add_argument('--linux-probe', action='store_true',
                        help='Retain only a passing Linux AMD64 probe; never claim six-host coverage.')
    args = parser.parse_args()
    if bool(args.baseline_report) != bool(args.comparison):
        parser.error('--baseline-report and --comparison must be supplied together')
    if args.linux_probe and not args.comparison:
        parser.error('--linux-probe requires an explicit comparison')
    expected_hosts = {'ubuntu-latest'} if args.linux_probe else HOSTS
    baseline = json.loads(args.baseline_report.read_text()) if args.baseline_report else None
    if baseline:
        assert baseline['source_revision'] != args.head
        assert expected_hosts <= {h['host'] for h in baseline['hosts']}
        assert baseline['per_call_results'] == MODES
    run = json.loads(subprocess.check_output([
        'gh', 'run', 'view', args.run, '--repo', REPO,
        '--json', 'headSha,status,conclusion,jobs,url']))
    assert run['headSha'] == args.head
    assert run['status'] == 'completed' and run['conclusion'] == 'success'
    jobs = [job for job in run['jobs'] if job['conclusion'] != 'skipped']
    prefixes = ['paths', 'server checks', 'client checks'] if args.split_checks else ['paths']
    assert len(jobs) == len(expected_hosts) * len(prefixes)
    assert {job['name'] for job in jobs} == {
        f'{prefix} ({host})' for host in expected_hosts for prefix in prefixes}
    assert all(job['status'] == 'completed' and job['conclusion'] == 'success' for job in jobs)
    measured_jobs = [job for job in jobs if job['name'].startswith('paths (')]
    checks = ['every_kind_of_call', 'server_measurement::repeated_server_call_memory']
    if baseline:
        checks += ['calls_are_concurrent', 'go_client_interoperates',
                   'stream_aliases_are_consistent_across_tasks',
                   'serving_peer_owner_survives_children_and_releases_at_completion',
                   'served_status_messages_release_after_encoding_and_on_cancellation',
                   'served_buffers_release_on_decode_encode_traps_and_cancelled_send',
                   'received_requests_and_statuses_release_on_errors_and_cancelled_waits',
                   'owned_client_streams_release_after_readers_and_senders_finish',
                   'encoded_messages_release_on_cancel_and_preserve_plain_and_gzip_frames',
                   'task_values_and_channel_aliases_preserve_owners',
                   'deadline_aliases_count_only_owned_types',
                   'deadline_passthrough_preserves_count_reclamation']
    if args.comparison in {'method-values', 'server-values', 'server-owners', 'server-borrows', 'server-arc', 'server-arc-moves'}:
        checks += ['served_values_release_on_partial_decode_aliases_errors_and_cancellation',
                   'input_owners_release_after_lookahead_failure_and_sender_cancellation',
                   'client_request_buffers_release_on_encode_trap_and_cancelled_send']
    if args.comparison in {'server-values', 'server-owners', 'server-borrows', 'server-arc', 'server-arc-moves'}:
        checks += ['native_output_channels_borrow_values_and_release_context',
                   'channels_own_queues_and_transfer_received_values',
                   'tasks_and_data_channels_reclaim_after_join_and_cancellation']
    if args.comparison in {'server-owners', 'server-borrows', 'server-arc', 'server-arc-moves'}:
        checks += ['inactive_state_slots_are_cleared_at_real_collection_and_handler_boundaries',
                   'served_requests_survive_resets_jobs_and_retained_inputs',
                   'accepted_connections_release_after_startup_io_jobs_and_channels',
                   'grpc_connection_startup_releases_failed_task_reservations',
                   'cancelling_grpc_server_releases_listener_and_preserves_accepted_owners']
    if args.comparison in {'server-borrows', 'server-arc', 'server-arc-moves'}:
        checks += ['rc::tests::borrowed_parameters_do_not_become_cleanup_owners',
                   'rc::tests::returned_borrowed_parameter_acquires_an_owner',
                   'rc::tests::external_borrow_survives_consumption_of_a_local_copy',
                   'known_fold_callbacks_borrow_captures_and_elements_without_retain_traffic',
                   'right_fold_releases_accumulator_and_scratch_on_failure',
                   'borrowed_application_preserves_aliases_and_typed_argument_slices']
    if args.comparison in {'server-arc', 'server-arc-moves'}:
        checks.remove('server_measurement::repeated_server_call_memory')
        checks += ['server_measurement::repeated_arc_server_call_memory',
                   'arc_remote_calls_exclude_tracing_and_preserve_behavior',
                   'client_received_buffers_release_on_retry_errors_and_cancelled_waits',
                   'client_failure_text_releases_after_traps_and_typed_errors',
                   'arc_scope::tests::remote_input_continuations_use_the_actual_sender_scope',
                   'arc_scope::tests::served_iterators_do_not_extend_method_scopes']
    if args.comparison == 'server-arc-moves':
        checks += ['wrapper_preparation_failures_and_worker_entry_preserve_exact_owners']
    output_tables = args.output.parent / args.output.stem
    output_tables.mkdir(parents=True, exist_ok=True)
    expected_keys = {(mode, calls, rep) for mode in MODES
                     for calls in [1, 16, 256] for rep in range(3)}
    key = lambda row: (row['mode'], row['calls'], row['repetition'])
    hosts = []
    for job in measured_jobs:
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
        check_logs = ['job.log']
        check_jobs = []
        if args.split_checks:
            for prefix in ['server checks', 'client checks']:
                check_job = next(item for item in jobs if item['name'] == f'{prefix} ({host})')
                check_jobs.append(check_job['url'])
                name = prefix.replace(' ', '-') + '.log'
                check_logs.append(name)
                check_log = folder / name
                if not check_log.exists():
                    check_id = check_job['url'].rsplit('/', 1)[-1]
                    check_log.write_bytes(subprocess.check_output(['gh', 'api', '--allow-escape-sequences',
                        f'repos/{REPO}/actions/jobs/{check_id}/logs']))
        content = '\n'.join((folder / name).read_text() for name in check_logs)
        for check in checks:
            assert f'test {check} ... ok' in content, (host, check)
        if args.comparison in {'server-arc', 'server-arc-moves'}:
            assert (folder / 'memory-mode.txt').read_text().strip() == 'arc'
            if host.startswith('ubuntu-'):
                assert 'test grpc_server_runs_in_bounded_memory ... ok' in content
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
            if args.comparison in {'server-owners', 'server-borrows', 'server-arc', 'server-arc-moves'}:
                assert row['streams_finalized'] == calls
                assert row['connections_finalized'] == 1
                assert row['final_charged_bytes'] == rows[0]['final_charged_bytes'], (host, key(row))
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
        comparison = None
        if baseline:
            earlier = next(h for h in baseline['hosts'] if h['host'] == host)
            prior = {key(row): row for row in earlier['rows']}
            prior_storage = {key(row): row for row in earlier['storage_allocations']}
            # Freeze the language programs, including the service implementation.
            # Never compare reduced work or a different measurement boundary.
            for name in ['greeter.fwp', 'scope.txt'] + [m + '.fwp' for m in MODES]:
                assert fingerprint(folder / name) == earlier['files'][name], (host, name)
            for row in rows:
                before = prior[key(row)]
                category = next(item for item in storage if key(item) == key(row))
                assert category['args_requested_bytes'] == category['args_charged_bytes'] == 0
                calls = row['calls']
                if args.comparison in {'server-arc', 'server-arc-moves'}:
                    allocation_change = requested_change = 0
                    retain_change = -calls if args.comparison == 'server-arc-moves' and row['mode'] == 'unary-strings' else 0
                elif args.comparison in {'server-owners', 'server-borrows'}:
                    # Same allocation requests; finalized request/connection
                    # storage replaces growth. One writer retain per connection,
                    # two per call for parser/job owners, and two more for an
                    # independently retained input source or output channel.
                    allocation_change = requested_change = 0
                    retain_change = 1 + calls * (4 if row['mode'] in {
                        'request-stream', 'channel-output'} else 2)
                    if args.comparison == 'server-borrows' and row['mode'] == 'channel-output':
                        # Its 64 sends borrow the captured channel; independently
                        # live parser/job/source owners still retain storage.
                        retain_change -= 64 * calls
                elif args.comparison == 'storage':
                    allocation_change = -calls
                    requested_change = -prior_storage[key(row)]['args_requested_bytes']
                    retain_change = 0
                else:
                    # Same four 64-element workloads: direct method dispatch
                    # removes its closure. Incoming-stream measurements also show
                    # one fewer 24-byte allocation and 125 fewer retains per call.
                    request_stream = row['mode'] == 'request-stream'
                    allocation_change = -(2 if request_stream else 1) * calls
                    requested_change = -(32 if request_stream else 8) * calls
                    retain_change = {'unary-strings': 1, 'response-stream': 0,
                                     'request-stream': -125, 'channel-output': 0}[row['mode']] * calls
                if args.comparison == 'server-values' and row['mode'] == 'channel-output':
                    allocation_change = -2 * calls
                    retain_change = 64 * calls
                assert row['allocations'] == before['allocations'] + allocation_change, (host, key(row))
                assert row['requested_bytes'] == before['requested_bytes'] + requested_change, (host, key(row))
                assert row['retains'] == before['retains'] + retain_change, (host, key(row))
                if args.comparison in {'server-arc', 'server-arc-moves'}:
                    assert row['final_charged_bytes'] == before['final_charged_bytes'], (host, key(row))
                else:
                    assert row['final_charged_bytes'] < before['final_charged_bytes'], (host, key(row))
            comparison = [{'mode': row['mode'], 'calls': row['calls'],
                'repetition': row['repetition'],
                'change_from_baseline': {field: row[field] - prior[key(row)][field]
                    for field in ['allocations', 'requested_bytes', 'retains',
                                  'peak_charged_bytes', 'final_charged_bytes']}}
                for row in rows]
        names = ['source.txt', 'rust.txt', 'c.txt', 'cpu.txt', 'scope.txt',
                 'greeter.fwp', 'primitive-inventory.json'] + check_logs
        if args.comparison in {'server-arc', 'server-arc-moves'}:
            names.append('memory-mode.txt')
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
                if args.comparison in {'server-arc', 'server-arc-moves'}:
                    assert '#define FWP_ARC_ONLY 1' in (folder / f'{mode}-{variant}.c').read_text()
                    symbols = folder / f'{mode}-{variant}.nm'
                    text = symbols.read_text()
                    assert all(symbol not in text for symbol in [
                        'fwp_heap_scan', 'fwp_heap_mark_all', 'fwp_heap_sweep'])
                    names.append(symbols.name)
            names += [f'{mode}-{calls}-{rep}.log' for calls in [1, 16, 256] for rep in range(3)]
        observations = folder / 'binary-observations.json'
        inspected = json.loads(observations.read_text()) if observations.exists() else None
        if host in {'ubuntu-latest', 'ubuntu-24.04-arm'}:
            assert inspected is not None, (host, 'missing actual-binary inspection')
            review = inspected.get('manual_review', {})
            assert review.get('source_revision') == args.head
            assert review.get('architecture') == ('AMD64' if host == 'ubuntu-latest' else 'ARM64')
            reviewed_modes = {'unary-strings', 'request-stream'}
            if args.comparison in {'server-values', 'server-owners', 'server-borrows', 'server-arc', 'server-arc-moves'}:
                reviewed_modes.add('channel-output')
            assert all(review.get(mode, {}).get('observations') for mode in reviewed_modes)
            assert reviewed_modes <= {
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
        hosts.append({'host': host, 'job_url': job['url'], 'check_job_urls': check_jobs, 'rows': rows,
            'storage_allocations': storage, 'raw_tables': raw,
            'comparison': comparison,
            'binary_observations': inspected,
            'scope': (folder / 'scope.txt').read_text(),
            'environment': {name: (folder / (name + '.txt')).read_text() for name in ['rust', 'c', 'cpu']},
            'files': {name: fingerprint(folder / name) for name in names}})
    report = {'source_revision': args.head, 'run_url': run['url'], 'checks': checks,
        'coverage': 'Linux AMD64 probe only' if args.linux_probe else 'All six native hosts',
        'comparison_kind': args.comparison,
        'per_call_results': MODES,
        'sampling': 'Native -O2 servers receive 1, 16 or 256 calls over one reused connection, three fresh server processes per case. Counters begin after listener/routing/root setup. Per-call samples follow serving-task removal; final samples require client disconnect and no serving/I/O/other tasks while the listener remains open. A measurement-only wake of the existing listener allows retirement of the final finished task without adding a task or connection.',
        'limits': 'Tracing is disabled and physical freeing enabled. Native clients check matching outputs against interpreted and ordinary native servers. Managed storage and cumulative allocation categories do not identify individual live objects. Raw request/wire buffers, stack pools, TLS/OS/allocator metadata, whole-process memory and timing are excluded. Lower retained storage does not establish complete server ownership, checked ARC, lower execution time, zero-cost abstractions or C/Rust parity.',
        'hosts': hosts}
    if args.comparison in {'server-arc', 'server-arc-moves'}:
        report['compiled_memory_mode'] = 'arc'
        report['limits'] = report['limits'].replace('Tracing is disabled',
            'Tracing code is excluded from compiled clients and servers')
    if baseline:
        report['baseline'] = {'source_revision': baseline['source_revision'],
            'run_url': baseline['run_url'], 'report': args.baseline_report.name,
            **fingerprint(args.baseline_report)}
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print(f'Retained {len(hosts)} native server measurement host(s) at {args.head}')


if __name__ == '__main__':
    main()
