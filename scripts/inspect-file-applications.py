#!/usr/bin/env python3
"""Record native file-application code and separate memory observations on CI."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import struct
import subprocess

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', required=True, type=Path)
parser.add_argument('--mode', required=True, choices=['collect', 'reinspect'])
parser.add_argument('--program-source', required=True)
args = parser.parse_args()
root = args.input
system = os.environ['RUNNER_OS']
architecture = os.environ['RUNNER_ARCH']
assert system in {'Linux', 'macOS', 'Windows'}
assert architecture in {'X64', 'ARM64'}
assert os.environ['FWP_LTO'] == '0'
commands = {
    'Linux': {'assembly': ['objdump', '-d'], 'sections': ['size', '-A']},
    'macOS': {'assembly': ['otool', '-tvV'], 'sections': ['size', '-m']},
    'Windows': {'assembly': ['llvm-objdump', '-d'], 'sections': ['llvm-size', '-A']},
}
collector_source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip()
original = None
if args.mode == 'reinspect':
    original = json.loads(root.joinpath('inspection.json').read_text(encoding='utf-8'))
    assert original['source'] == args.program_source
    assert original['os'] == system and original['architecture'] == architecture
    # Preserve the original execution/toolchain metadata. These binaries are
    # inspected again, not rebuilt or executed on the report-generation host.
    report = {key: value for key, value in original.items() if key not in {'binaries', 'observations', 'executions'}}
    report.update(binaries={}, observations={}, executions={})
else:
    assert args.program_source == collector_source
    report = dict(source=args.program_source,
        os=system, architecture=architecture, platform=platform.platform(),
        compiler=subprocess.check_output([os.environ['CC'], '--version'], text=True),
        rust=subprocess.check_output(['rustc', '-Vv'], text=True),
        optimization=dict(fwp='O1', native=['-O1', '-O2'], lto=False),
        scope='Cleanup checks, not timing comparisons. RSS includes allocator pages and observer overhead.',
        binaries={}, observations={}, executions={})
report['inspection_source'] = collector_source
report['inspection_mode'] = args.mode
report['rss_source'] = {'Linux': '/proc/PID/status VmRSS', 'macOS': 'ps -o rss=',
                        'Windows': 'K32GetProcessMemoryInfo WorkingSetSize / 1024'}[system]
variants_by_program = {
    'directory': ['measured', 'missing-release', 'missing-close'],
    **{name: ['measured', 'missing-release', 'missing-close', 'missing-buffer-free']
       for name in ['wc', 'grep', 'csv']},
    'todo': ['measured', 'missing-release', 'missing-close', 'missing-buffer-free', 'missing-write-close'],
}
expected = {f'{program}-{variant}-O{opt}'
            for program, variants in variants_by_program.items()
            for variant in variants for opt in [1, 2]}
for binary in sorted(root.glob('*.bin')):
    label = binary.stem
    assert label in expected, label
    data = binary.read_bytes()
    if system == 'Linux':
        assert data[:6] == b'\x7fELF\x02\x01'
        machine = struct.unpack_from('<H', data, 18)[0]
        assert machine == {'X64': 62, 'ARM64': 183}[architecture]
    elif system == 'macOS':
        assert data[:4] == b'\xcf\xfa\xed\xfe'
        machine = struct.unpack_from('<I', data, 4)[0]
        assert machine == {'X64': 0x1000007, 'ARM64': 0x100000c}[architecture]
    else:
        assert data[:2] == b'MZ'
        offset = struct.unpack_from('<I', data, 60)[0]
        assert data[offset:offset + 4] == b'PE\0\0'
        machine = struct.unpack_from('<H', data, offset + 4)[0]
        assert machine == {'X64': 0x8664, 'ARM64': 0xaa64}[architecture]
    inspection = {}
    for kind, command in commands[system].items():
        output = subprocess.check_output([*command, str(binary)])
        root.joinpath(f'{label}.{kind}').write_bytes(output)
        inspection[kind] = dict(command=command, sha256=hashlib.sha256(output).hexdigest())
    report['binaries'][label] = dict(machine=machine, bytes=len(data),
        sha256=hashlib.sha256(data).hexdigest(),
        c_sha256=hashlib.sha256(binary.with_suffix('.c').read_bytes()).hexdigest(),
        inspection=inspection)
assert set(report['binaries']) == expected, sorted(expected - set(report['binaries']))
if original is not None:
    assert set(original['binaries']) == expected
    for name, binary in report['binaries'].items():
        for key in ['machine', 'bytes', 'sha256', 'c_sha256']:
            assert binary[key] == original['binaries'][name][key], (name, key)
for program, sizes in [('directory', [64, 1024]), *[(name, [128, 4096]) for name in ['wc', 'grep', 'csv', 'todo']]]:
    for size in sizes:
        for opt in [1, 2]:
            label = f'{program}-{size}-measured-O{opt}'
            for variant in variants_by_program[program]:
                execution = f'{program}-{size}-{variant}-O{opt}'
                files = {kind: root.joinpath(f'{execution}.{kind}').read_bytes()
                         for kind in ['stdout', 'stderr', 'status']}
                status = files['status'].decode('ascii')
                assert status == ('0' if variant == 'measured' else '241'), (execution, status)
                if variant != 'measured':
                    assert b'file-memory changed' in files['stderr'], execution
                report['executions'][execution] = dict(status=int(status),
                    sha256={kind: hashlib.sha256(data).hexdigest() for kind, data in files.items()})
            lines = root.joinpath(label + '.stderr').read_text(encoding='utf-8').splitlines()
            assert len(lines) == 193 and lines[-1] == 'file-final\t0\t0\t0'
            charge = {}
            for index, line in enumerate(lines[:-1]):
                kind, phase, remaining, managed, handles, scratch = line.split('\t')
                assert kind == 'file-memory' and int(phase) == index // 64
                assert int(remaining) == 64 - index % 64
                assert handles == scratch == '0'
                assert charge.setdefault(phase, int(managed)) == int(managed)
            rss_lines = root.joinpath(label + '.rss.tsv').read_text(encoding='utf-8').splitlines()
            assert rss_lines[0] == 'phase\tremaining\trss_kib' and len(rss_lines) == 10
            samples = [list(map(int, line.split('\t'))) for line in rss_lines[1:]]
            assert [(p, r) for p, r, _ in samples] == [(p, r) for p in range(3) for r in [64, 32, 1]]
            assert all(rss > 0 for _, _, rss in samples)
            report['observations'][label] = dict(managed_charge_by_phase=charge,
                open_directory_and_file_handles=0, file_read_scratch_bytes=0, rss_samples=samples,
                stdout=root.joinpath(label + '.stdout').read_text(encoding='utf-8'))
if original is not None:
    assert report['executions'] == original['executions']
    assert report['observations'] == original['observations']
root.joinpath('inspection.json').write_text(json.dumps(report, indent=2) + '\n', encoding='utf-8')
print(f"Inspected {len(expected)} native binaries and {len(report['observations'])} memory series and {len(report['executions'])} executions on {system} {architecture}")
