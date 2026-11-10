"""Reconstruct both hosts' retained raw count outputs; native images stay on runners."""
import gzip
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent
results = {}
for arch in ('arm', 'amd'):
    report = json.loads(gzip.decompress((ROOT / f'{arch}-report.json.gz').read_bytes()))
    commands = [json.loads(line) for line in gzip.decompress(
        (ROOT / f'{arch}-commands.jsonl.gz').read_bytes()).decode().splitlines()]
    assert report['toolSource'] == 'b4b11d4a9f545b03a6af4b03f37612fb15650c9c'
    assert not report['failures'] and len(report['cases']) == 34
    assert len(report['builds']) == 6 and len(report['controls']) == 2
    rebuilt = {}
    for key, summary in report['cases'].items():
        row = commands[summary['command']]
        assert row['status'] == 0
        lines = row['stderr'].splitlines()
        selected = '/baseline/' not in key
        assert len(lines) == (2 if selected else 1)
        actual = dict(total=json.loads(lines[0]))
        total = actual['total']
        assert total['initialLiveBytes'] == total['finalLiveBytes']
        assert total['pushes'] == total['pops'] + total['unwinds']
        if selected:
            assert lines[1].startswith('FWP_PLAIN_HOLDS ')
            actual['selected'] = json.loads(lines[1].removeprefix('FWP_PLAIN_HOLDS '))
        assert actual == {name: value for name, value in summary.items() if name != 'command'}
        rebuilt[key] = actual
    for level in (1, 2):
        for population in (64, 4096):
            for mode in range(4):
                assert rebuilt[f'O{level}/baseline/{population}-{mode}']['total'] == rebuilt[f'O{level}/attributed/{population}-{mode}']['total']
        ordinary = rebuilt[f'O{level}/attributed/64-0']
        extra = rebuilt[f'O{level}/extra-pair/64-0']
        assert all(extra['selected'][name] == value + 1 for name, value in ordinary['selected'].items())
        delta = {name: extra['total'][name] - value for name, value in ordinary['total'].items()}
        assert all(delta[name] == 1 for name in ('dupCalls', 'retains', 'decrements'))
        assert delta['dropCalls'] + delta['releaseCalls'] == 1
        assert all(value == 0 for name, value in delta.items()
                   if name not in ('dupCalls', 'retains', 'decrements', 'dropCalls', 'releaseCalls'))
    assert 'raw output disagrees with summary' in (ROOT / f'{arch}-altered-summary.stderr').read_text()
    results[arch] = rebuilt
assert results['arm'] == results['amd']
print('Both hosts: 34 raw results each, unchanged totals, released storage and exact extra-pair controls agree')
