#!/usr/bin/env python3
"""Measure native reference storage after explicit ownership lifetime prefixes."""
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
from weak_operation_build import build
from weak_operation_profiles import COSTS, GROUPS, LANGUAGES, POPULATIONS, allocation_kind, check_stages, decode_output

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
    assert actual == manifest, 'changed or missing weak storage evidence'
    report = json.loads((folder / 'report.json').read_text())
    assert report['source'] == source and report['architecture'] == arch and not report['failures']
    assert report['populations'] == list(POPULATIONS) and len(report['cases']) == 3
    for fixture in (folder / 'fixtures').iterdir():
        original = subprocess.check_output(['git', 'show', source + ':tests/fixtures/' + fixture.name], cwd=ROOT)
        assert fixture.read_bytes() == original, 'changed weak storage fixture: ' + fixture.name
    PROFILES.check_unwinding(report['unwinding'])
    controls = {name: PROFILES.summarize(folder / ('control-' + name)) for name in ('ordinary', 'omitted')}
    assert controls == report['controls']
    PROFILES.check_control(controls['ordinary'], controls['omitted'])
    commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    assert all(row['status'] == 0 for row in commands), 'failed command in completed profile batch'
    for language in LANGUAGES:
        case = report['cases'][language]
        image = (folder / f'{language}-2-ordinary/program').read_bytes()
        assert image[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[arch]
        assert hashlib.sha256(image).hexdigest() == case['build']['binarySha256']
        assert len(case['ordinary']) == 8
        expected_binary = case['build']['link'][-1]
        for index, (population, stage) in zip(case['ordinary'], ((p, s) for p in POPULATIONS for s in range(4))):
            command = commands[index]
            assert command['command'] == [expected_binary, str(population), str(stage)]
            assert command['stderr'] == ''
            decode_output(command['stdout'], population, stage)
        assert len(case['profiles']) == 16
        keys = {(row['population'], row['stage'], row['sample']) for row in case['profiles']}
        assert keys == {(population, stage, sample) for population in POPULATIONS for stage in range(4) for sample in range(2)}
        for row in case['profiles']:
            directory = folder / f"{language}-p{row['population']}-stage{row['stage']}-sample{row['sample']}"
            assert row['factory'] == factory_costs(directory, language)
            assert row['process'] == PROFILES.summarize(directory)
            command = commands[row['command']]
            output = ''.join(line + '\n' for line in command['stdout'].splitlines() if line.startswith('{'))
            decode_output(output, row['population'], row['stage'])
            assert command['command'][-3:] == [expected_binary, str(row['population']), str(row['stage'])]
        for population in POPULATIONS:
            for sample in range(2):
                stages = [next(row['factory'] for row in case['profiles']
                               if (row['population'], row['stage'], row['sample']) == (population, stage, sample))
                          for stage in range(4)]
                check_stages(stages, language, population)
    print('48 native weak-storage profiles reconstruct from retained raw stacks and pass staged release controls')


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
    for path in (ROOT / 'tests/fixtures').glob('weak_operation_*'):
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
        return row, PROFILES.summarize(output)

    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  populations=POPULATIONS, settings={key: str(value) for key, value in vars(args).items()},
                  scope='Native allocator calls and retained bytes, not timing, ARC operations, RSS or fwp managed storage',
                  versions={}, cases={}, failures=[])

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

    save()
    for tool in ('cc', 'ar', 'rustc', 'swiftc', 'heaptrack', 'heaptrack_print'):
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
        try:
            binary, metadata = build(args, folder, fixtures, None, run, env, language, 2, 'ordinary', 'profiles', None)
            case = report['cases'][language] = dict(build=metadata, ordinary=[], profiles=[])
        except Exception as error:
            failure('build ' + language, error)
            continue
        for population in POPULATIONS:
            for stage in range(4):
                label = f'{language}-p{population}-stage{stage}'
                try:
                    row = run([binary, population, stage], (0, None, ''), env)
                    decode_output(row['stdout'], population, stage)
                    case['ordinary'].append(row['index'])
                except Exception as error:
                    failure(label + ' ordinary', error)
                    continue
                for sample in range(2):
                    try:
                        directory = folder / f'{label}-sample{sample}'
                        row, totals = profile(binary, [population, stage], directory)
                        output = ''.join(line + '\n' for line in row['stdout'].splitlines() if line.startswith('{'))
                        decode_output(output, population, stage)
                        case['profiles'].append(dict(population=population, stage=stage, sample=sample,
                                                     command=row['index'], process=totals,
                                                     factory=factory_costs(directory, language)))
                        save()
                    except Exception as error:
                        failure(f'{label}-sample{sample}', error)
            for sample in range(2):
                try:
                    stages = [next(row['factory'] for row in case['profiles']
                                   if (row['population'], row['stage'], row['sample']) == (population, stage, sample))
                              for stage in range(4)]
                    check_stages(stages, language, population)
                except Exception as error:
                    failure(f'{language}-p{population}-sample{sample} release evidence', error)
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
    for name in ('source', 'arch', 'cc', 'ar', 'rustc', 'swiftc', 'c-arch', 'rust-cpu', 'target',
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
