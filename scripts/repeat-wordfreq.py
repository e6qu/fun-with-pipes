#!/usr/bin/env python3
"""Repeat the six accepted word-frequency binaries and inspect C stack estimates."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', required=True, type=Path)
    parser.add_argument('--source', required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--nm', required=True)
    parser.add_argument('--objdump', required=True)
    parser.add_argument('--host', required=True)
    parser.add_argument('--warmups', required=True, type=int)
    parser.add_argument('--samples', required=True, type=int)
    parser.add_argument('--timeout', required=True, type=int)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert args.warmups > 0 and args.samples > 0 and args.samples % 12 == 0 and args.timeout > 0
    source = args.input.resolve()
    report = json.loads((source / 'comparison.json').read_text())
    assert report['source'] == args.source and report['host'] == args.host
    assert report['machine'] == platform.machine() and not report['acceptanceFailures']
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    env = {k: v for k, v in os.environ.items()
           if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    env.update(report['environment'])
    commands = []
    empty = source / 'empty.stdin'
    assert empty.read_bytes() == b''

    def run(command, input_path):
        command = list(map(str, command))
        with input_path.open('rb') as stream:
            result = subprocess.run(command, stdin=stream, capture_output=True, env=env,
                                    timeout=args.timeout)
        assert result.returncode == 0, (command, result)
        return result

    compiler = run([args.cc, '--version'], empty).stdout.decode()
    assert compiler == report['cCompiler'], 'stack comparison requires the original GCC version'
    labels = ['c', 'rust', 'fwp-arc', 'fwp-tracing', 'before-arc', 'before-tracing']
    assert set(report['binaries']) == set(labels)
    stack = {}
    binaries = {}
    for label in labels:
        binary = source / label
        assert digest(binary) == report['binaries'][label]['sha256']
        assert binary.stat().st_size == report['binaries'][label]['bytes']
        header = binary.read_bytes()[:20]
        assert header[:6] == b'\x7fELF\x02\x01'
        assert int.from_bytes(header[18:20], 'little') == {'x86_64': 62, 'aarch64': 183}[platform.machine()]
        binary.chmod(binary.stat().st_mode | 0o100)
        binaries[label] = binary
        if not label.startswith(('fwp-', 'before-')):
            continue
        if label.endswith('-arc'):
            symbols = run([args.nm, binary], empty).stdout
            assert not any(s in symbols for s in (b'fwp_gc_scan', b'fwp_gc_mark_all', b'fwp_gc_sweep'))
        cfile = out / (label + '.c')
        cfile.write_bytes((source / (label + '.c')).read_bytes())
        rebuilt = out / label
        command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-fstack-usage',
                   '-w', cfile, '-o', rebuilt, '-lm', '-lpthread', '-ldl']
        run(command, empty)
        commands.append(list(map(str, command)))
        # Adding stack estimates must not change the instructions being described.
        original_asm = run([args.objdump, '-d', binary], empty).stdout.decode()
        rebuilt_asm = run([args.objdump, '-d', rebuilt], empty).stdout.decode()
        original_body = original_asm[original_asm.index('Disassembly of section'):]
        rebuilt_body = rebuilt_asm[rebuilt_asm.index('Disassembly of section'):]
        assert original_body == rebuilt_body, label
        (out / (label + '.asm')).write_text(rebuilt_asm)
        stack_files = list(out.glob(label + '*.su'))
        assert stack_files, label
        frames = []
        for path in stack_files:
            for line in path.read_text().splitlines():
                location, size, kind = line.split('\t')
                frames.append(dict(function=location.rsplit(':', 1)[-1], bytes=int(size), kind=kind))
        assert frames
        stack[label] = dict(generatedCSha256=digest(cfile), rebuiltSha256=digest(rebuilt),
                            instructionsUnchanged=True, frames=frames,
                            largestReportedFrame=max(frame['bytes'] for frame in frames))

    results = {}
    for case, prior in report['results'].items():
        input_path = source / (case + '.stdin')
        data = input_path.read_bytes()
        assert hashlib.sha256(data).hexdigest() == prior['inputSha256']
        expected = (source / (case + '.stdout')).read_bytes()
        for _ in range(args.warmups):
            for binary in binaries.values():
                result = run([binary], input_path)
                assert result.stdout == expected and not result.stderr
        samples = {label: [] for label in labels}
        orders = []
        for number in range(args.samples):
            order = labels[number % 6:] + labels[:number % 6]
            if number % 12 >= 6:
                order.reverse()
            orders.append(order)
            for label in order:
                start = time.perf_counter_ns()
                result = run([binaries[label]], input_path)
                elapsed = time.perf_counter_ns() - start
                assert result.stdout == expected and not result.stderr
                samples[label].append(elapsed)
        medians = {label: statistics.median(values) for label, values in samples.items()}
        results[case] = dict(inputSha256=prior['inputSha256'], samplesNs=samples,
                             medianNs=medians, orders=orders,
                             candidateOverBaseline={mode: medians['fwp-' + mode] / medians['before-' + mode]
                                                    for mode in ('arc', 'tracing')},
                             ratios={mode: {peer: medians['fwp-' + mode] / medians[peer]
                                            for peer in ('c', 'rust')} for mode in ('arc', 'tracing')})
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    result = dict(source=args.source, host=args.host, machine=platform.machine(),
                  cpu=run(['lscpu'], empty).stdout.decode(), compiler=compiler,
                  sourceReportSha256=digest(source / 'comparison.json'),
                  binaries=report['binaries'], configuration=dict(warmups=args.warmups, samples=args.samples,
                  timeout=args.timeout), environment=report['environment'], results=results,
                  stack=stack, commands=commands,
                  scope='Whole fresh process as in the source comparison, using exactly its accepted binaries. '
                  'Compilation and inspection occur before warmup and timing. Stack estimates are GCC per-function '
                  'frames for identical emitted instructions, not summed live stack or recursion bounds. '
                  'Managed counts are not remeasured here. Slower results remain in the report; no timing gate is set.')
    (out / 'comparison.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({case: row['candidateOverBaseline'] for case, row in results.items()}, indent=2))


if __name__ == '__main__':
    main()
