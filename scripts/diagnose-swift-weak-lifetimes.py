#!/usr/bin/env python3
"""Locate the original Swift queued-lifetime trap without replacing its checks."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import traceback

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent


def once(source, before, after):
    assert source.count(before) == 1, before
    return source.replace(before, after)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('swiftc', 'source', 'original', 'arch', 'target'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
    assert os.environ['GITHUB_SHA'] == args.source
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items() if k not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no')
    report = dict(source=args.source, original=args.original, architecture=args.arch,
                  cases=[], failures=[], settings=vars(args) | {'output': str(folder)})

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def run(command, environment):
        result = run_capture(list(map(str, command)), env=environment, cwd=ROOT,
                             input_data=None, input_stream=None, text=True, encoding='utf-8',
                             timeout=90, check=False)
        row = dict(command=list(map(str, command)), status=result.returncode,
                   stdout=result.stdout, stderr=result.stderr,
                   backtrace=environment['SWIFT_BACKTRACE'])
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        return row

    original = run(['git', 'show', args.original + ':tests/fixtures/weak_registration_peer.swift'], env)
    assert original['status'] == 0 and not original['stderr'], original
    source = original['stdout']
    report['originalSourceSha256'] = hashlib.sha256(source.encode()).hexdigest()
    report['version'] = run([args.swiftc, '--version'], env)
    assert report['version']['status'] == 0
    for cancellation, lookup in ((False, False), (True, False), (False, True), (True, True)):
        name = f'cancel-{int(cancellation)}-lookup-{int(lookup)}'
        code = source
        if cancellation:
            code = once(code,
                '            queue[0] = nil\n            precondition(counts.disposed == 1 && counts.destroyed == 0)',
                '            withExtendedLifetime(owner) {\n                queue[0] = nil\n'
                '                precondition(counts.disposed == 1 && counts.destroyed == 0)\n            }')
        if lookup:
            for variable, expression, returned in (('active', 'registration.target', 'false'),
                                                     ('acquired', 'registration.target', 'false'),
                                                     ('held', 'entry.target', '')):
                before = f'    guard let {variable} = {expression} else {{ return{(" " + returned) if returned else ""} }}'
                after = before.replace('= ' + expression, '= withExtendedLifetime(outside, { ' + expression + ' })')
                code = once(code, before, after)
        part = folder / name
        part.mkdir()
        # Preserve the original basename, which also determines Swift's module name.
        path = part / 'swift-ordinary.swift'
        path.write_text(code)
        for debug in (False, True):
            binary = folder / (name + ('-debug' if debug else '-ordinary'))
            try:
                command = [args.swiftc, '-swift-version', '6', '-O', '-whole-module-optimization',
                           '-warnings-as-errors', '-target', args.target]
                if debug:
                    command.append('-g')
                built = run(command + [path, '-o', binary], env)
                assert (built['status'], built['stdout'], built['stderr']) == (0, '', ''), built
                image = binary.read_bytes()
                assert image[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(image[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[args.arch]
                row = dict(variant=name, debug=debug, sourceSha256=hashlib.sha256(code.encode()).hexdigest(),
                           binarySha256=hashlib.sha256(image).hexdigest(), result=run([binary], env))
                report['cases'].append(row)
                if row['result']['status'] == 0:
                    assert (row['result']['stdout'], row['result']['stderr']) == (
                        'calls=2 destroyed=66 expired=1 cancelled=1 error=1 queue=1\n', ''), row
                if row['result']['status'] != 0:
                    trace_env = env | {'SWIFT_BACKTRACE': 'enable=yes,interactive=no,demangle=yes,color=no,'
                                      'threads=crashed,registers=none,images=none,limit=12,top=12,symbolicate=full'}
                    row['trace'] = run([binary], trace_env)
                print(name, 'debug', debug, 'exit', row['result']['status'], flush=True)
                if 'trace' in row:
                    print(row['trace']['stderr'], flush=True)
            except Exception as error:
                report['failures'].append(dict(variant=name, debug=debug, error=str(error),
                                               traceback=traceback.format_exc()))
            save()
    assert not report['failures'], report['failures']
    assert len(report['cases']) == 8
    print('Eight original-check variants recorded; runtime traps remain diagnostic observations, not passing lifetime checks')


if __name__ == '__main__':
    main()
