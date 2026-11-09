#!/usr/bin/env python3
"""Calibrate actual Linux mapping accounting without changing host policy."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import traceback

from parser_mapping_accounting import check_accounting
from parser_process_memory import checkpoint_process
from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('source', 'tag', 'cc', 'arch', 'c-arch'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.source == os.environ['GITHUB_SHA'] == subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True, cwd=ROOT).strip()
    assert args.source == subprocess.check_output(['git', 'rev-parse', args.tag], text=True, cwd=ROOT).strip()
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env['LC_ALL'] = 'C'
    report = dict(source=args.source, tag=args.tag, architecture=args.arch, host=platform.uname()._asdict(),
                  scope='Accountable and no-reservation mapping extents, actual resident pages and separate system-wide commit counters',
                  cases=[], controls=[], failures=[])
    commands = []

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def run(command):
        command = list(map(str, command))
        try:
            result = run_capture(command, env=env, cwd=ROOT, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=90, check=False)
        except subprocess.TimeoutExpired as error:
            stdout, stderr = error.stdout or b'', error.stderr or b''
            row = dict(status=None, timedOut=True,
                       stdout=stdout.decode('utf-8', errors='replace') if isinstance(stdout, bytes) else stdout,
                       stderr=stderr.decode('utf-8', errors='replace') if isinstance(stderr, bytes) else stderr)
        else:
            row = dict(status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        row.update(command=command, index=len(commands))
        commands.append(row)
        (folder / 'commands.json').write_text(json.dumps(commands, indent=2) + '\n')
        assert row['status'] == 0 and row['stderr'] == '', row
        return row

    save()
    for name in ('parser_accounting_control.c', 'parser_memory_checkpoint.c'):
        shutil.copyfile(ROOT / 'tests/fixtures' / name, folder / name)
    report['compilerVersion'] = run([args.cc, '--version'])['stdout']
    for level in (1, 2):
        binary = folder / f'control-O{level}'
        try:
            built = run([args.cc, '-std=gnu11', '-O' + str(level), '-march=' + args.c_arch, '-fno-lto',
                         '-Wall', '-Wextra', '-Werror', folder / 'parser_accounting_control.c',
                         folder / 'parser_memory_checkpoint.c', '-o', binary])
            assert built['stdout'] == ''
            image = binary.read_bytes()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
        except Exception as error:
            report['failures'].append(dict(stage=f'build O{level}', error=str(error), traceback=traceback.format_exc()))
            save()
            continue
        for reservation in ('accounted', 'no-reserve'):
            for variant in ('ordinary', 'omit-touch', 'omit-unmap'):
                label = f'O{level}-{reservation}-{variant}'
                try:
                    part = folder / label
                    result = checkpoint_process([binary, variant, reservation], env, part, 5, 90)
                    record = dict(level=level, reservation=reservation, variant=variant, folder=label,
                                  binarySha256=hashlib.sha256(image).hexdigest(), result=result)
                    if variant == 'ordinary':
                        record['accounting'] = check_accounting(result, part, reservation)
                        report['cases'].append(record)
                    else:
                        try:
                            check_accounting(result, part, reservation)
                        except ValueError as error:
                            expected = 'touch-control-missing' if variant == 'omit-touch' else 'unmap-control-missing'
                            assert str(error) == expected, error
                            record['expectedError'] = str(error)
                        else:
                            raise AssertionError('actual missing operation accepted')
                        report['controls'].append(record)
                    print(label, 'passes', flush=True)
                except Exception as error:
                    report['failures'].append(dict(stage=label, error=str(error), traceback=traceback.format_exc()))
                save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in folder.rglob('*') if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['cases']) == 4 and len(report['controls']) == 8
    print('Four O1/O2 reservation observations and eight real omitted-touch/unmap controls pass')


if __name__ == '__main__':
    main()
