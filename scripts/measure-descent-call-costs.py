#!/usr/bin/env python3
"""Compare saved numerical C with two explicit inlining edits; no fwp code change."""

import argparse
import hashlib
import importlib.util
import json
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
SPEC = importlib.util.spec_from_file_location('descent_peers', ROOT / 'scripts/measure-descent-peers.py')
PEERS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(PEERS)


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def edit_helper(code, helper, mode):
    """Edit only the named saved scalar helper's declaration and definition."""
    assert re.fullmatch(r'w[0-9]+', helper), helper
    declaration = 'static double ' + helper + '(V l0_0, int64_t al0_1)'
    assert code.count(declaration + ';') == 1
    assert code.count(declaration + ' {') == 1
    if mode == 'baseline':
        return code
    prefix = {'hint': 'static inline double ',
              'forced': 'static inline __attribute__((always_inline)) double '}[mode]
    return code.replace(declaration, prefix + helper + '(V l0_0, int64_t al0_1)')


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['baseline-report', 'baseline-archive', 'output']:
        parser.add_argument('--' + name, required=True, type=Path)
    for name in ['host', 'cc', 'rustc', 'c-arch', 'objdump', 'nm', 'time', 'helper']:
        parser.add_argument('--' + name, required=True)
    for name in ['samples', 'warmups', 'order-seed', 'timeout']:
        parser.add_argument('--' + name, required=True, type=int)
    for name in ['control-max-difference', 'candidate-max-ratio', 'text-max-growth']:
        parser.add_argument('--' + name, required=True, type=float)
    parser.add_argument('--case', required=True, action='append')
    parser.add_argument('--decision-case', required=True)
    args = parser.parse_args()
    assert platform.system() == 'Linux' and args.samples > 0 and args.warmups > 0 and args.timeout > 0
    assert 0 < args.control_max_difference < 1 and 0 < args.candidate_max_ratio < 1 and args.text_max_growth >= 1
    assert len(args.case) == len(set(args.case)) and args.decision_case in args.case
    baseline_bytes = args.baseline_report.read_bytes()
    baseline = json.loads(baseline_bytes)
    host, = [row for row in baseline['hosts'] if row['host'] == args.host]
    archive_bytes = args.baseline_archive.read_bytes()
    assert digest(archive_bytes) == host['archiveSha256']
    assert host['report']['machine'] == platform.machine()
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

    labels = ['baseline', 'hint', 'forced', 'baseline-identical', 'forced-identical', 'c-explicit', 'rust-explicit']
    results = {}
    with zipfile.ZipFile(args.baseline_archive) as archive:
        for case in args.case:
            points, updates = map(int, case.split(':'))
            name = f'{points}-{updates}'
            previous = host['report']['results'][name]
            assert previous['dimensions'] == points and previous['updates'] == updates
            directory = out / name
            directory.mkdir()
            code = archive.read(name + '/fwp-packed.c').decode()
            profile_code = archive.read(name + '/fwp-packed-profile.c').decode()
            assert digest(code.encode()) == previous['binaries']['fwp-packed']['sourceSha256']
            assert digest(profile_code.encode()) == previous['binaries']['fwp-packed-profile']['sourceSha256']
            expected = archive.read(name + '/fwp-packed.stdout')
            assert digest(expected) == previous['outputSha256']['fwp-packed']
            profiles, binaries, outputs, metadata = {}, {}, {}, {}
            for mode in ['baseline', 'hint', 'forced']:
                for profiled, original in [(False, code), (True, profile_code)]:
                    label = mode + ('-profile' if profiled else '')
                    source = directory / (label + '.c')
                    source.write_text(edit_helper(original, args.helper, mode))
                    binary = directory / label
                    build([args.cc, *flags, '-w', source, '-o', binary, '-lm', '-lpthread', '-ldl'])
                    actual = run([binary])
                    (directory / (label + '.stdout')).write_bytes(actual.stdout)
                    (directory / (label + '.stderr')).write_bytes(actual.stderr)
                    assert actual.stdout == expected
                    if profiled:
                        managed, raw = [json.loads(line) for line in actual.stderr.splitlines()]
                        assert managed == previous['fwpProfiles']['fwp-packed']['managed']
                        raw = raw['rawDerivativeStorage']
                        PEERS.AD.RAW.check_profile(raw, 0, True)
                        assert digest(json.dumps(raw, sort_keys=True).encode()) == previous['fwpProfiles']['fwp-packed']['expandedRawSha256']
                        profiles[mode] = dict(managed=managed, rawDerivativeStorage=raw)
                    else:
                        assert not actual.stderr
                        binaries[label] = binary
                        outputs[label] = expected
            for label, extension in [('c-explicit', '.c'), ('rust-explicit', '.rs')]:
                source = directory / (label + extension)
                source.write_bytes(archive.read(name + '/' + label + extension))
                assert digest(source.read_bytes()) == previous['binaries'][label]['sourceSha256']
                binary = directory / label
                if label == 'c-explicit':
                    build([args.cc, *flags, '-Wall', '-Wextra', '-Werror', source, '-o', binary, '-lm'])
                else:
                    build([args.rustc, '--crate-name', 'descent_explicit', '--edition=2021', '-D', 'warnings',
                           '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'codegen-units=1',
                           '-C', 'target-cpu=generic', '-C', 'lto=off', source, '-o', binary])
                actual = run([binary])
                assert digest(actual.stdout) == previous['outputSha256'][label] and not actual.stderr
                binaries[label], outputs[label] = binary, actual.stdout
                (directory / (label + '.stdout')).write_bytes(actual.stdout)
            for original in ['baseline', 'forced']:
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
                    disassemblySha256=digest(assembly), instructionBytes=sum(int(size, 16) for size in sizes),
                    helperSymbols=[line.decode() for line in symbols.splitlines() if re.search(rb'\b' + args.helper.encode() + rb'(?:[.$]|$)', line)])
            assert len(metadata) == 10
            orders = PEERS.measurement_orders(labels, args.samples, args.order_seed)
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
            assert len(frames) == 7
            controls = {label: medians[label] / medians[label + '-identical'] for label in ['baseline', 'forced']}
            ratios = {label: {peer: medians[label] / medians[peer] for peer in ['baseline', 'c-explicit', 'rust-explicit']}
                      for label in ['hint', 'forced']}
            screens = {label: all(abs(value - 1) <= args.control_max_difference for value in controls.values())
                       and ratios[label]['baseline'] <= args.candidate_max_ratio
                       and metadata[label]['instructionBytes'] <= args.text_max_growth * metadata['baseline']['instructionBytes']
                       for label in ['hint', 'forced']}
            results[name] = dict(dimensions=points, updates=updates, profiles=profiles, binaries=metadata,
                outputSha256={label: digest(raw) for label, raw in outputs.items()}, samplesNs=samples, medianNs=medians,
                orders=orders, controlRatios=controls, ratios=ratios, singleRunScreen=screens,
                peakProcessRssBytes=resident, cCompilerStackUsage=frames)
            (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
            print(name, 'ratios', ratios, 'controls', controls, 'single-run screen', screens, flush=True)
    report = dict(source=os.environ['GITHUB_SHA'], host=args.host, machine=platform.machine(),
        cpu=run(['lscpu']).stdout.decode(), cCompiler=run([args.cc, '--version']).stdout.decode(),
        rustCompiler=run([args.rustc, '-Vv']).stdout.decode(), commands=commands,
        configuration={key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()},
        baseline=dict(source=baseline['source'], run=baseline['run'], reportSha256=digest(baseline_bytes), archiveSha256=digest(archive_bytes)),
        sourceHashes={name: digest((ROOT / name).read_bytes()) for name in ['scripts/measure-descent-call-costs.py', 'scripts/measure-descent-peers.py']},
        results=results, scope='C counterfactual experiment, not a compiler change. Only a named saved helper declaration changes. '
        'All output and managed/raw storage must reproduce the accepted artifact. Timing includes process startup, initialization, '
        'updates, complete output and teardown; compilation/profiles are excluded. C/Rust algorithms and formatting retain their '
        'documented differences. Two byte-identical controls expose unrelated variation. A single-run screen is not acceptance: '
        'both named native hosts need independent repeated results on matching CPU models before selecting an optimization. '
        'A failed timing screen is a recorded diagnostic result, not permission to relax correctness or storage requirements.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
