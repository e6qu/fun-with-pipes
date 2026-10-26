#!/usr/bin/env python3
"""Compare ordinary wide-array sort object code and stack frames with forced copying."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('sort_storage', ROOT / 'scripts/measure-list-sort-storage.py')
STORAGE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(STORAGE)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def object_details(path, system, arch, objdump):
    raw = path.read_bytes()
    if system == 'Linux':
        assert raw[:6] == b'\x7fELF\x02\x01' and struct.unpack_from('<H', raw, 16)[0] == 1
        machine = struct.unpack_from('<H', raw, 18)[0]
        assert machine == (183 if arch == 'ARM64' else 62)
    elif system == 'macOS':
        assert raw[:4] == b'\xcf\xfa\xed\xfe' and struct.unpack_from('<I', raw, 12)[0] == 1
        machine = struct.unpack_from('<I', raw, 4)[0]
        assert machine == (0x100000c if arch == 'ARM64' else 0x1000007)
    else:
        machine = struct.unpack_from('<H', raw)[0]
        assert machine == (0xaa64 if arch == 'ARM64' else 0x8664)
        assert struct.unpack_from('<H', raw, 16)[0] == 0  # COFF object, no executable header.
    sections = subprocess.check_output([objdump, '--section-headers', '--syms', str(path)])
    assembly = subprocess.check_output([objdump, '-d', str(path)])
    sizes = re.findall(rb'^\s*\d+\s+(?:\.text|__text)\s+([0-9a-fA-F]+)\s', sections, re.M)
    assert sizes and len(assembly) > 1000
    assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_heap_(?:scan|mark_all|sweep)\b', sections)
    return dict(machine=machine, fileBytes=len(raw), textBytes=sum(int(size, 16) for size in sizes),
                binarySha256=hashlib.sha256(raw).hexdigest(),
                sectionsSha256=hashlib.sha256(sections).hexdigest(),
                disassemblySha256=hashlib.sha256(assembly).hexdigest())


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    commands = parser.add_subparsers(dest='operation', required=True)
    measure = commands.add_parser('measure')
    measure.add_argument('--program', type=Path, required=True)
    measure.add_argument('--cc', required=True)
    for command in [measure, commands.add_parser('inspect')]:
        command.add_argument('--directory', type=Path, required=True)
        command.add_argument('--source', required=True)
        command.add_argument('--system', choices=['Linux', 'macOS', 'Windows'], required=True)
        command.add_argument('--arch', choices=['X64', 'ARM64'], required=True)
        command.add_argument('--objdump', required=True)
        command.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.source)
    for name in ['scripts/measure-array-sort-layout.py', 'scripts/measure-list-sort-storage.py']:
        assert (ROOT / name).read_bytes() == subprocess.check_output(['git', 'show', args.source + ':' + name])
    runtime = subprocess.check_output(['git', 'show', args.source + ':runtime/fwp_rt_prims.c'], text=True)
    if args.operation == 'measure':
        assert os.environ['GITHUB_ACTIONS'] == 'true'
        assert not args.directory.exists() and not args.output.exists()
        args.directory.mkdir(parents=True)
        program = args.program.read_text()
        assert program.count(runtime) == 1 and '#define FWP_ARC_ONLY 1' in program
        assert '#define FWP_EXACT_FLOAT 1' in program
        (args.directory / 'program.c').write_text(program)
        rows = []
        for variant, code in STORAGE.variants(program, 'array-owned'):
            for optimization in ['-O1', '-O2']:
                label = variant + optimization
                source = args.directory / (label + '.c')
                binary = source.with_suffix('.o')
                source.write_text(code)
                command = [args.cc, '-std=gnu11', optimization, '-ffp-contract=off',
                           '-fstack-usage', '-w', '-c', str(source), '-o', str(binary)]
                subprocess.run(command, check=True, timeout=120)
                stack = source.with_suffix('.su')
                assert stack.stat().st_size > 0
                rows.append(dict(label=label, command=command, sourceSha256=digest(source),
                    stackReport=stack.read_text(), stackSha256=digest(stack),
                    **object_details(binary, args.system, args.arch, args.objdump)))
        report = dict(source=args.source, system=args.system, arch=args.arch,
            compiler=subprocess.check_output([args.cc, '--version'], text=True),
            programSha256=digest(args.directory / 'program.c'), objects=rows,
            scope='Uninstrumented ARC program with string and 128-bit sorts; reuse versus '
                  'forcing only sorting to copy. O1/O2 objects and compiler stack reports. '
                  'Objects are not linked executables; external floating-library code and '
                  'frames are excluded. No elapsed-time or peak-stack claim.')
        (args.directory / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    report = json.loads((args.directory / 'report.json').read_text())
    assert (report['source'], report['system'], report['arch']) == (args.source, args.system, args.arch)
    program = (args.directory / 'program.c').read_text()
    assert digest(args.directory / 'program.c') == report['programSha256']
    assert program.count(runtime) == 1 and '#define FWP_ARC_ONLY 1' in program
    variants = dict(STORAGE.variants(program, 'array-owned'))
    assert [row['label'] for row in report['objects']] == [v + opt for v in variants for opt in ['-O1', '-O2']]
    reviewed = []
    for row in report['objects']:
        source = args.directory / (row['label'] + '.c')
        assert source.read_text() == variants[row['label'][:-3]]
        assert digest(source) == row['sourceSha256']
        stack = source.with_suffix('.su')
        assert digest(stack) == row['stackSha256'] and stack.read_text() == row['stackReport']
        assert row['stackReport'] and row['command'][1:7] == [
            '-std=gnu11', row['label'][-3:], '-ffp-contract=off', '-fstack-usage', '-w', '-c']
        observed = object_details(source.with_suffix('.o'), args.system, args.arch, args.objdump)
        for name in ['machine', 'fileBytes', 'textBytes', 'binarySha256']:
            assert observed[name] == row[name]
        reviewed.append(dict(label=row['label'], sourceSha256=row['sourceSha256'],
                             stackReport=row['stackReport'], stackSha256=row['stackSha256'], **observed))
    assert not args.output.exists()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(dict(source=args.source, system=args.system, arch=args.arch,
        reportSha256=digest(args.directory / 'report.json'), objects=reviewed), indent=2) + '\n')
    print('Verified four ordinary wide-sort objects and their stack reports')


if __name__ == '__main__':
    main()
