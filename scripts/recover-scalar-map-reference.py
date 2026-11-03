#!/usr/bin/env python3
"""Recover an omitted reference artifact only if every recorded byte hash matches.

This explicit repair builds the frozen reference; it never repeats measurements.
The ordinary retainer still rejects missing artifacts. Recovery records identify
newly reconstructed files separately from the original measurement artifacts.
"""
import argparse
import gzip
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess
import traceback

SPEC = importlib.util.spec_from_file_location(
    'retain', Path(__file__).with_name('retain-derivative-evidence.py'))
RETAIN = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RETAIN)
ROOT = Path(__file__).resolve().parent.parent


def verify_recovered_reference(folder, report, source, architecture):
    actual = json.loads((folder / 'manifest.json').read_text())
    expected = report['referenceCompiler']
    assert actual == expected, {'recorded': expected, 'reconstructed': actual}
    RETAIN.CHECK.check_reference(folder, report, source, architecture, 'scalar-array-map')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repository', required=True)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--runner', choices=['ubuntu-latest', 'ubuntu-24.04-arm'], required=True)
    parser.add_argument('--candidate-checkout', type=Path, required=True)
    parser.add_argument('--reference-checkout', type=Path, required=True)
    parser.add_argument('--target-dir', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'reference builds belong on runners'
    assert re.fullmatch(r'[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+', args.repository)
    assert re.fullmatch('[0-9a-f]{40}', args.source) and args.run > 0
    architecture = {'ubuntu-latest': 'x86_64', 'ubuntu-24.04-arm': 'aarch64'}[args.runner]
    assert platform.machine() == architecture
    repository = 'repos/' + args.repository
    run_path = repository + '/actions/runs/' + str(args.run)
    metadata = json.loads(RETAIN.api(run_path))
    assert metadata['status'] == 'completed' and metadata['head_sha'] == args.source
    args.output.mkdir(parents=True, exist_ok=False)
    summary = args.output / 'summary'
    summary.mkdir()
    jobs = RETAIN.pages(run_path + '/jobs', 'jobs')
    artifacts = RETAIN.pages(run_path + '/artifacts', 'artifacts')
    RETAIN.save_json(args.output / 'run.json', metadata)
    RETAIN.save_json(args.output / 'jobs.json', jobs)
    RETAIN.save_json(args.output / 'artifacts.json', artifacts)
    selected = [job for job in jobs if re.fullmatch(
        r'descent_peers \([12], ' + re.escape(args.runner) + r'\)', job['name'])]
    assert selected
    index = dict(protocol='scalar-array-map', source=args.source, run=args.run,
                 sessions={}, auditErrors=[], recovery=dict(
                     method='rebuild frozen reference and require exact recorded hashes',
                     workflowRun=os.environ['GITHUB_RUN_ID'],
                     toolingSource=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()))
    recovered = args.output / 'reconstructed-reference'
    prepared = False
    for job in selected:
        try:
            assert job['status'] == 'completed' and job['head_sha'] == args.source
            assert job['run_id'] == args.run
            session = int(job['name'].split('(', 1)[1].split(',', 1)[0])
            label = architecture + '-' + str(session)
            folder = args.output / label
            folder.mkdir()
            RETAIN.save_json(folder / 'job.json', job)
            log = RETAIN.api(repository + '/actions/jobs/' + str(job['id']) + '/logs')
            log_path = summary / (label + '.log.gz')
            log_path.write_bytes(gzip.compress(log, mtime=0))
            record = dict(source=args.source, run=args.run, architecture=architecture,
                          session=session, job=job, log=log_path.name, logBytes=len(log),
                          logSha256=hashlib.sha256(log).hexdigest(), artifacts={})

            def download(name, destination):
                artifact, = [a for a in artifacts if a['name'] == name and not a['expired']]
                assert artifact['workflow_run']['head_sha'] == args.source
                data = RETAIN.api(repository + '/actions/artifacts/' + str(artifact['id']) + '/zip')
                RETAIN.unpack(data, artifact, destination)
                record['artifacts'][name] = artifact
                RETAIN.save_json(folder / (destination.name + '-artifact.json'), artifact)

            download('descent-host-' + args.runner + '-' + str(session), folder / 'host')
            host = json.loads((folder / 'host/descent-host.json').read_text())
            assert host['source'] == args.source and host['actual']['machine'] == architecture
            record['qualification'] = host
            if not host['qualified']:
                RETAIN.rejected_host(job, host)
                record['decision'] = 'host-rejected-before-building-or-timing'
            else:
                assert not host['failures']
                name = 'scalar-array-map-reference-' + args.runner + '-' + str(session)
                assert not any(a['name'] == name for a in artifacts), 'use ordinary retention for existing artifacts'
                download('descent-peers-' + args.runner + '-' + str(session), folder / 'measurements')
                report = json.loads((folder / 'measurements/comparison.json').read_text())
                RETAIN.CHECK.GROUPS.check_report(report, args.source, 'scalar-array-map')
                assert report['machine'] == architecture and report['configuration']['session'] == session
                if not prepared:
                    for checkout in (args.candidate_checkout, args.reference_checkout):
                        subprocess.run(['git', 'worktree', 'add', '--detach', str(checkout), args.source], cwd=ROOT, check=True)
                    preparation = args.candidate_checkout / 'scripts/prepare-scalar-array-map-reference.py'
                    subprocess.run(['python3', str(preparation), '--checkout', str(args.reference_checkout),
                                    '--output', str(recovered)], check=True)
                    subprocess.run(['cargo', 'fetch', '--locked', '--manifest-path',
                                    str(args.reference_checkout / 'Cargo.toml')], check=True)
                    command = ['cargo', 'build', '--locked', '--release', '--bin', 'fwp',
                               '--manifest-path', str(args.reference_checkout / 'Cargo.toml'),
                               '--target-dir', str(args.target_dir)]
                    RETAIN.save_json(args.output / 'recovery-command.json', command)
                    subprocess.run(command, check=True, env=dict(os.environ, CARGO_NET_OFFLINE='true'))
                    shutil.copyfile(args.target_dir / 'release/fwp', recovered / 'fwp')
                    subprocess.run(['python3', str(preparation), '--verify', str(args.reference_checkout),
                                    '--output', str(recovered)], check=True)
                    prepared = True
                verify_recovered_reference(recovered, report, args.source, architecture)
                shutil.copytree(recovered, folder / 'reference')
                audit = RETAIN.CHECK.check_directory(folder / 'measurements', args.source,
                    architecture, session, 'scalar-array-map', folder / 'reference')
                failures = audit['budgetFailures']
                assert job['conclusion'] == ('failure' if failures else 'success')
                failed_steps = [step['name'] for step in job['steps'] if step['conclusion'] == 'failure']
                assert failed_steps == (['Compare the candidate with its same-source reference'] if failures else [])
                raw = (folder / 'measurements/comparison.json').read_bytes()
                report_path = summary / (label + '.json.gz')
                report_path.write_bytes(gzip.compress(raw, mtime=0))
                record.update(decision=audit['decision'], audit=audit, report=report_path.name,
                    reportBytes=len(raw), reportSha256=hashlib.sha256(raw).hexdigest(),
                    referencePatch=(recovered / 'reference.patch').read_text(),
                    referenceRecovery=index['recovery'])
            index['sessions'][label] = record
            print(label + ': ' + record['decision'], flush=True)
        except Exception as error:
            index['auditErrors'].append(dict(job=job['id'], error=type(error).__name__ + ': ' + str(error)))
            traceback.print_exc()
        RETAIN.save_json(summary / 'index.json', index)
    assert index['sessions'], 'no recovered session evidence'
    assert not index['auditErrors'], index['auditErrors']


if __name__ == '__main__':
    main()
