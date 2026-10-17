#!/usr/bin/env python3
"""Disassemble measured server workloads for review; never run the binaries."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess


def fingerprint(path):
    data = path.read_bytes()
    return {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--workloads', nargs='+', required=True,
                        choices=['unary-strings', 'response-stream', 'request-stream', 'channel-output'])
    args = parser.parse_args()
    symbols = ['g_handle', 'g_start_call', 'g_job_peer_finish', 'g_run_method',
               'g_apply_user', 'g_iter_next', 'g_recv_one', 'g_finish',
               'fwp_free_zombie', 'fwp_task_dispose', 'fwp_apply', 'fwp_apply_owned']
    observations = []
    for mode in args.workloads:
        source = args.artifacts / (mode + '-server.c')
        binaries = [p for p in [args.artifacts / (mode + '-server'),
                    args.artifacts / (mode + '-server.exe')] if p.is_file()]
        assert len(binaries) == 1, binaries
        binary = binaries[0]
        header = subprocess.check_output([args.objdump, '--file-headers', str(binary)], text=True)
        macho = 'mach-o' in header.lower()
        command = [args.objdump] + (['--macho', '--disassemble'] if macho else []) + [
            '--no-show-raw-insn', '--disassemble-symbols=' + ','.join(
                ('_' if macho else '') + name for name in symbols), str(binary)]
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        assert '<g_handle>:' in result.stdout or '_g_handle:' in result.stdout, result.stderr
        assembly = args.artifacts / (mode + '-server.asm')
        assembly.write_text(result.stdout)
        observations.append({'workload': mode, 'source': fingerprint(source),
            'binary': fingerprint(binary), 'header': header, 'command': command,
            'assembly': {'file': assembly.name, **fingerprint(assembly)},
            'diagnostics': result.stderr})
        print(f'{mode}: retained {assembly.name}')
    report = {'source_revision': (args.artifacts / 'source.txt').read_text().strip(),
        'tool': args.objdump, 'observations': observations,
        'limits': 'Static inspection of ordinary native server binaries, without measurement hooks. No downloaded program executed. Inlined helpers may lack standalone symbols; inspect instructions, ownership operations and register/stack use. No timing or zero-overhead claim follows from symbols.'}
    (args.artifacts / 'binary-observations.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
