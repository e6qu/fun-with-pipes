#!/usr/bin/env python3
"""Recheck the rejected or inconclusive short decimal experiments without rerunning its timings."""
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

SPEC = importlib.util.spec_from_file_location('decimal_count', Path(__file__).with_name('decimal-count.py'))
COUNT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COUNT)
EXPERIMENTS = (
    ('decimal-count', 'df80c15ee894c437df0f0216db211abefc27115c', 'bit-length', {'aarch64': True, 'x86_64': False}),
    ('decimal-tree', '9c89a3761cba2c3bccb02dff93b3fec6754f4583', 'threshold-tree', {'aarch64': False, 'x86_64': False}),
)
DIRECTORY = COUNT.ROOT / 'docs/measurements'


def sha(text):
    return hashlib.sha256(text.encode()).hexdigest()


def verify():
    table_path = DIRECTORY / 'cpu-budgets-2026-10-28.json'
    table = json.loads(table_path.read_text())
    for prefix, source, algorithm, expected_decisions in EXPERIMENTS:
        archives = json.loads((DIRECTORY / f'{prefix}-artifacts-2026-10-29.json').read_text())
        assert set(archives) == {'aarch64', 'x86_64'}
        old = subprocess.check_output(['git', 'show', COUNT.BASELINE + ':runtime/fwp_rt_ops.c'], cwd=COUNT.ROOT, text=True)
        new = subprocess.check_output(['git', 'show', source + ':runtime/fwp_rt_ops.c'], cwd=COUNT.ROOT, text=True)
        decisions = {}
        for label in ('arm', 'amd'):
            path = DIRECTORY / f'{prefix}-2026-10-29-{label}.json'
            report = json.loads(path.read_text())
            assert report['source'] == source and report['baseline'] == COUNT.BASELINE
            assert report['settings'] == COUNT.SHORT_SETTINGS and report['tableSha256'] == COUNT.digest(table_path)
            assert report['oldHelper'] == COUNT.helper(old) and report['newHelper'] == COUNT.helper(new)
            assert new.replace(report['newHelper'], report['oldHelper']) == old
            budgets = COUNT.CPU.BOUNDS.qualify(table, report['host'], report['compilers'], report['inputs'])
            archive = archives[report['architecture']]
            assert archive['source'] == source and archive['run'] == report['run']
            files = archive['artifactFiles']
            assert files['decimal-count/report.json'] == dict(sha256=COUNT.digest(path), bytes=path.stat().st_size)
            for key in ('inspection', 'memory', 'memoryInspection'):
                assert sha(archive[key]) == report['evidence'][key]
            inspection, memory, images = [json.loads(archive[k]) for k in ('inspection', 'memory', 'memoryInspection')]
            assert all(r['source'] == source and r['architecture'] == report['architecture'] for r in (inspection, memory, images))
            assert sha(archive['benchmark']) == inspection['reportSha256']
            assert memory['inspectionSha256'] == report['evidence']['inspection']
            assert images['reportSha256'] == report['evidence']['memory']
            assert len(inspection['programs']) == len(memory['programs']) == 7 and len(images['images']) == 14
            assert set(report['context']) == {p['name'] for p in inspection['programs']}
            assert set(report['programs']) == set(COUNT.CPU.PROGRAMS)
            for name, context in report['context'].items():
                original, = [p for p in inspection['programs'] if p['name'] == name]
                mem, = [p for p in memory['programs'] if p['name'] == name]
                assert context['stdout'] == original['stdout'] and context['ordinaryMemory'] == mem and mem['leakDetected']
                if name in COUNT.CPU.PROGRAMS:
                    assert all(all(v == 0 for v in p.values()) for p in mem['managedMemory']['ordinary']['profiles'])
                for variant, cost in context['costs'].items():
                    stem = f'decimal-count/{name}-{variant}'
                    assert files[stem + '.exe'] == dict(sha256=cost['binarySha256'], bytes=cost['binaryBytes'])
                    assert files[stem + '.c']['sha256'] == cost['generatedSha256']
                    stack, = [f for f in files if f.startswith(stem) and f.endswith('.su')]
                    assert files[stack]['sha256'] == sha(cost['stack'])
                    assert bool(cost['table']) == (algorithm == 'bit-length' and variant == 'candidate' and name in COUNT.COUNTING_PROGRAMS)
                    if cost['table']:
                        item = cost['table']
                        assert item['bytes'] == 160 and item['address'] % 8 == 0
                        assert item['addressModulo64'] == item['address'] % 64
                if name not in COUNT.COUNTING_PROGRAMS:
                    assert context['costs']['baseline']['textSha256'] == context['costs']['candidate']['textSha256']
            for variant in ('baseline', 'candidate'):
                assert report['context']['strings']['costs'][variant]['textSha256'] == report['context']['text-length']['costs'][variant]['textSha256']
            for name, row in report['programs'].items():
                assert row['result'] == COUNT.check_case(name, row, budgets[name], algorithm, report['settings'])
                original, = [p for p in inspection['programs'] if p['name'] == name]
                for kind in COUNT.KINDS:
                    if kind in ('c', 'rs'):
                        binary = original['files'][kind]
                        expected = dict(sha256=binary['binarySha256'], bytes=binary['fileBytes'])
                    else:
                        variant = 'baseline' if kind == 'identical' else kind
                        expected = files[f'decimal-count/{name}-{variant}.exe']
                    assert row['binaries'][kind] == expected
            decision = all(r['result']['withinRegression'] for r in report['programs'].values()) and report['programs']['text-length']['result']['improvement']
            assert report['qualifies'] == decision
            decisions[report['architecture']] = decision
        assert decisions == expected_decisions, 'retain the original decisions'
        for suffix in ('', '-2'):
            rejected = json.loads((DIRECTORY / f'{prefix}-2026-10-29-unqualified{suffix}.json').read_text())
            assert rejected['source'] == source and rejected['tableSha256'] == COUNT.digest(table_path)
            assert all(row['host'] != rejected['host'] for row in table['rows'])
        print(prefix, decisions, 'all paired samples and unchanged limits retained')


if __name__ == '__main__':
    verify()
