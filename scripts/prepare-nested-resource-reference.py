#!/usr/bin/env python3
"""Disable only nested resource borrowing in a separate same-source checkout."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
CANDIDATE = 'const NESTED_RESOURCE_BORROWS: bool = true;'
REFERENCE = 'const NESTED_RESOURCE_BORROWS: bool = false;'


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--checkout', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    checkout = args.checkout.resolve()
    assert checkout != ROOT
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
    subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
    current = (ROOT / 'src/cgen.rs').read_text()
    assert current.count(CANDIDATE) == 1 and REFERENCE not in current
    assert (checkout / 'src/cgen.rs').read_text() == current
    expected = current.replace(CANDIDATE, REFERENCE)
    args.output.mkdir(parents=True, exist_ok=False)
    (checkout / 'src/cgen.rs').write_text(expected)
    assert subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True) == 'src/cgen.rs\n'
    patch = subprocess.check_output(['git', 'diff', 'HEAD'], cwd=checkout)
    (args.output / 'reference.patch').write_bytes(patch)
    (args.output / 'manifest.json').write_text(json.dumps(dict(
        source=source, disabled='nested resource parameter borrowing',
        candidateSha256=hashlib.sha256(current.encode()).hexdigest(),
        referenceSha256=hashlib.sha256(expected.encode()).hexdigest(),
        patchSha256=hashlib.sha256(patch).hexdigest()), indent=2) + '\n')


if __name__ == '__main__':
    main()
