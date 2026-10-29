#!/usr/bin/env python3
"""Diagnose frozen timing failures; never turn diagnostic results into acceptance."""
import argparse
import gzip
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('kernel_schedule', ROOT / 'scripts/numerical-baselines.py')
SCHEDULE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(SCHEDULE)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def layout_source(source):
    declaration = 'typedef uint64_t V;'
    assert source.count(declaration) == 1
    source = source.replace(declaration, declaration + '\n#include <sched.h>\n')
    pattern = r'__asm__ volatile\("" : "\+r"\(a\), "\+r"\(b\) :: "memory"\);V result=([^;]+);'
    matches = list(re.finditer(pattern, source))
    assert len(matches) == 1, 'Changed matrix harness boundary'
    match = matches[0]
    # Observe input storage before its ownership moves into the function.
    # Only the still-live output is inspected after the call.
    replacement = '''uintptr_t diag_left=(uintptr_t)fwp_array_data(left),diag_right=(uintptr_t)fwp_array_data(right);
            int diag_before=sched_getcpu();
            __asm__ volatile("" : "+r"(a), "+r"(b) :: "memory");V result=''' + match[1] + ''';
            fprintf(stderr,"{\\"sample\\":%zu,\\"round\\":%zu,\\"cpuBefore\\":%d,\\"cpuAfter\\":%d,\\"leftOffset\\":%llu,\\"rightOffset\\":%llu,\\"outputOffset\\":%llu}\\n",
                sample,round,diag_before,sched_getcpu(),(unsigned long long)(diag_left%65536),
                (unsigned long long)(diag_right%65536),(unsigned long long)((uintptr_t)fwp_array_data(result)%65536));'''
    return source[:match.start()] + replacement + source[match.end():]


def validate_kernel(raw, expected_hash, label):
    data = json.loads(raw)
    assert set(data) == {'samples'}
    samples = data['samples']
    assert len(samples) == 5
    for sample in samples:
        assert sample['hash'] == expected_hash
        assert type(sample['kernelNs']) is int and sample['kernelNs'] > 0
        assert type(sample['allocationInclusiveNs']) is int and sample['allocationInclusiveNs'] >= sample['kernelNs']
        assert label in SCHEDULE.LABELS
        key = 'liveChargedBytes' if label.startswith('fwp') else 'livePayloadBytes'
        assert sample[key] == 0
    return samples


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['kernel', 'derivative', 'qualification', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ['kernel-source', 'derivative-source', 'cc']:
        parser.add_argument('--' + name, required=True)
    for name in ['cpu', 'rounds', 'layout-processes', 'seed', 'timeout']:
        parser.add_argument('--' + name, type=int, required=True)
    args = parser.parse_args()
    assert platform.system() == 'Linux' and platform.machine() == 'x86_64'
    assert (args.cpu, args.rounds, args.layout_processes, args.seed, args.timeout) == (0, 16, 32, 20261029, 180)
    host = json.loads(args.qualification.read_text())
    assert host['qualified'] and not host['failures'] and host['actual'] == host['expected']
    assert host['actual']['cpu'] == 'AMD EPYC 7763 64-Core Processor'
    assert subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0] == host['actual']['cVersion']
    allowed = os.sched_getaffinity(0)
    assert args.cpu in allowed and len(allowed) == 4
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    reports = {name: json.loads((path / 'comparison.json').read_text())
               for name, path in [('kernel', args.kernel), ('derivative', args.derivative)]}
    for name, source in [('kernel', args.kernel_source), ('derivative', args.derivative_source)]:
        assert reports[name]['source'] == source
        assert reports[name]['qualification']['actual'] == host['actual']
    configuration = dict(source=os.environ['GITHUB_SHA'], qualification=host, allowedCpus=sorted(allowed),
                         arguments={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()})
    (output / 'configuration.json').write_text(json.dumps(configuration, indent=2) + '\n')
    programs = {}
    origins = {}
    roles = {'kernel': dict(zip(SCHEDULE.LABELS, ['c', 'rust', 'fwp', 'fwp-identical'])),
             'derivative': dict(zip(SCHEDULE.LABELS, ['candidate', 'reference', 'candidate-copy', 'reference-copy']))}
    kernel = reports['kernel']['results']['matrix-65-67-63']
    derivative = reports['derivative']['results']['3-0']
    for group, directory, row, labels in [
        ('kernel', args.kernel / 'matrix-65-67-63', kernel, ['c-timing', 'rust-timing', 'fwp-timing', 'fwp-timing']),
        ('derivative', args.derivative / '3-0', derivative,
         ['fwp-ad-history', 'fwp-ad-history-reference', 'fwp-ad-history', 'fwp-ad-history-reference']),
    ]:
        for label, original in zip(SCHEDULE.LABELS, labels):
            raw = (directory / original).read_bytes()
            assert digest(raw) == row['binaries'][original]['sha256']
            path = output / (group + '-' + label)
            path.write_bytes(raw)
            path.chmod(0o755)
            programs[group, label] = [str(path)] + (['matrix'] if group == 'kernel' and label in ['c', 'rust'] else [])
            origins[group + '-' + label] = dict(role=roles[group][label], original=original, sha256=digest(raw))
    (output / 'programs.json').write_text(json.dumps(origins, indent=2) + '\n')
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    environment.pop('FWP_NO_OPT', None)

    def run(command, name, metadata):
        started = time.perf_counter_ns()
        timed_out = False
        try:
            result = subprocess.run(command, env=environment, capture_output=True, timeout=args.timeout)
        except subprocess.TimeoutExpired as error:
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
            timed_out = True
        record = dict(metadata, command=command, status=result.returncode, timedOut=timed_out,
                      elapsedNs=time.perf_counter_ns() - started, stdoutSha256=digest(result.stdout),
                      stderrSha256=digest(result.stderr), stdoutBytes=len(result.stdout), stderrBytes=len(result.stderr))
        for stream in ['stdout', 'stderr']:
            (output / (name + '.' + stream + '.gz')).write_bytes(gzip.compress(getattr(result, stream), mtime=0))
        with (output / 'processes.jsonl').open('a') as log:
            log.write(json.dumps(record) + '\n')
        assert result.returncode == 0 and not timed_out, record
        return result, record

    try:
        for group in ['kernel', 'derivative']:
            for index in range(args.rounds):
                policies = ['unbound', 'pinned'] if index % 2 == 0 else ['pinned', 'unbound']
                for policy in policies:
                    os.sched_setaffinity(0, allowed if policy == 'unbound' else {args.cpu})
                    for position, label in enumerate(SCHEDULE.execution_order(index, args.seed, 4)):
                        name = f'{group}-{index}-{policy}-{position}'
                        result, record = run(programs[group, label], name, dict(group=group, round=index, policy=policy, label=roles[group][label]))
                        assert not result.stderr
                        if group == 'kernel':
                            record['samples'] = validate_kernel(result.stdout, kernel['resultHash'], label)
                        else:
                            assert digest(result.stdout) == derivative['outputSha256']['fwp-ad-history']
                        with (output / 'observations.jsonl').open('a') as log:
                            log.write(json.dumps(record) + '\n')
        os.sched_setaffinity(0, allowed)
        source = (args.kernel / 'matrix-65-67-63/fwp-timing.c').read_bytes()
        assert digest(source) == kernel['binaries']['fwp-timing']['sourceSha256']
        instrumented = output / 'layout.c'
        instrumented.write_text(layout_source(source.decode()))
        binary = output / 'layout'
        run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=x86-64', '-w', '-D_GNU_SOURCE',
             '-UFWP_NO_REUSE', '-DPROFILE=0', '-DMATRIX_BENCH=1', str(instrumented), '-o', str(binary), '-lm', '-lpthread'],
            'layout-build', dict(group='build'))
        for index in range(args.layout_processes):
            for policy in (['unbound', 'pinned'] if index % 2 == 0 else ['pinned', 'unbound']):
                os.sched_setaffinity(0, allowed if policy == 'unbound' else {args.cpu})
                result, record = run([str(binary)], f'layout-{index}-{policy}', dict(group='layout', round=index, policy=policy))
                record['samples'] = validate_kernel(result.stdout, kernel['resultHash'], 'fwp')
                record['layouts'] = [json.loads(line) for line in result.stderr.splitlines()]
                assert len(record['layouts']) == 40
                if policy == 'pinned':
                    assert all(r['cpuBefore'] == r['cpuAfter'] == args.cpu for r in record['layouts'])
                with (output / 'observations.jsonl').open('a') as log:
                    log.write(json.dumps(record) + '\n')
    finally:
        os.sched_setaffinity(0, allowed)
    print('Diagnostic complete; no acceptance decision or frozen limit was changed')


if __name__ == '__main__':
    main()
