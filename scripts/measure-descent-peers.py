#!/usr/bin/env python3
"""Refresh current-source AD/history, list/packed explicit, and C/Rust costs."""
import argparse
from collections import Counter
import hashlib
import importlib.util
import json
import math
import operator
import os
from pathlib import Path
import platform
import random
import re
import shutil
import signal
import statistics
import subprocess
import time

from process_wait import communicate, run_capture

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('ad_application', ROOT / 'scripts/measure-ad-application.py')
AD = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AD)
PHASE_SPEC = importlib.util.spec_from_file_location('descent_phases', ROOT / 'scripts/descent-phases.py')
PHASE = importlib.util.module_from_spec(PHASE_SPEC)
PHASE_SPEC.loader.exec_module(PHASE)
BASELINE_SPEC = importlib.util.spec_from_file_location('descent_baselines', ROOT / 'scripts/descent-baselines.py')
BASELINE = importlib.util.module_from_spec(BASELINE_SPEC)
BASELINE_SPEC.loader.exec_module(BASELINE)


def verify(raw, expected, solves):
    lines = raw.splitlines()
    assert len(lines) == solves
    for line in lines:
        values = json.loads(line)
        assert len(values) == len(expected)
        assert all(math.isfinite(a) and math.isclose(a, b, abs_tol=1e-10, rel_tol=1e-10)
                   for a, b in zip(values, expected)), (values, expected)
    assert all(line == lines[0] for line in lines), 'repeated solve changed its output'

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


def measurement_orders(labels, samples, seed):
    """Balance positions and every immediate predecessor within each round."""
    assert len(labels) == len(set(labels)) == 7 and samples > 0 and samples % 14 == 0
    base = [0, 1, 6, 2, 5, 3, 4]
    forward = [[labels[(index + shift) % 7] for index in base] for shift in range(7)]
    block = forward + [list(reversed(row)) for row in forward]
    assert all(Counter(row[position] for row in block) == Counter({label: 2 for label in labels})
               for position in range(7))
    assert Counter((a, b) for row in block for a, b in zip(row, row[1:])) == Counter(
        {(a, b): 2 for a in labels for b in labels if a != b})
    rng = random.Random(seed)
    orders = []
    for _ in range(samples // 14):
        shuffled = list(block)
        rng.shuffle(shuffled)
        orders.extend(shuffled)
    return orders


def ownership_budget_failures(profiles, baseline):
    """Report every violated storage/count requirement without weakening it."""
    checks = [('fwp-packed-baseline', 'accepted profile', 'equal',
               profiles['fwp-packed-baseline'], baseline['fwp-packed'])]
    for label in ['fwp-ad', 'fwp-explicit', 'fwp-packed']:
        current, old = profiles[label], baseline[label]
        for key in ['rawDerivativeStorage', 'expandedRawSha256']:
            checks.append((label, key, 'equal', current[key], old[key]))
        for key in ['requests', 'requestedBytes', 'finalChargedBytes']:
            checks.append((label, key, 'equal', current['managed'][key], old['managed'][key]))
        for key in ['retains', 'peakChargedBytes']:
            checks.append((label, key, 'at most', current['managed'][key], old['managed'][key]))
    compare = {'equal': operator.eq, 'at most': operator.le}
    return [dict(program=label, metric=metric, requirement=rule, actual=actual, expected=expected)
            for label, metric, rule, actual, expected in checks if not compare[rule](actual, expected)]


def paired_budget_failures(results, comparison):
    """Apply the selected pre-candidate limits and report every violation."""
    assert comparison in {'scalar-recording', 'eager-captures', 'array-lists'}
    failures = []

    def require(case, program, metric, actual, limit):
        if actual > limit:
            failures.append(dict(case=case, program=program, metric=metric, actual=actual, limit=limit))

    for case, row in results.items():
        medians = row['medianNs']
        ratio = medians['fwp-ad'] / medians['fwp-ad-identical']
        require(case, 'fwp-ad', 'identical median variation', max(ratio, 1 / ratio), 1.02)
        nodes = 8 * (row['dimensions'] - 1) * row['updates'] * row['solvesPerProcess']
        for label in ['fwp-ad', 'fwp-ad-history']:
            reference = label + '-reference'
            current, old = (row['fwpProfiles'][name] for name in [label, reference])
            require(case, label, 'candidate/reference time', medians[label] / medians[reference],
                    1.02 if comparison == 'array-lists' else 0.95 if row['updates'] else 1.02)
            savings = ([('requests', nodes), ('requestedBytes', 40 * nodes)]
                       if comparison == 'scalar-recording' else [('requests', int(row['updates'] > 0))])
            if comparison == 'array-lists':
                cells = row['dimensions'] * row['updates'] * row['solvesPerProcess']
                savings = [('requests', cells), ('requestedBytes', 24 * cells)]
            for key, saving in savings + [('retains', 0), ('peakChargedBytes', 0), ('finalChargedBytes', 0)]:
                limit = 0 if key == 'finalChargedBytes' else old['managed'][key] - saving
                require(case, label, key, current['managed'][key], limit)
            for key in ['rawDerivativeStorage', 'expandedRawSha256']:
                if current[key] != old[key]:
                    failures.append(dict(case=case, program=label, metric=key,
                                         actual=current[key], expected=old[key]))
            images = row['binaries']
            require(case, label, 'instruction bytes', images[label]['instructionBytes'],
                    images[reference]['instructionBytes'] + 1024)
            stacks = row['cCompilerStackUsage']
            def frame(name):
                return max(entry['bytes'] for entry in stacks[name + '.su']['entries'])
            require(case, label, 'largest static stack frame', frame(label), frame(reference) + 128)
    return failures


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--comparison', required=True, choices=['current', 'eager-captures', 'array-lists'])
    parser.add_argument('--reference-compiler', type=Path)
    parser.add_argument('--reference-manifest', type=Path)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--c-arch', required=True, choices=['x86-64', 'armv8-a'])
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--nm', required=True)
    parser.add_argument('--time', required=True)
    parser.add_argument('--case', required=True, action='append', help='DIMENSIONS:UPDATES:PROCESSES_PER_LABEL_PER_SAMPLE:SOLVES_PER_PROCESS')
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--warmups', required=True, type=int)
    parser.add_argument('--order-seed', required=True, type=int)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--phase-samples', required=True, type=int)
    parser.add_argument('--phase-warmups', required=True, type=int)
    parser.add_argument('--session', required=True, type=int, choices=[1, 2])
    parser.add_argument('--host', required=True)
    parser.add_argument('--qualification', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    paired = args.comparison != 'current'
    separate_compiler = paired and args.comparison != 'array-lists'
    assert bool(args.reference_compiler) == bool(args.reference_manifest) == separate_compiler
    reference_manifest = json.loads(args.reference_manifest.read_text()) if separate_compiler else None
    if separate_compiler:
        assert reference_manifest['source'] == os.environ['GITHUB_SHA']
        assert digest(args.reference_compiler.read_bytes()) == reference_manifest['compilerSha256']
        assert args.comparison == 'eager-captures'
        assert reference_manifest['candidateOptimizerSha256'] == digest((ROOT / 'src/opt.rs').read_bytes())
        assert reference_manifest['ownershipSha256'] == digest((ROOT / 'src/ownership.rs').read_bytes())
        assert reference_manifest['disabledTransformation'] == 'once-used eager capture bindings'
    fwp_labels = ['fwp-ad-history', 'fwp-ad', 'fwp-ad-history-reference', 'fwp-ad-reference'] if paired else [
        'fwp-ad-history', 'fwp-ad', 'fwp-explicit', 'fwp-packed']
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.samples > 0 and args.samples % 49 == 0 and args.warmups > 0 and args.timeout > 0
    assert args.phase_samples > 0 and args.phase_samples % 2 == 0 and args.phase_warmups > 0
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[platform.machine()]
    qualification = json.loads(args.qualification.read_text())
    assert qualification['qualified'] and not qualification['failures']
    assert qualification['source'] == os.environ['GITHUB_SHA']
    assert qualification['actual'] == qualification['expected']
    current_host, _ = BASELINE.host_details(args.cc, args.rustc)
    assert not BASELINE.host_failures(current_host, qualification['expected'])
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_AD_WORKSPACE='1',
                       FWP_PACKED_ARRAYS='1', FWP_STACK='1', FWP_ARRAY_FUSION='1')
    commands = []
    cflags = ['-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off', '-UFWP_NO_REUSE', '-fstack-usage', '-march=' + args.c_arch]

    def run(command, env):
        command = list(map(str, command))
        with subprocess.Popen(command, cwd=ROOT, env=env, stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE, start_new_session=True) as process:
            try:
                stdout, stderr = communicate(process, args.timeout, None)
            except BaseException:
                try:
                    os.killpg(process.pid, signal.SIGKILL)
                except ProcessLookupError:
                    pass
                stdout, stderr = process.communicate()
                (out / 'failed-command.json').write_text(json.dumps(dict(command=command,
                    status=process.returncode, stdout=stdout.decode(errors='replace'),
                    stderr=stderr.decode(errors='replace')), indent=2) + '\n')
                raise
        result = subprocess.CompletedProcess(command, process.returncode, stdout, stderr)
        if result.returncode:
            (out / 'failed-command.json').write_text(json.dumps(dict(command=command,
                status=result.returncode, stdout=stdout.decode(errors='replace'),
                stderr=stderr.decode(errors='replace')), indent=2) + '\n')
            raise RuntimeError(f'{command}: {result.returncode}: {stderr.decode(errors="replace")}')
        return result

    def build(command):
        start = time.perf_counter_ns()
        result = run(command, environment)
        commands.append(dict(command=list(map(str, command)), elapsedNs=time.perf_counter_ns() - start,
                             status=result.returncode, stdout=result.stdout.decode(errors='replace'),
                             stderr=result.stderr.decode(errors='replace')))
        (out / 'build-commands.json').write_text(json.dumps(commands, indent=2) + '\n')
        return result


    results = {}
    for case in args.case:
        points, updates, processes, solves = map(int, case.split(':'))
        assert 2 <= points <= 4096 and 0 <= updates <= 4091
        assert processes > 0 and processes % 7 == 0
        assert solves > 0 and updates * solves <= 8192
        name = f'{points}-{updates}'
        assert name not in results
        directory = out / name
        directory.mkdir()
        expected = AD.analytic(points, updates + 1)
        binaries, outputs, metadata, profiles, phase_binaries = {}, {}, {}, {}, {}
        controls = {}
        for label in fwp_labels:
            source = packed_program(points, updates) if label.startswith('fwp-packed') else AD.program(points, updates + 1, 'history' in label)
            if label == 'fwp-explicit':
                assert source.count('(.1 | descend)') == 1
                source = source.replace('(.1 | descend)', '(.1 | explicit-descend)')
                source = (ROOT / 'tests/fixtures/descent_explicit.fwp').read_text() + '\n' + source
            source = BASELINE.repeat_source(source, 'fwp', solves)
            fwp_source = directory / (label + '.fwp')
            fwp_source.write_text(source)
            reference = run([args.compiler.resolve(), 'run', '--interp', fwp_source],
                            dict(environment, FWP_NO_OPT='1'))
            verify(reference.stdout, expected, solves)
            assert not reference.stderr
            code = directory / (label + '.c')
            emitter = args.reference_compiler if separate_compiler and label.endswith('-reference') else args.compiler
            command = [emitter.resolve(), 'build', '--emit-c', '-O2', fwp_source, '-o', code]
            if args.comparison == 'array-lists':
                # The exact same compiler emits both variants. This explicit
                # build setting appears in the retained command, not timing.
                command = ['env', 'FWP_ARRAY_FUSION=' + ('0' if label.endswith('-reference') else '1'), *command]
            build(command)
            text = code.read_text()
            assert 'FWP_ARC_ONLY' not in text
            assert not re.search(r'^\s*#\s*define\s+FWP_NO_REUSE\b', text, re.M)
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
            (directory / (label + '-profile.stderr')).write_bytes(profile.stderr)
            assert profile.stdout == actual.stdout
            managed, raw = [json.loads(line) for line in profile.stderr.splitlines()]
            assert managed['finalChargedBytes'] == 0
            assert set(managed) == {'requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'}
            raw = raw['rawDerivativeStorage']
            AD.RAW.check_profile(raw, updates * solves if label.startswith('fwp-ad') else 0, True)
            raw_hash = digest(json.dumps(raw, sort_keys=True).encode())
            checkpoints = raw.pop('afterBackward')
            assert not checkpoints or all(value == checkpoints[0] for value in checkpoints)
            raw['afterBackwardRepeated'] = dict(count=len(checkpoints), value=checkpoints[0] if checkpoints else None)
            profiles[label] = dict(managed=managed, rawDerivativeStorage=raw, expandedRawSha256=raw_hash)
            if label.startswith('fwp-ad'):
                phase_code = directory / (label + '-phases.c')
                phase_code.write_text(PHASE.instrument(text))
                phase_binary = directory / (label + '-phases')
                build([args.cc, *cflags, '-w', phase_code, '-o', phase_binary, '-lm', '-lpthread', '-ldl'])
                phase_binaries[label] = phase_binary
                without = run([profiled_binary], dict(environment, FWP_AD_WORKSPACE='0'))
                assert without.stdout == actual.stdout
                (directory / (label + '-no-workspace.stderr')).write_bytes(without.stderr)
                no_managed, no_raw = [json.loads(line) for line in without.stderr.splitlines()]
                assert no_managed['finalChargedBytes'] == 0
                AD.RAW.check_profile(no_raw['rawDerivativeStorage'], updates * solves, False)
                profiles[label]['withoutWorkspace'] = dict(managed=no_managed, **no_raw)
                assert no_managed == managed, 'workspace selection changed managed ownership'
                if label == 'fwp-ad' and updates == 1:
                    broken_sources = {
                        'missing-parent-free': (AD.RAW.replace_once(profiles_code,
                            'ad_raw_free(b->pa);', '/* deliberate missing physical release */'),
                            232, b'unreleased raw derivative storage'),
                        'missing-result-phase': (AD.RAW.replace_once(phase_code.read_text(),
                            '    descent_phase_step(DESCENT_RESULT);', ''),
                            233, b'incomplete or unsupported phase sequence'),
                    }
                    for control_name, (broken, status, message) in broken_sources.items():
                        control_code = directory / (control_name + '.c')
                        control_code.write_text(broken)
                        control_binary = directory / control_name
                        build([args.cc, *cflags, '-w', control_code, '-o', control_binary, '-lm', '-lpthread', '-ldl'])
                        failed = run_capture([str(control_binary)], timeout=args.timeout,
                                     env=environment, cwd=None, input_data=None, input_stream=None,
                                     text=False, encoding='utf-8', check=False)
                        (directory / (control_name + '.stdout')).write_bytes(failed.stdout)
                        (directory / (control_name + '.stderr')).write_bytes(failed.stderr)
                        assert failed.returncode == status and message in failed.stderr, failed
                        controls[control_name] = dict(status=failed.returncode,
                            stdoutSha256=digest(failed.stdout), stderr=failed.stderr.decode())
            binaries[label] = binary
            outputs[label] = actual.stdout
        csource = directory / 'c-explicit.c'
        csource.write_text(BASELINE.repeat_source(f'#define DIMENSIONS {points}\n#define UPDATES {updates}\n' +
                           (ROOT / 'tests/fixtures/descent_explicit.c').read_text(), 'c', solves))
        cbin = directory / 'c-explicit'
        build([args.cc, *cflags, '-Wall', '-Wextra', '-Werror', csource, '-o', cbin, '-lm'])
        rust_source = directory / 'rust-explicit.rs'
        rust_template = (ROOT / 'tests/fixtures/descent_explicit.rs').read_text()
        parameter_marker = '// Measurement parameters are inserted here.'
        assert rust_template.count(parameter_marker) == 1
        rust_source.write_text(BASELINE.repeat_source(rust_template.replace(parameter_marker,
            f'const DIMENSIONS: usize = {points};\nconst UPDATES: usize = {updates};'), 'rust', solves))
        rustbin = directory / 'rust-explicit'
        build([args.rustc, '--crate-name', 'descent_explicit', '--edition=2021', '-D', 'warnings', '-C', 'opt-level=2', '-C',
               'overflow-checks=yes', '-C', 'codegen-units=1', '-C', 'target-cpu=generic', '-C',
               'lto=off', rust_source, '-o', rustbin])
        binaries.update({'c-explicit': cbin, 'rust-explicit': rustbin})
        # Same bytes under a second name expose timing differences unrelated to code.
        control = directory / 'fwp-ad-identical'
        shutil.copyfile(binaries['fwp-ad'], control)
        control.chmod(binaries['fwp-ad'].stat().st_mode)
        shutil.copyfile(directory / 'fwp-ad.c', directory / 'fwp-ad-identical.c')
        assert control.read_bytes() == binaries['fwp-ad'].read_bytes()
        binaries['fwp-ad-identical'] = control
        for label, binary in binaries.items():
            actual = run([binary], environment)
            verify(actual.stdout, expected, solves)
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
                assert not any(name in symbols for name in [b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'])
            assembly = run([args.objdump, '-d', binary], environment).stdout
            assert b'Disassembly of section' in assembly
            (directory / (binary.name + '.symbols')).write_bytes(symbols)
            (directory / (binary.name + '.asm')).write_bytes(assembly)
            section_output = run([args.objdump, '-h', binary], environment).stdout
            if paired:
                (directory / (binary.name + '.sections')).write_bytes(section_output)
            text_bytes = sum(int(size, 16) for size in re.findall(
                rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', section_output, re.M))
            assert text_bytes > 0
            source_path = binary.with_suffix('.rs' if binary.name == 'rust-explicit' else '.c')
            metadata[binary.name] = dict(instructionBytes=text_bytes, bytes=len(raw), sha256=digest(raw), sourceSha256=digest(source_path.read_bytes()),
                                        disassemblySha256=digest(assembly))
        assert len(metadata) == (15 if paired else 13) + len(controls)
        assert metadata['fwp-ad-identical']['sha256'] == metadata['fwp-ad']['sha256']
        labels = list(binaries)
        assert labels == fwp_labels + ['c-explicit', 'rust-explicit', 'fwp-ad-identical']
        samples = {label: [] for label in labels}
        orders = [BASELINE.execution_order(labels, processes, number, args.order_seed)
                  for number in range(args.samples)]
        for phase, count in [('warmup', args.warmups), ('sample', args.samples)]:
            for number in range(count):
                order = BASELINE.execution_order(labels, processes, number, args.order_seed)
                totals = BASELINE.measure_round(order, binaries, outputs, environment, run,
                    directory / f'{phase}-{number:03d}.json')
                if phase == 'sample':
                    for label in labels:
                        samples[label].append(totals[label])
                    (directory / 'samples.json').write_text(json.dumps(dict(
                        orders=orders, samplesNs=samples, processesPerLabel=processes), indent=2) + '\n')
        medians = {label: statistics.median(values) for label, values in samples.items()}
        phase_observations = {}
        for label, diagnostic in phase_binaries.items():
            observations = []
            for phase, count in [('warmup', args.phase_warmups), ('sample', args.phase_samples)]:
                for number in range(count):
                    order = ['ordinary', 'diagnostic'] if number % 2 == 0 else ['diagnostic', 'ordinary']
                    for variant in order:
                        image = diagnostic if variant == 'diagnostic' else binaries[label]
                        started = time.perf_counter_ns()
                        observed = run([image], environment)
                        elapsed = time.perf_counter_ns() - started
                        assert observed.stdout == outputs[label]
                        if variant == 'diagnostic':
                            profile = json.loads(observed.stderr)
                            PHASE.check(profile, points, updates * solves)
                        else:
                            assert not observed.stderr
                            profile = None
                        observations.append(dict(phase=phase, round=number, variant=variant,
                            elapsedNs=elapsed, profile=profile, status=observed.returncode,
                            stdoutSha256=digest(observed.stdout), stderr=observed.stderr.decode()))
                    (directory / (label + '-phase-observations.json')).write_text(json.dumps(observations, indent=2) + '\n')
            med = {variant: statistics.median(row['elapsedNs'] for row in observations
                if row['phase'] == 'sample' and row['variant'] == variant)
                for variant in ['ordinary', 'diagnostic']}
            phase_observations[label] = dict(observations=observations, medianNs=med,
                diagnosticOverOrdinary=med['diagnostic'] / med['ordinary'])
        resident = {}
        for label in labels:
            observed = run([args.time, '-v', binaries[label]], environment)
            assert observed.stdout == outputs[label]
            match = re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', observed.stderr)
            assert match
            resident[label] = int(match[1]) * 1024
            (directory / (label + '-rss.txt')).write_bytes(observed.stderr)
        stack = {}
        for stack_file in sorted(directory.glob('*.su')):
            entries = []
            for line in stack_file.read_text().splitlines():
                location, size, qualifier = line.split('\t')
                entries.append(dict(location=location, bytes=int(size), qualifier=qualifier))
            assert entries
            stack[stack_file.name] = dict(sha256=digest(stack_file.read_bytes()), entries=entries)
        # Four fwp forms/profiles, two or four phase images, and C.
        assert len(stack) == (13 if paired else 11) + len(controls), stack.keys()
        results[name] = dict(dimensions=points, updates=updates, oracle=expected, processesPerLabel=processes, solvesPerProcess=solves,
            outputSha256={label: digest(value) for label, value in outputs.items()},
            samplesNs=samples, medianNs=medians, orders=orders,
            ratios={label: {peer: medians[label] / medians[peer] for peer in labels}
                    for label in fwp_labels},
            peakProcessRssBytes=resident, fwpProfiles=profiles, binaries=metadata, cCompilerStackUsage=stack,
            phaseObservations=phase_observations, controls=controls)
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
        print(f'{name}: outputs, cleanup, binaries and {args.samples} timing rounds recorded', flush=True)
    paths = ['scripts/descent-baselines.py', 'scripts/measure-descent-peers.py', 'scripts/measure-ad-application.py',
             'scripts/ad-storage-profile.py', 'scripts/measure-iteration.py', 'scripts/descent-phases.py',
             'tests/fixtures/descent_phases.c',
             'scripts/prepare-capture-reference.py', 'src/opt.rs', 'src/fuse.rs',
             'tests/fixtures/ad_raw_storage_probe.c', 'tests/fixtures/descent_explicit.fwp',
             'tests/fixtures/descent_explicit.c', 'tests/fixtures/descent_explicit.rs',
             'tests/fixtures/descent_packed.fwp', 'src/ownership.rs', 'src/escape.rs', 'src/cgen.rs', 'src/rc.rs', 'tests/boxed_projection_ownership.rs',
             'tests/fixtures/stack_array_projection.c', 'tests/array_element_ownership.rs',
             'tests/fixtures/array_capture_reads.fwp', 'tests/fixtures/array_capture_effects.fwp',
             'docs/tutorials/20-autodiff-and-devices/main.fwp']
    report = dict(source=os.environ['GITHUB_SHA'], host=args.host, machine=platform.machine(),
        qualification=qualification,
        settings={key: value for key, value in environment.items() if key.startswith('FWP_') or key == 'CC'},
        cpu=run(['lscpu'], environment).stdout.decode(), cCompiler=run([args.cc, '--version'], environment).stdout.decode(),
        rustCompiler=run([args.rustc, '-Vv'], environment).stdout.decode(), commands=commands,
        configuration={key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()},
        referenceCompiler=reference_manifest,
        sourceHashes={name: digest((ROOT / name).read_bytes()) for name in paths}, results=results,
        scope={
            'current': 'Six current-source implementations and one byte-identical AD-current control. ',
            'eager-captures': 'Current-source eager-capture comparison: reference compiler restores only constant-only capture hoisting; both compilers retain scalar recording stack storage. ',
            'array-lists': 'One current compiler with FWP_ARRAY_FUSION explicitly 1 versus 0. This toggles all numeric array fusion, including result formatting, so whole-solve differences are not attributed solely to gradient-list removal. Independent direct-boundary counts establish that removal. ',
        }[args.comparison] +
        ('Candidate and reference record and reverse the same derivatives; an identical candidate copy checks timing noise. '
         if paired else '') +
        'fwp AD-history retains every vector; AD-current retains current weights. Both record and reverse derivatives. ' +
        ('C/Rust reuse two contiguous buffers. ' if paired else
         'fwp explicit list and packed array forms use handwritten derivatives. C/Rust reuse two contiguous buffers. '
         'Packed fwp can recompute edge residuals that C/Rust compute once. ') +
        'All input/output vectors and update counts match; '
        'work, allocation and formatting strategies differ. No previous compiler or generated C is required. '
        'Each timed output matches its own checked reference exactly; the independent analytic tolerance is absolute/relative 1e-10. '
        'Times include one process launch, repeated independent solves with complete output, and teardown, excluding compilation/observers. '
        'Each solve starts from the original input. fwp repeats its source pipeline; C/Rust repeat input/gradient allocation and release. '
        'Runtime/constant initialization occurs once; per-solve time is amortized and does not describe standalone startup. '
        'Zero updates include construction and printing, not pure startup. Each sample sums multiple fresh processes per label. '
        'The rotated 49-entry cycle balances all cyclic predecessor pairs, including repeats, and positions over 49 samples. '
        'Actual round boundaries are retained separately; the flattened order is not perfectly balanced. '
        'All process times, output hashes, statuses and orders remain recorded; file writes and output checks are outside timing. '
        'Managed/raw allocation and peak RSS are separate observations and must not be added. '
        'Acceptance requires the explicit budget report and two independent sessions per architecture; '
        'these comparisons do not isolate pure compiler overhead.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: row['ratios'] for name, row in results.items()}, indent=2))
    if paired:
        failures = paired_budget_failures(results, args.comparison)
        (out / 'budget-failures.json').write_text(json.dumps(failures, indent=2) + '\n')
        assert not failures, json.dumps(failures, indent=2)


if __name__ == '__main__':
    main()
