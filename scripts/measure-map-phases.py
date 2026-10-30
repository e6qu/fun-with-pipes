#!/usr/bin/env python3
"""Locate the variable AMD64 construction cost with separate instrumented programs."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import time

ROOT = Path(__file__).resolve().parent.parent


def instrument(code):
    declaration = 'typedef uint64_t V;'
    assert code.count(declaration) == 1
    code = code.replace(declaration, declaration + r'''
static uint64_t map_probe_now(void) { struct timespec ts; if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0) { fputs("clock_gettime failed\n", stderr); exit(1); } return (uint64_t)ts.tv_sec*1000000000ULL+(uint64_t)ts.tv_nsec; }
static uint64_t map_probe_stamp(const char *stage, uint64_t before, size_t n, const void *a, const void *b) {
 uint64_t after=map_probe_now();
 fprintf(stderr,"{\"stage\":\"%s\",\"ns\":%llu,\"n\":%zu,\"a\":%llu,\"b\":%llu}\n",stage,(unsigned long long)(after-before),n,(unsigned long long)(uintptr_t)a,(unsigned long long)(uintptr_t)b);
 return map_probe_now();
}
''')
    start = code.index('static V fwp_map_build_typed(')
    end = code.index('\nstatic ', start + 1)
    builder = code[start:end]
    assert builder.count('    if (!n) return FWP_EMPTY_MAP;') == 1
    builder = builder.replace('    if (!n) return FWP_EMPTY_MAP;',
                              '    if (!n) return FWP_EMPTY_MAP;\n    uint64_t probe = map_probe_now();')
    for before, label, pointers in [
        ('    fwp_msort(keys,', 'scratch-allocation', 'tk, tv'),
        ('    size_t len = 0;', 'sort', 'keys, vals'),
        ('    V result = fwp_map_typed_new(len, ops->columns);', 'deduplicate', 'keys, vals'),
        ('    MAP(result)->len = 0;', 'result-allocation', '(void *)(uintptr_t)result, NULL'),
        ('    fwp_value_finish(&owner, &cleanup);', 'materialize', '(void *)(uintptr_t)result, NULL'),
        ('    return result;', 'release-scratch', 'NULL, NULL'),
    ]:
        assert builder.count(before) == 1, label
        stamp = f'    probe = map_probe_stamp("{label}", probe, n, {pointers});\n'
        builder = builder.replace(before, stamp + before)
    code = code[:start] + builder + code[end:]
    signature = 'static __attribute__((noinline)) void *fwp_heap_alloc_big(size_t n, int leaf) {'
    start = code.index(signature)
    end = code.index('\n}', start) + 2
    original = code[start:end]
    assert original.count('    return p;') == 1
    changed = original.replace(signature, signature + '\n    uint64_t probe = map_probe_now();')
    changed = changed.replace('    return p;',
                              '    map_probe_stamp("large-allocation", probe, n, p, NULL);\n    return p;')
    return code[:start] + changed + code[end:]


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
    baseline = json.loads((original / 'report.json').read_text())
    env = dict(os.environ)
    cc = os.environ['CC']
    variants = {}
    mode = 'counted'
    for enabled in ['0', '1']:
        label = f'{mode}-{enabled}'
        source = original / f'construction-{mode}-fusion-{enabled}.c'
        cfile = out / (label + '.c')
        cfile.write_text(instrument(source.read_text()))
        binary = out / label
        command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                   cfile, '-o', binary, '-lm', '-lpthread']
        helper.run(command, env)
        variants[label] = {**helper.inspect(binary, env), 'command': list(map(str, command)),
                           'sourceSha256': helper.digest(source),
                           'generatedSha256': helper.digest(cfile), 'samples': []}
    labels = list(variants)
    orders = []
    for round_number in range(16):
        offset = round_number % len(labels)
        order = labels[offset:] + labels[:offset]
        orders.append(order)
        for label in order:
            start = time.perf_counter_ns()
            result = helper.run([out / variants[label]['binary']], env)
            elapsed = time.perf_counter_ns() - start
            assert result.stdout == '500000\n'
            events = [json.loads(line) for line in result.stderr.splitlines()]
            assert [row['stage'] for row in events if row['stage'] != 'large-allocation'] == [
                'scratch-allocation', 'sort', 'deduplicate', 'result-allocation', 'materialize', 'release-scratch']
            variants[label]['samples'].append({'processWallNs': elapsed, 'events': events})
    report = {'source': helper.run(['git', 'rev-parse', 'HEAD'], env).stdout.strip(),
              'baselineSource': baseline['source'], 'hardware': baseline['hardware'],
              'cpu': baseline['cpu'], 'compiler': baseline['compiler'],
              'executionOrder': orders, 'variants': variants,
              'scope': 'Separate instrumented construction-only programs locate phase variation. '
                       'Clock reads and stderr reporting perturb execution; these samples are not '
                       'ordinary benchmark timings. Phase labels follow saved statement boundaries: '
                       'sort includes early scratch release in the current builder; the historical '
                       'builder releases it in release-scratch. Deduplicate addresses name input lanes. '
                       'Large-allocation timings overlap their enclosing phases; do not add them twice. '
                       'Sixteen fresh processes '
                       'per variant rotate execution order. Input is 500,000 entries; all print '
                       'the expected map size. Actual instrumented binaries and disassembly retained.'}
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    for label, row in variants.items():
        print(label, json.dumps([{'wallMs': sample['processWallNs']/1e6,
            'phaseMs': {event['stage']: event['ns']/1e6 for event in sample['events']
                        if event['stage'] != 'large-allocation'}} for sample in row['samples']]))


if __name__ == '__main__':
    main()
