#!/usr/bin/env python3
"""Require the raw-memory audit to reject independently corrupted evidence."""
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
    command = [sys.executable, str(ROOT / 'scripts/measure-parser-process-memory.py'), 'audit',
               '--input', str(folder), '--source', args.source, '--arch', args.arch]
    report = json.loads((folder / 'report.json').read_text())
    snapshot = report['cases']['small']['peers']['c']['snapshots'][0]
    journal_name = snapshot['folder'] + '/observation.json'
    results = []
    args.output.mkdir(parents=True, exist_ok=False)
    for name, filename in [('source-boundary', 'c-diagnostic.c'), ('checkpoint-sequence', journal_name),
                           ('missing-control', 'report.json'), ('rss-value', 'report.json'),
                           ('argument-oracle', 'report.json')]:
        path = folder / filename
        original = path.read_bytes()
        try:
            if name == 'source-boundary':
                changed = original.replace(b'parser_memory_checkpoint(1);', b'parser_memory_checkpoint(0);')
                assert changed != original
            else:
                value = json.loads(original)
                if name == 'checkpoint-sequence':
                    value['checkpointMessagesHex'][1] = '300a'
                elif name == 'missing-control':
                    value['controls']['omit-touch']['expectedError'] = None
                elif name == 'argument-oracle':
                    value['argumentControls'][0]['value'] = '1'
                else:
                    value['cases']['small']['peers']['c']['memory'][0]['peakRssKiB'] += 1
                changed = (json.dumps(value, indent=2) + '\n').encode()
            path.write_bytes(changed)
            manifest = json.loads(manifest_bytes)
            manifest[filename] = hashlib.sha256(changed).hexdigest()
            manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
            child = run_capture(command, timeout=90, env=dict(os.environ), cwd=ROOT,
                                input_data=None, input_stream=None, text=True, encoding='utf-8', check=False)
            result = dict(control=name, file=filename, command=command, status=child.returncode,
                          stdout=child.stdout, stderr=child.stderr)
            results.append(result)
            (args.output / (name + '.json')).write_text(json.dumps(result, indent=2) + '\n')
        finally:
            path.write_bytes(original)
            manifest_path.write_bytes(manifest_bytes)
    assert len(results) == 5
    for result in results:
        assert result['status'] == 1 and 'AssertionError' in result['stderr'] and not result['stdout'], result
    print('Five evidence corruptions rejected despite matching manifest hashes; originals restored')


if __name__ == '__main__':
    main()
