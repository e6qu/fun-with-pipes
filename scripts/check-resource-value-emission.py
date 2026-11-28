#!/usr/bin/env python3
"""Require demand-driven classification to preserve the previously measured C."""
import argparse
import hashlib
import json
from pathlib import Path
import zipfile


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--arch', choices=('aarch64', 'x86_64'), required=True)
    args = parser.parse_args()
    saved = Path('docs/measurements/resource-value-costs-2026-11-27/compiler/reports.zip')
    name = f'nested-resource-time-{args.arch}/nested-analysis-observations/report.json'
    with zipfile.ZipFile(saved) as archive:
        previous = json.loads(archive.read(name))
    assert previous['source'] == 'cee08dcbd422831d5fa6a1f56963aaedfd09d1fd'
    current = json.loads((args.input / 'report.json').read_text())
    assert not previous['failures'] and not current['failures']
    assert len(current['cases']) == 16 and current['cases'].keys() == previous['cases'].keys()
    for name, case in current['cases'].items():
        emitted = Path(case['commands']['ordinary']['command'][-1]).read_bytes()
        assert hashlib.sha256(emitted).hexdigest() == case['cSha256'] == previous['cases'][name]['cSha256'], name
    print('Demand-driven classification preserves exact C for all four applications and twelve growth inputs')


if __name__ == '__main__':
    main()
