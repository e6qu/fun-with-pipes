#!/usr/bin/env python3
"""Describe every retained process/sample position without changing acceptance."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import statistics


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--case', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    index = json.loads((args.directory / 'index.json').read_text())
    assert index['complete'] and not index['auditErrors']
    results = []
    for metadata in index['jobs']:
        if metadata['job']['id'] not in index['measurements']:
            continue
        raw = gzip.decompress((args.directory / metadata['report']).read_bytes())
        assert len(raw) == metadata['reportBytes']
        assert hashlib.sha256(raw).hexdigest() == metadata['reportSha256']
        report = json.loads(raw)
        row = report['results'][args.case]
        rounds = [r for r in row['observations'] if r['phase'] == 'sample']
        assert len(rounds) == 18 and all(r['complete'] for r in rounds)
        result = dict(machine=metadata['machine'], session=metadata['session'],
                      job=metadata['job']['id'], source=metadata['source'],
                      reportSha256=metadata['reportSha256'], labels={}, roundCopyRatios={})
        for label in row['medians']:
            observations = [x for r in rounds for x in r['observations'] if x['label'] == label]
            assert len(observations) == 18 * 256
            assert all(len(x['samples']) == 5 for x in observations)
            totals = [sum(s['kernelNs'] for s in x['samples']) for x in observations]
            deciles = statistics.quantiles(totals, n=10, method='exclusive')
            result['labels'][label] = dict(processes=len(observations),
                processMeanNs=statistics.mean(totals), processP10Ns=deciles[0],
                processMedianNs=statistics.median(totals), processP90Ns=deciles[-1],
                samplePositionMedianNs=[statistics.median(x['samples'][i]['kernelNs'] for x in observations)
                                        for i in range(5)])
        for label in ('fwp', 'reference'):
            result['roundCopyRatios'][label] = [a / b for a, b in zip(
                row['totals'][label]['kernelNs'], row['totals'][label + '-identical']['kernelNs'])]
        result['originalFailures'] = report['failures']
        results.append(result)
    assert len(results) == len(index['measurements']) == 4
    output = dict(schema=1, case=args.case, scope='Existing 18 measured rounds; all processes and five samples retained',
                  metric='kernelNs', timingAcceptance='Unchanged; descriptive diagnostic only', results=results)
    args.output.write_text(json.dumps(output, indent=2) + '\n')
    print('Summarized all four sessions without omitting measured samples or changing decisions')


if __name__ == '__main__':
    main()
