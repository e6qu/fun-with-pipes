#!/usr/bin/env python3
"""Compare verified before/after numerical binaries and C/Rust on the same runner."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import resource
import statistics
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location('hashing', ROOT / 'scripts/measure-hashing.py')
hashing = importlib.util.module_from_spec(spec)
spec.loader.exec_module(hashing)
run = hashing.run


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'measure only on native runners'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--workload', choices=['hash', 'vectors'], required=True)
    parser.add_argument('--before', type=Path, required=True)
    parser.add_argument('--after', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    keys = (['elements', 'repetitions', 'canonicalBytesPerHash'] if args.workload == 'hash'
            else ['lanes', 'repetitions'])
    filename = 'hash.fwp' if args.workload == 'hash' else 'lanes.fwp'
    instrument = hashing.profile if args.workload == 'hash' else hashing.iteration.instrument
    directories = {'before': args.before.resolve(), 'after': args.after.resolve()}
    reports = {name: json.loads((directory / 'report.json').read_text()) for name, directory in directories.items()}
    for report in reports.values():
        assert report['hardware']['system'] == platform.system()
        assert report['hardware']['machine'] == platform.machine()
    assert reports['before']['results'].keys() == reports['after']['results'].keys()
    out = args.output.resolve(); out.mkdir(parents=True, exist_ok=True)
    environment = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_GC', None)
    results = {}
    for name, after in reports['after']['results'].items():
        before = reports['before']['results'][name]
        for key in ['source', 'expected'] + keys:
            assert before[key] == after[key], (name, key)
        for reference in ['c', 'rust']:
            assert before['variants'][reference]['sourceSha256'] == after['variants'][reference]['sourceSha256']
        variants, binaries = {}, {}
        labels = [(phase, f'fwp-{mode}') for phase in ['before', 'after'] for mode in ['tracing', 'arc']]
        labels += [('after', 'c'), ('after', 'rust')]
        for phase, variant in labels:
            label = f'{phase}-{variant}'
            directory = directories[phase] / name
            original = reports[phase]['results'][name]['variants'][variant]
            binary = directory / variant
            source = directory / ('reference.rs' if variant == 'rust' else variant + '.c')
            assert (directory / filename).read_text() == after['source']
            for path, key in [(binary, 'binarySha256'), (source, 'sourceSha256'), (directory / (variant + '.asm'), 'assemblySha256')]:
                assert hashlib.sha256(path.read_bytes()).hexdigest() == original[key], (path, key)
            binary.chmod(0o755)
            profiles = {}
            profile_command = None
            if variant.startswith('fwp'):
                cfile = out / f'{name}-{label}-profile.c'
                measured = out / f'{name}-{label}-profile'
                cfile.write_text(instrument(source.read_text()))
                profile_command = [os.environ['CC'], '-O2', '-std=gnu11', '-ffp-contract=off', '-w', str(cfile), '-o', str(measured), '-lm', '-lpthread']
                run(profile_command, environment)
                for collector in (['normal', 'off'] if variant == 'fwp-tracing' else ['off']):
                    result = run([measured], dict(environment, FWP_GC='off') if collector == 'off' else environment)
                    assert result.stdout == after['expected']
                    if args.workload == 'hash':
                        counters = [json.loads(line) for line in result.stderr.splitlines()]
                        assert len(counters) == 2
                        expected = original['profile']
                        memory = counters[1]
                    else:
                        counters = json.loads(result.stderr)
                        expected = original['profiles']['off']
                        memory = counters
                    if collector == 'off':
                        assert counters == expected, (name, label, counters)
                    assert memory['finalChargedBytes'] == 0
                    profiles[collector] = counters
            warm = run([binary], environment)
            assert warm.stdout == after['expected'] and not warm.stderr
            binaries[label] = binary
            variants[label] = dict(sourceHead=reports[phase]['head'], sourceSha256=original['sourceSha256'], binarySha256=original['binarySha256'],
                assemblySha256=original['assemblySha256'], binaryBytes=original['binaryBytes'], profileCommand=profile_command, profiles=profiles, samples=[])
        labels = list(binaries)
        # Every variant occupies each position once in each direction. This
        # balances both execution position and each pair's relative order.
        for sample in range(2 * len(labels)):
            offset = sample % len(labels)
            order = labels[offset:] + labels[:offset]
            if sample >= len(labels):
                order.reverse()
            for label in order:
                cpu_before = resource.getrusage(resource.RUSAGE_CHILDREN)
                start = time.perf_counter_ns()
                actual = run([binaries[label]], environment)
                wall = time.perf_counter_ns() - start
                cpu_after = resource.getrusage(resource.RUSAGE_CHILDREN)
                cpu = (cpu_after.ru_utime + cpu_after.ru_stime - cpu_before.ru_utime - cpu_before.ru_stime) * 1e9
                assert actual.stdout == after['expected'] and not actual.stderr
                variants[label]['samples'].append(dict(order=order, wallNs=wall, childCpuNs=round(cpu)))
        for variant in variants.values():
            variant['medianWallNs'] = statistics.median(sample['wallNs'] for sample in variant['samples'])
            variant['medianChildCpuNs'] = statistics.median(sample['childCpuNs'] for sample in variant['samples'])
        ratios = {mode: {reference: {metric: variants[f'after-fwp-{mode}'][key] / variants[reference][key]
                                    for metric, key in [('wall', 'medianWallNs'), ('cpu', 'medianChildCpuNs')]}
                         for reference in [f'before-fwp-{mode}', 'after-c', 'after-rust']}
                  for mode in ['tracing', 'arc']}
        results[name] = dict(source=after['source'], expected=after['expected'], variants=variants, ratios=ratios, **{key: after[key] for key in keys})
    report = dict(workload=args.workload, head=os.environ['GITHUB_SHA'], beforeHead=reports['before']['head'], afterHead=reports['after']['head'],
        baselineRun=os.environ['BASELINE_RUN'], evidenceRun=os.environ['EVIDENCE_RUN'], hardware=platform.uname()._asdict(),
        cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
        profileCompiler=run([os.environ['CC'], '--version']).stdout, results=results,
        scope='Verified binaries from two named runs execute together: before/after fwp tracing/ARC and the after run\'s matching C/Rust references. Same source, inputs, arithmetic/encoding rules and output; one warmup then twelve balanced rotating whole-process wall/child-CPU samples. Compilation and normal/off collector profiles are separate; off profiles must reproduce original allocation/count measurements exactly. Original reports retain compilation, RSS and reference allocation scope. This compares the two recorded compiler revisions as a whole; it does not isolate individual transformations or establish universal speed or parity.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: case['ratios'] for name, case in results.items()}, indent=2))


if __name__ == '__main__':
    main()
