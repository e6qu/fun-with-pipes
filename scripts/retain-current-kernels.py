#!/usr/bin/env python3
"""Retain every selected kernel job and audit four complete measured sessions."""
import argparse
import gzip
import importlib.util
import io
import json
import os
from pathlib import Path
import re
import subprocess
import traceback
import zipfile

SPEC = importlib.util.spec_from_file_location('kernel_check', Path(__file__).with_name('check-current-kernels.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)
REFERENCE_FIELDS = {
    'loop-state': ('referenceCodegenSha256', 'candidateCodegenSha256'),
    'matrix-columns': ('runtimeSha256', 'candidateLoopSha256', 'referenceLoopSha256'),
}


def api(path):
    return subprocess.check_output(['gh', 'api', '--allow-escape-sequences', path])


def pages(path, field):
    raw = subprocess.check_output(['gh', 'api', '--paginate', '--slurp', path + '?per_page=100'])
    return [item for page in json.loads(raw) for item in page[field]]


def save_json(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def outcome(job, host, has_measurements, comparison):
    assert job['status'] == 'completed'
    failed = [step['name'] for step in job['steps'] if step['conclusion'] == 'failure']
    steps = {step['name']: step['conclusion'] for step in job['steps']}
    measurement = {'loop-state': 'Measure both fwp variants and C/Rust with independent copy controls',
                   'matrix-columns': 'Measure paired and scalar matrix columns with C/Rust peers'}[comparison]
    check = {'loop-state': 'Reference results, aliases, failure and cancellation',
             'matrix-columns': 'Require matching native matrix safety checks'}[comparison]
    if not host['qualified']:
        assert host['failures'] and job['conclusion'] == 'failure'
        assert failed == ['Qualify the kernel host before building']
        builds = [result for name, result in steps.items() if name.startswith('Build ')]
        assert builds and all(result == 'skipped' for result in builds)
        assert steps[measurement] == 'skipped' and not has_measurements
        return 'host-rejected-before-building-or-timing'
    assert not host['failures']
    if steps[measurement] == 'skipped':
        assert job['conclusion'] == 'failure' and not has_measurements
        assert failed == [check]
        return 'reference-check-failed-before-timing'
    assert has_measurements
    assert failed in ([], [measurement]), failed
    return 'measured'


def check_prerequisite(prerequisite, report):
    source = prerequisite['run']['head_sha']
    assert prerequisite['run']['conclusion'] == 'success'
    jobs = prerequisite['jobs']
    assert len(jobs) == 3 and all(job['head_sha'] == source and job['conclusion'] == 'success' for job in jobs)
    assert {job['name'] for job in jobs} == {'matrix_checks (ubuntu-latest, gcc)',
        'matrix_checks (ubuntu-24.04-arm, gcc)', 'matrix_checks (macos-15, clang)'}
    paths = {'src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs',
        'tests/blocked_matrix.rs', 'tests/fixtures/matrix_allocation_probe.c',
        'tests/fixtures/matrix_unwind_probe.c', 'tests/fixtures/blocked_matrix.fwp'}
    assert set(prerequisite['trees']) == paths
    for path, identity in prerequisite['trees'].items():
        for revision in (source, report['source']):
            assert subprocess.check_output(['git', 'rev-parse', revision + ':' + path],
                cwd=CHECK.ROOT, text=True).strip() == identity


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repository', required=True)
    parser.add_argument('--comparison', choices=('loop-state', 'matrix-columns'), required=True)
    parser.add_argument('--selection', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'large evidence audits run on GitHub'
    assert re.fullmatch(r'[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+', args.repository)
    selection = json.loads(args.selection.read_text())
    assert selection['schema'] == 1 and len(selection['runs']) == len(set(selection['runs']))
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    summary = output / 'summary'
    summary.mkdir()
    save_json(summary / 'selection.json', selection)
    repository = 'repos/' + args.repository
    index = dict(schema=1, comparison=args.comparison, auditSource=os.environ['GITHUB_SHA'], jobs=[], measurements=[], auditErrors=[])
    seen = set()
    for run in selection['runs']:
        assert type(run) is int and run > 0
        endpoint = repository + '/actions/runs/' + str(run)
        run_metadata = json.loads(api(endpoint))
        assert run_metadata['status'] == 'completed'
        source = run_metadata['head_sha']
        assert re.fullmatch('[0-9a-f]{40}', source)
        save_json(output / f'run-{run}.json', run_metadata)
        artifacts = pages(endpoint + '/artifacts', 'artifacts')
        save_json(output / f'artifacts-{run}.json', artifacts)
        for job in pages(endpoint + '/jobs', 'jobs'):
            if job['conclusion'] == 'skipped':
                continue
            record = dict(run=run, source=source, job=job, artifacts={})
            index['jobs'].append(record)
            try:
                match = re.fullmatch(r'current_kernels \(([12]), (ubuntu-latest|ubuntu-24\.04-arm)\)', job['name'])
                assert match, job['name']
                session, runner = int(match[1]), match[2]
                machine = 'x86_64' if runner == 'ubuntu-latest' else 'aarch64'
                assert job['head_sha'] == source and job['run_id'] == run and job['status'] == 'completed'
                label = f'{machine}-{session}-{job["id"]}'
                folder = output / label
                folder.mkdir()
                log = api(repository + '/actions/jobs/' + str(job['id']) + '/logs')
                log_path = summary / (label + '.log.gz')
                log_path.write_bytes(gzip.compress(log, mtime=0))
                record.update(machine=machine, session=session, log=log_path.name,
                              logBytes=len(log), logSha256=CHECK.digest(log))

                def download(name, destination):
                    metadata, = [a for a in artifacts if a['name'] == name and not a['expired']]
                    assert metadata['workflow_run']['head_sha'] == source
                    raw = api(repository + '/actions/artifacts/' + str(metadata['id']) + '/zip')
                    assert metadata['digest'] == 'sha256:' + CHECK.digest(raw)
                    with zipfile.ZipFile(io.BytesIO(raw)) as archive:
                        CHECK.PATCH.check_zip(archive)
                        archive.extractall(destination)
                    record['artifacts'][name] = metadata

                download('current-kernel-host-' + runner + '-' + str(session), folder / 'host')
                host = json.loads((folder / 'host/current-kernel-host.json').read_text())
                assert host['source'] == source and host['actual']['machine'] == machine
                name = 'current-kernels-' + runner + '-' + str(session)
                has_measurements = any(a['name'] == name for a in artifacts)
                record['qualification'] = host
                record['decision'] = outcome(job, host, has_measurements, args.comparison)
                if record['decision'] == 'host-rejected-before-building-or-timing':
                    continue
                if args.comparison == 'loop-state':
                    download('loop-state-reference-' + runner + '-' + str(session), folder / 'reference')
                if record['decision'] == 'reference-check-failed-before-timing':
                    if args.comparison == 'loop-state':
                        record['referenceTestLogs'] = {p.name: p.read_text() for p in
                            sorted((folder / 'reference/targets').glob('*.log'))}
                        assert record['referenceTestLogs']
                    continue
                assert (machine, session) not in seen, 'duplicate measured session'
                seen.add((machine, session))
                download(name, folder / 'measurements')
                failures = CHECK.check_directory(folder / 'measurements', source, machine, session)
                report_path = folder / 'measurements/comparison.json'
                raw_report = report_path.read_bytes()
                report = json.loads(raw_report)
                assert job['conclusion'] == ('failure' if failures else 'success')
                assert report['qualification'] == host
                if args.comparison == 'loop-state':
                    assert report['referenceManifest'] == json.loads((folder / 'reference/manifest.json').read_text())
                else:
                    assert report['referenceManifest']['disabledTransformation'] == 'paired matrix columns'
                    download('matrix-prerequisite-' + runner + '-' + str(session), folder / 'prerequisite')
                    prerequisite_raw = (folder / 'prerequisite/matrix-prerequisite.json').read_bytes()
                    check_prerequisite(json.loads(prerequisite_raw), report)
                    prerequisite_path = summary / (label + '-prerequisite.json')
                    prerequisite_path.write_bytes(prerequisite_raw)
                    record.update(prerequisite=prerequisite_path.name, prerequisiteSha256=CHECK.digest(prerequisite_raw))
                if session == 1 or args.comparison == 'matrix-columns':
                    required = ('Reference results, aliases, failure and cancellation' if args.comparison == 'loop-state'
                                else 'Require matching native matrix safety checks')
                    step, = [s for s in job['steps'] if s['name'] == required]
                    assert step['conclusion'] == 'success'
                saved_report = summary / (label + '.json.gz')
                saved_report.write_bytes(gzip.compress(raw_report, mtime=0))
                files = {str(path.relative_to(folder / 'measurements')): dict(bytes=path.stat().st_size,
                         sha256=CHECK.digest(path.read_bytes())) for path in
                         sorted((folder / 'measurements').rglob('*')) if path.is_file()}
                files_path = summary / (label + '-files.json.gz')
                files_path.write_bytes(gzip.compress((json.dumps(files, indent=2) + '\n').encode(), mtime=0))
                record.update(report=saved_report.name, reportBytes=len(raw_report), reportSha256=CHECK.digest(raw_report),
                    files=files_path.name, filesSha256=CHECK.digest(files_path.read_bytes()),
                    failures=failures, sourceTrees=report['sourceTrees'],
                    decision='all-current-rules-pass' if not failures else 'performance-limits-remain-open')
                record.update({field: report['referenceManifest'][field] for field in REFERENCE_FIELDS[args.comparison]})
                index['measurements'].append(job['id'])
                print(label + ': ' + record['decision'], flush=True)
            except Exception as error:
                index['auditErrors'].append(dict(job=job['id'], error=type(error).__name__ + ': ' + str(error)))
                traceback.print_exc()
            finally:
                save_json(summary / 'index.json', index)
    assert not index['auditErrors'], index['auditErrors']
    assert seen == {(machine, session) for machine in ('aarch64', 'x86_64') for session in (1, 2)}
    assert sorted(index['measurements']) == sorted(selection['measuredJobs'])
    measured = [row for row in index['jobs'] if row['job']['id'] in index['measurements']]
    assert all(row['sourceTrees'] == measured[0]['sourceTrees'] for row in measured)
    for field in REFERENCE_FIELDS[args.comparison]:
        assert len({row[field] for row in measured}) == 1
    index['complete'] = True
    index['decision'] = 'all-current-rules-pass' if all(not row['failures'] for row in measured) else 'performance-limits-remain-open'
    save_json(summary / 'index.json', index)
    print('Four measured sessions and all preceding failures retained; ' + index['decision'])


if __name__ == '__main__':
    main()
