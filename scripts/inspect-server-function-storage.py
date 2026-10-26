#!/usr/bin/env python3
"""Inspect actual fixed-function bytes in saved native HTTP server binaries."""
import argparse
import hashlib
import json
import re
import struct
import subprocess
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--artifact', type=Path, required=True)
parser.add_argument('--llvm-bin', type=Path, required=True)
args = parser.parse_args()
rows = []
for mode in ['arc', 'tracing']:
    binary = args.artifact / 'server-memory' / f'server-{mode}.exe'
    source = binary.with_suffix('.c')
    code = source.read_text()
    assert ('#define FWP_ARC_ONLY 1' in code) == (mode == 'arc')
    declarations = re.findall(
        r'^static fwp_clo (fwp_static_function\d+) = \{(\d+), (\d+), \{([0, ]+)\}\};$', code, re.M)
    assert declarations
    format_name = subprocess.check_output(['file', '-b', str(binary)], text=True).strip()
    if format_name.startswith('Mach-O 64-bit'):
        section = '__data'
    else:
        assert format_name.startswith(('ELF 64-bit LSB', 'PE32+ executable')), format_name
        section = '.data'
    symbols = subprocess.check_output([str(args.llvm_bin / 'llvm-nm'), '-n', str(binary)], text=True)
    addresses = {}
    for line in symbols.splitlines():
        fields = line.split()
        if len(fields) == 3 and re.fullmatch(r'[0-9a-fA-F]+', fields[0]):
            addresses[fields[2].removeprefix('_')] = int(fields[0], 16)
    tracing = [name for name in ['fwp_heap_scan', 'fwp_heap_mark_all', 'fwp_heap_sweep'] if name in addresses]
    assert bool(tracing) == (mode == 'tracing'), (binary, tracing)
    contents = subprocess.check_output(
        [str(args.llvm_bin / 'llvm-objdump'), '-s', '--section=' + section, str(binary)], text=True)
    data = {}
    for line in contents.splitlines():
        fields = line.split()
        if len(fields) < 2 or not re.fullmatch(r'[0-9a-fA-F]+', fields[0]):
            continue
        address = int(fields[0], 16)
        for field in fields[1:5]:
            if not re.fullmatch(r'(?:[0-9a-fA-F]{2}){1,4}', field):
                break
            for byte in bytes.fromhex(field):
                assert address not in data
                data[address] = byte
                address += 1
    objects, occupied = [], set()
    for name, function, count, zeroes in declarations:
        count = int(count)
        assert zeroes.split(', ') == ['0'] * count
        address = addresses[name]
        assert address % 8 == 0, (name, address)
        expected = struct.pack('<II', int(function), count) + bytes(8 * count)
        slots = set(range(address, address + len(expected)))
        assert not occupied.intersection(slots), name
        occupied.update(slots)
        actual = bytes(data[offset] for offset in range(address, address + len(expected)))
        assert actual == expected, (binary, name, actual.hex(), expected.hex())
        objects.append({'name': name, 'address': address, 'bytes': len(actual), 'initial_bytes': actual.hex()})
    sizes_text = subprocess.check_output(
        [str(args.llvm_bin / 'llvm-size'), '--format=sysv', str(binary)], text=True)
    sizes = {}
    for line in sizes_text.splitlines():
        fields = line.split()
        if len(fields) == 3 and fields[1].isdigit():
            sizes[fields[0]] = int(fields[1])
    rows.append({'mode': mode, 'format': format_name, 'sha256': hashlib.sha256(binary.read_bytes()).hexdigest(),
                 'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
                 'file_bytes': binary.stat().st_size, 'sections': sizes, 'tracing_symbols': tracing,
                 'object_count': len(objects), 'object_bytes': len(occupied), 'objects': objects})
    print(args.artifact.name, mode, len(objects), 'objects;', len(occupied), 'verified bytes', flush=True)
(args.artifact / 'function-storage-review.json').write_text(json.dumps({
    'revision': (args.artifact / 'revision.txt').read_text().strip(),
    'method': 'Static LLVM inspection only. Check real header/capture bytes, alignment and nonoverlap; ARC excludes tracing symbols and the tracing control retains them. Initial zero capture words are filled during startup; Linux startup instructions are checked separately. No binary execution.',
    'binaries': rows,
}, indent=2) + '\n')
