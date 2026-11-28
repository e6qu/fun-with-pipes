"""Reconstruct retained raw counts/replies; native-image auditing ran on CI."""
import gzip
import hashlib
import json
from pathlib import Path
import sys

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT.parents[2] / 'scripts'))

from http_load import REQUEST, response_ok
from nested_resource_counts import decode as decode_total
from resource_frame_counts import decode
from weak_callback_timing import decode_output

results = {}
for label, arch in (('arm', 'aarch64'), ('amd', 'x86_64')):
    payloads = {name: gzip.decompress((ROOT / f'{label}-{name}.gz').read_bytes())
                for name in ('report.json', 'commands.jsonl', 'manifest.json', 'http.json')}
    report = json.loads(payloads['report.json'])
    commands = [json.loads(line) for line in payloads['commands.jsonl'].splitlines()]
    manifest = json.loads(payloads['manifest.json'])
    http = json.loads(payloads['http.json'])
    assert report['arch'] == arch and not report['failures']
    assert report['toolSource'] == '041db8772962f0e15ff44d70b56f1142fc8aa103'
    assert report['source'] == '9b24e6965dd4c7cfb6e88163a34722e0b99ec901'
    assert len(report['builds']) == 12 and len(report['cases']) == 44
    for name in ('report.json', 'commands.jsonl'):
        assert hashlib.sha256(payloads[name]).hexdigest() == manifest[name]
    for name, value in http.items():
        assert hashlib.sha256(value.encode()).hexdigest() == manifest[name]
    state = json.loads((ROOT / f'{label}-run.json').read_text())
    assert state['id'] == 46063375647 and state['head_sha'] == report['toolSource']
    assert state['conclusion'] == 'success'
    rebuilt = {}
    for key, summary in report['cases'].items():
        application, level, variant, input_ = key.split('/')
        population, mode = map(int, input_.split('-'))
        if application == 'service':
            command = commands[summary['command']]
            assert command['status'] == 0
            assert command['command'][-3:] == [str(population), str(mode), '1']
            decode_output(command['stdout'], population, mode, 1)
            lines = command['stderr'].splitlines()
            actual = dict(total=decode_total(lines[0]))
        else:
            assert application == 'http'
            path = summary['directory']
            command = json.loads(http[path + '/command.json'])
            assert command['status'] == 0 and command['requests'] == command['responses'] == population
            assert http[path + '/request.bin'].encode() == REQUEST
            assert not http[path + '/stdout']
            for index in range(population):
                assert response_ok(http[f'{path}/response-{index}.bin'].encode())
            lines = http[path + '/stderr'].splitlines()
            assert lines.count('stopped') == 1
            total, = [line.removeprefix('FWP_HTTP_TOTAL ') for line in lines if line.startswith('FWP_HTTP_TOTAL ')]
            actual = dict(total=decode_total(total))
        if variant != 'baseline':
            work, = [line for line in lines if line.startswith('FWP_RESOURCE_WORK ')]
            actual['work'] = decode(work, report['selected'][application])
        assert actual == {name: value for name, value in summary.items() if name not in ('command', 'directory')}
        rebuilt[key] = actual
    for application in ('service', 'http'):
        assert 'raw output disagrees with summary' in (ROOT / f'{label}-{application}-altered-summary.stderr').read_text()
        for level in (1, 2):
            base = rebuilt[f'{application}/O{level}/attributed/64-0']
            extra = rebuilt[f'{application}/O{level}/extra-pair/64-0']
            assert base['work']['frames'] == extra['work']['frames']
            assert base['work']['closures'] == extra['work']['closures']
            assert [sum(row[i] for row in extra['work']['fields']) - sum(row[i] for row in base['work']['fields'])
                    for i in range(4)] == [1, 1, 1, 1]
            if application == 'service':
                for population in (64, 4096):
                    for mode in range(4):
                        assert rebuilt[f'service/O{level}/baseline/{population}-{mode}']['total'] == rebuilt[f'service/O{level}/attributed/{population}-{mode}']['total']
    results[label] = rebuilt
assert results['arm'] == results['amd']
print('Both hosts agree: 44 raw executions, every HTTP reply, released storage and real extra-owner controls')
