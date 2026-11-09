#!/usr/bin/env python3
"""Observe fwp managed slots by weak phase, with real allocation/free controls."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import traceback

from process_wait import run_capture
from weak_operation_build import build
from weak_operation_census import CASES, decode_output, instrument
from weak_operation_source import boundary

ROOT = Path(__file__).resolve().parent.parent


def audit(folder, source, arch):
    manifest = json.loads((folder / 'manifest.json').read_text())
    actual = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
              for path in folder.rglob('*') if path.is_file() and path.name != 'manifest.json'}
    assert actual == manifest
    report = json.loads((folder / 'report.json').read_text())
    assert (report['source'], report['architecture'], report['failures']) == (source, arch, [])
    commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    assert [row['index'] for row in commands] == list(range(len(commands)))
    for path in (folder / 'fixtures').iterdir():
        assert path.read_bytes() == subprocess.check_output(['git', 'show', f'{source}:tests/fixtures/{path.name}'], cwd=ROOT)
    expected_source = instrument(boundary((folder / 'original.c').read_text()))
    builds = {row['level']: row for row in report['builds']}
    assert len(report['builds']) == 2 and set(builds) == {1, 2}
    for level, build_row in builds.items():
        assert (build_row['language'], build_row['variant'], build_row['mode']) == ('fwp', 'release-observed', 'census')
        part = folder / f'fwp-{level}-release-observed'
        assert (part / 'factory.c').read_text() == expected_source
        assert (part / 'caller.c').read_bytes() == (folder / 'fixtures/weak_operation_census.c').read_bytes()
        image = (part / 'program').read_bytes()
        assert image[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[arch]
        assert hashlib.sha256(image).hexdigest() == build_row['binarySha256']
        assert sum(row['command'] == build_row['link'] for row in commands) == 1
    seen, failures = set(), set()
    assert len(report['observations']) == 8
    assert {(row['level'], row['result']['population'], row['result']['lookups']) for row in report['observations']} == {
        (level, population, lookups) for level in (1, 2) for population, lookups in CASES}
    for row in report['observations']:
        assert row['command'] not in seen
        seen.add(row['command'])
        command = commands[row['command']]
        population, lookups = row['result']['population'], row['result']['lookups']
        assert command['command'] == [builds[row['level']]['link'][-1], str(population), str(lookups), 'ordinary']
        assert row['result'] == decode_output(command['stdout'], population, lookups)
    controls = {
        'extra-allocation': (['1', '1', 'extra-allocation'], 79, 'allocation observer control failed'),
        'omit-free': (['1', '1', 'omit-free'], 79, 'allocation observer control failed'),
        'expected population lookups control': ([], 2, 'expected population lookups control'),
        'invalid allocation control': (['1', '1', 'unknown'], 2, 'invalid allocation control'),
    }
    assert len(report['controls']) == 8
    assert {(row['level'], row['control']) for row in report['controls']} == {
        (level, control) for level in (1, 2) for control in controls}
    for row in report['controls']:
        assert row['command'] not in seen
        seen.add(row['command'])
        failures.add(row['command'])
        command = commands[row['command']]
        arguments, status, error = controls[row['control']]
        assert command['command'] == [builds[row['level']]['link'][-1], *arguments]
        assert (command['status'], command['stdout'], command['stderr']) == (status, '', error + '\n')
    for row in commands:
        if row['index'] not in failures:
            assert row['status'] == 0 and row['stderr'] == ''
    print('Census source, native images, all raw observations and actual fault results agree')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'source', 'arch', 'c-arch'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source == os.environ['GITHUB_SHA']
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    fixtures = folder / 'fixtures'
    fixtures.mkdir()
    for path in (ROOT / 'tests/fixtures').glob('weak_operation_*'):
        shutil.copyfile(path, fixtures / path.name)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', CC=args.cc, FWP_LTO='0', FWP_STACK='1')
    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  compilerSha256=hashlib.sha256(args.compiler.read_bytes()).hexdigest(),
                  settings={key: str(value) for key, value in vars(args).items()},
                  scope='Diagnostic managed slot allocations/live/peak bytes, not native backing, RSS, timing or ARC counts',
                  builds=[], observations=[], controls=[], failures=[])
    commands = []

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

    def run(command, expected, environment):
        command = list(map(str, command))
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=120, check=False)
        except subprocess.TimeoutExpired as error:
            stdout, stderr = error.stdout or b'', error.stderr or b''
            row = dict(status=None, timedOut=True,
                       stdout=stdout.decode('utf-8', errors='replace') if isinstance(stdout, bytes) else stdout,
                       stderr=stderr.decode('utf-8', errors='replace') if isinstance(stderr, bytes) else stderr)
        else:
            row = dict(status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        row.update(command=command, index=len(commands))
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0] and row['stderr'] == expected[2], row
        assert expected[1] is None or row['stdout'] == expected[1], row
        return row

    save()
    report['compilerVersion'] = run([args.cc, '--version'], (0, None, ''), env)['stdout']
    report['cpu'] = run(['lscpu'], (0, None, ''), env)['stdout']
    original = folder / 'original.c'
    run([args.compiler.resolve(), 'build', '--fn', 'reference-functions', '--memory', 'dynamic', '--emit-c', '-O2',
         fixtures / 'weak_operation_peer.fwp', '-o', original], (0, '', ''), env)
    emitted = instrument(boundary(original.read_text()))
    for level in (1, 2):
        try:
            binary, metadata = build(args, folder, fixtures, emitted, run, env, 'fwp', level,
                                     'release-observed', 'census', None)
            report['builds'].append(metadata)
        except Exception as error:
            failure(f'build O{level}', error)
            continue
        for population, lookups in CASES:
            try:
                row = run([binary, population, lookups, 'ordinary'], (0, None, ''), env)
                result = decode_output(row['stdout'], population, lookups)
                report['observations'].append(dict(level=level, command=row['index'], result=result))
            except Exception as error:
                failure(f'O{level} {population}/{lookups}', error)
            save()
        for control in ('extra-allocation', 'omit-free'):
            try:
                row = run([binary, 1, 1, control], (79, '', 'allocation observer control failed\n'), env)
                report['controls'].append(dict(level=level, control=control, command=row['index']))
            except Exception as error:
                failure(f'O{level} {control}', error)
            save()
        for arguments, message in (([], 'expected population lookups control'),
                                   (['1', '1', 'unknown'], 'invalid allocation control')):
            try:
                row = run([binary, *arguments], (2, '', message + '\n'), env)
                report['controls'].append(dict(level=level, control=message, command=row['index']))
            except Exception as error:
                failure(f'O{level} arguments {arguments}', error)
            save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['builds']) == 2 and len(report['observations']) == 8 and len(report['controls']) == 8
    audit(folder, args.source, args.arch)
    print('Eight six-phase observations and eight real allocation/free/argument controls pass')


if __name__ == '__main__':
    main()
