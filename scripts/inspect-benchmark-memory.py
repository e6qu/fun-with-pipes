#!/usr/bin/env python3
"""Inspect saved benchmark memory observations and the actual instrumented images."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parent.parent
profile_spec = importlib.util.spec_from_file_location(
    'iteration_profile', ROOT / 'scripts/measure-iteration.py')
profile = importlib.util.module_from_spec(profile_spec)
profile_spec.loader.exec_module(profile)
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
assert report['samples'] >= 3
assert len(report['programs']) == len(inspection['programs']) == 7
directory, = (args.benchmarks / args.source).iterdir()
images = []
for row, measured in zip(report['programs'], inspection['programs'], strict=True):
    name = row['name']
    assert name == measured['name']
    for kind in ['c', 'rs', 'fwp']:
        memory = row['processMemory'][kind]
        assert memory['binarySha256'] == measured['files'][kind]['binarySha256']
        assert len(memory['peakRssKiB']) == report['samples']
        for number, value in enumerate(memory['peakRssKiB']):
            assert value > 0 and value == int((args.input / f'{name}-{kind}-{number}.rss-kib').read_text())
    original = (directory / f'{name}-generated.c').read_bytes()
    assert hashlib.sha256(original).hexdigest() == measured['generatedCSha256']
    ordinary_code = profile.instrument(original.decode())
    start = 'iteration_start_charge=iteration_charge();iteration_active=1;'
    assert ordinary_code.count(start) == 1
    for label in ['ordinary', 'injected-leak']:
        stem = f'{name}-{label}'
        records = row['managedMemory'][label]
        code = (args.input / (stem + '.c')).read_bytes()
        expected = ordinary_code if label == 'ordinary' else ordinary_code.replace(start, start + '(void)fwp_alloc_leaf(16);')
        assert code.decode() == expected
        assert hashlib.sha256(code).hexdigest() == records['generatedSha256']
        binary = args.input / stem
        data = binary.read_bytes()
        assert hashlib.sha256(data).hexdigest() == records['binarySha256']
        assert len(data) == records['fileBytes']
        assert data[:6] == b'\x7fELF\x02\x01'
        assert struct.unpack_from('<H', data, 18)[0] == {'x86_64': 62, 'aarch64': 183}[args.arch]
        assert struct.unpack_from('<H', data, 16)[0] in {2, 3}
        assert struct.unpack_from('<Q', data, 24)[0] != 0
        symbols = subprocess.check_output([args.objdump, '--section-headers', '--syms', str(binary)])
        assembly = subprocess.check_output([args.objdump, '-d', str(binary)])
        assert len(assembly) > 1000
        assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_gc_(scan|mark_all|sweep)\b', symbols)
        sections = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', symbols, re.M)
        assert len(sections) == 1
        stack, = args.input.glob(stem + '*.su')
        assert stack.stat().st_size > 0
        assert len(records['profiles']) == report['samples']
        for number, counts in enumerate(records['profiles']):
            assert (args.input / f'{stem}-{number}.stdout').read_text() == measured['stdout']
            assert json.loads((args.input / f'{stem}-{number}.stderr').read_text()) == counts
            assert counts == records['profiles'][0] and counts['collections'] == 0
        images.append(dict(program=name, variant=label, binarySha256=records['binarySha256'],
                           generatedSha256=records['generatedSha256'], fileBytes=len(data),
                           textSectionBytes=int(sections[0], 16),
                           disassemblySha256=hashlib.sha256(assembly).hexdigest(),
                           symbolsSha256=hashlib.sha256(symbols).hexdigest(),
                           instrumentedStackSha256=hashlib.sha256(stack.read_bytes()).hexdigest()))
    ordinary = row['managedMemory']['ordinary']['profiles'][0]
    leaked = row['managedMemory']['injected-leak']['profiles'][0]
    assert row['leakDetected'] and ordinary['finalChargedBytes'] == 0
    assert leaked['requests'] == ordinary['requests'] + 1
    assert leaked['requestedBytes'] == ordinary['requestedBytes'] + 16
    assert leaked['retains'] == ordinary['retains'] and leaked['finalChargedBytes'] > 0
args.output.write_text(json.dumps(dict(source=args.source, architecture=args.arch,
    reportSha256=hashlib.sha256((args.input / 'report.json').read_bytes()).hexdigest(),
    images=images, scope='Static inspection of separate instrumented ARC binaries and saved memory observations; no downloaded executable run. Stack reports belong to these instrumented images.'), indent=2) + '\n')
print('Inspected 14 instrumented ARC images, 21 RSS distributions and seven leak controls')
