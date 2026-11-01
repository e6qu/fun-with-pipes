#!/usr/bin/env python3
"""Trace the three derivative callback boxes in retained PR #239 evidence."""

import argparse
import gzip
import hashlib
import json
from pathlib import Path
import re
import zipfile


def audit(summary, archives):
    rows = []
    sources = []
    for host, path in archives.items():
        evidence = summary['hosts'][host]
        assert hashlib.sha256(path.read_bytes()).hexdigest() == evidence['archiveSha256']
        with zipfile.ZipFile(path) as archive:
            for case, report in evidence['cases'].items():
                coordinates, updates, form, optimization = case.split('-')
                coordinates, updates = int(coordinates), int(updates)
                name = f'{case}/ownership-base.c'
                source = archive.read(name)
                digest = hashlib.sha256(source).hexdigest()
                assert digest == evidence['files'][name]
                source = source.decode()
                table = source.split('static const fwp_fninfo fwp_fn_table[] = {', 1)[1]
                table = table.split('};', 1)[0].strip().splitlines()
                sites = {}
                for site in report['sites']['ownership']:
                    if site['operation'] != 'fresh' or 'fwp_record(2,' not in site['source']:
                        continue
                    caller = site['caller']
                    if caller is None or not re.fullmatch(r'f\d+', caller):
                        continue
                    function = int(caller[1:])
                    entry = re.fullmatch(r'\s*\{(\d+), [^,]+, "([^"]+)", [^}]+},', table[function])
                    assert entry is not None, table[function]
                    arity, label = int(entry[1]), entry[2]
                    if label == 'Add[Rev[t]].add':
                        assert arity == 2
                        role = 'sumAccumulator'
                    elif label == 'fused-zip-map' and arity in (2, 3):
                        role = 'pairResults' if arity == 2 else 'inputVertices'
                    else:
                        continue
                    assert f'w{function}(' in site['source']
                    assert role not in [value['role'] for value in sites.values()]
                    sites[site['id']] = dict(role=role, caller=caller, line=site['line'])
                if updates:
                    assert {site['role'] for site in sites.values()} == {
                        'sumAccumulator', 'pairResults', 'inputVertices'}
                sources.append(dict(host=host, case=case, sha256=digest, sites=list(sites.values())))
                for workspace, observation in report['observations'].items():
                    counts = dict(sumAccumulator=0, pairResults=0, inputVertices=0)
                    for row in observation['ownership']:
                        if row['site'] not in sites:
                            continue
                        assert row['phase'] == 'forwardWithRecording'
                        assert row['calls'] == row['effective'] and row['last'] == 0
                        counts[sites[row['site']]['role']] += row['effective']
                    assert counts == dict(
                        sumAccumulator=(coordinates - 1) * updates,
                        pairResults=(coordinates - 1) * updates,
                        inputVertices=coordinates * updates), (host, case, workspace, counts)
                    rows.append(dict(host=host, case=case, workspace=workspace, counts=counts))
    assert len(rows) == 96 and len(sources) == 48
    return dict(source=summary['source'], run=summary['run'],
                scope='Saved callback result-box counts, not timings or a new native execution.',
                sources=sources, observations=rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--summary', type=Path, required=True)
    parser.add_argument('--arm64', type=Path, required=True)
    parser.add_argument('--amd64', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    summary = json.loads(gzip.decompress(args.summary.read_bytes()))
    result = audit(summary, dict(aarch64=args.arm64, x86_64=args.amd64))
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print('96 observations and 48 source hashes verify the three callback boxing counts')


if __name__ == '__main__':
    main()
