#!/usr/bin/env python3
"""Check payload delivery, cancellation, expiration and handled callback errors."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import traceback

from process_wait import run_capture
from weak_callback_service import decode_missing_delivery, decode_output, variants
from weak_callback_service_build import build_native

ROOT = Path(__file__).resolve().parent.parent


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'rustc', 'swiftc', 'source', 'arch', 'c-arch', 'rust-cpu', 'target'):
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
                  scope='Service correctness and C release counters; not timing, ARC counts or all-peer storage proof',
                  versions={}, sourceHashes={path.name: hashlib.sha256(path.read_bytes()).hexdigest()
                                              for path in sorted((ROOT / "tests/fixtures").glob("weak_callback_service*"))}, builds=[], checks=[], interpreter=[], failures=[])
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
    for tool in ('cc', 'rustc', 'swiftc'):
        report['versions'][tool] = run([getattr(args, tool), '--version'], (0, None, ''), env)['stdout']
    for language in ('c', 'rs', 'swift', 'fwp'):
        original = ROOT / 'tests/fixtures' / ('weak_callback_service.' + language)
        source = original.read_text()
        report['sourceHashes'][language] = hashlib.sha256(original.read_bytes()).hexdigest()
        for variant, code in variants(language, source).items():
            path = folder / ('service_' + variant.replace('-', '_') + '.' + language)
            path.write_text(code)
            decoder = decode_missing_delivery if variant == 'missing-delivery' else decode_output
            if language == 'fwp':
                for raw in (True, False):
                    try:
                        row = run([args.compiler.resolve(), 'run', '--interp', path], (0, None, ''),
                                  env | {'FWP_NO_OPT': '1'} if raw else env)
                        report['interpreter'].append(dict(variant=variant, raw=raw, command=row['index'],
                                                          results=decoder(row['stdout'])))
                    except Exception as error:
                        failure(f'interpreter {variant} raw={raw}', error)
                    save()
            for level in (1, 2):
                group = f'{language} {variant} level={level}'
                binary = folder / f'{language}-{variant}-{level}'
                try:
                    if language != 'fwp':
                        caller = (ROOT / 'tests/fixtures' / ('weak_callback_service_check.' + language)).read_text()
                        binary, built = build_native(args, folder, language, code, variant, level,
                                                     'diagnostic', False, None, caller, run, env)
                    else:
                        command = [args.compiler.resolve(), 'build', '--memory', 'dynamic', '-O' + str(level),
                                   path, '-o', binary]
                        built = run(command, (0, '', ''), env)
                    image = binary.read_bytes()
                    assert image[:6] == b'\x7fELF\x02\x01'
                    assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
                    report['builds'].append(dict(language=language, variant=variant, level=level,
                                                command=built['index'], binarySha256=hashlib.sha256(image).hexdigest()))
                except Exception as error:
                    failure('build ' + group, error)
                    continue
                try:
                    omitted = variant.startswith('omitted-')
                    row = run([binary], (79, '', 'service storage not released\n') if omitted else (0, None, ''), env)
                    report['checks'].append(dict(language=language, variant=variant, level=level,
                                                command=row['index'], results=[] if omitted else decoder(row['stdout'])))
                except Exception as error:
                    failure(group, error)
                if variant == 'ordinary' and language != 'fwp':
                    try:
                        run([binary, 'unexpected'], (2, '', 'expected no arguments\n'), env)
                    except Exception as error:
                        failure('arguments ' + group, error)
                save()
    save()
    manifest = {str(path.relative_to(folder)): hashlib.sha256(path.read_bytes()).hexdigest()
                for path in sorted(folder.rglob('*')) if path.is_file()}
    (folder / 'manifest.json').write_text(json.dumps(manifest, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['builds']) == len(report['checks']) == 20
    assert len(report['interpreter']) == 4
    print('Eight ordinary native builds, eight missing-delivery builds, four real release faults and four interpreter executions pass')


if __name__ == '__main__':
    main()
