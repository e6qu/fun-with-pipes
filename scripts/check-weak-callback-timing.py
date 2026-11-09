#!/usr/bin/env python3
"""Verify ordinary service timing callers before collecting performance results."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import traceback

from process_wait import run_capture
from weak_callback_service import CASES, decode_output as interpreter_results, replace_once, variants
from weak_callback_source import boundary
from weak_callback_timing import decode_output
from weak_callback_service_build import build_native

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
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source == os.environ['GITHUB_SHA']
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', CC=args.cc, FWP_LTO='0', FWP_STACK='1', SWIFT_BACKTRACE='enable=no', RUST_BACKTRACE='0')
    report = dict(source=args.source, architecture=args.arch, host=platform.uname()._asdict(),
                  compilerSha256=hashlib.sha256(args.compiler.read_bytes()).hexdigest(),
                  settings={key: str(value) for key, value in vars(args).items()},
                  scope='Timing caller correctness, actual delivery/result-release faults and backward-clock rejection; not timing acceptance',
                  versions={}, sourceHashes={path.name: hashlib.sha256(path.read_bytes()).hexdigest()
                                              for path in sorted((ROOT / "tests/fixtures").glob("weak_callback_service*"))}, builds=[], checks=[], arguments=[], interpreter=[], failures=[])
    commands = []

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

    def run(command, expected, environment):
        command = list(map(str, command))
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=120, check=False)
        except subprocess.TimeoutExpired as error:
            stdout, stderr = error.stdout or b'', error.stderr or b''
            row = dict(status=None, timedOut=True,
                       stdout=stdout.decode('utf-8', errors='replace') if isinstance(stdout, bytes) else stdout,
                       stderr=stderr.decode('utf-8', errors='replace') if isinstance(stderr, bytes) else stderr)
        else:
            row = dict(status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        row.update(command=command, index=len(commands), fwpNoOpt=environment.get('FWP_NO_OPT'))
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0] and row['stderr'] == expected[2], row
        assert expected[1] is None or row['stdout'] == expected[1], row
        return row

    save()
    for tool in ('cc', 'ar', 'rustc', 'swiftc'):
        report['versions'][tool] = run([getattr(args, tool), '--version'], (0, None, ''), env)['stdout']
    fixtures = ROOT / 'tests/fixtures'
    clock = folder / 'clock.o'
    backward = folder / 'clock-backward.c'
    backward.write_text('#include <stdint.h>\nuint64_t callable_phase_clock(void) { static uint64_t n=2; return n--; }\n')
    backward_clock = folder / 'clock-backward.o'
    for source, output in ((fixtures / 'callable_phase_clock.c', clock), (backward, backward_clock)):
        run([args.cc, '-std=c11', '-O2', '-fno-lto', '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror',
             '-c', source, '-o', output], (0, '', ''), env)
    invalid = (([], 'expected population mode batches'), (['64', '0'], 'expected population mode batches'),
               (['64junk', '0', '1'], 'invalid integer'), (['64', '-1', '1'], 'invalid integer'),
               (['64', '0', '9223372036854775808'], 'invalid integer'), (['65', '0', '1'], 'invalid experiment arguments'),
               (['64', '4', '1'], 'invalid experiment arguments'), (['64', '0', '2'], 'invalid experiment arguments'))
    for language in ('c', 'rs', 'swift', 'fwp'):
        original = (fixtures / ('weak_callback_service.' + language)).read_text()
        candidates = variants(language, original)
        sources = {}
        for variant in ('ordinary', 'missing-delivery'):
            if language == 'fwp':
                path = folder / ('service_' + variant.replace('-', '_') + '.fwp')
                path.write_text(candidates[variant])
                if variant == 'ordinary':
                    for raw in (True, False):
                        try:
                            row = run([args.compiler.resolve(), 'run', '--interp', path], (0, None, ''),
                                      env | {'FWP_NO_OPT': '1'} if raw else env)
                            report['interpreter'].append(dict(raw=raw, command=row['index'], results=interpreter_results(row['stdout'])))
                        except Exception as error:
                            failure(f'interpreter raw={raw}', error)
                try:
                    generated = path.with_suffix('.c')
                    run([args.compiler.resolve(), 'build', '--fn', 'service', '--memory', 'dynamic', '--emit-c', '-O2',
                         path, '-o', generated], (0, '', ''), env)
                    sources[variant] = boundary(generated.read_text())
                except Exception as error:
                    failure('emit fwp ' + variant, error)
            else:
                sources[variant] = candidates[variant]
        if 'ordinary' in sources:
            sources['backward-clock'] = sources['ordinary']
            if language == 'fwp':
                sources['release-observed'] = sources['ordinary']
                sources['omitted-result-release'] = replace_once(sources['ordinary'], '    fwp_rc_free_obj(output);', '')
        caller = (fixtures / ('weak_callback_service_time.' + ('c' if language == 'fwp' else language))).read_text()
        for variant, source in sources.items():
            observes_release = variant in ('release-observed', 'omitted-result-release')
            for level in (1, 2):
                group = f'{language}/{variant}/O{level}'
                try:
                    binary, built = build_native(args, folder, language, source, variant, level,
                        'diagnostic' if observes_release else 'plain', False,
                        backward_clock if variant == 'backward-clock' else clock, caller, run, env)
                    image = binary.read_bytes()
                    assert image[:6] == b'\x7fELF\x02\x01'
                    assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
                    report['builds'].append(dict(language=language, variant=variant, level=level, command=built['index'],
                                                binarySha256=hashlib.sha256(image).hexdigest()))
                except Exception as error:
                    failure('build ' + group, error)
                    continue
                cases = [(population, mode, batches) for population, mode in CASES for batches in (1, 16)]
                if variant not in ('ordinary', 'release-observed'):
                    cases = [(64, 0, 1)]
                for population, mode, batches in cases:
                    try:
                        wanted = {'missing-delivery': (4, '', 'incorrect service result\n'),
                                  'backward-clock': (77, '', 'clock moved backwards\n'),
                                  'omitted-result-release': (79, '', 'service storage not released\n')}
                        expected = (0, None, '') if variant in ('ordinary', 'release-observed') else wanted[variant]
                        row = run([binary, population, mode, batches], expected, env)
                        output = decode_output(row['stdout'], population, mode, batches) if expected[0] == 0 else None
                        report['checks'].append(dict(language=language, variant=variant, level=level,
                            population=population, mode=mode, batches=batches, command=row['index'], result=output))
                    except Exception as error:
                        failure(f'{group} {population}/{mode}/{batches}', error)
                    save()
                if variant == 'ordinary':
                    for arguments, argument_message in invalid:
                        try:
                            row = run([binary, *arguments], (2, '', argument_message + '\n'), env)
                            report['arguments'].append(dict(language=language, level=level, command=row['index']))
                        except Exception as error:
                            failure('arguments ' + group + str(arguments), error)
                save()
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['builds']) == 28 and len(report['checks']) == 178 and len(report['arguments']) == 64
    assert len(report['interpreter']) == 2
    print('28 native timing builds, 178 result/fault checks, 64 invalid arguments and both interpreter modes pass')


if __name__ == '__main__':
    main()
