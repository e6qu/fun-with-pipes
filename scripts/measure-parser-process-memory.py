#!/usr/bin/env python3
"""Measure ordinary parser RSS and separate stopped-process mapping snapshots."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import resource
import shutil
import subprocess
import traceback

from parser_memory_source import MEASURE, ROOT, fwp, native
from parser_process_memory import checkpoint_process, mappings, summary, validate_mapping_control
from process_wait import run_capture

CASES = (('small', 5, False), ('medium', 9, False), ('large', 13, False), ('left', 64, True))
LANGUAGES = ('c', 'rs', 'fwp')
# Each field has eight malformed or out-of-range values, checked before I/O.
INVALID_ARGUMENTS = {
    2: ('', ' 1', '1junk', '-1', '-18446744073709551615', '0', '2', '18446744073709551616'),
    3: ('', ' 3', '3junk', '+', '-', '3 ', '9223372036854775808', '-9223372036854775809'),
    4: ('', ' 3', '3junk', '-1', '-18446744073709551615', '0', '65537', '18446744073709551616'),
}
CONTROLS = (('ordinary', None), ('omit-touch', 'touch-control-missing'), ('omit-unmap', 'unmap-control-missing'))
FIXTURES = ('parser_memory_checkpoint.c', 'parser_memory_control.c', 'parser_memory_fwp.c',
            'parser_arena_peer.c', 'parser_arena_peer.rs', 'parser_workspace.fwp')


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def result_value(row, language, expected, nodes, diagnostic):
    if language not in LANGUAGES:
        raise ValueError('unknown parser result language')
    if row['status'] != 0 or row['stderr']:
        raise ValueError('parser process failed: ' + str(row))
    value = json.loads(row['stdout'])
    fields = {'result', 'rounds'}
    if language == 'fwp':
        if diagnostic:
            fields.add('observedNodes')
    else:
        fields.update(('nodes', 'tokenizeNs', 'constructNs', 'walkAndReleaseNs', 'releaseNs',
                       'totalNs', 'nodeCapacityBytes', 'tokenCapacityBytes', 'allocations', 'nodeSize'))
    if not isinstance(value, dict) or set(value) != fields or any(type(item) is not int for item in value.values()):
        raise ValueError('malformed parser result fields')
    if row['stdout'] != json.dumps(value, separators=(',', ':')) + '\n':
        raise ValueError('duplicated parser result fields or unexpected output format')
    if any(item < 0 for key, item in value.items() if key != 'result'):
        raise ValueError('negative parser work or memory observation')
    if language != 'fwp' and (value['totalNs'] != value['tokenizeNs'] + value['constructNs'] + value['walkAndReleaseNs']
                              or value['walkAndReleaseNs'] < value['releaseNs']):
        raise ValueError('inconsistent parser phase durations')
    if value['result'] != expected or value['rounds'] != 1:
        raise ValueError('parser result or work count changed')
    if language != 'fwp' and value['nodes'] != nodes:
        raise ValueError('native parser node count changed')
    if language == 'fwp' and diagnostic and value['observedNodes'] != nodes:
        raise ValueError('fwp parser node count changed')


def collect(args):
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
    assert args.tag.startswith('roadmap/parser-process-memory-')
    assert subprocess.check_output(['git', 'rev-parse', 'refs/tags/' + args.tag], text=True).strip() == args.source
    assert os.environ['GITHUB_SHA'] == args.source
    resource.setrlimit(resource.RLIMIT_CORE, (0, 0))
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    environment.update(LC_ALL='C', FWP_LTO='0', FWP_STACK='1', CC=args.cc, RUST_BACKTRACE='0')
    report = dict(source=args.source, tag=args.tag, root=str(out), compilerPath=str(args.compiler.resolve()),
                  architecture=args.arch, host=platform.uname()._asdict(),
                  compilerSha256=digest(args.compiler), settings={k: str(v) for k, v in vars(args).items()},
                  versions={}, compile=[], images={}, controls={}, argumentControls=[], cases={}, failures=[],
                  scope='One parse per process. Ordinary RSS and separate diagnostic mappings; no timing or committed-byte claim.')
    commands = []

    def save():
        (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def record(row):
        row['index'] = len(commands)
        commands.append(row)
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(row) + '\n')
        return row

    def run(command, env):
        try:
            result = run_capture(list(map(str, command)), timeout=90, env=env, cwd=ROOT,
                                 input_data=None, input_stream=None, text=True, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            stdout, stderr = error.stdout or b'', error.stderr or b''
            record(dict(command=list(map(str, command)), status=None, timedOut=True,
                        stdout=stdout.decode('utf-8', errors='replace') if isinstance(stdout, bytes) else stdout,
                        stderr=stderr.decode('utf-8', errors='replace') if isinstance(stderr, bytes) else stderr,
                        fwpNoOpt=env.get('FWP_NO_OPT')))
            raise
        return record(dict(command=list(map(str, command)), status=result.returncode,
                           stdout=result.stdout, stderr=result.stderr, fwpNoOpt=env.get('FWP_NO_OPT')))

    def compile_program(command):
        metrics = out / f'compile-{len(report["compile"])}.txt'
        row = run([args.time, '-f', '%e %M', '-o', metrics, *command], environment)
        if (row['status'], row['stdout'], row['stderr']) != (0, '', ''):
            raise ValueError('parser compilation failed: ' + str(row))
        elapsed, rss = metrics.read_text().split()
        report['compile'].append(dict(command=row['index'], seconds=float(elapsed), peakRssKiB=int(rss), file=metrics.name))
        save()

    def image(label, binary):
        data = binary.read_bytes()
        assert data[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(data[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
        report['images'][label] = dict(path=str(binary.relative_to(out)), sha256=hashlib.sha256(data).hexdigest(), bytes=len(data))
        for kind, option in [('sections', '--section-headers'), ('frames', '--debug-dump=frames')]:
            row = run([args.readelf, '--wide', option, binary], environment)
            assert row['status'] == 0 and not row['stderr'], row
            path = out / (label + '-' + kind + '.txt')
            path.write_text(row['stdout'])
            report['images'][label][kind] = path.name

    def failure(stage, error):
        report['failures'].append(dict(stage=stage, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', stage, error, flush=True)

    def observe(command, part):
        try:
            row = checkpoint_process(command, environment, part, 5, 90)
        except Exception as error:
            record(dict(command=list(map(str, command)), status=None, stdout='', stderr=str(error),
                        partialSnapshots=str(part.relative_to(out))))
            raise
        row['fwpNoOpt'] = environment.get('FWP_NO_OPT')
        return record(row)

    for tool in ('cc', 'ar', 'rustc', 'readelf'):
        row = run([getattr(args, tool), '--version'], environment)
        assert row['status'] == 0 and not row['stderr'], row
        report['versions'][tool] = row['stdout']
    cpu = run(['lscpu'], environment)
    assert cpu['status'] == 0 and not cpu['stderr']
    report['cpu'] = cpu['stdout']
    libc = run(['getconf', 'GNU_LIBC_VERSION'], environment)
    assert libc['status'] == 0 and not libc['stderr'], libc
    report['versions']['libc'] = libc['stdout']
    cflags = ['-std=gnu11', '-O2', '-ffp-contract=off', '-fno-fast-math', '-fno-lto',
              '-fstack-usage', '-march=' + args.c_arch]
    for name in FIXTURES:
        shutil.copyfile(ROOT / 'tests/fixtures' / name, out / name)
    helper = out / 'checkpoint.o'
    control = out / 'mapping-control'
    save()
    try:
        compile_program([args.cc, *cflags, '-Wall', '-Wextra', '-Werror', '-c', out / 'parser_memory_checkpoint.c', '-o', helper])
        compile_program([args.ar, 'crs', out / 'libparser_memory_checkpoint.a', helper])
        compile_program([args.cc, *cflags, '-Wall', '-Wextra', '-Werror', out / 'parser_memory_control.c', helper, '-o', control])
        image('mapping-control', control)
    except Exception as error:
        failure('observer-build', error)
        raise
    for variant, expected_error in CONTROLS:
        part = out / ('control-' + variant)
        try:
            row = observe([control, variant], part)
            report['controls'][variant] = dict(command=row['index'], folder=part.name)
            observed_error = None
            try:
                validate_mapping_control(row, part)
            except ValueError as error:
                observed_error = str(error)
            assert observed_error == expected_error, (variant, observed_error, expected_error)
            report['controls'][variant]['expectedError'] = expected_error
        except Exception as error:
            failure('mapping-control-' + variant, error)
        save()
    assert not report['failures'], 'mapping observer must pass actual native controls before use'

    generated = None
    fixture = (ROOT / 'tests/fixtures/parser_workspace.fwp').read_text().split('# This entry returns')[0]
    source = out / 'parser.fwp'
    source.write_text(fixture + '\nmain = "+ 2 * 3 4" | calculate | echo\n')
    try:
        original = out / 'fwp-original.c'
        compile_program([args.compiler.resolve(), 'build', '--emit-c', '--memory', 'dynamic', '--fn', 'calculate',
                         '-O2', source, '-o', original])
        generated = original.read_text()
    except Exception as error:
        failure('fwp-emission', error)
    binaries = {}
    for language in LANGUAGES:
        for diagnostic in (False, True):
            label = language + ('-diagnostic' if diagnostic else '-ordinary')
            try:
                path = out / (label + ('.rs' if language == 'rs' else '.c'))
                if language == 'fwp':
                    if generated is None:
                        raise ValueError('fwp emission did not complete')
                    path.write_text(fwp(generated, diagnostic))
                else:
                    text = (ROOT / 'tests/fixtures' / ('parser_arena_peer.' + language)).read_text()
                    path.write_text(native(text, language) if diagnostic else text)
                binary = out / label
                if language == 'rs':
                    command = [args.rustc, '--edition=2021', '-C', 'opt-level=2', '-C', 'overflow-checks=yes',
                               '-C', 'lto=off', '-C', 'codegen-units=16', '-C', 'debuginfo=0', '-C', 'panic=unwind',
                               '-C', 'target-cpu=' + args.rust_cpu, '--target', args.target, '-D', 'warnings', path, '-o', binary]
                    if diagnostic:
                        command += ['-L', 'native=' + str(out), '-l', 'static=parser_memory_checkpoint']
                else:
                    command = [args.cc, *cflags, *(['-w'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']), path]
                    if diagnostic:
                        command.append(helper)
                    command += ['-o', binary, '-lm', '-lpthread', '-ldl']
                compile_program(command)
                image(label, binary)
                binaries[label] = binary
            except Exception as error:
                failure('build-' + label, error)
    (out / 'argument-input.txt').write_text('+ 1 2')
    for diagnostic in (False, True):
        label = 'fwp-' + ('diagnostic' if diagnostic else 'ordinary')
        for field, invalid_values in INVALID_ARGUMENTS.items():
            for invalid in invalid_values:
                try:
                    command = [binaries[label], out / 'argument-input.txt', '1', '3', '3']
                    command[field] = invalid
                    row = run(command, environment)
                    assert (row['status'], row['stdout'], row['stderr']) == (90, '', ''), row
                    report['argumentControls'].append(dict(command=row['index'], diagnostic=diagnostic,
                                                          field=field, value=invalid))
                except Exception as error:
                    failure(f'argument-{label}-{field}-{invalid!r}', error)
                save()
    for name, depth, left in CASES:
        text, nodes, expected = MEASURE.input_case(depth, left)
        path = out / (name + '.txt')
        path.write_text(text)
        case = report['cases'][name] = dict(input=path.name, nodes=nodes, expected=expected, interpreter=[], peers={})
        program = out / (name + '.fwp')
        program.write_text(fixture + '\nmain = ' + json.dumps(text) + ' | calculate | echo\n')
        for optimized in (False, True):
            try:
                env = environment if optimized else environment | {'FWP_NO_OPT': '1'}
                row = run([args.compiler.resolve(), 'run', '--interp', program], env)
                assert (row['status'], row['stdout'], row['stderr']) == (0, str(expected) + '\n', ''), row
                case['interpreter'].append(dict(optimized=optimized, command=row['index']))
            except Exception as error:
                failure('interpreter-' + name + '-' + str(optimized), error)
        for language in LANGUAGES:
            peer = case['peers'][language] = dict(memory=[], snapshots=[], wrongResult=[])
            for sample in range(3):
                try:
                    binary = binaries[language + '-ordinary']
                    metrics = out / f'rss-{name}-{language}-{sample}.txt'
                    row = run([args.time, '-f', '%M', '-o', metrics, binary, path, '1', expected, nodes], environment)
                    result_value(row, language, expected, nodes, False)
                    rss = int(metrics.read_text())
                    assert rss >= 0, metrics
                    peer['memory'].append(dict(command=row['index'], peakRssKiB=rss, file=metrics.name))
                except Exception as error:
                    failure(f'rss-{name}-{language}-{sample}', error)
                save()
            for sample in range(2):
                try:
                    binary = binaries[language + '-diagnostic']
                    part = out / f'snapshots-{name}-{language}-{sample}'
                    row = observe([binary, path, '1', expected, nodes], part)
                    result_value(row, language, expected, nodes, True)
                    peer['snapshots'].append(dict(command=row['index'], folder=part.name))
                except Exception as error:
                    failure(f'snapshots-{name}-{language}-{sample}', error)
                save()
            for diagnostic in (False, True):
                try:
                    binary = binaries[language + ('-diagnostic' if diagnostic else '-ordinary')]
                    command = [binary, path, '1', expected + 1, nodes]
                    if diagnostic:
                        row = observe(command, out / f'wrong-result-{name}-{language}')
                    else:
                        row = run(command, environment)
                    assert row['status'] == (101 if language == 'rs' else 93) and not row['stdout'], row
                    if language == 'rs':
                        assert 'assertion `left == right` failed' in row['stderr'], row
                    else:
                        assert not row['stderr'], row
                    peer['wrongResult'].append(dict(command=row['index'], diagnostic=diagnostic))
                except Exception as error:
                    failure(f'wrong-result-{name}-{language}-{diagnostic}', error)
                save()
        print('Completed parser memory case', name, flush=True)
    save()
    manifest = {str(path.relative_to(out)): digest(path) for path in sorted(out.rglob('*')) if path.is_file()}
    (out / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    print('36 ordinary RSS runs, 24 parser checkpoint sequences, 24 wrong-result controls, 48 invalid arguments and 8 interpreter checks complete')


def audit(args):
    out = args.input.resolve()
    manifest = json.loads((out / 'manifest.json').read_text())
    assert set(manifest) == {str(path.relative_to(out)) for path in out.rglob('*') if path.is_file() and path.name != 'manifest.json'}
    for name, sha in manifest.items():
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert digest(out / name) == sha, name
    report = json.loads((out / 'report.json').read_text())
    assert (report['source'], report['architecture']) == (args.source, args.arch) and not report['failures']
    assert subprocess.check_output(['git', 'rev-parse', report['tag']], text=True).strip() == args.source
    commands = [json.loads(line) for line in (out / 'commands.jsonl').read_text().splitlines()]
    assert [row['index'] for row in commands] == list(range(len(commands)))
    assert set(report['images']) == {'mapping-control'} | {language + '-' + mode
        for language in LANGUAGES for mode in ('ordinary', 'diagnostic')}
    assert set(report['controls']) == {name for name, _ in CONTROLS}
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
    for name in FIXTURES:
        assert (out / name).read_bytes() == (ROOT / 'tests/fixtures' / name).read_bytes(), name
    fixture = (out / 'parser_workspace.fwp').read_text().split('# This entry returns')[0]
    assert (out / 'parser.fwp').read_text() == fixture + '\nmain = "+ 2 * 3 4" | calculate | echo\n'
    generated = (out / 'fwp-original.c').read_text()
    for language in LANGUAGES:
        for diagnostic in (False, True):
            label = language + ('-diagnostic' if diagnostic else '-ordinary')
            path = out / (label + ('.rs' if language == 'rs' else '.c'))
            if language == 'fwp':
                expected_source = fwp(generated, diagnostic)
            else:
                original = (out / ('parser_arena_peer.' + language)).read_text()
                expected_source = native(original, language) if diagnostic else original
            assert path.read_text() == expected_source, label
    for image in report['images'].values():
        path = out / image['path']
        data = path.read_bytes()
        assert digest(path) == image['sha256'] and len(data) == image['bytes']
        assert data[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(data[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
    permitted_failures = set()
    observed_commands = set()
    root = Path(report['root'])

    def observation(index):
        assert index not in observed_commands, ('reused observation', index)
        observed_commands.add(index)
        return commands[index]

    def parser_command(row, language, diagnostic, input_name, expected, nodes, rss_file):
        label = language + ('-diagnostic' if diagnostic else '-ordinary')
        expected_command = [str(root / report['images'][label]['path']), str(root / input_name), '1', str(expected), str(nodes)]
        if rss_file is not None:
            expected_command = [report['settings']['time'], '-f', '%M', '-o', str(root / rss_file), *expected_command]
        assert row['command'] == expected_command, row['command']
        assert row['fwpNoOpt'] is None

    def checkpoints(row, folder):
        journal = json.loads((folder / 'observation.json').read_text())
        assert journal == dict(command=row['command'], status=row['status'], terminatedByObserver=False,
            checkpointMessagesHex=[f'{phase}\n'.encode().hex() for phase in range(5)],
            snapshots=row['snapshots'], failure=None, timeoutSeconds=90)
        assert (folder / 'stderr.txt').read_text() == row['stderr']
        assert [part['phase'] for part in row['snapshots']] == list(range(5))
        for part in row['snapshots']:
            assert part['file'] == f'phase-{part["phase"]}.smaps'
            path = folder / part['file']
            assert digest(path) == part['sha256']
            assert summary(mappings(path.read_text())) == part['metrics']

    for name, expected_error in CONTROLS:
        control = report['controls'][name]
        assert control['folder'] == 'control-' + name and control['expectedError'] == expected_error
        row = observation(control['command'])
        assert row['command'] == [str(root / 'mapping-control'), name] and row['fwpNoOpt'] is None
        checkpoints(row, out / control['folder'])
        error = None
        try:
            validate_mapping_control(row, out / control['folder'])
        except ValueError as failure:
            error = str(failure)
        assert error == expected_error, (error, control)
    assert (out / 'argument-input.txt').read_text() == '+ 1 2'
    expected_arguments = {(diagnostic, field, value) for diagnostic in (False, True)
                          for field, values in INVALID_ARGUMENTS.items() for value in values}
    assert len(report['argumentControls']) == len(expected_arguments) == 48
    assert {(part['diagnostic'], part['field'], part['value']) for part in report['argumentControls']} == expected_arguments
    for part in report['argumentControls']:
        row = observation(part['command'])
        label = 'fwp-' + ('diagnostic' if part['diagnostic'] else 'ordinary')
        command = [str(root / report['images'][label]['path']), str(root / 'argument-input.txt'), '1', '3', '3']
        command[part['field']] = part['value']
        assert row['command'] == command and row['fwpNoOpt'] is None
        assert (row['status'], row['stdout'], row['stderr']) == (90, '', '')
        permitted_failures.add(part['command'])
    assert set(report['cases']) == {case[0] for case in CASES}
    for name, depth, left in CASES:
        case = report['cases'][name]
        text, nodes, expected = MEASURE.input_case(depth, left)
        assert (out / case['input']).read_text() == text
        assert (case['nodes'], case['expected']) == (nodes, expected)
        assert (out / (name + '.fwp')).read_text() == fixture + '\nmain = ' + json.dumps(text) + ' | calculate | echo\n'
        assert {row['optimized'] for row in case['interpreter']} == {False, True}
        for row in case['interpreter']:
            command = observation(row['command'])
            assert command['command'] == [report['compilerPath'], 'run', '--interp', str(root / (name + '.fwp'))]
            assert command['fwpNoOpt'] == (None if row['optimized'] else '1')
            assert (command['status'], command['stdout'], command['stderr']) == (0, str(expected) + '\n', '')
        assert set(case['peers']) == set(LANGUAGES)
        for language, peer in case['peers'].items():
            assert len(peer['memory']) == 3 and len(peer['snapshots']) == 2 and len(peer['wrongResult']) == 2
            for memory in peer['memory']:
                row = observation(memory['command'])
                parser_command(row, language, False, case['input'], expected, nodes, memory['file'])
                result_value(row, language, expected, nodes, False)
                assert int((out / memory['file']).read_text()) == memory['peakRssKiB'] >= 0
            for snapshot in peer['snapshots']:
                row = observation(snapshot['command'])
                parser_command(row, language, True, case['input'], expected, nodes, None)
                result_value(row, language, expected, nodes, True)
                checkpoints(row, out / snapshot['folder'])
            for control in peer['wrongResult']:
                row = observation(control['command'])
                parser_command(row, language, control['diagnostic'], case['input'], expected + 1, nodes, None)
                assert row['status'] == (101 if language == 'rs' else 93) and not row['stdout']
                if language == 'rs':
                    assert 'assertion `left == right` failed' in row['stderr']
                else:
                    assert not row['stderr']
                if control['diagnostic']:
                    checkpoints(row, out / f'wrong-result-{name}-{language}')
                permitted_failures.add(control['command'])
    assert len(report['compile']) == 10
    for row in report['compile']:
        seconds, rss = (out / row['file']).read_text().split()
        assert (float(seconds), int(rss)) == (row['seconds'], row['peakRssKiB'])
        assert math.isfinite(row['seconds']) and row['seconds'] >= 0 and row['peakRssKiB'] >= 0
        assert commands[row['command']]['command'][:5] == [report['settings']['time'], '-f', '%e %M', '-o', str(root / row['file'])]
    for row in commands:
        if row['index'] not in permitted_failures:
            assert row['status'] == 0 and not row['stderr'], row
    assert len(permitted_failures) == 72 and len(observed_commands) == 143
    print('Native mapping controls, all parser results/snapshots, ordinary RSS and retained image/command identities agree')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    actions = parser.add_subparsers(dest='action', required=True)
    collector = actions.add_parser('collect')
    for name in ('cc', 'ar', 'rustc', 'readelf', 'time', 'source', 'tag', 'arch', 'c-arch', 'rust-cpu', 'target'):
        collector.add_argument('--' + name, required=True)
    collector.add_argument('--compiler', type=Path, required=True)
    collector.add_argument('--output', type=Path, required=True)
    reader = actions.add_parser('audit')
    reader.add_argument('--input', type=Path, required=True)
    reader.add_argument('--source', required=True)
    reader.add_argument('--arch', required=True)
    args = parser.parse_args()
    if args.action == 'collect':
        collect(args)
    else:
        audit(args)


if __name__ == '__main__':
    main()
