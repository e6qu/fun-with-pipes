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
args.output.write_text(json.dumps({
    'comparison': 'Older fwp versus current fwp; no C/Rust parity claim. Ratios above one mean the current variant takes longer.',
    'baseline_run': 'https://github.com/e6qu/fun-with-pipes/actions/runs/' + args.baseline_run,
    'current_run': 'https://github.com/e6qu/fun-with-pipes/actions/runs/' + args.current_run,
    'hosts': hosts,
}, indent=2) + '\n')
