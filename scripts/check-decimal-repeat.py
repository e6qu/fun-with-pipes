#!/usr/bin/env python3
"""Verify longer decimal sessions and select the first two qualified jobs per host."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess

SPEC = importlib.util.spec_from_file_location('decimal_count', Path(__file__).with_name('decimal-count.py'))
COUNT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COUNT)


def select_sessions(entries):
    identities = [(e['run'], e['job']) for e in entries]
    assert len(identities) == len(set(identities)), 'duplicate job'
    assert all(isinstance(run, int) and run > 0 and isinstance(job, int) and job > 0 for run, job in identities)
    assert {e['architecture'] for e in entries} == {'aarch64', 'x86_64'}, 'wrong architectures'
    executions = []
    for entry in entries:
        job = entry['jobMetadata']
        assert job['id'] == entry['job'] and job['run_id'] == entry['run']
        executions.append((job['runner_id'], job['started_at'], job['completed_at']))
    assert len(set(executions)) == len(executions), 'copied retry status is not an independent execution'
    selected = []
    for architecture in ('aarch64', 'x86_64'):
        matches = sorted((e for e in entries if e['architecture'] == architecture), key=lambda e: (e['run'], e['job']))
        assert len(matches) >= 2, 'two qualified jobs per architecture required'
        selected.extend(matches[:2])
    return selected


def verify(args):
    assert re.fullmatch('[0-9a-f]{40}', args.source)
    assert not subprocess.check_output(['git', 'diff', '9c89a3761cba2c3bccb02dff93b3fec6754f4583', args.source, '--', 'src', 'runtime', 'tests', 'lib', 'bench', 'vendor', 'Cargo.toml', 'Cargo.lock', 'build.rs'], cwd=COUNT.ROOT), 'native correctness source changed'
    settings = {'long': COUNT.LONG_SETTINGS, 'interleaved': COUNT.INTERLEAVED_SETTINGS, 'balanced': COUNT.BALANCED_SETTINGS}[args.protocol]
    archive = json.loads(args.archive.read_text())
    table = json.loads(args.table.read_text())
    old = subprocess.check_output(['git', 'show', COUNT.BASELINE + ':runtime/fwp_rt_ops.c'], cwd=COUNT.ROOT, text=True)
    new = subprocess.check_output(['git', 'show', args.source + ':runtime/fwp_rt_ops.c'], cwd=COUNT.ROOT, text=True)
    reports = {COUNT.digest(path): json.loads(path.read_text()) for path in args.reports}
    assert len(reports) == len(args.reports) == len(archive['sessions'])
    assert set(reports) == {e['reportSha256'] for e in archive['sessions']}
    entries = archive['sessions']
    selected = select_sessions(entries)  # Select before reading any timing decision.
    for entry in entries:
        job = entry['jobMetadata']
        assert job['head_sha'] == args.source and job['status'] == 'completed' and job['conclusion'] == 'success'
    for entry in entries:
        report = reports[entry['reportSha256']]
        assert report['source'] == args.source and report['baseline'] == COUNT.BASELINE
        assert report['architecture'] == entry['architecture'] and report['run'] == entry['run']
        assert report['session'] == entry['session'] and report['session'] in (1, 2)
        assert report['protocol'] == args.protocol and report['settings'] == settings
        assert report['algorithm'] == 'threshold-tree' and report['tableSha256'] == COUNT.digest(args.table)
        assert report['oldHelper'] == COUNT.helper(old) and report['newHelper'] == COUNT.helper(new)
        assert new.replace(report['newHelper'], report['oldHelper']) == old
        budgets = COUNT.CPU.BOUNDS.qualify(table, report['host'], report['compilers'], report['inputs'])
        files = entry['artifactFiles']
        assert files['decimal-count/report.json']['sha256'] == entry['reportSha256']
        for key in ('inspection', 'memory', 'memoryInspection'):
            assert hashlib.sha256(entry[key].encode()).hexdigest() == report['evidence'][key]
        inspection, memory, images = [json.loads(entry[key]) for key in ('inspection', 'memory', 'memoryInspection')]
        assert all(r['source'] == args.source and r['architecture'] == report['architecture'] for r in (inspection, memory, images))
        assert memory['inspectionSha256'] == report['evidence']['inspection'] and images['reportSha256'] == report['evidence']['memory']
        assert hashlib.sha256(entry['benchmark'].encode()).hexdigest() == inspection['reportSha256']
        assert len(inspection['programs']) == len(memory['programs']) == 7 and len(images['images']) == 14
        assert set(report['context']) == {p['name'] for p in inspection['programs']}
        for name, context in report['context'].items():
            original, = [p for p in inspection['programs'] if p['name'] == name]
            mem, = [p for p in memory['programs'] if p['name'] == name]
            assert context['stdout'] == original['stdout'] and context['ordinaryMemory'] == mem and mem['leakDetected']
            for variant, cost in context['costs'].items():
                stem = f'decimal-count/{name}-{variant}'
                assert files[stem + '.exe'] == dict(sha256=cost['binarySha256'], bytes=cost['binaryBytes'])
                assert files[stem + '.c']['sha256'] == cost['generatedSha256'] and cost['table'] is None
                stack, = [f for f in files if f.startswith(stem) and f.endswith('.su')]
                assert files[stack]['sha256'] == hashlib.sha256(cost['stack'].encode()).hexdigest()
                assert cost['rodataBytes'] > 0 and re.fullmatch('[0-9a-f]{64}', cost['rodataSha256'])
            for key in ('rodataBytes', 'rodataSha256'):
                assert context['costs']['baseline'][key] == context['costs']['candidate'][key], 'new readonly data requires review'
            if name not in COUNT.COUNTING_PROGRAMS:
                assert context['costs']['baseline']['textSha256'] == context['costs']['candidate']['textSha256']
        for variant in ('baseline', 'candidate'):
            assert report['context']['strings']['costs'][variant]['textSha256'] == report['context']['text-length']['costs'][variant]['textSha256']
        assert set(report['programs']) == set(COUNT.CPU.PROGRAMS)
        for name, row in report['programs'].items():
            assert row['result'] == COUNT.check_case(name, row, budgets[name], report['algorithm'], report['settings'])
            original, = [p for p in inspection['programs'] if p['name'] == name]
            for kind in COUNT.KINDS:
                if kind in ('c', 'rs'):
                    binary = original['files'][kind]
                    expected = dict(sha256=binary['binarySha256'], bytes=binary['fileBytes'])
                else:
                    variant = 'baseline' if kind == 'identical' else kind
                    expected = files[f'decimal-count/{name}-{variant}.exe']
                assert row['binaries'][kind] == expected
            assert all(all(v == 0 for v in p.values()) for p in report['context'][name]['ordinaryMemory']['managedMemory']['ordinary']['profiles'])
        accepted = all(r['result']['withinRegression'] for r in report['programs'].values()) and report['programs']['text-length']['result']['improvement']
        assert report['qualifies'] == accepted
        print(entry['run'], entry['job'], report['architecture'], 'qualifies:', accepted, 'selected:', entry in selected)
    for rejected in archive['unqualified']:
        record = rejected['qualification']
        assert record['source'] == args.source and record['tableSha256'] == COUNT.digest(args.table)
        assert all(row['host'] != record['host'] for row in table['rows'])
    accepted = all(reports[e['reportSha256']]['qualifies'] for e in selected)
    assert archive['accepted'] == accepted
    print('All selected sessions pass:', accepted)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--protocol', choices=['long', 'interleaved', 'balanced'], required=True)
    parser.add_argument('--archive', type=Path, required=True)
    parser.add_argument('--reports', type=Path, nargs='+', required=True)
    parser.add_argument('--table', type=Path, required=True)
    parser.add_argument('--source', required=True)
    verify(parser.parse_args())


if __name__ == '__main__':
    main()
