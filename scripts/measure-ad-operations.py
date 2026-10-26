#!/usr/bin/env python3
"""Runner-only storage and binary evidence for input-heavy autodiff tapes."""
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
CASES = {
    'identity': ('main = range 0 4096 | map int.to-float | vjp id (repeat 4096 1.0) | sum | echo\n', '4096.0\n'),
    'map': ('main = range 0 4096 | map int.to-float | vjp (map (mul 2.0)) (repeat 4096 1.0) | sum | echo\n', '8192.0\n'),
    'nested': ('square : List[t] -> t where Ring[t], Dup[t]\n'
               'square = head | option.unwrap-or zero | fork mul id id\n'
               'main = range 0 256 | map int.to-float | grad (grad square | sum) | sum | echo\n', '2.0\n'),
}


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full evidence runs on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    out = parser.parse_args().output.resolve()
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    cc = os.environ.get('CC', 'cc')
    environment = dict(os.environ, FWP_AD_WORKSPACE='0', FWP_GC_STRESS='0',
                       FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    results = {}
    for name, (program, expected) in CASES.items():
        source = out / (name + '.fwp')
        source.write_text(program)
        reference = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1'))
        assert reference.stdout == expected and not reference.stderr, reference
        emitted = out / (name + '.c')
        run([compiler, 'build', '--emit-c', '-o', emitted, source], environment)
        original = emitted.read_text()
        creation, growth = '    t->len = n;', '    fwp_tape_reserve(t, op + 1);'
        assert original.count(creation) == 1 and original.count(growth) == 2
        padded = original.replace(creation, creation + '\n    fwp_tape_reserve(t, n);')
        padded = padded.replace(growth, '    fwp_tape_reserve(t, t->leaves + op + 1);')
        cases = {}
        for label, code in [('operations', original), ('input-capacity-control', padded)]:
            stem = name + '-' + label
            cfile, profile = out / (stem + '.c'), out / (stem + '-profile.c')
            cfile.write_text(code)
            profile.write_text(checkpoint.instrument(code))
            binary, measured_binary = out / stem, out / (stem + '-profile')
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
                assert result.stdout == expected and not result.stderr
            result = run([measured_binary], environment)
            assert result.stdout == expected
            tape, managed = map(json.loads, result.stderr.splitlines())
            assert tape['finalTapeBytes'] == 0 and managed['finalChargedBytes'] == 0
            assert managed['collections'] == 0
            assembly = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
            asmfile = out / (stem + '.asm')
            asmfile.write_text(run(assembly).stdout)
            cases[label] = dict(tape=tape, managed=managed, commands=commands,
                               processWallNs=samples, medianProcessWallNs=statistics.median(samples),
                               generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(),
                               binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                               assemblySha256=hashlib.sha256(asmfile.read_bytes()).hexdigest())
        assert cases['operations']['tape']['peakTapeBytes'] < cases['input-capacity-control']['tape']['peakTapeBytes']
        if name == 'nested':
            assert cases['operations']['managed']['requestedBytes'] < cases['input-capacity-control']['managed']['requestedBytes']
        else:
            assert cases['operations']['managed'] == cases['input-capacity-control']['managed']
        results[name] = dict(source=program, sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(), cases=cases)
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(),
                  hardware=platform.uname()._asdict(),
                  cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
                  cc=run([cc, '--version']).stdout, rustc=run(['rustc', '-vV']).stdout,
                  results=results, scope='Identical ARC programs and compiler, workspace disabled. '
                  'The control reserves operation capacity for input placeholders at creation and growth; '
                  'logical offsets and arithmetic remain identical. This isolates storage, not all old-code costs. '
                  'Native tape buffers and charged managed storage are counted separately. '
                  'Process timings include startup/output; no speedup threshold. '
                  'Allocator metadata and OS reservations are excluded.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps(results, indent=2))


if __name__ == '__main__':
    main()
