#!/usr/bin/env python3
"""Measure real compiler phases and GCC separately on retained growing programs."""
import argparse
import json
import os
from pathlib import Path
import platform
import shutil
import statistics
import subprocess
import time

from compiler_scaling import ROOT, cases, digest, phase_totals, profile, program, resources
from process_wait import run_capture


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--compiler', type=Path, required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--time', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--phase', choices=['check', 'measure'], required=True)
    parser.add_argument('--session', type=int, choices=[0, 1, 2], required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'run measurements on GitHub runners'
    assert (args.phase == 'check') == (args.session == 0)
    machine = platform.machine()
    march = {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[machine]
    assert platform.system() == 'Linux'
    compiler = args.compiler.resolve()
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    copy = output / 'compiler-copy'
    shutil.copy2(compiler, copy)
    assert digest(copy) == digest(compiler)
    environment = {k: v for k, v in os.environ.items()
                   if not k.startswith('FWP_') and k not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(CC=args.cc, FWP_LTO='0', LC_ALL='C')
    flags = ['-O2', '-std=gnu11', '-ffp-contract=off', '-fno-fast-math', '-fno-lto', '-march=' + march]
    identity = dict(source=subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip(),
        compilerSha256=digest(compiler), machine=machine, session=args.session, phase=args.phase,
        compiler=str(compiler), cc=args.cc, flags=flags, deadlineSeconds=120, rounds=8, warmups=1,
        ccVersion=subprocess.check_output([args.cc, '--version'], text=True),
        rustVersion=subprocess.check_output(['rustc', '-Vv'], text=True),
        topology=subprocess.check_output(['lscpu'], text=True),
        kernel=platform.platform(), affinity=sorted(os.sched_getaffinity(0)),
        scope='Fresh-process fwp build --emit-c; GCC and execution measured separately. RSS is per-command process high-water mark, not per-phase memory. Copy controls compare identical compiler bytes. OS caches are not flushed.')
    (output / 'identity.json').write_text(json.dumps(identity, indent=2) + '\n')
    failures = []
    summary = dict(identity=identity, cases={}, failures=failures)

    def save():
        (output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')

    def run(command, destination, expected_status):
        command = list(map(str, command))
        resource_path = destination.with_suffix('.resources')
        measured = [str(args.time), '-v', '-o', str(resource_path), *command]
        start = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(measured, env=environment, cwd=ROOT, input_data=None,
                input_stream=subprocess.DEVNULL, text=False, encoding='utf-8', timeout=120, check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(measured, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - start
        destination.with_suffix('.stdout').write_bytes(result.stdout)
        destination.with_suffix('.stderr').write_bytes(result.stderr)
        row = dict(command=command, elapsedNs=elapsed, status=result.returncode, timedOut=timed_out,
                   output=str(destination.relative_to(output)))
        if resource_path.exists() and not timed_out:
            row.update(resources(resource_path.read_text()))
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(row) + '\n')
        assert not timed_out and result.returncode == expected_status, row
        return row, result.stdout, result.stderr

    def emit(selected, source, cfile, report, prefix, status):
        command = [selected, 'build', '--target', 'native', '--emit-c', '-O2', source, '-o', cfile]
        if report is not None:
            command += ['--profile-compile', report]
        row, stdout, stderr = run(command, prefix, status)
        assert not stdout, (prefix, stdout)
        if status == 0:
            assert not stderr, (prefix, stderr)
        else:
            assert source.name.encode() in stderr and b'error' in stderr, (prefix, stderr)
        if report is not None:
            row['phases'] = phase_totals(profile(report, status))
        return row, stderr

    def build_and_execute(cfile, expected, prefix):
        binary = prefix.with_suffix('.exe')
        row, stdout, stderr = run([args.cc, *flags, cfile, '-o', binary, '-lm', '-lpthread', '-ldl'], prefix, 0)
        assert not stdout and not stderr, (prefix, stdout, stderr)
        execution, stdout, stderr = run([binary], prefix.with_name(prefix.name + '-execution'), 0)
        assert stdout == expected.encode() and not stderr, (prefix, stdout, stderr)
        row['binaryBytes'] = binary.stat().st_size
        row['binarySha256'] = digest(binary)
        row['execution'] = execution
        binary.unlink()
        return row

    for family, size in cases():
        name = f'{family}-{size}'
        path = output / name
        path.mkdir()
        source = path / 'input.fwp'
        text, expected = program(family, size)
        source.write_text(text)
        (path / 'expected.stdout').write_text(expected)
        case = dict(family=family, size=size, sourceBytes=len(text.encode()), sourceSha256=digest(source), samples=[])
        summary['cases'][name] = case
        try:
            if args.phase == 'check':
                cfiles = []
                for observed in (False, True):
                    role = 'observed' if observed else 'ordinary'
                    cfile = path / (role + '.c')
                    report = path / (role + '.json') if observed else None
                    row, _ = emit(compiler, source, cfile, report, path / (role + '-emit'), 0)
                    cfiles.append(cfile)
                    row['cBytes'] = cfile.stat().st_size
                    row['cSha256'] = digest(cfile)
                    row['gcc'] = build_and_execute(cfile, expected, path / (role + '-gcc'))
                    case[role] = row
                assert cfiles[0].read_bytes() == cfiles[1].read_bytes(), 'observer changed generated C'
                for position in ('early', 'late'):
                    error_source = path / (position + '.fwp')
                    bad = 'broken : I64\nbroken = "wrong"\n'
                    error_source.write_text(bad + text if position == 'early' else text + bad)
                    line = 2 if position == 'early' else text.count('\n') + 2
                    diagnostics = []
                    for observed in (False, True):
                        role = position + ('-observed' if observed else '-ordinary')
                        report = path / (role + '.json') if observed else None
                        row, stderr = emit(compiler, error_source, path / (role + '.c'), report, path / role, 1)
                        assert f'{error_source}:{line}:'.encode() in stderr, (role, stderr)
                        diagnostics.append(stderr)
                        case[role] = row
                    assert diagnostics[0] == diagnostics[1], 'observer changed diagnostics'
            else:
                baseline_c = None
                # One warmup of each treatment, followed by eight balanced rounds.
                for round_index in range(-1, 8):
                    roles = ['ordinary', 'ordinary-copy', 'observed', 'observed-copy']
                    if (round_index + args.session) % 2:
                        roles.reverse()
                    for role in roles:
                        prefix = path / f'round-{round_index}-{role}'
                        cfile = path / 'generated.c'
                        observed = role.startswith('observed')
                        report = prefix.with_suffix('.json') if observed else None
                        row, _ = emit(copy if role.endswith('-copy') else compiler, source, cfile, report, prefix, 0)
                        row.update(role=role, round=round_index, cBytes=cfile.stat().st_size, cSha256=digest(cfile))
                        if baseline_c is None:
                            baseline_c = cfile.read_bytes()
                            (path / 'retained.c').write_bytes(baseline_c)
                        assert cfile.read_bytes() == baseline_c, 'generated C changed across identical treatments'
                        row['gcc'] = build_and_execute(cfile, expected, prefix.with_name(prefix.name + '-gcc'))
                        case['samples'].append(row)
                        save()
                medians = {role: statistics.median(row['elapsedNs'] for row in case['samples']
                    if row['round'] >= 0 and row['role'] == role) for role in roles}
                ratios = {role: medians[role + '-copy'] / medians[role] for role in ('ordinary', 'observed')}
                case.update(medianEmitNs=medians, identicalCopyRatios=ratios,
                            timingQualified=all(.98 <= ratio <= 1.02 for ratio in ratios.values()),
                            observerRatio=medians['observed'] / medians['ordinary'])
            case['correct'] = True
        except (AssertionError, OSError, ValueError, KeyError) as error:
            case['correct'] = False
            failures.append(dict(case=name, error=str(error)))
        save()
        print(name, 'pass' if case['correct'] else 'FAIL', flush=True)
    copy.unlink()
    assert not failures, failures


if __name__ == '__main__':
    main()
