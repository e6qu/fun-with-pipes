#!/usr/bin/env python3
"""Compare joined map buffers with the old separate layout on the same runner."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import re
import statistics
import time

ROOT = Path(__file__).resolve().parent.parent


def separate_storage(code):
    control = (ROOT / 'scripts/fixtures/map-separate-storage.c').read_text()
    for name in ['fwp_map_build_typed', 'fwp_p_map_from_list_typed']:
        declaration = 'static V ' + name + '('
        start = code.index(declaration)
        end = code.index('\nstatic ', start + 1)
        old_start = control.index(declaration)
        old_end = control.find('\nstatic ', old_start + 1)
        body = control[old_start:old_end if old_end >= 0 else len(control)].rstrip()
        code = code[:start] + body + code[end:]
    # Numeric direct/dynamic builders share one emitted storage body. Restore
    # its old independent owners, leaving callbacks and result semantics intact.
    pattern = r'(?P<indent> +)V \*keys = \(V \*\)fwp_mem_alloc\(2 \* n \* sizeof\(V\)\);.*?fwp_scratch_finish\(&keys, &keys_cleanup\);'
    count = 0

    def restore(match):
        nonlocal count
        count += 1
        body, indent = match[0], match['indent']
        body = body.replace('fwp_mem_alloc(2 * n * sizeof(V))', 'fwp_mem_alloc((n + 1) * sizeof(V))')
        assert body.count('V *vals = keys + n;') == 1
        body = body.replace('V *vals = keys + n;',
                            'V *vals = (V *)fwp_mem_alloc((n + 1) * sizeof(V));\n'
                            + indent + 'fwp_cleanup vals_cleanup;\n'
                            + indent + 'fwp_scratch_protect(&vals, &vals_cleanup);')
        body = body.replace('fwp_scratch_finish(&keys, &keys_cleanup);',
                            'fwp_scratch_finish(&vals, &vals_cleanup);\n'
                            + indent + 'fwp_scratch_finish(&keys, &keys_cleanup);')
        return body

    code = re.sub(pattern, restore, code, flags=re.S)
    assert count >= 1, 'missing numeric map storage'
    return code


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full measurements run on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    options = parser.parse_args()
    original = options.input.resolve()
    out = options.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    spec = importlib.util.spec_from_file_location('large_map', ROOT / 'scripts/measure-large-map.py')
    helper = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(helper)
    spec = importlib.util.spec_from_file_location('iteration', ROOT / 'scripts/measure-iteration.py')
    iteration = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(iteration)
    baseline = json.loads((original / 'report.json').read_text())
    env = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    cc = os.environ['CC']
    results = []
    for work in ['full', 'construction']:
        expected = next(case['expected'] for case in baseline['cases'] if case['work'] == work)
        variants = {}
        for mode in ['tracing', 'arc']:
            source = original / f'{work}-{mode}-fusion-1.c'
            code = source.read_text()
            for layout in ['separate', 'joined']:
                label = f'{mode}-{layout}'
                cfile = out / f'{work}-{label}.c'
                cfile.write_text(separate_storage(code) if layout == 'separate' else code)
                binary = out / f'{work}-{label}'
                profile = out / f'{work}-{label}-profile.c'
                profile.write_text(iteration.instrument(cfile.read_text()))
                measured = out / f'{work}-{label}-profile'
                commands = []
                for generated, executable in [(cfile, binary), (profile, measured)]:
                    command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                               generated, '-o', executable, '-lm', '-lpthread']
                    helper.run(command, env)
                    commands.append(list(map(str, command)))
                measured_result = helper.run([measured], env)
                assert measured_result.stdout == expected
                counters = json.loads(measured_result.stderr)
                assert counters['finalChargedBytes'] == 0, counters
                if mode == 'arc':
                    assert counters['collections'] == 0, counters
                actual = helper.run([binary], env)
                assert actual.stdout == expected and not actual.stderr
                variants[label] = {**helper.inspect(binary, env), 'commands': commands,
                                   'sourceSha256': helper.digest(source),
                                   'generatedSha256': helper.digest(cfile),
                                   'profileSha256': helper.digest(measured),
                                   'counters': counters, 'processWallNs': []}
        orders = []
        labels = list(variants)
        for round_number in range(24):
            offset = round_number % len(labels)
            order = labels[offset:] + labels[:offset]
            orders.append(order)
            for label in order:
                start = time.perf_counter_ns()
                actual = helper.run([out / variants[label]['binary']], env)
                elapsed = time.perf_counter_ns() - start
                assert actual.stdout == expected and not actual.stderr
                variants[label]['processWallNs'].append(elapsed)
        for variant in variants.values():
            variant['medianProcessWallNs'] = statistics.median(variant['processWallNs'])
        ratios = {mode: variants[f'{mode}-joined']['medianProcessWallNs'] /
                  variants[f'{mode}-separate']['medianProcessWallNs'] for mode in ['tracing', 'arc']}
        for mode in ['tracing', 'arc']:
            assert variants[f'{mode}-separate']['counters']['requests'] - variants[f'{mode}-joined']['counters']['requests'] == 2
            assert variants[f'{mode}-separate']['counters']['retains'] == variants[f'{mode}-joined']['counters']['retains']
        results.append({'work': work, 'expected': expected, 'executionOrder': orders,
                        'variants': variants, 'joinedToSeparateTimeRatio': ratios})
        (out / 'cases.json').write_text(json.dumps(results, indent=2) + '\n')
        print(work, json.dumps({'ratios': ratios, 'samplesMs': {
            label: [t / 1e6 for t in v['processWallNs']] for label, v in variants.items()}}), flush=True)
    report = {'source': helper.run(['git', 'rev-parse', 'HEAD'], env).stdout.strip(),
              'controlSource': '9f0632f9c1abf4f067fa659f1d95c5768cb8a965',
              'hardware': baseline['hardware'], 'cpu': baseline['cpu'], 'compiler': baseline['compiler'],
              'scope': 'Same-runner, same-compiler comparison of joined key/value storage with the '
                       'original independent allocations. The old builder bodies are an explicit '
                       'measurement fixture; numeric callback and sorting code stay unchanged. '
                       'All variants retain checked arithmetic, ownership and cleanup. Twenty-four '
                       'fresh processes per variant rotate order; each position occurs six times. '
                       'Full work constructs 500,000 entries and makes 2,000,000 lookups; separate '
                       'construction programs only print size. Neither is an isolated sort/lookup '
                       'measurement. Separate instrumented programs count managed requests, retains '
                       'and charged storage; they are excluded from ordinary timing. Actual timed '
                       'binaries, sources, counters and raw samples are retained. No C/Rust parity '
                       'or particular cache/TLB mechanism is claimed.', 'cases': results}
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
