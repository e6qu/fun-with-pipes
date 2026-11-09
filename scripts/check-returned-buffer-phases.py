#!/usr/bin/env python3
"""Verify phase callers and bad-clock/result controls; collect no peer ratios."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import shutil
import subprocess
import traceback

from process_wait import run_capture
from returned_buffer_build import build
from returned_buffer_phases import CASES, decode_output
from returned_buffer_source import boundary

ROOT = Path(__file__).resolve().parent.parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'ar', 'rustc', 'swiftc', 'source', 'arch', 'c-arch', 'rust-cpu', 'target'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    assert os.environ['GITHUB_SHA'] == args.source
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    fixtures = folder / 'fixtures'
    fixtures.mkdir()
    for pattern in ('returned_buffer_*', 'callable_phase_clock.*'):
        for path in (ROOT / 'tests/fixtures').glob(pattern):
            shutil.copyfile(path, fixtures / path.name)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no', CC=args.cc, FWP_LTO='0', FWP_STACK='1')
    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  compilerSha256=hashlib.sha256(args.compiler.read_bytes()).hexdigest(),
                  settings={key: str(value) for key, value in vars(args).items()},
                  scope='Phase caller correctness and clock/result controls, not a timing comparison',
                  builds=[], checks=[], failures=[], versions={})

    def run(command, expected, environment):
        command = list(map(str, command))
        result = run_capture(command, env=environment, cwd=None, input_data=None,
                             input_stream=None, text=True, encoding='utf-8', timeout=120, check=False)
        row = dict(command=command, status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        # None means the caller checks or records stdout.
        assert result.returncode == expected[0] and result.stderr == expected[2], row
        assert expected[1] is None or result.stdout == expected[1], row
        return row

    for name in ('cc', 'ar', 'rustc', 'swiftc'):
        report['versions'][name] = run([getattr(args, name), '--version'], (0, None, ''), env)['stdout']
    clock = folder / 'clock.o'
    bad_clock = folder / 'backward-clock.o'
    broken = folder / 'backward-clock.c'
    broken.write_text('#include <stdint.h>\nuint64_t callable_phase_clock(void) {\n'
                      '    static uint64_t value = UINT64_MAX; return value--;\n}\n')
    flags = [args.cc, '-std=c11', '-O2', '-fno-lto', '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror']
    run([*flags, '-c', fixtures / 'callable_phase_clock.c', '-o', clock], (0, '', ''), env)
    run([*flags, '-c', broken, '-o', bad_clock], (0, '', ''), env)
    bad_library = folder / 'backward-clock-library'
    bad_library.mkdir()
    run([args.ar, 'crs', bad_library / 'libbuffer_clock.a', bad_clock], (0, '', ''), env)
    original = folder / 'original.c'
    emitted = None
    try:
        run([args.compiler.resolve(), 'build', '--fn', 'buffer-functions', '--memory', 'dynamic', '--emit-c', '-O2',
             fixtures / 'returned_buffer_peer.fwp', '-o', original], (0, '', ''), env)
        emitted = boundary(original.read_text())
    except Exception as error:
        report['failures'].append(dict(group='fwp preparation', error=str(error), traceback=traceback.format_exc()))
    invalid = (([], 'expected length population batches'), (['16', '4096'], 'expected length population batches'),
               (['x', '4096', '16'], 'invalid integer'), (['16', '4096', '1.5'], 'invalid integer'),
               (['9223372036854775808', '4096', '16'], 'invalid integer'),
               (['-1', '4096', '16'], 'invalid experiment arguments'),
               (['16', '1', '16'], 'invalid experiment arguments'),
               (['16', '4096', '0'], 'invalid experiment arguments'),
               (['16', '4096', '17'], 'invalid experiment arguments'))
    for language in ('c', 'rs', 'swift', 'fwp'):
        if language == 'fwp' and emitted is None:
            continue
        for shared in (0, 1):
            for variant in ('ordinary', 'wrong-scan'):
                group = f'{language} shared={shared} {variant}'
                try:
                    binary, metadata = build(args, folder, fixtures, emitted, run, env,
                                             language, shared, 2, variant, 'phases', clock)
                    report['builds'].append(metadata)
                    if variant == 'wrong-scan':
                        report['checks'].append(run([binary, 16, 4096, 16], (4, '', 'incorrect result\n'), env))
                        continue
                    for length, population in CASES:
                        row = run([binary, length, population, 16], (0, None, ''), env)
                        row['phases'] = decode_output(row['stdout'], length, population, 16, shared)
                        report['checks'].append(row)
                    for argv, message in invalid:
                        report['checks'].append(run([binary, *argv], (2, '', message + '\n'), env))
                    # Relink the same factory against a real decreasing clock.
                    # This avoids compiling the large fwp factory a second time.
                    link = metadata['link']
                    assert link.count(str(binary)) == 1
                    clock_binary = binary.with_name('backward-clock-program')
                    before, after = (('native=' + str(binary.parent), 'native=' + str(bad_library))
                                     if language == 'rs' else (str(clock), str(bad_clock)))
                    assert link.count(before) == 1
                    command = [after if arg == before else str(clock_binary) if arg == str(binary) else arg for arg in link]
                    run(command, (0, '', ''), env)
                    row = run([clock_binary, 0, 4096, 16], (77, '', 'clock moved backwards\n'), env)
                    row['binarySha256'] = hashlib.sha256(clock_binary.read_bytes()).hexdigest()
                    report['checks'].append(row)
                except Exception as error:
                    report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
                    print(group, error, flush=True)
    report['files'] = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                       for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['builds']) == 16 and len(report['checks']) == 120
    print('Sixteen phase builds pass 120 result, argument and actual backward-clock checks; no timing ratios collected')


if __name__ == '__main__':
    main()
