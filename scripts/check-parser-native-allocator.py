#!/usr/bin/env python3
"""Connect installed-libc internal allocation events to real C/Rust parser calls."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import sys
import traceback

from parser_memory_source import MEASURE, ROOT, native, once
from parser_native_allocator import check_allocation_events, check_parser_events
from process_wait import run_capture

CASES = (('small', 5, False), ('medium', 9, False), ('large', 13, False), ('left', 64, True))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'ar', 'rustc', 'gdb', 'source', 'tag', 'arch', 'c-arch', 'rust-cpu', 'target'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[args.arch]
    assert args.rust_cpu == {'x86_64': 'x86-64', 'aarch64': 'generic'}[args.arch]
    for revision in ('HEAD', args.tag):
        assert subprocess.check_output(['git', 'rev-parse', revision], text=True).strip() == args.source == os.environ['GITHUB_SHA']
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith(('FWP_', 'MALLOC_', 'GLIBC_'))
           and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', DEBUGINFOD_URLS='', RUST_BACKTRACE='0')
    commands = []
    report = dict(source=args.source, tag=args.tag, architecture=args.arch,
                  settings={key: str(value) for key, value in vars(args).items()},
                  builds=[], ordinary=[], observations=[], faults=[], pathControls=[], failures=[], complete=False)

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

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
        row.update(command=command, index=len(commands))
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == 0 and row['stderr'] == '', row
        return row

    save()
    calibration = folder / 'calibration'
    calibrated = run([sys.executable, ROOT / 'scripts/check-parser-allocator-calibration.py',
        '--cc', args.cc, '--gdb', args.gdb, '--source', args.source, '--tag', args.tag,
        '--arch', args.arch, '--c-arch', args.c_arch, '--output', calibration], env)
    report['calibrationCommand'] = calibrated['index']
    calibration_report = json.loads((calibration / 'report.json').read_text())
    assert not calibration_report['failures']
    report['allocator'] = calibration_report['glibcSource']
    version = run([args.rustc, '--version', '--verbose'], env)['stdout']
    revision, = re.findall(r'^commit-hash: ([0-9a-f]{40})$', version, re.MULTILINE)
    sysroot = Path(run([args.rustc, '--print', 'sysroot'], env)['stdout'].strip())
    rust_source = sysroot / 'lib/rustlib/src/rust/library'
    assert rust_source.is_dir(), 'matching rust-src component required for debugger source lookup'
    report['rustVersion'] = version
    observer = folder / 'observer.py'
    shutil.copyfile(ROOT / 'scripts/parser_native_allocator_gdb.py', observer)
    helper = folder / 'checkpoint.c'
    helper.write_text('__attribute__((noinline)) void parser_memory_checkpoint(unsigned phase) {\n'
                      '    __asm__ __volatile__("" : : "r"(phase) : "memory");\n}\n')
    cflags = ['-std=gnu11', '-O2', '-g', '-fno-lto', '-ffp-contract=off', '-march=' + args.c_arch,
              '-Wall', '-Wextra', '-Werror']
    run([args.cc, *cflags, '-c', helper, '-o', folder / 'checkpoint.o'], env)
    run([args.ar, 'crs', folder / 'libparser_checkpoint.a', folder / 'checkpoint.o'], env)
    binaries = {}
    for language in ('c', 'rs'):
        original = (ROOT / 'tests/fixtures' / ('parser_arena_peer.' + language)).read_text()
        for mode in ('ordinary', 'observed', *(['omit-release'] if language == 'c' else [])):
            try:
                source = original if mode == 'ordinary' else native(original, language)
                if mode == 'omit-release':
                    source = once(source, '        free(arena.nodes); free(tokens);', '        free(tokens);')
                path = folder / (language + '-' + mode + '.' + language)
                path.write_text(source)
                binary = path.with_suffix('')
                if language == 'c':
                    command = [args.cc, *cflags, path, *([] if mode == 'ordinary' else [folder / 'checkpoint.o']), '-o', binary]
                else:
                    command = [args.rustc, '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
                        '-C', 'lto=off', '-C', 'codegen-units=16', '-C', 'debuginfo=2', '-C', 'panic=unwind',
                        '-C', 'target-cpu=' + args.rust_cpu, '--target', args.target, '-D', 'warnings', path,
                        *([] if mode == 'ordinary' else ['-L', 'native=' + str(folder), '-l', 'static=parser_checkpoint']), '-o', binary]
                built = run(command, env)
                image = binary.read_bytes()
                assert image[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(image[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[args.arch]
                report['builds'].append(dict(language=language, mode=mode, command=built['index'],
                    binarySha256=hashlib.sha256(image).hexdigest(), sourceSha256=hashlib.sha256(path.read_bytes()).hexdigest()))
                binaries[language, mode] = binary
            except Exception as error:
                failure(f'build {language}/{mode}', error)
    for name, depth, left in CASES:
        text, nodes, expected = MEASURE.input_case(depth, left)
        path = folder / (name + '.txt')
        path.write_text(text)
        for language in ('c', 'rs'):
            for mode in ('ordinary', 'observed', *(['omit-release'] if language == 'c' else [])):
                group = f'{name}/{language}/{mode}'
                try:
                    command = [binaries[language, mode], path, '1', expected, nodes]
                    if mode == 'ordinary':
                        row = run(command, env)
                        output = json.loads(row['stdout'])
                        assert (output['result'], output['nodes'], output['rounds']) == (expected, nodes, 1)
                        report['ordinary'].append(dict(case=name, language=language, command=row['index']))
                    else:
                        observation_path = folder / (name + '-' + language + '-' + mode + '.json')
                        row = run([args.gdb, '--batch', '--nx', '-iex', 'set auto-load off',
                            '-ex', 'directory ' + str(calibration / 'glibc-source'),
                            '-ex', 'directory ' + str(calibration / 'glibc-source/sysdeps/unix/sysv/linux'),
                            '-ex', f'set substitute-path /rustc/{revision}/library {rust_source}',
                            '-x', observer, '--args', *command], env | {'FWP_PARSER_ALLOCATOR_EVENTS': str(observation_path)})
                        outputs = [json.loads(line) for line in row['stdout'].splitlines() if line.startswith('{"rounds":')]
                        assert len(outputs) == 1
                        assert (outputs[0]['result'], outputs[0]['nodes'], outputs[0]['rounds']) == (expected, nodes, 1)
                        observation = json.loads(observation_path.read_text())
                        if mode == 'omit-release':
                            try:
                                check_parser_events(observation, nodes)
                            except AssertionError as error:
                                assert str(error) == 'parser allocations remain live', error
                            else:
                                raise AssertionError('actual omitted release was accepted')
                            report['faults'].append(dict(case=name, command=row['index'], file=observation_path.name))
                        else:
                            result = check_parser_events(observation, nodes)
                            report['observations'].append(dict(case=name, language=language, command=row['index'],
                                                              file=observation_path.name, result=result))
                    save()
                except Exception as error:
                    failure(group, error)
    try:
        path_source = folder / 'allocator-paths.c'
        shutil.copyfile(ROOT / 'tests/fixtures/parser_allocator_paths.c', path_source)
        path_binary = folder / 'allocator-paths'
        built = run([args.cc, *cflags, path_source, folder / 'checkpoint.o', '-pthread', '-o', path_binary], env)
        report['pathControlBuild'] = dict(command=built['index'],
            sourceSha256=hashlib.sha256(path_source.read_bytes()).hexdigest(),
            binarySha256=hashlib.sha256(path_binary.read_bytes()).hexdigest())
        for mode in ('mapped', 'retry'):
            try:
                ordinary = run([path_binary, mode], env)
                expected_output = ('mapped' if mode == 'mapped' else 'arena retry') + ' bytes preserved and released\n'
                assert ordinary['stdout'] == expected_output
                observation_path = folder / ('path-' + mode + '.json')
                observed = run([args.gdb, '--batch', '--nx', '-iex', 'set auto-load off',
                    '-ex', 'directory ' + str(calibration / 'glibc-source'),
                    '-ex', 'directory ' + str(calibration / 'glibc-source/sysdeps/unix/sysv/linux'), '-x', observer,
                    '--args', path_binary, mode], env | {'FWP_PARSER_ALLOCATOR_EVENTS': str(observation_path)})
                assert expected_output in observed['stdout']
                observation = json.loads(observation_path.read_text())
                transitions = ([[0, 1 << 20], [1 << 20, 4 << 20], [4 << 20, 0]] if mode == 'mapped'
                               else [[0, 128], [0, 128], [128, 1 << 20], [1 << 20, 0], [128, 0]])
                result = check_allocation_events(observation, transitions, 1 if mode == 'mapped' else 2)
                if mode == 'mapped':
                    remaps = [row for row in observation['events']
                              if row['kind'] == 'internal-return' and row['function'] == '__mremap']
                    assert len(remaps) == 1 and remaps[0]['pointer'] != (1 << 64) - 1
                    assert result['operations'][1]['path'] == 'mapped-remap'
                    assert result['requestedPeakWithObservedResizeOverlapBytes'] == 4 << 20
                else:
                    assert result['operations'][2]['path'] == 'arena-retry-copy'
                    assert result['requestedPeakWithObservedResizeOverlapBytes'] == (1 << 20) + 256
                report['pathControls'].append(dict(mode=mode, ordinary=ordinary['index'],
                    observed=observed['index'], file=observation_path.name, result=result))
                save()
            except Exception as error:
                failure('allocator path ' + mode, error)
    except Exception as error:
        failure('allocator path build', error)
    report['complete'] = (not report['failures'] and len(report['builds']) == 5
                         and len(report['ordinary']) == len(report['observations']) == 8
                         and len(report['faults']) == 4 and len(report['pathControls']) == 2)
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert report['complete'], report
    print('Eight parser traces, mapped remap and two-arena retry pass; four actual omitted releases rejected')


if __name__ == '__main__':
    main()
