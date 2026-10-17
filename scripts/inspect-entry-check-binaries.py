#!/usr/bin/env python3
"""Inspect one downloaded entry-check artifact; never execute its binaries."""
import argparse
import csv
import hashlib
import json
import re
import statistics
import subprocess
from pathlib import Path

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('directory', type=Path, help='One host artifact directory')
parser.add_argument('--llvm-bin', type=Path, required=True)
args = parser.parse_args()
directory, llvm = args.directory, args.llvm_bin
rows = []
for name in ['loop', 'pipeline', 'map', 'http-client', 'http-server']:
    pair = []
    for variant in ['ordinary', 'noinline']:
        binary = directory / f'{name}-{variant}.exe'
        symbols = subprocess.check_output([str(llvm / 'llvm-nm'), str(binary)], text=True)
        assert not any(symbol in symbols for symbol in
                       ['fwp_gc_scan', 'fwp_gc_mark_all', 'fwp_gc_sweep'])
        sections = subprocess.check_output(
            [str(llvm / 'llvm-size'), '--format=sysv', str(binary)], text=True)
        text_bytes = int(re.search(r'^\.text\s+(\d+)', sections, re.M).group(1))
        assembly = subprocess.check_output(
            [str(llvm / 'llvm-objdump'), '-d', '--no-show-raw-insn', str(binary)],
            text=True)
        binary.with_suffix('.asm').write_text(assembly)
        functions = list(re.finditer(r'^([0-9a-f]+) <([^>]+)>:', assembly, re.M))
        spans = {}
        for first, second in zip(functions, functions[1:]):
            if re.fullmatch(r'e\d+', first[2]):
                spans[first[2]] = int(second[1], 16) - int(first[1], 16)
        row = {
            'program': name,
            'variant': variant,
            'file_bytes': binary.stat().st_size,
            'text_bytes': text_bytes,
            'sha256': hashlib.sha256(binary.read_bytes()).hexdigest(),
            'source_sha256': hashlib.sha256(binary.with_suffix('.c').read_bytes()).hexdigest(),
            'generic_entry_count': len(spans),
            'generic_entry_address_span_bytes': sum(spans.values()),
            'header': subprocess.check_output(['file', '-b', str(binary)], text=True).strip(),
        }
        pair.append(row)
        rows.append(row)
    change = (pair[1]['text_bytes'] / pair[0]['text_bytes'] - 1) * 100
    print(name, 'text:', pair[0]['text_bytes'], '->', pair[1]['text_bytes'],
          f'({change:.2f}%)', 'generic entries:', pair[0]['generic_entry_count'], flush=True)

with (directory / 'elapsed.tsv').open() as source:
    samples = list(csv.DictReader(source, delimiter='\t'))
summary = []
for name in ['loop', 'pipeline', 'map']:
    medians = {}
    for variant in ['ordinary', 'noinline']:
        values = [int(row['elapsed_ns']) for row in samples
                  if row['program'] == name and row['variant'] == variant]
        assert len(values) == 6, (name, variant, values)
        medians[variant] = statistics.median(values)
    ratio = medians['noinline'] / medians['ordinary']
    summary.append({'program': name, 'medians_ns': medians,
                    'noinline_over_ordinary': ratio})
    print(name, medians, ratio, flush=True)
report = {
    'revision': (directory / 'revision.txt').read_text().strip(),
    'binaries': rows,
    'timing_summary': summary,
    'method': ('Static LLVM inspection only. Generic-entry spans include alignment '
               'between named functions; .text is the complete instruction section. '
               'Timings are original runner samples, not local execution.'),
}
(directory / 'binary-review.json').write_text(json.dumps(report, indent=2) + '\n')
