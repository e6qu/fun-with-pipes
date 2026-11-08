#!/usr/bin/env python3
"""Check selected native buffer peers; this does not measure performance."""
import argparse
import base64
import hashlib
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
ENTRIES = ('unique', 'callback', 'scan')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--languages', nargs='+', choices=['c', 'rs', 'swift'], required=True)
    parser.add_argument('--swiftc')
    parser.add_argument('--swift-target')
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    if not args.cc or not args.rustc:
        parser.error('compiler paths must not be empty')
    if len(set(args.languages)) != len(args.languages):
        parser.error('languages must not be repeated')
    if 'swift' in args.languages:
        if not args.swiftc or not args.swift_target:
            parser.error('Swift checks require --swiftc and --swift-target')
    elif args.swiftc is not None or args.swift_target is not None:
        parser.error('Swift settings require Swift in --languages')
    executions = 0
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    commands = 0

    def run(command, timeout):
        nonlocal commands
        try:
            result = subprocess.run(command, capture_output=True, timeout=timeout)
        except subprocess.TimeoutExpired as error:
            row = dict(command=command, timedOut=True, status=None,
                       stdout=base64.b64encode(error.stdout or b'').decode(),
                       stderr=base64.b64encode(error.stderr or b'').decode())
        else:
            row = dict(command=command, timedOut=False, status=result.returncode,
                       stdout=base64.b64encode(result.stdout).decode(),
                       stderr=base64.b64encode(result.stderr).decode())
        with (folder / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(row) + '\n')
        commands += 1
        assert not row['timedOut'], row
        return result

    sources = {}
    for language in args.languages:
        raw = (ROOT / f'tests/fixtures/unique_buffer_peer.{language}').read_bytes()
        (folder / f'peer.{language}').write_bytes(raw)
        sources[language] = hashlib.sha256(raw).hexdigest()

    if 'swift' in args.languages:
        for name in ('buffer_peer_opaque.c', 'buffer_peer_opaque.h'):
            raw = (ROOT / 'tests/fixtures' / name).read_bytes()
            (folder / name).write_bytes(raw)
            sources[name] = hashlib.sha256(raw).hexdigest()

    for level in [1, 2]:
        if 'swift' in args.languages:
            barrier = folder / f'opaque-{level}.o'
            command = [args.cc, '-std=c11', f'-O{level}', '-fno-lto',
                       '-Wall', '-Wextra', '-Werror', '-c',
                       str(folder / 'buffer_peer_opaque.c'), '-o', str(barrier)]
            built = run(command, 45)
            assert built.returncode == 0 and not built.stdout and not built.stderr, (command, built)
        for language in args.languages:
            for entry_index, entry in enumerate(ENTRIES):
                source = folder / f'peer.{language}'
                executable = folder / f'peer-{language}-{entry}-{level}'
                if language == 'c':
                    command = [args.cc, '-std=c11', f'-O{level}', '-ffp-contract=off',
                               '-fno-lto', '-Wall', '-Wextra', '-Werror',
                               f'-DBUFFER_ENTRY={entry_index}', str(source), '-o', str(executable)]
                elif language == 'rs':
                    command = [args.rustc, '--edition=2021', '-C', f'opt-level={level}',
                               '-C', 'overflow-checks=yes', '-C', 'lto=off', '-C', 'codegen-units=16', '-C', 'debuginfo=0', '-C', 'panic=unwind', '-D', 'warnings',
                               '--cfg', f'buffer_entry="{entry}"', str(source), '-o', str(executable)]
                else:
                    optimization = ['-Onone'] if level == 1 else ['-O', '-whole-module-optimization']
                    command = [args.swiftc, '-swift-version', '6', *optimization,
                               '-warnings-as-errors', '-target', args.swift_target,
                               '-D', 'BUFFER_' + entry.upper(), '-import-objc-header',
                               str(folder / 'buffer_peer_opaque.h'), str(source), str(barrier),
                               '-o', str(executable)]
                built = run(command, 90)
                assert built.returncode == 0 and not built.stdout and not built.stderr, (command, built)
                cases = []
                for length in [-9223372036854775808, -1, 0, 1, 16, 4096, 262144]:
                    size = max(length, 0)
                    value = size * (size - 1) // 2 if entry == 'scan' else size * (2 if entry == 'unique' else 1)
                    for repeats in [1, 3]:
                        cases.append(([entry, str(length), str(repeats)], 0, f'{value * repeats}\n'.encode(), b''))
                cases.append(([entry, '9223372036854775807', '1'], 3, b'', b'array too large\n'))
                cases.extend([
                    ([], 2, b'', b'expected entry length repeats\n'),
                    (['invalid', '1', '1'], 2, b'', b'invalid entry\n'),
                    ([entry, '0', '0'], 2, b'', b'repeats must be positive\n'),
                    ([entry, '0', '-1'], 2, b'', b'repeats must be positive\n'),
                ])
                for other in ENTRIES:
                    if other != entry:
                        cases.append(([other, '1', '1'], 2, b'', b'invalid entry\n'))
                for text in ['', '-', '+1', ' 1', '1 ', '1x', '9223372036854775808']:
                    cases.append(([entry, text, '1'], 2, b'', b'invalid integer\n'))
                    cases.append(([entry, '1', text], 2, b'', b'invalid integer\n'))
                for arguments, status, stdout, stderr in cases:
                    out = run([str(executable), *arguments], 10)
                    assert (out.returncode, out.stdout, out.stderr) == (status, stdout, stderr), (
                        language, level, entry, arguments, out)
                    executions += 1
    (folder / 'report.json').write_text(json.dumps(dict(sourceHashes=sources, commands=commands, executions=executions), indent=2) + '\n')
    print(f'{args.languages}: {executions} result and invalid-input controls pass; '
          'C/Rust O1/O2, Swift Onone/O where selected; no timings collected')


if __name__ == '__main__':
    main()
