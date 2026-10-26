#!/usr/bin/env python3
"""Inspect downloaded artifacts as data; never execute the runner binaries."""
import argparse
import hashlib
import json
import re
import subprocess
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--artifacts', type=Path, required=True)
parser.add_argument('--llvm-bin', type=Path, required=True,
                    help='Directory containing llvm-nm, llvm-size and llvm-objdump.')
args = parser.parse_args()
root, llvm = args.artifacts, args.llvm_bin
rows = []
folders = sorted(root.glob('http-clients-*'))
assert len(folders) == 6, 'expected all six native host artifacts'
for folder in folders:
    revision = (folder / 'revision.txt').read_text().strip()
    cases = [(mode, opt, folder / f'{mode}{opt}.exe', 'functional')
             for mode in ['counted'] for opt in ['-O1', '-O2']]
    cases += [(mode, '-O2', folder / 'memory' / f'{mode}{suffix}.exe', 'repeated' + suffix)
              for mode in ['counted'] for suffix in ['', '-measured']]
    for mode, opt, path, workload in cases:
        symbols = subprocess.check_output([str(llvm / 'llvm-nm'), str(path)], text=True)
        found = [name for name in ['fwp_heap_scan', 'fwp_heap_mark_all', 'fwp_heap_sweep'] if name in symbols]
        assert not found, (path, found)
        sections = subprocess.check_output([str(llvm / 'llvm-size'), '--format=sysv', str(path)], text=True)
        sections = sections.replace(str(path), str(path.relative_to(folder)))
        header = subprocess.check_output(['file', '-b', str(path)], text=True)
        disassembly = subprocess.check_output([str(llvm / 'llvm-objdump'), '-d', '--no-show-raw-insn', str(path)], text=True)
        path.with_suffix('.asm').write_text(disassembly)
        named = re.findall(r'^\w+ <([^>]+)>:', disassembly, re.M)
        source = path.with_suffix('.c').read_text()
        entry = re.search(r'static V (f\d+)\([^)]*\) \{\n    return fwp_p_http2_send', source)
        assert entry, path
        rows.append(dict(host=folder.name.removeprefix('http-clients-'), revision=revision,
                         mode=mode, optimization=opt, workload=workload, file=str(path.relative_to(folder)),
                         file_bytes=path.stat().st_size, sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                         tracing_symbols=found, sections=sections, format=header, http_entry=entry.group(1),
                         relevant_functions=[name for name in named if any(part in name for part in
                             ['http2_send', 'g_call_release', 'g_conn_drop', 'g_reader', 'g_writer'])]))
    print(folder.name, ': four binaries inspected; collector symbols absent', flush=True)
assert len(rows) == 24, len(rows)
(root / 'binary-review.json').write_text(json.dumps(rows, indent=2) + '\n')
