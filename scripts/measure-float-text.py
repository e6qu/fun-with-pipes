#!/usr/bin/env python3
"""Measure one formatter change in complete numerical programs, against C and Rust."""

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

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('output', ROOT / 'scripts/measure-descent-output.py')
OUTPUT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(OUTPUT)
BATCHES = OUTPUT.BATCHES


def digest(raw):
    return hashlib.sha256(raw).hexdigest()


def original_formatter(code):
    """Change only the function under study, retaining the same generated program."""
    baseline = (ROOT / 'tests/fixtures/float_text_baseline.c').read_text()
    body, = re.findall(r'^static void baseline_format_g\(.*?^\}', baseline, re.M | re.S)
    candidate, = re.findall(r'^static void fwp_format_g\(.*?^\}', code, re.M | re.S)
    body = body.replace('baseline_format_g', 'fwp_format_g')
    assert body != candidate
    changed = code.replace(candidate, body)
    assert changed.replace(body, candidate) == code
    return changed


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['compiler', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ['host', 'cc', 'rustc', 'c-arch', 'objdump', 'nm', 'time']:
        parser.add_argument('--' + name, required=True)
    for name in ['samples', 'warmups', 'order-seed', 'timeout']:
        parser.add_argument('--' + name, type=int, required=True)
    for name in ['control-max-difference', 'required-reduction']:
        parser.add_argument('--' + name, type=float, required=True)
    parser.add_argument('--case', action='append', required=True, metavar='COORDINATES:UPDATES:SOLVES')
    args = parser.parse_args()
    assert platform.system() == 'Linux'
    assert min(args.samples, args.warmups, args.timeout) > 0 and args.samples % 6 == 0
    assert 0 < args.control_max_difference < args.required_reduction < 1
    assert args.c_arch == {'x86_64': 'x86-64', 'aarch64': 'armv8-a'}[platform.machine()]
    plans = [tuple(map(int, case.split(':'))) for case in args.case]
    assert all(len(row) == 3 and 2 <= row[0] <= 4096 and 0 <= row[1] <= 4091 and row[2] > 0 for row in plans)
    assert len({row[:2] for row in plans}) == len(plans)
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {k: v for k, v in os.environ.items() if not k.startswith('FWP_') and k not in {'GH_TOKEN', 'GITHUB_TOKEN'}}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_AD_WORKSPACE='1', FWP_PACKED_ARRAYS='1',
                       FWP_STACK='1', FWP_FREE='1', FWP_REUSE='1', FWP_ARRAY_FUSION='1',
                       FWP_GC='off', FWP_GC_STATS='0', FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-fstack-usage', '-march=' + args.c_arch]
    labels = ['fwp-current', 'fwp-original', 'fwp-current-identical', 'fwp-original-identical', 'c', 'rust']
    commands, results = [], {}

    def run(command, env):
        result = subprocess.run([str(p) for p in command], env=env, capture_output=True, timeout=args.timeout)
        assert result.returncode == 0, (command, result.returncode, result.stderr.decode(errors='replace'))
        return result

    def build(command):
        actual = run(command, environment)
        commands.append(dict(command=[str(p) for p in command], stdout=actual.stdout.decode(), stderr=actual.stderr.decode()))

    for points, updates, repetitions in plans:
        name = f'{points}-{updates}'
        directory = out / name
        directory.mkdir()
        expected = BATCHES.PEERS.AD.analytic(points, updates + 1)
        source = directory / 'input.fwp'
        source.write_text(BATCHES.PEERS.packed_program(points, updates))
        reference = run([args.compiler.resolve(), 'run', '--interp', source], dict(environment, FWP_NO_OPT='1'))
        assert not reference.stderr
        OUTPUT.COORDINATE.check_vectors(reference.stdout, expected, 1)
        (directory / 'interpreter.stdout').write_bytes(reference.stdout)
        generated = directory / 'input.c'
        build([args.compiler.resolve(), 'build', '--memory', 'dynamic', '--emit-c', '-O2', source, '-o', generated])
        originals = {'fwp-current': generated.read_text()}
        originals['fwp-original'] = original_formatter(originals['fwp-current'])
        originals['c'] = f'#define DIMENSIONS {points}\n#define UPDATES {updates}\n' + (ROOT / 'tests/fixtures/descent_coordinate.c').read_text()
        originals['rust'] = (ROOT / 'tests/fixtures/descent_coordinate.rs').read_text().replace(
            '// Measurement parameters are inserted here.', f'const DIMENSIONS: usize = {points};\nconst UPDATES: usize = {updates};')
        binaries, outputs, metadata, profiles = {}, {}, {}, {}

        def compile_program(label, language, code):
            path, binary = directory / (label + ('.rs' if language == 'rust' else '.c')), directory / label
            path.write_text(code)
            if language == 'rust':
                command = [args.rustc, '--crate-name', 'float_text', '--edition=2021', '-D', 'warnings',
                           '-C', 'opt-level=2', '-C', 'overflow-checks=yes', '-C', 'codegen-units=1',
                           '-C', 'target-cpu=generic', '-C', 'lto=off', path, '-o', binary]
            else:
                command = [args.cc, *flags, *(['-w'] if language == 'fwp' else ['-Wall', '-Wextra', '-Werror']),
                           path, '-o', binary, '-lm', '-lpthread', '-ldl']
            build(command)
            binaries[label] = binary
            actual = run([binary], environment)
            for suffix, raw in [('stdout', actual.stdout), ('stderr', actual.stderr), ('status', b'0\n')]:
                (directory / (label + '.' + suffix)).write_bytes(raw)
            return actual

        for label, code in originals.items():
            language = 'fwp' if label.startswith('fwp') else label
            repeated = BATCHES.edit_source(code, language, repetitions)
            actual = compile_program(label, language, repeated)
            assert not actual.stderr
            OUTPUT.COORDINATE.check_vectors(actual.stdout, expected, repetitions)
            if language == 'fwp':
                assert actual.stdout == reference.stdout * repetitions
                instrumented = BATCHES.PEERS.AD.RAW.instrument(BATCHES.PEERS.AD.PROFILE.instrument(code))
                instrumented = BATCHES.observe_solves(BATCHES.edit_source(instrumented, language, repetitions), 'checked')
            else:
                instrumented = OUTPUT.peer_profile(repeated, language, False)
            observed = compile_program(label + '-profile', language, instrumented)
            assert observed.stdout == actual.stdout
            rows = [json.loads(line) for line in observed.stderr.splitlines()]
            if language == 'fwp':
                checkpoints = [row for row in rows if 'solve' in row]
                assert checkpoints == [dict(solve=i+1, managedLiveBytes=0, rawLiveBytes=0) for i in range(repetitions)]
                managed, raw = [row for row in rows if 'solve' not in row]
                assert managed['retains'] == managed['finalChargedBytes'] == managed['collections'] == 0
                BATCHES.PEERS.AD.RAW.check_profile(raw['rawDerivativeStorage'], 0, True)
                profiles[label] = dict(managed=managed, raw=raw, completedSolves=len(checkpoints), observationsSha256=digest(observed.stderr))
            else:
                assert rows == [dict(solve=i, inputRequests=2*i, inputRequestedBytes=16*points*i,
                                    inputLiveBytes=0, inputPeakBytes=16*points) for i in range(1, repetitions+1)]
                profiles[label] = dict(completedSolves=len(rows), first=rows[0], last=rows[-1], observationsSha256=digest(observed.stderr))
            outputs[label] = actual.stdout
        assert profiles['fwp-current'] == profiles['fwp-original']
        for label in ['fwp-current', 'fwp-original']:
            copy = label + '-identical'
            shutil.copyfile(binaries[label], directory / copy)
            (directory / copy).chmod(binaries[label].stat().st_mode)
            shutil.copyfile(directory / (label + '.c'), directory / (copy + '.c'))
            binaries[copy], outputs[copy] = directory / copy, outputs[label]
            assert binaries[copy].read_bytes() == binaries[label].read_bytes()
        for label, binary in binaries.items():
            raw = binary.read_bytes()
            assert raw[:6] == b'\x7fELF\x02\x01' and int.from_bytes(raw[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
            asm = run([args.objdump, '-d', binary], environment).stdout
            symbols = run([args.nm, binary], environment).stdout
            headers = run([args.objdump, '-h', binary], environment).stdout
            assert b'Disassembly of section' in asm
            if label.startswith('fwp'):
                assert not re.search(rb'\bfwp_gc_(?:scan|mark_all|sweep)\b', symbols)
            for suffix, content in [('asm', asm), ('symbols', symbols), ('headers', headers)]:
                (directory / (label + '.' + suffix)).write_bytes(content)
            path = directory / (label + ('.rs' if label.startswith('rust') else '.c'))
            sizes = re.findall(rb'^\s*\d+\s+\.text\s+([0-9a-fA-F]+)\s', headers, re.M)
            assert sizes
            metadata[label] = dict(bytes=len(raw), sha256=digest(raw), sourceSha256=digest(path.read_bytes()),
                                   disassemblySha256=digest(asm), textSectionBytes=sum(int(s, 16) for s in sizes))
        assert len(metadata) == 10
        sequence = OUTPUT.orders(labels, args.samples, args.order_seed)
        for _ in range(args.warmups):
            for label in labels:
                actual = run([binaries[label]], environment)
                assert actual.stdout == outputs[label] and not actual.stderr
        samples = {label: [] for label in labels}
        for order in sequence:
            for label in order:
                start = time.perf_counter_ns()
                actual = run([binaries[label]], environment)
                samples[label].append(time.perf_counter_ns() - start)
                assert actual.stdout == outputs[label] and not actual.stderr
        medians = {label: statistics.median(rows) for label, rows in samples.items()}
        resident = {}
        for label in labels:
            actual = run([args.time, '-v', binaries[label]], environment)
            assert actual.stdout == outputs[label]
            match, = re.findall(rb'Maximum resident set size \(kbytes\):\s*(\d+)', actual.stderr)
            resident[label] = int(match) * 1024
            (directory / (label + '-rss.txt')).write_bytes(actual.stderr)
        copies = {label: medians[label] / medians[label + '-identical'] for label in ['fwp-current', 'fwp-original']}
        frames = {p.name: dict(sha256=digest(p.read_bytes()), text=p.read_text()) for p in directory.glob('*.su')}
        assert frames
        ratio = medians['fwp-current'] / medians['fwp-original']
        stable = all(abs(r-1) <= args.control_max_difference for r in copies.values())
        results[name] = dict(dimensions=points, updates=updates, repetitions=repetitions, profiles=profiles,
            samplesNs=samples, orders=sequence, medianNs=medians, identicalCopyRatios=copies,
            controlsWithinBound=stable, currentToOriginalRatio=ratio,
            meetsSingleRunScreen=stable and ratio <= 1 - args.required_reduction,
            fwpToPeerRatios={variant: {peer: medians[variant]/medians[peer] for peer in ['c', 'rust']} for variant in ['fwp-current', 'fwp-original']},
            peakProcessRssBytes=resident, cCompilerStackUsage=frames, binaries=metadata,
            outputSha256={label: digest(raw) for label, raw in outputs.items()})
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
        print(name, 'current/original', ratio, 'copy controls', copies, flush=True)
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], cwd=ROOT, text=True).strip()
    inputs = subprocess.check_output(['git', 'ls-files', 'src', 'runtime', 'lib', 'scripts', 'tests/fixtures',
                                      'Cargo.toml', 'Cargo.lock', 'build.rs'], cwd=ROOT, text=True).splitlines()
    report = dict(source=source, sourceHashes={name: digest((ROOT/name).read_bytes()) for name in inputs},
        host=args.host, machine=platform.machine(), cpu=run(['lscpu'], environment).stdout.decode(),
        compilerSha256=digest(args.compiler.read_bytes()), cCompiler=run([args.cc, '--version'], environment).stdout.decode(),
        rustCompiler=run([args.rustc, '-Vv'], environment).stdout.decode(), commands=commands,
        configuration={k: str(v) if isinstance(v, Path) else v for k, v in vars(args).items()}, results=results,
        scope='Complete repeated numerical solves with ordinary output. The two fwp variants differ only in fwp_format_g. '
        'C/Rust use matched coordinate formulas but reuse two buffers; fwp uses immutable arrays. '
        'Timing includes process start, arithmetic, output and cleanup; excludes compilation, validation, profiles and RSS probes. '
        'All timed outputs are checked. Memory instrumentation can prevent optimizations; its counts are not traces of timed binaries. '
        'C/Rust profiles cover numerical buffers only; process RSS covers the whole process. '
        'A single-run screen is not acceptance: repeat on matching CPU models and report every case, including regressions.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
