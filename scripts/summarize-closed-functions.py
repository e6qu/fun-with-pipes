#!/usr/bin/env python3
"""Summarize saved function-allocation profiles without executing their binaries."""
import argparse
import csv
import hashlib
import itertools
import json
import statistics
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--artifact', type=Path, action='append', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()


def table(path):
    with path.open() as source:
        return list(csv.DictReader(source, delimiter='\t'))


hosts = []
for directory in args.artifact:
    sites = json.loads((directory / 'sites.json').read_text())['sites']
    assert [site['site'] for site in sites] == list(range(len(sites)))
    rows = table(directory / 'summary.tsv')
    expected = set(itertools.product(['false', 'true'], ['1', '16', '256'], ['0', '1', '2']))
    assert len(rows) == 18
    assert {(r['tls'], r['calls'], r['repetition']) for r in rows} == expected
    profiles = {}
    for row in rows:
        key = (row['tls'], row['calls'], row['repetition'])
        profile = table(directory / ('sites-' + '-'.join(key) + '.tsv'))
        assert len(profile) == len(sites)
        assert [int(p['site']) for p in profile] == list(range(len(sites)))
        allocations = sum(int(p['calls']) for p in profile)
        payload = sum(int(p['calls']) * int(p['requested_payload_bytes']) for p in profile)
        assert allocations == int(row['closed_function_requests']) <= int(row['all_requests'])
        assert payload == int(row['closed_function_requested_bytes']) <= int(row['all_requested_bytes'])
        profiles[key] = profile
    summaries = []
    for tls in ['false', 'true']:
        selected = [r for r in rows if r['tls'] == tls]

        def slope(field):
            def median(calls):
                return statistics.median(int(r[field]) for r in selected if r['calls'] == calls)
            return (median('256') - median('16')) / 240

        costs = {field: slope(field) for field in [
            'all_requests', 'all_requested_bytes', 'retains',
            'closed_function_requests', 'closed_function_requested_bytes']}
        ranked = []
        for site in sites:
            index = site['site']

            def median(calls):
                return statistics.median(int(profiles[(tls, calls, str(r))][index]['calls'])
                                         for r in range(3))

            count = (median('256') - median('16')) / 240
            if count > 0:
                ranked.append({**site, 'allocations_per_additional_call': count})
        ranked.sort(key=lambda site: (-site['allocations_per_additional_call'], site['site']))
        summaries.append({'tls': tls == 'true', 'median_slopes_per_additional_call': costs,
                          'ranked_executed_sites': ranked})
        print(directory.name, 'TLS=' + tls, costs, flush=True)
    hashes = {path.name: hashlib.sha256(path.read_bytes()).hexdigest()
              for path in sorted(directory.iterdir()) if path.suffix in {'.c', '.fwp', '.exe'}}
    hosts.append({'artifact': directory.name, 'revision': (directory / 'revision.txt').read_text().strip(),
                  'cpu': (directory / 'cpu.txt').read_text(),
                  'platform': (directory / 'platform.txt').read_text(),
                  'c_compiler': (directory / 'c.txt').read_text(),
                  'rust_compiler': (directory / 'rust.txt').read_text(),
                  'scope': (directory / 'scope.txt').read_text(),
                  'sites': sites, 'raw_totals': rows, 'summaries': summaries, 'sha256': hashes,
                  'raw_site_counts': [{'tls': key[0], 'calls': key[1], 'repetition': key[2],
                                       'sites': profile} for key, profile in profiles.items()]})
args.output.write_text(json.dumps({
    'comparison': 'Executed function-only partial applications within the same fwp server. No timing or C/Rust comparison.',
    'method': 'Three fresh processes per case. Slopes subtract the 16-call median from the 256-call median and divide by 240; background activity remains included.',
    'hosts': hosts,
}, indent=2) + '\n')
