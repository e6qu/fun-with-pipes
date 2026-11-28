#!/usr/bin/env python3
"""Audit saved native evidence on a runner and export only reviewable text records."""
import argparse
import gzip
import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import zipfile

from resource_value_review import compiler, counts, executables, http, memory, runtime


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('run', 'source'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--kind', choices=('compiler', 'runtime', 'counts', 'http', 'memory', 'exec-memory'), required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    repository = 'repos/' + os.environ['GITHUB_REPOSITORY']
    args.output.mkdir()

    def api(endpoint):
        return json.loads(subprocess.check_output(['gh', 'api', repository + endpoint]))

    state = api(f'/actions/runs/{args.run}')
    assert state['head_sha'] == args.source and state['status'] == 'completed'
    listing = api(f'/actions/runs/{args.run}/artifacts?per_page=100')
    assert listing['total_count'] == len(listing['artifacts'])
    jobs = api(f'/actions/runs/{args.run}/jobs?per_page=100&page=1')
    page = 2
    while len(jobs['jobs']) < jobs['total_count']:
        more = api(f'/actions/runs/{args.run}/jobs?per_page=100&page={page}')
        assert more['total_count'] == jobs['total_count'] and more['jobs']
        jobs['jobs'].extend(more['jobs'])
        page += 1
    assert jobs['total_count'] == len(jobs['jobs'])
    for name, value in (('run', state), ('artifacts', listing), ('jobs', jobs)):
        (args.output / (name + '.json')).write_text(json.dumps(value, indent=2) + '\n')
    prefix = {'compiler': 'nested-resource-time-', 'runtime': 'nested-resource-time-',
              'counts': 'nested-resource-owners-', 'http': 'http-load-',
              'memory': 'nested-resource-memory-', 'exec-memory': 'exec-memory-'}[args.kind]
    artifacts = [row for row in listing['artifacts'] if row['name'].startswith(prefix)]
    assert len(artifacts) in (2, 4), [row['name'] for row in listing['artifacts']]
    index = {}
    with zipfile.ZipFile(args.output / 'reports.zip', 'x', zipfile.ZIP_DEFLATED) as retained:
        for artifact in artifacts:
            assert not artifact['expired'] and artifact['workflow_run']['head_sha'] == args.source
            assert artifact['workflow_run']['id'] == int(args.run)
            assert artifact['size_in_bytes'] < 256 * 1024 * 1024
            archive = args.output / 'native.zip'
            with archive.open('wb') as stream:
                subprocess.run(['gh', 'api', f"{repository}/actions/artifacts/{artifact['id']}/zip"],
                               stdout=stream, check=True)
            assert archive.stat().st_size == artifact['size_in_bytes']
            with archive.open('rb') as stream:
                assert 'sha256:' + hashlib.file_digest(stream, 'sha256').hexdigest() == artifact['digest']
            root = (args.output / 'native').resolve()
            with zipfile.ZipFile(archive) as contents:
                assert sum(row.file_size for row in contents.infolist()) < 1024 * 1024 * 1024
                assert len(contents.namelist()) == len(set(contents.namelist()))
                assert all((root / name).resolve().is_relative_to(root) for name in contents.namelist())
                assert contents.testzip() is None
                contents.extractall(root)
            arch = 'aarch64' if 'aarch64' in artifact['name'] or 'arm' in artifact['name'] else 'x86_64'
            if args.kind == 'runtime':
                command = ['python3', 'scripts/audit-nested-resource-time.py', '--input',
                           str(root / 'nested-time-comparison'), '--peers', str(root / 'nested-time-peers')]
            elif args.kind == 'counts':
                command = ['python3', 'scripts/audit-nested-resource-counts.py', '--input',
                           str(root / 'nested-owner-counts')]
            else:
                command = None
            if command:
                subprocess.run([*command, '--source', args.source, '--arch', arch], check=True)
            review = {'compiler': compiler, 'http': http, 'counts': counts,
                      'runtime': runtime, 'memory': memory, 'exec-memory': executables}[args.kind](root, args.source)
            (root / 'reconstructed.json').write_text(json.dumps(review, indent=2) + '\n')
            kept = 0
            for path in sorted(root.rglob('*')):
                if not path.is_file() or path.suffix not in (
                    '.json', '.jsonl', '.txt', '.resources', '.stdout', '.stderr', '.log', '.fwp', '.su', '.smaps'
                ):
                    continue
                data = path.read_bytes()
                data.decode('utf-8')
                name = artifact['name'] + '/' + str(path.relative_to(root))
                retained.writestr(name, data)
                index[name] = dict(bytes=len(data), sha256=hashlib.sha256(data).hexdigest())
                kept += len(data)
            # Page walks retain every raw mapping snapshot; other reports are smaller.
            text_limit = 256 if args.kind == 'memory' else 64
            assert 0 < kept < text_limit * 1024 * 1024
            shutil.rmtree(root)
            archive.unlink()
            print('Verified and exported', artifact['name'], kept, 'text bytes', flush=True)
    # Audit the exported view too: a successful native audit cannot detect a
    # later omission of text files required by the retained reader.
    with tempfile.TemporaryDirectory() as temporary, zipfile.ZipFile(args.output / 'reports.zip') as archive:
        retained_root = Path(temporary)
        archive.extractall(retained_root)
        for artifact in artifacts:
            root = retained_root / artifact['name']
            reconstructed = json.loads((root / 'reconstructed.json').read_text())
            if args.kind == 'http':
                actual = json.loads((root / 'http-load/summary.json').read_text())
            else:
                actual = {'compiler': compiler, 'counts': counts, 'runtime': runtime,
                          'memory': memory, 'exec-memory': executables}[args.kind](root, args.source)
            assert actual == reconstructed
        print('Every exported text archive reconstructs without native images', flush=True)
    for job in jobs['jobs']:
        if job['conclusion'] == 'skipped':
            continue
        assert job['status'] == 'completed'
        data = subprocess.check_output(['gh', 'api', '--allow-escape-sequences',
                                        f"{repository}/actions/jobs/{job['id']}/logs"])
        (args.output / f"job-{job['id']}.log.gz").write_bytes(gzip.compress(data, mtime=0))
    (args.output / 'files.json').write_text(json.dumps(index, indent=2) + '\n')
    assert (args.output / 'reports.zip').stat().st_size < 20 * 1024 * 1024


if __name__ == '__main__':
    main()
