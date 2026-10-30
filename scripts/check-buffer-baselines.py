#!/usr/bin/env python3
"""Reconstruct a complete buffer baseline from retained files, not its summary."""
import argparse
import base64
import hashlib
import importlib.util
import json
from pathlib import Path

SPEC = importlib.util.spec_from_file_location('buffer_baselines', Path(__file__).with_name('unique-buffer-baselines.py'))
BASELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BASELINE)
SPEC = importlib.util.spec_from_file_location('buffer_programs', Path(__file__).with_name('prepare-buffer-baselines.py'))
PROGRAMS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PROGRAMS)


def check_manifest(folder):
    manifest = json.loads((folder / 'manifest.json').read_text())
    paths = list(folder.rglob('*'))
    assert not any(path.is_symlink() for path in paths), 'evidence must contain regular files'
    actual = {path.relative_to(folder).as_posix() for path in paths if path.is_file()}
    assert actual == set(manifest) | {'manifest.json'}, 'missing or extra evidence files'
    for name, metadata in manifest.items():
        path = Path(name)
        assert not path.is_absolute() and '..' not in path.parts, name
        data = (folder / path).read_bytes()
        assert metadata == dict(bytes=len(data), sha256=hashlib.sha256(data).hexdigest()), name


def check_evidence(folder, source, machine, session, origin):
    check_manifest(folder)
    config = json.loads((folder / 'configuration.json').read_text())
    assert origin in ['observed', 'synthetic'] and config['origin'] == origin
    assert config['source'] == source and config['session'] == session
    assert config['cpuPolicy'] == 'all' and config['timeout'] == 45
    assert config['environment'] == dict(PATH='/usr/bin:/bin', LANG='C', LC_ALL='C', TZ='UTC')
    affinity = config['affinity']
    assert len(affinity) == 4 and affinity == sorted(set(affinity))
    assert all(type(cpu) is int and cpu >= 0 for cpu in affinity)
    assert str(config['run']).isdecimal() and str(config['attempt']).isdecimal()
    assert 'GNU Time' in config['timeVersion']
    BASELINE.check_host(config['qualification'], source, machine)
    programs = check_build(folder / 'programs', source, machine, config['qualification'])
    root = Path(config['directory'])
    assert root.is_absolute()
    summaries = {}
    for entry in BASELINE.ENTRIES:
        for length, calls in BASELINE.CASES:
            name = f'{entry}-{length}'
            rows = [json.loads(line) for line in (folder / (name + '.jsonl')).read_text().splitlines()]
            summaries[name] = BASELINE.summarize_case(rows, entry, length, calls)
            for row in rows:
                binary = programs['entries'][entry][row['label']]['binary']
                assert row['command'] == [str(root / 'programs' / binary), entry, str(length), str(calls)]
    memory_rows = [json.loads(line) for line in (folder / 'memory.jsonl').read_text().splitlines()]
    expected = [(entry, length, calls, label) for entry in BASELINE.ENTRIES
                for length, calls in BASELINE.CASES for label in BASELINE.LABELS]
    assert len(memory_rows) == len(expected) == 72
    memory = []
    for row, (entry, length, calls, label) in zip(memory_rows, expected):
        assert (row['entry'], row['length'], row['calls'], row['label']) == (entry, length, calls, label)
        BASELINE.check_result(row, entry, length, calls)
        name = f'{entry}-{length}-{label}.rss'
        assert row['file'] == name
        binary = root / 'programs' / programs['entries'][entry][label]['binary']
        assert row['command'] == [config['time'], '-f', '%M', '-o', str(root / name), str(binary), entry, str(length), str(calls)]
        raw = (folder / name).read_text()
        assert raw.endswith('\n') and raw[:-1].isdecimal(), raw
        memory.append(dict(entry=entry, length=length, label=label, maximumResidentKiB=int(raw)))
    expected_report = dict(source=source, session=session, complete=True, cases=summaries,
                           memory=memory, decision='Descriptive baseline only; no optimization accepted.')
    assert json.loads((folder / 'report.json').read_text()) == expected_report, 'summary disagrees with raw observations'
    return expected_report


def check_build(folder, source, machine, qualification):
    programs = BASELINE.check_programs(folder, source, machine)
    assert programs['versions']['cc'].splitlines()[0] == qualification['actual']['cVersion']
    assert programs['versions']['rustc'].strip() == qualification['actual']['rustVersion']
    for entry in BASELINE.ENTRIES:
        for language in ['c', 'rust', 'fwp']:
            directory = folder / entry
            metadata = programs['entries'][entry][language]
            assert metadata['sections'] == PROGRAMS.sections((directory / (language + '-sections.txt')).read_text())
            if language == 'rust':
                frames = PROGRAMS.rust_frames((directory / 'rust-stack.jsonl').read_text())
                ordinary = (directory / 'rust-text.bin').read_bytes()
                assert ordinary and ordinary == (directory / 'rust-stack-text.bin').read_bytes()
            else:
                usage, = directory.glob(Path(metadata['binary']).name + '*.su')
                frames = PROGRAMS.c_frames(usage.read_text())
            assert metadata['frames'] == frames
    build_rows = [json.loads(line) for line in (folder / 'commands.jsonl').read_text().splitlines()]
    assert len(build_rows) == 31, 'incomplete build/inspection command log'
    for row in build_rows:
        assert type(row['status']) is int and row['status'] == 0 and row['timedOut'] is False
        stderr = base64.b64decode(row['stderr'], validate=True)
        if 'remark=prolog-epilog' in row['command']:
            PROGRAMS.rust_frames(stderr.decode())
        else:
            assert stderr == b'', row
    tools = {}
    for name, row in zip(['cc', 'rustc', 'size', 'objcopy'], build_rows[:4]):
        command = row['command']
        assert len(command) == 2 and command[1] == '--version'
        tools[name] = command[0]
        assert base64.b64decode(row['stdout']).decode() == programs['versions'][name]
    cursor = 4
    for index, entry in enumerate(BASELINE.ENTRIES):
        for language in ['c', 'rust', 'fwp']:
            row = build_rows[cursor]
            command = row['command']
            binary = Path(command[command.index('-o') + 1])
            assert binary.is_absolute() and binary.parent.name == entry
            metadata = programs['entries'][entry][language]
            assert binary.name == Path(metadata['binary']).name
            input_path = binary.parent / Path(metadata['source']).name
            if language == 'rust':
                expected_command = [tools['rustc'], '--edition=2021', '--crate-name', 'buffer_peer',
                    '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'lto=off',
                    '-C', 'codegen-units=16', '-C', 'debuginfo=0', '-C', 'panic=unwind',
                    '-C', 'target-cpu=' + ('generic' if machine == 'aarch64' else 'x86-64'),
                    '--cfg', f'buffer_entry="{entry}"', str(input_path), '-o', str(binary)]
            else:
                expected_command = [tools['cc'], '-std=gnu11', '-O2', '-ffp-contract=off',
                    '-fno-fast-math', '-fno-lto', '-fstack-usage',
                    '-march=' + ('armv8-a' if machine == 'aarch64' else 'x86-64'),
                    f'-DBUFFER_ENTRY={index}', str(input_path), '-o', str(binary),
                    *(['-w', '-lm', '-lpthread', '-ldl'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror'])]
            assert command == expected_command and base64.b64decode(row['stdout']) == b''
            size_row = build_rows[cursor + 1]
            assert size_row['command'] == [tools['size'], '-A', '-d', str(binary)]
            assert base64.b64decode(size_row['stdout']).decode() == (folder / entry / (language + '-sections.txt')).read_text()
            cursor += 2
            if language == 'rust':
                stack_binary = binary.parent / 'rust-stack'
                stack_row = build_rows[cursor]
                assert stack_row['command'] == command[:-1] + [str(stack_binary), '-C', 'remark=prolog-epilog', '--error-format=json']
                assert base64.b64decode(stack_row['stdout']) == b''
                assert base64.b64decode(stack_row['stderr']).decode() == (folder / entry / 'rust-stack.jsonl').read_text()
                for row, executable, name in zip(build_rows[cursor + 1:cursor + 3], [binary, stack_binary], ['rust-text.bin', 'rust-stack-text.bin']):
                    assert row['command'] == [tools['objcopy'], '--dump-section', f'.text={binary.parent / name}', str(executable), str(binary.parent / (executable.name + '-inspection'))]
                    assert base64.b64decode(row['stdout']) == b''
                cursor += 3
    assert cursor == len(build_rows)
    return programs


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--origin', choices=['observed', 'synthetic'], required=True)
    parser.add_argument('--machine', choices=['aarch64', 'x86_64'], required=True)
    parser.add_argument('--session', type=int, choices=[1, 2], required=True)
    args = parser.parse_args()
    check_evidence(args.input, args.source, args.machine, args.session, args.origin)
    print('Verified all files, 32,832 process records, 72 memory observations and reconstructed summaries')


if __name__ == '__main__':
    main()
