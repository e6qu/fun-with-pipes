#!/usr/bin/env python3
"""Compare checked-arithmetic C expressions without changing the fwp compiler."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import resource
import statistics
import subprocess
import time

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--inspection', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--cc', required=True)
parser.add_argument('--samples', type=int, required=True)
parser.add_argument('--warmups', type=int, required=True)
parser.add_argument('--cpu-policy', choices=['all'], required=True)
parser.add_argument('--max-control-change-percent', type=float, required=True)
parser.add_argument('--min-loop-gain-percent', type=float, required=True)
parser.add_argument('--max-other-slowdown-percent', type=float, required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert os.environ['GITHUB_ACTIONS'] == 'true' and platform.system() == 'Linux'
assert args.samples >= 8 and args.samples % 8 == 0 and args.warmups > 0
assert 0 < args.max_control_change_percent < 100 and 0 < args.min_loop_gain_percent < 100
assert 0 < args.max_other_slowdown_percent < 100
assert not args.output.exists()
inspection = json.loads(args.inspection.read_text())
assert inspection['source'] == args.source and inspection['memory'] == 'arc'
assert inspection['architecture'] == platform.machine()
directory, = (args.input / args.source).iterdir()
args.output.mkdir(parents=True)
environment = {key: value for key, value in os.environ.items()
               if not key.startswith('FWP_') and key not in {'GH_TOKEN', 'GITHUB_TOKEN'}}
environment.update(FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0',
                   FWP_LTO='0', LC_ALL='C')
labels = ['baseline', 'identical-control', 'sub-expression', 'add-sub-expression']
pattern = re.compile(r'(int64_t x = \(int64_t\)l1, y = \(int64_t\)l0, r;\n    '
                     r'if \(__builtin_(add|sub)_overflow\(x, y, &r\)\) '
                     r'fwp_trap_overflow\("I(?:64|Size)"\);\n    return \(V\))r;')


def run(command):
    result = subprocess.run(list(map(str, command)), env=environment,
                            capture_output=True, timeout=120)
    assert result.returncode == 0, (command, result.returncode, result.stderr)
    return result


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def candidate(code, operations):
    counts = {operation: 0 for operation in operations}
    def replace(match):
        operation = match[2]
        if operation not in operations:
            return match[0]
        counts[operation] += 1
        symbol = '+' if operation == 'add' else '-'
        return match[1] + f'(x {symbol} y);'
    return pattern.sub(replace, code), counts


cpus = sorted(os.sched_getaffinity(0))
result = dict(source=args.source, memory='arc', architecture=platform.machine(),
              inspectionSha256=digest(args.inspection), samples=args.samples,
              warmups=args.warmups, allowedCpus=cpus,
              cpu=run(['lscpu']).stdout.decode(), kernel=run(['uname', '-a']).stdout.decode(),
              cCompiler=run([args.cc, '--version']).stdout.decode(),
              thresholds=dict(maxControlChangePercent=args.max_control_change_percent,
                          minLoopGainPercent=args.min_loop_gain_percent,
                          maxOtherSlowdownPercent=args.max_other_slowdown_percent),
              scope='Same-session fwp-only experiment, not C/Rust overhead. Rebuild '
                    'saved checked-ARC generated C; candidates change only signed '
                    'I64/ISize return expressions after the existing overflow trap. '
                    'No compiler implementation change. Separate identical binary '
                    'controls measure noise. Complete-process elapsed and child CPU '
                    'times include startup/output/shutdown; compilation is excluded. '
                    'Pinning each allowed CPU does not fix frequency or hypervisor load. '
                    'A passing screen still requires semantic and full native checks.', programs=[])
for program in inspection['programs']:
    name = program['name']
    expected = program['stdout'].encode()
    generated = directory / f'{name}-generated.c'
    assert digest(generated) == program['generatedCSha256']
    original = generated.read_text()
    row = dict(name=name, variants={}, cpus=[])
    for label, operations in [('baseline', []), ('sub-expression', ['sub']),
                              ('add-sub-expression', ['add', 'sub'])]:
        code, changed = candidate(original, operations)
        cfile = args.output / f'{name}-{label}.c'
        binary = args.output / f'{name}-{label}'
        cfile.write_text(code)
        command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-fstack-usage',
                   '-w', cfile.resolve(), '-o', binary.resolve(), '-lm', '-lpthread', '-ldl']
        run(command)
        row['variants'][label] = dict(changed=changed, command=list(map(str, command)),
            sourceSha256=digest(cfile), binarySha256=digest(binary), fileBytes=binary.stat().st_size)
    control = args.output / f'{name}-identical-control'
    control.write_bytes((args.output / f'{name}-baseline').read_bytes())
    control.chmod(0o755)
    row['variants']['identical-control'] = dict(binarySha256=digest(control), fileBytes=control.stat().st_size)
    for cpu in cpus:
        os.sched_setaffinity(0, {cpu})
        for label in labels:
            for _ in range(args.warmups):
                actual = run([(args.output / f'{name}-{label}').resolve()])
                assert actual.stdout == expected and not actual.stderr
        samples = {label: [] for label in labels}
        for number in range(args.samples):
            offset = number % len(labels)
            order = labels[offset:] + labels[:offset]
            if number // len(labels) % 2:
                order = order[::-1]
            for position, label in enumerate(order):
                before = resource.getrusage(resource.RUSAGE_CHILDREN)
                started = time.perf_counter_ns()
                actual = run([(args.output / f'{name}-{label}').resolve()])
                elapsed = time.perf_counter_ns() - started
                after = resource.getrusage(resource.RUSAGE_CHILDREN)
                child = round((after.ru_utime + after.ru_stime - before.ru_utime - before.ru_stime) * 1e9)
                assert actual.stdout == expected and not actual.stderr and elapsed > 0 and child > 0
                samples[label].append(dict(round=number, position=position, elapsedNs=elapsed, childCpuNs=child))
        medians = {label: {key: statistics.median(sample[key] for sample in values)
                           for key in ['elapsedNs', 'childCpuNs']} for label, values in samples.items()}
        ratios = {label: {key: values[key] / medians['baseline'][key] for key in values}
                  for label, values in medians.items() if label != 'baseline'}
        stable = all(abs(value - 1) <= args.max_control_change_percent / 100
                     for value in ratios['identical-control'].values())
        limit = 1 - args.min_loop_gain_percent / 100 if name == 'loop' else 1 + args.max_other_slowdown_percent / 100
        screen = {label: stable and all(value <= limit for value in ratios[label].values())
                  for label in ['sub-expression', 'add-sub-expression']}
        row['cpus'].append(dict(cpu=cpu, samples=samples, medians=medians,
                                ratiosToBaseline=ratios, controlStable=stable, screen=screen))
        print(name, 'CPU', cpu, 'ratios', ratios, 'stable', stable, 'screen', screen, flush=True)
    os.sched_setaffinity(0, set(cpus))
    result['programs'].append(row)
    (args.output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
assert len(result['programs']) == 7
result['screen'] = {label: all(cpu['screen'][label] for row in result['programs'] for cpu in row['cpus'])
                    for label in ['sub-expression', 'add-sub-expression']}
(args.output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
print('Completed checked-bounds experiment; screen:', result['screen'])
