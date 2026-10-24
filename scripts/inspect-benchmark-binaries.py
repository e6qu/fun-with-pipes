#!/usr/bin/env python3
"""Check saved C/Rust/fwp benchmark inputs, samples and actual native binaries."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import statistics
import struct
import subprocess

ROOT = Path(__file__).resolve().parent.parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--memory', choices=['arc', 'tracing'], required=True)
parser.add_argument('--arch', choices=['x86_64', 'aarch64'], required=True)
parser.add_argument('--objdump', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert re.fullmatch('[0-9a-f]{40}', args.source)
assert not args.output.exists(), 'Preserve completed reviews'
directory, = (args.input / args.source).iterdir()
report = (directory / 'report.md').read_text()
assert f'Source commit: `{args.source}`. Host: `linux/{args.arch}`.' in report
assert f'Native fwp memory mode: `{args.memory}`.' in report, 'declared benchmark memory mode differs'
assert 'Arithmetic contract: checked signed I64 calculations in all three peers.' in report, 'declared arithmetic contract differs'
assert '-std=c11 -O2 -ffp-contract=off' in report, 'C build settings differ'
assert 'Rust compiler (`rustc --edition=2021 -O`)' in report, 'Rust build settings differ'
assert f'fwp build flags: `--gc {args.memory} -O2`, `FWP_LTO=0`' in report
programs = sorted(path.name for path in (ROOT / 'bench').iterdir()
                  if (path / 'main.fwp').is_file())
medians = re.findall(
    r'^\| (\S+) \| ([\d.]+) ms \| ([\d.]+) ms \| ([\d.]+) ms \|',
    report.split('## Raw elapsed samples')[0], re.M)
assert sorted(row[0] for row in medians) == programs
raw = report.split('## Raw elapsed samples')[1].split('## Compilation')[0]
samples = {}
for line in raw.splitlines():
    parts = [part.strip() for part in line.split('|')]
    if len(parts) == 6 and parts[1] in programs:
        assert parts[1] not in samples
        samples[parts[1]] = {
            kind: [float(item.removesuffix(' ms')) for item in column.split(', ')]
            for kind, column in zip(['c', 'rs', 'fwp'], parts[2:5], strict=True)}
assert sorted(samples) == programs
machine = {'x86_64': 62, 'aarch64': 183}[args.arch]
result = dict(source=args.source, memory=args.memory, architecture=args.arch,
              reportSha256=hashlib.sha256(report.encode()).hexdigest(),
              tool=subprocess.check_output([args.objdump, '--version'], text=True),
              scope='Static inspection of actual measured binaries; no re-execution. '
                    'Complete-process elapsed samples, not isolated compiler overhead. '
                    'Text-section sizes include padding; no allocation/RSS measurement.',
              programs=[])
for name, c, rs, fwp in medians:
    times = dict(zip(['c', 'rs', 'fwp'], map(float, [c, rs, fwp]), strict=True))
    for kind, values in samples[name].items():
        assert len(values) == 6 and all(value > 0 for value in values), 'need six positive timing samples'
        assert abs(statistics.median(values) - times[kind]) <= 0.00101
    row = dict(name=name, medianMs=times, samplesMs=samples[name],
               fwpOverC=times['fwp'] / times['c'], fwpOverRust=times['fwp'] / times['rs'],
               stdout=(directory / f'{name}-stdout.txt').read_text(), files={})
    assert row['stdout']
    for kind in ['c', 'rs', 'fwp']:
        input_file = directory / f'{name}-source.{kind}'
        original = subprocess.check_output(
            ['git', 'show', f'{args.source}:bench/{name}/main.{kind}'], cwd=ROOT)
        assert input_file.read_bytes() == original
        binary = directory / f'{name}-{kind}'
        data = binary.read_bytes()
        assert data[:6] == b'\x7fELF\x02\x01', binary
        assert struct.unpack_from('<H', data, 18)[0] == machine, 'benchmark binary has wrong architecture'
        assert struct.unpack_from('<H', data, 16)[0] in {2, 3}, 'benchmark image is not executable'
        assert struct.unpack_from('<Q', data, 24)[0] != 0, 'benchmark image has no entry point'
        symbols = subprocess.check_output([args.objdump, '--section-headers', '--syms', str(binary)])
        assembly = subprocess.check_output([args.objdump, '-d', str(binary)])
        sections = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', symbols, re.M)
        assert sections and len(assembly) > 100
        if kind == 'fwp' and args.memory == 'arc':
            assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_gc_(scan|mark_all|sweep)\b', symbols)
        row['files'][kind] = dict(sourceSha256=hashlib.sha256(original).hexdigest(),
            binarySha256=hashlib.sha256(data).hexdigest(), fileBytes=len(data),
            textSectionBytes=sum(int(size, 16) for size in sections),
            disassemblySha256=hashlib.sha256(assembly).hexdigest(),
            symbolsSha256=hashlib.sha256(symbols).hexdigest())
    generated = (directory / f'{name}-generated.c').read_bytes()
    assert (b'#define FWP_ARC_ONLY 1' in generated) == (args.memory == 'arc')
    row['generatedCSha256'] = hashlib.sha256(generated).hexdigest()
    result['programs'].append(row)
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(result, indent=2) + '\n')
print(f'Inspected {len(programs) * 3} native binaries and explicit {args.memory} benchmark records')
