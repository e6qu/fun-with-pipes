#!/usr/bin/env python3
"""Check phase boundaries and outputs without collecting baseline timings."""
import argparse
import base64
import hashlib
import importlib.util
import json
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('unique_buffer_phases', Path(__file__).with_name('unique-buffer-phases.py'))
PHASES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PHASES)
ENTRIES = ('unique', 'callback', 'scan')
FIELDS = {'constructionNs', 'readsNs', 'releaseNs', 'tailNs'}


def validate(result, expected, calls, fields):
    assert result.returncode == 0 and result.stdout == f'{expected * calls}\n'.encode(), result
    events = [json.loads(line) for line in result.stderr.splitlines()]
    assert len(events) == calls, events
    for event in events:
        assert set(event) == fields, event
        assert all(type(value) is int and 0 <= value < 2**63 for value in event.values()), event
    return events


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--native-checks', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--scan-storage', choices=['materialized', 'elided'], required=True)
    args = parser.parse_args()
    assert args.cc and args.rustc
    args.output.mkdir(parents=True, exist_ok=False)
    original_report = args.native_checks / 'report.json'
    assert original_report.is_file()
    sources = {'c': (ROOT / 'tests/fixtures/unique_buffer_peer.c').read_text(),
               'rust': (ROOT / 'tests/fixtures/unique_buffer_peer.rs').read_text()}
    checks = 0
    inputs = {}

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
        sources['fwp'] = (args.native_checks / f'{entry}-harness.c').read_text()
        transformed = {'c': PHASES.c_peer(sources['c']),
                       'rust': PHASES.rust_peer(sources['rust']),
                       'fwp': PHASES.fwp(sources['fwp'], entry, args.scan_storage)}
        for language, code in transformed.items():
            fields = {'computationNs'} if (entry, language, args.scan_storage) == ('scan', 'fwp', 'elided') else FIELDS
            inputs[f'{entry}-{language}'] = hashlib.sha256(sources[language].encode()).hexdigest()
            source = args.output / f'{entry}-{language}.{"rs" if language == "rust" else "c"}'
            source.write_text(code)
            for level in [1, 2]:
                executable = args.output / f'{entry}-{language}-O{level}'
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
                for length in [-1, 0, 16, 4096, 262144]:
                    size = max(0, length)
                    expected = size * (size - 1) // 2 if entry == 'scan' else size * (2 if entry == 'unique' else 1)
                    result = run([executable, entry, length, 3])
                    validate(result, expected, 3, fields)
                    # A missing event or changed result must invalidate observations.
                    for stdout, stderr in [(b'999\n', result.stderr),
                                           (result.stdout, b'\n'.join(result.stderr.splitlines()[1:]))]:
                        try:
                            validate(subprocess.CompletedProcess([], 0, stdout, stderr), expected, 3, fields)
                        except AssertionError:
                            pass
                        else:
                            raise AssertionError('damaged phase result accepted')
                    checks += 1
    (args.output / 'report.json').write_text(json.dumps(dict(
        scope='Observer correctness only; these clocks are not production performance evidence.',
        scanStorage=args.scan_storage,
        nativeReportSha256=hashlib.sha256(original_report.read_bytes()).hexdigest(),
        inputHashes=inputs, executions=checks, events=checks * 3, rejectedDamagedResults=checks * 2), indent=2) + '\n')
    print(f'Phase observers: {checks} executions, {checks * 3} events and {checks * 2} damaged-result rejections pass')


if __name__ == '__main__':
    main()
