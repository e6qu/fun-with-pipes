#!/usr/bin/env python3
"""Compare validated function-allocation summaries and paired runner timings."""
import argparse
import csv
import itertools
import json
import statistics
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--baseline-summary', type=Path, required=True)
parser.add_argument('--current-summary', type=Path, required=True)
parser.add_argument('--current-artifact', type=Path, action='append', required=True)
parser.add_argument('--baseline-run', required=True)
parser.add_argument('--current-run', required=True)
parser.add_argument('--memory-artifact', type=Path, action='append', required=True)
parser.add_argument('--memory-run', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
baseline = {host['artifact']: host for host in json.loads(args.baseline_summary.read_text())['hosts']}
current = {host['artifact']: host for host in json.loads(args.current_summary.read_text())['hosts']}
assert baseline.keys() == current.keys() == {directory.name for directory in args.current_artifact}


def sections(path):
    result = {}
    for line in path.read_text().splitlines():
        fields = line.split()
        if len(fields) == 3 and fields[1].isdigit():
            result[fields[0]] = int(fields[1])
    assert result['.text'] > 0
    return result


hosts = []
for directory in args.current_artifact:
    before, after = baseline[directory.name], current[directory.name]
    assert (directory / 'revision.txt').read_text().strip() == after['revision']
    assert (directory / 'baseline-revision.txt').read_text().strip() == before['revision']
    for source in ['server.fwp', 'repeated-client.fwp']:
        assert before['sha256'][source] == after['sha256'][source]
    assert before['sha256']['server.c'] == after['sha256']['server-baseline.c']
    with (directory / 'server-timing.tsv').open() as source:
        timings = list(csv.DictReader(source, delimiter='\t'))
    assert len(timings) == 24
    assert {(r['tls'], int(r['repetition']), r['variant']) for r in timings} == set(
        itertools.product(['false', 'true'], range(6), ['baseline', 'current']))
    for row in timings:
        row.update({key: int(value) for key, value in row.items() if key not in ['tls', 'variant']})
        assert row['calls'] == 8192
        assert row['position'] == (row['repetition'] % 2 if row['variant'] == 'baseline' else 1 - row['repetition'] % 2)
        assert row['elapsed_ns'] > 0 and row['startup_ns'] > 0
        assert row['warm_rss_kib'] > 0 and row['final_rss_kib'] > 0
    summaries = []
    for tls in ['false', 'true']:
        selected = [r for r in timings if r['tls'] == tls]
        medians = {variant: {field: statistics.median(r[field] for r in selected if r['variant'] == variant)
                            for field in ['elapsed_ns', 'startup_ns', 'warm_rss_kib', 'final_rss_kib']}
                   for variant in ['baseline', 'current']}
        ratios = {}
        for field in ['elapsed_ns', 'startup_ns']:
            pairs = [{r['variant']: r[field] for r in selected if r['repetition'] == repetition}
                     for repetition in range(6)]
            ratios[field] = [pair['current'] / pair['baseline'] for pair in pairs]
        summaries.append({'tls': tls == 'true', 'medians': medians,
                          'paired_current_over_baseline_ratios': ratios,
                          'median_paired_ratios': {field: statistics.median(values) for field, values in ratios.items()}})
    binary = json.loads((directory / 'fixed-function-binary-review.json').read_text())
    assert binary['revision'] == after['revision']
    assert binary['binary_sha256'] == after['sha256']['server.exe']
    assert binary['source_sha256'] == after['sha256']['server.c']
    host = {'artifact': directory.name,
            'baseline_revision': before['revision'], 'current_revision': after['revision'],
            'profile_method': json.loads(args.current_summary.read_text())['method'],
            'profile_scope': after['scope'], 'timing_scope': (directory / 'timing-scope.txt').read_text(),
            'cpu': after['cpu'], 'platform': after['platform'], 'c_compiler': after['c_compiler'],
            'rust_compiler': after['rust_compiler'],
            'baseline_profile': [{key: value for key, value in row.items() if key != 'ranked_executed_sites'} for row in before['summaries']],
            'current_profile': [{key: value for key, value in row.items() if key != 'ranked_executed_sites'} for row in after['summaries']],
            'baseline_raw_totals': before['raw_totals'], 'current_raw_totals': after['raw_totals'],
            'baseline_sha256': before['sha256'], 'current_sha256': after['sha256'],
            'timing_raw_samples': timings, 'timing_summaries': summaries,
            'baseline_sections': sections(directory / 'baseline-sections.txt'),
            'current_sections': sections(directory / 'server-sections.txt'),
            'static_function_objects': {key: value for key, value in binary.items() if key != 'objects'}}
    assert host['current_sections'] == binary['sections']
    hosts.append(host)
    print(directory.name, [(row['tls'], row['median_paired_ratios']) for row in summaries])
memory_hosts = []
assert {directory.name for directory in args.memory_artifact} == {
    'http-server-memory-' + host for host in ['ubuntu-latest', 'ubuntu-24.04-arm',
    'macos-15', 'macos-15-intel', 'windows-2025', 'windows-11-arm']}
for directory in args.memory_artifact:
    revision = (directory / 'revision.txt').read_text().strip()
    assert revision in {host['revision'] for host in current.values()}
    root = directory / 'server-memory'
    def table(name):
        with (root / name).open() as source:
            return list(csv.DictReader(source, delimiter='\t'))
    rows, rss, entries = table('server-memory.tsv'), table('server-rss.tsv'), table('entry-checks.tsv')
    assert len(rows) == 36 and len(rss) == 20 and len(entries) == 48
    assert {(r['mode'], r['tls'], int(r['calls']), int(r['repetition'])) for r in rows} == set(
        itertools.product(['tracing', 'arc'], ['false', 'true'], [1, 16, 256], range(3)))
    assert {(r['mode'], r['tls'], int(r['batch'])) for r in rss} == set(
        itertools.product(['tracing', 'arc'], ['false', 'true'], range(5)))
    expected_entries = {('server', mode, tls, calls, repetition) for mode, tls, calls, repetition in
                        itertools.product(['tracing', 'arc'], ['false', 'true'], [1, 16, 256], range(3))}
    expected_entries.update(('client', mode, tls, calls, 0) for mode, tls, calls in
                            itertools.product(['tracing', 'arc'], ['false', 'true'], [1, 16, 256]))
    assert {(r['role'], r['server_mode'], r['tls'], int(r['calls']), int(r['repetition'])) for r in entries} == expected_entries
    assert all(int(r['entry_check_calls']) == 0 for r in entries)
    summaries = []
    for mode, tls in itertools.product(['tracing', 'arc'], ['false', 'true']):
        selected = [r for r in rows if (r['mode'], r['tls']) == (mode, tls)]
        finals = {int(r['final_charged_bytes']) for r in selected}
        assert len(finals) == 1 and all(int(r['collections']) == 0 for r in selected)
        samples = sorted((r for r in rss if (r['mode'], r['tls']) == (mode, tls)), key=lambda r: int(r['batch']))
        assert [int(r['cumulative_calls']) for r in samples] == [4096 * (i + 1) for i in range(5)]
        resident = [int(r['rss_kib']) for r in samples]
        assert min(resident) > 0 and all(value < resident[0] + 8192 for value in resident[1:])
        slopes = {}
        for field in ['requests', 'requested_bytes', 'retains']:
            medians = {calls: statistics.median(int(r[field]) for r in selected if int(r['calls']) == calls)
                       for calls in [16, 256]}
            slopes[field] = (medians[256] - medians[16]) / 240
        summaries.append({'mode': mode, 'tls': tls == 'true', 'final_managed_bytes': next(iter(finals)),
                          'peak_managed_bytes': max(int(r['peak_charged_bytes']) for r in selected),
                          'largest_rss_growth_kib': max(resident) - resident[0],
                          'median_slopes_per_additional_call': slopes})
    storage = json.loads((directory / 'function-storage-review.json').read_text())
    assert storage['revision'] == revision
    memory_hosts.append({'artifact': directory.name, 'revision': revision,
                         'scope': (root / 'scope.txt').read_text(),
                         'cpu': (directory / 'cpu.txt').read_text(), 'platform': (directory / 'platform.txt').read_text(),
                         'c_compiler': (directory / 'c.txt').read_text(), 'rust_compiler': (directory / 'rust.txt').read_text(),
                         'summaries': summaries, 'raw_managed_rows': rows, 'raw_rss_rows': rss, 'raw_entry_rows': entries,
                         'storage_method': storage['method'],
                         'binaries': [{key: value for key, value in row.items() if key != 'objects'} for row in storage['binaries']]})
    print(directory.name, 'all managed, RSS, entry and binary rows validated')
args.output.write_text(json.dumps({
    'comparison': 'Older fwp versus current fwp; no C/Rust parity claim. Ratios above one mean the current variant takes longer.',
    'baseline_run': 'https://github.com/e6qu/fun-with-pipes/actions/runs/' + args.baseline_run,
    'current_run': 'https://github.com/e6qu/fun-with-pipes/actions/runs/' + args.current_run,
    'memory_run': 'https://github.com/e6qu/fun-with-pipes/actions/runs/' + args.memory_run,
    'hosts': hosts, 'native_memory': memory_hosts,
}, indent=2) + '\n')
