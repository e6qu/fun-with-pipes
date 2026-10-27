#!/usr/bin/env python3
"""Compare retained generated sort kernels, with baseline noise measured first."""

import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import re
import shutil
import statistics
import subprocess


ROOT = Path(__file__).resolve().parent.parent


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def kernel(code, inline):
    """Select the actual word-frequency sort entry, requiring its exact shape."""
    if inline:
        entries = re.findall(r'static V (fwp_sort_keys\d+)\(V xs\) \{', code)
        assert len(entries) == 1, entries
        entry, = entries
        start = code.index(f'static V {entry}(V xs) {{')
        end = code.index('\n}\n', start)
        descriptors = re.findall(r'fwp_copy_finish\(vals, n, 0, (&d\d+)\)', code[start:end])
        assert len(descriptors) == 1
        return f'{entry}(xs)', descriptors[0]
    entries = re.findall(r'/\* sort-by :[^\n]+\*/\nstatic V (f\d+)\(V l0, V l1\)', code)
    callbacks = re.findall(r'/\* sort-by-fn : \(String, I64\) -> \(I64, String\) \*/\nstatic fwp_wr\d+ w(\d+)\(', code)
    descriptors = re.findall(r'fwp_p_sort_by_copied\(l0, l1, &d\d+, fwp_drop\d+, (&d\d+)\)', code)
    assert len(entries) == len(callbacks) == len(descriptors) == 1
    return f'{entries[0]}(PTR(&fc{callbacks[0]}), xs)', descriptors[0]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--baseline', required=True, type=Path)
    parser.add_argument('--candidate', required=True, type=Path)
    parser.add_argument('--baseline-source', required=True)
    parser.add_argument('--candidate-source', required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--cpu', required=True, type=int)
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--warmups', required=True, type=int)
    parser.add_argument('--small-rounds', required=True, type=int)
    parser.add_argument('--large-rounds', required=True, type=int)
    parser.add_argument('--max-control-ratio', required=True, type=float)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.samples >= 6 and args.samples % 2 == 0 and args.warmups >= 1
    assert args.small_rounds > 0 and args.large_rounds > 0 and args.timeout > 0
    assert args.cpu in os.sched_getaffinity(0)
    assert 1 < args.max_control_ratio < 2
    assert all(re.fullmatch('[0-9a-f]{40}', value) for value in
               (args.baseline_source, args.candidate_source))
    args.output.mkdir(parents=True, exist_ok=False)
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment['LC_ALL'] = 'C'
    commands = []

    def run(command):
        command = list(map(str, command))
        commands.append(command)
        output = subprocess.run(command, capture_output=True, env=environment, timeout=args.timeout)
        assert output.returncode == 0, (command, output.returncode, output.stderr.decode(errors='replace'))
        assert not output.stderr, (command, output.stderr)
        return output.stdout

    report = dict(baselineSource=args.baseline_source, candidateSource=args.candidate_source,
                  protocolSource=run(['git', 'rev-parse', 'HEAD']).decode().strip(),
                  scriptSha256=digest(Path(__file__)),
                  harnessSha256=digest(ROOT / 'tests/fixtures/sort_key_timing.c'),
                  machine=platform.machine(), cpu=run(['lscpu']).decode(),
                  compiler=run([args.cc, '--version']).decode(), commands=commands,
                  scope='fwp A3 versus fwp A4 generated sorting kernels, not C/Rust. '
                        'Timer includes key calculation, stable sort, result-list construction and release. '
                        'Input construction, independent order validation, process startup and printing are excluded. '
                        'Each sample is a fresh process; two sampling sessions share one native runner. '
                        'These sessions do not establish performance across independent runner allocations.',
                  settings=vars(args) | {'output': str(args.output), 'baseline': str(args.baseline),
                                         'candidate': str(args.candidate)}, files={}, cases={}, failures=[])
    for label, directory, source, inline in [
        ('baseline', args.baseline, args.baseline_source, False),
        ('candidate', args.candidate, args.candidate_source, True),
    ]:
        measured = json.loads((directory / 'report.json').read_text())
        assert measured['source'] == source and measured['machine'] == platform.machine()
        assert measured['cases']['wordfreq']['sourceSha256'] == digest(ROOT / 'examples/wordfreq.fwp')
        original = directory / 'wordfreq/ordinary.c'
        assert digest(original) == measured['cases']['wordfreq']['files']['ordinary.c']
        code = original.read_text()
        call, descriptor = kernel(code, inline)
        marker = 'int main(int argc, char **argv)'
        assert code.count(marker) == 1
        harness = (ROOT / 'tests/fixtures/sort_key_timing.c').read_text()
        code = code.replace(marker, 'int original_main(int argc, char **argv)')
        code += harness.replace('@sort@', call).replace('@list@', descriptor)
        cfile = args.output / (label + '.c')
        cfile.write_text(code)
        binary = args.output / (label + '.exe')
        run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math',
             '-fno-lto', '-fstack-usage', '-w', cfile, '-o', binary, '-lm', '-lpthread', '-ldl'])
        report['files'][label] = dict(originalC=digest(original), harness=digest(cfile),
                                      binary=digest(binary), binaryBytes=binary.stat().st_size)
    control = args.output / 'baseline-copy.exe'
    shutil.copyfile(args.output / 'baseline.exe', control)
    shutil.copymode(args.output / 'baseline.exe', control)
    assert digest(control) == report['files']['baseline']['binary']

    def sample(label, elements, rounds):
        row = json.loads(run(['taskset', '--cpu-list', args.cpu,
                             args.output / (label + '.exe'), elements, rounds]))
        assert row['elements'] == elements and row['rounds'] == rounds
        assert type(row['nanoseconds']) is int and row['nanoseconds'] >= 1_000_000
        return row['nanoseconds']

    for elements, rounds in [(256, args.small_rounds), (4096, args.large_rounds)]:
        row = dict(elements=elements, rounds=rounds, control=[], candidate=[])
        report['cases'][str(elements)] = row
        for session in range(2):
            for _ in range(args.warmups):
                sample('baseline', elements, rounds)
                sample('baseline-copy', elements, rounds)
            pairs = []
            for i in range(args.samples):
                order = ['baseline', 'baseline-copy'] if i % 2 == 0 else ['baseline-copy', 'baseline']
                pairs.append({label: sample(label, elements, rounds) for label in order})
            row['control'].append(dict(session=session, pairs=pairs))
        ratios = [pair['baseline-copy'] / pair['baseline']
                  for session in row['control'] for pair in session['pairs']]
        # Freeze the allowed difference before observing the candidate. Double
        # the largest same-binary deviation to cover both sides of a ratio.
        noise = max(abs(ratio - 1) for ratio in ratios)
        row['controlEnvelope'] = noise
        row['allowedCandidateRatio'] = 1 + 2 * noise
        if 1 + noise > args.max_control_ratio:
            report['failures'].append(f'{elements}: identical-code control exceeds explicit noise limit')
            continue
        (args.output / f'budget-{elements}.json').write_text(json.dumps(row, indent=2) + '\n')
        for session in range(2):
            for _ in range(args.warmups):
                sample('baseline', elements, rounds)
                sample('candidate', elements, rounds)
            pairs = []
            for i in range(args.samples):
                order = ['baseline', 'candidate'] if i % 2 == 0 else ['candidate', 'baseline']
                pairs.append({label: sample(label, elements, rounds) for label in order})
            ratio = statistics.median(pair['candidate'] / pair['baseline'] for pair in pairs)
            row['candidate'].append(dict(session=session, pairs=pairs, medianRatio=ratio))
            if ratio > row['allowedCandidateRatio']:
                report['failures'].append(f'{elements}/{session}: candidate exceeds frozen ratio budget')
    (args.output / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    assert not report['failures'], '\n'.join(report['failures'])
    print('Both sizes passed independent output/cleanup checks and the frozen same-runner timing budgets')


if __name__ == '__main__':
    main()
