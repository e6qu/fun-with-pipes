#!/usr/bin/env python3
"""Verify strict memory parsing; optionally run Linux checkpoint programs."""
import argparse
import base64
import importlib.util
import json
from pathlib import Path
import platform
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('buffer_process_memory', Path(__file__).with_name('unique-buffer-process-memory.py'))
MEMORY = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEMORY)
ENTRIES = ('unique', 'callback', 'scan')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--mode', choices=['parser', 'linux'], required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--native-checks', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert args.cc and args.rustc
    if args.mode == 'linux':
        assert platform.system() == 'Linux'
    args.output.mkdir(parents=True, exist_ok=False)
    helper = (ROOT / 'tests/fixtures/unique_buffer_process_memory.c').read_text()
    helper_path = args.output / 'memory.c'
    helper_path.write_text(helper)

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

    def build(command):
        result = run(command)
        assert (result.returncode, result.stdout, result.stderr) == (0, b'', b''), result

    parser_source = args.output / 'parse.c'
    parser_source.write_text(helper + r'''
int main(int argc, char **argv) {
    if (argc != 2) return 95;
    printf("%" PRIu64 "\n", buffer_memory_field(argv[1], "Rss"));
    return 0;
}
''')
    invalid = ['Other: 12 kB\n', 'Rss: -1 kB\n', 'Rss: +1 kB\n', 'Rss: 12\n',
               'Rss: 12 MB\n', 'Rss: 12 kB', 'Rss: 12 kB\nRss: 12 kB\n',
               'Rss: 18446744073709551616 kB\n', 'Rss: 12.5 kB\n', 'Rss: kB\n']
    parsed = 0
    for level in [1, 2]:
        executable = args.output / f'parse-O{level}'
        build([args.cc, '-std=gnu11', f'-O{level}', '-Wall', '-Wextra', '-Werror', parser_source, '-o', executable])
        for data, status, stdout, stderr in [
            ('Rss: 12 kB\n', 0, b'12\n', b''),
            ('map header\nRss:     0 kB\nUnknown: 2 kB\n', 0, b'0\n', b''),
            *((text, 94, b'', b'invalid process memory observation\n') for text in invalid),
        ]:
            result = run([executable, data])
            assert (result.returncode, result.stdout, result.stderr) == (status, stdout, stderr), result
            parsed += 1
    observations = []
    # Compile every generated variant on the local host, but only Linux can
    # establish actual /proc checkpoint support. No alternative data source.
    for entry_index, entry in enumerate(ENTRIES):
        sources = {'c': MEMORY.c_peer((ROOT / 'tests/fixtures/unique_buffer_peer.c').read_text()),
                   'rust': MEMORY.rust_peer((ROOT / 'tests/fixtures/unique_buffer_peer.rs').read_text()),
                   'fwp': MEMORY.fwp((args.native_checks / f'{entry}-harness.c').read_text(), entry)}
        for level in [1, 2]:
            obj = args.output / f'memory-{entry}-O{level}.o'
            build([args.cc, '-std=gnu11', f'-O{level}', '-fPIC', '-Wall', '-Wextra', '-Werror', '-c', helper_path, '-o', obj])
            for language, code in sources.items():
                source = args.output / f'{entry}-{language}.{"rs" if language == "rust" else "c"}'
                source.write_text(code)
                executable = args.output / f'{entry}-{language}-O{level}'
                if language == 'rust':
                    command = [args.rustc, '--edition=2021', '-C', f'opt-level={level}', '-C', 'overflow-checks=yes',
                               '-C', 'lto=off', '-D', 'warnings', '--cfg', f'buffer_entry="{entry}"',
                               '-C', f'link-arg={obj.resolve()}', source, '-o', executable]
                else:
                    flags = ['-w', '-lm', '-lpthread', '-ldl'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']
                    command = [args.cc, '-std=gnu11', f'-O{level}', '-ffp-contract=off', '-fno-fast-math', '-fno-lto',
                               f'-DBUFFER_ENTRY={entry_index}', source, obj, '-o', executable, *flags]
                build(command)
                if args.mode != 'linux':
                    continue
                for length in [0, 16, 4096, 262144]:
                    result = run([executable, entry, length, 1])
                    expected = length * (length - 1) // 2 if entry == 'scan' else length * (2 if entry == 'unique' else 1)
                    assert result.returncode == 0 and result.stdout == f'{expected}\n'.encode(), result
                    events = [json.loads(line) for line in result.stderr.splitlines()]
                    assert [row['stage'] for row in events] == ['entry', 'constructed', 'released', 'returned', 'before-exit'], events
                    for row in events:
                        assert set(row) == {'stage', 'virtualKiB', 'residentKiB', 'proportionalKiB', 'anonymousKiB', 'swapKiB', 'sharedHugeTlbKiB', 'privateHugeTlbKiB'}, row
                        assert all(type(value) is int and value >= 0 for key, value in row.items() if key != 'stage'), row
                        assert row['virtualKiB'] > 0 and row['residentKiB'] > 0, row
                        assert row['anonymousKiB'] <= row['residentKiB'], row
                        assert row['proportionalKiB'] <= row['residentKiB'], row
                    observations.append(dict(entry=entry, language=language, level=level, length=length, events=events))
    (args.output / 'report.json').write_text(json.dumps(dict(mode=args.mode, parserControls=parsed,
        scope='Diagnostic snapshots include observer overhead; no ordinary-program timing or memory claim.',
        observations=observations), indent=2) + '\n')
    print(f'Process-memory checks: {parsed} parser controls, 18 compiled programs, {len(observations)} Linux executions')


if __name__ == '__main__':
    main()
