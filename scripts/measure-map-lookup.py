#!/usr/bin/env python3
"""Compare two concrete lookup costs using retained generated map programs."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import re
import statistics
import time

ROOT = Path(__file__).resolve().parent.parent


def lower_bound(code):
    start = code.index('static uint64_t fwp_map_find(')
    end = code.index('\nstatic ', start + 1)
    helper = code[start:end]
    for comparison, value in [('x', 'int64_t y = (int64_t)d[2 * mid];'),
                              ('k', 'V y = d[2 * mid];')]:
        key = 'x' if comparison == 'x' else 'k'
        old = f'''        while (lo < hi) {{
            uint64_t mid = (lo + hi) / 2;
            {value}
            if (y == {key}) {{ *found = 1; return mid; }}
            if (y < {key}) lo = mid + 1; else hi = mid;
        }}
        *found = 0;
        return lo;'''
        new = f'''        while (lo < hi) {{
            uint64_t mid = lo + (hi - lo) / 2;
            {value}
            if (y < {key}) lo = mid + 1; else hi = mid;
        }}
        *found = lo < MAP(m)->len && d[2 * lo] == k;
        return lo;'''
        assert helper.count(old) == 1, key
        helper = helper.replace(old, new)
    return code[:start] + helper + code[end:]


def separate_initializers(code):
    identifiers = re.findall(r'static int fwp_caf_state(\d+);', code)
    assert identifiers, 'expected counted cached values'
    for identifier in identifiers:
        declaration = f'static V f{identifier}(void);'
        assert code.count(declaration) == 1, identifier
        code = code.replace(declaration,
                            f'static __attribute__((noinline)) V f{identifier}(void);')
    return code, identifiers


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
    measurements = json.loads((original / 'report.json').read_text())
    env = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    cc = os.environ['CC']
    expected = measurements['cases'][0]['expected']
    variants = {}
    for mode in ['tracing', 'arc']:
        source = original / f'full-{mode}-fusion-1.c'
        code = source.read_text()
        for strategy in ['ordinary', 'lower-bound', 'separate-init', 'both']:
            changed = lower_bound(code) if strategy in ['lower-bound', 'both'] else code
            initializers = []
            if strategy in ['separate-init', 'both']:
                changed, initializers = separate_initializers(changed)
            label = f'{mode}-{strategy}'
            cfile = out / (label + '.c')
            cfile.write_text(changed)
            binary = out / label
            command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                       cfile, '-o', binary, '-lm', '-lpthread']
            helper.run(command, env)
            actual = helper.run([binary], env)
            assert actual.stdout == expected and not actual.stderr, (label, actual)
            variants[label] = {**helper.inspect(binary, env), 'command': list(map(str, command)),
                               'sourceSha256': helper.digest(source),
                               'generatedSha256': helper.digest(cfile),
                               'separatedInitializers': initializers, 'processWallNs': []}
    labels = list(variants)
    orders = []
    for round_number in range(2 * len(labels)):
        offset = round_number % len(labels)
        order = labels[offset:] + labels[:offset]
        orders.append(order)
        for label in order:
            start = time.perf_counter_ns()
            actual = helper.run([out / variants[label]['binary']], env)
            elapsed = time.perf_counter_ns() - start
            assert actual.stdout == expected and not actual.stderr, (label, actual)
            variants[label]['processWallNs'].append(elapsed)
    for label, variant in variants.items():
        variant['medianProcessWallNs'] = statistics.median(variant['processWallNs'])
    for label, variant in variants.items():
        mode = label.split('-')[0]
        variant['timeRatioToOrdinary'] = variant['medianProcessWallNs'] / variants[f'{mode}-ordinary']['medianProcessWallNs']
    report = {'source': helper.run(['git', 'rev-parse', 'HEAD'], env).stdout.strip(),
              'baselineSource': measurements['source'], 'hardware': measurements['hardware'],
              'cpu': measurements['cpu'], 'compiler': measurements['compiler'],
              'expected': expected, 'executionOrder': orders, 'variants': variants,
              'scope': 'Measurement-only edits to current generated C. All eight variants use the '
                       'same native flags and maintained 500,000-entry, 2,000,000-lookup program. '
                       'Integer lower-bound search compares equality after the search rather than '
                       'on every step; generic comparisons are unchanged. Separate-init prevents '
                       'inlining existing counted cached-value producer functions; it does not '
                       'remove cache ownership, retains, releases or evaluation. Both combines '
                       'these independent edits. Timings include construction, queries and '
                       'process startup/output/shutdown. Every variant occupies each position '
                       'twice after warmup. These are candidates, not accepted compiler changes '
                       'or isolated lookup timings. No C/Rust parity claim follows. All actual '
                       'executables, disassembly, generated C, hashes and raw samples are retained.'}
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({label: {'medianMs': row['medianProcessWallNs'] / 1e6,
                             'ratio': row['timeRatioToOrdinary']} for label, row in variants.items()}, indent=2))


if __name__ == '__main__':
    main()
