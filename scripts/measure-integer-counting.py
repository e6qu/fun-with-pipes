#!/usr/bin/env python3
"""Compare saved decimal counters and a grouped-digit candidate on each allowed CPU."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import resource
import statistics
import time

ROOT = Path(__file__).resolve().parent.parent
spec = importlib.util.spec_from_file_location(
    'scalar_memory', ROOT / 'scripts/measure-scalar-text-memory.py')
memory = importlib.util.module_from_spec(spec)
spec.loader.exec_module(memory)
audit = memory.audit
run = memory.run


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--host', choices=audit.HOSTS, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--affinity', choices=['each-allowed'], required=True)
    parser.add_argument('--rounds', type=int, required=True)
    parser.add_argument('--warmups', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ['GITHUB_ACTIONS'] == 'true' and platform.system() == 'Linux'
    machine, architecture = audit.HOSTS[args.host]
    assert platform.machine() == architecture
    assert re.fullmatch('[0-9a-f]{40}', args.source)
    labels = ('c', 'rs', 'saved-fwp', 'rebuilt-fwp', 'candidate-fwp',
              'matched-c', 'matched-rs', 'grouped-unhinted', 'recomputed-product')
    assert args.rounds > 0 and args.rounds % (2 * len(labels)) == 0
    assert args.warmups > 0
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    meta = json.loads(run(
        ['gh', 'run', 'view', args.run, '--repo', 'e6qu/fun-with-pipes',
         '--json', 'headSha,status,conclusion,jobs'], os.environ).stdout)
    assert meta['headSha'] == args.source and meta['status'] == 'completed'
    assert meta['conclusion'] == 'success'
    jobs = [job for job in meta['jobs'] if job['conclusion'] != 'skipped']
    assert len(jobs) == 2 and all(job['conclusion'] == 'success' for job in jobs)
    assert {job['name'] for job in jobs} == {
        f'channel_transfer_costs ({host})' for host in audit.HOSTS}
    inputs = out / 'input'
    for name in ('channel-costs-' + args.host, 'scalar-text-bench-' + args.host):
        run(['gh', 'run', 'download', args.run, '--repo', 'e6qu/fun-with-pipes',
             '--name', name, '--dir', inputs / name], os.environ)
    source_report = audit.host_report(inputs, args.host, args.source)
    (out / 'source-audit.json').write_text(json.dumps(source_report, indent=2) + '\n')
    directory, = (inputs / ('scalar-text-bench-' + args.host)
                  / 'bench-evidence' / args.source).iterdir()
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_GC_STRESS='0', FWP_GC_VERIFY='0',
                       FWP_REUSE_VERIFY='0', FWP_LTO='0', LC_ALL='C')
    compiler = run([args.cc, '--version'], environment).stdout.decode().splitlines()[0]
    assert compiler == source_report['cCompiler'], (compiler, source_report['cCompiler'])
    executables = {label: directory / ('text-length-' + kind)
                   for label, kind in [('c', 'c'), ('rs', 'rs'), ('saved-fwp', 'fwp')]}
    for executable in executables.values():
        executable.chmod(0o755)
    original = (directory / 'text-length-generated.c').read_text()
    # Match both complete helpers, including nested conditional/loop bodies.
    pattern = (r'static (?:inline )?int64_t fwp_u64_chars\(uint64_t x\) \{.*?\n\}\n\n'
               r'static (?:inline )?int64_t fwp_i64_chars\(int64_t x\) \{.*?\n\}')
    old_helper, = re.findall(pattern, original, re.S)
    new_helper, = re.findall(pattern, (ROOT / 'runtime/fwp_rt_ops.c').read_text(), re.S)
    assert old_helper != new_helper
    candidate = original.replace(old_helper, new_helper)
    assert candidate.replace(new_helper, old_helper) == original
    assert new_helper.count('static inline ') == 2
    unhinted = candidate.replace(new_helper, new_helper.replace('static inline ', 'static '))
    # A generated-C experiment only: retain the overflow check, then express
    # the known-safe product separately so GCC can infer its numeric range.
    multiply, = re.findall(
        r'/\* prim.mul : I64 -> I64 -> I64 \*/\nstatic V f\d+\(V l0, V l1\) \{.*?\n\}',
        candidate, re.S)
    assert multiply.count('if (__builtin_mul_overflow(x, y, &r)) fwp_trap_overflow("I64");') == 1
    assert multiply.count('return (V)r;') == 1
    recomputed_multiply = multiply.replace('return (V)r;', 'return (V)(x * y);')
    recomputed = candidate.replace(multiply, recomputed_multiply)
    builds = {}
    managed = {}
    for kind, tool, flags in [('c', args.cc, ['-O2']), ('rs', args.rustc, ['-O'])]:
        label = 'matched-' + kind
        source = out / (label + '.' + kind)
        source.write_bytes((ROOT / 'bench/text-length' / ('main.' + kind)).read_bytes())
        executable = out / label
        command = [tool, *flags, source, '-o', executable]
        if kind == 'c':
            command += [f'-fdump-tree-optimized={out / (label + ".optimized")}',
                        f'-fdump-tree-evrp={out / (label + ".ranges")}']
        run(command, environment)
        executables[label] = executable
        builds[label] = {'command': list(map(str, command)), 'sourceSha256': audit.digest(source)}
    for label, code in [('rebuilt-fwp', original), ('candidate-fwp', candidate),
                        ('grouped-unhinted', unhinted), ('recomputed-product', recomputed)]:
        cfile = out / (label + '.c')
        cfile.write_text(code)
        executable = out / label
        command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                   cfile, '-o', executable, '-lm', '-lpthread', '-ldl',
                   f'-fdump-tree-optimized={out / (label + ".optimized")}',
                   f'-fdump-tree-evrp={out / (label + ".ranges")}']
        run(command, environment)
        executables[label] = executable
        builds[label] = {'command': list(map(str, command)), 'sourceSha256': audit.digest(cfile)}
        # Count storage in separate binaries; never time instrumentation.
        instrumented = out / (label + '-counts.c')
        instrumented.write_text(memory.profile.instrument(code))
        counter = out / (label + '-counts')
        run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
             instrumented, '-o', counter, '-lm', '-lpthread', '-ldl'], environment)
        actual = run([counter], environment)
        assert actual.stdout == b'28518516\n'
        counts = json.loads(actual.stderr)
        for key in ('requests', 'requestedBytes', 'retains', 'peakChargedBytes',
                    'finalChargedBytes', 'collections'):
            assert counts[key] == 0, (label, key, counts)
        managed[label] = counts
    control_source = out / 'injected-allocation.c'
    marker = 'iteration_start_charge=iteration_charge();iteration_active=1;'
    instrumented_code = memory.profile.instrument(candidate)
    assert instrumented_code.count(marker) == 1
    control_source.write_text(instrumented_code.replace(marker, marker + '(void)fwp_alloc_leaf(16);'))
    control = out / 'injected-allocation'
    run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
         control_source, '-o', control, '-lm', '-lpthread', '-ldl'], environment)
    actual = run([control], environment)
    assert actual.stdout == b'28518516\n'
    counts = json.loads(actual.stderr)
    assert counts['requests'] == 1 and counts['requestedBytes'] == 16
    assert counts['peakChargedBytes'] > 0
    managed['injected-allocation'] = counts
    binaries = {}
    for label, executable in executables.items():
        assembly = out / (label + '.asm')
        assembly.write_bytes(run(['objdump', '-d', executable], environment).stdout)
        binaries[label] = {**audit.binary(executable, machine),
                           'assemblySha256': audit.digest(assembly)}
    affinity = sorted(os.sched_getaffinity(0))
    assert affinity
    measurements = []
    # Pin the parent and its children without an extra launcher in the interval.
    # Each CPU remains a separate result; pooling could conceal different costs.
    try:
        for cpu in affinity:
            os.sched_setaffinity(0, {cpu})
            assert os.sched_getaffinity(0) == {cpu}
            samples = {label: [] for label in labels}
            for label in labels:
                for _ in range(args.warmups):
                    actual = run([executables[label]], environment)
                    assert actual.stdout == b'28518516\n' and not actual.stderr
            for number in range(args.rounds):
                offset = number % len(labels)
                order = labels[offset:] + labels[:offset]
                if number // len(labels) % 2:
                    order = order[::-1]
                for label in order:
                    cpu_start = resource.getrusage(resource.RUSAGE_CHILDREN)
                    wall_start = time.perf_counter_ns()
                    actual = run([executables[label]], environment)
                    elapsed = time.perf_counter_ns() - wall_start
                    cpu_end = resource.getrusage(resource.RUSAGE_CHILDREN)
                    child_cpu = round((cpu_end.ru_utime + cpu_end.ru_stime
                                       - cpu_start.ru_utime - cpu_start.ru_stime) * 1e9)
                    assert actual.stdout == b'28518516\n' and not actual.stderr
                    assert elapsed > 0 and child_cpu > 0
                    samples[label].append({'round': number, 'order': order,
                                           'wallNs': elapsed, 'childCpuNs': child_cpu})
            results = {label: {'samples': values,
                              'medianWallNs': statistics.median(v['wallNs'] for v in values),
                              'medianChildCpuNs': statistics.median(v['childCpuNs'] for v in values)}
                       for label, values in samples.items()}
            ratios = {peer: {metric: results['candidate-fwp'][metric] / results[peer][metric]
                             for metric in ('medianWallNs', 'medianChildCpuNs')}
                      for peer in labels if peer != 'candidate-fwp'}
            measurements.append({'cpu': cpu, 'timing': results, 'candidateOverPeer': ratios})
            print(json.dumps({'cpu': cpu, 'candidateOverPeer': ratios}), flush=True)
    finally:
        os.sched_setaffinity(0, affinity)
    result = {
        'measurementSource': run(['git', 'rev-parse', 'HEAD'], environment).stdout.decode().strip(),
        'measurementRun': int(os.environ['GITHUB_RUN_ID']),
        'programSource': args.source, 'programRun': args.run, 'host': args.host,
        'cCompiler': compiler, 'cpuInfo': run(['lscpu'], environment).stdout.decode(),
        'rustCompiler': run([args.rustc, '-Vv'], environment).stdout.decode().strip(),
        'kernel': run(['uname', '-a'], environment).stdout.decode().strip(),
        'aslr': Path('/proc/sys/kernel/randomize_va_space').read_text().strip(),
        'affinityPolicy': args.affinity, 'allowedCpus': affinity,
        'rounds': args.rounds, 'warmups': args.warmups,
        'oldHelper': old_helper, 'candidateHelper': new_helper,
        'arithmeticExperiment': {'originalMultiply': multiply,
                                 'recomputedMultiply': recomputed_multiply,
                                 'rewriteScope': 'saved generated C'},
        'builds': builds, 'binaries': binaries, 'managedMemory': managed,
        'measurements': measurements,
        'scope': 'C, Rust and fwp count decimal characters for i and checked 3*i over '
                 '0 <= i < 2000000, with checked accumulation and output 28518516. '
                 'Saved C/Rust and fwp executables come from the audited earlier run. '
                 'Matched C/Rust use the candidate algorithm from the measurement source, '
                 'with GCC O2 and Rust -O respectively. Compare these peers to assess '
                 'remaining overhead; comparison with old peers also changes algorithms. '
                 'All matched helpers carry ordinary inline hints, not forced inlining. '
                 'Grouped-unhinted removes only the two fwp inline hints to isolate their cost. '
                 'Recomputed-product keeps the same signed overflow check and expresses '
                 'the product again on its non-overflow continuation. This comparison rewrites '
                 'saved generated C. The workflow separately verifies actual compiler-produced '
                 'C and its executable; measurements alone do not establish full arithmetic acceptance. '
                 'GCC range and optimized tree dumps accompany each C rebuild. '
                 'Rebuilt fwp uses unchanged saved C; candidate changes only integer '
                 'digit counting to descending decimal groups. Both use GCC O2, no LTO. Balanced '
                 'whole-process timing includes startup, output and shutdown; wall '
                 'time includes Python subprocess launch, child CPU excludes parent '
                 'and descheduling. Compilation, audit and memory instrumentation '
                 'are outside timing. Each allowed CPU is pinned separately. ASLR '
                 'is recorded and unchanged. Every sample is retained. Separate '
                 'instrumented binaries measure managed storage after constant '
                 'initialization, excluding raw buffers, libc, stacks and metadata. '
                 'These measurements do not prove causality for historical variability.'}
    (out / 'report.json').write_text(json.dumps(result, indent=2) + '\n')


if __name__ == '__main__':
    main()
