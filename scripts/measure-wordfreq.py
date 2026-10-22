#!/usr/bin/env python3
"""Compare the maintained word-frequency application with sorted-map C/Rust peers."""
import argparse
from collections import Counter
import hashlib
import importlib.util
import json
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


def oracle(data):
    """Independent result for the documented ASCII-only comparison input."""
    text = data.decode('ascii')
    assert '\0' not in text
    counts = Counter(word.lower().replace(',', '').replace('.', '')
                     for word in re.split(r'[ \t\n\r]+', text) if word)
    ordered = sorted(counts.items(), key=lambda pair: (-pair[1], pair[0]))[:5]
    return ''.join(f'{word}: {count}\n' for word, count in ordered).encode()


def make_input(tokens, vocabulary):
    assert tokens > 0 and 0 < vocabulary <= tokens
    # Coprime stride visits every power-of-two vocabulary; punctuation/case vary.
    assert vocabulary & (vocabulary - 1) == 0
    words = []
    for index in range(tokens):
        word = f'word{(index * 7919) % vocabulary:06d}'
        if index % 3 == 0:
            word = word.upper()
        if index % 5 == 0:
            word = ',' + word + '.'
        words.append(word)
    return '\n'.join(' '.join(words[start:start + 16])
                     for start in range(0, tokens, 16)).encode() + b'\n'


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', required=True, type=Path)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--nm', required=True)
    parser.add_argument('--time', required=True)
    parser.add_argument('--case', required=True, action='append', help='TOKENS:VOCABULARY')
    parser.add_argument('--warmups', required=True, type=int)
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--host', required=True)
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--baseline', required=True, type=Path)
    parser.add_argument('--baseline-source', required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.warmups > 0 and args.samples > 0 and args.samples % 12 == 0
    assert args.timeout > 0
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', FWP_GC_STRESS='0',
                       FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    compiler = args.compiler.resolve()
    baseline = json.loads((args.baseline / 'comparison.json').read_text())
    assert baseline['source'] == args.baseline_source and baseline['host'] == args.host
    assert baseline['machine'] == platform.machine()
    for name in ('examples/wordfreq.fwp', 'tests/fixtures/wordfreq_bench.c',
                 'tests/fixtures/wordfreq_bench.rs', 'scripts/measure-iteration.py'):
        assert baseline['sourceHashes'][name] == digest(ROOT / name), name
    baseline_c = {}
    commands = []

    def run(command, input_path, env):
        command = list(map(str, command))
        with input_path.open('rb') as source:
            result = subprocess.run(command, stdin=source, capture_output=True,
                                    env=env, cwd=ROOT, timeout=args.timeout)
        if result.returncode:
            raise RuntimeError(f'{command}: {result.returncode}: '
                               + result.stderr.decode(errors='replace'))
        return result

    empty = out / 'empty.stdin'
    empty.write_bytes(b'')
    build_times = {}

    def build(label, command):
        start = time.perf_counter_ns()
        result = run(command, empty, environment)
        build_times[label] = time.perf_counter_ns() - start
        commands.append(list(map(str, command)))
        (out / (label + '-build.stderr')).write_bytes(result.stderr)

    source = ROOT / 'examples/wordfreq.fwp'
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off']
    binaries = {name: out / name for name in ('c', 'rust', 'fwp-arc', 'fwp-tracing')}
    build('c', [args.cc, *flags, '-Wall', '-Wextra', '-Werror',
                ROOT / 'tests/fixtures/wordfreq_bench.c', '-o', binaries['c']])
    build('rust', [args.rustc, '--edition=2021', '-C', 'opt-level=2',
                   '-C', 'overflow-checks=yes', ROOT / 'tests/fixtures/wordfreq_bench.rs',
                   '-o', binaries['rust']])
    for mode in ('arc', 'tracing'):
        label = 'fwp-' + mode
        cfile = out / (label + '.c')
        build(label + '-frontend', [compiler, 'build', '--gc', mode, '-O2',
                                    '--emit-c', source, '-o', cfile])
        build(label, [args.cc, *flags, '-w', cfile, '-o', binaries[label],
                      '-lm', '-lpthread', '-ldl'])
        profiled = out / (label + '-profile.c')
        profiled.write_text(PROFILE.instrument(cfile.read_text()))
        build(label + '-profile', [args.cc, *flags, '-w', profiled,
                                   '-o', out / (label + '-profile'), '-lm', '-lpthread', '-ldl'])

    for mode in ('arc', 'tracing'):
        label = 'before-' + mode
        old_label = 'fwp-' + mode
        assert digest(args.baseline / old_label) == baseline['binaries'][old_label]['sha256']
        cfile = out / (label + '.c')
        cfile.write_bytes((args.baseline / (old_label + '.c')).read_bytes())
        baseline_c[label] = digest(cfile)
        binaries[label] = out / label
        build(label, [args.cc, *flags, '-w', cfile, '-o', binaries[label],
                      '-lm', '-lpthread', '-ldl'])
        profiled = out / (label + '-profile.c')
        profiled.write_text(PROFILE.instrument(cfile.read_text()))
        build(label + '-profile', [args.cc, *flags, '-w', profiled,
                                   '-o', out / (label + '-profile'), '-lm', '-lpthread', '-ldl'])

    evidence = {}
    for label, binary in binaries.items():
        asm = run([args.objdump, '-d', binary], empty, environment).stdout
        symbols = run([args.nm, binary], empty, environment).stdout
        header = run([args.objdump, '-f', binary], empty, environment).stdout
        expected_machine = {'x86_64': 62, 'aarch64': 183}[platform.machine()]
        raw_header = binary.read_bytes()[:20]
        assert raw_header[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(raw_header[18:20], 'little') == expected_machine
        if label.endswith('-arc'):
            assert not any(name in symbols for name in
                           (b'fwp_gc_scan', b'fwp_gc_mark_all', b'fwp_gc_sweep'))
        (out / (label + '.asm')).write_bytes(asm)
        (out / (label + '.symbols')).write_bytes(symbols)
        evidence[label] = dict(sha256=digest(binary), bytes=binary.stat().st_size,
                               header=header.decode(), buildNs=build_times[label])

    # Small independent cases exercise empty input, ties, punctuation and whitespace.
    controls = [b'', b' \t\r\n\v\f', b'a A a, b. B', b'z y x w v u',
                b'... , . A', b'one\vtwo\fone\rTWO\tthree', b'Keep-hyphens keep-hyphens!']
    for number, data in enumerate(controls):
        path = out / f'control-{number}.stdin'
        path.write_bytes(data)
        expected = oracle(data)
        reference = run([compiler, 'run', '--interp', source], path,
                        dict(environment, FWP_NO_OPT='1'))
        assert reference.stdout == expected and not reference.stderr, (number, reference)
        for label, binary in binaries.items():
            actual = run([binary], path, environment)
            assert actual.stdout == expected and not actual.stderr, (number, label, actual)

    results = {}
    acceptance_failures = []
    for case in args.case:
        tokens, vocabulary = map(int, case.split(':'))
        name = f'{tokens}-{vocabulary}'
        assert name not in results
        path = out / (name + '.stdin')
        data = make_input(tokens, vocabulary)
        path.write_bytes(data)
        expected = oracle(data)
        (out / (name + '.stdout')).write_bytes(expected)
        for _ in range(args.warmups):
            for binary in binaries.values():
                actual = run([binary], path, environment)
                assert actual.stdout == expected and not actual.stderr
        samples = {label: [] for label in binaries}
        orders = []
        labels = list(binaries)
        for round_number in range(args.samples):
            order = labels[round_number % len(labels):] + labels[:round_number % len(labels)]
            if round_number % (2 * len(labels)) >= len(labels):
                order = list(reversed(order))
            orders.append(order)
            for label in order:
                start = time.perf_counter_ns()
                actual = run([binaries[label]], path, environment)
                elapsed = time.perf_counter_ns() - start
                assert actual.stdout == expected and not actual.stderr, (name, label, actual)
                samples[label].append(elapsed)
        profiles, rss = {}, {}
        for label, binary in binaries.items():
            # RSS is a separate fresh-process run; /usr/bin/time is outside timings.
            actual = run([args.time, '-v', binary], path, environment)
            assert actual.stdout == expected
            match = re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', actual.stderr)
            assert match, actual.stderr
            rss[label] = int(match[1]) * 1024
            (out / f'{name}-{label}-rss.txt').write_bytes(actual.stderr)
            if label.startswith(('fwp-', 'before-')):
                actual = run([out / (label + '-profile')], path, environment)
                assert actual.stdout == expected
                counts = json.loads(actual.stderr)
                assert counts['finalChargedBytes'] == 0, (name, label, counts)
                if label.endswith('-arc'):
                    assert counts['collections'] == 0, counts
                profiles[label] = counts
        assert baseline['results'][name]['inputSha256'] == digest(path)
        for mode in ('arc', 'tracing'):
            before, after = profiles['before-' + mode], profiles['fwp-' + mode]
            checks = {
                'baseline counts reproduce': before == baseline['results'][name]['managedProfiles']['fwp-' + mode],
                'fewer requests': after['requests'] < before['requests'],
                'fewer requested bytes': after['requestedBytes'] < before['requestedBytes'],
                'no extra retains': after['retains'] <= before['retains'],
                'no higher managed peak': after['peakChargedBytes'] <= before['peakChargedBytes'],
            }
            acceptance_failures.extend(f'{name} {mode}: {check}'
                                       for check, passed in checks.items() if not passed)
        medians = {label: statistics.median(values) for label, values in samples.items()}
        ratios = {label: {peer: medians[label] / medians[peer] for peer in ('c', 'rust')}
                  for label in ('fwp-arc', 'fwp-tracing')}
        results[name] = dict(tokens=tokens, vocabulary=vocabulary, inputBytes=len(data),
                             inputSha256=digest(path), samplesNs=samples, medianNs=medians,
                             ratios=ratios, orders=orders,
                             candidateOverBaseline={mode: medians['fwp-' + mode] / medians['before-' + mode]
                                                    for mode in ('arc', 'tracing')}, peakProcessRssBytes=rss,
                             managedProfiles=profiles)
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    tracked = [source, ROOT / 'tests/fixtures/wordfreq_bench.c',
               ROOT / 'tests/fixtures/wordfreq_bench.rs', Path(__file__),
               ROOT / 'scripts/measure-iteration.py']
    report = dict(source=os.environ['GITHUB_SHA'], host=args.host,
                  machine=platform.machine(), cpu=run(['lscpu'], empty, environment).stdout.decode(),
                  cCompiler=run([args.cc, '--version'], empty, environment).stdout.decode(),
                  rustCompiler=run([args.rustc, '--version', '--verbose'], empty, environment).stdout.decode(),
                  environment={key: value for key, value in environment.items() if key.startswith('FWP_')},
                  arguments=vars(args) | {'compiler': str(compiler), 'output': str(out), 'baseline': str(args.baseline)},
                  baselineSource=args.baseline_source, baselineGeneratedCHashes=baseline_c,
                  commands=commands, buildNs=build_times, binaries=evidence, results=results,
                  acceptanceFailures=acceptance_failures,
                  sourceHashes={str(path.relative_to(ROOT)): digest(path) for path in tracked},
                  scope='Whole process including input read, normalization, sorted-map counting, ranking, '
                  'printing and teardown. Input generation and compilation excluded. Timings use '
                  'uninstrumented binaries; fresh-process RSS and fwp managed counters are separate. '
                  'C/Rust implement only ASCII; input fixtures are ASCII. fwp also accepts UTF-8 text, with ASCII-only lowercasing. '
                  'All materialize normalized words and use sorted contiguous key/count pairs. '
                  'String/list layout, allocation growth, sorting and buffering implementations differ. C/Rust combine the three normalization passes; fwp may allocate intermediate strings. '
                  'Managed counters exclude raw buffers, allocator metadata, stacks and process startup; '
                  'they are not comparable to whole-process RSS. No C/Rust allocation counts are claimed. '
                  'Ratios are per-host fwp median / peer median; all samples retained. '
                  "Before variants recompile saved baseline C with this run's toolchain and flags. "
                  'All six variants run in balanced order on this host; baseline counts must reproduce exactly. '
                  'Candidate allocation requests/bytes must fall with no higher retains or managed peak. '
                  'Timing is reported even when slower; no timing budget or language-wide speed claim is established.')
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: row['ratios'] for name, row in results.items()}, indent=2))
    assert not acceptance_failures, acceptance_failures


if __name__ == '__main__':
    main()
