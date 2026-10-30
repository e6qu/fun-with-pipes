#!/usr/bin/env python3
"""Measure process RSS and separate fwp managed-storage counts for saved benchmarks."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent
profile_spec = importlib.util.spec_from_file_location(
    'iteration_profile', ROOT / 'scripts/measure-iteration.py')
profile = importlib.util.module_from_spec(profile_spec)
profile_spec.loader.exec_module(profile)

parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('--input', type=Path, required=True)
parser.add_argument('--inspection', type=Path, required=True)
parser.add_argument('--source', required=True)
parser.add_argument('--cc', required=True)
parser.add_argument('--time', type=Path, required=True)
parser.add_argument('--samples', type=int, required=True)
parser.add_argument('--output', type=Path, required=True)
args = parser.parse_args()
assert os.environ['GITHUB_ACTIONS'] == 'true' and platform.system() == 'Linux'
assert args.samples >= 3 and re.fullmatch('[0-9a-f]{40}', args.source)
assert not args.output.exists(), 'Preserve completed memory measurements'
inspection = json.loads(args.inspection.read_text())
assert inspection['source'] == args.source and inspection['ownership'] == 'counted'
assert inspection['architecture'] == platform.machine()
directory, = (args.input / args.source).iterdir()
args.output.mkdir(parents=True)
# These are the same local job artifacts, not downloaded untrusted executables.
# Select runtime diagnostics explicitly; keep credentials out of child programs.
environment = {key: value for key, value in os.environ.items()
               if not key.startswith('FWP_') and key not in {'GH_TOKEN', 'GITHUB_TOKEN'}}
environment.update(FWP_LTO='0', LC_ALL='C')


def run(command):
    result = run_capture(list(map(str, command)), timeout=120,
                 env=environment, cwd=None, input_data=None, input_stream=None,
                 text=False, encoding='utf-8', check=False)
    assert result.returncode == 0, (command, result.returncode, result.stderr)
    return result


def digest(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


result = dict(source=args.source, ownership='counted', architecture=platform.machine(),
              inspectionSha256=digest(args.inspection), samples=args.samples,
              cCompiler=run([args.cc, '--version']).stdout.decode(),
              timeTool=run([args.time, '--version']).stdout.decode(),
              kernel=run(['uname', '-a']).stdout.decode().strip(),
              scope='Fresh-process peak RSS from the actual timed binaries; no timing '
                    'samples from GNU time or instrumented binaries. Separate fwp '
                    'profiles count managed requests/bytes, retains and charged live '
                    'storage after constant initialization through language cleanup. '
                    'Counts exclude runtime raw buffers, allocator metadata, stacks '
                    'and C/Rust allocations. Stack reports describe instrumented '
                    'binaries, not the original timed executables.', programs=[])
for program in inspection['programs']:
    name = program['name']
    expected = program['stdout'].encode()
    row = dict(name=name, processMemory={}, managedMemory={})
    for language in ['c', 'rs', 'fwp']:
        executable = directory / f'{name}-{language}'
        assert digest(executable) == program['files'][language]['binarySha256']
        samples = []
        for number in range(args.samples):
            path = args.output / f'{name}-{language}-{number}.rss-kib'
            actual = run([args.time.resolve(), '-f', '%M', '-o', path, executable.resolve()])
            assert actual.stdout == expected and not actual.stderr
            value = int(path.read_text())
            assert value > 0, (name, language, number, value)
            samples.append(value)
        row['processMemory'][language] = dict(binarySha256=digest(executable), peakRssKiB=samples)
    generated = directory / f'{name}-generated.c'
    assert digest(generated) == program['generatedCSha256']
    code = profile.instrument(generated.read_text())
    start = 'iteration_start_charge=iteration_charge();iteration_active=1;'
    assert code.count(start) == 1
    leak = code.replace(start, start + '(void)fwp_alloc_leaf(16);')
    for label, candidate in [('ordinary', code), ('injected-leak', leak)]:
        stem = f'{name}-{label}'
        cfile = args.output / (stem + '.c')
        binary = args.output / stem
        cfile.write_text(candidate)
        command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-fstack-usage',
                   '-w', cfile.resolve(), '-o', binary.resolve(), '-lm', '-lpthread', '-ldl']
        run(command)
        profiles = []
        for number in range(args.samples):
            actual = run([binary.resolve()])
            assert actual.stdout == expected
            (args.output / f'{stem}-{number}.stdout').write_bytes(actual.stdout)
            (args.output / f'{stem}-{number}.stderr').write_bytes(actual.stderr)
            counters = json.loads(actual.stderr)
            assert set(counters) == {'requests', 'requestedBytes', 'retains', 'peakChargedBytes', 'finalChargedBytes'}
            profiles.append(counters)
        assert all(counts == profiles[0] for counts in profiles)
        row['managedMemory'][label] = dict(profiles=profiles, command=list(map(str, command)),
            generatedSha256=digest(cfile), binarySha256=digest(binary), fileBytes=binary.stat().st_size)
    ordinary = row['managedMemory']['ordinary']['profiles'][0]
    leaked = row['managedMemory']['injected-leak']['profiles'][0]
    assert ordinary['finalChargedBytes'] == 0, (name, ordinary)
    assert leaked['requests'] == ordinary['requests'] + 1
    assert leaked['requestedBytes'] == ordinary['requestedBytes'] + 16
    assert leaked['retains'] == ordinary['retains']
    assert leaked['finalChargedBytes'] > 0, (name, leaked)
    row['leakDetected'] = True
    result['programs'].append(row)
    (args.output / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
    print(name, 'RSS:', {kind: entry['peakRssKiB'] for kind, entry in row['processMemory'].items()},
          'managed:', ordinary, 'leak detected:', leaked['finalChargedBytes'], flush=True)
assert len(result['programs']) == 7
print('Measured 21 native process-memory distributions and 14 separate fwp profiles')
