#!/usr/bin/env python3
"""Inspect saved API binaries and request-memory records without executing them."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--os', choices=['Linux', 'macOS', 'Windows'], required=True)
parser.add_argument('--arch', choices=['ARM64', 'X64'], required=True)
parser.add_argument('--objdump', type=Path, required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert re.fullmatch('[0-9a-f]{40}', args.source)
assert not args.output.exists(), 'Keep completed reviews; use a new output path'


def digest(data):
    return hashlib.sha256(data).hexdigest()


report = dict(source=args.source, os=args.os, architecture=args.arch,
              tool=subprocess.check_output([str(args.objdump), '--version'], text=True),
              scope='Saved ARC API binaries; static inspection, no local execution. '
                    'Managed charge, metric storage and RSS are separate quantities. '
                    'Text section bytes include padding. No C/Rust timing comparison.',
              binaries={}, observations={})
expected = {f'api-{variant}O{opt}' for variant in ['healthy', 'missing-free', 'missing-close']
            for opt in [1, 2]}
assert {path.stem for path in args.input.glob('*.exe')} == expected
for label in sorted(expected):
    files = {kind: args.input.joinpath(f'{label}.{kind}').read_bytes()
             for kind in ['exe', 'c', 'status', 'stderr', 'rss.tsv']}
    binary = args.input / (label + '.exe')
    raw = files['exe']
    if args.os == 'Linux':
        assert raw[:6] == b'\x7fELF\x02\x01'
        machine = struct.unpack_from('<H', raw, 18)[0]
        assert machine == {'ARM64': 183, 'X64': 62}[args.arch]
    elif args.os == 'macOS':
        assert raw[:4] == b'\xcf\xfa\xed\xfe'
        machine = struct.unpack_from('<I', raw, 4)[0]
        assert machine == {'ARM64': 0x100000c, 'X64': 0x1000007}[args.arch]
    else:
        assert raw[:2] == b'MZ'
        offset = struct.unpack_from('<I', raw, 60)[0]
        assert raw[offset:offset + 4] == b'PE\0\0'
        machine = struct.unpack_from('<H', raw, offset + 4)[0]
        assert machine == {'ARM64': 0xaa64, 'X64': 0x8664}[args.arch]
    code = files['c'].decode()
    assert '#define FWP_ARC_ONLY 1' in code
    assert ('#define HTTP_APP_OMIT_FREE 1' in code) == ('missing-free' in label)
    assert ('#define HTTP_APP_OMIT_CLOSE 1' in code) == ('missing-close' in label)
    symbols = subprocess.check_output([str(args.objdump), '--section-headers', '--syms', str(binary)])
    assembly = subprocess.check_output([str(args.objdump), '-d', str(binary)])
    assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_heap_(?:scan|mark_all|sweep)\b', symbols)
    sizes = re.findall(rb'^\s*\d+\s+(?:\.text|__text)\s+([0-9a-fA-F]+)\s', symbols, re.M)
    assert sizes and len(assembly) > 1000
    report['binaries'][label] = dict(machine=machine, fileBytes=len(raw),
        sha256={kind: digest(value) for kind, value in files.items()},
        textSectionBytes=sum(int(size, 16) for size in sizes),
        disassemblySha256=digest(assembly), symbolsSha256=digest(symbols))
    healthy = 'healthy' in label
    assert files['status'].decode().strip() == ('0' if healthy else '241'), label
    lines = files['stderr'].decode().splitlines()
    observations = [line.split('\t') for line in lines if line.startswith('http-memory\t')]
    assert len(observations) == (8 if healthy else 2), (label, lines)
    baseline = observations[0]
    assert len(baseline) == 7 and baseline[1:3] == ['8', '8']
    assert baseline[4] == '1' and baseline[6] == '0'
    for index, row in enumerate(observations):
        assert len(row) == 7 and int(row[1]) == 8 * (index + 1)
        assert row[4] == '1' and row[6] == '0'
        if healthy:
            assert row[1] == row[2] and row[3] == baseline[3] and row[5] == baseline[5]
    if healthy:
        assert 'http-shutdown\t1' in lines
        assert lines[-1] == 'http-metrics-final\t0'
        assert f'http-final\t72\t72\t0\t{baseline[5]}' in lines
        assert 'stopped' in lines and 'http-memory changed' not in lines
    else:
        assert 'http-memory changed' in lines
        last = observations[-1]
        if 'missing-free' in label:
            assert int(last[3]) > int(baseline[3])
        else:
            assert int(last[2]) < int(last[1])
    resident = files['rss.tsv'].decode().splitlines()
    assert resident[0] == 'connections\trss_kib'
    samples = [list(map(int, row.split('\t'))) for row in resident[1:]]
    assert len(samples) == (8 if healthy else 1)
    assert [row[0] for row in samples] == list(range(8, 8 * len(samples) + 1, 8))
    assert all(0 < rss <= samples[0][1] + 8192 for _, rss in samples)
    report['observations'][label] = dict(idle=observations, rssKiB=samples,
        status=int(files['status']), maxRssGrowthKiB=max(row[1] for row in samples) - samples[0][1])
args.output.write_text(json.dumps(report, indent=2) + '\n')
print(f'Inspected six API binaries and their execution records on {args.os} {args.arch}')
