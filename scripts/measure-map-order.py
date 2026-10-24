#!/usr/bin/env python3
"""Measure ordered-range sort candidates without changing the fwp compiler."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
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
parser.add_argument('--min-map-gain-percent', type=float, required=True)
parser.add_argument('--max-other-slowdown-percent', type=float, required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert os.environ['GITHUB_ACTIONS'] == 'true' and platform.system() == 'Linux'
assert args.samples >= 8 and args.samples % 8 == 0 and args.warmups > 0
assert 0 < args.max_control_change_percent < 100 and 0 < args.min_map_gain_percent < 100
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
labels = ['baseline', 'identical-control', 'ordered-merge', 'ordered-range']
merge_anchor = '    fwp_msort(keys + m, vals + m, n - m, d, tk, tv);\n'
merge_check = '    if (fwp_cmp(keys[m - 1], keys[m], d) <= 0) return;\n'
entry_anchor = 'static void fwp_msort(V *keys, V *vals, size_t n, const fwp_desc *d, V *tk, V *tv) {\n    if (n < 2) return;\n'
range_check = ('    size_t ordered = 1;\n'
               '    while (ordered < n && fwp_cmp(keys[ordered - 1], keys[ordered], d) <= 0) ordered++;\n'
               '    if (ordered == n) return;\n')


def run(command):
    result = subprocess.run(list(map(str, command)), env=environment,
                            capture_output=True, timeout=120)
    assert result.returncode == 0, (command, result.returncode, result.stderr)
    return result


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def candidate(code, label):
    assert code.count(merge_anchor) == code.count(entry_anchor) == 1
    if label == 'baseline':
        return code, []
    assert label in ['ordered-merge', 'ordered-range']
    code = code.replace(merge_anchor, merge_anchor + merge_check)
    changes = ['skip merge after ordered halves']
    if label == 'ordered-range':
        code = code.replace(entry_anchor, entry_anchor + range_check)
        changes.append('skip recursion for ordered input')
    return code, changes


# This small correctness probe uses the actual candidate sort with dynamic
# lengths/patterns. It checks stable equal keys and aliased set lanes separately.
map_program, = [row for row in inspection['programs'] if row['name'] == 'map']
map_code = (directory / 'map-generated.c').read_text()
assert hashlib.sha256(map_code.encode()).hexdigest() == map_program['generatedCSha256']
probe = r"""
int main(int argc, char **argv) {
    if (argc != 4) return 2;
    size_t n = (size_t)strtoul(argv[1], NULL, 10);
    unsigned pattern = (unsigned)strtoul(argv[2], NULL, 10);
    unsigned aliased = (unsigned)strtoul(argv[3], NULL, 10);
    if (n > 257 || pattern > 4 || aliased > 1) return 3;
    V keys[257], values[257], temporary_keys[257], temporary_values[257];
    const fwp_desc scalar = {.kind = K_I64};
    for (size_t i = 0; i < n; i++) {
        int64_t key = pattern == 0 ? (int64_t)i :
            pattern == 1 ? -(int64_t)i :
            pattern == 2 ? (int64_t)(i % 5) - 2 :
            pattern == 3 ? (int64_t)(i % 2 ? n - i : i) :
            (int64_t)((i * 73 + 19) % 257) - 128;
        keys[i] = (V)key;
        values[i] = (V)i;
    }
    fwp_msort(keys, aliased ? keys : values, n, &scalar,
        temporary_keys, aliased ? temporary_keys : temporary_values);
    for (size_t i = 0; i < n; i++)
        printf("%lld:%llu\n", (long long)(int64_t)keys[i],
            (unsigned long long)(aliased ? 0 : values[i]));
    return 0;
}
"""
probe_records = []
for label in ['baseline', 'ordered-merge', 'ordered-range', 'missing-merge']:
    code, _ = candidate(map_code, 'baseline' if label == 'missing-merge' else label)
    if label == 'missing-merge':
        code = code.replace(merge_anchor, merge_anchor + '    return; /* broken control */\n')
    entry = 'int main(int argc, char **argv)'
    assert code.count(entry) == 1
    code = code.replace(entry, 'int benchmark_main(int argc, char **argv)') + probe
    cfile, binary = args.output / f'stability-{label}.c', args.output / f'stability-{label}'
    cfile.write_text(code)
    command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-fstack-usage',
               '-w', cfile.resolve(), '-o', binary.resolve(), '-lm', '-lpthread', '-ldl']
    run(command)
    record = dict(variant=label, command=list(map(str, command)), sourceSha256=digest(cfile),
                  binarySha256=digest(binary), fileBytes=binary.stat().st_size, observations=[])
    rejected = 0
    for n in [0, 1, 2, 3, 17, 257]:
        for pattern in range(5):
            keys = [i if pattern == 0 else -i if pattern == 1 else i % 5 - 2
                    if pattern == 2 else (n - i if i % 2 else i) if pattern == 3
                    else (i * 73 + 19) % 257 - 128 for i in range(n)]
            pairs = sorted(enumerate(keys), key=lambda pair: pair[1])
            for aliased in [0, 1]:
                expected = ''.join(f'{key}:{0 if aliased else index}\n' for index, key in pairs)
                actual = run([binary.resolve(), n, pattern, aliased])
                assert not actual.stderr
                matches = actual.stdout.decode() == expected
                if label != 'missing-merge':
                    assert matches, (label, n, pattern, aliased, actual.stdout, expected)
                rejected += not matches
                record['observations'].append(dict(length=n, pattern=pattern, aliased=aliased,
                    stdout=actual.stdout.decode(), stderr=actual.stderr.decode(), status=actual.returncode,
                    expected=expected, matches=matches))
    assert label != 'missing-merge' or rejected > 0
    record['rejectedCases'] = rejected
    probe_records.append(record)
(args.output / 'stability.json').write_text(json.dumps(dict(source=args.source,
    architecture=platform.machine(), images=probe_records), indent=2) + '\n')
print('Stable duplicate keys and aliased set lanes pass; deliberately omitted merge is detected', flush=True)

cpus = sorted(os.sched_getaffinity(0))
result = dict(source=args.source, memory='arc', architecture=platform.machine(),
              inspectionSha256=digest(args.inspection), samples=args.samples,
              warmups=args.warmups, allowedCpus=cpus,
              cpu=run(['lscpu']).stdout.decode(), kernel=run(['uname', '-a']).stdout.decode(),
              cCompiler=run([args.cc, '--version']).stdout.decode(),
              thresholds=dict(maxControlChangePercent=args.max_control_change_percent,
                          minMapGainPercent=args.min_map_gain_percent,
                          maxOtherSlowdownPercent=args.max_other_slowdown_percent),
              scope='Same-session fwp-only sort experiment, not C/Rust overhead. Rebuild '
                    'saved checked-ARC generated C; candidates only skip stable merge work '
                    'when a total-order comparison proves that ranges are already ordered. '
                    'The second also scans for ordered input before recursing. No runtime '
                    'implementation change. Identical binary controls measure noise. '
                    'Complete-process elapsed and child CPU times include startup/output/'
                    'shutdown; compilation is excluded. Pinning each allowed CPU does not '
                    'fix frequency or hypervisor load. A passing screen still needs '
                    'callback, failure and complete native checks. Small I64 stability/alias '
                    'probes and a deliberately omitted merge run separately from timing.',
              stabilitySha256=digest(args.output / 'stability.json'), programs=[])
for program in inspection['programs']:
    name = program['name']
    expected = program['stdout'].encode()
    generated = directory / f'{name}-generated.c'
    assert digest(generated) == program['generatedCSha256']
    original = generated.read_text()
    row = dict(name=name, variants={}, cpus=[])
    for label in ['baseline', 'ordered-merge', 'ordered-range']:
        code, changed = candidate(original, label)
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
        limit = 1 - args.min_map_gain_percent / 100 if name == 'map' else 1 + args.max_other_slowdown_percent / 100
        screen = {label: stable and all(value <= limit for value in ratios[label].values())
                  for label in ['ordered-merge', 'ordered-range']}
        row['cpus'].append(dict(cpu=cpu, samples=samples, medians=medians,
                                ratiosToBaseline=ratios, controlStable=stable, screen=screen))
        print(name, 'CPU', cpu, 'ratios', ratios, 'stable', stable, 'screen', screen, flush=True)
    os.sched_setaffinity(0, set(cpus))
    result['programs'].append(row)
    (args.output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
assert len(result['programs']) == 7
result['screen'] = {label: all(cpu['screen'][label] for row in result['programs'] for cpu in row['cpus'])
                    for label in ['ordered-merge', 'ordered-range']}
(args.output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
print('Completed map-order experiment; screen:', result['screen'])
