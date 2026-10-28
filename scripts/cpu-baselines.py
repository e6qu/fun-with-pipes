#!/usr/bin/env python3
"""Measure and freeze repeated baselines for the two named CPU gaps."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import re
import statistics
import subprocess
import time


PROGRAMS = ('loop', 'text-length')
KINDS = ('c', 'rs', 'fwp', 'identical')


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n')


def check_case(name, row, settings):
    """Recompute every statistic from complete, ordered process observations."""
    count = settings['samples']
    process_count = settings['processes'][name]
    assert isinstance(process_count, int) and process_count > 0
    assert count >= 8 and count % 4 == 0
    assert settings['warmups'] >= 2
    assert settings['cpuPolicy'] == 'all' and math.isfinite(settings['timeout']) and settings['timeout'] > 0
    assert 1 < settings['maxControlRatio'] <= settings['maxPairRatio']
    assert math.isfinite(settings['maxPairRatio'])
    assert row['stdout'] and set(row['binaries']) == set(KINDS)
    assert row['binaries']['fwp'] == row['binaries']['identical']
    for binary in row['binaries'].values():
        assert re.fullmatch('[0-9a-f]{64}', binary['sha256']) and binary['bytes'] > 0
    observations = row['observations']
    assert len(observations) == 4 * (settings['warmups'] + count)
    times = {kind: [] for kind in KINDS}
    for index, observation in enumerate(observations):
        round_index, position = divmod(index, 4)
        warmup = round_index < settings['warmups']
        phase_round = round_index if warmup else round_index - settings['warmups']
        kind = KINDS[(phase_round + position) % 4]
        assert (observation['kind'], observation['phase'], observation['round']) == (
            kind, 'warmup' if warmup else 'sample', phase_round)
        processes = observation['processes']
        assert len(processes) == process_count
        for process in processes:
            assert process['status'] == 0 and not process['stderr']
            assert process['stdout'] == row['stdout']
            assert math.isfinite(process['seconds']) and process['seconds'] > 0
        assert observation['seconds'] == sum(p['seconds'] for p in processes)
        assert observation['binarySha256'] == row['binaries'][kind]['sha256']
        if not warmup:
            times[kind].append(observation['seconds'])
    medians = {kind: statistics.median(values) for kind, values in times.items()}
    control = max(medians['fwp'], medians['identical']) / min(medians['fwp'], medians['identical'])
    pair_ratios = sorted(max(a, b) / min(a, b) for a, b in zip(times['fwp'], times['identical'], strict=True))
    # Nearest-rank 95th percentile, including both directions of each difference.
    spread = pair_ratios[math.ceil(0.95 * count) - 1]
    stable = control <= settings['maxControlRatio'] and spread <= settings['maxPairRatio']
    return dict(medianBatchSeconds=medians, controlRatio=control, pairRatio95=spread,
                fwpOverC=medians['fwp'] / medians['c'],
                fwpOverRust=medians['fwp'] / medians['rs'],
                decision='stable' if stable else 'inconclusive')


def freeze(reports):
    """Require two independent jobs per architecture before fixing budgets."""
    assert len(reports) >= 4, 'need two independent sessions on each architecture'
    source, settings = reports[0]['source'], reports[0]['settings']
    assert re.fullmatch('[0-9a-f]{40}', source)
    groups = {}
    identities = set()
    for report in reports:
        assert report['source'] == source and report['settings'] == settings
        identity = (report['run'], report['architecture'], report['session'])
        assert identity not in identities, 'duplicate session'
        identities.add(identity)
        assert report['architecture'] in ('x86_64', 'aarch64') and report['session'] in (1, 2)
        assert set(report['programs']) == set(PROGRAMS)
        assert report['host']['model'] and report['toolchains']
        groups.setdefault(report['architecture'], []).append(report)
        for name, row in report['programs'].items():
            assert row['result'] == check_case(name, row, settings), 'stored statistics differ'
            memory = row['memory']
            assert memory['leakDetected']
            profiles = memory['managedMemory']['ordinary']['profiles']
            leaked = memory['managedMemory']['injected-leak']['profiles']
            assert len(profiles) >= 3 and len(leaked) == len(profiles)
            assert all(p == profiles[0] for p in profiles)
            assert profiles[0]['finalChargedBytes'] == 0
            for p in leaked:
                assert p['finalChargedBytes'] > 0
                assert p['requests'] == profiles[0]['requests'] + 1
                assert p['requestedBytes'] == profiles[0]['requestedBytes'] + 16
                assert p['retains'] == profiles[0]['retains']
            for kind in ('c', 'rs', 'fwp'):
                observed = memory['processMemory'][kind]
                assert observed['binarySha256'] == row['binaries'][kind]['sha256']
                assert len(observed['peakRssKiB']) >= 3 and all(n > 0 for n in observed['peakRssKiB'])
            assert row['textBytes'] and set(row['textBytes']) == {'c', 'rs', 'fwp'}
            assert all(n > 0 for n in row['textBytes'].values())
            assert set(row['inputs']) == {'c', 'rs', 'fwp'}
            assert all(re.fullmatch('[0-9a-f]{64}', value) for value in row['inputs'].values())
            assert row['instrumentedStack'] and all(text.strip() for text in row['instrumentedStack'].values()), 'missing separately instrumented stack reports'
    assert set(groups) == {'x86_64', 'aarch64'}
    rows, selected = [], set()
    for architecture, sessions in sorted(groups.items()):
        sessions.sort(key=lambda report: (report['run'], report['session']))
        assert all(r['toolchains'] == sessions[0]['toolchains'] for r in sessions), 'toolchains changed between sessions'
        assert all(r['programs'][name]['inputs'] == sessions[0]['programs'][name]['inputs']
                   for r in sessions for name in PROGRAMS), 'benchmark work changed between sessions'
        pair = None
        for index, second in enumerate(sessions):
            earlier = [first for first in sessions[:index] if first['host'] == second['host']]
            if earlier:
                pair = [earlier[0], second]
                break
        assert pair is not None, 'different CPU models need their own repeated baseline'
        first, second = pair
        selected.update((r['run'], architecture, r['session']) for r in pair)
        for name in PROGRAMS:
            a, b = (r['programs'][name] for r in pair)
            assert all(row['result']['decision'] == 'stable' for row in [a, b]), f'{name}: inconclusive control'
            assert a['inputs'] == b['inputs'], 'benchmark work changed between sessions'
            spread = max(a['result']['pairRatio95'], b['result']['pairRatio95'])
            rows.append(dict(architecture=architecture, host=first['host'], toolchains=first['toolchains'], program=name,
                             maxCandidateRatio=1 + 2 * (spread - 1),
                             maxRatioForImprovement=1 / (1 + 2 * (spread - 1)),
                             maxControlPairRatio=spread,
                             baseline=[a['result'], b['result']], inputs=a['inputs'],
                             sessions=[dict(run=r['run'], session=r['session']) for r in pair]))
    additional = [dict(run=r['run'], architecture=r['architecture'], session=r['session'], host=r['host'],
                       results={name: row['result'] for name, row in r['programs'].items()})
                  for r in sorted(reports, key=lambda r: (r['run'], r['architecture'], r['session']))
                  if (r['run'], r['architecture'], r['session']) not in selected]
    return dict(source=source, settings=settings, rows=rows, additionalSessions=additional,
                selection='Order jobs by workflow run and session label per architecture; use the first repeated CPU model, independent of its speed or noise result. Preserve and validate every additional session.',
                rule='Future same-session candidate/baseline median ratio must be <= 1 + twice the larger baseline-session 95th-percentile identical-code deviation. A speedup claim additionally needs a ratio below the reciprocal limit. Its control must stay inside the frozen control envelope. These are empirical decision limits, not statistical confidence guarantees. Never compare wall times from different jobs as a speedup.',
                scope='Only loop and text-length on these CPUs/toolchains. Other programs and architectures require their own baselines.')


def measure(args):
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert platform.machine() == args.architecture
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
    assert args.samples >= 8 and args.samples % 4 == 0 and args.warmups >= 2
    assert math.isfinite(args.timeout) and args.timeout > 0
    assert args.loop_processes > 0 and args.text_processes > 0
    assert 1 < args.max_control_ratio <= args.max_pair_ratio and math.isfinite(args.max_pair_ratio)
    args.output.mkdir(parents=True, exist_ok=False)
    inspection = json.loads(args.inspection.read_text())
    memory = json.loads((args.memory / 'report.json').read_text())
    memory_check = json.loads(args.memory_inspection.read_text())
    assert all(r['source'] == args.source and r['architecture'] == args.architecture
               for r in [inspection, memory, memory_check])
    assert inspection['ownership'] == memory['ownership'] == 'counted'
    assert memory['inspectionSha256'] == digest(args.inspection)
    assert memory_check['reportSha256'] == digest(args.memory / 'report.json')
    directory, = (args.input / args.source).iterdir()
    original = (directory / 'report.md').read_text()
    assert digest(directory / 'report.md') == inspection['reportSha256']
    # These sections include the exact versions and flags from the original build.
    toolchains = original.split('C compiler (', 1)[1].split('| Program | C | Rust | fwp |', 1)[0]
    cpu = json.loads(subprocess.check_output(['lscpu', '-J'], text=True))
    fields = {row['field']: row['data'] for row in cpu['lscpu']}
    report = dict(source=args.source, architecture=args.architecture,
                  run=int(os.environ['GITHUB_RUN_ID']), session=args.session,
                  host=dict(model=fields['Model name:'], vendor=fields['Vendor ID:'], architecture=fields['Architecture:'],
                            allowedCpuCount=len(os.sched_getaffinity(0))),
                  toolchains=toolchains,
                  settings=dict(samples=args.samples, warmups=args.warmups, cpuPolicy=args.cpu_policy, timeout=args.timeout,
                                processes={'loop': args.loop_processes, 'text-length': args.text_processes},
                                maxControlRatio=args.max_control_ratio, maxPairRatio=args.max_pair_ratio),
                  scope='Sum of fresh-process wall times in each explicitly sized batch, including startup, computation, output and cleanup; compilation and evidence writes excluded. Same checked work as the seven-peer suite. Memory profiles are separate and never timed. No C/Rust allocation-count claim.',
                  evidence=dict(inspection=digest(args.inspection), memory=digest(args.memory / 'report.json'),
                                memoryInspection=digest(args.memory_inspection)), programs={})
    environment = {k: v for k, v in os.environ.items() if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_LTO='0', LC_ALL='C')
    for name in PROGRAMS:
        old, = [p for p in inspection['programs'] if p['name'] == name]
        mem, = [p for p in memory['programs'] if p['name'] == name]
        paths = {kind: directory / f'{name}-{kind if kind != "identical" else "fwp"}' for kind in KINDS}
        binaries = {kind: dict(sha256=digest(p), bytes=p.stat().st_size) for kind, p in paths.items()}
        for kind in ('c', 'rs', 'fwp'):
            assert binaries[kind]['sha256'] == old['files'][kind]['binarySha256']
        row = dict(stdout=old['stdout'], binaries=binaries, inputs={}, memory=mem,
                   textBytes={kind: old['files'][kind]['textSectionBytes'] for kind in ('c', 'rs', 'fwp')},
                   instrumentedStack={p.name: p.read_text() for p in args.memory.glob(name + '-ordinary*.su')},
                   observations=[])
        for kind in ('c', 'rs', 'fwp'):
            p = directory / f'{name}-source.{kind}'
            assert digest(p) == old['files'][kind]['sourceSha256']
            row['inputs'][kind] = digest(p)
        report['programs'][name] = row
        write_json(args.output / 'report.json', report)
        for phase, rounds in [('warmup', args.warmups), ('sample', args.samples)]:
            for index in range(rounds):
                for position in range(4):
                    kind = KINDS[(index + position) % 4]
                    observation = dict(kind=kind, phase=phase, round=index,
                                       binarySha256=binaries[kind]['sha256'], processes=[], seconds=0)
                    row['observations'].append(observation)
                    for process_index in range(report['settings']['processes'][name]):
                        start = time.perf_counter()
                        try:
                            result = subprocess.run([str(paths[kind].resolve())], env=environment,
                                                    capture_output=True, text=True, timeout=args.timeout)
                        except subprocess.TimeoutExpired as error:
                            write_json(args.output / 'report.json', report)
                            write_json(args.output / 'timeout.json', dict(program=name, kind=kind, phase=phase,
                                       round=index, process=process_index, timeout=args.timeout,
                                       stdout=(error.stdout or b'').decode(errors='replace'),
                                       stderr=(error.stderr or b'').decode(errors='replace')))
                            raise
                        elapsed = time.perf_counter() - start
                        observation['processes'].append(dict(seconds=elapsed, status=result.returncode,
                                                            stdout=result.stdout, stderr=result.stderr))
                        observation['seconds'] += elapsed
                        if result.returncode != 0 or result.stdout != row['stdout'] or result.stderr:
                            write_json(args.output / 'report.json', report)
                            raise AssertionError(f'{name}/{kind}: unexpected process result: {result}')
                    write_json(args.output / 'report.json', report)
        row['result'] = check_case(name, row, report['settings'])
        write_json(args.output / 'report.json', report)
    print(json.dumps({name: row['result'] for name, row in report['programs'].items()}, indent=2))
    assert all(row['result']['decision'] == 'stable' for row in report['programs'].values()), 'inconclusive baseline; retain evidence and repair measurement'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest='command', required=True)
    run = commands.add_parser('measure')
    for name in ['input', 'inspection', 'memory', 'memory-inspection', 'output']:
        run.add_argument('--' + name, type=Path, required=True)
    run.add_argument('--source', required=True)
    run.add_argument('--cpu-policy', choices=['all'], required=True)
    run.add_argument('--architecture', choices=['x86_64', 'aarch64'], required=True)
    run.add_argument('--session', type=int, choices=[1, 2], required=True)
    for name in ['samples', 'warmups', 'loop-processes', 'text-processes']:
        run.add_argument('--' + name, type=int, required=True)
    for name in ['timeout', 'max-control-ratio', 'max-pair-ratio']:
        run.add_argument('--' + name, type=float, required=True)
    for command, argument in [('freeze', '--output'), ('verify', '--table')]:
        collect = commands.add_parser(command)
        collect.add_argument('--reports', type=Path, nargs='+', required=True)
        collect.add_argument(argument, dest='table', type=Path, required=True)
    args = parser.parse_args()
    if args.command == 'measure':
        measure(args)
    else:
        result = freeze([json.loads(p.read_text()) for p in args.reports])
        result['records'] = sorted(digest(p) for p in args.reports)
        if args.command == 'freeze':
            assert not args.table.exists(), 'preserve frozen budgets'
            write_json(args.table, result)
        else:
            assert json.loads(args.table.read_text()) == result, 'frozen table differs from the original baseline evidence'
            print('Frozen CPU limits match every original baseline record')


if __name__ == '__main__':
    main()
