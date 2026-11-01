#!/usr/bin/env python3
"""Retain native image sizes and separate static-frame reports for typed AD probes."""
import argparse
import hashlib
import json
import platform
from pathlib import Path
import re
import subprocess

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--root', type=Path, required=True)
parser.add_argument('--cc', required=True)
parser.add_argument('--size', required=True)
parser.add_argument('--source', required=True)
args = parser.parse_args()
assert re.fullmatch('[0-9a-f]{40}', args.source)
assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
root = args.root.resolve()
report = dict(source=args.source, machine=platform.machine(), system=platform.system(),
              compiler=subprocess.check_output([args.cc, '--version'], text=True),
              scope='Instrumented count/cleanup binaries, not timing or whole-stack bounds',
              probes={}, complete=False)
try:
    for source in sorted(root.glob('record-ownership/ad_tape_ownership/typed-*-workspace0.c')):
        name = source.stem
        if not name.startswith(('typed-quad-', 'typed-nested-', 'typed-owners-')):
            continue
        match = re.search(r'(-O[12])-workspace0$', name)
        assert match, name
        executable = source.with_suffix('.exe')
        assert source.with_suffix('.status').read_text().strip() == 'Some(0)', name
        output = root / 'static-frames'
        output.mkdir(exist_ok=True)
        object_path = output / (name + '.o')
        flags = [match[1], '-std=gnu11', '-ffp-contract=off', '-w', '-fstack-usage']
        command = [args.cc, *flags, '-c', str(source), '-o', str(object_path)]
        compiled = subprocess.run(command, capture_output=True, text=True, check=False)
        (output / (name + '.build.log')).write_text(compiled.stdout + compiled.stderr)
        assert compiled.returncode == 0, (name, compiled.stderr)
        stack = object_path.with_suffix('.su')
        assert stack.is_file() and stack.stat().st_size, name
        sizes = subprocess.check_output([args.size, str(executable)], text=True)
        (output / (name + '.size.txt')).write_text(sizes)
        report['probes'][name] = dict(command=command, stackReport=str(stack.relative_to(root)),
            executableBytes=executable.stat().st_size,
            executableSha256=hashlib.sha256(executable.read_bytes()).hexdigest(),
            sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(), size=sizes,
            stdout=source.with_suffix('.stdout').read_text(),
            stderr=source.with_suffix('.stderr').read_text())
        object_path.unlink()
    assert len(report['probes']) == 10, report['probes'].keys()
    report['complete'] = True
finally:
    (root / 'typed-derivative-report.json').write_text(json.dumps(report, indent=2) + '\n')
