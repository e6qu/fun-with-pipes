#!/usr/bin/env python3
"""Audit native hash tests, paired measurements and their actual binaries."""
import argparse
import importlib.util
import json
from pathlib import Path
import re
import statistics

SPEC = importlib.util.spec_from_file_location(
    'collection_report', Path(__file__).with_name('summarize-collection-build.py'))
COLLECTIONS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COLLECTIONS)
command = COLLECTIONS.command
digest = COLLECTIONS.digest
HOSTS = COLLECTIONS.HOSTS
REPO = COLLECTIONS.REPO


def audit_tests(log):
    log = re.sub(r'\x1b\[[0-9;]*[A-Za-z]', '', log)
    targets = re.findall(r'Running tests[/\\]([a-z_]+)\.rs', log)
    assert targets == ['arc_execution', 'exec_protocol_ownership', 'hash_ownership',
                       'integer_output', 'protocol', 'range_array', 'scalar_traps'], targets
    summaries = re.findall(r'test result: (ok|FAILED)\. (\d+) passed; (\d+) failed; (\d+) ignored;', log)
    counts = [38, 7, 2, 4, 2, 6, 3, 9, 3, 2]
    assert summaries == [('ok', str(count), '0', '0') for count in counts], summaries
    assert 'panicked at' not in log
    for name in ['numeric_hash_loops_preserve_widths_slices_and_shared_values',
                 'numeric_hash_loops_allocate_nothing_and_do_not_adjust_reference_counts']:
        assert len(re.findall(r'test ' + name + r' \.\.\. ok', log)) == 1, name
    return sum(counts)


def completed_run(run, head, directory, prefix, hosts):
    metadata = json.loads(command('gh', 'run', 'view', run, '--repo', REPO,
                                  '--json', 'headSha,status,conclusion,jobs'))
    (directory / f'run-{run}.json').write_text(json.dumps(metadata, indent=2) + '\n')
    assert metadata['headSha'] == head, metadata['headSha']
    assert metadata['status'] == 'completed' and metadata['conclusion'] == 'success'
    jobs = [job for job in metadata['jobs'] if job['name'].startswith(prefix + ' (')]
    assert len(jobs) == len(hosts)
    assert {job['name'] for job in jobs} == {f'{prefix} ({host})' for host in hosts}
    for job in jobs:
        assert job['status'] == 'completed' and job['conclusion'] == 'success', job
        assert not any(step['conclusion'] == 'failure' for step in job['steps'])
    return jobs


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--tests-run', type=int, required=True)
    parser.add_argument('--costs-run', type=int, required=True)
    parser.add_argument('--head', required=True)
    parser.add_argument('--artifacts', type=Path, required=True)
    parser.add_argument('--llvm-bin', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert re.fullmatch('[0-9a-f]{40}', args.head)
    args.artifacts.mkdir(parents=True, exist_ok=True)
    tests = completed_run(args.tests_run, args.head, args.artifacts, 'paths', HOSTS)
    cost_hosts = [host for host in HOSTS if not host.startswith('windows-')]
    costs = completed_run(args.costs_run, args.head, args.artifacts, 'ad_metadata', cost_hosts)
    rows = []
    for host in HOSTS:
        job = next(job for job in tests if job['name'] == f'paths ({host})')
        log = command('gh', 'api', f'repos/{REPO}/actions/jobs/{job["databaseId"]}/logs', '--allow-escape-sequences')
        (args.artifacts / f'{host}.log').write_text(log)
        count = audit_tests(log)
        directory = args.artifacts / f'hash-{host}'
        command('gh', 'run', 'download', args.tests_run, '--repo', REPO,
                '--name', directory.name, '--dir', directory)
        binaries = []
        for typed in ['0', '1']:
            for packed in ['0', '1']:
                for mode in ['arc', 'tracing']:
                    for opt in ['-O0', '-O2']:
                        label = f'typed-{typed}-packed-{packed}-{mode}{opt}'
                        source = directory / 'numeric' / f'{label}.c'
                        assert ('/* numeric hash without type dispatch */' in source.read_text()) == (typed == '1')
                        binaries.append(dict(typed=typed, packed=packed, mode=mode, optimization=opt,
                            sourceSha256=digest(source),
                            inspection=COLLECTIONS.inspect(source.with_suffix('.exe'), host, mode, args.llvm_bin,
                                                           require_tracing=mode == 'tracing')))
        row = dict(host=host, job=job['databaseId'], passedTests=count, binaries=binaries)
        if host in cost_hosts:
            cost_job = next(job for job in costs if job['name'] == f'ad_metadata ({host})')
            directory = args.artifacts / f'hash-costs-{host}'
            command('gh', 'run', 'download', args.costs_run, '--repo', REPO,
                    '--name', directory.name, '--dir', directory)
            report = json.loads((directory / 'report.json').read_text())
            assert report['head'] == args.head
            assert report['generationSettings'] == dict(FWP_ARRAY_FUSION='1',
                FWP_MAP_BUILD='1', FWP_DIRECT_INTEGER_PRINT='1')
            assert set(report['results']) == {'small', 'large', 'set'}
            for name, case in report['results'].items():
                assert (case['collection'], case['elements'], case['repetitions']) == {
                    'small': ('array', 16, 4096), 'large': ('array', 4096, 1024),
                    'set': ('set', 65536, 64)}[name]
                n = case['elements']
                assert case['canonicalBytesPerHash'] == 8 + max(1, (n.bit_length() + 6) // 7) + 8*n
                assert (directory / name / 'hash.fwp').read_text() == case['source']
                assert set(case['variants']) == {'fwp-tracing', 'fwp-arc', 'fwp-arc-generic', 'fwp-arc-buffered', 'c', 'rust'}
                assert case['variants']['fwp-arc']['profile'] == case['variants']['fwp-arc-generic']['profile'], (host, name, 'specialization changed allocation or owner counts')
                for label, variant in case['variants'].items():
                    folder = directory / name
                    source = folder / ('reference.rs' if label == 'rust' else label + '.c')
                    assert digest(source) == variant['sourceSha256']
                    assert digest(folder / label) == variant['binarySha256']
                    assert digest(folder / (label + '.asm')) == variant['assemblySha256']
                    assert (folder / label).stat().st_size == variant['binaryBytes']
                    samples = variant['samples']
                    assert len(samples) == 12
                    for index, sample in enumerate(samples):
                        assert sorted(sample['order']) == sorted(case['variants'])
                        assert sample['order'] == case['variants']['c']['samples'][index]['order']
                    for metric, median in [('wallNs', 'medianWallNs'), ('childCpuNs', 'medianChildCpuNs')]:
                        assert min(sample[metric] for sample in samples) > 0
                        assert statistics.median(sample[metric] for sample in samples) == variant[median]
                    assert sorted(sample['order'].index(label) for sample in samples) == sorted(list(range(6))*2)
                    if label.startswith('fwp'):
                        mode = 'tracing' if label == 'fwp-tracing' else 'arc'
                        variant['inspection'] = COLLECTIONS.inspect(folder / label, host, mode, args.llvm_bin,
                                                                    require_tracing=mode == 'tracing')
                        buffers, managed = variant['profile']
                        assert managed['finalChargedBytes'] == managed['collections'] == 0
                        assert bool(buffers['hashBufferRequests']) == label.endswith('buffered')
                        for reference, ratios in case['ratios'][label].items():
                            for metric, median in [('wall', 'medianWallNs'), ('cpu', 'medianChildCpuNs')]:
                                assert ratios[metric] == variant[median] / case['variants'][reference][median]
                    else:
                        assert len(variant['profile']) == 1
                        assert variant['profile'][0]['finalArrayBytes'] == 0
            row.update(costJob=cost_job['databaseId'], measurements=report)
        rows.append(row)
        print(host, count, 'tests and 16 correctness binaries inspected', flush=True)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(dict(source=args.head, testsRun=args.tests_run,
        costsRun=args.costs_run, collectorSource=command('git', 'rev-parse', 'HEAD').strip(),
        scope='Six native hosts run all hash and neighboring ownership/protocol tests. '
              'Four hosts measure specialized tracing/ARC, generic ARC, buffered ARC and C/Rust '
              'on three equivalent-encoding workloads. Actual binaries are inspected as data, '
              'never executed by this collector. ARC binaries must exclude tracing symbols. '
              'Section sizes are recorded; assembly still needs human review for register and '
              'inner-loop claims. Focused evidence does not replace production acceptance.',
        hosts=rows), indent=2) + '\n')


if __name__ == '__main__':
    main()
