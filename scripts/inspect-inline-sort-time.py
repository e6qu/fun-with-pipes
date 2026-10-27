#!/usr/bin/env python3
"""Verify retained sort timings, binary identity and pre-candidate noise budgets."""

import argparse
import hashlib
import json
from pathlib import Path
import statistics


def check_case(row, settings):
    elements = row['elements']
    assert elements in (256, 4096)
    assert row['rounds'] == settings['small_rounds' if elements == 256 else 'large_rounds']
    assert len(row['control']) == 2
    ratios = []
    for index, session in enumerate(row['control']):
        assert session['session'] == index and len(session['pairs']) == settings['samples']
        for sample, pair in enumerate(session['pairs']):
            order = ['baseline', 'baseline-copy'] if sample % 2 == 0 else ['baseline-copy', 'baseline']
            assert list(pair) == order
            assert all(type(value) is int and value >= 1_000_000 for value in pair.values())
            ratios.append(pair['baseline-copy'] / pair['baseline'])
    noise = max(abs(ratio - 1) for ratio in ratios)
    assert row['controlEnvelope'] == noise
    assert row['allowedCandidateRatio'] == 1 + 2 * noise
    if 1 + noise > settings['max_control_ratio']:
        assert row['candidate'] == [], 'candidate ran despite rejected noise control'
        return [f'{elements}: identical-code control exceeds explicit noise limit']
    assert len(row['candidate']) == 2
    failures = []
    for index, session in enumerate(row['candidate']):
        assert session['session'] == index and len(session['pairs']) == settings['samples']
        ratios = []
        for sample, pair in enumerate(session['pairs']):
            order = ['baseline', 'candidate'] if sample % 2 == 0 else ['candidate', 'baseline']
            assert list(pair) == order
            assert all(type(value) is int and value >= 1_000_000 for value in pair.values())
            ratios.append(pair['candidate'] / pair['baseline'])
        ratio = statistics.median(ratios)
        assert session['medianRatio'] == ratio
        if ratio > row['allowedCandidateRatio']:
            failures.append(f'{elements}/{index}: candidate exceeds frozen ratio budget')
    return failures


def audit(directory, source):
    report = json.loads((directory / 'report.json').read_text())
    assert report['protocolSource'] == source
    settings = report['settings']
    assert settings['samples'] == 6 and settings['warmups'] == 2
    assert settings['cpu'] == 1 and settings['max_control_ratio'] == 1.10
    assert report['baselineSource'] == settings['baseline_source']
    assert report['candidateSource'] == settings['candidate_source']
    assert set(report['cases']) == {'256', '4096'}
    assert set(report['files']) == {'baseline', 'candidate'}
    machine = {'x86_64': 62, 'aarch64': 183}[report['machine']]
    for label, files in report['files'].items():
        code = (directory / (label + '.c')).read_bytes()
        binary = (directory / (label + '.exe')).read_bytes()
        assert hashlib.sha256(code).hexdigest() == files['harness']
        assert hashlib.sha256(binary).hexdigest() == files['binary']
        assert len(binary) == files['binaryBytes']
        assert binary[:6] == b'\x7fELF\x02\x01' and int.from_bytes(binary[18:20], 'little') == machine
    assert (directory / 'baseline-copy.exe').read_bytes() == (directory / 'baseline.exe').read_bytes()
    failures = []
    for label, row in report['cases'].items():
        assert str(row['elements']) == label
        problems = check_case(row, settings)
        failures.extend(problems)
        frozen = directory / f'budget-{label}.json'
        if row['candidate']:
            budget = json.loads(frozen.read_text())
            assert budget == dict(row, candidate=[]), 'saved pre-candidate budget changed'
        else:
            assert not frozen.exists(), 'noisy control cannot produce an accepted budget'
    assert report['failures'] == failures
    return report


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', required=True, type=Path)
    parser.add_argument('--source', required=True)
    args = parser.parse_args()
    report = audit(args.input, args.source)
    assert not report['failures'], '\n'.join(report['failures'])
    print('Both sizes: binary hashes, all sample pairs and frozen budgets verified')


if __name__ == '__main__':
    main()
