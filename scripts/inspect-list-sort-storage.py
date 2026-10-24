#!/usr/bin/env python3
"""Verify actual sort-storage executables, controls, stack reports and counts."""
import argparse
import hashlib
import importlib.util
import json
from pathlib import Path
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parent.parent
measurement_spec = importlib.util.spec_from_file_location('list_sort_storage', ROOT / 'scripts/measure-list-sort-storage.py')
measurement = importlib.util.module_from_spec(measurement_spec)
measurement_spec.loader.exec_module(measurement)

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--arch', choices=['X64', 'ARM64'], required=True)
parser.add_argument('--objdump', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
report = json.loads((args.input / 'report.json').read_text())
assert report['source'] == args.source and re.fullmatch('[0-9a-f]{40}', args.source)
assert report['architecture'] == ('aarch64' if args.arch == 'ARM64' else 'x86_64')
for name in ['scripts/measure-list-sort-storage.py', 'scripts/measure-iteration.py']:
    assert (ROOT / name).read_bytes() == subprocess.check_output(['git', 'show', args.source + ':' + name])
runtime = subprocess.check_output(['git', 'show', args.source + ':runtime/fwp_rt_prims.c'], text=True)
assert [row['name'] for row in report['programs']] == ['list', 'array', 'array-owned']
images = []
observations = []
for row in report['programs']:
    kind = row['name']
    generated = (args.input / (kind + '-generated.c')).read_text()
    assert hashlib.sha256(generated.encode()).hexdigest() == row['generatedSha256']
    assert generated.count(runtime) == 1 and '#define FWP_ARC_ONLY 1' in generated
    language = (args.input / (kind + '.fwp')).read_bytes()
    assert hashlib.sha256(language).hexdigest() == row['languageSha256']
    variants = dict(measurement.variants(generated, kind))
    normal, control = variants
    expected = {variant + opt for variant in variants for opt in ['-O1', '-O2']}
    assert set(row['variants']) == expected
    for variant, scopes in row['variants'].items():
        assert set(scopes) == {'ordinary', 'profile'}
        expected_code = variants[variant[:-3]]
        for scope, recorded in scopes.items():
            binary = args.input / recorded['binary']
            assert binary.name == f'{kind}-{variant}' + ('-profile' if scope == 'profile' else '')
            raw = binary.read_bytes()
            assert hashlib.sha256(raw).hexdigest() == recorded['binarySha256']
            assert len(raw) == recorded['fileBytes']
            assert raw[:6] == b'\x7fELF\x02\x01'
            assert struct.unpack_from('<H', raw, 16)[0] in [2, 3]
            machine = struct.unpack_from('<H', raw, 18)[0]
            assert machine == (183 if args.arch == 'ARM64' else 62)
            code = binary.with_suffix('.c').read_text()
            assert hashlib.sha256(code.encode()).hexdigest() == recorded['sourceSha256']
            assert code == (measurement.profile.instrument(expected_code) if scope == 'profile' else expected_code)
            flags = recorded['command']
            assert flags[1:6] == ['-std=gnu11', variant[-3:], '-ffp-contract=off', '-fstack-usage', '-w']
            assert '-flto' not in flags
            stack = binary.with_suffix('.su').read_bytes()
            assert stack.decode() == recorded['stackReport']
            assert hashlib.sha256(stack).hexdigest() == recorded['stackSha256']
            sections = subprocess.check_output([args.objdump, '--syms', '--section-headers', str(binary)])
            assembly = subprocess.check_output([args.objdump, '-d', str(binary)])
            sizes = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', sections, re.M)
            assert sizes and len(assembly) > 1000
            assert sum(int(size, 16) for size in sizes) == recorded['textSectionBytes']
            assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_gc_(?:scan|mark_all|sweep)\b', sections)
            images.append(dict(program=kind, variant=variant, scope=scope, machine=machine,
                               **recorded, inspectionDisassemblySha256=hashlib.sha256(assembly).hexdigest()))
    assert [entry['elements'] for entry in row['observations']] == [0, 1, 32, 4096]
    for entry in row['observations']:
        count = entry['elements']
        data = (' '.join(f'word{(index * 17) % 103:03d}' for index in range(count)) + '\n').encode()
        assert hashlib.sha256(data).hexdigest() == entry['inputSha256']
        assert set(entry['variants']) == expected
        for samples in entry['variants'].values():
            assert len(samples) == 3 and all(sample == samples[0] for sample in samples)
            assert samples[0]['finalChargedBytes'] == samples[0]['collections'] == 0
        for opt in ['-O1', '-O2']:
            shared = entry['variants'][normal + opt][0]
            separate = entry['variants'][control + opt][0]
            extra = (2 if kind == 'list' else 1) if count > 1 else 0
            assert separate['requests'] - shared['requests'] == extra
            assert separate['requestedBytes'] - shared['requestedBytes'] == extra * (count + 1) * 8
            assert separate['retains'] - shared['retains'] == (count if kind == 'array-owned' and count > 1 else 0)
            assert separate['peakChargedBytes'] >= shared['peakChargedBytes']
            observations.append(dict(program=kind, elements=count, optimization=opt,
                                     normalVariant=normal, controlVariant=control, normal=shared, control=separate))
assert len(images) == len(observations) == 24
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(dict(source=args.source, architecture=report['architecture'],
    reportSha256=hashlib.sha256((args.input / 'report.json').read_bytes()).hexdigest(),
    images=images, observations=observations), indent=2) + '\n')
print('Inspected 24 actual sort-storage images and 24 repeated count comparisons')
