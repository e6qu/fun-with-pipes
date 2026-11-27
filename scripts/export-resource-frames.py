#!/usr/bin/env python3
"""Retain small raw attribution records after native-image auditing on a runner."""
import argparse
import gzip
import json
import os
from pathlib import Path
import subprocess


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('input', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('source', 'arch', 'run'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    root = args.input / 'resource-frames'
    report = json.loads((root / 'report.json').read_text())
    assert report['toolSource'] == args.source and report['arch'] == args.arch
    assert report['source'] == '9b24e6965dd4c7cfb6e88163a34722e0b99ec901'
    subprocess.run(['python3', 'scripts/audit-resource-frames.py', '--input', str(root),
                    '--source', report['source'], '--arch', args.arch], check=True)
    args.output.mkdir()
    for name in ('report.json', 'commands.jsonl', 'manifest.json'):
        (args.output / (name + '.gz')).write_bytes(gzip.compress((root / name).read_bytes(), mtime=0))
    http = {str(path.relative_to(root)): path.read_bytes().decode('utf-8')
            for path in sorted(root.glob('http-O*/*')) if path.is_file()}
    assert len(http) > 1000
    (args.output / 'http.json.gz').write_bytes(gzip.compress(json.dumps(http).encode(), mtime=0))
    for name in ('service', 'http'):
        text = (args.input / 'resource-frame-controls' / f'{name}.stderr').read_text()
        assert 'raw output disagrees with summary' in text
        (args.output / f'{name}-altered-summary.stderr').write_text(text)
    repository = 'repos/' + os.environ['GITHUB_REPOSITORY']
    for name, endpoint in (
        ('run.json', f'{repository}/actions/runs/{args.run}'),
        ('artifacts.json', f'{repository}/actions/runs/{args.run}/artifacts?per_page=100'),
    ):
        data = subprocess.check_output(['gh', 'api', endpoint])
        (args.output / name).write_bytes(data)
    state = json.loads((args.output / 'run.json').read_text())
    assert state['head_sha'] == args.source and state['conclusion'] == 'success'


if __name__ == '__main__':
    main()
