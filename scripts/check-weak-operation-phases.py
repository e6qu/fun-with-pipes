#!/usr/bin/env python3
"""Verify separate weak-operation phases and actual bad-result/release/clock builds."""
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
from weak_operation_phases import PHASES, decode_output
from weak_operation_source import boundary

ROOT = Path(__file__).resolve().parent.parent
INVALID = (([], 'expected population lookups batches'), (['1', '1'], 'expected population lookups batches'),
           (['1junk', '1', '1'], 'invalid integer'), (['1', '-1', '1'], 'invalid integer'),
           (['1', '1', '9223372036854775808'], 'invalid integer'), (['1', ' 1', '1'], 'invalid integer'),
           (['0', '1', '1'], 'invalid experiment arguments'), (['2', '1', '1'], 'invalid experiment arguments'),
           (['1', '2', '1'], 'invalid experiment arguments'), (['1', '1', '2'], 'invalid experiment arguments'))


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'ar', 'rustc', 'swiftc', 'source', 'arch', 'c-arch', 'rust-cpu', 'target'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--compiler', type=Path, required=True)
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
    for pattern in ('weak_operation_*', 'callable_phase_clock.*'):
        for path in (ROOT / 'tests/fixtures').glob(pattern):
            shutil.copyfile(path, fixtures / path.name)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    environment.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no', RUST_BACKTRACE='0', CC=args.cc, FWP_LTO='0', FWP_STACK='1')
    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  compilerSha256=hashlib.sha256(args.compiler.read_bytes()).hexdigest(),
                  settings={key: str(value) for key, value in vars(args).items()},
                  scope='Phase correctness, not a peer timing comparison or native allocator/ARC observation',
                  versions={}, builds=[], checks=[], interpreter=[], failures=[])
    commands = []

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def run(command, expected, env):
        command = list(map(str, command))
        try:
            result = run_capture(command, env=env, cwd=ROOT, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=120, check=False)
        except subprocess.TimeoutExpired as error:
            stdout, stderr = error.stdout or b'', error.stderr or b''
            row = dict(command=command, status=None, timedOut=True,
                       stdout=stdout.decode('utf-8', errors='replace') if isinstance(stdout, bytes) else stdout,
                       stderr=stderr.decode('utf-8', errors='replace') if isinstance(stderr, bytes) else stderr)
        else:
            row = dict(command=command, status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        row['index'] = len(commands)
        row['fwpNoOpt'] = env.get('FWP_NO_OPT')
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0] and row['stderr'] == expected[2], row
        assert expected[1] is None or row['stdout'] == expected[1], row
        return row

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

    for tool in ('cc', 'ar', 'rustc', 'swiftc'):
        report['versions'][tool] = run([getattr(args, tool), '--version'], (0, None, ''), environment)['stdout']
    clock = folder / 'clock.o'
    backward = folder / 'backward.o'
    bad_source = folder / 'backward.c'
    bad_source.write_text('#include <stdint.h>\nuint64_t callable_phase_clock(void) {\n'
                          'static uint64_t value = UINT64_MAX; return value--;\n}\n')
    flags = [args.cc, '-std=c11', '-O2', '-ffp-contract=off', '-fno-lto', '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror']
    run([*flags, '-c', fixtures / 'callable_phase_clock.c', '-o', clock], (0, '', ''), environment)
    run([*flags, '-c', bad_source, '-o', backward], (0, '', ''), environment)
    source = fixtures / 'weak_operation_peer.fwp'
    original = folder / 'original.c'
    emitted = None
    try:
        run([args.compiler.resolve(), 'build', '--fn', 'reference-functions', '--memory', 'dynamic', '--emit-c', '-O2',
             source, '-o', original], (0, '', ''), environment)
        emitted = boundary(original.read_text())
    except Exception as error:
        failure('fwp entry preparation', error)
    program = folder / 'check.fwp'
    program.write_text(source.read_text() + '\nmain = reference-check () | echo\n')
    for raw in (True, False):
        try:
            row = run([args.compiler.resolve(), 'run', '--interp', program], (0, '(True, False)\n', ''),
                      environment | {'FWP_NO_OPT': '1'} if raw else environment)
            report['interpreter'].append(row['index'])
        except Exception as error:
            failure('interpreter raw=' + str(raw), error)
    for language in ('c', 'rs', 'swift', 'fwp'):
        if language == 'fwp' and emitted is None:
            continue
        for level in (1, 2):
            variants = ['ordinary', 'wrong-lookup', 'backward-clock']
            if language in ('c', 'fwp'):
                variants += ['release-observed', 'omit-owner', 'omit-weak']
            for variant in variants:
                group = f'{language} O{level} {variant}'
                try:
                    binary, metadata = build(args, folder, fixtures, emitted, run, environment, language, level,
                                             variant, 'phases', backward if variant == 'backward-clock' else clock)
                    report['builds'].append(metadata)
                except Exception as error:
                    failure('build ' + group, error)
                    continue
                cases = []
                if variant == 'ordinary':
                    cases = [(p, n, b) for p in (1, 64, 4096) for n in (1, 16, 64) for b in (1, 16)]
                elif variant == 'release-observed':
                    cases = [(64, 16, 16)]
                for population, lookups, batches in cases:
                    try:
                        row = run([binary, population, lookups, batches], (0, None, ''), environment)
                        decode_output(row['stdout'], population, lookups, batches)
                        report['checks'].append(row['index'])
                    except Exception as error:
                        failure(f'{group} {population}/{lookups}/{batches}', error)
                failures = {'wrong-lookup': (4, 'incorrect result\n'), 'backward-clock': (77, 'clock moved backwards\n'),
                            'omit-owner': (79, 'reference release check failed\n'), 'omit-weak': (79, 'reference release check failed\n')}
                if variant in failures:
                    try:
                        status, diagnostic = failures[variant]
                        row = run([binary, 64, 16, 1], (status, '', diagnostic), environment)
                        report['checks'].append(row['index'])
                    except Exception as error:
                        failure(group, error)
                if variant == 'ordinary':
                    for arguments, diagnostic in INVALID:
                        try:
                            row = run([binary, *arguments], (2, '', diagnostic + '\n'), environment)
                            report['checks'].append(row['index'])
                        except Exception as error:
                            failure(group + ' invalid ' + repr(arguments), error)
                save()
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert (len(report['builds']), len(report['checks']), len(report['interpreter'])) == (36, 252, 2)
    print('36 separate-module builds, 252 native phase/fault/argument checks and two interpreter checks pass')


if __name__ == '__main__':
    main()
