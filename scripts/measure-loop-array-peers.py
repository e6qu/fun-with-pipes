#!/usr/bin/env python3
"""Compare saved fwp computation with explicit C and Rust implementations."""
import argparse
import hashlib
import importlib.util
import json
import math
import os
from pathlib import Path
import platform
import shutil
import statistics
import subprocess
import time

from process_wait import run_capture

SPEC = importlib.util.spec_from_file_location('audit', Path(__file__).with_name('audit-borrowed-arrays.py'))
AUDIT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(AUDIT)
COSTS = AUDIT.COSTS
ROLES = ('fwp', 'c', 'rust', 'fwp-copy', 'c-copy', 'rust-copy')
METRICS = ('constructionNs', 'computationNs', 'releaseNs', 'loopNs', 'processNs')


def order(number):
    position = number % len(ROLES)
    return ROLES[position:] + ROLES[:position]


def coordinate_values(count, updates):
    values = [-1.2 if index % 2 == 0 else 1.0 for index in range(count)]
    for _ in range(updates):
        result = []
        for i in range(count):
            previous = 0.0 if i == 0 else 200.0 * (values[i] - values[i-1] * values[i-1])
            following = 0.0 if i+1 == count else (
                -400.0 * values[i] * (values[i+1] - values[i] * values[i]) - 2.0 * (1.0 - values[i]))
            result.append(values[i] - 0.001 * (previous + following))
        values = result
    return values


def peer_sources(case):
    expected = case['expected'] if case['kind'] in ('loop', 'array') else coordinate_values(case['count'], case['updates'])
    words = COSTS.words(expected, case['kind'] == 'loop')
    kind = {'loop': 0, 'array': 1, 'manual': 2, 'local': 2}[case['kind']]
    c = '\n'.join(f'#define {name} {value}' for name, value in (
        ('KIND', kind), ('COUNT', case['count']), ('UPDATES', case['updates']),
        ('REPEATS', case['repeats']), ('EXPECTED', ', '.join(f'UINT64_C({word})' for word in words)))) + '\n'
    c += (COSTS.ROOT / 'tests/fixtures/loop_array_peer.c').read_text()
    rust = f"const COUNT: usize = {case['count']};\nconst REPEATS: usize = {case['repeats']};\n"
    if kind == 2:
        rust += f"const UPDATES: usize = {case['updates']};\n"
    rust += 'const EXPECTED: &[u64] = &[' + ', '.join(str(word) for word in words) + '];\n'
    rust += (COSTS.ROOT / 'tests/fixtures/loop_array_peer.rs').read_text()
    return c, rust, expected


def summarize(rows):
    assert [(row['round'], row['role']) for row in rows] == [
        (number, role) for number in range(-2, 24) for role in order(number)]
    for row in rows:
        assert all(type(row[key]) is int and row[key] > 0 for key in METRICS)
        assert sum(row[key] for key in METRICS[:3]) <= row['loopNs']
    medians = {metric: {role: statistics.median(
        row[metric] for row in rows if row['round'] >= 0 and row['role'] == role)
        for role in ROLES} for metric in METRICS}
    copies = {metric: {role: max(values[role], values[role + '-copy']) /
        min(values[role], values[role + '-copy']) for role in ROLES[:3]}
        for metric, values in medians.items()}
    ratios = {metric: {peer: values['fwp'] / values[peer] for peer in ('c', 'rust')}
              for metric, values in medians.items()}
    qualified = {metric: {peer: copies[metric]['fwp'] <= 1.02 and copies[metric][peer] <= 1.02
                         for peer in ('c', 'rust')} for metric in METRICS}
    return dict(medians=medians, copyRatios=copies, fwpRatios=ratios, qualified=qualified)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--cc', required=True)
    parser.add_argument('--rustc', required=True)
    parser.add_argument('--time', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    machine = platform.machine()
    arch = {'aarch64': 'ARM64', 'x86_64': 'X64'}[machine]
    repository = 'repos/' + os.environ['GITHUB_REPOSITORY']
    run = json.loads(AUDIT.api(f'{repository}/actions/runs/{args.run}'))
    assert run['head_sha'] == args.source and run['conclusion'] == 'success'
    artifacts = json.loads(AUDIT.api(f'{repository}/actions/runs/{args.run}/artifacts'))['artifacts']
    metadata, = [item for item in artifacts if item['name'] == f'borrowed-array-costs-{arch}-1']
    assert not metadata['expired'] and metadata['workflow_run']['head_sha'] == args.source
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    saved = output / 'original'
    AUDIT.unpack(AUDIT.api(f"{repository}/actions/artifacts/{metadata['id']}/zip"), metadata, saved)
    verified = AUDIT.audit(saved, machine, 1, args.source)
    AUDIT.save(output / 'input-audit.json', verified)
    identity = verified['identity']
    assert identity['reference']['disabled'] == 'fresh-array'
    assert subprocess.check_output([args.cc, '--version'], text=True) == identity['ccVersion']
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(identity['settings'])
    environment['LC_ALL'] = 'C'
    rust_flags = ['--edition=2021', '-O', '-C', 'target-cpu=generic', '-C', 'lto=off']
    report = dict(source=os.environ['GITHUB_SHA'], measuredSource=args.source, originalArtifact=metadata,
                  machine=machine, cpu=Path('/proc/cpuinfo').read_text(),
                  affinity=sorted(os.sched_getaffinity(0)), cFlags=identity['flags'], rustFlags=rust_flags,
                  ccVersion=identity['ccVersion'], rustVersion=subprocess.check_output([args.rustc, '-vV'], text=True),
                  cases={})

    def run_command(command, destination):
        command = list(map(str, command))
        start = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(command, timeout=180, cwd=COSTS.ROOT, env=environment,
                input_data=None, input_stream=None, text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - start
        destination.with_suffix('.stdout').write_bytes(result.stdout)
        destination.with_suffix('.stderr').write_bytes(result.stderr)
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode, timedOut=timed_out,
                elapsedNs=elapsed, output=str(destination.relative_to(output)))) + '\n')
        assert result.returncode == 0 and not timed_out and not result.stderr, (command, result.stderr)
        return result.stdout, elapsed

    for case in COSTS.programs():
        name = case['name']
        directory = output / name
        directory.mkdir()
        c, rust, expected = peer_sources(case)
        original_case = json.loads((saved / 'array-costs' / name / 'case.json').read_text())
        assert len(expected) == len(original_case['expected'])
        assert all(math.isfinite(a) and math.isclose(a, b, abs_tol=1e-10, rel_tol=1e-10)
                   for a, b in zip(expected, original_case['expected']))
        (directory / 'c.c').write_text(c)
        (directory / 'rust.rs').write_text(rust)
        (directory / 'fwp.c').write_bytes((saved / 'array-costs' / name / 'candidate.c').read_bytes())
        for role in ('fwp', 'c'):
            run_command([args.cc, *identity['flags'], directory / (role + '.c'),
                         '-o', directory / role, '-lm', '-lpthread', '-ldl'], directory / (role + '-build'))
        cfg = case['kind'] if case['kind'] in ('loop', 'array') else 'descent'
        run_command([args.rustc, *rust_flags, '--cfg', f'workload="{cfg}"', directory / 'rust.rs',
                     '-o', directory / 'rust'], directory / 'rust-build')
        for role in ROLES[:3]:
            shutil.copy2(directory / role, directory / (role + '-copy'))
        rows = []
        for number in range(-2, 24):
            for role in order(number):
                raw, elapsed = run_command([directory / role], directory / f'round-{number}-{role}')
                row = json.loads(raw) | dict(round=number, role=role, processNs=elapsed)
                if role.startswith('fwp'):
                    assert row['initialLiveBytes'] == row['finalLiveBytes']
                rows.append(row)
                with (directory / 'samples.jsonl').open('a') as log:
                    log.write(json.dumps(row) + '\n')
        result = summarize(rows)
        result['peerExpectedBits'] = COSTS.words(expected, case['kind'] == 'loop')
        result['fwpExpectedBits'] = COSTS.words(original_case['expected'], case['kind'] == 'loop')
        result['binaryHashes'] = {role: hashlib.sha256((directory / role).read_bytes()).hexdigest() for role in ROLES}
        result['resources'] = {}
        # These executions are separate observations, never timing samples.
        for role in ROLES[:3]:
            resource = directory / (role + '.resources')
            raw, elapsed = run_command([args.time, '-v', '-o', resource, directory / role],
                                       directory / (role + '-rss'))
            value = json.loads(raw)
            original = next(row for row in rows if row['role'] == role)
            assert value['checksum'] == original['checksum']
            if role == 'fwp':
                assert value['initialLiveBytes'] == value['finalLiveBytes'] == original['initialLiveBytes']
            result['resources'][role] = AUDIT.OBSERVATIONS.resources(resource.read_text()) | dict(
                elapsedNs=elapsed, imageBytes=(directory / role).stat().st_size)
        report['cases'][name] = result
        AUDIT.save(output / 'summary.json', report)
        print(name, json.dumps(result['fwpRatios']['computationNs']), result['qualified']['computationNs'], flush=True)


if __name__ == '__main__':
    main()
