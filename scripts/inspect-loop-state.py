#!/usr/bin/env python3
"""Verify array results and retain GCC's loop-state representation; no timing claim."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import subprocess

SPEC = importlib.util.spec_from_file_location('kernel_measurement', Path(__file__).with_name('measure-kernel-baselines.py'))
MEASURE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(MEASURE)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['compiler', 'cc', 'c-arch']:
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--timeout', type=int, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[platform.machine()]
    assert args.timeout == 180
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_STACK='1', FWP_LTO='0')
    environment.pop('FWP_NO_OPT', None)
    compiler = Path(args.compiler).resolve()

    def run(command, name):
        command = list(map(str, command))
        try:
            result = subprocess.run(command, env=environment, capture_output=True, timeout=args.timeout)
        except subprocess.TimeoutExpired as error:
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        (output / (name + '.stdout')).write_bytes(result.stdout)
        (output / (name + '.stderr')).write_bytes(result.stderr)
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode,
                stdout=name+'.stdout', stderr=name+'.stderr')) + '\n')
        assert result.returncode == 0 and not result.stderr, (command, result)
        return result.stdout

    version = run([args.cc, '--version'], 'compiler-version').decode()
    assert 'gcc' in version.lower()
    program = output / 'kernel.fwp'
    program.write_text('export reduce64 : Array[F64] -> F64\nreduce64 = array.map (mul 3.0) | array.map (add 1.0) | array.fold add -0.0\n')
    emitted = output / 'generated.c'
    run([compiler, 'build', '--fn', 'reduce64', '--emit-c', program, '-o', emitted], 'emit')
    generated = emitted.read_text()
    marker = generated.index('/* reduce64 :')
    entry = 'f' + generated[marker:].split('static V f', 1)[1].split('(', 1)[0]
    assert re.search(r'typedef struct \{ V v0; V v1; double v2; \} fwp_loop_state\d+;', generated)
    results = {}
    for count in [65537, 262145]:
        dimensions = (count, 65, 67, 63)
        expected = [MEASURE.BASELINE.array_result(count, r) for r in range(8)]
        values = MEASURE.BASELINE.verification_output([[value] for value in expected])
        source = output / f'array-{count}.c'
        source.write_text(MEASURE.native_source(generated, entry, dimensions, False, False, True))
        binary = output / f'array-{count}.exe'
        report = output / f'array-{count}-optimized.txt'
        run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch,
             '-w', '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=0', '-DMATRIX_BENCH=0',
             '-fdump-tree-optimized=' + str(report), source, '-o', binary, '-lm', '-lpthread'],
            f'array-{count}-build')
        observed = run([binary], f'array-{count}-output')
        actual = b'\n'.join(re.findall(rb'^\d+:\d+:[0-9a-f]{16}$', observed, re.M)) + b'\n'
        assert actual == values
        samples = json.loads(re.sub(rb'^\d+:\d+:[0-9a-f]{16}\n', b'', observed, flags=re.M))['samples']
        assert len(samples) == 1 and samples[0]['liveChargedBytes'] == 0
        assert samples[0]['hash'] == MEASURE.BASELINE.result_hash([[value] for value in expected])
        results[str(count)] = dict(binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
            sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(),
            optimizedTreeSha256=hashlib.sha256(report.read_bytes()).hexdigest(),
            resultBits=expected, liveChargedBytes=0)
        (output / 'results.json').write_text(json.dumps(dict(source=os.environ['GITHUB_SHA'],
            decision='representation-and-correctness-only', results=results), indent=2)+'\n')
    print('Both array sizes match the exact oracle and release all storage; no speed claim')


if __name__ == '__main__':
    main()
