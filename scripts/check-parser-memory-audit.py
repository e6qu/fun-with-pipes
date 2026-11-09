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
    policy_name = snapshot['folder'] + '/phase-0.accounting.json'
    results = []
    args.output.mkdir(parents=True, exist_ok=False)
    for name, filename in [('source-boundary', 'c-diagnostic.c'), ('checkpoint-sequence', journal_name),
                           ('missing-control', 'report.json'), ('rss-value', 'report.json'),
                           ('argument-oracle', 'report.json'), ('invalid-policy', policy_name),
                           ('changed-policy', policy_name)]:
        path = folder / filename
        original = path.read_bytes()
        originals = {filename: original}
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
                elif name in ('invalid-policy', 'changed-policy'):
                    mode = value['policy']['overcommit_memory']
                    value['policy']['overcommit_memory'] = 9 if name == 'invalid-policy' else (mode + 1) % 3
                else:
                    value['cases']['small']['peers']['c']['memory'][0]['peakRssKiB'] += 1
                changed = (json.dumps(value, indent=2) + '\n').encode()
            path.write_bytes(changed)
            manifest = json.loads(manifest_bytes)
            manifest[filename] = hashlib.sha256(changed).hexdigest()
            if name in ('invalid-policy', 'changed-policy'):
                # Keep every journal/hash consistent: only the policy's meaning
                # or its change during this process should reject the record.
                for related in (journal_name, 'commands.jsonl'):
                    related_path = folder / related
                    originals[related] = related_path.read_bytes()
                    if related == journal_name:
                        journal = json.loads(originals[related])
                        journal['snapshots'][0]['kernelAccountingSha256'] = manifest[filename]
                        updated = (json.dumps(journal, indent=2) + '\n').encode()
                    else:
                        commands = [json.loads(line) for line in originals[related].splitlines()]
                        commands[snapshot['command']]['snapshots'][0]['kernelAccountingSha256'] = manifest[filename]
                        updated = ''.join(json.dumps(row) + '\n' for row in commands).encode()
                    related_path.write_bytes(updated)
                    manifest[related] = hashlib.sha256(updated).hexdigest()
            manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
            child = run_capture(command, timeout=90, env=dict(os.environ), cwd=ROOT,
                                input_data=None, input_stream=None, text=True, encoding='utf-8', check=False)
            result = dict(control=name, file=filename, command=command, status=child.returncode,
                          stdout=child.stdout, stderr=child.stderr)
            results.append(result)
            (args.output / (name + '.json')).write_text(json.dumps(result, indent=2) + '\n')
        finally:
            for filename, content in originals.items():
                (folder / filename).write_bytes(content)
            manifest_path.write_bytes(manifest_bytes)
    assert len(results) == 7
    for result in results:
        assert result['status'] == 1 and 'AssertionError' in result['stderr'] and not result['stdout'], result
        if result['control'] == 'invalid-policy':
            assert 'AssertionError: invalid overcommit mode' in result['stderr'], result
        elif result['control'] == 'changed-policy':
            assert 'AssertionError: kernel or overcommit policy changed between checkpoints' in result['stderr'], result
    print('Seven evidence corruptions rejected despite matching hashes and policy journals; originals restored')


if __name__ == '__main__':
    main()
