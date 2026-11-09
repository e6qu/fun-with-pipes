#!/usr/bin/env python3
"""Check separately compiled buffer factories, surviving aliases and release."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import traceback

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('returned_buffer_source', ROOT / 'scripts/returned-buffer-source.py')
SOURCE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SOURCE)
LENGTHS = (-9223372036854775808, -1, 0, 1, 16, 4096, 262144)
INVALID = (
    ([], 'expected length repeats'), (['0'], 'expected length repeats'),
    (['0', '1', 'extra'], 'expected length repeats'),
    (['', '1'], 'invalid integer'), (['+', '1'], 'invalid integer'),
    ([' 1', '1'], 'invalid integer'), (['1x', '1'], 'invalid integer'),
    (['9223372036854775808', '1'], 'invalid integer'),
    (['-9223372036854775809', '1'], 'invalid integer'),
    (['262145', '1'], 'length exceeds experiment bound'),
    (['0', '0'], 'repeats outside experiment bound'),
    (['0', '-1'], 'repeats outside experiment bound'),
    (['0', '65'], 'repeats outside experiment bound'),
    (['0', '1.0'], 'invalid integer'),
)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'rustc', 'swiftc', 'source', 'arch', 'c-arch', 'rust-cpu', 'target'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'native comparisons run on GitHub'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    assert os.environ['GITHUB_SHA'] == args.source
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    fixtures = folder / 'fixtures'
    fixtures.mkdir()
    for path in (ROOT / 'tests/fixtures').glob('returned_buffer_*'):
        shutil.copyfile(path, fixtures / path.name)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no', CC=args.cc, FWP_LTO='0', FWP_STACK='1')
    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  settings={name: str(value) for name, value in vars(args).items()},
                  scope='Returned-buffer correctness; no timing or native allocation/ARC count claims',
                  compilerSha256=hashlib.sha256(args.compiler.read_bytes()).hexdigest(),
                  versions={}, builds=[], checks=[], interpreter=[], failures=[])

    def failed(group, error):
        report['failures'].append(dict(group=group, type=type(error).__name__,
                                       message=str(error), traceback=traceback.format_exc()))
        print(f'{group} failed: {error}', flush=True)

    def run(command, expected, environment):
        command = list(map(str, command))
        result = run_capture(command, env=environment, cwd=None, input_data=None,
                             input_stream=None, text=True, encoding='utf-8', timeout=120, check=False)
        row = dict(command=command, status=result.returncode, stdout=result.stdout, stderr=result.stderr,
                   fwpNoOpt=environment.get('FWP_NO_OPT'))
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        actual = (row['status'], row['stdout'], row['stderr'])
        assert actual == expected, row
        return row

    for name in ('cc', 'rustc', 'swiftc'):
        result = subprocess.run([getattr(args, name), '--version'], env=env, capture_output=True, text=True, check=True)
        assert not result.stderr
        report['versions'][name] = result.stdout
    fwp_source = fixtures / 'returned_buffer_peer.fwp'
    original = folder / 'original.c'
    emitted = None
    try:
        run([args.compiler.resolve(), 'build', '--fn', 'buffer-functions', '--memory', 'dynamic', '--emit-c', '-O2',
             fwp_source, '-o', original], (0, '', ''), env)
        emitted = SOURCE.boundary(original.read_text())
    except Exception as error:
        failed('fwp emission/owned boundary', error)
    for length in LENGTHS:
        size = max(length, 0)
        expected = f'{size * (size - 1) // 2}\n'
        for raw in (False, True):
            try:
                report['interpreter'].append(run([args.compiler.resolve(), 'exec', '--interp',
                    fwp_source, 'buffer-check', length], (0, expected, ''), dict(env, FWP_NO_OPT='1') if raw else env))
            except Exception as error:
                failed(f'interpreter length={length} raw={raw}', error)

    def build(language, shared, level, variant):
        part = folder / f'{language}-{shared}-{level}-{variant}'
        part.mkdir()
        binary = part / 'program'
        diagnostic = variant in ('release-observed', 'omitted-release')
        cflags = ['-std=gnu11', f'-O{level}', '-fno-lto', '-march=' + args.c_arch,
                  '-I', fixtures, '-DBUFFER_SHARED=' + str(shared),
                  '-DBUFFER_DIAGNOSTIC=' + str(int(diagnostic)), '-DRETURNED_FWP=' + str(int(language == 'fwp'))]
        if language in ('c', 'fwp'):
            source = emitted if language == 'fwp' else (fixtures / 'returned_buffer_peer.c').read_text()
            if variant == 'wrong-scan':
                if language == 'fwp':
                    source = SOURCE.replace_once(source, '(&value);\n}\nvoid returned_buffer_release',
                                                 '(&value) + 1;\n}\nvoid returned_buffer_release')
                else:
                    source = SOURCE.replace_once(source, '    return sum;', '    return sum + 1;')
            factory = part / 'factory.c'
            factory.write_text(source)
            caller = part / 'caller.c'
            source = (fixtures / 'returned_buffer_caller.c').read_text()
            if variant == 'omitted-release':
                source = SOURCE.replace_once(source, '        returned_buffer_release(first);', '')
            caller.write_text(source)
            warnings = ['-w'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']
            run([args.cc, *cflags, *warnings, '-c', factory, '-o', part / 'factory.o'], (0, '', ''), env)
            run([args.cc, *cflags, '-Wall', '-Wextra', '-Werror', '-c', caller, '-o', part / 'caller.o'], (0, '', ''), env)
            run([args.cc, '-fno-lto', part / 'factory.o', part / 'caller.o', '-lm', '-lpthread', '-ldl', '-o', binary], (0, '', ''), env)
        elif language == 'rs':
            flags = ['--edition=2021', '-C', 'opt-level=' + str(level), '-C', 'overflow-checks=yes',
                     '-C', 'lto=off', '-C', 'embed-bitcode=no', '-C', 'target-cpu=' + args.rust_cpu,
                     '--target', args.target, '-D', 'warnings', '--check-cfg', 'cfg(buffer_shared)']
            if shared:
                flags += ['--cfg', 'buffer_shared']
            source = (fixtures / 'returned_buffer_peer.rs').read_text()
            if variant == 'wrong-scan':
                source = SOURCE.replace_once(source, '    sum\n}', '    sum + 1\n}')
            factory = part / 'factory.rs'
            factory.write_text(source)
            library = part / 'libreturned_buffer.rlib'
            run([args.rustc, *flags, '--crate-name', 'returned_buffer', '--crate-type', 'rlib', factory, '-o', library], (0, '', ''), env)
            run([args.rustc, *flags, fixtures / 'returned_buffer_caller.rs', '--extern', f'returned_buffer={library}', '-o', binary], (0, '', ''), env)
        else:
            flags = ['-swift-version', '6', '-target', args.target, '-warnings-as-errors',
                     *(['-Onone'] if level == 1 else ['-O', '-whole-module-optimization'])]
            if shared:
                flags += ['-D', 'BUFFER_SHARED']
            source = (fixtures / 'returned_buffer_peer.swift').read_text()
            if variant == 'wrong-scan':
                source = SOURCE.replace_once(source, '    return sum\n}', '    return sum + 1\n}')
            factory = part / 'factory.swift'
            factory.write_text(source)
            run([args.swiftc, *flags, '-parse-as-library', '-module-name', 'ReturnedBuffer', '-emit-module',
                 '-emit-module-path', part / 'ReturnedBuffer.swiftmodule', '-emit-object', factory, '-o', part / 'factory.o'], (0, '', ''), env)
            run([args.swiftc, *flags, '-I', part, fixtures / 'returned_buffer_caller.swift', part / 'factory.o', '-o', binary], (0, '', ''), env)
        report['builds'].append(dict(language=language, shared=shared, level=level, variant=variant,
                                     binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest()))
        return binary

    for language in ('c', 'rs', 'swift', 'fwp'):
        if language == 'fwp' and emitted is None:
            # The setup failure is retained and fails the final result. Native
            # C/Rust/Swift checks are independent and still need their results.
            continue
        for shared in (0, 1):
            for level in (1, 2):
                variants = ['ordinary', 'wrong-scan']
                if language in ('c', 'fwp'):
                    variants += ['release-observed', 'omitted-release']
                for variant in variants:
                    try:
                        binary = build(language, shared, level, variant)
                        if variant in ('ordinary', 'release-observed'):
                            for length in LENGTHS:
                                size = max(length, 0)
                                for repeats in ((1, 3) if variant == 'ordinary' else (3,)):
                                    expected = size * (size - 1) // 2 * (shared + 1) * repeats
                                    report['checks'].append(run([binary, length, repeats], (0, f'{expected}\n', ''), env))
                            if variant == 'ordinary':
                                for argv, diagnostic in INVALID:
                                    report['checks'].append(run([binary, *argv], (2, '', diagnostic + '\n'), env))
                        elif variant == 'wrong-scan':
                            report['checks'].append(run([binary, 16, 1], (4, '', 'incorrect result\n'), env))
                        else:
                            assert variant == 'omitted-release'
                            report['checks'].append(run([binary, 16, 1], (79, '', 'buffer release check failed\n'), env))
                    except Exception as error:
                        failed(f'{language} shared={shared} O{level} {variant}', error)
    report['files'] = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                       for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    assert not report['failures'], f'{len(report["failures"])} failed groups; see report.json and commands.jsonl'
    assert (len(report['builds']), len(report['checks']), len(report['interpreter'])) == (48, 528, 14)
    print(f'{len(report["builds"])} separate factory/caller builds, '
          f'{len(report["checks"])} native checks and {len(report["interpreter"])} interpreter checks pass')


if __name__ == '__main__':
    main()
