#!/usr/bin/env python3
"""Check retained derivative sessions and reproduce their time/memory tables."""
import argparse
import gzip
import importlib.util
import json
from pathlib import Path
import re
import subprocess

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('retention', ROOT / 'scripts/retain-derivative-evidence.py')
RETAIN = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(RETAIN)
CHECK = RETAIN.CHECK


def payload(folder, session, kind):
    name = session[kind]
    assert Path(name).name == name
    raw = gzip.decompress((folder / name).read_bytes())
    assert len(raw) == session[kind + 'Bytes']
    assert CHECK.digest(raw) == session[kind + 'Sha256']
    return raw


def measured_session(folder, label, session, source, source_hashes):
    report = json.loads(payload(folder, session, 'report'))
    CHECK.GROUPS.check_report(report, source, 'packed-records')
    assert label == report['machine'] + '-' + str(report['configuration']['session'])
    assert report['sourceHashes'] == source_hashes
    audit = session['audit']
    assert (audit['source'], audit['architecture'], audit['session']) == (
        source, report['machine'], report['configuration']['session'])
    failures = CHECK.GROUPS.DESCENT.paired_budget_failures(report['results'], 'packed-records')
    assert audit['budgetFailures'] == failures
    decision = 'not-accepted' if failures else 'accepted'
    assert session['decision'] == audit['decision'] == decision
    job = session['job']
    assert job['conclusion'] == ('failure' if failures else 'success')
    assert [step['name'] for step in job['steps'] if step['conclusion'] == 'failure'] == (
        ['Compare the candidate with its same-source reference'] if failures else [])
    assert session['qualification'] == report['qualification']
    assert audit['files']['comparison.json'] == dict(
        bytes=session['reportBytes'], sha256=session['reportSha256'])
    for name, row in report['results'].items():
        for image, binary in row['binaries'].items():
            assert audit['files'][name + '/' + image] == dict(
                bytes=binary['bytes'], sha256=binary['sha256'])
        for phase, count in [('warmup', 2), ('sample', 98)]:
            assert all(f'{name}/{phase}-{i:03d}.json' in audit['files'] for i in range(count))
    reference = report['referenceCompiler']
    assert reference['source'] == source
    assert reference['disabledTransformation'] == 'packed temporary numeric-record storage'
    assert reference['candidateCodegenSha256'] == source_hashes['src/cgen.rs']
    assert reference['ownershipSha256'] == source_hashes['src/ownership.rs']
    for name, field in [('fwp', 'compilerSha256'), ('codegen-reference.rs', 'referenceCodegenSha256'),
                        ('reference.patch', 'patchSha256')]:
        assert audit['referenceFiles'][name]['sha256'] == reference[field]
    assert CHECK.digest(session['referencePatch'].encode()) == reference['patchSha256']
    return report


def verified_reports(directory, source):
    assert re.fullmatch('[0-9a-f]{40}', source)
    sessions, rejections, jobs = {}, [], set()
    source_hashes = None
    for path in sorted((directory / 'timing').glob('*/index.json.gz')):
        index = json.loads(gzip.decompress(path.read_bytes()))
        assert index['source'] == source and index['protocol'] == 'packed-records'
        assert not index['auditErrors'] and str(index['run']) == path.parent.name
        assert index['sessions']
        for label, session in index['sessions'].items():
            assert session['source'] == source and session['run'] == index['run']
            assert session['architecture'] in {'aarch64', 'x86_64'} and session['session'] in {1, 2}
            assert label == session['architecture'] + '-' + str(session['session'])
            assert session['qualification']['source'] == source
            job = session['job']
            assert job['id'] not in jobs
            jobs.add(job['id'])
            assert job['status'] == 'completed' and job['head_sha'] == source
            assert job['run_id'] == index['run']
            assert job['name'] == 'descent_peers (' + str(session['session']) + ', ' + (
                'ubuntu-24.04-arm' if session['architecture'] == 'aarch64' else 'ubuntu-latest') + ')'
            payload(path.parent, session, 'log')
            if not session['qualification']['qualified']:
                RETAIN.rejected_host(job, session['qualification'])
                assert session['decision'] == 'host-rejected-before-building-or-timing'
                assert 'report' not in session
                rejections.append((index['run'], session))
                continue
            assert label not in sessions, 'duplicate completed measurement'
            if source_hashes is None:
                first = json.loads(payload(path.parent, session, 'report'))
                source_hashes = first['sourceHashes']
                for name, digest in source_hashes.items():
                    assert CHECK.digest(subprocess.check_output(
                        ['git', 'show', source + ':' + name], cwd=ROOT)) == digest, name
                candidate = subprocess.check_output(['git', 'show', source + ':src/cgen.rs'], cwd=ROOT).decode()
                preparation = subprocess.check_output(['git', 'show', source + ':scripts/prepare-packed-records-reference.py'], cwd=ROOT).decode()
                reference = CHECK.recorded_reference(candidate, preparation)
                CHECK.check_reference_patch(session['referencePatch'], candidate, reference, 'src/cgen.rs')
                assert CHECK.digest(reference.encode()) == first['referenceCompiler']['referenceCodegenSha256']
            report = measured_session(path.parent, label, session, source, source_hashes)
            sessions[label] = (path.parent.name, session, report)
    assert set(sessions) == {'aarch64-1', 'aarch64-2', 'x86_64-1', 'x86_64-2'}
    assert len({session['referencePatch'] for _, session, _ in sessions.values()}) == 1
    return sessions, rejections


def render(sessions, rejections):
    lines = ['# Paired derivative timings', '',
        'Read the [storage change and allocation results](README.md) first. These',
        'measurements compare the same fwp source with only packed temporary storage',
        'enabled or disabled. Every completed session and rejected CPU remains below.', '',
        '## Measurement scope', '',
        '- Each table time is the median of 98 samples. A sample sums seven fresh',
        '  processes; each process repeats the complete solve and prints every result.',
        '- Startup, repeated solves, formatting and shutdown are timed. Compilation',
        '  and observers are excluded. This is not isolated derivative-kernel time.',
        '- Initial coordinates alternate -1.2 and 1.0; each update subtracts 0.001',
        '  times the gradient. Every repeated solve starts from the original values.',
        '- Current keeps only the latest vector; history keeps all vectors. C/Rust',
        '  use explicit derivative formulas and two reusable buffers, without general',
        '  autodiff. Ratios against them include algorithm, allocation and formatting',
        '  differences; they are not pure compiler overhead.',
        '- fwp captures its initial immutable input once per process. C/Rust call',
        '  their input-initializing workload each solve. Equal initialization work',
        '  is not claimed; zero updates still include construction and printing.',
        '- fwp uses workspace reuse, packed arrays, stack storage and array fusion.',
        '  GCC uses `-O2 -std=gnu11 -fno-fast-math -ffp-contract=off`, reuse enabled,',
        '  and `-march=armv8-a` or `-march=x86-64`. LTO is off. Rust uses optimization',
        '  level 2, checked overflow, one codegen unit, generic CPU and no LTO.', '',
        '| Coordinates / updates | Solves per process |', '|---|---|',
        '| 3 / 0 | 32,768 |', '| 3 / 1 | 512 |', '| 3 / 199 | 32 |',
        '| 3 / 1,999 | 4 |', '| 33 / 199 | 32 |', '| 129 / 199 | 8 |', '',
        'A candidate/reference ratio below 1 is faster. All cases require at most',
        '1.02; cases with at least 199 updates require at most 0.95. **Copy difference**',
        'is `100 * (max(candidate/copy, copy/candidate) - 1)` and must not exceed 2%.',
        'C/Rust columns are current-form fwp elapsed time divided by peer time.',
        'For example, 10× means ten times the elapsed time, or 900% extra time.', '',
        'RSS is a separate process high-water observation in KiB, not managed live',
        'bytes or allocation traffic. Do not add these measures. A single RSS result',
        'includes runtime/library/allocator pages and does not establish a memory',
        'regression or saving by itself. Frame sizes are compiler-reported maxima,',
        'not total stack high-water marks. Full commands, samples, profiles, source',
        'and binary identities are in the linked compressed reports.', '']

    for label, (run, session, report) in sorted(sessions.items()):
        architecture = 'ARM64' if label.startswith('aarch64') else 'AMD64'
        lines.extend([f'## {architecture}, session {session["session"]}', '',
            f'Run [{run}](https://github.com/e6qu/fun-with-pipes/actions/runs/{run}); '
            f'[report](timing/{run}/{session["report"]}); '
            f'[audit and identities](timing/{run}/index.json.gz).', '',
            f'CPU: {report["qualification"]["actual"]["cpu"]}. '
            f'C: {report["qualification"]["actual"]["cVersion"]}. '
            f'Rust: {report["qualification"]["actual"]["rustVersion"]}.', '',
            '| Coordinates / updates | Current ms | History ms | Current/ref | History/ref | Copy difference | Current/C | Current/Rust |',
            '|---|---|---|---|---|---|---|---|'])
        for name, row in report['results'].items():
            ratio = row['ratios']
            current, history = ratio['fwp-ad'], ratio['fwp-ad-history']
            copy = current['fwp-ad-identical']
            lines.append(f'| {name.replace("-", " / ")} | {row["medianNs"]["fwp-ad"]/1e6:.3f} | {row["medianNs"]["fwp-ad-history"]/1e6:.3f} | '
                f'{current["fwp-ad-reference"]:.5f} | {history["fwp-ad-history-reference"]:.5f} | '
                f'{100*(max(copy,1/copy)-1):.3f}% | {current["c-explicit"]:.2f}× | {current["rust-explicit"]:.2f}× |')
        lines.extend(['', '| Coordinates / updates | Current/reference RSS KiB | History/reference RSS KiB | C/Rust RSS KiB | Current/reference instruction bytes | Current/reference largest reported frame bytes |',
            '|---|---|---|---|---|---|'])
        for name, row in report['results'].items():
            rss, binaries, stack = row['peakProcessRssBytes'], row['binaries'], row['cCompilerStackUsage']
            values = [max(e['bytes'] for e in stack[p+'.su']['entries']) for p in ['fwp-ad','fwp-ad-reference']]
            lines.append(f'| {name.replace("-", " / ")} | {rss["fwp-ad"]//1024} / {rss["fwp-ad-reference"]//1024} | '
                f'{rss["fwp-ad-history"]//1024} / {rss["fwp-ad-history-reference"]//1024} | '
                f'{rss["c-explicit"]//1024} / {rss["rust-explicit"]//1024} | '
                f'{binaries["fwp-ad"]["instructionBytes"]} / {binaries["fwp-ad-reference"]["instructionBytes"]} | {values[0]} / {values[1]} |')
        lines.append('')
        failures = session['audit']['budgetFailures']
        if not failures:
            lines.append('All frozen limits pass in this session.')
        else:
            lines.append('Failed limits (retained without rounding or threshold changes):')
            lines.append('')
            for failure in failures:
                lines.append(f'- `{failure["case"]}`, `{failure["program"]}`: {failure["metric"]} '
                    f'`{failure["actual"]}` > `{failure["limit"]}`.')
        lines.append('')

    lines.extend(['## Host rejections and remaining work', '',
        'These jobs stopped before building or timing because their CPU differed',
        'from the frozen AMD EPYC 7763. They are not measured sessions.', '',
        '| Run | Observed CPU | Retained evidence |', '|---|---|---|'])
    for run, session in rejections:
        lines.append(f'| [{run}](https://github.com/e6qu/fun-with-pipes/actions/runs/{run}) | '
            f'{session["qualification"]["actual"]["cpu"]} | [Index/log identity](timing/{run}/index.json.gz) |')
    lines.extend(['', 'All four required sessions are complete. '
        'No completed session is repeated to seek a pass. The full production matrix',
        'and the separate D2 requirements remain; fewer allocations do not close them.', ''])
    return '\n'.join(lines)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--directory', type=Path, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--mode', choices=['write', 'check'], required=True)
    args = parser.parse_args()
    sessions, rejections = verified_reports(args.directory, args.source)
    rendered = render(sessions, rejections)
    output = args.directory / 'timing.md'
    if args.mode == 'write':
        output.write_text(rendered)
    else:
        assert output.read_text() == rendered, 'timing table differs from verified observations'
    print(f'Four measured sessions and {len(rejections)} rejected hosts verified; timing table {args.mode} passes')


if __name__ == '__main__':
    main()
