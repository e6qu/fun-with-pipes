#!/usr/bin/env python3
"""Repeat complete saved numerical workloads inside each process to diagnose timing noise."""

import argparse
from collections import Counter
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import random
import re
import shutil
import statistics
import subprocess
import time
import zipfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('descent_peers', ROOT / 'scripts/measure-descent-peers.py')
PEERS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PEERS)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def edit_source(code, language, repetitions):
    """Repeat a complete workload, keeping initialization and teardown explicit."""
    assert repetitions > 0
    if language == 'fwp':
        # Only this saved pure numerical entry may bypass its one-shot CAF.
        assert re.findall(r'^static V caf[0-9]+\(void\)', code, re.M) == ['static V caf0(void)']
        assert 'static void fwp_init_consts(void) {\n}' in code
        old = '    V r = caf0();'
        new = f'    V r = FWP_UNIT; for (size_t batch = 0; batch < {repetitions}; ++batch) {{ r = f0(); }}'
    elif language == 'c':
        old = 'int main(void) {'
        new = 'static int workload(void) {'
    elif language == 'rust':
        old = 'fn main() -> io::Result<()> {'
        new = 'fn workload() -> io::Result<()> {'
    else:
        raise ValueError(language)
    assert code.count(old) == 1, (language, old)
    changed = code.replace(old, new)
    if language == 'c':
        changed += f'\nint main(void) {{ for (size_t batch = 0; batch < {repetitions}; ++batch) {{ int status = workload(); if (status) return status; }} return 0; }}\n'
    elif language == 'rust':
        changed += f'\nfn main() -> io::Result<()> {{ for _ in 0..{repetitions} {{ workload()?; }} Ok(()) }}\n'
    return changed


def observe_solves(code, mode):
    """Observe managed/raw live storage before each next solve can begin."""
    assert mode in {'checked', 'retained', 'retained-without-observer'}
    call = 'r = f0();'
    assert code.count(call) == 1
    assert 'iteration_start_charge=iteration_charge();iteration_active=1;' in code
    observation = r'''r = f0();
        double solve_managed = iteration_charge() - iteration_start_charge;
        size_t solve_raw = ad_raw_total();
        fprintf(stderr, "{\"solve\":%zu,\"managedLiveBytes\":%.0f,\"rawLiveBytes\":%zu}\n", batch + 1, solve_managed, solve_raw);
        if (solve_managed != 0 || solve_raw != 0) _Exit(225);'''
    if mode == 'retained-without-observer':
        observation = call
    changed = code.replace(call, observation)
    if mode != 'checked':
        start = '    V r = FWP_UNIT;'
        finish = '    /* Ownership observation point: before runtime teardown. */'
        assert changed.count(start) == changed.count(finish) == 1
        changed = changed.replace(start, '    V retained_until_end = fwp_rc_fresh(fwp_str_new("held", 4));\n' + start)
        changed = changed.replace(finish, '    FWP_KEEP_ALIVE(retained_until_end); fwp_rc_free_obj(retained_until_end);\n' + finish)
    return changed


def batch_orders(labels, samples, seed):
    assert len(labels) == len(set(labels)) == 6 and samples > 0 and samples % 6 == 0
    base = [0, 1, 5, 2, 4, 3]
    block = [[labels[(index + shift) % 6] for index in base] for shift in range(6)]
    assert all(Counter(row[position] for row in block) == Counter(labels) for position in range(6))
    assert Counter((a, b) for row in block for a, b in zip(row, row[1:])) == Counter({(a, b): 1 for a in labels for b in labels if a != b})
    rng = random.Random(seed)
    orders = []
    for _ in range(samples // 6):
        shuffled = list(block)
        rng.shuffle(shuffled)
        orders.extend(shuffled)
    return orders


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['baseline-report', 'baseline-archive', 'output']:
        parser.add_argument('--' + name, required=True, type=Path)
    for name in ['host', 'cc', 'rustc', 'c-arch', 'objdump', 'nm', 'time']:
        parser.add_argument('--' + name, required=True)
    for name in ['samples', 'warmups', 'order-seed', 'timeout', 'repetitions']:
        parser.add_argument('--' + name, required=True, type=int)
    parser.add_argument('--control-max-difference', required=True, type=float)
    parser.add_argument('--case', required=True, action='append')
    args = parser.parse_args()
    assert platform.system() == 'Linux' and args.samples > 0 and args.warmups > 0 and args.timeout > 0
    assert 0 < args.control_max_difference < 1 and args.repetitions > 0
    assert len(args.case) == len(set(args.case)) and '33:199' in args.case
    baseline_bytes = args.baseline_report.read_bytes()
    baseline = json.loads(baseline_bytes)
    host, = [row for row in baseline['hosts'] if row['host'] == args.host]
    archive_bytes = args.baseline_archive.read_bytes()
    assert digest(archive_bytes) == host['archiveSha256']
    assert host['report']['machine'] == platform.machine()
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[platform.machine()]
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_GC', None)
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fstack-usage', '-march=' + args.c_arch]
    commands = []

    def run(command):
        actual = subprocess.run([str(part) for part in command], env=environment,
                                capture_output=True, timeout=args.timeout)
        if actual.returncode:
            raise RuntimeError(f'{command}: {actual.returncode}: {actual.stderr.decode(errors="replace")}')
        return actual

    def build(command):
        start = time.perf_counter_ns()
        actual = run(command)
        commands.append(dict(command=[str(part) for part in command], elapsedNs=time.perf_counter_ns() - start,
                             stdout=actual.stdout.decode(), stderr=actual.stderr.decode()))

    labels = ['baseline', 'candidate', 'baseline-identical', 'candidate-identical', 'c-explicit', 'rust-explicit']
    results = {}
    with zipfile.ZipFile(args.baseline_archive) as archive:
        for case in args.case:
            points, updates = map(int, case.split(':'))
            name = f'{points}-{updates}'
            previous = host['report']['results'][name]
            assert previous['dimensions'] == points and previous['updates'] == updates
            directory = out / name
            directory.mkdir()
            profiles, binaries, outputs, metadata = {}, {}, {}, {}
            for mode, saved in [('baseline', 'fwp-packed-baseline'), ('candidate', 'fwp-packed')]:
                code = archive.read(name + '/' + saved + '.c').decode()
                profile_code = archive.read(name + '/' + saved + '-profile.c').decode()
                assert digest(code.encode()) == previous['binaries'][saved]['sourceSha256']
                assert digest(profile_code.encode()) == previous['binaries'][saved + '-profile']['sourceSha256']
                single_output = archive.read(name + '/' + saved + '.stdout')
                assert digest(single_output) == previous['outputSha256'][saved]
                expected = single_output * args.repetitions
                for profiled, original in [(False, code), (True, profile_code)]:
                    label = mode + ('-profile' if profiled else '')
                    source = directory / (label + '.c')
                    edited = edit_source(original, 'fwp', args.repetitions)
                    source.write_text(observe_solves(edited, 'checked') if profiled else edited)
                    binary = directory / label
                    build([args.cc, *flags, '-w', source, '-o', binary, '-lm', '-lpthread', '-ldl'])
                    actual = run([binary])
                    (directory / (label + '.stdout')).write_bytes(actual.stdout)
                    (directory / (label + '.stderr')).write_bytes(actual.stderr)
                    assert actual.stdout == expected
                    if profiled:
                        records = [json.loads(line) for line in actual.stderr.splitlines()]
                        observations = [row for row in records if 'solve' in row]
                        managed, raw = [row for row in records if 'solve' not in row]
                        assert observations == [dict(solve=i + 1, managedLiveBytes=0, rawLiveBytes=0)
                                                for i in range(args.repetitions)]
                        assert managed['retains'] == managed['finalChargedBytes'] == managed['collections'] == 0
                        single = previous['fwpProfiles'][saved]['managed']
                        assert managed['peakChargedBytes'] <= single['peakChargedBytes']
                        assert managed['requests'] <= single['requests'] * args.repetitions
                        assert managed['requestedBytes'] <= single['requestedBytes'] * args.repetitions
                        raw = raw['rawDerivativeStorage']
                        PEERS.AD.RAW.check_profile(raw, 0, True)
                        assert digest(json.dumps(raw, sort_keys=True).encode()) == previous['fwpProfiles'][saved]['expandedRawSha256']
                        profiles[mode] = dict(managed=managed, rawDerivativeStorage=raw, completedSolves=observations)
                    else:
                        assert not actual.stderr
                        binaries[label] = binary
                        outputs[label] = expected
            assert profiles['baseline'] == profiles['candidate']
            controls = {}
            if (points, updates) == (33, 199):
                for mode, saved in [('baseline', 'fwp-packed-baseline'), ('candidate', 'fwp-packed')]:
                    original = archive.read(name + '/' + saved + '-profile.c').decode()
                    for control in ['retained', 'retained-without-observer']:
                        label = mode + '-' + control
                        source = directory / (label + '.c')
                        source.write_text(observe_solves(edit_source(original, 'fwp', args.repetitions), control))
                        binary = directory / label
                        build([args.cc, *flags, '-w', source, '-o', binary, '-lm', '-lpthread', '-ldl'])
                        actual = subprocess.run([str(binary)], env=environment, capture_output=True, timeout=args.timeout)
                        (directory / (label + '.stdout')).write_bytes(actual.stdout)
                        (directory / (label + '.stderr')).write_bytes(actual.stderr)
                        (directory / (label + '.status')).write_text(str(actual.returncode) + '\n')
                        records = [json.loads(line) for line in actual.stderr.splitlines()]
                        if control == 'retained':
                            assert actual.returncode == 225 and len(records) == 1
                            assert records[0]['solve'] == 1 and records[0]['managedLiveBytes'] > 0 and records[0]['rawLiveBytes'] == 0
                        else:
                            assert actual.returncode == 0 and actual.stdout == outputs[mode]
                            managed, raw = records
                            assert managed['finalChargedBytes'] == raw['rawDerivativeStorage']['finalBytes'] == 0
                        controls[label] = dict(status=actual.returncode, observations=records)

            for label, extension in [('c-explicit', '.c'), ('rust-explicit', '.rs')]:
                source = directory / (label + extension)
                original = archive.read(name + '/' + label + extension)
                assert digest(original) == previous['binaries'][label]['sourceSha256']
                source.write_text(edit_source(original.decode(), 'c' if extension == '.c' else 'rust', args.repetitions))
                binary = directory / label
                if label == 'c-explicit':
                    build([args.cc, *flags, '-Wall', '-Wextra', '-Werror', source, '-o', binary, '-lm'])
                else:
                    build([args.rustc, '--crate-name', 'descent_explicit', '--edition=2021', '-D', 'warnings',
                           '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'codegen-units=1',
                           '-C', 'target-cpu=generic', '-C', 'lto=off', source, '-o', binary])
                actual = run([binary])
                single_output = archive.read(name + '/' + label + '.stdout')
                assert digest(single_output) == previous['outputSha256'][label]
                assert actual.stdout == single_output * args.repetitions and not actual.stderr
                binaries[label], outputs[label] = binary, actual.stdout
                (directory / (label + '.stdout')).write_bytes(actual.stdout)
            for original in ['baseline', 'candidate']:
                label = original + '-identical'
                binary = directory / label
                shutil.copyfile(binaries[original], binary)
                binary.chmod(binaries[original].stat().st_mode)
                shutil.copyfile(directory / (original + '.c'), directory / (label + '.c'))
                assert binary.read_bytes() == binaries[original].read_bytes()
                binaries[label], outputs[label] = binary, outputs[original]
                (directory / (label + '.stdout')).write_bytes(outputs[label])
            for binary in sorted(directory.iterdir()):
                if not binary.is_file() or binary.read_bytes()[:4] != b'\x7fELF':
                    continue
                raw = binary.read_bytes()
                assert raw[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(raw[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
                assembly = run([args.objdump, '-d', binary]).stdout
                headers = run([args.objdump, '-h', binary]).stdout
                symbols = run([args.nm, binary]).stdout
                if binary.name not in ['c-explicit', 'rust-explicit']:
                    assert not re.search(rb'\bfwp_gc_(?:scan|mark_all|sweep)\b', symbols)
                sizes = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', headers, re.M)
                assert sizes and b'Disassembly of section' in assembly
                (directory / (binary.name + '.asm')).write_bytes(assembly)
                (directory / (binary.name + '.symbols')).write_bytes(symbols)
                source = binary.with_suffix('.rs' if binary.name == 'rust-explicit' else '.c')
                metadata[binary.name] = dict(sha256=digest(raw), bytes=len(raw), sourceSha256=digest(source.read_bytes()),
                    disassemblySha256=digest(assembly), instructionBytes=sum(int(size, 16) for size in sizes))
            assert len(metadata) == (12 if controls else 8)
            orders = batch_orders(labels, args.samples, args.order_seed)
            for _ in range(args.warmups):
                for label in labels:
                    actual = run([binaries[label]])
                    assert actual.stdout == outputs[label] and not actual.stderr
            samples = {label: [] for label in labels}
            for order in orders:
                for label in order:
                    start = time.perf_counter_ns()
                    actual = run([binaries[label]])
                    elapsed = time.perf_counter_ns() - start
                    assert actual.stdout == outputs[label] and not actual.stderr
                    samples[label].append(elapsed)
            medians = {label: statistics.median(values) for label, values in samples.items()}
            resident = {}
            for label in labels:
                actual = run([args.time, '-v', binaries[label]])
                assert actual.stdout == outputs[label]
                match = re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', actual.stderr)
                assert match
                resident[label] = int(match[1]) * 1024
                (directory / (label + '-rss.txt')).write_bytes(actual.stderr)
            frames = {}
            for path in sorted(directory.glob('*.su')):
                entries = []
                for line in path.read_text().splitlines():
                    location, size, qualifier = line.split('\t')
                    entries.append(dict(location=location, bytes=int(size), qualifier=qualifier))
                assert entries
                frames[path.name] = dict(sha256=digest(path.read_bytes()), entries=entries)
            assert len(frames) == (9 if controls else 5)
            lifetime_controls = controls
            controls = {label: medians[label] / medians[label + '-identical'] for label in ['baseline', 'candidate']}
            ratios = {peer: medians['candidate'] / medians[peer] for peer in ['baseline', 'c-explicit', 'rust-explicit']}
            stable_controls = all(abs(value - 1) <= args.control_max_difference for value in controls.values())
            results[name] = dict(dimensions=points, updates=updates, profiles=profiles, binaries=metadata,
                outputSha256={label: digest(raw) for label, raw in outputs.items()}, samplesNs=samples, medianNs=medians,
                orders=orders, controlRatios=controls, ratios=ratios, controlsWithinBound=stable_controls,
                lifetimeControls=lifetime_controls,
                peakProcessRssBytes=resident, cCompilerStackUsage=frames)
            (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
            print(name, 'ratios', ratios, 'controls', controls, 'controls within bound', stable_controls, flush=True)
    report = dict(source=os.environ['GITHUB_SHA'], host=args.host, machine=platform.machine(),
        cpu=run(['lscpu']).stdout.decode(), cCompiler=run([args.cc, '--version']).stdout.decode(),
        rustCompiler=run([args.rustc, '-Vv']).stdout.decode(), commands=commands,
        configuration={key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()},
        baseline=dict(source=baseline['source'], run=baseline['run'], reportSha256=digest(baseline_bytes), archiveSha256=digest(archive_bytes)),
        sourceHashes={name: digest((ROOT / name).read_bytes()) for name in ['scripts/measure-descent-batches.py', 'scripts/measure-descent-peers.py']},
        results=results, scope='Saved-source diagnostic with repeated complete solves per process, including full output each time. '
        'fwp runtime initialization and teardown occur once, while each solve creates and releases its values. '
        'C/Rust also repeat their full allocation, calculation, output and release. This is distinct from the original single-solve process measurement. '
        'Compilation and instrumented profiles are excluded from timing. Both old/new fwp must have identical managed/raw profiles, '
        'zero final storage and zero retains; each managed peak is bounded by the corresponding single-solve profile. '
        'Each output must be the accepted complete output repeated exactly. Identical executable copies control unrelated variation. '
        'Report all samples and slowdowns; stable controls alone do not establish a repeatable compiler speed change.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
