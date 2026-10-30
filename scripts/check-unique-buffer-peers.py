#!/usr/bin/env python3
"""Check peer results and argument errors; this does not measure performance."""
import argparse
from pathlib import Path
import subprocess
import tempfile

ROOT = Path(__file__).resolve().parent.parent
ENTRIES = ('unique', 'callback', 'scan')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    args = parser.parse_args()
    if not args.cc or not args.rustc:
        parser.error('compiler paths must not be empty')
    executions = 0
    with tempfile.TemporaryDirectory(prefix='fwp-buffer-peers-') as scratch:
        folder = Path(scratch)
        for level in [1, 2]:
            for language in ['c', 'rs']:
                for entry_index, entry in enumerate(ENTRIES):
                    source = ROOT / f'tests/fixtures/unique_buffer_peer.{language}'
                    executable = folder / f'peer-{language}-{entry}-{level}'
                    if language == 'c':
                        command = [args.cc, '-std=c11', f'-O{level}', '-ffp-contract=off',
                                   '-fno-lto', '-Wall', '-Wextra', '-Werror',
                                   f'-DBUFFER_ENTRY={entry_index}', str(source), '-o', str(executable)]
                    else:
                        command = [args.rustc, '--edition=2021', '-C', f'opt-level={level}',
                                   '-C', 'overflow-checks=yes', '-C', 'lto=off', '-D', 'warnings',
                                   '--cfg', f'buffer_entry="{entry}"', str(source), '-o', str(executable)]
                    built = subprocess.run(command, capture_output=True, timeout=45)
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
                        out = subprocess.run([str(executable), *arguments], capture_output=True, timeout=10)
                        assert (out.returncode, out.stdout, out.stderr) == (status, stdout, stderr), (
                            language, level, entry, arguments, out)
                        executions += 1
    print(f'C/Rust peers: {executions} O1/O2 result and invalid-input controls pass; no timings collected')


if __name__ == '__main__':
    main()
