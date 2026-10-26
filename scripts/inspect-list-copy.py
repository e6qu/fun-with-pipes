#!/usr/bin/env python3
"""Inspect saved list-copy binaries and deliberate missing-cleanup controls."""
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
parser.add_argument('--system', choices=['Linux', 'macOS', 'Windows'], required=True)
parser.add_argument('--arch', choices=['X64', 'ARM64'], required=True)
parser.add_argument('--objdump', required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert re.fullmatch(r'[0-9a-f]{40}', args.source)
runtime = subprocess.check_output(['git', 'show', args.source + ':runtime/fwp_rt_prims.c'], text=True)
fixture = subprocess.check_output(['git', 'show', args.source + ':tests/fixtures/list_copy_probe.c'], text=True)
changes = {
    'missing-key': ('fwp_map_owner owner = {keys, 0, 0, drop_key, NULL};',
                    'fwp_map_owner owner = {keys, 0, 0, NULL, NULL};'),
    'missing-scratch': ('static void fwp_scratch_release(void *arg) {',
                        'static void fwp_scratch_release(void *arg) { (void)arg; return;'),
    'missing-partial': ('fwp_value_owner result = {owned_tail, list->drop};',
                        'fwp_value_owner result = {owned_tail, NULL};'),
}
expected = set()
images = []
observations = []
program_output = None
for memory in ['arc', 'tracing']:
    for optimization in ['-O1', '-O2']:
        baseline = args.input / f'{memory}{optimization}-balanced-reuse0.c'
        balanced = baseline.read_text()
        descriptor, = re.findall(r'static const fwp_desc \*copy_list = (&d\d+);', balanced)
        assert balanced.endswith(fixture.replace('LIST_DESCRIPTOR', descriptor))
        for case in ['program', 'balanced', *changes]:
            reuses = ['0', '1'] if memory == 'tracing' and case in ['program', 'balanced'] else ['0']
            for reuse in reuses:
                label = f'{memory}{optimization}-{case}-reuse{reuse}'
                expected.add(label)
                prefix = args.input / label
                code = prefix.with_suffix('.c').read_text()
                if case == 'program':
                    assert code.count(runtime) == 1, 'Program must contain the exact revision runtime'
                    assert 'copy_tick' not in code
                elif case == 'balanced':
                    assert code == balanced
                else:
                    old, new = changes[case]
                    assert balanced.count(old) == 1
                    assert code == balanced.replace(old, new)
                assert ('#define FWP_ARC_ONLY 1' in code) == (memory == 'arc')
                stdout = prefix.with_suffix('.stdout').read_bytes()
                stderr = prefix.with_suffix('.stderr').read_bytes()
                status = prefix.with_suffix('.status').read_text().strip()
                if case in changes:
                    assert status == 'Some(213)' and not stdout
                    assert b'copied-list live allocations:' in stderr
                else:
                    assert status == 'Some(0)' and not stderr
                    if case == 'program':
                        if program_output is None:
                            program_output = stdout
                        assert stdout == program_output and b'Err "expected"' in stdout
                    else:
                        match = re.fullmatch(rb'7 copied-list operations: (\d+) allocation/retain failures and 6 callback exits cleaned; aliases preserved\r?\n', stdout)
                        assert match and int(match[1]) >= 130
                        observations.append(dict(label=label, interruptions=int(match[1]), callbackExits=6, rounds=8))
                binary = prefix.with_suffix('.exe')
                raw = binary.read_bytes()
                if args.system == 'Linux':
                    assert raw[:6] == b'\x7fELF\x02\x01'
                    assert struct.unpack_from('<H', raw, 16)[0] in [2, 3]
                    machine = struct.unpack_from('<H', raw, 18)[0]
                    assert machine == (183 if args.arch == 'ARM64' else 62)
                elif args.system == 'macOS':
                    assert raw[:4] == b'\xcf\xfa\xed\xfe'
                    assert struct.unpack_from('<I', raw, 12)[0] == 2
                    machine = struct.unpack_from('<I', raw, 4)[0]
                    assert machine == (0x100000c if args.arch == 'ARM64' else 0x1000007)
                else:
                    assert raw[:2] == b'MZ'
                    offset = struct.unpack_from('<I', raw, 60)[0]
                    assert raw[offset:offset+4] == b'PE\0\0'
                    machine = struct.unpack_from('<H', raw, offset+4)[0]
                    assert machine == (0xaa64 if args.arch == 'ARM64' else 0x8664)
                sections = subprocess.check_output([args.objdump, '--section-headers', '--syms', str(binary)])
                assembly = subprocess.check_output([args.objdump, '-d', str(binary)])
                assert len(assembly) > 1000
                sizes = re.findall(rb'^\s*\d+\s+(?:\.text|__text)\s+([0-9a-fA-F]+)\s', sections, re.M)
                assert sizes
                if memory == 'arc':
                    assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_heap_(?:scan|mark_all|sweep)\b', sections)
                images.append(dict(label=label, machine=machine, fileBytes=len(raw),
                    instructionBytes=sum(int(size, 16) for size in sizes),
                    sourceSha256=hashlib.sha256(code.encode()).hexdigest(),
                    binarySha256=hashlib.sha256(raw).hexdigest(),
                    disassemblySha256=hashlib.sha256(assembly).hexdigest(),
                    sectionsSha256=hashlib.sha256(sections).hexdigest(),
                    stdout=stdout.decode(), stderr=stderr.decode(), status=status))
assert {path.stem for path in args.input.glob('*.exe')} == expected
assert len(images) == 24 and len(observations) == 6
report = dict(source=args.source, system=args.system, architecture=args.arch,
    scope='Current generated program and cleanup probes; no elapsed-time comparison.',
    images=images, observations=observations)
args.output.parent.mkdir(parents=True, exist_ok=True)
args.output.write_text(json.dumps(report, indent=2) + '\n')
print('Inspected 24 actual list-copy images, six balanced observations and 12 missing-cleanup controls')
