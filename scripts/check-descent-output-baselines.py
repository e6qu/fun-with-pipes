#!/usr/bin/env python3
"""Preserve complete output/checksum comparisons, including inconclusive controls."""
import argparse
import gzip
import hashlib
import json
from pathlib import Path
import statistics

LABELS = {'fwp-full', 'fwp-sink', 'fwp-full-identical', 'fwp-sink-identical',
          'c-full', 'c-sink', 'rust-full', 'rust-sink'}
CASES = {'3-0', '3-1', '3-199', '3-1999', '33-199', '129-199'}


def check_report(report, source):
    assert report['source'] == source and set(report['results']) == CASES
    config = report['configuration']
    assert (config['samples'], config['warmups'], config['order_seed'],
            config['control_max_difference']) == (48, 4, 20261023, .02)
    assert report['commands'] and all(c['returncode'] == 0 and c['failure'] is None for c in report['commands'])
    for name, row in report['results'].items():
        dimensions, updates = map(int, name.split('-'))
        repetitions = 32768 if updates <= 1 else 4096
        assert (row['dimensions'], row['updates'], row['repetitions']) == (dimensions, updates, repetitions)
        assert set(row['samplesNs']) == set(row['medianNs']) == LABELS
        assert len(row['orders']) == 48
        assert all(len(order) == 8 and set(order) == LABELS for order in row['orders'])
        for label, samples in row['samplesNs'].items():
            assert len(samples) == 48 and all(type(n) is int and n > 0 for n in samples)
            assert row['medianNs'][label] == statistics.median(samples)
        for mode in ['full', 'sink']:
            image, identical = 'fwp-' + mode, 'fwp-' + mode + '-identical'
            assert row['binaries'][image]['sha256'] == row['binaries'][identical]['sha256']
            ratio = row['medianNs'][image] / row['medianNs'][identical]
            assert row['identicalCopyRatios'][mode] == ratio
            assert row['controlsWithinBound'][mode] == (abs(ratio - 1) <= .02)
            for peer in ['c', 'rust']:
                assert row['fwpToPeerRatios'][mode][peer] == row['medianNs'][image] / row['medianNs'][peer + '-' + mode]
        for language in ['fwp', 'c', 'rust']:
            assert row['sinkToFullRatios'][language] == row['medianNs'][language + '-sink'] / row['medianNs'][language + '-full']
        assert len(row['binaries']) == (24 if name == '33-199' else 17)
        assert all(b['bytes'] > 0 and b['textSectionBytes'] > 0 for b in row['binaries'].values())
        assert row['cCompilerStackUsage']
        assert set(row['profiles']) == {'fwp-full', 'fwp-sink'}
        for profile in row['profiles'].values():
            assert profile['completedSolves'] == repetitions
            assert profile['managed']['retains'] == profile['managed']['finalChargedBytes'] == 0
            assert profile['raw']['rawDerivativeStorage']['finalBytes'] == 0
            assert profile['first'] == dict(solve=1, managedLiveBytes=0, rawLiveBytes=0)
            assert profile['last'] == dict(solve=repetitions, managedLiveBytes=0, rawLiveBytes=0)
        assert set(row['peerBufferProfiles']) == {'c-full', 'c-sink', 'rust-full', 'rust-sink'}
        for profile in row['peerBufferProfiles'].values():
            assert profile['completedSolves'] == repetitions
            for which, count in [('first', 1), ('last', repetitions)]:
                assert profile[which] == dict(solve=count, inputRequests=2 * count,
                    inputRequestedBytes=16 * dimensions * count, inputLiveBytes=0, inputPeakBytes=16 * dimensions)
        expected_controls = {language + '-sink' for language in ['fwp', 'c', 'rust']}
        expected_controls |= {language + '-' + mode + '-missing-release'
                              for language in ['c', 'rust'] for mode in ['full', 'sink']}
        assert set(row['controls']) == (expected_controls if name == '33-199' else set())
        for label, control in row['controls'].items():
            if label.endswith('missing-release'):
                assert control['status'] == 226
                assert control['observations'] == [dict(solve=1, inputRequests=2,
                    inputRequestedBytes=16 * dimensions, inputLiveBytes=8 * dimensions, inputPeakBytes=16 * dimensions)]
            else:
                assert control['expected'] != control['omittedLast']


def check_archive(path):
    archive = json.loads(path.read_text())
    assert set(archive['sessions']) == {'arm-1', 'arm-2', 'amd-1', 'amd-2'}
    identities = set()
    for label, session in archive['sessions'].items():
        job = session['job']
        identity = (job['runner_id'], job['started_at'], job['completed_at'])
        assert identity not in identities
        identities.add(identity)
        assert job['head_sha'] == archive['source'] and job['conclusion'] == 'success'
        for kind in ['report', 'log']:
            raw = gzip.decompress((path.parent / session[kind]).read_bytes())
            assert len(raw) == session[kind + 'Bytes']
            assert hashlib.sha256(raw).hexdigest() == session[kind + 'Sha256']
            if kind == 'report':
                report = json.loads(raw)
        check_report(report, archive['source'])
        assert report['machine'] == ('aarch64' if label.startswith('arm') else 'x86_64')
        assert len(session['files']) == 1446 and len(session['outputControls']['records']) == 60
        coordinate = session['coordinateControls']
        assert coordinate['outputRejectionControls'] == 7
        expected = {(n, u, language, arrangement, mode)
                    for n, u in [(2, 0), (2, 1), (3, 7)]
                    for language in ['c', 'rust'] for arrangement in ['coordinate', 'edge']
                    for mode in (['checked', 'missing-release'] if u == 7 else ['checked'])}
        assert len(coordinate['cases']) == len(expected) == 16
        assert {(c['dimensions'], c['updates'], c['language'], c['arrangement'], c['mode'])
                for c in coordinate['cases']} == expected
        for control in coordinate['cases']:
            n = control['dimensions']
            missing = control['mode'] == 'missing-release'
            assert control['status'] == (226 if missing else 0)
            assert control['observations'] == [dict(solve=i, inputRequests=2 * i,
                inputRequestedBytes=16 * n * i, inputLiveBytes=8 * n if missing else 0,
                inputPeakBytes=16 * n) for i in ([1] if missing else [1, 2])]
        for name, row in report['results'].items():
            for image, metadata in row['binaries'].items():
                file = session['files']['descent-output-evidence/' + name + '/' + image]
                assert (file['bytes'], file['sha256']) == (metadata['bytes'], metadata['sha256'])
        inconclusive = [name for name, row in report['results'].items() if not all(row['controlsWithinBound'].values())]
        print(label, 'inconclusive:', ', '.join(inconclusive) or 'none')
    print('Four complete output diagnostics verified; no optimization acceptance claimed')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    check_archive(parser.parse_args().archive)
