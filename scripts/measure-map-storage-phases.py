#!/usr/bin/env python3
"""Compare construction and query costs for both map storage layouts."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import re
import time

ROOT = Path(__file__).resolve().parent.parent


def instrument_queries(code):
    """Time the existing construction and subsequent query loop separately."""
    declaration = 'typedef uint64_t V;'
    assert code.count(declaration) == 1
    code = code.replace(declaration, declaration + r'''
static uint64_t map_work_build_ns;
static unsigned map_work_build_count;
static uint64_t map_work_now(void) { struct timespec ts; clock_gettime(CLOCK_MONOTONIC, &ts); return (uint64_t)ts.tv_sec*1000000000ULL+(uint64_t)ts.tv_nsec; }
''')
    table = re.findall(r'/\* table : Map\[I64, I64\] \*/\nstatic V (f\d+)\(void\)', code)
    assert len(table) == 1, 'expected the maintained benchmark table'
    call = f'V next = {table[0]}();'
    assert code.count(call) == 1
    code = code.replace(call, 'uint64_t map_work_start = map_work_now(); ' + call
                        + ' map_work_build_ns += map_work_now() - map_work_start; map_work_build_count++;')
    loops = list(re.finditer(r'static V fwp_loop_fields\d+\([^\n]*\) \{', code))
    assert len(loops) == 1, 'expected one maintained benchmark query loop'
    start = loops[0].start()
    end = code.index('\n}', start) + 2
    loop = code[start:end]
    assert loop.count('return out;') == 1
    loop = loop.replace('{\n', '{\n    unsigned map_work_before = map_work_build_count;\n    uint64_t map_work_start = map_work_now();\n', 1)
    loop = loop.replace('return out;', r'''uint64_t map_work_total = map_work_now() - map_work_start;
            fprintf(stderr, "{\"stage\":\"query-loop\",\"queryNs\":%llu,\"constructionNs\":%llu,\"constructionCount\":%u,\"constructionBeforeLoop\":%u}\n",
                (unsigned long long)map_work_total, (unsigned long long)map_work_build_ns, map_work_build_count, map_work_before);
            return out;''')
    return code[:start] + loop + code[end:]


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full measurements run on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    options = parser.parse_args()
    original, out = options.input.resolve(), options.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    modules = {}
    for name in ['measure-large-map', 'measure-map-phases']:
        spec = importlib.util.spec_from_file_location(name, ROOT / 'scripts' / (name + '.py'))
        modules[name] = importlib.util.module_from_spec(spec)
        spec.loader.exec_module(modules[name])
    helper, phases = modules.values()
    baseline = json.loads((original / 'report.json').read_text())
    env = dict(os.environ)
    results = []
    for case in baseline['cases']:
        work, variants = case['work'], {}
        for label, source_variant in case['variants'].items():
            source = original / (source_variant['binary'] + '.c')
            generated = out / source.name
            generated.write_text((instrument_queries if work == 'full' else phases.instrument)(source.read_text()))
            binary = generated.with_suffix('')
            command = [os.environ['CC'], '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                       generated, '-o', binary, '-lm', '-lpthread']
            helper.run(command, env)
            variants[label] = {**helper.inspect(binary, env), 'command': list(map(str, command)),
                               'sourceSha256': helper.digest(source),
                               'generatedSha256': helper.digest(generated), 'samples': []}
        orders, labels = [], list(variants)
        for round_number in range(16):
            offset = round_number % len(labels)
            order = labels[offset:] + labels[:offset]
            orders.append(order)
            for label in order:
                start = time.perf_counter_ns()
                result = helper.run([out / variants[label]['binary']], env)
                elapsed = time.perf_counter_ns() - start
                assert result.stdout == case['expected']
                events = [json.loads(line) for line in result.stderr.splitlines()]
                if work == 'full':
                    assert len(events) == 1 and events[0]['stage'] == 'query-loop'
                    event = events[0]
                    assert event['constructionCount'] == event['constructionBeforeLoop'] == 1
                    assert event['constructionNs'] > 0 and event['queryNs'] > 0
                else:
                    assert [e['stage'] for e in events if e['stage'] != 'large-allocation'] == [
                        'scratch-allocation', 'sort', 'deduplicate', 'result-allocation', 'materialize', 'release-scratch']
                variants[label]['samples'].append({'processWallNs': elapsed, 'events': events})
        results.append({'work': work, 'expected': case['expected'], 'executionOrder': orders, 'variants': variants})
        (out / 'cases.json').write_text(json.dumps(results, indent=2) + '\n')
        print(work, json.dumps({label: v['samples'] for label, v in variants.items()}), flush=True)
    report = {key: baseline[key] for key in ['source', 'controlSource', 'hardware', 'cpu', 'compiler']}
    report.update({'cases': results, 'scope':
        'Separate diagnostic executables compare joined and original separate storage on the same host. '
        'The historical builder also retains scratch longer; this is not a layout-only comparison. '
        'Phase labels follow statement boundaries: sort includes early scratch release in the '
        'current builder; release-scratch includes it in the historical builder. Deduplicate '
        'addresses name input lanes. Construction probes record six phases and addresses, so an '
        'unreproduced slow control cannot establish a repair. Full-work probes time the actual '
        'table construction and subsequent query loop separately, without changing evaluation order. '
        'The maintained program constructs its table before printing its size and starting queries; '
        'the probe verifies exactly one construction before the query interval and none inside it. '
        'No subtraction of independently run programs is used. Clock reads and diagnostic code perturb '
        'execution; ordinary timings remain in the storage report. Sixteen fresh processes per '
        'variant rotate order. Compare CPU models explicitly across runs.'})
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
