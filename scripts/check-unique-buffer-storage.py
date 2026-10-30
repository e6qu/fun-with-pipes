#!/usr/bin/env python3
"""Verify buffer allocation observers and deliberate omitted-release controls."""
import argparse
import base64
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('unique_buffer_storage', Path(__file__).with_name('unique-buffer-storage.py'))
STORAGE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(STORAGE)
ENTRIES = ('unique', 'callback', 'scan')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native-checks', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    args = parser.parse_args()
    assert args.cc and args.rustc
    args.output.mkdir(parents=True, exist_ok=False)
    results = []
    source_hashes = {}

    def run(command):
        command = list(map(str, command))
        try:
            result = subprocess.run(command, capture_output=True, timeout=45)
        except subprocess.TimeoutExpired as error:
            row = dict(command=command, timedOut=True, status=None,
                       stdout=base64.b64encode(error.stdout or b'').decode(),
                       stderr=base64.b64encode(error.stderr or b'').decode())
        else:
            row = dict(command=command, timedOut=False, status=result.returncode,
                       stdout=base64.b64encode(result.stdout).decode(),
                       stderr=base64.b64encode(result.stderr).decode())
        with (args.output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(row) + '\n')
        assert not row['timedOut'], row
        return result

    for entry_index, entry in enumerate(ENTRIES):
        fwp, sites = STORAGE.fwp((args.native_checks / f'{entry}-harness.c').read_text())
        (args.output / f'{entry}-sites.json').write_text(json.dumps(sites, indent=2) + '\n')
        sources = {'c': STORAGE.c_peer((ROOT / 'tests/fixtures/unique_buffer_peer.c').read_text()),
                   'rust': STORAGE.rust_peer((ROOT / 'tests/fixtures/unique_buffer_peer.rs').read_text()), 'fwp': fwp}
        for language, code in sources.items():
            if language == 'c':
                leaked = STORAGE.replace_once(code, '    buffer_release(values);', '    (void)buffer_release;')
            elif language == 'rust':
                leaked = STORAGE.replace_once(code, '    drop(values);', '    std::mem::forget(values);')
            else:
                start = code.index(f'/* {entry} : I64 -> I64 */')
                end = code.index('\n}', start) + 2
                release = 'fwp_drop0(l1);' if entry == 'scan' else 'fwp_mem_free((void *)(uintptr_t)l1);'
                leaked = code[:start] + STORAGE.replace_once(code[start:end], release, '(void)l1;') + code[end:]
            source_hashes[f'{entry}-{language}'] = hashlib.sha256(code.encode()).hexdigest()
            for variant, generated in [('observed', code), ('omitted-release', leaked)]:
                source = args.output / f'{entry}-{language}-{variant}.{"rs" if language == "rust" else "c"}'
                source.write_text(generated)
                for level in [1, 2]:
                    executable = args.output / f'{entry}-{language}-{variant}-O{level}'
                    if language == 'rust':
                        command = [args.rustc, '--edition=2021', '-C', f'opt-level={level}',
                                   '-C', 'overflow-checks=yes', '-C', 'lto=off', '-C', 'codegen-units=16', '-C', 'debuginfo=0', '-C', 'panic=unwind', '-D', 'warnings',
                                   '--cfg', f'buffer_entry="{entry}"', source, '-o', executable]
                    else:
                        flags = ['-w', '-lm', '-lpthread', '-ldl'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']
                        command = [args.cc, '-std=gnu11', f'-O{level}', '-ffp-contract=off', '-fno-fast-math',
                                   '-fno-lto', f'-DBUFFER_ENTRY={entry_index}', source, '-o', executable, *flags]
                    built = run(command)
                    assert (built.returncode, built.stdout, built.stderr) == (0, b'', b''), built
                    for length in ([16] if variant == 'omitted-release' else [0, 16, 4096, 262144]):
                        result = run([executable, entry, length, 3])
                        if variant == 'omitted-release':
                            assert (result.returncode, result.stdout, result.stderr) == (225, b'', b'buffer still live\n'), result
                            results.append(dict(entry=entry, language=language, level=level, variant=variant, status=225))
                            continue
                        value = length * (length - 1) // 2 if entry == 'scan' else length * (2 if entry == 'unique' else 1)
                        assert result.returncode == 0 and result.stdout == f'{value * 3}\n'.encode(), result
                        if language == 'fwp':
                            counts = STORAGE.parse_fwp(result.stderr, sites)
                            assert counts['managed']['requests'] >= 3, counts
                            if entry != 'scan':
                                assert counts['managed']['requests'] == 3, counts
                                assert all(operation['calls'] == 0 for operation in counts['operations'].values()), counts
                                assert counts['metadata']['requestedCountBytes'] == 0, counts
                            else:
                                assert counts['metadata']['requestedCountBytes'] > 0, counts
                                assert counts['operations']['fresh']['effective'] >= 3, counts
                        else:
                            counts = json.loads(result.stderr)
                            assert counts == dict(requests=3 if length else 0, requestedBytes=3 * length * 8,
                                                  peakRequestedBytes=length * 8, finalRequestedBytes=0), counts
                        results.append(dict(entry=entry, language=language, level=level, variant=variant, length=length, counts=counts))
    (args.output / 'report.json').write_text(json.dumps(dict(
        scope='Diagnostic allocation requests and ownership only; not ordinary timing or OS memory release.',
        sourceHashes=source_hashes, results=results), indent=2) + '\n')
    print(f'Storage observers: {len(results)} executions pass, including 18 omitted-release failures')


if __name__ == '__main__':
    main()
