#!/usr/bin/env python3
"""Compare explicit C aliasing contracts with the former value views on runners."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--fwp', type=Path, required=True)
    parser.add_argument('--cc', action='append', required=True)
    parser.add_argument('--optimization', action='append', required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'run compiler matrices on GitHub'
    args.output.mkdir(parents=True, exist_ok=True)
    source = Path('tests/fixtures/hash_capture_order.fwp').resolve()
    compiler = args.fwp.resolve()
    environment = dict(os.environ, FWP_TYPED_HASH='1', FWP_STACK='1',
                       FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    environment.pop('FWP_GC', None)

    def run(command, env):
        return subprocess.run(list(map(str, command)), env=env, capture_output=True,
                              text=True, timeout=120)

    reference = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1'))
    assert (reference.returncode, reference.stdout, reference.stderr) == (
        0, 'seed\ncapture\ninput\n7737125569037174274\n', '')
    report = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        platform=platform.platform(), machine=platform.machine(), sourceText=source.read_text(),
        expected=reference.stdout, compilers={}, cases=[],
        scope='Correctness comparison, not timing or a C/Rust benchmark. The same emitted program '
              'uses explicit aliasing views, former views, former views with alias analysis disabled, '
              'or only the object view marked as aliasing. Compilation and execution commands, '
              'outputs, errors and binary hashes are retained. Incorrect former output diagnoses '
              'the old representation; a compiler is not required to expose undefined behavior.')
    failures = []
    for memory in ['arc', 'tracing']:
        generated = args.output / (memory + '.c')
        emitted = run([compiler, 'build', '--gc', memory, '--emit-c', source, '-o', generated], environment)
        assert emitted.returncode == 0, emitted.stderr
        code = generated.read_text()
        marker = '__attribute__((__may_alias__)) '
        assert code.count(marker) == 5
        former = code.replace(marker, '')
        object_only = former.replace('typedef struct { uint32_t tag; uint32_t n; V f[]; } fwp_obj;',
                                     'typedef struct ' + marker + '{ uint32_t tag; uint32_t n; V f[]; } fwp_obj;')
        assert object_only != former
        for label, text, alias_flag in [
            ('views', code, '-fstrict-aliasing'),
            ('former', former, '-fstrict-aliasing'),
            ('former-no-strict', former, '-fno-strict-aliasing'),
            ('object-only', object_only, '-fstrict-aliasing'),
        ]:
            cfile = args.output / f'{memory}-{label}.c'
            cfile.write_text(text)
            for cc in args.cc:
                report['compilers'][cc] = run([cc, '--version'], environment).stdout
                for optimization in args.optimization:
                    binary = args.output / f'{memory}-{label}-{cc}{optimization}'
                    command = [cc, optimization, alias_flag, '-ffp-contract=off',
                               str(cfile), '-o', str(binary), '-lm', '-lpthread']
                    compiled = run(command, environment)
                    assert compiled.returncode == 0, compiled.stderr
                    actual = run([binary], environment)
                    matches = (actual.returncode, actual.stdout, actual.stderr) == (
                        reference.returncode, reference.stdout, reference.stderr)
                    report['cases'].append(dict(memory=memory, variant=label, compiler=cc,
                        optimization=optimization, command=command, status=actual.returncode,
                        stdout=actual.stdout, stderr=actual.stderr, matches=matches,
                        generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(),
                        binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest()))
                    if label in {'views', 'former-no-strict'} and not matches:
                        failures.append(binary.name)
                    if optimization == '-O2' and label in {'views', 'former'}:
                        assembly = run(['objdump', '-d', '--no-show-raw-insn', binary], environment)
                        assert assembly.returncode == 0, assembly.stderr
                        binary.with_suffix('.asm').write_text(assembly.stdout)
                    print(binary.name, 'matches interpreter:', matches, flush=True)
                    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    assert not failures, failures


if __name__ == '__main__':
    main()
