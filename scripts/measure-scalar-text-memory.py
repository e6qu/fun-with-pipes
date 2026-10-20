#!/usr/bin/env python3
"""Remeasure saved counting binaries' time, process memory and managed storage."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import resource
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
audit_spec = importlib.util.spec_from_file_location('scalar_text_audit', ROOT / 'scripts/summarize-scalar-text.py')
audit = importlib.util.module_from_spec(audit_spec)
audit_spec.loader.exec_module(audit)
profile_spec = importlib.util.spec_from_file_location('iteration_profile', ROOT / 'scripts/measure-iteration.py')
profile = importlib.util.module_from_spec(profile_spec)
profile_spec.loader.exec_module(profile)


def run(command, environment):
    result = subprocess.run(list(map(str, command)), env=environment, capture_output=True)
    if result.returncode:
        raise RuntimeError(f'{command}: exit {result.returncode}: '
                           + result.stderr.decode(errors='replace'))
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True, type=int)
    parser.add_argument('--source', required=True)
    parser.add_argument('--host', required=True, choices=audit.HOSTS)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--time', required=True, type=Path)
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--timing-samples', required=True, type=int)
    parser.add_argument('--warmups', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ['GITHUB_ACTIONS'] == 'true' and platform.system() == 'Linux'
    assert args.samples >= 3 and re.fullmatch('[0-9a-f]{40}', args.source)
    labels = ('c', 'rs', 'fwp')
    assert args.timing_samples > 0 and args.timing_samples % (2 * len(labels)) == 0
    assert args.warmups > 0
    machine, architecture = audit.HOSTS[args.host]
    assert platform.machine() == architecture
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    meta = json.loads(run(
        ['gh', 'run', 'view', args.run, '--repo', 'e6qu/fun-with-pipes',
         '--json', 'headSha,status,conclusion,jobs'], os.environ).stdout)
    assert meta['headSha'] == args.source and meta['status'] == 'completed'
    assert meta['conclusion'] == 'success'
    jobs = [job for job in meta['jobs'] if job['conclusion'] != 'skipped']
    assert {job['name'] for job in jobs} == {
        f'channel_transfer_costs ({host})' for host in audit.HOSTS}
    assert len(jobs) == 2 and all(job['conclusion'] == 'success' for job in jobs)
    inputs = out / 'input'
    for name in ('channel-costs-' + args.host, 'scalar-text-bench-' + args.host):
        run(['gh', 'run', 'download', args.run, '--repo', 'e6qu/fun-with-pipes',
             '--name', name, '--dir', inputs / name], os.environ)
    source_report = audit.host_report(inputs, args.host, args.source)
    source_audit = out / 'source-audit.json'
    source_audit.write_text(json.dumps(source_report, indent=2) + '\n')
    directory, = (inputs / ('scalar-text-bench-' + args.host)
                  / 'bench-evidence' / args.source).iterdir()
    # The profiling children need no GitHub credentials or caller-selected fwp
    # runtime switches. Their code and memory mode come from the saved source.
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_GC_STRESS='0', FWP_GC_VERIFY='0',
                       FWP_REUSE_VERIFY='0', FWP_LTO='0', LC_ALL='C')
    compiler = run([args.cc, '--version'], environment).stdout.decode().splitlines()[0]
    assert compiler == source_report['cCompiler'], (compiler, source_report['cCompiler'])
    # Actions artifacts preserve bytes, but not executable permissions.
    for kind in ('c', 'rs', 'fwp'):
        (directory / ('text-length-' + kind)).chmod(0o755)
    reference = run([directory / 'text-length-c'], environment).stdout
    timing = {kind: {'samples': []} for kind in labels}
    for kind in labels:
        for _ in range(args.warmups):
            actual = run([directory / ('text-length-' + kind)], environment)
            assert actual.stdout == reference and not actual.stderr
    for sample in range(args.timing_samples):
        offset = sample % len(labels)
        order = labels[offset:] + labels[:offset]
        if sample // len(labels) % 2:
            order = order[::-1]
        for kind in order:
            cpu_start = resource.getrusage(resource.RUSAGE_CHILDREN)
            wall_start = time.perf_counter_ns()
            actual = run([directory / ('text-length-' + kind)], environment)
            wall = time.perf_counter_ns() - wall_start
            cpu_end = resource.getrusage(resource.RUSAGE_CHILDREN)
            cpu = round((cpu_end.ru_utime + cpu_end.ru_stime
                         - cpu_start.ru_utime - cpu_start.ru_stime) * 1e9)
            assert actual.stdout == reference and not actual.stderr
            assert wall > 0 and cpu > 0
            timing[kind]['samples'].append(
                {'round': sample, 'order': order, 'wallNs': wall, 'childCpuNs': cpu})
    for kind, result in timing.items():
        result.update(
            binarySha256=audit.digest(directory / ('text-length-' + kind)),
            medianWallNs=statistics.median(sample['wallNs'] for sample in result['samples']),
            medianChildCpuNs=statistics.median(sample['childCpuNs'] for sample in result['samples']))
    rss = {}
    for kind in ('c', 'rs', 'fwp'):
        executable = directory / ('text-length-' + kind)
        samples = []
        for number in range(args.samples):
            path = out / f'{kind}-{number}.rss-kib'
            actual = run([args.time.resolve(), '-f', '%M', '-o', path, executable], environment)
            assert actual.stdout == reference and not actual.stderr
            value = int(path.read_text())
            assert value > 0, (kind, number, value)
            samples.append(value)
        rss[kind] = {'peakRssKiB': samples, **audit.binary(executable, machine)}

    generated = directory / 'text-length-generated.c'
    code = profile.instrument(generated.read_text())
    start = 'iteration_start_charge=iteration_charge();iteration_active=1;'
    assert code.count(start) == 1
    control = code.replace(start, start + '(void)fwp_alloc_leaf(16);')
    managed = {}
    for label, candidate, expected_requests in (
            ('ordinary', code, 0), ('injected-allocation', control, 1)):
        cfile = out / (label + '.c')
        cfile.write_text(candidate)
        executable = out / label
        command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                   cfile, '-o', executable, '-lm', '-lpthread', '-ldl']
        run(command, environment)
        samples = []
        for _ in range(args.samples):
            actual = run([executable], environment)
            assert actual.stdout == reference
            counts = json.loads(actual.stderr)
            assert counts['requests'] == expected_requests, (label, counts)
            assert counts['requestedBytes'] == 16 * expected_requests, (label, counts)
            assert counts['retains'] == 0, (label, counts)
            if label == 'ordinary':
                assert counts['peakChargedBytes'] == counts['finalChargedBytes'] == 0, counts
                assert counts['collections'] == 0, counts
            else:
                assert counts['peakChargedBytes'] > 0, counts
            samples.append(counts)
        managed[label] = {
            'profiles': samples, 'command': list(map(str, command)),
            'generatedSha256': audit.digest(cfile), **audit.binary(executable, machine)}
    model, = re.findall(r'^Model name:\s*(.+)$', run(['lscpu'], environment).stdout.decode(), re.M)
    result = {
        'measurementSource': run(['git', 'rev-parse', 'HEAD'], environment).stdout.decode().strip(),
        'measurementRun': int(os.environ['GITHUB_RUN_ID']),
        'programSource': args.source, 'programRun': args.run, 'host': args.host,
        'cpu': model, 'kernel': run(['uname', '-a'], environment).stdout.decode().strip(),
        'cCompiler': compiler,
        'timeTool': run([args.time.resolve(), '--version'], environment).stdout.decode().splitlines()[0],
        'expectedOutput': reference.decode(), 'processMemory': rss,
        'timing': timing, 'timingSamples': args.timing_samples, 'warmups': args.warmups,
        'fwpOverPeer': {
            kind: {metric: timing['fwp'][metric] / timing[kind][metric]
                   for metric in ('medianWallNs', 'medianChildCpuNs')}
            for kind in ('c', 'rs')},
        'managedMemory': managed, 'sourceAuditSha256': audit.digest(source_audit),
        'scope': 'Three or more fresh runs of the actual previously timed direct-counting '
                 'C/Rust/fwp binaries, on the matching native architecture. GNU time records '
                 'whole-process peak RSS in KiB, including startup, output and shutdown. '
                 'Separate balanced rotating/reversed timing rounds record whole-process '
                 'elapsed and child user+system CPU time with explicit warmups/sample count. '
                 'Elapsed includes Python subprocess launch, input/output and shutdown; '
                 'child CPU excludes parent and descheduled time. No recompilation occurs '
                 'inside either timed interval. Every sample is retained. These memory '
                 'runs are excluded from the timing comparison; RSS '
                 'includes shared code/libraries and has page/accounting granularity. '
                 'Separate instrumented GCC O2 builds of saved fwp C count managed requests, '
                 'retains and peak/final charged bytes after constant initialization through '
                 'cleanup. They exclude raw buffers, allocator metadata, stacks and libc. '
                 'A single injected 16-byte leaf allocation must be detected. No C/Rust '
                 'allocator-call count or peak-RSS improvement over older fwp is claimed.'}
    (out / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({'host': args.host, 'rss': {k: v['peakRssKiB'] for k, v in rss.items()},
                      'managed': {k: v['profiles'] for k, v in managed.items()},
                      'fwpOverPeer': result['fwpOverPeer']}), flush=True)


if __name__ == '__main__':
    main()
