#!/usr/bin/env python3
"""Compare stored descent history with a loop that retains only current weights."""
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
PROFILE_SPEC = importlib.util.spec_from_file_location(
    'iteration_profile', ROOT / 'scripts/measure-iteration.py')
PROFILE = importlib.util.module_from_spec(PROFILE_SPEC)
PROFILE_SPEC.loader.exec_module(PROFILE)
RAW_SPEC = importlib.util.spec_from_file_location(
    'ad_storage_profile', ROOT / 'scripts/ad-storage-profile.py')
RAW = importlib.util.module_from_spec(RAW_SPEC)
RAW_SPEC.loader.exec_module(RAW)


def analytic(points, count):
    """Independent handwritten derivative; not a timed language comparison."""
    values = [-1.2 if i % 2 == 0 else 1.0 for i in range(points)]
    for _ in range(count - 1):
        gradient = [0.0] * points
        for i in range(points - 1):
            residual = values[i + 1] - values[i] * values[i]
            gradient[i] += -400.0 * values[i] * residual - 2.0 * (1.0 - values[i])
            gradient[i + 1] += 200.0 * residual
        values = [value - 0.001 * delta for value, delta in zip(values, gradient)]
    return values


def program(points, count, history):
    tutorial = (ROOT / 'docs/tutorials/20-autodiff-and-devices/main.fwp').read_text()
    assert tutorial.count('soft :') == 1
    functions = tutorial.split('soft :', 1)[0]
    point = ', '.join('-1.2' if i % 2 == 0 else '1.0' for i in range(points))
    if history:
        solve = f'''solve : List[F64] -> List[F64]
solve = iterate {count} descend | last | match
    Some -> id
    None -> "descent needs at least one stored value" | prim.trap
'''
    else:
        solve = f'''solve : List[F64] -> List[F64]
solve = both (const {count - 1}) id | loop (if
    (.0 | eq 0)
    (.1 | Stop)
    (both (.0 | sub 1) (.1 | descend) | Again))
'''
    return functions + solve + f'''\nmain = [{point}] | solve | echo\n'''


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--nm', required=True)
    parser.add_argument('--time', required=True, help='GNU time for separate peak-RSS observations')
    parser.add_argument('--case', required=True, action='append', help='DIMENSIONS:STORED_VALUES')
    parser.add_argument('--warmups', required=True, type=int)
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--host', required=True)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.samples > 0 and args.samples % 8 == 0 and args.warmups > 0 and args.timeout > 0
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_AD_WORKSPACE='1',
                       FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    commands = []

    def run(command, env):
        result = subprocess.run(list(map(str, command)), cwd=ROOT, env=env,
                                capture_output=True, timeout=args.timeout)
        if result.returncode:
            raise RuntimeError(f'{command}: {result.returncode}: '
                               + result.stderr.decode(errors='replace'))
        return result

    def build(command):
        start = time.perf_counter_ns()
        result = run(command, environment)
        commands.append(dict(command=list(map(str, command)), elapsedNs=time.perf_counter_ns() - start))
        return result

    def verify(result, expected):
        values = json.loads(result.stdout)
        assert len(values) == len(expected)
        assert all(math.isfinite(value) and math.isclose(value, reference, rel_tol=1e-10, abs_tol=1e-10)
                   for value, reference in zip(values, expected)), (values, expected)

    results = {}
    for case in args.case:
        points, count = map(int, case.split(':'))
        assert points >= 2 and 1 <= count <= 8192
        name = f'{points}-{count}'
        assert name not in results
        directory = out / name
        directory.mkdir()
        expected = analytic(points, count)
        binaries, profiles, raw_profiles, no_workspace, metadata = {}, {}, {}, {}, {}
        reference = None
        for variant in ('history', 'loop'):
            source = directory / (variant + '.fwp')
            source.write_text(program(points, count, variant == 'history'))
            raw = run([args.compiler.resolve(), 'run', '--interp', source],
                      dict(environment, FWP_NO_OPT='1'))
            verify(raw, expected)
            assert not raw.stderr
            if reference is None:
                reference = raw.stdout
            assert raw.stdout == reference, (name, variant, raw)
            for mode in ('arc', 'tracing'):
                label = variant + '-' + mode
                code_path = directory / (label + '.c')
                build([args.compiler.resolve(), 'build', '--gc', mode, '--emit-c', '-O2',
                       source, '-o', code_path])
                code = code_path.read_text()
                profile_code = PROFILE.instrument(code)
                # Verify tape retirement at the observation point, before runtime shutdown.
                marker = '    iteration_active=0;'
                assert profile_code.count(marker) == 1
                profile_code = profile_code.replace(marker, '''    if(fwp_owned_tapes)exit(230);
    for(int64_t i=0;i<fwp_ntapes;i++)if(fwp_tapes[i].live)exit(231);
''' + marker)
                profile_code = RAW.instrument(profile_code)
                profiled = directory / (label + '-profile.c')
                profiled.write_text(profile_code)
                binary = directory / label
                profile_binary = directory / (label + '-profile')
                for cfile, executable in ((code_path, binary), (profiled, profile_binary)):
                    build([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', cfile,
                           '-o', executable, '-lm', '-lpthread', '-ldl'])
                symbols = run([args.nm, binary], environment).stdout
                if mode == 'arc':
                    assert not any(symbol in symbols for symbol in
                                   (b'fwp_gc_scan', b'fwp_gc_mark_all', b'fwp_gc_sweep'))
                raw_header = binary.read_bytes()[:20]
                assert raw_header[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(raw_header[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
                (directory / (label + '.symbols')).write_bytes(symbols)
                (directory / (label + '.asm')).write_bytes(run([args.objdump, '-d', binary], environment).stdout)
                actual = run([profile_binary], environment)
                assert actual.stdout == reference
                counts, raw_record = [json.loads(line) for line in actual.stderr.splitlines()]
                raw_counts = raw_record['rawDerivativeStorage']
                RAW.check_profile(raw_counts, count - 1, True)
                assert counts['finalChargedBytes'] == 0, (name, label, counts)
                if mode == 'arc':
                    assert counts['collections'] == 0
                profiles[label] = counts
                raw_profiles[label] = raw_counts
                (directory / (label + '-profile.stderr')).write_bytes(actual.stderr)
                uncached = run([profile_binary], dict(environment, FWP_AD_WORKSPACE='0'))
                assert uncached.stdout == reference
                uncached_managed, uncached_raw = [json.loads(line) for line in uncached.stderr.splitlines()]
                RAW.check_profile(uncached_raw['rawDerivativeStorage'], count - 1, False)
                assert uncached_managed == counts, (name, label, uncached_managed, counts)
                no_workspace[label] = uncached_raw['rawDerivativeStorage']
                (directory / (label + '-no-workspace.stderr')).write_bytes(uncached.stderr)
                metadata[label] = dict(bytes=binary.stat().st_size,
                                       sha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                                       cSha256=hashlib.sha256(code.encode()).hexdigest())
                binaries[label] = binary
                # Deliberately preserve a live registry flag after backward. Data buffers
                # still release normally; the independent observer must reject the flag.
                if mode == 'arc' and variant == 'loop' and count > 1:
                    release = 'fwp_tape tp = *t;\n    t->live = 0;'
                    assert profile_code.count(release) == 1
                    broken = directory / 'missing-retirement.c'
                    broken.write_text(profile_code.replace(release, 'fwp_tape tp = *t;'))
                    control = directory / 'missing-retirement'
                    build([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', broken,
                           '-o', control, '-lm', '-lpthread', '-ldl'])
                    failed = subprocess.run([str(control)], env=environment, capture_output=True,
                                            timeout=args.timeout)
                    assert failed.returncode == 231, failed
                    (directory / 'missing-retirement.stderr').write_bytes(failed.stderr)
                    # An orphaned allocation is absent from the runtime's tape
                    # pointers. The physical ledger must still detect it.
                    for control_name, release in [
                        ('missing-parent-free', 'ad_raw_free(b->pa);'),
                        ('missing-registry-free', 'ad_raw_free(fwp_tapes);'),
                    ]:
                        broken = directory / (control_name + '.c')
                        broken.write_text(RAW.replace_once(profile_code, release,
                                                          '/* deliberately omit physical release */'))
                        control = directory / control_name
                        build([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', broken,
                               '-o', control, '-lm', '-lpthread', '-ldl'])
                        failed = subprocess.run([str(control)], env=environment, capture_output=True,
                                                timeout=args.timeout)
                        assert failed.returncode == 232, failed
                        assert b'unreleased raw derivative storage' in failed.stderr, failed
                        (directory / (control_name + '.stderr')).write_bytes(failed.stderr)
        for _ in range(args.warmups):
            for binary in binaries.values():
                actual = run([binary], environment)
                assert actual.stdout == reference and not actual.stderr
        samples = {label: [] for label in binaries}
        labels = list(binaries)
        orders = []
        for round_number in range(args.samples):
            order = labels[round_number % 4:] + labels[:round_number % 4]
            if round_number % 8 >= 4:
                order = list(reversed(order))
            orders.append(order)
            for label in order:
                start = time.perf_counter_ns()
                actual = run([binaries[label]], environment)
                elapsed = time.perf_counter_ns() - start
                assert actual.stdout == reference and not actual.stderr
                samples[label].append(elapsed)
        medians = {label: statistics.median(values) for label, values in samples.items()}
        resident = {}
        for label, binary in binaries.items():
            # Uninstrumented executable, in a separate process outside timing.
            observed = run([args.time, '-v', binary], environment)
            assert observed.stdout == reference
            match = re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', observed.stderr)
            assert match, observed.stderr
            resident[label] = int(match[1]) * 1024
            (directory / (label + '-rss.txt')).write_bytes(observed.stderr)
        results[name] = dict(dimensions=points, storedValues=count, updates=count - 1,
                             samplesNs=samples, medianNs=medians, orders=orders,
                             loopOverHistory={mode: medians['loop-' + mode] / medians['history-' + mode]
                                              for mode in ('arc', 'tracing')},
                             managedProfiles=profiles, rawDerivativeProfiles=raw_profiles,
                             rawDerivativeProfilesWithoutWorkspace=no_workspace,
                             peakProcessRssBytes=resident, binaries=metadata,
                             output=reference.decode(), analyticReference=expected)
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    tracked = [Path(__file__), ROOT / 'scripts/measure-iteration.py',
               ROOT / 'scripts/ad-storage-profile.py', ROOT / 'tests/fixtures/ad_raw_storage_probe.c',
               ROOT / 'docs/tutorials/20-autodiff-and-devices/main.fwp']
    report = dict(source=os.environ['GITHUB_SHA'], host=args.host, machine=platform.machine(),
                  cpu=run(['lscpu'], environment).stdout.decode(),
                  compiler=run([args.cc, '--version'], environment).stdout.decode(),
                  commands=commands, configuration=dict(warmups=args.warmups, samples=args.samples, timeout=args.timeout),
                  environment={key: value for key, value in environment.items()
                                                   if key.startswith('FWP_')},
                  sourceHashes={str(path.relative_to(ROOT)): hashlib.sha256(path.read_bytes()).hexdigest()
                                for path in tracked}, results=results,
                  scope='Same fwp Rosenbrock objective and reverse-mode gradient, input and step size. '
                  'History stores N values including the initial point, so both execute N-1 updates. '
                  'Loop keeps only current weights. Raw interpreters and native outputs match exactly; '
                  'an independent analytic derivative is checked with relative/absolute tolerance 1e-10. '
                  'This is a program-structure comparison, not a compiler improvement or C/Rust overhead. '
                  'Timings include fresh-process startup, calculation, printing and teardown. '
                  'Compilation, raw interpretation and separate managed profiles are excluded. '
                  'Managed profiles and raw numeric derivative storage are separate ledgers. '
                  'Raw profiles track actual successful allocator requests and frees for registry, '
                  'parents, local derivatives and backward adjoints, including retained workspace. '
                  'They exclude allocator metadata, temporary realloc copies and stack storage. '
                  'Per-kind peaks need not coincide; do not add them to obtain a process peak. '
                  'Separate uninstrumented GNU-time runs report process peak RSS. '
                  'Timings explicitly enable workspace reuse; extra untimed profiles disable it. '
                  'Idle raw storage must be constant after each selected backward pass and zero '
                  'after actual shutdown. The finite repeated cases stay below tape-generation '
                  'exhaustion and do not establish bounds for arbitrary nesting or run lengths. '
                  'All timing samples are retained; no elapsed-time budget is set.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: row['loopOverHistory'] for name, row in results.items()}, indent=2))


if __name__ == '__main__':
    main()
