#!/usr/bin/env python3
"""Check saved Linux function objects and startup code without running binaries."""
import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--artifact', type=Path, required=True)
parser.add_argument('--llvm-bin', type=Path, required=True)
args = parser.parse_args()
directory = args.artifact
binary = directory / 'server.exe'
code = (directory / 'server.c').read_text()
assert '#define FWP_ARC_ONLY 1' in code
declarations = re.findall(
    r'^static fwp_clo (fwp_static_function\d+) = \{(\d+), (\d+), \{([0, ]+)\}\};$',
    code, re.M)
assert declarations
symbols = subprocess.check_output(
    [str(args.llvm_bin / 'llvm-nm'), '-S', '--defined-only', str(binary)], text=True)
assert not any(name in symbols for name in ['fwp_gc_scan', 'fwp_gc_mark_all', 'fwp_gc_sweep'])
objects = {}
addresses = {}
for line in symbols.splitlines():
    fields = line.split()
    if len(fields) == 4:
        addresses[fields[3]] = int(fields[0], 16)
    if len(fields) == 4 and fields[3].startswith('fwp_static_function'):
        objects[fields[3]] = {'address': int(fields[0], 16), 'bytes': int(fields[1], 16),
                              'symbol_kind': fields[2]}
assert set(objects) == {name for name, _, _, _ in declarations}
captures = 0
for name, function, count, zeroes in declarations:
    count = int(count)
    assert zeroes.split(', ') == ['0'] * count
    # Two uint32_t header fields followed by count 64-bit V capture words.
    assert objects[name]['bytes'] == 8 + 8 * count, (name, objects[name], count)
    assert objects[name]['address'] % 8 == 0, (name, objects[name])
    assert objects[name]['symbol_kind'] == 'd', (name, objects[name])
    stores = re.findall(r'    ' + name + r'\.a\[(\d+)\] = PTR\(&fc(\d+)\);', code)
    assert [int(index) for index, _ in stores] == list(range(count)), (name, stores)
    objects[name].update(function=int(function), captures=[int(target) for _, target in stores])
    captures += count
sections = subprocess.check_output(
    [str(args.llvm_bin / 'llvm-size'), '--format=sysv', str(binary)], text=True)
sizes = {}
for line in sections.splitlines():
    fields = line.split()
    if len(fields) == 3 and fields[1].isdigit():
        sizes[fields[0]] = int(fields[1])
assembly = subprocess.check_output(
    [str(args.llvm_bin / 'llvm-objdump'), '-d', '--no-show-raw-insn', '--disassemble-symbols=main,fwp_main_thread',
     str(binary)], text=True)
assert '<main>:' in assembly
assert '<fwp_main_thread>:' in assembly
(directory / 'server-startup.asm').write_text(assembly)
expected = {obj['address'] + 8 + 8 * index: addresses[f'fc{target}']
            for obj in objects.values() for index, target in enumerate(obj['captures'])}
assert len(expected) == captures
# The measured Linux Clang binaries inline constant initialization immediately
# after signal setup. Check each actual stored pointer against its source recipe.
# This is a bounded straight-line inspection, not an emulator or execution.
body = assembly.split('<fwp_main_thread>:', 1)[1]
lines = body[body.rindex('<sigaction@plt>'):].splitlines()[1:]
registers, observed = {}, {}
for line in lines:
    instruction = re.match(r'\s*[0-9a-f]+:\s+(\w+)\s+(.*)', line)
    if not instruction:
        continue
    op, operands = instruction.groups()
    if op in ['bl', 'callq']:
        break
    if 'file format elf64-x86-64' in assembly:
        if op == 'leaq':
            load = re.search(r', (%\w+)\s+# (0x[0-9a-f]+)', operands)
            if load:
                registers[load[1]] = int(load[2], 16)
            else:
                # Stack addresses are outside the static objects being checked.
                registers.clear()
        elif op == 'movq' and (store := re.match(r'(%\w+), .*# (0x[0-9a-f]+)', operands)):
            address = int(store[2], 16)
            if address in expected:
                assert address not in observed and store[1] in registers, line
                observed[address] = registers[store[1]]
        else:
            # Do not carry address knowledge across unmodelled register writes.
            registers.clear()
    else:
        assert 'file format elf64-littleaarch64' in assembly
        operands = operands.split('//', 1)[0].split(' <', 1)[0].strip()
        if op == 'adrp':
            register, address = operands.split(', ')
            registers[register] = int(address, 16)
        elif op == 'add':
            register, source, offset = operands.split(', ')
            if source in registers:
                registers[register] = registers[source] + int(offset.lstrip('#'), 0)
            else:
                registers.pop(register, None)
        elif op == 'mov':
            register, source = operands.split(', ')
            if source in registers:
                registers[register] = registers[source]
            else:
                registers.pop('x' + register[1:] if register.startswith('w') else register, None)
        elif op in ['str', 'stp']:
            store = re.fullmatch(r'(x\d+)(?:, (x\d+))?, \[(x\d+)(?:, #(0x[0-9a-f]+))?\]', operands)
            if store and store[3] in registers:
                address = registers[store[3]] + (int(store[4], 16) if store[4] else 0)
                for index, source in enumerate([store[1], store[2]] if op == 'stp' else [store[1]]):
                    destination = address + 8 * index
                    if destination in expected:
                        assert destination not in observed and source in registers, line
                        observed[destination] = registers[source]
        else:
            assert op == 'movk', line
            register = operands.split(', ')[0]
            registers.pop('x' + register[1:] if register.startswith('w') else register, None)
assert observed == expected, (len(observed), len(expected), 'startup pointer stores differ from source')
report = {
    'revision': (directory / 'revision.txt').read_text().strip(),
    'method': 'Static LLVM inspection only. Object size/alignment and actual startup pointer stores are checked against generated C; main and fwp_main_thread disassembly is saved. No binary execution.',
    'binary_sha256': hashlib.sha256(binary.read_bytes()).hexdigest(),
    'source_sha256': hashlib.sha256(code.encode()).hexdigest(),
    'sections': sizes, 'file_bytes': binary.stat().st_size,
    'object_count': len(objects), 'object_bytes': sum(o['bytes'] for o in objects.values()),
    'startup_capture_stores_in_source': captures,
    'startup_capture_stores_verified_in_binary': len(observed), 'objects': objects,
}
(directory / 'fixed-function-binary-review.json').write_text(json.dumps(report, indent=2) + '\n')
print(directory.name, {key: report[key] for key in ['object_count', 'object_bytes', 'startup_capture_stores_in_source']}, flush=True)
