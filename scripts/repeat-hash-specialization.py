#!/usr/bin/env python3
"""Repeat verified specialized/generic hash binaries with C and Rust peers."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import resource
import statistics
import time

REPO = 'e6qu/fun-with-pipes'
LABELS = ['fwp-arc', 'fwp-arc-generic', 'c', 'rust']
SPEC = importlib.util.spec_from_file_location(
    'iteration', Path(__file__).with_name('measure-iteration.py'))
ITERATION = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(ITERATION)
run = ITERATION.run


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'measure on native runners'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--host', choices=['ubuntu-latest', 'ubuntu-24.04-arm', 'macos-15', 'macos-15-intel'], required=True)
    parser.add_argument('--samples', type=int, required=True)
    parser.add_argument('--warmups', type=int, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert args.samples > 0 and args.samples % (2*len(LABELS)) == 0
    assert args.warmups > 0
    environment = dict(os.environ)
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    metadata = json.loads(run(['gh', 'run', 'view', args.run, '--repo', REPO,
                              '--json', 'headSha,status,conclusion,jobs'], environment).stdout)
    (out / 'source-run.json').write_text(json.dumps(metadata, indent=2) + '\n')
    assert metadata['headSha'] == args.source
    assert metadata['status'] == 'completed' and metadata['conclusion'] == 'success'
    job, = [job for job in metadata['jobs'] if job['name'] == f'ad_metadata ({args.host})']
    assert job['conclusion'] == 'success'
    folder = out / 'original'
    run(['gh', 'run', 'download', args.run, '--repo', REPO,
         '--name', f'hash-costs-{args.host}', '--dir', folder], environment)
    original = json.loads((folder / 'report.json').read_text())
    assert original['head'] == args.source
    assert original['hardware']['system'] == platform.system()
    assert original['hardware']['machine'] == platform.machine()
    results = {}
    for name, case in original['results'].items():
        assert (folder / name / 'hash.fwp').read_text() == case['source']
        assert case['variants']['fwp-arc']['profile'] == case['variants']['fwp-arc-generic']['profile']
        variants, binaries = {}, {}
        for label in LABELS:
            stored = case['variants'][label]
            binary = folder / name / label
            source = folder / name / ('reference.rs' if label == 'rust' else label + '.c')
            for file, key in [(binary, 'binarySha256'), (source, 'sourceSha256'),
                              (folder / name / (label + '.asm'), 'assemblySha256')]:
                assert hashlib.sha256(file.read_bytes()).hexdigest() == stored[key], file
            binary.chmod(0o755)
            for _ in range(args.warmups):
                actual = run([binary], environment)
                assert actual.stdout == case['expected'] and not actual.stderr
            binaries[label] = binary
            variants[label] = dict(binarySha256=stored['binarySha256'], sourceSha256=stored['sourceSha256'], samples=[])
        for sample in range(args.samples):
            offset = sample % len(LABELS)
            order = LABELS[offset:] + LABELS[:offset]
            if sample // len(LABELS) % 2:
                order.reverse()
            for label in order:
                cpu_start = resource.getrusage(resource.RUSAGE_CHILDREN)
                start = time.perf_counter_ns()
                actual = run([binaries[label]], environment)
                wall = time.perf_counter_ns() - start
                cpu_end = resource.getrusage(resource.RUSAGE_CHILDREN)
                assert actual.stdout == case['expected'] and not actual.stderr
                cpu = round((cpu_end.ru_utime + cpu_end.ru_stime - cpu_start.ru_utime - cpu_start.ru_stime)*1e9)
                variants[label]['samples'].append(dict(order=order, wallNs=wall, childCpuNs=cpu))
        for variant in variants.values():
            variant['medianWallNs'] = statistics.median(sample['wallNs'] for sample in variant['samples'])
            variant['medianChildCpuNs'] = statistics.median(sample['childCpuNs'] for sample in variant['samples'])
        ratios = {reference: {metric: variants['fwp-arc'][key] / variants[reference][key]
                              for metric, key in [('wall', 'medianWallNs'), ('cpu', 'medianChildCpuNs')]}
                  for reference in LABELS[1:]}
        paired = {reference: [left['childCpuNs'] / right['childCpuNs']
                              for left, right in zip(variants['fwp-arc']['samples'], variants[reference]['samples'])]
                  for reference in LABELS[1:]}
        results[name] = dict(source=case['source'], expected=case['expected'],
                             variants=variants, ratios=ratios, pairedCpuRatios=paired)
        print(name, json.dumps(ratios), flush=True)
    report = dict(source=args.source, sourceRun=args.run, host=args.host,
        collectorSource=run(['git', 'rev-parse', 'HEAD'], environment).stdout.strip(),
        hardware=platform.uname()._asdict(),
        cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu'], environment).stdout,
        samples=args.samples, warmups=args.warmups, results=results,
        scope='Exact saved specialized ARC, generic ARC and matching C/Rust executables, '
              'verified against source and binary hashes before execution. No recompilation. '
              'Balanced rotating/reversed whole-process wall and child-CPU samples include '
              'startup, construction, hashing and output. Original reports retain compiler '
              'flags, allocation profiles, RSS and code sizes. Buffered/tracing variants are '
              'excluded from this repeat to concentrate on the specialization and peer gaps. '
              'All samples remain visible; overlapping distributions do not prove improvement.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')


if __name__ == '__main__':
    main()
