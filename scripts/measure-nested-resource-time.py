#!/usr/bin/env python3
"""Time ordinary reference/candidate services after a verified contemporary peer comparison."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import shutil
import subprocess
import sys
import time
import traceback

from nested_resource_timing import LABELS, order, summarize
from process_wait import run_capture
from weak_callback_service_build import build_native
from weak_callback_source import boundary
from weak_callback_timing import CASES, COPY_LIMIT, MINIMUM_NS, PILOT_NS, ROUNDS, decode_output

ROOT = Path(__file__).resolve().parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('reference', 'peers', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('source', 'reference-source', 'arch', 'cc', 'c-arch', 'time', 'objdump', 'readelf'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source == os.environ['GITHUB_SHA']
    peers = args.peers.resolve()
    subprocess.run([sys.executable, ROOT / 'scripts/measure-weak-callback-service.py', 'audit',
                    '--input', peers, '--source', args.source, '--arch', args.arch], check=True)
    peer_report = json.loads((peers / 'report.json').read_text())
    for key in ('cc', 'c_arch', 'time', 'objdump', 'readelf'):
        assert peer_report['settings'][key] == getattr(args, key)
    assert args.reference_source == '65719f7fc2277a5b97c5a790df941fea6c5eb4d7'
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', CC=args.cc, FWP_LTO='0', FWP_STACK='1')
    report = dict(source=args.source, architecture=args.arch, root=str(folder),
                  host=platform.uname()._asdict(), settings={key: str(value) for key, value in vars(args).items()},
                  peerManifestSha256=digest(peers / 'manifest.json'), referenceSource=args.reference_source,
                  referenceCompilerSha256=digest(args.reference),
                  protocol=dict(labels=LABELS, rounds=ROUNDS, pilotNs=PILOT_NS,
                                minimumNs=MINIMUM_NS, copyLimit=COPY_LIMIT),
                  compile=[], binaries={}, sessions={}, failures=[],
                  scope='Ordinary complete service calls, including entry/result ownership. '
                        'Reuses audited C-only pilots from the preceding peer experiment on this host. '
                        'Service timing excludes process startup and printed-result checks; process timing includes them. '
                        'No profiler or ownership counters. RSS is a separate whole-process high-water measurement.')
    commands = []

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def run(command, expected, environment):
        command = list(map(str, command))
        start = time.perf_counter_ns()
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=180, check=False)
            row = dict(status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        except subprocess.TimeoutExpired as error:
            row = dict(status=None, stdout=str(error.stdout), stderr=str(error.stderr))
        row.update(command=command, index=len(commands), elapsedNs=time.perf_counter_ns() - start)
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0] and row['stderr'] == expected[2], row
        assert expected[1] is None or row['stdout'] == expected[1], row
        return row

    def compile_run(command, expected, environment):
        metrics = folder / f'compile-{len(report["compile"])}.txt'
        row = run([args.time, '-f', '%e %M', '-o', metrics, *command], expected, environment)
        seconds, rss = metrics.read_text().split()
        assert math.isfinite(float(seconds)) and float(seconds) >= 0 and int(rss) > 0
        report['compile'].append(dict(command=row['index'], seconds=float(seconds), peakRssKiB=int(rss), file=metrics.name))
        save()
        return row

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

    report['cpu'] = run(['lscpu'], (0, None, ''), env)['stdout']
    report['ccVersion'] = run([args.cc, '--version'], (0, None, ''), env)['stdout']
    assert report['ccVersion'] == peer_report['versions']['cc']
    source = folder / 'reference.c'
    compile_run([args.reference.resolve(), 'build', '--fn', 'service', '--memory', 'dynamic', '--emit-c', '-O2',
                 ROOT / 'tests/fixtures/weak_callback_service.fwp', '-o', source], (0, '', ''), env)
    assert 'protected by enclosing frame' not in source.read_text()
    assert 'protected by enclosing frame' in (peers / 'original.c').read_text()
    clock = folder / 'clock.o'
    shutil.copyfile(peers / 'clock.o', clock)
    caller = (ROOT / 'tests/fixtures/weak_callback_service_time.c').read_text()
    reference, linked = build_native(args, folder, 'fwp', boundary(source.read_text()), 'reference', 2,
                                     'plain', False, clock, caller, compile_run, env)
    candidate = folder / 'candidate'
    shutil.copy2(peers / peer_report['binaries']['fwp']['path'], candidate)
    assert digest(candidate) == peer_report['binaries']['fwp']['binarySha256']
    binaries = {}
    for role, binary in (('reference', reference), ('candidate', candidate)):
        image = binary.read_bytes()
        assert image[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
        copy = folder / (role + '-copy')
        shutil.copy2(binary, copy)
        assert digest(copy) == digest(binary)
        binaries[role], binaries[role + '-copy'] = binary, copy
        metadata = dict(path=str(binary.relative_to(folder)), copyPath=copy.name,
                        sha256=digest(binary), bytes=binary.stat().st_size)
        for kind, command in (('sections', [args.objdump, '--section-headers', binary]),
                              ('frames', [args.readelf, '--debug-dump=frames-interp', binary]),
                              ('libraries', ['ldd', binary])):
            row = run(command, (0, None, ''), env)
            path = folder / f'{role}-{kind}.txt'
            path.write_text(row['stdout'])
            metadata[kind] = path.name
        report['binaries'][role] = metadata
    report['referenceLinkCommand'] = linked['index']
    save()
    for session in (1, 2):
        cases = report['sessions'][str(session)] = {}
        for population, mode in CASES:
            key = f'{population}-{mode}'
            case = cases[key] = dict(batches=peer_report['pilots'][key]['batches'], warmups=[], samples=[], memory={})
            try:
                for round_number in range(-2, ROUNDS):
                    for position, label in enumerate(order(round_number + 2 if round_number < 0 else round_number)):
                        row = run([binaries[label], population, mode, case['batches']], (0, None, ''), env)
                        phases = decode_output(row['stdout'], population, mode, case['batches'])
                        observation = dict(label=label, command=row['index'])
                        if round_number < 0:
                            case['warmups'].append(observation)
                        else:
                            case['samples'].append(observation | dict(round=round_number, position=position,
                                ns=dict(service=phases['serviceNs'], process=row['elapsedNs'])))
                    save()
                case['summary'] = summarize(case['samples'], population)
                for role in ('reference', 'candidate'):
                    case['memory'][role] = []
                    for sample in range(3):
                        rss = folder / f'rss-{session}-{key}-{role}-{sample}.txt'
                        row = run([args.time, '-f', '%M', '-o', rss, binaries[role], population, mode, case['batches']], (0, None, ''), env)
                        decode_output(row['stdout'], population, mode, case['batches'])
                        value = int(rss.read_text())
                        assert value > 0
                        case['memory'][role].append(dict(command=row['index'], peakRssKiB=value, file=rss.name))
                peaks = {role: max(row['peakRssKiB'] for row in rows) for role, rows in case['memory'].items()}
                case['peakRssRatio'] = peaks['candidate'] / peaks['reference']
                case['rssTargetMet'] = case['peakRssRatio'] <= 1.05
                print('RESULT', session, key, json.dumps(case['summary']), case['peakRssRatio'], flush=True)
            except Exception as error:
                failure(f'{session}/{key}', error)
            save()
    (folder / 'manifest.json').write_text(json.dumps(
        {str(path.relative_to(folder)): digest(path) for path in sorted(folder.rglob('*')) if path.is_file()}, indent=2) + '\n')
    assert not report['failures'], report['failures']


if __name__ == '__main__':
    main()
