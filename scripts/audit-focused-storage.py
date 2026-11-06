#!/usr/bin/env python3
"""Audit all three focused storage jobs, target results and native image headers."""
import argparse
import gzip
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import subprocess
import zipfile

SPEC = importlib.util.spec_from_file_location('production_audit', Path(__file__).with_name('audit-production-run.py'))
PRODUCTION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PRODUCTION)
HOSTS = {
    'arm': ('gradient_call_checks (ubuntu-24.04-arm, gcc)', 'ubuntu-24.04-arm'),
    'amd': ('gradient_call_checks (ubuntu-latest, gcc)', 'ubuntu-latest'),
    'mac': ('gradient_call_checks (macos-15, clang)', 'macos-15'),
}


def native_header(host, raw):
    if host == 'mac':
        return len(raw) >= 32 and raw[:4] == b'\xcf\xfa\xed\xfe' and int.from_bytes(raw[4:8], 'little') == 0x100000c
    assert host in ('arm', 'amd'), host
    return len(raw) >= 64 and raw[:6] == b'\x7fELF\x02\x01' and int.from_bytes(raw[18:20], 'little') == (183 if host == 'arm' else 62)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--attempt', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert args.attempt > 0 and re.fullmatch(r'[0-9a-f]{40}', args.source)
    args.output.mkdir(parents=True, exist_ok=True)
    jobs = json.loads(PRODUCTION.api(f'actions/runs/{args.run}/attempts/{args.attempt}/jobs?per_page=100'))['jobs']
    artifacts = json.loads(PRODUCTION.api(f'actions/runs/{args.run}/artifacts?per_page=100'))['artifacts']
    PRODUCTION.save(args.output / 'jobs.json', jobs)
    PRODUCTION.save(args.output / 'artifacts.json', artifacts)
    issues, summary = [], {}
    for host, (name, runner) in HOSTS.items():
        job, = [j for j in jobs if j['name'] == name]
        assert job['head_sha'] == args.source
        if job['status'] != 'completed':
            issues.append((host, 'job is incomplete'))
            continue
        log = PRODUCTION.api(f"actions/jobs/{job['id']}/logs")
        (args.output / (host + '-job.log.gz')).write_bytes(gzip.compress(log, mtime=0))
        report = dict(source=args.source, job=job, jobLogSha256=hashlib.sha256(log).hexdigest(),
                      files={}, targets={}, probes={}, images={}, diagnostics={})
        diagnostics = PRODUCTION.diagnostics(log)
        if diagnostics:
            report['diagnostics']['job'] = [line.decode(errors='replace') for line in diagnostics]
        if job['conclusion'] != 'success':
            issues.append((host, 'job ' + str(job['conclusion'])))
        artifact_name = 'gradient-call-checks-' + runner
        ids = {int(i) for i in re.findall(rb'Artifact ' + artifact_name.encode() + rb' successfully finalized\. Artifact ID ([0-9]+)', log)}
        matches = [a for a in artifacts if a['id'] in ids and a['name'] == artifact_name and not a['expired']]
        if len(matches) != 1:
            issues.append((host, 'missing or ambiguous evidence artifact'))
            PRODUCTION.save(args.output / (host + '-audit.json'), report)
            continue
        artifact, = matches
        assert artifact['workflow_run']['head_sha'] == args.source
        report['artifact'] = artifact
        archive = args.output / (host + '-evidence.zip')
        with archive.open('wb') as out:
            subprocess.run(['gh', 'api', '--allow-escape-sequences',
                            f"repos/e6qu/fun-with-pipes/actions/artifacts/{artifact['id']}/zip"], stdout=out, check=True)
        with archive.open('rb') as data:
            assert artifact['digest'] == 'sha256:' + hashlib.file_digest(data, 'sha256').hexdigest()
        retained = args.output / (host + '-records.zip')
        with zipfile.ZipFile(archive) as z, zipfile.ZipFile(retained, 'w', zipfile.ZIP_DEFLATED) as records:
            assert z.read('source.txt').decode().strip() == args.source
            for name in z.namelist():
                if name.endswith('/'):
                    continue
                raw = z.read(name)
                report['files'][name] = hashlib.sha256(raw).hexdigest()
                if name.endswith('.log'):
                    found = PRODUCTION.diagnostics(raw)
                    if found:
                        report['diagnostics'][name] = [line.decode(errors='replace') for line in found]
                    if name.startswith('targets/'):
                        results = re.findall(rb'test result: ([^\r\n]+)', raw)
                        report['targets'][name] = [s.decode() for s in results]
                        if len(results) != 1 or not re.fullmatch(rb'ok\. \d+ passed; 0 failed; 0 ignored;.*', results[0]):
                            issues.append((host, name + ': missing/failed/ignored target result'))
                if name.endswith('.exe'):
                    report['images'][name] = report['files'][name]
                    if not native_header(host, raw):
                        issues.append((host, name + ': wrong native image format/architecture'))
                if name.endswith('.status'):
                    report['probes'][name] = raw.decode().strip()
                if not name.endswith('.exe') and (not name.endswith('.c') or name.startswith(('selection/', 'consuming-selection/'))):
                    records.writestr(name, raw)
            for member in ('selection/packed-pair-selection.json', 'selection/gradient-call-selection.json', 'consuming-selection/record.json'):
                report[member] = json.loads(z.read(member))
            assert len(report['selection/packed-pair-selection.json']) == 3
            constant_steps = [step for step in job['steps']
                              if step['name'] == 'Verify exact scalar constants in complete programs']
            if constant_steps and constant_steps[0]['conclusion'] == 'success':
                constants = json.loads(z.read('selection/scalar-constant-selection.json'))
                assert len(constants) == 3 and all(row['representation'] == 'literal' for row in constants.values())
                report['selection/scalar-constant-selection.json'] = constants
            recording_steps = [step for step in job['steps']
                               if step['name'] == 'Verify live bounded recording lookup selection']
            if recording_steps and recording_steps[0]['conclusion'] == 'success':
                recording = json.loads(z.read('selection/recording-lookup-selection.json'))
                assert len(recording) == 3 and all(row['enabled'] and row['liveWorkers']
                    and set(row['liveWorkers'].values()) == {6} for row in recording.values())
                report['selection/recording-lookup-selection.json'] = recording
            context_steps = [step for step in job['steps']
                             if step['name'] == 'Verify live numeric call and loop recording scopes']
            if context_steps and context_steps[0]['conclusion'] == 'success':
                context = json.loads(z.read('selection/recording-context-selection.json'))
                assert len(context) == 3
                assert all(row['enabled'] and len(row['loopScopes']) == 2
                           and sorted(n for n in row['liveWorkers'].values() if n) == [1, 6]
                           and any(row['forwardedCalls'].values()) for row in context.values())
                report['selection/recording-context-selection.json'] = context
        if len(report['targets']) != 25 or not report['images'] or not report['probes']:
            issues.append((host, 'incomplete targets/images/probe observations'))
        if report['diagnostics']:
            issues.append((host, report['diagnostics']))
        report['retainedArchiveSha256'] = hashlib.sha256(retained.read_bytes()).hexdigest()
        PRODUCTION.save(args.output / (host + '-audit.json'), report)
        summary[host] = dict(job=job['id'], targets=len(report['targets']),
                             images=len(report['images']), probes=len(report['probes']),
                             conclusion=job['conclusion'])
        print(host, summary[host], flush=True)
    PRODUCTION.save(args.output / 'summary.json', dict(source=args.source, run=args.run,
                    attempt=args.attempt, hosts=summary, issues=issues))
    assert len(summary) == 3 and not issues, issues


if __name__ == '__main__':
    main()
