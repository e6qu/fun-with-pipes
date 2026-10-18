#!/usr/bin/env python3
"""Measure a scoped cached-map borrow prototype; this is not compiler behavior."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import statistics
import time

ROOT = Path(__file__).resolve().parent.parent


def module(name):
    spec = importlib.util.spec_from_file_location(name, ROOT / 'scripts' / (name + '.py'))
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def borrow_queries(code):
    """Only this benchmark: its table is owned before its non-suspending loop."""
    table, = re.findall(r'/\* table : Map\[I64, I64\] \*/\nstatic V f(\d+)\(void\)', code)
    loop, = re.findall(r'static V fwp_loop_fields\d+\([^\n]*\) \{(.*?)\n\}', code, re.S)
    step, = set(re.findall(r'int done = (fs\d+)\(st, nx, &out\);', loop))
    start = code.index(' int ' + step + '(')
    end = code.index('\n}', start) + 2
    body = code[start:end]
    binding, = re.findall(r'V (t\d+) = caf' + table + r'\(\);\n\s*(l\d+) = \1;', body)
    temporary, local = binding
    call = f'V {temporary} = caf{table}();'
    assert body.count(call) == 1
    body = body.replace(call, f'if (!fwp_caf_state{table}) fwp_trap("benchmark table is not initialized");\n'
                        f'        V {temporary} = fwp_caf_value{table};')
    drop, = re.findall(r'fwp_drop\d+\(' + local + r'\);', body)
    body = body.replace(drop, '')
    # Require the expected immediate numeric lookup, keeping key arithmetic,
    # its checked traps, and the existing KEEP_ALIVE in their original order.
    assert body.count(f'fwp_map_find({local},') == 1
    assert body.count(f'FWP_KEEP_ALIVE({local});') == 1
    return code[:start] + body + code[end:]


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full measurements run on GitHub'
    assert platform.system() == 'Linux'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--host', required=True, choices=['ubuntu-latest', 'ubuntu-24.04-arm'])
    parser.add_argument('--output', required=True, type=Path)
    options = parser.parse_args()
    helper, replay, iteration = [module(name) for name in ['measure-large-map', 'replay-map-storage', 'measure-iteration']]
    out = options.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    replay.save(out / 'request.json', {'run': options.run, 'source': options.source, 'host': options.host})
    meta = json.loads(helper.run(['gh', 'run', 'view', options.run, '--repo', 'e6qu/fun-with-pipes',
                                  '--json', 'headSha,status,conclusion,jobs'], env).stdout)
    replay.save(out / 'run.json', meta)
    assert meta['headSha'] == options.source and meta['status'] == 'completed' and meta['conclusion'] == 'success'
    assert all(job['conclusion'] in ['success', 'skipped'] for job in meta['jobs'])
    original = out / 'original'
    helper.run(['gh', 'run', 'download', options.run, '--repo', 'e6qu/fun-with-pipes',
                '--name', 'large-map-' + options.host, '--dir', original], env)
    report = json.loads((original / 'storage/report.json').read_text())
    machine = {'x86_64': 62, 'aarch64': 183}[platform.machine()]
    replay.validate(original / 'storage', report, options.source, machine)
    full, = [case for case in report['cases'] if case['work'] == 'full']
    variants = {}
    for name, baseline in full['variants'].items():
        source = original / 'storage' / (baseline['binary'] + '.c')
        code = source.read_text()
        for ownership in ['retained', 'borrowed']:
            label = name + '-' + ownership
            generated = out / (label + '.c')
            generated.write_text(borrow_queries(code) if ownership == 'borrowed' else code)
            binary = out / label
            profile = out / (label + '-profile.c')
            profile.write_text(iteration.instrument(generated.read_text()))
            measured = profile.with_suffix('')
            commands = []
            for cfile, executable in [(generated, binary), (profile, measured)]:
                command = [os.environ['CC'], '-O2', '-std=gnu11', '-ffp-contract=off', '-w', cfile, '-o', executable, '-lm', '-lpthread']
                helper.run(command, env)
                commands.append(list(map(str, command)))
            result = helper.run([measured], env)
            assert result.stdout == full['expected']
            counters = json.loads(result.stderr)
            assert counters['retains'] == (1 if ownership == 'borrowed' else 2000001), counters
            for key in ['requests', 'peakChargedBytes', 'finalChargedBytes', 'collections']:
                assert counters[key] == baseline['counters'][key], (key, counters, baseline['counters'])
            result = helper.run([binary], env)
            assert result.stdout == full['expected'] and not result.stderr
            variants[label] = {**helper.inspect(binary, env), 'commands': commands,
                               'generatedSha256': helper.digest(generated), 'profileSha256': helper.digest(measured),
                               'counters': counters, 'processWallNs': []}
    result = {'source': helper.run(['git', 'rev-parse', 'HEAD'], env).stdout.strip(),
              'programSource': options.source, 'programRun': options.run,
              'cpu': helper.run(['lscpu'], env).stdout, 'hardware': platform.platform(),
              'compiler': helper.run([os.environ['CC'], '--version'], env).stdout,
              'expected': full['expected'], 'variants': variants, 'executionOrder': [],
              'scope': 'Measurement-only prototype for the maintained map program. Its printed size '
                       'initializes the table before a numeric loop that cannot suspend or invoke callbacks. '
                       'A checked borrowed read replaces only the loop retain/release pair; original '
                       'initialization, key arithmetic, lookup and failure order remain. The cache owner '
                       'stays alive through the loop. This manual proof is specific to this program; '
                       'the compiler does not yet prove general cached borrows. Twenty-four balanced '
                       'fresh-process samples per variant; separate profiles are excluded from timing.'}
    labels = list(variants)
    for number in range(24):
        offset = number % len(labels)
        order = labels[offset:] + labels[:offset]
        result['executionOrder'].append(order)
        for label in order:
            start = time.perf_counter_ns()
            actual = helper.run([out / label], env)
            elapsed = time.perf_counter_ns() - start
            assert actual.stdout == full['expected'] and not actual.stderr
            variants[label]['processWallNs'].append(elapsed)
        replay.save(out / 'report.json', result)
    for variant in variants.values():
        variant['medianProcessWallNs'] = statistics.median(variant['processWallNs'])
    replay.save(out / 'report.json', result)
    print(json.dumps({label: v['medianProcessWallNs'] / 1e6 for label, v in variants.items()}), flush=True)


if __name__ == '__main__':
    main()
