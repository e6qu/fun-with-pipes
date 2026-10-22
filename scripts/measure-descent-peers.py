#!/usr/bin/env python3
"""Measure reverse AD, list/packed explicit derivatives and explicit C/Rust."""
import argparse
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import platform
import re
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('ad_application', ROOT / 'scripts/measure-ad-application.py')
AD = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AD)


def digest(data):
    return hashlib.sha256(data).hexdigest()


def packed_program(points, updates):
    point = ', '.join('-1.2' if i % 2 == 0 else '1.0' for i in range(points))
    return (ROOT / 'tests/fixtures/descent_packed.fwp').read_text() + f"""
solve : Array[F64] -> Array[F64]
solve = both (const {updates}) id | loop (if
    (.0 | eq 0)
    (.1 | Stop)
    (both (.0 | sub 1) (.1 | packed-descend) | Again))
main = [{point}] | array.from-list | solve | array.to-list | echo
"""


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--baseline-report', required=True, type=Path)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--c-arch', required=True, choices=['x86-64', 'armv8-a'])
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--nm', required=True)
    parser.add_argument('--time', required=True)
    parser.add_argument('--case', required=True, action='append', help='DIMENSIONS:UPDATES')
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--warmups', required=True, type=int)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--host', required=True)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.samples > 0 and args.samples % 10 == 0 and args.warmups > 0 and args.timeout > 0
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[platform.machine()]
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_AD_WORKSPACE='1',
                       FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    baseline_bytes = args.baseline_report.read_bytes()
    baseline = json.loads(baseline_bytes)
    baseline_host, = [host for host in baseline['hosts'] if host['host'] == args.host]
    assert baseline_host['source'] == baseline['source']
    assert baseline_host['report']['machine'] == platform.machine()
    commands = []
    cflags = ['-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off', '-march=' + args.c_arch]

    def run(command, env):
        result = subprocess.run(list(map(str, command)), cwd=ROOT, env=env,
                                capture_output=True, timeout=args.timeout)
        if result.returncode:
            raise RuntimeError(f'{command}: {result.returncode}: {result.stderr.decode(errors="replace")}')
        return result

    def build(command):
        start = time.perf_counter_ns()
        result = run(command, environment)
        commands.append(dict(command=list(map(str, command)), elapsedNs=time.perf_counter_ns() - start))
        return result

    def verify(raw, expected):
        values = json.loads(raw)
        assert len(values) == len(expected)
        assert all(math.isfinite(a) and math.isclose(a, b, abs_tol=1e-10, rel_tol=1e-10)
                   for a, b in zip(values, expected)), (values, expected)

    results = {}
    for case in args.case:
        points, updates = map(int, case.split(':'))
        assert 2 <= points <= 4096 and 0 <= updates <= 4091
        name = f'{points}-{updates}'
        assert name not in results
        directory = out / name
        directory.mkdir()
        expected = AD.analytic(points, updates + 1)
        binaries, outputs, metadata, profiles = {}, {}, {}, {}
        for label in ['fwp-ad', 'fwp-explicit', 'fwp-packed']:
            source = packed_program(points, updates) if label == 'fwp-packed' else AD.program(points, updates + 1, False)
            if label == 'fwp-explicit':
                assert source.count('(.1 | descend)') == 1
                source = source.replace('(.1 | descend)', '(.1 | explicit-descend)')
                source = (ROOT / 'tests/fixtures/descent_explicit.fwp').read_text() + '\n' + source
            fwp_source = directory / (label + '.fwp')
            fwp_source.write_text(source)
            reference = run([args.compiler.resolve(), 'run', '--interp', fwp_source],
                            dict(environment, FWP_NO_OPT='1'))
            verify(reference.stdout, expected)
            assert not reference.stderr
            code = directory / (label + '.c')
            build([args.compiler.resolve(), 'build', '--gc', 'arc', '--emit-c', '-O2', fwp_source, '-o', code])
            text = code.read_text()
            assert '#define FWP_ARC_ONLY 1' in text
            binary = directory / label
            build([args.cc, *cflags, '-w', code, '-o', binary, '-lm', '-lpthread', '-ldl'])
            actual = run([binary], environment)
            assert actual.stdout == reference.stdout and not actual.stderr
            profiles_code = AD.RAW.instrument(AD.PROFILE.instrument(text))
            profiled_source = directory / (label + '-profile.c')
            profiled_source.write_text(profiles_code)
            profiled_binary = directory / (label + '-profile')
            build([args.cc, *cflags, '-w', profiled_source, '-o', profiled_binary, '-lm', '-lpthread', '-ldl'])
            profile = run([profiled_binary], environment)
            assert profile.stdout == actual.stdout
            managed, raw = [json.loads(line) for line in profile.stderr.splitlines()]
            assert managed['finalChargedBytes'] == managed['collections'] == 0
            raw = raw['rawDerivativeStorage']
            AD.RAW.check_profile(raw, updates if label == 'fwp-ad' else 0, True)
            (directory / (label + '-profile.stderr')).write_bytes(profile.stderr)
            raw_hash = digest(json.dumps(raw, sort_keys=True).encode())
            checkpoints = raw.pop('afterBackward')
            assert not checkpoints or all(value == checkpoints[0] for value in checkpoints)
            raw['afterBackwardRepeated'] = dict(count=len(checkpoints), value=checkpoints[0] if checkpoints else None)
            profiles[label] = dict(managed=managed, rawDerivativeStorage=raw, expandedRawSha256=raw_hash)
            binaries[label] = binary
            outputs[label] = actual.stdout
        csource = directory / 'c-explicit.c'
        csource.write_text(f'#define DIMENSIONS {points}\n#define UPDATES {updates}\n' +
                           (ROOT / 'tests/fixtures/descent_explicit.c').read_text())
        cbin = directory / 'c-explicit'
        build([args.cc, *cflags, '-Wall', '-Wextra', '-Werror', csource, '-o', cbin, '-lm'])
        rust_source = directory / 'rust-explicit.rs'
        rust_template = (ROOT / 'tests/fixtures/descent_explicit.rs').read_text()
        parameter_marker = '// Measurement parameters are inserted here.'
        assert rust_template.count(parameter_marker) == 1
        rust_source.write_text(rust_template.replace(parameter_marker,
            f'const DIMENSIONS: usize = {points};\nconst UPDATES: usize = {updates};'))
        rustbin = directory / 'rust-explicit'
        build([args.rustc, '--crate-name', 'descent_explicit', '--edition=2021', '-D', 'warnings', '-C', 'opt-level=2', '-C',
               'overflow-checks=yes', '-C', 'codegen-units=1', '-C', 'target-cpu=generic', '-C',
               'lto=off', rust_source, '-o', rustbin])
        binaries.update({'c-explicit': cbin, 'rust-explicit': rustbin})
        for label, binary in binaries.items():
            actual = run([binary], environment)
            verify(actual.stdout, expected)
            assert not actual.stderr
            outputs[label] = actual.stdout
            (directory / (label + '.stdout')).write_bytes(actual.stdout)
        for binary in sorted(directory.iterdir()):
            if not binary.is_file() or binary.read_bytes()[:4] != b'\x7fELF':
                continue
            raw = binary.read_bytes()
            assert raw[:6] == b'\x7fELF\x02\x01'
            assert int.from_bytes(raw[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
            symbols = run([args.nm, binary], environment).stdout
            if binary.name.startswith('fwp-'):
                assert not any(name in symbols for name in [b'fwp_gc_scan', b'fwp_gc_mark_all', b'fwp_gc_sweep'])
            assembly = run([args.objdump, '-d', binary], environment).stdout
            assert b'Disassembly of section' in assembly
            (directory / (binary.name + '.symbols')).write_bytes(symbols)
            (directory / (binary.name + '.asm')).write_bytes(assembly)
            source_path = binary.with_suffix('.rs' if binary.name == 'rust-explicit' else '.c')
            metadata[binary.name] = dict(bytes=len(raw), sha256=digest(raw), sourceSha256=digest(source_path.read_bytes()),
                                        disassemblySha256=digest(assembly))
        assert len(metadata) == 8
        labels = list(binaries)
        assert labels == ['fwp-ad', 'fwp-explicit', 'fwp-packed', 'c-explicit', 'rust-explicit']
        baseline_case = baseline_host['report']['results'][name]
        for label in ['fwp-ad', 'fwp-explicit']:
            assert profiles[label] == baseline_case['fwpProfiles'][label], (name, label, profiles[label], baseline_case['fwpProfiles'][label])
        # Requirements chosen before this comparison. Short controls retain all
        # extra setup costs; the repeated workloads must reduce allocation work.
        if updates >= 199:
            packed = profiles['fwp-packed']['managed']
            listed = profiles['fwp-explicit']['managed']
            assert packed['requests'] < listed['requests'], (name, packed, listed)
            assert packed['peakChargedBytes'] <= listed['peakChargedBytes'], (name, packed, listed)
        for _ in range(args.warmups):
            for label in labels:
                actual = run([binaries[label]], environment)
                assert actual.stdout == outputs[label] and not actual.stderr
        samples = {label: [] for label in labels}
        orders = []
        for round_number in range(args.samples):
            order = labels[round_number % len(labels):] + labels[:round_number % len(labels)]
            if round_number % (2 * len(labels)) >= len(labels):
                order.reverse()
            orders.append(order)
            for label in order:
                start = time.perf_counter_ns()
                actual = run([binaries[label]], environment)
                elapsed = time.perf_counter_ns() - start
                assert actual.stdout == outputs[label] and not actual.stderr
                samples[label].append(elapsed)
        medians = {label: statistics.median(values) for label, values in samples.items()}
        resident = {}
        for label in labels:
            observed = run([args.time, '-v', binaries[label]], environment)
            assert observed.stdout == outputs[label]
            match = re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', observed.stderr)
            assert match
            resident[label] = int(match[1]) * 1024
            (directory / (label + '-rss.txt')).write_bytes(observed.stderr)
        results[name] = dict(dimensions=points, updates=updates, oracle=expected,
            outputSha256={label: digest(value) for label, value in outputs.items()},
            samplesNs=samples, medianNs=medians, orders=orders,
            ratios={label: {peer: medians[label] / medians[peer] for peer in ['fwp-explicit', 'fwp-packed', 'c-explicit', 'rust-explicit']}
                    for label in ['fwp-ad', 'fwp-explicit', 'fwp-packed']},
            peakProcessRssBytes=resident, fwpProfiles=profiles, binaries=metadata)
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    paths = ['scripts/measure-descent-peers.py', 'scripts/measure-ad-application.py',
             'scripts/ad-storage-profile.py', 'scripts/measure-iteration.py',
             'tests/fixtures/ad_raw_storage_probe.c', 'tests/fixtures/descent_explicit.fwp',
             'tests/fixtures/descent_explicit.c', 'tests/fixtures/descent_explicit.rs',
             'tests/fixtures/descent_packed.fwp',
             'docs/tutorials/20-autodiff-and-devices/main.fwp']
    report = dict(source=os.environ['GITHUB_SHA'], host=args.host, machine=platform.machine(),
        cpu=run(['lscpu'], environment).stdout.decode(), cCompiler=run([args.cc, '--version'], environment).stdout.decode(),
        rustCompiler=run([args.rustc, '-Vv'], environment).stdout.decode(), commands=commands,
        configuration=vars(args) | {'compiler': str(args.compiler), 'output': str(args.output),
                                   'baseline_report': str(args.baseline_report)},
        baseline=dict(source=baseline['source'], run=baseline['run'], reportSha256=digest(baseline_bytes)),
        sourceHashes={name: digest((ROOT / name).read_bytes()) for name in paths}, results=results,
        scope='Five implementations of the same Rosenbrock descent and complete final vector. '
        'fwp-ad records and reverses derivatives; the other four use the explicit derivative. '
        'Comparing fwp-ad to a peer includes general AD work and representation costs, not pure compiler overhead. '
        'fwp-explicit uses immutable lists and intermediate pairs/lists; fwp-packed generates a packed array per update, '
        'reading the previous array at checked indices. C/Rust reuse two contiguous buffers. '
        'Explicit formulas preserve their multiplication order, but reverse AD may round differently. '
        'All outputs are checked against an independent Python derivative with absolute/relative tolerance 1e-10. '
        'Per-implementation timed outputs must repeat exactly. Inputs and update counts are compile-time constants. '
        'C/Rust/fwp formatting and allocation strategies differ. Timings include fresh-process startup, initialization, '
        'descent, complete output and teardown; compilation and instrumentation are excluded. '
        'The zero-update case includes initialization and formatting, so it is not pure startup time. '
        'Raw derivative buffers and managed charge are observed separately for fwp only. '
        'Separate uninstrumented process RSS includes all process storage; do not add it to allocation peaks. '
        'The original two fwp forms must reproduce the recorded managed/raw profiles exactly; timing peers '
        'are recompiled and remeasured together. All samples and compile commands are retained. '
        'For at least 199 updates, packed fwp must make fewer '
        'managed allocation requests with no higher managed peak than explicit-list fwp. Retains and timings '
        'are reported without a speed threshold; this is a program-representation experiment, not a compiler change.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: row['ratios'] for name, row in results.items()}, indent=2))


if __name__ == '__main__':
    main()
