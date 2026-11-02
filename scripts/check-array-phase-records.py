#!/usr/bin/env python3
"""Check retained phase reports and decisions after their complete raw-file audit."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import subprocess

import array_construction_phases as PHASES
from current_kernel_costs import LABELS, summarize

ROOT = Path(__file__).resolve().parent.parent
CASES = {name: dimensions for name, dimensions in PHASES.MEASURE.CASES.items() if name.startswith('array')}


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def check(directory):
    index = json.loads((directory / 'index.json').read_text())
    seen = set()
    for record in index['records']:
        key = (record['machine'], record['session'])
        assert key not in seen and key[0] in ('aarch64', 'x86_64') and key[1] in (1, 2)
        seen.add(key)
        raw = gzip.decompress((directory / record['report']).read_bytes())
        report = json.loads(raw)
        files = json.loads(gzip.decompress((directory / record['files']).read_bytes()))
        assert files['comparison.json'] == dict(bytes=len(raw), sha256=digest(raw))
        source = record['source']
        assert report['source'] == source == record['artifact']['workflow_run']['head_sha']
        assert record['artifact']['workflow_run']['id'] == record['run']
        qualification = report['qualification']
        assert qualification['qualified'] and not qualification['failures'] and qualification['source'] == source
        assert qualification['actual'] == qualification['expected']
        assert qualification['actual']['machine'] == record['machine']
        config = report['configuration']
        required = dict(samples=18, warmups=2, processes=4, timeout=180, session=record['session'], case=list(CASES))
        assert {key: config[key] for key in required} == required
        for name, sha in report['sourceHashes'].items():
            assert digest(subprocess.check_output(['git', 'show', source + ':' + name], cwd=ROOT)) == sha
        assert files['fwp-compiler']['sha256'] == report['compilerSha256']
        assert list(report['results']) == list(CASES)
        for case, row in report['results'].items():
            assert row['dimensions'] == list(CASES[case])
            elements = CASES[case][0]
            values = [[PHASES.MEASURE.BASELINE.array_result(elements, r)] for r in range(8)]
            expected_hash = PHASES.MEASURE.BASELINE.result_hash(values)
            assert row['resultHash'] == expected_hash
            for observation in row['observations']:
                for entry in observation['observations']:
                    PHASES.check_samples(json.dumps(dict(samples=entry['samples'])), expected_hash, entry['label'], False, False)
            summary = summarize(row['observations'], 4, PHASES.METRICS)
            assert all(row[key] == value for key, value in summary.items())
            for group, phases in (('profiles', False), ('phaseProfiles', True)):
                assert set(row[group]) == ({'fwp', 'reference'} if phases else {'fwp', 'reference', 'c', 'rust'})
                for label, samples in row[group].items():
                    PHASES.check_samples(json.dumps(dict(samples=samples)), expected_hash, label, True, phases)
                    for sample in samples:
                        assert sample['requests'] == 8
                        assert sample['requestedBytes'] == 8 * (elements * 8 + (8 if label in ('fwp', 'reference') else 0))
                        if label in ('fwp', 'reference'):
                            assert sample['retains'] == sample['nonlastReleases'] == 0
            for image in row['binaries'].values():
                assert files[case + '/' + image['path']] == dict(bytes=image['bytes'], sha256=image['sha256'])
            assert set(row['peakProcessRssBytes']) == set(LABELS)
        failures = [dict(kind='copy', case=case, label=label, metric=metric, ratio=ratio, limit=1.02)
            for case, row in report['results'].items() for label, scopes in row['identicalRatios'].items()
            for metric, ratio in scopes.items() if ratio > 1.02]
        assert failures == report['failures'] and len(failures) == record['failedCopyLimits']
        assert record['conclusion'] == ('failure' if failures else 'success')
    remaining = [machine + ' session ' + str(session) for machine in ('aarch64', 'x86_64')
                 for session in (1, 2) if (machine, session) not in seen]
    assert index['remaining'] == remaining
    print(f'{len(seen)} retained sessions reproduce samples, storage, binary identities and every failed limit; remaining: {remaining}')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    args = parser.parse_args()
    check(args.directory)


if __name__ == '__main__':
    main()
