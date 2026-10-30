#!/usr/bin/env python3
"""Observe CPU work, faults and scheduling in retained programs; never accept timing."""
import argparse
import gzip
import importlib.util
import json
import os
from pathlib import Path
import platform
import resource
import subprocess
import time

SPEC = importlib.util.spec_from_file_location('timing_diagnostic', Path(__file__).with_name('diagnose-timing-variation.py'))
DIAGNOSTIC = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(DIAGNOSTIC)
FIELDS = {'userSeconds': 'ru_utime', 'systemSeconds': 'ru_stime', 'minorFaults': 'ru_minflt',
          'majorFaults': 'ru_majflt', 'voluntarySwitches': 'ru_nvcsw', 'involuntarySwitches': 'ru_nivcsw'}


def resource_delta(before, after):
    result = {name: getattr(after, field) - getattr(before, field) for name, field in FIELDS.items()}
    assert all(value >= 0 for value in result.values()), result
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['kernel', 'derivative', 'qualification', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ['kernel-source', 'derivative-source']:
        parser.add_argument('--' + name, required=True)
    for name in ['rounds', 'processes', 'seed', 'timeout']:
        parser.add_argument('--' + name, type=int, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux' and platform.machine() == 'x86_64'
    assert (args.rounds, args.processes, args.seed, args.timeout) == (16, 4, 20261029, 180)
    host = json.loads(args.qualification.read_text())
    assert host['qualified'] and not host['failures'] and host['actual'] == host['expected']
    assert host['actual']['cpu'] == 'AMD EPYC 7763 64-Core Processor'
    allowed = sorted(os.sched_getaffinity(0))
    assert len(allowed) == 4
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    reports = {name: json.loads((path / 'comparison.json').read_text())
               for name, path in [('kernel', args.kernel), ('derivative', args.derivative)]}
    for name, source in [('kernel', args.kernel_source), ('derivative', args.derivative_source)]:
        assert reports[name]['source'] == source
        assert reports[name]['qualification']['actual'] == host['actual']
    configuration = dict(source=os.environ['GITHUB_SHA'], qualification=host, allowedCpus=allowed,
                         decision='diagnostic-only', arguments={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()})
    (output / 'configuration.json').write_text(json.dumps(configuration, indent=2) + '\n')
    programs, origins = {}, {}
    roles = {'kernel': DIAGNOSTIC.SCHEDULE.LABELS,
             'derivative': ['candidate', 'reference', 'candidate-copy', 'reference-copy']}
    kernel = reports['kernel']['results']['array-65537']
    derivative = reports['derivative']['results']['3-0']
    for group, directory, row, originals in [
        ('kernel', args.kernel / 'array-65537', kernel, ['c-timing', 'rust-timing', 'fwp-timing', 'fwp-timing']),
        ('derivative', args.derivative / '3-0', derivative,
         ['fwp-ad-history', 'fwp-ad-history-reference', 'fwp-ad-history', 'fwp-ad-history-reference']),
    ]:
        for label, role, original in zip(DIAGNOSTIC.SCHEDULE.LABELS, roles[group], originals):
            raw = (directory / original).read_bytes()
            assert DIAGNOSTIC.digest(raw) == row['binaries'][original]['sha256']
            path = output / (group + '-' + role + '.exe')
            path.write_bytes(raw)
            path.chmod(0o755)
            programs[group, label] = [str(path)] + (['array'] if group == 'kernel' and label in ['c', 'rust'] else [])
            origins[group + '-' + role] = dict(original=original, sha256=DIAGNOSTIC.digest(raw))
    (output / 'programs.json').write_text(json.dumps(origins, indent=2) + '\n')
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    environment.pop('FWP_NO_OPT', None)
    for group in ['kernel', 'derivative']:
        for index in range(args.rounds):
            for position, label in enumerate(DIAGNOSTIC.SCHEDULE.execution_order(index, args.seed, args.processes)):
                command = programs[group, label]
                name = f'{group}-{index}-{position}'
                before = resource.getrusage(resource.RUSAGE_CHILDREN)
                started = time.perf_counter_ns()
                timed_out = False
                try:
                    result = subprocess.run(command, env=environment, capture_output=True, timeout=args.timeout)
                except subprocess.TimeoutExpired as error:
                    result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
                    timed_out = True
                elapsed = time.perf_counter_ns() - started
                after = resource.getrusage(resource.RUSAGE_CHILDREN)
                record = dict(group=group, round=index, position=position, label=label,
                              role=roles[group][DIAGNOSTIC.SCHEDULE.LABELS.index(label)], command=command,
                              status=result.returncode, timedOut=timed_out, elapsedNs=elapsed,
                              resources=resource_delta(before, after))
                for stream in ['stdout', 'stderr']:
                    raw = getattr(result, stream)
                    record[stream + 'Sha256'] = DIAGNOSTIC.digest(raw)
                    (output / (name + '.' + stream + '.gz')).write_bytes(gzip.compress(raw, mtime=0))
                with (output / 'processes.jsonl').open('a') as log:
                    log.write(json.dumps(record) + '\n')
                assert result.returncode == 0 and not timed_out and not result.stderr, record
                if group == 'kernel':
                    record['samples'] = DIAGNOSTIC.validate_kernel(result.stdout, kernel['resultHash'], label)
                else:
                    assert DIAGNOSTIC.digest(result.stdout) == derivative['outputSha256']['fwp-ad-history']
                with (output / 'observations.jsonl').open('a') as log:
                    log.write(json.dumps(record) + '\n')
    print('512 unchanged-program resource observations retained; no acceptance decision')


if __name__ == '__main__':
    main()
