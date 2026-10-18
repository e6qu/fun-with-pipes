#!/usr/bin/env python3
"""Runner-only numeric collection construction: fused versus ordinary fwp."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import random
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent


def run(command, environment):
    result = subprocess.run(list(map(str, command)), cwd=ROOT, env=environment,
                            capture_output=True, text=True, check=False)
    if result.returncode:
        raise RuntimeError(f'{command}: {result.returncode}\n{result.stdout}\n{result.stderr}')
    return result


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full evidence runs on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--compiler', required=True, type=Path,
                        help='Compiler executable; its own execution is excluded from program timing')
    options = parser.parse_args()
    out = options.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    spec = importlib.util.spec_from_file_location('iteration', ROOT / 'scripts/measure-iteration.py')
    iteration = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(iteration)
    windows = platform.system() == 'Windows'
    suffix = '.exe' if windows else ''
    compiler = options.compiler.resolve()
    assert compiler.is_file(), compiler
    compiler_hash = hashlib.sha256()
    with compiler.open('rb') as executable:
        for chunk in iter(lambda: executable.read(1024 * 1024), b''):
            compiler_hash.update(chunk)
    cc = os.environ['CC']
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-w']
    links = ['-lm', '-lws2_32', '-lshell32'] if windows else ['-lm', '-lpthread']
    env = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    env.pop('FWP_GC', None)
    env.pop('FWP_NO_OPT', None)
    cases = []
    for inputs in [32, 4096, 65536]:
        for kind, expression in [
            ('set', 'map (rem 257) | set.from-list | set.size'),
            ('map', 'map (fork (curry id) (rem 257) id) | map.from-list | map.get 5'),
        ]:
            source = out / f'{kind}-{inputs}.fwp'
            source.write_text(f'main = range 0 {inputs} | {expression} | echo\n')
            # The raw interpreter is the semantic reference, not a timing peer.
            reference = run([compiler, 'run', '--interp', source], dict(env, FWP_NO_OPT='1')).stdout
            expected = str(min(inputs, 257)) if kind == 'set' else f'Some {5 + ((inputs - 6) // 257) * 257}'
            assert reference == expected + '\n', (kind, inputs, reference)
            variants = {}
            for fused in ['0', '1']:
                label = f'{kind}-{inputs}-fused-{fused}'
                build_env = dict(env, FWP_MAP_BUILD=fused)
                cfile = out / (label + '.c')
                run([compiler, 'build', '--gc', 'arc', '-O2', '--emit-c', source, '-o', cfile], build_env)
                code = cfile.read_text()
                marker = ('/* numeric map: direct callback fields */' if kind == 'map'
                          else '/* numeric set: direct callback */')
                assert (marker in code) == (fused == '1')
                profile = out / (label + '-profile.c')
                profile.write_text(iteration.instrument(code))
                commands, compile_ns = [], []
                binary = out / (label + suffix)
                measured_binary = out / (label + '-profile' + suffix)
                for csource, executable in [(cfile, binary), (profile, measured_binary)]:
                    command = [cc, *flags, csource, '-o', executable, *links]
                    start = time.perf_counter_ns()
                    run(command, build_env)
                    compile_ns.append(time.perf_counter_ns() - start)
                    commands.append(list(map(str, command)))
                measured = run([measured_binary], env)
                assert measured.stdout == reference
                counters = json.loads(measured.stderr)
                assert counters['collections'] == 0 and counters['finalChargedBytes'] == 0
                assert counters['retains'] == 0
                # Retain assembly including compiler stack-size annotations,
                # plus the actual executable for independent disassembly.
                assembly = out / (label + '.s')
                assembly_command = [cc, *flags, '-S', cfile, '-o', assembly]
                run(assembly_command, build_env)
                variants[fused] = {
                    'binary': binary.name, 'binaryBytes': binary.stat().st_size,
                    'binarySha256': hashlib.sha256(binary.read_bytes()).hexdigest(),
                    'generatedSha256': hashlib.sha256(cfile.read_bytes()).hexdigest(),
                    'counters': counters, 'commands': commands,
                    'nativeCompileNs': compile_ns[0], 'profileCompileNs': compile_ns[1],
                    'assemblyCommand': list(map(str, assembly_command)), 'processWallNs': [],
                }
            # Compile both variants before timing; alternate randomized order.
            generator = random.Random(20261018)
            orders = []
            for _ in range(8):
                order = ['0', '1']
                generator.shuffle(order)
                orders.append(order)
                for fused in order:
                    binary = out / variants[fused]['binary']
                    start = time.perf_counter_ns()
                    actual = run([binary], env)
                    elapsed = time.perf_counter_ns() - start
                    assert actual.stdout == reference and not actual.stderr
                    variants[fused]['processWallNs'].append(elapsed)
            for variant in variants.values():
                variant['medianProcessWallNs'] = statistics.median(variant['processWallNs'])
            assert variants['1']['counters']['requests'] < variants['0']['counters']['requests']
            row = {'kind': kind, 'inputs': inputs, 'output': reference,
                   'sourceSha256': hashlib.sha256(source.read_bytes()).hexdigest(),
                   'executionOrder': orders, 'variants': variants,
                   'fusedToOrdinaryTimeRatio': variants['1']['medianProcessWallNs'] / variants['0']['medianProcessWallNs']}
            cases.append(row)
            # Preserve finished cases if a later workload fails.
            (out / 'cases.json').write_text(json.dumps(cases, indent=2) + '\n')
            print(kind, inputs, json.dumps({k: v['counters'] for k, v in variants.items()}), flush=True)
    report = {
        'source': run(['git', 'rev-parse', 'HEAD'], env).stdout.strip(),
        'hardware': platform.uname()._asdict(), 'processor': platform.processor(),
        'cpu': run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin'
                   else ['powershell', '-NoProfile', '-Command', 'Get-CimInstance Win32_Processor | Select-Object Name,NumberOfCores,NumberOfLogicalProcessors | Format-List'] if windows
                   else ['lscpu'], env).stdout,
        'compiler': run([cc, '--version'], env).stdout,
        'rustc': run(['rustc', '--version', '--verbose'], env).stdout,
        'fwpCompiler': {'path': str(compiler), 'sha256': compiler_hash.hexdigest()},
        'scope': 'Same fwp program and explicitly selected compiler with numeric collection fusion enabled or disabled, '
                 'checked ARC, native -O2, no tracing or reuse poisoning. Inputs are compiled constants; '
                 'range construction, callbacks, sorting, deduplication, one query, startup and output '
                 'are included in whole-process time. Both variants use the same map sorting algorithm. '
                 'The map keeps the last value for each duplicate key; the set keeps distinct keys. '
                 'Memory uses separate instrumented executables and includes main and shutdown; '
                 'charged storage excludes allocator capacity and process RSS. Eight samples per '
                 'variant use recorded randomized order; small inputs may be dominated by startup. '
                 'Native compilation times exclude fwp C generation; the compiler executable need not '
                 'itself be a release build to produce the measured native -O2 programs. No C/Rust timing parity, '
                 'universal speed threshold or register-placement claim follows from this report.',
        'cases': cases,
    }
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
