#!/usr/bin/env python3
"""Audit a completed record-zip run on GitHub and retain every original outcome."""
import argparse
import gzip
import hashlib
import importlib.util
import io
import json
import os
from pathlib import Path
import re
import subprocess
import traceback
import zipfile

SPEC = importlib.util.spec_from_file_location('evidence', Path(__file__).with_name('check-array-list-evidence.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)


def api(path):
    return subprocess.check_output(['gh', 'api', '--allow-escape-sequences', path])


def pages(path, field):
    raw = subprocess.check_output(['gh', 'api', '--paginate', '--slurp', path + '?per_page=100'])
    return [record for page in json.loads(raw) for record in page[field]]


def save_json(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def unpack(data, metadata, folder):
    assert 'sha256:' + hashlib.sha256(data).hexdigest() == metadata['digest']
    with zipfile.ZipFile(io.BytesIO(data)) as archive:
        CHECK.check_zip(archive)
        archive.extractall(folder)


def rejected_host(job, host):
    assert host['qualified'] is False and host['failures']
    assert job['conclusion'] == 'failure'
    failed = [step['name'] for step in job['steps'] if step['conclusion'] == 'failure']
    assert failed == ['Qualify the native host before building'], failed
    for step in job['steps']:
        if 'cargo build' in step['name'] or step['name'] in (
                'Build the same-source reference with only the selected transformation disabled',
                'Compare the candidate with its same-source reference'):
            assert step['conclusion'] == 'skipped', step


def retain_session(repository, run, source, job, artifacts, output, summary):
    match = re.fullmatch(r'descent_peers \(([12]), (ubuntu-latest|ubuntu-24\.04-arm)\)', job['name'])
    assert match, job['name']
    session, runner = int(match[1]), match[2]
    architecture = {'ubuntu-latest': 'x86_64', 'ubuntu-24.04-arm': 'aarch64'}[runner]
    label = architecture + '-' + str(session)
    folder = output / label
    folder.mkdir()
    assert job['status'] == 'completed' and job['head_sha'] == source and job['run_id'] == run
    save_json(folder / 'job.json', job)
    log = api(repository + '/actions/jobs/' + str(job['id']) + '/logs')
    log_path = summary / (label + '.log.gz')
    log_path.write_bytes(gzip.compress(log, mtime=0))
    record = dict(source=source, run=run, architecture=architecture, session=session, job=job,
                  log=log_path.name, logBytes=len(log), logSha256=CHECK.digest(log), artifacts={})

    def download(name, destination):
        metadata, = [item for item in artifacts if item['name'] == name and not item['expired']]
        assert metadata['workflow_run']['head_sha'] == source
        data = api(repository + '/actions/artifacts/' + str(metadata['id']) + '/zip')
        unpack(data, metadata, destination)
        record['artifacts'][name] = metadata
        save_json(folder / (destination.name + '-artifact.json'), metadata)

    download('descent-host-' + runner + '-' + str(session), folder / 'host')
    host = json.loads((folder / 'host/descent-host.json').read_text())
    assert host['source'] == source and host['actual']['machine'] == architecture
    record['qualification'] = host
    if not host['qualified']:
        rejected_host(job, host)
        record['decision'] = 'host-rejected-before-building-or-timing'
        return label, record
    assert not host['failures']
    download('descent-peers-' + runner + '-' + str(session), folder / 'measurements')
    download('record-zip-reference-' + runner + '-' + str(session), folder / 'reference')
    audit = CHECK.check_directory(folder / 'measurements', source, architecture, session,
                                 'record-zip', folder / 'reference')
    failures = audit['budgetFailures']
    assert job['conclusion'] == ('failure' if failures else 'success')
    failed_steps = [step['name'] for step in job['steps'] if step['conclusion'] == 'failure']
    assert failed_steps == (['Compare the candidate with its same-source reference'] if failures else [])
    report = (folder / 'measurements/comparison.json').read_bytes()
    report_path = summary / (label + '.json.gz')
    report_path.write_bytes(gzip.compress(report, mtime=0))
    record.update(decision=audit['decision'], audit=audit, report=report_path.name,
                  reportBytes=len(report), reportSha256=CHECK.digest(report),
                  referencePatch=(folder / 'reference/reference.patch').read_text())
    return label, record


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repository', required=True)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'large evidence processing belongs on GitHub'
    assert re.fullmatch(r'[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+', args.repository)
    assert re.fullmatch('[0-9a-f]{40}', args.source) and args.run > 0
    repository = 'repos/' + args.repository
    run_path = repository + '/actions/runs/' + str(args.run)
    metadata = json.loads(api(run_path))
    assert metadata['status'] == 'completed' and metadata['head_sha'] == args.source
    args.output.mkdir(parents=True, exist_ok=False)
    summary = args.output / 'summary'
    summary.mkdir()
    save_json(args.output / 'run.json', metadata)
    jobs = pages(run_path + '/jobs', 'jobs')
    artifacts = pages(run_path + '/artifacts', 'artifacts')
    save_json(args.output / 'jobs.json', jobs)
    save_json(args.output / 'artifacts.json', artifacts)
    index = dict(source=args.source, run=args.run, sessions={}, auditErrors=[])
    for job in jobs:
        if job['conclusion'] == 'skipped':
            continue
        try:
            label, record = retain_session(repository, args.run, args.source, job, artifacts,
                                           args.output, summary)
            assert label not in index['sessions']
            index['sessions'][label] = record
            print(label + ': ' + record['decision'], flush=True)
        except Exception as error:
            index['auditErrors'].append(dict(job=job['id'], error=type(error).__name__ + ': ' + str(error)))
            traceback.print_exc()
        save_json(summary / 'index.json', index)
    assert index['sessions'], 'no completed session evidence'
    assert not index['auditErrors'], index['auditErrors']


if __name__ == '__main__':
    main()
