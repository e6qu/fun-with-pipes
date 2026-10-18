#!/usr/bin/env python3
"""Runner-only same-host comparison of maintained map construction and lookups."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent


def run(arguments, environment):
    result = subprocess.run(list(map(str, arguments)), cwd=ROOT, env=environment,
                            text=True, capture_output=True)
    if result.returncode:
        raise RuntimeError(f'{arguments}: exit {result.returncode}\n{result.stdout}\n{result.stderr}')
    return result


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inspect(binary, environment):
    # Inspect the executable that was timed, not a separately compiled assembly file.
    for tool, arguments, suffix in [
        ('objdump', ['-d', '--no-show-raw-insn'], '.disassembly.txt'),
        ('nm', [], '.symbols.txt'),
        ('size', ['--format=sysv'], '.sections.txt'),
    ]:
        binary.with_suffix(suffix).write_text(run([tool, *arguments, binary], environment).stdout)
    return {'binary': binary.name, 'binaryBytes': binary.stat().st_size,
            'binarySha256': digest(binary)}


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full measurements run on GitHub'
    assert platform.system() == 'Linux', 'this comparison uses native Linux binutils'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', required=True, type=Path)
    options = parser.parse_args()
    out = options.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    spec = importlib.util.spec_from_file_location('iteration', ROOT / 'scripts/measure-iteration.py')
    iteration = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(iteration)
    compiler = ROOT / 'target/release/fwp'
    cc = os.environ['CC']
    env = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    env.pop('FWP_GC', None)
    env.pop('FWP_NO_OPT', None)
    source = ROOT / 'bench/map/main.fwp'
    text = source.read_text()
    assert text.count('main =') == 1
    construction = out / 'construction.fwp'
    construction.write_text('# Construct the maintained map and print its size.\n'
                            + text[text.index('key :'):].split('main =')[0]
                            + 'main = table | map.size | echo\n')
    for extension in ['fwp', 'c', 'rs']:
        (out / f'map-source.{extension}').write_bytes((ROOT / f'bench/map/main.{extension}').read_bytes())
    peers = {}
    for kind, command in [
        ('c', [cc, '-O2', ROOT / 'bench/map/main.c', '-o', out / 'map-c']),
        ('rust', ['rustc', '-O', ROOT / 'bench/map/main.rs', '-o', out / 'map-rust']),
    ]:
        start = time.perf_counter_ns()
        run(command, env)
        elapsed = time.perf_counter_ns() - start
        binary = out / f'map-{kind}'
        peers[kind] = {**inspect(binary, env), 'buildCommand': list(map(str, command)),
                       'buildNs': elapsed, 'processWallNs': []}
    reference = run([out / peers['c']['binary']], env).stdout
    assert run([out / peers['rust']['binary']], env).stdout == reference
    assert reference.splitlines()[0] == '500000'
    cases = []
    for name, program, expected in [('full', source, reference),
                                     ('construction', construction, '500000\n')]:
        variants = dict(peers) if name == 'full' else {}
        for mode in ['tracing', 'arc']:
            for enabled in ['0', '1']:
                label = f'{name}-{mode}-fusion-{enabled}'
                binary = out / label
                build_env = dict(env, FWP_MAP_BUILD=enabled)
                command = [compiler, 'build', '--gc', mode, '-O2', program, '-o', binary]
                start = time.perf_counter_ns()
                run(command, build_env)
                elapsed = time.perf_counter_ns() - start
                generated = out / (label + '.c')
                run([compiler, 'build', '--gc', mode, '-O2', '--emit-c', program, '-o', generated], build_env)
                code = generated.read_text()
                assert ('numeric map: direct callback fields' in code) == (enabled == '1')
                measured_c = out / (label + '-profile.c')
                measured_c.write_text(iteration.instrument(code))
                measured = out / (label + '-profile')
                profile_command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                                   measured_c, '-o', measured, '-lm', '-lpthread']
                run(profile_command, build_env)
                result = run([measured], env)
                assert result.stdout == expected
                counters = json.loads(result.stderr)
                if mode == 'arc':
                    assert counters['finalChargedBytes'] == counters['collections'] == 0, counters
                variants[f'{mode}-{enabled}'] = {
                    **inspect(binary, env), 'mode': mode, 'constructionFusion': enabled == '1',
                    'buildCommand': list(map(str, command)), 'buildNs': elapsed,
                    'sourceSha256': digest(program), 'generatedSha256': digest(generated),
                    'profileCommand': list(map(str, profile_command)),
                    'profileSha256': digest(measured), 'counters': counters, 'processWallNs': [],
                }
        # Every variant occupies every position twice, after one warmup each.
        labels = list(variants)
        for label in labels:
            actual = run([out / variants[label]['binary']], env)
            assert actual.stdout == expected and not actual.stderr, (name, label, actual)
        orders = []
        for round_number in range(2 * len(labels)):
            offset = round_number % len(labels)
            order = labels[offset:] + labels[:offset]
            orders.append(order)
            for label in order:
                start = time.perf_counter_ns()
                actual = run([out / variants[label]['binary']], env)
                elapsed = time.perf_counter_ns() - start
                assert actual.stdout == expected and not actual.stderr, (name, label, actual)
                variants[label]['processWallNs'].append(elapsed)
        for variant in variants.values():
            variant['medianProcessWallNs'] = statistics.median(variant['processWallNs'])
        ratios = {mode: variants[f'{mode}-1']['medianProcessWallNs']
                  / variants[f'{mode}-0']['medianProcessWallNs'] for mode in ['tracing', 'arc']}
        cases.append({'work': name, 'expected': expected, 'executionOrder': orders,
                      'variants': variants, 'enabledToDisabledTimeRatio': ratios})
        (out / 'cases.json').write_text(json.dumps(cases, indent=2) + '\n')
        print(name, json.dumps({'timeRatios': ratios, 'variants': {
            label: {'medianMs': row['medianProcessWallNs'] / 1e6,
                    'counters': row.get('counters')} for label, row in variants.items()}}), flush=True)
    report = {
        'source': run(['git', 'rev-parse', 'HEAD'], env).stdout.strip(),
        'hardware': platform.uname()._asdict(), 'cpu': run(['lscpu'], env).stdout,
        'compiler': run([cc, '--version'], env).stdout,
        'rustc': run(['rustc', '-vV'], env).stdout,
        'scope': 'Maintained map benchmark: generate 500,000 pairs with scrambled distinct keys, '
                 'sort them during map construction, and perform '
                 '2,000,000 lookups. C/Rust outputs agree with every fwp variant. Same runner, '
                 'compiler and fwp source; compare numeric construction fusion on/off in both '
                 'default tracing and checked ARC. Separate construction-only fwp programs print '
                 'the map size; their timings are not a direct measurement of lookup time and '
                 'must not be subtracted as one. Whole-process time includes startup, allocation, '
                 'construction, queries/output and shutdown. Build time includes fwp C generation, '
                 'native compilation/linking and any ordinary compiler cache effects. C/Rust '
                 'sorting and overflow rules differ; the guide explains these comparisons. '
                 'Counter instrumentation uses separate executables excluded from timing. '
                 'Counted storage excludes allocator capacity and process RSS; tracing may retain '
                 'uncollected storage. Every variant occupies every position twice after warmup. '
                 'Actual timed executables, sources, hashes, raw samples and disassembly are saved. '
                 'No universal speed threshold or cross-run regression conclusion is assumed.',
        'cases': cases,
    }
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
