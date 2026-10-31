#!/usr/bin/env python3
"""Build ordinary buffer peers and retain code/stack evidence before any timing."""
import argparse
import base64
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import shutil
import subprocess

ROOT = Path(__file__).resolve().parent.parent
ENTRIES = ('unique', 'callback', 'scan')


def sections(text):
    lines = [line.strip() for line in text.splitlines() if line.strip()]
    assert lines[0].endswith(':') and lines[1].split() == ['section', 'size', 'addr'], lines[:2]
    assert lines[-1].split()[0] == 'Total'
    values = {}
    for line in lines[2:-1]:
        name, size, address = line.split()
        assert name not in values and int(size) >= 0 and int(address) >= 0, line
        values[name] = int(size)
    assert sum(values.values()) == int(lines[-1].split()[1]), values
    assert values['.text'] > 0
    return values


def rust_frames(text, pass_name):
    # Stable rustc exposes LLVM's final frame sizes through optimization remarks.
    # With production debuginfo=0 it emits this one location warning; retain it
    # and reject every other diagnostic, including an empty/missing frame report.
    assert pass_name in ('prolog-epilog', 'prologepilog'), pass_name
    warning = '-C remark requires "-C debuginfo=n" to show source locations'
    result = []
    warnings = 0
    for line in text.splitlines():
        row = json.loads(line)
        assert row['$message_type'] == 'diagnostic' and row['code'] is None, row
        assert row['spans'] == [] and row['children'] == [], row
        if row['level'] == 'warning':
            assert row['message'] == warning, row
            warnings += 1
        else:
            assert row['level'] == 'note', row
            match = re.fullmatch(r"<unknown file>:0:0 " + re.escape(pass_name) + r" \(analysis\): ([0-9]+) stack bytes in function '([^']+)'", row['message'])
            assert match, row
            result.append(dict(functions=match[2], bytes=int(match[1])))
    assert warnings == 1 and result, 'missing Rust stack remarks or location diagnostic'
    return result


def c_frames(text):
    result = []
    for line in text.splitlines():
        location, size, kind = line.split('\t')
        assert size.isdecimal() and kind in ['static', 'dynamic', 'dynamic,bounded'], line
        result.append(dict(location=location, bytes=int(size), kind=kind))
    assert result, 'no C static stack metadata'
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['native-checks', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ['cc', 'rustc', 'c-arch', 'rust-cpu', 'size', 'objcopy']:
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    machine = platform.machine()
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[machine]
    assert args.rust_cpu == {'x86_64': 'x86-64', 'aarch64': 'generic'}[machine]
    native = json.loads((args.native_checks / 'report.json').read_text())
    assert native['source'] == os.environ['GITHUB_SHA']
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    records = {}

    def run(command, *, stack_remarks):
        command = list(map(str, command))
        try:
            result = subprocess.run(command, capture_output=True, timeout=180)
        except subprocess.TimeoutExpired as error:
            row = dict(command=command, status=None, timedOut=True,
                       stdout=base64.b64encode(error.stdout or b'').decode(),
                       stderr=base64.b64encode(error.stderr or b'').decode())
        else:
            row = dict(command=command, status=result.returncode, timedOut=False,
                       stdout=base64.b64encode(result.stdout).decode(), stderr=base64.b64encode(result.stderr).decode())
        with (out / 'commands.jsonl').open('a') as stream:
            stream.write(json.dumps(row) + '\n')
        assert row['status'] == 0 and not row['timedOut'], row
        if stack_remarks:
            rust_frames(result.stderr.decode(), 'prolog-epilog')
        else:
            assert not result.stderr, row
        return result

    versions = {name: run([getattr(args, name), '--version'], stack_remarks=False).stdout.decode()
                for name in ['cc', 'rustc', 'size', 'objcopy']}
    for index, entry in enumerate(ENTRIES):
        folder = out / entry
        folder.mkdir()
        sources = {'c': (ROOT / 'tests/fixtures/unique_buffer_peer.c').read_bytes(),
                   'rust': (ROOT / 'tests/fixtures/unique_buffer_peer.rs').read_bytes(),
                   'fwp': (args.native_checks / f'{entry}-harness.c').read_bytes()}
        records[entry] = {}
        for slot, language in enumerate(['c', 'rust', 'fwp']):
            source = folder / ('peer-' + language + ('.rs' if language == 'rust' else '.c'))
            source.write_bytes(sources[language])
            binary = folder / f'slot{slot * 2}exe'
            if language == 'rust':
                command = [args.rustc, '--edition=2021', '--crate-name', 'buffer_peer',
                           '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'lto=off',
                           '-C', 'codegen-units=16', '-C', 'debuginfo=0', '-C', 'panic=unwind',
                           '-C', f'target-cpu={args.rust_cpu}', '--cfg', f'buffer_entry="{entry}"',
                           source, '-o', binary]
            else:
                command = [args.cc, '-std=gnu11', '-O2', '-ffp-contract=off', '-fno-fast-math',
                           '-fno-lto', '-fstack-usage', '-march=' + args.c_arch,
                           f'-DBUFFER_ENTRY={index}', source, '-o', binary,
                           *(['-w', '-lm', '-lpthread', '-ldl'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror'])]
            assert run(command, stack_remarks=False).stdout == b''
            image = binary.read_bytes()
            assert image[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(image[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[machine]
            size_text = run([args.size, '-A', '-d', binary], stack_remarks=False).stdout.decode()
            (folder / (language + '-sections.txt')).write_text(size_text)
            if language == 'rust':
                stack_binary = folder / 'rust-stack'
                stack_command = command[:-1] + [stack_binary, '-C', 'remark=prolog-epilog', '--error-format=json']
                stack_result = run(stack_command, stack_remarks=True)
                assert stack_result.stdout == b''
                # The stack-only build must preserve the ordinary instruction bytes.
                text_paths = [folder / 'rust-text.bin', folder / 'rust-stack-text.bin']
                for executable, text_path in zip([binary, stack_binary], text_paths):
                    before = executable.read_bytes()
                    inspected = folder / (executable.name + '-inspection')
                    assert run([args.objcopy, '--dump-section', f'.text={text_path}', executable, inspected], stack_remarks=False).stdout == b''
                    assert executable.read_bytes() == before, 'section inspection modified its input'
                assert text_paths[0].read_bytes() == text_paths[1].read_bytes(), 'stack report changed Rust instructions'
                stack_text = stack_result.stderr.decode()
                (folder / 'rust-stack.jsonl').write_text(stack_text)
                frames = rust_frames(stack_text, 'prolog-epilog')
            else:
                usage, = folder.glob(binary.name + '*.su')
                frames = c_frames(usage.read_text())
            metadata = dict(source=source.relative_to(out).as_posix(),
                            sourceSha256=hashlib.sha256(sources[language]).hexdigest(),
                            sha256=hashlib.sha256(image).hexdigest(), bytes=len(image),
                            sections=sections(size_text), frames=frames,
                            stackScope='Compiler-reported frames for this compiled source; excludes prebuilt libraries and is not total call-stack usage.')
            for label, path in [(language, binary), (language + '-identical', folder / f'slot{slot * 2 + 1}exe')]:
                if path != binary:
                    shutil.copyfile(binary, path)
                path.chmod(0o555)
                assert path.read_bytes() == image
                records[entry][label] = dict(metadata, binary=path.relative_to(out).as_posix())
    (out / 'programs.json').write_text(json.dumps(dict(source=os.environ['GITHUB_SHA'], machine=machine,
        versions=versions, entries=records, scope='Ordinary programs and separate verified static-stack metadata; no timings collected.'), indent=2) + '\n')
    print('Prepared nine ordinary programs and nine byte-identical controls with code/stack evidence')


if __name__ == '__main__':
    main()
