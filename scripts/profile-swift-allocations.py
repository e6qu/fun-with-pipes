#!/usr/bin/env python3
"""Profile allocator traffic for four-language peers; never treat profile time as a benchmark."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import struct
import subprocess

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('iteration_profile', ROOT / 'scripts/measure-iteration.py')
PROFILE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROFILE)
LANGUAGES = ('c', 'rs', 'swift', 'fwp')
PROGRAMS = ('pipeline', 'map')
COSTS = ('allocations', 'peak', 'leaked')
CONTROL = r'''
#include <stdlib.h>
#include <stdio.h>
static volatile size_t control_size = 1048576;
__attribute__((noinline)) void *allocate_control(size_t index) {
    volatile unsigned char *p = malloc(control_size + index);
    if (!p) abort();
    p[0] = (unsigned char)index;
    return (void *)p;
}
int main(int argc, char **argv) {
    (void)argv;
    void *p[3];
    unsigned sum = 0;
    for(size_t i=0;i<3;i++) p[i]=allocate_control(i);
    for(size_t i=0;i<3;i++) sum+=*(volatile unsigned char *)p[i];
    for(size_t i=0;i<3;i++) if(argc==1 || i!=2) free(p[i]);
    printf("%u\n",sum);
    return 0;
}
'''
UNWIND_CONTROL = r'''
#define UNW_LOCAL_ONLY
#include <libunwind.h>
#include <stdio.h>
#include <unistd.h>
__attribute__((noinline)) int capture_control(void) {
    void *frames[64];
    int count = unw_backtrace(frames, 64);
    unw_context_t context;
    unw_cursor_t cursor;
    int context_status = unw_getcontext(&context);
    int init_status = unw_init_local(&cursor, &context);
    int steps = 0, status = init_status;
    if (!context_status && !init_status)
        while ((status = unw_step(&cursor)) > 0 && steps < 64) steps++;
    printf("{\"frames\":%d,\"steps\":%d,\"stepStatus\":%d,\"contextStatus\":%d,\"initStatus\":%d,\"pageBytes\":%ld}\n",
           count, steps, status, context_status, init_status, sysconf(_SC_PAGESIZE));
    return count;
}
__attribute__((noinline)) int caller_control(void) {
    int count = capture_control();
    return count + 1;
}
int main(void) { return caller_control() < 0; }
'''


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def stacks(text):
    rows = []
    for line in text.splitlines():
        stack, count = line.rsplit(' ', 1)
        assert stack and re.fullmatch(r'[0-9]+', count), line
        rows.append([stack, int(count)])
    assert rows, 'empty allocation profile'
    return rows


def summarize(folder):
    values = {cost: stacks((folder / (cost + '.stacks')).read_text()) for cost in COSTS}
    text = (folder / 'allocations.txt').read_text()
    matches = re.findall(r'^calls to allocation functions: ([0-9]+) \(', text, re.M)
    assert len(matches) == 1, 'missing/duplicate heaptrack allocation total'
    totals = {cost: sum(value for _, value in rows) for cost, rows in values.items()}
    assert totals['allocations'] == int(matches[0]), 'stack/summary count disagreement'
    assert totals['allocations'] > 0 and totals['peak'] > 0
    return dict(totals=totals, control={cost: sum(value for stack, value in rows if 'allocate_control' in stack)
                                      for cost, rows in values.items()},
                topAllocationStacks=sorted(values['allocations'], key=lambda row: (-row[1], row[0]))[:10],
                scope='Native allocation calls; peak is bytes live at the global heap peak. Not managed-object or ARC operation counts.')


def check_control(ordinary, omitted):
    for result in (ordinary, omitted):
        assert result['control']['allocations'] == 3, result
        assert result['control']['peak'] == 3 * 1048576 + 3, result
    assert ordinary['control']['leaked'] == 0, ordinary
    assert omitted['control']['leaked'] == 1048578, omitted


def check_unwinding(record):
    observation = record['selected']['observation']
    assert observation['frames'] >= 3 and observation['steps'] >= 2, observation
    assert observation['stepStatus'] == observation['contextStatus'] == observation['initStatus'] == 0, observation
    assert observation['pageBytes'] > 0
    assert record['selectedLibrary'] in record['selected']['libraries']


def collect(args):
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full profiles run on GitHub'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    assert os.environ['GITHUB_SHA'] == args.source
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[args.arch]
    assert args.rust_cpu == {'x86_64': 'x86-64', 'aarch64': 'generic'}[args.arch]
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items()
           if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(CC=args.cc, FWP_STACK='1', FWP_LTO='0', LC_ALL='C', SWIFT_BACKTRACE='enable=no')

    selected_env = dict(env, LD_LIBRARY_PATH=str(args.unwind_library_directory.resolve()))

    def run(command, environment):
        command = list(map(str, command))
        result = run_capture(command, env=environment, cwd=None, input_data=None, input_stream=None,
                             text=True, encoding='utf-8', timeout=180, check=False)
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, libraryPath=environment.get('LD_LIBRARY_PATH'), status=result.returncode,
                                     stdout=result.stdout, stderr=result.stderr)) + '\n')
        assert result.returncode == 0, result
        return result

    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  cpu=run(['lscpu'], env).stdout, compilerSha256=digest(args.compiler),
                  versions={name: run([getattr(args, name), '--version'], env).stdout for name in
                            ('cc', 'rustc', 'swiftc', 'heaptrack', 'heaptrack_print')},
                  settings={key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()},
                  programs={}, controls={})
    flags = ['-std=gnu11', '-O2', '-g', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-march=' + args.c_arch]
    unwind_source = out / 'unwind-control.c'
    unwind_source.write_text(UNWIND_CONTROL)
    unwind_binary = out / 'unwind-control'
    run([args.cc, *flags, unwind_source, '-lunwind', '-o', unwind_binary], env)
    report['unwinding'] = {}
    for label, environment in [('system', env), ('selected', selected_env)]:
        result = run([args.strace, '-o', out / (label + '-unwind.syscalls'),
                      '-e', 'trace=process_vm_readv,pipe2,read,write,mincore', unwind_binary], environment)
        report['unwinding'][label] = dict(observation=json.loads(result.stdout),
                                          libraries=run(['ldd', unwind_binary], environment).stdout)
    selected_library = args.unwind_library_directory.resolve() / 'libunwind.so.8'
    shutil.copyfile(selected_library, out / 'libunwind.so.8')
    report['unwinding']['selectedLibrary'] = str(selected_library)
    report['unwinding']['selectedLibrarySha256'] = digest(selected_library)
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    check_unwinding(report['unwinding'])

    def profile(binary, arguments, directory, expected, environment):
        directory.mkdir(parents=True)
        result = run([args.heaptrack, '-o', directory / 'trace', binary, *arguments], environment)
        # heaptrack's launcher adds nonnumeric status lines around program stdout.
        actual = ''.join(line + '\n' for line in result.stdout.splitlines() if line.isdecimal())
        assert actual == expected, result
        traces = list(directory.glob('trace*'))
        assert len(traces) == 1 and traces[0].stat().st_size > 0, traces
        for cost in COSTS:
            result = run([args.heaptrack_print, '--file', traces[0], '--merge-backtraces', '0',
                          '--print-peaks', '1', '--print-allocators', '1', '--print-temporary', '1',
                          '--print-leaks', '1', '--peak-limit', '20', '--sub-peak-limit', '20',
                          '--flamegraph-cost-type', cost, '--print-flamegraph', directory / (cost + '.stacks')], environment)
            (directory / (cost + '.txt')).write_text(result.stdout)
        return summarize(directory)

    control = out / 'control.c'
    control.write_text(CONTROL)
    binary = out / 'control'
    run([args.cc, *flags, control, '-o', binary], env)
    report['systemControls'] = {}
    for name, arguments in [('release', []), ('omit-release', ['omit'])]:
        report['systemControls'][name] = profile(binary, arguments, out / ('system-' + name), '3\n', env)
        report['controls'][name] = profile(binary, arguments, out / name, '3\n', selected_env)
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    check_control(report['controls']['release'], report['controls']['omit-release'])

    for name in PROGRAMS:
        folder = out / name
        folder.mkdir()
        programs = report['programs'][name] = {}
        expected = None
        for language in LANGUAGES:
            source = folder / ('main.' + language)
            shutil.copyfile(ROOT / 'bench' / name / source.name, source)
            binary = folder / language / 'program'
            binary.parent.mkdir()
            if language == 'fwp':
                generated = folder / 'generated.c'
                run([args.compiler.resolve(), 'build', source, '-O2', '--memory', 'dynamic', '--emit-c', '-o', generated], env)
                command = [args.cc, *flags, generated, '-lm', '-lpthread', '-ldl', '-o', binary]
            elif language == 'c':
                command = [args.cc, *flags, source, '-o', binary]
            elif language == 'rs':
                command = [args.rustc, '--edition=2021', '-O', '-g', '-C', 'lto=no', '-C', 'target-cpu=' + args.rust_cpu,
                           '--target', args.target, source, '-o', binary]
            else:
                command = [args.swiftc, '-swift-version', '6', '-O', '-g', '-whole-module-optimization',
                           '-target', args.target, '-warnings-as-errors', source, '-o', binary]
            result = run(command, env)
            assert not result.stdout and not result.stderr, result
            header = binary.read_bytes()[:20]
            assert header[:6] == b'\x7fELF\x02\x01'
            assert struct.unpack_from('<H', header, 18)[0] == {'x86_64': 62, 'aarch64': 183}[args.arch]
            result = run([binary], env)
            assert result.stdout and not result.stderr, result
            if expected is None:
                expected = result.stdout
            assert result.stdout == expected, result
            entry = programs[language] = dict(stdout=expected, binarySha256=digest(binary), profiles=[])
            for sample in range(2):
                entry['profiles'].append(profile(binary, [], binary.parent / str(sample), expected, selected_env))
            if language == 'fwp':
                # The managed heap reserves mmap storage, outside heaptrack's
                # malloc boundary. Preserve its separate counters; never label
                # native allocator bytes as the program's complete heap use.
                managed_source = folder / 'managed.c'
                managed_source.write_text(PROFILE.instrument(generated.read_text()))
                managed_binary = folder / 'managed'
                run([args.cc, *flags, managed_source, '-lm', '-lpthread', '-ldl', '-o', managed_binary], env)
                entry['managed'] = []
                for sample in range(2):
                    result = run([managed_binary], env)
                    assert result.stdout == expected
                    counters = json.loads(result.stderr)
                    assert set(counters) == {'requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'}
                    assert all(type(value) is int and value >= 0 for value in counters.values())
                    assert counters['finalChargedBytes'] == 0, counters
                    entry['managed'].append(counters)
                assert entry['managed'][0] == entry['managed'][1], entry
            (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
            print(name, language, json.dumps([row['totals'] for row in entry['profiles']]), flush=True)
    report['scope'] = ('Two whole-process allocator profiles per program/language, including runtime initialization and shutdown. '
                       'Debug information enables stack attribution; optimized arithmetic flags match the ordinary peers. '
                       'No profile duration is a speed measurement. Heaptrack excludes direct mmap storage, including the fwp managed heap. '
                       'Separate fwp managed counters cover program work after constants initialize and before runtime teardown; do not add independent peaks. '
                       'Internal fwp pool allocations and ARC retains/releases are not native allocator calls. '
                       'Unfreed process-exit bytes include runtime caches; only the controlled allocation proves deliberate leakage.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    manifest = {str(path.relative_to(out)): digest(path) for path in sorted(out.rglob('*')) if path.is_file()}
    (out / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')


def audit(args):
    out = args.input.resolve()
    manifest = json.loads((out / 'manifest.json').read_text())
    assert set(manifest) == {str(path.relative_to(out)) for path in out.rglob('*') if path.is_file() and path.name != 'manifest.json'}
    for name, checksum in manifest.items():
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert digest(out / name) == checksum, name
    report = json.loads((out / 'report.json').read_text())
    assert report['source'] == args.source and report['architecture'] == args.arch
    check_unwinding(report['unwinding'])
    assert report['unwinding']['selectedLibrarySha256'] == digest(out / 'libunwind.so.8')
    commands = [json.loads(line) for line in (out / 'commands.jsonl').read_text().splitlines()]
    for label in ('system', 'selected'):
        traces = [command for command in commands if any(argument.endswith('/' + label + '-unwind.syscalls')
                                                          for argument in command['command'])]
        assert len(traces) == 1 and traces[0]['status'] == 0
        assert json.loads(traces[0]['stdout']) == report['unwinding'][label]['observation']
    for name in ('release', 'omit-release'):
        assert report['controls'][name] == summarize(out / name)
        assert report['systemControls'][name] == summarize(out / ('system-' + name))
    check_control(report['controls']['release'], report['controls']['omit-release'])
    assert set(report['programs']) == set(PROGRAMS)
    for name, programs in report['programs'].items():
        assert set(programs) == set(LANGUAGES)
        for language, row in programs.items():
            folder = out / name / language
            assert row['binarySha256'] == digest(folder / 'program')
            assert row['stdout'] == programs['c']['stdout']
            assert row['profiles'] == [summarize(folder / str(sample)) for sample in range(2)]
            if language == 'fwp':
                observations = [json.loads(command['stderr']) for command in commands
                                if len(command['command']) == 1 and command['command'][0].endswith('/' + name + '/managed')]
                assert len(observations) == 2 and row['managed'] == observations
                assert observations[0] == observations[1] and observations[0]['finalChargedBytes'] == 0
            source = subprocess.check_output(['git', 'show', args.source + ':bench/' + name + '/main.' + language], cwd=ROOT)
            assert (out / name / ('main.' + language)).read_bytes() == source
    print('Two programs, four languages, two profiles each and allocation/release controls verified')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest='action', required=True)
    collect_parser = commands.add_parser('collect')
    for name in ('compiler', 'output', 'unwind-library-directory'):
        collect_parser.add_argument('--' + name, required=True, type=Path)
    for name in ('cc', 'rustc', 'swiftc', 'heaptrack', 'heaptrack-print', 'strace', 'c-arch', 'rust-cpu', 'target'):
        collect_parser.add_argument('--' + name, required=True)
    audit_parser = commands.add_parser('audit')
    audit_parser.add_argument('--input', required=True, type=Path)
    for command in (collect_parser, audit_parser):
        command.add_argument('--source', required=True)
        command.add_argument('--arch', required=True, choices=('x86_64', 'aarch64'))
    args = parser.parse_args()
    (collect if args.action == 'collect' else audit)(args)


if __name__ == '__main__':
    main()
