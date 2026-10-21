#!/usr/bin/env python3
"""Record native cancellation-storage binaries; run on the producing CI host."""

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
args = parser.parse_args()
root = args.input
system = os.environ['RUNNER_OS']
architecture = os.environ['RUNNER_ARCH']
assert architecture in {'X64', 'ARM64'}, architecture
assert os.environ['FWP_LTO'] == '0'
host_commands = {
    'Linux': ['lscpu'],
    'macOS': ['sysctl', 'machdep.cpu', 'hw.memsize'],
    'Windows': ['pwsh', '-NoProfile', '-Command',
                'Get-CimInstance Win32_Processor | Format-List Name,Architecture,NumberOfCores,NumberOfLogicalProcessors'],
}
inspection_commands = {
    'Linux': {'assembly': ['objdump', '-d'], 'sections': ['size', '-A']},
    'macOS': {'assembly': ['otool', '-tvV'], 'sections': ['size', '-m']},
    'Windows': {'assembly': ['llvm-objdump', '-d'], 'sections': ['llvm-size', '-A']},
}
report = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
              os=system, architecture=architecture, platform=platform.platform(),
              cpu=subprocess.check_output(host_commands[system], text=True),
              compilation=dict(compiler=os.environ['CC'], fwp_optimization='O1',
                  native_optimizations=['-O0', '-O2'], link_time_optimization=False,
                  flags=['-std=gnu11', '-ffp-contract=off', '-w'],
                  runtime_libraries=['-lm', '-lws2_32', '-lshell32'] if system == 'Windows'
                                    else ['-lm', '-lpthread']), binaries={})
expected = {
    f'{memory}-{layout}{opt}'
    for memory in ['arc', 'tracing']
    for layout in ['heap', 'stack']
    for opt in ['-O0', '-O2']
} | {
    f'{memory}-{control}-O2'
    for memory in ['arc', 'tracing']
    for control in ['verified', 'missing-clear', 'missing-entry']
}
if system == 'Windows':
    expected |= {f'windows-context/abi-{variant}-O{opt}'
                 for variant in ['arc', 'restored-snapshot'] for opt in range(3)}
    expected |= {f'windows-context/cost-{variant}-O{opt}'
                 for variant in ['snapshot', 'arc'] for opt in [0, 2]}
    report['compilation']['windows_abi_native_optimizations'] = ['-O0', '-O1', '-O2']
for binary in sorted(root.rglob('*.exe')):
    label = binary.relative_to(root).with_suffix('').as_posix()
    assert label in expected, label
    data = binary.read_bytes()
    if system == 'Linux':
        assert data[:6] == b'\x7fELF\x02\x01', label
        machine = struct.unpack_from('<H', data, 18)[0]
        assert machine == {'X64': 62, 'ARM64': 183}[architecture], (label, machine)
    elif system == 'macOS':
        assert data[:4] == b'\xcf\xfa\xed\xfe', label
        machine = struct.unpack_from('<I', data, 4)[0]
        assert machine == {'X64': 0x1000007, 'ARM64': 0x100000c}[architecture], (label, machine)
    else:
        assert data[:2] == b'MZ', label
        offset = struct.unpack_from('<I', data, 60)[0]
        assert data[offset:offset + 4] == b'PE\0\0', label
        machine = struct.unpack_from('<H', data, offset + 4)[0]
        assert machine == {'X64': 0x8664, 'ARM64': 0xaa64}[architecture], (label, machine)
    outputs = {}
    for kind, command in inspection_commands[system].items():
        output = subprocess.check_output([*command, str(binary)])
        root.joinpath(f'{label}.{kind}').write_bytes(output)
        outputs[kind] = dict(command=command, sha256=hashlib.sha256(output).hexdigest())
    status = root.joinpath(f'{label}.status').read_text().strip()
    desired = (211 if 'restored-snapshot' in label else
               195 if 'missing-clear' in label else 194 if 'missing-entry' in label else 0)
    assert status == f'Some({desired})', (label, status)
    stderr = root.joinpath(f'{label}.stderr').read_text()
    report['binaries'][label] = dict(
        machine=machine, bytes=len(data), sha256=hashlib.sha256(data).hexdigest(),
        c_sha256=hashlib.sha256(binary.with_suffix('.c').read_bytes()).hexdigest(),
        status=desired, stderr=stderr, inspection=outputs)
root.joinpath('inspection.json').write_text(json.dumps(report, indent=2) + '\n')
assert set(report['binaries']) == expected, sorted(expected - set(report['binaries']))
print(f'Inspected {len(expected)} native binaries on {system} {architecture}')
