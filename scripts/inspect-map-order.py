#!/usr/bin/env python3
"""Review ordered-range sort candidates and recompute every timing screen."""
import argparse
import ast
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
assert report['thresholds'] == dict(maxControlChangePercent=3, minMapGainPercent=5, maxOtherSlowdownPercent=3)
assert len(report['allowedCpus']) == len(set(report['allowedCpus'])) and report['allowedCpus']
assert len(report['programs']) == len(inspection['programs']) == 7
directory, = (args.benchmarks / args.source).iterdir()
labels = ['baseline', 'identical-control', 'ordered-merge', 'ordered-range']
images = []
verdicts = {'ordered-merge': True, 'ordered-range': True}
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
            merge_anchor = '    fwp_msort(keys + m, vals + m, n - m, d, tk, tv);\n'
            entry_anchor = 'static void fwp_msort(V *keys, V *vals, size_t n, const fwp_desc *d, V *tk, V *tv) {\n    if (n < 2) return;\n'
            expected = original.decode()
            assert expected.count(merge_anchor) == expected.count(entry_anchor) == 1
            changes = []
            if label != 'baseline':
                expected = expected.replace(merge_anchor, merge_anchor +
                    '    if (fwp_cmp(keys[m - 1], keys[m], d) <= 0) return;\n')
                changes.append('skip merge after ordered halves')
            if label == 'ordered-range':
                expected = expected.replace(entry_anchor, entry_anchor +
                    '    size_t ordered = 1;\n'
                    '    while (ordered < n && fwp_cmp(keys[ordered - 1], keys[ordered], d) <= 0) ordered++;\n'
                    '    if (ordered == n) return;\n')
                changes.append('skip recursion for ordered input')
            assert code.decode() == expected
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
        limit = .95 if name == 'map' else 1.03
        for label in verdicts:
            passed = stable and all(value <= limit for value in ratios[label].values())
            assert passed == entry['screen'][label]
            verdicts[label] &= passed
assert verdicts == report['screen']
stability_bytes = (args.input / 'stability.json').read_bytes()
assert hashlib.sha256(stability_bytes).hexdigest() == report['stabilitySha256']
stability = json.loads(stability_bytes)
assert stability['source'] == args.source and stability['architecture'] == args.arch
assert [row['variant'] for row in stability['images']] == ['baseline', 'ordered-merge', 'ordered-range', 'missing-merge']
script = subprocess.check_output(['git', 'show', args.source + ':scripts/measure-map-order.py'], text=True)
probe, = [ast.literal_eval(node.value) for node in ast.parse(script).body
          if isinstance(node, ast.Assign) and any(isinstance(target, ast.Name) and target.id == 'probe' for target in node.targets)]
map_code = (directory / 'map-generated.c').read_text()
for row in stability['images']:
    label = row['variant']
    original = map_code
    if label == 'missing-merge':
        original = original.replace(merge_anchor, merge_anchor + '    return; /* broken control */\n')
    elif label != 'baseline':
        original = original.replace(merge_anchor, merge_anchor +
            '    if (fwp_cmp(keys[m - 1], keys[m], d) <= 0) return;\n')
        if label == 'ordered-range':
            original = original.replace(entry_anchor, entry_anchor +
                '    size_t ordered = 1;\n'
                '    while (ordered < n && fwp_cmp(keys[ordered - 1], keys[ordered], d) <= 0) ordered++;\n'
                '    if (ordered == n) return;\n')
    original = original.replace('int main(int argc, char **argv)',
                                'int benchmark_main(int argc, char **argv)') + probe
    code = (args.input / f'stability-{label}.c').read_text()
    assert code == original and hashlib.sha256(code.encode()).hexdigest() == row['sourceSha256']
    expected_cases = [(n, pattern, alias) for n in [0, 1, 2, 3, 17, 257]
                      for pattern in range(5) for alias in [0, 1]]
    assert [(r['length'], r['pattern'], r['aliased']) for r in row['observations']] == expected_cases
    rejected = 0
    for observation in row['observations']:
        n, pattern, aliased = observation['length'], observation['pattern'], observation['aliased']
        if pattern == 0:
            keys = list(range(n))
        elif pattern == 1:
            keys = [-i for i in range(n)]
        elif pattern == 2:
            keys = [i % 5 - 2 for i in range(n)]
        elif pattern == 3:
            keys = [n - i if i % 2 else i for i in range(n)]
        else:
            keys = [(i * 73 + 19) % 257 - 128 for i in range(n)]
        ordered = sorted((value, index) for index, value in enumerate(keys))
        expected = ''.join(f'{value}:{0 if aliased else index}\n' for value, index in ordered)
        assert observation['expected'] == expected
        assert observation['status'] == 0 and observation['stderr'] == ''
        matches = observation['stdout'] == expected
        assert matches == observation['matches']
        assert label == 'missing-merge' or matches
        rejected += not matches
    assert rejected == row['rejectedCases']
    assert label != 'missing-merge' or rejected > 0
    binary = args.input / f'stability-{label}'
    data = binary.read_bytes()
    assert hashlib.sha256(data).hexdigest() == row['binarySha256'] and len(data) == row['fileBytes']
    assert data[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', data, 18)[0] == {'x86_64': 62, 'aarch64': 183}[args.arch]
    assert struct.unpack_from('<H', data, 16)[0] in {2, 3} and struct.unpack_from('<Q', data, 24)[0]
    assert row['command'][1:6] == ['-O2', '-std=gnu11', '-ffp-contract=off', '-fstack-usage', '-w']
    symbols = subprocess.check_output([args.objdump, '--section-headers', '--syms', str(binary)])
    assembly = subprocess.check_output([args.objdump, '-d', str(binary)])
    assert len(assembly) > 1000
    sections = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', symbols, re.M)
    assert len(sections) == 1
    stack, = args.input.glob(f'stability-{label}*.su')
    images.append(dict(program='stability', variant=label, binarySha256=row['binarySha256'],
        sourceSha256=row['sourceSha256'], fileBytes=len(data), textSectionBytes=int(sections[0], 16),
        disassemblySha256=hashlib.sha256(assembly).hexdigest(), symbolsSha256=hashlib.sha256(symbols).hexdigest(),
        stackReport=stack.read_text(), stackSha256=hashlib.sha256(stack.read_bytes()).hexdigest()))
assert len(images) == 32
args.output.write_text(json.dumps(dict(source=args.source, architecture=args.arch,
    reportSha256=hashlib.sha256((args.input / 'report.json').read_bytes()).hexdigest(),
    images=images, screen=verdicts,
    scope='Independent static inspection and recomputation of all paired sample summaries. No downloaded programs executed. The timing screen is not semantic acceptance or a C/Rust comparison.'), indent=2) + '\n')
print('Inspected 32 sort experiment images and stability controls; recomputed all timing screens:', verdicts)
