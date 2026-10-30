#!/usr/bin/env python3
"""Enforce the unique-replacement candidate's predeclared managed counts."""
import argparse
import json
from pathlib import Path


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--source', required=True)
    args = parser.parse_args()
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
