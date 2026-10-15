#!/usr/bin/env python3
"""Runner-only equivalent-workload evidence for numeric adjoint prefix bounds."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
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
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    environment = dict(os.environ, FWP_AD_WORKSPACE='0', FWP_GC_STRESS='0',
                       FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    source = out / 'prefix.fwp'
    source.write_text('main = [2.0, 3.0, 4.0] | vjp '
                      '(tap (rev._replay 4096 (map (add 1.0)) | ignore)) '
                      '[1.0, 2.0, 3.0] | echo\n')
    reference = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1')).stdout
    assert reference == '[1.0, 2.0, 3.0]\n', reference
    cfile = out / 'prefix.c'
    run([compiler, 'build', '--gc', 'arc', '--emit-c', '-o', cfile, source], environment)
    original = cfile.read_text()
    marker = '    int64_t needed = active;'
    assert original.count(marker) == 1
    cases = {'bounded': original, 'full-prefix-control': original.replace(marker, '    active = tp.len;\n' + marker)}
    results = {}
    cc = os.environ.get('CC', 'cc')
    for label, code in cases.items():
        cfile = out / (label + '.c')
        cfile.write_text(code)
        profile = out / (label + '-profile.c')
        measured = checkpoint.instrument(code)
        measured = measured.replace('typedef uint64_t V;', 'typedef uint64_t V;\nstatic int64_t prefix_nodes,prefix_active;')
        measured = measured.replace(marker, '    prefix_nodes=tp.len;prefix_active=active;\n' + marker)
        measured = measured.replace('    fwp_tape_finish();\n',
            '    fprintf(stderr,"{\\"recordedNodes\\":%lld,\\"activeNodes\\":%lld}\\n",(long long)prefix_nodes,(long long)prefix_active);\n    fwp_tape_finish();\n')
        profile.write_text(measured)
        binary, measured_binary = out / label, out / (label + '-profile')
        commands = []
        for src, dest in [(cfile, binary), (profile, measured_binary)]:
            command = [cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-w', src,
                       '-o', dest, '-lm', '-lpthread']
            run(command, environment)
            commands.append(list(map(str, command)))
        samples = []
        for _ in range(7):
            start = time.perf_counter_ns()
            result = run([binary], environment)
            samples.append(time.perf_counter_ns() - start)
            assert result.stdout == reference and not result.stderr
        result = run([measured_binary], environment)
        assert result.stdout == reference
        prefix, tape, managed = map(json.loads, result.stderr.splitlines())
        assert tape['finalTapeBytes'] == 0 and managed['finalChargedBytes'] == 0
        assert managed['collections'] == 0
        assert prefix['recordedNodes'] == 12291, prefix
        assert prefix['activeNodes'] == (3 if label == 'bounded' else 12291), prefix
        assembly = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
        (out / (label + '.asm')).write_text(run(assembly).stdout)
        results[label] = dict(prefix=prefix, tape=tape, managed=managed, commands=commands,
                              processWallNs=samples, medianProcessWallNs=statistics.median(samples),
                              generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest())
    assert results['bounded']['tape']['peakTapeBytes'] < results['full-prefix-control']['tape']['peakTapeBytes']
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(),
                  hardware=platform.uname()._asdict(),
                  cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
                  cc=run([cc, '--version']).stdout, rustc=run(['rustc', '-vV']).stdout,
                  source=source.read_text(), sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(),
                  results=results, scope='Identical ARC program and compiler, workspace disabled. '
                  'The control only extends the backward prefix to the full recorded tape. '
                  'Actual tape buffers and charged managed storage are measured separately. '
                  'Process timings include startup/output; no speedup threshold. '
                  'Forward recording is unchanged; allocator metadata and OS reservations excluded.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(results, indent=2))


if __name__ == '__main__':
    main()
