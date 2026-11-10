#!/usr/bin/env python3
"""Prepare a counter-only compiler or compare its emitted C with ordinary compilation."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess
import traceback

from compiler_scaling import APPLICATIONS, ROOT, cases, program
import nested_resource_analysis
import resource_field_census
from process_wait import run_capture


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--kind', choices=('nested-borrows', 'plain-fields'), required=True)
    modes = parser.add_subparsers(dest='mode', required=True)
    prepare = modes.add_parser('prepare')
    prepare.add_argument('--checkout', type=Path, required=True)
    prepare.add_argument('--output', type=Path, required=True)
    measure = modes.add_parser('measure')
    measure.add_argument('--compiler', type=Path, required=True)
    measure.add_argument('--ordinary', type=Path, required=True)
    measure.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    relative, observer = {
        'nested-borrows': ('src/cgen/resource_borrows.rs', nested_resource_analysis),
        'plain-fields': ('src/cgen.rs', resource_field_census),
    }[args.kind]
    args.output.mkdir(parents=True, exist_ok=False)
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    if args.mode == 'prepare':
        checkout = args.checkout.resolve()
        assert checkout != ROOT
        assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=checkout, text=True).strip() == source
        subprocess.run(['git', 'diff', '--exit-code', 'HEAD'], cwd=checkout, check=True)
        original = (ROOT / relative).read_text()
        assert (checkout / relative).read_text() == original
        observed = observer.instrument(original)
        (checkout / relative).write_text(observed)
        assert subprocess.check_output(['git', 'diff', '--name-only', 'HEAD'], cwd=checkout, text=True) == relative + '\n'
        patch = subprocess.check_output(['git', 'diff', 'HEAD'], cwd=checkout)
        (args.output / 'observer.patch').write_bytes(patch)
        (args.output / 'identity.json').write_text(json.dumps(dict(source=source, kind=args.kind, file=relative,
            originalSha256=digest(original.encode()), observedSha256=digest(observed.encode()), patchSha256=digest(patch)), indent=2) + '\n')
        return
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and os.environ['GITHUB_SHA'] == source
    compilers = dict(ordinary=args.ordinary.resolve(), observed=args.compiler.resolve())
    report = dict(source=source, kind=args.kind, compilerHashes={role: digest(path.read_bytes()) for role, path in compilers.items()},
                  scope='Counter-enabled compiler only; elapsed time is not measured or accepted.', cases={}, failures=[])
    env = {key: value for key, value in os.environ.items() if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    env.update(FWP_LTO='0', LC_ALL='C', CC='gcc')
    inputs = [(name, ROOT / path, []) for name, path in APPLICATIONS.items()]
    if args.kind == 'plain-fields':
        inputs.append(('exported-service', ROOT / APPLICATIONS['callbacks'], ['--fn', 'service']))
    for family, size in cases():
        path = args.output / f'{family}-{size}.fwp'
        path.write_text(program(family, size)[0])
        inputs.append((f'{family}-{size}', path.resolve(), []))
    for name, path, options in inputs:
        try:
            outputs = {}
            case = report['cases'][name] = dict(commands={}, observations=[])
            for role, compiler in compilers.items():
                generated = args.output.resolve() / f'{name}-{role}.c'
                memory = ['--memory', 'dynamic'] if args.kind == 'plain-fields' else []
                command = list(map(str, [compiler, 'build', '--emit-c', '-O2', *memory,
                                         *options, path, '-o', generated]))
                row = run_capture(command, cwd=ROOT, env=env, input_data=None, input_stream=None,
                                  timeout=180, text=True, encoding='utf-8', check=False)
                case['commands'][role] = dict(command=command, status=row.returncode, stdout=row.stdout, stderr=row.stderr)
                assert row.returncode == 0 and not row.stdout
                if role == 'ordinary':
                    assert not row.stderr
                else:
                    case['observations'] = observer.decode(row.stderr)
                outputs[role] = generated.read_bytes()
            assert outputs['ordinary'] == outputs['observed'], 'observer changed generated C'
            case['cSha256'] = digest(outputs['ordinary'])
            if args.kind == 'nested-borrows':
                case['emittedSelections'] = outputs['ordinary'].count(b'protected by enclosing frame')
                case['totals'] = {key: sum(row[key] for row in case['observations'])
                                  for key in (*nested_resource_analysis.COUNTERS, 'selected')}
                if name in ('callbacks', 'http'):
                    assert case['emittedSelections'] > 0 and case['totals']['selected'] > 0
            else:
                case['totals'] = resource_field_census.validate_contexts(
                    outputs['ordinary'].decode(), case['observations'])
                if name in ('callbacks', 'http'):
                    assert case['totals']['frames'] > 0
            print('RESULT', name, json.dumps(case['totals']), flush=True)
        except Exception:
            report['failures'].append(dict(case=name, error=traceback.format_exc()))
        (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    assert not report['failures'], report['failures']
    assert len(report['cases']) == len(inputs)


if __name__ == '__main__':
    main()
