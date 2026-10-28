#!/usr/bin/env python3
"""Runner experiment for proved range-index and character-count additions."""
import argparse
import hashlib
import json
import math
import os
from pathlib import Path
import platform
import re
import shutil
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
FILES = ('src/fuse.rs', 'src/cgen/scalar_text.rs')
VARIANTS = ('baseline', 'index', 'length', 'both')
KINDS = ('c', 'rs', *VARIANTS, 'identical')
PROGRAMS = ('loop', 'text-length')
BASELINE = 'ec03d9cd81c001bf006a73e7dbfb044155884611'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def write_json(path, value):
    path.write_text(json.dumps(value, indent=2, allow_nan=False) + '\n')


def output(command):
    return subprocess.check_output(list(map(str, command)), cwd=ROOT, text=True).strip()


def qualify(table, host, compilers, inputs):
    assert table['source'] == BASELINE, 'wrong baseline revision'
    rows = [r for r in table['rows'] if r['host'] == host]
    assert len(rows) == 2 and {r['program'] for r in rows} == set(PROGRAMS), 'host needs its own repeated baseline before candidate timing'
    for row in rows:
        versions = re.findall(r'```text\n(.*?)\n```', row['toolchains'], re.S)
        assert versions == compilers, 'toolchains differ from frozen baseline'
        assert row['inputs'] == inputs[row['program']], 'benchmark inputs changed'
    return {r['program']: r for r in rows}


def check_case(name, row, settings, budget):
    """Recompute a decision; incomplete or reordered observations are invalid."""
    assert settings == dict(samples=56, warmups=2, processes={'loop': 1, 'text-length': 32}, timeout=120, cpuPolicy='all')
    assert set(row['binaries']) == set(KINDS)
    assert row['binaries']['baseline'] == row['binaries']['identical']
    assert row['stdout'] == {'loop': '300000003\n', 'text-length': '28518516\n'}[name]
    for binary in row['binaries'].values():
        assert re.fullmatch('[0-9a-f]{64}', binary['sha256']) and binary['bytes'] > 0
    observations = row['observations']
    assert len(observations) == 7 * (settings['samples'] + settings['warmups'])
    times = {kind: [] for kind in KINDS}
    for index, observation in enumerate(observations):
        round_index, position = divmod(index, 7)
        warmup = round_index < settings['warmups']
        phase_round = round_index if warmup else round_index - settings['warmups']
        kind = KINDS[(phase_round + position) % 7]
        assert (observation['kind'], observation['phase'], observation['round']) == (
            kind, 'warmup' if warmup else 'sample', phase_round)
        assert observation['binarySha256'] == row['binaries'][kind]['sha256']
        processes = observation['processes']
        assert len(processes) == settings['processes'][name]
        for process in processes:
            assert process['status'] == 0 and not process['stderr'] and process['stdout'] == row['stdout']
            assert math.isfinite(process['seconds']) and process['seconds'] > 0
        assert observation['seconds'] == sum(p['seconds'] for p in processes)
        if not warmup:
            times[kind].append(observation['seconds'])
    medians = {kind: statistics.median(values) for kind, values in times.items()}
    control = max(medians['baseline'], medians['identical']) / min(medians['baseline'], medians['identical'])
    pairs = sorted(max(a, b) / min(a, b) for a, b in zip(times['baseline'], times['identical'], strict=True))
    spread = pairs[math.ceil(0.95 * settings['samples']) - 1]
    stable = control <= 1.03 and spread <= budget['maxControlPairRatio']
    ratios = {kind: medians[kind] / medians['baseline'] for kind in VARIANTS[1:]}
    return dict(medianBatchSeconds=medians, controlRatio=control, pairRatio95=spread,
                control='stable' if stable else 'inconclusive', candidateOverBaseline=ratios,
                candidateOverC={k: medians[k] / medians['c'] for k in VARIANTS},
                candidateOverRust={k: medians[k] / medians['rs'] for k in VARIANTS},
                withinRegression={k: stable and r <= budget['maxCandidateRatio'] for k, r in ratios.items()},
                improvement={k: stable and r < budget['maxRatioForImprovement'] for k, r in ratios.items()})


def check_report(report, table):
    assert report['baseline'] == BASELINE and re.fullmatch('[0-9a-f]{40}', report['candidate'])
    budgets = qualify(table, report['host'], report['compilers'], report['inputs'])
    assert set(report['programs']) == set(PROGRAMS)
    for name, row in report['programs'].items():
        assert row['result'] == check_case(name, row, report['settings'], budgets[name]), 'stored decision differs'
    return [kind for kind in VARIANTS[1:]
            if all(report['programs'][name]['result']['withinRegression'][kind] for name in PROGRAMS)
            and report['programs']['text-length']['result']['improvement'][kind]]


def experiment(args):
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.architecture == platform.machine()
    assert output(['git', 'rev-parse', 'HEAD']) == args.source
    assert not output(['git', 'status', '--porcelain', '--untracked-files=no']), 'start with committed source'
    assert output(['git', 'diff', '--name-only', BASELINE, args.source, '--', 'src', 'runtime', 'lib', 'bench', 'Cargo.toml', 'Cargo.lock', 'build.rs']).splitlines() == sorted(FILES), 'unexpected compiler/runtime/library changes'
    args.output = args.output.resolve()
    args.output.mkdir(parents=True, exist_ok=False)
    table = json.loads(args.table.read_text())
    cpu = {r['field']: r['data'] for r in json.loads(output(['lscpu', '-J']))['lscpu']}
    host = dict(model=cpu['Model name:'], vendor=cpu['Vendor ID:'], architecture=cpu['Architecture:'], allowedCpuCount=len(os.sched_getaffinity(0)))
    compilers = [output([args.cc, '--version']), output([args.rustc, '-vV'])]
    inputs = {name: {kind: digest(ROOT / f'bench/{name}/main.{kind}') for kind in ('c', 'rs', 'fwp')} for name in PROGRAMS}
    report = dict(baseline=BASELINE, candidate=args.source, architecture=args.architecture,
                  run=int(os.environ['GITHUB_RUN_ID']), host=host, compilers=compilers, inputs=inputs,
                  tableSha256=digest(args.table), variants={}, programs={},
                  settings=dict(samples=56, warmups=2, processes={'loop': 1, 'text-length': 32}, timeout=120, cpuPolicy='all'),
                  scope='Fresh-process wall time including startup, calculation, output and cleanup. Compilation, memory profiles and evidence writes excluded. All samples retained. Variant patches identify the compiler source; nested benchmark reports use the harness checkout revision.')
    write_json(args.output / 'report.json', report)
    budgets = qualify(table, host, compilers, inputs)  # Before any candidate timing.
    environment = {k: v for k, v in os.environ.items() if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', LC_ALL='C', RUST_TEST_THREADS='1')

    def run(command, log):
        print('Running:', ' '.join(map(str, command)), flush=True)
        with log.open('wb') as stream:
            result = subprocess.run(list(map(str, command)), cwd=ROOT, env=environment,
                                    stdout=stream, stderr=subprocess.STDOUT, timeout=1800)
        if result.returncode:
            print(log.read_text(errors='replace')[-16000:], flush=True)
        assert result.returncode == 0, (command, result.returncode, str(log))

    # The existing peer audit covers all seven programs, including overflow and
    # deliberately broken checks. Keep its original evidence, not a two-row proxy.
    run(['python3', 'scripts/check-benchmark-peers.py', '--source', args.source, '--cc', args.cc,
         '--rustc', args.rustc, '--arch', args.architecture, '--output', args.output / 'peers'], args.output / 'peer-check.log')
    run(['python3', 'scripts/inspect-benchmark-peers.py', '--input', args.output / 'peers', '--source', args.source,
         '--arch', args.architecture, '--objdump', args.objdump, '--output', args.output / 'peer-inspection.json'], args.output / 'peer-inspect.log')
    originals = {name: (ROOT / name).read_bytes() for name in FILES}
    baseline = {name: subprocess.check_output(['git', 'show', f'{BASELINE}:{name}'], cwd=ROOT) for name in FILES}
    assert not (ROOT / 'target/bench-evidence').exists(), 'do not mix independent benchmark invocations'
    binaries = {}
    try:
        for kind in VARIANTS:
            directory = args.output / kind
            directory.mkdir()
            for index, name in enumerate(FILES):
                changed = kind == 'both' or kind == ('index', 'length')[index]
                (ROOT / name).write_bytes(originals[name] if changed else baseline[name])
            patch = subprocess.check_output(['git', 'diff', BASELINE, '--', *FILES], cwd=ROOT)
            (directory / 'compiler.patch').write_bytes(patch)
            report['variants'][kind] = dict(patchSha256=digest(directory / 'compiler.patch'),
                sources={name: digest(ROOT / name) for name in FILES})
            write_json(args.output / 'report.json', report)
            # Production test optimization and checks are explicit in the workflow.
            run(['cargo', 'test', '--locked', '--offline', '--test', 'integer_output', '--', '--nocapture'], directory / 'correctness.log')
            run(['cargo', 'test', '--locked', '--offline', '--release', '--test', 'bench', 'benchmarks', '--', '--ignored', '--exact', '--nocapture'], directory / 'benchmark.log')
            shutil.copy2(ROOT / 'target/release/fwp', directory / 'compiler.exe')
            report['variants'][kind]['compilerSha256'] = digest(directory / 'compiler.exe')
            # Move, never overwrite, every actual timed executable and sample.
            shutil.move(ROOT / 'target/bench-evidence', directory / 'bench-evidence')
            for script, destination in [('inspect-benchmark-binaries.py', 'inspection.json'), ('test-benchmark-evidence.py', 'controls.json')]:
                run(['python3', 'scripts/' + script, '--input', directory / 'bench-evidence', '--source', args.source,
                     '--arch', args.architecture, '--objdump', args.objdump, '--output', directory / destination], directory / (destination + '.log'))
            run(['python3', 'scripts/measure-benchmark-memory.py', '--input', directory / 'bench-evidence', '--inspection', directory / 'inspection.json',
                 '--source', args.source, '--cc', args.cc, '--time', args.time, '--samples', '3', '--output', directory / 'memory'], directory / 'memory.log')
            run(['python3', 'scripts/inspect-benchmark-memory.py', '--input', directory / 'memory', '--benchmarks', directory / 'bench-evidence',
                 '--inspection', directory / 'inspection.json', '--source', args.source, '--arch', args.architecture, '--objdump', args.objdump,
                 '--output', directory / 'memory-inspection.json'], directory / 'memory-inspect.log')
            timed, = (directory / 'bench-evidence' / args.source).iterdir()
            inspection = json.loads((directory / 'inspection.json').read_text())
            memory = json.loads((directory / 'memory/report.json').read_text())
            for name in PROGRAMS:
                observed, = [p for p in memory['programs'] if p['name'] == name]
                assert all(all(value == 0 for value in p.values()) for p in observed['managedMemory']['ordinary']['profiles']), 'expected zero managed allocation/count cost'
                binaries[name, kind] = timed / f'{name}-fwp'
                if kind == 'baseline':
                    binaries[name, 'c'] = timed / f'{name}-c'
                    binaries[name, 'rs'] = timed / f'{name}-rs'
                    binaries[name, 'identical'] = binaries[name, kind]
            report['variants'][kind].update(inspectionSha256=digest(directory / 'inspection.json'), memorySha256=digest(directory / 'memory/report.json'),
                memoryInspectionSha256=digest(directory / 'memory-inspection.json'),
                costs={p['name']: dict(textBytes=p['files']['fwp']['textSectionBytes'], binaryBytes=p['files']['fwp']['fileBytes']) for p in inspection['programs']},
                instrumentedStack={p.name: p.read_text() for p in (directory / 'memory').glob('*-ordinary*.su')})
            write_json(args.output / 'report.json', report)
    finally:
        for name, data in originals.items():
            (ROOT / name).write_bytes(data)
    for name in PROGRAMS:
        row = dict(stdout={'loop': '300000003\n', 'text-length': '28518516\n'}[name], observations=[],
                   binaries={kind: dict(sha256=digest(binaries[name, kind]), bytes=binaries[name, kind].stat().st_size) for kind in KINDS})
        report['programs'][name] = row
        for phase, rounds in [('warmup', 2), ('sample', 56)]:
            for index in range(rounds):
                for position in range(7):
                    kind = KINDS[(index + position) % 7]
                    observation = dict(kind=kind, phase=phase, round=index, binarySha256=row['binaries'][kind]['sha256'], processes=[], seconds=0)
                    row['observations'].append(observation)
                    for process_index in range(report['settings']['processes'][name]):
                        start = time.perf_counter()
                        try:
                            result = subprocess.run([str(binaries[name, kind])], env=environment, capture_output=True, text=True, timeout=120)
                        except subprocess.TimeoutExpired as error:
                            write_json(args.output / 'report.json', report)
                            write_json(args.output / 'timeout.json', dict(program=name, kind=kind, phase=phase, round=index, process=process_index,
                                stdout=(error.stdout or b'').decode(errors='replace'), stderr=(error.stderr or b'').decode(errors='replace')))
                            raise
                        elapsed = time.perf_counter() - start
                        observation['processes'].append(dict(seconds=elapsed, status=result.returncode, stdout=result.stdout, stderr=result.stderr))
                        observation['seconds'] += elapsed
                        if result.returncode or result.stderr or result.stdout != row['stdout']:
                            write_json(args.output / 'report.json', report)
                            raise AssertionError(f'{name}/{kind}: wrong process output')
                    write_json(args.output / 'report.json', report)
        row['result'] = check_case(name, row, report['settings'], budgets[name])
        write_json(args.output / 'report.json', report)
    report['qualifyingVariants'] = check_report(report, table)
    write_json(args.output / 'report.json', report)
    print(json.dumps({name: row['result'] for name, row in report['programs'].items()}, indent=2), flush=True)
    print('Qualifying on this host only:', report['qualifyingVariants'], flush=True)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', required=True)
    parser.add_argument('--architecture', choices=['x86_64', 'aarch64'], required=True)
    for name in ('cc', 'rustc', 'objdump', 'time'):
        parser.add_argument('--' + name, required=True)
    for name in ('table', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    experiment(parser.parse_args())


if __name__ == '__main__':
    main()
