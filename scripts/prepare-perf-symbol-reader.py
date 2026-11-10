#!/usr/bin/env python3
"""Repair perf 6.8's GNU inline-name/end-marker distinction at a pinned source."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess

SOURCE = 'e8f897f4afef0031fe618a8e94127a0934896aba'
BEFORE = "if (line_len >= 2 || line[0] != '0' || line[1] != 'x') {"
AFTER = "if (line_len >= 2 && line[0] == '0' && line[1] == 'x') {"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--checkout', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    checkout = args.checkout.resolve()
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == SOURCE
    assert not subprocess.check_output(['git', 'status', '--porcelain'], cwd=checkout, text=True)
    path = checkout/'tools/perf/util/srcline.c'
    before = path.read_text()
    assert before.count(BEFORE) == 1 and AFTER not in before
    after = before.replace(BEFORE, AFTER)
    path.write_text(after)
    diff = subprocess.check_output(['git', 'diff', '--', 'tools/perf/util/srcline.c'], cwd=checkout)
    assert subprocess.check_output(['git', 'diff', '--name-only'], cwd=checkout, text=True).splitlines() == ['tools/perf/util/srcline.c']
    args.output.mkdir(parents=True, exist_ok=False)
    (args.output/'reader.patch').write_bytes(diff)
    (args.output/'identity.json').write_text(json.dumps(dict(source=SOURCE,
        beforeSha256=hashlib.sha256(before.encode()).hexdigest(),
        afterSha256=hashlib.sha256(after.encode()).hexdigest(),
        patchSha256=hashlib.sha256(diff).hexdigest()), indent=2)+'\n')


if __name__ == '__main__':
    main()
