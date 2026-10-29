#!/usr/bin/env python3
"""Verify matched derivative baselines without accepting noisy comparisons."""
import argparse
import gzip
import hashlib
import importlib.util
import json
import math
from pathlib import Path
import statistics

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('baseline_checks', ROOT / 'scripts/check-descent-baselines.py')
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SPEC = importlib.util.spec_from_file_location('descent_schedule', ROOT / 'scripts/descent-baselines.py')
SCHEDULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SCHEDULE)
LABELS = ['fwp-ad-history', 'fwp-ad', 'fwp-explicit', 'fwp-packed',
          'c-explicit', 'rust-explicit', 'fwp-ad-identical']
GROUPS = {'3-0': 42, '3-1': 42, '3-199': 21, '3-1999': 7, '33-199': 7, '129-199': 7}
SOLVES = {'3-0': 32768, '3-1': 512, '3-199': 32, '3-1999': 4, '33-199': 32, '129-199': 8}


def check_report(report, source, protocol):
    assert protocol in {'grouped', 'repeated'}
    assert report['source'] == source
    config = report['configuration']
    assert (config['samples'], config['warmups'], config['order_seed'],
            config['phase_samples'], config['phase_warmups']) == (98, 2, 20261029, 12, 2)
    host = report['qualification']
    assert host['source'] == source and host['qualified'] and not host['failures']
    assert host['actual'] == host['expected']
    expected_host = dict(system='Linux', machine=report['machine'], processors=4,
                        rustVersion='rustc 1.99.1 (58cf8f9c3 2026-10-13)')
    if report['machine'] == 'aarch64':
        expected_host.update(cpu='Neoverse-N2', cVersion='gcc (Ubuntu 13.3.0-6ubuntu2~24.04.1) 13.3.0')
    else:
        assert report['machine'] == 'x86_64'
        expected_host.update(cpu='AMD EPYC 7763 64-Core Processor', cVersion='gcc (Ubuntu 15.2.0-16ubuntu1) 15.2.0')
    assert host['actual'] == expected_host
    assert report['commands'] and all(c['status'] == 0 and not c['stderr'] for c in report['commands'])
    assert set(report['results']) == set(GROUPS)
    for name, row in report['results'].items():
        dimensions, updates = map(int, name.split('-'))
        assert (row['dimensions'], row['updates']) == (dimensions, updates)
        processes = GROUPS[name] if protocol == 'grouped' else 7
        solves = 1 if protocol == 'grouped' else SOLVES[name]
        assert row['processesPerLabel'] == processes
        if protocol == 'repeated':
            assert row['solvesPerProcess'] == solves
        else:
            assert 'solvesPerProcess' not in row
        case = f'{dimensions}:{updates}:{processes}' + (f':{solves}' if protocol == 'repeated' else '')
        assert case in config['case'] and len(config['case']) == 6
        assert row['orders'] == [SCHEDULE.execution_order(LABELS, processes, index, 20261029) for index in range(98)]
        assert set(row['samplesNs']) == set(row['medianNs']) == set(row['outputSha256']) == set(LABELS)
        for label, values in row['samplesNs'].items():
            assert len(values) == 98 and all(type(value) is int and value > 0 for value in values)
            assert row['medianNs'][label] == statistics.median(values)
        for label, ratios in row['ratios'].items():
            for peer, value in ratios.items():
                assert value == row['medianNs'][label] / row['medianNs'][peer]
        CHECK.check_observations(name, row, updates * solves)


def check_archive(path, protocol):
    archive = json.loads(path.read_text())
    assert set(archive['sessions']) == {'arm-1', 'arm-2', 'amd-1', 'amd-2'}
    identities = set()
    for label, session in archive['sessions'].items():
        job = session['job']
        identity = (job['runner_id'], job['started_at'], job['completed_at'])
        assert identity not in identities
        identities.add(identity)
        assert job['run_id'] == archive['run'] and job['head_sha'] == archive['source']
        assert job['status'] == 'completed' and job['conclusion'] == 'success'
        for kind in ['report', 'log']:
            raw = gzip.decompress((path.parent / session[kind]).read_bytes())
            assert len(raw) == session[kind + 'Bytes']
            assert hashlib.sha256(raw).hexdigest() == session[kind + 'Sha256']
            if kind == 'report':
                report = json.loads(raw)
        check_report(report, archive['source'], protocol)
        assert report['machine'] == ('aarch64' if label.startswith('arm') else 'x86_64')
        assert report['configuration']['session'] == int(label[-1])
        assert len(session['files']) == 1157
        for name, row in report['results'].items():
            for image, metadata in row['binaries'].items():
                file = session['files'][name + '/' + image]
                assert (file['bytes'], file['sha256']) == (metadata['bytes'], metadata['sha256'])
            for phase, count in [('warmup', 2), ('sample', 98)]:
                assert all(f'{name}/{phase}-{index:03d}.json' in session['files'] for index in range(count))
            derived = session['derived'][name]
            assert set(derived['instructionSections']) == set(row['binaries'])
            assert all(value.get('.text', 0) > 0 for value in derived['instructionSections'].values())
            assert derived['identicalMedianRatio'] == row['ratios']['fwp-ad']['fwp-ad-identical']
            ratios = [a / b for a, b in zip(row['samplesNs']['fwp-ad'], row['samplesNs']['fwp-ad-identical'])]
            paired = [max(ratio, 1 / ratio) for ratio in ratios]
            assert derived['identicalPairedP95'] == sorted(paired)[math.ceil(.95 * len(paired)) - 1]
    print(f'Four {protocol} sessions verified; all identical-code variation remains visible')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--archive', type=Path, required=True)
    parser.add_argument('--protocol', choices=['grouped', 'repeated'], required=True)
    args = parser.parse_args()
    check_archive(args.archive, args.protocol)
