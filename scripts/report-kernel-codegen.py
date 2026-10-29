#!/usr/bin/env python3
"""Collect GCC explanations for exact retained kernel binaries; do not benchmark."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import subprocess

SPEC = importlib.util.spec_from_file_location('kernel_measurement', Path(__file__).with_name('measure-kernel-baselines.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['evidence', 'qualification', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ['source', 'cc', 'c-arch']:
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--timeout', type=int, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.timeout == 180
    report = json.loads((args.evidence / 'comparison.json').read_text())
    host = json.loads(args.qualification.read_text())
    assert report['source'] == args.source
    assert host['source'] == os.environ['GITHUB_SHA']
    assert host['qualified'] and not host['failures']
    assert host['actual'] == host['expected'] == report['qualification']['actual']
    assert platform.machine() == host['actual']['machine']
    assert args.c_arch == report['configuration']['c_arch']
    assert subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0] == host['actual']['cVersion']
    assert list(report['results']) == list(MEASURE.CASES)
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    configuration = dict(diagnosticSource=os.environ['GITHUB_SHA'], inputSource=args.source,
                         qualification=host, inputFailures=report['failures'], decision='diagnostic-only',
                         arguments={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()})
    (output / 'configuration.json').write_text(json.dumps(configuration, indent=2) + '\n')
    results = {}

    def run(command, destination):
        command = list(map(str, command))
        try:
            execution = subprocess.run(command, capture_output=True, timeout=args.timeout)
            timed_out = False
        except subprocess.TimeoutExpired as error:
            execution = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
            timed_out = True
        for stream in ['stdout', 'stderr']:
            destination.with_suffix('.' + stream).write_bytes(getattr(execution, stream))
        record = dict(command=command, status=execution.returncode, timedOut=timed_out,
                      stdoutSha256=digest(execution.stdout), stderrSha256=digest(execution.stderr))
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(record) + '\n')
        assert execution.returncode == 0 and not timed_out, record
        assert not execution.stderr, execution.stderr.decode(errors='replace')
        return execution.stdout

    for case, row in report['results'].items():
        directory = output / case
        directory.mkdir()
        results[case] = {}
        for language in ['c', 'fwp']:
            name = language + '-timing'
            info = row['binaries'][name]
            original = args.evidence / case
            source = (original / (name + '.c')).read_bytes()
            assert digest(source) == info['sourceSha256']
            assert digest((original / name).read_bytes()) == info['sha256']
            path = directory / (name + '.c')
            path.write_bytes(source)
            binary = directory / name
            vector = directory / (language + '-vectorization.txt')
            optimized = directory / (language + '-optimized.txt')
            run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch, '-w',
                 '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=0',
                 '-DMATRIX_BENCH=' + str(int(case.startswith('matrix'))),
                 '-fopt-info-vec-all=' + str(vector), '-fdump-tree-optimized=' + str(optimized),
                 path, '-o', binary, '-lm', '-lpthread'], directory / (language + '-build'))
            assert digest(binary.read_bytes()) == info['sha256'], 'Report options changed the retained binary'
            assert vector.stat().st_size > 0 and optimized.stat().st_size > 0
            invocation = [binary] + (['matrix' if case.startswith('matrix') else 'array'] if language == 'c' else [])
            raw = run(invocation, directory / (language + '-output'))
            MEASURE.check_samples(raw, row['resultHash'], language, False)
            results[case][language] = dict(binarySha256=info['sha256'], sourceSha256=info['sourceSha256'],
                                           vectorizationSha256=digest(vector.read_bytes()),
                                           optimizedTreeSha256=digest(optimized.read_bytes()),
                                           stdoutSha256=digest(raw), expectedResultHash=row['resultHash'])
            (output / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    print('Eight original binary hashes and all outputs match; compiler reports are diagnostic only')


if __name__ == '__main__':
    main()
