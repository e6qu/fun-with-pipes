#!/usr/bin/env python3
"""Describe all retained array sample positions without changing acceptance."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import statistics


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, action='append', required=True)
    parser.add_argument('--case', choices=('array-65537', 'array-262145'), action='append', required=True)
    parser.add_argument('--mode', choices=('write', 'check'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert len(set(args.directory)) == len(args.directory)
    assert len(set(args.case)) == len(args.case)
    results = []
    for directory in args.directory:
        index = json.loads((directory / 'index.json').read_text())
        assert not index['remaining'] and len(index['records']) == 4
        assert {(r['machine'], r['session']) for r in index['records']} == {
            (machine, session) for machine in ('aarch64', 'x86_64') for session in (1, 2)}
        for record in index['records']:
            raw = gzip.decompress((directory / record['report']).read_bytes())
            files = json.loads(gzip.decompress((directory / record['files']).read_bytes()))
            identity = dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest())
            assert files['comparison.json'] == identity
            report = json.loads(raw)
            assert report['source'] == record['source']
            assert report['configuration']['processes'] == 4
            for case in args.case:
                row = report['results'][case]
                rounds = [r for r in row['observations'] if r['phase'] == 'sample']
                assert len(rounds) == 18 and all(r['complete'] for r in rounds)
                result = dict(experiment=directory.name, machine=record['machine'],
                    session=record['session'], case=case, source=record['source'],
                    job=record['job'], reportSha256=identity['sha256'],
                    constructionPaths=report['constructionPaths'], labels={},
                    originalFailures=report['failures'])
                for label in row['medians']:
                    observations = [x for r in rounds for x in r['observations'] if x['label'] == label]
                    assert len(observations) == 72
                    assert all(len(x['samples']) == 5 for x in observations)
                    metrics = {}
                    for metric in ('constructionNs', 'kernelNs', 'allocationInclusiveNs'):
                        differences = [x['samples'][0][metric] - x['samples'][4][metric]
                                       for x in observations]
                        deciles = statistics.quantiles(differences, n=10, method='exclusive')
                        metrics[metric] = dict(samplePositionMedianNs=[
                            statistics.median(x['samples'][i][metric] for x in observations)
                            for i in range(5)], firstMinusLastMedianNs=statistics.median(differences),
                            firstMinusLastP10Ns=deciles[0], firstMinusLastP90Ns=deciles[-1])
                    result['labels'][label] = dict(processes=72, metrics=metrics)
                results.append(result)
    output = dict(schema=1,
        scope='All 18 measured rounds, 72 processes per role and all five samples; each sample contains eight arrays',
        timingAcceptance='Unchanged; descriptive analysis only', results=results)
    encoded = json.dumps(output, indent=2) + '\n'
    if args.mode == 'write':
        args.output.write_text(encoded)
    else:
        assert args.output.read_text() == encoded
    print(f'{len(results)} experiment/session/case records retain every measured process and original failed limit')


if __name__ == '__main__':
    main()
