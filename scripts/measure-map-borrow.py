#!/usr/bin/env python3
"""Compare compiler-proved cached-map borrows with the saved owned-read compiler."""
import argparse
import importlib.util
import json
import os
from pathlib import Path
import platform
import statistics
import time

ROOT = Path(__file__).resolve().parent.parent


def module(name):
    spec = importlib.util.spec_from_file_location(name, ROOT / 'scripts' / (name + '.py'))
    result = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(result)
    return result


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full measurements run on GitHub'
    assert platform.system() == 'Linux'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--host', required=True, choices=['ubuntu-latest', 'ubuntu-24.04-arm'])
    parser.add_argument('--output', required=True, type=Path)
    parser.add_argument('--compiler', required=True, type=Path)
    options = parser.parse_args()
    helper, replay, iteration, storage = [module(name) for name in
        ['measure-large-map', 'replay-map-storage', 'measure-iteration', 'measure-map-storage']]
    out = options.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    env = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    env.pop('FWP_GC', None)
    env.pop('FWP_NO_OPT', None)
    env['FWP_MAP_BUILD'] = '1'
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
    program = ROOT / 'bench/map/main.fwp'
    assert program.read_bytes() == (original / 'map-source.fwp').read_bytes(), 'comparison requires identical fwp input'
    (out / 'program.fwp').write_bytes(program.read_bytes())
    compiler = options.compiler.resolve()
    current = {}
    for mode in ['tracing', 'arc']:
        generated = out / (mode + '-compiler.c')
        helper.run([compiler, 'build', '--gc', mode, '--emit-c', program, '-o', generated], env)
        code = generated.read_text()
        assert 'fwp_caf_borrow' in code, 'measured compiler must prove cached borrowing'
        current[mode + '-joined'] = code
        current[mode + '-separate'] = storage.separate_storage(code)
    full, = [case for case in report['cases'] if case['work'] == 'full']
    variants = {}
    for name, baseline in full['variants'].items():
        source = original / 'storage' / (baseline['binary'] + '.c')
        code = source.read_text()
        for ownership in ['retained', 'borrowed']:
            label = name + '-' + ownership
            generated = out / (label + '.c')
            generated.write_text(current[name] if ownership == 'borrowed' else code)
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
              'fwpCompiler': str(compiler), 'fwpCompilerSha256': helper.digest(compiler),
              'programSha256': helper.digest(program),
              'cpu': helper.run(['lscpu'], env).stdout, 'hardware': platform.platform(),
              'compiler': helper.run([os.environ['CC'], '--version'], env).stdout,
              'expected': full['expected'], 'variants': variants, 'executionOrder': [],
              'scope': 'Actual compiler output for the maintained map program: 500,000 scrambled '
                       'distinct entries and 2,000,000 numeric queries. Retained variants use saved '
                       'C output from the earlier compiler; borrowed variants use the current compiler, '
                       'which proves a non-suspending read span and preserves first-use initialization. '
                       'Both key/value layouts are compiled on the same host with the same C compiler. '
                       'Separate storage is an explicit old-layout measurement fixture. Whole-process '
                       'time includes startup, construction, queries, output and teardown; compiler '
                       'build time is excluded. This measures compiler revisions, not a hand-edited '
                       'borrow or universal language overhead. Twenty-four balanced '
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
