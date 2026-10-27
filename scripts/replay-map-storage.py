#!/usr/bin/env python3
"""Repeat verified map timings on CI without rebuilding the compiler or programs."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import statistics
import subprocess
import time


def run(arguments, env):
    result = subprocess.run(list(map(str, arguments)), env=env, text=True,
                            capture_output=True)
    if result.returncode:
        raise RuntimeError(f'{arguments}: exit {result.returncode}\n{result.stdout}\n{result.stderr}')
    return result


def save(path, value):
    path.write_text(json.dumps(value, indent=2) + '\n')


def validate(folder, report, source, machine):
    """Check every executable and generated input before running any of them."""
    assert report['source'] == source, 'evidence source mismatch'
    assert [case['work'] for case in report['cases']] == ['full', 'construction']
    binaries = []
    for case in report['cases']:
        assert set(case['variants']) == {'counted-separate', 'counted-joined'}
        for variant in case['variants'].values():
            name = variant['binary']
            assert Path(name).name == name, 'binary must be inside its evidence directory'
            binary = folder / name
            data = binary.read_bytes()
            assert data[:6] == b'\x7fELF\x02\x01', 'expected 64-bit little-endian ELF'
            assert int.from_bytes(data[18:20], 'little') == machine, 'architecture mismatch'
            assert len(data) == variant['binaryBytes'], 'binary size mismatch'
            assert hashlib.sha256(data).hexdigest() == variant['binarySha256'], 'binary hash mismatch'
            assert hashlib.sha256(binary.with_suffix('.c').read_bytes()).hexdigest() == variant['generatedSha256'], 'generated source mismatch'
            binaries.append(binary)
    return binaries


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full measurements run on GitHub'
    assert platform.system() == 'Linux' and platform.machine() == 'x86_64'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--run', required=True)
    parser.add_argument('--source', required=True)
    parser.add_argument('--output', required=True, type=Path)
    options = parser.parse_args()
    out = options.output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    save(out / 'request.json', {'run': options.run, 'source': options.source})
    env = dict(os.environ)
    meta = json.loads(run(['gh', 'run', 'view', options.run, '--repo', 'e6qu/fun-with-pipes',
                          '--json', 'headSha,status,conclusion,jobs'], env).stdout)
    save(out / 'run.json', meta)
    assert meta['headSha'] == options.source
    assert meta['status'] == 'completed' and meta['conclusion'] == 'success'
    assert all(j['conclusion'] in ['success', 'skipped'] for j in meta['jobs'])
    original = out / 'original'
    run(['gh', 'run', 'download', options.run, '--repo', 'e6qu/fun-with-pipes',
         '--name', 'large-map-ubuntu-latest', '--dir', original], env)
    reports = {name: json.loads((original / name / 'report.json').read_text())
               for name in ['storage', 'storage-phases']}
    binaries = []
    for name, report in reports.items():
        binaries.extend(validate(original / name, report, options.source, 62))
    for binary in binaries:
        binary.chmod(binary.stat().st_mode | 0o100)
    result = {'sourceRun': options.run, 'source': options.source,
              'replaySource': run(['git', 'rev-parse', 'HEAD'], env).stdout.strip(),
              'cpu': run(['lscpu'], env).stdout, 'hardware': platform.platform(),
              'validatedBinaries': len(binaries), 'reports': {},
              'scope': 'Unmodified, hash-verified native executables from the named successful '
                       'evidence run. No compiler or native build. Ordinary timings and separate '
                       'construction/query diagnostics use fresh processes and balanced order. '
                       'Original sources, binaries, compiler flags and reports are retained. '
                       'This repeat identifies its own CPU; hosted runners do not promise a model.'}
    for name, report in reports.items():
        cases = []
        result['reports'][name] = cases
        for original_case in report['cases']:
            work, expected = original_case['work'], original_case['expected']
            variants = {label: {'binary': v['binary'], 'binarySha256': v['binarySha256'],
                                'samples': []} for label, v in original_case['variants'].items()}
            case = {'work': work, 'expected': expected, 'variants': variants, 'executionOrder': []}
            cases.append(case)
            for variant in variants.values():
                actual = run([original / name / variant['binary']], env)
                assert actual.stdout == expected
                if name == 'storage':
                    assert not actual.stderr
            rounds = 24 if name == 'storage' else 16
            labels = list(variants)
            for number in range(rounds):
                offset = number % len(labels)
                order = labels[offset:] + labels[:offset]
                case['executionOrder'].append(order)
                for label in order:
                    start = time.perf_counter_ns()
                    actual = run([original / name / variants[label]['binary']], env)
                    elapsed = time.perf_counter_ns() - start
                    assert actual.stdout == expected
                    events = [json.loads(line) for line in actual.stderr.splitlines()]
                    if name == 'storage':
                        assert not events
                    elif work == 'full':
                        assert len(events) == 1 and events[0]['stage'] == 'query-loop'
                        assert events[0]['constructionCount'] == events[0]['constructionBeforeLoop'] == 1
                        assert events[0]['constructionNs'] > 0 and events[0]['queryNs'] > 0
                    else:
                        assert [e['stage'] for e in events if e['stage'] != 'large-allocation'] == [
                            'scratch-allocation', 'sort', 'deduplicate', 'result-allocation', 'materialize', 'release-scratch']
                    variants[label]['samples'].append({'processWallNs': elapsed, 'events': events})
                save(out / 'report.json', result)
            for variant in variants.values():
                variant['medianProcessWallNs'] = statistics.median(s['processWallNs'] for s in variant['samples'])
            case['joinedToSeparateTimeRatio'] = {mode: variants[mode + '-joined']['medianProcessWallNs'] /
                variants[mode + '-separate']['medianProcessWallNs'] for mode in ['counted']}
            save(out / 'report.json', result)
            print(name, work, json.dumps(case['joinedToSeparateTimeRatio']), flush=True)


if __name__ == '__main__':
    main()
