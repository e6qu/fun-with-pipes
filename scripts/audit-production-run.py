#!/usr/bin/env python3
"""Audit exact-head production jobs, every target log and artifact identity."""
import argparse
from datetime import datetime
import gzip
import hashlib
import json
from pathlib import Path
import re
import subprocess
import zipfile

CONFIG = {
    'linux-arm': ('test (ubuntu-24.04-arm)', 'native-test-logs-ubuntu-24.04-arm', 257),
    'linux-amd': ('test (ubuntu-latest)', 'native-test-logs-ubuntu-latest', 257),
    'mac-arm': ('macos (macos-15)', 'macos-regular-tests-macos-15', 131),
    'mac-amd': ('macos (macos-15-intel)', 'macos-regular-tests-macos-15-intel', 131),
    'mac-arm-ownership': ('macos_ownership (macos-15)', 'macos-ownership-tests-macos-15', 126),
    'mac-amd-ownership': ('macos_ownership (macos-15-intel)', 'macos-ownership-tests-macos-15-intel', 126),
    'windows-arm': ('windows / native (windows-11-arm)', 'windows-native-windows-11-arm', 57),
    'windows-amd': ('windows / native (windows-2025)', 'windows-native-windows-2025', 57),
    'bench': ('bench', None, 0),
    'docs': ('roadmap_docs', None, 0),
}


def api(path):
    return subprocess.check_output(['gh', 'api', '--allow-escape-sequences',
                                    'repos/e6qu/fun-with-pipes/' + path])


def save(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def diagnostics(raw):
    clean = re.sub(rb'\x1b\[[0-?]*[ -/]*[@-~]', b'', raw)
    return [line for line in clean.splitlines()
            if re.search(rb'\bwarning:|\berror:(?!:)|\berror\[|Traceback|##\[error\]|test result: FAILED', line, re.I)]



def windows_diagnostics(log):
    found = diagnostics(log)
    expected_diagnostics = []
    lines = [re.sub(rb'^\S+Z ', b'', line) for line in log.splitlines()]
    starts = [i for i, line in enumerate(lines)
              if line.startswith(b'test rest_with_client_certificates ...')]
    for line in found:
        if b'curl peer:' not in line or b'tlsv1 alert unknown ca' not in line:
            continue
        clean = re.sub(rb'^\S+Z ', b'', line)
        position, = [i for i, value in enumerate(lines) if value == clean]
        start, = [i for i in starts if i < position]
        end = next(i for i in range(start + 1, len(lines))
                   if lines[i] == b'ok' or lines[i].startswith(b'test '))
        assert position < end and lines[end] == b'ok', 'untrusted-client control did not pass'
        expected_diagnostics.append(line)
    found = [line for line in found if line not in expected_diagnostics]
    return found, expected_diagnostics

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--attempt', type=int, required=True)
    parser.add_argument('--host', required=True, choices=('all', 'linux-arm', 'linux-amd', 'mac-arm', 'mac-amd', 'mac-arm-ownership', 'mac-amd-ownership', 'windows-arm', 'windows-amd', 'bench', 'docs'))
    parser.add_argument('--docs-job', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert args.attempt > 0 and re.fullmatch(r'[0-9a-f]{40}', args.source), 'explicit attempt and full source SHA required'
    ROOT = args.output
    ROOT.mkdir(parents=True, exist_ok=True)
    RUN = args.run
    SOURCE = args.source
    jobs_path = f'actions/runs/{RUN}' + (f'/attempts/{args.attempt}' if args.attempt else '')
    jobs = json.loads(api(jobs_path + '/jobs?per_page=100'))['jobs']
    assert len(jobs) == 9
    jobs.append(json.loads(api(f'actions/jobs/{args.docs_job}')))
    artifacts = json.loads(api(f'actions/runs/{RUN}/artifacts?per_page=100'))['artifacts']
    save(ROOT / 'jobs.json', jobs)
    save(ROOT / 'artifacts.json', artifacts)
    issues = []
    for label, (name, artifact_name, expected) in CONFIG.items():
        if args.host != 'all' and label != args.host:
            continue
        job, = [item for item in jobs if item['name'] == name]
        assert job['head_sha'] == SOURCE
        if job['status'] != 'completed':
            issues.append((label, 'job is not complete; no passing-gate claim'))
            continue
        if job['conclusion'] == 'cancelled' and not job['steps']:
            annotations = json.loads(api(f"check-runs/{job['id']}/annotations"))
            save(ROOT / (label + '-not-started-job.json'), dict(job=job, annotations=annotations))
            issues.append((label, 'cancelled before any steps; runner annotations retained'))
            print(label, 'cancelled without execution; NOT a passing gate', flush=True)
            continue
        cached = ROOT / (label + '-audit.json')
        if cached.exists():
            previous = json.loads(cached.read_text())
            assert previous['source'] == SOURCE
            if previous['job'] != job:
                original = previous['job']
                assert original == json.loads(api(f"actions/jobs/{original['id']}"))
                identities = {'id', 'node_id', 'url', 'html_url', 'run_attempt', 'check_run_url', 'created_at', 'runner_group_id'}
                assert job['runner_group_id'] == original['runner_group_id'] or (
                    original['runner_group_id'] == 0 and job['runner_group_id'] is None
                )
                assert job['created_at'] > original['completed_at']
                assert {key: value for key, value in original.items() if key not in identities} == {
                    key: value for key, value in job.items() if key not in identities
                }, 'retried job differs from previously audited execution'
                assert original['conclusion'] == job['conclusion'] == 'success'
                assert original['run_attempt'] < job['run_attempt']
                save(ROOT / (label + '-reused-job.json'), dict(originalJob=original, latestJob=job))
            print(label, 'already audited', flush=True)
            continue
        save(ROOT / (label + '-job.json'), job)
        log = api(f"actions/jobs/{job['id']}/logs")
        (ROOT / (label + '-job.log.gz')).write_bytes(gzip.compress(log, mtime=0))
        found = diagnostics(log)
        if label == 'docs':
            assert len(found) == 3 and b'intentional runner control' in log
            assert b'duplicate selected test target' in found[0]
            assert b'unknown selected test targets' in found[1]
            assert b'test result: FAILED. 0 passed; 1 failed;' in found[2]
            found = []
        elif label.startswith('mac-'):
            found = [line for line in found if not re.search(
                rb'Warning: openssl@3 [0-9.]+ is already installed and up-to-date\.$', line)]
        expected_diagnostics = []
        if label.startswith('mac-'):
            first_name = ('Publish individual ownership test logs' if label.endswith('ownership')
                          else 'Publish individual regular test logs')
            retry_name = ('Retry individual ownership test log upload' if label.endswith('ownership')
                          else 'Retry individual regular test log upload')
            first, = [step for step in job['steps'] if step['name'] == first_name]
            retry, = [step for step in job['steps'] if step['name'] == retry_name]
            if first['conclusion'] == 'failure':
                assert retry['conclusion'] == 'success' and job['conclusion'] == 'success'
                begin = datetime.fromisoformat(first['started_at'])
                end = datetime.fromisoformat(first['completed_at'])
                recovered = []
                for line in found:
                    timestamp, _, message = line.partition(b' ')
                    if message == b'##[error]Failed to CreateArtifact: Unable to make request: ENOTFOUND':
                        when = datetime.fromisoformat(timestamp.decode())
                        assert begin <= when and when.timestamp() < end.timestamp() + 1
                        recovered.append(line)
                assert len(recovered) == 1, 'inspect any new upload diagnostic explicitly'
                found = [line for line in found if line not in recovered]
                expected_diagnostics.extend(recovered)
            else:
                assert first['conclusion'] == 'success' and retry['conclusion'] == 'skipped'
        if label.startswith('windows-'):
            found, expected_diagnostics = windows_diagnostics(log)
        report = dict(source=SOURCE, job=job, logSha256=hashlib.sha256(log).hexdigest(),
                      expectedDiagnostics=[line.decode() for line in expected_diagnostics], targetLogs={})
        if artifact_name:
            uploaded_ids = {int(value) for value in re.findall(
                rb'Artifact ' + re.escape(artifact_name.encode())
                + rb' successfully finalized\. Artifact ID ([0-9]+)', log)}
            assert len(uploaded_ids) <= 1, 'target artifact identity is ambiguous'
            if job['conclusion'] == 'success':
                assert len(uploaded_ids) == 1, 'target artifact must be identified by this job log'
            matches = [a for a in artifacts if a['name'] == artifact_name
                       and a['id'] in uploaded_ids and not a['expired']]
            if not matches:
                issues.append((label, 'missing target artifact'))
            else:
                artifact, = matches
                assert artifact['workflow_run']['head_sha'] == SOURCE
                archive = ROOT / (label + '-targets.zip')
                if not archive.exists():
                    partial = archive.with_suffix('.part')
                    with partial.open('wb') as output:
                        subprocess.run(['gh', 'api', '--allow-escape-sequences', f"repos/e6qu/fun-with-pipes/actions/artifacts/{artifact['id']}/zip"], stdout=output, check=True)
                    with partial.open('rb') as source:
                        assert artifact['digest'] == 'sha256:' + hashlib.file_digest(source, 'sha256').hexdigest()
                    partial.rename(archive)
                with archive.open('rb') as source:
                    assert artifact['digest'] == 'sha256:' + hashlib.file_digest(source, 'sha256').hexdigest()
                save(ROOT / (label + '-artifact.json'), artifact)
                with zipfile.ZipFile(archive) as z:
                    for member in z.namelist():
                        if member.endswith('.log'):
                            raw = z.read(member)
                            found.extend(diagnostics(raw))
                            report['targetLogs'][member] = hashlib.sha256(raw).hexdigest()
                            if not label.startswith('windows-'):
                                summaries = re.findall(rb'test result: ([^\r\n]+)', raw)
                                if (len(summaries) != 1 or not summaries[0].startswith(b'ok.')
                                        or b'0 failed;' not in summaries[0]):
                                    issues.append((label, member + ': missing or failed target summary'))
                report['artifact'] = artifact
                if len(report['targetLogs']) != expected:
                    issues.append((label, f'expected {expected} target logs, found {len(report["targetLogs"])}'))
        if label.startswith('windows-'):
            runner = 'windows-11-arm' if label == 'windows-arm' else 'windows-2025'
            name = 'windows-probe-' + runner
            ids = {int(value) for value in re.findall(
                rb'Artifact ' + name.encode() + rb' successfully finalized\. Artifact ID ([0-9]+)', log)}
            assert len(ids) == 1
            metadata, = [item for item in artifacts if item['id'] in ids and item['name'] == name and not item['expired']]
            assert metadata['workflow_run']['head_sha'] == SOURCE
            archive = ROOT / (label + '-probe.zip')
            if not archive.exists():
                partial = archive.with_suffix('.part')
                with partial.open('wb') as output:
                    subprocess.run(['gh', 'api', '--allow-escape-sequences', f"repos/e6qu/fun-with-pipes/actions/artifacts/{metadata['id']}/zip"], stdout=output, check=True)
                with partial.open('rb') as source:
                    assert metadata['digest'] == 'sha256:' + hashlib.file_digest(source, 'sha256').hexdigest()
                partial.rename(archive)
            with archive.open('rb') as source:
                assert metadata['digest'] == 'sha256:' + hashlib.file_digest(source, 'sha256').hexdigest()
            save(ROOT / (label + '-probe-artifact.json'), metadata)
            started = re.findall(rb'Starting test/(\w+); log: ([^\r\n]+)', log)
            expected_paths = {path.decode().replace('\\', '/') for _, path in started}
            assert len(started) == len(expected_paths), 'duplicate native target launch'
            if len(started) != 155:
                issues.append((label, f'expected 155 native targets, found {len(started)}'))
            assert b'iteration_consumers' in {name for name, _ in started}
            completed = re.findall(rb'Finished test/(\w+): exit 0,', log)
            if len(completed) != 155 or set(completed) != {name for name, _ in started}:
                issues.append((label, f'{len(completed)} of 155 native targets exited successfully'))
            logs = {}
            extracted = ROOT / (label + '-probe-logs.zip')
            with zipfile.ZipFile(archive) as original, zipfile.ZipFile(extracted, 'w', compression=zipfile.ZIP_DEFLATED) as retained:
                actual_paths = {name for name in original.namelist() if re.fullmatch(r'windows-(resource|callback|tls|command)-tests/test-\w+\.log', name)}
                assert actual_paths == expected_paths
                for name in sorted(original.namelist()):
                    if not name.endswith('.log'):
                        continue
                    data = original.read(name)
                    unexpected, accepted = windows_diagnostics(data)
                    found.extend(unexpected)
                    report['expectedDiagnostics'].extend(name + ': ' + line.decode() for line in accepted)
                    logs[name] = hashlib.sha256(data).hexdigest()
                    if name in report['targetLogs']:
                        assert logs[name] == report['targetLogs'][name]
                    if name in actual_paths:
                        results = re.findall(rb'test result: ([^\r\n]+)', data)
                        if len(results) != 1 or not results[0].startswith(b'ok.') or b'0 failed;' not in results[0]:
                            issues.append((label, name + ': missing or failed native summary'))
                    retained.writestr(name, data)
            report.update(probeArtifact=metadata, probeLogs=logs,
                          probeLogArchiveSha256=hashlib.sha256(extracted.read_bytes()).hexdigest())
            print(label, len(started), 'started targets matched to their retained logs;', len(completed), 'successful', flush=True)
        if job['conclusion'] != 'success':
            issues.append((label, 'job ' + job['conclusion']))
        for line in found:
            issues.append((label, line.decode(errors='replace')))
        if not any(item[0] == label for item in issues):
            save(cached, report)
            print(label, len(report['targetLogs']), 'target logs and full job pass audit', flush=True)
        else:
            save(ROOT / (label + '-failed-audit.json'), dict(report, issues=[item for item in issues if item[0] == label]))
    for label, issue in issues:
        print(label + ': ' + issue, flush=True)
    save(ROOT / ('issues-' + args.host + '.json' if args.host else 'issues.json'), issues)
    assert not issues, 'inspect retained logs and repair every finding'


if __name__ == '__main__':
    main()
