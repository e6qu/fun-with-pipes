#!/usr/bin/env python3
"""Compare actual ownership/cleanup calls and charged service storage, without timing claims."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess
import traceback

from nested_resource_counts import compare, decode, instrument
from process_wait import run_capture
from weak_callback_service import CASES, replace_once
from weak_callback_service_build import build_native
from weak_callback_source import boundary
from weak_callback_timing import decode_output

ROOT = Path(__file__).resolve().parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('compiler', 'reference', 'output'):
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ('source', 'reference-source', 'arch', 'cc', 'c-arch'):
        parser.add_argument('--' + name, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == args.arch
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[args.arch]
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip() == args.source == os.environ['GITHUB_SHA']
    assert args.reference_source == '65719f7fc2277a5b97c5a790df941fea6c5eb4d7'
    folder = args.output.resolve()
    folder.mkdir(parents=True, exist_ok=False)
    env = {key: value for key, value in os.environ.items()
           if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN', 'LD_PRELOAD', 'LD_LIBRARY_PATH')}
    env.update(LC_ALL='C', CC=args.cc, FWP_LTO='0', FWP_STACK='1')
    compilers = dict(reference=args.reference.resolve(), candidate=args.compiler.resolve())
    report = dict(source=args.source, referenceSource=args.reference_source, architecture=args.arch, root=str(folder),
                  compilers={key: digest(value) for key, value in compilers.items()},
                  host=platform.uname()._asdict(), settings={key: str(value) for key, value in vars(args).items()},
                  builds=[], cases={}, controls=[], selection={}, comparisons={}, failures=[])
    commands = []

    def save():
        (folder / 'report.json').write_text(json.dumps(report, indent=2) + '\n')

    def run(command, expected, environment):
        command = list(map(str, command))
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None, input_stream=None,
                                 text=True, encoding='utf-8', timeout=180, check=False)
            row = dict(status=result.returncode, stdout=result.stdout, stderr=result.stderr)
        except subprocess.TimeoutExpired as error:
            row = dict(status=None, stdout=str(error.stdout), stderr=str(error.stderr))
        row.update(command=command, index=len(commands))
        commands.append(row)
        with (folder / 'commands.jsonl').open('a') as output:
            output.write(json.dumps(row) + '\n')
        assert row['status'] == expected[0], row
        for key, value in zip(('stdout', 'stderr'), expected[1:]):
            assert value is None or row[key] == value, row
        return row

    def failure(group, error):
        report['failures'].append(dict(group=group, error=str(error), traceback=traceback.format_exc()))
        save()
        print('FAILED', group, error, flush=True)

    report['ccVersion'] = run([args.cc, '--version'], (0, None, ''), env)['stdout']
    fixtures = ROOT / 'tests/fixtures'
    clock = folder / 'clock.o'
    run([args.cc, '-std=c11', '-O2', '-fno-lto', '-march=' + args.c_arch, '-Wall', '-Wextra', '-Werror',
         '-c', fixtures / 'callable_phase_clock.c', '-o', clock], (0, '', ''), env)
    caller = (fixtures / 'weak_callback_service_time.c').read_text()
    for role, compiler in compilers.items():
        for application, path, options in (
            ('service', fixtures / 'weak_callback_service.fwp', ['--fn', 'service']),
            ('http', ROOT / 'examples/server/api.fwp', []),
        ):
            try:
                generated = folder / f'{role}-{application}.c'
                emitted = run([compiler, 'build', '--memory', 'dynamic', '--emit-c', '-O2', *options,
                               path, '-o', generated], (0, '', ''), env)
                original = generated.read_text()
                selections = original.count('protected by enclosing frame')
                assert (selections > 0) if role == 'candidate' else (selections == 0)
                report['selection'][role + '-' + application] = dict(
                    command=emitted['index'], anchors=selections, sha256=digest(generated))
                save()
            except Exception as error:
                failure(f'{role}/{application} emission', error)
                continue
            if application != 'service':
                continue
            observed = instrument(boundary(original))
            for level in (1, 2):
                key = f'{role}-O{level}'
                try:
                    binary, built = build_native(args, folder, 'fwp', observed, role, level,
                                                 'diagnostic', False, clock, caller, run, env)
                    image = binary.read_bytes()
                    assert image[:6] == b'\x7fELF\x02\x01'
                    assert int.from_bytes(image[18:20], 'little') == {'aarch64': 183, 'x86_64': 62}[args.arch]
                    report['builds'].append(dict(role=role, level=level, sha256=digest(binary), command=built['index']))
                except Exception as error:
                    failure(key + ' build', error)
                    continue
                readings = report['cases'][key] = {}
                for population, mode in CASES:
                    try:
                        row = run([binary, population, mode, 1], (0, None, None), env)
                        decode_output(row['stdout'], population, mode, 1)
                        readings[f'{population}-{mode}'] = dict(command=row['index'], counts=decode(row['stderr']))
                    except Exception as error:
                        failure(f'{key}/{population}/{mode}', error)
                    save()
                # These controls execute real calls/releases; no fabricated report fields.
                for variant in ('extra-cleanup', 'missing-release'):
                    try:
                        control = (replace_once(observed, '    ServiceStats result =',
                            '    fwp_cleanup extra; fwp_cleanup_push(&extra, NULL, NULL); fwp_cleanup_pop(&extra);\n    ServiceStats result =')
                            if variant == 'extra-cleanup' else replace_once(observed, '    fwp_rc_free_obj(output);', ''))
                        probe, linked = build_native(args, folder, 'fwp', control, role + '-' + variant,
                            level, 'diagnostic', False, clock, caller, run, env)
                        wanted = (0, None, None) if variant == 'extra-cleanup' else (79, '', 'service storage not released\n')
                        row = run([probe, 64, 0, 1], wanted, env)
                        if variant == 'extra-cleanup':
                            decode_output(row['stdout'], 64, 0, 1)
                            actual = decode(row['stderr'])
                            expected = dict(readings['64-0']['counts'])
                            expected['pushes'] += 1
                            expected['pops'] += 1
                            assert actual == expected, (actual, expected)
                        report['controls'].append(dict(role=role, level=level, variant=variant,
                                                       build=linked['index'], command=row['index']))
                    except Exception as error:
                        failure(key + '/' + variant, error)
                    save()
    for level in (1, 2):
        for population, mode in CASES:
            key = f'{population}-{mode}'
            try:
                reference = report['cases'][f'reference-O{level}'][key]['counts']
                candidate = report['cases'][f'candidate-O{level}'][key]['counts']
                result = compare(reference, candidate)
                report['comparisons'][f'O{level}/{key}'] = result
                print('RESULT', level, key, json.dumps(result), flush=True)
            except Exception as error:
                failure(f'comparison O{level}/{key}', error)
    save()
    (folder / 'manifest.json').write_text(json.dumps(
        {str(path.relative_to(folder)): digest(path) for path in sorted(folder.rglob('*')) if path.is_file()}, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['builds']) == 4 and len(report['controls']) == 8
    assert len(report['comparisons']) == 16 and len(report['selection']) == 4


if __name__ == '__main__':
    main()
