#!/usr/bin/env python3
"""Check selected native buffer peers; this does not measure performance."""
import argparse
import base64
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
ENTRIES = ('unique', 'callback', 'scan')
NATIVE_SPEC = importlib.util.spec_from_file_location('buffer_native', ROOT / 'scripts/check-unique-buffer-native.py')
NATIVE = importlib.util.module_from_spec(NATIVE_SPEC)
NATIVE_SPEC.loader.exec_module(NATIVE)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--languages', nargs='+', choices=['c', 'rs', 'swift', 'fwp'], required=True)
    parser.add_argument('--compiler', type=Path)
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
    if 'fwp' in args.languages:
        if args.compiler is None or 'c' not in args.languages:
            parser.error('fwp checks require --compiler and c in --languages for the common harness')
    elif args.compiler is not None:
        parser.error('--compiler requires fwp in --languages')
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_STACK='1', LC_ALL='C')
    executions = 0
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    commands = 0

    def run(command, timeout):
        nonlocal commands
        command = list(map(str, command))
        try:
            result = subprocess.run(command, capture_output=True, timeout=timeout, env=environment)
        except subprocess.TimeoutExpired as error:
            row = dict(command=command, timedOut=True, status=None,
                       stdout=base64.b64encode(error.stdout or b'').decode(),
                       stderr=base64.b64encode(error.stderr or b'').decode())
        else:
            row = dict(command=command, timedOut=False, status=result.returncode,
                       stdout=base64.b64encode(result.stdout).decode(),
                       stderr=base64.b64encode(result.stderr).decode())
        row['fwpNoOpt'] = environment.get('FWP_NO_OPT')
        with (folder / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(row) + '\n')
        commands += 1
        assert not row['timedOut'], row
        return result

    sources = {}
    generated_sources = {}
    for language in [name for name in args.languages if name != 'fwp']:
        raw = (ROOT / f'tests/fixtures/unique_buffer_peer.{language}').read_bytes()
        (folder / f'original.{language}').write_bytes(raw)
        sources[language] = hashlib.sha256(raw).hexdigest()
        code = raw.decode()
        if language == 'c':
            substitutions = {
                '#include <stdint.h>': '#include <stdint.h>\n#include "buffer_peer_opaque.h"',
                'uint64_t size = length < 0 ? 0 : (uint64_t)length;': 'uint64_t size = length < 0 ? 0 : (uint64_t)length;\n    if (size > (uint64_t)PTRDIFF_MAX / sizeof(int64_t)) fail("array too large", 3);',
                '__asm__ volatile ("" : "+r" (input));': 'input = buffer_peer_opaque(input);',
                '__asm__ volatile ("" : "+r" (result));': 'result = buffer_peer_opaque(result);',
            }
        elif language == 'rs':
            substitutions = {
                'use std::hint::black_box;': '',
                '#[cfg(buffer_entry = "unique")]': 'extern "C" { fn buffer_peer_opaque(value: i64) -> i64; }\n\n#[cfg(buffer_entry = "unique")]',
                'let result = black_box(work(black_box(length)));': 'let input = unsafe { buffer_peer_opaque(length) };\n        let result = work(input);\n        let result = unsafe { buffer_peer_opaque(result) };',
            }
        else:
            substitutions = {}
        for before, after in substitutions.items():
            assert code.count(before) == 1, ('changed buffer barrier boundary', language, before)
            code = code.replace(before, after)
        (folder / f'peer.{language}').write_text(code)
        generated_sources[language] = hashlib.sha256(code.encode()).hexdigest()

    for name in ('buffer_peer_opaque.c', 'buffer_peer_opaque.h'):
        raw = (ROOT / 'tests/fixtures' / name).read_bytes()
        (folder / name).write_bytes(raw)
        sources[name] = hashlib.sha256(raw).hexdigest()
    original_barrier = (folder / 'buffer_peer_opaque.c').read_text()
    assert original_barrier.count('return value;') == 1
    # An actual wrong external result must be rejected by each language's oracle.
    (folder / 'damaged-opaque.c').write_text(original_barrier.replace('return value;', 'return value + 1;'))
    interpreter_checks = 0
    if 'fwp' in args.languages:
        compiler = args.compiler.resolve()
        sources['compiler'] = hashlib.sha256(compiler.read_bytes()).hexdigest()
        fixture = folder / 'buffer.fwp'
        fixture.write_text((ROOT / 'tests/fixtures/unique_buffer_costs.fwp').read_text()
                           + '\nexport scan : I64 -> I64\nscan = flip array.generate id | array.fold add 0\n')
        sources['fwp'] = hashlib.sha256(fixture.read_bytes()).hexdigest()
        for entry in ENTRIES:
            original = folder / f'{entry}-original.c'
            built = run([compiler, 'build', '--fn', entry, '--memory', 'dynamic',
                         '--emit-c', '-O2', fixture, '-o', original], 90)
            assert (built.returncode, built.stdout, built.stderr) == (0, b'', b''), built
            prepared = NATIVE.harness(original.read_text(), entry, (folder / 'peer.c').read_text())
            (folder / f'{entry}-fwp.c').write_text(prepared)
            generated_sources['fwp-' + entry] = hashlib.sha256(prepared.encode()).hexdigest()
            for length in [-9223372036854775808, -1, 0, 1, 16, 4096, 262144]:
                size = max(length, 0)
                expected = size * (size - 1) // 2 if entry == 'scan' else size * (2 if entry == 'unique' else 1)
                for optimize in (False, True):
                    if optimize:
                        environment.pop('FWP_NO_OPT', None)
                    else:
                        environment['FWP_NO_OPT'] = '1'
                    interpreted = run([compiler, 'exec', '--interp', fixture, entry, str(length)], 90)
                    assert (interpreted.returncode, interpreted.stdout, interpreted.stderr) == (
                        0, f'{expected}\n'.encode(), b''), interpreted
                    interpreter_checks += 1
        environment.pop('FWP_NO_OPT', None)
    barrier_controls = 0
    for level in [1, 2]:
        barrier = folder / f'opaque-{level}.o'
        damaged_barrier = folder / f'damaged-opaque-{level}.o'
        for source_name, object_path in [('buffer_peer_opaque.c', barrier), ('damaged-opaque.c', damaged_barrier)]:
            command = [args.cc, '-std=c11', f'-O{level}', '-fno-lto',
                       '-Wall', '-Wextra', '-Werror', '-c',
                       str(folder / source_name), '-o', str(object_path)]
            built = run(command, 45)
            assert built.returncode == 0 and not built.stdout and not built.stderr, (command, built)
        for language in args.languages:
            for entry_index, entry in enumerate(ENTRIES):
                source = folder / (f'{entry}-fwp.c' if language == 'fwp' else f'peer.{language}')
                executable = folder / f'peer-{language}-{entry}-{level}'
                if language == 'fwp':
                    command = [args.cc, '-std=gnu11', f'-O{level}', '-ffp-contract=off',
                               '-fno-fast-math', '-fno-lto', '-w', f'-DBUFFER_ENTRY={entry_index}',
                               str(source), str(barrier), '-o', str(executable), '-lm', '-lpthread', '-ldl']
                elif language == 'c':
                    command = [args.cc, '-std=c11', f'-O{level}', '-ffp-contract=off',
                               '-fno-lto', '-Wall', '-Wextra', '-Werror',
                               f'-DBUFFER_ENTRY={entry_index}', str(source), str(barrier), '-o', str(executable)]
                elif language == 'rs':
                    command = [args.rustc, '--edition=2021', '-C', f'opt-level={level}',
                               '-C', 'overflow-checks=yes', '-C', 'lto=off', '-C', 'codegen-units=16', '-C', 'debuginfo=0', '-C', 'panic=unwind', '-D', 'warnings',
                               '--cfg', f'buffer_entry="{entry}"', '-C', 'link-arg=' + str(barrier), str(source), '-o', str(executable)]
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
                damaged = folder / f'damaged-{language}-{entry}-{level}'
                damaged_command = [part.replace(str(barrier), str(damaged_barrier))
                                   if part != str(executable) else str(damaged) for part in command]
                built = run(damaged_command, 90)
                assert (built.returncode, built.stdout, built.stderr) == (0, b'', b''), built
                rejected = run([str(damaged), entry, '16', '1'], 10)
                assert (rejected.returncode, rejected.stdout, rejected.stderr) == (
                    4, b'', b'incorrect result\n'), rejected
                barrier_controls += 1
    (folder / 'report.json').write_text(json.dumps(dict(sourceHashes=sources, generatedSourceHashes=generated_sources,
        barrierPolicy='One separately compiled C input/result barrier, no LTO, for every selected peer',
        interpreterChecks=interpreter_checks, rejectedBarrierControls=barrier_controls, commands=commands, executions=executions), indent=2) + '\n')
    print(f'{args.languages}: {executions} result and invalid-input controls pass; '
          f'C/Rust/fwp O1/O2, Swift Onone/O where selected; {interpreter_checks} interpreter checks; no timings collected')


if __name__ == '__main__':
    main()
