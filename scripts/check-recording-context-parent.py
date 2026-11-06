#!/usr/bin/env python3
"""Compare the disabled scope compiler with the delivered compiler's emitted C."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import subprocess

ROOT = Path(__file__).resolve().parents[1]
CASES = {
    'direct': '''record : I64 -> I64
record = fn node ->
    let first = ad.push node 1.0 -1 0.0
    in ad.push first 1.0 node 1.0
main = -1 | ad.scope record | echo
''',
    'nested': '''one : I64 -> I64
one = fn node -> ad.push node 1.0 -1 0.0
record : I64 -> I64
record = fn node ->
    let first = one node
    in one first
main = -1 | ad.scope record | echo
''',
    'branch': '''record : I64 -> I64
record = fn node ->
    node == -1 | match
        True -> ad.push node 1.0 -1 0.0
        False -> ad.push node 2.0 -1 0.0
main = -1 | ad.scope record | echo
''',
}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--parent', type=Path, required=True)
    parser.add_argument('--reference', type=Path, required=True)
    parser.add_argument('--parent-source', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(FWP_LTO='0', FWP_VRET='1', FWP_FRAME_FIELDS='1',
                       FWP_PACKED_ARRAYS='1', FWP_STACK='1', FWP_ARRAY_FUSION='1', LC_ALL='C')
    cases = dict(CASES, loops=(ROOT / 'tests/fixtures/ad_recording_context.fwp').read_text())
    report = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip(),
                  parentSource=args.parent_source, cases={}, compilers={})
    compilers = {'parent': args.parent.resolve(), 'reference': args.reference.resolve()}
    for kind, compiler in compilers.items():
        report['compilers'][kind] = hashlib.sha256(compiler.read_bytes()).hexdigest()
    for name, program in cases.items():
        path = args.output / (name + '.fwp')
        path.write_text(program)
        for mode in ('raw', 'optimized'):
            label = name + '-' + mode
            generated = {}
            for kind, compiler in compilers.items():
                output = args.output / (label + '-' + kind + '.c')
                command = [str(compiler), 'build', '--memory', 'dynamic', '--emit-c', '-O2', str(path), '-o', str(output)]
                settings = dict(environment)
                if mode == 'raw':
                    settings['FWP_NO_OPT'] = '1'
                result = subprocess.run(command, env=settings, capture_output=True, timeout=180)
                (args.output / (label + '-' + kind + '.stdout')).write_bytes(result.stdout)
                (args.output / (label + '-' + kind + '.stderr')).write_bytes(result.stderr)
                assert result.returncode == 0 and not result.stdout and not result.stderr, (label, kind, result)
                generated[kind] = output.read_bytes()
            assert generated['parent'] == generated['reference'], (label, 'disabled scopes changed delivered C')
            report['cases'][label] = hashlib.sha256(generated['reference']).hexdigest()
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print('Eight raw/optimized direct, nested, loop and branch C comparisons match')


if __name__ == '__main__':
    main()
