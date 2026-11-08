#!/usr/bin/env python3
"""Compare CPU placement using byte-identical saved images, without recompiling."""
import argparse
import hashlib
import importlib.util
import json
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
ROLES = ('all', 'one', 'all-copy', 'one-copy')
CASES = ('loop-100000000', 'manual-3-0', 'array-65537', 'array-262145')


def order(number):
    position = number % len(ROLES)
    return ROLES[position:] + ROLES[:position]


def summarize(rows):
    assert [(row['round'], row['role']) for row in rows] == [
        (number, role) for number in range(-2, 24) for role in order(number)]
    medians = {}
    for metric in ('constructionNs', 'computationNs', 'releaseNs', 'loopNs', 'processNs'):
        assert all(type(row[metric]) is int and row[metric] > 0 for row in rows)
        medians[metric] = {role: statistics.median(
            row[metric] for row in rows if row['round'] >= 0 and row['role'] == role)
            for role in ROLES}
    copies = {metric: {role: max(values[role], values[role + '-copy']) /
        min(values[role], values[role + '-copy']) for role in ROLES[:2]}
        for metric, values in medians.items()}
    return dict(medians=medians, copyRatios=copies,
                computationQualified={role: ratio <= 1.02 for role, ratio in copies['computationNs'].items()})


def host_failures(models, processors, allowed, processor_index):
    failures = []
    if len(models) != 1 or not models <= set(allowed):
        failures.append(f'CPU models {sorted(models)} are outside {allowed}')
    if len(processors) != 4:
        failures.append(f'Expected four assigned CPUs, received {processors}')
    if not 0 <= processor_index < len(processors):
        failures.append(f'Processor index {processor_index} is outside {processors}')
    return failures


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', type=int, required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--processor-index', type=int, required=True)
    parser.add_argument('--cpu', action='append', required=True)
    parser.add_argument('--taskset', type=Path, required=True)
    parser.add_argument('--time', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == 'x86_64'
    cpu_text = Path('/proc/cpuinfo').read_text()
    models = {line.split(':', 1)[1].strip() for line in cpu_text.splitlines() if line.startswith('model name')}
    processors = sorted(os.sched_getaffinity(0))
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    failures = host_failures(models, processors, args.cpu, args.processor_index)
    host = dict(source=os.environ['GITHUB_SHA'], cpu=cpu_text, models=sorted(models),
                visibleProcessors=os.cpu_count(), assignedProcessors=processors,
                processorIndex=args.processor_index, allowedModels=args.cpu,
                failures=failures, qualified=not failures)
    AUDIT.save(output / 'host.json', host)
    print('Assigned CPUs:', processors, 'visible CPUs:', host['visibleProcessors'],
          'models:', host['models'], flush=True)
    if failures:
        raise SystemExit('Host rejected before executing saved images:\n' + '\n'.join(failures))
    placements = dict(all=','.join(map(str, processors)), one=str(processors[args.processor_index]))
    repository = 'repos/' + os.environ['GITHUB_REPOSITORY']
    run = json.loads(AUDIT.api(f'{repository}/actions/runs/{args.run}'))
    assert run['head_sha'] == args.source and run['conclusion'] == 'success'
    artifacts = json.loads(AUDIT.api(f'{repository}/actions/runs/{args.run}/artifacts'))['artifacts']
    metadata, = [item for item in artifacts if item['name'] == 'borrowed-array-costs-X64-2']
    assert not metadata['expired'] and metadata['workflow_run']['head_sha'] == args.source
    AUDIT.unpack(AUDIT.api(f"{repository}/actions/artifacts/{metadata['id']}/zip"), metadata, output / 'original')
    verified = AUDIT.audit(output / 'original', 'x86_64', 2, args.source)
    AUDIT.save(output / 'input-audit.json', verified)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(verified['identity']['settings'])
    environment['LC_ALL'] = 'C'
    report = dict(source=os.environ['GITHUB_SHA'], measuredSource=args.source, originalArtifact=metadata,
                  cpu=cpu_text, processors=processors, placements=placements, cases={})
    for name in CASES:
        directory = output / name
        directory.mkdir()
        original = output / 'original/array-costs' / name / 'candidate'
        digest = hashlib.sha256(original.read_bytes()).hexdigest()
        for role in ROLES:
            image = directory / role
            shutil.copy2(original, image)
            image.chmod(0o755)
            assert hashlib.sha256(image.read_bytes()).hexdigest() == digest
        expected = json.loads((original.parent / 'round-0-candidate.stdout').read_text())
        rows = []
        for number in range(-2, 24):
            for role in order(number):
                placement = placements[role.split('-')[0]]
                destination = directory / f'round-{number}-{role}'
                resource = destination.with_suffix('.resources')
                command = list(map(str, [args.time, '-v', '-o', resource, args.taskset,
                                        '--cpu-list', placement, directory / role]))
                start = time.perf_counter_ns()
                timed_out = False
                try:
                    result = run_capture(command, timeout=180, cwd=AUDIT.COSTS.ROOT,
                        env=environment, input_data=None, input_stream=None, text=False,
                        encoding='utf-8', check=False)
                except subprocess.TimeoutExpired as error:
                    timed_out = True
                    result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
                elapsed = time.perf_counter_ns() - start
                destination.with_suffix('.stdout').write_bytes(result.stdout)
                destination.with_suffix('.stderr').write_bytes(result.stderr)
                with (output / 'commands.jsonl').open('a') as log:
                    log.write(json.dumps(dict(command=command, status=result.returncode, timedOut=timed_out,
                        elapsedNs=elapsed, output=str(destination.relative_to(output)))) + '\n')
                assert result.returncode == 0 and not timed_out and not result.stderr
                row = json.loads(result.stdout) | dict(round=number, role=role, processNs=elapsed)
                assert row['initialLiveBytes'] == row['finalLiveBytes'] == expected['initialLiveBytes']
                assert row['checksum'] == expected['checksum']
                row['processResources'] = AUDIT.OBSERVATIONS.resources(resource.read_text())
                rows.append(row)
                with (directory / 'samples.jsonl').open('a') as log:
                    log.write(json.dumps(row) + '\n')
        report['cases'][name] = summarize(rows) | dict(binarySha256=digest)
        AUDIT.save(output / 'summary.json', report)
        print(name, report['cases'][name]['copyRatios']['computationNs'], flush=True)


if __name__ == '__main__':
    main()
