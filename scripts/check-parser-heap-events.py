#!/usr/bin/env python3
"""Run real fwp parser allocations, region blocks and broken-observer controls."""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import traceback

from parser_heap_events import check_events
from parser_heap_source import instrument
from parser_memory_source import MEASURE, ROOT, fwp
from process_wait import run_capture

CASES = (('small', 5, False), ('medium', 9, False), ('large', 13, False), ('left', 64, True))
MODES = ('ordinary', 'none', 'omit-region-release', 'omit-allocation-event', 'wrong-slot-size')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('compiler', 'cc', 'source', 'tag', 'arch', 'c-arch'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[args.arch]
    for revision in ('HEAD', args.tag):
        assert subprocess.check_output(['git', 'rev-parse', revision], text=True).strip() == args.source == os.environ['GITHUB_SHA']
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith(('FWP_', 'MALLOC_', 'GLIBC_'))
           and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', RUST_BACKTRACE='0')
    commands = []
    report = dict(source=args.source, tag=args.tag, architecture=args.arch,
                  settings={key: str(value) for key, value in vars(args).items()},
                  builds=[], ordinary=[], observations=[], faults=[], wrongResults=[], failures=[], complete=False)

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, str(error)[:500], flush=True)

    def run(command, status):
        command = list(map(str, command))
        try:
            result = run_capture(command, env=env, cwd=ROOT, input_data=None, input_stream=None,
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
        # Compact complete per-command records keep even the large event streams
        # reviewable without removing raw output or inflating local downloads.
        data = (json.dumps(row) + '\n').encode()
        (folder / f'command-{row["index"]}.json.gz').write_bytes(gzip.compress(data, mtime=0))
        assert row['status'] == status, (row['index'], row['status'], status, row['stderr'])
        assert row['stderr'] == '' or status == 94 and row['stderr'].startswith('parser entry cleanup failed:'), (row['index'], row['stderr'])
        return row

    save()
    report['compilerSha256'] = hashlib.sha256(Path(args.compiler).read_bytes()).hexdigest()
    report['ccVersion'] = run([args.cc, '--version'], 0)['stdout']
    report['cpu'] = run(['lscpu'], 0)['stdout']
    fixture = (ROOT / 'tests/fixtures/parser_workspace.fwp').read_text().split('\nmain =')[0]
    program = folder / 'parser.fwp'
    program.write_text(fixture + '\nmain = "+ 2 * 3 4" | calculate | echo\n')
    generated = folder / 'original.c'
    run([Path(args.compiler).resolve(), 'build', '--emit-c', '--memory', 'dynamic', '--fn', 'calculate',
         '-O2', program, '-o', generated], 0)
    binaries = {}
    for mode in MODES:
        for level in (1, 2):
            group = f'{mode}/O{level}'
            try:
                source = folder / (mode + f'-O{level}.c')
                source.write_text(fwp(generated.read_text(), False) if mode == 'ordinary' else instrument(generated.read_text(), mode))
                binary = source.with_suffix('')
                row = run([args.cc, '-std=gnu11', f'-O{level}', '-fno-lto', '-ffp-contract=off',
                    '-march=' + args.c_arch, '-w', source, '-lm', '-lpthread', '-ldl', '-o', binary], 0)
                image = binary.read_bytes()
                assert image[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(image[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[args.arch]
                binaries[mode, level] = binary
                report['builds'].append(dict(mode=mode, level=level, command=row['index'],
                    sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(), binarySha256=hashlib.sha256(image).hexdigest()))
                save()
            except Exception as error:
                failure('build ' + group, error)
    for name, depth, left in CASES:
        text, nodes, expected = MEASURE.input_case(depth, left)
        path = folder / (name + '.txt')
        path.write_text(text)
        for mode in MODES:
            for level in (1, 2):
                group = f'{name}/{mode}/O{level}'
                try:
                    binary = binaries[mode, level]
                    row = run([binary, path, 1, expected, nodes], 94 if mode == 'omit-region-release' else 0)
                    records = [json.loads(line) for line in row['stdout'].splitlines()]
                    events = [record for record in records if 'event' in record]
                    results = [record for record in records if 'event' not in record]
                    if mode != 'omit-region-release':
                        assert len(results) == 1 and results[0]['result'] == expected and results[0]['rounds'] == 1
                    if mode == 'ordinary':
                        assert not events
                        report['ordinary'].append(dict(case=name, level=level, command=row['index']))
                        wrong = run([binary, path, 1, expected + 1, nodes], 93)
                        assert wrong['stdout'] == ''
                        report['wrongResults'].append(dict(case=name, level=level, command=wrong['index']))
                    elif mode == 'none':
                        result = check_events(events, nodes)
                        report['observations'].append(dict(case=name, level=level, command=row['index'], result=result))
                    else:
                        try:
                            check_events(events, nodes)
                        except AssertionError as error:
                            if mode == 'omit-region-release':
                                assert str(error) == 'parser allocations remain live', error
                            report['faults'].append(dict(case=name, mode=mode, level=level, command=row['index'], diagnostic=str(error)))
                        else:
                            raise AssertionError('actual missing release or broken observer accepted')
                    save()
                except Exception as error:
                    failure(group, error)
    report['complete'] = (not report['failures'] and len(report['builds']) == 10
        and len(report['ordinary']) == len(report['observations']) == len(report['wrongResults']) == 8
        and len(report['faults']) == 24)
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert report['complete'], [(row['group'], row['error'][:500]) for row in report['failures']]
    print('Eight actual fwp parser event traces pass; eight wrong results and 24 missing-release/observer faults rejected')


if __name__ == '__main__':
    main()
