#!/usr/bin/env python3
"""Measure finite nested-derivative costs against explicit fwp formulas."""
import argparse
from decimal import Decimal
from fractions import Fraction
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import signal
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
PROFILE_SPEC = importlib.util.spec_from_file_location('iteration_profile', ROOT / 'scripts/measure-iteration.py')
PROFILE = importlib.util.module_from_spec(PROFILE_SPEC)
PROFILE_SPEC.loader.exec_module(PROFILE)
RAW_SPEC = importlib.util.spec_from_file_location('ad_raw_profile', ROOT / 'scripts/ad-storage-profile.py')
RAW = importlib.util.module_from_spec(RAW_SPEC)
RAW_SPEC.loader.exec_module(RAW)


def program(number, depth, scalar, variant):
    assert number in [1, 16, 128] and depth in [1, 2, 3]
    assert scalar in ['F64', 'F128'] and variant in ['ad', 'formula']
    suffix = 'f128' if scalar == 'F128' else ''
    source = ('quartic : t -> t where Ring[t], Dup[t]\n'
              'quartic = fork mul id id | fork mul id id\n'
              'loss : List[t] -> t where Ring[t], Dup[t]\n'
              'loss = map quartic | sum\n'
              f'point : I64 -> {scalar}\n'
              f'point = int.to-float | div {number}.0{suffix} | sub 0.5{suffix}\n')
    if variant == 'ad':
        stage = 'grad loss'
        for _ in range(depth - 1):
            stage = f'grad ({stage} | sum)'
    else:
        formula = {
            1: f'fork mul id (fork mul id id) | mul 4.0{suffix}',
            2: f'fork mul id id | mul 12.0{suffix}',
            3: f'mul 24.0{suffix}',
        }[depth]
        stage = f'map ({formula})'
    return source + f'main = range 0 {number} | map point | {stage} | echo\n'


def verify_output(output, number, depth, scalar):
    values = json.loads(output, parse_float=Decimal)
    assert len(values) == number
    for index, value in enumerate(values):
        x = Fraction(index, number) - Fraction(1, 2)
        expected = {1: 4 * x**3, 2: 12 * x**2, 3: 24 * x}[depth]
        if scalar == 'F128':
            assert Fraction(value) == expected, (index, value, expected)
        else:
            # F64's shortest decimal may omit digits of the exact binary value.
            assert float(value) == float(expected), (index, value, expected)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def instrument(code):
    observed = RAW.instrument(PROFILE.instrument(code))
    return RAW.replace_once(observed, '    iteration_active=0;',
        '    if(fwp_owned_tapes)exit(231);\n'
        '    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)exit(231);\n'
        '    iteration_active=0;')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--cxx', required=True)
    parser.add_argument('--c-arch', choices=['x86-64', 'armv8-a'], required=True)
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--nm', required=True)
    parser.add_argument('--warmups', type=int, required=True)
    parser.add_argument('--samples', type=int, required=True)
    parser.add_argument('--timeout', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.warmups > 0 and args.samples > 0 and args.samples % 2 == 0 and args.timeout > 0
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[platform.machine()]
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items() if not key.startswith('FWP_')}
    environment.update(CC=args.cc, CXX=args.cxx, FWP_STACK='1', FWP_REUSE='1', FWP_AD_WORKSPACE='0', FWP_LTO='0')
    commands = []

    def run(command, name, env, expected_status):
        started = time.perf_counter_ns()
        interrupted = None
        with subprocess.Popen(list(map(str, command)), env=env, stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE, start_new_session=True) as process:
            try:
                stdout, stderr = process.communicate(timeout=args.timeout)
            except BaseException as error:
                interrupted = error
                try:
                    os.killpg(process.pid, signal.SIGKILL)
                except ProcessLookupError:
                    pass
                stdout, stderr = process.communicate()
            result = subprocess.CompletedProcess(command, process.returncode, stdout, stderr)
        elapsed = time.perf_counter_ns() - started
        (out / (name + '.stdout')).write_bytes(result.stdout)
        (out / (name + '.stderr')).write_bytes(result.stderr)
        record = dict(command=list(map(str, command)), status=result.returncode, elapsedNs=elapsed,
                      stdoutSha256=digest(result.stdout), stderrSha256=digest(result.stderr),
                      interruption=str(interrupted) if interrupted is not None else None)
        commands.append(record)
        (out / 'commands.json').write_text(json.dumps(commands, indent=2) + '\n')
        if name.endswith('-build') and result.stderr:
            print(result.stderr.decode(errors='replace'), flush=True)
        if interrupted is not None:
            raise interrupted
        assert result.returncode == expected_status, (name, result.returncode, result.stderr.decode(errors='replace'))
        return result, record

    cflags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto',
              '-fstack-usage', f'-march={args.c_arch}', '-w']
    results, controls, exact_float = {}, {}, {}
    for scalar in ['F64', 'F128']:
        for depth in [1, 2, 3]:
            for number in [1, 16, 128]:
                case = f'{scalar}-depth{depth}-n{number}'
                programs = {}
                reference = None
                for variant in ['ad', 'formula']:
                    name = case + '-' + variant
                    source = out / (name + '.fwp')
                    source.write_text(program(number, depth, scalar, variant))
                    interpreted, _ = run([args.compiler.resolve(), 'run', '--interp', source],
                                         name + '-interp', dict(environment, FWP_NO_OPT='1'), 0)
                    assert not interpreted.stderr
                    verify_output(interpreted.stdout, number, depth, scalar)
                    if reference is None:
                        reference = interpreted.stdout
                    assert interpreted.stdout == reference, 'AD and formula output differ'
                    cfile = out / (name + '.c')
                    run([args.compiler.resolve(), 'build', '--memory', 'dynamic', '-O2', '--emit-c',
                         source, '-o', cfile], name + '-emit', environment, 0)
                    code = cfile.read_text()
                    companions = []
                    if '#define FWP_EXACT_FLOAT 1\n' in code:
                        for extension, compiler, flags in [
                            ('float.c', args.cc, ['-std=c11']),
                            ('float.cpp', args.cxx, ['-std=c++20', '-fno-exceptions', '-fno-rtti']),
                        ]:
                            emitted = cfile.with_suffix('.' + extension)
                            source_hash = digest(emitted.read_bytes())
                            if extension not in exact_float:
                                shared_source = out / ('exact.' + extension)
                                shared_source.write_bytes(emitted.read_bytes())
                                object_path = out / ('exact.' + extension + '.o')
                                float_flags = ['-O2', '-fno-fast-math', '-ffp-contract=off', '-fPIC',
                                    '-ffunction-sections', '-fdata-sections', '-fno-lto', '-fstack-usage',
                                    f'-march={args.c_arch}', *flags]
                                run([compiler, *float_flags, '-c', shared_source, '-o', object_path],
                                    'exact-' + extension + '-build', environment, 0)
                                exact_float[extension] = dict(sourceSha256=source_hash, object=str(object_path),
                                    objectSha256=digest(object_path.read_bytes()), flags=float_flags)
                            assert exact_float[extension]['sourceSha256'] == source_hash
                            companions.append(exact_float[extension]['object'])
                    observed = instrument(code)
                    profile_source = out / (name + '-profile.c')
                    profile_source.write_text(observed)
                    images = {}
                    for label, path in [('ordinary', cfile), ('profile', profile_source)]:
                        binary = out / (name + ('-profile' if label == 'profile' else ''))
                        run([args.cc, *cflags, path, *companions, '-o', binary, '-lm', '-lpthread', '-ldl'],
                            name + '-' + label + '-build', environment, 0)
                        executed, _ = run([binary], name + '-' + label + '-check', environment, 0)
                        assert executed.stdout == reference
                        raw = binary.read_bytes()
                        assert raw[:6] == b'\x7fELF\x02\x01'
                        assert int.from_bytes(raw[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
                        symbols, _ = run([args.nm, binary], name + '-' + label + '-symbols', environment, 0)
                        assert not any(symbol in symbols.stdout for symbol in
                                       [b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'])
                        assembly, _ = run([args.objdump, '-d', binary], name + '-' + label + '-asm', environment, 0)
                        assert b'Disassembly of section' in assembly.stdout
                        sections, _ = run([args.objdump, '-h', binary], name + '-' + label + '-sections', environment, 0)
                        instruction_bytes = sum(int(size, 16) for size in re.findall(
                            rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections.stdout, re.M))
                        assert instruction_bytes > 0
                        images[label] = dict(path=str(binary), bytes=len(raw), sha256=digest(raw),
                            sourceSha256=digest(path.read_bytes()), instructionBytes=instruction_bytes)
                        if label == 'profile':
                            managed, raw_profile = map(json.loads, executed.stderr.splitlines())
                            assert managed['finalChargedBytes'] == 0
                            storage = raw_profile['rawDerivativeStorage']
                            assert storage['finalBytes'] == 0
                            if variant == 'formula':
                                assert storage['peakBytes'] == 0 and not storage['afterBackward']
                            else:
                                last = storage['afterBackward'][-1]
                                assert last['otherBytes'] == last['workspaceBytes'] == 0
                                assert storage['beforeShutdownBytes'] == last['registryBytes']
                        else:
                            assert not executed.stderr
                    if variant == 'ad' and number == 1 and (scalar, depth) in [('F64', 1), ('F128', 2)]:
                        if scalar == 'F64':
                            broken = RAW.replace_once(observed, 'ad_raw_free(b->pa);', '(void)b->pa;')
                            expected_status = 232
                        else:
                            broken = RAW.replace_once(observed, 'fwp_mem_free(owner->weights);', '(void)owner->weights;')
                            expected_status = 0
                        broken_source = out / (name + '-missing-release.c')
                        broken_source.write_text(broken)
                        broken_image = out / (name + '-missing-release')
                        run([args.cc, *cflags, broken_source, *companions, '-o', broken_image, '-lm', '-lpthread', '-ldl'],
                            name + '-missing-release-build', environment, 0)
                        failure, observation = run([broken_image], name + '-missing-release', environment, expected_status)
                        assert failure.stdout == reference
                        if scalar == 'F64':
                            assert b'unreleased raw derivative storage' in failure.stderr
                        else:
                            broken_managed, broken_raw = map(json.loads, failure.stderr.splitlines())
                            assert broken_managed['finalChargedBytes'] > 0
                            assert broken_raw['rawDerivativeStorage']['finalBytes'] == 0
                        controls[name] = observation | dict(sourceSha256=digest(broken_source.read_bytes()),
                            binarySha256=digest(broken_image.read_bytes()))
                    programs[variant] = dict(images=images, managed=managed, raw=raw_profile,
                                             processWallNs=[], warmupWallNs=[])
                # Alternate AD/formula order. These short timings describe complete
                # processes, not accepted speedups or sustained kernel throughput.
                for phase, count in [('warmup', args.warmups), ('sample', args.samples)]:
                    for index in range(count):
                        order = ['ad', 'formula'] if index % 2 == 0 else ['formula', 'ad']
                        for variant in order:
                            result, record = run([programs[variant]['images']['ordinary']['path']],
                                f'{case}-{variant}-{phase}-{index}', environment, 0)
                            assert result.stdout == reference and not result.stderr
                            key = 'processWallNs' if phase == 'sample' else 'warmupWallNs'
                            programs[variant][key].append(record['elapsedNs'])
                for result in programs.values():
                    result['medianProcessWallNs'] = statistics.median(result['processWallNs'])
                results[case] = dict(scalar=scalar, depth=depth, inputs=number, programs=programs)
                (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
                print(case, 'outputs and cleanup verified', flush=True)
    stack = {path.name: dict(sha256=digest(path.read_bytes()), text=path.read_text())
             for path in sorted(out.glob('*.su'))}
    assert len(stack) == 76 and len(controls) == 2 and len(exact_float) == 2
    cpu, _ = run(['lscpu'], 'cpu', environment, 0)
    compiler, _ = run([args.cc, '--version'], 'cc', environment, 0)
    cpp, _ = run([args.cxx, '--version'], 'cxx', environment, 0)
    source, _ = run(['git', 'rev-parse', 'HEAD'], 'source', environment, 0)
    report = dict(source=source.stdout.decode().strip(), machine=platform.machine(), cpu=cpu.stdout.decode(),
        compiler=compiler.stdout.decode(), cxx=cpp.stdout.decode(), cflags=cflags, exactFloat=exact_float,
        settings={key: value for key, value in environment.items() if key.startswith('FWP_')},
        configuration=vars(args) | dict(compiler=str(args.compiler), output=str(args.output)),
        results=results, stack=stack, controls=controls,
        scope='First/second/third derivatives of sum(x^4), at x[i]=i/N-1/2 for N=1/16/128. '
        'F64 and F128 AD are compared with explicit formulas in current fwp, not C/Rust. '
        'Both produce the complete derivative vector. Dyadic inputs have exact analytic results; '
        'raw interpreter and native ordinary/profile outputs agree byte for byte. '
        'Managed allocations/counts and raw tape buffers are separate ledgers; both finish at zero. '
        'Workspace reuse is disabled in both variants. Counts include input construction and output. '
        'Code bytes and compiler stack estimates belong to actual ELF images. '
        'Uninstrumented timings include process startup, all work, output and shutdown. '
        'Small-process timing ratios are diagnostic, without noise qualification or speedup acceptance. '
        'These finite cases do not establish constant memory or cost for arbitrary nested AD.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
