#!/usr/bin/env python3
"""Collect or independently verify the frozen known-scalar fold comparison."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import shutil
import signal
import statistics
import subprocess

from process_wait import WAIT_POLICY

SPEC = importlib.util.spec_from_file_location('buffer_check', Path(__file__).with_name('check-buffer-baselines.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
SPEC = importlib.util.spec_from_file_location('buffer_measure', Path(__file__).with_name('measure-buffer-baselines.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)
BASELINE = CHECK.BASELINE
REFERENCE = 'fadebf713e0854d6d132fc6e3666f275b214fc17'
REFERENCE_IMAGES = {
    'aarch64': '8a8c997541855eca80ed6e26ad23ed073c2dd5bf6afd7602a4eb7d26b644c20a',
    'x86_64': '107ed04e00cd440c56fb64b9e20396e4aca2bc7128b6f582c97ab6fe1ecee6e3',
}
LABELS = ('old0', 'old1', 'old2', 'new0', 'new1', 'new2')
FAMILIES = ('old', 'new')
ENVIRONMENT = dict(PATH='/usr/bin:/bin', LANG='C', LC_ALL='C', TZ='UTC')
LENGTH, CALLS = 4096, 256


def summarize(rows):
    elapsed, cpu = BASELINE.round_totals(rows, 'scan', LENGTH, CALLS, LABELS)
    medians = {label: statistics.median(values) for label, values in elapsed.items()}
    controls = {}
    totals = {}
    for family in FAMILIES:
        labels = [family + str(index) for index in range(3)]
        values = [medians[label] for label in labels]
        controls[family] = max(values) / min(values)
        totals[family] = [sum(elapsed[label][index] for label in labels) for index in range(BASELINE.ROUNDS)]
    family_medians = {family: statistics.median(values) for family, values in totals.items()}
    ratio = family_medians['new'] / family_medians['old']
    return dict(roundElapsedNs=elapsed, roundCpuNs=cpu, medianRoundElapsedNs=medians,
        familyRoundElapsedNs=totals, familyMedianRoundElapsedNs=family_medians,
        copyRatios=controls, copyControlLimit=1.02,
        copyControlPassed=all(value <= 1.02 for value in controls.values()),
        candidateReferenceRatio=ratio, elapsedRatioLimit=0.90, elapsedPassed=ratio <= 0.90)


def check_inputs(folder, source, machine, qualification):
    programs = {}
    for family, revision in [('old', REFERENCE), ('new', source)]:
        record = CHECK.check_build(folder / family, revision, machine, qualification)
        programs[family] = record['entries']['scan']['fwp']
    assert programs['old']['sha256'] == REFERENCE_IMAGES[machine], 'reference differs from the frozen session'
    assert programs['new']['sha256'] != programs['old']['sha256'], 'candidate is unchanged'
    return programs


def code_budget(programs):
    old, new = [programs[family] for family in FAMILIES]
    old_dynamic = {row['location'].rsplit(':', 1)[-1]: row for row in old['frames'] if row['kind'] != 'static'}
    new_dynamic = {row['location'].rsplit(':', 1)[-1]: row for row in new['frames'] if row['kind'] != 'static'}
    # A dynamic report is not a whole-stack bound. Preserve every remaining
    # dynamic function's classification and fixed component independently.
    dynamic_ok = all(name in old_dynamic and row['kind'] == old_dynamic[name]['kind']
                     and row['bytes'] <= old_dynamic[name]['bytes'] for name, row in new_dynamic.items())
    frame_sizes = {family: max(row['bytes'] for row in programs[family]['frames']) for family in FAMILIES}
    ratio = new['sections']['.text'] / old['sections']['.text']
    return dict(textRatio=ratio, textRatioLimit=1.05, textPassed=ratio <= 1.05,
        maximumReportedFrameBytes=frame_sizes, dynamicFrames={family: [row for row in programs[family]['frames']
            if row['kind'] != 'static'] for family in FAMILIES},
        stackPassed=dynamic_ok and frame_sizes['new'] <= frame_sizes['old'])


def manifest(folder):
    values = {path.relative_to(folder).as_posix(): dict(bytes=path.stat().st_size,
        sha256=hashlib.sha256(path.read_bytes()).hexdigest()) for path in sorted(folder.rglob('*'))
        if path.is_file() and path != folder / 'manifest.json'}
    (folder / 'manifest.json').write_text(json.dumps(values, indent=2) + '\n')


def check_evidence(folder, source, machine, session, origin, wait_policy):
    CHECK.check_manifest(folder)
    config = json.loads((folder / 'configuration.json').read_text())
    assert origin in ['observed', 'synthetic'] and config['origin'] == origin
    assert wait_policy in ['timed-polling', 'posix-alarm']
    if wait_policy == 'timed-polling':
        assert 'waitPolicy' not in config
    else:
        assert config['waitPolicy'] == wait_policy
    assert config['source'] == source and config['reference'] == REFERENCE and config['session'] == session
    assert config['environment'] == ENVIRONMENT and config['timeout'] == 45 and config['cpuPolicy'] == 'all'
    assert config['labels'] == list(LABELS) and config['length'] == LENGTH and config['calls'] == CALLS
    assert config['rounds'] == 36 and config['warmups'] == 2 and config['processes'] == 12 and config['seed'] == 20261030
    affinity = config['affinity']
    assert len(affinity) == 4 and affinity == sorted(set(affinity))
    assert all(type(cpu) is int and cpu >= 0 for cpu in affinity)
    assert str(config['run']).isdecimal() and str(config['attempt']).isdecimal()
    BASELINE.check_host(config['qualification'], source, machine)
    programs = check_inputs(folder, source, machine, config['qualification'])
    for label in LABELS:
        assert hashlib.sha256((folder / (label + '.exe')).read_bytes()).hexdigest() == programs[label[:3]]['sha256']
    root = Path(config['directory'])
    assert root.is_absolute()
    rows = [json.loads(line) for line in (folder / 'observations.jsonl').read_text().splitlines()]
    for row in rows:
        assert row['command'] == [str(root / (row['label'] + '.exe')), 'scan', str(LENGTH), str(CALLS)]
    expected = dict(source=source, reference=REFERENCE, session=session, origin=origin,
        timing=summarize(rows), code=code_budget(programs),
        decision='Timing/code evidence only; semantic and storage gates are required separately.')
    assert json.loads((folder / 'report.json').read_text()) == expected, 'summary disagrees with retained observations'
    return expected


def collect(args):
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.timeout == 45
    source = os.environ['GITHUB_SHA']
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == source
    machine = platform.machine()
    qualification = json.loads(args.qualification.read_text())
    BASELINE.check_host(qualification, source, machine)
    assert len(os.sched_getaffinity(0)) == 4
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    for family, path in [('old', args.reference), ('new', args.candidate)]:
        shutil.copytree(path, out / family)
    programs = check_inputs(out, source, machine, qualification)
    config = dict(source=source, reference=REFERENCE, origin='observed', waitPolicy=WAIT_POLICY, session=args.session,
        directory=str(out), environment=ENVIRONMENT, timeout=args.timeout, cpuPolicy=args.cpu_policy,
        affinity=sorted(os.sched_getaffinity(0)), labels=list(LABELS), length=LENGTH, calls=CALLS,
        rounds=BASELINE.ROUNDS, warmups=BASELINE.WARMUPS, processes=BASELINE.PROCESSES, seed=BASELINE.SEED,
        qualification=qualification, run=os.environ['GITHUB_RUN_ID'], attempt=os.environ['GITHUB_RUN_ATTEMPT'],
        platform=platform.platform(), python=platform.python_version(),
        scope='Serial whole child including spawn, startup, checked work, output and cleanup; excludes artifact writes.')
    (out / 'configuration.json').write_text(json.dumps(config, indent=2) + '\n')
    for label in LABELS:
        family = label[:3]
        shutil.copyfile(out / family / programs[family]['binary'], out / (label + '.exe'))
        (out / (label + '.exe')).chmod(0o755)
    rows = []
    with (out / 'observations.jsonl').open('x', buffering=1) as log:
        for warmup, rounds in [(True, BASELINE.WARMUPS), (False, BASELINE.ROUNDS)]:
            for index in range(rounds):
                for position, label in enumerate(BASELINE.execution_order(index, BASELINE.SEED, BASELINE.PROCESSES, LABELS)):
                    row = MEASURE.measure_process([out / (label + '.exe'), 'scan', LENGTH, CALLS], ENVIRONMENT, args.timeout)
                    row.update(entry='scan', length=LENGTH, calls=CALLS, warmup=warmup, round=index, position=position, label=label)
                    log.write(json.dumps(row) + '\n')
                    rows.append(row)
                    BASELINE.check_result(row, 'scan', LENGTH, CALLS)
    report = dict(source=source, reference=REFERENCE, session=args.session, origin='observed',
        timing=summarize(rows), code=code_budget(programs),
        decision='Timing/code evidence only; semantic and storage gates are required separately.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    manifest(out)
    check_evidence(out, source, machine, args.session, 'observed', WAIT_POLICY)
    print('Retained and verified all 2,736 ordinary processes; no failed control is retried.')
    print(json.dumps({key: value for key, value in report['timing'].items() if not isinstance(value, dict)}))


def main():
    signal.signal(signal.SIGTERM, MEASURE.cancel)
    parser = argparse.ArgumentParser(description=__doc__)
    modes = parser.add_subparsers(dest='mode', required=True)
    collect_parser = modes.add_parser('collect')
    for name in ['reference', 'candidate', 'qualification', 'output']:
        collect_parser.add_argument('--' + name, type=Path, required=True)
    collect_parser.add_argument('--cpu-policy', choices=['all'], required=True)
    collect_parser.add_argument('--timeout', type=int, required=True)
    check_parser = modes.add_parser('check')
    check_parser.add_argument('--input', type=Path, required=True)
    check_parser.add_argument('--source', required=True)
    check_parser.add_argument('--machine', choices=['aarch64', 'x86_64'], required=True)
    check_parser.add_argument('--wait-policy', choices=['timed-polling', 'posix-alarm'], required=True)
    check_parser.add_argument('--origin', choices=['observed', 'synthetic'], required=True)
    for sub in [collect_parser, check_parser]:
        sub.add_argument('--session', type=int, choices=[1, 2], required=True)
    args = parser.parse_args()
    if args.mode == 'collect':
        collect(args)
    else:
        check_evidence(args.input, args.source, args.machine, args.session, args.origin, args.wait_policy)
        print('Verified all files, exact builds, copies and 2,736 ordered observations.')


if __name__ == '__main__':
    main()
