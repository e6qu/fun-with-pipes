#!/usr/bin/env python3
"""Measure N1's four GC-free kernel cases with exact results and a noise control."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import platform
import re
import shutil
import statistics
import subprocess
import time

ROOT = Path(__file__).resolve().parent.parent
SPEC = importlib.util.spec_from_file_location('numerical_baselines', ROOT / 'scripts/numerical-baselines.py')
BASELINE = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(BASELINE)
CASES = {'array-65537': (65537, 65, 67, 63), 'array-262145': (262145, 65, 67, 63),
         'matrix-65-67-63': (65537, 65, 67, 63), 'matrix-257-259-255': (65537, 257, 259, 255)}


def replace_once(source, before, after):
    assert source.count(before) == 1, f'Changed measurement boundary: {before}'
    return source.replace(before, after)


def configured_peer(source, language, dimensions, verification):
    elements, rows, inner, columns = dimensions
    samples = 1 if verification else 5
    if language == 'c':
        source = replace_once(source, 'size_t elements=65537,m=65,k=67,n=63;',
                              f'size_t elements={elements},m={rows},k={inner},n={columns};')
        source = replace_once(source, 'sample<5', f'sample<{samples}')
        if verification:
            source = replace_once(source, 'hash=(hash^bits(result))*1099511628211ULL;',
                                  'printf("%zu:0:%016llx\\n",round,(unsigned long long)bits(result));hash=(hash^bits(result))*1099511628211ULL;')
            source = replace_once(source, 'for(size_t i=0;i<m*n;i++)hash=(hash^bits(out[i]))*1099511628211ULL;',
                                  'for(size_t i=0;i<m*n;i++){printf("%zu:%zu:%016llx\\n",round,i,(unsigned long long)bits(out[i]));hash=(hash^bits(out[i]))*1099511628211ULL;}')
    else:
        assert language == 'rust'
        source = replace_once(source, 'black_box((65537,65,67,63))',
                              f'black_box(({elements},{rows},{inner},{columns}))')
        source = replace_once(source, 'for sample in 0..5', f'for sample in 0..{samples}')
        if verification:
            source = replace_once(source, 'hash=(hash^value.to_bits()).wrapping_mul(1099511628211);',
                                  'println!("{}:0:{:016x}",round,value.to_bits());hash=(hash^value.to_bits()).wrapping_mul(1099511628211);')
            source = replace_once(source, 'for x in out{hash=(hash^x.to_bits()).wrapping_mul(1099511628211);}',
                                  'for (i,x) in out.into_iter().enumerate(){println!("{}:{}:{:016x}",round,i,x.to_bits());hash=(hash^x.to_bits()).wrapping_mul(1099511628211);}')
    return source


def native_source(source, entry, dimensions, matrix, profile, verification):
    elements, rows, inner, columns = dimensions
    source = replace_once(source, 'typedef uint64_t V;', '''typedef uint64_t V;
static uint64_t bench_clock(void);static void bench_sample_live(void);
static uint64_t bench_kernel_ns,bench_calls,bench_bytes,bench_retains,bench_nonlast_releases,bench_release_checks;
''')
    if matrix:
        start = source.index('static V fwp_p_matrix_mul_f64(')
        end = source.index('return result;\n}', start) + len('return result;\n}')
        body = source[start:end]
        body = replace_once(body, 'for(size_t ib=0;', 'bench_sample_live();uint64_t bench_started=bench_clock();\n    for(size_t ib=0;')
        body = replace_once(body, 'fwp_cleanup_pop(&cleanup);', 'bench_kernel_ns+=bench_clock()-bench_started;\n    fwp_cleanup_pop(&cleanup);')
        source = source[:start] + body + source[end:]
    if profile:
        changes = {
            'static inline void *fwp_heap_alloc(size_t n, int kind) {': 'static inline void *fwp_heap_alloc(size_t n, int kind) {\nif(kind!=0){bench_calls++;bench_bytes+=n;}',
            'static inline void *fwp_alloc_init(size_t n) {': 'static inline void *fwp_alloc_init(size_t n) {\nbench_calls++;bench_bytes+=n;',
            'static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {': 'static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {\n        bench_retains++;',
            'static inline void fwp_rc_drop_slot(uint8_t *slot) {': 'static inline void fwp_rc_drop_slot(uint8_t *slot) {\nbench_nonlast_releases++;',
            'static inline int fwp_rc_release_last(V v) {\n    uint8_t *c = fwp_rc_slot(v);': 'static inline int fwp_rc_release_last(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    bench_release_checks++;',
        }
        for before, after in changes.items():
            source = replace_once(source, before, after)
    harness = (ROOT / 'tests/fixtures/numerical_bench_native.c').read_text()
    harness = replace_once(harness, 'elements=65537,m=65,k=67,n=63,rounds=8',
                          f'elements={elements},m={rows},k={inner},n={columns},rounds=8')
    harness = replace_once(harness, 'sample<5', 'sample<1' if verification else 'sample<5')
    if verification:
        harness = replace_once(harness, 'hash=(hash^result)*1099511628211ULL;',
                               'printf("%zu:0:%016llx\\n",round,(unsigned long long)result);hash=(hash^result)*1099511628211ULL;')
        harness = replace_once(harness, 'for(size_t i=0;i<m*n;i++)hash=(hash^fwp_array_load(result,i,&scalar))*1099511628211ULL;',
                               'for(size_t i=0;i<m*n;i++){V value=fwp_array_load(result,i,&scalar);printf("%zu:%zu:%016llx\\n",round,i,(unsigned long long)value);hash=(hash^value)*1099511628211ULL;}')
    # A live owner must fail before process shutdown can reclaim its address space.
    harness = replace_once(harness, 'puts("]}");return 0;',
                           'puts("]}");if(fwp_heap.live!=0)return 225;return 0;')
    source = source.replace('int main(int argc, char **argv)', 'int original_main(int argc, char **argv)')
    return source + '\n' + harness.replace('fBENCH_ENTRY', entry)


def check_samples(raw, expected_hash, label, profile):
    data = json.loads(raw)
    assert set(data) == {'samples'} and len(data['samples']) == 5
    for sample in data['samples']:
        assert sample['hash'] == expected_hash
        assert type(sample['kernelNs']) is int and sample['kernelNs'] > 0
        assert type(sample['allocationInclusiveNs']) is int and sample['allocationInclusiveNs'] >= sample['kernelNs']
        live = 'liveChargedBytes' if label.startswith('fwp') else 'livePayloadBytes'
        assert sample[live] == 0
        for key in ['requests', 'requestedBytes']:
            assert type(sample[key]) is int and sample[key] >= 0
        if profile:
            assert sample['requests'] > 0
    return data['samples']


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ['compiler', 'cc', 'rustc', 'c-arch', 'rust-cpu', 'objdump', 'nm', 'time']:
        parser.add_argument('--' + name, required=True)
    for name in ['samples', 'warmups', 'processes', 'order-seed', 'timeout', 'session']:
        parser.add_argument('--' + name, type=int, required=True)
    parser.add_argument('--case', action='append', choices=list(CASES), required=True)
    parser.add_argument('--qualification', type=Path, required=True)
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true' and platform.system() == 'Linux'
    assert (args.samples, args.warmups, args.processes) == (16, 2, 4)
    assert args.order_seed == 20261029 and args.session in [1, 2] and args.timeout > 0
    assert args.case == list(CASES), 'All four declared cases are required in order'
    qualification = json.loads(args.qualification.read_text())
    assert qualification['qualified'] and not qualification['failures']
    assert qualification['actual'] == qualification['expected']
    assert qualification['source'] == os.environ['GITHUB_SHA']
    assert qualification['actual']['machine'] == platform.machine()
    assert args.c_arch == {'aarch64': 'armv8-a', 'x86_64': 'x86-64'}[platform.machine()]
    assert args.rust_cpu == {'aarch64': 'generic', 'x86_64': 'x86-64'}[platform.machine()]
    assert subprocess.check_output([args.cc, '--version'], text=True).splitlines()[0] == qualification['actual']['cVersion']
    assert subprocess.check_output([args.rustc, '--version'], text=True).strip() == qualification['actual']['rustVersion']
    out = args.output.resolve()
    out.mkdir(parents=True, exist_ok=False)
    compiler = Path(args.compiler).resolve()
    environment = dict(os.environ, FWP_ARRAY_FUSION='1', FWP_MATRIX_BLOCKING='1', FWP_STACK='1', FWP_LTO='0')
    environment.pop('FWP_NO_OPT', None)

    def run(command, destination, expected_status):
        started = time.perf_counter_ns()
        timeout = None
        try:
            result = subprocess.run(list(map(str, command)), env=environment, capture_output=True, timeout=args.timeout)
        except subprocess.TimeoutExpired as error:
            timeout = error
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - started
        destination.with_suffix(destination.suffix + '.stdout').write_bytes(result.stdout)
        destination.with_suffix(destination.suffix + '.stderr').write_bytes(result.stderr)
        observation = dict(command=list(map(str, command)), status=result.returncode,
                           elapsedNs=elapsed, stdoutSha256=hashlib.sha256(result.stdout).hexdigest(),
                           stderrSha256=hashlib.sha256(result.stderr).hexdigest(), timedOut=timeout is not None)
        with (out / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(observation) + '\n')
        if timeout is not None:
            raise timeout
        assert result.returncode == expected_status, (command, result.returncode, result.stderr.decode(errors='replace'))
        return result, elapsed

    results = {}
    for case, dimensions in CASES.items():
        directory = out / case
        directory.mkdir()
        elements, rows, inner, columns = dimensions
        matrix = case.startswith('matrix')
        expected = [BASELINE.matrix_result(rows, inner, columns, r) if matrix else
                    [BASELINE.array_result(elements, r)] for r in range(8)]
        expected_hash = BASELINE.result_hash(expected)
        expected_output = BASELINE.verification_output(expected)
        (directory / 'expected-values.txt').write_bytes(expected_output)
        program = directory / 'kernel.fwp'
        if matrix:
            program.write_text(f'export product-data : Matrix[F64, {inner}, {columns}] -> Matrix[F64, {rows}, {inner}] -> Array[F64]\nproduct-data = curry (uncurry matmul | .data)\n')
            entry_name = 'product-data'
        else:
            program.write_text('export reduce64 : Array[F64] -> F64\nreduce64 = array.map (mul 3.0) | array.map (add 1.0) | array.fold add -0.0\n')
            entry_name = 'reduce64'
        emitted = directory / 'generated.c'
        result, _ = run([compiler, 'build', '--fn', entry_name, '--emit-c', program, '-o', emitted], directory / 'emit', 0)
        assert not result.stderr
        generated = emitted.read_text()
        marker = generated.index('/* ' + entry_name + ' :')
        entry = 'f' + generated[marker:].split('static V f', 1)[1].split('(', 1)[0]
        binaries, profiles, images, stack = {}, {}, {}, {}
        for mode in ['timing', 'profile', 'verify']:
            profile, verification = mode == 'profile', mode == 'verify'
            for language in ['c', 'rust', 'fwp']:
                extension = '.rs' if language == 'rust' else '.c'
                source_path = directory / (language + '-' + mode + extension)
                binary = directory / (language + '-' + mode)
                if language == 'fwp':
                    source = native_source(generated, entry, dimensions, matrix, profile, verification)
                else:
                    source = configured_peer((ROOT / ('tests/fixtures/numerical_bench' + extension)).read_text(), language, dimensions, verification)
                source_path.write_text(source)
                if language == 'rust':
                    command = [args.rustc, '--edition=2021', '--crate-name', 'kernel_' + mode,
                               '-C', 'opt-level=2', '-C', 'target-cpu=' + args.rust_cpu,
                               *(['--cfg', 'memory_profile'] if profile else []), source_path, '-o', binary]
                else:
                    command = [args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch, '-w',
                               '-fstack-usage', '-UFWP_NO_REUSE', '-DPROFILE=' + str(int(profile)),
                               '-DMATRIX_BENCH=' + str(int(matrix)), source_path, '-o', binary, '-lm', '-lpthread']
                built, _ = run(command, directory / (language + '-' + mode + '-build'), 0)
                assert not built.stderr
                invocation = [binary] + ([] if language == 'fwp' else ['matrix' if matrix else 'array'])
                if verification:
                    execution, _ = run(invocation, directory / (language + '-verify-output'), 0)
                    values = b'\n'.join(re.findall(rb'^\d+:\d+:[0-9a-f]{16}$', execution.stdout, re.M)) + b'\n'
                    assert values == expected_output and not execution.stderr, (case, language)
                elif profile:
                    execution, _ = run(invocation, directory / (language + '-profile-output'), 0)
                    assert not execution.stderr
                    profiles[language] = check_samples(execution.stdout, expected_hash, language, True)
                else:
                    binaries[language] = invocation
                raw = binary.read_bytes()
                sections, _ = run([args.objdump, '-h', binary], directory / (binary.name + '-sections'), 0)
                symbols, _ = run([args.nm, binary], directory / (binary.name + '-symbols'), 0)
                assert not any(name in symbols.stdout for name in [b'fwp_heap_scan', b'fwp_heap_mark_all', b'fwp_heap_sweep'])
                assembly, _ = run([args.objdump, '-d', binary], directory / (binary.name + '-assembly'), 0)
                text_bytes = sum(int(size, 16) for size in re.findall(rb'^\s*\d+\s+\.text(?:\.[^\s]+)?\s+([0-9a-fA-F]+)', sections.stdout, re.M))
                assert text_bytes > 0
                images[binary.name] = dict(bytes=len(raw), sha256=hashlib.sha256(raw).hexdigest(), instructionBytes=text_bytes,
                                          sourceSha256=hashlib.sha256(source_path.read_bytes()).hexdigest(),
                                          assemblySha256=hashlib.sha256(assembly.stdout).hexdigest())
        copy = directory / 'fwp-identical'
        shutil.copyfile(binaries['fwp'][0], copy)
        copy.chmod(0o755)
        assert copy.read_bytes() == binaries['fwp'][0].read_bytes()
        binaries['fwp-identical'] = [copy]
        leak = directory / 'missing-owner-release.c'
        leak_source = (directory / 'fwp-profile.c').read_text()
        leak_source = replace_once(leak_source, 'uint64_t elapsed=bench_clock()-start;',
                                   'fwp_rc_fresh(fwp_array_new_packed(1,&scalar));uint64_t elapsed=bench_clock()-start;')
        leak.write_text(leak_source)
        leak_binary = leak.with_suffix('')
        run([args.cc, '-O2', '-std=gnu11', '-ffp-contract=off', '-march=' + args.c_arch, '-w',
             '-DPROFILE=1', '-DMATRIX_BENCH=' + str(int(matrix)), leak, '-o', leak_binary, '-lm', '-lpthread'], directory / 'leak-build', 0)
        leaked, _ = run([leak_binary], directory / 'leak-check', 224)
        assert b'unexpected charged storage' in leaked.stderr
        observations, totals = [], {label: {'kernelNs': [], 'allocationInclusiveNs': []} for label in BASELINE.LABELS}
        for phase, count in [('warmup', args.warmups), ('sample', args.samples)]:
            for index in range(count):
                order = BASELINE.execution_order(index, args.order_seed)
                records, complete = [], False
                try:
                    for position, label in enumerate(order):
                        execution, elapsed = run(binaries[label], directory / f'{phase}-{index}-{position}', 0)
                        assert not execution.stderr
                        samples = check_samples(execution.stdout, expected_hash, label, False)
                        records.append(dict(label=label, processNs=elapsed, samples=samples))
                    complete = True
                finally:
                    record = dict(phase=phase, round=index, order=order, observations=records, complete=complete)
                    (directory / f'{phase}-{index}.json').write_text(json.dumps(record, indent=2) + '\n')
                observations.append(record)
                if phase == 'sample':
                    for label in BASELINE.LABELS:
                        for metric in totals[label]:
                            totals[label][metric].append(sum(s[metric] for r in records if r['label'] == label for s in r['samples']))
        rss = {}
        for label, invocation in binaries.items():
            result, _ = run([args.time, '-v', *invocation], directory / (label + '-rss'), 0)
            check_samples(result.stdout, expected_hash, label, False)
            rss[label] = int(re.search(rb'Maximum resident set size \(kbytes\):\s*(\d+)', result.stderr)[1]) * 1024
        for path in directory.glob('*.su'):
            stack[path.name] = dict(sha256=hashlib.sha256(path.read_bytes()).hexdigest(),
                                   entries=[dict(location=p, bytes=int(size), qualifier=q) for p, size, q in
                                            (line.split('\t') for line in path.read_text().splitlines())])
        medians = {label: {metric: statistics.median(values) for metric, values in samples.items()} for label, samples in totals.items()}
        noise = {metric: max(medians['fwp'][metric], medians['fwp-identical'][metric]) / min(medians['fwp'][metric], medians['fwp-identical'][metric])
                 for metric in ['kernelNs', 'allocationInclusiveNs']}
        results[case] = dict(dimensions=dimensions, resultHash=expected_hash, observations=observations,
                             totals=totals, medians=medians, identicalRatios=noise, profiles=profiles,
                             binaries=images, stack=stack, peakProcessRssBytes=rss)
        (out / 'results.json').write_text(json.dumps(results, indent=2) + '\n')
    failures = [dict(case=case, metric=metric, ratio=ratio, limit=1.02)
                for case, result in results.items() for metric, ratio in result['identicalRatios'].items() if ratio > 1.02]
    source_paths = ['scripts/measure-kernel-baselines.py', 'scripts/numerical-baselines.py',
                    'tests/fixtures/numerical_bench.c', 'tests/fixtures/numerical_bench.rs',
                    'tests/fixtures/numerical_bench_native.c', 'src/cgen.rs', 'src/linalg.rs', 'runtime/fwp_rt_kernel.c']
    report = dict(source=os.environ['GITHUB_SHA'], qualification=qualification,
                  configuration={key: str(value) if isinstance(value, Path) else value for key, value in vars(args).items()},
                  compilerSha256=hashlib.sha256(compiler.read_bytes()).hexdigest(),
                  sourceTrees={name: subprocess.check_output(['git', 'rev-parse', os.environ['GITHUB_SHA'] + ':' + name],
                                                             cwd=ROOT, text=True).strip()
                               for name in ['src', 'runtime', 'lib', 'Cargo.toml', 'Cargo.lock', 'build.rs']},
                  sourceHashes={name: hashlib.sha256((ROOT / name).read_bytes()).hexdigest() for name in source_paths},
                  results=results, failures=failures)
    (out / 'comparison.json').write_text(json.dumps(report, indent=2) + '\n')
    print(json.dumps({case: result['identicalRatios'] for case, result in results.items()}, indent=2))
    assert not failures, failures


if __name__ == '__main__':
    main()
