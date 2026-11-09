#!/usr/bin/env python3
"""Observe native C/Rust/Swift buffer storage and actual first/last release omissions."""
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
from returned_buffer_build import build
from returned_buffer_phases import decode_output
from returned_buffer_profiles import INPUTS, LANGUAGES, allocation_kind, check_release, omit_release
from returned_buffer_source import replace_once

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('allocation_profiles', ROOT / 'scripts/profile-swift-allocations.py')
PROFILES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILES)


def factory_costs(directory, language):
    result = {kind: {cost: 0 for cost in PROFILES.COSTS} for kind in ('storage', 'metadata', 'total')}
    for cost in PROFILES.COSTS:
        for stack, value in PROFILES.stacks((directory / (cost + '.stacks')).read_text()):
            kind = allocation_kind(stack, language)
            if kind != 'outside':
                result[kind][cost] += value
                result['total'][cost] += value
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('source', 'arch', 'cc', 'ar', 'rustc', 'swiftc', 'c-arch', 'rust-cpu', 'target',
                 'heaptrack', 'heaptrack-print', 'strace'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--unwind-library-directory', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.source == os.environ['GITHUB_SHA']
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no')
    profile_env = dict(env, LD_LIBRARY_PATH=str(args.unwind_library_directory.resolve()))

    def run(command, expected, environment):
        command = list(map(str, command))
        result = run_capture(command, env=environment, cwd=None, input_data=None, input_stream=None,
                             text=True, encoding='utf-8', timeout=180, check=False)
        row = dict(command=command, libraryPath=environment.get('LD_LIBRARY_PATH'), status=result.returncode,
                   stdout=result.stdout, stderr=result.stderr)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert result.returncode == expected[0], row
        assert expected[1] is None or result.stdout == expected[1], row
        assert expected[2] is None or result.stderr == expected[2], row
        return row

    def profile(binary, arguments, output):
        output.mkdir()
        result = run([args.heaptrack, '-o', output / 'trace', binary, *arguments], (0, None, None), profile_env)
        trace, = output.glob('trace*')
        assert trace.stat().st_size > 0
        for cost in PROFILES.COSTS:
            row = run([args.heaptrack_print, '--file', trace, '--merge-backtraces', '0',
                       '--print-peaks', '1', '--print-allocators', '1', '--print-temporary', '1',
                       '--print-leaks', '1', '--peak-limit', '20', '--sub-peak-limit', '20',
                       '--flamegraph-cost-type', cost, '--print-flamegraph', output / (cost + '.stacks')],
                      (0, None, None), profile_env)
            (output / (cost + '.txt')).write_text(row['stdout'])
        return result, PROFILES.summarize(output)

    report = dict(source=args.source, architecture=args.arch, inputs=INPUTS, host=platform.uname()._asdict(),
                  cpu=run(['lscpu'], (0, None, ''), env)['stdout'],
                  settings={key: str(value) for key, value in vars(args).items()},
                  versions={name: run([getattr(args, name), '--version'], (0, None, ''), env)['stdout']
                            for name in ('cc', 'ar', 'rustc', 'swiftc', 'heaptrack', 'heaptrack_print')},
                  cases={}, failures=[],
                  scope='Native allocator traffic and release, not timing, ARC counts or fwp managed storage')

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    flags = [args.cc, '-std=gnu11', '-O2', '-g', '-fno-lto', '-march=' + args.c_arch]
    unwind = folder / 'unwind.c'
    unwind.write_text(PROFILES.UNWIND_CONTROL)
    run([*flags, unwind, '-lunwind', '-o', folder / 'unwind'], (0, '', ''), env)
    row = run([args.strace, '-o', folder / 'unwind.syscalls',
               '-e', 'trace=process_vm_readv,pipe2,read,write,mincore', folder / 'unwind'], (0, None, ''), profile_env)
    library = args.unwind_library_directory.resolve() / 'libunwind.so.8'
    shutil.copyfile(library, folder / 'libunwind.so.8')
    report['unwinding'] = dict(selectedLibrary=str(library), selected=dict(
        observation=json.loads(row['stdout']), libraries=run(['ldd', folder / 'unwind'], (0, None, ''), profile_env)['stdout']))
    save()
    PROFILES.check_unwinding(report['unwinding'])
    control = folder / 'control.c'
    control.write_text(PROFILES.CONTROL)
    run([*flags, control, '-o', folder / 'control'], (0, '', ''), env)
    report['controls'] = {}
    for variant, arguments in [('ordinary', []), ('omitted', ['omit'])]:
        row, observation = profile(folder / 'control', arguments, folder / ('control-' + variant))
        assert ''.join(line + '\n' for line in row['stdout'].splitlines() if line.isdecimal()) == '3\n', row
        report['controls'][variant] = observation
    save()
    PROFILES.check_control(report['controls']['ordinary'], report['controls']['omitted'])
    clock = folder / 'clock.o'
    run([*flags, '-c', ROOT / 'tests/fixtures/callable_phase_clock.c', '-o', clock], (0, '', ''), env)

    for language in LANGUAGES:
        for shared in (0, 1):
            variants = ('ordinary', 'omit-first', 'omit-last') if shared else ('ordinary', 'omit-first')
            for variant in variants:
                label = f'{language}-{shared}-{variant}'
                try:
                    part = folder / label
                    part.mkdir()
                    fixtures = part / 'fixtures'
                    fixtures.mkdir()
                    for pattern in ('returned_buffer_*', 'callable_phase_clock.*'):
                        for path in (ROOT / 'tests/fixtures').glob(pattern):
                            shutil.copyfile(path, fixtures / path.name)
                    if variant != 'ordinary':
                        caller = fixtures / ('returned_buffer_time.' + language)
                        caller.write_text(omit_release(caller.read_text(), language,
                                                      'first' if variant == 'omit-first' else 'second'))
                        if language == 'rs' and not shared:
                            # The deliberately omitted sole release leaves this import unused.
                            caller.write_text(replace_once(caller.read_text(), '{make, release, scan, Buffer}', '{make, scan, Buffer}'))
                    binary, metadata = build(args, part, fixtures, None, run, env, language, shared, 2,
                                             'ordinary', 'profiles', clock)
                    case = report['cases'][label] = dict(build=metadata, profiles=[])
                    for length, population, batches in INPUTS:
                        arguments = [length, population, batches]
                        # Check the uninstrumented executable as well as profiler output.
                        row = run([binary, *arguments], (0, None, ''), env)
                        decode_output(row['stdout'], length, population, batches, shared)
                        for sample in range(2):
                            output = part / f'profile-{length}-{sample}'
                            row, totals = profile(binary, arguments, output)
                            text = ''.join(line + '\n' for line in row['stdout'].splitlines() if line.startswith('{'))
                            decode_output(text, length, population, batches, shared)
                            case['profiles'].append(dict(length=length, sample=sample, process=totals,
                                                         factory=factory_costs(output, language)))
                            save()
                except Exception as error:
                    report['failures'].append(dict(group=label, error=str(error), traceback=traceback.format_exc()))
                    print(label, error, flush=True)
                    save()
            try:
                ordinary = report['cases'][f'{language}-{shared}-ordinary']['profiles']
                assert len(ordinary) == 4
                for variant in variants[1:]:
                    omitted = report['cases'][f'{language}-{shared}-{variant}']['profiles']
                    assert len(omitted) == 4
                    for before, after in zip(ordinary, omitted):
                        assert (before['length'], before['sample']) == (after['length'], after['sample'])
                        check_release(before['factory']['storage'], after['factory']['storage'], before['length'], 4096, 16)
                        # Keep one-time native metadata visible and require the
                        # same work in ordinary and omitted-release controls.
                        for cost in ('allocations', 'leaked'):
                            assert before['factory']['metadata'][cost] == after['factory']['metadata'][cost]
            except Exception as error:
                report['failures'].append(dict(group=f'{language}-{shared} release evidence', error=str(error),
                                               traceback=traceback.format_exc()))
                print(language, shared, 'release evidence', error, flush=True)
                save()
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['cases']) == 15 and sum(len(row['profiles']) for row in report['cases'].values()) == 60
    print('Sixty native buffer profiles verify ordinary release and actual first/last owner omissions')


if __name__ == '__main__':
    main()
