#!/usr/bin/env python3
"""List collector/ownership diagnostic mentions; this is not a coverage proof."""

import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parent.parent
KEYS = ('FWP_GC', 'FWP_GC_STRESS', 'FWP_GC_VERIFY', 'FWP_REUSE_VERIFY', 'FWP_GC_STATS')
PATTERN = re.compile(r'\b(?:' + '|'.join(KEYS) + r')\b')
ROOTS = {'src', 'runtime', 'tests', 'scripts', '.github'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', required=True, help='expected checked-out commit')
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    if source != args.source:
        raise SystemExit(f'checked-out commit {source} differs from --source {args.source}')
    names = subprocess.check_output(['git', 'ls-files', '-z'], cwd=ROOT).decode().split('\0')
    files = []
    for name in sorted(names):
        if not name or name.split('/')[0] not in ROOTS:
            continue
        content = (ROOT / name).read_bytes()
        # Source mentions are ASCII. Preserve their surrounding text even if a
        # fixture contains non-UTF-8 bytes; never silently skip a matching file.
        lines = []
        for number, line in enumerate(content.decode(errors='replace').splitlines(), 1):
            keys = sorted(set(PATTERN.findall(line)))
            if keys:
                lines.append(dict(line=number, keys=keys, text=line.strip()))
        if lines:
            files.append(dict(path=name, sha256=hashlib.sha256(content).hexdigest(), lines=lines))
    result = dict(
        source=source,
        dirty=bool(subprocess.check_output(['git', 'status', '--porcelain'], cwd=ROOT)),
        scope=sorted(ROOTS),
        meaning='Textual mentions, including definitions, comments and disabled controls; not replacement coverage',
        files=files,
    )
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + '\n')
    print(f'{len(files)} files, {sum(len(file["lines"]) for file in files)} matching lines; source {source}')


if __name__ == '__main__':
    main()
