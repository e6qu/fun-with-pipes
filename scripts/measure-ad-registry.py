#!/usr/bin/env python3
"""Runner-only equivalent AD registry growth and native instruction evidence."""
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
PROGRAM = '''finish : I64 -> F64
finish = make { 0 = id, 1 = singleton | array.from-list, 2 = const [1.0] | array.from-list }
    | uncurry3 ad.backward | array.to-list | sum
batch = range 0 | map (const 1 | ad.tape) | map finish | sum
main = COUNT | ad.scope batch | echo
'''


def instrument(code):
    code = checkpoint.instrument(code)
    declaration = 'static int64_t fwp_tapes_cap = 0;'
    assert code.count(declaration) == 1
    code = code.replace(declaration, declaration + '''
static uint64_t registry_requests, registry_requested;
static size_t registry_peak;
static void *registry_realloc(void *old,size_t bytes) {
    registry_requests++;registry_requested+=bytes;
    if(bytes>registry_peak)registry_peak=bytes;
    return checkpoint_realloc(old,bytes);
}
''')
    assert code.count('checkpoint_realloc(fwp_tapes,') == 1
    code = code.replace('checkpoint_realloc(fwp_tapes,', 'registry_realloc(fwp_tapes,')
    main = code.index('static void *fwp_main_thread(void *arg) {')
    prefix, body = code[:main], code[main:]
    marker = '    fwp_tape_finish();\n'
    assert body.count(marker) == 1
    body = body.replace(marker, r'''
    fprintf(stderr,"{\"registryRequests\":%llu,\"registryRequestedBytes\":%llu,\"peakRegistryBytes\":%zu,\"slotBytes\":%zu,\"initializedSlots\":%lld,\"capacitySlots\":%lld}\n",
        (unsigned long long)registry_requests,(unsigned long long)registry_requested,registry_peak,
        sizeof(fwp_tape),(long long)fwp_ntapes,(long long)fwp_tapes_cap);
''' + marker)
    return prefix + body


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
    for count in [1, 256, 257, 4096]:
        source = out / f'slots-{count}.fwp'
        source.write_text(PROGRAM.replace('COUNT', str(count)))
        expected = f'{count}.0\n'
        reference = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1'))
        assert reference.stdout == expected and not reference.stderr, reference
        emitted = out / f'slots-{count}.c'
        run([compiler, 'build', '--gc', 'arc', '--emit-c', '-o', emitted, source], environment)
        original = emitted.read_text()
        growth = 'if (fwp_ntapes == fwp_tapes_cap)'
        capacity = 'int64_t cap = fwp_tapes_cap ? fwp_tapes_cap * 2 : 1;'
        assert original.count(growth) == 1 and original.count(capacity) == 1
        incremental = original.replace(growth, 'if (1)').replace(capacity, 'int64_t cap = fwp_ntapes + 1;')
        cases = {}
        for label, code in [('geometric', original), ('incremental-control', incremental)]:
            stem = f'slots-{count}-{label}'
            cfile, profile = out / (stem + '.c'), out / (stem + '-profile.c')
            cfile.write_text(code)
            profile.write_text(instrument(code))
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
            registry, tape, managed = map(json.loads, result.stderr.splitlines())
            assert registry['initializedSlots'] == count
            assert registry['capacitySlots'] == (1 << (count - 1).bit_length() if label == 'geometric' else count)
            assert registry['registryRequests'] == ((count - 1).bit_length() + 1 if label == 'geometric' else count)
            assert tape['finalTapeBytes'] == 0 and managed['finalChargedBytes'] == 0 and managed['collections'] == 0
            asm = out / (stem + '.asm')
            asm.write_text(run(['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]).stdout)
            cases[label] = dict(output=expected, registry=registry, tape=tape, managed=managed,
                                processWallNs=samples, medianProcessWallNs=statistics.median(samples), commands=commands,
                                hashes={p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in [source, cfile, profile, binary, measured_binary, asm]})
        assert cases['geometric']['managed'] == cases['incremental-control']['managed']
        results[str(count)] = cases
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(), hardware=platform.uname()._asdict(),
                  cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
                  cc=run([cc, '--version']).stdout, rustc=run(['rustc', '-vV']).stdout,
                  environment={k: environment[k] for k in ['FWP_AD_WORKSPACE', 'FWP_GC_STRESS', 'FWP_GC_VERIFY', 'FWP_REUSE_VERIFY']},
                  results=results,
                  scope='ARC, cold numeric registry, actual equivalent gradients. Control restores one-slot native registry growth only. '
                        'First-free slot search remains linear. Separate profiles count actual C tape/registry buffers and managed requests/live bytes. '
                        'Registry peak is included in tape peak, not additional storage. Allocator metadata and transient realloc copies are excluded. '
                        'Process timings include startup/output; no timing threshold. Interpreter cache fixes have unit/semantic evidence, not a timing claim.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({n: {k: v['registry'] for k, v in cases.items()} for n, cases in results.items()}, indent=2))


if __name__ == '__main__':
    main()
