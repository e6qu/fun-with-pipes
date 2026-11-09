#!/usr/bin/env python3
"""Observe native queued-service allocations, peak attribution and actual release."""
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
from weak_callback_service import CASES, decode_missing_delivery, decode_output, variants
from weak_callback_service_build import build_native
from weak_callback_profiles import COSTS, GROUPS, LANGUAGES, allocation_kind, check_costs, decode_case, decode_profiler_status

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('allocation_profiles', ROOT / 'scripts/profile-swift-allocations.py')
PROFILES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILES)


def factory_costs(directory, language):
    result = {group: {cost: 0 for cost in COSTS} for group in GROUPS}
    for cost in COSTS:
        for stack, value in PROFILES.stacks((directory / (cost + '.stacks')).read_text()):
            group = allocation_kind(stack, language)
            if group != 'outside':
                result[group][cost] += value
    return result


def audit(folder, source, arch):
    manifest = json.loads((folder / 'manifest.json').read_text())
    actual = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
              for path in folder.rglob('*') if path.is_file() and path.name != 'manifest.json'}
    assert actual == manifest, 'changed or missing service storage evidence'
    report = json.loads((folder / 'report.json').read_text())
    assert report['source'] == source and report['architecture'] == arch and not report['failures']
    assert report['cases'] and len(report['cases']) == 5
    for fixture in (folder / 'fixtures').iterdir():
        original = subprocess.check_output(['git', 'show', source + ':tests/fixtures/' + fixture.name], cwd=ROOT)
        assert fixture.read_bytes() == original, 'changed service fixture: ' + fixture.name
    PROFILES.check_unwinding(report['unwinding'])
    controls = {name: PROFILES.summarize(folder / ('control-' + name)) for name in ('ordinary', 'omitted')}
    assert controls == report['controls']
    PROFILES.check_control(controls['ordinary'], controls['omitted'])
    commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    assert all(row['status'] in (0, 2, 79) for row in commands)
    expected_diagnostics = {(language, variant, level) for language in LANGUAGES
                            for variant in variants(language, (folder / 'fixtures' / ('weak_callback_service.' + language)).read_text())
                            for level in (1, 2)}
    assert len(report['diagnostics']) == len(expected_diagnostics) == 16
    assert {(row['language'], row['variant'], row['level']) for row in report['diagnostics']} == expected_diagnostics
    for observation in report['diagnostics']:
        row = commands[observation['command']]
        if observation['variant'].startswith('omitted-'):
            assert (row['status'], row['stdout'], row['stderr']) == (79, '', 'service storage not released\n')
        else:
            assert row['status'] == 0 and row['stderr'] == ''
            (decode_missing_delivery if observation['variant'] == 'missing-delivery' else decode_output)(row['stdout'])
    expected_cases = {(language, variant) for language in LANGUAGES for variant in
                      (('ordinary', 'omitted-payload-release', 'omitted-registration-release') if language == 'c' else ('ordinary',))}
    assert {(case['language'], case['variant']) for case in report['cases'].values()} == expected_cases
    for case in report['cases'].values():
        language, variant = case['language'], case['variant']
        binary = case['binary']
        image = (folder / f'{language}-{variant}-2-plain/program').read_bytes()
        assert image[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[arch]
        assert hashlib.sha256(image).hexdigest() == case['binarySha256']
        assert len(case['ordinary']) == 8 and len(case['profiles']) == 16
        for index, (population, mode) in zip(case['ordinary'], CASES):
            row = commands[index]
            assert row['command'] == [binary, str(population), str(mode)] and row['status'] == 0 and row['stderr'] == ''
            decode_case(row['stdout'], population, mode)
        assert {(row['population'], row['mode'], row['sample']) for row in case['profiles']} == {
            (population, mode, sample) for population, mode in CASES for sample in range(2)}
        for observation in case['profiles']:
            population, mode, sample = (observation[key] for key in ('population', 'mode', 'sample'))
            directory = folder / f'{language}-{variant}-p{population}-mode{mode}-sample{sample}'
            costs = factory_costs(directory, language)
            assert observation['factory'] == costs
            assert observation['process'] == PROFILES.summarize(directory)
            check_costs(costs, language, population, variant)
            row = commands[observation['command']]
            assert row['status'] == 0 and row['command'][-3:] == [binary, str(population), str(mode)]
            decode_case(''.join(line + '\n' for line in row['stdout'].splitlines() if line.startswith('{')), population, mode)
    print('80 service profiles reconstruct from raw stacks; actual omitted releases are detected')


def collect(args):
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.source == os.environ['GITHUB_SHA']
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    fixtures = folder / 'fixtures'
    fixtures.mkdir()
    for path in (ROOT / 'tests/fixtures').glob('weak_callback_service*'):
        shutil.copyfile(path, fixtures / path.name)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no', RUST_BACKTRACE='0')
    profile_env = dict(env, LD_LIBRARY_PATH=str(args.unwind_library_directory.resolve()))
    commands = []

    def run(command, expected, environment):
        command = list(map(str, command))
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=180, check=False)
        except subprocess.TimeoutExpired as error:
            stdout, stderr = error.stdout or b'', error.stderr or b''
            row = dict(status=None, timedOut=True,
                       stdout=stdout.decode('utf-8', errors='replace') if isinstance(stdout, bytes) else stdout,
                       stderr=stderr.decode('utf-8', errors='replace') if isinstance(stderr, bytes) else stderr)
        else:
            row = dict(status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        row.update(command=command, index=len(commands), libraryPath=environment.get('LD_LIBRARY_PATH'))
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0], row
        assert expected[1] is None or row['stdout'] == expected[1], row
        assert expected[2] is None or row['stderr'] == expected[2], row
        return row

    def profile(binary, arguments, output):
        output.mkdir()
        row = run([args.heaptrack, '-o', output / 'trace', binary, *arguments], (0, None, None), profile_env)
        trace, = output.glob('trace*')
        assert trace.stat().st_size > 0
        for cost in COSTS:
            result = run([args.heaptrack_print, '--file', trace, '--merge-backtraces', '0',
                          '--print-peaks', '1', '--print-allocators', '1', '--print-temporary', '1',
                          '--print-leaks', '1', '--peak-limit', '20', '--sub-peak-limit', '20',
                          '--flamegraph-cost-type', cost, '--print-flamegraph', output / (cost + '.stacks')],
                         (0, None, None), profile_env)
            (output / (cost + '.txt')).write_text(result['stdout'])
        totals = PROFILES.summarize(output)
        decode_profiler_status(row['stderr'], totals['totals']['allocations'])
        return row, totals

    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  settings={key: str(value) for key, value in vars(args).items()},
                  scope='Native allocator calls and retained bytes, not timing, ARC operations, RSS or fwp managed storage',
                  versions={}, cases={}, diagnostics=[], failures=[])

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

    save()
    for tool in ('cc', 'rustc', 'swiftc', 'heaptrack', 'heaptrack_print'):
        report['versions'][tool] = run([getattr(args, tool), '--version'], (0, None, ''), env)['stdout']
    report['cpu'] = run(['lscpu'], (0, None, ''), env)['stdout']
    flags = [args.cc, '-std=gnu11', '-O2', '-g', '-ffp-contract=off', '-fno-lto', '-march=' + args.c_arch]
    unwind = folder / 'unwind.c'
    unwind.write_text(PROFILES.UNWIND_CONTROL)
    run([*flags, unwind, '-lunwind', '-o', folder / 'unwind'], (0, '', ''), env)
    row = run([args.strace, '-o', folder / 'unwind.syscalls', '-e', 'trace=process_vm_readv,pipe2,read,write,mincore',
               folder / 'unwind'], (0, None, ''), profile_env)
    library = args.unwind_library_directory.resolve() / 'libunwind.so.8'
    shutil.copyfile(library, folder / 'libunwind.so.8')
    report['unwinding'] = dict(selectedLibrary=str(library), selected=dict(observation=json.loads(row['stdout']),
        libraries=run(['ldd', folder / 'unwind'], (0, None, ''), profile_env)['stdout']))
    save()
    PROFILES.check_unwinding(report['unwinding'])
    control = folder / 'control.c'
    control.write_text(PROFILES.CONTROL)
    run([*flags, control, '-o', folder / 'control'], (0, '', ''), env)
    report['controls'] = {}
    for variant, arguments in (('ordinary', []), ('omitted', ['omit'])):
        row, observation = profile(folder / 'control', arguments, folder / ('control-' + variant))
        assert ''.join(line + '\n' for line in row['stdout'].splitlines() if line.isdecimal()) == '3\n'
        report['controls'][variant] = observation
        save()
    PROFILES.check_control(report['controls']['ordinary'], report['controls']['omitted'])
    for language in LANGUAGES:
        source = (fixtures / ('weak_callback_service.' + language)).read_text()
        caller = (fixtures / ('weak_callback_service_check.' + language)).read_text()
        for variant, code in variants(language, source).items():
            for level in (1, 2):
                try:
                    binary, _ = build_native(args, folder, language, code, variant, level, 'diagnostic', False, None, caller, run, env)
                    omitted = variant.startswith('omitted-')
                    row = run([binary], (79, '', 'service storage not released\n') if omitted else (0, None, ''), env)
                    if not omitted:
                        (decode_missing_delivery if variant == 'missing-delivery' else decode_output)(row['stdout'])
                    report['diagnostics'].append(dict(language=language, variant=variant, level=level, command=row['index']))
                    save()
                except Exception as error:
                    failure(f'diagnostic {language}/{variant}/O{level}', error)
    for language in LANGUAGES:
        original = (fixtures / ('weak_callback_service.' + language)).read_text()
        caller = (fixtures / ('weak_callback_service_profile.' + language)).read_text()
        sources = variants(language, original) if language == 'c' else {'ordinary': original}
        for variant, source in sources.items():
            if variant == 'missing-delivery':
                continue
            label = language + '-' + variant
            try:
                binary, linked = build_native(args, folder, language, source, variant, 2, 'plain', True, None, caller, run, env)
                image = binary.read_bytes()
                assert image[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
                case = report['cases'][label] = dict(language=language, variant=variant, binary=str(binary),
                    binarySha256=hashlib.sha256(image).hexdigest(), link=linked['index'], ordinary=[], profiles=[])
                for arguments in ([], ['64'], ['64', '4'], ['65', '0'], ['+64', '0'], ['64', '0', 'extra']):
                    run([binary, *arguments], (2, '', 'expected population 64|4096 and mode 0|1|2|3\n'), env)
            except Exception as error:
                failure('build ' + label, error)
                continue
            for population, mode in CASES:
                try:
                    row = run([binary, population, mode], (0, None, ''), env)
                    decode_case(row['stdout'], population, mode)
                    case['ordinary'].append(row['index'])
                except Exception as error:
                    failure(f'{label} {population}/{mode} ordinary', error)
                    continue
                for sample in range(2):
                    try:
                        directory = folder / f'{label}-p{population}-mode{mode}-sample{sample}'
                        row, totals = profile(binary, [population, mode], directory)
                        output = ''.join(line + '\n' for line in row['stdout'].splitlines() if line.startswith('{'))
                        decode_case(output, population, mode)
                        costs = factory_costs(directory, language)
                        case['profiles'].append(dict(population=population, mode=mode, sample=sample,
                            command=row['index'], process=totals, factory=costs))
                        save()
                        check_costs(costs, language, population, variant)
                    except Exception as error:
                        failure(f'{label} {population}/{mode} sample={sample}', error)
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    audit(folder, args.source, args.arch)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    modes = parser.add_subparsers(dest='mode', required=True)
    collecting = modes.add_parser('collect')
    for name in ('source', 'arch', 'cc', 'rustc', 'swiftc', 'c-arch', 'rust-cpu', 'target',
                 'heaptrack', 'heaptrack-print', 'strace'):
        collecting.add_argument('--' + name, required=True)
    collecting.add_argument('--unwind-library-directory', type=Path, required=True)
    collecting.add_argument('--output', type=Path, required=True)
    auditing = modes.add_parser('audit')
    auditing.add_argument('--input', type=Path, required=True)
    auditing.add_argument('--source', required=True)
    auditing.add_argument('--arch', required=True, choices=('aarch64', 'x86_64'))
    args = parser.parse_args()
    if args.mode == 'collect':
        collect(args)
    else:
        audit(args.input.resolve(), args.source, args.arch)


if __name__ == '__main__':
    main()
