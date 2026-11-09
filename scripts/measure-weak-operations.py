#!/usr/bin/env python3
"""Measure weak-reference phases with a C-only pilot and two paired sessions."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import shutil
import struct
import subprocess
import time
import traceback

from process_wait import run_capture
from weak_operation_build import build
from weak_operation_phases import BATCHES, CASES, COPY_LIMIT, LABELS, MIN_PHASE_NS, PEERS, PHASES, PILOT_NS, ROUNDS
from weak_operation_phases import decode_output, order, select_pilot, summarize
from weak_operation_source import boundary

ROOT = Path(__file__).resolve().parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def native(path, arch):
    with path.open('rb') as stream:
        header = stream.read(20)
    assert header[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', header, 18)[0] == {'x86_64': 62, 'aarch64': 183}[arch]


def collect(args):
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.source == os.environ['GITHUB_SHA']
    for revision in ('HEAD', args.tag):
        assert subprocess.check_output(['git', 'rev-parse', revision], cwd=ROOT, text=True).strip() == args.source
    assert args.tag.startswith('roadmap/weak-operation-time-')
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no', CC=args.cc, FWP_LTO='0', FWP_STACK='1')
    commands = []

    def run(command, expected, environment):
        command = list(map(str, command))
        start = time.perf_counter_ns()
        try:
            result = run_capture(command, env=environment, cwd=None, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=180, check=False)
        except subprocess.TimeoutExpired as error:
            stdout, stderr = error.stdout or b'', error.stderr or b''
            row = dict(command=command, status=None, timedOut=True,
                       stdout=stdout.decode('utf-8', errors='replace') if isinstance(stdout, bytes) else stdout,
                       stderr=stderr.decode('utf-8', errors='replace') if isinstance(stderr, bytes) else stderr,
                       elapsedNs=time.perf_counter_ns() - start, index=len(commands))
        else:
            row = dict(command=command, status=result.returncode, stdout=result.stdout, stderr=result.stderr,
                       elapsedNs=time.perf_counter_ns() - start, index=len(commands))
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0] and row['stderr'] == expected[2], row
        assert expected[1] is None or row['stdout'] == expected[1], row
        return row

    report = dict(source=args.source, tag=args.tag, architecture=args.arch, root=str(folder),
                  compilerSha256=digest(args.compiler), host=platform.uname()._asdict(),
                  cpu=run(['lscpu'], (0, None, ''), env)['stdout'],
                  versions={name: run([getattr(args, name), '--version'], (0, None, ''), env)['stdout']
                            for name in ('cc', 'ar', 'rustc', 'swiftc', 'time', 'objdump', 'readelf')},
                  settings={key: str(value) for key, value in vars(args).items()},
                  protocol=dict(cases=CASES, pilotBatches=BATCHES, pilotNs=PILOT_NS, rounds=ROUNDS,
                                minimumPhaseNs=MIN_PHASE_NS, copyLimit=COPY_LIMIT, labels=LABELS),
                  compile=[], binaries={}, pilots={}, sessions={}, failures=[],
                  scope='Six weak-reference phases; fwp channel versus native peers; process time includes launch/wait/output; no ARC counts')

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

    save()

    def compile_run(command, expected, environment):
        metrics = folder / f'compile-{len(report["compile"])}.txt'
        row = run([args.time, '-f', '%e %M', '-o', metrics, *command], expected, environment)
        seconds, rss = metrics.read_text().split()
        seconds, rss = float(seconds), int(rss)
        assert math.isfinite(seconds) and seconds >= 0 and rss > 0
        report['compile'].append(dict(command=row['index'], seconds=seconds, peakRssKiB=rss,
                                      file=str(metrics.relative_to(folder))))
        save()
        return row

    fixtures = folder / 'fixtures'
    fixtures.mkdir()
    for pattern in ('weak_operation_*', 'callable_phase_clock.*'):
        for path in (ROOT / 'tests/fixtures').glob(pattern):
            shutil.copyfile(path, fixtures / path.name)
    clock = folder / 'clock.o'
    compile_run([args.cc, '-std=c11', '-O2', '-ffp-contract=off', '-fno-lto', '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror',
                 '-c', fixtures / 'callable_phase_clock.c', '-o', clock], (0, '', ''), env)
    generated = folder / 'original.c'
    emitted = None
    try:
        compile_run([args.compiler.resolve(), 'build', '--fn', 'reference-functions', '--memory', 'dynamic', '--emit-c', '-O2',
                     fixtures / 'weak_operation_peer.fwp', '-o', generated], (0, '', ''), env)
        emitted = boundary(generated.read_text())
    except Exception as error:
        failure('fwp emission', error)
    binaries = {}
    for peer in PEERS:
        try:
            binary, metadata = build(args, folder, fixtures, emitted, compile_run, env, peer, 2,
                                     'ordinary', 'phases', clock)
            native(binary, args.arch)
            duplicate = binary.with_name('program-copy')
            shutil.copy2(binary, duplicate)
            assert digest(duplicate) == metadata['binarySha256']
            binaries[peer] = binary
            binaries[peer + '-copy'] = duplicate
            metadata['path'] = str(binary.relative_to(folder))
            metadata['copyPath'] = str(duplicate.relative_to(folder))
            metadata['bytes'] = binary.stat().st_size
            # Preserve section sizes and emitted unwind tables. They are code and
            # frame evidence, not a claim about maximum dynamic stack use.
            for name, command in (
                ('sections', [args.objdump, '--section-headers', binary]),
                ('frames', [args.readelf, '--debug-dump=frames-interp', binary]),
                ('libraries', ['ldd', binary]),
            ):
                row = run(command, (0, None, ''), env)
                path = binary.with_name(name + '.txt')
                path.write_text(row['stdout'])
                metadata[name] = str(path.relative_to(folder))
            report['binaries'][peer] = metadata
            save()
        except Exception as error:
            failure('build ' + peer, error)
    # Complete every C-only pilot before any peer samples or warmup runs.
    for population, lookups in CASES:
        try:
            key = f'{population}-{lookups}'
            pilot = report['pilots'][key] = dict(observations=[])
            for batches in BATCHES:
                row = run([binaries['c'], population, lookups, batches], (0, None, ''), env)
                phases = decode_output(row['stdout'], population, lookups, batches)
                pilot['observations'].append(dict(batches=batches, stdout=row['stdout'], command=row['index']))
                save()
                if sum(phases[phase] for phase in PHASES) >= PILOT_NS:
                    break
            pilot['batches'] = select_pilot(pilot['observations'], population, lookups)
            save()
        except Exception as error:
            failure(f'pilot {population}/{lookups}', error)
    for session in (1, 2):
        cases = report['sessions'][str(session)] = {}
        for population, lookups in CASES:
            try:
                key = f'{population}-{lookups}'
                batches = report['pilots'][key]['batches']
                case = cases[key] = dict(warmups=[], samples=[], memory={})
                for warmup in range(2):
                    for label in order(warmup):
                        row = run([binaries[label], population, lookups, batches], (0, None, ''), env)
                        decode_output(row['stdout'], population, lookups, batches)
                        case['warmups'].append(dict(label=label, command=row['index']))
                for round_number in range(ROUNDS):
                    for position, label in enumerate(order(round_number)):
                        row = run([binaries[label], population, lookups, batches], (0, None, ''), env)
                        phases = decode_output(row['stdout'], population, lookups, batches)
                        durations = {phase: phases[phase] for phase in PHASES}
                        durations['process'] = row['elapsedNs']
                        case['samples'].append(dict(round=round_number, position=position, label=label,
                                                    command=row['index'], ns=durations))
                    save()
                case['summary'] = summarize(case['samples'])
                for peer in PEERS:
                    case['memory'][peer] = []
                    for sample in range(3):
                        rss = folder / f'rss-{session}-{key}-{peer}-{sample}.txt'
                        row = run([args.time, '-f', '%M', '-o', rss, binaries[peer], population, lookups, batches],
                                  (0, None, ''), env)
                        decode_output(row['stdout'], population, lookups, batches)
                        value = int(rss.read_text())
                        assert value >= 0
                        case['memory'][peer].append(dict(command=row['index'], peakRssKiB=value,
                                                         file=str(rss.relative_to(folder))))
                save()
                print('RESULT', session, key, json.dumps(case['summary']), flush=True)
            except Exception as error:
                failure(f'session {session} {population}/{lookups}', error)
    manifest = {str(path.relative_to(folder)): digest(path) for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']


def audit(args):
    folder = args.input.resolve()
    manifest = json.loads((folder / 'manifest.json').read_text())
    assert set(manifest) == {str(path.relative_to(folder)) for path in folder.rglob('*')
                             if path.is_file() and path.name != 'manifest.json'}
    for name, expected in manifest.items():
        assert not Path(name).is_absolute() and '..' not in Path(name).parts
        assert digest(folder / name) == expected, name
    report = json.loads((folder / 'report.json').read_text())
    assert (report['source'], report['architecture']) == (args.source, args.arch) and not report['failures']
    assert subprocess.check_output(['git', 'rev-parse', report['tag']], cwd=ROOT, text=True).strip() == args.source
    assert report['protocol'] == dict(cases=[list(case) for case in CASES], pilotBatches=list(BATCHES),
        pilotNs=PILOT_NS, rounds=ROUNDS, minimumPhaseNs=MIN_PHASE_NS, copyLimit=COPY_LIMIT, labels=list(LABELS))
    for path in (folder / 'fixtures').iterdir():
        assert path.read_bytes() == subprocess.check_output(['git', 'show', f'{args.source}:tests/fixtures/{path.name}'], cwd=ROOT)
    commands = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    for index, row in enumerate(commands):
        assert row['index'] == index and row['status'] == 0 and row['stderr'] == ''
        assert type(row['elapsedNs']) is int and row['elapsedNs'] > 0
    root = Path(report['root'])
    assert set(report['binaries']) == set(PEERS)
    for key, row in report['binaries'].items():
        for name in ('path', 'copyPath'):
            assert row[name] in manifest
            path = folder / row[name]
            native(path, args.arch)
            assert digest(path) == row['binarySha256'] and path.stat().st_size == row['bytes']
        assert (row['language'], row['level'], row['variant'], row['mode']) == (key, 2, 'ordinary', 'phases')
        extension = 'c' if key == 'fwp' else key
        expected_factory = (boundary((folder / 'original.c').read_text()) if key == 'fwp'
                            else (folder / 'fixtures' / ('weak_operation_peer.' + extension)).read_text())
        assert (folder / row['path']).with_name('factory.' + extension).read_text() == expected_factory
        if key in ('c', 'fwp'):
            assert (folder / row['path']).with_name('caller.c').read_bytes() == (folder / 'fixtures/weak_operation_time.c').read_bytes()
        assert sum(command['command'][5:] == row['link'] for command in commands) == 1
    seen = []

    def observation(index, peer, population, lookups, batches, prefix):
        row = commands[index]
        language = peer.removesuffix('-copy')
        filename = report['binaries'][language]['copyPath' if peer.endswith('-copy') else 'path']
        assert row['command'] == [*prefix, str(root / filename), str(population), str(lookups), str(batches)]
        seen.append(index)
        return decode_output(row['stdout'], population, lookups, batches)

    keys = {f'{population}-{lookups}' for population, lookups in CASES}
    assert set(report['pilots']) == keys
    for population, lookups in CASES:
        pilot = report['pilots'][f'{population}-{lookups}']
        assert pilot['batches'] == select_pilot(pilot['observations'], population, lookups)
        for row in pilot['observations']:
            observation(row['command'], 'c', population, lookups, row['batches'], [])
            assert row['stdout'] == commands[row['command']]['stdout']
    last_pilot = max(seen)
    assert set(report['sessions']) == {'1', '2'}
    for session in ('1', '2'):
        assert set(report['sessions'][session]) == keys
        for population, lookups in CASES:
            key = f'{population}-{lookups}'
            case = report['sessions'][session][key]
            batches = report['pilots'][key]['batches']
            assert [row['label'] for row in case['warmups']] == order(0) + order(1)
            for row in case['warmups']:
                assert row['command'] > last_pilot
                observation(row['command'], row['label'], population, lookups, batches, [])
            for row in case['samples']:
                phases = observation(row['command'], row['label'], population, lookups, batches, [])
                assert row['ns'] == dict((phase, phases[phase]) for phase in PHASES) | {
                    'process': commands[row['command']]['elapsedNs']}
            assert case['summary'] == summarize(case['samples'])
            assert set(case['memory']) == set(PEERS)
            for peer, readings in case['memory'].items():
                assert len(readings) == 3
                for row in readings:
                    assert row['file'] in manifest
                    observation(row['command'], peer, population, lookups, batches,
                                [report['settings']['time'], '-f', '%M', '-o', str(root / row['file'])])
                    assert row['peakRssKiB'] == int((folder / row['file']).read_text()) >= 0
    assert seen == sorted(set(seen)), 'reused or reordered observations'
    assert len(report['compile']) == 13
    for row in report['compile']:
        assert row['file'] in manifest
        seconds, rss = (folder / row['file']).read_text().split()
        assert row['seconds'] == float(seconds) and math.isfinite(row['seconds']) and row['seconds'] >= 0
        assert row['peakRssKiB'] == int(rss) > 0
        assert commands[row['command']]['command'][:5] == [report['settings']['time'], '-f', '%e %M', '-o', str(root / row['file'])]
    print('Raw pilot, paired phase samples, live/expired results, RSS, compile costs and binary identities agree')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest='action', required=True)
    collector = commands.add_parser('collect')
    for name in ('source', 'tag', 'arch', 'cc', 'ar', 'rustc', 'swiftc', 'c-arch', 'rust-cpu', 'target', 'time', 'objdump', 'readelf'):
        collector.add_argument('--' + name, required=True)
    collector.add_argument('--compiler', type=Path, required=True)
    collector.add_argument('--output', type=Path, required=True)
    reader = commands.add_parser('audit')
    for name in ('source', 'arch'):
        reader.add_argument('--' + name, required=True)
    reader.add_argument('--input', type=Path, required=True)
    args = parser.parse_args()
    if args.action == 'collect':
        collect(args)
    else:
        audit(args)


if __name__ == '__main__':
    main()
