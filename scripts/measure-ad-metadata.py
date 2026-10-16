#!/usr/bin/env python3
"""Runner-only paired AD metadata allocation and native binary evidence."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import statistics
import sys
import time

ROOT = Path(__file__).resolve().parent.parent
BASELINE = '09f1a029c139d06ac3a11623c70f1de959624fbb'
START = '/* ------------------------------------------------------------------ tapes */'
END = '/* ---------------------------------------------------------------- kernels */'
sys.dont_write_bytecode = True
spec = importlib.util.spec_from_file_location('checkpoint', ROOT / 'scripts/measure-checkpoint.py')
checkpoint = importlib.util.module_from_spec(spec)
spec.loader.exec_module(checkpoint)
run = checkpoint.run
CASES = {
    'identity': ('main = range 0 4096 | map int.to-float | vjp id (repeat 4096 1.0) | sum | echo\n', '4096.0\n'),
    'map': ('main = range 0 4096 | map int.to-float | vjp (map (mul 2.0)) (repeat 4096 1.0) | sum | echo\n', '8192.0\n'),
    'repeated-map': ('main = range 0 16 | map (const (range 0 4096 | map int.to-float) | '
                     'vjp (map (mul 2.0)) (repeat 4096 1.0) | sum) | sum | echo\n', '131072.0\n'),
    # Longer steady work makes process startup a smaller part of the comparison.
    'sustained-map': ('main = range 0 512 | map (const (range 0 4096 | map int.to-float) | '
                      'vjp (map (mul 2.0)) (repeat 4096 1.0) | sum) | sum | echo\n', '4194304.0\n'),
    'replay': ('main = [2.0] | vjp (rev._replay 4096 (map (add 1.0))) [1.0] | sum | echo\n', '1.0\n'),
    'nested': ('square : List[t] -> t where Ring[t], Dup[t]\n'
               'square = head | option.unwrap-or zero | fork mul id id\n'
               'main = range 0 256 | map int.to-float | grad (grad square | sum) | sum | echo\n', '2.0\n'),
}


def instrument(code):
    code = checkpoint.instrument(code)
    code = re.sub(r'checkpoint_realloc\(t->(pa|pb|da|db),', r'metadata_realloc(t->\1,', code)
    code = re.sub(r'\bmemmove\(t->', 'metadata_move(t->', code)
    helpers = r'''
static uint64_t metadata_requests, metadata_bytes, metadata_moved;
static void *metadata_realloc(void *old,size_t bytes) {
    metadata_requests++;metadata_bytes+=bytes;
    return checkpoint_realloc(old,bytes);
}
static void *metadata_move(void *to,const void *from,size_t bytes) {
    metadata_moved+=bytes;return memmove(to,from,bytes);
}
'''
    code = code.replace(START, helpers + START, 1)
    marker = r'    fprintf(stderr,"{\"tapeRequests\"'
    assert code.count(marker) == 1
    report = r'''
    fprintf(stderr,"{\"metadataRequests\":%llu,\"metadataRequestedBytes\":%llu,\"explicitMovedBytes\":%llu}\n",
        (unsigned long long)metadata_requests,(unsigned long long)metadata_bytes,(unsigned long long)metadata_moved);
'''
    return code.replace(marker, report + marker)


def interleaved(code):
    """Pair the two parents/weights of each operation within the same blocks."""
    start, end = code.index(START), code.index(END)
    tape = code[start:end]
    for field, base in [('pb', 'pa'), ('db', 'da')]:
        for capacity in ['t->cap', 'cap']:
            before = f't->{field} = t->{base} + {capacity};'
            assert tape.count(before) == 1, before
            tape = tape.replace(before, f't->{field} = t->{base} + 1;')
    before = '    size_t used = (size_t)(t->len - t->leaves);\n'
    assert tape.count(before) == 1
    tape = tape.replace(before, '')
    for before in [
        '        if (used) memmove(t->da + cap, t->db, used * sizeof(double));\n',
        '    if (used) memmove(t->pa + cap, t->pb, used * sizeof(int32_t));\n',
    ]:
        assert tape.count(before) == 1, before
        tape = tape.replace(before, '')
    tape, changed = re.subn(r'((?:t->|tp\.)(?:pa|pb|da|db))\[op\]', r'\1[2 * op]', tape)
    assert changed == 14, changed
    return code[:start] + tape + code[end:]


def main():
    assert os.environ.get('GITHUB_ACTIONS') == 'true', 'full evidence runs on GitHub'
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, required=True)
    parser.add_argument('--comparison', choices=['separate', 'interleaved'], default='separate')
    args = parser.parse_args()
    out = args.output.resolve()
    other_label = 'separate-control' if args.comparison == 'separate' else 'interleaved'
    out.mkdir(parents=True, exist_ok=True)
    compiler = ROOT / 'target/release/fwp'
    cc = os.environ.get('CC', 'cc')
    environment = dict(os.environ, FWP_GC_STRESS='0', FWP_GC_VERIFY='0', FWP_REUSE_VERIFY='0')
    environment.pop('FWP_NO_OPT', None)
    baseline_tape = None
    if args.comparison == 'separate':
        baseline = run(['git', 'show', BASELINE + ':runtime/fwp_rt_kernel.c']).stdout
        baseline_tape = baseline[baseline.index(START):baseline.index(END)]
    results = {}
    for name, (program, expected) in CASES.items():
        source = out / (name + '.fwp')
        source.write_text(program)
        reference = run([compiler, 'run', '--interp', source], dict(environment, FWP_NO_OPT='1'))
        assert reference.stdout == expected and not reference.stderr, reference
        emitted = out / (name + '.c')
        run([compiler, 'build', '--gc', 'arc', '--emit-c', '-o', emitted, source], environment)
        original = emitted.read_text()
        control = (original[:original.index(START)] + baseline_tape + original[original.index(END):]
                   if baseline_tape is not None else interleaved(original))
        variants = {}
        for label, code in [('paired', original), (other_label, control)]:
            stem = name + '-' + label
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
            caches = {}
            for cache in ['0', '1']:
                env = dict(environment, FWP_AD_WORKSPACE=cache)
                result = run([measured_binary], env)
                assert result.stdout == expected
                metadata, tape, managed = map(json.loads, result.stderr.splitlines())
                assert tape['finalTapeBytes'] == 0 and managed['finalChargedBytes'] == 0
                assert managed['collections'] == 0
                caches[cache] = dict(metadata=metadata, tape=tape, managed=managed,
                                    processWallNs=[])
            assembly = ['otool', '-tvV', binary] if platform.system() == 'Darwin' else ['objdump', '-d', binary]
            asmfile = out / (stem + '.asm')
            asmfile.write_text(run(assembly).stdout)
            variants[label] = dict(caches=caches, commands=commands,
                                   generatedSha256=hashlib.sha256(cfile.read_bytes()).hexdigest(),
                                   binarySha256=hashlib.sha256(binary.read_bytes()).hexdigest(),
                                   assemblySha256=hashlib.sha256(asmfile.read_bytes()).hexdigest())
        for cache in ['0', '1']:
            env = dict(environment, FWP_AD_WORKSPACE=cache)
            labels = ['paired', other_label]
            for label in labels:
                warmup = run([out / (name + '-' + label)], env)
                assert warmup.stdout == expected and not warmup.stderr
            # Alternate process order after warming both executables, avoiding
            # a complete variant block being measured before the other builds.
            for sample in range(8):
                for label in (labels if sample % 2 == 0 else labels[::-1]):
                    start = time.perf_counter_ns()
                    result = run([out / (name + '-' + label)], env)
                    elapsed = time.perf_counter_ns() - start
                    assert result.stdout == expected and not result.stderr
                    variants[label]['caches'][cache]['processWallNs'].append(elapsed)
            for variant in variants.values():
                values = variant['caches'][cache]
                values['medianProcessWallNs'] = statistics.median(values['processWallNs'])
            paired = variants['paired']['caches'][cache]
            other = variants[other_label]['caches'][cache]
            multiplier = 2 if args.comparison == 'separate' else 1
            assert paired['metadata']['metadataRequests'] * multiplier == other['metadata']['metadataRequests']
            assert paired['metadata']['metadataRequestedBytes'] == other['metadata']['metadataRequestedBytes']
            for field in ['tapeRequestedBytes', 'peakTapeBytes', 'finalTapeBytes']:
                assert paired['tape'][field] == other['tape'][field], (name, cache, field)
            assert other['tape']['tapeRequests'] - paired['tape']['tapeRequests'] == (
                paired['metadata']['metadataRequests'] if args.comparison == 'separate' else 0)
            assert paired['managed'] == other['managed']
            assert other['metadata']['explicitMovedBytes'] == 0
            if name != 'identity':
                assert paired['metadata']['metadataRequests'] > 0
        results[name] = dict(source=program, sourceSha256=hashlib.sha256(source.read_bytes()).hexdigest(), variants=variants)
        if name in ['repeated-map', 'sustained-map']:
            for variant in variants.values():
                assert variant['caches']['1']['metadata']['metadataRequests'] < variant['caches']['0']['metadata']['metadataRequests']
    report = dict(head=run(['git', 'rev-parse', 'HEAD']).stdout.strip(), baseline=BASELINE if args.comparison == 'separate' else None,
                  comparison=args.comparison,
                  hardware=platform.uname()._asdict(),
                  cpu=run(['sysctl', '-n', 'machdep.cpu.brand_string'] if platform.system() == 'Darwin' else ['lscpu']).stdout,
                  cc=run([cc, '--version']).stdout, rustc=run(['rustc', '-vV']).stdout,
                  sampling='One unmeasured process warmup per variant/cache; eight alternating paired/control process samples, each variant first four times.',
                  results=results, scope=('Same ARC program and compiler; control substitutes the accepted baseline tape runtime. '
                  if args.comparison == 'separate' else
                  'Same ARC program/compiler/runtime; candidate interleaves each operation parent/weight pair, '
                  'keeps both block sizes and removes explicit region moves during growth. ') +
                  'Both workspace settings are explicit. Eight process samples include startup/output, with no speedup threshold. '
                  'The sustained-map case repeats 512 derivative calculations to reduce the relative contribution of startup. '
                  'Profiles separately count native tape payloads and charged managed storage; allocator metadata, '
                  'transient realloc copies and OS reservations are excluded. Paired growth explicitly moves initialized '
                  'second regions; that count excludes allocator-internal copies in both variants. '
                  'The Rust interpreter supplies semantic reference results, not a storage or timing comparison.')
    (out / 'report.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({name: {label: value['caches'] for label, value in row['variants'].items()}
                      for name, row in results.items()}, indent=2))


if __name__ == '__main__':
    main()
