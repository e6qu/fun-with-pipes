#!/usr/bin/env python3
"""Compare complete fwp solves with coordinate-wise and edge-wise C/Rust peers."""

import argparse
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import platform
import re
import shutil
import statistics
import subprocess
import time
import zipfile

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('descent_batches', ROOT / 'scripts/measure-descent-batches.py')
BATCHES = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BATCHES)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def check_vectors(raw, expected, repetitions):
    lines = raw.splitlines()
    assert len(lines) == repetitions
    for line in lines:
        values = json.loads(line)
        assert isinstance(values, list) and len(values) == len(expected)
        assert all(type(value) in (int, float) for value in values)
        assert all(math.isfinite(a) and math.isclose(a, b, rel_tol=1e-10, abs_tol=1e-10)
                   for a, b in zip(values, expected)), (values, expected)
    assert all(line == lines[0] for line in lines)


def observe_peer_inputs(code, language, arrangement, mode):
    """Count the two numerical buffers only; formatting/runtime allocations differ."""
    assert language in {'c', 'rust'} and arrangement in {'coordinate', 'edge'}
    assert mode in {'checked', 'missing-release'}
    buffer = 'next' if arrangement == 'coordinate' else 'gradient'
    extension = '.c' if language == 'c' else '.rs'
    probe = (ROOT / ('tests/fixtures/descent_buffer_probe' + extension)).read_text()
    if language == 'c':
        assert code.count('malloc(') == 2
        if mode == 'missing-release':
            release = f'    free({buffer});\n    return ferror(stdout)'
            assert code.count(release) == 1
            code = code.replace(release, '    /* Deliberately omit one input release. */\n    return ferror(stdout)')
        code = code.replace('malloc(', 'input_alloc(').replace('free(', 'input_free(')
        marker = 'static int workload(void) {'
        assert code.count(marker) == 1
        code = code.replace(marker, probe + '\n' + marker)
        marker = 'int status = workload(); if (status) return status;'
        assert code.count(marker) == 1
        return code.replace(marker, marker + ' observe_inputs(batch + 1);')
    imports = 'use std::alloc::{GlobalAlloc, Layout, System};\nuse std::sync::atomic::{AtomicBool, AtomicUsize, Ordering};\n'
    marker = 'fn workload() -> io::Result<()> {'
    assert code.count(marker) == 1
    code = imports + code.replace(marker, probe + '\n' + marker)
    marker = '    let mut x: Vec<f64>'
    assert code.count(marker) == 1
    code = code.replace(marker, '    INPUT_CAPTURE.store(true, Ordering::Relaxed);\n' + marker)
    marker = f'    let mut {buffer} = vec![0.0; DIMENSIONS];'
    assert code.count(marker) == 1
    code = code.replace(marker, marker + '\n    INPUT_CAPTURE.store(false, Ordering::Relaxed);')
    if mode == 'missing-release':
        marker = '    writeln!(output, "]")'
        assert code.count(marker) == 1
        code = code.replace(marker, f'    let result = writeln!(output, "]");\n    std::mem::forget({buffer});\n    result')
    # Only the final solve loop gets an observation. A consumer may report a
    # checksum after that loop; it does not change the buffer lifetime boundary.
    prefix, wrapper = code.rsplit('fn main() -> io::Result<()> {', 1)
    loop, = re.findall(r'for _ in 0\.\.\d+ \{ workload\(\)\?; \}', wrapper)
    observed = loop.replace('for _ in', 'for solve in').replace('workload()?;', 'workload()?; observe_inputs(solve + 1);')
    return prefix + 'fn main() -> io::Result<()> {' + wrapper.replace(loop, observed)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['source-report', 'source-archive', 'output']:
        parser.add_argument('--' + name, required=True, type=Path)
    for name in ['host', 'cc', 'rustc', 'c-arch', 'objdump', 'nm', 'time']:
        parser.add_argument('--' + name, required=True)
    for name in ['samples', 'warmups', 'order-seed', 'timeout', 'repetitions']:
        parser.add_argument('--' + name, required=True, type=int)
    parser.add_argument('--control-max-difference', required=True, type=float)
    parser.add_argument('--case', required=True, action='append')
    args = parser.parse_args()
    assert platform.system() == 'Linux'
    assert min(args.samples, args.warmups, args.timeout, args.repetitions) > 0
    assert args.samples % 6 == 0
    assert 0 < args.control_max_difference < 1
    assert len(args.case) == len(set(args.case)) and '33:199' in args.case
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[platform.machine()]
    source_bytes = args.source_report.read_bytes()
    saved = json.loads(source_bytes)
    host, = [row for row in saved['hosts'] if row['host'] == args.host]
    assert host['report']['machine'] == platform.machine()
    archive_hash = digest(args.source_archive.read_bytes())
    assert archive_hash == host['archiveSha256']
    # These measurements reuse this compiler's inspected C, not a rebuilt fwp.
    for name in ['src/cgen.rs', 'src/rc.rs', 'tests/fixtures/descent_packed.fwp']:
        assert digest((ROOT / name).read_bytes()) == host['report']['sourceHashes'][name], name
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_GC', None)
    cflags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fstack-usage', '-march=' + args.c_arch]
    commands = []

    def run(command):
        result = subprocess.run([str(p) for p in command], env=environment,
                                capture_output=True, timeout=args.timeout)
        if result.returncode:
            raise RuntimeError(f'{command}: {result.returncode}: {result.stderr.decode(errors="replace")}')
        return result

    def build(command):
        start = time.perf_counter_ns()
        result = run(command)
        commands.append(dict(command=[str(p) for p in command], elapsedNs=time.perf_counter_ns() - start,
                             stdout=result.stdout.decode(), stderr=result.stderr.decode()))

    labels = ['fwp', 'fwp-identical', 'c-coordinate', 'rust-coordinate', 'c-edge', 'rust-edge']
    results = {}
    with zipfile.ZipFile(args.source_archive) as archive:
        for case in args.case:
            points, updates = map(int, case.split(':'))
            name = f'{points}-{updates}'
            old = host['report']['results'][name]
            assert old['dimensions'] == points and old['updates'] == updates
            expected = BATCHES.PEERS.AD.analytic(points, updates + 1)
            directory = out / name
            directory.mkdir()
            binaries, outputs, peer_profiles, controls = {}, {}, {}, {}
            observed_labels = []
            for profiled in [False, True]:
                label = 'fwp-profile' if profiled else 'fwp'
                saved_label = 'fwp-packed-profile' if profiled else 'fwp-packed'
                original = archive.read(name + '/' + saved_label + '.c')
                assert digest(original) == old['binaries'][saved_label]['sourceSha256']
                source = directory / (label + '.c')
                code = BATCHES.edit_source(original.decode(), 'fwp', args.repetitions)
                source.write_text(BATCHES.observe_solves(code, 'checked') if profiled else code)
                binary = directory / label
                build([args.cc, *cflags, '-w', source, '-o', binary, '-lm', '-lpthread', '-ldl'])
                actual = run([binary])
                single = archive.read(name + '/fwp-packed.stdout')
                assert digest(single) == old['outputSha256']['fwp-packed']
                assert actual.stdout == single * args.repetitions
                check_vectors(actual.stdout, expected, args.repetitions)
                (directory / (label + '.stdout')).write_bytes(actual.stdout)
                (directory / (label + '.stderr')).write_bytes(actual.stderr)
                if profiled:
                    records = [json.loads(line) for line in actual.stderr.splitlines()]
                    observations = [row for row in records if 'solve' in row]
                    assert observations == [dict(solve=i+1, managedLiveBytes=0, rawLiveBytes=0)
                                            for i in range(args.repetitions)]
                    managed, raw = [row for row in records if 'solve' not in row]
                    previous = old['fwpProfiles']['fwp-packed']
                    assert managed['retains'] == managed['finalChargedBytes'] == managed['collections'] == 0
                    assert managed['peakChargedBytes'] <= previous['managed']['peakChargedBytes']
                    for metric in ['requests', 'requestedBytes']:
                        assert managed[metric] <= previous['managed'][metric] * args.repetitions
                    raw = raw['rawDerivativeStorage']
                    BATCHES.PEERS.AD.RAW.check_profile(raw, 0, True)
                    assert digest(json.dumps(raw, sort_keys=True).encode()) == previous['expandedRawSha256']
                    profile = dict(managed=managed, rawDerivativeStorage=raw, completedSolves=observations)
                else:
                    assert not actual.stderr
                    binaries[label], outputs[label] = binary, actual.stdout
            for language in ['c', 'rust']:
                for arrangement in ['coordinate', 'edge']:
                    label = language + '-' + arrangement
                    extension = '.c' if language == 'c' else '.rs'
                    fixture = 'descent_coordinate' if arrangement == 'coordinate' else 'descent_explicit'
                    template = (ROOT / ('tests/fixtures/' + fixture + extension)).read_text()
                    if language == 'c':
                        code = f'#define DIMENSIONS {points}\n#define UPDATES {updates}\n' + template
                    else:
                        marker = '// Measurement parameters are inserted here.'
                        assert template.count(marker) == 1
                        code = template.replace(marker, f'const DIMENSIONS: usize = {points};\nconst UPDATES: usize = {updates};')
                    source = directory / (label + extension)
                    repeated = BATCHES.edit_source(code, language, args.repetitions)
                    source.write_text(repeated)
                    binary = directory / label
                    if language == 'c':
                        build([args.cc, *cflags, '-Wall', '-Wextra', '-Werror', source, '-o', binary, '-lm'])
                    else:
                        build([args.rustc, '--crate-name', 'descent_' + arrangement, '--edition=2021', '-D', 'warnings',
                               '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'codegen-units=1',
                               '-C', 'target-cpu=generic', '-C', 'lto=off', source, '-o', binary])
                    actual = run([binary])
                    assert not actual.stderr
                    check_vectors(actual.stdout, expected, args.repetitions)
                    binaries[label], outputs[label] = binary, actual.stdout
                    (directory / (label + '.stdout')).write_bytes(actual.stdout)
                    for mode in ['checked', 'missing-release'] if case == '33:199' else ['checked']:
                        observed = label + ('-profile' if mode == 'checked' else '-missing-release')
                        observed_labels.append(observed)
                        source = directory / (observed + extension)
                        source.write_text(observe_peer_inputs(repeated, language, arrangement, mode))
                        binary = directory / observed
                        if language == 'c':
                            build([args.cc, *cflags, '-Wall', '-Wextra', '-Werror', source, '-o', binary, '-lm'])
                        else:
                            build([args.rustc, '--crate-name', 'descent_' + arrangement, '--edition=2021', '-D', 'warnings',
                                   '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'codegen-units=1',
                                   '-C', 'target-cpu=generic', '-C', 'lto=off', source, '-o', binary])
                        actual = subprocess.run([str(binary)], env=environment, capture_output=True, timeout=args.timeout)
                        (directory / (observed + '.stdout')).write_bytes(actual.stdout)
                        (directory / (observed + '.stderr')).write_bytes(actual.stderr)
                        (directory / (observed + '.status')).write_text(str(actual.returncode) + '\n')
                        observations = [json.loads(line) for line in actual.stderr.splitlines()]
                        if mode == 'checked':
                            assert actual.returncode == 0 and actual.stdout == outputs[label]
                            assert observations == [dict(solve=i, inputRequests=2*i, inputRequestedBytes=16*points*i,
                                                         inputLiveBytes=0, inputPeakBytes=16*points)
                                                    for i in range(1, args.repetitions + 1)]
                            peer_profiles[label] = observations
                        else:
                            assert actual.returncode == 226
                            assert observations == [dict(solve=1, inputRequests=2, inputRequestedBytes=16*points,
                                                         inputLiveBytes=8*points, inputPeakBytes=16*points)]
                            controls[observed] = dict(status=actual.returncode, observations=observations)
            if case == '33:199':
                original = archive.read(name + '/fwp-packed-profile.c').decode()
                for mode in ['retained', 'retained-without-observer']:
                    label = 'fwp-' + mode
                    observed_labels.append(label)
                    source = directory / (label + '.c')
                    source.write_text(BATCHES.observe_solves(BATCHES.edit_source(original, 'fwp', args.repetitions), mode))
                    binary = directory / label
                    build([args.cc, *cflags, '-w', source, '-o', binary, '-lm', '-lpthread', '-ldl'])
                    actual = subprocess.run([str(binary)], env=environment, capture_output=True, timeout=args.timeout)
                    (directory / (label + '.stdout')).write_bytes(actual.stdout)
                    (directory / (label + '.stderr')).write_bytes(actual.stderr)
                    (directory / (label + '.status')).write_text(str(actual.returncode) + '\n')
                    observations = [json.loads(line) for line in actual.stderr.splitlines()]
                    if mode == 'retained':
                        assert actual.returncode == 225 and len(observations) == 1
                        assert observations[0]['solve'] == 1 and observations[0]['managedLiveBytes'] > 0
                        assert observations[0]['rawLiveBytes'] == 0
                    else:
                        assert actual.returncode == 0 and actual.stdout == outputs['fwp']
                        managed, raw = observations
                        assert managed['finalChargedBytes'] == raw['rawDerivativeStorage']['finalBytes'] == 0
                    controls[label] = dict(status=actual.returncode, observations=observations)
            identical = directory / 'fwp-identical'
            shutil.copyfile(binaries['fwp'], identical)
            identical.chmod(binaries['fwp'].stat().st_mode)
            shutil.copyfile(directory / 'fwp.c', directory / 'fwp-identical.c')
            binaries['fwp-identical'], outputs['fwp-identical'] = identical, outputs['fwp']
            (directory / 'fwp-identical.stdout').write_bytes(outputs['fwp'])
            assert identical.read_bytes() == binaries['fwp'].read_bytes()
            metadata = {}
            for label in [*labels, 'fwp-profile', *observed_labels]:
                binary = directory / label
                raw = binary.read_bytes()
                assert raw[:6] == b'\x7fELF\x02\x01'
                assert int.from_bytes(raw[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
                assembly = run([args.objdump, '-d', binary]).stdout
                headers = run([args.objdump, '-h', binary]).stdout
                symbols = run([args.nm, binary]).stdout
                if label.startswith('fwp'):
                    assert not re.search(rb'\bfwp_gc_(?:scan|mark_all|sweep)\b', symbols)
                sizes = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', headers, re.M)
                assert sizes and b'Disassembly of section' in assembly
                (directory / (label + '.asm')).write_bytes(assembly)
                (directory / (label + '.symbols')).write_bytes(symbols)
                source = directory / (label + ('.rs' if label.startswith('rust-') else '.c'))
                metadata[label] = dict(bytes=len(raw), sha256=digest(raw), sourceSha256=digest(source.read_bytes()),
                                       disassemblySha256=digest(assembly), textSectionBytes=sum(int(s, 16) for s in sizes))
            orders = BATCHES.batch_orders(labels, args.samples, args.order_seed)
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
            assert len(frames) == (10 if controls else 6)
            assert len(metadata) == (17 if controls else 11)
            control = medians['fwp'] / medians['fwp-identical']
            results[name] = dict(dimensions=points, updates=updates, profile=profile,
                peerInputProfiles=peer_profiles, lifetimeControls=controls,
                outputSha256={label: digest(raw) for label, raw in outputs.items()}, binaries=metadata,
                samplesNs=samples, orders=orders, medianNs=medians, identicalCopyRatio=control,
                controlWithinBound=abs(control-1) <= args.control_max_difference,
                fwpRatios={label: medians['fwp']/medians[label] for label in labels if label != 'fwp'},
                coordinateToEdgeRatios={language: medians[language+'-coordinate']/medians[language+'-edge']
                                        for language in ['c', 'rust']},
                peakProcessRssBytes=resident, cCompilerStackUsage=frames)
            (out / 'results.json').write_text(json.dumps(results, indent=2)+'\n')
            print(name, 'fwp/peer', results[name]['fwpRatios'], 'identical control', control, flush=True)
    inputs = ['scripts/measure-coordinate-work.py', 'scripts/measure-descent-batches.py',
              'scripts/measure-descent-peers.py', 'tests/fixtures/descent_coordinate.c',
              'tests/fixtures/descent_coordinate.rs', 'tests/fixtures/descent_explicit.c',
              'tests/fixtures/descent_explicit.rs', 'tests/fixtures/descent_buffer_probe.c',
              'tests/fixtures/descent_buffer_probe.rs']
    report = dict(source=os.environ['GITHUB_SHA'], compilerSource=saved['source'], host=args.host,
        machine=platform.machine(), cpu=run(['lscpu']).stdout.decode(),
        cCompiler=run([args.cc, '--version']).stdout.decode(), rustCompiler=run([args.rustc, '-Vv']).stdout.decode(),
        commands=commands, sourceHashes={name: digest((ROOT / name).read_bytes()) for name in inputs},
        configuration={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()},
        savedCompiler=dict(run=saved['run'], reportSha256=digest(source_bytes), archiveSha256=archive_hash),
        results=results, scope='Complete repeated solves, including fresh inputs, arithmetic, output and cleanup. '
        'Coordinate peers match the fwp formula arrangement but reuse two buffers; fwp keeps immutable arrays. '
        'Edge peers retain the original residual-once-per-edge calculation. Formatting and bounds checks differ. '
        'Peer profiles observe only the two numerical input/output buffers, excluding stdio and runtime allocations. '
        'Those bytes are not directly comparable to all fwp managed storage or process RSS. '
        'Profiles and compilation are excluded from timing. No isolated language-overhead or speed claim follows from one run.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2)+'\n')


if __name__ == '__main__':
    main()
