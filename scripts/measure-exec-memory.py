#!/usr/bin/env python3
"""Compare GNU time and lifecycle counters for unchanged service executables."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import zipfile

from exec_memory import observe
from exec_memory_records import review, validate_transient
from nested_resource_memory import MEMORY_ENVIRONMENTS
from nested_resource_timing import order
from process_wait import run_capture
from weak_callback_timing import CASES, decode_output

ROOT = Path(__file__).resolve().parent.parent
SOURCE = '33149ad2fd888a66ff36b8eb7f2c5b61faccfccb'
RUN = 46067853489


def digest(path):
    with path.open('rb') as stream:
        return hashlib.file_digest(stream, 'sha256').hexdigest()


def original(folder, arch):
    repository = 'repos/' + os.environ['GITHUB_REPOSITORY']
    listing = json.loads(subprocess.check_output(['gh', 'api', f'{repository}/actions/runs/{RUN}/artifacts?per_page=100']))
    assert listing['total_count'] == len(listing['artifacts'])
    artifact, = [row for row in listing['artifacts'] if row['name'] == 'nested-resource-time-' + arch]
    assert not artifact['expired'] and artifact['workflow_run']['head_sha'] == SOURCE
    assert artifact['workflow_run']['id'] == RUN and artifact['size_in_bytes'] < 256 * 1024 * 1024
    archive = folder / 'native.zip'
    with archive.open('wb') as stream:
        subprocess.run(['gh', 'api', f"{repository}/actions/artifacts/{artifact['id']}/zip"], stdout=stream, check=True)
    assert archive.stat().st_size == artifact['size_in_bytes']
    assert 'sha256:' + digest(archive) == artifact['digest']
    destination = (folder / 'original-native').resolve()
    with zipfile.ZipFile(archive) as contents:
        assert sum(row.file_size for row in contents.infolist()) < 1024 * 1024 * 1024
        assert len(contents.namelist()) == len(set(contents.namelist()))
        assert all((destination / name).resolve().is_relative_to(destination) for name in contents.namelist())
        assert contents.testzip() is None
        contents.extractall(destination)
    archive.unlink()
    for directory in ('nested-time-comparison', 'nested-time-peers'):
        part = destination / directory
        for name, expected in json.loads((part / 'manifest.json').read_text()).items():
            path = part / name
            assert path.resolve().is_relative_to(part) and digest(path) == expected
    return destination, artifact


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    parser.add_argument('--image', required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.machine() == args.arch
    image, libc = MEMORY_ENVIRONMENTS[SOURCE]
    assert args.image == image
    assert subprocess.check_output(['dpkg-query', '-W', '-f=${Version}', 'libc6'], text=True) == libc
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    native, artifact = original(folder, args.arch)
    comparison = json.loads((native / 'nested-time-comparison/report.json').read_text())
    peers = json.loads((native / 'nested-time-peers/report.json').read_text())
    assert comparison['source'] == peers['source'] == SOURCE
    assert comparison['architecture'] == peers['architecture'] == args.arch
    assert not comparison['failures'] and not peers['failures']
    for name, value in (('original-comparison', comparison), ('original-peers', peers)):
        (folder / (name + '.json')).write_text(json.dumps(value, indent=2) + '\n')
    binaries = {}
    for role, metadata in comparison['binaries'].items():
        for label, field in ((role, 'path'), (role + '-copy', 'copyPath')):
            path = native / 'nested-time-comparison' / metadata[field]
            assert digest(path) == metadata['sha256'] and path.stat().st_size == metadata['bytes']
            data = path.read_bytes()
            assert data[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(data[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
            path.chmod(0o755)
            binaries[label] = dict(path=str(path), sha256=metadata['sha256'])
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', FWP_LTO='0', FWP_STACK='1')
    commands = []
    for name in ('launch', 'control'):
        command = ['gcc', '-std=gnu11', '-O2', '-Wall', '-Wextra', '-Werror', '-fno-lto', '-pthread',
                   '-march=' + {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch],
                   str(ROOT / 'tests/fixtures' / f'exec_memory_{name}.c'), '-o', str(folder / name)]
        subprocess.run(command, check=True, env=env)
        commands.append(command)
    report = dict(source=os.environ['GITHUB_SHA'], binarySource=SOURCE, originalRun=RUN,
                  architecture=args.arch, pageBytes=os.sysconf('SC_PAGE_SIZE'),
                  kernel=platform.release(), cpu=subprocess.check_output(['lscpu'], text=True),
                  image=image, libcPackage=libc, originalArtifact=artifact, binaries=binaries,
                  timeSha256=digest(Path('/usr/bin/time')),
                  timeVersion=subprocess.check_output(['/usr/bin/time', '--version'], text=True),
                  compiler=subprocess.check_output(['gcc', '--version'], text=True),
                  commands=commands, controls={}, cases={},
                  scope='Lifecycle counters and terminal mappings, not exact transient page peaks or timing acceptance.')

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    for mode in ('transient', 'untouched', 'exec'):
        part = folder / ('control-' + mode)
        observe(folder / 'launch', ['/usr/bin/time', '-f', '%M', '-o', part / 'rss.txt', folder / 'control', mode], env, part)
        expected = [digest(folder / 'control')]
        if mode == 'exec':
            expected.append(digest(Path('/bin/true')))
        result = review(part, expected, report['pageBytes'])
        report['controls'][mode] = dict(hashes=expected, result=result)
        if mode == 'transient':
            validate_transient(result)
        elif mode == 'untouched':
            try:
                validate_transient(result)
            except AssertionError as error:
                assert str(error) == 'touch-control-missing'
            else:
                raise AssertionError('untouched control accepted')
        else:
            assert result['gnuTimePeakKiB'] > 30 * 1024 and result['terminalHwmKiB'] < 8 * 1024
        save()
    for population, mode in CASES:
        key = f'{population}-{mode}'
        batches = peers['pilots'][key]['batches']
        rows = report['cases'][key] = []
        for round_number in range(4):
            for label in order(round_number):
                for path in (('ordinary', 'traced') if round_number % 2 == 0 else ('traced', 'ordinary')):
                    part = folder / key / f'{round_number}-{label}-{path}'
                    command = list(map(str, ['/usr/bin/time', '-f', '%M', '-o', part / 'rss.txt',
                                            binaries[label]['path'], population, mode, batches]))
                    if path == 'traced':
                        observe(folder / 'launch', command, env, part)
                        result = review(part, [binaries[label]['sha256']], report['pageBytes'])
                    else:
                        part.mkdir(parents=True)
                        child = run_capture(command, env=env, cwd=ROOT, input_data=None, input_stream=None,
                                            text=True, encoding='utf-8', timeout=30, check=False)
                        (part / 'stdout.txt').write_text(child.stdout)
                        (part / 'stderr.txt').write_text(child.stderr)
                        (part / 'execution.json').write_text(json.dumps(dict(command=command, status=child.returncode)) + '\n')
                        assert child.returncode == 0
                        result = dict(gnuTimePeakKiB=int((part / 'rss.txt').read_text()))
                    assert not (part / 'stderr.txt').read_text()
                    decode_output((part / 'stdout.txt').read_text(), population, mode, batches)
                    rows.append(dict(round=round_number, label=label, path=path,
                                     folder=str(part.relative_to(folder)), result=result))
                    save()
        print(key, '32 executions retained;',
              'GNU-time/terminal-HWM differences:', [row['result']['lifetimeMinusTerminalHwmKiB']
               for row in rows if row['path'] == 'traced'], flush=True)
    print('All 256 service executions and three native accounting controls complete', flush=True)


if __name__ == '__main__':
    main()
