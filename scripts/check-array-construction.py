#!/usr/bin/env python3
"""Audit retained construction outputs, observer mutations and exact source files."""
import argparse
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess
from zipfile import ZipFile

SPEC = importlib.util.spec_from_file_location('construction', Path(__file__).with_name('report-array-construction.py'))
REPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(REPORT)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def check(directory):
    index = json.loads((directory / 'index.json').read_text())
    source = index['source']
    jobs = index['jobs']
    assert len(jobs) == len(index['records']) == 2
    assert all(j['conclusion'] == 'success' and j['head_sha'] == source for j in jobs)
    assert {j['name'] for j in jobs} == {'array_construction (ubuntu-latest, x86-64)',
        'array_construction (ubuntu-24.04-arm, armv8-a)'}
    machines = set()
    for row in index['records']:
        meta = row['artifact']
        assert meta['workflow_run']['head_sha'] == source
        assert meta['workflow_run']['id'] == index['run']
        raw = (directory / row['archive']).read_bytes()
        assert meta['digest'] == 'sha256:' + digest(raw)
        report_raw = gzip.decompress((directory / row['report']).read_bytes())
        with ZipFile(directory / row['archive']) as archive:
            assert archive.read('array-construction/report.json') == report_raw
            report = json.loads(report_raw)
            assert report['source'] == source
            machines.add(report['machine'])
            assert report['configuration']['c_arch'] == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[report['machine']]
            for name, identity in report['files'].items():
                data = archive.read('array-construction/' + name)
                assert identity == dict(bytes=len(data), sha256=digest(data)), name
            sources = {}
            for name, identity in report['sourceHashes'].items():
                data = subprocess.check_output(['git', 'show', source + ':' + name], cwd=REPORT.ROOT)
                assert digest(data) == identity, name
                sources[name] = data
            program = sources['tests/fixtures/array_construction_costs.fwp']
            assert archive.read('array-construction-source.fwp') == program
            generated = archive.read('array-construction/generated.c').decode()
            probe = sources['tests/fixtures/array_construction_costs_probe.c'].decode()
            commands = [json.loads(line) for line in archive.read('array-construction/commands.jsonl').splitlines()]
            assert len({c['observation'] for c in commands}) == len(commands)
            commands = {c['observation']: c for c in commands}
            for opt in ('O1', 'O2'):
                for profile in (False, True):
                    name = opt + ('-profile' if profile else '-ordinary')
                    csource = archive.read('array-construction/' + name + '.c').decode()
                    assert csource == REPORT.probe_source(generated, profile, probe)
                    command = commands[name + '-build']
                    assert command['status'] == 0
                    for flag in ('-' + opt, '-std=gnu11', '-ffp-contract=off',
                                 '-march=' + report['configuration']['c_arch'], '-fstack-usage'):
                        assert flag in command['command']
                    assert commands[name + '-run']['status'] == 0
                    assert not archive.read('array-construction/' + name + '-run.stderr')
                    output = archive.read('array-construction/' + name + '-run.stdout')
                    assert REPORT.check_output(output, profile) == report['results'][name]
                    if profile:
                        altered = REPORT.replace_once(csource,
                            'fwp_rc_free_arr(leftover); /* construction-final-release control */',
                            '/* deliberately omit the final constructed-array release */')
                        assert archive.read('array-construction/' + name + '-missing-release.c').decode() == altered
                        assert commands[name + '-control-run']['status'] == 219
                        assert archive.read('array-construction/' + name + '-control-run.stderr') == b'construction result retained before exit\n'
            for count in REPORT.COUNTS[:4]:
                for round_number in (0, 7):
                    for function in ('make-input', 'work'):
                        name = f'interpreter-{function}-{count}-{round_number}'
                        assert commands[name]['status'] == 0
                        assert not archive.read('array-construction/' + name + '.stderr')
            assert all(c['status'] == (219 if c['observation'].endswith('-control-run') else 0)
                       for c in commands.values())
    assert machines == {'aarch64', 'x86_64'}
    print('Both native archives reproduce exact source, results, storage and missing-release controls')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    args = parser.parse_args()
    check(args.directory)


if __name__ == '__main__':
    main()
