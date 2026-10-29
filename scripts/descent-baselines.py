#!/usr/bin/env python3
"""Host qualification and balanced whole-process derivative measurements."""
import argparse
from collections import Counter
import hashlib
import json
import os
from pathlib import Path
import platform
import random
import subprocess
import time


def execution_order(labels, processes, round_index, seed):
    """Balance every ordered predecessor pair, including a label after itself."""
    assert len(labels) == len(set(labels)) == 7
    assert processes > 0 and processes % len(labels) == 0 and round_index >= 0
    rng = random.Random(seed)
    edges = {label: rng.sample(labels, len(labels)) for label in labels}
    stack, circuit = [labels[0]], []
    while stack:
        if edges[stack[-1]]:
            stack.append(edges[stack[-1]].pop())
        else:
            circuit.append(stack.pop())
    circuit.reverse()
    assert circuit[0] == circuit[-1]
    cycle = circuit[:-1]
    assert Counter(zip(cycle, cycle[1:] + cycle[:1])) == Counter(
        {(a, b): 1 for a in labels for b in labels})
    offset = round_index % len(cycle)
    return (cycle[offset:] + cycle[:offset]) * (processes // len(labels))


def measure_round(order, binaries, outputs, environment, run, destination):
    """Keep complete process observations, including an interrupted round."""
    observations, totals = [], {label: 0 for label in binaries}
    complete = False
    try:
        for label in order:
            started = time.perf_counter_ns()
            actual = run([binaries[label]], environment)
            elapsed = time.perf_counter_ns() - started
            matches = actual.stdout == outputs[label] and not actual.stderr and actual.returncode == 0
            observations.append(dict(label=label, elapsedNs=elapsed, status=actual.returncode,
                stdoutSha256=hashlib.sha256(actual.stdout).hexdigest(),
                stderrSha256=hashlib.sha256(actual.stderr).hexdigest(), outputMatches=matches))
            if not matches:
                destination.with_suffix('.stdout').write_bytes(actual.stdout)
                destination.with_suffix('.stderr').write_bytes(actual.stderr)
                raise AssertionError(f'{label}: process output or status changed')
            totals[label] += elapsed
        complete = True
    finally:
        destination.write_text(json.dumps(dict(order=order, observations=observations,
            totalsNs=totals, complete=complete), indent=2) + '\n')
    return totals


def host_failures(actual, expected):
    return [f'{key}: expected {value!r}, observed {actual.get(key)!r}'
            for key, value in expected.items() if actual.get(key) != value]


def host_details(cc, rustc):
    cpu = subprocess.check_output(['lscpu'], text=True)
    model, = [line.split(':', 1)[1].strip() for line in cpu.splitlines() if line.startswith('Model name:')]
    actual = dict(system=platform.system(), machine=platform.machine(), cpu=model,
        processors=len(os.sched_getaffinity(0)),
        cVersion=subprocess.check_output([cc, '--version'], text=True).splitlines()[0],
        rustVersion=subprocess.check_output([rustc, '--version'], text=True).strip())
    return actual, cpu


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['cpu', 'machine', 'cc', 'rustc', 'c-version', 'rust-version', 'source']:
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--processors', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip() == args.source
    actual, cpu = host_details(args.cc, args.rustc)
    expected = dict(system='Linux', machine=args.machine, cpu=args.cpu, processors=args.processors,
                    cVersion=args.c_version, rustVersion=args.rust_version)
    failures = host_failures(actual, expected)
    report = dict(source=args.source, actual=actual, expected=expected, lscpu=cpu,
                  failures=failures, qualified=not failures)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + '\n')
    if failures:
        raise SystemExit('Host rejected before building/timing:\n' + '\n'.join(failures))
    print('Qualified native derivative host:', actual)


if __name__ == '__main__':
    main()
