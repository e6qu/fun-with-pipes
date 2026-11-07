"""Audit and archive all four completed local-derivative sessions on runners."""
import argparse
import gzip
import hashlib
import importlib.util
import json
import os
from pathlib import Path, PurePosixPath
import re
import subprocess
import tarfile
import tempfile
import zipfile

from github_records import records

SPEC = importlib.util.spec_from_file_location('local_audit', Path(__file__).with_name('audit-local-derivatives.py'))
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--repository', required=True)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--representation', choices=['boxed', 'numeric'], required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'large retention runs on GitHub'
    assert re.fullmatch(r'[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+', args.repository)
    assert re.fullmatch('[0-9a-f]{40}', args.source)
    args.output.mkdir(parents=True, exist_ok=False)

    def api(path):
        return subprocess.check_output(['gh', 'api', '--allow-escape-sequences', 'repos/' + args.repository + '/' + path])

    run = json.loads(api(f'actions/runs/{args.run}'))
    assert run['head_sha'] == args.source and run['status'] == 'completed'
    jobs = records(api, f'actions/runs/{args.run}/jobs', 'jobs')
    artifacts = records(api, f'actions/runs/{args.run}/artifacts', 'artifacts')
    index = dict(source=args.source, run=args.run, representation=args.representation,
                 auditSource=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(), sessions=[])
    for runner, machine, label in [('ubuntu-24.04-arm', 'aarch64', 'arm'), ('ubuntu-latest', 'x86_64', 'amd')]:
        for session in [1, 2]:
            name = label + str(session)
            job, = [job for job in jobs if job['name'] == f'local_derivatives / measure ({runner}, {session})']
            assert job['head_sha'] == args.source and job['status'] == 'completed'
            artifact, = [item for item in artifacts if item['name'] == f'local-derivative-costs-{runner}-{session}' and not item['expired']]
            assert artifact['workflow_run']['head_sha'] == args.source
            raw = api(f"actions/artifacts/{artifact['id']}/zip")
            assert artifact['digest'] == 'sha256:' + AUDIT.digest(raw)
            log = api(f"actions/jobs/{job['id']}/logs")
            (args.output / (name + '-job.log.gz')).write_bytes(gzip.compress(log, mtime=0))
            with tempfile.TemporaryDirectory() as temporary:
                directory = Path(temporary)
                archive = directory / 'download.zip'
                archive.write_bytes(raw)
                tree = directory / 'observations'
                with zipfile.ZipFile(archive) as saved:
                    names = saved.namelist()
                    assert len(names) == len(set(names))
                    for path in names:
                        parsed = PurePosixPath(path)
                        assert not parsed.is_absolute() and '..' not in parsed.parts
                    saved.extractall(tree)
                original = (tree / 'solves/audit.json').read_bytes()
                inventory = json.loads(original)
                assert inventory['source'] == args.source
                for path, record in inventory['files'].items():
                    assert 'solves/' + path in names
                    data = (tree / 'solves' / path).read_bytes()
                    assert len(data) == record['bytes'] and AUDIT.digest(data) == record['sha256']
                (args.output / (name + '-producer-audit.json.gz')).write_bytes(gzip.compress(original, mtime=0))
                AUDIT.audit(tree / 'solves', args.source, machine, args.representation)
                verified = json.loads((tree / 'solves/audit.json').read_text())
                failures = verified['budgetFailures']
                failed_steps = [step['name'] for step in job['steps'] if step['conclusion'] == 'failure']
                assert failed_steps == (['Compare complete solves and retain all costs'] if failures else [])
                assert job['conclusion'] == ('failure' if failures else 'success')
                target = args.output / (name + '-observations.tar.xz')
                with tarfile.open(target, 'w:xz') as bundle:
                    bundle.add(tree, arcname=name)
                with target.open('rb') as stream:
                    checksum = hashlib.file_digest(stream, 'sha256').hexdigest()
                index['sessions'].append(dict(label=name, job=job, artifact=artifact, budgetFailures=failures,
                                              archiveSha256=checksum, logSha256=AUDIT.digest(log),
                                              originalAuditSha256=AUDIT.digest(original)))
                (args.output / 'index.json').write_text(json.dumps(index, indent=2) + '\n')
                print(name, 'all observations retained:', target.stat().st_size, 'bytes', flush=True)


if __name__ == '__main__':
    main()
