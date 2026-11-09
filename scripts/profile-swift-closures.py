#!/usr/bin/env python3
"""Attribute native allocations to the existing scalar Swift closure factory."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('allocation_profiles', ROOT / 'scripts/profile-swift-allocations.py')
PROFILES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILES)
INPUT = (4096, 256, 16)


def factory_costs(folder):
    return {cost: sum(value for stack, value in PROFILES.stacks((folder / (cost + '.stacks')).read_text())
                      if 'returnedMake' in stack) for cost in PROFILES.COSTS}


def check_release(ordinary, omitted):
    for row in (ordinary, omitted):
        assert set(row) == set(PROFILES.COSTS), row
        assert all(type(value) is int and value >= 0 for value in row.values()), row
    assert ordinary['allocations'] > 0, 'no scalar-factory allocation attributed'
    assert ordinary['leaked'] == 0, ordinary
    assert omitted['allocations'] == ordinary['allocations'], (ordinary, omitted)
    assert omitted['leaked'] > 0, 'omitted closure destruction was not observed'
    # These stack-attributed peaks are sampled at the whole-process heap peak,
    # not each stack's own peak; do not compare them as per-factory maxima.


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('source', 'arch', 'cc', 'swiftc', 'c-arch', 'target',
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
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no',
               LD_LIBRARY_PATH=str(args.unwind_library_directory.resolve()))

    def run(command):
        command = list(map(str, command))
        result = run_capture(command, env=env, cwd=None, input_data=None, input_stream=None,
                             text=True, encoding='utf-8', timeout=180, check=False)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(dict(command=command, status=result.returncode,
                                         stdout=result.stdout, stderr=result.stderr)) + '\n')
        assert result.returncode == 0, result
        return result

    def build(command):
        result = run(command)
        assert not result.stdout and not result.stderr, result

    def profile(binary, arguments, output, expected):
        output.mkdir()
        result = run([args.heaptrack, '-o', output / 'trace', binary, *arguments])
        numeric = ''.join(line + '\n' for line in result.stdout.splitlines() if line.isdecimal())
        assert numeric == expected, result
        trace, = output.glob('trace*')
        assert trace.stat().st_size > 0
        for cost in PROFILES.COSTS:
            result = run([args.heaptrack_print, '--file', trace, '--merge-backtraces', '0',
                          '--print-peaks', '1', '--print-allocators', '1', '--print-temporary', '1',
                          '--print-leaks', '1', '--peak-limit', '20', '--sub-peak-limit', '20',
                          '--flamegraph-cost-type', cost, '--print-flamegraph', output / (cost + '.stacks')])
            (output / (cost + '.txt')).write_text(result.stdout)
        return PROFILES.summarize(output)

    report = dict(source=args.source, architecture=args.arch, input=INPUT,
                  versions={name: run([getattr(args, name), '--version']).stdout
                            for name in ('cc', 'swiftc', 'heaptrack', 'heaptrack_print')},
                  host=platform.uname()._asdict(), cpu=run(['lscpu']).stdout,
                  settings={name: str(value) for name, value in vars(args).items()},
                  cases={}, scope='Scalar Swift closure native allocations, not timing or ARC-operation counts')
    cflags = ['-std=gnu11', '-O2', '-g', '-fno-lto', '-march=' + args.c_arch]
    swiftflags = ['-swift-version', '6', '-O', '-g', '-whole-module-optimization',
                  '-warnings-as-errors', '-target', args.target]
    unwind_source = folder / 'unwind.c'
    unwind_source.write_text(PROFILES.UNWIND_CONTROL)
    build([args.cc, *cflags, unwind_source, '-lunwind', '-o', folder / 'unwind'])
    observation = run([args.strace, '-o', folder / 'unwind.syscalls',
                       '-e', 'trace=process_vm_readv,pipe2,read,write,mincore', folder / 'unwind'])
    selected = args.unwind_library_directory.resolve() / 'libunwind.so.8'
    report['unwinding'] = dict(selectedLibrary=str(selected), selected=dict(
        observation=json.loads(observation.stdout), libraries=run(['ldd', folder / 'unwind']).stdout))
    PROFILES.check_unwinding(report['unwinding'])
    shutil.copyfile(selected, folder / 'libunwind.so.8')
    control = folder / 'control.c'
    control.write_text(PROFILES.CONTROL)
    build([args.cc, *cflags, control, '-o', folder / 'control'])
    ordinary = profile(folder / 'control', [], folder / 'control-release', '3\n')
    omitted = profile(folder / 'control', ['omit'], folder / 'control-omitted', '3\n')
    PROFILES.check_control(ordinary, omitted)
    report['controls'] = dict(release=ordinary, omitted=omitted)
    (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    for name in ('returned_callable_peer.swift', 'returned_callable_time.swift',
                 'callable_phase_clock.c', 'callable_phase_clock.h'):
        shutil.copyfile(ROOT / 'tests/fixtures' / name, folder / name)
    clock = folder / 'clock.o'
    build([args.cc, *cflags, '-c', folder / 'callable_phase_clock.c', '-o', clock])
    factory = folder / 'ReturnedCallable.o'
    build([args.swiftc, *swiftflags, '-parse-as-library', '-module-name', 'ReturnedCallable',
           '-emit-module', '-emit-module-path', folder / 'ReturnedCallable.swiftmodule',
           '-emit-object', folder / 'returned_callable_peer.swift', '-o', factory])
    original = (folder / 'returned_callable_time.swift').read_text()
    printed = 'print("\\(checksum) \\(construction) \\(invocation) \\(destruction)")'
    assert original.count(printed) == 1
    ordinary_source = original.replace(printed, 'print("\\(checksum)")')
    released = '    values.deinitialize(count: population)'
    assert ordinary_source.count(released) == 1
    omitted_source = ordinary_source.replace(released, '    // Deliberate control: leak the captured closure owners.')
    for variant, code in [('ordinary', ordinary_source), ('omitted', omitted_source)]:
        source = folder / (variant + '.swift')
        source.write_text(code)
        binary = folder / variant
        build([args.swiftc, *swiftflags, '-I', folder, '-import-objc-header',
               folder / 'callable_phase_clock.h', source, factory, clock, '-o', binary])
        for kind in (0, 1):
            population, cycles, passes = INPUT
            checksum = (kind + 1) * cycles * (passes * (population * (population - 1) // 2 + 7 * population)
                                            + population * passes * (passes - 1) // 2)
            arguments = [str(kind), *map(str, INPUT)]
            result = run([binary, *arguments])
            assert result.stdout == f'{checksum}\n' and not result.stderr, result
            profiles = []
            for sample in range(2):
                path = folder / f'{variant}-{kind}-{sample}'
                totals = profile(binary, arguments, path, f'{checksum}\n')
                profiles.append(dict(process=totals, factory=factory_costs(path)))
            report['cases'][f'{variant}-{kind}'] = dict(profiles=profiles, binarySha256=PROFILES.digest(binary))
            (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    for kind in (0, 1):
        for sample in range(2):
            check_release(report['cases'][f'ordinary-{kind}']['profiles'][sample]['factory'],
                          report['cases'][f'omitted-{kind}']['profiles'][sample]['factory'])
    # Reconstruct every accepted summary from the raw stacks before publishing.
    for variant in ('ordinary', 'omitted'):
        for kind in (0, 1):
            for sample, row in enumerate(report['cases'][f'{variant}-{kind}']['profiles']):
                path = folder / f'{variant}-{kind}-{sample}'
                assert row == dict(process=PROFILES.summarize(path), factory=factory_costs(path))
    manifest = {str(path.relative_to(folder)): PROFILES.digest(path)
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print('Two scalar closure kinds, two samples, actual release omissions and allocator/unwinder controls pass')


if __name__ == '__main__':
    main()
