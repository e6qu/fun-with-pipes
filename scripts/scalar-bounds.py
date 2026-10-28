#!/usr/bin/env python3
"""Verify the retained scalar-bound experiment against its unchanged CPU limits."""
import argparse
import hashlib
import json
import math
from pathlib import Path
import re
import statistics
import subprocess

ROOT = Path(__file__).resolve().parent.parent
FILES = ('src/fuse.rs', 'src/cgen/scalar_text.rs')
VARIANTS = ('baseline', 'index', 'length', 'both')
KINDS = ('c', 'rs', *VARIANTS, 'identical')
PROGRAMS = ('loop', 'text-length')
BASELINE = 'ec03d9cd81c001bf006a73e7dbfb044155884611'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def qualify(table, host, compilers, inputs):
    assert table['source'] == BASELINE, 'wrong baseline revision'
    rows = [r for r in table['rows'] if r['host'] == host]
    assert len(rows) == 2 and {r['program'] for r in rows} == set(PROGRAMS), 'host needs its own repeated baseline before candidate timing'
    for row in rows:
        versions = re.findall(r'```text\n(.*?)\n```', row['toolchains'], re.S)
        assert versions == compilers, 'toolchains differ from frozen baseline'
        assert row['inputs'] == inputs[row['program']], 'benchmark inputs changed'
    return {r['program']: r for r in rows}


def check_case(name, row, settings, budget):
    """Recompute a decision; incomplete or reordered observations are invalid."""
    assert settings == dict(samples=56, warmups=2, processes={'loop': 1, 'text-length': 32}, timeout=120, cpuPolicy='all')
    assert set(row['binaries']) == set(KINDS)
    assert row['binaries']['baseline'] == row['binaries']['identical']
    assert row['stdout'] == {'loop': '300000003\n', 'text-length': '28518516\n'}[name]
    for binary in row['binaries'].values():
        assert re.fullmatch('[0-9a-f]{64}', binary['sha256']) and binary['bytes'] > 0
    observations = row['observations']
    assert len(observations) == 7 * (settings['samples'] + settings['warmups'])
    times = {kind: [] for kind in KINDS}
    for index, observation in enumerate(observations):
        round_index, position = divmod(index, 7)
        warmup = round_index < settings['warmups']
        phase_round = round_index if warmup else round_index - settings['warmups']
        kind = KINDS[(phase_round + position) % 7]
        assert (observation['kind'], observation['phase'], observation['round']) == (
            kind, 'warmup' if warmup else 'sample', phase_round)
        assert observation['binarySha256'] == row['binaries'][kind]['sha256']
        processes = observation['processes']
        assert len(processes) == settings['processes'][name]
        for process in processes:
            assert process['status'] == 0 and not process['stderr'] and process['stdout'] == row['stdout']
            assert math.isfinite(process['seconds']) and process['seconds'] > 0
        assert observation['seconds'] == sum(p['seconds'] for p in processes)
        if not warmup:
            times[kind].append(observation['seconds'])
    medians = {kind: statistics.median(values) for kind, values in times.items()}
    control = max(medians['baseline'], medians['identical']) / min(medians['baseline'], medians['identical'])
    pairs = sorted(max(a, b) / min(a, b) for a, b in zip(times['baseline'], times['identical'], strict=True))
    spread = pairs[math.ceil(0.95 * settings['samples']) - 1]
    stable = control <= 1.03 and spread <= budget['maxControlPairRatio']
    ratios = {kind: medians[kind] / medians['baseline'] for kind in VARIANTS[1:]}
    return dict(medianBatchSeconds=medians, controlRatio=control, pairRatio95=spread,
                control='stable' if stable else 'inconclusive', candidateOverBaseline=ratios,
                candidateOverC={k: medians[k] / medians['c'] for k in VARIANTS},
                candidateOverRust={k: medians[k] / medians['rs'] for k in VARIANTS},
                withinRegression={k: stable and r <= budget['maxCandidateRatio'] for k, r in ratios.items()},
                improvement={k: stable and r < budget['maxRatioForImprovement'] for k, r in ratios.items()})


def check_report(report, table):
    assert report['baseline'] == BASELINE and re.fullmatch('[0-9a-f]{40}', report['candidate'])
    budgets = qualify(table, report['host'], report['compilers'], report['inputs'])
    assert set(report['programs']) == set(PROGRAMS)
    for name, row in report['programs'].items():
        assert row['result'] == check_case(name, row, report['settings'], budgets[name]), 'stored decision differs'
    return [kind for kind in VARIANTS[1:]
            if all(report['programs'][name]['result']['withinRegression'][kind] for name in PROGRAMS)
            and report['programs']['text-length']['result']['improvement'][kind]]


def verify(reports, rejected, table, table_digest, artifacts):
    assert len(reports) == 2 and {r['architecture'] for r in reports} == {'aarch64', 'x86_64'}
    assert set(artifacts) == {'aarch64', 'x86_64'}
    candidate = '08039d8698743116c31cc0b8929e705c3562f833'
    results = []
    for report in reports:
        assert report['candidate'] == candidate and report['tableSha256'] == table_digest
        assert set(report['variants']) == set(VARIANTS)
        archive = artifacts[report['architecture']]
        assert archive['run'] == report['run'] and set(archive['variants']) == set(VARIANTS)
        assert report['qualifyingVariants'] == check_report(report, table)
        results.append(set(report['qualifyingVariants']))
        for kind, variant in report['variants'].items():
            changed = [name for index, name in enumerate(FILES)
                       if kind == 'both' or kind == ('index', 'length')[index]]
            assert set(variant['sources']) == set(FILES)
            for name in FILES:
                revision = candidate if name in changed else BASELINE
                actual = subprocess.check_output(['git', 'show', revision + ':' + name], cwd=ROOT)
                assert hashlib.sha256(actual).hexdigest() == variant['sources'][name], 'wrong compiler source'
            for key in ['patchSha256', 'compilerSha256', 'inspectionSha256', 'memorySha256', 'memoryInspectionSha256']:
                assert re.fullmatch('[0-9a-f]{64}', variant[key]), 'missing artifact identity'
            assert len(variant['costs']) == 7
            assert all(r['textBytes'] > 0 and r['binaryBytes'] > r['textBytes'] for r in variant['costs'].values())
            assert len(variant['instrumentedStack']) == 7 and all(variant['instrumentedStack'].values())
            saved = archive['variants'][kind]
            for key in ('inspection', 'memory', 'memoryInspection'):
                assert hashlib.sha256(saved[key].encode()).hexdigest() == variant[key + 'Sha256'], 'archived artifact differs'
            inspection = json.loads(saved['inspection'])
            memory = json.loads(saved['memory'])
            images = json.loads(saved['memoryInspection'])
            assert all(r['source'] == candidate and r['architecture'] == report['architecture'] for r in (inspection, memory, images))
            assert inspection['ownership'] == memory['ownership'] == 'counted'
            assert hashlib.sha256(saved['benchmark'].encode()).hexdigest() == inspection['reportSha256']
            assert memory['inspectionSha256'] == variant['inspectionSha256']
            assert images['reportSha256'] == variant['memorySha256']
            assert len(inspection['programs']) == len(memory['programs']) == 7 and len(images['images']) == 14
            assert set(saved['codeSections']) == set(PROGRAMS)
            for name in PROGRAMS:
                image, = [p for p in inspection['programs'] if p['name'] == name]
                mem, = [p for p in memory['programs'] if p['name'] == name]
                timed = report['programs'][name]['binaries'][kind]
                assert timed == dict(sha256=image['files']['fwp']['binarySha256'], bytes=image['files']['fwp']['fileBytes'])
                assert mem['processMemory']['fwp']['binarySha256'] == timed['sha256']
                assert len(mem['processMemory']['fwp']['peakRssKiB']) == 3
                normal = mem['managedMemory']['ordinary']['profiles']
                leak = mem['managedMemory']['injected-leak']['profiles']
                assert len(normal) == len(leak) == 3 and mem['leakDetected']
                assert all(all(value == 0 for value in profile.values()) for profile in normal)
                assert all(profile['requests'] == 1 and profile['requestedBytes'] == 16
                           and profile['retains'] == 0 and profile['finalChargedBytes'] > 0 for profile in leak)
                assert re.fullmatch('[0-9a-f]{64}', saved['codeSections'][name])
    assert not set.intersection(*results), 'retained observations no longer support rejection'
    assert rejected['candidate'] == candidate and rejected['baseline'] == BASELINE
    assert rejected['tableSha256'] == table_digest
    assert not rejected['programs'] and not rejected['variants'], 'unqualified host executed a candidate'
    assert all(row['host'] != rejected['host'] for row in table['rows'])
    print('Both complete sessions and the rejected host record preserve the fixed limits; no candidate qualifies')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--reports', type=Path, nargs=2, required=True)
    parser.add_argument('--unqualified', type=Path, required=True)
    parser.add_argument('--table', type=Path, required=True)
    parser.add_argument('--artifacts', type=Path, required=True)
    args = parser.parse_args()
    verify([json.loads(p.read_text()) for p in args.reports], json.loads(args.unqualified.read_text()),
           json.loads(args.table.read_text()), digest(args.table), json.loads(args.artifacts.read_text()))


if __name__ == '__main__':
    main()
