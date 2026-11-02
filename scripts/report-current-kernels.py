#!/usr/bin/env python3
"""Verify retained kernel reports and render their time and memory comparisons."""
import argparse
import gzip
import importlib.util
import json
from pathlib import Path
import re
import subprocess

SPEC = importlib.util.spec_from_file_location('retention', Path(__file__).with_name('retain-current-kernels.py'))
RETAIN = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RETAIN)
CHECK = RETAIN.CHECK


def verified_reports(directory, comparison):
    index = json.loads((directory / 'index.json').read_text())
    selection = json.loads((directory / 'selection.json').read_text())
    assert index['schema'] == selection['schema'] == 1
    assert 'comparison' not in index or index['comparison'] == comparison
    assert index['complete'] and not index['auditErrors']
    assert sorted(index['measurements']) == sorted(selection['measuredJobs'])
    assert len(index['measurements']) == len(set(index['measurements'])) == 4
    assert {row['run'] for row in index['jobs']} == set(selection['runs'])
    reports, seen = [], set()
    for row in index['jobs']:
        source, job = row['source'], row['job']
        assert re.fullmatch('[0-9a-f]{40}', source)
        assert job['head_sha'] == source and job['run_id'] == row['run']
        assert job['id'] not in seen
        seen.add(job['id'])
        log = gzip.decompress((directory / row['log']).read_bytes())
        assert len(log) == row['logBytes'] and CHECK.digest(log) == row['logSha256']
        measured = job['id'] in index['measurements']
        decision = RETAIN.outcome(job, row['qualification'], measured, comparison)
        if not measured:
            assert row['decision'] == decision
            continue
        assert decision == 'measured'
        raw = gzip.decompress((directory / row['report']).read_bytes())
        assert len(raw) == row['reportBytes'] and CHECK.digest(raw) == row['reportSha256']
        report = json.loads(raw)
        transformation = {'loop-state': 'native floating-point loop-state fields',
                          'matrix-columns': 'paired matrix columns'}[comparison]
        assert report['referenceManifest']['disabledTransformation'] == transformation
        failures = CHECK.check_report(report, source, row['machine'], row['session'])
        assert failures == row['failures']
        assert job['conclusion'] == ('failure' if failures else 'success')
        expected = 'performance-limits-remain-open' if failures else 'all-current-rules-pass'
        assert row['decision'] == expected
        assert report['qualification'] == row['qualification']
        assert report['sourceTrees'] == row['sourceTrees']
        for name, tree in report['sourceTrees'].items():
            assert subprocess.check_output(['git', 'rev-parse', source + ':' + name],
                cwd=CHECK.ROOT, text=True).strip() == tree
        files_raw = (directory / row['files']).read_bytes()
        assert CHECK.digest(files_raw) == row['filesSha256']
        files = json.loads(gzip.decompress(files_raw))
        assert files['comparison.json'] == dict(bytes=len(raw), sha256=CHECK.digest(raw))
        for label, sha in report['compilerSha256'].items():
            assert files[label + '-compiler']['sha256'] == sha
        if comparison == 'matrix-columns':
            prerequisite = (directory / row['prerequisite']).read_bytes()
            assert CHECK.digest(prerequisite) == row['prerequisiteSha256']
            RETAIN.check_prerequisite(json.loads(prerequisite), report)
        reports.append((row, report))
    assert {(row['machine'], row['session']) for row, _ in reports} == {
        (machine, session) for machine in CHECK.HOSTS for session in (1, 2)}
    assert all(report['sourceTrees'] == reports[0][1]['sourceTrees'] for _, report in reports)
    for field in RETAIN.REFERENCE_FIELDS[comparison]:
        assert len({report['referenceManifest'][field] for _, report in reports}) == 1
    assert index['decision'] == ('performance-limits-remain-open' if any(
        report['failures'] for _, report in reports) else 'all-current-rules-pass')
    return index, sorted(reports, key=lambda pair: (pair[0]['machine'], pair[0]['session']))


def time_per_calculation(row, case, metric, label):
    processes = 256 if case == 'matrix-65-67-63' else 4
    return row['medians'][label][metric] / (processes * 5 * 8)


def span(values, divisor):
    low, high = min(values) / divisor, max(values) / divisor
    return f'{low:,.3f}' if low == high else f'{low:,.3f}–{high:,.3f}'


def render(index, reports, comparison):
    introduction = {'loop-state': ['# Current numerical costs', '',
        'Generated from all four retained sessions; [protocol and timing boundaries](../current-kernel-costs.md).',
        'No production compiler change is introduced by this measurement batch.'],
        'matrix-columns': ['# Paired matrix columns: time and memory', '',
        'Generated from all four retained sessions; [protocol and timing boundaries](../matrix-calculation-costs.md).',
        'fwp computes two adjacent output columns together; reference uses the original scalar loop.',
        'Both use the same compiler output with only that loop changed. C and Rust do equivalent work.',
        'Inputs are built by the C driver; inclusive costs do not measure source-compiled array construction.']}[comparison]
    lines = introduction + ['',
        '## Time', '',
        'Times are milliseconds per calculation: the median complete round total divided by',
        'its number of calculations. Ratios use the same totals. A ratio of 1.30 means 30%',
        'more time than that peer. **Noise** means either identical-copy control exceeded',
        '2% for that case and scope; retain the observation but do not accept a speed claim.', '']
    for metric, title in (('kernelNs', 'Calculation only'), ('allocationInclusiveNs', 'Allocation through cleanup')):
        lines += ['### ' + title, '',
            '| Host/session | Case | fwp ms | C ms | Rust ms | fwp/C | fwp/Rust | fwp/reference | Copy controls fwp/reference | Status |',
            '|---|---|---:|---:|---:|---:|---:|---:|---|---|']
        for metadata, report in reports:
            host = ('ARM64' if metadata['machine'] == 'aarch64' else 'AMD64') + '/' + str(metadata['session'])
            for case, row in report['results'].items():
                times = [f'{time_per_calculation(row, case, metric, label) / 1e6:.4f}' for label in ('fwp', 'c', 'rust')]
                ratios = [f'{row["ratios"][label][metric]:.4f}' for label in ('c', 'rust', 'reference')]
                controls = [row['identicalRatios'][label][metric] for label in ('fwp', 'reference')]
                status = 'Noise' if max(controls) > 1.02 else 'Copy controls pass'
                lines.append('| ' + ' | '.join([host, case, *times, *ratios,
                    '/'.join(f'{value:.4f}' for value in controls), status]) + ' |')
        lines.append('')
    lines += ['## Memory', '',
        'Ranges include both architectures, both sessions and all five profile samples.',
        'Requests and requested bytes are divided by eight calculations per sample.',
        'Peak storage is **not** divided: it is the highest simultaneous storage observed.',
        'C/Rust count payload; fwp/reference count managed allocator charge including metadata.',
        'These columns are different accounting boundaries, not total process memory.', '',
        '| Case | Program | Requests/calculation | Requested KiB/calculation | Peak payload or charge KiB | Effective retains/calculation | Final live bytes |',
        '|---|---|---:|---:|---:|---:|---:|']
    for case in reports[0][1]['results']:
        for label in ('c', 'rust', 'fwp', 'reference'):
            samples = [sample for _, report in reports for sample in report['results'][case]['profiles'][label]]
            managed = label in ('fwp', 'reference')
            peak = 'peakChargedBytes' if managed else 'peakPayloadBytes'
            live = 'liveChargedBytes' if managed else 'livePayloadBytes'
            lines.append('| ' + ' | '.join([case, label,
                span([s['requests'] for s in samples], 8), span([s['requestedBytes'] for s in samples], 8 * 1024),
                span([s[peak] for s in samples], 1024),
                span([s['retains'] for s in samples], 8) if managed else 'Not instrumented',
                span([s[live] for s in samples], 1)]) + ' |')
    lines += ['', '## Process memory and code', '',
        'RSS is the separate whole-process maximum, including runtime and system pages.',
        'Code is the executable text section, not file size. Ranges include both sessions.',
        'GCC frame estimates and every raw profile remain in the reports; they do not measure',
        'stack high-water usage. Rust frame sizes are not measured.', '',
        '| Host | Case | Program | Peak RSS MiB | Code bytes |', '|---|---|---|---:|---:|']
    for machine in CHECK.HOSTS:
        host_reports = [report for metadata, report in reports if metadata['machine'] == machine]
        for case in reports[0][1]['results']:
            for label in ('c', 'rust', 'fwp', 'reference'):
                rows = [report['results'][case] for report in host_reports]
                lines.append('| ' + ' | '.join([machine, case, label,
                    span([r['peakProcessRssBytes'][label] for r in rows], 1024 * 1024),
                    span([r['binaries'][label + '-timing']['instructionBytes'] for r in rows], 1)]) + ' |')
    if comparison == 'matrix-columns':
        lines += ['', '## Generated C stack frames', '',
            'GCC estimates for the generated `product-data` worker (`f0`) and benchmark',
            'driver (`main`). `static` is a fixed frame; `dynamic,bounded` includes stack',
            'adjustments whose maximum GCC can determine. Neither is a whole-program stack peak.',
            'See [GCC stack-usage qualifiers](https://gcc.gnu.org/onlinedocs/gcc-13.3.0/gcc/Developer-Options.html).', '',
            '| Host | Function | Paired bytes | Scalar bytes | GCC qualifier (both) |', '|---|---|---:|---:|---|']
        for machine in CHECK.HOSTS:
            rows = [row for metadata, report in reports if metadata['machine'] == machine
                    for row in report['results'].values()]
            for function in ('f0', 'main'):
                sizes, qualifiers = {}, set()
                for label in ('fwp', 'reference'):
                    sizes[label] = []
                    for row in rows:
                        prefix = Path(row['binaries'][label + '-timing']['path']).stem + '-'
                        frame, = [entry for name, info in row['stack'].items() if name.startswith(prefix)
                                  for entry in info['entries'] if entry['location'].endswith(':' + function)]
                        assert frame['qualifier'] in ('static', 'dynamic,bounded')
                        qualifiers.add(frame['qualifier'])
                        sizes[label].append(frame['bytes'])
                qualifier, = qualifiers
                lines.append('| ' + ' | '.join([machine, function,
                    span(sizes['fwp'], 1), span(sizes['reference'], 1), qualifier]) + ' |')
    lines += ['', '## Every missed limit', '']
    for metadata, report in reports:
        job = metadata['job']['id']
        url = f'https://github.com/e6qu/fun-with-pipes/actions/runs/{metadata["run"]}/job/{job}'
        lines += [f'[{metadata["machine"]}, session {metadata["session"]}]({url}), source `{report["source"]}`:', '']
        if not report['failures']:
            lines += ['- All declared rules pass.']
        for failure in report['failures']:
            detail = (f'{failure["ratio"]:.6f} exceeds {failure["limit"]:.2f}' if failure['kind'] != 'memory'
                      else f'{failure["current"]} exceeds reference {failure["reference"]}')
            label = ' / ' + failure['label'] if 'label' in failure else ''
            lines.append(f'- {failure["kind"]}: {failure["case"]}{label}, {failure["metric"]}: {detail}.')
        lines.append('')
    rejected = [row for row in index['jobs'] if row['job']['id'] not in index['measurements']]
    lines += [f'{len(rejected)} preceding host/check failures are retained in [the index](index.json),',
              'with their complete logs. None supplied a timing result.', '']
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--comparison', choices=('loop-state', 'matrix-columns'), required=True)
    parser.add_argument('--mode', choices=('write', 'check'), required=True)
    args = parser.parse_args()
    index, reports = verified_reports(args.directory, args.comparison)
    expected = render(index, reports, args.comparison)
    output = args.directory / 'README.md'
    if args.mode == 'write':
        output.write_text(expected)
    else:
        assert output.read_text() == expected, 'retained current-kernel tables are stale'
    print('Four retained reports, source trees, raw-file identities and all published tables agree')


if __name__ == '__main__':
    main()
