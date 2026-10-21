#!/usr/bin/env python3
"""Inspect executed task-owner probes on their producing native CI host."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import struct
import subprocess

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
args = parser.parse_args()
root = args.input
system = os.environ['RUNNER_OS']
architecture = os.environ['RUNNER_ARCH']
assert architecture in {'X64', 'ARM64'}
assert os.environ['FWP_LTO'] == '0'
commands = {
    'Linux': {'cpu': ['lscpu'], 'assembly': ['objdump', '-d'],
              'sections': ['size', '-A'], 'symbols': ['nm']},
    'macOS': {'cpu': ['sysctl', 'machdep.cpu', 'hw.memsize'],
              'assembly': ['otool', '-tvV'], 'sections': ['size', '-m'], 'symbols': ['nm']},
    'Windows': {'cpu': ['pwsh', '-NoProfile', '-Command',
                       'Get-CimInstance Win32_Processor | Format-List Name,Architecture,NumberOfCores,NumberOfLogicalProcessors'],
                'assembly': ['llvm-objdump', '-d'], 'sections': ['llvm-size', '-A'],
                'symbols': ['llvm-nm']},
}[system]
expected = {f'task-handles-{memory}-O{opt}': 0
            for memory in ['arc', 'tracing'] for opt in [0, 2]}
expected.update({f'task-handles-arc-O{opt}-missing-queue-owner': 201 for opt in [0, 2]})
expected.update({f'callback-transfer/{memory}-O{opt}-{variant}': 0
                 for memory in ['arc', 'tracing'] for opt in [0, 2]
                 for variant in ['transfer', 'redundant-pair']})
expected.update({f'clock-owners/{memory}-O{opt}-{variant}': status
                 for memory in ['arc', 'tracing'] for opt in [0, 2]
                 for variant, status in [('protected', 0), ('missing-owner', 3)]})
expected.update({f'await-fields/{memory}-O{opt}-{variant}': 0
                 for memory in ['arc', 'tracing'] for opt in [0, 2]
                 for variant in ['fields', 'boxed-control']})
expected.update({f'interop-buffers/{variant}-O{opt}': status
                 for opt in [0, 2] for variant, status in [('released', 0), ('missing-free', 211)]})
observed = {p.relative_to(root).with_suffix('').as_posix() for p in root.rglob('*.exe')
            if p.relative_to(root).as_posix().startswith(
                ('task-handles-', 'callback-transfer/', 'clock-owners/', 'await-fields/', 'interop-buffers/'))}
assert observed == set(expected), (sorted(set(expected) - observed), sorted(observed - set(expected)))
report = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
              os=system, architecture=architecture, platform=platform.platform(),
              cpu=subprocess.check_output(commands['cpu'], text=True),
              compilation=dict(compiler=os.environ['CC'], fwp_optimization='O1',
                  native_optimizations=['-O0', '-O2'], link_time_optimization=False,
                  flags=['-std=gnu11', '-ffp-contract=off', '-w'],
                  runtime_libraries=['-lm', '-lws2_32', '-lshell32'] if system == 'Windows'
                                    else ['-lm', '-lpthread']), binaries={})
for label, expected_status in sorted(expected.items()):
    binary = root / (label + '.exe')
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
    code = binary.with_suffix('.c').read_bytes()
    arc = label.startswith('task-handles-arc-') or '/arc-' in label
    assert (b'#define FWP_ARC_ONLY 1' in code) == arc, label
    assert binary.with_suffix('.status').read_text().strip() == f'Some({expected_status})', label
    outputs = {}
    for kind in ['assembly', 'sections', 'symbols']:
        output = subprocess.check_output([*commands[kind], str(binary)])
        binary.with_suffix('.' + kind).write_bytes(output)
        outputs[kind] = dict(command=commands[kind], sha256=hashlib.sha256(output).hexdigest())
        if kind == 'symbols' and arc:
            assert all(name not in output for name in [b'fwp_gc_scan', b'fwp_gc_mark_all', b'fwp_gc_sweep']), label
    stdout = binary.with_suffix('.stdout').read_bytes()
    stderr = binary.with_suffix('.stderr').read_bytes()
    record = dict(machine=machine, bytes=len(data), sha256=hashlib.sha256(data).hexdigest(),
                  c_sha256=hashlib.sha256(code).hexdigest(), status=expected_status,
                  stdout_sha256=hashlib.sha256(stdout).hexdigest(),
                  stderr_sha256=hashlib.sha256(stderr).hexdigest(), inspection=outputs)
    if label.startswith(('callback-transfer/', 'await-fields/')):
        counter = 'callback-pairs' if label.startswith('callback-transfer/') else 'await-boxes'
        lines = stderr.decode().splitlines()
        assert len(lines) == 2 and lines[0].startswith('client-memory\t')
        counts = [int(n) for n in lines[0].split('\t')[1:]]
        assert len(counts) == 6 and lines[1].startswith(counter + '\t')
        record['counters'] = dict(zip(['allocation_requests', 'requested_bytes', 'retains',
                                      'peak_managed_charge', 'final_managed_charge', 'collections'], counts, strict=True))
        record['restored_pairs' if counter == 'callback-pairs' else 'restored_boxes'] = int(lines[1].split('\t')[1])
        if arc:
            assert counts[4:] == [0, 0], (label, counts)
    else:
        assert not stderr, label
        if label.startswith('clock-owners/'):
            assert not stdout, label
        elif label.startswith('interop-buffers/'):
            assert stdout == Path('tests/run/ffi.out').read_bytes(), label
        elif expected_status == 0:
            assert stdout == b'task captures released\n', label
    report['binaries'][label] = record
for memory in ['arc', 'tracing']:
    for opt in [0, 2]:
        before = report['binaries'][f'callback-transfer/{memory}-O{opt}-redundant-pair']
        after = report['binaries'][f'callback-transfer/{memory}-O{opt}-transfer']
        assert before['restored_pairs'] > 0 and after['restored_pairs'] == 0
        assert before['stdout_sha256'] == after['stdout_sha256']
        for key, value in after['counters'].items():
            expected_value = value + before['restored_pairs'] if key == 'retains' else value
            assert before['counters'][key] == expected_value, (memory, opt, key)
        boxed = report['binaries'][f'await-fields/{memory}-O{opt}-boxed-control']
        fields = report['binaries'][f'await-fields/{memory}-O{opt}-fields']
        assert boxed['restored_boxes'] == 34 and fields['restored_boxes'] == 0
        assert boxed['stdout_sha256'] == fields['stdout_sha256']
        assert boxed['counters']['allocation_requests'] - fields['counters']['allocation_requests'] == 34
        assert boxed['counters']['requested_bytes'] > fields['counters']['requested_bytes']
        assert boxed['counters']['retains'] == fields['counters']['retains']
        assert boxed['counters']['collections'] == fields['counters']['collections']
root.joinpath('task-owner-inspection.json').write_text(json.dumps(report, indent=2) + '\n')
print(f'Inspected {len(expected)} executed task-owner binaries on {system} {architecture}')
