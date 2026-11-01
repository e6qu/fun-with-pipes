#!/usr/bin/env python3
"""Reproduce saved zero-update binaries with GCC reports; collect no new timings."""
import argparse
import hashlib
import json
import os
from pathlib import Path
import platform
import subprocess

from process_wait import run_capture

ROOT = Path(__file__).resolve().parent.parent


def digest(data):
    return hashlib.sha256(data).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['evidence', 'output']:
        parser.add_argument('--' + name, type=Path, required=True)
    for name in ['source', 'cc']:
        parser.add_argument('--' + name, required=True)
    parser.add_argument('--timeout', type=int, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    assert platform.system() == 'Linux' and platform.machine() == 'x86_64'
    assert args.timeout == 180
    report = json.loads((args.evidence / 'comparison.json').read_text())
    assert report['source'] == args.source and report['configuration']['comparison'] == 'record-zip'
    assert report['configuration']['c_arch'] == 'x86-64' and report['configuration']['cc'] == args.cc
    expected = report['qualification']['actual']
    version = subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0]
    assert version == expected['cVersion'] and expected['machine'] == platform.machine()
    row = report['results']['3-0']
    assert row['dimensions'] == 3 and row['updates'] == 0 and row['solvesPerProcess'] == 32768
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(report['settings'])
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    restored = ROOT / 'descent-peers-evidence' / '3-0'
    restored.mkdir(parents=True, exist_ok=False)
    flags = ['-O2', '-std=gnu11', '-fno-fast-math', '-ffp-contract=off', '-UFWP_NO_REUSE',
             '-fstack-usage', '-march=x86-64', '-w']
    results = dict(diagnosticSource=os.environ['GITHUB_SHA'], inputSource=args.source,
                   decision='diagnostic-only', cVersion=version, architecture=platform.machine(),
                   cpuInfo=json.loads(subprocess.check_output(['lscpu', '--json'], text=True)),
                   configuration={key: str(value) if isinstance(value, Path) else value
                                  for key, value in vars(args).items()}, programs={})
    (output / 'results.json').write_text(json.dumps(results, indent=2) + '\n')

    def run(command, name):
        try:
            observed = run_capture(command, env=environment, cwd=ROOT, input_data=None,
                                   input_stream=None, text=False, encoding='utf-8',
                                   timeout=args.timeout, check=False)
            timed_out = False
        except subprocess.TimeoutExpired as error:
            observed = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
            timed_out = True
        for stream in ['stdout', 'stderr']:
            (output / (name + '.' + stream)).write_bytes(getattr(observed, stream))
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=observed.returncode, timedOut=timed_out,
                                     stdoutSha256=digest(observed.stdout),
                                     stderrSha256=digest(observed.stderr))) + '\n')
        assert observed.returncode == 0 and not observed.stderr, (command, observed)
        return observed.stdout

    for label in ['fwp-ad', 'fwp-ad-reference', 'fwp-ad-history', 'fwp-ad-history-reference']:
        info = row['binaries'][label]
        data = (args.evidence / '3-0' / (label + '.c')).read_bytes()
        assert digest(data) == info['sourceSha256']
        assert digest((args.evidence / '3-0' / label).read_bytes()) == info['sha256']
        source = restored / (label + '.c')
        binary = restored / label
        # Match the original path and every build flag before adding diagnostics.
        # This prevents a changed build or source identity from explaining a dump.
        original = [args.cc, *flags, str(source), '-o', str(binary), '-lm', '-lpthread', '-ldl']
        command, = [item for item in report['commands'] if item['command'] == original]
        assert command['status'] == 0 and not command['stdout'] and not command['stderr']
        source.write_bytes(data)
        inline = output / (label + '.inline.txt')
        optimized = output / (label + '.optimized.txt')
        run([*original[:1], '-fopt-info-inline-all=' + str(inline),
             '-fdump-tree-optimized=' + str(optimized), *original[1:]], label + '-build')
        binary_hash = digest(binary.read_bytes())
        assert binary_hash == info['sha256'], 'Diagnostic flags changed the measured binary'
        assert inline.stat().st_size > 0 and optimized.stat().st_size > 0
        stdout = run([str(binary)], label + '-run')
        assert digest(stdout) == row['outputSha256'][label]
        assert len(stdout.splitlines()) == row['solvesPerProcess']
        result = dict(sourceSha256=digest(data), binarySha256=binary_hash,
                      stdoutSha256=digest(stdout), inlineSha256=digest(inline.read_bytes()),
                      optimizedSha256=digest(optimized.read_bytes()))
        results['programs'][label] = result
        (output / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
        print(label + ': original binary and output hashes match', flush=True)
    print('Four zero-update builds reproduced; reports explain compilation, not timing causality')


if __name__ == '__main__':
    main()
