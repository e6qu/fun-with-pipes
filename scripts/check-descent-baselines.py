#!/usr/bin/env python3
"""Verify retained D1 baseline observations without treating them as a speedup."""
import argparse
import gzip
import hashlib
import json
import math
from pathlib import Path
import statistics

LABELS = {'fwp-ad-history', 'fwp-ad', 'fwp-explicit', 'fwp-packed',
          'fwp-ad-identical', 'c-explicit', 'rust-explicit'}
CASES = {'3-0', '3-1', '3-199', '3-1999', '33-199', '129-199'}
PHASES = {'setup', 'forwardWithRecording', 'reverseSetup', 'reverseTraversal',
          'resultArray', 'retirement'}


def check_observations(name, row, updates):
    dimensions = row['dimensions']
    controls = {'missing-parent-free', 'missing-result-phase'} if name == '3-1' else set()
    assert set(row['controls']) == controls
    assert len(row['binaries']) == 13 + len(controls)
    assert len(row['cCompilerStackUsage']) == 11 + len(controls)
    assert row['binaries']['fwp-ad']['sha256'] == row['binaries']['fwp-ad-identical']['sha256']
    for label, control in row['controls'].items():
        assert control['status'] == {'missing-parent-free': 232, 'missing-result-phase': 233}[label]
        assert control['stderr']
    assert set(row['fwpProfiles']) == {'fwp-ad-history', 'fwp-ad', 'fwp-explicit', 'fwp-packed'}
    for label, profile in row['fwpProfiles'].items():
        assert profile['managed']['finalChargedBytes'] == 0
        raw = profile['rawDerivativeStorage']
        assert raw['finalBytes'] == 0
        checkpoints = raw['afterBackwardRepeated']
        assert checkpoints['count'] == (updates if label.startswith('fwp-ad') else 0)
        if label.startswith('fwp-ad'):
            without = profile['withoutWorkspace']
            assert without['managed'] == profile['managed']
            assert without['rawDerivativeStorage']['finalBytes'] == 0
    assert set(row['phaseObservations']) == {'fwp-ad-history', 'fwp-ad'}
    for label, phase in row['phaseObservations'].items():
        observations = phase['observations']
        assert len(observations) == 28
        for kind, count in [('warmup', 2), ('sample', 12)]:
            for index in range(count):
                pair = [o for o in observations if o['phase'] == kind and o['round'] == index]
                assert [o['variant'] for o in pair] == (['ordinary', 'diagnostic'] if index % 2 == 0 else ['diagnostic', 'ordinary'])
        for observation in observations:
            assert observation['status'] == 0 and observation['elapsedNs'] > 0
            assert observation['stdoutSha256'] == row['outputSha256'][label]
            if observation['variant'] == 'ordinary':
                assert observation['profile'] is None and not observation['stderr']
            else:
                assert json.loads(observation['stderr']) == observation['profile']
                p = observation['profile']['derivativePhases']
                assert (p['updates'], p['inputs']) == (updates, dimensions * updates)
                assert set(p['nanoseconds']) == PHASES
                assert all(type(n) is int and n >= 0 for n in p['nanoseconds'].values())
                if not updates:
                    assert not any(p['nanoseconds'].values())
        medians = {v: statistics.median(o['elapsedNs'] for o in observations
                   if o['phase'] == 'sample' and o['variant'] == v)
                   for v in ['ordinary', 'diagnostic']}
        assert phase['medianNs'] == medians
        assert phase['diagnosticOverOrdinary'] == medians['diagnostic'] / medians['ordinary']


def check_report(report, source):
    assert report['source'] == source
    config = report['configuration']
    assert (config['samples'], config['warmups'], config['order_seed'],
            config['phase_samples'], config['phase_warmups']) == (56, 2, 20261029, 12, 2)
    assert report['commands'] and all(c['status'] == 0 for c in report['commands'])
    assert set(report['results']) == CASES
    for name, row in report['results'].items():
        dimensions, updates = map(int, name.split('-'))
        assert (row['dimensions'], row['updates']) == (dimensions, updates)
        assert set(row['samplesNs']) == set(row['medianNs']) == set(row['outputSha256']) == LABELS
        assert len(row['orders']) == 56 and all(len(order) == 7 and set(order) == LABELS for order in row['orders'])
        for label, values in row['samplesNs'].items():
            assert len(values) == 56 and all(type(v) is int and v > 0 for v in values)
            assert row['medianNs'][label] == statistics.median(values)
        for label, ratios in row['ratios'].items():
            for peer, value in ratios.items():
                assert value == row['medianNs'][label] / row['medianNs'][peer]
        check_observations(name, row, updates)


def check_archive(path):
    archive = json.loads(path.read_text())
    assert set(archive['sessions']) == {'arm-1', 'arm-2', 'amd-1', 'amd-2'}
    identities = set()
    for label, session in archive['sessions'].items():
        job = session['job']
        identity = (job['runner_id'], job['started_at'], job['completed_at'])
        assert identity not in identities, 'copied job status is not an independent execution'
        identities.add(identity)
        assert job['run_id'] == archive['run'] and job['head_sha'] == archive['source']
        assert job['status'] == 'completed' and job['conclusion'] == 'success'
        for kind in ['report', 'log']:
            raw = gzip.decompress((path.parent / session[kind]).read_bytes())
            assert len(raw) == session[kind + 'Bytes']
            assert hashlib.sha256(raw).hexdigest() == session[kind + 'Sha256']
            if kind == 'report':
                report = json.loads(raw)
        check_report(report, archive['source'])
        assert report['machine'] == ('aarch64' if label.startswith('arm') else 'x86_64')
        assert report['configuration']['session'] == int(label[-1])
        assert len(session['files']) == 557
        for name, row in report['results'].items():
            for image, metadata in row['binaries'].items():
                file = session['files'][name + '/' + image]
                assert (file['bytes'], file['sha256']) == (metadata['bytes'], metadata['sha256'])
            derived = session['derived'][name]
            assert set(derived['instructionSections']) == set(row['binaries'])
            assert all(value.get('.text', 0) > 0 for value in derived['instructionSections'].values())
            assert derived['identicalMedianRatio'] == row['ratios']['fwp-ad']['fwp-ad-identical']
            ratios = [a / b for a, b in zip(row['samplesNs']['fwp-ad'], row['samplesNs']['fwp-ad-identical'])]
            paired = [max(ratio, 1 / ratio) for ratio in ratios]
            assert derived['identicalPairedP95'] == sorted(paired)[math.ceil(.95 * len(paired)) - 1]
    print('Four baseline sessions verified; different AMD hosts and noisy controls remain explicit')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    check_archive(parser.parse_args().archive)
