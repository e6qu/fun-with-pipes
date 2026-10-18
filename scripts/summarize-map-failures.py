#!/usr/bin/env python3
"""Inspect saved map failure evidence without executing downloaded programs."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess


HOSTS = {
    'ubuntu-latest': 'elf64-x86-64',
    'ubuntu-24.04-arm': 'elf64-littleaarch64',
    'macos-15': 'mach-o arm64',
    'macos-15-intel': 'mach-o 64-bit x86-64',
    'windows-2025': 'coff-x86-64',
    'windows-11-arm': 'coff-arm64',
}


def inspect(binary, mode, kind, file_format, llvm):
    names = subprocess.check_output([str(llvm / 'llvm-nm'), str(binary)], text=True)
    symbols = {line.split()[-1].removeprefix('_')
               for line in names.splitlines() if line.split()}
    runtime = sorted(name for name in symbols if name.startswith('fwp_'))
    assert len(runtime) > 10, (binary, 'missing internal runtime names')
    tracing = sorted(symbols.intersection({'fwp_gc_scan', 'fwp_gc_mark_all', 'fwp_gc_sweep'}))
    assert bool(tracing) == (mode == 'tracing'), (binary, tracing)
    assembly = subprocess.check_output(
        [str(llvm / 'llvm-objdump'), '-d', '--no-show-raw-insn', str(binary)], text=True)
    assert 'file format ' + file_format in assembly, binary
    binary.with_suffix('.disassembly.txt').write_text(assembly)
    raw = binary.read_bytes()
    if kind == 'callbacks' and mode == 'arc':
        assert b'map callback storage leaked:' in raw, binary
    return {'file': binary.name, 'sha256': hashlib.sha256(raw).hexdigest(),
            'bytes': len(raw), 'format': file_format,
            'internal_runtime_symbols': len(runtime), 'tracing_symbols': tracing}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--audit', type=Path, required=True)
    parser.add_argument('--llvm-bin', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--head', required=True)
    args = parser.parse_args()
    audit = json.loads(args.audit.read_text())
    assert audit['head'] == args.head
    assert audit['status'] == 'completed' and len(audit['jobs']) == 6
    rows = []
    for host, file_format in HOSTS.items():
        jobs = [job for job in audit['jobs'] if job['name'] == f'map_storage ({host})']
        assert len(jobs) == 1, host
        job = jobs[0]
        assert job['conclusion'] == 'success' and job['passed'] == 11
        assert not any(job[key] for key in
                       ['failed', 'ignored', 'failed_steps', 'panic_lines'])
        directory = args.artifacts / f'map-storage-{host}'
        assert (directory / 'source.txt').read_text().strip() == audit['head']
        reference = (directory / 'interpreter.txt').read_bytes()
        assert reference.count(b'Err "expected"\n') == 4
        runs, binaries = [], []
        for mode in ['arc', 'tracing']:
            for opt in ['-O1', '-O2']:
                for poison in (['0'] if mode == 'arc' else ['0', '1']):
                    line = (directory / f'faults-{mode}{opt}-reuse-{poison}.txt').read_text().strip()
                    count = 110 if poison == '1' else 108
                    assert line == (f'22 map/set operations: {count} injected failures cleaned; '
                                    'aliases preserved'), line
                    runs.append({'mode': mode, 'optimization': opt,
                                 'reuse_verification': poison == '1',
                                 'injected_failures': count})
                assert (directory / f'callbacks-{mode}{opt}.txt').read_bytes() == reference
                assert not (directory / f'callbacks-{mode}{opt}.stderr').read_bytes()
                for kind in ['faults', 'callbacks']:
                    binaries.append(inspect(directory / f'{kind}-{mode}{opt}.bin',
                                            mode, kind, file_format, args.llvm_bin))
        controls = {name: (directory / f'{name}.txt').read_text().strip()
                    for name in ['missing-result-owner', 'missing-scratch-owner']}
        assert all(value.endswith(': 213') for value in controls.values())
        rows.append({'host': host, 'job': job['job'],
                     'settings': (directory / 'settings.txt').read_text().splitlines(),
                     'clang': (directory / 'clang.txt').read_text().strip(),
                     'rustc': (directory / 'rustc.txt').read_text().strip(),
                     'runs': runs, 'controls': controls, 'binaries': binaries,
                     'callback_outputs_match_interpreter': True,
                     'arc_shutdown_counted_bytes': 0})
        print(host, '8 binaries, 6 fault configurations, 4 callback runs, 2 controls verified')
    args.output.write_text(json.dumps({
        'source': audit['head'], 'run': audit['run'], 'complete_native_matrix': True,
        'scope': 'Failure cleanup and typed ownership, not a timing or code-size comparison. '
                 'Instrumented programs execute on native CI hosts; this collector only reads '
                 'their files. ARC counted bytes exclude allocator capacity and process RSS. '
                 'Tracing retains collector code and deliberately poisons released objects '
                 'under reuse verification.',
        'hosts': rows,
    }, indent=2) + '\n')


if __name__ == '__main__':
    main()
