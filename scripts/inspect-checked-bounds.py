#!/usr/bin/env python3
"""Review actual arithmetic experiment images and recompute every timing screen."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import statistics
import struct
import subprocess

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--benchmarks', type=Path, required=True)
parser.add_argument('--inspection', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--arch', choices=['x86_64', 'aarch64'], required=True)
parser.add_argument('--objdump', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert not args.output.exists()
report = json.loads((args.input / 'report.json').read_text())
inspection = json.loads(args.inspection.read_text())
assert report['source'] == inspection['source'] == args.source
assert report['memory'] == inspection['memory'] == 'arc'
assert report['architecture'] == inspection['architecture'] == args.arch
assert report['inspectionSha256'] == hashlib.sha256(args.inspection.read_bytes()).hexdigest()
assert report['samples'] == 32 and report['warmups'] == 2
assert report['thresholds'] == dict(maxControlChangePercent=3, minLoopGainPercent=5, maxOtherSlowdownPercent=3)
assert len(report['allowedCpus']) == len(set(report['allowedCpus'])) and report['allowedCpus']
assert len(report['programs']) == len(inspection['programs']) == 7
directory, = (args.benchmarks / args.source).iterdir()
labels = ['baseline', 'identical-control', 'sub-expression', 'add-sub-expression']
images = []
verdicts = {'sub-expression': True, 'add-sub-expression': True}
for row, measured in zip(report['programs'], inspection['programs'], strict=True):
    name = row['name']
    assert name == measured['name'] and set(row['variants']) == set(labels)
    original = (directory / f'{name}-generated.c').read_bytes()
    assert hashlib.sha256(original).hexdigest() == measured['generatedCSha256']
    assert (args.input / f'{name}-baseline.c').read_bytes() == original
    for label in labels:
        record = row['variants'][label]
        binary = args.input / f'{name}-{label}'
        data = binary.read_bytes()
        assert hashlib.sha256(data).hexdigest() == record['binarySha256'] and len(data) == record['fileBytes']
        if label == 'identical-control':
            assert data == (args.input / f'{name}-baseline').read_bytes()
            source_label = 'baseline'
        else:
            source_label = label
            code = (args.input / f'{name}-{label}.c').read_bytes()
            assert hashlib.sha256(code).hexdigest() == record['sourceSha256']
            allowed = [] if label == 'baseline' else ['sub'] if label == 'sub-expression' else ['add', 'sub']
            changes = {operation: 0 for operation in allowed}
            old_lines, new_lines = original.decode().splitlines(), code.decode().splitlines()
            for number, (before, after) in enumerate(zip(old_lines, new_lines, strict=True)):
                if before == after:
                    continue
                assert before == '    return (V)r;'
                operation = 'add' if after == '    return (V)(x + y);' else 'sub' if after == '    return (V)(x - y);' else None
                assert operation in allowed
                assert old_lines[number - 2] == '    int64_t x = (int64_t)l1, y = (int64_t)l0, r;'
                assert re.fullmatch(r'    if \(__builtin_' + operation + r'_overflow\(x, y, &r\)\) fwp_trap_overflow\("I(?:64|Size)"\);', old_lines[number - 1])
                changes[operation] += 1
            assert changes == record['changed']
        assert data[:6] == b'\x7fELF\x02\x01'
        assert struct.unpack_from('<H', data, 18)[0] == {'x86_64': 62, 'aarch64': 183}[args.arch]
        assert struct.unpack_from('<H', data, 16)[0] in {2, 3} and struct.unpack_from('<Q', data, 24)[0]
        symbols = subprocess.check_output([args.objdump, '--section-headers', '--syms', str(binary)])
        assembly = subprocess.check_output([args.objdump, '-d', str(binary)])
        assert len(assembly) > 1000
        assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_heap_(scan|mark_all|sweep)\b', symbols)
        sections = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', symbols, re.M)
        assert len(sections) == 1
        stack, = args.input.glob(f'{name}-{source_label}*.su')
        assert stack.stat().st_size > 0
        images.append(dict(program=name, variant=label, binarySha256=record['binarySha256'],
                           fileBytes=len(data), textSectionBytes=int(sections[0], 16),
                           disassemblySha256=hashlib.sha256(assembly).hexdigest(),
                           symbolsSha256=hashlib.sha256(symbols).hexdigest(),
                           stackReport=stack.read_text(), stackSha256=hashlib.sha256(stack.read_bytes()).hexdigest()))
    assert [entry['cpu'] for entry in row['cpus']] == report['allowedCpus']
    for entry in row['cpus']:
        assert set(entry['samples']) == set(labels)
        medians = {}
        for label in labels:
            samples = entry['samples'][label]
            assert len(samples) == report['samples']
            assert [sample['round'] for sample in samples] == list(range(report['samples']))
            assert all(sum(sample['position'] == position for sample in samples) == 8 for position in range(4))
            for sample in samples:
                number = sample['round']
                offset = number % 4
                order = labels[offset:] + labels[:offset]
                if number // 4 % 2:
                    order = order[::-1]
                assert sample['position'] == order.index(label)
            assert all(sample['elapsedNs'] > 0 and sample['childCpuNs'] > 0 for sample in samples)
            medians[label] = {key: statistics.median(sample[key] for sample in samples)
                              for key in ['elapsedNs', 'childCpuNs']}
        assert medians == entry['medians']
        ratios = {label: {key: medians[label][key] / medians['baseline'][key] for key in medians[label]}
                  for label in labels if label != 'baseline'}
        assert ratios == entry['ratiosToBaseline']
        stable = all(abs(value - 1) <= .03 for value in ratios['identical-control'].values())
        assert stable == entry['controlStable']
        limit = .95 if name == 'loop' else 1.03
        for label in verdicts:
            passed = stable and all(value <= limit for value in ratios[label].values())
            assert passed == entry['screen'][label]
            verdicts[label] &= passed
assert verdicts == report['screen']
args.output.write_text(json.dumps(dict(source=args.source, architecture=args.arch,
    reportSha256=hashlib.sha256((args.input / 'report.json').read_bytes()).hexdigest(),
    images=images, screen=verdicts,
    scope='Independent static inspection and recomputation of all paired sample summaries. No downloaded programs executed. The timing screen is not semantic acceptance or a C/Rust comparison.'), indent=2) + '\n')
print('Inspected 28 arithmetic experiment images; recomputed all timing screens:', verdicts)
