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
import zipfile

from process_wait import run_capture

SPEC = importlib.util.spec_from_file_location('kernel_measurement', Path(__file__).with_name('measure-kernel-baselines.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)
SPEC = importlib.util.spec_from_file_location('archive_check', Path(__file__).with_name('check-array-list-evidence.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def evidence_record(index, source, machine, session):
    assert index['schema'] == 1 and index['complete'] and not index['auditErrors']
    record, = [row for row in index['jobs'] if row['source'] == source
               and row['machine'] == machine and row['session'] == session
               and row['job']['id'] in index['measurements']]
    assert record['qualification']['qualified'] and not record['qualification']['failures']
    artifact, = [value for name, value in record['artifacts'].items()
                 if name.startswith('current-kernels-')]
    assert artifact['workflow_run']['head_sha'] == source
    return record, artifact


def read_archive(path, index, source, machine, session):
    record, artifact = evidence_record(index, source, machine, session)
    assert artifact['digest'] == 'sha256:' + digest(path.read_bytes())
    archive = zipfile.ZipFile(path)
    try:
        CHECK.check_zip(archive)
        raw = archive.read('comparison.json')
        assert len(raw) == record['reportBytes'] and digest(raw) == record['reportSha256']
        report = json.loads(raw)
        assert report['source'] == source and report['configuration']['session'] == session
        assert report['qualification'] == record['qualification']
        assert report['failures'] == record['failures']
        return archive, report, artifact
    except BaseException:
        archive.close()
        raise


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['archive', 'index', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ['source', 'cc', 'c-arch']:
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--timeout', type=int, required=True)
    parser.add_argument('--session', type=int, choices=(1, 2), required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.timeout == 180
    archive, report, artifact = read_archive(args.archive, json.loads(args.index.read_text()),
        args.source, platform.machine(), args.session)
    expected = report['qualification']['actual']
    assert platform.machine() == expected['machine']
    assert args.c_arch == report['configuration']['c_arch']
    version = subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0]
    assert version == expected['cVersion']
    host = dict(system=platform.system(), machine=platform.machine(), cVersion=version,
                cpuInfo=json.loads(subprocess.check_output(['lscpu', '--json'], text=True)))
    assert list(report['results']) == list(MEASURE.CASES)
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    configuration = dict(diagnosticSource=os.environ['GITHUB_SHA'], inputSource=args.source,
                         host=host, inputFailures=report['failures'], inputArtifact=artifact, decision='diagnostic-only',
                         arguments={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()})
    (output / 'configuration.json').write_text(json.dumps(configuration, indent=2) + '\n')
    results = {}

    def run(command, destination):
        command = list(map(str, command))
        try:
            execution = run_capture(command, timeout=args.timeout, env=os.environ.copy(), cwd=None,
                input_data=None, input_stream=None, text=False, encoding='utf-8', check=False)
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
            source = archive.read(case + '/' + name + '.c')
            assert digest(source) == info['sourceSha256']
            assert Path(info['path']).name == info['path']
            original = archive.read(case + '/' + info['path'])
            assert digest(original) == info['sha256']
            path = directory / (name + '.c')
            path.write_bytes(source)
            binary = directory / info['path']
            vector = directory / (language + '-vectorization.txt')
            optimized = directory / (language + '-optimized.txt')
            run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch, '-w',
                 '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=0',
                 '-DMATRIX_BENCH=' + str(int(case.startswith('matrix'))),
                 '-fopt-info-vec-all=' + str(vector), '-fdump-tree-optimized=' + str(optimized),
                 path, '-o', binary, '-lm', '-lpthread'], directory / (language + '-build'))
            assert binary.read_bytes() == original, 'Report options changed the retained binary'
            assert vector.stat().st_size > 0 and optimized.stat().st_size > 0
            invocation = [binary] + (['matrix' if case.startswith('matrix') else 'array'] if language == 'c' else [])
            raw = run(invocation, directory / (language + '-output'))
            MEASURE.check_samples(raw, row['resultHash'], language, False)
            results[case][language] = dict(binarySha256=info['sha256'], sourceSha256=info['sourceSha256'],
                                           vectorizationSha256=digest(vector.read_bytes()),
                                           optimizedTreeSha256=digest(optimized.read_bytes()),
                                           stdoutSha256=digest(raw), expectedResultHash=row['resultHash'])
            (output / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    archive.close()
    print('Eight original binary hashes and all outputs match; compiler reports are diagnostic only')


if __name__ == '__main__':
    main()
