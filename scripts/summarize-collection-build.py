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


def inspect(binary, host, llvm):
    names = command(llvm / 'llvm-nm', binary)
    symbols = {line.split()[-1].removeprefix('_') for line in names.splitlines() if line.split()}
    runtime = {name for name in symbols if name.startswith('fwp_')}
    assert len(runtime) > 10, (binary, 'missing internal symbols')
    tracing = sorted(symbols.intersection({'fwp_heap_scan', 'fwp_heap_mark_all', 'fwp_heap_sweep'}))
    assert not tracing, (binary, tracing)
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


def audit_tests(log):
    """Require every named target to finish, with its complete expected tests."""
    log = re.sub(r'\x1b\[[0-9;]*[A-Za-z]', '', log)
    expected = {'cached_map_borrows': 3, 'caf_ownership': 3,
                'collection_construction': 3, 'decoder_partial': 1,
                'inline_caf_ownership': 7, 'map_set_ownership': 7,
                'mapped_array_construction': 3, 'numeric_array_fusion': 3,
                'protocol': 11, 'range_set': 3, 'repl': 9, 'static_constants': 1}
    # Cargo's target headers use stderr; harness summaries use stdout. GitHub
    # can place the next header before the preceding summary, so audit the two
    # ordered streams separately instead of splitting on headers.
    targets = re.findall(r'Running tests[/\\]([a-z_]+)\.rs', log)
    assert targets == list(expected), targets
    summaries = re.findall(r'test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', log)
    assert summaries == [('ok', str(count), '0', '0') for count in expected.values()], summaries
    assert 'panicked at' not in log
    return expected


def set_requests(path):
    """Validate observed requests; the previous-layout sizes are calculated."""
    rows = []
    for line in path.read_text().splitlines():
        match = re.fullmatch(r'keys=(\d+) requested=(\d+) charged=(\d+)', line)
        assert match, (path, line)
        keys, requested, charged = map(int, match.groups())
        expected = 8 + 8 * keys if keys else 0
        assert requested == expected and charged >= requested, (path, line)
        if not keys:
            assert charged == 0, (path, line)
        rows.append({'keys': keys, 'requestedBytes': requested,
                     'chargedBytes': charged,
                     'previousLayoutRequestBytes': 8 + 16 * keys if keys else 0})
    assert [row['keys'] for row in rows] == [0, 1, 7, 257, 4096], path
    return rows


def compact_sets(directory, host, llvm):
    runs = []
    for opt in ['-O0', '-O2']:
        label = f'compact-counted{opt}'
        rows = set_requests(directory / f'{label}.txt')
        binary = inspect(directory / f'{label}.exe', host, llvm)
        source = directory / f'{label}.c'
        assert source.stat().st_size and (directory / f'{label}.asm').stat().st_size
        runs.append({'optimization': opt, 'sizes': rows,
                     'generatedSha256': digest(source), 'binaryInspection': binary})
    control = (directory / 'compact-wasted-slot-control.txt').read_text().strip()
    assert control == 'set 1: requested 24, expected 16', control
    return {'runs': runs, 'wastedSlotControl': control,
            'scope': 'Observed requests to the managed allocator for a freshly built I64 set. '
                     'Charged bytes include allocator rounding, not process RAM or child storage. '
                     'Empty sets use static storage. The previous 8 + 16*n layout is calculated '
                     'from its representation, not timed here. Live charge must return to its '
                     'starting value after each result is freed. '
                     'These instrumented executions are not a speed benchmark.'}


def range_requests(path, direct):
    rows = []
    for line in path.read_text().splitlines():
        match = re.fullmatch(r'keys=(\d+) requests=(\d+) requested_bytes=(\d+)', line)
        assert match, (path, line)
        keys, requests, requested = map(int, match.groups())
        expected_requests = (1 if direct else keys + 3) if keys else 0
        expected_bytes = (8 + 8 * keys if direct else 16 + 48 * keys) if keys else 0
        assert (requests, requested) == (expected_requests, expected_bytes), (path, line)
        rows.append({'keys': keys, 'requests': requests, 'requestedBytes': requested})
    assert [row['keys'] for row in rows] == [0, 1, 7, 257, 4096], path
    return rows


def range_sets(directory, host, llvm):
    runs = []
    for opt in ['-O0', '-O2']:
        for direct in ['0', '1']:
            label = f'counted{opt}-direct-{direct}'
            runs.append({'optimization': opt, 'direct': direct == '1',
                         'sizes': range_requests(directory / f'{label}.txt', direct == '1'),
                         'generatedSha256': digest(directory / f'{label}.c'),
                         'binaryInspection': inspect(directory / f'{label}.exe', host, llvm)})
    return {'runs': runs,
            'scope': 'Observed managed allocation requests while an exported function builds '
                     'an I64 range set. Includes input list and scratch construction; excludes '
                     'startup, output, allocator headers and rounding. Both implementations '
                     'produce and check every key. ARC charge returns to baseline after release. '
                     'No timing claim follows from these instrumented executions.'}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True, type=int)
    parser.add_argument('--head', required=True)
    parser.add_argument('--artifacts', required=True, type=Path)
    parser.add_argument('--llvm-bin', required=True, type=Path)
    parser.add_argument('--output', required=True, type=Path)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.head)
    # Retain the request and raw run state even when acceptance fails before
    # downloads. A cancelled job is not success just because its tests passed.
    args.artifacts.mkdir(parents=True, exist_ok=True)
    (args.artifacts / 'request.json').write_text(json.dumps(
        {'run': args.run, 'head': args.head}, indent=2) + '\n')
    metadata = json.loads(command('gh', 'run', 'view', args.run, '--repo', REPO,
                                  '--json', 'headSha,status,conclusion,jobs'))
    (args.artifacts / 'run.json').write_text(json.dumps(metadata, indent=2) + '\n')
    assert metadata['headSha'] == args.head, 'evidence source differs from the requested source'
    assert metadata['status'] == 'completed', 'evidence run has not completed'
    assert metadata['conclusion'] == 'success', f"evidence run did not succeed: {metadata['conclusion']}"
    jobs = [job for job in metadata['jobs'] if job['name'].startswith('collection_build (')]
    assert {job['name'] for job in jobs} == {f'collection_build ({host})' for host in HOSTS}
    assert len(jobs) == 6
    rows = []
    for host in HOSTS:
        job = next(job for job in jobs if job['name'] == f'collection_build ({host})')
        assert job['status'] == 'completed' and job['conclusion'] == 'success', job
        assert not any(step['conclusion'] == 'failure' for step in job['steps'])
        log = command('gh', 'api', f'repos/{REPO}/actions/jobs/{job["databaseId"]}/logs', '--allow-escape-sequences')
        (args.artifacts / f'{host}.log').write_text(log)
        completed_tests = audit_tests(log)
        directory = args.artifacts / f'collection-build-{host}'
        command('gh', 'run', 'download', args.run, '--repo', REPO, '--name', directory.name, '--dir', directory)
        assert (directory / 'source.txt').read_text().strip() == args.head
        costs = directory / 'costs'
        report = json.loads((costs / 'report.json').read_text())
        assert report['source'] == args.head
        assert len(report['cases']) == 9
        assert {(case['kind'], case['inputs']) for case in report['cases']} == {
            (kind, count) for kind in ['map', 'set', 'range-set'] for count in [32, 4096, 65536]}
        for case in report['cases']:
            assert set(case['variants']) == {'0', '1'}
            assert len(case['executionOrder']) == 8
            assert all(sorted(order) == ['0', '1'] for order in case['executionOrder'])
            for fused, variant in case['variants'].items():
                counters = variant['counters']
                assert set(counters) == {'requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'}
                assert counters['retains'] == counters['finalChargedBytes'] == 0
                count = case['inputs']
                expected = (4 if fused == '1' else 2 * count + 5) if case['kind'] == 'set' else (5 if fused == '1' else 3 * count + 6)
                if case['kind'] == 'range-set':
                    expected = 2 if fused == '1' else count + 4
                assert counters['requests'] == expected, (host, case['kind'], count, fused, counters)
                assert len(variant['processWallNs']) == 8 and min(variant['processWallNs']) > 0
                assert variant['medianProcessWallNs'] == statistics.median(variant['processWallNs'])
                binary = costs / variant['binary']
                assert digest(binary) == variant['binarySha256']
                assert binary.stat().st_size == variant['binaryBytes']
                label = f'{case["kind"]}-{count}-fused-{fused}'
                assert digest(costs / f'{label}.c') == variant['generatedSha256']
                assert digest(costs / f'{case["kind"]}-{count}.fwp') == case['sourceSha256']
                variant['binaryInspection'] = inspect(binary, host, args.llvm_bin)
            ratio = case['variants']['1']['medianProcessWallNs'] / case['variants']['0']['medianProcessWallNs']
            assert case['fusedToOrdinaryTimeRatio'] == ratio
        checks = directory / 'checks'
        binaries, exits = [], []
        for opt in ['-O1', '-O2']:
            text = (checks / f'failures-counted{opt}.txt').read_text()
            assert text == '8 builders: 48 allocation failures and 64 callback exits cleaned; aliases preserved\n', text
            exits.append({'optimization': opt, 'allocationFailures': 48, 'callbackExits': 64})
            broken = (checks / f'missing-cleanup-counted{opt}.txt').read_text()
            assert 'collection live allocations: 2' in broken, broken
            for kind in ['failures', 'missing-cleanup']:
                binaries.append(inspect(checks / f'{kind}-counted{opt}.bin', host, args.llvm_bin))
        rows.append({'host': host, 'job': job['databaseId'], 'passedTests': sum(completed_tests.values()),
                     'completedTargets': completed_tests,
                     'failureConfigurations': exits, 'cleanupControls': 2,
                     'failureBinaries': binaries,
                     'compactSets': compact_sets(directory / 'sets', host, args.llvm_bin),
                     'rangeSets': range_sets(directory / 'sets/range-sets', host, args.llvm_bin),
                     'measurements': report})
        print(host, sum(completed_tests.values()), 'tests, 28 actual binaries, nine cost cases verified', flush=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps({
        'source': args.head, 'run': args.run,
        'auditSource': command('git', 'rev-parse', 'HEAD').strip(),
        'completeNativeMatrix': True,
        'scope': 'Actual binaries are inspected as data, never executed by this audit tool. '
                 'Each host has 44 focused tests, two failure configurations, two deliberately '
                 'broken builder cleanup controls, two compact-set configurations, an extra-slot '
                 'control, four range-set allocation configurations and nine paired cost cases. '
                 'Range-set tests also reject missing size guards, missing releases and ordinary '
                 'construction under a one-allocation budget. Timing compares fused and '
                 'ordinary fwp, not C/Rust. Native section sizes are recorded; assembly must be '
                 'reviewed before any claim about register placement or vectorization. '
                 'Passing focused evidence does not replace production acceptance.',
        'hosts': rows,
    }, indent=2) + '\n')


if __name__ == '__main__':
    main()
