#!/usr/bin/env python3
"""Reconstruct the retained small native count reports without downloading binaries."""
import argparse
import hashlib
import json
from pathlib import Path
from nested_resource_counts import compare, decode
from weak_callback_timing import decode_output
from weak_callback_service import CASES

parser = argparse.ArgumentParser(description=__doc__)
for name in ('arm', 'amd', 'output'):
    parser.add_argument('--' + name, type=Path, required=True)
parser.add_argument('--source', required=True)
args = parser.parse_args()
reports = []
for host in ('arm', 'amd'):
    root = getattr(args, host).resolve()
    folder = root / 'nested-owner-counts'
    manifest = json.loads((folder / 'manifest.json').read_text())
    for filename in ('report.json', 'commands.jsonl'):
        assert hashlib.sha256((folder / filename).read_bytes()).hexdigest() == manifest[filename]
    r = json.loads((folder / 'report.json').read_text())
    assert r['source'] == args.source
    assert r['source'] == (root / 'nested-owner-identity/source.txt').read_text().strip()
    assert r['referenceSource'] == (root / 'nested-owner-reference/source.txt').read_text().strip() == '65719f7fc2277a5b97c5a790df941fea6c5eb4d7'
    assert r['architecture'] == {'arm':'aarch64', 'amd':'x86_64'}[host]
    assert not r['failures']
    hashes = dict(line.split()[::-1] for line in (root / 'nested-owner-reference/compilers.sha256').read_text().splitlines())
    assert r['compilers'] == dict(reference=hashes['nested-owner-reference/fwp'], candidate=hashes['target/debug/fwp'])
    commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    for index, row in enumerate(commands):
        assert index == row['index']
    for role in ('reference', 'candidate'):
        for level in (1, 2):
            cases = r['cases'][f'{role}-O{level}']
            assert len(cases) == 8
            for population, mode in CASES:
                item = cases[f'{population}-{mode}']
                raw = commands[item['command']]
                assert raw['status'] == 0
                assert raw['command'][-3:] == [str(population), str(mode), '1']
                decode_output(raw['stdout'], population, mode, 1)
                assert decode(raw['stderr']) == item['counts']
                assert cases[f'{population}-{mode}']['counts'] == r['cases'][f'{role}-O1'][f'{population}-{mode}']['counts']
    for level in (1, 2):
        for population, mode in CASES:
            key = f'{population}-{mode}'
            ref = r['cases'][f'reference-O{level}'][key]['counts']
            cand = r['cases'][f'candidate-O{level}'][key]['counts']
            assert compare(ref, cand) == r['comparisons'][f'O{level}/{key}']
            assert r['comparisons'][f'O{level}/{key}']['cleanupTargetMet']
    for control in r['controls']:
        raw = commands[control['command']]
        if control['variant'] == 'missing-release':
            assert (raw['status'], raw['stdout'], raw['stderr']) == (79, '', 'service storage not released\n')
        else:
            assert raw['status'] == 0
            decode_output(raw['stdout'], 64, 0, 1)
            expected = dict(r['cases'][f"{control['role']}-O{control['level']}"]['64-0']['counts'])
            expected['pushes'] += 1
            expected['pops'] += 1
            assert decode(raw['stderr']) == expected
    controls = list((root / 'nested-owner-audit-controls').glob('*.json'))
    assert len(controls) == 6
    for file in controls:
        control = json.loads(file.read_text())
        assert control['status'] == 1 and 'AssertionError' in control['stderr']
    print(host, 'raw cases, count differences, memory and rejection controls agree')
    print('selections', {key: value['anchors'] for key, value in r['selection'].items()})
    reports.append(r)
assert reports[0]['comparisons'] == reports[1]['comparisons']
summary = dict(source=args.source, referenceSource=reports[0]['referenceSource'], cases={},
               selection={key: value['anchors'] for key, value in reports[0]['selection'].items()},
               hosts={r['architecture']: dict(compilers=r['compilers'], host=r['host'], ccVersion=r['ccVersion']) for r in reports})
for population, mode in CASES:
    key = f'{population}-{mode}'
    ref = reports[0]['cases']['reference-O2'][key]['counts']
    cand = reports[0]['cases']['candidate-O2'][key]['counts']
    assert ref == reports[1]['cases']['reference-O2'][key]['counts']
    assert cand == reports[1]['cases']['candidate-O2'][key]['counts']
    summary['cases'][key] = dict(reference=ref, candidate=cand, comparison=compare(ref, cand))
args.output.write_text(json.dumps(summary, indent=2) + '\n')
print('Both hosts have identical observed calls and storage; no ordinary timing claim')
