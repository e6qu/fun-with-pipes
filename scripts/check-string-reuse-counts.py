#!/usr/bin/env python3
"""Enforce the unique-replacement candidate's predeclared managed counts."""
import argparse
import importlib.util
import json
from pathlib import Path

SPEC = importlib.util.spec_from_file_location('string_results', Path(__file__).with_name('check-direct-string-results.py'))
CHECK = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(CHECK)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    inputs = parser.add_mutually_exclusive_group(required=True)
    inputs.add_argument('--directory', type=Path)
    inputs.add_argument('--retained-index', nargs=3, metavar=('PATH', 'MACHINE', 'SESSION'))
    parser.add_argument('--source', required=True)
    args = parser.parse_args()
    if args.retained_index:
        path, machine, session = args.retained_index
        if machine not in ('aarch64', 'x86_64') or session not in ('1', '2'):
            parser.error('retained evidence requires aarch64/x86_64 and session 1/2')
        files = CHECK.read_retained(Path(path), machine, int(session))
        report = json.loads(files['comparison.json'])
    else:
        report = json.loads((args.directory / 'comparison.json').read_text())
    assert report['configuration']['source'] == args.source
    limits = {'4096:64': (12513, 431876), '65536:1024': (199721, 6909092)}
    assert set(report['results']) == set(limits)
    failures = []
    for case, (requests, requested_bytes) in limits.items():
        profiles = report['results'][case]['profiles']
        actual = profiles['candidate']['managed']
        for field, limit in [('requests', requests), ('requestedBytes', requested_bytes)]:
            if actual[field] > limit:
                failures.append(f'{case} {field}: {actual[field]} > {limit}')
        assert profiles['candidate']['raw']['rawRequests'] == 0
    print(json.dumps(dict(limits=limits, failures=failures), indent=2))
    assert not failures, failures


if __name__ == '__main__':
    main()
