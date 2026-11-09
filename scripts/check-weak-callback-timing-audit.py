#!/usr/bin/env python3
"""Require timing reconstruction to reject altered evidence, even with new hashes."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import sys

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--arch', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    folder = args.input.resolve()
    manifest_path = folder / 'manifest.json'
    manifest_bytes = manifest_path.read_bytes()
    path = folder / 'report.json'
    original = path.read_bytes()
    command = [sys.executable, str(ROOT / 'scripts/measure-weak-callback-service.py'), 'audit',
               '--input', str(folder), '--source', args.source, '--arch', args.arch]
    results = []
    args.output.mkdir(parents=True, exist_ok=False)
    for name in ('pilot-count', 'paired-order', 'copy-hash', 'service-duration', 'qualification', 'rss-counter'):
        try:
            report = json.loads(original)
            case = report['sessions']['1']['64-0']
            if name == 'pilot-count':
                report['pilots']['64-0']['batches'] += 1
            elif name == 'paired-order':
                case['samples'][0], case['samples'][1] = case['samples'][1], case['samples'][0]
            elif name == 'copy-hash':
                report['binaries']['swift']['binarySha256'] = '0' * 64
            elif name == 'service-duration':
                case['samples'][0]['ns']['service'] += 1
            elif name == 'qualification':
                row = case['summary']['service']['peerQualified']
                row['swift'] = not row['swift']
            else:
                case['memory']['fwp'][0]['peakRssKiB'] += 1
            changed = (json.dumps(report, indent=2) + '\n').encode()
            path.write_bytes(changed)
            manifest = json.loads(manifest_bytes)
            manifest['report.json'] = hashlib.sha256(changed).hexdigest()
            manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
            child = run_capture(command, timeout=90, env=dict(os.environ), cwd=ROOT,
                                input_data=None, input_stream=None, text=True, encoding='utf-8', check=False)
            result = dict(control=name, command=command, status=child.returncode,
                          stdout=child.stdout, stderr=child.stderr)
            results.append(result)
            (args.output / (name + '.json')).write_text(json.dumps(result, indent=2) + '\n')
        finally:
            path.write_bytes(original)
            manifest_path.write_bytes(manifest_bytes)
    assert len(results) == 6
    for result in results:
        assert result['status'] == 1 and 'AssertionError' in result['stderr'] and not result['stdout'], result
    print('Six timing corruptions rejected with matching manifests; original evidence restored')


if __name__ == '__main__':
    main()
