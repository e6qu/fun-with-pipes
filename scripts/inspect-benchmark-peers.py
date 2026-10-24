#!/usr/bin/env python3
"""Review saved peer boundary/cleanup observations and actual native control images."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parent.parent
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--arch', choices=['x86_64', 'aarch64'], required=True)
parser.add_argument('--objdump', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert not args.output.exists(), 'Preserve completed reviews'
assert re.fullmatch('[0-9a-f]{40}', args.source)
report = json.loads((args.input / 'report.json').read_text())
assert report['source'] == args.source and report['architecture'] == args.arch
assert len(report['arithmetic']) == 8 and len(report['allocation']) == 3
minimum, maximum = -(1 << 63), (1 << 63) - 1
indices = {minimum, minimum + 1, maximum, maximum - 1, maximum // 3,
           maximum // 3 + 1, -(abs(minimum) // 3), -(abs(minimum) // 3) - 1,
           -8, -7, -2, -1, 0, 1, 2, 7, 8}
expected_inputs = {(i, acc) for i in indices for acc in [minimum, 0, maximum]}
files = []


def inspect_image(record, language, program):
    name = record['file']
    assert Path(name).name == name
    code = (args.input / f'{name}.{language}').read_bytes()
    data = (args.input / name).read_bytes()
    original = subprocess.check_output(
        ['git', 'show', f'{args.source}:bench/{program}/main.{language}'], cwd=ROOT)
    assert hashlib.sha256(original).hexdigest() == record['benchmarkSourceSha256']
    assert hashlib.sha256(code).hexdigest() == record['sourceSha256']
    assert hashlib.sha256(data).hexdigest() == record['binarySha256']
    assert data[:6] == b'\x7fELF\x02\x01'
    assert struct.unpack_from('<H', data, 18)[0] == {'x86_64': 62, 'aarch64': 183}[args.arch]
    assert struct.unpack_from('<H', data, 16)[0] in {2, 3}
    assert struct.unpack_from('<Q', data, 24)[0] != 0
    flags = (['-std=c11', '-O2', '-ffp-contract=off'] if language == 'c'
             else ['--edition=2021', '-O', '--crate-name', 'peer_probe'])
    assert record['command'][1:1 + len(flags)] == flags
    assert Path(record['command'][1 + len(flags)]).name == f'{name}.{language}'
    assert len(record['command']) == len(flags) + 4
    assert record['command'][-2] == '-o'
    assert Path(record['command'][-1]).name == name
    symbols = subprocess.check_output([args.objdump, '--section-headers', '--syms', str(args.input / name)])
    assembly = subprocess.check_output([args.objdump, '-d', str(args.input / name)])
    sections = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', symbols, re.M)
    assert sections and len(assembly) > 100
    files.append(dict(file=name, binarySha256=record['binarySha256'],
        sourceSha256=record['sourceSha256'], fileBytes=len(data),
        textSectionBytes=sum(int(size, 16) for size in sections),
        disassemblySha256=hashlib.sha256(assembly).hexdigest()))
    return original.decode(), code.decode()


seen = set()
for record in report['arithmetic']:
    language, removed = record['language'], record['removedCheck']
    assert language in {'c', 'rs'} and removed in {'none', 'subtraction', 'multiplication', 'addition'}
    assert (language, removed) not in seen
    seen.add((language, removed))
    original, code = inspect_image(record, language, 'loop')
    marker = '    while (i != 0) {\n' if language == 'c' else '    while i != 0 {\n'
    body = original.split(marker, 1)[1].split('\n    }\n', 1)[0]
    if removed != 'none':
        operation = {'subtraction': 'sub', 'multiplication': 'mul', 'addition': 'add'}[removed]
        if language == 'c':
            expression = {
                'subtraction': 'next = (int64_t)((uint64_t)i - UINT64_C(1));',
                'multiplication': 'product = (int64_t)((uint64_t)i * UINT64_C(3));',
                'addition': 'sum = (int64_t)((uint64_t)acc + (uint64_t)(product % 7));',
            }[removed]
            body, count = re.subn(
                rf'if \(__builtin_{operation}_overflow\([^\n]+\)\) \{{.*?\n        \}}',
                expression, body, flags=re.S)
            assert count == 1
        else:
            operand = {'subtraction': 'i', 'multiplication': 'i', 'addition': 'acc'}[removed]
            argument = {'subtraction': '1', 'multiplication': '3', 'addition': 'product % 7'}[removed]
            before = f'{operand}.checked_{operation}({argument}).expect("{removed} overflow")'
            assert body.count(before) == 1
            body = body.replace(before, f'{operand}.wrapping_{operation}({argument})')
    assert body in code, 'saved control must contain the exact benchmark body and intended edit'
    observations = record['observations']
    assert len(observations) == len(expected_inputs)
    assert {(row['index'], row['accumulator']) for row in observations} == expected_inputs
    detected = 0
    for row in observations:
        i, accumulator = row['index'], row['accumulator']
        error = None
        expected = [i, accumulator]
        if i != 0:
            product = i * 3
            remainder = (abs(product) % 7) * (-1 if product < 0 else 1)
            if i == minimum:
                error = 'subtraction'
            elif product < minimum or product > maximum:
                error = 'multiplication'
            elif not minimum <= accumulator + remainder <= maximum:
                error = 'addition'
            else:
                expected = [i - 1, accumulator + remainder]
        expected = None if error else expected
        assert row['expected'] == expected and row['expectedFailure'] == error
        matches = (row['status'] == 0 and row['stdout'] == f'{expected[0]} {expected[1]}\n'
                   and row['stderr'] == '') if not error else (
                   row['status'] == (1 if language == 'c' else 101) and row['stdout'] == ''
                   and f'{error} overflow' in row['stderr'])
        assert matches == row['matchesContract']
        if removed == 'none' or error is None:
            assert matches
        if removed != 'none' and error == removed:
            assert not matches
            detected += 1
    assert detected == record['detectedMissingChecks']
    assert removed == 'none' or detected > 0

seen_allocations = set()
for record in report['allocation']:
    program, removed = record['program'], record['removedCleanup']
    assert (program, removed) in {('map', 'none'), ('pipeline', 'none'), ('pipeline', 'partial-free')}
    assert (program, removed) not in seen_allocations
    seen_allocations.add((program, removed))
    original, code = inspect_image(record, 'c', program)
    body = original.replace('int main(void)', 'int benchmark_main(void)')
    if removed == 'partial-free':
        before = 'if (!b) { free(a); return 1; }'
        assert body.count(before) == 1
        body = body.replace(before, 'if (!b) return 1;')
    body = body.replace('malloc(', 'probe_malloc(').replace('free(', 'probe_free(')
    body = '\n'.join(line for line in body.splitlines() if not line.startswith('#include'))
    assert body in code
    expected_sites = [1] if program == 'map' else [1, 2]
    assert [row['failedRequest'] for row in record['observations']] == expected_sites
    for row in record['observations']:
        failure = row['failedRequest']
        leaked = int(removed == 'partial-free' and failure == 2)
        assert row['status'] == (75 if leaked else 0) and not row['stderr']
        assert row['stdout'] == f'status=1 calls={failure} live={leaked}\n'

args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(dict(source=args.source, architecture=args.arch,
    dynamicInputs=len(expected_inputs), arithmeticImages=8, allocationImages=3,
    missingChecks=6, missingCleanup=1, files=files,
    scope='Static review of saved native images, exact benchmark bodies and recorded observations; '
          'no execution of downloaded binaries and no timing claim.'), indent=2) + '\n')
print('Inspected eleven native peer-control images, all boundary observations and seven broken controls')
