#!/usr/bin/env python3
"""Require the native evidence readers to reject altered reports with recomputed hashes."""
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
    parser.add_argument('--kind', choices=('counts', 'time'), required=True)
    for name in ('input', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--peers', type=Path)
    for name in ('source', 'arch'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    assert (args.peers is not None) == (args.kind == 'time')
    folder = args.input.resolve()
    path, manifest_path = folder / 'report.json', folder / 'manifest.json'
    original, manifest_bytes = path.read_bytes(), manifest_path.read_bytes()
    command = [sys.executable, str(ROOT / f'scripts/audit-nested-resource-{args.kind}.py'),
               '--input', str(folder), '--source', args.source, '--arch', args.arch]
    if args.kind == 'time':
        command += ['--peers', str(args.peers.resolve())]
    controls = (('reference-source', 'pilot', 'order', 'binary', 'duration', 'qualification', 'rss')
                if args.kind == 'time' else ('reference-source', 'count', 'selection', 'binary', 'delta', 'fault-command'))
    args.output.mkdir(parents=True, exist_ok=False)
    results = []
    for name in controls:
        try:
            report = json.loads(original)
            if name == 'reference-source':
                report['referenceSource'] = '0' * 40
            elif args.kind == 'time':
                case = report['sessions']['1']['64-0']
                if name == 'pilot':
                    case['batches'] *= 4
                elif name == 'order':
                    case['samples'][0], case['samples'][1] = case['samples'][1], case['samples'][0]
                elif name == 'binary':
                    report['binaries']['candidate']['sha256'] = '0' * 64
                elif name == 'duration':
                    case['samples'][0]['ns']['service'] += 1
                elif name == 'qualification':
                    row = case['summary']['service']
                    row['qualified'] = not row['qualified']
                else:
                    case['memory']['candidate'][0]['peakRssKiB'] += 1
            elif name == 'count':
                report['cases']['candidate-O2']['64-0']['counts']['pushes'] += 1
            elif name == 'selection':
                report['selection']['candidate-service']['anchors'] += 1
            elif name == 'binary':
                report['builds'][0]['sha256'] = '0' * 64
            elif name == 'delta':
                report['comparisons']['O2/64-0']['delta']['pushes'] += 1
            else:
                report['controls'][0]['command'] = report['cases']['candidate-O2']['64-0']['command']
            changed = (json.dumps(report, indent=2) + '\n').encode()
            path.write_bytes(changed)
            manifest = json.loads(manifest_bytes)
            manifest['report.json'] = hashlib.sha256(changed).hexdigest()
            manifest_path.write_text(json.dumps(manifest, indent=2) + '\n')
            child = run_capture(command, timeout=90, env=dict(os.environ), cwd=ROOT,
                                input_data=None, input_stream=None, text=True, encoding='utf-8', check=False)
            result = dict(control=name, command=command, status=child.returncode, stdout=child.stdout, stderr=child.stderr)
            results.append(result)
            (args.output / (name + '.json')).write_text(json.dumps(result, indent=2) + '\n')
        finally:
            path.write_bytes(original)
            manifest_path.write_bytes(manifest_bytes)
    for result in results:
        assert result['status'] == 1 and 'AssertionError' in result['stderr'], result
    assert len(results) == len(controls)
    print(f'{len(results)} altered {args.kind} reports rejected; original evidence restored')


if __name__ == '__main__':
    main()
