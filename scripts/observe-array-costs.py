#!/usr/bin/env python3
"""Observe memory, compiler resources and image/stack costs outside array timings."""
import argparse
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import time

from process_wait import run_capture

SPEC = importlib.util.spec_from_file_location('costs', Path(__file__).with_name('measure-borrowed-arrays.py'))
COSTS = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(COSTS)


def replace_once(source, before, after):
    assert source.count(before) == 1, ('observation boundary changed', before)
    return source.replace(before, after)


def memory_source(source):
    source = replace_once(source, 'typedef uint64_t V;',
        'typedef uint64_t V;\nstatic uint64_t observed_requests, observed_bytes, observed_retains;')
    for marker, addition in (
        ('static inline void *fwp_heap_alloc(size_t n, int kind) {',
         '\nif(kind!=0){observed_requests++;observed_bytes+=n;}'),
        ('static inline void *fwp_alloc_init(size_t n) {',
         '\nobserved_requests++;observed_bytes+=n;'),
        ('static inline void fwp_rc_dup(V v) {\n    uint8_t *c = fwp_rc_slot(v);\n    if (c && *c) {',
         '\nobserved_retains++;'),
    ):
        source = replace_once(source, marker, marker + addition)
    source = replace_once(source, '    size_t initial = fwp_heap.live;',
        '    size_t initial = fwp_heap.live;\n'
        '    observed_requests=observed_bytes=observed_retains=0; fwp_heap.peak=initial;')
    marker = 'initial, fwp_heap.live);\n    return 0;\n}'
    report = '''initial, fwp_heap.live);
    printf("{\\"requests\\":%llu,\\"requestedBytes\\":%llu,\\"retains\\":%llu,\\"peakLiveBytes\\":%zu,\\"initialLiveBytes\\":%zu,\\"finalLiveBytes\\":%zu}\\n",
        (unsigned long long)observed_requests, (unsigned long long)observed_bytes,
        (unsigned long long)observed_retains, fwp_heap.peak, initial, fwp_heap.live);
    return 0;
}'''
    return replace_once(source, marker, report)


def resources(text):
    result = {}
    for label, key, conversion in (
        ('Maximum resident set size (kbytes)', 'maxRssKiB', int),
        ('User time (seconds)', 'userSeconds', float),
        ('System time (seconds)', 'systemSeconds', float),
    ):
        value, = re.findall(r'^\s*' + re.escape(label) + r':\s*(\S+)\s*$', text, re.M)
        result[key] = conversion(value)
    return result


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    for name in ('directory', 'compiler', 'reference', 'output', 'time'):
        parser.add_argument('--' + name, type=Path, required=True)
    parser.add_argument('--cc', required=True)
    args = parser.parse_args()
    assert os.environ.get('GITHUB_ACTIONS') == 'true'
    source = subprocess.check_output(['git', 'rev-parse', 'HEAD'], text=True).strip()
    directory = args.directory.resolve()
    identity = json.loads((directory / 'identity.json').read_text())
    assert identity['source'] == source and identity['reference']['disabled'] == 'fresh-array'
    output = args.output.resolve()
    output.mkdir(parents=True, exist_ok=False)
    environment = {key: value for key, value in os.environ.items()
                   if not key.startswith('FWP_') and key not in ('GH_TOKEN', 'GITHUB_TOKEN')}
    environment.update(identity['settings'])
    environment.update(CC=args.cc, LC_ALL='C')
    compilers = dict(candidate=args.compiler.resolve(), reference=args.reference.resolve())
    flags = identity['flags']
    assert subprocess.check_output([args.cc, '--version'], text=True) == identity['ccVersion']
    for role, compiler in compilers.items():
        assert hashlib.sha256(compiler.read_bytes()).hexdigest() == identity['compilerHashes'][role]

    def run(command, destination, observe):
        command = list(map(str, command))
        resource_path = destination.with_suffix('.resources')
        if observe:
            command = [str(args.time), '-v', '-o', str(resource_path), *command]
        start = time.perf_counter_ns()
        timed_out = False
        try:
            result = run_capture(command, timeout=180, cwd=COSTS.ROOT, env=environment,
                input_data=None, input_stream=None, text=False, encoding='utf-8', check=False)
        except subprocess.TimeoutExpired as error:
            timed_out = True
            result = subprocess.CompletedProcess(command, 124, error.stdout or b'', error.stderr or b'')
        elapsed = time.perf_counter_ns() - start
        destination.with_suffix('.stdout').write_bytes(result.stdout)
        destination.with_suffix('.stderr').write_bytes(result.stderr)
        with (output / 'commands.jsonl').open('a') as log:
            log.write(json.dumps(dict(command=command, status=result.returncode, timedOut=timed_out,
                elapsedNs=elapsed, output=str(destination.relative_to(output)))) + '\n')
        assert result.returncode == 0 and not timed_out and not result.stderr, (command, result.stderr)
        observation = dict(elapsedNs=elapsed)
        if observe:
            observation.update(resources(resource_path.read_text()))
        return result.stdout, observation

    summary = dict(source=source, identity=identity, cases={})
    for case in COSTS.programs():
        name = case['name']
        saved = directory / name
        target = output / name
        target.mkdir()
        report = {}
        for role, compiler in compilers.items():
            ordinary = saved / role
            raw, rss = run([ordinary], target / (role + '-rss'), True)
            value = json.loads(raw)
            assert value['initialLiveBytes'] == value['finalLiveBytes']
            emitted = target / (role + '-generated.c')
            _, emitter = run([compiler, 'build', '--fn', 'measure', '--emit-c', '-O2',
                              saved / 'program.fwp', '-o', emitted], target / (role + '-emit'), True)
            assert emitted.read_bytes() == (saved / (role + '-generated.c')).read_bytes()
            rebuilt = target / (role + '-ordinary')
            _, c_compiler = run([args.cc, *flags, saved / (role + '.c'), '-o', rebuilt,
                                '-lm', '-lpthread', '-ldl'], target / (role + '-c-build'), True)
            run([rebuilt], target / (role + '-rebuilt-check'), False)
            profile = memory_source((saved / (role + '.c')).read_text())
            cfile = target / (role + '-memory.c')
            cfile.write_text(profile)
            binary = target / (role + '-memory')
            run([args.cc, *flags, cfile, '-o', binary, '-lm', '-lpthread', '-ldl'],
                target / (role + '-memory-build'), False)
            raw, _ = run([binary], target / (role + '-memory-run'), False)
            timing, counts = [json.loads(line) for line in raw.splitlines()]
            assert counts['initialLiveBytes'] == counts['finalLiveBytes'] == timing['initialLiveBytes']
            assert counts['peakLiveBytes'] >= counts['initialLiveBytes']
            assert timing['checksum'] == value['checksum']
            report[role] = dict(memory=counts, ordinaryProcess=rss, compiler=emitter,
                                cCompiler=c_compiler, imageBytes=ordinary.stat().st_size,
                                imageSha256=hashlib.sha256(ordinary.read_bytes()).hexdigest())
        assert report['candidate']['memory'] == report['reference']['memory'], 'fresh stores changed memory costs'
        if case['kind'] == 'loop':
            assert report['candidate']['memory']['requests'] == report['candidate']['memory']['retains'] == 0
        summary['cases'][name] = report
        (output / 'summary.json').write_text(json.dumps(summary, indent=2) + '\n')
        print(name, 'memory unchanged; compiler/RSS/image costs retained', flush=True)


if __name__ == '__main__':
    main()
