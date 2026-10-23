#!/usr/bin/env python3
"""Untimed controls for output removal, complete numerical results and checksum consumption."""

import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import struct
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('descent_output', ROOT / 'scripts/measure-descent-output.py')
OUTPUT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(OUTPUT)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['compiler', 'output']:
        parser.add_argument('--' + name, required=True, type=Path)
    for name in ['cc', 'rustc', 'c-arch', 'objdump', 'nm']:
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {k: v for k, v in os.environ.items() if not k.startswith('FWP_') and k not in {'GH_TOKEN', 'GITHUB_TOKEN'}}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_AD_WORKSPACE='1', FWP_PACKED_ARRAYS='1',
                       FWP_STACK='1', FWP_FREE='1', FWP_REUSE='1', FWP_ARRAY_FUSION='1',
                       FWP_GC='off', FWP_GC_STATS='0', FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-march=' + args.c_arch]
    records, commands = [], []

    def run(command):
        commands.append([str(p) for p in command])
        actual = subprocess.run(command, env=environment, capture_output=True, timeout=45)
        assert actual.returncode == 0, (command, actual.returncode, actual.stderr.decode(errors='replace'))
        return actual

    def inspect(binary, source):
        raw = binary.read_bytes()
        if platform.system() == 'Darwin':
            assert raw[:4] == b'\xcf\xfa\xed\xfe'
            assert int.from_bytes(raw[4:8], 'little') == {'arm64': 0x100000c, 'x86_64': 0x1000007}[platform.machine()]
        else:
            assert platform.system() == 'Linux' and raw[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(raw[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[platform.machine()]
        asm = run([args.objdump, '-d', str(binary)]).stdout
        symbols = run([args.nm, str(binary)]).stdout
        assert len(asm) > 1000
        if binary.name.startswith('fwp'):
            assert not re.search(rb'(?<![A-Za-z0-9])_?fwp_gc_(?:scan|mark_all|sweep)\b', symbols)
        (binary.parent / (binary.name + '.asm')).write_bytes(asm)
        (binary.parent / (binary.name + '.symbols')).write_bytes(symbols)
        return dict(sha256=OUTPUT.digest(raw), sourceSha256=OUTPUT.digest(source.read_bytes()),
                    disassemblySha256=OUTPUT.digest(asm), bytes=len(raw))

    encoded = [[struct.pack('>d', value).hex() for value in [1., 2.]]]*2
    valid = b'\n'.join(json.dumps(row).encode() for row in encoded) + b'\n'
    assert OUTPUT.sink_vectors(valid, [1., 2.], 2) == encoded
    invalid = [valid.splitlines()[0]+b'\n', valid.replace(b'4000000000000000', b'4008000000000000'),
               valid.replace(b'4000000000000000', b'7ff0000000000000'),
               valid.replace(b'4000000000000000', b'7ff8000000000000'),
               b'["3ff0000000000000"]\n'*2, b'[true, false]\n'*2,
               b'["3ff0000000000000", "4000000000000000", "0"]\n'*2]
    for value in invalid:
        try:
            OUTPUT.sink_vectors(value, [1., 2.], 2)
        except AssertionError:
            continue
        raise AssertionError('Malformed or incomplete vector accepted')
    assert OUTPUT.sink_checksum(encoded) != OUTPUT.sink_checksum([row[:-1] for row in encoded])
    assert OUTPUT.orders(list('abcdefgh'), 48, 20261023) == OUTPUT.orders(list('abcdefgh'), 48, 20261023)
    for points, updates in [(2, 0), (2, 1), (3, 7)]:
        directory = out / f'{points}-{updates}'
        directory.mkdir()
        expected = OUTPUT.BATCHES.PEERS.AD.analytic(points, updates + 1)
        source, generated = directory / 'input.fwp', directory / 'input.c'
        source.write_text(OUTPUT.BATCHES.PEERS.packed_program(points, updates))
        reference = subprocess.run([str(args.compiler), 'run', '--interp', str(source)],
                                   env=dict(environment, FWP_NO_OPT='1'), capture_output=True, timeout=45)
        assert reference.returncode == 0 and not reference.stderr
        OUTPUT.COORDINATE.check_vectors(reference.stdout, expected, 1)
        (directory / 'interpreter.stdout').write_bytes(reference.stdout)
        run([str(args.compiler), 'build', '--gc', 'arc', '--memory', 'dynamic', '--emit-c', '-O2', str(source), '-o', str(generated)])
        originals = dict(fwp=generated.read_text(),
            c=f'#define DIMENSIONS {points}\n#define UPDATES {updates}\n' + (ROOT / 'tests/fixtures/descent_coordinate.c').read_text(),
            rust=(ROOT / 'tests/fixtures/descent_coordinate.rs').read_text().replace('// Measurement parameters are inserted here.',
                f'const DIMENSIONS: usize = {points};\nconst UPDATES: usize = {updates};'))
        objects = {}
        for mode, dump, omit in [('hash', 0, 0), ('dump', 1, 0), ('omit', 0, 1)]:
            obj = directory / ('sink-' + mode + '.o')
            run([args.cc, *flags, '-Wall', '-Wextra', '-Werror', '-DDESCENT_SINK_DUMP='+str(dump),
                 '-DDESCENT_SINK_OMIT_LAST='+str(omit), '-c', str(ROOT / 'tests/fixtures/descent_output_sink.c'), '-o', str(obj)])
            objects[mode] = obj
        for language, original in originals.items():
            outputs = {}
            modes = ['full', 'dump', 'hash', 'omit', 'full-profile', 'hash-profile']
            if (points, updates) == (3, 7):
                modes += ['full-missing-release', 'hash-missing-release']
            for mode in modes:
                profiled = mode.endswith('profile') or mode.endswith('missing-release')
                missing = mode.endswith('missing-release')
                sink = not mode.startswith('full')
                observed = original
                if profiled and language == 'fwp':
                    observed = OUTPUT.BATCHES.PEERS.AD.RAW.instrument(OUTPUT.BATCHES.PEERS.AD.PROFILE.instrument(original))
                code = OUTPUT.repeated(observed, language, 2, sink)
                if profiled:
                    code = (OUTPUT.BATCHES.observe_solves(code, 'retained' if missing else 'checked')
                            if language == 'fwp' else OUTPUT.peer_profile(code, language, missing))
                object_mode = 'hash' if profiled and sink else mode
                binary = directory / (language + '-' + mode)
                path = directory / (binary.name + ('.rs' if language == 'rust' else '.c'))
                path.write_text(code)
                if language == 'rust':
                    command = [args.rustc, '--crate-name', 'descent_output_control', '--edition=2021', '-D', 'warnings',
                               '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'codegen-units=1',
                               '-C', 'target-cpu=generic', '-C', 'lto=off', str(path), '-o', str(binary)]
                    if sink:
                        command += ['-C', 'link-arg=' + str(objects[object_mode])]
                else:
                    command = [args.cc, *flags, *(['-w'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']), str(path),
                               *([str(objects[object_mode])] if sink else []), '-o', str(binary), '-lm', '-lpthread']
                run(command)
                actual = subprocess.run([str(binary)], env=environment, capture_output=True, timeout=45)
                expected_status = (225 if language == 'fwp' else 226) if missing else 0
                assert actual.returncode == expected_status, (mode, actual.returncode, actual.stderr.decode(errors='replace'))
                if profiled:
                    rows = [json.loads(line) for line in actual.stderr.splitlines()]
                    if language == 'fwp':
                        checks = [row for row in rows if 'solve' in row]
                        if missing:
                            assert len(rows) == 1 and checks[0]['solve'] == 1
                            assert checks[0]['managedLiveBytes'] > 0 and checks[0]['rawLiveBytes'] == 0
                        else:
                            assert checks == [dict(solve=i, managedLiveBytes=0, rawLiveBytes=0) for i in [1, 2]]
                            managed, raw = [row for row in rows if 'solve' not in row]
                            assert managed['retains'] == managed['finalChargedBytes'] == managed['collections'] == 0
                            OUTPUT.BATCHES.PEERS.AD.RAW.check_profile(raw['rawDerivativeStorage'], 0, True)
                    else:
                        assert rows == [dict(solve=i, inputRequests=2*i, inputRequestedBytes=16*points*i,
                                             inputLiveBytes=8*points if missing else 0, inputPeakBytes=16*points)
                                        for i in ([1] if missing else [1, 2])]
                    if not missing:
                        assert actual.stdout == outputs['hash' if sink else 'full']
                else:
                    assert not actual.stderr
                outputs[mode] = actual.stdout
                (directory / (binary.name + '.stdout')).write_bytes(actual.stdout)
                (directory / (binary.name + '.stderr')).write_bytes(actual.stderr)
                (directory / (binary.name + '.status')).write_text(str(actual.returncode) + '\n')
                record = dict(case=f'{points}-{updates}', language=language, mode=mode, **inspect(binary, path))
                records.append(record)
            OUTPUT.COORDINATE.check_vectors(outputs['full'], expected, 2)
            if language == 'fwp':
                assert outputs['full'] == reference.stdout*2
            vectors = OUTPUT.sink_vectors(outputs['dump'], expected, 2)
            assert outputs['hash'] == OUTPUT.sink_checksum(vectors)
            assert outputs['omit'] != outputs['hash']
            print(points, updates, language, 'output, checksum and between-solve ownership checks pass', flush=True)
    assert len(records) == 60
    (out / 'controls.json').write_text(json.dumps(dict(scope='Untimed control checks; no speed claim',
        malformedOutputsRejected=len(invalid), records=records, commands=commands), indent=2) + '\n')


if __name__ == '__main__':
    main()
