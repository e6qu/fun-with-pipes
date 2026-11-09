#!/usr/bin/env python3
"""Calibrate debug-symbol observations against the installed native glibc."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import tarfile
import traceback

from parser_allocator_observation import check_observation
from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
EXPECTED = 'in-place-growth moving shrink failed-old-preserved\n'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'gdb', 'source', 'tag', 'arch', 'c-arch'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source == os.environ['GITHUB_SHA']
    assert subprocess.check_output(['git', 'rev-parse', args.tag], cwd=ROOT, text=True).strip() == args.source
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith(('FWP_', 'MALLOC_', 'GLIBC_'))
           and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', DEBUGINFOD_URLS='')
    report = dict(source=args.source, tag=args.tag, architecture=args.arch, host=platform.uname()._asdict(),
                  scope='Installed libc resize-boundary calibration; not parser peaks, allocator chunk totals, RSS or committed RAM',
                  settings={key: str(value) for key, value in vars(args).items()}, failures=[])
    commands = []

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def run(command, environment):
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
        row.update(index=len(commands), command=command)
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == 0, row
        return row

    save()
    try:
        report['ccVersion'] = run([args.cc, '--version'], env)['stdout']
        report['gdbVersion'] = run([args.gdb, '--version'], env)['stdout']
        packages = run(['dpkg-query', '-W', '-f=${binary:Package}\t${source:Package}\t${source:Version}\n',
                        'libc6', 'libc6-dbg', 'glibc-source'], env)['stdout']
        report['packages'] = packages
        rows = [line.split('\t') for line in packages.splitlines()]
        assert len(rows) == 3 and {row[1] for row in rows} == {'glibc'} and len({row[2] for row in rows}) == 1
        source_archive, = Path('/usr/src/glibc').glob('*.tar.xz')
        report['glibcSource'] = dict(path=str(source_archive), sha256=hashlib.sha256(source_archive.read_bytes()).hexdigest())
        with tarfile.open(source_archive) as archive:
            member, = [member for member in archive.getmembers() if member.name.endswith('/malloc/malloc.c')]
            malloc_source = archive.extractfile(member).read()
        report['glibcSource'].update(mallocMember=member.name, mallocSha256=hashlib.sha256(malloc_source).hexdigest())
        source_root = folder / 'glibc-source'
        (source_root / 'malloc').mkdir(parents=True)
        source_path = source_root / 'malloc/malloc.c'
        source_path.write_bytes(malloc_source)
        os.utime(source_path, (member.mtime, member.mtime))
        report['glibcSource']['mallocArchiveMtime'] = member.mtime
        fixture = folder / 'calibration.c'
        shutil.copyfile(ROOT / 'tests/fixtures/parser_allocator_calibration.c', fixture)
        shutil.copyfile(ROOT / 'scripts/parser_allocator_gdb.py', folder / 'observer.py')
        binary = folder / 'calibration'
        built = run([args.cc, '-std=c11', '-O2', '-g', '-fno-lto', '-march=' + args.c_arch,
                     '-Wall', '-Wextra', '-Werror', fixture, '-o', binary], env)
        assert not built['stdout'] and not built['stderr'], built
        ordinary = run([binary], env)
        assert (ordinary['stdout'], ordinary['stderr']) == (EXPECTED, ''), ordinary
        report['ordinary'] = ordinary['index']
        report['binarySha256'] = hashlib.sha256(binary.read_bytes()).hexdigest()
        save()
        observed = run([args.gdb, '--batch', '--nx', '-ex', 'set auto-load off',
                        '-ex', 'directory ' + str(source_root), '-x', folder / 'observer.py', '--args', binary],
                       env | {'FWP_ALLOCATOR_OBSERVATION': str(folder / 'observation.json')})
        assert EXPECTED in observed['stdout'] and observed['stderr'] == '', observed
        observation = json.loads((folder / 'observation.json').read_text())
        report['observation'] = observed['index']
        report['calibration'] = check_observation(observation)
        report['ldd'] = run(['ldd', binary], env)['stdout']
    except Exception as error:
        report['failures'].append(dict(error=str(error), traceback=traceback.format_exc()))
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    print('In-place growth, moving, shrinking and failed reallocations observed with matched native libc/debug identities')


if __name__ == '__main__':
    main()
