#!/usr/bin/env python3
"""Compare ordinary compiler builds on complete applications and growing inputs."""
import argparse
import json
import os
from pathlib import Path
import platform
import shutil
import statistics
import subprocess
import time
import traceback

from compiler_scaling import APPLICATIONS, ROOT, cases, digest, program, resources
from process_wait import run_capture


def comparison(samples, name):
    roles = ('reference', 'reference-copy', 'candidate', 'candidate-copy')
    assert len(samples) == 36 and {row['role'] for row in samples} == set(roles)
    for role in roles:
        rows = [row for row in samples if row['role'] == role]
        assert sorted(row['round'] for row in rows) == list(range(-1, 8))
        assert all(row['elapsedNs'] > 0 and row['maxRssKiB'] > 0 for row in rows)
    timed = [row for row in samples if row['round'] >= 0]
    medians = {role: statistics.median(row['elapsedNs'] for row in timed if row['role'] == role) for role in roles}
    controls = {role: medians[role+'-copy']/medians[role] for role in ('reference', 'candidate')}
    peaks = {role: max(row['maxRssKiB'] for row in timed if row['role'].removesuffix('-copy') == role) for role in ('reference', 'candidate')}
    ratio = medians['candidate']/medians['reference']
    qualified = all(.98 <= value <= 1.02 for value in controls.values())
    rss_ratio = peaks['candidate']/peaks['reference']
    return dict(medianEmitNs=medians, identicalCopyRatios=controls, timingQualified=qualified,
        candidateRatio=ratio, peakRssKiB=peaks, peakRssRatio=rss_ratio,
        acceptance=qualified and ratio <= (.95 if name in ('words', 'callbacks') else 1.02) and rss_ratio <= 1.05)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--reference', type=Path, required=True)
    parser.add_argument('--candidate', type=Path, required=True)
    parser.add_argument('--reference-source', required=True)
    parser.add_argument('--phase', choices=('check', 'measure'), required=True)
    parser.add_argument('--session', type=int, choices=(0, 1, 2), required=True)
    parser.add_argument('--time', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--cpu', type=int, required=True)
    parser.add_argument('--deadline', type=float, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert (args.phase == 'check') == (args.session == 0)
    assert 0 < args.deadline <= 120 and args.cpu in os.sched_getaffinity(0)
    assert os.environ.get('CARGO_PROFILE_RELEASE_DEBUG') in (None, 'false', '0')
    os.sched_setaffinity(0, {args.cpu})
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    compilers = dict(reference=args.reference.resolve(), candidate=args.candidate.resolve())
    for role in ('reference', 'candidate'):
        copy = output/(role+'-copy')
        shutil.copy2(compilers[role], copy)
        assert digest(copy) == digest(compilers[role])
        compilers[role+'-copy'] = copy
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', LC_ALL='C')
    identity = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        referenceSource=args.reference_source, phase=args.phase, session=args.session,
        compilers={role: dict(path=str(path), sha256=digest(path)) for role, path in compilers.items()},
        cc=args.cc, ccVersion=subprocess.check_output([args.cc, '--version'], text=True),
        rustVersion=subprocess.check_output(['rustc', '-Vv'], text=True),
        topology=subprocess.check_output(['lscpu'], text=True), kernel=platform.platform(),
        affinity=sorted(os.sched_getaffinity(0)), deadlineSeconds=args.deadline, rounds=8, warmups=1,
        scope='Fresh-process ordinary emit-C, including GNU time startup; no phase reporter, '
              'copy counters, GCC compilation or program execution. One allowed logical CPU, '
              'not reserved exclusively; OS caches are not flushed. RSS is process high-water memory.')
    (output/'identity.json').write_text(json.dumps(identity, indent=2)+'\n')
    summary = dict(identity=identity, cases={}, failures=[])
    inputs = [(name, ROOT/relative, None) for name, relative in APPLICATIONS.items()]
    for family, size in cases():
        name = f'{family}-{size}'
        directory = output/name
        directory.mkdir()
        source = directory/'input.fwp'
        text, expected = program(family, size)
        source.write_text(text)
        (directory/'expected.stdout').write_text(expected)
        inputs.append((name, source, text))

    def save():
        (output/'summary.json').write_text(json.dumps(summary, indent=2)+'\n')

    def emit(role, source, destination, prefix, expected_status):
        usage = prefix.with_suffix('.resources')
        command = [str(args.time), '-v', '-o', str(usage), str(compilers[role]), 'build',
                   '--target', 'native', '--emit-c', '-O2', str(source), '-o', str(destination)]
        start = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(command, env=environment, cwd=ROOT, input_data=None,
                input_stream=subprocess.DEVNULL, text=False, encoding='utf-8', timeout=args.deadline, check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        row = dict(command=command, elapsedNs=time.perf_counter_ns()-start,
                   status=result.returncode, timedOut=timed_out, role=role)
        prefix.with_suffix('.stdout').write_bytes(result.stdout)
        prefix.with_suffix('.stderr').write_bytes(result.stderr)
        if usage.exists() and not timed_out:
            row.update(resources(usage.read_text()))
        with (output/'commands.jsonl').open('a') as log:
            log.write(json.dumps(row)+'\n')
        assert not timed_out and result.returncode == expected_status, row
        assert not result.stdout
        if expected_status == 0:
            assert not result.stderr, result.stderr
            row.update(cSha256=digest(destination), cBytes=destination.stat().st_size)
        else:
            assert source.name.encode() in result.stderr and b'error' in result.stderr
        return row, result.stderr

    for name, source, generated in inputs:
        directory = output/name
        directory.mkdir(exist_ok=True)
        if generated is None:
            shutil.copyfile(source, directory/'input.fwp')
        case = dict(source=str(source), sourceSha256=digest(source), samples=[], correct=False)
        summary['cases'][name] = case
        try:
            reference_c = None
            rounds = range(-1, 8) if args.phase == 'measure' else (0,)
            for round_index in rounds:
                roles = ['reference', 'reference-copy', 'candidate', 'candidate-copy'] if args.phase == 'measure' else ['reference', 'candidate']
                if (round_index + args.session) % 2:
                    roles.reverse()
                for role in roles:
                    cfile = directory/'generated.c'
                    row, _ = emit(role, source, cfile, directory/f'round-{round_index}-{role}', 0)
                    row['round'] = round_index
                    if reference_c is None:
                        reference_c = cfile.read_bytes()
                        (directory/'retained.c').write_bytes(reference_c)
                    assert cfile.read_bytes() == reference_c, 'candidate changed generated C'
                    case['samples'].append(row)
                    save()
            if args.phase == 'check' and generated is not None:
                for position in ('early', 'late'):
                    bad = 'broken : I64\nbroken = "wrong"\n'
                    invalid = directory/(position+'.fwp')
                    invalid.write_text(bad+generated if position == 'early' else generated+bad)
                    line = 2 if position == 'early' else generated.count('\n')+2
                    diagnostics = []
                    for role in ('reference', 'candidate'):
                        row, stderr = emit(role, invalid, directory/(position+'-'+role+'.c'), directory/(position+'-'+role), 1)
                        assert f'{invalid}:{line}:'.encode() in stderr
                        diagnostics.append(stderr)
                    assert diagnostics[0] == diagnostics[1], 'candidate changed diagnostics'
            if args.phase == 'measure':
                case.update(comparison(case['samples'], name))
            case['correct'] = True
        except Exception:
            case['failure'] = traceback.format_exc()
            summary['failures'].append(name)
        save()
        print(name, 'pass' if case['correct'] else case['failure'], flush=True)
    assert not summary['failures'], summary['failures']
    if args.phase == 'measure':
        print('Timing acceptance:', {name: case['acceptance'] for name, case in summary['cases'].items()})


if __name__ == '__main__':
    main()
