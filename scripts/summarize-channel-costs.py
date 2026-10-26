#!/usr/bin/env python3
"""Audit two native channel-count artifacts; report counts without timing claims."""
import argparse
import csv
import hashlib
import json
from pathlib import Path
import re
import subprocess

HOSTS = ('ubuntu-latest', 'ubuntu-24.04-arm')
CASES = ('unique-text', 'unique-function', 'shared-text', 'shared-function',
         'closed-function')
METRICS = ('requests', 'requested_bytes', 'retains', 'peak_charge', 'final_charge',
           'sends', 'accepted', 'unique_payloads', 'queue_retains',
           'binary_bytes')


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def host_report(directory, source):
    assert (directory / 'source.txt').read_text().strip() == source, directory
    with (directory / 'counts.tsv').open() as stream:
        rows = list(csv.DictReader(stream, delimiter='\t'))
    assert len(rows) == 90, (directory, len(rows))
    measurements = []
    seen = set()
    for row in rows:
        assert row['case'] in CASES and row['memory'] in ('arc', 'tracing'), row
        assert row['optimization'] == 'O2', row
        for field in ('messages', 'sample', *METRICS):
            row[field] = int(row[field])
            assert row[field] >= 0, row
        assert row['messages'] in (0, 16, 1024) and row['sample'] in (0, 1, 2), row
        key = (row['case'], row['memory'], row['messages'], row['sample'])
        assert key not in seen, key
        seen.add(key)
        assert row['sends'] == row['messages'], row
        assert row['accepted'] == (0 if row['case'] == 'closed-function' else row['messages']), row
        assert row['unique_payloads'] <= row['accepted'], row
        if row['memory'] == 'arc':
            assert row['final_charge'] == 0, row
        label = f"{row['case']}-{row['memory']}-O2"
        raw = (directory / f"{label}-{row['messages']}-{row['sample']}.stderr").read_text().splitlines()
        assert len(raw) == 2, raw
        assert raw[0].split('\t') == ['client-memory', *[str(row[x]) for x in METRICS[:5]]], row
        assert raw[1].split('\t') == ['channel-counts', *[str(row[x]) for x in METRICS[5:9]]], row
    for case in CASES:
        for memory in ('arc', 'tracing'):
            label = f'{case}-{memory}-O2'
            profiles = {}
            for n in (0, 16, 1024):
                matching = [row for row in rows if row['case'] == case
                            and row['memory'] == memory and row['messages'] == n]
                assert len(matching) == 3
                profile = {key: matching[0][key] for key in METRICS}
                assert all({key: row[key] for key in METRICS} == profile for row in matching), matching
                profiles[str(n)] = profile
            files = {}
            for suffix in ('.c', '.exe', '.asm', '-counted.c', '-counted.exe'):
                path = directory / (label + suffix)
                assert path.stat().st_size > 0, path
                files[path.name] = dict(bytes=path.stat().st_size, sha256=digest(path))
            assert files[label + '.exe']['bytes'] == profiles['0']['binary_bytes']
            measurements.append(dict(case=case, memory=memory, optimization='O2',
                profiles=profiles, files=files,
                # A finite difference over measured sizes, not a claim of a
                # universally linear cost model. Keep baseline setup separate.
                perAdditionalMessage16To1024={key: (profiles['1024'][key] - profiles['16'][key]) / 1008
                    for key in ('requests', 'requested_bytes', 'retains', 'queue_retains')},
                peakChargeGrowth16To1024=profiles['1024']['peak_charge'] - profiles['16']['peak_charge']))
    return dict(environment={name: (directory / f'{name}.txt').read_text()
                for name in ('cpu', 'kernel', 'rust', 'cc', 'settings')}, measurements=measurements)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.source), args.source
    run = json.loads(subprocess.check_output(['gh', 'run', 'view', str(args.run),
        '--repo', 'e6qu/fun-with-pipes', '--json', 'headSha,status,conclusion,jobs,url'], text=True))
    assert run['headSha'] == args.source and run['status'] == 'completed' and run['conclusion'] == 'success', run
    jobs = [job for job in run['jobs'] if job['conclusion'] != 'skipped']
    assert {job['name'] for job in jobs} == {f'channel_transfer_costs ({host})' for host in HOSTS}, jobs
    assert len(jobs) == 2 and all(job['conclusion'] == 'success' for job in jobs), jobs
    hosts = []
    for host in HOSTS:
        job, = [job for job in jobs if job['name'] == f'channel_transfer_costs ({host})']
        assert all(step['conclusion'] != 'failure' for step in job['steps']), job
        report = host_report(args.artifacts / f'channel-costs-{host}', args.source)
        hosts.append(dict(host=host, job=job['databaseId'], **report))
    report = dict(source=args.source, run=args.run, url=run['url'],
        scope='Five sequential channel programs; raw interpreter and ordinary native results agree. '
              'Three fresh count profiles per input (0, 16, 1024), ARC/tracing, GCC O2. '
              'No timing, C/Rust peer, concurrency or total process memory claim. '
              'Requested and charged managed bytes exclude raw buffers, allocator metadata and stacks. '
              'Code hashes identify saved ordinary/instrumented binaries and ordinary disassembly.', hosts=hosts)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    print('Two native hosts, 180 count samples and 20 ordinary binaries audited')


if __name__ == '__main__':
    main()
