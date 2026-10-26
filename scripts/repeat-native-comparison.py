#!/usr/bin/env python3
"""Repeat verified comparison binaries, measuring child CPU and allocation costs."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import resource
import statistics
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location('checkpoint', ROOT / 'scripts/measure-checkpoint.py')
checkpoint = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checkpoint)
run = checkpoint.run


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'measure on native runners'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--input', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    source_dir, out = args.input.resolve(), args.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    report = json.loads((source_dir / 'report.json').read_text())
    assert report['hardware']['system'] == platform.system()
    assert report['hardware']['machine'] == platform.machine()
    environment = dict(os.environ)
    results = {}
    for case, original in report['results'].items():
        assert (source_dir / (case + '.fwp')).read_text() == original['source']
        mode = 'counted'
        data = original['comparison']
        variants = {}; binaries = {}
        for enabled, recorded in data['variants'].items():
            stem = f'{case}-{mode}-{enabled}'
            cfile, binary = source_dir / (stem + '.c'), source_dir / stem
            for path, key in [(cfile, 'generatedSha256'), (binary, 'binarySha256')]:
                assert hashlib.sha256(path.read_bytes()).hexdigest() == recorded[key], (path, key)
            binary.chmod(0o755)
            profile_source, profile_binary = out / (stem + '-profile.c'), out / (stem + '-profile')
            profile_source.write_text(checkpoint.instrument(cfile.read_text()))
            command = [os.environ['CC'], '-O2', '-std=gnu11', '-ffp-contract=off', '-w',
                       profile_source, '-o', profile_binary, '-lm', '-lpthread']
            run(command, environment)
            profile = run([profile_binary], environment)
            assert profile.stdout == original['expected']
            tape, managed = map(json.loads, profile.stderr.splitlines())
            assert tape['finalTapeBytes'] == managed['finalChargedBytes'] == 0
            assert managed == recorded['managed'] and tape == recorded['tape']
            warm = run([binary], environment)
            assert warm.stdout == original['expected'] and not warm.stderr
            variants[enabled] = dict(generatedSha256=recorded['generatedSha256'], binarySha256=recorded['binarySha256'],
                profileCommand=list(map(str, command)), profile=dict(tape=tape, managed=managed), wallNs=[], cpuNs=[])
            binaries[enabled] = binary
        for sample in range(16):
            for enabled in (['0', '1'] if sample % 2 == 0 else ['1', '0']):
                before_cpu = resource.getrusage(resource.RUSAGE_CHILDREN)
                before_wall = time.perf_counter_ns()
                actual = run([binaries[enabled]], environment)
                wall = time.perf_counter_ns() - before_wall
                after_cpu = resource.getrusage(resource.RUSAGE_CHILDREN)
                cpu = (after_cpu.ru_utime + after_cpu.ru_stime - before_cpu.ru_utime - before_cpu.ru_stime) * 1e9
                assert actual.stdout == original['expected'] and not actual.stderr
                variants[enabled]['wallNs'].append(wall)
                variants[enabled]['cpuNs'].append(round(cpu))
        for value in variants.values():
            value['medianWallNs'] = statistics.median(value['wallNs'])
            value['medianCpuNs'] = statistics.median(value['cpuNs'])
        comparison = dict(variants=variants,
            enabledOverDisabledWall=variants['1']['medianWallNs'] / variants['0']['medianWallNs'],
            enabledOverDisabledCpu=variants['1']['medianCpuNs'] / variants['0']['medianCpuNs'])
        results[case] = dict(source=original['source'], expected=original['expected'], comparison=comparison)
    result = dict(head=os.environ['GITHUB_SHA'], emittedHead=report['head'], evidenceRun=os.environ['EVIDENCE_RUN'],
        hardware=platform.uname()._asdict(),
        cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
        compiler=run([os.environ['CC'], '--version']).stdout, results=results,
        scope='Same verified binaries from the named run, one warmup and 16 alternating process samples. '
              'Elapsed time includes process startup/input/output; CPU time is the child user+system CPU delta. '
              'Allocation profiles are separate rebuilt binaries; original '
              'counts must match exactly. No compilation in timed intervals or C/Rust comparison.')
    (out / 'report.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps({case: {key: value for key, value in data['comparison'].items() if key != 'variants'} for case, data in results.items()}, indent=2))


if __name__ == '__main__':
    main()
