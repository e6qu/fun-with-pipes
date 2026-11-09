#!/usr/bin/env python3
"""Check serial weak-registration lifetimes using native C, Rust and Swift."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
EXPECTED = 'calls=2 destroyed=66 expired=1 cancelled=1 error=1\n'


def replace_once(source, before, after):
    assert source.count(before) == 1, ('changed failure-control boundary', before)
    return source.replace(before, after)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('cc', 'rustc', 'swiftc', 'source', 'arch', 'c-arch', 'rust-cpu', 'target'):
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'native peer batches run on GitHub'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.target == args.arch + '-unknown-linux-gnu'
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source
    assert os.environ['GITHUB_SHA'] == args.source
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', SWIFT_BACKTRACE='enable=no')

    def run(command):
        command = list(map(str, command))
        result = run_capture(command, env=env, cwd=None, input_data=None,
                             input_stream=None, text=True, encoding='utf-8',
                             timeout=90, check=False)
        row = dict(command=command, status=result.returncode,
                   stdout=result.stdout, stderr=result.stderr)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        return row

    report = dict(source=args.source, architecture=args.arch,
                  host=platform.uname()._asdict(), sourceHashes={}, checks=[],
                  settings={name: str(value) for name, value in vars(args).items()},
                  scope='Serial callback lifetime correctness, not timing, allocation or ARC counts')
    report['versions'] = {}
    for name in ('cc', 'rustc', 'swiftc'):
        row = run([getattr(args, name), '--version'])
        assert row['status'] == 0, row
        report['versions'][name] = row['stdout']
    for language in ('c', 'rs', 'swift'):
        source = (ROOT / 'tests/fixtures' / ('weak_registration_peer.' + language)).read_text()
        report['sourceHashes'][language] = hashlib.sha256(source.encode()).hexdigest()
        variants = {'ordinary': source}
        if language == 'c':
            variants.update({
                'omitted-active-release': replace_once(source, '    release_owner(&active);', ''),
                'omitted-error-release': replace_once(source, '    release_owner(&acquired);', ''),
                'omitted-expiration': replace_once(source, '        owner->target = NULL;', ''),
                'omitted-metadata-release': replace_once(source,
                    '        control->counts->metadata--;\n        free(control);', ''),
            })
        for variant, code in variants.items():
            path = folder / (language + '-' + variant + '.' + language)
            path.write_text(code)
            for level in (1, 2):
                binary = folder / (language + '-' + variant + '-' + str(level))
                if language == 'c':
                    command = [args.cc, '-std=c11', '-O' + str(level), '-fno-lto',
                               '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror', path, '-o', binary]
                elif language == 'rs':
                    command = [args.rustc, '--edition=2021', '-C', 'opt-level=' + str(level),
                               '-C', 'overflow-checks=yes', '-C', 'lto=off', '-C', 'panic=unwind',
                               '-C', 'target-cpu=' + args.rust_cpu, '--target', args.target,
                               '-D', 'warnings', path, '-o', binary]
                else:
                    command = [args.swiftc, '-swift-version', '6',
                               *(['-Onone'] if level == 1 else ['-O', '-whole-module-optimization']),
                               '-warnings-as-errors', '-target', args.target, path, '-o', binary]
                built = run(command)
                assert (built['status'], built['stdout'], built['stderr']) == (0, '', ''), built
                result = run([binary])
                expected = (0, EXPECTED, '') if variant == 'ordinary' else (79, '', 'lifetime check failed\n')
                assert (result['status'], result['stdout'], result['stderr']) == expected, result
                report['checks'].append(dict(language=language, variant=variant, level=level,
                                              binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                                              result=result))
                if variant == 'ordinary':
                    invalid = run([binary, 'unexpected'])
                    assert (invalid['status'], invalid['stdout'], invalid['stderr']) == (
                        2, '', 'expected no arguments\n'), invalid
    (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('Six native peer builds and eight actual lifetime-fault builds pass their expected checks')


if __name__ == '__main__':
    main()
