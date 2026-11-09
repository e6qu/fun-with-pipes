#!/usr/bin/env python3
"""Observe actual target addresses and reject a link rebound to a replacement."""
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
from weak_operation_reuse import decode_output

ROOT = Path(__file__).resolve().parent.parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'ar', 'rustc', 'swiftc', 'source', 'arch', 'c-arch', 'rust-cpu', 'target'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source == os.environ['GITHUB_SHA']
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    fixtures = folder / 'fixtures'
    fixtures.mkdir()
    for path in (ROOT / 'tests/fixtures').glob('weak_operation_*'):
        shutil.copyfile(path, fixtures / path.name)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no', RUST_BACKTRACE='0')
    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  settings={key: str(value) for key, value in vars(args).items()},
                  scope='Observed address reuse and expiration, not timing, allocation sizes or ARC counts',
                  versions={}, builds=[], observations=[], checks=[], failures=[])
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
    for tool in ('cc', 'ar', 'rustc', 'swiftc'):
        report['versions'][tool] = run([getattr(args, tool), '--version'], (0, None, ''), env)['stdout']
    report['cpu'] = run(['lscpu'], (0, None, ''), env)['stdout']
    for language in ('c', 'rs', 'swift'):
        for level in (1, 2):
            for variant in ('ordinary', 'rebound'):
                label = f'{language}-O{level}-{variant}'
                try:
                    binary, metadata = build(args, folder, fixtures, None, run, env, language, level, variant, 'reuse', None)
                    report['builds'].append(metadata)
                except Exception as error:
                    failure('build ' + label, error)
                    continue
                cases = [((), (0, None, '')), (('unexpected',), (2, '', 'expected no arguments\n'))] if variant == 'ordinary' else [
                    ((), (79, '', 'weak reuse check failed\n'))]
                for arguments, expected in cases:
                    try:
                        row = run([binary, *arguments], expected, env)
                        if variant == 'ordinary' and not arguments:
                            observation = decode_output(row['stdout'], language)
                            report['observations'].append(dict(language=language, level=level, command=row['index'], result=observation))
                        report['checks'].append(row['index'])
                    except Exception as error:
                        failure(label + ' ' + repr(arguments), error)
                    save()
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert (len(report['builds']), len(report['checks']), len(report['observations'])) == (12, 18, 6)
    print('12 native builds and 18 checks verify actual address reuse, expiration and rebound-link controls')


if __name__ == '__main__':
    main()
