#!/usr/bin/env python3
"""Inspect one host's HTTP server artifacts as data; never run its binaries."""
import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--functional', type=Path, required=True,
                    help='One http-clients-HOST artifact directory')
parser.add_argument('--memory', type=Path, required=True,
                    help='The matching http-server-memory-HOST artifact directory')
parser.add_argument('--llvm-bin', type=Path, required=True)
args = parser.parse_args()
revision = (args.functional / 'revision.txt').read_text().strip()
assert revision == (args.memory / 'revision.txt').read_text().strip()
cases = [(args.functional, Path('server') / f'{mode}{opt}.exe', mode, opt,
          'server-functional') for mode in ['tracing', 'arc'] for opt in ['-O1', '-O2']]
cases += [(args.memory, Path('server-memory') / f'server-{mode}{suffix}.exe',
           mode, '-O2', 'server-memory' + suffix)
          for mode in ['tracing', 'arc'] for suffix in ['', '-measured']]
cases += [(args.memory, Path('server-memory') / f'client{suffix}.exe', 'arc',
           '-O2', 'memory-client' + suffix) for suffix in ['', '-counted']]
rows = []
for root, relative, mode, opt, workload in cases:
    binary = root / relative
    source = binary.with_suffix('.c')
    code = source.read_text()
    assert ('#define FWP_ARC_ONLY 1' in code) == (mode == 'arc')
    symbols = subprocess.check_output([str(args.llvm_bin / 'llvm-nm'), str(binary)], text=True)
    found = [name for name in ['fwp_gc_scan', 'fwp_gc_mark_all', 'fwp_gc_sweep']
             if name in symbols]
    assert bool(found) == (mode == 'tracing'), (binary, found)
    sections = subprocess.check_output(
        [str(args.llvm_bin / 'llvm-size'), '--format=sysv', str(binary)], text=True)
    sizes = {}
    for line in sections.splitlines():
        fields = line.split()
        if len(fields) == 3 and fields[1].isdigit():
            sizes[fields[0]] = int(fields[1])
    text_bytes = sum(size for name, size in sizes.items() if name in ['.text', '__text'])
    assert text_bytes > 0, sections
    command = [str(args.llvm_bin / 'llvm-objdump'), '-d', '--no-show-raw-insn', str(binary)]
    assembly = subprocess.check_output(command, text=True)
    binary.with_suffix('.asm').write_text(assembly)
    names = re.findall(r'^\w+ <([^>]+)>:', assembly, re.M)
    wrappers = re.findall(r'static V (f\d+)\([^)]*\) \{\n    return fwp_p_http2_serve', code)
    rows.append({
        'artifact': root.name, 'file': str(relative), 'revision': revision,
        'mode': mode, 'optimization': opt, 'workload': workload,
        'file_bytes': binary.stat().st_size, 'text_section_bytes': text_bytes,
        'sha256': hashlib.sha256(binary.read_bytes()).hexdigest(),
        'source_sha256': hashlib.sha256(source.read_bytes()).hexdigest(),
        'sections': sizes, 'tracing_symbols': found,
        'format': subprocess.check_output(['file', '-b', str(binary)], text=True).strip(),
        'serve_wrappers': wrappers,
        'generic_entries': len([name for name in names if re.fullmatch(r'_?e\d+', name)]),
        'relevant_symbols': [name for name in names if any(part in name for part in
                             ['w_start', 'w_handle', 'w_job_finish', 'g_call_value',
                              'g_call_drop', 'w_server_release', 'http2_serve'])],
    })
    print(relative, text_bytes, 'text-section bytes (including padding); tracing control passed', flush=True)
report = {'revision': revision, 'binaries': rows,
          'method': 'Static LLVM symbols, section sizes and disassembly; no local execution.'}
(args.memory / 'server-binary-review.json').write_text(json.dumps(report, indent=2) + '\n')
