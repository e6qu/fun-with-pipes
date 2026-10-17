#!/usr/bin/env python3
"""Disassemble native input clients for review; never execute the artifacts."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess


def fingerprint(path):
    data = path.read_bytes()
    return {'bytes': len(data), 'sha256': hashlib.sha256(data).hexdigest()}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--clients', nargs='+', required=True,
                        choices=['synchronous', 'bidirectional', 'retained-input', 'early-completion'])
    args = parser.parse_args()
    observations = []
    for client in args.clients:
        source = args.artifacts / (client + '.c')
        code = source.read_text()
        remotes = re.findall(r'/\* greeter\.(?:total|shout|firsts) :[^\n]*\*/\nstatic V (f\d+)\(', code)
        assert remotes, (source, 'missing generated remote entry')
        symbols = remotes + ['fwp_remote_call', 'g_iter_next', 'g_send_all', 'g_spawn_sender',
            'g_sender_peer_finish', 'g_encode_request', 'fwp_apply', 'fwp_apply_owned',
            'fwp_free_zombie', 'fwp_task_dispose', 'g_input_next', 'g_input_release']
        binaries = [path for path in [args.artifacts / client, args.artifacts / (client + '.exe')]
                    if path.is_file()]
        assert len(binaries) == 1, binaries
        binary = binaries[0]
        header = subprocess.check_output([args.objdump, '--file-headers', str(binary)], text=True)
        macho = 'mach-o' in header.lower()
        command = [args.objdump] + (['--macho', '--disassemble'] if macho else []) + [
            '--no-show-raw-insn', '--disassemble-symbols=' + ','.join(
                ('_' if macho else '') + name for name in symbols), str(binary)]
        result = subprocess.run(command, capture_output=True, text=True, check=True)
        assert re.search(r'(?:<|_)(?:g_send_all|fwp_remote_call|fwp_apply|f\d+)(?:>|:)', result.stdout), (
            binary, result.stderr)
        assembly = args.artifacts / (client + '.asm')
        assembly.write_text(result.stdout)
        observations.append({'client': client, 'source': fingerprint(source),
            'binary': fingerprint(binary), 'header': header, 'symbols': symbols,
            'command': command, 'assembly': {'file': assembly.name, **fingerprint(assembly)},
            'diagnostics': result.stderr})
        print(f'{client}: retained {assembly.name}')
    report = {'source_revision': (args.artifacts / 'source.txt').read_text().strip(),
        'tool': args.objdump, 'observations': observations,
        'limits': 'Static inspection only; no downloaded program executed. Inlined or unused helpers may have no standalone symbol. Review actual instructions for input ownership, callback dispatch, spills and frame sizes. No speed or zero-overhead claim follows from symbol names.'}
    (args.artifacts / 'binary-observations.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
