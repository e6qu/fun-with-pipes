#!/usr/bin/env python3
"""Reconstruct retained callback timings and check their storage/image reports.

The full runner audit covers every command and image. This checks the smaller
review copy without executing saved binaries or repeating any measurements.
Unqualified timing results must remain unqualified, not become CI failures.
"""
import argparse
import gzip
import hashlib
import json
from pathlib import Path

from structured_ad_costs import REFERENCE_SOURCE, callback_cases, entry_and_drops
from structured_ad_observations import check_reports, stack_report
from structured_ad_statistics import summarize


SOURCE = '4a32c102f74f738433c1d55969936b023a5510f0'
PRIMARY = ('neighbors-129-local', 'independent-129-local')


def check(directory):
    workload = {case['name']: case for case in callback_cases()}
    for label, machine, session, failed_copies in (
        ('arm1', 'aarch64', 1, 0), ('arm2', 'aarch64', 2, 0),
        ('amd1', 'x86_64', 1, 7), ('amd2', 'x86_64', 2, 5),
    ):
        identity = json.loads((directory / (label + '-identity.json')).read_text())
        saved = json.loads((directory / (label + '-summary.json')).read_text())
        samples = json.loads((directory / (label + '-samples.json')).read_text())
        audit = json.loads((directory / (label + '-audit.json')).read_text())
        controls = json.loads((directory / (label + '-audit-controls.json')).read_text())
        assert identity['source'] == audit['source'] == controls['source'] == SOURCE
        assert identity['referenceSource'] == REFERENCE_SOURCE
        assert identity['machine'] == audit['machine'] == machine
        assert identity['session'] == audit['session'] == controls['session'] == session
        assert identity['comparison'] == audit['comparison'] == 'callbacks'
        assert audit['inputCases'] == len(workload) == 14 and audit['methodCases'] == 28
        assert controls['restored'] is True
        rejected = ['missing timing observation', 'changed arithmetic policy',
                    'wrong native architecture', 'invented speed ratio']
        if session == 1:
            rejected.append('unreleased managed storage')
        assert controls['rejected'] == rejected
        assert set(saved) == set(samples) == set(workload)
        reconstructed = {
            name: summarize(samples[name], ('baseline', 'candidate'), 256, 'baseline')
            | {'binaryHashes': saved[name]['binaryHashes']}
            for name in workload
        }
        assert saved == reconstructed, (label, 'summary differs from original samples')
        comparisons = {name: row['vsBaseline'] for name, row in saved.items()}
        for row in saved.values():
            for role in ('baseline', 'candidate'):
                assert row['binaryHashes'][role] == row['binaryHashes'][role + '-copy']
        assert comparisons == audit['vsBaseline']
        assert sum(not row['candidate']['copyQualified'] for row in comparisons.values()) == failed_copies
        for name in PRIMARY:
            result = comparisons[name]['candidate']
            accepted = result['copyQualified'] and result['interval95'][1] <= 0.90
            assert accepted == (machine == 'aarch64'), (label, name)
        if session != 1:
            continue
        observations = json.loads((directory / (label + '-observations.json')).read_text())
        assert set(observations) == set(workload)
        for name, case in workload.items():
            before, after = (observations[name][role] for role in ('baseline', 'candidate'))
            method = name.rsplit('-', 1)[1]
            for workspace in ('0', '1'):
                for report in (before, after):
                    memory = report['memory'][workspace]
                    check_reports(memory['managed'], memory['rawDerivativeStorage'],
                                  case['count'], 256, method, workspace == '1')
                original = before['memory'][workspace]['managed']
                changed = after['memory'][workspace]['managed']
                assert changed['peakChargedBytes'] <= original['peakChargedBytes'], (label, name)
                if method == 'local':
                    assert changed['requests'] == 256 * (2 * case['count'] + 2), (label, name)
                    assert after['memory'][workspace]['rawDerivativeStorage']['peakBytes'] == 0
            if name not in PRIMARY:
                continue
            for role, report in (('baseline', before), ('candidate', after)):
                root = directory / 'images' / label / name
                image = gzip.decompress((root / (role + '.gz')).read_bytes())
                assert hashlib.sha256(image).hexdigest() == saved[name]['binaryHashes'][role]
                assert image[:6] == b'\x7fELF\x02\x01' and len(image) == report['imageBytes']
                assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[machine]
                source = gzip.decompress((root / (role + '-generated.c.gz')).read_bytes()).decode()
                entry, _, _ = entry_and_drops(source)
                stack = gzip.decompress((root / (role + '.su.gz')).read_bytes()).decode()
                assert stack_report(stack, entry) == report['stack'], (label, name, role)
    print('Four retained sessions reproduce timings, storage and primary image/stack reports; AMD timing acceptance remains open.')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    arguments = parser.parse_args()
    check(arguments.directory)
