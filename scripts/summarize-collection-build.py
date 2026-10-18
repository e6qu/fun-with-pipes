#!/usr/bin/env python3
"""Audit native collection evidence and inspect binaries without executing them."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import statistics
import subprocess

REPO = 'e6qu/fun-with-pipes'
HOSTS = {
    'ubuntu-latest': 'elf64-x86-64',
    'ubuntu-24.04-arm': 'elf64-littleaarch64',
    'macos-15': 'mach-o arm64',
    'macos-15-intel': 'mach-o 64-bit x86-64',
    'windows-2025': 'coff-x86-64',
    'windows-11-arm': 'coff-arm64',
}


def command(*arguments):
    return subprocess.check_output(list(map(str, arguments)), text=True)


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def inspect(binary, host, mode, llvm):
    names = command(llvm / 'llvm-nm', binary)
    symbols = {line.split()[-1].removeprefix('_') for line in names.splitlines() if line.split()}
    runtime = {name for name in symbols if name.startswith('fwp_')}
    assert len(runtime) > 10, (binary, 'missing internal symbols')
    tracing = sorted(symbols.intersection({'fwp_gc_scan', 'fwp_gc_mark_all', 'fwp_gc_sweep'}))
    assert bool(tracing) == (mode == 'tracing'), (binary, tracing)
    assembly = command(llvm / 'llvm-objdump', '-d', '--no-show-raw-insn', binary)
    assert 'file format ' + HOSTS[host] in assembly, binary
    binary.with_suffix(binary.suffix + '.disassembly.txt').write_text(assembly)
    binary.with_suffix(binary.suffix + '.symbols.txt').write_text(names)
    sections = {}
    for line in command(llvm / 'llvm-size', '--format=sysv', binary).splitlines():
        fields = line.split()
        if len(fields) == 3 and fields[1].isdigit():
            sections[fields[0]] = sections.get(fields[0], 0) + int(fields[1])
    assert sections, binary
    return {'file': binary.name, 'sha256': digest(binary), 'bytes': binary.stat().st_size,
            'format': HOSTS[host], 'sections': sections, 'tracingSymbols': tracing,
            'internalRuntimeSymbols': len(runtime)}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True, type=int)
    parser.add_argument('--head', required=True)
    parser.add_argument('--artifacts', required=True, type=Path)
    parser.add_argument('--llvm-bin', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.head)
    metadata = json.loads(command('gh', 'run', 'view', args.run, '--repo', REPO,
                                  '--json', 'headSha,status,conclusion,jobs'))
    assert metadata['headSha'] == args.head and metadata['status'] == 'completed'
    assert metadata['conclusion'] == 'success'
    jobs = [job for job in metadata['jobs'] if job['name'].startswith('collection_build (')]
    assert {job['name'] for job in jobs} == {f'collection_build ({host})' for host in HOSTS}
    assert len(jobs) == 6
    args.artifacts.mkdir(parents=True, exist_ok=True)
    rows = []
    for host in HOSTS:
        job = next(job for job in jobs if job['name'] == f'collection_build ({host})')
        assert job['status'] == 'completed' and job['conclusion'] == 'success', job
        assert not any(step['conclusion'] == 'failure' for step in job['steps'])
        log = command('gh', 'api', f'repos/{REPO}/actions/jobs/{job["databaseId"]}/logs', '--allow-escape-sequences')
        (args.artifacts / f'{host}.log').write_text(log)
        summaries = re.findall(r'test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', log)
        assert len(summaries) == 4 and sum(int(row[1]) for row in summaries) == 13, (host, summaries)
        assert all(row[0] == 'ok' and row[2:] == ('0', '0') for row in summaries)
        assert 'panicked at' not in log
        directory = args.artifacts / f'collection-build-{host}'
        command('gh', 'run', 'download', args.run, '--repo', REPO, '--name', directory.name, '--dir', directory)
        assert (directory / 'source.txt').read_text().strip() == args.head
        costs = directory / 'costs'
        report = json.loads((costs / 'report.json').read_text())
        assert report['source'] == args.head
        assert len(report['cases']) == 6
        assert {(case['kind'], case['inputs']) for case in report['cases']} == {
            (kind, count) for kind in ['map', 'set'] for count in [32, 4096, 65536]}
        for case in report['cases']:
            assert set(case['variants']) == {'0', '1'}
            assert len(case['executionOrder']) == 8
            assert all(sorted(order) == ['0', '1'] for order in case['executionOrder'])
            for fused, variant in case['variants'].items():
                counters = variant['counters']
                assert counters['retains'] == counters['finalChargedBytes'] == counters['collections'] == 0
                count = case['inputs']
                expected = (6 if fused == '1' else 2 * count + 7) if case['kind'] == 'set' else (7 if fused == '1' else 3 * count + 8)
                assert counters['requests'] == expected, (host, case['kind'], count, fused, counters)
                assert len(variant['processWallNs']) == 8 and min(variant['processWallNs']) > 0
                assert variant['medianProcessWallNs'] == statistics.median(variant['processWallNs'])
                binary = costs / variant['binary']
                assert digest(binary) == variant['binarySha256']
                assert binary.stat().st_size == variant['binaryBytes']
                label = f'{case["kind"]}-{count}-fused-{fused}'
                assert digest(costs / f'{label}.c') == variant['generatedSha256']
                assert digest(costs / f'{case["kind"]}-{count}.fwp') == case['sourceSha256']
                variant['binaryInspection'] = inspect(binary, host, 'arc', args.llvm_bin)
            ratio = case['variants']['1']['medianProcessWallNs'] / case['variants']['0']['medianProcessWallNs']
            assert case['fusedToOrdinaryTimeRatio'] == ratio
        checks = directory / 'checks'
        binaries, exits = [], []
        for mode in ['arc', 'tracing']:
            for opt in ['-O1', '-O2']:
                for reuse in (['0'] if mode == 'arc' else ['0', '1']):
                    text = (checks / f'failures-{mode}{opt}-reuse-{reuse}.txt').read_text()
                    assert text == '6 builders: 54 allocation failures and 48 callback exits cleaned; aliases preserved\n', text
                    exits.append({'mode': mode, 'optimization': opt, 'reuseVerification': reuse == '1',
                                  'allocationFailures': 54, 'callbackExits': 48})
                broken = (checks / f'missing-cleanup-{mode}{opt}.txt').read_text()
                assert 'collection live allocations: 4' in broken, broken
                for kind in ['failures', 'missing-cleanup']:
                    binaries.append(inspect(checks / f'{kind}-{mode}{opt}.bin', host, mode, args.llvm_bin))
        rows.append({'host': host, 'job': job['databaseId'], 'passedTests': 13,
                     'failureConfigurations': exits, 'cleanupControls': 4,
                     'failureBinaries': binaries, 'measurements': report})
        print(host, '13 tests, 20 actual binaries, six cost cases verified', flush=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps({
        'source': args.head, 'run': args.run, 'completeNativeMatrix': True,
        'scope': 'Actual binaries are inspected as data, never executed by this collector. '
                 'Each host has 13 focused tests, six failure configurations, four deliberately '
                 'broken cleanup controls and six paired cost cases. Timing compares fused and '
                 'ordinary fwp, not C/Rust. Native section sizes are recorded; assembly must be '
                 'reviewed before any claim about register placement or vectorization. '
                 'Passing focused evidence does not replace production acceptance.',
        'hosts': rows,
    }, indent=2) + '\n')


if __name__ == '__main__':
    main()
