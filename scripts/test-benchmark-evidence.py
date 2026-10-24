#!/usr/bin/env python3
"""Corrupt copies of real benchmark artifacts and require rejection."""
import argparse
import hashlib
import json
from pathlib import Path
import shutil
import struct
import subprocess
import sys
import tempfile

ROOT = Path(__file__).resolve().parent.parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--memory', choices=['arc', 'tracing'], required=True)
parser.add_argument('--arch', choices=['x86_64', 'aarch64'], required=True)
parser.add_argument('--objdump', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert not args.output.exists()
original, = (args.input / args.source).iterdir()
records = []
for case, expected in [
        ('wrong-mode', 'declared benchmark memory mode differs'),
        ('wrong-machine', 'benchmark binary has wrong architecture'),
        ('object-file', 'benchmark image is not executable'),
        ('missing-sample', 'need six positive timing samples')]:
    with tempfile.TemporaryDirectory(prefix='fwp-benchmark-control-') as temporary:
        temporary = Path(temporary)
        directory = temporary / args.source / original.name
        shutil.copytree(original, directory)
        memory = args.memory
        changed = directory / 'report.md'
        if case == 'wrong-mode':
            memory = 'tracing' if args.memory == 'arc' else 'arc'
        elif case in {'wrong-machine', 'object-file'}:
            changed, *_ = sorted(directory.glob('*-c'))
            data = bytearray(changed.read_bytes())
            assert data[:6] == b'\x7fELF\x02\x01'
            if case == 'wrong-machine':
                struct.pack_into('<H', data, 18, 183 if args.arch == 'x86_64' else 62)
            else:
                struct.pack_into('<H', data, 16, 1)
            changed.write_bytes(data)
        else:
            report = changed.read_text()
            before, raw = report.split('## Raw elapsed samples', 1)
            lines = raw.splitlines(keepends=True)
            for i, line in enumerate(lines):
                parts = line.split('|')
                if len(parts) == 6 and ', ' in parts[2]:
                    samples = parts[2].strip().split(', ')
                    assert len(samples) == 6
                    parts[2] = ' ' + ', '.join(samples[:-1]) + ' '
                    lines[i] = '|'.join(parts)
                    break
            else:
                raise AssertionError('missing raw sample row')
            changed.write_text(before + '## Raw elapsed samples' + ''.join(lines))
        result = subprocess.run([
            sys.executable, str(ROOT / 'scripts/inspect-benchmark-binaries.py'),
            '--input', str(temporary), '--source', args.source, '--memory', memory,
            '--arch', args.arch, '--objdump', args.objdump,
            '--output', str(temporary / 'invalid-review.json')], capture_output=True, text=True)
        assert result.returncode != 0 and expected in result.stderr, (case, result)
        assert not (temporary / 'invalid-review.json').exists()
        records.append(dict(case=case, expected=expected, exitStatus=result.returncode,
                            stdout=result.stdout, stderr=result.stderr,
                            changedSha256=hashlib.sha256(changed.read_bytes()).hexdigest()))
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(dict(source=args.source, memory=args.memory,
                                     architecture=args.arch, controls=records), indent=2) + '\n')
print('Rejected four corrupted benchmark artifact copies')
